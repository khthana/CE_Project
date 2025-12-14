// "flag1" use for check new input
// "ent" use for check have Enter key
// "backsp" use for check have Back_Space key
// "fg" use for check have ESC code

int strcmp(char *str1,char *str2);

// Define function about buffer input and output
void push_buffer(unsigned char data);
unsigned char read_buffer(void);
void clear_buffer(void);

unsigned char full_kbuffer(void);
unsigned char empty_kbuffer(void);
unsigned char get_kbuffer(void);
void put_kbuffer(unsigned char);
void init_kbuffer(void);

unsigned char full_buffer_in(void);
unsigned char empty_buffer_in(void);
unsigned char get_buffer_in(void);
void put_buffer_in(unsigned char);

unsigned char full_buffer_out(void);
unsigned char empty_buffer_out(void);
unsigned char get_buffer_out(void);
void put_buffer_out(unsigned char);
void init_buffer(void);

unsigned char incx(unsigned char data);
interrupt timer0(void);
interrupt timer1(void);
interrupt timer2(void);
void init_timer(void);

interrupt int_0(void);
interrupt int_1(void);
interrupt int_2(void);
void send(char);
void send1(char);
void send2(char);
unsigned char recv2(void);
void RS485send(void);
void RS485recv(void);
void print (char *);
void print2 (char *);
void init_serial0(void);
void init_serial1(void);
void init_serial2(void);

void lcd(char);
void lcdx(char);
void lcd_byte(unsigned char);
void Str2lcd(char *);
void init_lcd(void);

void eoi(void);
void outpx (unsigned int port,unsigned char data);
void outpw (unsigned int port,unsigned int data);
unsigned char inpx (unsigned int port);
unsigned int inpw (unsigned int port);

void attribute(unsigned char ps1,unsigned char ps2);
void clrline(unsigned char ps);
void clrscr();
void s_cursor();
void r_cursor();
void gotoxy(unsigned char,unsigned char);

void delayx(unsigned int);
void init_int(void);

unsigned char buffer_in[MAX_BUF];
unsigned int head_in,tail_in;
unsigned char buffer_out[MAX_BUF];
unsigned int head_out,tail_out;
unsigned char key_buffer[MAX_KBUF+1];
unsigned int head,tail;

unsigned char com_buffer[MAX_CBUF+1];
unsigned int point_buffer;
unsigned char command1[MAX_CBUF+1]="\0";

int strcmp(char *str1,char *str2)
{
  unsigned int i;
  for (i = 0;(i<1000)&&((str1[i]!='\0')||(str2[i])!='\0');i++) {
    if (str1[i] != str2[i]) {
      return -1;
    }
  }
  if (i>=1000) return 1;
  return 0;
}

void push_buffer(unsigned char data)      // Keyboard function
{
  unsigned char i;                        // count
  unsigned char tdata;                    // temp data
  unsigned char fg2;                      // use for check ESC OK
  static unsigned char fg=0;              // use for check ESC CODE
  fg2 = 0;
  if (fg == 0) {
    switch (data) {
      case ESC       : fg = 1;
		       break;
      case BACKSPACE : if (point_buffer != 0) {
			 point_buffer--;
			 com_buffer[point_buffer] = '\0';
		       }
		       backsp = 1;
		       flag1 = 1;
		       break;
      case ENTER :     for (i=0;i<=point_buffer;i++)
			 command1[i] = com_buffer[i];
		       command1[i+1] = '\0';
		       point_buffer = 0;
		       com_buffer[0] = '\0';
		       ent = 1;
		       flag1 = 1;
		       break;
      default :        com_buffer[point_buffer] = data;
		       if (point_buffer != MAX_CBUF) {
			 point_buffer++;
		       }
		       com_buffer[point_buffer] = '\0';
		       flag1 = 1;
		       break;
    }
  } else if (fg == 1) {
    if (data == '[') {
      fg = 2;
    } else fg = 0;
  } else if (fg == 2) {
    switch (data) {
      case 'A' : tdata = UP; fg2 =1; break;
      case 'B' : tdata = DOWN; fg2 =1; break;
      case 'C' : tdata = LEFT; fg2 =1; break;
      case 'D' : tdata = RIGHT; fg2 =1; break;
    }
    if (fg2 == 1) {
      com_buffer[point_buffer] = tdata;
      if (point_buffer != MAX_CBUF) {
	point_buffer++;
      }
      com_buffer[point_buffer] = '\0';
      fg2 = 0;
    }
    fg = 0;
    flag1 = 1;
  }
}

unsigned char read_buffer(void)
{
  unsigned char data;
  if (point_buffer != 0) {
    point_buffer--;
    data = com_buffer[point_buffer];
    com_buffer[point_buffer] = '\0';
  }
  return data;
}

void clear_buffer(void)
{
  point_buffer = 0;
  com_buffer[point_buffer] = '\0';
}

// Keyboard Buffer
unsigned char empty_kbuffer(void)
{
  return (head == tail);
}

unsigned char full_kbuffer(void)
{
  unsigned int temp;
  temp = head;
  if (temp == MAX_KBUF) {
    temp = 0;
  } else temp++;
  return (temp == tail);
}

unsigned char get_kbuffer(void)
{
  unsigned char data;
  do {

  } while(empty_kbuffer());
    if (tail == MAX_KBUF) {
      tail = 0;
    } else tail++;
    data = key_buffer[tail];
    key_buffer[tail] = ' ';
    return data;
}

void put_kbuffer(unsigned char pdata)
{
  if (!full_kbuffer()) {
    if (head == MAX_KBUF) {
      head = 0;
    } else head++;
    key_buffer[head] = pdata;
  }
}

void init_kbuffer(void)
{
  head = 0;
  tail = 0;
}

// Buffer input and output
unsigned char empty_buffer_in(void)
{
  return (head_in == tail_in);
}

unsigned char full_buffer_in(void)
{
  unsigned int temp;
  temp = head_in;
  if (temp == MAX_BUF) {
    temp = 0;
  } else temp++;
  return (temp == tail_in);
}

unsigned char get_buffer_in(void)
{
  unsigned char data;
  do {

  } while(empty_buffer_in());
    if (tail_in == MAX_BUF) {
      tail_in = 0;
    } else tail_in++;
    data = buffer_in[tail_in];
    buffer_in[tail_in] = ' ';
    return data;
}

void put_buffer_in(unsigned char pdata)
{
  if (!full_buffer_in()) {
    if (head_in == MAX_BUF) {
      head_in = 0;
    } else head_in++;
    buffer_in[head_in] = pdata;
  }
}

unsigned char empty_buffer_out(void)
{
  return (head_out == tail_out);
}

unsigned char full_buffer_out(void)
{
  unsigned int temp;
  temp = head_out;
  if (temp == MAX_BUF) {
    temp = 0;
  } else temp++;
  return (temp == tail_out);
}

unsigned char get_buffer_out(void)
{
  unsigned char data;
  do {

  } while(empty_buffer_out());
    if (tail_out == MAX_BUF) {
      tail_out = 0;
    } else tail_out++;
    data = buffer_out[tail_out];
    buffer_out[tail_out] = ' ';
    return data;
}

void put_buffer_out(unsigned char podata)
{
  if (!full_buffer_out()) {
    if (head_out == MAX_BUF) {
      head_out = 0;
    } else head_out++;
    buffer_out[head_out] = podata;
  }
}

void init_buffer(void)
{
  head_in = 0;
  tail_in = 0;
  head_out = 0;
  tail_out = 0;
}

// interrupt timer and timer
unsigned char incx(unsigned char data)
{
  asm {
    mov al,data
    add al,1
    daa
    mov data,al
  }
  return data;
}

interrupt timer0(void)
{
  static unsigned int ssec=0;
  if (ssec >= 24) {
    if (delaylcd > 0) delaylcd--;
  /*  if (second >= 0x59) {
      if (minute >= 0x59) {
	if (hour >= 0x23) {
	  if (day >= 0x29) {
	    if (month >= 0x11) {
	      year=incx(year);
	      month=0;
	    } else month=incx(month);
	    day=0;
	  } else day=incx(day);
	  hour=0;
	} else hour=incx(hour);
	minute=0;
      } else minute=incx(minute);
      second=0;
    } else second=incx(second);*/
    ssec=0;
  } else ssec++;
  asm {               // use assembly code provide fast cycle
    mov dx,_EOIx
    mov ax,80ffh
    out dx,ax
  }  //eoi();
  return 0;
}

interrupt timer1(void)      // RS485
{
  check_send();             // call to program
  eoi();
  return 0;
}

interrupt timer2(void)
{
  eoi();
  return 0;
}

void init_timer(void)
{
  outpw(T1_Compare_A,50000);   // Manage RS485  15 ms
  outpw(T1_Compare_B,0);
  outpw(T1_Count,0);
  outpw(T1_Control,0xe001);    // enable

  outpw(T0_Compare_A,60000);   // Real Time Clock    20 ms
  outpw(T0_Compare_B,0);
  outpw(T0_Count,0);
  outpw(T0_Control,0xe001);    // enable

  outpw(T2_Compare_A,60000);
  outpw(T2_Count,0);
  outpw(T2_Control,0x6001);    // disable

  outpw(TIMER_REGS,0);
  asm sti;
}

// interrupt and interrupt serial
interrupt int_0(void)
{
  unsigned char xdata;
  asm cli;
  outpx(UART0_IER,0x00);
  do {
    xdata = inpx(UART0_LSR);
  } while (!(xdata&0x01));
  xdata = inpx(UART0_RBR);
  //outpx(UART1_THR,xdata);       // out to modem
  push_buffer(xdata);
  outpx(UART0_IER,0x01);
  eoi();
  asm sti;
  return 0;
}

interrupt int_1(void)   // modem
{
  unsigned char xdata;
  asm cli;
  outpx(UART1_IER,0x00);
  do {
    xdata = inpx(UART1_LSR);
  } while (!(xdata&0x01));
  xdata = inpx(UART1_RBR);
  modem(xdata);
  outpx(UART1_IER,0x01);
  eoi();
  asm sti;
  return 0;
}

interrupt int_2(void)  // RS485
{
  unsigned char xdata;
  asm cli;
  outpx(UART2_IER,0x00);
  do {
    xdata = inpx(UART2_LSR);
  } while (!(xdata&0x01));
  xdata = inpx(UART2_RBR);
  put_buffer_in(xdata);
  rs485(xdata);
  outpx(UART2_IER,0x01);
  eoi();
  asm sti;
  return 0;
}

void RS485send(void)
{
  outpx(PCS3,0x01);
}

void RS485recv(void)
{
  outpx(PCS3,0x00);
}

unsigned char recv2(void)
{
  unsigned char xdata;
  do {
    xdata = inpx(UART2_LSR);
  } while (!(xdata&0x01));
  xdata = inpx(UART2_RBR);
  return xdata;
}

void print (char *string)
{
  while (*string != '\0') {
    send(*string++);
  }
}

void print1(char *string)
{
  while (*string != '\0') {
    send1(*string++);
  }
}

void print2 (char *string)
{
  while (*string != '\0') {
    send2(*string++);
  }
}

void send (char data)
{
  unsigned char xdata;
  do {
    xdata = inpx(UART0_LSR);
  } while (!(xdata&0x20));
  outpx(UART0_THR,data);
}

void send1 (char data)
{
  unsigned char xdata;
  do {
    xdata = inpx(UART1_LSR);
  } while (!(xdata&0x20));
  outpx(UART1_THR,data);
}

void send2 (char data)
{
  unsigned char xdata;
  do {
    xdata = inpx(UART2_LSR);
  } while (!(xdata&0x20));
  outpx(UART2_THR,data);
}

void send_byte (unsigned char bdata)
{
  unsigned char bxdata;
  bxdata = bdata >> 4;
  if (bxdata > 9) bxdata = bxdata + 0x7;
  bxdata = bxdata + 0x30;
  send(bxdata);
  bxdata = bdata & 0x0f;
  if (bxdata > 9) bxdata = bxdata + 0x7;
  bxdata = bxdata + 0x30;
  send(bxdata);
}

void send1_byte (unsigned char bdata)
{
  unsigned char bxdata;
  bxdata = bdata >> 4;
  if (bxdata > 9) bxdata = bxdata + 0x7;
  bxdata = bxdata + 0x30;
  send1(bxdata);
  bxdata = bdata & 0x0f;
  if (bxdata > 9) bxdata = bxdata + 0x7;
  bxdata = bxdata + 0x30;
  send1(bxdata);
}

void send2_byte (unsigned char bdata)
{
  unsigned char bxdata;
  bxdata = bdata >> 4;
  if (bxdata > 9) bxdata = bxdata + 0x7;
  bxdata = bxdata + 0x30;
  send2(bxdata);
  bxdata = bdata & 0x0f;
  if (bxdata > 9) bxdata = bxdata + 0x7;
  bxdata = bxdata + 0x30;
  send2(bxdata);
}

void send_dec(unsigned char datax)
{
  if (datax >= 0xc8) {
    datax -= 0xc8;
    send('2');
  } else if (datax >= 0x64) {
    datax -= 0x64;
    send('1');
  }	else send(' ');
  if (datax >= 90) {
    datax -= 90;
    send('9');
  } else if (datax >= 80) {
    datax -= 80;
    send('8');
  } else if (datax >= 70) {
    datax -= 70;
    send('7');
  } else if (datax >= 60) {
    datax -= 60;
    send('6');
  } else if (datax >= 50) {
    datax -= 50;
    send('5');
  } else if (datax >= 40) {
    datax -= 40;
    send('4');
  } else if (datax >= 30) {
    datax -= 30;
    send('3');
  } else if (datax >= 20) {
    datax -= 20;
    send('2');
  } else if (datax >= 10) {
    datax -= 10;
    send('1');
  }	else send('0');
  send(datax+'0');
}

void send_dec1(unsigned char datax)
{
  if (datax >= 0xc8) {
    datax -= 0xc8;
    send1('2');
  } else if (datax >= 0x64) {
    datax -= 0x64;
    send1('1');
  }	else send1(' ');
  if (datax >= 90) {
    datax -= 90;
    send1('9');
  } else if (datax >= 80) {
    datax -= 80;
    send1('8');
  } else if (datax >= 70) {
    datax -= 70;
    send1('7');
  } else if (datax >= 60) {
    datax -= 60;
    send1('6');
  } else if (datax >= 50) {
    datax -= 50;
    send1('5');
  } else if (datax >= 40) {
    datax -= 40;
    send1('4');
  } else if (datax >= 30) {
    datax -= 30;
    send1('3');
  } else if (datax >= 20) {
    datax -= 20;
    send1('2');
  } else if (datax >= 10) {
    datax -= 10;
    send1('1');
  }	else send1('0');
  send1(datax+'0');
}

void send_dec2(unsigned char datax)
{
  if (datax >= 0xc8) {
    datax -= 0xc8;
    send2('2');
  } else if (datax >= 0x64) {
    datax -= 0x64;
    send2('1');
  }	else send2(' ');
  if (datax >= 90) {
    datax -= 90;
    send2('9');
  } else if (datax >= 80) {
    datax -= 80;
    send2('8');
  } else if (datax >= 70) {
    datax -= 70;
    send2('7');
  } else if (datax >= 60) {
    datax -= 60;
    send2('6');
  } else if (datax >= 50) {
    datax -= 50;
    send2('5');
  } else if (datax >= 40) {
    datax -= 40;
    send2('4');
  } else if (datax >= 30) {
    datax -= 30;
    send2('3');
  } else if (datax >= 20) {
    datax -= 20;
    send2('2');
  } else if (datax >= 10) {
    datax -= 10;
    send2('1');
  }	else send2('0');
  send2(datax+'0');
}
void init_serial0(void)        // Console
{
  outpx(UART0_LCR,0X83);
  outpx(UART0_DLL,0x78);       // 9600 bps
  outpx(UART0_DLM,0x00);
  outpx(UART0_LCR,0x03);
  outpx(UART0_IER,0x01);

  outpx(UART0_FCR,0x01);
  outpx(UART0_MCR,0x0B);
  outpx(UART0_LSR,0x60);
  outpw(Int0_REGS,0x0011);
  asm sti;
}

void init_serial1(void)         // Modem
{
  outpx(UART1_LCR,0X83);
  outpx(UART1_DLL,0x78);        //1200 bps   // DLL = 0xc0,DLM = 0x03
  outpx(UART1_DLM,0x00);
  outpx(UART1_LCR,0x03);

  outpx(UART1_IER,0x01);
  outpx(UART1_FCR,0x01);
  outpx(UART1_LCR,0x03);
  outpx(UART1_MCR,0x0B);
  outpx(UART1_LSR,0x60);
  outpx(UART1_MSR,0x10);

  outpw(Int1_REGS,0x0011);
  asm sti;
}

void init_serial2(void)         // RS485
{
  outpx(UART2_LCR,0X83);
  outpx(UART2_DLL,0x78);        // 9600 bps
  outpx(UART2_DLM,0x00);
  outpx(UART2_LCR,0x03);

  outpx(UART2_IER,0x01);
  outpx(UART2_FCR,0x01);
  outpx(UART2_MCR,0x0B);
  outpx(UART2_LSR,0x60);
  outpw(Int2_REGS,0x0011);
  asm sti;
}

// lcd function
void lcd (char data)				// Send Data to LCD	(current position)
{
  outpx(LCD_DATA,data);
  delayx(TLCD);
}

void lcdx(char xdata)				// Send Data to LCD	(position follow value of count)
{
  static unsigned char count = 0;
  if (count >= 16) count = 0;
  if (count < 8) {
    outpx(LCD_CODE,0x80+count);
    delayx(TLCD);
  } else {
    outpx(LCD_CODE,0xc0+count-8);
    delayx(TLCD);
  }
  outpx(LCD_DATA,xdata);
  delayx(TLCD);
  count++;
}

void lcd_byte (unsigned char bdata)		// Send Data to LCD in format of Hex
{
  unsigned char bxdata;
  bxdata = bdata >> 4;
  if (bxdata > 9) bxdata = bxdata + 0x7;
  bxdata = bxdata + 0x30;
  outpx(LCD_DATA,bxdata);
  delayx(TLCD);
  bxdata = bdata & 0x0f;
  if (bxdata > 9) bxdata = bxdata + 0x7;
  bxdata = bxdata + 0x30;
  outpx(LCD_DATA,bxdata);
  delayx(TLCD);
}

void lcd_dec(unsigned char datax)
{
  if (datax >= 0xc8) {
    datax -= 0xc8;
    lcd('2');
  } else if (datax >= 0x64) {
    datax -= 0x64;
    lcd('1');
  }	else lcd(' ');
  if (datax >= 90) {
    datax -= 90;
    lcd('9');
  } else if (datax >= 80) {
    datax -= 80;
    lcd('8');
  } else if (datax >= 70) {
    datax -= 70;
    lcd('7');
  } else if (datax >= 60) {
    datax -= 60;
    lcd('6');
  } else if (datax >= 50) {
    datax -= 50;
    lcd('5');
  } else if (datax >= 40) {
    datax -= 40;
    lcd('4');
  } else if (datax >= 30) {
    datax -= 30;
    lcd('3');
  } else if (datax >= 20) {
    datax -= 20;
    lcd('2');
  } else if (datax >= 10) {
    datax -= 10;
    lcd('1');
  }	else lcd('0');
  lcd(datax+'0');
}

void Str2lcd(char *string)				// Send String to LCD
{
  int i;
  outpx(LCD_CODE,0x80);
  delayx(TLCD);
  for (i=0;(i<8)&&(*string!='\0');i++) {
    outpx(LCD_DATA,*string++);
    delayx(TLCD);
  }
  outpx(LCD_CODE,0xc0);
  delayx(TLCD);
  for (i=8;(i<16)&&(*string!='\0');i++) {
    outpx(LCD_DATA,*string++);
    delayx(TLCD);
  }
}

void init_lcd(void)						// Initital LCD
{
  outpx(LCD_CODE,0x38);
  delayx(TLCD);
  outpx(LCD_CODE,0x0e);
  delayx(TLCD);
  outpx(LCD_CODE,0x06);
  delayx(TLCD);
  outpx(LCD_CODE,0x02);
  delayx(TLCD);
  outpx(LCD_CODE,0x01);
  delayx(TLCD);
}

// System lib
void eoi(void)
{
  outpw(_EOIx,0x80ff);
}

void outpx (unsigned int port,unsigned char data) // Byte
{
  asm {
    mov dx,port
    mov al,data
    out dx,al
  }
}

void outpw (unsigned int port,unsigned int data) // Word
{
  asm {
    mov dx,port
    mov ax,data
    out dx,ax
  }
}

unsigned char inpx (unsigned int port)   // Byte
{
  unsigned char retx;
  asm {
    mov dx,port
    in  al,dx
    mov retx,al
  }
  return retx;
}

unsigned int inpw (unsigned int port)   // Word
{
  unsigned int retx;
  asm {
    mov dx,port
    in  ax,dx
    mov retx,ax
  }
  return retx;
}

void mem_write(unsigned int segm,unsigned int offs,unsigned char data)
{
  asm {
    push es
    push di
    push ax
    mov al,data
    mov es,segm
    mov di,offs
    mov es:[di],al
    pop ax
    pop di
    pop es
  }
}

unsigned char mem_read(unsigned int segm,unsigned int offs)
{ 
  unsigned char data;
  asm {
    push es
    push di
    push ax
    mov es,segm
    mov di,offs
    mov al,es:[di]
    mov data,al
    pop ax
    pop di
    pop es
  }
  return data;
}

void delayx(unsigned int tdelay)
{
  unsigned int count;
  for (count=0;count<tdelay;count++) {;}
}

void attribute(unsigned char ps1,unsigned char ps2)
{
  send(0x1B);
  send('[');
  send(ps1+'0');
  send(';');
  send(ps2+'0');
  send('m');
}

void clrline(unsigned char ps)
{
  send(0x1B);
  send('[');
  send(ps+'0');
  send('K');
}

void clrscr()
{
  send(0x1B);
  send('[');
  send('2');
  send('J');
}

void s_cursor()
{
  send(0x1B);
  send('[');
  send('s');
}

void r_cursor()
{
  send(0x1B);
  send('[');
  send('u');
}

void gotoxy(unsigned char x,unsigned char y)
{
  send(0x1B);
  send('[');
  send('0'+(y/10));
  send('0'+(y%10));
  send(';');
  send('0'+(x/10));
  send('0'+(x%10));
  send('H');
}

void read_time(void)
{
  unsigned char data;
  data = mem_read(MCS1,TIMBUF);
  data = data | 0x40;
  mem_write(MCS1,TIMBUF,data);
  second = mem_read(MCS1,TIMBUF+1);
  minute = mem_read(MCS1,TIMBUF+2);
  hour = mem_read(MCS1,TIMBUF+3);
  data = data & 0xbf;
  mem_write(MCS1,TIMBUF,data);
}

void write_time(void)
{
  unsigned char data,temp;
  data = mem_read(MCS1,TIMBUF);
  data = data | 0x80;
  mem_write(MCS1,TIMBUF,data);
  temp = second & 0x7f;
  mem_write(MCS1,TIMBUF+1,temp);
  temp = minute & 0x7f;
  mem_write(MCS1,TIMBUF+2,temp);
  temp = hour & 0x7f;
  mem_write(MCS1,TIMBUF+3,temp);
  data = data & 0x7f;
  mem_write(MCS1,TIMBUF,data);
}

void read_date(void)
{
  unsigned char data;
  data = mem_read(MCS1,TIMBUF);
  data = data | 0x40;
  mem_write(MCS1,TIMBUF,data);
  day = mem_read(MCS1,TIMBUF+5);
  month = mem_read(MCS1,TIMBUF+6);
  year = mem_read(MCS1,TIMBUF+7);
  data = data & 0xbf;
  mem_write(MCS1,TIMBUF,data);
}

void write_date(void)
{
  unsigned char data,temp;
  data = mem_read(MCS1,TIMBUF);
  data = data | 0x80;
  mem_write(MCS1,TIMBUF,data);
  temp = day & 0x7f;
  mem_write(MCS1,TIMBUF+5,temp);
  temp = month & 0x7f;
  mem_write(MCS1,TIMBUF+6,temp);
  temp = year & 0x7f;
  mem_write(MCS1,TIMBUF+7,temp);
  data = data & 0x7f;
  mem_write(MCS1,TIMBUF,data);
}


void init_int(void)
{
  asm {
	push    ds
	push    di
	push    dx
	push    ax
	xor     ax,ax
	mov     ds,ax
	mov     ax,cs
	cli
/*      mov     di,_Divide0*4
	mov     word ptr ds:[di], offset Divide
	mov     word ptr ds:[di+2], ax

	mov     di,_Single_Step*4
	mov     word ptr ds:[di], offset Single_Step
	mov     word ptr ds:[di+2], ax

	mov     di,_NMI_Pin*4
	mov     word ptr ds:[di], offset NMI_Pin
	mov     word ptr ds:[di+2], ax

	mov     di,_Breakpoint*4
	mov     word ptr ds:[di], offset Break
	mov     word ptr ds:[di+2], ax

	mov     di,_Overflow*4
	mov     word ptr ds:[di], offset Overflow
	mov     word ptr ds:[di+2], ax

	mov     di,_BOUND*4
	mov     word ptr ds:[di], offset BOUND_INS
	mov     word ptr ds:[di+2], ax

	mov     di,_Unused*4
	mov     word ptr ds:[di], offset Unused
	mov     word ptr ds:[di+2], ax

	mov     di,_ESCape*4
	mov     word ptr ds:[di], offset ESCape
	mov     word ptr ds:[di+2], ax
*/
	mov     di,_Timer0*4
	mov     word ptr ds:[di], offset timer0
	mov     word ptr ds:[di+2], ax

/*      mov     di,_Reserved*4
	mov     word ptr ds:[di], offset Reserved
	mov     word ptr ds:[di+2], ax

	mov     di,_DMA0*4
	mov     word ptr ds:[di], offset DMA0
	mov     word ptr ds:[di+2], ax

	mov     di,_DMA1*4
	mov     word ptr ds:[di], offset DMA1
	mov     word ptr ds:[di+2], ax
*/
	mov     di,_INT0*4
	mov     word ptr ds:[di], offset int_0
	mov     word ptr ds:[di+2], ax

	mov     di,_INT1*4
	mov     word ptr ds:[di], offset int_1
	mov     word ptr ds:[di+2], ax

	mov     di,_INT2*4
	mov     word ptr ds:[di], offset int_2
	mov     word ptr ds:[di+2], ax

/*      mov     di,_INT3*4
	mov     word ptr ds:[di], offset int_3
	mov     word ptr ds:[di+2], ax

	mov     di,_80187*4
	mov     word ptr ds:[di], offset X80187
	mov     word ptr ds:[di+2], ax

	mov     di,_Reserved2*4
	mov     word ptr ds:[di], offset Reserved2
	mov     word ptr ds:[di+2], ax
*/
	mov     di,_Timer1*4
	mov     word ptr ds:[di], offset timer1
	mov     word ptr ds:[di+2], ax

	mov     di,_Timer2*4
	mov     word ptr ds:[di], offset timer2
	mov     word ptr ds:[di+2], ax
/*
	mov     dx,Int3_REGS               // initial interrupt 0
	mov     ax,0013h
	out     dx,ax

	mov     dx,Int2_REGS               // initial external interrupt
	mov     ax,0012h                   // Set in init_serial2
	out     dx,ax

	mov     dx,Int1_REGS               // Set in init_serial1
	mov     ax,0011h
	out     dx,ax

	mov     dx,Int0_REGS               // Set in init_serial0
	mov     ax,0010h
	out     dx,ax

	mov     dx,Timer_REGS              // Set in init_timer
	mov     ax,0000h
	out     dx,ax
*/
	sti
	pop     ax
	pop     dx
	pop     di
	pop     ds
  }
}
