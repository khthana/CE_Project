;    Last change:  C    28 Jan 97    7:18 pm
;---- This program is used for BCD adder.
	LIST  p=16C61
;---------------------------------------------
;  Register naming
;---------------------------------------------
INDF	equ	00h
TMR0	equ	01h
OPT	equ	01h
PCL	equ	02h
STATUS	equ	03h
FSR	equ	04h
PORTA	equ	05h
TRISA	equ	05h
PORTB	equ	06h
TRISB	equ	06h
PCLATH	equ	0Ah
INTCON	equ	0bh

;-----------------------------------------------
; Working register
;-----------------------------------------------
SEG1            =       21h
SEG2            =       22h
AREG            =       23h
SUM             =       0Ch
TMP1            =       0Dh
TMP2            =       0Eh
FREG            =       0fh
ITERATE         =       10h
CV_LOOP         =       11h
BINV            =       12h
SR1             =       14h
SR2             =       15h
ADT             =       16h

		org	0
		goto	start
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
		org	9
;---   Set I/O pin for PORT A
;---   RA[4:0] = 5 bit output
start           bsf     STATUS, 5
		movlw	B'00000000'
                movwf   TRISA
;---   SET I/O PIN FOR PORT B
;---   RB[7:0] = 8 bit output (No Interrupt on change)
                movlw	B'00000000'
                movwf   TRISB
;---   Disable all interrupt source and clear all interrupt flag [2:0]
                movlw   B'00000000'
                movwf   INTCON
;---   Set Increase method of TIMER   inc / 1 cyc
                movlw   B'00000000'
                movwf   OPT
;---   Set Initial value for TIMER
                bcf     STATUS, 5
                movlw   B'00000000'
                movwf   TMR0
;---   Set all bit in PORT A,B to zero.
                movwf   PORTA
                movwf   PORTB

;----------- Test for all instruction
;--------------------------------------------------------
;IST_BCF_BTSFSC :  (f) <= 0xFF
;Execute        :  for b = 0 to 7 : bcf f,b
;               :  f<b> = '1' , STATUS : UUU
                movlw   7
                movwf   STATUS
                movlw   H'FF'
		movwf	FREG
;-- Test bit 0
                bcf	FREG,0
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfsc   FREG, 0
                goto    error_occur
;-- Test bit 1
                bcf	FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfsc   FREG, 1
                goto    error_occur
;-- Test bit 2
                bcf	FREG,2
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfsc   FREG, 2
                goto    error_occur
;-- Test bit 3
                bcf	FREG,3
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfsc   FREG, 3
                goto    error_occur
;-- Test bit 4
                bcf	FREG, 4
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfsc   FREG, 4
                goto    error_occur
;-- Test bit 5
                bcf	FREG, 5
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfsc   FREG, 5
                goto    error_occur
;-- Test bit 6
                bcf	FREG, 6
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfsc   FREG, 6
                goto    error_occur
;-- Test bit 7
                bcf	FREG, 7
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfsc   FREG, 7
                goto    error_occur

;--------------------------------------------------------
;IST_BSF_BTFSS	:  (f) <= 0x00
;Execute        :  for b = 0 to 7 : bsf f,b
;               :  f<b> = '1' , STATUS : UUU
                movlw   7
                movwf   STATUS
                movlw   H'00'
		movwf	FREG
;-- Test bit 0
                bsf	FREG,0
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfss   FREG, 0
                goto    error_occur
;-- Test bit 1
                bsf	FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfss   FREG, 1
                goto    error_occur
;-- Test bit 2
                bsf	FREG,2
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfss   FREG, 2
                goto    error_occur
;-- Test bit 3
                bsf	FREG,3
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfss   FREG, 3
                goto    error_occur
;-- Test bit 4
                bsf	FREG, 4
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfss   FREG, 4
                goto    error_occur
;-- Test bit 5
                bsf	FREG, 5
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfss   FREG, 5
                goto    error_occur
;-- Test bit 6
                bsf	FREG, 6
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfss   FREG, 6
                goto    error_occur
;-- Test bit 7
                bsf	FREG, 7
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		btfss   FREG, 7
                goto    error_occur
		nop
		goto    correct_result
error_occur     bcf     STATUS, 5
                movlw   H'FF'
                movwf   PORTA
stay2		goto    stay2
correct_result  bcf     STATUS, 5
                movlw   H'FF'
                movwf   PORTA
                movwf   PORTB
stay1		goto    stay1

		nop

	END
