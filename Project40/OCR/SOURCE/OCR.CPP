#include "HEADER.CPP"
float error    = 10;
/////////////////////////////////////////////////////////////////////////////
/////
/////			   	    TRAIN
/////   	void train()
/////		void check0d()
/////		void save_code(char ch)
/////		void backpropagation()
/////           void set_weight()
/////		void showtime(clock_t time)
/////		void forward()
/////		void showbar(int x)
/////		int  check_error(int *flag)
/////		void backward()
/////
/////////////////////////////////////////////////////////////////////////////
void train()
{unsigned int ch,c;
 for(int y=1;y<=MaxpicY;y++)
  for(int x=1;x<=MaxpicX;x++)
   {if(X0(x,y))
     {contour(x,y);
      if (((xmaxc-xminc)>10)&((ymaxc-yminc)>10))
      {p_qcode();
       outtextxy(285,YMAX-255,"This Charecter is");
       do{ch = getche();
	  if (ch!='\x1B')    	//save to file "code.txt"
	   {char *ascii;
	    *ascii=ch;
	    showTfont(400,YMAX-200,WHITE,ascii);
	    c = getche();
	    if (c=='\r') save_code(ch);
	      else {setcolor(BLUE); bar(370,YMAX-230,422,YMAX-170);
		   setcolor(WHITE);}
	   } else {c='\r';}
	 }while(c!='\r');
      }
      delchar();
      if (((xmaxc-xminc)>10)&((ymaxc-yminc)>10))
	show_image(StartpicX,StartpicY,MaxpicX,MaxpicY,BLACK,WHITE);
     }
   }
 board(5,35,XMAX-85,YMAX-35,BLACK,LIGHTGREEN);
 board(100,YMAX-350,XMAX-190,YMAX-150,BLUE,WHITE);
 setcolor(WHITE);
 outtextxy(240,YMAX-300,"Train ...");

 clock_t start, end,time;
 start = clock();

 backpropagation();

 end = clock();
 time = (end - start) / CLK_TCK;
 showtime(time);
 getche();
 board(5,35,XMAX-85,YMAX-35,BLACK,LIGHTGREEN);
}

void save_code(unsigned int ch)
{FILE *fp;
 unsigned int as[33];

 fp = fopen("code.txt","a+");
 ch=ch-160;
 as[32]=10;
 as[31]=ch%10+48;
 as[30]=ch/10+48;
 int b=0;
 for(int a=0; a<5; a++)
  {as[b]=(code[a]/10000)+48;     b++;
   as[b]=((code[a]/1000)%10)+48; b++;
   as[b]=((code[a]/100)%10)+48;  b++;
   as[b]=((code[a]/10)%10)+48;   b++;
   as[b]=code[a]%10+48;          b++;
   as[b]=' ';                    b++;
  }
 for (a=0; a<33; a++) fputc(as[a],fp);
 fclose(fp);
}

void backpropagation()
{int flag,count=0,x=0;
 FILE *fp;
 unsigned char as[33];
 struct con_code_type{unsigned int code[5];
		      unsigned int ascii;
		     }con_code;


 set_weight();
 do{showbar(count);
    if (x==1) count--; else count++;
    if (count==45) x=1;
    if (count==0)  x=0;

    flag=0;
    fp = fopen("code.txt","r");
    while (!feof(fp))
     {fread(&as,33,1,fp);
      int b=0;
      for (int a=0; a<5; a++)
       {con_code.code[a]=(as[b]-48)*10000; 		    b++;
	con_code.code[a]=con_code.code[a]+(as[b]-48)*1000;  b++;
	con_code.code[a]=con_code.code[a]+(as[b]-48)*100;   b++;
	con_code.code[a]=con_code.code[a]+(as[b]-48)*10;    b++;
	con_code.code[a]=con_code.code[a]+(as[b]-48);       b++; b++;
       }
      con_code.ascii=(as[30]-48)*10;
      con_code.ascii=con_code.ascii+(as[31]-48);

      int x3=innode-1;
      for (int x2=4; x2>-1; x2--)
       {unsigned int c_code=con_code.code[x2];
       for (int x1=15; x1>-1; x1--)
	 {if (c_code%2==0) indata[x3]=0; else indata[x3]=1;
	      c_code=c_code/2;
	      x3--;}}

      for (int x1=outnode-1; x1>-1; x1--) toutput[x1]=0;
      toutput[con_code.ascii] = 1;

      do{forward();
	}while(check_error(&flag));
     }
    fclose(fp);
   }while (flag);
}

void set_weight()
{for(int i=0; i<innode; i++)
  for(int j=0; j<hidenode; j++)
   {wt1[i][j] = 0.5*(1.0-random(100)/51.0);}
 for(i=0; i<hidenode; i++)
  for(j=0; j<outnode; j++)
   {wt2[i][j] = 0.5*(1.0-random(100)/51.0);}
}

void showtime(clock_t time)
{char str[14];
 char ch;
 ch=time/360000; if (ch==0) str[0]=' '; else str[0]=ch+48;
 time=time-360000*ch;
 ch=time/36000;  str[1]=ch+48;  time=time-36000*ch;
 ch=time/3600;   str[2]=ch+48;  time=time-3600*ch;
 str[3]=' ';     str[4]=':';    str[5]=' ';
 ch=time/600;    str[6]=ch+48;  time=time-600*ch;
 ch=time/60;     str[7]=ch+48;  time=time-60*ch;
 str[8]=' ';     str[9]=':';    str[10]=' ';
 ch=time/10;     str[11]=ch+48; time=time-10*ch;
 ch=time;        str[12]=ch+48; str[13]='\0';
 board(100,YMAX-350,XMAX-190,YMAX-150,BLUE,WHITE);
 setcolor(WHITE);
 outtextxy(210,YMAX-300,"Success Training !");
 outtextxy(235,YMAX-255,"Total Time");
 outtextxy(220,YMAX-205,str);
}

void showbar(int x)
{board(150,YMAX-255,XMAX-240,YMAX-245,BLUE,YELLOW);
 setfillstyle(1,RED);
 bar(152+x*5,YMAX-253,172+x*5,YMAX-247);
}

void forward()
{float sum;
 for (int a=0; a<hidenode; a++)
  {sum=0;
   for (int b=0; b<innode; b++) sum=sum+wt1[b][a]*indata[b];
   hidedata[a]=1.0 / (1.0 + exp(-sum));
  }

 for (a=0; a<outnode; a++)
  {sum=0;
   for (int b=0; b<hidenode; b++) sum=sum+wt2[b][a]*hidedata[b];
   outdata[a]=1.0 / (1.0 + exp(-sum));
  }
}

int check_error(int *flag)
{double err[outnode];
 double sum;

 for (int a=0; a<outnode; a++) err[a]=toutput[a]-outdata[a];
 for (a=0; a<outnode; a++) err[a]=pow(err[a],2.0);
 sum=0;
 for (a=0; a<outnode; a++) sum=sum+err[a];
 sum=sum*100;
 if (sum<error) return(0);
  else {*flag=1; backward(); return(1);}
}

void backward()
{for (int a=0; a<outnode; a++)
  for (int b=0; b<hidenode; b++)
    {float R=(outdata[a])*(1-outdata[a])*(toutput[a]-outdata[a]);
     wt2[b][a]=wt2[b][a]+(0.7*R*hidedata[b]);
    }

 for (a=0; a<hidenode; a++)
  for (b=0; b<innode; b++)
    {float S=0;
     for (int c=0; c<outnode; c++)
       S=S+wt2[a][c]*((outdata[c])*(1-outdata[c])*(toutput[c]-outdata[c]));
     float R=(hidedata[a])*(1-hidedata[a])*(S);
     wt1[b][a]=wt1[b][a]+(0.7*R*indata[b]);
    }
}
/////////////////////////////////////////////////////////////////////////////
/////
/////				RECOGNIZE
/////	void recognize()
/////
/////////////////////////////////////////////////////////////////////////////
void recognize()
{clock_t start, end,time;
 start = clock();

 for(int y=1;y<=MaxpicY;y++)
   for(int x=1;x<=MaxpicX;x++)
     {if(X0(x,y))
       {contour(x,y);
	if (((xmaxc-xminc)>10)&((ymaxc-yminc)>10))
	 {p_qcode();
	  outtextxy(285,YMAX-255,"This Charecter is");
	  int x3=innode-1;
	  for (int x2=4; x2>-1; x2--)
	   for (int x1=15; x1>-1; x1--)
	    {if (code[x2]%2==0) indata[x3]=0; else indata[x3]=1;
		 code[x2]=code[x2]/2;
		 x3--;}

	  forward();

	  float ch=0;
	  int index;
	  for (x3=0; x3<outnode; x3++)
	    if (outdata[x3]>ch) {ch=outdata[x3]; index=x3;}

	  index=index+160;
	  int x=400,y=YMAX-200;
	  for(int j=0;j<20;j++)
	   {setlinestyle(USERBIT_LINE,Tfont[index][j],1);
	    line(x,y,x-7,y);
	    y++;
	   }
	  setlinestyle(0,2,2);
	  delay(1000);
	 }
	delchar();
	if (((xmaxc-xminc)>10)&((ymaxc-yminc)>10))
	   show_image(StartpicX,StartpicY,MaxpicX,MaxpicY,BLACK,WHITE);
       }
     }
 end = clock();
 time = (end - start) / CLK_TCK;
 board(5,35,XMAX-85,YMAX-35,BLACK,LIGHTGREEN);
 showtime(time);
 getche();
 board(5,35,XMAX-85,YMAX-35,BLACK,LIGHTGREEN);
}
/////////////////////////////////////////////////////////////////////////////
/////
/////				MAIN PROGRAM
/////		void set()
/////		void operation(unsigned status,unsigned flag)
/////		void main()
/////
/////////////////////////////////////////////////////////////////////////////
void set()
{int a[2],err;
 char ch;
 board(100,YMAX-350,XMAX-190,YMAX-150,BLUE,WHITE);
 setcolor(YELLOW);
 outtextxy(175,YMAX-255,"Error Value (10-99) : __");
 ch=getche();
 a[0]=ch;
 int x=357,y=YMAX-267;
 for(int j=0;j<20;j++)
  {setlinestyle(USERBIT_LINE,Tfont[ch][j],1);
   line(x,y,x-7,y);
   y++;
  }
 ch=getche();
 a[1]=ch;
 x=365,y=YMAX-267;
 for(j=0;j<20;j++)
  {setlinestyle(USERBIT_LINE,Tfont[ch][j],1);
   line(x,y,x-7,y);
   y++;
  }
 setlinestyle(0,2,2);
 err=(a[0]-48)*10+(a[1]-48);
 if ((err>9)&(err<100)) error=err;
 delay(500);
 board(5,35,XMAX-85,YMAX-35,BLACK,LIGHTGREEN);
}

/*void loadweight()
{
}

void saveweight()
{unsigned char x;
 float y;
 FILE *fp;

 fp = fopen("weight.txt","w");
 for (int a=0; a<innode; a++)
  {for (int b=0; b<hidenode; b++)
     {y=wt1[a][b];
//      x=y; y<<=8; fputc(x+48,fp);
//      x=y; y<<=8; fputc(x+48,fp);
//      x=y; y<<=8; fputc(x+48,fp);
//      x=y; y<<=8; fputc(x+48,fp); fputc(' ',fp);
     }fputc('\x0a',fp);
  }
 fclose(fp);
}*/

void operation(unsigned status,unsigned flag)
{if (status>7) {sidebox();
		show_image(StartpicX,StartpicY,MaxpicX,MaxpicY,WHITE,BLACK);
		box(5,35,XMAX-85,YMAX-35,WHITE);}

  else {box(5,35,XMAX-85,YMAX-35,LIGHTGREEN);
	sidebox();
	box(XMAX-80,35,XMAX-5,YMAX-35,WHITE);
	if (status==0){board(XMAX-78,70,XMAX-7,100,RED,WHITE);
		       setcolor(15);
		       outtextxy(XMAX-60,80,"Train");}
	if (status==1){board(XMAX-78,100,XMAX-7,130,RED,WHITE);
		       setcolor(15);
		       outtextxy(XMAX-60,110,"Load");}
	if (status==2){board(XMAX-78,130,XMAX-7,160,RED,WHITE);
		       setcolor(15);
		       outtextxy(XMAX-77,140,"Recognize");}
	if (status==3){board(XMAX-78,160,XMAX-7,190,RED,WHITE);
		       setcolor(15);
		       outtextxy(XMAX-60,170,"Setup");}
	if (flag==1)  {if (status==0) train();
		       if (status==1) load();
		       if (status==2) recognize();
		       if (status==3) set();}
       }
}

void main()
{unsigned ch,flag,status;		//setup value
 StartpicX=StartpicY=status=flag=0;

 int driver = DETECT,mode;		//setup graphic mode
 initgraph(&driver,&mode,"");

 randomize();
// loadweight();
 readfont();				//load thai font to tfont[256][20]
 screen();
 operation(status,flag);
 do
  {ch = bioskey(0);
   flag=0;
   switch(ch)
    {case TAB   :  if (status<7) status = status+10;
		      else status = status-10;
		      break;
     case UP    :  if ((status>0)&&(status<7)) status--;
		      if (status > 7) StartpicY=StartpicY+5;
		      break;
     case DOWN  :  if (status<3) status++;
		      if (status>7) StartpicY=StartpicY-5;
		      break;
     case LEFT  :  if (status>7) StartpicX=StartpicX-5;
		      break;
     case RIGHT :  if (status>7) StartpicX=StartpicX+5;
		      break;
     case ENTER :  flag=1; break;
    }
   if (ch!=ESC) operation(status,flag);
  }while (ch!=ESC);
 closegraph();
// saveweight();
}