// New remote and New Board
#include<reg51.h>
#include<stdio.h>
#define ID '1'
#define ServerID '0'
#define WBSe 180
#define WASe 120

sbit p10 = 0x90;
sbit p11 = 0x91;
sbit p12 = 0x92;
sbit p13 = 0x93;
sbit sw4 = 0x94;
sbit sw3 = 0x95;
sbit sw2 = 0x96;
sbit sw1 = 0x97;
sbit IRdata = 0x92;
sbit rs485 = 0x93;


sbit p37 = 0xB7;

sbit a00 = 0xE0;

sbit b00 = 0xF0;
sbit b01 = 0xF1;
sbit b02 = 0xF2;
sbit b03 = 0xF3;
sbit b04 = 0xF4;
sbit b05 = 0xF5;
sbit b06 = 0xF6;
sbit b07 = 0xF7;
bit flag;


unsigned char temp,temp2;
unsigned char destination,source,type,size,datat[2],crc;
unsigned char dataf[24];
unsigned int berror;
unsigned char getdata(void);
unsigned char check_key(void);
unsigned char check_head(void);
unsigned char getcharx(void);
void delayx(unsigned int);
void main(void)
{
  rs485 = 1;
  SCON = 0x50;
  PCON = PCON & 0x7F;
  TMOD |= 0x20;
  TH1 =  0xFD;
  TR1 = 1;
  TI = 1;
  RI = 0;
  IRdata = 1;
  berror = 0;
  while(1) {
    temp = check_key();
    if (temp != 0) {
      flag = 1;
      while (flag) {
	    if (getdata() == 0) {
	      if (destination == ID) {
	        delayx(WBSe);
	    	rs485 = 0;
	    	printf(":%c%cD1%cc",ServerID,ID,temp);
	    	delayx(WASe);
	    	rs485 = 1;
	    	flag = 0;
	      }                               // end of if(getchar == ID)
	    }
      }
      delayx(5000);
    } else {
      if (p37 == 0) {
		if (berror > 20000) {
		  berror = 0;
		  flag = 1;
          while (flag) {
	        if (getdata() == 0) {
	          if (destination == ID) {
	            delayx(WBSe);
	    		rs485 = 0;
	    		printf(":%c%cZ11c",ServerID,ID);
	    		delayx(WASe);
	    		rs485 = 1;
	    		flag = 0;
	      	  }                               // end of if(getchar == ID)
	    	}	
		  }
		} else berror++;
	  } else berror=0;
    } 
  }                                       // end of while(1)
}                                         // end of main

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


void delayx(unsigned int datax)
{
   unsigned int i;
   for (i=0;i<datax;i++) {}
}

unsigned char check_head(void)
{
  unsigned char count_hix,count_lox;
  if (IRdata == 0) {
    count_lox = 0;
    do {
      count_lox++;
      if (count_lox > 26) return 1;
      delayx(10);
    } while (IRdata == 0);
    count_hix = 0;
    do {
      count_hix++;
      if (count_hix > 26) return 1;
      delayx(10);
    } while (IRdata == 1);
    if ((count_lox > 18) && (count_hix > 18)) return 0;
  }
  return 1;
}

unsigned char check_key(void)
{
  unsigned char i;
  unsigned char count_hi,count_lo;
  unsigned char flagx;
  if (check_head() == 0) {
    for(i=0;i<24;i++) {
      count_lo=0;
      do {
	    count_lo++;
	    if (count_lo >=10)  return 0;
	    delayx(10);
      } while (IRdata == 0);
      count_hi = 0;
      do {
	    flagx = 0;
	    count_hi++;
		if (count_hi >= 10) {
	      flagx = 1;
	      dataf[i] = 1;
	      do {
	        count_hi++;
	        if (count_hi >= 20) return 0;
	        delayx(10);
	      } while (IRdata == 1);
	    } else {
	      dataf[i] = 0;
	      delayx(10);
     	}
      } while (IRdata == 1);
    }
    if (dataf[2] == 1) return '4';
    B = 0xff;
    if (dataf[4] == 0) b07 = 0;
    if (dataf[5] == 0) b06 = 0;
    if (dataf[6] == 0) b05 = 0;
    if (dataf[7] == 0) b04 = 0;
    if (dataf[8] == 0) b03 = 0;
    if (dataf[9] == 0) b02 = 0;
    if (dataf[10] == 0) b01 = 0;
    if (dataf[11] == 0) b00 = 0;
    switch (B) {
      case 0x41 : return '1';
      case 0x68 : return '2';
      case 0x6f : return '3';
      case 0x7e : return '5';
      case 0x61 : return '6';
      case 0x51 : return '7';
      case 0x71 : return '8';
	  case 0x49 : return '9';
      case 0x69 : return '0';
      default   : return 0;
    }
  } return 0;
}
