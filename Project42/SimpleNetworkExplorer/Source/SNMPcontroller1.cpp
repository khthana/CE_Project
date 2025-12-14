// SNMPcontroller1.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "SNMPcontroller1.h"
#include "vbs.h"
#include "UdpClient.h"
#include "GetNameByAddress.h"

//#include "winsock2.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// SNMPcontroller dialog


SNMPcontroller::SNMPcontroller(CWnd* pParent /*=NULL*/)
	: CDialog(SNMPcontroller::IDD, pParent)
{
	//{{AFX_DATA_INIT(SNMPcontroller)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void SNMPcontroller::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(SNMPcontroller)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(SNMPcontroller, CDialog)
	//{{AFX_MSG_MAP(SNMPcontroller)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// SNMPcontroller message handlers

snmpdata SNMPcontroller::SNMPgetdesc(CString snmpip)
{
  WSADATA wsaData;
  SOCKET sockRaw;
  CEdit message;
  CString community;
  snmpdata tempnodedata;
  WSAStartup(MAKEWORD(2,1),&wsaData);
  sockRaw = WSASocket (AF_INET,
					   SOCK_DGRAM,
					   IPPROTO_UDP,
					   NULL, 0,0);
  community = snmpcommunityname;
    Packet* snmppkt = new Packet(V1GETCOMMAND);
	snmppkt->Community(community);
	snmppkt->RequestId(123);
	OidVarbind* oid = new OidVarbind("1.3.6.1.2.1.1.1.0");
    Varbind* vb = new StringVarbind();
    VbPair* vbp = new VbPair(oid, vb);
    snmppkt->Add(vbp);
	UdpClient* udp = new UdpClient(161,snmpip.GetBuffer(1));
    udp->Send(snmppkt);
	Packet* retP = udp->Receive(0);
	 if (retP)
		{ if(retP->RequestId() == 123)
			{
			if (retP->ErrorStatus() == NOERROR)
				{      
				tempnodedata.nodedesc = retP->VbData(1);
				}
			}
		}
	 else { message.MessageBox("snmp nodedesc error");}
	 delete(snmppkt);
	 delete(retP);
	 delete(udp);

	Packet* snmppkt2 = new Packet(V1GETCOMMAND);
	snmppkt2->Community(community);
	snmppkt2->RequestId(123);
	OidVarbind* oid2 = new OidVarbind("1.3.6.1.2.1.1.5.0");
    Varbind* vb2 = new StringVarbind();
    VbPair* vbp2 = new VbPair(oid2, vb2);
    snmppkt2->Add(vbp2);
	UdpClient* udp2 = new UdpClient(161,snmpip.GetBuffer(1));
    udp2->Send(snmppkt2);
	Packet* retP2 = udp2->Receive(0);
	 if (retP2)
		{if (retP2->RequestId() == 123)
			{
			if (retP2->ErrorStatus() == NOERROR)
				{      
				tempnodedata.nodename = retP2->VbData(1);
				}
			}
		}
	 else { message.MessageBox("snmp nodename error");}
	 delete(snmppkt2);
	 delete(retP2);
	 delete(udp2);

	Packet* snmppkt3 = new Packet(V1GETCOMMAND);
	snmppkt3->Community(community);
	snmppkt3->RequestId(123);
	OidVarbind* oid3 = new OidVarbind("1.3.6.1.2.1.1.7.0");
    Varbind* vb3 = new StringVarbind();
    VbPair* vbp3 = new VbPair(oid3, vb3);
    snmppkt3->Add(vbp3);
	UdpClient* udp3 = new UdpClient(161,snmpip.GetBuffer(1));
    udp3->Send(snmppkt3);
	Packet* retP3 = udp3->Receive(0);
	 if (retP3)
		{if (retP3->RequestId() == 123)
			{
			if (retP3->ErrorStatus() == NOERROR)
				{      
				tempnodedata.nodeservice = stringtobyte(retP3->VbData(1));
				}
			}
		}
	 else {message.MessageBox("snmp service error");}
	 delete(snmppkt3);
	 delete(retP3);
	 delete(udp3);
	 
	Packet* snmppkt4 = new Packet(V1GETCOMMAND);
	snmppkt4->Community(community);
	snmppkt4->RequestId(123);
	OidVarbind* oid4 = new OidVarbind("1.3.6.1.2.1.2.1.0");
    Varbind* vb4 = new StringVarbind();
    VbPair* vbp4 = new VbPair(oid4, vb4);
    snmppkt4->Add(vbp4);
	UdpClient* udp4 = new UdpClient(161,snmpip.GetBuffer(1));
    udp4->Send(snmppkt4);
	Packet* retP4 = udp4->Receive(0);
	 if (retP4)
		{
		if(retP4->RequestId() == 123)
			{
				if (retP4->ErrorStatus() == NOERROR)
				{      
				tempnodedata.ifnumber = stringtobyte(retP4->VbData(1));
				}
			}
		}
	 else {message.MessageBox("snmp ifnumber error");}
	 delete(snmppkt4);
	 delete(retP4);
	 delete(udp4);
 
	WSACleanup();
	return tempnodedata;
}

interfacedata SNMPcontroller::initif()
{	interfacedata ifdata;
	ifdata.ifindex = 0;
	ifdata.ifspeed = 0;
	ifdata.iftype = 0;
	ifdata.IP="";
	ifdata.subnet="";
	return ifdata;
}

int SNMPcontroller::stringtobyte(CString invalue)
{	int returnint;
	int strlen;
	char tchar;
	int index;
	strlen = invalue.GetLength();
	index = 0;
	returnint = 0;
	while (index < strlen)
	{ tchar = invalue.GetAt(index);
	switch(tchar){
	case '0':
		{returnint = returnint * 10;
		returnint = returnint + 0;}
		break;
	case '1':
		{returnint = returnint * 10;
		returnint = returnint + 1;}
		break;
	case '2':
		{returnint = returnint * 10;
		returnint = returnint + 2;}
		break;
	case '3':
		{returnint = returnint * 10;
		returnint = returnint + 3;}
		break;
	case '4':
		{returnint = returnint * 10;
		returnint = returnint + 4;}
		break;
	case '5':
		{returnint = returnint * 10;
		returnint = returnint + 5;}
		break;
	case '6':
		{returnint = returnint * 10;
		returnint = returnint + 6;}
		break;
	case '7':
		{returnint = returnint * 10;
		returnint = returnint + 7;}
		break;
	case '8':
		{returnint = returnint * 10;
		returnint = returnint + 8;}
		break;
	case '9':
		{returnint = returnint * 10;
		returnint = returnint + 9;}
		break;
	}
	index++;
	}

return returnint;
}

interfacedata SNMPcontroller::ifgetdata(int ifindex,CString oldip,CString snmpip,int ifnum)
{ interfacedata tifdata;
  char* toid;
  char tempindex[3];
  CString tcoid;
  CString community;
  WSADATA wsaData;
  SOCKET sockRaw;
  CEdit message;
  int ttype;
  WSAStartup(MAKEWORD(2,1),&wsaData);
  sockRaw = WSASocket (AF_INET,
					   SOCK_DGRAM,
					   IPPROTO_UDP,
					   NULL, 0,0);
	community = snmpcommunityname;
    tcoid = "1.3.6.1.2.1.2.2.1.3.";
	ifindex++;
	_itoa(ifindex,tempindex,10);
	tcoid += tempindex;
	toid = tcoid.GetBuffer(1);
	Packet* snmppkt = new Packet(V1GETCOMMAND);
	snmppkt->Community(community);
	snmppkt->RequestId(123);
	OidVarbind* oid = new OidVarbind(toid);
    Varbind* vb = new StringVarbind();
    VbPair* vbp = new VbPair(oid, vb);
    snmppkt->Add(vbp);
	UdpClient* udp = new UdpClient(161,snmpip.GetBuffer(1));
    udp->Send(snmppkt);
	Packet* retP = udp->Receive(0);
	 if (retP)
		{
		if (retP->RequestId() == 123)
			{
			if (retP->ErrorStatus() == NOERROR)
				{     
				tifdata.iftype = stringtobyte(retP->VbData(1));
				}
			}
		}
	 else { message.MessageBox("snmp iftype error");}
	delete(snmppkt);
	delete(retP);
	delete(udp);

	tcoid = "1.3.6.1.2.1.2.2.1.5.";
	tcoid += chr(ifindex);
	toid = tcoid.GetBuffer(1);
	Packet* snmppkt2 = new Packet(V1GETCOMMAND);
	snmppkt2->Community(community);
	snmppkt2->RequestId(123);
	OidVarbind* oid2 = new OidVarbind(toid);
    Varbind* vb2 = new StringVarbind();
    VbPair* vbp2 = new VbPair(oid2, vb2);
    snmppkt2->Add(vbp2);
	UdpClient* udp2 = new UdpClient(161,snmpip.GetBuffer(1));
    udp2->Send(snmppkt2);
	Packet* retP2 = udp2->Receive(0);
	if (retP2)
		{
		if (retP2->RequestId() == 123)
			{
			if (retP2->ErrorStatus() == NOERROR)
				{  
				tifdata.ifspeed = stringtobyte(retP2->VbData(1));
				}
			}
		}
	else {message.MessageBox("snmp ifspeed error");}
	delete(snmppkt2);
	delete(retP2);
	delete(udp2);
	
	tcoid = "1.3.6.1.2.1.4.20.1.1";
	tcoid = tcoid + "." + oldip;
	toid = tcoid.GetBuffer(1);
	Packet* snmppkt3 = new Packet(V1GETNEXTCOMMAND);
	snmppkt3->Community(community);
	snmppkt3->RequestId(123);
	OidVarbind* oid3 = new OidVarbind(toid);
    Varbind* vb3 = new StringVarbind();
    VbPair* vbp3 = new VbPair(oid3, vb3);
    snmppkt3->Add(vbp3);
	UdpClient* udp3 = new UdpClient(161,snmpip.GetBuffer(1));
    udp3->Send(snmppkt3);
	Packet* retP3 = udp3->Receive(0);
	if (retP3)
		{if (retP3->RequestId() == 123)
			{
			if (retP3->ErrorStatus() == NOERROR)
				{   
				tifdata.IP = retP3->VbData(1);
				}
			}
		}
	else { message.MessageBox("snmp IP error");}
	delete(snmppkt3);
	delete(retP3);
	delete(udp3);
	
	tcoid = "1.3.6.1.2.1.4.20.1.3";
	if (ifnum == 1)
	{ ttype = V1GETCOMMAND;
		tcoid = tcoid + "." + snmpip;
	}
	else
	{ ttype = V1GETNEXTCOMMAND;
		tcoid = tcoid + "." + oldip;
	}
	toid = tcoid.GetBuffer(1);
	Packet* snmppkt4 = new Packet(ttype);
	snmppkt4->Community(community);
	snmppkt4->RequestId(123);
	OidVarbind* oid4 = new OidVarbind(toid);
    Varbind* vb4 = new StringVarbind();
    VbPair* vbp4 = new VbPair(oid4, vb4);
    snmppkt4->Add(vbp4);
	UdpClient* udp4 = new UdpClient(161,snmpip.GetBuffer(1));
    udp4->Send(snmppkt4);
	Packet* retP4 = udp4->Receive(0);
	if (retP4)
		{
			if (retP4->RequestId() == 123)
			{
			if (retP4->ErrorStatus() == NOERROR)
				{  
				tifdata.subnet = retP4->VbData(1);
				}
			}
		}
	else { message.MessageBox("snmp subnet error");}
	delete(snmppkt4);
	delete(retP4);
	delete(udp4);

	WSACleanup();
	return tifdata;
}

char SNMPcontroller::chr(byte inconvert)
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

bool SNMPcontroller::SNMPopenagent(CString snmpip,CString myOID,CString instance,CString community)
{	bool returnvalue = false;
  WSADATA wsaData;
  SOCKET sockRaw;
  CString Myoid;
  char* CompleteOID;
  char* Community;
	  if (WSAStartup(MAKEWORD(2,1),&wsaData) != 0)
		return false;
  sockRaw = WSASocket (AF_INET,
					   SOCK_DGRAM,
					   IPPROTO_UDP,
					   NULL, 0,0);
  if (sockRaw == INVALID_SOCKET) 
	  return false;
    Myoid = myOID;
	Myoid += ".";
	Myoid += instance;
	Community = community.GetBuffer(1);
	CompleteOID = Myoid.GetBuffer(1);
	Packet* snmppkt = new Packet(V1GETCOMMAND);
	snmppkt->Community(Community);
	snmppkt->RequestId(123);
	OidVarbind* oid = new OidVarbind(CompleteOID);
    Varbind* vb = new StringVarbind();
    VbPair* vbp = new VbPair(oid, vb);
    snmppkt->Add(vbp);
	UdpClient* udp = new UdpClient(161,snmpip.GetBuffer(1));
	udp->Timeout(1);
    udp->Send(snmppkt);
	Packet* retP = udp->Receive(0);
	 if (retP)
		{if (retP->RequestId() == 123)
			{
			if (retP->ErrorStatus() == NOERROR)
				{returnvalue = true;
				querydata = retP->VbData(1);}
			else
				{returnvalue = false;}
			}
		else
			{returnvalue = false;}
		}
	 else
		{returnvalue = false;}
	delete(snmppkt);
	delete(retP);
	delete(udp);
	WSACleanup();
	return returnvalue;
}

CString SNMPcontroller::ipinttostr(ipfields inip){
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

ipfields SNMPcontroller::collectip(CString inIP)
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

int SNMPcontroller::ifallince(CString oldifno,CString snmpip,UINT snmpcommunity)
{
  char* toid;
  CString tcoid;
  CString returnvalue;
  CString community;
  WSADATA wsaData;
  SOCKET sockRaw;
  int nextif;
  WSAStartup(MAKEWORD(2,1),&wsaData);
  sockRaw = WSASocket (AF_INET,
					   SOCK_DGRAM,
					   IPPROTO_UDP,
					   NULL, 0,0);
  community = snmpcommunityname;
    tcoid = "1.3.6.1.2.1.4.20.1.2.";
	tcoid += oldifno;
	toid = tcoid.GetBuffer(1);
    Packet* snmppkt = new Packet(snmpcommunity);
	snmppkt->Community(community);
	snmppkt->RequestId(123);
	OidVarbind* oid = new OidVarbind(toid);
    Varbind* vb = new StringVarbind();
    VbPair* vbp = new VbPair(oid, vb);
    snmppkt->Add(vbp);
	UdpClient* udp = new UdpClient(161,snmpip.GetBuffer(1));
    udp->Send(snmppkt);
	Packet* retP = udp->Receive(0);
	if (retP)
		{
		if(retP->RequestId() == 123)
			{
			if (retP->ErrorStatus() == NOERROR)
				{      
				returnvalue = retP->VbData(1);
				nextif = stringtobyte(returnvalue);
				if (returnvalue == "255.255.255.0" || returnvalue == "255.255.0.0" || returnvalue == "255.0.0.0")
					{nextif = 255;}
				}
			}
		}
	delete(snmppkt);
	delete(retP);
	delete(udp);
	WSACleanup();
	return nextif;

}

void SNMPcontroller::OnOK() 
{  CEdit message;
  snmpdata tsnmpdata;
  nodedata tnodedata;
  network tnetwork;
  CString snmpip;
  CString community;
  int ifnum;
  int ifindex;
  int ipindex;
  ipindex = 0;
  ipfields ifiptemp;
  ipfields ifclasstemp;
  nodedata supportlist[300];
  int supportindex = 0;
  network networklist[30];
  int networkindex =0;
  dnslookup dnslist[900];
  CGetNameByAddress dnsresolve;
  int dnsindex =0;
  ipfields tdnsip;
  RECT rect1;
  RECT rect2;
  CString lastip;
  int x;
  int y;
  int ifindextemp;
  bool netcheck = false;
  datacollector dataclct;
  rect1.top = 60;
  rect1.bottom = 80;
  rect2.top = 60;
  rect2.bottom = 80;
  rect1.left = 60;
  rect1.right = 160;
  rect2.left = 180;
  rect2.right = 240;
  IP.Create("",WS_VISIBLE|SS_RIGHT,rect1,this,9002);
  Status.Create("",WS_VISIBLE|SS_RIGHT,rect2,this,9003);
  community = snmpcommunityname;
  while ( ipindex < ipnum)
  {
	    	
	snmpip = ipinttostr(iplist[ipindex]);
	if (snmpip != "255.255.255.255")
	{	
		IP.SetWindowText(snmpip);
		Status.SetWindowText("Waiting");
		if (SNMPopenagent(snmpip,"1.3.6.1.2.1.1.5","0",community) == false)
		{
			dnslist[dnsindex].IP = snmpip;
			dnslist[dnsindex].nodename = dnsresolve.GetNameByIPAddress(snmpip);
			dnsindex++;
		}
	else
		{

		y = 0;
		for ( y = 0; y < 20 ; y++)
			{
			tnodedata.ifdata[y] = initif();
			}
		tsnmpdata = SNMPgetdesc(snmpip);
		tnodedata.nodeindex = tsnmpdata;
		ifnum = 0;
		ifindex = 0;
		ifnum = tsnmpdata.ifnumber;
		lastip ="0";
			while ( ifindex < ifnum)
				{   if (ifnum == 1)
					{ifindextemp = ifallince(snmpip,snmpip,V1GETCOMMAND);}
					else
					{
					ifindextemp = ifallince(lastip,snmpip,V1GETNEXTCOMMAND);
					}
					if (ifindextemp == 255)
					break;
					ifindextemp = ifindextemp - 1;
					if (ifindex >0)
					{
					netcheck = false;
					tnodedata.ifdata[ifindex] = ifgetdata(ifindextemp,lastip,snmpip,ifnum);
					tnodedata.ifdata[ifindex].ifindex = (ifindextemp ++);
					lastip = tnodedata.ifdata[ifindex].IP;
					ifiptemp = collectip(tnodedata.ifdata[ifindex].IP);
					ifclasstemp = collectip(tnodedata.ifdata[ifindex].subnet);
					tnetwork.netclass = ifclasstemp;
					tnetwork.nettype = tnodedata.ifdata[ifindex].iftype;
					tnetwork.netadd.field1 = ifiptemp.field1 & ifclasstemp.field1;
					tnetwork.netadd.field2 = ifiptemp.field2 & ifclasstemp.field2;
					tnetwork.netadd.field3 = ifiptemp.field3 & ifclasstemp.field3;
					tnetwork.netadd.field4 = ifiptemp.field4 & ifclasstemp.field4;
					for (x = 0;x < networkindex; x++)
						{
						if (networklist[x].netadd.field1 == tnetwork.netadd.field1 && networklist[x].netadd.field2 == tnetwork.netadd.field2 && networklist[x].netadd.field3 == tnetwork.netadd.field3 && networklist[x].netadd.field4 == tnetwork.netadd.field4)
							{
							netcheck = true;
							}
						}
					if (netcheck == false)
						{
						networklist[networkindex] = tnetwork;
						networkindex++;
						}

					for (x = ipindex+1;x<ipnum;x++)
						{					
						if (iplist[x].field1 == ifiptemp.field1 && iplist[x].field2 == ifiptemp.field2 && iplist[x].field3 == ifiptemp.field3 && iplist[x].field4 == ifiptemp.field4)
							{
							iplist[x].field1 =255;
							iplist[x].field2 =255;
							iplist[x].field3 =255;
							iplist[x].field4 =255;
							}
						}
					}
				else 
					{
					netcheck = false;
					tnodedata.ifdata[ifindex] = ifgetdata(ifindextemp,"0",snmpip,ifnum);
					tnodedata.ifdata[ifindex].ifindex = (ifindextemp ++);
					lastip = tnodedata.ifdata[ifindex].IP;
					ifiptemp = collectip(tnodedata.ifdata[ifindex].IP);
					ifclasstemp = collectip(tnodedata.ifdata[ifindex].subnet);
					tnetwork.netclass = ifclasstemp;
					tnetwork.nettype = tnodedata.ifdata[ifindex].iftype;
					tnetwork.netadd.field1 = ifiptemp.field1 & ifclasstemp.field1;
					tnetwork.netadd.field2 = ifiptemp.field2 & ifclasstemp.field2;
					tnetwork.netadd.field3 = ifiptemp.field3 & ifclasstemp.field3;
					tnetwork.netadd.field4 = ifiptemp.field4 & ifclasstemp.field4;

					for (x = 0;x < networkindex; x++)
						{
						if (networklist[x].netadd.field1 == tnetwork.netadd.field1 && networklist[x].netadd.field2 == tnetwork.netadd.field2 && networklist[x].netadd.field3 == tnetwork.netadd.field3 && networklist[x].netadd.field4 == tnetwork.netadd.field4)
							{
							netcheck = true;
							}
						}
					if (netcheck == false)
						{
						networklist[networkindex] = tnetwork;
						networkindex++;
						}
					for (x = ipindex+1;x<ipnum;x++)
						if (iplist[x].field1 == ifiptemp.field1 && iplist[x].field2 == ifiptemp.field2 && iplist[x].field3 == ifiptemp.field3 && iplist[x].field4 == ifiptemp.field4)
							{
							iplist[x].field1 = 255;
							iplist[x].field2 = 255;
							iplist[x].field3 = 255;
							iplist[x].field4 = 255;
							}
					}
				ifindex++;
				}
		supportlist[supportindex] = tnodedata;
		supportindex++;
		}
	}
	Status.SetWindowText("Complete");
  ipindex++;
  }
  for (x = 0;x < dnsindex;x++)
	{
	  for ( y = 0;y < networkindex;y++)
		{
		tdnsip = collectip(dnslist[x].IP);
		if ((tdnsip.field1 & networklist[y].netclass.field1) == networklist[y].netadd.field1 && (tdnsip.field2 & networklist[y].netclass.field2)== networklist[y].netadd.field2 && (tdnsip.field3 & networklist[y].netclass.field3) == networklist[y].netadd.field3 && (tdnsip.field4 & networklist[y].netclass.field4)== networklist[y].netadd.field4 )
			{
			dnslist[x].subnet = ipinttostr(networklist[y].netclass);
			break;
			}
		}
	}
  message.MessageBox("ending search");

//	dataclct.unsupportcollect(notsupportlist,notsupportindex);
	dataclct.supportcollect(supportlist,supportindex,dnslist,dnsindex);
	dataclct.networkcollect(networklist,networkindex);
	message.MessageBox("collect complete");

	
	CDialog::OnOK();
}

void SNMPcontroller::update(ipfields tiplist[1000],int tipnum,CString tcommunity)
{	int x;
	for (x = 0;x<1000;x++)
		{
		iplist[x] = tiplist[x];
		}
	ipnum = tipnum;
	snmpcommunityname = tcommunity;
//	MessageBox(tcommunity);
//	MessageBox(snmpcommunityname);
}

void SNMPcontroller::SNMPgetnext(CString snmpip,CString Myoid,CString snmpcmname)
{
  WSADATA wsaData;
  SOCKET sockRaw;
  WSAStartup(MAKEWORD(2,1),&wsaData);
  sockRaw = WSASocket (AF_INET,
					   SOCK_DGRAM,
					   IPPROTO_UDP,
					   NULL, 0,0);
	Packet* snmppkt = new Packet(V1GETNEXTCOMMAND);
	snmppkt->Community(snmpcmname.GetBuffer(1));
	snmppkt->RequestId(123);
	OidVarbind* oid = new OidVarbind(Myoid.GetBuffer(1));
    Varbind* vb = new StringVarbind();
    VbPair* vbp = new VbPair(oid, vb);
    snmppkt->Add(vbp);
	UdpClient* udp = new UdpClient(161,snmpip.GetBuffer(1));
	udp->Timeout(1);
    udp->Send(snmppkt);
	Packet* retP = udp->Receive(0);
	 if (retP)
		{if (retP->RequestId() == 123)
			{
			if (retP->ErrorStatus() == NOERROR)
				{
				querydata = retP->VbData(1);
				querytype = retP->VbType(1);
				}
			}
		}
	delete(snmppkt);
	delete(retP);
	delete(udp);
	WSACleanup();

}
