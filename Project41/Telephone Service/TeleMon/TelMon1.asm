;------------------------------------
;  Telephone Service DOS V1.0
;  Program by T.Krissada
;   Com,Eng KMIT'L 1999
;  CPU 89C51
;  17/4/1998
;------------------------------------
atohOK         EQU    1
atohError      EQU    2
BAUD96         EQU   0fdh
ACK            EQU   6h
NAK            EQU   15h
CAN            EQU   18h

OrgSub1        EQU   0800h
OrgSub2        EQU   0880h
OrgSub3        EQU   0900h
OrgSub4        EQU   0980h
OrgSub5        EQU   0A00h
OrgSub6        EQU   0A80h
OrgSub7        EQU   0B00h
OrgSub8        EQU   0B80h
OrgSub9        EQU   0C00h

InfraLft       EQU    0FF4h
InfraFnt       EQU    0FF3h
InfraRgh       EQU    0FF2h
VDO_Gnd        EQU    0FF1h
VDO_Dat        EQU    0FF0h

VDO_Buf        EQU    0FE1h       ;  VDO_Buf     DS   7
VDO_Flag       EQU    0FE0h
;---------------------------------------------
; Define internal data address for variables
;---------------------------------------------
StackPtr       EQU    22h         ;  StackPtr    DS   5eh

FuncSel        EQU    021h
LTimeFlag      EQU    020h
LTime2         EQU    01Fh
LTime1         EQU    01Eh
LTime0Hi       EQU    01Dh
LTime0Lo       EQU    01Ch
RunAddrLo      EQU    01Bh
RunAddrHi      EQU    01Ah
VDO_dig        EQU    019h
VDO_idx        EQU    018h


DataBuf        EQU    08h         ;  DataBuf     DS   10h
DataLen        EQU    07h
LAddrHi        EQU    06h
LAddrLo        EQU    05h
ChkSum         EQU    04h
RecType        EQU    03h

               ORG   0000h
               jmp   ColdStart                 ; power on/reset vector

               ORG   0003h
               jmp   Int0Int                   ; external int 0 vector

               ORG   000Bh
               jmp   Timer0Int                 ; timer 0 overflow vector

               ORG   0013h
               jmp   Int1Int                   ; external int 1 vector
 
               ORG   001Bh
               reti                            ; timer 1 overflow vector

               ORG   0023h
               reti                            ; serial I/O interrupt vector

               ORG   0080h
ColdStart:     mov    sp,#StackPtr
               call   Init
               call   InitVar
               setb   ET0
               setb   EX0
               setb   EX1
               jmp    Main

               ORG    0100h
Main:          mov    a,#0fh
               call   DispNumLft
               mov    a,FuncSel
               call   DispNumRgh
loop:          jnb    LTimeFlag.7,DoInt1
               jmp    loop
DoInt1:        mov    a,FuncSel
Int1Func0:     cjne   a,#0,Int1Func1
               call   DownLoad
               mov    a,#2
               call   DelaySec

               mov    a,#0fh
               call   DispNumLft
               clr    a
               mov    FuncSel,a
               call   DispNumRgh
               setb   LTimeFlag.7
               jmp    loop
Int1Func1:     cjne   a,#1,Int1Func2
               push   RunAddrLo
               push   RunAddrHi
               setb   LTimeFlag.7
               ret
               jmp    loop

Int1Func2:     cjne   a,#2,Int1Func3
               mov    a,#00h
               push   acc
               mov    a,#11h
               push   acc
               setb   LTimeFlag.7
               ret
               jmp    loop

Int1Func3:     cjne   a,#3,Int1Func4
               setb   LTimeFlag.7
               call   InfTest
               jmp    loop

Int1Func4:     cjne   a,#4,Int1Func5
               setb   LTimeFlag.7
               call   SMTest
               jmp    loop

Int1Func5:     mov    a,#0fh
               call   DispNumLft
               clr    a
               mov    FuncSel,a
               call   DispNumRgh
               setb   LTimeFlag.7
               jmp    loop

;-----------------------------------
; Off 7 Seg
;-----------------------------------
Off7Seg:       push   acc
               push   dpl
               push   dph
               mov    dptr,#VDO_Flag
               movx   a,@dptr
               anl    a,#0E7h
               movx   @dptr,a
               pop    dph
               pop    dpl
               pop    acc
               ret
;-----------------------------------
; On 7 Seg
;-----------------------------------
On7Seg:        push   acc
               push   dpl
               push   dph
               mov    dptr,#VDO_Flag
               movx   a,@dptr
               orl    a,#018h
               movx   @dptr,a
               pop    dph
               pop    dpl
               pop    acc
               ret

;-------------------------------------
;  Setup Pointer
;-------------------------------------
InitVar:       mov   LTime0Lo,#0
               mov   Ltime0Hi,#0
               mov   LTime1,#0
               mov   LTime2,#0
               mov   LTimeFlag,#0ffh
               mov   VDO_Idx,#0
               mov   VDO_Dig,#0FFh
               mov   dptr,#VDO_Flag
               mov   a,#18h
               movx  @dptr,a
               mov   dptr,#VDO_GND
               mov   a,#0FFh
               movx  @dptr,a
               clr   a
               mov   dptr,#(VDO_Buf+1)
               movx  @dptr,a
               mov   dptr,#(VDO_Buf+3)
               movx  @dptr,a
               mov   FuncSel,a
               ret
;-------------------------------------
;  Setup Pointer
;-------------------------------------
InitVarTst:    mov   LTime0Lo,#4
               mov   Ltime0Hi,#0
               mov   LTime1,#8
               mov   LTime2,#0
               mov   LTimeFlag,#01
               mov   dptr,#VDO_Flag
               mov   a,#19h
               movx  @dptr,a
               mov   dptr,#(VDO_Buf+1)
               clr   a
               movx  @dptr,a
               inc   dptr
               movx  @dptr,a
               ret
;------------------------------------------
;  Initialize
;------------------------------------------
Init:          mov   pcon,#0
               mov   IE,#0                ; disable all interupts
               mov   a,#0ffh              ; deactivate output ports
               mov   p0,a
               mov   p1,a
               mov   p2,a
               mov   p3,a

               mov   ip,#02h        ; set timer 0 to high priority
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
               setb   tr0                     ; start timer 0

               setb   ren                     ; enable serial reception
               clr    ri                      ; first use setup
               setb   ti                      ; first use setup

               setb   EA                      ; global interupt enable
               ret
;--------------------------
; Int 0  interupt routine
;--------------------------
Int0Int:       push   psw
               push   acc
               mov    a,#0fh
               call   DispNumLft
               mov    a,FuncSel
               call   DispNumRgh
               mov    a,#50
               call   DelayMs
               mov    a,p3
               jb     acc.2,Int0Ext
               inc    FuncSel
               anl    FuncSel,#07h
               mov    a,FuncSel
               call   DispNumRgh
Int0Ext:       pop    acc
               pop    psw
               reti
;--------------------------
; Int 1  interupt routine
;--------------------------
Int1Int:       mov    r1,sp
               push   psw
               push   acc
               mov    a,#50
               call   DelayMs
               mov    a,p3
               jb     acc.3,Int1Ext
               mov    @r1,#01h
               dec    r1
               mov    @r1,#00h
               clr    LTimeFlag.7
Int1Ext:       pop    acc
               pop    psw
               reti
;----------------------
; Timer 0 interupt routine
;----------------------
Timer0Int:     push   psw       ; set timer 0 interupt every 10 ms
               push   acc
               call   ScanVDO        ; 10 ms
               clr    TR0            ; (-4600+64) = 10000h-2400h+40h = DC40h
               mov    th0,#0DCh      ; 20 ms
;               mov    th0,#0FFh
               mov    tl0,#040h      ; (-9216+64) = 10000h-4800h+40h = B840h
               setb   TR0
               jb     LTimeFlag.2,ti2
               mov    a,LTime0Lo
               cjne   a,#0,ti1
               dec    Ltime0Hi
ti1:           djnz   Ltime0Lo,ti2
               mov    a,Ltime0Hi
               cjne   a,#0,ti2
               setb   LtimeFlag.2

ti2:           jb     LTimeFlag.1,ti3
               djnz   Ltime1,ti3
               setb   LtimeFlag.1

ti3:           jb     LTimeFlag.0,ti4
               djnz   Ltime2,ti4
               setb   LtimeFlag.0
ti4:
               pop    acc
               pop    psw
               reti

;-----------------------------------------
;  ScanVDO
;-----------------------------------------
ScanVDO:       push   dpl
               push   dph
               push   b

               mov    a,VDO_Idx
               clr    c
               subb   a,#5
               jc     ScanVDO1
ScanVDO0:      mov    VDO_Idx,#0          ; If VDO_Idx>4 THEN VDO_Idx=0
ScanVDO1:
               mov    dptr,#VDO_Flag
               movx   a,@dptr
               anl    a,#01Fh
               mov    b,a
ScanAgain:     mov    a,VDO_Idx

               cjne   a,#0,ScanVDO3
               jnb    b.4,ScanChkNxt
               mov    dptr,#VDO_Buf
               movx   a,@dptr
               mov    b,a
               inc    dptr
               movx   a,@dptr
               jz     ScanVDO2
               anl    b,#7fh                ; display dot
ScanVDO2:      mov    VDO_Dig,#0FDh
               jmp    ScanVDOex

ScanVDO3:      cjne   a,#1,ScanVDO5
               jnb    b.3,ScanChkNxt

               mov    dptr,#(VDO_Buf+2)    ; dptr = VDO_Buf
               movx   a,@dptr
               mov    b,a
               inc    dptr
               movx   a,@dptr
               jz     ScanVDO4
               anl    b,#7fh
ScanVDO4:      mov    VDO_Dig,#0FEh
               jmp    ScanVDOex

ScanVDO5:      cjne   a,#2,ScanVDO6
               jnb    b.2,ScanChkNxt

               mov    dptr,#(VDO_Buf+4)
               movx   a,@dptr
               mov    b,a
               mov    VDO_Dig,#0F4h
               jmp    ScanVDOex

ScanVDO6:      cjne   a,#3,ScanVDO7
               jnb    b.1,ScanChkNxt

               mov    dptr,#(VDO_Buf+5)
               movx   a,@dptr
               mov    b,a
               mov    VDO_Dig,#0ECh
               jmp    ScanVDOex

ScanVDO7:      cjne   a,#4,ScanVDO0
               jnb    b.0,ScanChkNxt

               mov    dptr,#(VDO_Buf+6)
               movx   a,@dptr
               mov    b,a
               mov    VDO_Dig,#0F8h
               jmp    ScanVDOex

ScanChkNxt:    mov    a,b
               jz     ScanVDOoff
               inc    VDO_Idx
               mov    a,VDO_Idx
               clr    c
               subb   a,#5
               jc     ScanAgain
               mov    VDO_Idx,#0          ; If VDO_Idx>4 THEN VDO_Idx=0
               jmp    ScanAgain

ScanVDOoff:    mov    VDO_Dig,#0FCh

ScanVDOex:     mov    dptr,#VDO_Gnd
               mov    a,#0FCh
               movx   @dptr,a              ; VDO off

               mov    dptr,#VDO_Dat
               mov    a,b
               movx   @dptr,a
               inc    dptr
               mov    a,VDO_Dig
               movx   @dptr,a
ScanVDOend:    inc    VDO_Idx
               pop    b
               pop    dph
               pop    dpl
               ret

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
; Infraled Test
;-------------------------------
InfTest:      mov   dptr,#0fe0h         ; flag bit   display
              mov   a,#07h              ;    4      7 SEG Left
              movx  @dptr,a             ;    3      7 SEG right
                                        ;    2       LED left
InfTest1:     call  SenseInf            ;    1       LED front
                                        ;    0       LED right
              mov   dptr,#0ff4h
              movx  a,@dptr
              mov   dptr,#0fe5h
              movx  @dptr,a

              mov   dptr,#0ff3h
              movx  a,@dptr
              mov   dptr,#0fe6h
              movx  @dptr,a

              mov   dptr,#0ff2h
              movx  a,@dptr
              mov   dptr,#0fe7h
              movx  @dptr,a

              mov   a,#3
              call  DelayMs
              jmp   InfTest1

              ret

;---------------
; Sense Infraled
;---------------
SenseInf:  push  acc

           clr   p3.4

;           mov   a,#150
           mov   a,#115
           djnz  acc,$             ; delay 250 us

           setb  p3.5
           mov   a,#230
           djnz  acc,$             ; delay 499.13 us
           clr   p3.5

;           mov   a,#80
           mov   a,#115
           djnz  acc,$             ; delay 250 us

           setb  p3.4

           pop   acc
           ret

;-------------------------------
; Stepper Motor Test
;-------------------------------
SMTest:    mov   a,FuncSel
           cjne  a,#0,SMTest1
           mov   a,#0D7h
           mov   p1,a
           jmp   SMTest

SMTest1:   cjne  a,#1,SMTest2
           mov   a,#0D6h
           mov   p1,a
           mov   a,#5           ; at last 2 ms  ,4ms osciilate
           call  DelayMs
           mov   a,#092h
           mov   p1,a
           mov   a,#5           ; at last 2 ms  ,4 ms osciilate
           call  DelayMs
           jmp   SMTest

SMTest2:   cjne  a,#2,SMTest3
           mov   a,#0c7h
           mov   p1,a
           mov   a,#5           ; at last 2 ms  ,4ms osciilate
           call  DelayMs
           mov   a,#083h
           mov   p1,a
           mov   a,#5           ; at last 2 ms  ,4 ms osciilate
           call  DelayMs
           jmp   SMTest

SMTest3:   cjne  a,#3,SMTest4
           mov   a,#0c6h
           mov   p1,a
           mov   a,#5           ; at last 2 ms  ,4ms osciilate
           call  DelayMs
           mov   a,#082h
           mov   p1,a
           mov   a,#5           ; at last 2 ms  ,4 ms osciilate
           call  DelayMs
           jmp   SMTest

SMTest4:   clr   a
           mov   FuncSel,a
           jmp   SMTest
           ret

;-------------------------------
; Down Load
;-------------------------------
DLready:      DB     ' THE IMPOSSIBLE OS V 1.0 ',0dh,0ah,'-',00h
DownLoad:     push   dpl
              push   dph
              mov    dptr,#DLready
              call   SndMes
              pop    dph
              pop    dpl
              mov    a,#0dh
              call   DispNumLft
              mov    a,#00
              call   DispNumRgh
              call   RunLTime30s
DownLoad1:    call   GetChar
              cjne   a,#':',DLWait1
              call   GetRecord
              jnc    DownLoad2
              mov    a,#NAK
              call   SndChar
              mov    a,#01                     ; Error d1 ,Get record error
              call   DispNumRgh
              call   DelaySec
              clr    a
              call   DispNumRgh
              jmp    DownLoad1

DLWait1:      jnb    LTimeFlag.2,DownLoad1
              mov    a,#02                 ; Error d2 ,Get record time out
              call   DispNumRgh
              ret

DownLoad2:    cjne   a,#0,DownLoad6
              mov    RunAddrLo,LAddrLo
              mov    RunAddrHi,LAddrHi
              call   WriRecord
              jc     DownLoad8
              mov    a,#ACK
              call   SndChar

DownLoad3:    call   RunLTime30s
DownLoad4:    call   GetChar
              cjne   a,#':',DLWait2
              call   GetRecord
              jnc    DownLoad5
              mov    a,#NAK
              call   SndChar
              mov    a,#01                  ; Error d1 ,Get record error
              call   DispNumRgh
              call   DelaySec
              clr    a
              call   DispNumRgh
              jmp    DownLoad4

DLWait2:      jnb    LTimeFlag.2,DownLoad4
              mov    a,#02h                ; Error d2 ,Get record time out
              call   DispNumRgh
              ret

DownLoad5:    cjne   a,#0,DownLoad6
              call   WriRecord
              jc     DownLoad8
              mov    a,#ACK
              call   SndChar
              jmp    DownLoad3

DownLoad6:    cjne   a,#1,DownLoad7
              ret

DownLoad7:    mov    a,#03h                ; Error d3 ,Unknow error
              call   DispNumRgh
              ret

DownLoad8:    mov    a,#04h
              call   DispNumRgh
              mov    a,#CAN
              call   SndChar
              ret
;-------------------------------
;  Write Record
;-------------------------------
WriRecord:    push   dpl
              push   dph
              push   b
              mov    dpl,LAddrLo
              mov    dph,LAddrHi
              mov    r2,DataLen
              mov    r1,#DataBuf
WriRec1:      mov    a,@r1
              inc    r1
              movx   @dptr,a
              inc    dptr
              djnz   r2,WriRec1
              ;---- Verify data ----
              mov    dpl,LAddrLo
              mov    dph,LAddrHi
              mov    r2,DataLen
              mov    r1,#DataBuf
WriRec2:      mov    b,@r1
              inc    r1
              movx   a,@dptr
              inc    dptr
              cjne   a,b,WriRec3
              djnz   r2,WriRec2

              clr    c               ; No error
              jmp    WriRecExt
WriRec3:      setb   c

WriRecExt:    pop    b
              pop    dph
              pop    dpl
              ret
;-------------------------------
; Get record
;-------------------------------
GetRecord:    mov    ChkSum,#0

              call   GetByte
              cjne   r0,#atohOK,GetRecErr
              mov    DataLen,a
              clr    c
              subb   a,#(16+1)
              jnc    GetRecErr

              call   GetByte
              cjne   r0,#atohOK,GetRecErr
              mov    LAddrHi,a

              call   GetByte
              cjne   r0,#atohOK,GetRecErr
              mov    LAddrLo,a

              call   GetByte
              cjne   r0,#atohOK,GetRecErr
              mov    RecType,a

              cjne   a,#0,GetRecT1

              mov    r1,#DataBuf
              mov    r2,DataLen
GetRecT0:
              call   GetByte
              cjne   r0,#atohOK,GetRecErr
              mov    @r1,a

              add    a,ChkSum
              mov    ChkSum,a
              inc    r1
              djnz   r2,GetRecT0
              jmp    GetRecTail

GetRecT1:     mov    a,RecType
              cjne   a,#1,GetRecErr

GetRecTail:   call   GetByte
              cjne   r0,#atohOK,GetRecErr
              add    a,ChkSum
              add    a,DataLen
              add    a,LAddrLo
              add    a,LAddrHi
              add    a,RecType
              jnz    GetRecErr

              mov    a,RecType
              clr    c
              jmp    GetRecExt
GetRecErr:
              setb   c
GetRecExt:    ret

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

;-----------------------------------
;  RunLTime2
;   A = LTimer2
;-----------------------------------
RunLTime2:     setb   LTimeFlag.0
               mov    LTime2,a
               clr    LTimeFlag.0
               ret

;-----------------------------------
;  ChkLTime2
;   A == 0 -> Long Timer 2 is running
;   A != 0 -> Long Timer 2 is stop
;-----------------------------------
ChkLTime2:     clr     a
               jnb     LTimeFlag.0,Ltime2Ext
               mov     a,#0ffh
LTime2Ext:     ret

;---------------------------------
; RunLTime30s
;---------------------------------
RunLTime30s:   setb   LTimeFlag.2
               mov    LTime0Lo,#58h
               mov    Ltime0Hi,#02h
               clr    LTimeFlag.2
               ret

              ORG   OrgSub1
Font7Seg:      DB     0C0h,0F9h,0A4h,0B0h,099h,092h,082h,0F8h
               DB     080h,090h,088h,083h,0C6h,0A1h,086h,08Eh

              ORG   OrgSub2
;------------------------------
; DispNum Right
; ACC = Number 0..Fh
;------------------------------
DispNumRgh:    push   acc
               push   dpl
               push   dph
               anl    a,#0fh
               mov    dptr,#Font7Seg
               movc   a,@a+dptr
               mov    dptr,#(VDO_Buf+2)
               movx   @dptr,a
               mov    dptr,#VDO_Flag
               movx   a,@dptr
               orl    a,#08h
               movx   @dptr,a
               pop    dph
               pop    dpl
               pop    acc
               ret

              ORG   OrgSub3
;------------------------------
; DispNum Left
; ACC = Number 0..Fh
;------------------------------
DispNumLft:    push   acc
               push   dpl
               push   dph
               anl    a,#0fh
               mov    dptr,#Font7Seg
               movc   a,@a+dptr
               mov    dptr,#(VDO_Buf)
               movx   @dptr,a
               mov    dptr,#VDO_Flag
               movx   a,@dptr
               orl    a,#10h
               movx   @dptr,a
               pop    dph
               pop    dpl
               pop    acc
               ret

              ORG   OrgSub4
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

              ORG   OrgSub5
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

              ORG   OrgSub6
;-----------------------------------
;  RunLTime0
;   A = LTimer0Lo
;   B = LTimer0Hi
;-----------------------------------
RunLTime0:     setb   LTimeFlag.2
               mov    LTime0Lo,a
               mov    Ltime0Hi,b
               clr    LTimeFlag.2
               ret

              ORG   OrgSub7
;-----------------------------------
;  ChkLTime0
;   A == 0 -> Long Timer 0 is running
;   A != 0 -> Long Timer 0 is stop
;-----------------------------------
ChkLTime0:    clr     a
              jnb     LTimeFlag.2,Ltime0Ext
              mov     a,#0ffh
LTime0Ext:    ret

              ORG   OrgSub8
;-----------------------------------
;  RunLTime1
;   A = LTimer1
;-----------------------------------
RunLTime1:     setb   LTimeFlag.1
               mov    LTime1,a
               clr    LTimeFlag.1
               ret

              ORG   OrgSub9
;-----------------------------------
;  ChkLTime1
;   A == 0 -> Long Timer 1 is running
;   A != 0 -> Long Timer 1 is stop
;-----------------------------------
ChkLTime1:    clr     a
              jnb     LTimeFlag.1,Ltime1Ext
              mov     a,#0ffh
LTime1Ext:    ret


            END
