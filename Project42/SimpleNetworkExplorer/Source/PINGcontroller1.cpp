// PINGcontroller1.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "PINGcontroller1.h"
#include "IP_input.h"
#include "winsock2.h"
#include "SNMPcontroller1.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// PINGcontroller dialog


PINGcontroller::PINGcontroller(CWnd* pParent /*=NULL*/)
	: CDialog(PINGcontroller::IDD, pParent)
{
	//{{AFX_DATA_INIT(PINGcontroller)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void PINGcontroller::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(PINGcontroller)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(PINGcontroller, CDialog)
	//{{AFX_MSG_MAP(PINGcontroller)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// PINGcontroller message handlers

int PINGcontroller::ping(CString firstip)
{
  WSADATA wsaData;
  SOCKET sockRaw;
  struct sockaddr_in dest,from;
  int bread,datasize;
  int fromlen = sizeof(from);
  int timeout = 100;
  char *icmp_data;
  char *recvbuf;
  unsigned int addr=0;
  USHORT seq_no = 0;
  returntime = 9999;
  bool pingstatus;
	if (WSAStartup(MAKEWORD(2,1),&wsaData) != 0)
  {											
	pingstatus = false;
	goto endping;
  }
  
  sockRaw = WSASocket (AF_INET,
					   SOCK_RAW,
					   IPPROTO_ICMP,
					   NULL, 0,0);
  if (sockRaw == INVALID_SOCKET) {
	pingstatus = false;
	goto endping2;
  }
  bread = setsockopt(sockRaw,SOL_SOCKET,SO_RCVTIMEO,(char*)&timeout,
  					sizeof(timeout));
  if(bread != 0) {
	pingstatus = false;
	goto endping2;
  }
  timeout = 100;
  bread = setsockopt(sockRaw,SOL_SOCKET,SO_SNDTIMEO,(char*)&timeout,
  					sizeof(timeout));
  if(bread != 0) {
	pingstatus = false;
	goto endping2;
  }

  memset(&dest,0,sizeof(dest));

	addr = inet_addr(firstip);
 	dest.sin_addr.s_addr = addr;
    dest.sin_family = AF_INET;
  datasize = DEF_PACKET_SIZE;
  datasize += sizeof(IcmpHeader);  

  icmp_data = (char*)xmalloc(MAX_PACKET);
  recvbuf = (char*)xmalloc(MAX_PACKET);
  if (!icmp_data) {
	pingstatus = false;
	goto endping3;
  }
  memset(icmp_data,0,MAX_PACKET);
  fill_icmp_data(icmp_data,datasize);
  
   int bwrote;
	
	((IcmpHeader*)icmp_data)->i_cksum = 0;
	((IcmpHeader*)icmp_data)->timestamp = GetTickCount();

	((IcmpHeader*)icmp_data)->i_seq = seq_no++;
	((IcmpHeader*)icmp_data)->i_cksum = checksum((USHORT*)icmp_data, 
											datasize);
	bwrote = sendto(sockRaw,icmp_data,datasize,0,(struct sockaddr*)&dest,
					sizeof(dest));
	if (bwrote == SOCKET_ERROR){
	  if (WSAGetLastError() == WSAETIMEDOUT) {
//	  	printf("timed out\n");
		//continue;
		//  message.MessageBox("timeout");
	  }
		pingstatus = false;
		goto endping3;
	}
		if (bwrote < datasize ) {
		goto endping3;
	}
	bread = recvfrom(sockRaw,recvbuf,MAX_PACKET,0,(struct sockaddr*)&from,
				 &fromlen);
		if (bread == SOCKET_ERROR){
	  if (WSAGetLastError() == WSAETIMEDOUT) {
		   //message.MessageBox("timeout");
	//	continue;
	  }
		pingstatus = false;
		goto endping3;
		}
  decode_resp(recvbuf,bread,&from);
endping3:
  xfree(icmp_data);
  xfree(recvbuf);
endping2:
  WSACleanup();
endping:
	return 0;
}

void PINGcontroller::fill_icmp_data(char * icmp_data, int datasize){
  IcmpHeader *icmp_hdr;
  char *datapart;

  icmp_hdr = (IcmpHeader*)icmp_data;

  icmp_hdr->i_type = ICMP_ECHO;
  icmp_hdr->i_code = 0;
  icmp_hdr->i_id = (USHORT)GetCurrentProcessId();
  icmp_hdr->i_cksum = 0;
  icmp_hdr->i_seq = 0;
  
  datapart = icmp_data + sizeof(IcmpHeader);
  //
  // Place some junk in the buffer.
  //
  memset(datapart,'E', datasize - sizeof(IcmpHeader));

}

USHORT PINGcontroller::checksum(USHORT *buffer, int size) {
  unsigned long cksum=0;
  while(size >1) {
	cksum+=*buffer++;
	size -=sizeof(USHORT);
  }
  
  if(size ) {
	cksum += *(UCHAR*)buffer;
  }

  cksum = (cksum >> 16) + (cksum & 0xffff);
  cksum += (cksum >>16);
  return (USHORT)(~cksum);
}

void PINGcontroller::decode_resp(char *buf, int bytes,struct sockaddr_in *from) {
	IpHeader *iphdr;
	IcmpHeader *icmphdr;
	unsigned short iphdrlen;

	iphdr = (IpHeader *)buf;

	iphdrlen = iphdr->h_len * 4 ; // number of 32-bit words *4 = bytes
	if (bytes  < iphdrlen + ICMP_MIN) {
//		printf("Too few bytes from %s\n",inet_ntoa(from->sin_addr));
	}

	icmphdr = (IcmpHeader*)(buf + iphdrlen);

	if (icmphdr->i_type != ICMP_ECHOREPLY) {
//		fprintf(stderr,"non-echo type %d recvd\n",icmphdr->i_type);
		return;
	}
	if (icmphdr->i_id != (USHORT)GetCurrentProcessId()) {
//		fprintf(stderr,"someone else's packet!\n");
		return ;
	}
//	printf("%d bytes from %s:",bytes, inet_ntoa(from->sin_addr));
//	printf(" icmp_seq = %d. ",icmphdr->i_seq);
//	printf(" time: %d ms ",GetTickCount()-icmphdr->timestamp);
//	printf("\n");
	returntime = GetTickCount()-icmphdr->timestamp;
}

ipfields PINGcontroller::collectip(char* inIP)
{
	int iplength;
	int fieldindex;
	int fieldslot;
	int ipindex;
	char chrtemp;
	char field1[3];
	char field2[3];
	char field3[3];
	char field4[3];
	ipfields tempip;

	fieldindex =1;
	fieldslot =0;

	iplength = strlen(inIP);
	for(ipindex = 0;ipindex < iplength;ipindex++)
	{chrtemp = inIP[ipindex];
	if ( chrtemp != '.')
	{ switch(fieldindex){
		case 1:
			field1[fieldslot]=chrtemp;
			fieldslot++;
			break;
		case 2:
			field2[fieldslot]=chrtemp;
			fieldslot++;
			break;
		case 3:
			field3[fieldslot]=chrtemp;
			fieldslot++;
			break;
		case 4:
			field4[fieldslot]=chrtemp;
			fieldslot++;
			break;}
		}
	else{
		switch(fieldindex){
		case 1:
			field1[fieldslot]=NULL;
			fieldindex++;
			fieldslot = 0;
			break;
		case 2:
			field2[fieldslot]=NULL;
			fieldindex++;
			fieldslot = 0;
			break;
		case 3:
			field3[fieldslot]=NULL;
			fieldindex++;
			fieldslot = 0;
			break;
			}
	}
	}
	field4[fieldslot]=NULL;
	tempip.field1 = atoi(field1);
	tempip.field2 = atoi(field2);
	tempip.field3 = atoi(field3);
	tempip.field4 = atoi(field4);
	return tempip;
}

char PINGcontroller::chr(byte inconvert)
{	char chrret;
	switch(inconvert){
	case 0:
		chrret = '0';
		break;
	case 1:
		chrret = '1';
		break;
	case 2:
		chrret = '2';
		break;
	case 3:
		chrret = '3';
		break;
	case 4:
		chrret = '4';
		break;
	case 5:
		chrret = '5';
		break;
	case 6:
		chrret = '6';
		break;
	case 7:
		chrret = '7';
		break;
	case 8:
		chrret = '8';
		break;
	case 9:
		chrret = '9';
		break;}
	return chrret;
}

CString PINGcontroller::ipinttostr(ipfields inip){
	CString returnip;
	int divtemp;
	char iptemp;
	int iplength;
	bool empty = true;
	divtemp = inip.field1/100;
	if ( divtemp > 0 )
	{ iptemp = chr(divtemp);
	returnip += iptemp;
	empty = false;}
	divtemp = (inip.field1/10)%10;
	if (divtemp > 0)
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	else{
		if (empty == false)
		{iptemp = chr(divtemp);
		returnip += iptemp;}
	}
	divtemp = inip.field1 % 10;
	iptemp = chr(divtemp);
	returnip += iptemp;
	returnip += '.';
	divtemp = inip.field2/100;
	if ( divtemp > 0 )
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	divtemp = (inip.field2/10)%10;
	if (divtemp > 0)
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	else{iplength = strlen(returnip);
		if (returnip.GetAt(iplength - 1) != '.')
		{iptemp = chr(divtemp);
		returnip += iptemp;}
	}
	divtemp = inip.field2 % 10;
	iptemp = chr(divtemp);
	returnip += iptemp;
	returnip += '.';
	divtemp = inip.field3/100;
	if ( divtemp > 0 )
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	divtemp = (inip.field3/10)%10;
	if (divtemp > 0)
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	else{iplength = strlen(returnip);
		if (returnip.GetAt(iplength - 1) != '.')
		{iptemp = chr(divtemp);
		returnip += iptemp;}
	}
	divtemp = inip.field3 % 10;
	iptemp = chr(divtemp);
	returnip += iptemp;
	returnip += '.';
	divtemp = inip.field4/100;
	if ( divtemp > 0 )
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	divtemp = (inip.field4/10)%10;
	if (divtemp > 0)
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	else{iplength = strlen(returnip);
		if (returnip.GetAt(iplength - 1) != '.')
		{iptemp = chr(divtemp);
		returnip += iptemp;}
	}
	divtemp = inip.field4 % 10;
	iptemp = chr(divtemp);
	returnip += iptemp;
	return returnip;
}

ipfields PINGcontroller::increaseip(ipfields tip)
{
	if (tip.field4 < 255)
	{ tip.field4++;}
	else{ tip.field4 = 0;
	if (tip.field3 < 255)
	{tip.field3++;}
	else{tip.field3 = 0;
	if (tip.field2 < 255)
	{tip.field2++;}
	else{tip.field2 = 0;
	if (tip.field1 < 255)
	{tip.field1++;}
	else{ tip.field1 = 0;}
	}
	}
	}
	
	return tip;
}


void PINGcontroller::OnOK() 
{ 	CString firstip;
	CString lastip;
	CString community;
  CEdit message;
  ipfields tfirstip;
  ipfields tlastip;
  CString strfirstip;
  CString strlastip;
  RECT rect1;
  RECT rect2;
  int ipno;
  int activeindex = 0;
  IP_input pinginputip;
  pinginputip.DoModal();
  firstip = pinginputip.getfirst();
  lastip = pinginputip.getlast();
  community = pinginputip.getcommunity();
  returntime = 9999;
  ipno = 0;
  rect1.bottom = 80;
  rect2.bottom = 80;
  rect1.top = 60;
  rect2.top = 60;
  rect1.left = 60;
  rect2.left = 180;
  rect1.right = 160;
  rect2.right = 240;
  pingingip.Create("",WS_VISIBLE|SS_RIGHT,rect1,this,9000);
  pingingstatus.Create("",WS_VISIBLE|SS_RIGHT,rect2,this,9001);
  tfirstip = collectip(firstip.GetBuffer(1));
  tlastip = collectip(lastip.GetBuffer(1));
  if (tfirstip.field1 == 0 && tfirstip.field2 == 0 && tfirstip.field3 == 0 && tfirstip.field4 == 0)
	{message.MessageBox("IP error");
		CDialog::OnOK();
	}
  if (tlastip.field1 == 0 && tlastip.field2 == 0 && tlastip.field3 == 0 && tlastip.field4 == 0)
	{
	  message.MessageBox("IP Error");
	  	CDialog::OnOK();
	}
  ipno = tlastip.field1 - tfirstip.field1;
  ipno = ipno * 255;
  ipno = ipno + tlastip.field2 - tfirstip.field2;
  ipno = ipno * 255;
  ipno = ipno + tlastip.field3 - tfirstip.field3;
  ipno = ipno * 255;
  ipno = ipno + tlastip.field4 - tfirstip.field4;
  int x;
  for (x=0;x <= ipno;x++)
  {
	  if (tfirstip.field4 == 0 || tfirstip.field4 == 255)
		{
		  x++;
		}
	  else
		{
		strfirstip = ipinttostr(tfirstip);
		pingingip.SetWindowText(strfirstip);
		pingingstatus.SetWindowText("waiting");
		ping(strfirstip);
		pingingstatus.SetWindowText("complete");
	  if (returntime == 9999)
		{}

		else { 
		activeip[activeindex] = tfirstip;
		activeindex++;}
		}
		returntime = 9999;
		tfirstip = increaseip(tfirstip);
   
  }
//  MessageBox(community);
  SNMPcontroller snmpcontrol;
  snmpcontrol.update(activeip,activeindex,community);
  snmpcontrol.DoModal();
	CDialog::OnOK();
}
