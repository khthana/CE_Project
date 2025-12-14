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
		goto	start


;---   Set I/O pin for PORT A
;---   RA[4:0] = 5 bit output
		org	9
start           bsf     STATUS, 5
		movlw	B'00000001'
                movwf   TRISA
;---   SET I/O PIN FOR PORT B
;---   RB[7:0] = 8 bit output (No Interrupt on change)
                movlw	B'00000001'
                movwf   TRISB
;---   Disable all interrupt source and clear all interrupt flag [2:0]
                movlw   B'00000000'
                movwf   INTCON
;---   Set all bit in PORT A,B to zero.
		bcf     STATUS, 5
		movlw	B'00000000'
                movwf   PORTA
		movlw	B'00000011'
                movwf   PORTB
		movlw	H'FF'
		movwf	AREG
LOOP		btfsc	PORTA,1
		goto 	Tb_16K
;-- Test f = 500 Hz
		btfsc	PORTA,2
		goto	Tb_500K
Tb_500		call	delay1
		goto	show
;-- Test f = 500 KHz
Tb_500K		Call	delay3
		goto	show
;-- Test f = 16  KHz
Tb_16K		btfsc	PORTA,2
		goto	Tb_8M
		call	delay2
		goto	show
;-- Test f = 8   MHz
Tb_8M		call	delay3
		call	delay3
show		incf	AREG,1
		movf	AREG,0
		andlw	H'0F'
		call	pattern
		movwf	PORTB
		comf	PORTA
		goto	LOOP
;---  For calling delay1 use 80 cycles
delay1		movlw	D'25'
		movwf	SEG1
dec_loop1	decfsz	SEG1,1
		goto	dec_loop1
		return
;---  For calling delay2 use 2,050 cycles
delay2		movlw	D'25'
		movwf	SEG2
dec_loop2	decfsz	SEG2,1
		goto	d2_c_d1
		goto	ret_d2
d2_c_d1		call	delay1
		goto	dec_loop2
ret_d2		return
;---  For calling delay3 use 524,035 cycles
delay3		movlw	H'FF'
		movwf	TMP1
dec_loop3	decfsz	TMP1,1
		goto	d3_c_d2
		goto	ret_d3
d3_c_d2		call	delay2
		goto	dec_loop3
ret_d3		return
pattern		addwf	PCL,1
		retlw	B'00000011'	;--	when "0000" =>  --  abcdefgp 
		retlw	B'10011111'	;--	when "0001" =>
		retlw	B'00100101'	;--	when "0010" =>
		retlw	B'00001101'	;--	when "0011" =>
		retlw	B'10011001'	;--	when "0100" =>
		retlw	B'01001001'	;--	when "0101" =>
		retlw	B'01000001'	;--	when "0110" =>
		retlw	B'00011011'	;--	when "0111" =>
		retlw	B'00000001'	;--	when "1000" =>
		retlw	B'00001001'	;--	when "1001" =>
		retlw	B'00010001'	;--	when "1010" =>
		retlw	B'11000001'	;--	when "1011" =>
		retlw	B'01100011'	;--	when "1100" =>
		retlw	B'10000101'	;--	when "1101" =>
		retlw	B'01100001'	;--	when "1110" =>
		retlw	B'01110001'	;--	when "1111" =>
		nop
END
