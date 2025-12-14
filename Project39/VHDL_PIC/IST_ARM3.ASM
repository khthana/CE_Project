;    Last change:  C    28 Jan 97    7:19 pm
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
;IST_IORLW_1  	:  (w) <= 0x5A
;Execute        :  xorlw 0xA5
;               :  (w) = 0xff ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'5A'
                xorlw	H'A5'
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		addlw	1
		btfss	STATUS, 0
		goto	error_occur

;--------------------------------------------------------
;IST_IORLW_2  	:  (w) <= 0x00
;Execute        :  iorlw  0x00
;               :  (w) = 0x00 ,STATUS : 1UU
                movlw   0
                movwf   STATUS
                movlw   H'00'
                xorlw	H'00'
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		addlw	H'FF'
		btfsc	STATUS, 0
		goto	error_occur

;--------------------------------------------------------
;IST_IORWF_1   	:  (w) <= 0xA5, (f) <= 0x5A
;Execute        :  iorwf  f,0
;               :  (f) = 0xff ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'A5'
		movwf	FREG
		movlw	H'5A'
                iorwf	FREG,0
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		addlw	1
		btfss	STATUS, 0
		goto    error_occur
		
;--------------------------------------------------------
;IST_IORWF_2   	:  (w) <= 0xA5, (f) <= 0x5A
;Execute        :  iorwf  f,1
;               :  (w) = 0xFF ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'5A'
		movwf	FREG
		movlw	H'A5'
                iorwf	FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		movf	FREG,0
		addlw	1
		btfss	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_IORWF_3   	:  (w) <= 0x00, (f) <= 0x00
;Execute        :  iorwf  f,0
;               :  (f) = 0x00 ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'00'
		movwf	FREG
		movlw	H'00'
                iorwf	FREG,0
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
;IST_CLRF   	:  (f) <= 0x5A
;Execute        :  clrf  f
;		:  (f) = 0x00 ,STATUS : 1UU
                movlw   0
                movwf   STATUS
                movlw   H'5A'
		movwf	FREG
                clrf	FREG
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		movf	FREG,0
		addlw	H'FF'
		btfsc	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_CLRW   	:  (w) <= 0x5A
;Execute        :  clrw
;		:  (w) = 0x00 ,STATUS : 1UU
                movlw   0
                movwf   STATUS
                movlw   H'5A'
                clrw
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		addlw	H'FF'
		btfsc	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_COMF_1   	:  (f) <= 0x5A
;Execute        :  comf	f,0
;		:  (w) = 0xA5 ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'5A'
                movwf	FREG
		comf	FREG,0
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		addlw	H'5B'
		btfss	STATUS, 2
		goto 	error_occur

;--------------------------------------------------------
;IST_COMF_2   	:  (f) <= 0xFF
;Execute        :  comf	f,1
;		:  (f) = 0x00 ,STATUS : 1UU
                movlw   0
                movwf   STATUS
                movlw   H'FF'
                movwf	FREG
		comf	FREG,1
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur
		movf	FREG,0
		addlw	H'FF'
		btfsc	STATUS, 0
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
