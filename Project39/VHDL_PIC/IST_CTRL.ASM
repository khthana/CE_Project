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
;IST_NOP 	: W = UU , STATUS : UUU
		movlw	6
		movwf	STATUS
		movlw 	h'FF'
		nop
		nop
		addlw	1
		btfss	STATUS,0
		goto	error_occur
		btfss	STATUS,1
		goto	error_occur
		btfss	STATUS,2
		goto	error_occur

;--------------------------------------------------------
;IST_CALL_1 :	PCLATH <4:3> <= '00'
;		HERE   	: call THERE
;		TRUE	: ret
;       	THERE	: call TRUE
;			  ret
		movf	PCLATH,0
		andlw	B'11100111'
		movwf	PCLATH
		call	there_1


			
;--------------------------------------------------------
;IST_CALL_2 :	PCLATH <4:3> <= '11'
;		HERE   	: call THERE
;		TRUE	: ret
;       	THERE	: call TRUE
;			  ret
		movf	PCLATH,0
		iorlw	B'00011000'
		movwf	PCLATH
		call	there_1

;--------------------------------------------------------
;IST_CALL_3 :	PCLATH <4:3> <= '00'
;		HERE   	: call THERE
;		TRUE	: ret
;       	THERE	: call TRUE
;			  retlw	k
		movf	PCLATH,0
		andlw	B'11100111'
		movwf	PCLATH
		call	there_2
		addlw	1
		btfss	STATUS, 0
		goto	error_occur

;--------------------------------------------------------
;IST_CALL_4 :	PCLATH <4:3> <= '11'
;		HERE   	: call THERE
;		TRUE	: ret
;       	THERE	: call TRUE
;			  ret
		movf	PCLATH,0
		iorlw	B'00011000'
		movwf	PCLATH
		call	there_2
		addlw	1
		btfss	STATUS, 0
		goto	error_occur

;--------------------------------------------------------
;IST_INCFSZ_1 	: (f) <= 0x00
;		: incfsz f,1
;		: TRUE : true_routine
;		: FALSE: false_routine
		movlw	H'00'
		movwf	FREG
		incfsz	FREG,1
		goto	inc_skip
		goto	error_occur
inc_skip	movf	FREG,0
		addlw	H'FF'
		btfsc	STATUS, 0
		goto	test_inc_skip
		goto	error_occur
;--------------------------------------------------------
;IST_INCFSZ_2 	: (f) <= 0xFF
;		: incfsz f,0
;		: FALSE: false_routine
;		: TRUE : true_routine
test_inc_skip	movlw	H'FF'
		movwf	FREG
		incfsz	FREG,0
		goto	error_occur
		addlw	H'FF'
		btfss	STATUS, 0
		goto	skip_dec
		goto	error_occur

;--------------------------------------------------------
;IST_DECFSZ_1 	: (f) <= 0x01
;		: decfsz f,0
;		: FALSE: false_routine
;		: TRUE : true_routine
skip_dec	movlw	H'01'
		movwf	FREG
		decfsz	FREG,0
		goto	error_occur
		addlw	H'FF'
		btfss   STATUS, 0
		goto	test_dec_skip
		goto	error_occur

;--------------------------------------------------------
;IST_DECFSZ_2 	: (f) <= 0xFF
;		: decfsz f,1
;		: TRUE : true_routine
;		: FALSE: false_routine
test_dec_skip	movlw	H'FF'
		movwf	FREG
		decfsz	FREG,1
		goto	dec_skip
		goto	error_occur
dec_skip	movf	FREG,0
		addlw	H'01'
		btfss	STATUS,0
		goto 	correct_result
		goto	error_occur

;----------------------------------------------------
;IST_GOTO_1	: PCLATH <4:3> <= '00'
;----------------------------------------------------
true_1	 	goto	test_b1
test_b1		return
there_1		call	true_1
		return

;----------------------------------------------------
;IST_GOTO_1	: PCLATH <4:3> <= '11'
;----------------------------------------------------
true_2	 	goto 	test_b2
test_b2		return
there_2		call	true_2
		retlw	H'FF'

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
