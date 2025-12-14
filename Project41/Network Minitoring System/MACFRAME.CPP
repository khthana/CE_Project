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
	unsigned int contentlength;		  // longueur des donnees d'une trame
	unsigned char src[7];	  // adresse source
	unsigned char dest[7];	  // adresse destination
	unsigned int type;			  // type ou longueur
	unsigned char content[1501];  // les donnees
}ETHERFRAME;


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

void fprintethaddr(FILE *f, unsigned char ethaddr[6])
{
    fprintf(f, "%02X:%02X:%02X:%02X:%02X:%02X",
	ethaddr[0], ethaddr[1], ethaddr[2], ethaddr[3], ethaddr[4], ethaddr[5]);
}

void getData(ETHERFRAME *frame,unsigned char buffer[1514],int length){

	frame->contentlength = length;

    /* copy source address*/
    for(int c=0; c<6; c++)
	frame->src[c] = buffer[c+6];
	frame->src[7] = '\0';

    /* copy destination address */
    for(c=0; c<6; c++)
	frame->dest[c] = buffer[c];
	frame->dest[7] = '\0';

    /* copier le type / longueur des donnees */
	frame->type = (buffer[12] << 8) + (buffer[13]);

    /* copy content */
    for(c=0; c<length; c++)
	frame->content[c] = buffer[14+c];
	frame->content[c+1] = '\0';
}


int main(){
	PktDriver pkt;
	int handle;
	ETHERFRAME Etherf;

	clrscr();
		pkt.InitPktDriver();
		handle=pkt.AccessType(0xffff,0,NULL,0,receiver);
		printf("\nHandle = %d\n",handle);
		pkt.SetRCVmode(handle,6);

	while (!kbhit()){
	    if (packet_len){

		getData(&Etherf,buffer,packet_len);
		packet_len=0;
		fprintf(stdout, "    Ethernet: ");
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
