        org     0000h
        jmp     main

        org     0050h

din0    equ     40h
din1    equ     41h
din2    equ     42h
din3    equ     43h

dout0   equ     50h
dout1   equ     51h
dout2   equ     52h
dout3   equ     53h

clknum  equ     55h
key0    equ     56h
key1    equ     57h
key2    equ     58h
key3    equ     59h
keyport equ     5Ah
datport equ     5Bh
doutx   equ     5Ch


 ;================  initial  ================

main:   mov     scon,#50h
        mov     tmod,#20h
        mov     th1,#0fdh
        setb    tr1
        setb    ea
        mov     key0,#0aah   ;====== key data for DES ======
        mov     key1,#67h
        mov     key2,#32h
        mov     key3,#45h


Mloop:  call    getdata
        cjne    a,#58h,Mloop ;======  command detect ======
        call    getdata
        cjne    a,#79h,Mloop
        call    getdata
        cjne    a,#5Ah,Mloop
        call    getdata

;========================= receive command ===================
        cjne    a,#31h,N1com
        call    onecom
N1com:  cjne    a,#32h,N2com
        call    twocom
N2com:  cjne    a,#33h,N3com
        call    threecom
N3com:  cjne    a,#34h,N4com
        call    fourcom
N4com:  cjne    a,#35h,N5com
        call    fivecom
N5com:  jmp     Mloop

;========================== get 32 bit from PC ======================
onecom: push    acc

        call    getdata
        mov     din0,a
        call    getdata
        mov     din1,a
        call    getdata
        mov     din2,a
        call    getdata
        mov     din3,a

        pop     acc
        ret

;========================== send 32 bit to PC ======================
twocom: push    acc

loop2:  call    synwait
        mov     a,dout0
        call    sendpc

        call    synwait
        mov     a,dout1
        call    sendpc

        call    synwait
        mov     a,dout2
        call    sendpc

        call    synwait
        mov     a,dout3
        call    sendpc

        pop     acc
        ret

;========================== Encode ======================
        
threecom:
        push    acc

        clr     p2.2            ;encode
        setb    p2.1
        call    delay
        mov     clknum,#2h
        call    clkgen          ;Reset DES
        clr     p2.1
        call    delay

        mov     clknum,#5h
        call    clkgen          ;initial DES
        
        mov     a,din0
        mov     datport,a
        mov     a,key0          ;==== sent bit 7-0 to DES
        mov     keyport,a
        call    sendport

        mov     a,din1
        mov     datport,a
        mov     a,key1          ;==== sent bit 15-8 to DES
        mov     keyport,a
        call    sendport

        mov     a,din2
        mov     datport,a
        mov     a,key2          ;==== sent bit 23-16 to DES
        mov     keyport,a
        call    sendport

        mov     a,din3
        mov     datport,a
        mov     a,key3          ;==== sent bit 31-24 to DES
        mov     keyport,a
        call    sendport

        mov     clknum,#65d     ;==== excute DES =====
        call    clkgen

        call    recport
        mov     a,doutx         ;==== receive bit 7-0 from DES ===
        mov     dout0,a

        call    recport
        mov     a,doutx         ;==== receive bit 15-8 from DES ===
        mov     dout1,a

        call    recport
        mov     a,doutx         ;==== receive bit 23-16 from DES ===
        mov     dout2,a

        call    recport
        mov     a,doutx         ;==== receive bit 31-24 from DES ===
        mov     dout3,a

        pop     acc
        ret

;========================== Decode ======================
fourcom:
        push    acc

        setb    p2.2            ;decode
        setb    p2.1
        call    delay
        mov     clknum,#2h
        call    clkgen          ;Reset DES
        clr     p2.1
        call    delay

        mov     clknum,#5h
        call    clkgen          ;initial DES

        mov     a,din0
        mov     datport,a
        mov     a,key0          ;==== sent bit 7-0 to DES
        mov     keyport,a
        call    sendport

        mov     a,din1
        mov     datport,a
        mov     a,key1          ;==== sent bit 15-8 to DES
        mov     keyport,a
        call    sendport

        mov     a,din2
        mov     datport,a
        mov     a,key2          ;==== sent bit 23-16 to DES
        mov     keyport,a
        call    sendport

        mov     a,din3
        mov     datport,a
        mov     a,key3          ;==== sent bit 31-24 to DES
        mov     keyport,a
        call    sendport

        mov     clknum,#65d     ;==== excute DES =====
        call    clkgen

        call    recport
        mov     a,doutx         ;==== receive bit 7-0 from DES ===
        mov     dout0,a

        call    recport
        mov     a,doutx         ;==== receive bit 15-8 from DES ===
        mov     dout1,a

        call    recport
        mov     a,doutx         ;==== receive bit 23-16 from DES ===
        mov     dout2,a

        call    recport
        mov     a,doutx         ;==== receive bit 31-24 from DES ===
        mov     dout3,a

        pop     acc

        ret

;============================= Check Hardlock ==================
fivecom:
        push    acc

        mov     a,#65d
        call    sendpc

        pop     acc
        ret
;============================== Synwait ==================
synwait: push   acc

Sloop:  call    getdata
        cjne    a,#58h,Sloop ;======  command ======
        call    getdata
        cjne    a,#79h,Sloop
        call    getdata
        cjne    a,#5Ah,Sloop
        call    getdata
        cjne    a,#5Ah,Sloop

        pop     acc
        ret

;=========================== Clock generate ==================
clkgen: mov     r5,clknum

clklo:  clr     p2.0
        call    delay
        setb    p2.0
        djnz    r5,clklo

        clr     p2.0
        call    delay
        ret

;======================= receive data from port ========================
recport:
        push    acc
        push    0

        mov     clknum,#2h
        call    clkgen

        mov     a,p2        ;==== receive bit 7-0 ======
        swap    a
        anl     a,#00001111b
        mov     r0,a

        mov     clknum,#2h
        call    clkgen

        mov     a,p2
        anl     a,#11110000b
        add     a,r0
        mov     doutx,a
                     
        pop     0
        pop     acc
        ret

;============================ send data to port ========================
sendport:
        push    acc

;========================= mov data to p1.0-p1.3 =================
        mov     a,datport
        rrc     a
        jc      have10
        clr     p1.0
        jmp     bit1
have10: setb    p1.0

bit1:   rrc     a
        jc      have11
        clr     p1.1
        jmp     bit2
have11: setb    p1.1

bit2:   rrc     a
        jc      have12
        clr     p1.2
        jmp     bit3
have12: setb    p1.2

bit3:   rrc     a
        jc      have13
        clr     p1.3
        jmp     kbit0
have13: setb    p1.3

;========================= mov key to p1.4-p1.7 =================

kbit0:  mov     a,keyport
        rrc     a
        jc      have14
        clr     p1.4
        jmp     kbit1
have14: setb    p1.4

kbit1:  rrc     a
        jc      have15
        clr     p1.5
        jmp     kbit2
have15: setb    p1.5

kbit2:  rrc     a
        jc      have16
        clr     p1.6
        jmp     kbit3
have16: setb    p1.6        

kbit3:  rrc     a
        jc      have17
        clr     p1.7
        jmp     clkin
have17: setb    p1.7

clkin:  mov     clknum,#2h
        call    clkgen

;========================= mov data to p1.0-p1.3 =================
        mov     a,datport
        swap    a
        rrc     a
        jc      have10h
        clr     p1.0
        jmp     bit1h
have10h:setb    p1.0

bit1h:  rrc     a
        jc      have11h
        clr     p1.1
        jmp     bit2h
have11h:setb    p1.1

bit2h:  rrc     a
        jc      have12h
        clr     p1.2
        jmp     bit3h
have12h:setb    p1.2

bit3h:  rrc     a
        jc      have13h
        clr     p1.3
        jmp     kbit0h
have13h:setb    p1.3

;========================= mov key to p1.4-p1.7 =================

kbit0h: mov     a,keyport
        swap    a
        rrc     a
        jc      have14h
        clr     p1.4
        jmp     kbit1h
have14h:setb    p1.4

kbit1h: rrc     a
        jc      have15h
        clr     p1.5
        jmp     kbit2h
have15h:setb    p1.5

kbit2h: rrc     a
        jc      have16h
        clr     p1.6
        jmp     kbit3h
have16h:setb    p1.6        

kbit3h: rrc     a
        jc      have17h
        clr     p1.7
        jmp     clkinh
have17h:setb    p1.7

clkinh: mov     clknum,#2h
        call    clkgen    

        pop     acc
        ret

;============================ delay ========================
delay:  push    7
        mov     r7,#0ffh
        djnz    r7,$
        pop     7
        ret

;============================ Receive data from PC ========================
Getdata:jnb     ri,$
        mov     a,sbuf
        clr     ri
        ret

;============================ sent data to PC ========================
SendPC: clr     ti
        xrl     a,#78h      ;===== encode data to PC
        mov     sbuf,a
        jnb     ti,$
        ret
end


