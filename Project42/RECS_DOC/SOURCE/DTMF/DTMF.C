// New Board invert control rs485
#include<reg51.h>
#include<stdio.h>

#define ID '3'
#define ServerID '0'
#define WBSe 180
#define WASe 120
#define TCOUNT 3000

sbit p00 = 0x80;        // A2 of ISD
sbit p01 = 0x81;        // A3 of ISD
sbit p02 = 0x82;        // A4 of ISD
sbit p03 = 0x83;        // A5 of ISD
sbit p04 = 0x84;        // A6 of ISD
sbit p05 = 0x85;        // A7 of ISD
sbit p06 = 0x86;        // A8 of ISD
sbit p07 = 0x87;        // A9 of ISD

sbit p10 = 0x90;        // Q1 of DTMF
sbit p11 = 0x91;        // Q2 of DTMF
sbit p12 = 0x92;        // Q3 of DTMF
sbit p13 = 0x93;        // Q4 of DTMF
sbit p14 = 0x94;        // Key Switch
sbit p15 = 0x95;        // Relay of select telephone line
sbit p16 = 0x96;        // /EOM of ISD
sbit p17 = 0x97;        // /OVF of ISD

sbit p20 = 0xa0;        // Send or Resv of RS485
sbit CE = 0xa1;        // CE of ISD
sbit PD = 0xa2;        // PD of ISD
sbit PR = 0xa3;        // PR of ISD
sbit p24 = 0xa4;        // NC
sbit p25 = 0xa5;        // NC
sbit p26 = 0xa6;        // NC
sbit p27 = 0xa7;        // NC

sbit p32 = 0xb2;
sbit p33 = 0xb3;

bit  flag1;             // check int1
bit  flag2;             // exist data in buffer
bit  flag3 = 0;
bit  flag4 = 0;         // check 2 digit
bit  invert;
bit  mesgx = 0;         // bit for check send mesg
bit  passwd = 0;
bit  getpass = 0;
bit  rec = 0;
bit rec2 = 0;
bit  zero = 0;

unsigned char destination,source,type,size,datat[5];
unsigned char buffer_in[5] = '\0';			
unsigned char point_buf=0;				
unsigned char buffer[3];				
unsigned char mesg[11] = "mesg";			
unsigned char nint0=0;					
unsigned char password[4] = "1234";		
unsigned char state = 0;	
unsigned char key = 0;					
unsigned int count=0;
unsigned int txcount=0;					
unsigned char chk=0;
													 
void check_pass(void);
void operate(void);

int strcmpx(char *,char *);
void strcpyx(char *,char *);
void strcpyxx(char *,char *);
void record(unsigned char);
void play(unsigned char);
void tele(void);
void std(void);
void InitISD(void);
void setINT(void);
void check_in(void);
void send_address(unsigned char addr);
void delayx(unsigned int);
unsigned char getdata(void);
unsigned char getcharx(void);

void main(void)
{

  p20 = 1;              // Control RS485
  p15 = 1;              // Disconnect telephone
  buffer[1] = '0';
  invert = 0;
  SCON = 0x50;
  PCON = PCON & 0x7F;
  TMOD |= 0x20;
  TH1 =  0xFD;
  TR1 = 1;
  TI = 1;
  RI = 0;
  InitISD();
  setINT();
  flag1 = 0;                    // Interrupt STD from DTMF
  flag2 = 0;
  count = TCOUNT;
  rec2 = 0;
  while(1) {
    check_in();
    switch (state) {
      case 0 : check_pass(); break;
      case 1 : operate(); break;
    }
  }
}

void check_pass(void)
{
  unsigned char tmp;
  if (flag1 == 1) {
    flag1 = 0;
    if (getpass == 0) {
      getpass = 1;
      passwd = 1;
      mesgx = 1;
      strcpyx(mesg,"Password");
	  if (key == 0x0a) key = 0x00;
	  tmp = key;
      if (tmp != 0x0C) {
	    buffer_in[point_buf] = tmp + '0';
	    point_buf++;
	    buffer_in[point_buf] = '\0';
      }
    } else {
	  if (key == 0x0a) key = 0x00;
      tmp = key;
      if (tmp == 0x0C) {
		if (buffer_in[0] != '\0') {
	      if (!strcmpx(buffer_in,password)) {
	        state = 1;
	        mesgx = 1;
	        strcpyx(mesg,"Pass OK!");
			zero = 0;
	        play(2);
	      } else {
	        mesgx = 1;
	        strcpyx(mesg,"Incorrect");
	        play(3);
	      }
		}
	    point_buf=0;
	    buffer_in[point_buf] = '\0';
	    getpass = 0;
      } else {
	    buffer_in[point_buf] = tmp + '0';
	    point_buf++;
	    buffer_in[point_buf] = '\0';
      }
    }
  }
  if (p15 == 0)	{
	if (txcount == 0) {
      state = 0;
      mesgx = 1;
      play(4);
      p15 = 1;
	  nint0 = 0;
      strcpyx(mesg,"Exit");
      txcount = TCOUNT;
    } else txcount--;
  }
}

void operate(void)
{
  unsigned char tmp2;
  if (flag1 == 1) {
    flag1 = 0;
    count = TCOUNT;
    tmp2 = key;
    if (tmp2 == 0x0B) {				// *
      invert = 1;
      flag4 = 1;
      rec = 0;
	  zero = 0;
      buffer[1] = '0';
    } else if (tmp2 == 0x0C) {	    // #
      invert = 1;
      flag4 = 1;
      rec = 0;
	  zero = 0;
      buffer[1] = '1';
    } else if (tmp2 == 0x09) {          
      rec = 1;
      flag4 = 0;
	  zero = 0;
    } else if (rec == 1) {			// danger about zero
	   rec = 0;
	   rec2 = 1;
      chk = tmp2;
    } else if (flag4 == 1) {
      if (tmp2 == 0x0a) {			// 0
		if (zero == 1) {
		  flag4 = 0;
		  zero = 0;
		  state = 0;
	      mesgx = 1;
		  nint0 = 0;
	      play(4);
	      p15 = 1;
	      strcpyx(mesg,"Exit");
		} else zero = 1;
      } else if (tmp2<=8) {
	    if (zero == 0) {
		  tmp2 = tmp2 + 0x30;
	      buffer[0] = tmp2;
		} else {
		  if (tmp2 == 2) {
		    buffer[0] = '0';
		  } else {
		    if (tmp2 == 1) {
		      buffer[0] = '9';
			}
		  }
		}
		zero = 0;
	    flag2 = 1;
      } //else tmp2 = tmp2 + 7;
    }
  }
  if (count == 0) {
    state = 0;
    mesgx = 1;
	nint0 = 0;
    play(4);
    p15 = 1;
    strcpyx(mesg,"Exit");
    count = TCOUNT;
  } else count--;
}

void check_in(void)
{
  unsigned char i;
  if (!getdata()) {
    if (destination == ID) {
      if (passwd == 1) {
	    passwd = 0;
	    delayx(WBSe);
	    p20 = 0;
	    printf(":%c%cP11c",ServerID,ID);
	    delayx(WASe);
	    p20 = 1;
	  
      } else if (mesgx == 1) {
	    mesgx = 0;
	    delayx(WBSe);
	    p20 = 0;
	    for(i=1;mesg[i]!='\0';i++) {}
	    printf(":%c%cM%c%sc",ServerID,ID,i+'0',&mesg);
	    delayx(WASe);
	    p20 = 1;
	  } else if (rec2 == 1) {
	    rec2 = 0;
		delayx(WBSe);
	    p20 = 0;
	    printf(":%c%cQ1%cc",ServerID,ID,chk);
	    delayx(WASe);
	    p20 = 1;
      } else if (flag2 == 1) {                  // exist data in buffer
	if (invert == 0) {
	  flag2 = 0;
	  delayx(WBSe);
	  p20 = 0;
	  printf(":%c%cD1%cc",ServerID,ID,buffer[0]);
	  delayx(WASe);
	  p20 = 1;
	} else {
	  flag2 = 0;
	  delayx(WBSe);
	  p20 = 0;
	  printf(":%c%cD2%c%cc",ServerID,ID,buffer[0],buffer[1]);
	  delayx(WASe);
	  p20 = 1;
	}
      }
    }                                   // end of if(getchar == ID)
  }
}

unsigned char getdata(void)
{
  unsigned char i,crc;
  if (getcharx() == ':') {
    destination = getcharx();
    source = getcharx();
    type = getcharx();
    size = getcharx();
    if (type == 'p') {
      for (i=0;i<(size-'0');i++)
	    password[i] = getcharx();
	} else if (type == 'q') {
	  for (i=0;i<(size-'0');i++)
        datat[i] = getcharx();
	  if (datat[1] == '1') play(6);
	  if (datat[1] == '0') play(5);
	} else {  
	for (i=0;i<(size-'0');i++)
      datat[i] = getcharx();
    }
    crc = getcharx();
	if (crc != 'c') return 2;
    return 0;
  }
  return 1;
}

void send_address(unsigned char addrx)
{
  unsigned char addressx;
  addressx = addrx * 0x0c;
//  addressx = addressx >> 2;
  addressx = addressx & 0x3f;
  P0 = addressx;
}

/*void record(unsigned char address)
{
  CE = 1;
  send_address(address);
  PD = 0;
  PR = 0;
  CE = 0;
  p27 = 1;
  delayx(0xffff);               
  p27 = 0;
  delayx(0xffff);
  p27 = 1;
  delayx(0xffff);
  p27 = 0;
  delayx(0x7fff);
  p27 = 1;
  CE = 1;
  PR = 1;
  PD = 1;
}*/

void play(unsigned char address)
{
  if (p15 == 0) {
    CE = 1;
	send_address(address);
	PD = 0;
    PR = 1;
    CE = 0;
    p26 = 1;
    delayx(0xffff);             //  4 Sec
    p26 = 0;
    delayx(0xffff);
    p26 = 1;
    delayx(0xffff);
    p26 = 0;
    delayx(0x7fff);
    p26 = 1;
    CE = 1;
    PD = 1;
  }
}

unsigned char getcharx()
{
  RI = 0;
  while (!RI) {}
  return SBUF;
}

void delayx(unsigned int datax)
{
   unsigned int i;
   for (i=0;i<datax;i++) {}
}

void std(void)                  // Call by Int 1
{
  if (flag1 == 0) {
    key = P1 & 0x0f;
	txcount = TCOUNT;
    flag1 = 1;
  }
}

void tele(void)                 // Call by Int 0
{
  if (nint0 >= 2) {
	p15 = 0; 
	txcount = TCOUNT;                   // resv telephone
    nint0 = 0;
    mesgx = 1;
    strcpyxx(mesg,"Tel connect");
    play(1);
  } else nint0++;
}

void InitISD(void)
{
  P0 = 0;
  CE = 1;
  PD = 1;
  PR = 1;
}

void setINT(void)
{
  IE = 0x85; // EA,-,ET2,ES,ET1,EX1,ET0,EX0
  IT0 = 1;
  IT1 = 1;
}

int strcmpx(char *str1,char *str2)
{
  unsigned char i;
  for (i = 0;(i<255)&&((str1[i]!='\0')||(str2[i])!='\0');i++) {
    if (str1[i] != str2[i]) {
      return -1;
    }
  }
  if (i>=1000) return 1;
  return 0;
}

void strcpyx(char *str1,char *str2)
{
  unsigned char i;
  for (i = 0;(i<255)&&(str2[i]!='\0');i++)
    str1[i] = str2[i];
  str1[i] = '\0';
}
void strcpyxx(char *str1,char *str2)
{
  unsigned char i;
  for (i = 0;(i<255)&&(str2[i]!='\0');i++)
    str1[i] = str2[i];
  str1[i] = '\0';
}


