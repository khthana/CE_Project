;=================================================
;==	Send MP3 bit stream by SPI function	               ==
;=================================================
;== Include Function:			               ==
;== 		send_to_com1		               ==
;== 		convert			               ==
;== 		delay			               ==
;== 		receive_from_com1	               ==
;== 		masterIO			               ==
;== 		get_high_dptr		               ==
;== 		keep			               ==
;=================================================
	org	0000h
        	ljmp    	initial

	org	0003h
	lcall	rec_par
	reti

	ORG	0013h
	lcall	chk_key
	reti

	org	0023h
	lcall	receive_from_com1
	reti
;************************************************************************************
        	org     	0040h
;sda	equ	p1.2
;scl	equ	p1.3
drq	equ	p1.3
spcr    	equ     	0d5h    		; spi control register
spsr    	equ     	0aah    		; spi status register
spif    	equ     	10000000b       	; interrupt flag
spdr    	equ     	86h     		; spi data register
ss_     	bit     	p1.4    		; port ss_ for select slave
mosi    	bit     	p1.5   		; master out slave in port
miso    	bit     	p1.6    		; master in slave out port
sck     	bit     	p1.7    		; spi clock (master output & slave input)
sdsr    	equ     	05h
wrsr    	equ     	01h
write   	equ     	02h
wren    	equ     	06h
wrdi    	equ     	04h
CR	equ	0dh
LF	equ	0ah
send	equ	p3.4
sa	equ	p1.0
sb	equ	p1.1
sc	equ	p1.2

; declare variable

page		equ	7ah
block_l		equ	79h
reload_posiH	equ	78h
reload_posiL	equ	77h
reload_page	equ	76h
decode_posiH	equ	75h
decode_posiL	equ	74h
block_left		equ	73h
odd		equ	72h
now_posiH	equ	71h
now_posiL	equ	70h
next_posiH	equ	6fh
next_posiL	equ	6eh
add_buf0		equ	6dh
add_buf1		equ	6ch
add_buf2		equ	6bh
add_buf3		equ	6ah
dirH		equ	69h	; เก็บ ตำแหน่งสุดท้ายที่ถือค่า dir
dirL		equ	68h
fileH		equ	67h	; เก็บ ตำแหน่งสุดท้ายที่ถือค่า file
fileL		equ	66h
size_buf0	equ	65h
size_buf1	equ	64h
size_buf2	equ	63h
size_buf3	equ	62h
hdpl		equ	61h
hdph		equ	60h
length_buf0	equ	5fh
length_buf1	equ	5eh
length_buf2	equ	5dh
length_buf3	equ	5ch
r_flag		equ	5bh
loadH		equ	5ah
loadL		equ	59h
line		equ	58h
end_of_file	equ	57h
chk_pageH	equ	56h
chk_pageL	equ	55h
reload_counter	equ	54h
song_noH	equ	53h
song_noL	equ	52h
; define constant

read	equ	01h
open_tray	equ	03h
one_b		equ	08H

initial:	
	mov	r2,#00h
	djnz	r2,$
	mov	p0,#0ffh
	mov	p1,#0ffh
	mov	p2,#0ffh
	mov	r_flag,#00h
	mov	end_of_file,#00h
	setb	send
	mov	r4,#00h
	djnz	r4,$
	djnz	r4,$
        	setb    	ss_
        	setb    	mosi
        	setb    	miso
        	setb    	sck
        	mov     	spcr,#01010101b
        	MOV     	TH1,#0feh       ;Load Value to TH1
        	MOV    	SCON,#50h ;Set Serial port Mode1 ren=1
        	MOV     	TMOD,#20h ;SET Timer 1 Mode2(auto reload)
        	MOV     	PCON,#80h	; 57600
        	setb	tr1
	setb	ea
	setb	ex0		; enable interrupt 0
	setb	ex1
	mov	page,#00h
	mov	a,page
	lcall	select_p		; select page 0
	mov	dptr,#0000h
	mov	r2,#00h
	
main:	mov	block_l,#01h
	mov	loadH,#00h
	mov	loadL,#00h
	lcall	read_block
	
	lcall	read_path_iden	;หาตำแหน่ง path table
	lcall	store_folder	;เก็บตำแหน่ง folder ต่างๆ ไว้ใน page7
	lcall	store_file
	mov	song_noH,#10h
	mov	song_noL,#00h
play:	lcall	read_file

	mov	reload_posiH,#00h
	mov	reload_posiL,#00h
	mov	reload_page,#00h
	mov	block_left,#10h
	mov	decode_posiH,#00h
	mov	decode_posiL,#00h
	mov	reload_counter,#20h
	mov	r4,#00h
	djnz	r4,$
	mov	a,#'0'
	lcall	send_to_com1
	mov	page,#00h		; let page be decode page value

loop:	mov	a,page
	cjne	a,#07h,normal
	mov	page,#00h
	

normal:
	mov	chk_pageH,#80h	; ค่า dptr ที่จะอ่านถึง
	mov	chk_pageL,#00h		
	mov	a,page		; keep page value in acc	
	lcall	select_p		; select page
	lcall	send_data
	mov	a,end_of_file
	cjne	a,#00h,out_main	; if end_of_file = 0 then continue send data
				; else  end of loop
	inc	page
	sjmp	loop

Out_main:		; เตรียมเขียน เริ่มเพลงใหม่ นะจ๊ะ
	mov	a,#'1'
	lcall	update_song_no
	mov	end_of_file,#00h
	ljmp	play
	sjmp	$
;=================================================
;==		   Function Part		               ==
;=================================================
send_data:			; this function just send data from 0
				; to r3r2 dptr. don't care page
	mov	dptr,#0000h

ld1:	jnb	drq,ld3
	mov	a,dph
	cjne	a,chk_pageH,ld2		; เทียบกับค่าสุงสุดที่ส่งเข้ามา
	mov	a,dpl
	cjne	a,chk_pageL,ld2
	jmp	od1

ld2:	movx	a,@dptr
	clr	ss_
;	lcall	convert
	lcall	masterIO
;	lcall	convert
	setb	ss_
	inc	dptr
	mov	decode_posiH,dph
	mov	decode_posiL,dpl
	mov	a,dpl
	cjne	a,#00h,ld1
	mov	a,decode_posiH
	mov	b,#08h
	div	ab
	mov	a,b
	jnz	ld1
	lcall	update_length	; ถ้าเป็น X0 หรือ X8 ให้ลด length ลง 1 block
	mov	a,length_buf3
	cjne	a,#00h,ld1
	mov	a,length_buf2
	cjne	a,#00h,ld1
	mov	end_of_file,#01h
	sjmp	od1

ld3:	djnz	reload_counter,ld1
	mov	reload_counter,#20h
	mov	a,reload_page
	cjne	a,#07,ld4
	mov	reload_page,#00h

ld4:	lcall	reload_data
	jmp	ld1
od1:	
	ret
;===========================================
reload_data:	; ทำหน้าที่เติมค่าใน mem ทีละ 1 block และจะเติมไล่เพจไปเอง
		; แต่ไม่ได้เช็คว่าสุดเพจ 06 แล้ว เพราะฉะนั้นก่อน call ฟังก์ชันนี้
		; ต้องมีการ เช็ค ตำแหน่งเพจก่อน
	push	7

	mov	a,page
	cjne	a,reload_page,reload1
	mov	a,decode_posiH	; เพจเดียวกัน ให้ดูว่ามีช่องพอใส่ 1 block มั๊ย
	clr	c
	subb	a,reload_posiH
	clr	c
	subb	a,#08h
	jc	out_reload	; น้อยกว่า 1 block

reload1:	mov	a,reload_page
	mov	block_l,#01h
	lcall	command_read	; command to read 1 block
	mov	loadH,reload_posiH  
	mov	loadL,reload_posiL
	lcall	read_block	; save data in 
	mov	reload_posiH,Hdph
	mov	reload_posiL,Hdpl	; save now reload value
	lcall	update_add
	djnz	block_left,out_reload 	; if block_left = 0 then save new variable value

before_out:
	inc	reload_page
	mov	reload_posiH,#00h
	mov	reload_posiL,#00h
	mov	block_left,#10h

out_reload:
	clr	c
	mov	dph,decode_posiH
	mov	dpl,decode_posiL

	pop	7
	ret
;===========================================
read_file:
	push	7
	mov	a,#07h
	lcall	select_p
	mov	dpH,song_noH
	mov	dpl,song_noL

	lcall	get8
	lcall	transfer_length
	mov	page,#00h

	mov	a,page
	lcall	select_p

readf00:	mov	loadH,#00h
	mov	loadL,#00h
	mov	r7,#10h
readf01:	mov	block_l,#01h
	lcall	command_read
	mov	block_l,#01h
	lcall	read_block	;p0
	lcall	update_add
	mov	loadH,dph
	mov	loadL,dpl
	djnz	r7,readf01
	lcall	next_p
	mov	a,page
	cjne	a,#07,readf00


	pop	7
	ret
;=================================================
read_block:		; read data in. length is times of 2k
			; block_length keep in block_l varible
			; dptr must set before call this function
			; dpl จะต้องเริ่มที่ 00 เท่านั้นนะเว้ย
			; ไม่ต้องคิดด้วยว่าจะหมดเพจรึเปล่า ต้องคิดมาจาก
			; ข้างนอก
			; return ค่า dptr ว่าง ๆ ใน hdph  , hdpl
	push	4
	push	3
	push	2
	
	mov	a,block_l
	mov	b,#08h
	mul	ab
	add	a,loadH
	mov	r4,a	; keep highest dph

	mov	dph,loadH
	mov	dpl,loadL

rdb0:	mov	a,r_flag
	jnb	acc.0,rdb0
	mov	r_flag,#00h
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	p0,#0ffh
	mov	p2,#0ffh
	mov	a,dph
	cjne	a,4,rdb0

out_rdb:
	mov	a,dph
	mov	hdph,a
	mov	a,dpl
	mov	hdpl,a

	mov	r2,#10h
	djnz	r2,$
	pop	2
	pop	3
	pop	4
	ret
;=================================================
command_read:
	mov	r2,#read		; read command
	mov	r3,add_buf0	;  add buffer variable1
	lcall	send_par
	mov	r2,add_buf1	;
	mov	r3,add_buf2	;
	lcall	send_par
	mov	r2,add_buf3	;
	mov	r3,#00h		;
	lcall	send_par
	mov	r2,block_l		;  block length variable
	mov	r3,#00h		; reserve
	lcall	send_par
	ret
;=================================================
read_path_iden:
	mov	dptr,#151		
	movx	a,@dptr
	push	acc
	mov	r2,#read
	mov	r3,#00h
	lcall	send_par
	mov	r2,#00h			;
	mov	r3,#00h			;  logical block address
	lcall	send_par
	pop	2
	mov	r3,#00h	
	lcall	send_par
	mov	r2,#01h			; logical block length
	mov	r3,#00h			
	lcall	send_par
	
	mov	a,#00h
	lcall	select_p
	mov	loadH,#00h
	mov	loadL,#00h
	mov	block_l,#01h
	lcall	read_block
	ret
;=================================================
store_folder:
	mov	dirH,#00h		; initial start address for keep
	mov	dirL,#00h		
	mov	dptr,#0000h
	mov	now_posiH,dph
	mov	now_posiL,dpl

store0:	mov	dpl,now_posiL
	mov	dph,now_posiH
	movx	a,@dptr
	lcall	chk_odd		; a hold length value
	add	a,#08h
	add	a,dpl
	jnc	store02
	inc	dph
store02:	mov	next_posiL,a	; find and save next position
	mov	next_posiH,dph

	mov	dpl,next_posiL	; make dptr at next posi
	mov	dph,next_posiH
	movx	a,@dptr
	cjne	a,#00,store1	; compare if next_position is 0 then
				; return out from loop
;----------  this part for last keep and return ----------
	mov	dph,now_posiH
	mov	dpl,now_posiL
	inc	dptr
	inc	dptr		; move to msb point of address
	movx	a,@dptr
	mov	add_buf0,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf1,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf2,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf3,a

	mov	dph,dirH
	mov	dpl,dirL
	mov	a,#07h
	lcall	select_p		; select page 7
	lcall	keep_add
	mov	a,#00h
	lcall	select_p
	mov	dirH,dph		; save next address memory
	mov	dirL,dpl		; for keep next dir address

	ret
;---------------------------------------------------------------------------
store1:	mov	dph,now_posiH
	mov	dpl,now_posiL
	inc	dptr
	inc	dptr		; move to msb point of address
	movx	a,@dptr
	mov	add_buf0,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf1,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf2,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf3,a

	mov	dph,dirH
	mov	dpl,dirL
	mov	a,#07h
	lcall	select_p		; select page 7
	lcall	keep_add
	mov	a,#00h
	lcall	select_p
	mov	dirH,dph		; save next address memory
	mov	dirL,dpl		; for keep next dir address
	mov	now_posiH,next_posiH
	mov	now_posiL,next_posiL
	jmp	store0		
	ret
;=================================================
store_file:	; search file ในทุก ๆ dir 
	mov	fileH,#10H
	mov	fileL,#00H

	mov	dptr,#0000h
	mov	a,dirL
	mov	b,#04h
	div	ab
	mov	r6,a
sto_file0:
	mov	a,#07h
	lcall	select_p
	lcall	get4		; get address to read
	push	dph
	push	dpl

run_a:	lcall	analyse_dir
	pop	dpl
	pop	dph
	djnz	r6,sto_file0
out_store_file:
	ret
;=================================================
analyse_dir:
	mov	block_l,#01	; length of block to read
	lcall	command_read
	mov	a,#00h
	lcall	select_p		; select page
	mov	block_l,#01	; set length
	mov	loadH,#00h
	mov	loadL,#00h
	lcall	read_block	; call function

	mov	dptr,#0000h
	mov	now_posiH,dph
	mov	now_posiL,dpl

sf00:	mov	dph,now_posiH
	mov	dpl,now_posiL
	movx	a,@dptr
	add	a,dpl
	jnc	sf01
	inc	dph
sf01:	mov	next_posiL,a
	mov	next_posiH,dph

	mov	dph,next_posiH
	mov	dpl,next_posiL
	movx	a,@dptr
	cjne	a,#00,sf02
;------------------------ this part for last keep & return---------------------------
	mov	dph,now_posiH
	mov	dpl,now_posiL
	mov	a,#25
	add	a,dpl
	jnc	sf030
	inc	dph
sf030:	mov	dpl,a
	movx	a,@dptr
	jnb	acc.1,sf040
	mov	now_posiH,next_posiH
	mov	now_posiL,next_posiL
	RET

sf040:	mov	dph,now_posiH
	mov	dpl,now_posiL
	mov	a,#6
	add	a,dpl
	jnc	sf050
	inc	dph
sf050:	mov	dpl,a
	movx	a,@dptr
	mov	add_buf0,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf1,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf2,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf3,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf3,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf2,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf1,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf0,a

	mov	a,#07h
	lcall	select_p
	mov	dph,fileH
	mov	dpl,fileL
	lcall	keep_file_size
	mov	fileH,dph
	mov	fileL,dpl
	mov	a,#00h
	lcall	select_p
	
	ret
;---------------------------------------------------------------------------------------------------
sf02:	mov	dph,now_posiH
	mov	dpl,now_posiL
	mov	a,#25
	add	a,dpl
	jnc	sf03
	inc	dph
sf03:	mov	dpl,a
	movx	a,@dptr
	jnb	acc.1,sf04
	mov	now_posiH,next_posiH
	mov	now_posiL,next_posiL
	jmp	sf00

sf04:	mov	dph,now_posiH
	mov	dpl,now_posiL
	mov	a,#6
	add	a,dpl
	jnc	sf05
	inc	dph
sf05:	mov	dpl,a
	movx	a,@dptr
	mov	add_buf0,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf1,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf2,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf3,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf3,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf2,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf1,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf0,a

	mov	a,#07h
	lcall	select_p
	mov	dph,fileH
	mov	dpl,fileL
	lcall	keep_file_size
	mov	fileH,dph
	mov	fileL,dpl
	mov	a,#00h
	lcall	select_p

	mov	now_posiH,next_posiH
	mov	now_posiL,next_posiL
	ljmp	sf00

	ret
;=================================================
read_dir_iden:
	mov	dptr,#000fh
	movx	a,@dptr
	push	acc
	dec 	dpl		; ได้ 000eh
	movx	a,@dptr
	push	acc
	mov	r2,#read
	mov	r3,#00h
	lcall	send_par
	mov	r2,#00h			;
	pop	3			;  logical block address
	lcall	send_par
	pop	2			;
	mov	r3,#00h	
	lcall	send_par
	mov	r2,#01h			; logical block length
	mov	r3,#00h			
	lcall	send_par
	
	mov	a,#07h
	lcall	select_p
	mov	dptr,#0800h
	mov	block_l,#01h
	lcall	read_block
	ret
;=================================================
convert:				; this function use r7 
				; convert and send value in acc
	push	7
	push	0
	push	1

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

	pop	1
	pop	0
	pop	7
	ret
;=================================================
send_to_com1:		; send value in acc to com1 port
     	mov     	sbuf,a
        	jnb     	ti,$
        	clr     	ti
	ret
;=================================================
delay:			; this function use r4,r5,r6
	mov	r4,#40
d1:	mov	r5,#200
d2:	mov	r6,#250
	djnz	r6,$
	djnz	r5,d2
	djnz	r4,d1
	ret	
;=================================================
receive_from_com1:	; this function return dph,dpl in r3,r2
        	clr	ri
        	mov     	a,sbuf
	movx	@dptr,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	ret
;=================================================
rec_par:
	mov	r2,p0
	mov	r3,p2
	mov	r_flag,#01h
	ret
;=================================================
chk_key:
	clr	ea
	mov	length_buf3,#01h
	mov	length_buf2,#00h
	setb	ea
	ret
;=================================================
send_par:
	push	2
	push	3
	push	4
	mov	p0,r2
	mov	p2,r3
	clr	send
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
keep:
	movx	@dptr,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	ret
;=================================================
masterIO:
        	mov     	spdr,a  	; write output
bbb:
        	mov     	a,spsr  	; get status
        	anl     	a,#spif 	; check for done
        	jz      	bbb     	; loop until done
        	mov     	a,spdr  	; read input data
        	ret
;=================================================
get_high_dptr:			; return r3=dph 
				; return r2=dpl
	mov	r3,hdph
	mov	r2,hdpl

	ret
;=================================================
next_p:
	inc	page
	lcall	page0
	mov	a,page
	lcall	select_p
	ret
;=================================================
select_p:			; input page in acc
	lcall	page0
	jnb	acc.0,ss0
	setb	sa
ss0:	jnb	acc.1,ss1
	setb	sb
ss1:	jnb	acc.2,ss2
	setb	sc
ss2:
	ret
;=================================================
page0:
	clr	sa
	clr	sb
	clr	sc
	ret
;=================================================
chk_odd:			; if acc is odd then add one
	push	acc
	rrc	a
	jnc	no_add
	pop	acc
	inc	acc
	ret
no_add:	pop	acc
	ret
;=================================================
keep_add:
	mov	a,add_buf0
	movx	@dptr,a
	inc	dptr
	mov	a,add_buf1
	movx	@dptr,a
	inc	dptr
	mov	a,add_buf2
	movx	@dptr,a
	inc	dptr
	mov	a,add_buf3
	movx	@dptr,a
	inc	dptr
	ret
;=================================================
keep_file_size:
	mov	a,add_buf0
	movx	@dptr,a
	inc	dptr
	mov	a,add_buf1
	movx	@dptr,a
	inc	dptr
	mov	a,add_buf2
	movx	@dptr,a
	inc	dptr
	mov	a,add_buf3
	movx	@dptr,a
	inc	dptr
	mov	a,size_buf0
	movx	@dptr,a
	inc	dptr
	mov	a,size_buf1
	movx	@dptr,a
	inc	dptr
	mov	a,size_buf2
	movx	@dptr,a
	inc	dptr
	mov	a,size_buf3
	movx	@dptr,a
	inc	dptr
	ret
;=================================================
get4:
	movx	a,@dptr
	mov	add_buf0,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf1,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf2,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf3,a
	inc	dptr
	ret
;=================================================
get8:
	movx	a,@dptr
	mov	add_buf0,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf1,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf2,a
	inc	dptr
	movx	a,@dptr
	mov	add_buf3,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf0,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf1,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf2,a
	inc	dptr
	movx	a,@dptr
	mov	size_buf3,a
	inc	dptr
	ret
;=================================================
transfer_length:		; devide size by 2048
	clr	c	
	mov	r6,#3
trans0:	mov	a,size_buf0
	rrc	a
	mov	size_buf0,a
	mov	a,size_buf1
	rrc	a
	mov	size_buf1,a
	mov	a,size_buf2
	rrc	a	
	mov	size_buf2,a

	djnz	r6,trans0
	inc	size_buf2

	mov	length_buf3,size_buf2
	mov	length_buf2,size_buf1
	mov	length_buf1,size_buf0
	mov	length_buf0,#00h

	mov	size_buf0,#00h
	mov	size_buf1,#00h
	mov	size_buf2,#00h
	mov	size_buf3,#00h

	ret
;=================================================
update_add:
	mov	a,add_buf3
	add	a,#01h
	jc	update0
	mov	add_buf3,a
	jmp	out_update

update0:	mov	add_buf3,a
	mov	a,add_buf2
	add	a,#01h
	jc	update1
	mov	add_buf2,a
	jmp	out_update

update1:	mov	add_buf2,a
	mov	a,add_buf1
	add	a,#01h
	jc	update2
	mov	add_buf1,a
	jmp	out_update

update2:	mov	add_buf1,a
	inc	add_buf0	
	
out_update:
	ret
;=================================================
update_length:
	mov	a,length_buf3
	clr	c
	subb	a,#01h
	jc	lupdate0
	mov	length_buf3,a
	jmp	lout_update

lupdate0:	clr	c
	mov	length_buf3,a
	dec	length_buf2
	
lout_update:
	ret
;=================================================
new_line:
	mov	a,#0dh
	lcall	send_to_com1
	mov	a,#0ah
	lcall	send_to_com1
	ret
;=================================================
update_song_no:
	mov	a,song_noL
	add	a,#08h
	jnc	us0
	clr	c
	inc	song_noH
us0:	mov	song_noL,a
	ret
;=================================================

end
