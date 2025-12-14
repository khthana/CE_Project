#include <bios.h>
#include <conio.h>
#include <ctype.h>
#include <dos.h>
#include <graphics.h>
#include <math.h>
#include <mem.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
////////////////////////////////DEFINE  KEYS/////////////////////////////////
#define	 INS	20992
#define	 DEL	21248
#define  HOME   18176
#define  END    20224
#define  PU     18688
#define  PD     20736

#define  UP     18432
#define  DOWN   20480
#define  LEFT   19200
#define  RIGHT  19712

#define  SP     14624
#define  BS     3592
#define  ESC    283
#define  TAB    3849
#define  ENTER  7181

#define  F1    15104
#define  F2    15360
#define  F3    15616
#define  F4    15872
#define  F5    16128
#define  F6    16384
#define  F7    16640
#define  F8    16896
#define  F9    17152
#define  F10   17408
///////////////////////////////DEFINE  COLOR////////////////////////////////
#define  BLACK           0
#define  BLUE            1
#define  GREEN           2
#define  CYAN            3
#define  RED             4
#define  MAGENTA         5
#define  BROWN           6
#define  LIGHTGRAY       7
#define  DARKGRAY        8
#define  LIGHTBLUE       9
#define  LIGHTGREEN     10
#define  LIGHTCYAN      11
#define  LIGHTRED       12
#define  LIGHTMAGENTA   13
#define  YELLOW         14
#define  WHITE          15
///////////////////////////////DEFINE  VARIABLE//////////////////////////////
#define MAXSIZEX    1200    //
#define MAXSIZEY    1800    //
#define Xb  8              //
#define Yb  37             //
#define Xn  552            //
#define Yn  441            //

const innode   = 80;
const hidenode = 30;
const outnode  = 50;


struct BMPHEAD
{
 unsigned char id[2];	// file type : must be ASCII text "BM"
 long  filesize;	// Size of teh file : in double words (32 bit integers)
 int   reserved[2];	// Reserved for future use : must be zero
 long  headersize;	// byte offser to bitmap data : offset from the Bitmap file header (i.e,the startof the file)
 long  infosize;	// number of bytes in header : currenty 40 bytes
 long  width;		// width of bitmap : in pixels
 long  depth;		// height of bitmap : in pixels
 int   blplanes;	// number of color planese : must be set to 1
 int   bits;		// number of bits per pixel : valid choices are 1,4,8,24;if not 24,determines the size of the palette
 long  blcompression;   // type of compression : {0:no compression}{1:run legth 8 bits per pixel}{2:run legth 4 bits per pixel}
 long  bisizeimage;	// size of image : in byte
 long  bixpelspermeter;	// horizontal resolution : in pixels/meter
 long  biypelspermeter;	// vertical   resolution : in pixels/meter
 long  biclrused;	// number of color indexes used by the bitmap : zero indicates all color important
 long  biclrimportant;  // number of color indexes important for displaying bitmap : a value of size indicates all colors are important
}bmphead;

char *menu1 = " File :";
char *menu2 = "   Move         Select       Toggle Window        Exit";
char fname[30];

unsigned char   Tfont[256][20];
unsigned char huge buffer_image[MAXSIZEX/8][MAXSIZEY];

int   width;
int   StartpicX,StartpicY;   	//Startpoint display picture
int   MaxpicX,MaxpicY;          //Max value picture
int   XMAX,YMAX;

int xmaxc,xminc,ymaxc,yminc;
char arr[150][150];
unsigned int code[5];

float indata[innode],hidedata[hidenode],outdata[outnode];
float toutput[outnode];
float wt1[innode][hidenode],wt2[hidenode][outnode];

////////////////////////PROTOTYPE DECLARATION  SECTION///////////////////////
void screen();
void box(int x1,int y1,int x2,int y2, int color);
void board(int x1,int y1,int x2,int y2,int color1,int color2);
void topbox();
void downbox();
void sidebox();

void readfont(void);
void boxstr(int x,int y,int color,unsigned char *input, unsigned char *buff);
void showTfont(int x, int y, int color,unsigned char *fontthai);
int  sizeTfont(unsigned char *data);

void load();
int  read_image(char *st);
void show_image(int lft,int up,int rght,int dw,int color,int back);

void delchar();
unsigned char X0(int &x,int &y);
void contour(int &x,int &y);
void p_qcode();
void pcode();
void qcode();
void adjust_ground();
void change_ground(int a,int b,char c);
void show_ground();
void concentrade_code();
void find_con_code(unsigned int con_code[50][2]);

void train();
void check0d();
void save_code(unsigned int ch);
void backpropagation();
void set_weight();
void showtime(clock_t time);
void forward();
void showbar(int x);
int  check_error(int *flag);
void backward();

void recognize();
/////////////////////////////////////////////////////////////////////////////
/////
/////			      	 SCREEN
/////	void screen()
/////	void box(int x1,int y1,int x2,int y2, int color)
/////	void board(int x1,int y1,int x2,int y2,int color1,int color2)
/////	void topbox()
/////	void downbox()
/////	void sidebox()
/////
/////////////////////////////////////////////////////////////////////////////
void screen()
{
  XMAX = getmaxx();          /* get screen resolution values */
  YMAX = getmaxy();

  board(0,0,XMAX,YMAX,BLACK,WHITE);
  box(5,35,XMAX-85,YMAX-35,LIGHTGREEN);
  topbox();
  downbox();
  sidebox();
}

void box(int x1,int y1,int x2,int y2, int color)
{
  setcolor(color);
  line(x1,y1,x2,y1);    line(x2,y1,x2,y2);
  line(x1,y1,x1,y2);    line(x1,y2,x2,y2);
}

void board(int x1,int y1,int x2,int y2,int color1,int color2)
{
  setcolor(color2);
  line(x1,y1,x2,y1);    line(x2,y1,x2,y2);
  line(x1,y1,x1,y2);    line(x1,y2,x2,y2);
  setfillstyle(1,color1);
  bar(x1+2,y1+2,x2-2,y2-2);
}

void topbox()
{
  board(5,5,XMAX-5,30,GREEN,LIGHTGREEN);
  setcolor(BLUE);
  outtextxy(15,15,menu1);
  showTfont(80,8,RED,fname);
}

void downbox()
{
  board(5,YMAX-30,XMAX-5,YMAX-5,GREEN,LIGHTGREEN);
  setcolor(MAGENTA);
  outtextxy(50,YMAX-19,"Arrow");
  outtextxy(170,YMAX-19,"Enter");
  outtextxy(300,YMAX-19,"Tap");
  outtextxy(490,YMAX-19,"Esc");
  showTfont(70,YMAX-28,1,menu2);
}

void sidebox()
{
  board(XMAX-80,35,XMAX-5,YMAX-35,GREEN,LIGHTGREEN);
  setcolor(RED);
  outtextxy(XMAX-60,80,"Train");
  outtextxy(XMAX-60,110,"Load");
  outtextxy(XMAX-77,140,"Recognize");
  outtextxy(XMAX-60,170,"Setup");
}
/////////////////////////////////////////////////////////////////////////////
/////
/////			       THAI FONT
/////	void readfont(void)
/////   void boxstr(int x,int y,int color, --
/////                          -- unsigned char *input, unsigned char *buff)
/////	void showTfont(int x, int y, int color,unsigned char *fontthai)
/////	int  sizeTfont(unsigned char *data)
/////
/////////////////////////////////////////////////////////////////////////////
void readfont(void)
{
  FILE *fontfile;
  int x,y;
  unsigned char ch;

  fontfile = fopen("thai.fnt","rb");
  x = y = 0;
  rewind(fontfile);
  while (!feof(fontfile))   {
      fread(&ch,1,1,fontfile);
      Tfont[x][y] = ch;
      y++;
      if (y==20) {
	 y=0;
	 x++;
      }
    }
    fclose(fontfile);
}

void boxstr(int x,int y,int color,unsigned char *text, unsigned char *string)
{
  int cursor,key,i;
  unsigned c;
  unsigned char ch;

  cursor=0;
  board(x-90,y-2,x+148,y+22,CYAN,MAGENTA);
  showTfont(x-85,y,color,text);
  setcolor(YELLOW);
  outtextxy(x,y+9,"_");
  outtextxy(x,y+10,"_");
  outtextxy(x,y+11,"_");
  showTfont(x,y,color,string);

  do {
     key = bioskey(0);
     ch = (unsigned char)(key&(0x00ff));
     switch (key)
     {
	case SP:
		 strcpy(string,"");
		 cursor=0;
		 break;

	case LEFT:
		 if(sizeTfont(string)>0) if(cursor>0) cursor--;   // 72 down
		 break;

	case RIGHT:
		 if(cursor<sizeTfont(string)) cursor++;   // 80 up
		 break;

	case BS:
		 if(cursor>0)
		 cursor--;
		 if (sizeTfont(string)>0)
		  {
		    for(i=cursor;i<sizeTfont(string); i++)
		    string[i]=string[i+1];
		  }
		 break;

       case DEL:
		 if (sizeTfont(string)>0)
		  {
		    for(i=cursor;i<sizeTfont(string); i++)
		    string[i]=string[i+1];
		  }
		 break;

       default:
		 if(isprint(ch))
		 {
		   if (sizeTfont(string)>0)
		     {
		       for(i=sizeTfont(string);i>=cursor;i--)
		       string[i+1] = string[i];
		     }
		   else string[1]=NULL;
		   string[cursor] = ch;
		   cursor++;
		   break;
		 }
     }
     board(x-90,y-2,x+148,y+22,CYAN,MAGENTA);
     showTfont(x-85,y,color,text);
     showTfont(x,y,color,string);
     setcolor(YELLOW);
     outtextxy(x+(cursor*9),y+9,"_");
     outtextxy(x+(cursor*9),y+10,"_");
     outtextxy(x+(cursor*9),y+11,"_");
     }
  while ((key!=ENTER)&&(key!=ESC));
  board(x-90,y-2,x+148,y+22,BLACK,BLACK);
}

void showTfont(int x, int y, int color,unsigned char *string)
{
 int i,j,ch;
 int temp;

 temp = y;
 setcolor(color);
 for(i=0;i< strlen(string);i++)
  {
    ch = (int)(string[i])|0xff00;

    if((ch!='Ñ')&&(ch!='Ô')&&(ch!='Õ')&&(ch!='Ö')&&(ch!='×')&&(ch!='Ø')
      &&(ch!='Ù')&&(ch!='ç')&&(ch!='è')&&(ch!='é')&&(ch!='ê')&&(ch!='ë')
      &&(ch!='ì')) x+=9;
    ch=(unsigned char)ch;
    for(j=0;j<20;j++)
    {
      setlinestyle(USERBIT_LINE,Tfont[ch][j],1);
      line(x,y,x-7,y);
      y++;
    }
    y = temp;
    setlinestyle(0,2,2);
  }
}

int sizeTfont(unsigned char *string)
{
  int length=0,i,ch;

  for(i=0;i<strlen(string);i++)
  {
    ch = (int)(string[i])|0xff00;
    if((ch!='Ñ')&&(ch!='Ô')&&(ch!='Õ')&&(ch!='Ö')&&(ch!='×')&&(ch!='Ø')
      &&(ch!='Ù')&&(ch!='ç')&&(ch!='è')&&(ch!='é')&&(ch!='ê')&&(ch!='ë')
      &&(ch!='ì'))      length++;
  }
  return(length);
}
/////////////////////////////////////////////////////////////////////////////
/////
/////       			     LOAD
/////	void load()
/////	int  read_image(char *st)
/////	void show_image(int lft,int up,int rght,int dw,int color,int back)
/////
/////////////////////////////////////////////////////////////////////////////
void load()
{
  StartpicX=StartpicY=0;
  boxstr(200,100,WHITE,"FILE : ",fname);   // get file name
  setfillstyle(1,YELLOW);
  setcolor(RED);

  switch(read_image(fname))
   {
      case 1: board(110,98,348,122,CYAN,MAGENTA);
	      outtextxy(170,107,"File not Found !"); // file not found
	      getch();
	      board(5,35,XMAX-85,YMAX-35,BLACK,LIGHTGREEN);
	      show_image(StartpicX,StartpicY,MaxpicX,MaxpicY,BLACK,WHITE);
	      break;
      case 2: board(110,98,348,122,CYAN,MAGENTA);
	      outtextxy(175,107,"Not BMP File !");  // not bmp file
	      getch();
	      board(5,35,XMAX-85,YMAX-35,BLACK,LIGHTGREEN);
	      show_image(StartpicX,StartpicY,MaxpicX,MaxpicY,BLACK,WHITE);
	      break;
      case 3: board(110,98,348,122,CYAN,MAGENTA);
	      outtextxy(160,107,"Not 2 gray level !");  // not 2 gray level
	      getch();
	      board(5,35,XMAX-85,YMAX-35,BLACK,LIGHTGREEN);
	      show_image(StartpicX,StartpicY,MaxpicX,MaxpicY,BLACK,WHITE);
	      break;
      case 0: show_image(StartpicX,StartpicY,MaxpicX,MaxpicY,BLACK,WHITE);
	      topbox();
	      break;
   }
}

int  read_image(char *st)
{
  FILE *fbmp;

  if((fbmp=fopen(st,"rb"))==NULL)  return(1);   // can't open file

  fseek(fbmp,0,SEEK_SET);
  fread(&bmphead,sizeof(bmphead),1,fbmp);

  if(memcmp(bmphead.id,"BM",2))   // if not bitmap file return 2
  {
    fclose(fbmp);
    return(2);
  }

  if(bmphead.bits!=1)   // if not b/w color return 3
  {
    fclose(fbmp);
    return(3);
  }

  MaxpicX = (int)(bmphead.width)-2;
  MaxpicY = (int)(bmphead.depth)-2;

  width = bmphead.width/32;       //BitMap reserve 32 bit in times
  if(bmphead.width%32) width++;   //if don't enough increment 32 bit
  width<<=2;                      // 8*4 = 32 bit (get 8 bit in times must get 4 time)

  fseek(fbmp,bmphead.headersize,SEEK_SET);
  int x,y;
  for(y=MaxpicY+1;y>=0;--y)
    for(x=0;x<width;++x)
      buffer_image[x][y]=~fgetc(fbmp);

  fclose(fbmp);

  for(x=0;x<width;x++)
  {
    buffer_image[x][0] = 0;
    buffer_image[x][MaxpicY+1] = 0;
  }

  --width;
  for(y=0;y<=MaxpicY+1;y++)
  {
    buffer_image[0][y] &= (unsigned char)0x7f;
    buffer_image[width][y] &= (unsigned char)0x0fe;
  }

  ++width;
  return(0);
}

void show_image(int lft,int up,int rght,int dw,int color,int back)
{
  int x,y,ymax,xmax,l;
  board(5,35,XMAX-85,YMAX-35,BLACK,LIGHTGREEN);
  ymax = ((dw-up)>(Yn-Yb)) ? Yn :  dw-up+Yb;
  xmax = ((rght-lft)>(Xn-Xb)) ? Xn :  rght-lft+Xb;

  setfillstyle(1,back);
  bar(Xb,Yb,xmax,ymax);

  for(y=Yb;y<=ymax;++y,++up)
    for(x=Xb,l=lft;x<=xmax;++x,++l)
      if(buffer_image[(l/8)][up]&(0x80>>(l%8))) putpixel(x,y,color);
}
/////////////////////////////////////////////////////////////////////////////
/////
/////				P & Q CODE
/////		void delchar()
/////		unsigned char X0(int &x,int &y)
/////		void contour(int &x,int &y)
/////		void p_qcode()
/////		void pcode()
/////		void qcode()
/////		void adjust_ground()
/////		void change_ground(int a,int b,char c)
/////		void show_ground()
/////		void concentrade_code()
/////		void find_con_code(unsigned int con_code[50][2])
/////
/////////////////////////////////////////////////////////////////////////////
void delchar()
{for (int y=yminc;y<=ymaxc;y++)
   for (int x=xminc; x<=xmaxc; x++)
     {if (X0(x,y))
       buffer_image[(x/8)][y]=buffer_image[(x/8)][y]&(0x7F>>(x%8));
     }
}

unsigned char X0(int &x,int &y)
{if(buffer_image[(x/8)][y]&(0x80>>(x%8))) return(0x01);
   else return(0x00);
}

void contour(int &x,int &y)
{int Xold=x;  int Yold=y;  int direct=1;
 xmaxc=xminc=x; ymaxc=yminc=y;
 do{if(X0(x,y))
     {if (direct==1) {direct=4; y--;} else	//left
      if (direct==2) {direct=1; x++;} else
      if (direct==3) {direct=2; y++;} else
      if (direct==4) {direct=3; x--;}}
    else 					//right
     {if (direct==1) {direct=2; y++;} else
      if (direct==2) {direct=3; x--;} else
      if (direct==3) {direct=4; y--;} else
      if (direct==4) {direct=1; x++;}}
    if (xmaxc<x) xmaxc=x;
    if (ymaxc<y) ymaxc=y;
    if (xminc>x) xminc=x;
    if (yminc>y) yminc=y;
   }while ((Xold!=x)||(Yold!=y));
}

void p_qcode()
{if (((xmaxc-xminc)<150)&((ymaxc-yminc)<150))
  {for (int y=0;y<150;y++)
     for (int x=0;x<150;x++) arr[x][y]='0';   //setup array
   pcode();
   qcode();
   adjust_ground();
   show_ground();
   concentrade_code();
  }
}

void pcode()
{int p1,p2,p3,p4;
 for (int y=yminc;y<=ymaxc;y++)
  for (int x=xminc; x<=xmaxc; x++)
   {if (X0(x,y))
    {int x1=x+1,x2=x,x3=x-1;
     int y1=y+1,y2=y,y3=y-1;
     if (X0(x1,y2)&(x1<=xmaxc)) p1=1; else p1=0;
     if (X0(x2,y1)&(y1>=yminc)) p2=1; else p2=0;
     if (X0(x3,y2)&(x3>=xminc)) p3=1; else p3=0;
     if (X0(x2,y3)&(y3<=ymaxc)) p4=1; else p4=0;
     if ((1-p2*p4)*p1*p3==1) arr[x-xminc][y-yminc]='H';
     if ((1-p1*p3)*p2*p4==1) arr[x-xminc][y-yminc]='V';
     if ((1-p1*p3)*(1-p2*p4)==1) arr[x-xminc][y-yminc]='S';
     if (p1*p2*p3*p4==1) arr[x-xminc][y-yminc]='I';
    }
   }
}

void qcode()
{int p1,p2,p3,p4;
 for (int y=yminc;y<=ymaxc;y++)
  for (int x=xminc; x<=xmaxc; x++)
   {if (X0(x,y))
     {/*nothing*/}
    else
     {int tempx = x; int tempy = y;
      p1=p2=p3=p4=0;

      do {x=x++; if (X0(x,y)) p1=1;} while (x<xmaxc); x=tempx; y=tempy;
      do {y=y--; if (X0(x,y)) p2=1;} while (y>yminc); x=tempx; y=tempy;
      do {x=x--; if (X0(x,y)) p3=1;} while (x>xminc); x=tempx; y=tempy;
      do {y=y++; if (X0(x,y)) p4=1;} while (y<ymaxc); x=tempx; y=tempy;

      if ((8*p1)+(4*p2)+(2*p3)+(p4)==3)  arr[x-xminc][y-yminc]='3';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==5)  arr[x-xminc][y-yminc]='5';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==6)  arr[x-xminc][y-yminc]='6';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==7)  arr[x-xminc][y-yminc]='7';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==9)  arr[x-xminc][y-yminc]='9';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==10) arr[x-xminc][y-yminc]='A';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==11) arr[x-xminc][y-yminc]='B';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==12) arr[x-xminc][y-yminc]='C';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==13) arr[x-xminc][y-yminc]='D';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==14) arr[x-xminc][y-yminc]='E';
      if ((8*p1)+(4*p2)+(2*p3)+(p4)==15) arr[x-xminc][y-yminc]='F';
     }
   }
}

void adjust_ground()
{int p1,p2,p3,p4;
 for (int i=0;i<150;i++)
  for (int j=0;j<150;j++)
   {if (arr[j][i]=='F')
     {p1=arr[j+1][i]; p2=arr[j][i-1]; p3=arr[j-1][i]; p4=arr[j][i+1];
      if((p1=='5')||(p2=='5')||(p3=='5')||(p4=='5')) change_ground(j,i,'5');
      if((p1=='7')||(p2=='7')||(p3=='7')||(p4=='7')) change_ground(j,i,'7');
      if((p1=='A')||(p2=='A')||(p3=='A')||(p4=='A')) change_ground(j,i,'A');
      if((p1=='B')||(p2=='B')||(p3=='B')||(p4=='B')) change_ground(j,i,'B');
      if((p1=='D')||(p2=='D')||(p3=='D')||(p4=='D')) change_ground(j,i,'D');
      if((p1=='E')||(p2=='E')||(p3=='E')||(p4=='E')) change_ground(j,i,'E');
     }
   }
}

void change_ground(int a,int b,char c)
{arr[a][b]=c;
 if (arr[a+1][b]=='F')   {arr[a+1][b]=c;   change_ground(a+1,b,c);}
 if (arr[a+1][b-1]=='F') {arr[a+1][b-1]=c; change_ground(a+1,b-1,c);}
 if (arr[a][b-1]=='F')   {arr[a][b-1]=c;   change_ground(a,b-1,c);}
 if (arr[a-1][b-1]=='F') {arr[a-1][b-1]=c; change_ground(a-1,b-1,c);}
 if (arr[a-1][b]=='F')   {arr[a-1][b]=c;   change_ground(a-1,b,c);}
 if (arr[a-1][b+1]=='F') {arr[a-1][b+1]=c; change_ground(a-1,b+1,c);}
 if (arr[a][b+1]=='F')   {arr[a][b+1]=c;   change_ground(a,b+1,c);}
 if (arr[a+1][b+1]=='F') {arr[a+1][b+1]=c; change_ground(a+1,b+1,c);}
}

void show_ground()
{board(100,YMAX-350,XMAX-190,YMAX-150,BLUE,MAGENTA);
 int Xc=120; int Yc=150;
 for (int i=0;i<150;i++)
  for (int j=0;j<150;j++)
   {if (arr[j][i]=='H') putpixel(j+Xc,i+Yc,8);
    else if (arr[j][i]=='V') putpixel(j+Xc,i+Yc,4);
    else if (arr[j][i]=='S') putpixel(j+Xc,i+Yc,2);
    else if (arr[j][i]=='I') putpixel(j+Xc,i+Yc,1);
    else if (arr[j][i]=='0') putpixel(j+Xc,i+Yc,0);
    else if (arr[j][i]=='1') putpixel(j+Xc,i+Yc,0);
    else if (arr[j][i]=='2') putpixel(j+Xc,i+Yc,0);
    else if (arr[j][i]=='3') putpixel(j+Xc,i+Yc,3);
    else if (arr[j][i]=='4') putpixel(j+Xc,i+Yc,0);
    else if (arr[j][i]=='5') putpixel(j+Xc,i+Yc,5);
    else if (arr[j][i]=='6') putpixel(j+Xc,i+Yc,6);
    else if (arr[j][i]=='7') putpixel(j+Xc,i+Yc,7);
    else if (arr[j][i]=='8') putpixel(j+Xc,i+Yc,0);
    else if (arr[j][i]=='9') putpixel(j+Xc,i+Yc,9);
    else if (arr[j][i]=='A') putpixel(j+Xc,i+Yc,10);
    else if (arr[j][i]=='B') putpixel(j+Xc,i+Yc,11);
    else if (arr[j][i]=='C') putpixel(j+Xc,i+Yc,12);
    else if (arr[j][i]=='D') putpixel(j+Xc,i+Yc,13);
    else if (arr[j][i]=='E') putpixel(j+Xc,i+Yc,14);
    else if (arr[j][i]=='F') putpixel(j+Xc,i+Yc,15);
   }
 box(119,149,271,301,WHITE);
}

void concentrade_code()
{int p1,p2,p3,p4,p5;
 unsigned int con_code[100][2];                //concentrade code 50 value

 for (int i=0;i<2;i++)
  for (int j=0;j<100;j++) con_code[j][i]=0;    //set concentrade code

 find_con_code(con_code);

 unsigned int tcode[5];

 for (int b=0; b<5;b++)			      //sort 5 value con_code
  {int index,temp=0;
   for (int a=0;a<100;a++)
    if (con_code[a][1]>temp) {temp=con_code[a][1]; index=a;}
   tcode[b]=con_code[index][0];
   con_code[index][1]=0;
  }


 for (b=0; b<5;b++)			      //sort 5 value con_code
  {int index,temp=0;
   for (int a=0;a<5;a++)
    if (tcode[a]>temp) {temp=tcode[a]; index=a;}
   code[b]=tcode[index];
   tcode[index]=0;
  }
}

void find_con_code(unsigned int con_code[100][2])
{for (int i=0;i<150;i++)  		//concetrade code
  for (int j=0;j<150;j++)

   if (arr[j][i]!='0')
    {int p1,p2,p3,p4,p5;
     p1=p2=p3=p4=p5=0;

     if((arr[j][i]=='S')||(arr[j][i]=='H')||(arr[j][i]=='V')||(arr[j][i]=='I'))
      {///////////////find p1 to p5 in font/////////////////
       p5=arr[j][i];                 	//find p5
       int tempx=j; int tempy=i;

       do{j=j++;
	  if((arr[j][i]!='S')&(arr[j][i]!='H')&(arr[j][i]!='V')&(arr[j][i]!='I'))
	   {p1=arr[j][i]; j=150;}       //find p1
	 }while (j<150);
       j = tempx; i = tempy;

       do{i=i--;
	  if((arr[j][i]!='S')&(arr[j][i]!='H')&(arr[j][i]!='V')&(arr[j][i]!='I'))
	   {p2=arr[j][i]; i=0;}         //find p2
	 }while (i>0);
       j = tempx; i = tempy;

       do{j=j--;
	  if((arr[j][i]!='S')&(arr[j][i]!='H')&(arr[j][i]!='V')&(arr[j][i]!='I'))
	   {p3=arr[j][i]; j=0;}         //find p3
	 }while (j>0);
       j = tempx; i = tempy;

       do{i=i++;
	  if((arr[j][i]!='S')&(arr[j][i]!='H')&(arr[j][i]!='V')&(arr[j][i]!='I'))
	   {p4=arr[j][i]; i=150;}       //find p4
	 }while (i<150);
       j = tempx; i = tempy;
      }
     else         			//find p1 to p5 in ground
      {p5=arr[j][i];                    //find p5
       int tempx=j; int tempy=i; int flag;

       flag=0;
       do{j=j++;
	  if((arr[j][i]=='S')|(arr[j][i]=='H')|(arr[j][i]=='V')|(arr[j][i]=='I')) flag=1;
	  if((arr[j][i]!='S')&(arr[j][i]!='H')&(arr[j][i]!='V')&(arr[j][i]!='I')&(flag==1))
	   {p1=arr[j][i]; j=150;}	//find p1
	 }while (j<150);
       j = tempx; i = tempy;

       flag=0;
       do{i=i--;
	  if((arr[j][i]=='S')|(arr[j][i]=='H')|(arr[j][i]=='V')|(arr[j][i]=='I')) flag=1;
	  if((arr[j][i]!='S')&(arr[j][i]!='H')&(arr[j][i]!='V')&(arr[j][i]!='I')&(flag==1))
	   {p2=arr[j][i]; i=0;}         //find p2
	 }while (i>0);
       j = tempx; i = tempy;

       flag=0;
       do{j=j--;
	  if((arr[j][i]=='S')|(arr[j][i]=='H')|(arr[j][i]=='V')|(arr[j][i]=='I')) flag=1;
	  if((arr[j][i]!='S')&(arr[j][i]!='H')&(arr[j][i]!='V')&(arr[j][i]!='I')&(flag==1))
	   {p3=arr[j][i]; j=0;}         //find p3
	 }while (j>0);
       j = tempx; i = tempy;

       flag=0;
       do{i=i++;
	  if((arr[j][i]=='S')|(arr[j][i]=='H')|(arr[j][i]=='V')|(arr[j][i]=='I')) flag=1;
	  if((arr[j][i]!='S')&(arr[j][i]!='H')&(arr[j][i]!='V')&(arr[j][i]!='I')&(flag==1))
	   {p4=arr[j][i]; i=150;}       //find p4
	 }while (i<150);
       j = tempx; i = tempy;
      }
///////////declease 5 byte to 4 byte///////////////////
     int arr16[16];
     for (int a=0;a<16;a++) arr16[a]=0;

     if (p1=='0') {arr16[1]=0; arr16[2]=0; arr16[0]=0;}
     if (p1=='I') {arr16[1]=0; arr16[2]=0; arr16[0]=1;}
     if (p1=='S') {arr16[1]=0; arr16[2]=0; arr16[0]=0;}
     if (p1=='3') {arr16[1]=0; arr16[2]=0; arr16[0]=1;}
     if (p1=='V') {arr16[1]=0; arr16[2]=1; arr16[0]=0;}
     if (p1=='5') {arr16[1]=0; arr16[2]=1; arr16[0]=1;}
     if (p1=='6') {arr16[1]=0; arr16[2]=1; arr16[0]=0;}
     if (p1=='7') {arr16[1]=0; arr16[2]=1; arr16[0]=1;}
     if (p1=='H') {arr16[1]=1; arr16[2]=0; arr16[0]=0;}
     if (p1=='9') {arr16[1]=1; arr16[2]=0; arr16[0]=1;}
     if (p1=='A') {arr16[1]=1; arr16[2]=0; arr16[0]=0;}
     if (p1=='B') {arr16[1]=1; arr16[2]=0; arr16[0]=1;}
     if (p1=='C') {arr16[1]=1; arr16[2]=1; arr16[0]=0;}
     if (p1=='D') {arr16[1]=1; arr16[2]=1; arr16[0]=1;}
     if (p1=='E') {arr16[1]=1; arr16[2]=1; arr16[0]=0;}
     if (p1=='F') {arr16[1]=1; arr16[2]=1; arr16[0]=1;}

     if (p2=='0') {arr16[3]=0; arr16[4]=0; arr16[5]=0;}
     if (p2=='I') {arr16[3]=0; arr16[4]=0; arr16[5]=0;}
     if (p2=='S') {arr16[3]=0; arr16[4]=0; arr16[5]=1;}
     if (p2=='3') {arr16[3]=0; arr16[4]=0; arr16[5]=1;}
     if (p2=='V') {arr16[3]=0; arr16[4]=1; arr16[5]=0;}
     if (p2=='5') {arr16[3]=0; arr16[4]=1; arr16[5]=0;}
     if (p2=='6') {arr16[3]=0; arr16[4]=1; arr16[5]=1;}
     if (p2=='7') {arr16[3]=0; arr16[4]=1; arr16[5]=1;}
     if (p2=='H') {arr16[3]=1; arr16[4]=0; arr16[5]=0;}
     if (p2=='9') {arr16[3]=1; arr16[4]=0; arr16[5]=0;}
     if (p2=='A') {arr16[3]=1; arr16[4]=0; arr16[5]=1;}
     if (p2=='B') {arr16[3]=1; arr16[4]=0; arr16[5]=1;}
     if (p2=='C') {arr16[3]=1; arr16[4]=1; arr16[5]=0;}
     if (p2=='D') {arr16[3]=1; arr16[4]=1; arr16[5]=0;}
     if (p2=='E') {arr16[3]=1; arr16[4]=1; arr16[5]=1;}
     if (p2=='F') {arr16[3]=1; arr16[4]=1; arr16[5]=1;}

     if (p3=='0') {arr16[6]=0; arr16[7]=0; arr16[8]=0;}
     if (p3=='I') {arr16[6]=0; arr16[7]=0; arr16[8]=1;}
     if (p3=='S') {arr16[6]=0; arr16[7]=1; arr16[8]=0;}
     if (p3=='3') {arr16[6]=0; arr16[7]=1; arr16[8]=1;}
     if (p3=='V') {arr16[6]=1; arr16[7]=0; arr16[8]=0;}
     if (p3=='5') {arr16[6]=1; arr16[7]=0; arr16[8]=1;}
     if (p3=='6') {arr16[6]=1; arr16[7]=1; arr16[8]=0;}
     if (p3=='7') {arr16[6]=1; arr16[7]=1; arr16[8]=1;}
     if (p3=='H') {arr16[6]=0; arr16[7]=0; arr16[8]=0;}
     if (p3=='9') {arr16[6]=0; arr16[7]=0; arr16[8]=1;}
     if (p3=='A') {arr16[6]=0; arr16[7]=1; arr16[8]=0;}
     if (p3=='B') {arr16[6]=0; arr16[7]=1; arr16[8]=1;}
     if (p3=='C') {arr16[6]=1; arr16[7]=0; arr16[8]=0;}
     if (p3=='D') {arr16[6]=1; arr16[7]=0; arr16[8]=1;}
     if (p3=='E') {arr16[6]=1; arr16[7]=1; arr16[8]=0;}
     if (p3=='F') {arr16[6]=1; arr16[7]=1; arr16[8]=1;}

     if (p4=='0') {arr16[11]=0; arr16[9]=0; arr16[10]=0;}
     if (p4=='I') {arr16[11]=0; arr16[9]=0; arr16[10]=1;}
     if (p4=='S') {arr16[11]=0; arr16[9]=1; arr16[10]=0;}
     if (p4=='3') {arr16[11]=0; arr16[9]=1; arr16[10]=1;}
     if (p4=='V') {arr16[11]=0; arr16[9]=0; arr16[10]=0;}
     if (p4=='5') {arr16[11]=0; arr16[9]=0; arr16[10]=1;}
     if (p4=='6') {arr16[11]=0; arr16[9]=1; arr16[10]=0;}
     if (p4=='7') {arr16[11]=0; arr16[9]=1; arr16[10]=1;}
     if (p4=='H') {arr16[11]=1; arr16[9]=0; arr16[10]=0;}
     if (p4=='9') {arr16[11]=1; arr16[9]=0; arr16[10]=1;}
     if (p4=='A') {arr16[11]=1; arr16[9]=1; arr16[10]=0;}
     if (p4=='B') {arr16[11]=1; arr16[9]=1; arr16[10]=1;}
     if (p4=='C') {arr16[11]=1; arr16[9]=0; arr16[10]=0;}
     if (p4=='D') {arr16[11]=1; arr16[9]=0; arr16[10]=1;}
     if (p4=='E') {arr16[11]=1; arr16[9]=1; arr16[10]=0;}
     if (p4=='F') {arr16[11]=1; arr16[9]=1; arr16[10]=1;}

     if (p5=='0') {arr16[12]=0; arr16[13]=0; arr16[14]=0; arr16[15]=0;}
     if (p5=='I') {arr16[12]=0; arr16[13]=0; arr16[14]=0; arr16[15]=1;}
     if (p5=='S') {arr16[12]=0; arr16[13]=0; arr16[14]=1; arr16[15]=0;}
     if (p5=='3') {arr16[12]=0; arr16[13]=0; arr16[14]=1; arr16[15]=1;}
     if (p5=='V') {arr16[12]=0; arr16[13]=1; arr16[14]=0; arr16[15]=0;}
     if (p5=='5') {arr16[12]=0; arr16[13]=1; arr16[14]=0; arr16[15]=1;}
     if (p5=='6') {arr16[12]=0; arr16[13]=1; arr16[14]=1; arr16[15]=0;}
     if (p5=='7') {arr16[12]=0; arr16[13]=1; arr16[14]=1; arr16[15]=1;}
     if (p5=='H') {arr16[12]=1; arr16[13]=0; arr16[14]=0; arr16[15]=0;}
     if (p5=='9') {arr16[12]=1; arr16[13]=0; arr16[14]=0; arr16[15]=1;}
     if (p5=='A') {arr16[12]=1; arr16[13]=0; arr16[14]=1; arr16[15]=0;}
     if (p5=='B') {arr16[12]=1; arr16[13]=0; arr16[14]=1; arr16[15]=1;}
     if (p5=='C') {arr16[12]=1; arr16[13]=1; arr16[14]=0; arr16[15]=0;}
     if (p5=='D') {arr16[12]=1; arr16[13]=1; arr16[14]=0; arr16[15]=1;}
     if (p5=='E') {arr16[12]=1; arr16[13]=1; arr16[14]=1; arr16[15]=0;}
     if (p5=='F') {arr16[12]=1; arr16[13]=1; arr16[14]=1; arr16[15]=1;}

/////////change value from binary to char/////////////
     unsigned int c_code=0;
     int flag,index;
     for (a=0;a<16;a++) c_code=(c_code*2)+arr16[a];

     flag=0;
     for (a=0;a<100;a++)
      if (con_code[a][0]==c_code) {con_code[a][1]++; flag=1;}

     if (flag==0) 			//new value
      {int temp=100;
       for (a=0;a<100;a++)
	if (temp>con_code[a][1]) {temp=con_code[a][1]; index=a;}
       con_code[index][0]=c_code;
       con_code[index][1]=1;
      }
     }
}
/////////////////////////////////////////////////////////////////////////////
/////
/////
/////
/////////////////////////////////////////////////////////////////////////////