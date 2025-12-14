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
;IST_DECF_1   	:  (f) <= 0xFF
;Execute        :  decf	f,1
;		:  (f) <= 0xFE ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'FF'
		movwf	FREG
                decf	FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		movf	FREG,0
		addlw	H'02'
		btfss	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_DECF_2   	:  (f) <= 0x00
;Execute        :  decf	f,1
;		:  (f) <= 0xFF ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'00'
		movwf	FREG
                decf	FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		movf	FREG,0
		addlw	H'01'
		btfss	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_INCF_1   	:  (f) <= 0xFF
;Execute        :  incf	f,0
;		:  (f) <= 0x01 ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'FF'
		movwf	FREG
                incf	FREG,0
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		addlw	H'FF'
		btfsc	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_INCF_2   	:  (f) <= 0xF
;Execute        :  incf	f,1
;		:  (f) <= 0x10 ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'0F'
		movwf	FREG
                incf	FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		movf	FREG,0
		addlw	H'F0'
		btfss	STATUS, 0
		goto 	error_occur

correct_result  bcf     STATUS, 5
                movlw   H'FF'
                movwf   PORTA
                movwf   PORTB
stay1		goto    stay1
error_occur     bcf     STATUS, 5
                movlw   H'FF'
                movwf   PORTA
stay2		goto    stay2
		nop

	END
