;    Last change:  C    28 Jan 97    7:17 pm
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
;---   Set all bit in PORT A,B to zero.
		bcf     STATUS, 5
                movwf   PORTA
                movwf   PORTB
LOOP		call    delay3
		call	delay3
		comf	PORTA,1
		comf	PORTB,1
		goto	LOOP

;---  For calling delay1 use 775 cycles
delay1		movlw	H'FF'
		movwf	SEG1
dec_loop1	decfsz	SEG1,1
		goto	dec_loop1
		return
;---  For calling delay2 use 199,175 cycles
delay2		movlw	H'FF'
		movwf	SEG2
dec_loop2	decfsz	SEG2,1
		call	delay1
		goto	dec_loop2
		return
;---  For calling delay3 use 50,192,863 cycles
delay3		movlw	D'252'
		movwf	AREG
dec_loop3	decfsz	AREG,1
		call	delay2
		goto	dec_loop3
		return
		nop
END
