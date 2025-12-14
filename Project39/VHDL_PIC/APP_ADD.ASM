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

;---------------------------------------------
; [01:02] + [99] = [02:01]
		movlw	1
		movwf	SR2
		movlw	2
		movwf	SR1
		movlw	H'99'
		movwf	ADT
		movlw	#SEG1
		movwf	FSR
		call	bcd_add
		movf	SEG1,0
		addlw	H'FE'
		btfsc	STATUS,0
		goto	error_occur
		movf	SEG2,0
		addlw	H'FD'
		btfsc	STATUS,0
		goto	error_occur
		goto	correct_result

;----------- Small application test ---------------;
;--------------   BCD addition  ---------------;
;---   Expression : SR2:SR1 + ADT = [FSR+1:FSR]
;---   Destroy    : W, TMP1, STATUS
bcd_add         bsf     STATUS, 5
                movf    ADT,0
                addwf   SR1,0           ; normally add
                movwf   TMP1
                addlw   B'00000110'     ; check if low nibble exceed 9
                btfsc   STATUS,1
                goto    bcdadd_low
                movf    TMP1,0
bcdadd_low      movwf   TMP1
                addlw   B'01100000'     ; check if  hi nibble exceed 9
                btfsc   STATUS, 0
                goto    bcdadd_check
                movf    TMP1,0
bcdadd_check    movwf   INDF            ; save first bye result
                btfss   STATUS, 0
                goto    bcdadd_done
;--- Check if first bye overflow
                incf    FSR,1
                incf    SR2,0
                movwf   INDF            ; save second bye result
                decf    FSR,1
bcdadd_done     return

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
