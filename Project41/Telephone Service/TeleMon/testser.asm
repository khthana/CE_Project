
atohOK         EQU    1
atohError      EQU    2
BAUD96         EQU   0fdh
ACK            EQU   6h
NAK            EQU   15h
CAN            EQU   18h

StackPtr       EQU    22h         ;  StackPtr    DS   5eh

               ORG   0000h
               jmp   ColdStart                 ; power on/reset vector

               ORG   0003h
               reti                                   ; external int 0 vector

               ORG   000Bh
               reti                                  ; timer 0 overflow vector

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

               mov   ip,#00h           ; set timer 0 to high priority
               mov   scon,#40h      ; serial port mode 1(data 8 bit,stop 1 bit)

               mov   tmod,#21h      ;              Gate  C/T  M1  M0
               mov   tcon,#05h      ;   Timer 1     0     0   1   0
                                    ;   Timer 0     0     0   0   1
                                    ;   Edge pulse detect

               mov   th1,#BAUD96    ; set timer 1 reload value

;               mov   th0,#04Ch
;               mov   th0,#0FFh
               mov   th0,#0DCh
               mov   tl0,#040h      ; set timer 0 interupt every 10 ms


               setb   tr1                     ; start timer 1
;               setb   tr0                      start timer 0

               setb   ren                     ; enable serial reception
               clr    ri                      ; first use setup
               clr    ti                      ; first use setup

               setb   EA                      ; global interupt enable
               ret
;---------------------------------------------------------
;  Serial Interupt Routine
;---------------------------------------------------------
SerialInt:       jnb   RI,s2
                     mov  a,SBUF
	     clr  RI
s2:                mov  r6,#8
s3:                djnz  r6,s3
                     reti
                      
;---------------------------------------------------------
;  GetChar
;        Read a character from the serial port.
;        Return the character in the accumulator.
;---------------------------------------------------------
GetChar:      jnb    ri,$        ; jump here if Bit RI not set (waiting loop)
              mov  a,sbuf
              clr     ri
              ret

;---------------------------------------------------------
;  SndChar
;       Send a character in the accumulator to the serial port.
;---------------------------------------------------------
SndChar:      jnb    ti,$        ; wait here for transmitter to clear
              clr     ti         ; clear transmit flag
              mov  sbuf,a        ; load character into transmitter
              ret

;---------------------------------------------------------
;  Writeln
;        Send carring return and line feed character to the serial port
;---------------------------------------------------------
Writeln:      mov    a,#0ah
              lcall    SndChar
              mov    a,#0dh
              lcall    SndChar
              ret

;-------------------------------
; Get Byte
; ACC = Get 1 Byte
;-------------------------------
GetByte:      push   b
              call   GetChar
              call   asctoh
              cjne   r0,#atohOK,GetByteEr
              swap   a
              mov    b,a
              call   GetChar
              call   asctoh
              cjne   r0,#atohOK,GetByteEr
              orl    a,b
GetByteEr:    pop    b
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
asctoh1:      mov   r0,#atohError
              ret
;------------------
;  to upper
; 
;------------------
ToUpper:      cjne  a,#'a',$+3
              jc    endupper          ; If ACC<'a' Then return
              cjne  a,#'{',$+3
              jc    toupper1          ; If ACC<='z' Then convert to upper case
              ret                       ; Else return
toupper1:     clr    c
              subb  a,#20h
endupper:     ret

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

htoas:          anl   a,#0fh
                cjne  a,#0ah,$+3
                jnc   htoas1
                orl   a,#30h
                ret
htoas1:         subb  a,#9h
                orl   a,#40h
                ret

;---------------------
; send hex (0..0ffh)
; input  a
; use    a,r2,r3
;---------------------
SndHexH:        call htoa
                mov   a,r2
                call  SndChar
                mov   a,r3
                call  SndChar
                mov   a,#68h   ;  xxh
                call  SndChar
                ret

;---------------------
; send hex (0..0ffh)
; input  a
; use    a,r2,r3
;---------------------
SndHex:         call  htoa
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
SndMes:       push  acc
              push  dpl
              push  dph
SndMesLp:     clr   a
              movc  a,@a+dptr          ; get character
              jz    SndMesEnd
              call  SndChar
              inc   dptr
              jmp   SndMesLp
SndMesEnd:    pop   dph
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


            END
