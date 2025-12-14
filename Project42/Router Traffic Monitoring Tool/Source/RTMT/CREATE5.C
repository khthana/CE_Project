/********************************************
**This Program used for create /image graph *
*********************************************/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "gd.h"
#include "gdfonts.h"
//**************************************************
#define MAX 100
#define black 0, 0, 0
#define white 255, 255, 255
#define blue 20, 120, 200
#define red 255, 0, 0 
#define green 0, 255, 0
#define dark 120, 120, 120
#define light 195, 195, 195
#define Xsize 400 
#define Ysize 230
#define x1 86 
#define x2 374 
#define y1 29 
#define y2 189 
//**************************************************
char *day = "/usr/local/rtmt/html/gd/image/day/";
char *mon = "/usr/local/rtmt/html/gd/image/month/";
char *year = "/usr/local/rtmt/html/gd/image/year/";
char *dlog = "/etc/RTMT/";

gdImagePtr dd,mm,yy,brushin, brushout;
FILE *in, *out, *llog;
int bg, ip, op, base;
char *fday, *fmon, *fyear, *flog, ftemp[MAX];	//filename
char *y_label[10];
char *xd_label[15] = {"0","2","4","6","8","10","12","14","16","18","20","22","24","26"};
char *xm_label[18] = {"1","3","5","7","9","11","13","15","17","19","21","23","25","27","29","31","33"};
char *xy_label[15] = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","Jan"};
long iscale[MAX],yscale=0,myscale=0;
float fscale,fmore;
int interface[MAX], time[MAX][600],imax,maxin;
float inp[MAX][600],outp[MAX][600];
char *oid,*meter="M";
int type;
//**************************************************
char *itoa (int n)
{
   static char buf[16];
   char sign;
   char *ptr;
        if (n>=0) sign = ' ';
        else { n = -n; sign = '-'; }
        buf[15] = 0;
        ptr = buf + 14;
        do { *--ptr = n % 10 + '0';
             if (ptr <= buf) return(buf);
             n /= 10;
        } while (n > 0);
        *--ptr = sign;
	if (sign==' ') {
           ptr++;	
	}
        return(ptr);
}            
//**************************************************
void image(char *temp,gdImagePtr im,int xpp,int ypp,char *xl[15],int bound)
{
int bor_d, bor_l, y0;
int styleDotted[2];
static int i,inf,t,nt,olx,nx;
static float x,y,oly,olz,ny,nz;
char fname[MAX], *f_temp;
char YL[MAX];	
	//create image
	for (inf=0; inf<=maxin; inf++)
        {
	       im = gdImageCreate(Xsize,Ysize);
           brushin = gdImageCreate(3,3);
           brushout = gdImageCreate(2,2);
           bg = gdImageColorAllocate(im, black);
           ip = gdImageColorAllocate(brushin, green);
           op = gdImageColorAllocate(brushout, red);                           
           base = gdImageColorAllocate(im, white);
           bor_d = gdImageColorAllocate(im, dark);
           bor_l = gdImageColorAllocate(im, light);
           //draw image border
           gdImageLine(im,0,0,Xsize-1,0,bor_l);
           gdImageLine(im,1,1,Xsize-2,1,bor_l);
           gdImageLine(im,0,0,0,Ysize-1,bor_l);
           gdImageLine(im,1,1,1,Ysize-2,bor_l);
           gdImageLine(im,Xsize-1,0,Xsize-1,Ysize-1,bor_d);
           gdImageLine(im,Xsize-2,1,Xsize-2,Ysize-2,bor_d);
           gdImageLine(im,0,Ysize-1,Xsize-1,Ysize-1,bor_d);
           gdImageLine(im,1,Ysize-2,Xsize-2,Ysize-2,bor_d);                    
           //draw edge of graph
           gdImageLine(im,x1,y1,x2,y1,base);
           gdImageLine(im,x1,y1,x1,y2,base);
           gdImageLine(im,x1,y2,x2,y2,base);
           gdImageLine(im,x2,y1,x2,y2,base);                                   
           t = 0;
           while(t < imax)
           {
	          nt = t+1;
              olx = time[inf][t];
              nx = time[inf][nt];
              oly = inp[inf][t];
              ny = inp[inf][nt];
	          olz = outp[inf][t];
	          nz = outp[inf][nt];
	          //find pixel
	          if(type==4) y0 = 109;
		      else y0 = y2;
	          if(type==0 || type==5) 
	          { olx = ((olx-1)*xpp)+86;
		      nx = ((nx-1)*xpp)+86;
	          } else
	          { olx = (olx/5)+86;
	            nx = (nx/5)+86; }
	          oly = y0-(oly * ypp/iscale[inf]);
	          ny = y0-(ny * ypp/iscale[inf]);
	          olz = y0-(olz * ypp/iscale[inf]);
	          nz = y0-(nz * ypp/iscale[inf]);
	          gdImageSetBrush(im, brushin);
              gdImageLine(im,olx,oly,nx,ny,gdBrushed);
	          gdImageSetBrush(im, brushout);
	          gdImageLine(im,olx,olz,nx,nz,gdBrushed);
			  t++;
           }
	       styleDotted[0]=base;
	       styleDotted[1]=gdTransparent;
	       gdImageSetStyle(im,styleDotted,2);

	       // x label
	       y = y2 + 3;
	       switch(type){
	         case 5 :
	          x = x1-9;
	          for (i=0; i<bound; i++)
	          {
		       gdImageString(im,gdFontSmall,x,y,xl[i],base);
		       x += xpp;
	          } break;
	         default :
	          x = x1 - 2;
	          for (i=0; i<bound; i++)
	          {	
	           gdImageString(im, gdFontSmall, x, y, xl[i], base);
	           x += (xpp*2); 
	           if (xl[i][0] > xl[i+1][0]) x -= 4;
	          } break;
	       }
	       //y label
	       x = x1-45;
	       y = y1-8;
	       i = 0;
	       while(i<9)
	       {
	         switch(type){
	          case 4 :
	           if (i<4)
               { yscale = iscale[inf]*(4-i);
                 y_label[i] = itoa(yscale); }
               else if (i==4) {y_label[i] = itoa(0);}
               else if (i>4)
               { myscale = iscale[inf]*(i-4);
                 y_label[i] = itoa(-myscale); }      
	           break;
	          default :
	           if (i==8) y_label[i] = itoa(0);
	           else { yscale = iscale[inf]*(8-i);
		       y_label[i] = itoa(yscale); }
	           break;  
       	     }
	         strcpy(YL,y_label[i]); 
	         strcat(YL,meter);
	         gdImageString(im, gdFontSmall, x, y, YL, base);
	         y += ypp;
	         i++;
	       }
// Y label
	   gdImageStringUp(im, gdFontSmall,4,((Ysize/2)+(Ysize/5)),"Bytes per Second",base);

// X label
	   if(type==0) gdImageString(im,gdFontSmall,(Xsize/2),210,"Day",base);
	   else if(type==5) gdImageString(im,gdFontSmall,(Xsize/2),210,"Month",base); 
	   else gdImageString(im,gdFontSmall,(Xsize/2),210,"Hour",base);
 
           x = x1;
           while (x<x2)
           {
              x += xpp;
              gdImageLine(im,x,y1,x,y2+2,gdStyled);
           }
           y = y1;
           while (y<y2)
           {
              y += ypp;
              gdImageLine(im,x1-2,y,x2+2,y,gdStyled);
           }    
	   strcpy(fname,temp);
	   strcat(fname,"_");
	   strcat(fname,itoa(inf));
	   strcat(fname,".png");
	   f_temp = fname;                               	
	   out = fopen(f_temp,"wb");
           gdImagePng(im, out);
           fclose(out);
           gdImageDestroy(im);
	   gdImageDestroy(brushin);
	   gdImageDestroy(brushout);
	}
}           

//**************************************************
int main (int argc, char **argv)
{
int max,min;
int interf,timef,i,j,ti,to,intrf;
float input,output;
char check;
long MAXI[MAX],MINI[MAX],MAXO[MAX],MINO[MAX];
long MAXX[MAX],MINN[MAX];
float maxi,mini,maxo,mino;
        max = atoi(argv[argc-4]);
        min = atoi(argv[argc-3]);
        oid = argv[argc-2];
        type = atoi(argv[argc-1]);                             
	strcpy(ftemp, dlog);
	strcat(ftemp, argv[argc-5]);
	if (type==0) strcat(ftemp,".mon");
	else if (type==5) strcat(ftemp,".yrs");
	else strcat(ftemp,".day");
	flog = ftemp;
	j = 0; i = 0; 
	llog = fopen(flog,"rt");
	while (!feof(llog))
	{
	  fscanf(llog,"%c",&check);
	  if (check=='m')
	  { fscanf(llog,"%d%f%f%f%f",&intrf,&mini,&maxi,&mino,&maxo);
	    MINI[intrf] = (double) mini/1000000;
	    MAXI[intrf] = (double) maxi/1000000;
	    MINO[intrf] = (double) mino/1000000;
	    MAXO[intrf] = (double) maxo/1000000;
	    if(MAXI[intrf]>MAXO[intrf]) MAXX[intrf] = MAXI[intrf];
		else MAXX[intrf] = MAXO[intrf];
	    if(MINI[intrf]<MINO[intrf]) MINN[intrf] = MINI[intrf];
		else MINN[intrf] = MINO[intrf];
	  }
	}
	fclose(llog);

	llog = fopen(flog,"rt");
	while (!feof(llog))
        {
	 fscanf(llog,"%c",&check);
	 if (check=='i')
	 {
	   fscanf(llog,"%d%d%f%f",&interf,&timef,&input,&output);
	   if(i>0 && interf != interface[interf-1] && time[0][0]==timef) i=0;
	   interface[interf] = interf;
	   time[interf][i] = timef;
	   inp[interf][i] = input/1000000;
	   outp[interf][i] = output/1000000;
	   if(i>imax) { imax = i;}
	   if(interf>maxin) { maxin = interf; }  
	   j = interf;
	   i++;
	  }
	}
	fclose(llog);
	
        if(inp[0][imax-1]>0 && inp[0][imax]==0) imax--; 
	for(interf=0; interf<=maxin; interf++)
	{
	  if (max > MAXX[interf]) MAXX[interf] = max; 
	  if (min < MINN[interf]) MINN[interf] = min;
	  if (type==4) YScale(MAXX[interf],MINN[interf],4,interf);
	  else YScale(MAXX[interf],MINN[interf],8,interf);
	}

	if (type==0)  
	{  strcpy(ftemp, mon);
	   strcat(ftemp, argv[argc-5]);
	   fmon = ftemp;
	   image(fmon,mm,9,20,xm_label,16);
	} else if (type==5)
	{  strcpy(ftemp, year);
	   strcat(ftemp, argv[argc-5]);
	   fyear = ftemp;
	   image(fyear,yy,24,20,xy_label,13);
	} else 
	{  strcpy(ftemp, day);
	   strcat(ftemp, argv[argc-5]);
	   fday = ftemp;
	   image(fday,dd,12,20,xd_label,13);
	}
   	return(0);
}		//end main

int YScale (long ymax,long ymin,int s,int inttf)
{
float fscale,fmore;
	if (abs(ymax) > abs(ymin))  ymax = ymax; 
	else ymax = abs(ymin);
	fscale = ymax/(s*1.0);
	iscale[inttf] = ymax/s;
	fmore = fscale - iscale[inttf];
	if (fmore>=0.5) iscale[inttf]++;
	return(iscale[inttf]);   

}
