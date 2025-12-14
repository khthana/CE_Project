	in_bit	equ	p1.0	;1bit of port
	RS	EQU	P1.1
	RW	EQU	P1.2
	EN	EQU	P1.3
				;	R0	for @r0
				;	R1	for @r1
	clock	equ	2	;	R2
	ascii	equ	3	;	R3
				;	R4	for loop
				;	R5	for loop
	key	equ	6	;	R6
	status	equ	7	;	R7

	code	equ	30H
	code1	equ	31H
	send	equ	32H
	send1	equ	33H
	shf_buf	equ	34H
	tmp	equ	35H
	rstcount	equ	36H

	dec3	equ	40H
	dec2	equ	41H
	dec1	equ	42H
	dec0	equ	43H

	cmd	equ	0E0C0H
	readb	equ	0E0C1H
	writed	equ	0E0C2H
	readd	equ	0E0C3H
	
	org	0000h
	ljmp	main

	org	0003h
	ljmp	int_kb
	
	org 	000bh
	reti

	org 	0013h
	ljmp	int_111

	org 	001bh
	reti

	org 	0023h
	reti

	org 	0030h

std_t:  	DB 	0h,00h,0,00h,00h,00h,00h,00h,0,00h,00h,00h,00h,09h,60h,0
	DB	0,0,0,0,0,'q','1',0,0,0,'z','s','a','w','2',0
	DB	0,'c','x','d','e','4','3',0,0,20h,'v','f','t','r','5',0
	DB	0,'n','b','h','g','y','6',0,0,0,'m','j','u','7','8',0
	DB	0,',','k','i','o','0','9',0,0,'.','/','l',';','p','-',0
	DB	0,0,27h,0,'[','=',0,0,0,0,0dh,']',0,5ch,0,0
	DB	0,0,0,0,0,0,08h,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0,1bh,0,0,'+',0,'-','*',0,0,0
	DB	0,0,0,0

num_t:   	DB 	0,0,0,0,0,0,0,0,0,0,0,0,0,09h,60h,0
	DB	0,0,0,0,0,'q','1',0,0,0,'z','s','a','w','2',0
	DB	0,'c','x','d','e','4','3',0,0,20h,'v','f','t','r','5',0
	DB	0,'n','b','h','g','y','6',0,0,0,'m','j','u','7','8',0
	DB	0,2CH,'k','i','o','0','9',0,0,'.','/','l',';','p','-',0
	DB	0,0,27h,0,'[','=',0,0,0,0,0dh,']',0,5ch,0,0
	DB	0,0,0,0,0,0,08H,0,0,'1',0,'4','7',0,0,0
	DB	'0','.','2','5','6','8',1bh,0,0,'+','3','-','*','9',0,0
	DB	0,0,0,0

shf_t: 	DB	0,0,0,0,0,0,0,0,0,0,0,0,0,09H,7EH,0
	DB	0,0,0,0,0,'Q','!',0,0,0,'Z','S','A','W','@',0
	DB	0,'C','X','D','E','$','#',0,0,20H,'V','F','T','R','%',0
	DB	0,'N','B','H','G','Y','^',0,0,0,'M','J','U','&','*',0
	DB	0,'<','K','I','O',')','(',0,0,'>','?','L',':','P','_',0
	DB	0,0,22H,0,'{','+',0,0,0,0,0DH,'}',0,'|',0,0
	DB	0,0,0,0,0,0,08H,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0,1BH,0,0,'+',0,'-','*',0,0,0
	DB	0,0,0,0

shn_t:	DB	0,0,0,0,0,0,0,0,0,0,0,0,0,09H,7EH,0
	DB	0,0,0,0,0,'Q','!',0,0,0,'Z','S','A','W','@',0
	DB	0,'C','X','D','E','$','#',0,0,20H,'V','F','T','R','%',0
	DB	0,'N','B','H','G','Y','^',0,0,0,'M','J','U','&','*',0
	DB	0,'<','K','I','O',')','(',0,0,'>','?','L',':','P','_',0
	DB	0,0,22H,0,'{','+',0,0,0,0,0DH,'}',0,'|',0,0
	DB	0,0,0,0,0,0,08H,0,0,'1',0,'4','7',0,0,0
	DB	'0','.','2','5','6','8',1BH,0,0,'+','3','-','*','9',0,0
	DB	0,0,0,0
;----------------------------------------------------------------------------------------
int_111:	mov	c,p1.7
	jc	int_222
	ljmp	int_reset
int_222:	ljmp	int_send
;----------------------------------------------------------------------------------------

int_kb:	mov	ie,#0
	inc	clock
	mov	psw.1,c

	cjne	r2,#1,kb1		;clock
	sjmp	end_kb

kb1:	cjne	r2,#10,kb2	;clock
	sjmp	end_kb

kb2:	cjne	r2,#11,kb3	;clock
	mov	clock,#0
	mov	key,shf_buf
	orl	status,#1	;set got
	sjmp	end_kb
	
kb3:	mov	tmp,a
	mov	c,in_bit
	mov	a,shf_buf
	rrc	a
	mov	shf_buf,a
	mov	a,tmp
		
end_kb:	mov	c,psw.1
	mov	rstcount,#0ffh
	mov	ie,#10000101b
	reti

;-----------------------------------------------------------------------------------------------
write_mem:
	mov	a,code1
	mov	dph,a
	mov	a,code
	mov	dpl,a	

	mov	r4,#3
mem_1:	mov	a,dpl
	clr	c
	rlc	a
	mov	dpl,a
	mov	a,dph
	rlc	a
	mov	dph,a
	djnz	r4,mem_1
	
	mov	a,dpl
	add	a,ascii
	mov	dpl,a

	mov	a,key
	movx	@dptr,a
	inc	ascii

	cjne	r3,#7,end_write	;ascii
	mov	ascii,#0
	inc	dptr
	mov	a,#' '
	movx	@dptr,a
	
	mov	a,dpl
	clr	c
	subb	a,#7
	mov	dpl,a

	mov	r1,#code
	lcall	cal_dec
	lcall	mem_to_lcd	

	clr	c
	mov	a,code
	add	a,#1
	mov	code,a
	jnc	mem_2
	inc	code1

mem_2:	clr	a
	mov	dpl,a
	mov	dph,a
			inc	dptr
	mov	a,code
	movx	@dptr,a
	inc	dptr
	mov	a,code1
	movx	@dptr,a

end_write:	ret

;-------------------------------------------------------
int_send:	mov	ie,#0
	mov	scon,#40h
	mov	tmod,#20h
	mov	th1,#0fdh
	setb	tr1

	mov	r1,#code
	lcall	cal_dec

	mov	a,#'0'
	acall	trans
	mov	a,#'0'
	acall	trans
	mov	a,#'0'
	acall	trans
	mov	a,dec3
	acall	trans
	mov	a,dec2
	acall	trans
	mov	a,dec1
	acall	trans
	mov	a,dec0
	acall	trans
	mov	a,#20h
	acall	trans

	mov	a,code1
	cjne	a,#0,send_0
	mov	a,code
	cjne	a,#1,send_0
	sjmp	end_send
	
send_0:	mov	ascii,#0
	mov	send,#1
	mov	send1,#0
	
send_1:	mov	a,send1
	mov	dph,a
	mov	a,send
	mov	dpl,a

	mov	r4,#3
send_2:	mov	a,dpl
	clr	c
	rlc	a
	mov	dpl,a
	mov	a,dph
	rlc	a
	mov	dph,a
	djnz	r4,send_2
	
	mov	a,dpl
	add	a,ascii
	mov	dpl,a
	
	movx	a,@dptr
	acall	trans
	inc	ascii
	
	cjne	r3,#7,send_1	;ascii
	mov	ascii,#0

	mov	a,#' '
	acall	trans
	
	mov	a,dpl
	clr	c
	subb	a,#6
	mov	dpl,a

	mov	r1,#send
	lcall	cal_dec
	lcall	mem_to_lcd
	lcall	delay

	clr	c
	mov	a,send
	add	a,#1
	mov	send,a
	jnc	send_3
	inc	send1

send_3:	mov	a,code1
	cjne	a,send1,send_1
	mov	a,code
	cjne	a,send,send_1

end_send:	
	clr	tr1
	mov	scon,#00h
	mov	tmod,#00h
	mov	ie,#10000101b
	reti
;-------------------------------------------------------------------
trans:	clr	ti
	mov	sbuf,a
	jnb	ti,$
ent_trans:	ret
;----------------------------------------------------------------------------------------
init_lcd:	CLR	RS
	CLR	RW
	SETB	EN
	MOV	P0,#38H
	CLR	EN

	mov	r4,#20
loop_1:	mov	r5,#0FFh
	djnz	r5,$
	djnz	r4,loop_1
	
	CLR	RS
	CLR	RW
	SETB	EN
	MOV	P0,#38H
	CLR	EN
	mov	r4,#150
	djnz	r4,$

	CLR	RS
	CLR	RW
	SETB	EN
	MOV	P0,#38H
	CLR	EN
	mov	r4,#150
	djnz	r4,$
	
	mov	a,#38h
	lcall	write_c	

	mov	a,#08h
	lcall	write_c	
	
	mov	a,#1
	lcall	write_c	


	mov	a,#6
	lcall	write_c	


	mov	a,#0dh
	lcall	write_c	


	mov	a,#1
	lcall	write_c	

	ret
;---------------------------------------------------------------------------------
WAITB:	MOV	P0,#0FFH
	CLR	RS
	SETB	RW

WAIT:	SETB	EN
	JNB	P0.7,WAITB_END
	CLR	EN
	SJMP	WAIT

WAITB_END:	CLR	EN
	RET
;--------------------------------------------------------------------------------
write_c:	clr	rs
	clr	rw
	setb	en
	mov	p0,a
	clr	en
	lcall	waitb
	ret
;--------------------------------------------------------------------------------
write_d:	setb	rs
	clr	rw
	setb	en
	mov	p0,a
	clr	en
	lcall	waitb
	ret
;----------------------------------------------------------------
mem_to_lcd:
	mov	a,#80h
	lcall	write_c

	mov	r4,#07h
str1:	movx	a,@dptr
	lcall	write_d
	inc	dptr	
	djnz	r4,str1
	mov	a,#' '
	lcall	write_d

	mov	a,#0c0h
	lcall	write_c

	mov	a,#'N'
	lcall	write_d
	mov	a,#'o'
	lcall	write_d
	mov	a,#'.'
	lcall	write_d

	mov	r0,#dec3
	mov	r4,#04h
str2:	mov	a,@r0
	lcall	write_d
	inc	r0
	djnz	r4,str2

	ret
;----------------------------------------------------------------------
delay:	mov	r4,#0ffh
loop1:	mov	r5,#0FFh
	djnz	r5,$
	djnz	r4,loop1
	ret
;--------------------------------------------------------------------
cal_dec:	mov	dec0,#0h
	mov	dec1,#0h
	mov	dec2,#0h
	mov	dec3,#0h

	mov	a,@r1
	anl	a,#00000001b
	jz	cal_1

	mov	r0,#dec0
	mov	r5,#1
	lcall	add_dec

cal_1:	mov	a,@r1
	anl	a,#00000010b
	jz	cal_2

	mov	r0,#dec0
	mov	r5,#2
	lcall	add_dec

cal_2:	mov	a,@r1
	anl	a,#00000100b
	jz	cal_3

	mov	r0,#dec0
	mov	r5,#4
	lcall	add_dec
	
cal_3:	mov	a,@r1
	anl	a,#00001000b
	jz	cal_4

	mov	r0,#dec0
	mov	r5,#8
	lcall	add_dec
	
cal_4:	mov	a,@r1
	anl	a,#00010000b
	jz	cal_5

	mov	r0,#dec1
	mov	r5,#1
	lcall	add_dec
	mov	r0,#dec0
	mov	r5,#6
	lcall	add_dec
	
cal_5:	mov	a,@r1
	anl	a,#00100000b
	jz	cal_6

	mov	r0,#dec1
	mov	r5,#3
	lcall	add_dec
	mov	r0,#dec0
	mov	r5,#2
	lcall	add_dec
	
cal_6:	mov	a,@r1
	anl	a,#01000000b
	jz	cal_7

	mov	r0,#dec1
	mov	r5,#6
	lcall	add_dec
	mov	r0,#dec0
	mov	r5,#4
	lcall	add_dec
	
cal_7:	mov	a,@r1
	anl	a,#10000000b
	jz	cal_8

	mov	r0,#dec2
	mov	r5,#1
	lcall	add_dec
	mov	r0,#dec1
	mov	r5,#2
	lcall	add_dec
	mov	r0,#dec0
	mov	r5,#8
	lcall	add_dec

cal_8:	inc	r1
	mov	a,@r1
	anl	a,#00000001b
	jz	cal_10

	mov	r0,#dec2
	mov	r5,#2
	lcall	add_dec
	mov	r0,#dec1
	mov	r5,#5
	lcall	add_dec
	mov	r0,#dec0
	mov	r5,#6
	lcall	add_dec

cal_10:	mov	a,@r1
	anl	a,#00000010b
	jz	cal_20

	mov	r0,#dec2
	mov	r5,#5
	lcall	add_dec	
	mov	r0,#dec1
	mov	r5,#1
	lcall	add_dec
	mov	r0,#dec0
	mov	r5,#2
	lcall	add_dec

cal_20:	mov	a,@r1
	anl	a,#00000100b
	jz	cal_30

	mov	r0,#dec3
	mov	r5,#1
	lcall	add_dec
	mov	r0,#dec1
	mov	r5,#2
	lcall	add_dec
	mov	r0,#dec0
	mov	r5,#4
	lcall	add_dec
	
cal_30:	mov	a,@r1
	anl	a,#00001000b
	jz	cal_40

	mov	r0,#dec3
	mov	r5,#2
	lcall	add_dec
	mov	r0,#dec1
	mov	r5,#4
	lcall	add_dec
	mov	r0,#dec0
	mov	r5,#8
	lcall	add_dec
	
cal_40:	mov	a,@r1
	anl	a,#00010000b
	jz	end_cal

	mov	r0,#dec3
	mov	r5,#4
	lcall	add_dec
	mov	r0,#dec1
	mov	r5,#9
	lcall	add_dec
	mov	r0,#dec0
	mov	r5,#6
	lcall	add_dec
	
end_cal:	mov	a,dec0
	add	a,#30H
	mov	dec0,a
	mov	a,dec1
	add	a,#30H
	mov	dec1,a
	mov	a,dec2
	add	a,#30H
	mov	dec2,a
	mov	a,dec3
	add	a,#30H
	mov	dec3,a
	ret
;--------------------------------------------------------------------
add_dec:	mov	a,@r0
	add	a,r5
	mov	@r0,a
	clr	c
	subb	a,#10
	jc	end_add
	mov	@r0,a
	dec	r0
	mov	r5,#1
	lcall	add_dec
end_add:	ret
;--------------------------------------------------------------------
init_mem:
	clr	a
	mov	dpl,a
	mov	dph,a
			inc	dptr
	movx	a,@dptr
	mov	code,a
	inc	dptr
	movx	a,@dptr
	mov	code1,a
	
	mov	a,code
	clr	c
	subb	a,#1
	mov	code,a
	jnc	initm_1
	dec	code1

initm_1:	mov	r1,#code
	lcall	cal_dec

	mov	a,code1
	mov	dph,a
	mov	a,code
	mov	dpl,a

	mov	r4,#3
initm_2:	mov	a,dpl
	clr	c
	rlc	a
	mov	dpl,a
	mov	a,dph
	rlc	a
	mov	dph,a
	djnz	r4,initm_2
	lcall	mem_to_lcd

	mov	a,code
	cjne	a,#0,ready
	mov	a,code1
	cjne	a,#0,ready
	
	mov	a,#80h
	lcall	write_c

	mov	a,#' '
	lcall	write_d
	mov	a,#'R'
	lcall	write_d
	mov	a,#'e'
	lcall	write_d
	mov	a,#'a'
	lcall	write_d
	mov	a,#'d'
	lcall	write_d
	mov	a,#'y'
	lcall	write_d
	mov	a,#' '
	lcall	write_d
	mov	a,#' '
	lcall	write_d

ready:	clr	c
	mov	a,code
	add	a,#1
	mov	code,a
	jnc	end_initm
	inc	code1
end_initm:	ret
;----------------------------------------------------------------------
int_reset:	clr	a
	mov	dpl,a
	mov	dph,a
			inc	dptr
	inc	a
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
 
	mov	r4,#60
reset_1:	mov	r5,#0FFh
	djnz	r5,$
	djnz	r4,reset_1
	lcall	init_lcd
	lcall	init_mem

	mov	key,#00h
	mov	clock,#00h
	mov	ascii,#00h
	mov	status,#00h
	mov	shf_buf,#00h
	mov	tmp,#00h

	setb	it0
	mov	ie,#10000101b

	reti
;----------------------------------------------------------------------
main:	
	mov	r4,#60
loop:	mov	r5,#0FFh
	djnz	r5,$
	djnz	r4,loop
	lcall	init_lcd
	lcall	init_mem

	mov	key,#00h
	mov	clock,#00h
	mov	ascii,#00h
	mov	status,#00h
	mov	shf_buf,#00h
	mov	tmp,#00h

	setb	it0
	mov	ie,#10000101b
	
wait_got:	djnz	r4,wait_1
	djnz	rstcount,wait_1
	mov	clock,#00h
	mov	ascii,#00h
wait_1:	mov	a,#1
	anl	a,status
	cjne	a,#1,wait_got
	anl	status,#11111110b	;clear got

	cjne	r6,#12H,s1	;check l-shf
	orl	status,#2		;set shf
	sjmp	wait_got
	
s1:	cjne	r6,#59H,s2	;check r-shf
	orl	status,#2		;set shf
	sjmp	wait_got

s2:	cjne	r6,#77H,s3	;check num
	xrl	status,#4		;xor num
	sjmp	wait_got

s3:	cjne	r6,#58H,s4	;check caps
	xrl	status,#8		;xor cap
	sjmp	wait_got

s4:	cjne	r6,#0F0H,decode	;check release

wait_g1:	mov	a,#1
	anl	a,status
	cjne	a,#1,wait_g1
	anl	status,#11111110b	;clear got

	cjne	r6,#12H,ss1	;check l-shf
	anl	status,#11111101b	;clear shf
	sjmp	wait_got
	
ss1:	cjne	r6,#59H,wait_got	;check r-shf
	anl	status,#11111101b	;clear shf
	sjmp	wait_got

decode:	cjne	r7,#14,d1		;status
	mov	dptr,#num_t
	sjmp	find

d1:	cjne	r7,#12,d2		;status
	mov	dptr,#shn_t
	sjmp	find

d2:	cjne	r7,#10,d3		;status
	mov	dptr,#std_t
	sjmp	find

d3:	cjne	r7,#8,d4		;status
	mov	dptr,#shf_t
	sjmp	find

d4:	cjne	r7,#6,d5		;status
	mov	dptr,#shn_t
	sjmp	find

d5:	cjne	r7,#4,d6		;status
	mov	dptr,#num_t
	sjmp	find

d6:	cjne	r7,#2,d7		;status
	mov	dptr,#shf_t
	sjmp	find

d7:	mov	dptr,#std_t

find:	mov	a,key
	movc 	a,@a+dptr
	mov  	key,a
	cjne	r6,#2AH,find2
	ljmp	wait_got

find2:	cjne	r6,#0DH,find3
	ljmp	wait_got

find3:	lcall	write_mem	
	ljmp	wait_got
	jmp	$
end
;----------------------------------------------------------------------------------------

