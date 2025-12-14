;------------------------------------------
;  Telephone Service DOS V1.0
;  Program by T.Krissada
;  Com,Eng KMIT'L 1999
;  CPU 89C51
;  27/4/1999
;------------------------------------------
atohOK        EQU    1
atohError     EQU    2
BAUD96        EQU   0fdh
;ACK          EQU   6h
ACK           EQU   23h
;NAK          EQU   15h
NAK           EQU   21h
CAN           EQU   18h

StartCmd      EQU   060h

DTMFCmd       EQU    0FF9h    ; for write control register,read status register
DTMFDat	      EQU    0FF1h    ; for write tone number,read tone number
AnalogC       EQU    0FF0h    ; for control analog switch
         ;  AnalogC description     d7   d6  d5  d4  d3  d2  d1  d0
         ;  1 on    0 off                 data  x3  x2  x1  x0  y2  y1  y0
StackPtr      EQU    31h         ;  StackPtr    DS   80-58h

DialC1       EQU    30h
DialTime     EQU    2fh

BusyC2       EQU    2eh
BusyC1       EQU    2dh
BusyTime     EQU    2ch

RgBkC2       EQU    2bh
RgBkC1       EQU    2ah
RgBkTime     EQU    29h

ActvFlag      EQU    28h      ; ring active,beep active,send busy,old dial
SnalFlag      EQU    27h      ; generate busy ,generate ringback
ContMsk       EQU    26h      ; detect ringback,dialing,Busy,HK,RV
StatFlag      EQU    25h
StatFlagT     EQU    24h      ; save old StatFlag

RXDat         EQU    23h         
TXDat         EQU    22h
PCCmd         EQU    21h
LTimeFlag     EQU    20h

LTime4         EQU    1eh                 ; 0-5 sec timer counter
LTime3         EQU    1dh                 ; ring timer counter
LTime2         EQU    1ch	      ; beep timer counter
LTime1         EQU    1bh	      ; 1 sec timer counter
LTime0         EQU    1ah	      ; 100ms timer counter

IndxRD         EQU    19h
IndxWR        EQU    18h
StrtQBuf        EQU    08h

                    ORG   0000h
                    jmp   ColdStart                 ; power on/reset vector

                    ORG   0003h
                    reti                                   ; external int 0 vector

                    ORG   000Bh
                    jmp    Timer0Int               ; timer 0 overflow vector

                    ORG   0013h
                    jmp    Int1Int                    ; external int 1 vector
  
                    ORG   001Bh
                    reti                                 ; timer 1 overflow vector

                    ORG   0023h
                    jmp   SerialInt              ; serial I/O interrupt vector

                    ORG   0040h
ColdStart:     mov    sp,#StackPtr
                    call   Init
                    call   InitVar
                    call   InitDTMF
                    setb   ES                   ;  enable serial interupt
                    setb   ET0                 ;  enable timer 0 interupt
                    setb   EX1                ;   enable external int 1 interupt
                    jmp    Main

                    ORG    080h
Main:           mov    a,PCCmd
	    cjne    a,#60h,ChkCmd1   ; because receive data can be sleep serial interupt
	    setb    ES                      ; then wakeup serial interupt every time peroid 
                    jmp     main              ; receive command also sleep but wakeup when finish command
ChkCmd1:    cjne    a,#61h,ChkCmd2         ; off hook command
                       setb    P1.0		  ;  activate loop relay
	    mov    dptr,#AnalogC
 	    mov    a,#83h
	    movx   @dptr,a           ; cross node X0 to Y3 (CO1,CO_END)
	    mov    a,#92h
	    movx   @dptr,a           ; cross node X2 to Y2 (DTMFO,CORXD)
 	    mov    a,#0a9h
	    movx   @dptr,a           ; cross node X5 to Y1 (DECDIAL,CORDX)
            jmp     EndChk
ChkCmd2:    cjne   a,#62h,ChkCmd3
	    mov    dptr,#AnalogC
	    mov    a,#03h
	    movx  @dptr,a            ; break node X0 to Y3 (CO1,CO_END)
	    mov    a,#12h
	    movx  @dptr,a            ; break node X2 to Y2 (DTMFO,CORXD)
 	    mov    a,#19h
	    movx   @dptr,a           ; break node X3 to Y1 (AMPI,COTTXD)
 	    mov    a,#22h
	    movx   @dptr,a           ; break node X4 to Y2 (AMPO,CORDX)
 	    mov    a,#29h
	    movx   @dptr,a           ; break node X5 to Y1 (DECDIAL,CORDX)
	    clr       P1.0	    ;  deactivate loop relay
	    jmp     EndChk
ChkCmd3:    cjne   a,#63h,ChkCmd4        ; enable  DTMF interupt
	    mov    dptr,#AnalogC	   
 	    mov    a,#089h
	    movx   @dptr,a                        ; cross node X1 to Y1 
	    jmp     EndChk
ChkCmd4:    cjne   a,#64h,ChkCmd5         ; disable DTMF interupt
	    mov    dptr,#AnalogC	  
 	    mov    a,#09h
	    movx   @dptr,a                        ; break node X1 to Y1 
	    jmp     EndChk
ChkCmd5:    cjne   a,#65h,ChkCmd6	  
	    setb   ContMsk.0	                  ; enable send RVDET
	    jmp    EndChk
ChkCmd6:    cjne   a,#66h,ChkCmd7
	    clr      ContMsk.0	                 ; disable send RVDET
	    jmp    EndChk
ChkCmd7:    cjne   a,#67h,ChkCmd8
	    clr      a
	    mov   BusyTime,a
	    mov   BusyC1,a
	    mov   BusyC2,a
	    setb   ContMsk.2	                  ; enable send Busy DET
	    jmp    EndChk
ChkCmd8:    cjne   a,#68h,ChkCmd9
	    clr      ContMsk.2	                 ; disable send Busy DET
	    jmp    EndChk
ChkCmd9:    cjne   a,#69h,ChkCmd10
	    mov   DialTime,#70
	    mov   DialC1,#0
	    setb   ContMsk.3	                  ; start check Dialing tone
	    jmp    EndChk
ChkCmd10:  cjne   a,#6ah,ChkCmd11
	    clr       a
	    mov    RgBkTime,a
	    mov    RgBkC1,a
 	    mov    RgBkC2,a	
 	    setb   ContMsk.4	                  ; start check Ring back tone
	    jmp    EndChk
ChkCmd11:  cjne   a,#6bh,ChkCmd12
	    clr      a
	    mov   IndxWR,a		 ; reset queue index
	    mov   IndxRD,a                   
	    jmp    EndChk
ChkCmd12:  cjne   a,#6ch,ChkCmd13      ; send DTMF to CO
                    call    ReadQ
                    jc       NoSend
                    mov   dptr,#DTMFDat
	    movx  @dptr,a   
NoSend:      jmp    EndChk
ChkCmd13:  cjne   a,#6dh,ChkCmd14       ; read  DTMF Queue to PC
                    call    ReadQ
                    jc       EndRead
                    mov   TXDat,a
	    call    Tran	          ;   maybe receive PCCmd
			          ;   do not   mov   PCCmd,#60h  (receive will be fail)
	    jmp    main                    ;   force Recv PCCmd do finish  
EndRead:	    setb   ES 
 	    jmp    main
ChkCmd14:  cjne   a,#6eh,ChkCmd15          ; send status flag to PC
	    mov   PCCmd,#60h	; if tran finish then next  PCCmd=60h
                        mov   TXDat,StatFlag
	    call    Tran	          ;   maybe receive PCCmd
	    jmp    main                    ;   Tran ok then setb ES ,IF receive then clr ES
ChkCmd15:  cjne   a,#6fh,ChkCmd16         ; activate Amplifier input
	    mov    dptr,#AnalogC
 	    mov    a,#99h
	    movx   @dptr,a           ; cross node X3 to Y1 (AMPI,COTTXD)
	    jmp    EndChk
ChkCmd16:  cjne   a,#70h,ChkCmd17         ; deactivate Amplifier input
	    mov    dptr,#AnalogC
 	    mov    a,#19h
	    movx   @dptr,a           ; break node X3 to Y1 (AMPI,COTTXD)
	    jmp    EndChk
ChkCmd17:  cjne   a,#71h,ChkCmd18         ; activate Amplifier output
	    mov    dptr,#AnalogC
 	    mov    a,#0a2h
	    movx   @dptr,a           ; cross node X4 to Y2 (AMPO,CORDX)	       
	    jmp    EndChk
ChkCmd18:  cjne   a,#72h,EndChk                ; deactivate Amplifier output
	    mov    dptr,#AnalogC
 	    mov    a,#22h
	    movx   @dptr,a           ; break node X4 to Y2 (AMPO,CORDX)
	    jmp    EndChk

EndChk:       mov   PCCmd,#60h
	    setb   ES
                        jmp    main

;------------------------------------------
;  Initialize
;------------------------------------------
Init:         mov   pcon,#0
               mov   IE,#0                ; disable all interupts
               mov   a,#0fch            ; deactivate loop relay,bias relay,ground relay
               mov   p1,a
               mov   a,#0ffh              ; deactivate output ports
               mov   p0,a
               mov   p2,a
               mov   a,#0dfh              ; deactivate ring voltage P3.5
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
               ret

;--------------------------
; Initial variable
;--------------------------
InitVar:      push  psw 
                 push  acc
	 clr      a
                 mov   IndxWR,a
                 mov   IndxRD,a
	 mov   LTime0,a
	 mov   LTime1,a
	 mov   LTime2,a
                 mov   LTime3,a
	 mov   LTime4,a
	 mov   LTimeFlag,#0ffh
	 mov   PCCmd,#StartCmd
	 mov   TXDat,a
                 mov   RXDat,a
	 mov   ContMsk,a            ; none is enable
                 mov   ActvFlag,a            ; none is enable
                 mov   SnalFlag,a           ; none signal is generate

	 mov    BusyTime,a
	 mov    BusyC1,a
	 mov    BusyC2,a

	 mov    DialTime,#70
	 mov    DialC1,a

	 mov    RgBkTime,a
	 mov    RgBkC1,a
 	 mov    RgBkC2,a	

                 mov   StatFlag,a
	 mov   c,P1.5                ; Ring Voltage detect
	 mov   StatFlag.0,c
	 mov   c,P3.4	     ; on/off Hook detect
	 mov   StatFlag.1,c
	 mov   c,P3.2
	 mov   SnalFlag.0,c      ; save old dial detect
	 setb   StatFlag.7
 	 mov   StatFlagT,StatFlag  ; save old state flag

                 pop  acc
	 pop  psw
	 ret

;----------------------
; Initial DTMF
;----------------------
InitDTMF:    push acc
	   mov  dptr,#DTMFCmd
	   movx   a,@dptr      ;  read and clear status register
	   clr        a
	   movx   @dptr,a      ; select control reg A for next write cycle
	   movx   @dptr,a      ; disable interupt,enable DTMF mode,tone output off
	   mov     a,#08h
	   movx   @dptr,a      ; select control reg B for next write cycle
	   clr        a
	   movx   @dptr,a      ;  clear control register B
	   movx   a,@dptr      ;  read and clear status register
	   mov     a,#0dh        ;           b2                   b1                b0
	   movx   @dptr,a      ; enable interupt,enable DTMF,tone output on
	   clr        a                 ;           b2                   b1
	   movx   @dptr,a      ; enable burst mode,disable test mode
	   pop   acc
	   ret

;----------------------
; Timer 0 interupt routine
; none of any interrupt can interrupt this service
;----------------------
Timer0Int:     push   psw       ; set timer 0 interupt every 20 ms
                     push   acc       
	  ; update new flag
	     mov    c,P1.5         ; Ring voltage detect
                     mov    StatFlag.0,c
 	     mov    c,P3.4	   ; on/off Hook detect
	     mov    StatFlag.1,c
	     clr       StatFlag.2
	     clr       StatFlag.3
	     clr       StatFlag.4
                     setb    StatFlag.7    ; data flag indicator
;-------- Check Busyl tone ---------
	     jnb      ContMsk.2,ChkDial
ChkBusy:	     mov    a,BusyTime
	     jnz      ChkBusy1
	     jb        P3.2,ChkDial    ; if dial detect pin = 1 then end
	     jnb      SnalFlag.0,ChkDial ; if old dial detect pin = 0 then end                   
ChkBusy1:    inc      BusyTime
             mov    a,BusyTime
             cjne    a,#25,$+3
	     jc       ChkBusy2      ; if  BusyTime<70 then ChkBusy2
             mov    a,BusyC1
	     cjne    a,#8,$+3
	     jc      BusyRes
	     mov    a,BusyC2
	     cjne    a,#8,$+3
	     jc      BusyRes
	     setb    StatFlag.2         ; force to send Busy flag
	     clr     StatFlagT.2
BusyRes:     clr     a
	     mov    BusyTime,a
	     mov    BusyC1,a
 	     mov    BusyC2,a
	     jmp     ChkDial
ChkBusy2:    cjne    a,#12,$+3
	     jc      ChkBusy3      ; if  BusyTime<45 then ChkBusy3
	     jnb     P3.2,ChkDial
	     inc     BusyC2
             jmp     ChkDial  
ChkBusy3:    jb      P3.2,ChkDial			     
	     inc     BusyC1
;-------- Check Dial tone ---------
ChkDial:     jnb      ContMsk.3,ChkRgBk
	     djnz    DialTime,ChkDial1
             mov     a,DialC1
             cjne    a,#45,$+3
	     jc      DialSnd0
	     setb    StatFlag.3       ; force to send Dial flag 1
	     clr     StatFlagT.3
	     jmp     DialRes
DialSnd0:    clr     StatFlag.3      ; force to send Dial flag 0
	     setb    StatFlagT.3
DialRes:     mov    DialTime,#70
	     mov    DialC1,#0
             jmp     ChkRgBk
ChkDial1:    mov     a,DialTime
	     cjne     a,#50,$+3
	     jnc       ChkRgBk
	     jb         P3.2,ChkRgBk
             inc       DialC1  
;-------- Check Ring back tone ---------
ChkRgBk:     jnb      ContMsk.4,ChkFlag
	     mov    a,RgBkTime
	     jnz      ChkRgBk1
	     jb        P3.2,ChkFlag    ; if dial detect pin = 1 then end
	     jnb      SnalFlag.0,ChkFlag ; if old dial detect pin = 0 then end                   
ChkRgBk1:   inc      RgBkTime
             mov    a,RgBkTime
             cjne    a,#25,$+3
	     jnc      ChkRgBk2       ; if  RgBkTime>24 then ChkRgBk2
	     jb        P3.2,ChkFlag
	     inc      RgBkC1
	     jmp     ChkFlag
ChkRgBk2:   cjne     a,#100,$+3
	     jnc      ChkRgBk3       ; if  RgBkTime>99 then ChkRgBk3	 
                     jmp     ChkFlag
ChkRgBk3:   cjne     a,#200,$+3
	     jnc       ChkRgBk4      ; if  RgBkTime>199 then ChkRgBk4
	     jnb       P3.2,ChkFlag
	     inc       RgBkC2
	     jmp      ChkFlag
ChkRgBk4:   mov    a,RgBkC1
	     cjne    a,#20,$+3
	     jc	RgBkSnd0
	     mov    a,RgBkC2
	     cjne    a,#80,$+3
	     jc        RgBkSnd0
	     setb    StatFlag.4         ; force to send Ring Back flag 1
	     clr       StatFlagT.4
	     jmp     RgBkRes
RgBkSnd0:   clr       StatFlag.4         ; force to send Ring Back flag 0
	     setb    StatFlagT.4
RgBkRes:     clr       a
	     mov    RgBkTime,a
	     mov    RgBkC1,a
 	     mov    RgBkC2,a
;-------- Check detecter control flag --------
	  ; check   flag
ChkFlag:	     mov    a,ContMsk
	     anl      StatFlagT,a
	     anl      a,StatFlag
	     cjne    a,StatFlagT,TransFlag
	     jmp     UpdateOF
TransFlag:    jnb      ES,UpdateOF              ;  if PCCmd is not finish then not send
                     mov    PCCmd,#6eh               ;  force to send  status flag	     
	     jnb      StatFlag.2,StopDiaRB
                     clr       ContMsk.2                 ; stop check busy flag
StopDiaRB:  clr       ContMsk.3
	     clr       ContMsk.4
	  ; update old flag   
UpdateOF:    mov    StatFlagT,StatFlag
	     mov    c,P3.2
	     mov    SnalFlag.0,c      ; save old dial detect

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

;--------------------------
; Send/Receive DTMF (Int 1  interupt routine)
; register IP is enable timer0 to interrupt this service
;--------------------------
Int1Int:        push   psw
                   push   acc
                   push   b
                   mov    b,r1
	   mov    dptr,#DTMFCmd
 	   movx   a,@dptr         ; read DTMF status register and clear flag
                   mov    dptr,#DTMFDat     
                   jb        acc.2,GetTone
	   jb        acc.1,SndTone
                   jmp     Int1End
GetTone:     jb       acc.1,GetSndT
                   movx  a,@dptr
	   anl      a,#0fh
                   call     WriteQ  
                   jmp     Int1End
GetSndT:    movx  a,@dptr
	   anl      a,#0fh
	   push   acc
	   call     ReadQ
                   jc        Int1End               ; if Q empty then error and jmp end
	   movx  @dptr,a
                   pop     acc
                   call     WriteQ
                   jmp     Int1End
SndTone:    call     ReadQ
                    jc        Int1End	        ; if Q empty then error and jmp end
	    movx  @dptr,a             ; write to transmit data reg 
Int1End:       mov   r1,b 
                    pop    b
                    pop    acc
                    pop    psw
                    reti

;---------------------------------------------------------
;  Serial Interupt Routine
;---------------------------------------------------------
SerialInt:       clr     ES                  ; force to sleep serial interupts
	      push  psw	
	      push  acc                      
	      clr     TI	     ; stop transmit flag interupt
                      call   SerialEnd       ; exit Serial interrupt and enable receive DTMF(int1)	   
	      jnb    RI,TransInt     ; if not receive then TranInt
                      mov  a,SBUF         ; else
	      clr     RI 	     ; reset receive flag
	      cjne  a,#':',SerialNAK
	      call   Recv
	      jmp   TransInt
SerialNAK:     mov  a,#NAK
	      call   SndChar 	
TransInt:	      pop   acc
                      pop   psw
	      ret
SerialEnd:     reti

;---------------------------------------------------------
; Recv
;---------------------------------------------------------
Recv:            call    getByte
                      jc       RecvEr                ; read command or data byte
	      mov   RxDat,a
	      call    getByte               ; read check sum byte
	      jc       RecvEr
                      add    a,RxDat              ; calculate  check sum
	      jnz     RecvEr	           ; if check sum not zero then error
	      mov   a,RxDat
	      cjne   a,#StartCmd,$+3
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
                      call     Start20ms
ChkRecv:       jb        RI,CmmOvlap
                      jnb      LTimeFlag.0,ChkRecv
	      jmp     SndTxDat
SndStart:       mov    a,#':'
	      call     SndChar
SndTxDat:     mov    a,TxDat 
	      call     SndHex		; send data byte
	      mov    a,TxDat
                      cpl      a		; calculate check sum
	      inc      a
	      call     SndHex		; send check sum
	      call     GetChar
	      jc        SndStart
	      cjne    a,#ACK,SndStart
	      setb    ES     
                      ret
CmmOvlap:   mov  a,SBUF        
	      clr     RI 	            ; reset receive flag
                      cjne  a,#':',OvlapNAK
	      call   Recv
	      jmp   OvlapEnd
OvlapNAK:     mov  a,#NAK
	      call   SndChar                        	
OvlapEnd:     ret		            ; receive data or PCCmd then ES = 0
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
WriteQ:       push  IE	    ; save interrupt enable reg
	   clr      EX1	    ; disable DTMF (int1) interrupt
	   clr      ES	    ; disable serial interrupt
                   push  acc
 	   mov   a,IndxWR
	   inc     a
	   anl     a,#0fh
	   cjne   a,indxRD,WriteOk
WriteFull:   pop    acc
	   pop    IE	    ; restore interrupt enable reg
	   setb   c		    ; set error flag
                   ret
WriteOk:     mov   IndxWR,a
	   add    a,#StrtQBuf      ; Start Q buffer + Q index
	   mov   r1,a
	   pop    acc
	   mov   @r1,a
                   pop    IE	    ; restore interrupt enable reg
	   clr      c		    ; reset error flag
	   ret
;------------------------
; ReadQ
; use r1
;------------------------
ReadQ:       push  IE	    ; save interrupt enable reg
	   clr      EX1	    ; disable DTMF (int1) interrupt
	   clr      ES	    ; disable serial interrupt
	   mov   a,IndxRD
	   cjne   a,IndxWR,ReadOk
	   pop    IE	    ; restore interrupt enable reg   
	   setb   c                     ;  set error flag
                   ret
ReadOk:     inc     a
	   anl     a,#0fh     
	   mov   IndxRD,a
	   add    a,#StrtQBuf
	   mov   r1,a
	   mov   a,@r1                 
	   pop    IE	    ; restore interrupt enable reg   
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
;  20 ms timer
;   clear LTimeFlag.0 to start this timer
;   when finish => LTimeFlag.0 = 1
;-----------------------------------
Start20ms:     setb   LTimeFlag.0       ; stop timer
                       mov   LTime0,#1         ; set counter 1 * 20ms = 20 ms
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
