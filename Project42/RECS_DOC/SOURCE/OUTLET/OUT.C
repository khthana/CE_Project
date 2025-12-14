#include<reg51.h>
#include<stdio.h>
#define ID '2'
#define ServerID '0'
#define WBSe 180
#define WASe 120
#define Error 1
#define ON 0;
#define datax '1'

sbit a00 = 0xe0;
sbit a01 = 0xe1;
sbit a02 = 0xe2;
sbit a03 = 0xe3;
sbit a04 = 0xe4;
sbit a05 = 0xe5;
sbit a06 = 0xe6;
sbit a07 = 0xe7;

sbit b00 = 0xF0;
sbit b01 = 0xF1;

sbit p07 = 0x80;     //output 
sbit p06 = 0x81;
sbit p05 = 0x82;
sbit p04 = 0x83;
sbit p03 = 0x84;
sbit p02 = 0x85;
sbit p01 = 0x86;
sbit p00 = 0x87;

sbit p17 = 0x90;     //input
sbit p16 = 0x91;
sbit p15 = 0x92;
sbit p14 = 0x93;
sbit p13 = 0x94;
sbit p12 = 0x95;
sbit p11 = 0x96;
sbit p10 = 0x97;

sbit p20 = 0xa0;     //output
sbit p21 = 0xa1;     //output
sbit p22 = 0xa2;     //input
sbit p23 = 0xa3;     //input
sbit p24 = 0xa4;
sbit p25 = 0xa5;
sbit p26 = 0xa6;
sbit p27 = 0xa7;     //control send/recv
sbit rs485 = 0xa7;

bit t0;
bit t1;
bit t2;
bit t3;
bit t4;
bit t5;
bit t6;
bit t7;
bit t8;
bit t9;

bit b_error;

void delayx(unsigned int);
unsigned char getdata(void) ;
unsigned char getcharx();
void send (unsigned char);
void send_error(void);
void send_485 (void);
unsigned char destination,source,type,size,datat[3],crc;
unsigned char temp[8] = 0;
unsigned int counter = 0;
//unsigned char status='-';
void main(void)
{
  rs485 = 1;
  SCON = 0x52;
  PCON = PCON & 0x7F;
  TMOD = 0x20;
  TH1 =  0xFD;
  TR1 = 1;
  RI = 0;
  P1 = 0xFF;
  P0 = 0xFF;
  P2 = 0xFF;

  t9 = t8 = t7 = t6 = t5 = t4 = t3 = t2 = t1 = t0 = 0; 
  b_error = 0;
  while(1) {
   rs485 = 1;
   if (getdata()==0) {
    if (destination == ID) {
      if (type == 'Y') {
		send_485();					// request updata 
      } else if (type == 'C') {
    	switch (datat[0]) {
   		case '1': if (size == '1') {
		    		if (t0 == 0) {
	 				  p00 = 0; t0 = 1;  
		      		} else {
	 				  p00 = 1; t0 = 0;  
		      		}
		    	  } else {
		      		if (datat[1] == datax) {
	 				  p00 = 0; t0 = 1;  
		            } else {
	 				  p00 = 1; t0 = 0;  
		      	    }
		          }
		    	  send_485();
		    	  break;
	    case '2': if (size == '1') {
		      	    if (t1 == 0) {
	  				  p01 = 0; t1 = 1;  
		      		} else {
	  				  p01 = 1; t1 = 0;  
		      		}
		    	  } else {
		      		if (datat[1] == datax) {
	  				  p01 = 0; t1 = 1;  
		      		} else {
	  				  p01 = 1; t1 = 0;  
		      		}
		    	  }
		    	  send_485();
		    	  break;
	    case '3': if (size == '1') {
		      	    if (t2 == 0) {
					  p02 = 0; t2 = 1;  
		      		} else {
					  p02 = 1; t2 = 0;  
		      		}
		    	  } else {
		      		if (datat[1] == datax) {
					  p02 = 0; t2 = 1;  
		      		} else {
					  p02 = 1; t2 = 0;  
		      		}
		    	  }
		    	  send_485();
		    	  break;
	    case '4': if (size == '1') {
		      		if (t3 == 0) {
					  p03 = 0; t3 = 1;  
		      		} else {
					  p03 = 1; t3 = 0;  
		      		}
		    	  } else {
		      		if (datat[1] == datax) {
					  p03 = 0; t3 = 1;  
		      	    } else {
					  p03 = 1; t3 = 0;  
		      		}
		          }
		    	  send_485();
		    	  break;
	    case '5': if (size == '1') {
		            if (t4 == 0) {
					  p04 = 0; t4 = 1;  
		      		} else {
					  p04 = 1; t4 = 0;  
		     		}
		    	  } else {
		      		if (datat[1] == datax) {
					  p04 = 0; t4 = 1;  
		      		} else {
					  p04 = 1; t4 = 0;  
		      		}
		    	  }
		    	  send_485();
		    	  break;
        case '6': if (size == '1') {
		    	    if (t5 == 0) {
					  p05 = 0; t5 = 1;  
		      		} else {
					  p05 = 1; t5 = 0;  
		      		}
		    	  } else {
		      		if (datat[1] == datax) {
					  p05 = 0; t5 = 1;  
		      		} else {
					  p05 = 1; t5 = 0;  
		      		}
		    	  }
		    	  send_485();
		    	  break;
	    case '7': if (size == '1') {
		            if (t6 == 0) {
					  p06 = 0; t6 = 1;  
		      		} else {
					  p06 = 1; t6 = 0;  
		     	 	}
		    	  } else {
		      		if (datat[1] == datax) {
					  p06 = 0; t6 = 1;  
		      		} else {
					  p06 = 1; t6 = 0;  
		      		}
		    	  }
		    	  send_485();
		    	  break;
	    case '8': if (size == '1') {
		      		if (t7 == 0) {
					  p07 = 0; t7 = 1;  
		      		} else {
					  p07 = 1; t7 = 0;  
		      		}
		    	  } else {
		      		if (datat[1] == datax) {
					  p07 = 0; t7 = 1;  
		      		} else {
					  p07 = 1; t7 = 0;  
		      		}
		    	  }
		    	  send_485();
		    	  break;
	    case '9': if (size == '1') {
		            if (t8 == 0) {
					  p20 = 0; t8 = 1;  
		      		} else {
					  p20 = 1; t8 = 0;  
		      		}
		    	  } else {
		      		if (datat[1] == datax) {
					  p20 = 0; t8 = 1;  
		      		} else {
					  p20 = 1; t8 = 0;  
		      		}
		    	  }
		    	  send_485();
		    	  break;
	    case '0': if (size == '1') {
		      		if (t9 == 0) {
					  p21 = 0; t9 = 1;  
		      		} else {
					  p21 = 1; t9 = 0;  
		      		}
		    	  } else {
		      		if (datat[1] == datax) {
					  p21 = 0; t9 = 1;  
		      		} else {
					  p21 = 1; t9 = 0;  
		      		}
		    	  }
		    	  send_485();
		    	  break;

	    default : break;
	    } // end of switch
      } else {
        if (type == 'A') {
		  if (P0 != P1) {
			if (counter >= 12) {
			  counter = 0;
			  b_error = 1;
	  	      send_error();
			} else counter++;
		  }	else {
		    if (b_error == 1) {
			  b_error = 0;
			  send_error();
			}
		  }
		}
      }  // end f if (type == 'A' and error)
    }  // end of if Destination
   }
  }  // end of while(1)
}  // end of main

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
  unsigned char datac;
  while (!RI) {}
  datac = SBUF;
  RI = 0;
  return datac;
}

void send (unsigned char datac)
{
  SBUF = datac;
  while(!TI) {}
  TI = 0;
}

void send_error(void)
{
  delayx(WBSe);
  rs485 = 0;
  //ACC = P0;
  ACC = 0x00;
  B = 0x00;
  if (!p00) if (p10) a00 = 1;
  if (!p01) if (p11) a01 = 1;
  if (!p02) if (p12) a02 = 1;
  if (!p03) if (p13) a03 = 1;
  if (!p04) if (p14) a04 = 1;
  if (!p05) if (p15) a05 = 1;
  if (!p06) if (p16) a06 = 1;
  if (!p07) if (p17) a07 = 1;
  if (!p20) if (p22) b00 = 1;
  if (!p21) if (p23) b01 = 1;
  send(':');
  send(ServerID);
  send(ID);
  send('E');
  send('2');
  send(ACC);
  send(B);
  send('c');
  delayx(WASe);
  rs485 = 1;
}

void send_485(void)
{
  counter = 0;
  delayx(WBSe);
  rs485 = 0;
  //ACC = P0;
  ACC = 0xFF;
  B = 0x03;
  if (p00) a00 = 0;
  if (p01) a01 = 0;
  if (p02) a02 = 0;
  if (p03) a03 = 0;
  if (p04) a04 = 0;
  if (p05) a05 = 0;
  if (p06) a06 = 0;
  if (p07) a07 = 0;
  if (p20) b00 = 0;
  if (p21) b01 = 0;
  send(':');
  send(ServerID);
  send(ID);
  send('K');
  send('2');
  send(ACC);
  send(B);
  send('c');
  delayx(WASe);
  rs485 = 1;
}

void delayx(unsigned int datac)         // (datax * 13) + 5 cycle
{
  unsigned int i;
  for (i=0;i<datac;i++) {}
}



