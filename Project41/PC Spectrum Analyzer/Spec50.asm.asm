;-----------------------------------------------------------;
BITLEN2         .set    54h 
BITLEN          .set    0a8h
;===============================
     .ds 0x60                   ; AIC/FFT Setup data in upper 1/2 B2
;==================================================================
TA      .word   12              ;control sampling rate for AIC
TB      .word   42
;*******************************
AIC_CMD         .word   0x0003  ; 0x72  0000 0000 0000 0011=0x0003
SIG_DEL         .word   0x0000  ; 0x73
STAT0           .word   0x0000  ;
STAT1           .word   0x0000  ; 0x74
ACCU_lo         .word   0x0000  ; 0x75
ACCU_hi         .word   0x0000  ; 0x76
REAL            .word   0x0000  ; 0x77
IMAG            .word   0x0000  ; 0x78
FFT_S           .word   256     ;
FFT_S-1         .word   255     ;
FFT_S/2         .word   128     ;
FFT_S/2-1       .word   127     ;
;----------------------------------------------------------------
;    SECONDARY VECTOR TABLE LOCATED IN B0 PROGRAM RAM
;----------------------------------------------------------------
        .mmregs                 ;
_D_base+128     .set    0x1080
        .ps     080ah           ;
        B       RINT            ;RINT  Branch to receive interrupt routine
        B       XINT            ;
;----------------------------------------------------------------
;    APPLICATION CODE IS LOCATED ABOVE DSKD KERNAL
;----------------------------------------------------------------
        .ps     0x0a00          ;
        .entry                  ;
start:                          ;
        SETC    INTM
        SETC    SXM
        SETC    OVM             ; catch accumulator overflows
        LDP     #0              ; All direct addressing is to MMRs and B2
        SPLK    #0830h,PMST
        LACC    #0
        SAMM    CWSR            ; Setsoftware wait stat eto 0
        SAMM    PDWSR           ;
        SPLK    #020h,IMR       ; Using XINT syn TX & RX
                                ; initialize AIC and enable interrupts
AIC_RS  SPLK    #01h,PRD        ; To generate  10MHz from Tout
        SPLK    #20h,TCR        ; for AIC maste rclock
        MAR     *,AR0
        LACC    #0008h          ; Non continuous mode
        SACL    SPC             ; FSX as input
        LACC    #00c8h          ; 16 bit words
        SACL    SPC
        LACC    #080h           ;
        SACH    DXR
        SACL    GREG
        LAR     AR0,#0FFFFh     ; Reset AIC by pulsing BR\pin
        RPT     #500            ; and taking it high after 500 cycles
        LACC    *,0,AR0         ; (.25ms at 50ns )
        SACH    GREG
        SETC    SXM             ;
;-------------------------------
        LACC    AIC_CMD         ; AIC control
        CALL    AIC_2nd         ; call loader
        ;------------------------
        LACC    TB,2            ; AIC timing B regs
        ADD     TB,9            ;
        ADD     #2              ;
        CALL    AIC_2nd         ; call loader
        ;-----------------------
        LACC    TA,2            ; AIC timing A regs
        ADD     TA,9            ;
        CALL    AIC_2nd         ; call loader
        ;-----------------------
        LDP     #0
        LACC    #010h           ; AIC RINT
        SACL    IMR             ; where INT0 indicates EOC (End Of Conv)
;************************************************************************
        LAR     AR6,#_B_base1   ; _D_base = A1[n],A2[n],A1[n+1],A2[n+1],...
        LAR     AR7,#255        ;
        MAR     *,AR7           ; enable buffer fill
        CLRC    INTM            ; Fill FFT array with 512 samples
FILL    BANZ    FILL,*,AR7      ;wait for buffer full

MAIN:   CALL    Init_S          ; Load 512 alternating data points
        LAR     AR0,FFT_S       ; Sigma FFT
        CALL    FFT             ;
        CALL    TO_HOST         ;
        B       MAIN
        ;-----------------------

;************************************************************************
Init_S:
        MAR     *,AR7           ; enable buffer fill
        CLRC    INTM            ; Fill FFT array with 512 samples
FILL2   BANZ    FILL2,*,AR7     ;wait for buffer full
        LAR     AR7,#255
        LAR     AR6,#_B_base1
        CALL    Init_D
        RET                     ;
;************************************************************************
Init_D: LAR     AR0,#_D_base    ;
        LAR     AR1,#_B_base1   ; Flip Flop data buffer and FFT array
        LAR     AR2,#255        ;
        MAR     *,AR1           ;
FILLD   LACL    *,AR0           ; get x[n+256]
        SACL    *+              ; REAL=X[n]
        SACH    *+,0,AR1        ; IMAG=0
        MAR     *+,AR2
        BANZ    FILLD,*-,AR1    ;
        RET                     ;
*************************************************************************
TO_HOST:
        LACC    #80h
        CALL    BCXMIT          ; Send frame synch (START)
        CALL    BRECV           ; Wait for host start word (01Bh)
        SUB     #01Bh
        NOP                     ; Insert NOPs to ensure condition was ready
        NOP                     ; while execute BCND
        BCND    TO_HOST,NEQ
        LAR     AR3,#_D_base    ;AR3= FFT data array
        LAR     AR5,FFT_S/2-1   ;AR5= loop counter
        MAR     *,AR3           ;
        CLRC    INTM
        IDLE                    ;TimeSync mark for RINT
more2   LACC    *+              ;scale log magnitude for host
        MAR     *+              ;
        RPT     #7              ;
        SFR                     ;
        SETC    INTM
        CALL    XMIT            ;send data 8 bit
        CLRC    INTM
        LAR     AR1,#BITLEN
        MAR     *,AR1
S_BIT1: BANZ    S_BIT1,*-,AR1   ;send 2 STOP BIT
        LAR     AR1,#BITLEN
        MAR     *,AR1
S_BIT2: BANZ    S_BIT2,*-,AR1

        MAR     *,AR5           ;
        BANZ    more2,*-,AR3    ;
        RET
;***********************************************************************
FFT:    MAR     *,AR0             ; Calculate FFT parameters from AR0 = Size
        SAR     AR0,FFT_S       ;
        MAR     *-              ;
        SAR     AR0,FFT_S-1     ;
        MAR     *+              ;
        MAR     *BR0+           ; AR0 = AR0 >> 1;
        SAR     AR0,FFT_S/2     ;
        MAR     *-
        SAR     AR0,FFT_S/2-1   ;
        ;-----------------------
        SETC    INTM
        LAR     AR0,FFT_S/2     ;
new_stg LAR    AR1,#_D_base     ; AR1 is the TOP BFLY address
        LAR    AR2,#_D_base     ; AR2 is the BOT BFLY address
        LAR    AR3,#_T_base+1   ; AR3 is the TWiddle pointer
        LAR     AR4,FFT_S/2     ; AR4 counts DFT blocks
        B       n_DFT2,*,AR1    ;
DFT:    MAR     *BR0+,AR5       ; complete circular buffer for TW's
        LAR     AR5,#1           ; set up DFT loop with *BR0+/BANZ
        MAR     *BR0+,AR1       ; using 1 cuts *BR0+ loop in half!
        ;----------------------------------------
        ; AR1=Top AR2=Bottom AR3=Twiddle
        ;----------------------------------------
BFLY:   LACC    *,14,AR2        ;(imag1+imag2)/4
        ADD     *,14,AR1        ;
        SACH    *+,1,AR2        ;store TOP imag
        SUB     *,15            ;(imag1-imag2)/2
        SACH    *+,1,AR1        ;store BOT imag
        LACC    *,14,AR2        ;(real1+real2)/4
        ADD     *,14,AR1        ;
        SACH    *+,1,AR2        ;store TOP real
        SUB     *,15            ;(real1-real2)/2
        SACH    *,1,AR5         ;store BOT real
        BANZ    OK,*BR0+,AR3    ;If at DFT end quit early
        ;-----------------------
        MAR     *+,AR2          ;clean up TW base (xxx0000+1)
        MAR     *+              ;modify BOTom DATA pointer
        MAR     *0+             ;
        MAR     *0+,AR1         ;
n_DFT2: MAR     *0+             ;modify the TOP pointer
        MAR     *0+,AR4         ;
        BANZ    DFT,*0-,AR3     ;dec DFT block count AR4 by OFFset
        MAR     *,AR0             ;
        MAR     *BR0+           ;
        BANZ    new_stg,*       ;if OFFset was 1, now cleared
        B       endFFT          ;
        ;-----------------------
OK      LT      *-,AR2          ;TREG=TWR     *NOTE* Twiddles are Q15
        MPY     *-              ;PREG=REAL*TWR
        LTP     *+,AR3          ;TREG=IMAG     ACCU=REAL*TWR
        MPY     *               ;PREG=IMAG*TWI                AR2=R AR3=I
        LTS     *+,AR2          ;TREG=TWI      ACCU=REAL*TWR-IMAG*TWI
        MPY     *               ;PREG=REAL*TWI
        SACH    *-,1,AR2     ;<<;
        LTP     *,AR3           ;TREG=IMAG     ACCU=REAL*TWI
        MPY     *BR0+,AR2       ;PREG=IMAG*TWR
        APAC                    ;              ACCU=IMAG*TWR+REAL*TWI
        SACH    *+,1,AR2     ;<<;
        B       BFLY,*+,AR1     ;
        ;------------------------------------------------------------
endFFT: MAR     *,AR2           ;Transform REAL & IMAG to log magnitude
        LAR     AR2,#_D_base    ;AR3=FFT data pointer
        LAR     AR3,FFT_S-1     ;AR5=FFT loop counter
        LAR     AR0,FFT_S

        ;-----------------------------------------------------------;
        ; WINDOW: Performs post FFT raised cosine windowing!        ;
        ; This is done by using the frequency coefficients of the   ;
        ; window in a convolution filter of the spectrum.           ;
        ;-----------------------------------------------------------;
more_MAG
        MAR      *BR0-          ;  -IMAG[-1]  1-COS(nwt/N)       + 1
        LACC     *BR0+,15       ;   IMAG[-0]  filter by post     |
        SUB      *BR0+,16       ;  +IMAG[+1]  convolution    <--+++-->
        ADD      *BR0-,15       ;   IMAG                        + + -.5
        SACH     IMAG           ;
        MAR      *+             ;   REAL
        MAR      *BR0-          ;  -REAL[-1]
        LACC     *BR0+,15       ;   REAL[-0]  X[-1] -2*X[0] + X[1]
        SUB      *BR0+,16       ;  +REAL[+1]
        ADD      *BR0-,15,AR1   ;   REAL
        SACH     REAL           ;
        SQRA    IMAG            ;IMAG & REAL can be at most 0x7fff Q15
        LTP     REAL            ;MPY will result (at most) in max positive
        MPY     REAL            ;
        APAC                    ;output is positive Q30
        ADD     #0x1            ;Set up a floor value; log(0) not legal!
        LAR     AR1,#17          ;pre-scaling exponent shifts Y axis
        RPT     #31             ;
        NORM    *-              ;
        NOP
        NOP
        MAR     *,AR2           ;
        MAR     *BR0-           ;-REAL;dump log(f) into oldest REAL (odd addr)
        SACH    *,2             ;clr explicit 1.0 and sign bit from mant
        LACL    *               ;load into ACCU_lo
        SAR     AR1,*           ;then append exponent (AR1)
        ADD     *,16            ;
        RPT     #10             ;jam result into ACCU_hi
        SFL                     ;If needed, Use ADDH to saturate overflow
        SACH    *               ;
        LACC    *               ;
        AND     #0xfffc,0       ;
        SACL    *BR0+           ; REAL
        MAR     *-              ; IMAG
        MAR     *BR0+,AR3       ;+IMAG
        BANZ    more_MAG,*-,AR2 ;keep going until all done
        ;--------------------------------------------------------
BITREV: LAR     AR0,FFT_S       ;Now perform Output bit reversal
        LAR    AR1,#_D_base     ;by moving the magnitude, which
        LAR    AR2,#_D_base+1   ;is in the REAL slots, into the
        LAR     AR3,FFT_S-1     ;IMAG slots of the FFT data array
more_BR LACC    *+              ;load the magnitude
        MAR     *+,AR1          ;
        SACL    *BR0+,0,AR3     ;move it to an open IMAG slot
        BANZ    more_BR,*-,AR2  ;more data to move?
        ;-----------------------
        RET                     ; FFT is finished!!
******************************************************************
AIC_2nd SACH    DXR
        CLRC    INTM
        IDLE
        ADD     #6,15           ;set ACCU_hi = 3 for secondary XMIT
        SACH    DXR             ;
        IDLE                    ;ACCU_hi requests 2nd XMIT
        SACL    DXR             ;
        IDLE                    ;ACCU_lo sets up registers
        SACL    DXR,2           ;close command with LSB = 00
        IDLE
        RET                     ;
*******************************************************************
; Transmitt a character
*******************************************************************
;============================================================================
; Trasmit word routine
;============================================================================
BCXMIT  BCND    $+4,bio         ; expect a sync (0) signal from PC
        B       $-2
;-----------------------------------------------------------------------------
; xmtbyte follows now           ; send lowbyte and return to calling pgm
;
;  'xmtbyte' requires ARP->AR0 and sets ACCU='mask for byte'
;  send startbit (0) +  databyte + stopbits (2)
;-----------------------------------------------------------------------------
XMIT    CLRC    c               ; startbit=0
        LAR     ar1,#8          ; counter: 1 startbit+ 8 databits (+ 2 stopbits)
nextbit1 BCND   snd0,nc         ; if c=1 send 1 else send 0
snd1    SETC    xf              ; send one
        B       snd
snd0    CLRC    xf
snd     RPT     #BITLEN         ; send one bit
        MAR     *,ar1
        ROR                     ; lsb(accu) -> carrybit
        BANZ    nextbit1,*-     ; repeat for entire word (9 bits)
        SETC    xf
        RET
;============================================================================
; Read Routine
;============================================================================
BRECV:
wait    BCNDD   STOK,bio        ;wait for start bit
        LAR     AR1,#7
        LACL    #0
        B       wait            ;
STOK    RPT     #BITLEN2        ;BITLEN is scaled and
        NOP
        MAR     *,AR1           ;number of bits - 1
WTBIT   SFR
        RPT     #BITLEN         ;decremented by 8/3 for
        NOP                     ;BITLEN/2 wait
        BCND    ZEROBT,bio
        ADD     #80h
ZEROBT  BANZ    WTBIT,*-        ;last bit ?
        RET                     ;ACC = read value
;******************************************************************
; NOTE: This code is NOT written with context restore!
;************************************************************************
RINT:   SST     #1,STAT1        ;Recover ARP from ARB by LST1
        SST     #0,STAT0
        PUSH
        MAR     *,AR7           ;
        BANZ    more_buf,*-,AR6 ;if buffer is full RET w/o EINT
        LAR     AR7,#0          ;
        LST     #1,STAT1        ;
        LST     #0,STAT0
        POP
        RET                    ;
more_buf                        ;
        LACC    DRR             ;
        SACL    *+              ;<<< store Ax[n], point to next
        ;-----------------------
FASTRET LST     #1,STAT1        ;
        LST     #0,STAT0
        POP
        RETE                    ;
XINT:   RETE
;====================================================================
        .listoff                ;
        .ds     01000h          ;NOTE: Twiddles are relocated to
        .include "dsk_twid.asm" ;      0x400 (B2) using CONF 1
        .liston
        .end
