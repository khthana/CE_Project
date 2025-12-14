// For board 188 ,2 flash & 2 srm last edit 23/03/2000
#include "define.h"
#define Station '1';
#define ID '0'
#define IRn '1'
#define Outletn '2'
#define DTMFn '3'
#define TEMPn '4'
#define Node 3
#define WAIT 1200
#define TLCD 100
#define MAX_DEVICE '5'
#define MAX_BUF 5000
#define MAX_KBUF 16
#define MAX_CBUF 16
#define MAX_DATA 16
#define LTELPASS 5
#define COM_BUF 128

void modem(unsigned char);
void screen(void);
void mainp(void);
void control(void);
void modemx(void);
void mpword(void);
void mtel(void);
void direct(void);
void system(void);
void pdate(void);
void ptime(void);
void pword(void);
void tpword(void);
void ctemp1(void);
void ctemp2(void);
void ctemp3(void);
void outlet(unsigned char,unsigned char);
void ir(unsigned char);
void dtmf(unsigned char);
void temperature(unsigned char);
void rs485(unsigned char);
void check_in(void);
unsigned char get_command(void);
void check_send(void);
void readRTC(void);
void show_temp(unsigned char);
void show_time(void);
void show_time2(void);
void callback(void);
void command(unsigned char);

unsigned char day=1;
unsigned char month=1;
unsigned char year=0x80;
unsigned char hour=0;
unsigned char minute=0;
unsigned char second=0;
unsigned char source,size,type,ndata[MAX_DATA];
unsigned char stage;
unsigned char output,output2,screenn,mainpn,controln,systemn,modemn;
unsigned char flag1;
unsigned char flag2=0;
unsigned char ent=0;
unsigned char backsp=0;
unsigned char sh_modem=0;
unsigned char sh_485=0;
unsigned char kdata=0;
unsigned char mst= 0;                   // modem status
unsigned char mts= 0;                   // modem status
unsigned char ssend = 0;
unsigned char callx = 0;
unsigned char tmodem =0;                // outlet send to modem too
unsigned char gx=0;                     // address in X
unsigned char gy=0;                     // address in Y
unsigned char slcd=0;                   //
unsigned char refresh=0;
unsigned char tdata[3];
unsigned char cdata[3];
unsigned char Password[MAX_CBUF] = "RECS";
unsigned char ModPass[MAX_CBUF] = "RECS";
unsigned char Tel_num[MAX_CBUF] = "102";
unsigned char TelPass[LTELPASS] = "1234";
unsigned char VTemp[3] = {0x3e,0x3e,0x3e};
unsigned char chout[10];

unsigned char *menu[] = {" Control "," Refresh "," System "," Modem "," Quit "};
#define N_MENU 5
unsigned char *menu_set[] = {" Ch1 "," Ch2 "," Ch3 "," Ch4 "," Ch5 "," Ch6 "," Ch7 "," Ch8 "," DC1 "," DC2 "," Main "};
#define S_MENU 11
unsigned char *menu_sys[] = {" Date "," Time "," Password "," Tel-Pass "," Temp1 "," Temp2 "," Temp3 "," Main "};
#define SY_MENU 8
unsigned char *menu_modem[] = {" Initial "," Connect "," Direct "," Password "," Tel-Num "," Main "};
#define M_MENU 6
static unsigned int delaylcd=0;

#include "lib.c"

void main() {
  static char *logo = "RECS version 1.2";
  int i;
  stage = 0; 	// Reset stage
  screenn = 0; mainpn = 0; controln = 0; systemn = 0; modemn = 0; //Reset menu
  output = 0; output2 = 0;
  clear_buffer();
  init_kbuffer();
  init_buffer();
  init_lcd();
  init_int();
  init_serial0();
  init_serial1();
  init_serial2();
  init_timer();
  init_buffer();
  attribute(0,0);
  Str2lcd(logo);
  slcd = 1;
  stage = 0;
  readRTC();
  put_buffer_out(':');
  put_buffer_out(Outletn);
  put_buffer_out(ID);
  put_buffer_out('Y');
  put_buffer_out('1');
  put_buffer_out('0');
  put_buffer_out('c');
  for (i = 0;i<5;i++) {
    print1("AT&F&C1&D2S0=1\r\n");				// initial modem
	delayx(0xffff);
  }
  while (1) {
    read_time();
	show_time();
    show_time2();		// send to LCD
    check_in();
    switch (stage) {
      case 0 : screen(); break;
      case 1 : mainp(); break;
      case 2 : control(); break;
      case 3 : system(); break;
      case 4 : modemx(); break;
      case 5 : pdate(); break;
      case 6 : ptime(); break;
      case 7 : pword(); break;
      case 8 : direct(); break;
      case 9 : mtel(); break;
      case 11 : tpword(); break;
      case 10 : mpword(); break;
	  case 12 : ctemp1(); break;
	  case 13 : ctemp2(); break;
	  case 14 : ctemp3(); break;
    }
  }
}

void screen(void)					// Screen of program (Reset and Quit)
{
  unsigned char i=0;
  unsigned char chk;
  if (screenn==0) {
    clrscr();
    gotoxy(22,5);
    print("Remote Environmental Control System");
    gotoxy(25,6);
    print("for Network Equipment (RECS)");
    gotoxy(29,8);
    print("Embedded System Lab");
    gotoxy(25,11);
    print("Password :");
    gotoxy(36,11);
    attribute(7,7);
    for (i=0;i<MAX_CBUF;i++) send(' ');
    attribute(0,0);
    gotoxy(36,11);
    screenn = 1;
    mainpn = 0;
    controln = 0;
    systemn = 0;
    modemn = 0;
  }
  if (ent == 1) {
    screenn = 0;
    flag1 = 0;
    ent = 0;
	chk = mem_read(MCS1,16);		 // Password System
    if (chk == 0xaa) {
	  for (i=0;i<MAX_CBUF-1;i++) {
	    Password[i] = mem_read(MCS1,i);
	  }
    } else {
	  gotoxy(80,1);
	  send('*');
	}
    if (!strcmp(command1,Password)) stage = 1;          // PASS
  }
  if (flag1 == 1) {
    gotoxy(36,11);
    attribute(7,7);
    for (i=0;i<point_buffer;i++) send('*');
    for (i=point_buffer;i<MAX_CBUF;i++) send(' ');
    gotoxy(36+point_buffer,11);
    attribute(0,0);
    flag1 = 0;
  }
}

void mainp(void)					// Menu of main program
{
  unsigned char i;
  unsigned char gxo;
  unsigned char xdata;
  unsigned char change=0;
  if (mainpn == 0) {
    gx = 0;
    mainpn = 1;
    screenn = 0;
    controln = 0;
    systemn = 0;
    modemn = 0;
    ent = 0;
    output = 0;
	output2 = 0;
    clrscr();
    for (i=1;i<=8;i++) {
      gotoxy(1,(5+i));
      print("channel ");
      send(i+'0');
      print(" off");
    }
	for (i=1;i<=2;i++) {
      gotoxy(1,(14+i));
      print("DC-48V. ");
      send(i+'0');
      print(" off");
    }
	for (i=1;i<=3;i++) {
      gotoxy(66,(9+i));
      print("Temp ");
      send(i+'0');
	  print(" =  ");
	  send_dec(tdata[i-1]);
	  send('.');
	  if (cdata[i-1]) {
	    send('5');
	  } else {
	    send('0');
	  }
	}
	refresh = 1;
    put_buffer_out(':');
    put_buffer_out(Outletn);
    put_buffer_out(ID);
    put_buffer_out('Y');
    put_buffer_out('1');
    put_buffer_out('0');
    put_buffer_out('c');
    gx = 0;
    attribute(0,0);
    for (i=0;i<N_MENU;i++) {
      gotoxy(1+(i*9),23);
      print(menu[i]);
    }
    gotoxy(1+(gx*9),23);
    attribute(7,7);
    print(menu[gx]);
    attribute(0,0);
  }
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    switch (gx) {
      case 0 : stage = 2; break;
      case 1 : stage = 1; mainpn = 0; break;    // refresh
      case 2 : stage = 3; break;
      case 3 : stage = 4; break;
      case 4 : stage = 0; break;
    }
  } else if (flag1 == 1) {
    flag1 = 0;
    change = 0;
    xdata = read_buffer();
    gxo=gx;
    switch (xdata) {
      case LEFT  : gx++;
		   if (gx >= N_MENU) gx = 0;
		   change = 1;
		   break;
      case RIGHT : if (gx == 0) gx = N_MENU;
		   gx--;
		   change = 1;
		   break;
    }
    if (change == 1) {
      attribute(0,0);
      gotoxy(1+(gxo*9),23);
      print(menu[gxo]);

      gotoxy(1+(gx*9),23);
      attribute(7,7);
      print(menu[gx]);
      attribute(0,0);
      change = 0;
    }
  }
}

void control(void)					// Menu of Seting Channal
{
  unsigned char gxo;
  unsigned char i;
  unsigned char xdata;
  unsigned char change;
  if (controln == 0) {
    change = 0;
    gx = 0;
    ent = 0;
    controln = 1;
    mainpn = 0;
    screenn = 0;
    systemn = 0;
    modemn = 0;
    attribute(0,0);
    for (i=0;i<S_MENU;i++) {
      gotoxy(1+(i*5),23);
      print(menu_set[i]);
    }
    gotoxy(1+(gx*5),23);
    attribute(7,7);
    print(menu_set[gx]);
    attribute(0,0);
  }
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    if (gx < 9) {
      flag2 = 1;
      put_buffer_out(':');
      put_buffer_out(Outletn);
      put_buffer_out(ID);
      put_buffer_out('C');
      put_buffer_out('1');
      put_buffer_out(gx+1+'0');
      put_buffer_out('c');
      flag2 = 0;
    } else if (gx == 9) {
		flag2 = 1;
        put_buffer_out(':');
        put_buffer_out(Outletn);
        put_buffer_out(ID);
        put_buffer_out('C');
        put_buffer_out('1');
        put_buffer_out('0');
        put_buffer_out('c');
        flag2 = 0;
	} else {
      stage = 1;
    }
  } else if (flag1 == 1) {
    flag1 = 0;
    xdata = read_buffer();
    gxo=gx;
    switch (xdata) {
      case LEFT : gx++;
		  if (gx >= S_MENU) gx = 0;
		  change = 1;
		  break;
      case RIGHT : if (gx == 0) gx = S_MENU;
		  gx--;
		  change = 1;
		  break;
    }
    if (change == 1) {
      attribute(0,0);
      gotoxy(1+(gxo*5),23);
      print(menu_set[gxo]);

      gotoxy(1+(gx*5),23);
      attribute(7,7);
      print(menu_set[gx]);
      attribute(0,0);
      change = 0;
    }
  }
}

void system(void)					// Menu of Check System (Time & Date, Password, Tel-Pass)
{
  unsigned char gxo;
  unsigned char i;
  unsigned char xdata;
  unsigned char change;
  static unsigned char tsec,tminute,thour,tday,tmonth,tyear;
  if (systemn == 0) {
    clrscr();
    change = 0;
    gx = 0;
    ent = 0;
    controln = 0;
    mainpn = 0;
    screenn = 0;
    systemn = 1;
    modemn = 0;
    attribute(0,0);
    read_date();                     // date
    gotoxy(1,5);
    print("Date(dd-mm-yy) :");
    gotoxy(1,6);
    print("Time(hh:mm:ss) :");
    gotoxy(1,7);
    print("Password : ");
    gotoxy(1,8);
    print("Tel Pass : ");
	gotoxy(1,10);
	print("Temperature 1 : ");
	gotoxy(1,11);
	print("Temperature 2 : ");
 	gotoxy(1,12);
	print("Temperature 3 : ");

    for (i=1;i<=3;i++) {
      gotoxy(66,(9+i));
      print("Temp ");
      send(i+'0');
	  print(" =  ");
	  send_dec(tdata[i-1]);
	  send('.');
	  if (cdata[i-1]) {
	    send('5');
	  } else {
	    send('0');
	  }
	}
    gotoxy(18,5);
    attribute(7,7);
    send_byte(day);
    attribute(0,0);
    send('-');
    attribute(7,7);
    send_byte(month);
    attribute(0,0);
    send('-');
    attribute(7,7);
    send_byte(year);
    attribute(0,0);

    gotoxy(18,6);
    attribute(7,7);
    send_byte(hour);
    attribute(0,0);
    send(':');
    attribute(7,7);
    send_byte(minute);
    attribute(0,0);
    send(':');
    attribute(7,7);
    send_byte(second);
    attribute(0,0);

    gotoxy(12,7);
    attribute(7,7);
    print(Password);
    attribute(0,0);

    gotoxy(12,8);
    attribute(7,7);
    print(TelPass);
    attribute(0,0);

	gotoxy(17,10);
    attribute(7,7);
    show_temp(VTemp[0]);
    attribute(0,0);

	gotoxy(17,11);
    attribute(7,7);
    show_temp(VTemp[1]);
    attribute(0,0);

	gotoxy(17,12);
    attribute(7,7);
    show_temp(VTemp[2]);
    attribute(0,0);

    for (i=0;i<SY_MENU;i++) {
      gotoxy(1+(i*10),23);
      print(menu_sys[i]);
    }
    gotoxy(1+(gx*10),23);
    attribute(7,7);
    print(menu_sys[gx]);
    attribute(0,0);
  } else if (tsec != second) {
    gotoxy(24,6);
    attribute(7,7);
    send_byte(second);
    attribute(0,0);
    tsec = second;
    if (tminute != minute) {
      gotoxy(21,6);
      attribute(7,7);
      send_byte(minute);
      attribute(0,0);
      tminute = tminute;
      if (thour != hour) {
	gotoxy(18,6);
	attribute(7,7);
	send_byte(hour);
	attribute(0,0);
	thour = hour;
	if (tday != day) {
	  gotoxy(24,5);
	  attribute(7,7);
	  send_byte(year);
	  attribute(0,0);
	  tday = day;
	  if (tmonth != month) {
	    gotoxy(21,5);
	    attribute(7,7);
	    send_byte(month);
	    attribute(0,0);
	    tmonth = month;
	    if (tyear != year) {
	      gotoxy(18,5);
	      attribute(7,7);
	      send_byte(day);
	      attribute(0,0);
	      tyear = year;
	    }
	  }
	}
      }
    }
  }
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    switch (gx) {
      case 7 : stage = 1; break;
      case 4 : stage = 12; ent = 0; flag1 = 1; break;
	  case 5 : stage = 13; ent = 0; flag1 = 1; break;
	  case 6 : stage = 14; ent = 0; flag1 = 1; break;
      case 3 : stage = 11; ent = 0; flag1 =1; break;
      case 0 : stage = 5; ent = 0; flag1 = 0; break;
      case 1 : stage = 6; ent = 0; flag1 = 0; break;
      case 2 : stage = 7; ent = 0; flag1 = 1; break;
    }
  } else if (flag1 == 1) {
    flag1 = 0;
    xdata = read_buffer();
    gxo=gx;
    switch (xdata) {
      case LEFT : gx++;
		  if (gx >= SY_MENU) gx = 0;
		  change = 1;
		  break;
      case RIGHT : if (gx == 0) gx = SY_MENU;
		  gx--;
		  change = 1;
		  break;
    }
    if (change == 1) {
      attribute(0,0);
      gotoxy(1+(gxo*10),23);
      print(menu_sys[gxo]);

      gotoxy(1+(gx*10),23);
      attribute(7,7);
      print(menu_sys[gx]);
      attribute(0,0);
      change = 0;
    }
  }
}

void modemx(void)				// Menu of Modem
{
  unsigned char gxo;
  unsigned char i;
  unsigned char xdata;
  unsigned char change;
  if (modemn == 0) {
    clrscr();
    change = 0;
    gx = 0;
    ent = 0;
    modemn = 1;
    controln = 0;
    mainpn = 0;
    screenn = 0;
    systemn = 0;
    attribute(0,0);
    gotoxy(1,7);
    print("Password modem : ");
    gotoxy(1,8);
    print("Telephone Number : ");
    attribute(7,7);
    gotoxy(18,7);
    print(ModPass);
    attribute(0,0);
    gotoxy(20,8);
    attribute(7,7);
    print(Tel_num);
    attribute(0,0);
    gotoxy(1,23);
    clrline(2);
    for (i=0;i<M_MENU;i++) {
      gotoxy(1+(i*10),23);
      print(menu_modem[i]);
    }
    gotoxy(1+(gx*10),23);
    attribute(7,7);
    print(menu_modem[gx]);
    attribute(0,0);
  }
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    gotoxy(1,1);
    switch (gx) {
      case 5 : stage = 1; break;                        // Main
      case 4 : stage = 9; ent = 0; flag1 = 1; break;    // Tel-modem
      case 3 : stage = 10; ent = 0; flag1 = 1; break;   // Password
//	  case 3 : tmodem = 0; print1("+++~~~+++ATH0\r\n"); break; // Dis Connect
      case 0 : print1("AT&F&C1&D2S0=1\r\n"); break;     // Initial
      case 1 : mst = 0;print1("ATDT");print1(Tel_num);print1("\r\n"); break; // Connect
      case 2 : stage = 8; clrscr(); gotoxy(1,1);
	       print("TAB to exit direction \n\r"); sh_modem=1; break; // Direct
    }
  } else if (flag1 == 1) {
    flag1 = 0;
    xdata = read_buffer();
    gxo=gx;
    switch (xdata) {
      case LEFT : gx++;
		  if (gx >= M_MENU) gx = 0;
		  change = 1;
		  break;
      case RIGHT : if (gx == 0) gx = M_MENU;
		  gx--;
		  change = 1;
		  break;
    }
    if (change == 1) {
      attribute(0,0);
      gotoxy(1+(gxo*10),23);
      print(menu_modem[gxo]);

      gotoxy(1+(gx*10),23);
      attribute(7,7);
      print(menu_modem[gx]);
      attribute(0,0);
      change = 0;
    }
  }
}

void pdate(void)						// Change Date
{
  unsigned char i;
  unsigned char temp;
  static unsigned char temp2;
  static unsigned char flagdata=0;
  static unsigned char fgdate1=0;
  static unsigned char fgdate2=0;
  static unsigned char fgdate3=0;
  if (flagdata == 0) {
    fgdate3 = 0;
    temp2 = 0;
    flagdata = 1;
    gotoxy(18,5);
    attribute(7,7);
    send_byte(day);
    attribute(0,0);
    send('-');
    attribute(7,7);
    send_byte(month);
    attribute(0,0);
    send('-');
    attribute(7,7);
    send_byte(year);
    attribute(0,0);
    gotoxy(18,5);
    attribute(7,7);
    send(' '); send(' ');
    attribute(0,0);
    gotoxy(18,5);
  } else if (ent == 1) {
    ent = 0;
    flag1 = 0;
    fgdate2 = 0;
    switch (fgdate1) {
      case 0 : if (fgdate3 != 0) { day = temp2; write_date(); }
	       fgdate3 = 0; temp2 = 0;
	       gotoxy(18,5); attribute(7,7); send_byte(day); attribute(0,0);
	       gotoxy(21,5); attribute(7,7); send(' '); send(' ');
	       attribute(0,0); gotoxy(21,5);
	       break;
      case 1 : if (fgdate3 != 0) { month = temp2; write_date(); }
	       fgdate3 = 0; temp2 = 0;
	       gotoxy(21,5); attribute(7,7); send_byte(month); attribute(0,0);
	       gotoxy(24,5); attribute(7,7); send(' '); send(' ');
	       attribute(0,0); gotoxy(24,5);
	       break;
      case 2 : if (fgdate3 != 0) { year = temp2; write_date(); }
	       stage = 3;
	       systemn = 0; flagdata = 0;
	       break;
    }
    fgdate1++; if (fgdate1 >= 3) fgdate1 = 0;
  } else if (flag1 == 1) {
    flag1 = 0;
    temp = read_buffer();
    if ((temp >= '0') && (temp <= '9')) {
      fgdate3 = 1;
      if (fgdate2 < 2) {
	temp2 = (temp2 * 0x10) + (temp - '0');
	attribute(7,7);
	send(temp);
	attribute(0,0);
	fgdate2++;
      }
    }
  }
}

void ptime(void)						// Change Time
{
  unsigned char i;
  unsigned char temp;
  static unsigned char temp2;
  static unsigned char flagtime=0;
  static unsigned char fgtime1=0;
  static unsigned char fgtime2=0;
  static unsigned char fgtime3=0;
  if (flagtime == 0) {
    fgtime3 = 0;
    temp2 = 0;
    flagtime = 1;
    gotoxy(18,6);
    attribute(7,7);
    send_byte(hour);
    attribute(0,0);
    send('-');
    attribute(7,7);
    send_byte(minute);
    attribute(0,0);
    send('-');
    attribute(7,7);
    send_byte(second);
    attribute(0,0);
    gotoxy(18,6);
    attribute(7,7);
    send(' '); send(' ');
    attribute(0,0);
    gotoxy(18,6);
  } else if (ent == 1) {
    ent = 0;
    flag1 = 0;
    fgtime2 = 0;
    switch (fgtime1) {
      case 0 : if (fgtime3 != 0) { hour = temp2; write_time(); }
	       fgtime3 = 0; temp2 = 0;
	       gotoxy(18,6); attribute(7,7); send_byte(hour); attribute(0,0);
	       gotoxy(21,6); attribute(7,7); send(' '); send(' ');
	       attribute(0,0); gotoxy(21,6);
	       break;
      case 1 : if (fgtime3 != 0) { minute = temp2; write_time(); }
	       fgtime3 = 0; temp2 = 0;
	       gotoxy(21,6); attribute(7,7); send_byte(minute); attribute(0,0);
	       gotoxy(24,6); attribute(7,7); send(' '); send(' ');
	       attribute(0,0); gotoxy(24,6);
	       break;
      case 2 : if (fgtime3 != 0) { second = temp2; write_time(); }
	       stage = 3;
	       systemn = 0; flagtime = 0;
	       break;
    }
    fgtime1++; if (fgtime1 >= 3) fgtime1 = 0;
  } else if (flag1 == 1) {
    flag1 = 0;
    temp = read_buffer();
    if ((temp >= '0') && (temp <= '9')) {
      fgtime3 = 1;
      if (fgtime2 < 2) {
	    temp2 = (temp2 * 0x10) + (temp - '0');
	    attribute(7,7);
		send(temp);
		attribute(0,0);
		fgtime2++;
      }
    }
  }
}

void pword(void) 				// Change Password
{
  unsigned char i;
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    if (command1[0] != '\0') {
      for (i = 0;i<MAX_CBUF-1;i++)
		Password[i] = command1[i];
	  for (i=0;i<MAX_CBUF-1;i++)
	    mem_write(MCS1,i,Password[i]);
	  mem_write(MCS1,16,0xaa);
      stage = 3;
      systemn = 0;
    }
  } else if (flag1 == 1) {
    gotoxy(12,7);
    attribute(7,7);
    print(com_buffer);
    for (i=point_buffer;i<MAX_CBUF;i++) send(' ');
    gotoxy(12+point_buffer,7);
    attribute(0,0);
    flag1 = 0;
  }
}


void direct(void)                               // connect modem direct
{
  unsigned char tdata;
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    send1(ENTER);
  } else if (flag1 == 1) {
    flag1 = 0;
    tdata = read_buffer();
    if (tdata == TAB) {
      sh_modem=0;
      modemn = 0;
      stage = 4;
    } else send1(tdata);
  }
}

void mtel(void)						// Change Modem Telephone number of Center
{
  unsigned char i;
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    if (command1[0] != '\0') {
      for (i=0;i<MAX_CBUF-1;i++)
	    Tel_num[i] = command1[i];
	  for (i=0;i<MAX_CBUF-1;i++)
	    mem_write(MCS1,i+34,Tel_num[i]);
	  mem_write(MCS1,50,0xaa);
      stage = 4;
      modemn = 0;
    }
  } else if (flag1 == 1) {
    flag1 = 0;
    gotoxy(20,8);
    attribute(7,7);
    if ((com_buffer[point_buffer-1] < '0') || (com_buffer[point_buffer-1] > '9')) {
      read_buffer();
    }
    for (i=0;i<point_buffer;i++) send(com_buffer[i]);
    if (point_buffer < MAX_CBUF)
      for (i=point_buffer;i<MAX_CBUF;i++) send(' ');
    gotoxy(20+point_buffer,8);
    attribute(0,0);
  }
}

void mpword(void)					// Change Modem Password  
{
  unsigned char i;
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    if (command1[0] != '\0') {
      for (i = 0;i<MAX_CBUF-1;i++)
	    ModPass[i] = command1[i];
	  for (i=0;i<MAX_CBUF-1;i++)
	    mem_write(MCS1,i+17,ModPass[i]);
	  mem_write(MCS1,33,0xaa);
      stage = 4;
      modemn = 0;
    }
  } else if (flag1 == 1) {
    gotoxy(18,7);
    attribute(7,7);
    print(com_buffer);
    for (i=point_buffer;i<MAX_CBUF;i++) send(' ');
    gotoxy(18+point_buffer,7);
    attribute(0,0);
    flag1 = 0;
  }
}

void tpword(void)						// Change Telephone Password of DTMF
{
  unsigned char i;
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    if (command1[0] != '\0') {
      for (i=0;i<LTELPASS-1;i++)
		TelPass[i] = command1[i];
	  for (i=0;i<LTELPASS-1;i++)
	    mem_write(MCS1,i+51,TelPass[i]);
	  mem_write(MCS1,55,0xaa);
      stage = 3;
      systemn = 0;
    }
  } else if (flag1 == 1) {
    flag1 = 0;
    gotoxy(12,8);
    attribute(7,7);
    if ((com_buffer[point_buffer-1] < '0') || (com_buffer[point_buffer-1] > '9')) {
      read_buffer();
    }
    for (i=0;i<point_buffer && i<4;i++) send(com_buffer[i]);
    if (point_buffer <4) {
      for (i=point_buffer;i<4;i++) send(' ');
	  gotoxy(12+point_buffer,8);
	}
    
    attribute(0,0);
  }
}

void ctemp1(void)
{
  unsigned char i,j;
  unsigned char btemp[3];
  unsigned int hexbyte;
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    if (command1[0] != '\0') {
	  for (i=0;i<3;i++) btemp[i] = 0;
	  j = 2;
	  for (i=0;i<3;i++) { 
	    if (command1[2-i] != '\0') {
		  btemp[j] = command1[2-i] - '0';
		  j--;
		}
	  }
	  hexbyte = 0;
	  hexbyte += (100 * btemp[0]);
	  hexbyte += (10 * btemp[1]);
	  hexbyte += btemp[2];
	  if (hexbyte <= 127) {
	    VTemp[0] = (hexbyte) << 1;
		mem_write(MCS1,56,VTemp[0]);
	    mem_write(MCS1,57,0xaa);
		if (tmodem == 1) {
		  print1(":@S1"); send1(VTemp[0]);
		}
	  }
      stage = 3;
      systemn = 0;
    }
  } else if (flag1 == 1) {
    flag1 = 0;
    gotoxy(17,10);
    attribute(7,7);
    if ((com_buffer[point_buffer-1] < '0') || (com_buffer[point_buffer-1] > '9')) {
      read_buffer();
    }
    for (i=0;i<point_buffer && i<3;i++) send(com_buffer[i]);
    if (point_buffer < 3) {
      for (i=point_buffer;i<3;i++) send(' ');
      gotoxy(17+point_buffer,10);
	}
    attribute(0,0);
  }
}

void ctemp2(void)
{
  unsigned char i,j;
  unsigned char btemp[3];
  unsigned int hexbyte;
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    if (command1[0] != '\0') {
	  for (i=0;i<3;i++) btemp[i] = 0;
	  j = 2;
	  for (i=0;i<3;i++) { 
	    if (command1[2-i] != '\0') {
		  btemp[j] = command1[2-i] - '0';
		  j--;
		}
	  }
	  hexbyte = 0;
	  hexbyte += (100 * btemp[0]);
	  hexbyte += (10 * btemp[1]);
	  hexbyte += btemp[2];
	  if (hexbyte <= 127) {
	    VTemp[1] = hexbyte << 1;
		mem_write(MCS1,58,VTemp[1]);
	    mem_write(MCS1,59,0xaa);
		if (tmodem == 1) {
		  print1(":@S2"); send1(VTemp[1]);
		}
	  }
      stage = 3;
      systemn = 0;
    }
  } else if (flag1 == 1) {
    flag1 = 0;
    gotoxy(17,11);
    attribute(7,7);
    if ((com_buffer[point_buffer-1] < '0') || (com_buffer[point_buffer-1] > '9')) {
      read_buffer();
    }
    for (i=0;i<point_buffer && i<3;i++) send(com_buffer[i]);
    if (point_buffer < 3) {
      for (i=point_buffer;i<3;i++) send(' ');
      gotoxy(17+point_buffer,11);
	}
    attribute(0,0);
  }
}

void ctemp3(void)
{
  unsigned char i,j;
  unsigned char btemp[3];
  unsigned int hexbyte;
  if (ent == 1) {
    ent = 0;
    flag1 = 0;
    if (command1[0] != '\0') {
	  for (i=0;i<3;i++) btemp[i] = 0;
	  j = 2;
	  for (i=0;i<3;i++) { 
	    if (command1[2-i] != '\0') {
		  btemp[j] = command1[2-i] - '0';
		  j--;
		}
	  }
	  hexbyte = 0;
	  hexbyte += (100 * btemp[0]);
	  hexbyte += (10 * btemp[1]);
	  hexbyte += btemp[2];
	  if (hexbyte <= 127) {
	    VTemp[2] = hexbyte << 1;
		mem_write(MCS1,60,VTemp[2]);
	    mem_write(MCS1,61,0xaa);
		if (tmodem == 1) {
		  print1(":@S3"); send1(VTemp[2]);
		}
	  }
      stage = 3;
      systemn = 0;
    }
  } else if (flag1 == 1) {
    flag1 = 0;
    gotoxy(17,12);
    attribute(7,7);
    if ((com_buffer[point_buffer-1] < '0') || (com_buffer[point_buffer-1] > '9')) {
      read_buffer();
    }
    for (i=0;i<point_buffer && i<3;i++) send(com_buffer[i]);
    if (point_buffer < 3) {
      for (i=point_buffer;i<3;i++) send(' ');
      gotoxy(17+point_buffer,12);
	}
    attribute(0,0);
  }
}

void modem(unsigned char data)		   // Call from interrupt Int_1{
{
  switch (mst) {
    case 0 : if (data == ':') mst = 1; break;
    case 1 : if (data == '&') {mst = 2; tmodem = 1; break;}
    		 else if (data == '@') {mst = 0; tmodem = 0; callx = 0; break;} 
	case 2 : if (data == 'C') {mst = 3; break;}		// expand type
			 else if (data == 'Y') {			// modem connect
			   put_buffer_out(':');
    		   put_buffer_out(Outletn);
    		   put_buffer_out(ID);
    		   put_buffer_out('Y');
    		   put_buffer_out('1');
    		   put_buffer_out('0');
    		   put_buffer_out('c');
			   callx = 0;						// ***
			   mst = 0; break;
			 }
			 else if (data == 'P') {
			   print1(":@p"); print1(ModPass); send1(0x00); mst = 0; 
			   print1(":@S1"); send1(VTemp[0]);
			   print1(":@S2"); send1(VTemp[1]);
			   print1(":@S3"); send1(VTemp[2]);
			   print1(":@B"); send1('3');
			   print1(":@B"); send1('3');
			   break;
			 }
			 else if (data == 'S') {
			   mst = 4; break;
			 }
			 else mst = 0; break;
	case 3 : put_buffer_out(':');
	     	 put_buffer_out(Outletn);
	     	 put_buffer_out(ID);
	     	 put_buffer_out('C');
	     	 put_buffer_out('1');
	     	 put_buffer_out(data);
	     	 put_buffer_out('c');
	     	 mst = 0; break;
	case 4 : if (data == '1') {mst = 5; break;}
			 else if (data == '2') {mst = 6; break;}
			 else if (data == '3') {mst = 7; break;}
			 else {mst = 0; break;}		//  expand stage
	case 5 : VTemp[0] = data;
			 mem_write(MCS1,56,data);
	    	 mem_write(MCS1,57,0xaa);
			 systemn = 0;
			 mst = 0; break;
	case 6 : VTemp[1] = data;
			 mem_write(MCS1,58,data);
	    	 mem_write(MCS1,59,0xaa);
			 systemn = 0;
			 mst = 0; break;
	case 7 : VTemp[2] = data;
	         mem_write(MCS1,60,data);
	    	 mem_write(MCS1,61,0xaa);
			 systemn = 0;
			 mst = 0; break;
  }		 
  if (sh_modem == 1) {
    send(data);
  }
}

void outlet(unsigned char data0,unsigned char data1)
{
  unsigned char i,j;
  unsigned char tmp,tmp2;
  unsigned char temp = 0x01;
  unsigned char showbit = 0;
  if (tmodem == 1) {
	if (ssend == 0) {
	  if (data0 == 0) {
		ssend = 1 ; print1(":@"); send1(type); send1(0x00); send1(data0); send1(data1); ssend = 0;
	  } else if (data0 == 0x11) {
	  	  ssend = 1 ; print1(":@"); send1(type); send1(0x32); send1(0x31); send1(data1); ssend = 0;
	  } else if (data0 == 0x13) {
	  	  ssend = 1 ; print1(":@"); send1(type); send1(0x32); send1(0x33); send1(data1); ssend = 0;
	  } else if (data0 == 0x32) {
	  	  ssend = 1 ; print1(":@"); send1(type); send1(0x32); send1(0x32); send1(data1); ssend = 0;
	  } else {
	      ssend = 1 ; print1(":@"); send1(type); send1(data0); send1(data1); ssend = 0;
	  }
	}
  }

  if (type == 'K') {
    if ((stage == 1) || (stage == 2)) {          // main and seting can view
      showbit = 1;
    } else showbit = 0;
    for (i=1;i<=8;i++) {
      tmp = data0 & temp;
      tmp2 = output & temp;
      if (tmp != tmp2) {
        if (showbit == 1) gotoxy(11,(5+i));
        slcd = 1;
        if (refresh == 0) Str2lcd("                ");
        if (refresh == 0) Str2lcd("Channel ");
        if (refresh == 0) lcd(i+'0');
        if (tmp) {
	      if (showbit == 1) print("on ");
	      if (refresh == 0) {
	        lcd(' '); lcd('o'); lcd('n');
		  }
        } else {
	      if (showbit == 1) print("off");
		  if (refresh == 0) {
		    lcd(' '); lcd('o'); lcd('f'); lcd('f');
		  }
      	}
      }
      temp = temp << 1;
  	}
	temp = 0x01;
  	for (i=1;i<=2;i++) {
      tmp = data1 & temp;
      tmp2 = output2 & temp;
      if (tmp != tmp2) {
        if (showbit == 1) gotoxy(11,(14+i));
        slcd = 1;
        if (refresh == 0) Str2lcd("                ");
        if (refresh == 0) Str2lcd("DC-48V. ");
        if (refresh == 0) lcd(i+'0');
        if (tmp) {
	      if (showbit == 1) print("on ");
		  if (refresh == 0) {
		    lcd(' '); lcd('o'); lcd('n');
		  }
        } else {
	  	if (showbit == 1) print("off");
		  if (refresh == 0) {
		    lcd(' '); lcd('o'); lcd('f'); lcd('f');
		  }
        }
      }
      temp = temp << 1;
    }
    output2 = data1;
    output = data0;
    if (showbit==1) gotoxy(1,23);
  } else {
    if (type == 'E') {	   						// Error Show
	  if (tmodem == 0) callback();
      if ((stage == 1) || (stage == 2)) {          // main and seting can view
        showbit = 1;
      } else showbit = 0;
	  if (data0 != 0) {
	    slcd = 1;
        Str2lcd("Outlet Error    ");
	  }
	  temp = 0x01;
      for (i=1;i<=8;i++) {
        tmp = data0 & temp;
        if (showbit==1) gotoxy(21,(5+i));
        if (tmp) {
	      if (showbit==1) print("Error ");
        } else {
	      if (showbit==1) print("      ");
        }
      temp = temp << 1;
  	  }
  	  /*for (i=1;i<=2;i++) {					// Show Error DC 48 V
        tmp = data1 & temp2;
        if (showbit==1) gotoxy(21,(14+i));
        if (tmp) {
	      if (showbit==1) print("Error ");
        } else {
	  	  if (showbit==1) print("      ");
        }
        temp2 = temp2 << 1;
      }*/
      if (showbit==1) gotoxy(1,23);
	}
  }
  refresh = 0;
}

void ir(unsigned char data)
{
  if (type == 'Z') {
	slcd = 1;
	Str2lcd("   Power Fail   ");
	s_cursor();
	gotoxy(32,14);
	print("Power Fail Detect");
	r_cursor();
    if (tmodem == 1) {
	  print1(":@Z");	    
	} else callback();
  } else if (type == 'D') {
    put_buffer_out(':');
    put_buffer_out(Outletn);
    put_buffer_out(ID);
    put_buffer_out('C');
    put_buffer_out('1');
    put_buffer_out(data);
    put_buffer_out('c');
  }	
}

void dtmf(unsigned char data)
{
  unsigned char i;
  unsigned char tmp;
  unsigned char ox;
  if (type == 'D') {
    if (size == '1') {
      put_buffer_out(':');
      put_buffer_out(Outletn);
      put_buffer_out(ID);
      put_buffer_out('C');
      put_buffer_out('1');
      put_buffer_out(data);
      put_buffer_out('c');
    } else if (size == '2') {
      put_buffer_out(':');
      put_buffer_out(Outletn);
      put_buffer_out(ID);
      put_buffer_out('C');
      put_buffer_out('2');
      put_buffer_out(data);
      put_buffer_out(ndata[1]);		  
      put_buffer_out('c');
    }
  } else if (type == 'P') {
    put_buffer_out(':');
    put_buffer_out(DTMFn);
    put_buffer_out(ID);
    put_buffer_out('p');
    put_buffer_out('5');
    put_buffer_out(TelPass[0]);
    put_buffer_out(TelPass[1]);
    put_buffer_out(TelPass[2]);
    put_buffer_out(TelPass[3]);
    put_buffer_out('\0');
    put_buffer_out('c');
  } else if (type == 'Q') {
	tmp = 0x01;
//	for (i=1;i<=data;i++) {
	  tmp = tmp << (data - 1);
//	}
	ox = output & tmp;
	if (ox) {
	  put_buffer_out(':');
      put_buffer_out(DTMFn);
      put_buffer_out(ID);
      put_buffer_out('q');
      put_buffer_out('2');
	  put_buffer_out(data);
      put_buffer_out('0');
      put_buffer_out('c');
	} else {
	  put_buffer_out(':');
      put_buffer_out(DTMFn);
      put_buffer_out(ID);
      put_buffer_out('q');
      put_buffer_out('2');
	  put_buffer_out(data);
      put_buffer_out('1');
      put_buffer_out('c');
	}
  }
}

void temperature(unsigned char data0)
{
  unsigned char i;
  
  tdata[data0-'1'] = ndata[1] >> 1;
  cdata[data0-'1'] = ndata[1] & 0x01;
  if ((stage == 1) || (stage == 2) || (stage == 3)) {          // main and seting can view
	gotoxy(76,9+(data0 - '0'));
    send_dec(tdata[data0-'1']);
	send('.');
	if (cdata[data0-'1']) {
	  send('5');
	} else {
	  send('0');
	}
	gotoxy(63,9+(data0 - '0')); 
  	if (ndata[1] > VTemp[data0-'1']) {
      send('*');
    } else {
      send(' ');
    }
	gotoxy(79,24);
  }
  if (ndata[1] > VTemp[data0-'1']) {
	slcd = 1;
	Str2lcd("  Error Temp ");
	lcd(data0);
	lcd(' ');
	lcd(' ');
	if (tmodem == 1) {
	  if (ssend == 0) {
        print1(":@"); send1('X'); send1(data0); send1(ndata[1]);
	  }
    } else callback();
  } else {
	if (tmodem == 1) {
	  if (ssend == 0) {
        print1(":@"); send1('T'); send1(data0); send1(ndata[1]);
	  }
    }
  }
}

void rs485(unsigned char data)
{
  if (sh_485 == 1) {
    send(data);
  }
}

void check_in(void)
{
  unsigned char i;
  if (!get_command()) {
    if (type == 'M') {                       // Message
      Str2lcd("                ");
      outpx(LCD_CODE,0x80);
      delayx(TLCD);
      for (i=0;i<(size-'0');i++) {
	    if (i == 8) {
	      outpx(LCD_CODE,0xc0);
	      delayx(TLCD);
	    }
	    lcd(ndata[i]);
      }
      slcd = 1;
    } else {
      switch (source) {
		case '1' : ir(ndata[0]); break;
		case '2' : outlet(ndata[0],ndata[1]); break;
		case '3' : dtmf(ndata[0]); break;
		case '4' : temperature(ndata[0]); break;
      }
    }
  }
}

unsigned char get_command(void)
{
  unsigned char crc,s_start,distination;
  unsigned char i;
  if (!empty_buffer_in()) {
    s_start = get_buffer_in();
    if (s_start == ':') {
      distination = get_buffer_in();
      if (distination != ID) return -1;
      source = get_buffer_in();
      type = get_buffer_in();
      size = get_buffer_in();
      for (i=0;i<(size-'0');i++)
	    ndata[i] = get_buffer_in();
      crc = get_buffer_in();
      if (crc != 'c') return -3;
      return 0;
    } else {
      return -2;
    }
  } else {
    return 1;
  }
}

void check_send(void)
{
  static unsigned char board = '1';
  unsigned char i,sized;
  if (!empty_buffer_out()) {
    if (flag2 == 0) {                      // Exist data in buffer
      outpx(PCS3,0x01);                    // Get data and send to 485
      send2(' ');
      for (i=0;i<4;i++)
	send2(get_buffer_out());
      sized = get_buffer_out();
      send2(sized);
      for (i=0;i<(sized-'0');i++)
	send2(get_buffer_out());
      send2(get_buffer_out());
      send2(' ');
      outpx(PCS3,0x00);
    }
  } else {
    outpx(PCS3,0x01);                      // No exist data in buffer
    send2(' ');                            // Send command polling to device
    send2(':');
    send2(board);
    send2(ID);
    send2('A');
    send2('1');
    send2('0');
    send2('c');
    send2(' ');
    board++;
    if (board > MAX_DEVICE)
      board = '1';
    outpx(PCS3,0x00);
  }
}

void readRTC(void)
{
  unsigned char chk,i;
  chk = mem_read(MCS1,16);		 // check Password System in RTC Ram
  if (chk == 0xaa) {
	for (i=0;i<MAX_CBUF-1;i++) {
	  Password[i] = mem_read(MCS1,i);
	}
  }
  chk = mem_read(MCS1,33);		// check Password Modem in RTC Ram
  if (chk == 0xaa) {
	for (i=0;i<MAX_CBUF-1;i++) {
	  ModPass[i] = mem_read(MCS1,i+17);
	}
  }
  chk = mem_read(MCS1,50);		// check number tel modem in RTC Ram
  if (chk == 0xaa) {
	for (i=0;i<MAX_CBUF-1;i++) {
	  Tel_num[i] = mem_read(MCS1,i+34);
	}
  }
  chk = mem_read(MCS1,55);   	// check Password Tel in RTC Ram
  if (chk == 0xaa) {
	for (i=0;i<LTELPASS-1;i++) {
	  TelPass[i] = mem_read(MCS1,i+51);
	}
  }
  chk = mem_read(MCS1,57);   	
  if (chk == 0xaa) {
    VTemp[0] = mem_read(MCS1,56);
  }
  chk = mem_read(MCS1,59);   	
  if (chk == 0xaa) {
    VTemp[1] = mem_read(MCS1,58);
  }
  chk = mem_read(MCS1,61);   	
  if (chk == 0xaa) {
    VTemp[2] = mem_read(MCS1,60);
  }
}

void show_temp(unsigned char data)
{
  unsigned char tvalue,cvalue;
  tvalue = data >> 1;
  cvalue = data & 0x01;
  send_dec(tvalue);
  send('.');
  if (cvalue) {
	send('5');
  } else {
	send('0');
  }
}

void show_time(void)
{
  static unsigned char csecx;
  if (csecx != second) {
  //asm cli;
    s_cursor();
    gotoxy(72,1);
    send_byte(hour);
    send(':');
    send_byte(minute);
    send(':');
    send_byte(second);
	gotoxy(32,14);
	print("                    ");
	r_cursor();
    csecx = second;
  //asm sti;
  }
}

void show_time2(void)
{
  static unsigned char csec;
  static unsigned char temp=0;
  if (slcd == 1) {delaylcd = 5; slcd = 0; temp = 1;}
  if (delaylcd == 0) {                    // delaylcd = 5 to mean 5 Second
    if (temp == 1) {Str2lcd("                "); temp = 0;}
    if (csec != second) {
      outpx(LCD_CODE,0xc0);
      delayx(TLCD);
      lcd_byte(hour);
      lcd(':');
      lcd_byte(minute);
      lcd(':');
      lcd_byte(second);
      csec = second;
    }
  }// else delaylcd--;          // decrease by timer (in lib.c)
}

void callback(void)
{
  static unsigned char cminute = 0;
  if (tmodem == 0) {
	if (callx == 0)	{
	  callx = 1;
	  cminute = minute;
	  mst = 0;print1("ATDT");print1(Tel_num);print1("\r\n");
	}
	if (cminute < (minute-1))
	  callx = 0;
  }
}

/*  while(1) {  			// Show Time & Date
    read_time();
    send_byte(hour);send(':');send_byte(minute);send(':');send_byte(second);
    print(" " );
    read_date();
    send_byte(day);send('/');send_byte(month);send('/');send_byte(year);
    print("\r\n");
    delayx(10000);
  } */

/*  while (1) {  			// Check & Show Memory MCS1
     print("begin write \r\n");
     stage = 0;
     for (gxx=0;gxx<2048;gxx++) {
       for (gy=0;gy<16;gy++) {
	 mem_write(MCS1,stage,0);
	 stage++;
       }
     }
     print("write ok \r\n");
     stage = 0;
     ent = 0;
     for (gx=0;gx<0x80;gx++) {
       for (gxx=0;gxx<0x100;gxx++) {
	 ent = mem_read(MCS1,stage);
	 stage++;
       }
       if (ent == 0) {
	 send_byte(gx); print("00 ");
       } else { print("error"); while(1) {}
       }
     }
  }*/     
