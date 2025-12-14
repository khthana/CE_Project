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
;IST_RLF_1   	:  (f) <= 10101111b ,C <= 0
;Execute        :  for 1 to 9 : rlf f,0
;		:  (w) <= 10101111b ,STATUS : UU0
                movlw   6
                movwf   STATUS
                movlw   B'10101111'
		movwf	FREG
                rlf	FREG,0
		movwf	FREG
		rlf	FREG,0
		movwf	FREG
		rlf	FREG,0
		movwf	FREG
		rlf	FREG,0
		movwf	FREG
		rlf	FREG,0
		movwf	FREG
		rlf	FREG,0
		movwf	FREG
		rlf	FREG,0
		movwf	FREG
		rlf	FREG,0
		movwf	FREG
		rlf	FREG,0
		movwf	FREG
                btfsc   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		addlw	H'51'
		btfss	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_RLF_2   	:  (f) <= 10101111b ,C <= 0
;Execute        :  for 1 to 9 : rlf f,1
;		:  (f) <= 10101111b ,STATUS : UU0
                movlw   6
                movwf   STATUS
                movlw   B'10101111'
		movwf	FREG
                rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
                btfsc   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		movf	FREG,0
		addlw	H'51'
		btfss	STATUS, 0
		goto 	error_occur
;--------------------------------------------------------
;IST_RLF_3   	:  FSR <= 0x20h, INDF  <= 10101111b ,C <= 0
;Execute        :  for 1 to 9 : rlf INDF,1
;		:  (f) <= 10101111b ,STATUS : UU0
                movlw   6
                movwf   STATUS
		movlw	H'20'
		movwf	FSR
                movlw   B'10101111'
		movwf	INDF
                rlf	INDF,1
		rlf	INDF,1
		rlf	INDF,1
		rlf	INDF,1
		rlf	INDF,1
		rlf	INDF,1
		rlf	INDF,1
		rlf	INDF,1
		rlf	INDF,1
                btfsc   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		movf	INDF,0
		addlw	H'51'
		btfss	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_RRF_1   	:  (f) <= 11111010b ,C <= 0
;Execute        :  for 1 to 9 : rrf f,0
;		:  (w) <= 11111010b ,STATUS : UU0
                movlw   6
                movwf   STATUS
                movlw   B'11111010'
		movwf	FREG
                rrf	FREG,0
		movwf	FREG
		rrf	FREG,0
		movwf	FREG
		rrf	FREG,0
		movwf	FREG
		rrf	FREG,0
		movwf	FREG
		rrf	FREG,0
		movwf	FREG
		rrf	FREG,0
		movwf	FREG
		rrf	FREG,0
		movwf	FREG
		rrf	FREG,0
		movwf	FREG
		rrf	FREG,0
		movwf	FREG
                btfsc   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		addlw	H'06'
		btfss	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_RRF_2   	:  (f) <= 11111010b ,C <= 0
;Execute        :  for 1 to 9 : rrf f,1
;		:  (f) <= 11111010b ,STATUS : UU0
                movlw   6
                movwf   STATUS
                movlw   B'11111010'
		movwf	FREG
                rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
		rlf	FREG,1
                btfsc   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		movf	FREG,0
		addlw	H'06'
		btfss	STATUS, 0
		goto 	error_occur
;--------------------------------------------------------
;IST_RRF_3   	:  FSR <= 0x20h, INDF  <= 11111010b ,C <= 0
;Execute        :  for 1 to 9 : rrf INDF,1
;		:  (f) <= 11111010b ,STATUS : UU0
                movlw   6
                movwf   STATUS
		movlw	H'20'
		movwf	FSR
                movlw   B'11111010'
		movwf	INDF
                rrf	INDF,1
		rrf	INDF,1
		rrf	INDF,1
		rrf	INDF,1
		rrf	INDF,1
		rrf	INDF,1
		rrf	INDF,1
		rrf	INDF,1
		rrf	INDF,1
                btfsc   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		movf	INDF,0
		addlw	H'06'
		btfss	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_SWAP_1   	:  (f) <= 0xA5
;Execute        :  swapf f,0
;		:  (w) <= 0x5A ,STATUS : UUU
                movlw   7
                movwf   STATUS
                movlw   H'A5'
		movwf	FREG
                swapf	FREG,0
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		iorwf	FREG,0
		addlw	1
		btfss	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_SWAP_2   	:  (f) <= 0x5A
;Execute        :  swapf f,1
;		:  (f) <= 0xA5 ,STATUS : UUU
                movlw   7
                movwf   STATUS
                movlw   H'5A'
		movwf	FREG
                swapf	FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		iorwf	FREG,0
		addlw	1
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
