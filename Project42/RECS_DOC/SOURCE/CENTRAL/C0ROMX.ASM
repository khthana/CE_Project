; For board 188 ,2 flash & 2 srm last edit 03/03/2000
	NAME    c0romx
	PAGE    60,96
	TITLE   C0ROMX - ROM Startup Code and Config 80188

;       Segment and Group declarations

_TEXT   SEGMENT BYTE PUBLIC 'CODE'
_TEXT   ENDS
_DATA   SEGMENT PARA PUBLIC 'DATA'
stdata@ label byte                      ; Start data is assigned
_DATA   ENDS
_DATAEND   SEGMENT PARA PUBLIC 'DATAEND'
endata@ label byte                      ; End data is assigned
_DATAEND   ENDS
_BSS    SEGMENT BYTE PUBLIC 'BSS'
;WORD PUBLIC 'BSS'                      ; Start data is not assigned 
stbss@ label byte
_BSS    ENDS
_BSSEND SEGMENT BYTE PUBLIC 'BSSEND'
endbss@ label byte                      ; End data is not assigned
_BSSEND ENDS

DGROUP  GROUP   _BSS, _BSSEND
CGROUP  GROUP   _TEXT, _DATA, _DATAEND

; The following values will depend upon the amount and location of RAM
; This example assumes 32K of RAM starting at 0000:0
; The "startds" value puts the _BSS segment at 0:100 (allowing for
;  up to 256 bytes of interrupt vectors).
;  _BSS is 28K less 256 bytes

startds equ     00h

; These values set up the last 4K of the 32K RAM as a stack

startss equ     00h
startsp equ     07000h          ; sets up 4K stack

	ASSUME  CS:CGROUP, DS:DGROUP

_TEXT   SEGMENT
	extrn   _main:near
	public  STARTX

STARTX  PROC    NEAR
realstart:
COLD:   ;MOV     AX,40h                          ; Entered by POWER_ON/RESET
	;MOV     DS,AX
	;MOV     Word ptr DS:72h,0               ; Show data areas not init

WARM:   CLI                                     ; Begin FLAG test of CPU
	XOR     AX,AX
	JB      HALT
	JO      HALT
	JS      HALT
	JNZ     HALT
	JPO     HALT
	ADD     AX,1
	JZ      HALT
	JPE     HALT
	SUB     AX,8002h
	JS      HALT
	INC     AX
	JNO     HALT
	SHL     AX,1
	JNB     HALT
	JNZ     HALT
	SHL     AX,1
	JB      HALT

	MOV     BX,0101010101010101b            ; Begin REGISTER test of CPU
CPUTST: MOV     BP,BX
	MOV     CX,BP
	MOV     SP,CX
	MOV     DX,SP
	MOV     SS,DX
	MOV     SI,SS
	MOV     ES,SI
	MOV     DI,ES
	MOV     DS,DI
	MOV     AX,DS
	CMP     AX,0101010101010101b
	JNZ     CPU1
	NOT     AX
	MOV     BX,AX
	JMP     CPUTST

CPU1:   XOR     AX,1010101010101010b
	JZ      CPU_OK

HALT:   HLT

CPU_OK: mov     dx,LCS_REGS             ; setup LCS to segment 0000:xxxx
	mov     ax,LCS_32K		; 07fcH		ucs = f83cH (in asm.bin)
	out     dx,ax
	mov     dx,MCS_SIZE             ; setup MCS size
	mov     ax,9038h
	out     dx,ax
	mov     dx,MCS_BASE             ; setup MCS base
	mov     ax,8002h;f802h
	out     dx,ax
	mov     dx,PCS_BASE             ; setup PCS base
	mov     ax,00fch		; c00, c80, d00, d80, e00, e80
	out     dx,ax

; Copy Variable exist value from ROM to RAM

	xor     ax,ax
	mov     es,ax
	mov     ax,cs 
	mov     ds,ax
	cld
	mov     di, offset CGROUP: stdata@
	mov     si, offset CGROUP: stdata@
	mov     cx, offset CGROUP: endata@
	sub     cx, di
	rep     movsb
	
	mov     ax,cs
	mov     es,ax
	mov     ax,startds
	mov     ds,ax
	mov     ax,startss
	mov     ss,ax
	mov     sp,startsp

	jmp     _main   ; will not return

;        org     07FF0h
;        mov     dx,UCS_REGS                     ; Setup UCS
;        mov     ax,LCS_32K
;        out     dx,ax
;        jmpf    0F000h,realstart
STARTX          ENDP
_TEXT   ENDS

_BSS    SEGMENT 
bdata@  label   byte
_BSS    ENDS

; The _BSSEND segment is defined only so that we can get "edata@"
;  as the end of _BSS for the above initialization code
; No other module defines a _BSSEND segment, so "edata@" is
;  guaranteed to be the last byte of _BSS

_BSSEND SEGMENT
edata@  label   byte
_BSSEND ENDS

	public  bdata@  ; make these show on the map
	public  edata@  ; they don't need to be public otherwise

UCS_32K         EQU     0F83CH
UCS_64K         EQU     0F03CH
LCS_08K         EQU     01FCH
LCS_32K         EQU     07FCH
LCS_64K         EQU     0FFCH

; Chip-Select Control Registers
UCS_REGS        EQU     0FFA0h
LCS_REGS        EQU     0FFA2h
PCS_BASE        EQU     0FFA4h
MCS_BASE        EQU     0FFA6h
MCS_SIZE        EQU     0FFA8h

; Set interrupt number
_Divide0         EQU     0
_Single_Step     EQU     1
_NMI_Pin         EQU     2
_Breakpoint      EQU     3
_Overflow        EQU     4
_BOUND           EQU     5
_Unused          EQU     6
_ESCape          EQU     7
_Timer0          EQU     8
_Reserved        EQU     9
_DMA0            EQU     10
_DMA1            EQU     11
_INT0            EQU     12
_INT1            EQU     13
_INT2            EQU     14
_INT3            EQU     15
_80187           EQU     16
_Reserved2       EQU     17
_Timer1          EQU     18
_Timer2          EQU     19
_Serial0_RX      EQU     20
_Serial1_TX      EQU     21

; Port of Interrupt Control Unit
Int3_REGS       EQU     0FF3Eh
Int2_REGS       EQU     0FF3Ch
Int1_REGS       EQU     0FF3Ah
Int0_REGS       EQU     0FF38h
DMA1_REGS       EQU     0FF36h
DMA0_REGS       EQU     0FF34h
TIMER_REGS      EQU     0FF32h
Int_Status      EQU     0FF30h
Request         EQU     0FF2Eh
In_Service      EQU     0FF2Ch
PRIMSK          EQU     0FF2Ah
Int_Masks       EQU     0FF28h
POLL_Status     EQU     0FF26h
POLL            EQU     0FF24h
_EOI            EQU     0FF22h

; Port of Register Timer
T2_Control      EQU     0FF66h
T2_Compare_A    EQU     0FF62h
T2_Count        EQU     0FF60h
T1_Control      EQU     0FF5Eh
T1_Compare_A    EQU     0FF5Ch
T1_Compare_B    EQU     0FF5Ah
T1_Count        EQU     0FF58h
T0_Control      EQU     0FF56h
T0_Compare_A    EQU     0FF54h
T0_Compare_B    EQU     0FF52h
T0_Count        EQU     0FF50h
	
	END
