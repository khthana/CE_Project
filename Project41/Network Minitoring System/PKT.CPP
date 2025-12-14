/*******************************************************************************
**   FileName: Pkt.cpp
**   Description : Examples of use pktdriver class
**		  
** ----------------------------------------------------------
**   Compiler: Turbo C++ Version 3.0  Borland International.
**   Last Edit: 15-April-1999
**   OS-Version: MS-DOS 6.0
**   Version: 1.04  Build 1300
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
#include <fstream.h>

#include "pktdrvr.cpp"
#include "fields.cpp"
#include "filter.cpp"

unsigned char buffer[1514];
FILE* dump_file;
unsigned char frame_arr[1514];

int packet_len,index,noOfFrame;
int len[15];

packetFilter filter;

static void ctohex(char *buf,int c)
{
	static char hex[] = "0123456789abcdef";

	*buf++ = hex[c >> 4];
	*buf = hex[c & 0xf];
}

void fmtline(int addr,char *buf,int len)
{
	char line[80];
	register char *aptr,*cptr;
	unsigned register char c;

	memset(line,' ',sizeof(line));
	ctohex(line,addr >> 8);
	ctohex(line+2,addr & 0xff);
	aptr = &line[6];
	cptr = &line[55];
	while(len-- != 0){
		c = *buf++;
		frame_arr[index++]=c;
		ctohex(aptr,c);
		aptr += 3;
		c &= 0x7f;
		*cptr++ = isprint(c) ? c : '.';

	}
	*cptr++ = '\n';

//fwrite(&s, sizeof(s), 1, stream); /* write struct s to file */


	fwrite(line,1,(unsigned)(cptr-line),dump_file);
//	fwrite(line,1,(unsigned)(cptr-line),stdout);

}

void dump_bytes(char *bytes, int count)
{
	int n;
	char buf[16];
	int address;

	address = 0;
	index=0;
	while(count){
		if (count > 16) n = 16;
		else n = count;
		fmtline(address,bytes,n);
		address += n;
		count -= n;
		bytes += n;
	}

	/*for(int i=0;i<packet_len;i++)
	{
	   cout << frame_arr[noOfFrame].byte[i];
	}
	cout << endl;*/
}



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

int main(){

	PktDriver pkt;
	int handle;
	char addr[6];
	addr[0]=161;
	addr[1]=246;
	addr[2]=6;
	addr[3]=99;
	//addr[4]=0xff;
	//addr[5]=0xff;

	ofstream result("field.sep");
	Fields sep(&result);

	noOfFrame=0;

	packet_len=0;
	if ((dump_file = fopen("frames.dmp", "wb")) == NULL) /* open file TEST.$$$ */
	{
		fprintf(stderr, "Cannot open output file.\n");
		return 1;
	}

	clrscr();
		pkt.InitPktDriver();
		handle=pkt.AccessType(0xffff,0,NULL,0,receiver);
		printf("Handle = %d\n",handle);
		pkt.SetRCVmode(handle,6);

       while (!kbhit())
       {
		if (packet_len) {
			len[noOfFrame]=packet_len;
			cout << "Frame " << noOfFrame << " :";
			cout << endl << len[noOfFrame] << endl;

			dump_bytes(buffer, packet_len);

			int flag=filter.filterByIP(1,frame_arr,addr);
			//cout << flag << endl;
			if(flag)
			{
			   sep.seperate(frame_arr,len[noOfFrame]);
			}
//#if 0
			/* send packet back */
/*			memcpy(buffer,buffer+6,6);
			memcpy(buffer+6,myeaddr,6);
			send_pkt(intno,buffer,packet_len);*/
//#endif

			noOfFrame++;
			packet_len = 0;
		}
	}
	getch();

	pkt.ReleaseType(handle);
	fclose(dump_file); /* close file */
	return 0;
}
