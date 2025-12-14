;------------------------------------------
;  Telephone Service DOS V1.0
;  Program by T.Krissada
;  Com,Eng KMIT'L 1999
;  CPU 89C51
;  18/4/1998
;------------------------------------------
atohOK         EQU    1
atohError      EQU    2
BAUD96       EQU   0fdh
;ACK              EQU   6h
ACK              EQU   23h
;NAK              EQU   15h
NAK              EQU   21h
CAN              EQU   18h

StackPtr       EQU    27h         ;  StackPtr    DS   58h

LTime1        EQU    22h
LTime0        EQU    21h
LTimeFlag   EQU    20h

RXDat          EQU    1ch         
TXDat           EQU   1bh
PCCmd         EQU    1ah

IndxRD         EQU    19h
IndxWR        EQU    18h
StrtQBuf        EQU    08h

               ORG   0000h
               jmp   ColdStart                 ; power on/reset vector

               ORG   0003h
               reti                                   ; external int 0 vector

               ORG   000Bh
               jmp    Timer0Int
                                                        ; timer 0 overflow vector

               ORG   0013h
               reti                                  ; external int 1 vector
 
               ORG   001Bh
               reti                                 ; timer 1 overflow vector

               ORG   0023h
               jmp   SerialInt              ; serial I/O interrupt vector

               ORG   0080h
ColdStart:     mov    sp,#StackPtr
               call   Init
	setb   es                   ;  enable serial interupt
                setb   et0                  ;  enable timer 0 interupt
               jmp    Main

               ORG    0100h
Main:      mov   a,#5
               call   DelayMs
               jmp $

;------------------------------------------
;  Initialize
;------------------------------------------
Init:         mov   pcon,#0
               mov   IE,#0                ; disable all interupts
               mov   a,#0ffh              ; deactivate output ports
               mov   p0,a
               mov   p1,a
               mov   p2,a
               mov   p3,a

               mov   ip,#02h           ; set timer 0 to high priority
               mov   scon,#40h      ; serial port mode 1(data 8 bit,stop 1 bit)

               mov   tmod,#21h      ;              Gate  C/T  M1  M0
               mov   tcon,#05h      ;   Timer 1     0     0   1   0
                                    ;   Timer 0     0     0   0   1
                                    ;   Edge pulse detect

               mov   th1,#BAUD96    ; set timer 1 reload value

               mov   th0,#0B8h
               mov   tl0,#00h      ; set timer 0 interupt every 10 ms

               setb   tr1                     ; start timer 1
               setb   tr0                     ; start timer 0

               setb   ren                     ; enable serial reception
               clr      ri                       ; stop receive interupt flag
               clr      ti                       ; stop transmit interupt flag

               setb   EA                      ; global interupt enable
               mov   IndxWR,#00
               mov   IndxRD,#00
               ret

;----------------------
; Timer 0 interupt routine
;----------------------
Timer0Int:     push   psw       ; set timer 0 interupt every 20 ms
                     push   acc       

                  ; initial start counter value
                  ; count from  b800h to 10000h
                  ; numbers 18432 (4800h) machine cycle = 20 ms

                     clr      TR0                ; stop timer                     
                     mov    th0,#0B8h     
                     mov    tl0,#00h    
                     setb   TR0                ; start timer

Tim0_1:        jb      LTimeFlag.0,Tim1_1
                    djnz   Ltime0,Tim1_1
                    setb   LtimeFlag.0

Tim1_1:       jb       LTimeFlag.1,TimIntEnd
                   djnz    Ltime1,TimIntEnd
                   setb    LtimeFlag.1
TimIntEnd:
                   pop    acc
                   pop    psw
                   reti

;---------------------------------------------------------
;  Serial Interupt Routine
;---------------------------------------------------------
SerialInt:        push  psw
                      clr    ES                  ; disable serial interupts
	      clr    TI	    ; stop transmit flag interupt
	      jnb   RI,TransInt     ; if not receive then TranInt
                      mov  a,SBUF         ; else
	      clr     RI 	     ; reset receive flag
	      cjne  a,#':',SerialNAK
	      call   Recv
	      jmp  TransInt
SerialNAK:     mov  a,#NAK
	      call   SndChar 	
TransInt:	      setb  ES
                      pop   psw
                      reti
;---------------------------------------------------------
; Recv
;---------------------------------------------------------
Recv:
                      call    getByte
                      jc       RecvEr                ; read command or data byte
	      mov   RxDat,a
	      call    getByte               ; read check sum byte
	      jc       RecvEr
                      add    a,RxDat              ; calculate  check sum
	      jnz     RecvEr	           ; if check sum not zero then error
	      mov   a,RxDat
	      cjne   a,#80h,$+3
	      jc       SetDat
SetCmd:        mov   PCCmd,a
	      jmp    RecvOk
SetDat:          call     WriteQ
RecvOk:        mov   a,#ACK
	      call    SndChar
                      ret
RecvEr:         mov   a,#NAK               ; if error then send NAK
	      call    SndChar
	      ret

;---------------------------------------------------------
;  Tran
;---------------------------------------------------------
Tran:              clr      ES
                      clr      TI
	      mov    a,#':'
	      call     SndChar
                      call     Start100ms
ChkRecv:       jb        RI,CmmOvlap
                      jnb      LTimeFlag.0,ChkRecv
SndTxDat:     mov    a,TxDat 
	      call     SndHex		; send data byte
                      cpl      a		; calculate check sum
	      inc      a
	      call     SndHex		; send check sum
	      call     GetChar
	      jc        SndTxDat
	      cjne    a,#ACK,SndTxDat
	      setb    ES     
                      ret
CmmOvlap:   mov  a,SBUF        
	      clr     RI 	            ; reset receive flag
                      cjne  a,#':',OvlapNAK
	      call   Recv
	      jmp   OvlapEnd
OvlapNAK:     mov  a,#NAK
	      call   SndChar                        	
OvlapEnd:     setb  ES
                      ret
;---------------------------------------------------------
;  GetChar
;        Read a character from the serial port.
;        Return the character in the accumulator.
;---------------------------------------------------------
GetChar:      
                       jb      RI,gc2              ; jump if char is waiting
                       call   Start1Sec
gc1:
	       jb      RI,gc2
	       jnb    LTimeFlag.1,gc1
                       setb  c
	       jmp   gc3
gc2:
	       mov  a,SBUF
	       clr     c                      ; clear error flag
	       clr     RI
gc3:
                       ret

;---------------------------------------------------------
;  SndChar
;       Send a character in the accumulator to the serial port.
;---------------------------------------------------------
SndChar:      
                       clr      TI             ; clear transmit flag
	       mov   SBUF,a
	       jnb     TI,$          ; wait here for transmited
                       clr      TI             ; clear transmit flag
	       ret

;---------------------------------------------------------
;  Writeln
;        Send carring return and line feed character to the serial port
;---------------------------------------------------------
Writeln:     mov    a,#0ah
                  lcall    SndChar
                  mov    a,#0dh
                  lcall    SndChar
                  ret

;-------------------------------
; Get Byte
; ACC = Get 1 Byte from RS232 comm
;-------------------------------
GetByte:      push   b
                    call    GetChar
	    jc       GetByteEr
                    call    asctoh
                    cjne    r0,#atohOK,GetByteEr
                    swap   a
                    mov    b,a
                    call    GetChar
	    jc       GetByteEr
                    call    asctoh
                    cjne   r0,#atohOK,GetByteEr
                    orl     a,b
	    clr      c
	     jmp   GetByteOk
GetByteEr:   setb   c
GetByteOk:   pop    b
                     ret
;---------------------------------------------------------
;   Convert one upper case ascii to hex number range 0-Fh
;   input = ACC
;   output  r0=return value (atohOK,atohError)
;               If r0=atohOK   Then ACC=hex number
;---------------------------------------------------------
asctoh:       cjne  a,#':',$+3
                   jc    chk09           ; jump if ACC<':' (ACC = '0'-'9')
                   cjne  a,#'A',$+3
                   jc    asctoh1         ; If ACC<'A' Then Error
                   cjne  a,#'G',$+3
                   jc    hexAF           ; If ACC<='F' Then convert
                   jmp   asctoh1           ; Else Error
hexAF:        anl   a,#0fh
                   add   a,#09
                   mov   r0,#atohOK
                   ret
chk09:        cjne  a,#'0',$+3
                   jc    asctoh1         ; If ACC<'0' Then Error
                  anl   a,#0fh
                  mov   r0,#atohOK
                  ret
asctoh1:     mov   r0,#atohError
                   ret

;--------------------------
;  WriteQ
;  use r1
;--------------------------
WriteQ:       push  acc
 	   mov   a,IndxWR
	   inc     a
	   anl     a,#0fh
	   cjne   a,indxRD,WriteOk
WriteFull:   pop    acc
	   setb   c		    ; set error flag
                   ret
WriteOk:     mov   IndxWR,a
	   add    a,#StrtQBuf      ; Start Q buffer + Q index
	   mov   r1,a
	   pop    acc
	   mov   @r1,a
	   clr      c		    ; reset error flag
	   ret
;------------------------
; ReadQ
; use r1
;------------------------
ReadQ:       mov   a,IndxRD
	   cjne   a,IndxWR,ReadOk
	   setb   c                     ;  set error flag
                   ret
ReadOk:     inc     a
	   anl     a,#0fh     
	   mov   IndxRD,a
	   add    a,#StrtQBuf
	   mov   r1,a
	   mov   a,@r1
	   clr      c
	   ret
;------------------
;  to upper
;  input  = acc
;------------------
ToUpper:      cjne  a,#'a',$+3
                     jc    endupper      ; If ACC<'a' Then end
                     cjne  a,#'{',$+3
                     jc    toupper1       ; If ACC<='z' Then convert to upper case
                     ret                       ; Else return
toupper1:     clr    c
                     subb  a,#20h
endupper:    ret

;----------------------
; convert hex to ascii
; input  a
; output r2,r3
; use    a,r2,r3
;----------------------
htoa:           push  acc
                   swap  a
                   lcall htoas
                   mov   r2,a
                   pop   acc
                   lcall htoas
                   mov   r3,a
                   ret

htoas:        anl   a,#0fh
                  cjne  a,#0ah,$+3
                  jnc   htoas1
                  orl   a,#30h
                  ret
htoas1:      subb  a,#9h
                  orl   a,#40h
                  ret

;---------------------
; send hex (0..0ffh)
; input  a
; use    a,r2,r3
;---------------------
SndHex:     call  htoa
                   mov   a,r2
                   call  SndChar
                   mov   a,r3
                   call  SndChar
                   ret

;---------------------------
; send message
; input    dptr = #message table
;                 terminate by #00h
;---------------------------
SndMes:        push  acc
                      push  dpl
                      push  dph
SndMesLp:    clr   a
                      movc  a,@a+dptr          ; get character
                      jz    SndMesEnd
                      call  SndChar
                      inc   dptr
                      jmp   SndMesLp
SndMesEnd:   pop   dph
                      pop   dpl
                      pop   acc
                      ret

;------------------------------
; Delay n ms
; acc = n
;------------------------------
DelayMs:      push  acc
                     push  b
DelayM1:      mov   b,#230                 ; delay 500 us at 11.0592 MHZ
                     djnz  b,$
                     mov   b,#230                 ; delay 500 us at 11.0592 MHZ
                     djnz  b,$
                     djnz  acc,DelayM1
                     pop   b
                     pop   acc
                     ret

;------------------------------
; Delay n sec
; acc = n
;------------------------------
DelaySec:     push  acc
                     push  b
                     mov   b,a
DelayS1:
                     mov   a,#250
                     call  DelayMs
                     call  DelayMs
                     call  DelayMs
                     call  DelayMs

                     djnz  b,DelayS1

                     pop   b
                     pop   acc
                     ret

;-----------------------------------
;  100 ms timer
;   clear LTimeFlag.0 to start this timer
;   when finish => LTimeFlag.0 = 1
;-----------------------------------
Start100ms:   setb   LTimeFlag.0       ; stop timer
                       mov   LTime1,#5        ; set counter 5 * 20ms = 100 ms
                       clr     LTimeFlag.0       ; start timer
                       ret

;-----------------------------------
;  1 sec timer
;   clear LTimeFlag.1 to start this timer
;   when finish => LTimeFlag.1 = 1
;-----------------------------------
Start1Sec:     setb   LTimeFlag.1       ; stop timer
                      mov   LTime1,#50       ; set counter 50 * 20ms = 1 s
                      clr    LTimeFlag.1         ; start timer
                      ret

                END
