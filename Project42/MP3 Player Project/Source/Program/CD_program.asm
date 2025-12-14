;=============================================================
;
;		Connection with IDE/ATA
;
;
;
;
;=============================================================

	ORG	0000H
	LJMP	BEGIN

	org	0003h
	lcall	rec_par
	reti

	ORG	0040H
BUFFER		EQU	7000H
IDE_LSB		EQU	P0
IDE_MSB		EQU	P2
IDE_CTRL	EQU	P1
send		equ	p3.4
b0		equ	70h
b1		equ	71h
b2		equ	72h
b3		equ	73h
b4		equ	74h
b5		equ	75h
b6		equ	76h
b7		equ	77h
b8		equ	78h
b9		equ	79h
b10		equ	7ah
b11		equ	7bh
command		equ	7ch
reserved		equ	7bh

; DEFINE REGISTER PART

IDE_DATA	EQU	00001000B
IDE_ERR		EQU	00001001B
IDE_features	EQU	00001001B
IDE_SEC_CNT	EQU	00001010B
IDE_SECTOR	EQU	00001011B
IDE_CYL_LSB	EQU	00001100B
IDE_Cyl_MSB	EQU	00001101B
IDE_HEAD	EQU	00001110B
IDE_COMMAND	EQU	00001111B
IDE_STATUS	EQU	00001111B
IDE_CONTROL	EQU	00010110B
IDE_ASTATUS	EQU	00010110B

; IDE COMMAND CONSTANTS
IDE_CMD_RECAL	EQU	10H
IDE_CMD_READ	EQU	20H
IDE_CMD_WRITE	EQU	30H
IDE_CMD_INIT	EQU	91H
IDE_CMD_ID	EQU	0ECH
IDE_CMD_SPINDOWN EQU	0E0H
IDE_CMD_SPINUP	EQU	0E1H
IDE_WR_LINE	EQU	00100000B
IDE_RD_LINE	EQU	01000000B
IDE_RST_LINE	EQU	10000000B
r_flag		equ	70h

CR	equ	0dh
LF	equ	0ah

; flag define
to_flag:		db	0
tout:		db	0
command_count:	db	0

; MESSAGE DEFINE
MSG_OK: 	DB "OK",0dh,0ah,0
msg_timeout:	db " Time Out ",0dh,0ah,0
PATH:	 	DB "PATH",0dh,0ah,0
DIR: 		DB "DIR",0dh,0ah,0
FILE:	 	DB "FILE",0dh,0ah,0

;============= start program =====================

BEGIN:
INITIAL:
	mov	r2,#00H
	djnz	r2,$
	mov	p0,#00h
	mov	p1,#00h
	mov	p2,#00h
	setb	send
        	MOV     	TH1,#0fdh       ;Load Value to TH1
        	MOV    	SCON,#50h ;Set Serial port Mode1 ren=1
        	MOV     	TMOD,#20h ;SET Timer 1 Mode2(auto reload)
        	MOV     	PCON,#00h	;19200
        	setb	tr1
	setb	ex0
	setb	ea
MAIN:
	lcall	delay
	LCALL	IDE_HARD_RESET
first:
	lcall	read_pri
	mov	r4,tout
	cjne	r4,#01h,step0
	mov	tout,#00h
	sjmp	first

step0:
	lcall	recieve
;	lcall	get_key
	lcall	chk_command
;	setb	ea
;	setb	es
	sjmp	step0

;========================= FUNCTION PART========================
chk_command:
	push	0
	mov	a,command
	cjne	a,#01h,step2
	lcall	read		;use primary volume descriptor ,
				;path table and directory structure
	sjmp	nokey

step2:	cjne	a,#02h,nokey
	lcall	open_tray
	
nokey:	pop	0
	ret
;---------------------------------------------------------------------------------------------------
open_tray:
	mov	b0,#1bh
	mov	b1,#00h
	mov	b2,#00h
	mov	b3,#00h
	mov	b4,#02h
	mov	b5,#00h
	mov	b6,#00h
	mov	b7,#00h
	mov	b8,#00h
	mov	b9,#00h
	mov	b10,#00h
	mov	b11,#00h
	lcall	packet_no_data
	mov	r4,tout
	cjne	r4,#00h,open_tray

	ret
;---------------------------------------------------------------------------------------------------
read_pri:
	mov	a,#ide_head
	mov	r2,#0a0h
	lcall	ide_wr

pri0:	mov	a,#ide_status
	lcall	ide_rd
	mov	a,r2		
	lcall	counter
	mov	r4,to_flag
	cjne	r4,#01h,pri1	
	jmp	time_out
				
pri1:	jb	acc.7,pri0		;wait busy = 0
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0

	mov	a,#ide_command
	mov	r2,#0a0h
	lcall	ide_wr

pri2:	mov	a,#ide_status
	lcall	ide_rd
	mov	a,r2
	lcall	counter
	mov	r4,to_flag
	cjne	r4,#01h,pri3
	jmp	time_out
				
pri3:	jnb	acc.3,pri2		; wait drq bit = 1
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0

	mov	a,#ide_data
	mov	r2,#28h		;byte 0
	mov	r3,#00h		;byte 1
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,#00h		;byte2
	mov	r3,#00h		;byte3
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,#00h		;byte4
	mov	r3,#10h		;byte5
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,#00h		;byte6
	mov	r3,#00h		;byte7
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,#01h		;byte8
	mov	r3,#00h		;byte9
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,#00h		;byte10
	mov	r3,#00h		;byte11
	lcall	ide_wr
	nop

pri4:	mov	a,#ide_status
	lcall	ide_rd	
	mov	a,r2
	lcall	counter		;
	mov	r4,to_flag		;  count for time out
	cjne	r4,#01h,pri5
	jmp	time_out

pri5:	jb	acc.7,pri4		;wait busy = 0
	jnb	acc.3,pri4
	mov	r6,#0
	mov	r7,#0
;	mov	a,#'B'
;	lcall	send_to_com1	; not use in parallel

pri6:	mov	a,#ide_cyl_msb
	lcall	ide_rd
	push	2		; push msb byte

	mov	a,#ide_cyl_lsb
	lcall	ide_rd
	pop	3		; pop msb byte in r3
	
; devide count word by 2 to make correct count loop
	mov	a,r3
	clr	c
	rrc	a
	mov	r3,a
	mov	a,r2
	rrc	a
	mov	r2,a

	mov	r6,3	; r6 = high
	mov	r7,2	; r7 = low

pri7:	cjne 	r7,#00h,pri8
	cjne	r6,#00h,pri8
	jmp	pri9

pri8:	mov	a,#ide_data
	lcall	ide_rd
;	mov	a,r2
;	lcall	send_to_com1
;	mov	a,r3
;	lcall	send_to_com1
	lcall	send_par
	dec	r7
	cjne	r7,#0ffh,pri7
	dec	r6
	jmp	pri7

pri9:	mov	a,#ide_status
	lcall	ide_rd
	mov	a,r2
	jb	acc.3,pri6		; if more data jump to read byte count
	sjmp	quit

time_out:
	mov	tout,#01h
	mov	to_flag,#00h
	
quit:
	mov	p0,#0ffh
	mov	p2,#0ffh
	ret	
;---------------------------------------------------------------------------------------------------
read:
	push	0
;b2-5 ,7-8 ส่งมาจาก 51 อีกตัว	
	mov	b0,#28h
	mov	b1,#00h
	mov	b6,#00h
	mov	b9,#00h
	mov	b10,#00h
	mov	b11,#00h

r_again:
	lcall	packet_data
	mov	r4,tout
	cjne	r4,#01h,r_end
	mov	tout,#00h
	sjmp	r_again

r_end:	pop	0
	ret
;---------------------------------------------------------------------------------------------------
packet_no_data:
	mov	a,#ide_head
	mov	r2,#0a0h
	lcall	ide_wr
	
pac0:	mov	a,#ide_status
	lcall	ide_rd
	mov	a,r2
	lcall	counter		;
	mov	r4,to_flag		;  count for time out
	cjne	r4,#00h,time_out0	;
	jb	acc.7,pac0
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0
	
	mov	a,#ide_command
	mov	r2,#0a0h
	lcall	ide_wr

pac1:	mov	a,#ide_status
	lcall	ide_rd
	mov	a,r2
	lcall	counter		;
	mov	r4,to_flag		;  count for time out
	cjne	r4,#00h,time_out0	;
	jnb	acc.3,pac1
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0
	
	mov	a,#ide_data
	mov	r2,b0		;byte 0
	mov	r3,b1		;byte 1
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b2		;byte2
	mov	r3,b3		;byte3
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b4		;byte4
	mov	r3,b5		;byte5
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b6		;byte6
	mov	r3,b7		;byte7
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b8		;byte8
	mov	r3,b9		;byte9
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b10		;byte10
	mov	r3,b11		;byte11
	lcall	ide_wr

pac2:	mov	a,#ide_sec_cnt
	lcall	ide_rd
	mov	a,r2
	lcall	counter		;
	mov	r4,to_flag		;  count for time out
	cjne	r4,#00h,time_out0	;
	jnb	acc.1,pac2
	jnb	acc.0,pac2
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0
	sjmp	quit0

time_out0:
	mov	tout,#01h
	mov	to_flag,#00h
	mov	a,#ide_err
	lcall	ide_rd
	mov	a,r2

quit0:
	ret
;------------------------------------------------------------------------------------------------------
packet_data:
	mov	a,#ide_head
	mov	r2,#0a0h
	lcall	ide_wr

pac_d0:	mov	a,#ide_status
	lcall	ide_rd
	mov	a,r2		
	lcall	counter
	mov	r4,to_flag
	cjne	r4,#01h,pac_d1	
	jmp	time_out1	
				
pac_d1:	jb	acc.7,pac_d0	;wait busy = 0
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0

	mov	a,#ide_command
	mov	r2,#0a0h
	lcall	ide_wr

pac_d2:	mov	a,#ide_status
	lcall	ide_rd
	mov	a,r2
	lcall	counter
	mov	r4,to_flag
	cjne	r4,#01h,pac_d3
	jmp	time_out1	
				
pac_d3:	jnb	acc.3,pac_d2	; wait drq bit = 1
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0

	mov	a,#ide_data
	mov	r2,b0		;byte 0
	mov	r3,b1		;byte 1
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b2		;byte2
	mov	r3,b3		;byte3
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b4		;byte4
	mov	r3,b5		;byte5
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b6		;byte6
	mov	r3,b7		;byte7
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b8		;byte8
	mov	r3,b9		;byte9
	lcall	ide_wr
	mov	a,#ide_data
	mov	r2,b10		;byte10
	mov	r3,b11		;byte11
	lcall	ide_wr
	nop

pac_d4:	mov	a,#ide_status
	lcall	ide_rd	
	mov	a,r2
	lcall	counter		;
	mov	r4,to_flag		;  count for time out
	cjne	r4,#01h,pac_d5
	jmp	time_out1

pac_d5:	jb	acc.7,pac_d4	;wait busy = 0
	jnb	acc.3,pac_d4	;wait drq bit = 1
	mov	r5,#0
	mov	r6,#0
	mov	r7,#0

pac_d6:	mov	a,#ide_cyl_msb
	lcall	ide_rd
	push	2		; push msb byte

	mov	a,#ide_cyl_lsb
	lcall	ide_rd
	pop	3		; pop msb byte in r3
	
; devide count word by 2 to make correct count loop
	mov	a,r3
	clr	c
	rrc	a
	mov	r3,a
	mov	a,r2
	rrc	a
	mov	r2,a

	mov	r6,3	; r6 = high
	mov	r7,2	; r7 = low

pac_d7:	cjne 	r7,#00h,pac_d8
	cjne	r6,#00h,pac_d8
	jmp	pac_d9

pac_d8:	mov	a,#ide_data
	lcall	ide_rd
;	mov	a,r2
;	lcall	send_to_com1
;	mov	a,r3
;	lcall	send_to_com1
	lcall	send_par
	dec	r7
	cjne	r7,#0ffh,pac_d7
	dec	r6
	jmp	pac_d7

pac_d9:	mov	a,#ide_status
	lcall	ide_rd
	mov	a,r2
	jb	acc.3,pac_d6	; if more data jump to read byte count
	sjmp	quit1

time_out1:
	mov	tout,#01h
	mov	to_flag,#00h
	
quit1:
	mov	p0,#0ffh
	mov	p2,#0ffh
	ret	
;------------------------------------------------------------------------------------------------------	
IDE_HARD_RESET:
	MOV	A,#IDE_RST_LINE
	MOV	IDE_CTRL,A
	MOV	R2,#250
	DJNZ	R2,$
	clr	a
	MOV	IDE_CTRL,A
	lcall	delay
	lcall	delay
	lcall	delay
;	lcall	init_ide
;	lcall	init_packet
	RET
;------------------------------------------------------------------------------------------------------
IDE_BUSY:
	MOV	A,#IDE_STATUS
	LCALL	IDE_RD
	MOV	A,R2
	JB	ACC.7,IDE_BUSY		; CHECK BUSY BIT
	RET
;------------------------------------------------------------------------------------------------------
IDE_RD:
	mov	IDE_CTRL, a		;drive address onto control lines
	orl	a, #ide_rd_line	
	mov	IDE_CTRL, a		;assert read pin
	clr	a
	mov	a,IDE_MSB		;read the upper byte
	mov	r3, a
	clr	a
	mov	a,IDE_LSB		;read the lower byte
	mov	r2, a
	clr	a
	mov	IDE_CTRL, a		;deassert all control pins
	ret

;------------------------------------------------------------------------------------------------------
IDE_WR:

	PUSH	ACC

	MOV	A,R2
	MOV	IDE_LSB,A
	MOV	A,R3
	MOV	IDE_MSB,A

	POP	ACC
	mov	IDE_CTRL, a		;drive address onto control lines
	setb	acc.5	
	mov	IDE_CTRL, a		;assert write pin

	clr	acc.5
	mov	IDE_CTRL, a		;deassert all control pins
	clr	a
	mov	ide_ctrl,a
	
	nop

	ret

;------------------------------------------------------------------------------------------------------
PSTR:			; SEND ASCII CODE AT DPTR TO COM PORT UNTIL FIND 0
	clr	a
	MOVc 	A,@a+DPTR
	JZ	RETURN
	LCALL	SEND_TO_COM1
	INC	DPTR
	SJMP	PSTR

RETURN:
	RET
	
;------------------------------------------------------------------------------------------------------
convert:				; this function use r7 
				; convert and send value in acc
	push	7
	push	1
	push	0
	push	acc
	mov	r7,#00h	
	anl	a,#11110000b	; get hight nibble in acc
	swap	a		; move it to be low nibble for change to ascii
	
c0: 	cjne	a,#0ah,c1
	mov	a,#'a'
	ljmp	next
c1:	cjne	a,#0bh,c2
	mov	a,#'b'
	ljmp	next
c2:	cjne	a,#0ch,c3
	mov	a,#'c'
	ljmp	next
c3:	cjne	a,#0dh,c4
	mov	a,#'d'
	ljmp	next
c4:	cjne	a,#0eh,c5
	mov	a,#'e'
	ljmp	next
c5:	cjne	a,#0fh,c6
	mov	a,#'f'
	ljmp	next
c6:			
	orl	a,#00110000b	; change value to ascii

NEXT:
	cjne	r7,#00h,c7	; if loop 2 skip to keep in r1
	mov	r0,a		;keep value in r0
	pop	acc
	mov	r7,#01h	
	anl	acc,#00001111b	; get low nibble in acc
	ljmp	c0
	
c7:	mov	r1,a
	mov	a,r0
	lcall	send_to_com1
	mov	a,r1
	lcall	send_to_com1
	mov	a,#' '
	lcall	send_to_com1

	pop	0
	pop	1
	pop	7
	ret
;------------------------------------------------------------------------------------------------------
NEW_LINE:
	MOV	A,#CR
	LCALL	SEND_TO_COM1
	MOV	A,#LF
	LCALL	SEND_TO_COM1
	RET
;------------------------------------------------------------------------------------------------------
send_acc:
	push	acc
	lcall	convert
	pop	acc
	ret
;------------------------------------------------------------------------------------------------------
send_to_com1:		; send value in acc to com1 port
     	mov     	sbuf,a
        	jnb     	ti,$
        	clr     	ti
	ret
;------------------------------------------------------------------------------------------------------
receive_from_com1:	; this function return dph,dpl in r3,r2
        	clr	ri
        	mov     	a,sbuf
	movx	@dptr,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	ret
;------------------------------------------------------------------------------------------------------
rec_par:
	mov	r2,p0
	mov	r3,p2
	mov	r_flag,#01h
	ret
;=================================================
send_par:
	push	2
	push	3
	push	4
	clr	send
	mov	p0,r2
	mov	p2,r3
	nop
	nop
	nop	
	nop
	setb	send
	nop
	nop
	nop	
	nop
	mov	p0,#0ffh
	mov	p2,#0ffh
	mov	r4,#12
	djnz	r4,$

	pop	4
	pop	3
	pop	2
	ret
;===================================================
char2hex:		; input from acc
			; output to acc with hex value
c2h0:	cjne	a,#'a',c2h1
	mov	a,#0ah
	ljmp	qc2h

c2h1:	cjne	a,#'b',c2h2
	mov	a,#0bh
	ljmp	qc2h

c2h2:	cjne	a,#'c',c2h3
	mov	a,#0ch
	ljmp	qc2h

c2h3:	cjne	a,#'d',c2h4
	mov	a,#0dh
	ljmp	qc2h

c2h4:	cjne	a,#'e',c2h5
	mov	a,#0eh
	ljmp	qc2h

c2h5:	cjne	a,#'f',c2h6
	mov	a,#0fh
	ljmp	qc2h

c2h6:	cjne	a,#'A',c2h7
	mov	a,#0ah
	ljmp	qc2h

c2h7:	cjne	a,#'B',c2h8
	mov	a,#0bh
	ljmp	qc2h

c2h8:	cjne	a,#'C',c2h9
	mov	a,#0ch
	ljmp	qc2h

c2h9:	cjne	a,#'D',c2h10
	mov	a,#0dh
	ljmp	qc2h

c2h10:	cjne	a,#'E',c2h11
	mov	a,#0eh
	ljmp	qc2h

c2h11:	cjne	a,#'F',c2h12
	mov	a,#0fh
	ljmp	qc2h

c2h12:	anl	a,#0fh
	
qc2h:	ret
;------------------------------------------------------------------------------------------------------
DELAY:
	MOV	R3,#20
DELAY1:	MOV	R4,#200
DELAY2:	MOV	R5,#250
	DJNZ	R5,$
	DJNZ	R4,DELAY2
	DJNZ	R3,DELAY1
	RET	
;------------------------------------------------------------------------------------------------------
get_press:
	jnb	ri,$
	clr	ri
	mov	a,sbuf
	lcall	char2hex
	swap	a
	push	acc
	jnb	ri,$
	clr	ri
	mov	a,sbuf
	lcall	char2hex
	pop	2
	orl	a,r2
	lcall	send_acc
	ret
;------------------------------------------------------------------------------------------------------
get_key:
	push	0
	lcall	get_press
	mov	command,a
	lcall	get_press
	mov	b2,a
	lcall	get_press
	mov	b3,a
	lcall	get_press
	mov	b4,a
	lcall	get_press
	mov	b5,a
	lcall	get_press
	mov	b7,a
	lcall	get_press
	mov	b8,a
	lcall	new_line

	pop	0
	ret
;------------------------------------------------------------------------------------------------------
recieve:
rec0:	mov	a,r_flag
	jnb	acc.0,rec0
	mov	r_flag,#00h
	mov	command,r2	;command
	mov	b2,r3		;position3
rec1:	mov	a,r_flag
	jnb	acc.0,rec1
	mov	r_flag,#00h
	mov	b3,r2		;position2
	mov	b4,r3		;position1
rec2:	mov	a,r_flag
	jnb	acc.0,rec2
	mov	r_flag,#00h
	mov	b5,r2		;position0
	mov	b7,r3		;length1
rec3:	mov	a,r_flag
	jnb	acc.0,rec3
	mov	r_flag,#00h
	mov	b8,r2		;length0
	mov	reserved,r3	;reserved

	ret
;------------------------------------------------------------------------------------------------------
counter:			; 1,000,000 round
	inc	r5
	cjne	r5,#250,out_count
	mov	r5,#00h
	inc	r6
	cjne	r6,#200,out_count
	mov	r6,#00h
	inc	r7
	cjne	r7,#5,out_count
	mov	r7,#00h
	mov	to_flag,#01h

out_count:
	ret

END