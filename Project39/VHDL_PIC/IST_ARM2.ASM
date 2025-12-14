;    Last change:  C    28 Jan 97    7:20 pm
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
;IST_SUBWF_1    :  (f) <= 255, (w) <= 127
;Execute        :  subwf f,0
;               :  (w) = 80h , STATUS : 011
                movlw  	D'255'
                movwf   FREG
                movlw   H'4'
                movwf   STATUS
                movlw   D'127'
                subwf   FREG,0
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
                addlw   H'80'
                btfss   STATUS, 0
                goto    error_occur

;--------------------------------------------------------
;IST_SUBWF_2    :  (f) <= 255, (w) <= 255
;Execute        :  subwf f,1
;               :  (f) = 0 ,STATUS : 111
                movlw   D'255'
                movwf   FREG
                movlw   0
                movwf   STATUS
                movlw   D'255'
                subwf   FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur

;--------------------------------------------------------
;IST_SUBWF_3    :  (f) <= 0, (w) <= 255
;Execute        :  subwf f,0
;               :  (w) = 01 ,STATUS : 000
                movlw   0
                movwf   FREG
                movlw   7
                movwf   STATUS
                movlw   D'255'
                subwf   FREG,0
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		addlw	H'FF'
		btfss	STATUS, 0
		goto	error_occur

;--------------------------------------------------------
;IST_SUBWF_4    :  (f) <= -128, (w) <= -127
;Execute        :  subwf f,0
;               :  (w) = -1 ,STATUS : 000
                movlw   H'00'
                movwf   FREG
                movlw   4
                movwf   STATUS
                movlw   H'01'
                subwf   FREG,0
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		addlw	1
		btfss	STATUS, 0
		goto 	error_occur

;--------------------------------------------------------
;IST_SUBLW_1    :  (w) <= 127
;Execute        :  sublw 255
;               :  (w) = 80h , STATUS : 011
                movlw   H'4'
                movwf   STATUS
                movlw   D'127'
                sublw	D'255'
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
                addlw   H'80'
                btfss   STATUS, 0
                goto    error_occur

;--------------------------------------------------------
;IST_SUBLW_2    :  (w) <= 255
;Execute        :  sublw 255
;               :  (f) = 0 ,STATUS : 111
                movlw   0
                movwf   STATUS
                movlw   D'255'
                sublw   D'255'
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur

;--------------------------------------------------------
;IST_SUBLW_3    :  (w) <= 255
;Execute        :  sublw 0
;               :  (w) = 01 ,STATUS : 000
                movlw   7
                movwf   STATUS
                movlw   D'255'
                sublw   0
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		addlw	H'FF'
		btfss	STATUS, 0
		goto	error_occur

;--------------------------------------------------------
;IST_SUBLW_4    :  (w) <= -127
;Execute        :  sublw -128
;               :  (w) = -1 ,STATUS : 000
                movlw   4
                movwf   STATUS
                movlw   H'81'
                sublw   H'80'
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		addlw	1
		btfss	STATUS, 0
		goto 	error_occur



;--------------------------------------------------------
;IST_XORLW_1  	:  (w) <= 0xAA
;Execute        :  xorlw 0x55
;               :  (w) = 0xff ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'AA'
                xorlw	H'55'
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
;IST_XORLW_2  	:  (w) <= 0xFF
;Execute        :  xorlw 0xFF
;               :  (w) = 0x00 ,STATUS : 1UU
                movlw   0
                movwf   STATUS
                movlw   H'FF'
                xorlw	H'FF'
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur

;--------------------------------------------------------
;IST_XORWF_1   	:  (w) <= 0xAA, (f) <= 0x55
;Execute        :  xorwf f,1
;               :  (f) = 0xff ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'55'
		movwf	FREG
		movlw	H'AA'
                xorwf	FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfsc   STATUS, 2
                goto    error_occur
		movf	FREG,0
		addlw	1
		btfss	STATUS, 0
		goto    error_occur
		
;--------------------------------------------------------
;IST_XORWF_2   	:  (w) <= 0xFF, (f) <= 0xFF
;Execute        :  xorwf f,0
;               :  (w) = 0 ,STATUS : 1UU
                movlw   0
                movwf   STATUS
                movlw   H'FF'
		movwf	FREG
		movlw	H'FF'
                xorwf	FREG,0
                btfsc   STATUS, 0
                goto    error_occur
                btfsc   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur

;--------------------------------------------------------
;IST_XORWF_2   	:  (w) <= 0x00, (f) <= 0x00
;Execute        :  xorwf f,1
;               :  (f) = 0xff ,STATUS : 0UU
                movlw   7
                movwf   STATUS
                movlw   H'00'
		movwf	FREG
		movlw	H'00'
                xorwf	FREG,1
                btfss   STATUS, 0
                goto    error_occur
                btfss   STATUS, 1
                goto    error_occur
                btfss   STATUS, 2
                goto    error_occur

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
