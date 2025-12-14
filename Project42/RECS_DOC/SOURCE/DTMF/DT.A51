extrn   code(tele,std)
	cseg    at      00h

	cseg    at      03h
	jmp     i_tele
	cseg    at      13h
	jmp     i_std


	cseg    at      30h

i_tele: push    acc
	push    psw
	call    tele
	pop     psw
	pop     acc
	reti

i_std:  push    acc
	push    psw
	call    std
	pop     psw
	pop     acc
	reti

	end
