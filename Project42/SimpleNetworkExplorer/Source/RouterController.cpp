// RouterController.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "RouterController.h"
#include "VBs.h"
#include "UdpClient.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// RouterController dialog


RouterController::RouterController(CWnd* pParent /*=NULL*/)
	: CDialog(RouterController::IDD, pParent)
{
	//{{AFX_DATA_INIT(RouterController)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void RouterController::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(RouterController)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(RouterController, CDialog)
	//{{AFX_MSG_MAP(RouterController)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// RouterController message handlers

void RouterController::OnOK() 
{	char snmpip[16];
	char snmpcmname[16];
	char hoptosearch[1];
	ipfield iplist[1000];
	ipfield rtsearchlist[50];
	RECT rect1;
	int rtsearchindex = 0;
	int hopno;
	int x;
	int y;
	CString rtip;
	int ipindex;
	ipindex = 0;
	rtindex= 0;
	rtnextindex = 0;
	GetDlgItemText(IDC_IP,snmpip,16);
	GetDlgItemText(IDC_CMname,snmpcmname,16);
	GetDlgItemText(IDC_Hop,hoptosearch,1);
	hopno = atoi(hoptosearch);
	rect1.top = 140;
	rect1.bottom = 160;
	rect1.left = 100;
	rect1.right = 200;
	label[0].Create("Searching in",WS_VISIBLE,rect1,this,6000);
	rect1.left = 250;
	rect1.right = 280;
	label[1].Create("hop",WS_VISIBLE,rect1,this,6001);
	rect1.top = 160;
	rect1.bottom = 180;
	rect1.left = 100;
	rect1.right = 200;
	label[2].Create("Collect IP from",WS_VISIBLE,rect1,this,6002);
	rect1.top = 180;
	rect1.bottom = 200;
	rect1.left = 100;
	rect1.right = 250;
	label[3].Create("Found Other Router",WS_VISIBLE,rect1,this,6003);
	rect1.top = 140;
	rect1.bottom = 160;
	rect1.left = 200;
	rect1.right = 250;
	data[0].Create("0",WS_VISIBLE,rect1,this,6004);
	rect1.top = 160;
	rect1.bottom = 180;
	rect1.left = 250;
	rect1.right = 400;
	data[1].Create("0",WS_VISIBLE,rect1,this,6005);
	rect1.top = 180;
	rect1.bottom = 200;
	rect1.left = 250;
	rect1.right = 400;
	data[2].Create("0",WS_VISIBLE,rect1,this,6006);
	rtip = snmpip;
	rtsearchlist[rtsearchindex] = snmpcontrol.collectip(rtip);
	rtlist[rtindex] = rtsearchlist[rtsearchindex];
	rtsearchindex++;
	rtindex++;
	hopno = 1;
	label[0].SetWindowText("Searching in");
	label[1].SetWindowText("hop");
	label[2].SetWindowText("Collect IP from");
	label[3].SetWindowText("Found Other Router");
	if (snmpcontrol.SNMPopenagent(rtip,"1.3.6.1.2.1.1.5","0",snmpcmname))
		{
		for (x=0;x<hopno;x++)
			{
			_itoa(x+1,hoptosearch,10);
			data[0].SetWindowText(hoptosearch);
			rtnextindex = 0;
			for (y=0;y<rtsearchindex;y++)
				{
				if (x == 0)
					{
					iplist[ipindex] = rtsearchlist[y];
					ipindex++;
					}
				rtip = snmpcontrol.ipinttostr(rtsearchlist[y]);
				data[1].SetWindowText(rtip);
				if (snmpcontrol.SNMPopenagent(rtip,"1.3.6.1.2.1.1.5","0",snmpcmname))
					{
					getnexthoprouter(rtip,snmpcmname);
					iplist[ipindex] = getip(rtip,snmpcmname,"0","0");
					ipindex++;
					while (iplist[ipindex-1].field1 != 0 && iplist[ipindex-1].field2 != 0 && iplist[ipindex-1].field3 != 0 && iplist[ipindex-1].field4 != 0)
						{
						iplist[ipindex] = getip(rtip,snmpcmname,oldif,oldip);
						ipindex++;
						}
					ipindex--;
					}
				}
			for (y=0;y<rtnextindex;y++)
				{
				rtsearchlist[y] = rtnextlist[y];
				}
			}
		snmpcontrol.update(iplist,ipindex,snmpcmname);
		snmpcontrol.DoModal();
		}
	else
		{
		MessageBox("Not support SNMP");
		}
	CDialog::OnOK();
}

ipfield RouterController::getip(CString snmpip,CString snmpcmname,CString indexif,CString indexip)
{	ipfield returnip;
	WSADATA wsaData;
	SOCKET sockRaw;
	CString Myoid;
	char* CompleteOID;
	char* Community;
	CString ifnext;
	CString ipnext;
	CString tip;
	WSAStartup(MAKEWORD(2,1),&wsaData);
	sockRaw = WSASocket (AF_INET,
					   SOCK_DGRAM,
					   IPPROTO_UDP,
					   NULL, 0,0);
	Myoid = "1.3.6.1.2.1.4.22.1.1";
	Myoid += ".";
	Myoid += indexif;
	if (indexif != "0")
		{
		Myoid += ".";
		Myoid += indexip;
		}
	Community = snmpcmname.GetBuffer(1);
	CompleteOID = Myoid.GetBuffer(1);
	Packet* snmppkt = new Packet(V1GETNEXTCOMMAND);
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
				{
				if ( retP->VbType(1) == "octet string" )
					{
					returnip.field1 = 0;
					returnip.field2 = 0;
					returnip.field3 = 0;
					returnip.field4 = 0;
					return returnip;
					}
				ifnext = retP->VbData(1);
				oldif = ifnext;
				}
			}
		}
	delete(snmppkt);
	delete(retP);
	delete(udp);

	Myoid = "1.3.6.1.2.1.4.22.1.3";
	Myoid += ".";
	Myoid += indexif;
	if (indexif != "0")
		{
		Myoid += ".";
		Myoid += indexip;
		}
	Community = snmpcmname.GetBuffer(1);
	CompleteOID = Myoid.GetBuffer(1);
	Packet* snmppkt2 = new Packet(V1GETNEXTCOMMAND);
	snmppkt2->Community(Community);
	snmppkt2->RequestId(123);
	OidVarbind* oid2 = new OidVarbind(CompleteOID);
    Varbind* vb2 = new StringVarbind();
    VbPair* vbp2 = new VbPair(oid2, vb2);
    snmppkt2->Add(vbp2);
	UdpClient* udp2 = new UdpClient(161,snmpip.GetBuffer(1));
	udp2->Timeout(1);
    udp2->Send(snmppkt2);
	Packet* retP2 = udp2->Receive(0);
	 if (retP2)
		{if (retP2->RequestId() == 123)
			{
			if (retP2->ErrorStatus() == NOERROR)
				{
				if ( retP2->VbType(1) == "integer" )
					{
					returnip.field1 = 0;
					returnip.field2 = 0;
					returnip.field3 = 0;
					returnip.field4 = 0;
					return returnip;
					}
				ipnext = retP2->VbData(1);
				oldip = ipnext;
				returnip = snmpcontrol.collectip(ipnext);
				}
			}
		}
	delete(snmppkt2);
	delete(retP2);
	delete(udp2);

	WSACleanup();

	return returnip;
}

void RouterController::getnexthoprouter(CString rtip,CString snmpcmname)
{	int x;
	CString nrt;
	bool testip;
	ipfield tip;
	tip = getnextip(rtip,"0",snmpcmname);
	while (tip.field1 != 0 && tip.field2 != 0 && tip.field3 != 0 && tip.field4 != 0)
		{
		testip = false;
		for (x = 0;x < rtindex;x++)
			{
			if (rtlist[x].field1 == tip.field1 && rtlist[x].field2 == tip.field2 && rtlist[x].field3 == tip.field3 && rtlist[x].field4 == tip.field4)
				{
				testip = true;
				break;
				}
			}
		if (testip == false)
			{
			rtlist[rtindex].field1 = tip.field1;
			rtlist[rtindex].field2 = tip.field2;
			rtlist[rtindex].field3 = tip.field3;
			rtlist[rtindex].field4 = tip.field4;
			rtindex++;
			}
		tip = getnextip(rtip,snmpcontrol.ipinttostr(tip),snmpcmname);
		}
	tip = getnextrt(rtip,"0",snmpcmname);
	while (tip.field1 != 255 && tip.field2 != 255 && tip.field3 != 255 && tip.field4 != 255)
		{
		testip = false;
		for ( x = 0;x < rtindex;x++)
			{
			if (rtlist[x].field1 == tip.field1 && rtlist[x].field2 == tip.field2 && rtlist[x].field3 == tip.field3 && rtlist[x].field4 == tip.field4)
				{
				testip = true;
				break;
				}
			}
		if (testip == false)
			{
			rtlist[rtindex].field1 = tip.field1;
			rtnextlist[rtnextindex].field1 = tip.field1;
			rtlist[rtindex].field2 = tip.field2;
			rtnextlist[rtnextindex].field2 = tip.field2;
			rtlist[rtindex].field3 = tip.field3;
			rtnextlist[rtnextindex].field3 = tip.field3;
			rtlist[rtindex].field4 = tip.field4;
			rtnextlist[rtnextindex].field4 = tip.field4;
			nrt = snmpcontrol.ipinttostr(rtnextlist[rtnextindex]);
			data[2].SetWindowText(nrt);
			rtindex++;
			rtnextindex++;
			}
		tip = getnextrt(rtip,nextrthop,snmpcmname);
		}

}

ipfield RouterController::getnextip(CString rtip,CString oldip,CString snmpcmname)
{
	ipfield returnvalue;
	CString Myoid;
	CString nextip;
	Myoid = "1.3.6.1.2.1.4.20.1.1.";
	Myoid += oldip;
	snmpcontrol.SNMPgetnext(rtip,Myoid,snmpcmname);
	if (snmpcontrol.querytype == "IpAddress")
		{
		nextip = snmpcontrol.querydata;
		returnvalue = snmpcontrol.collectip(nextip);
		}
	else
		{
		returnvalue.field1 = 0;
		returnvalue.field2 = 0;
		returnvalue.field3 = 0;
		returnvalue.field4 = 0;
		}
	return returnvalue;
}

ipfield RouterController::getnextrt(CString rtip,CString nexthop,CString snmpcmname)
{
	ipfield returnvalue;
	CString Myoid;
	CString nexthop2;
	CString nextip;
	Myoid = "1.3.6.1.2.1.4.21.1.1.";
	Myoid += nexthop;
	snmpcontrol.SNMPgetnext(rtip,Myoid,snmpcmname);
	if (snmpcontrol.querytype == "IpAddress")
		{
//		nexthop2 
		nextrthop = snmpcontrol.querydata;
		
		Myoid = "1.3.6.1.2.1.4.21.1.7.";
		Myoid += nexthop;
		snmpcontrol.SNMPgetnext(rtip,Myoid,snmpcmname);
		if (snmpcontrol.querytype == "IpAddress")
			{
			nextip = snmpcontrol.querydata;
			returnvalue = snmpcontrol.collectip(nextip);
			}
		else
			{
			returnvalue.field1 = 255;
			returnvalue.field2 = 255;
			returnvalue.field3 = 255;
			returnvalue.field4 = 255;
			}
		}
	else
		{
		returnvalue.field1 = 255;
		returnvalue.field2 = 255;
		returnvalue.field3 = 255;
		returnvalue.field4 = 255;
		}

	return returnvalue;
}
