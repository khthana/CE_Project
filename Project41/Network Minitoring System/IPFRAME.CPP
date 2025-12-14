/*******************************************************************************
**   FileName: Packet.cpp
**   Description : Examples of use pktdriver class
**
** ----------------------------------------------------------
**   Compiler: Turbo C++ Version 3.0  Borland International.
**   Last Edit: 27-April-1999
**   OS-Version: MS-DOS 6.0
**   Version: 1.042  Build 1600
** ----------------------------------------------------------
**   Author : Thanathip Tharavanich (Luisekm)
**
**   Email  : luisekm75@hotmail.com
**            luisekm@gang4d.com
**
**   Copyright: (C) 1999 LuiseKm.
**
**   Released to public domain.
**   The author can not be held responsible for any damages resulting
**   from the use of this software.
*******************************************************************************/

#include <conio.h>
#include <stdio.h>
#include <ctype.h>
#include <iostream.h>
#include "pktdrvr.cpp"

typedef struct{
	unsigned char src[4];	  // adresse source
	unsigned char dest[4];	  // adresse destination
	unsigned char * contents;
} ipFRAME;

#define Eth802_3 1
#define Eth802_2 2
#define EthSNAP  3
#define EthII    4

char buffer[1514];
int packet_len=0;

int interrupt receiver(bp,di,si,ds,es,dx,cx,bx,ax,ip,cs,flags){
	if (packet_len || cx > sizeof(buffer))
	es = di = 0;		/* discard this packet */
    else
	if (ax == 0)
	{
	    es = FP_SEG(buffer);	/* tell them to stick it in our buffer */
	    di = FP_OFF(buffer);
	}
	else
	    packet_len = cx;	/* second upcall -- remember size. */
    return(0);
}

void fprintethaddr(FILE *f, unsigned char ethaddr[4])
{
    fprintf(f, "%d:%d:%d:%d",
	ethaddr[0], ethaddr[1], ethaddr[2], ethaddr[3]);
}

unsigned int twoChar2Int(unsigned int one,unsigned int zero)
{
   one*=256;
   one+=zero;
   return(one);
}; //End of twoChar2Int

int whatTypeOfEth(char currentFrame[])
{
unsigned int typeOrLenF=twoChar2Int(currentFrame[12],currentFrame[13]);
// 12,13 are position of length or type field

   if(typeOrLenF>1500)
   {
      return(EthII);   //this is EthII
   }
   else {
      if((currentFrame[14]==0xFF) && (currentFrame[15]==0xFF))
      {
	 return(Eth802_3);   //this is Eth802.3
      }
      else {
	 if((currentFrame[14]==0xAA) && (currentFrame[15]==0xAA))
	 {
	    return(EthSNAP);
	 } else {
	    return(Eth802_2);
	 }
      }
   }
}; //End of whatTypeOfEth

void getData(ipFRAME *frame,unsigned char buffer[1514],int length){

	//frame->contentlength = length;

	// find ip
	int startIP;
	int beforeip=12;
	int ethType=whatTypeOfEth(buffer);
	if(ethType==Eth802_2)
	{
	   if(buffer[15]==0x06)
	   startIP=17+beforeip;
	} else if(ethType==EthSNAP) {
	   if(buffer[20]==0x08 && buffer[21]==0x00)
	   startIP=22+beforeip;
	} else if(ethType==EthII) {
	   if(buffer[12]==0x08 && buffer[13]==0x00)
	   startIP=14+beforeip;
	}
	for(int ipP=0; ipP<4 ; ipP++)
	{
	   frame->src[ipP]=buffer[startIP+ipP];   //=buffer[startIP+ipP];
	}
	frame->src[4]='\0';
	startIP+=4;

	for(ipP=0; ipP<4 ; ipP++)
	{
	   frame->dest[ipP]=buffer[startIP+ipP];   //=buffer[startIP+ipP];
	}
	frame->dest[4]='\0';
	// end find ip

    /* copy source address*/
    /*for(int c=0; c<4; c++)
	frame->src[c] = buffer[c+4];
	frame->src[7] = '\0';*/

    /* copy destination address */
   /* for(c=0; c<6; c++)
	frame->dest[c] = buffer[c];
	frame->dest[7] = '\0';*/

    /* copier le type / longueur des donnees */
	//frame->type = (buffer[12] << 8) + (buffer[13]);

    /* copy content */
    /*for(c=0; c<length; c++)
	frame->content[c] = buffer[14+c];
	frame->content[c+1] = '\0';*/
}


int main(){
	PktDriver pkt;
	int handle;
	ipFRAME Etherf;

	clrscr();
		pkt.InitPktDriver();
		handle=pkt.AccessType(0xffff,0,NULL,0,receiver);
		printf("\nHandle = %d\n",handle);
		pkt.SetRCVmode(handle,6);

	while (!kbhit()){
	    if (packet_len){

		getData(&Etherf,buffer,packet_len);
		packet_len=0;
		fprintf(stdout, "    IP Address: ");
		fprintethaddr(stdout, Etherf.src);
		printf(" -> ");
		fprintethaddr(stdout,Etherf.dest);
		cout<<"\n";
	    }
	 }

	getch();
	pkt.ReleaseType(handle);

	return 0;
}
