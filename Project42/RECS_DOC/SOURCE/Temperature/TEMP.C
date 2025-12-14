#pragma Small

#include<reg51.h>
#include<stdio.h>
#define ID '4'
#define ServerID '0'
#define WBSe 180
#define WASe 120
#define TCOUNT 3000

sbit p10 = 0x90;        
sbit p11 = 0x91;        
sbit p12 = 0x92;        
sbit p13 = 0x93;        
sbit p14 = 0x94;        // Send or Resv of RS485
sbit p15 = 0x95;        // Tempperature 1
sbit p16 = 0x96;        // Tempperature 2
sbit p17 = 0x97;        // Tempperature 3

sbit b0 = 0xf0;
sbit b1 = 0xf1;
sbit b2 = 0xf2;
sbit b3 = 0xf3;
sbit b4 = 0xf4;
sbit b5 = 0xf5;
sbit b6 = 0xf6;
sbit b7 = 0xf7;

sbit p37 = 0xb7;


unsigned char getdata(void);
unsigned char getcharx(void);
void sendcharx(unsigned char);
void check_in(void);
void delayx(unsigned int);
void treset(unsigned char);
bit tpresence(unsigned char);
bit read_tbit(unsigned char);
unsigned char read_tbyte(unsigned char);
void write_tbyte(unsigned char,unsigned char);
void write_tbit(bit,unsigned char);

unsigned char read_temp(unsigned char);

//bit tcheck1(void);
//bit tcheck2(void);
//bit tcheck3(void);

unsigned char destination,source,type,size,datat[1],crc;
//unsigned char tempid[9] = '\0';
//unsigned char tempdata[10] = '\0';
unsigned char countx;
unsigned char countt;

unsigned char dataxt[3];
int datatx[3];
unsigned char datac[3];

void main(void)
{
  unsigned char x;
  SCON = 0x52;
  PCON = PCON & 0x7F;
  TMOD |= 0x20;
  TH1 =  0xFD;
  TR1 = 1;
  //x = 0;
  while(1) {
	for (x=0;x<3;x++) {
	  dataxt[x] = read_temp(x+1);
	  //datatx[x] = (int)dataxt[x] >> 1;
      //datac[x] = dataxt[x] & 0x01;
	}
	check_in();
  }
}

void check_in(void)
{
  destination = 0;
  while (destination != ID) {
    getdata();
  }
  if ((countx == 10) || (countx == 20) || (countx == 30)) {
  	countt = (countx / 10) - 1;
  	delayx(WBSe);
	p13 = 0;
	sendcharx(':');
	sendcharx(ServerID);
	sendcharx(ID);
	sendcharx('T');
	sendcharx('2');
	sendcharx('1'+countt);
	sendcharx(dataxt[countt]);
	sendcharx('c');

  	//if (datac[countt]) 
    //  printf(":%c%cT6%c%03d.5c",ServerID,ID,'1'+countt,datatx[countt]);
    //else 
    //  printf(":%c%cT6%c%03d.0c",ServerID,ID,'1'+countt,datatx[countt]);
	delayx(WASe);
	p13 = 1;
  }
  countx++;  		  
  if (countx > 30) countx = 0;
}

unsigned char getdata(void)
{
  unsigned char i;
  if (getcharx() == ':') {
    destination = getcharx();
    source = getcharx();
    type = getcharx();
    size = getcharx();
    for (i=0;i<(size-'0');i++)
      datat[i] = getcharx();
    crc = getcharx();
	if (crc != 'c') return 2;
    return 0;
  }
  return 1;
} 

unsigned char getcharx()
{
  RI = 0;
  while (!RI) {}
  return SBUF;
}

void sendcharx(unsigned char datax)
{
  TI = 0;
  SBUF = datax;
  while(!TI) {}
}

void delayx(unsigned int datax)
{
   unsigned int i;
   for (i=0;i<datax;i++) {}
}

unsigned char read_temp(unsigned char ch)
{
  unsigned char dataxx;
  treset(ch);
  if (!tpresence(ch)) return -1;
  delayx(20);
  write_tbyte(0xcc,ch);
  write_tbyte(0x44,ch);
  treset(ch);
  //while(!tcheck()) {					// infinity loop
  //  treset();
  //}
  delayx(20);
  treset(ch);
  if (!tpresence(ch)) return -1;
  delayx(20);
  write_tbyte(0xcc,ch);
  write_tbyte(0xbe,ch);
  dataxx = read_tbyte(ch);
  treset(ch);       
  if (!tpresence(ch)) return -1;
  return dataxx;
}

void treset(unsigned char ch)
{
  switch (ch) {
    case 1 : p16 = 0; delayx(50); p16 = 1; p16 = 1; break;
	case 2 : p15 = 0; delayx(50); p15 = 1; p15 = 1; break;
	case 3 : p17 = 0; delayx(50); p17 = 1; p17 = 1; break;
  }
}

bit tpresence(unsigned char ch)
{
  unsigned char i;
  i = 0;
  switch (ch) {
    case 1 : while(p16 && (i>=200)) {i++;} i = 0; while(!p16 && (i>=200)) {i++;} break;
	case 2 : while(p15 && (i>=200)) {i++;} i = 0; while(!p15 && (i>=200)) {i++;} break;
  	case 3 : while(p17 && (i>=200)) {i++;} i = 0; while(!p17 && (i>=200)) {i++;} break;
  }
  if (i>=200) return 0;
  return 1;				// ok re p16 exist return 1;
}

unsigned char read_tbyte(unsigned char ch)
{
  b0 = read_tbit(ch);
  b1 = read_tbit(ch);
  b2 = read_tbit(ch);
  b3 = read_tbit(ch);
  b4 = read_tbit(ch);
  b5 = read_tbit(ch);
  b6 = read_tbit(ch);
  b7 = read_tbit(ch);
  return B;
}

bit read_tbit(unsigned char ch)
{
  bit retx;
  switch (ch) {
	case 1 : p16 = 0; p16 = 0; p16 = 0; p16 = 1; p16 = 1; p16 = 1; p16 = 1; p16 = 1; retx = p16; break;
   	case 2 : p15 = 0; p15 = 0; p15 = 0; p15 = 1; p15 = 1; p15 = 1; p15 = 1; p15 = 1; retx = p15; break;
   	case 3 : p17 = 0; p17 = 0; p17 = 0; p17 = 1; p17 = 1; p17 = 1; p17 = 1; p17 = 1; retx = p17; break;
  }
  delayx(2);
  return retx;
}

void write_tbyte(unsigned char temp_id,unsigned char ch)
{
  B = temp_id;
  write_tbit(b0,ch);
  write_tbit(b1,ch);
  write_tbit(b2,ch);
  write_tbit(b3,ch);
  write_tbit(b4,ch);
  write_tbit(b5,ch);
  write_tbit(b6,ch);
  write_tbit(b7,ch);
} 

void write_tbit(bit tbitx,unsigned char ch)
{
  if (tbitx == 0) {
	switch (ch) {
	  case 1 : p16 = 0; delayx(3); p16 = 1; break;
	  case 2 : p15 = 0; delayx(3); p15 = 1; break;
	  case 3 : p17 = 0; delayx(3); p17 = 1; break;
	}
  } else {
	switch (ch) {
	  case 1 : p16 = 0; p16 = 0; p16 = 1; break;
	  case 2 : p15 = 0; p15 = 0; p15 = 1; break;
	  case 3 : p17 = 0; p17 = 0; p17 = 1; break;
	}
    delayx(3);
  }
}