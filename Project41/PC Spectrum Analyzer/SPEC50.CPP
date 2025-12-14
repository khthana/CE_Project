# include "spec50.h"

# define THR      0    // Transmitter holding register
# define DHR      0    // Receiver data       register
# define BRDL     0    // Baud rate devisor, low byte
# define BRDH     1    // Baud rate devisor, high byte
# define LCR      3    // Line control register
# define MSR      4    // Modem status register
# define LSR      5    // Line status register
# define DATA_READY    1  //  defined in the LCR register
# define DATA_OVERRUN  2  //  defined in the LCR register
# define TRUE     1
# define FALSE    0
# define XMT_BUF_EMPTY 0x20
# define DD       0    // Upload data from DSK -> PC
# define DP       1    // Upload prog from DSK -> PC
# define LD       2    // Download data from PC -> DSK
# define LP       3    // Download prog from PC -> DSK
# define XG       5    // Execute the program

FILE  *stream;        // global for this file

const STRING programme ="Spectrum Analyzer";
//const STRING pgmdate   ="04.19.95";
//const STRING version   ="2.00";
//const STRING copyright ="Copyright (c) 1995 Texas Instruments";

// global variables
PARAMETER  prm;            // parameter file and definition --> getchar.cpp
char       INFO[300];
char       title[200];
UINT       pcom;

char buf_0[512];                      // Keep past data history for
char buf_1[512];                      // time averaging of signals
char buf_2[512];
char buf_3[512];
char buf_4[512];
char buf_5[512];
char buf_6[512];
char buf_7[512];
char buf_8[512];

char buf_pk_t[512];
int  buf_y_pk[512];

int avg_on = 0,restart = 0,new_line1=0,new_line=0,x_position=5,y_position;
int x_position1 = 5,TrueKey=0;
int TempX,zoom=0,step=4,LineActive=0;
char string[20];
clock_t   duration;
char sa_kernel_out[]={"spec50.dsk"};


//--------------------------------------------------------------------
// Main program
//--------------------------------------------------------------------
void main(void)
{
  char *ptr1, *ptr2, *ptr3, *ptr4;
  char *ptr5, *ptr6, *ptr7, *ptr8, *ptr0;
  char *tmp0, *tmp1, *tmp2, *tmp3, *tmp4;
  char *tmp5, *tmp6, *tmp7, *tmp8, *pk_t;
  int  x, y, old_y, xx, *y_pk;
  int TA;
  int two_block_length,block_length,address;
  int k,c, number_overrun,BRD;
  float SCF, FDAC;


  prm.com = 1;
  clrscr();
  prm.EntryPoint=prm.PGM_CNT=0x0a00;   // standard entry point
  prm.INVERSE   =YES;              // for standard boards like DSK
re_start:
  prm.speed=57600;                 // default !
  InitializeMonitor();   // Establish communication at 57600 baud using old kernel

//------------------------------------------------------------------
// Load Spectrum Analyzer Kernel
//------------------------------------------------------------------

  printf("\nDownloading Spectrum Analyzer Program...\n");
  stream=fopen(sa_kernel_out,"rb");
  duration = LoadDsk();
  ExePgm();

//------------------------------------------------------------------
// Reinitialize PC serial port to 115200 baud
//------------------------------------------------------------------
  prm.speed=115200l;
  InitPort();
  init_graphics();
//------------------------------------------------------------------
// This module test the transfering of data without handshaking
//------------------------------------------------------------------
  two_block_length=128;
  tmp0 = buf_0;
  tmp1 = buf_1; tmp2 = buf_2; tmp3 = buf_3; tmp4 = buf_4;
  tmp5 = buf_5; tmp6 = buf_6; tmp7 = buf_7; tmp8 = buf_8;

  ptr0 = tmp0;
  for(x=0;x<256;x+=2) *ptr0++ = 128;  // init 1st line
  for(x=0;x<512;x++){
      buf_y_pk[x] = 0;
      buf_pk_t[x] = NULL;
  }
  for(         ;        ;     ) {
      ptr0 = tmp0;                            // Set buffer data pointers
      ptr1 = tmp1; ptr2 = tmp2; ptr3 = tmp3; ptr4 = tmp4;
      ptr5 = tmp5; ptr6 = tmp6; ptr7 = tmp7; ptr8 = tmp8;
      y_pk = buf_y_pk;
      pk_t = buf_pk_t;
      for(x=0;x<512;x+=step/*4*/) {
	  old_y = 128 - *ptr0; //Result = 256
	  switch(avg_on) {
	    case  1: *ptr0 = (*ptr1+*ptr2) >> 1;   // avg of 2
		     break;
	    case  2: *ptr0 = (*ptr1+*ptr2+*ptr3+*ptr4) >> 2; // avg of 4
		     break;
	    case  3: *ptr0 = (*ptr1+*ptr2+*ptr3+*ptr4+      // avg of 8
			      *ptr5+*ptr6+*ptr7+*ptr8) >> 3;
		     break;
	    default: *ptr0 = *ptr1;
		     break;                             // avg of 1
	  }
	  y = 128 - *ptr0;
	  *pk_t += 1;
	  if((*pk_t > 8) || (y < *y_pk)) {
	     //setcolor(LIGHTRED);
	     //line(x+3, *y_pk  ,x+7, *y_pk  );  // undraw old peak
	     if(y < *y_pk) {
		*y_pk = y;
		*pk_t = 0;
	     }
	     else
		*y_pk += 6;
	     //line(x+3, *y_pk  ,x+7, *y_pk  );  // draw new peak
	     setcolor(WHITE);
	  }
	  y_pk++;
	  pk_t++;
//----------------------------
	  if(y > old_y){
	     old_y++;//setcolor(RED);
	     line(x+5,old_y,x+5,y);
	  }
	  if(y < old_y){
	     y++;//setcolor(BLUE);
	     line(x+5,old_y,x+5,y);
	  }
	  if(new_line>0) //Modify Draw Line 2 for Analysis
	       {
		 setcolor(14);  //Set color Yellow
		 line(x_position,0,x_position,270);
		 setcolor(WHITE);
	       }
	  if(new_line1>0) //Modify Draw Line 1 for Analysis
	       {
		 setcolor(12);  //Set color Ligth Red
		 line(x_position1,0,x_position1,270);
		 setcolor(WHITE);
	       }
	  ptr0++;
	  ptr1++; ptr2++; ptr3++; ptr4++;               // next data
	  ptr5++; ptr6++; ptr7++; ptr8++;
      }

      if(kbhit()) check_key();
      if(restart){
	 avg_on=restart=0;
	 closegraph();
	 goto re_start;
      }
      ptr1 = tmp8;                    // Rotate the buffer pointers
      tmp8 = tmp7; tmp7 = tmp6; tmp6 = tmp5; tmp5 = tmp4;
      tmp4 = tmp3; tmp3 = tmp2; tmp2 = tmp1; tmp1 = ptr1;

      for(k = 10000; k > 0; k--){
	  WaitFor(XMT_BUF_EMPTY);    // Send a pulse to DSP then wait for
	  outportb(pcom,NULL);       // starting pulse 0x80
	  delay(1);
	  c = inportb(pcom);
	  if( c == 0x80 ){              // reveive starting pulse 0x80 send
	      WaitFor(XMT_BUF_EMPTY);   // 0x1b to DSP indicate "ready to
	      outportb(pcom,0x1B);      // receive 128 data with interrupt
	      break;                    // turn-off
	  }
      }
      if( k == 0 ){
	  printf("Fail to get start pulse\n");
	  exit(0);
      }

// Turn off interrupt and reading the data from DSP
      asm cli;
      WaitFor(XMT_BUF_EMPTY);
      outport(pcom,NULL);
      for(k=0;k<two_block_length;k++)
	  *ptr1++=Bcrcv(pcom);
      asm sti;
  }
}

void check_key(void)
{
  int key;
  key = (bioskey(0)) >> 8;
  switch(key)                           // Key traps for various routines
  {
    case 66    : avg_on += 1;   //F8 (A)veraging select
		 if(avg_on >3)
		   avg_on = 0;
		 TrueKey = 1;
		 break;
    case 59    : new_line1 +=1;  //F1
		 LineActive=1;
		 TrueKey=1;
		 break;
    case 60    : new_line +=1;   //F2
		 LineActive=2;
		 //if(new_line>1)
		 //  new_line = 0;
		 TrueKey=1;
		 break;
    case 0x4D  : TrueKey=1;
		 switch (LineActive)
		   {
		     case 2 : x_position +=step/*4*/;    // Right Arrow
			      if(x_position>500)
			      x_position=5;
			      break;
		 //y_position=x_position;}
		     case 1 : x_position1 +=step;
			      if(x_position1>500)
			     x_position1=5;
			     break;
		    }
		 break;
    case 0x4B  : TrueKey=1;
		switch (LineActive)
		  {
		    case 2 : x_position -=step/*4*/;    // Left Arrow
			     if(x_position<5)
			     x_position=5;
			     break;
		 //y_position=x_position;}
		    case 1 : x_position1 -=step;
			     if(x_position1<5)
			     x_position1=5;
			     break;
		  }
		 break;
    case 0x43  : restart = 1;break;   // F9 (R)eboot code
    case 0x44  : closegraph();            // (Q)uit to DOS
	       exit(0);          break;
    default    : TrueKey=0;      break;
  }
  if(TrueKey)
    {
      setup_vals();                         // redraw the setup values
      setviewport(100,40,600,274,1);        // Set window to show display
      setwritemode(1);                      // display lines are XOR drawn
      setcolor(15);                         // light gray
    }
}
void InitializeMonitor(void) /*altered on 03/01/95*/
{
 UINT num;
 UINT error;
 int pass=FALSE;


 InitPort(); //initialise serial com regiaters.

 pass=FALSE;
 BaudRateDetect(); //send 0x80 to DSP to calculate BITLEN.
 delay(2);  // what is the right time ??? was 1 up to version 0.98

 switch(error=InitMonitor())
 {
	case 0:
	case 1:
	case 2:   pass=FALSE;
		  break;
	case 3:   pass=TRUE;
		  break;
 }
 if(!pass){
    clrscr();
    printf("\nCommunication not successful\n");
    switch(error) {
      case 0: printf("\nNo Response.\n");
	      break;
      case 1: printf("\nTest Error.\n");
	      break;
      case 2: printf("\nNo Escape.\n");
	      break;
     default: break;
    }
    exit(1);
 }
}

void InitPort(void)
{
  UINT  COMADD[]={0x3f8, 0x2f8, 0x3e8, 0x2e8};
  int   BRD=115200l/prm.speed;
  pcom = COMADD[prm.com];
  UINT port_no=pcom;

  asm  mov  DX,word ptr port_no  //
  asm  add  DX,3                 //
  asm  mov  AL,087h              // SET BAUD access
  asm  out  DX,AL                //
  asm  sub  DX,3                 //
  asm  mov  AX,word ptr BRD  //LO// Set 19200 baud
  asm  out  DX,AL                //
  asm  add  DX,1                 //
  asm  mov  AL,byte ptr BRD  //HI//
  asm  xchg AL,AH                //
  asm  out  DX,AL                //
  asm  sub  DX,1                 //
  asm  add  DX,3                 //
  asm  mov  AL,07h               // CLR BAUD access...  N-8-2
  asm  out  DX,AL                //
  asm  out  DX,AL                // N-8-2
  asm  mov  DX,port_no           //0x3FC 0x2FC  modem control register
  asm  add  DX,5                 //check LINE_STATUS  0x2FD  0x3FD (+5)
xempty0:                         //
  asm  in   AL,DX                //
  asm  and  AL,060h              //wait for DXR & TXR to empty before RST!
  asm  cmp  AL,060h              //
  asm  jne  xempty0              //
}

//--------------------------------------------------------------------
UINT InitMonitor(void)
{
  int  i=10000;
  int  ans=inportb(pcom+LSR);
  int  byte_return;

  while(!(ans & DATA_READY) && i){  // data received?
	ans = inportb(pcom+LSR);
	i--;
  }
  if(i<1)
     return  0;
  if( inportb(pcom)!=KB_ESC)
      return 2;

   delay(1);
   UINT send=0xAA;               // test for reponse with random pattern
   WaitFor(XMT_BUF_EMPTY);       // wait for buff empty
   outportb(pcom,send);          // send a byte
   WaitFor(DATA_READY);          // wait for data received
   delay(1);
   if ((byte_return=inportb(pcom))!=send) {
       printf("\nbyte recieve = %x\n",byte_return);
       return 1;
   }
   WaitFor(XMT_BUF_EMPTY);       // wait for buff empty
   outportb(pcom,(send=KB_ESC)); // send a byte
   WaitFor(DATA_READY);          // wait for data received
   delay(1);
   if ((byte_return=inportb(pcom))==send)
       return 3;                // all tests are successful!
   return 1;
}

//--------------------------------------------------------------------
void reset50()
{
  UINT  port_no=pcom;
  if(prm.INVERSE) {               // do the inverse DTR for reset of c50
     asm  mov  DX,word ptr port_no//modem control register  02FC 03FC
     asm  add  DX,4               //
     asm  mov  AL,0xB             //RTS=1, DTR=0
     asm  out  DX,AL
     delay(1);
     asm  mov  DX,word ptr port_no//modem control register
     asm  add  DX,4               //
     asm  mov  AL,0xA             //RTS=1, DTR=0
     asm  out  DX,AL
     delay(1);
     asm  mov  DX,word ptr port_no//modem control register
     asm  add  DX,4               //
     asm  mov  AL,0xB             //RTS=1, DTR=0
     asm  out  DX,AL
     delay(1);
  }
  else  {                        // else we have a hardware negate function from PC to c50
     asm  mov  DX,word ptr port_no//modem control register
     asm  add  DX,4               //
     asm  mov  AL,0xA             //RTS=1, DTR=0
     asm  out  DX,AL
     delay(1);
     asm  mov  DX,word ptr port_no//modem control register
     asm  add  DX,4               //
     asm  mov  AL,0xB             //RTS=1, DTR=0
     asm  out  DX,AL
     delay(1);
     asm  mov  DX,word ptr port_no//modem control register
     asm  add  DX,4               //
     asm  mov  AL,0xA             //RTS=1, DTR=0
     asm  out  DX,AL
     delay(1);
  }
}

//--------------------------------------------------------------------
void BaudRateDetect()
{
 reset50();
 delay(12);        // v.02 ROM code need delay for boot loader

 if(prm.speed<57600){
    while(!(inportb(pcom+LSR) & XMT_BUF_EMPTY));
    outportb(pcom,0x80);    // write a byte to the com port (320c50)
 }
 else
    outportb(pcom,0x80);    // write a byte to the com port (320c50)
}
void WaitFor(UINT what)
{
 int j=10000,i=j;

 while(!(inportb(pcom+LSR) & what) && i--);

 if(i<1){
    fprintf(stdout,"Handshake error"
	    "\r\nWait loop finished in WaitFor() with start=%d",j);
    exit(1);
 }
 else return;
}

int screen(UINT x,UINT y,char *fmt,...)
{
 const MAXSCREENLEN=700;
 static char buffer[MAXSCREENLEN];
 va_list argptr;
 va_start(argptr,fmt);
 int cnt=vsprintf(buffer,fmt,argptr);
 va_end(argptr);
 gotoxy(x,y);
 cprintf(buffer);
 clreol();
 return cnt;
}

void sendbyte(UINT send)
{
  WaitFor(XMT_BUF_EMPTY);        // wait for buff empty

  outportb(pcom,send);           // send a byte

  WaitFor(DATA_READY);           // wait for data received
  delay(1);
  UINT receive=inportb(pcom);
  if (receive!=send)
      fprintf(stdout,"Handshake error"
		 "\r\nSent byte in 'sendbyte()' is not correct!\r\n"
		 "Sent    : 0x%02x   Received: 0x%02x\r\n",send,receive);
}

UINT sendword(UINT send)
{
 UINT   s1;

 WaitFor(XMT_BUF_EMPTY);          // wait for empty
 s1 = (send>>8)&0xff;
 outportb(pcom,s1);   // send high byte of end address

 WaitFor(DATA_READY);             // wait for data rec
 delay(1);
 UINT receive=inportb(pcom);

 WaitFor(XMT_BUF_EMPTY);
 s1 = send&0xff;
 outportb(pcom,s1);        // send low  byte of end address

 WaitFor(DATA_READY);             // wait for data rec
 delay(1);
 if((receive=(receive<<8)+inportb(pcom))!=send)
    fprintf(stdout,"Handshake error"
		 "\r\nSent word in sendword() is not correct!\r\n"
		 "Sent    : %04xh   Received: %04xh\r\n",send,receive);

 return receive; // return sent word for check if necessary
 }

//--------------------------------------------------------------------
//--- Load a program/data file in TI-Dsk Format: default ext. dsk   --
//--------------------------------------------------------------------
double LoadDsk(void)
{
 char    linebuf[MAXLINE], *pbuf=linebuf;
 UINT    line=0;        // line counter of file
 UINT    data[MAXLINE]; // max 100. words to download
 UINT    numdata=0;     // num of words to download
 ULONG   sumdata=0;     // sum of all downloaded words
 UINT    address;       // address for     download
 BOOLE   program;       // type: if program 'yes' , no if data 'no'

 clock_t start=clock();
 while(1) {                                    // for all lines
     pbuf=fgets(linebuf,MAXLINE,stream);

     switch(*pbuf){                            // analyse line
	case  ':':
	case NULL: fclose(stream);
		   fprintf(stdout,"\nLoading of prog/data finished");
		   double d=clock()-start;
		   return d>0 ? d : 0.001;
	case  'K': numdata=0;break;           // Do something with the name ?
	case  '9': address=GetDskAdd(pbuf+1); // DSK for an address
		   switch(*(pbuf+5))
		     {
		      case '7': break;        // Do nothing with checksum   ?
		      case 'M': program=NO; break;
		      case 'B': program=YES; break;
		      default : fprintf(stdout,"\n\nerror 1: 'Wrong Tag "
					"in Pos 6'!\n\n\rPlease check whether"
				   " the file is a valid *.dsk file!\n\n\r");
				return 0;
		     }
		   numdata=GetDskData(pbuf+5,data);
		   sumdata +=numdata;
		   break;
	case  '1': address=GetDskAdd(pbuf+1);          // Entry address
		   if(address==0)
		     break; // dska generates address=0 if no entry defined!

		   prm.PGM_CNT=prm.EntryPoint=address;
		   break;
	default  : fprintf(stdout,"\n\nerror 2: 'Wrong Tag in Pos 1' in LoadDsk()"
				"!\n\n\rPlease check whether"
				" the file is a valid *.dsk file!\n\n\r");
		   return 0;
       }

     if(numdata){                                    // download line
	UINT i,cmd=(program==YES) ? LP:LD;

	fprintf(stdout,"\r   %4d %5d %8ld  %s",
		     ++line,numdata,sumdata,program ? "program":"data");
	sendcommand(cmd,address,numdata);
	for(i=0;i<numdata;i++) sendword(data[i]);
     }
 }
}

//--------------------------------------------------------------------
UINT GetDskAdd(STRING pbuf)
{
 UINT x=0,i=4;
 char c=*pbuf++;
 for(;i;i--,c=*pbuf++)
   {
    x =(x<<4) + c;
    if(isdigit(c))
      x -= '0';
    else
      x -= 'A'-10;
   }
 return x;
}
//--------------------------------------------------------------------
UINT GetDskData(STRING pbuf,UINT *data)
{
 UINT x,num=0,i;
 UCHAR c;

 while(*(pbuf++)!='7')
   {
    for(*data=0,i=4;i;i--)
      {
       c = *pbuf++;
       *data<<=4;
       if(isdigit(c))
	 *data +=c-'0';
       else
	 *data +=c-'A'+10;
      }
     data++;
     num++;
   }

 return num;
}

void ExePgm(void)
{
 sendbyte(XG); sendword(prm.PGM_CNT);    // execute
 outportb(pcom,NULL);               // Startpulse / sync for windows/OS2 ??????
 return;
}
void setup_vals(void)
{
  setwritemode(0);                      // turn off XOR write
  setviewport(0,300,200,309,1);        // clear window
  clearviewport();                      //
  //--------Modify----------
  setviewport(0,getmaxy()-10,getmaxx(),getmaxy(),1);
  setcolor(WHITE);
  line(0,getmaxy()-10,getmaxx(),getmaxy());
  //------------------------
  setviewport(100,0,620,30,1);          // Write the title in yellow
  setcolor(14);
  settextstyle(0,0,2);
  outtextxy(60,10,"PC SPECTRUM ANALYZER");
  setviewport(0,30,620,300,1);// Write to window in bright blue 360
  setcolor(11);                         //
  settextstyle(0,0,0);
  outtextxy(10,33, "    +10dBm");
  outtextxy(10,59, "     +0dBm");
  outtextxy(10,72, " M       ");
  outtextxy(10,85, " A  -10dBm");
  outtextxy(10,98, " G       ");
  outtextxy(10,111," N  -20dBm");
  outtextxy(10,124," I       ");
  outtextxy(10,137," T  -30dBm");
  outtextxy(10,150," U       ");
  outtextxy(10,163," D  -40dBm");
  outtextxy(10,176," E       ");
  outtextxy(10,189,"    -50dBm");
  outtextxy(10,215,"    -60dBm");
  outtextxy(10,241,"    -70dBm");
  outtextxy(96,250,"DC");
  outtextxy(185,250," 950");
  outtextxy(285,250,"1900");
  outtextxy(385,250,"2850");
  outtextxy(485,250,"3800");
  outtextxy(585,250,"4750");
  outtextxy(224,260,"         Frequency (Hz)         ");
  outtextxy(100,290,"(Q)uit to DOS   ");   //
  //outtextxy(100,280,"(L)ine to Analysis 0");   //
  setviewport(500,460,639,479,1);
  setfillstyle(SOLID_FILL,LIGHTGRAY);
  bar(0,0,150,20);
  setcolor(BLUE);
  switch(avg_on)
  {
    case  1: outtextxy(20,5,"Average 2");break; //
    case  2: outtextxy(20,5,"Average 4");break; //
    case  3: outtextxy(20,5,"Average 8");break; //
    default: outtextxy(20,5,"Average 1");break; //
  }
  setviewport(200,330,285,440,1);
  setfillstyle(SOLID_FILL,BLACK);
  bar(0,0,65,100);
  setcolor(RED);
  //--------------------------------
  char *Dot = ".",*Zero="0",st1[20],st2[20];
  float Hz=(x_position1/step)*38.75;
  int temp1 = Hz;
  float temp2 = (Hz-temp1)*100;
  itoa(Hz,st1,10);
  itoa(temp2,st2,10);
  strcpy(string,st1);
  strcat(string,Dot);
  if (temp2<10) strcat(string,Zero);
  strcat(string,st2);
  outtextxy(0,30,string);
  //-------------------------------
  int dbtemp;
  float db=buf_0[(x_position1/step)-1];
  float dbp,TempdB;
  dbp=(db-77)*0.38;
  dbtemp=dbp;
  TempdB=(dbp-dbtemp)*100;
  itoa(dbtemp,st1,10);
  if (TempdB<0) TempdB = TempdB*(-1);
  itoa(TempdB,st2,10);
  strcpy(string,st1);
  strcat(string,Dot);
  if (TempdB<10) strcat(string,Zero);
  strcat(string,st2);
  //itoa(dbp,string,10);
  outtextxy(0,50,string);
  //----------------------
  setviewport(470,330,555,440,1);
  setfillstyle(SOLID_FILL,BLACK);
  bar(0,0,65,100);
  setcolor(YELLOW);
  //----------------------------
  float Hz1=(x_position/step)*38.75;
  int tmp1 = Hz1;
  float tmp2 = (Hz1-tmp1)*100;
  itoa(Hz1,st1,10);
  itoa(tmp2,st2,10);
  strcpy(string,st1);
  strcat(string,Dot);
  if (tmp2<10) strcat(string,Zero);
  strcat(string,st2);
  //---------------------------
  outtextxy(0,30,string);
  //*********************
  int dbtemp1;
  float db1=buf_0[(x_position/step)-1];
  float dbp1,TempdB1;
  dbp1=(db1-77)*0.38;
  dbtemp1=dbp1;
  TempdB1=(dbp1-dbtemp1)*100;
  itoa(dbtemp1,st1,10);
  if (TempdB1<0) TempdB1 = TempdB1*(-1);
  itoa(TempdB1,st2,10);
  strcpy(string,st1);
  strcat(string,Dot);
  if (TempdB1<10) strcat(string,Zero);
  strcat(string,st2);
  //*********************
  outtextxy(0,50,string);
}
void init_graphics(void)
{
  int gdriver = VGA/*EGA*/, gmode = VGAHI, errorcode, Y, X;
//  registerbgidriver(EGAVGA_driver);     // Use with BCC for no EGAVGA.BGI
  initgraph(&gdriver, &gmode, "");        // if possible open EGA mode
  errorcode = graphresult();
  if (errorcode != grOk)
  {
     printf("Graphics error: %s\n", grapherrormsg(errorcode));
     printf("Press any key to halt:");
     getch();
     exit(1);
  }
  clearviewport();                        //
  //-----------------------------
  settextstyle(0,0,0);
  setcolor(RED);
  outtextxy(100,340,"Line 1");
  outtextxy(100,360,"Frequency :          Hz");
  outtextxy(100,380,"Magnitude :          dBm");
  setcolor(YELLOW);
  outtextxy(370,340,"Line 2");
  outtextxy(370,360,"Frequency :          Hz");
  outtextxy(370,380,"Magnitude :          dBm");
  setfillstyle(SOLID_FILL,LIGHTGRAY);
  bar(0,460,639,479);
  settextstyle(2,0,0);
  setcolor(RED);outtextxy(5,465,"F1");
  setcolor(BLACK);outtextxy(20,465,"Line 1");
  setcolor(RED);outtextxy(65,465,"F2");
  setcolor(BLACK);outtextxy(80,465,"Line 2");
  setcolor(RED);outtextxy(125,465,"\x3c\x2d \x2d\x3e"); //Left & Right Arrow
  setcolor(BLACK);outtextxy(160,465,"Move Line");
  setcolor(RED);outtextxy(225,465,"F8");
  setcolor(BLACK);outtextxy(240,465,"Average");
  setcolor(RED);outtextxy(290,465,"F9");
  setcolor(BLACK);outtextxy(305,465,"Reset DSK");
  setcolor(RED);outtextxy(370,465,"F10");
  setcolor(BLACK);outtextxy(395,465,"Exit");
  //-------------------------------
  setup_vals();                           // dispaly the setup
  setviewport(100,40,600,274,1);          // Set window to show display
  setcolor(2);                            // reticle is green
  for(Y=0;Y<=234;Y+=26) line(0,Y,500,Y);  // draw reticle
  for(X=0;X<=500;X+=50) line(X,0,X,234);  //
  //-----------------------------------

  //------------------------------------
  setwritemode(1);                        // display lines are XOR drawn

  setcolor(15);                           // light gray

}

unsigned char Bcrcv(int port_no)
{
  unsigned char c;
  asm  mov  DX,word ptr port_no // RECV a character
  asm  add  DX,5                // check LINE_STATUS  0x2FD  0x3FD (+5)
  asm  mov  BX,4000             // 836 loops is marginal at 4800 baud.
chkst:                          // with 33MHz 486
  asm  sub  bx,1                //
  asm  jz   timerr              //
  asm  in   AL,DX               //
  asm  and  AL,061h             //
  asm  cmp  AL,061h             //
  asm  jne  chkst               // wait for DRR & RSR to fill
  asm  sub  DX,5                //
  asm  in   AL,DX               //
  asm  mov  byte ptr c,AL       //                                             ²
  return(c);                    //                                             ²
timerr:                         //                                             ²
  return(-1);                   //                                             ²
}
