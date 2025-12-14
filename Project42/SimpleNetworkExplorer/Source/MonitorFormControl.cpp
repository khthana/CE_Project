// MonitorFormControl.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "MonitorFormControl.h"
#include <winsock2.h>
#include "vbs.h"
#include "UdpClient.h"
#include <stdio.h>
#include <stdlib.h>
#include "newshowingmonitordata.h"
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// MonitorFormControl dialog


MonitorFormControl::MonitorFormControl(CWnd* pParent /*=NULL*/)
	: CDialog(MonitorFormControl::IDD, pParent)
{
	//{{AFX_DATA_INIT(MonitorFormControl)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void MonitorFormControl::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(MonitorFormControl)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
	
}


BEGIN_MESSAGE_MAP(MonitorFormControl, CDialog)
	//{{AFX_MSG_MAP(MonitorFormControl)
	ON_WM_TIMER()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// MonitorFormControl message handlers

void MonitorFormControl::OnTimer(UINT nIDEvent) 
{	if (show1.startupdate)// && !show1.canexit)
		{
		if (testinterval == false)
			{
			testinterval = true;
			CString snmpip;
			snmpip = targetip;
			if (!show1.exited)
				{
				updatedata(snmpip);
				show1.setifnumber(inrate,outrate,totalin,totalout,erinrate,eroutrate,totalerin,totalerout,pktinrate,pktoutrate,totalpktin,totalpktout,unicastinrate,unicastoutrate,multicastinrate,multicastoutrate,totalunicastin,totalunicastout,totalmulticastin,totalmulticastout,intervalnumber);
				show1.updatedata(intervalnumber);
				intervalnumber = 1;
				}
			else
				{
				KillTimer(1+processID);
				}
			testinterval = false;
			}
		else
			{
			intervalnumber++;
			}
		}
	CDialog::OnTimer(nIDEvent);

}




void MonitorFormControl::OnOK() 
{	char snmpip[16];
	char intervalt[2];
	testinterval = false;
	GetDlgItemText(IDC_IP,snmpip,16);
	GetDlgItemText(IDC_interval,intervalt,2);
	Intervaltime = atoi(intervalt);
	Intervaltime = Intervaltime * 1000;
	targetip = snmpip;
	testmutual();
	openagent = snmpcollect.SNMPopenagent(targetip,"1.3.6.1.2.1.1.5","0","public");
	freemutual();
	if (openagent)
		{
		collectif(snmpip);
		show1.startupdate = false;
		show1.canexit = false;
		show1.exited = false;
		show1.setifnumber(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1);
		show1.setstaticvar(Intervaltime/1000,ifspeed,ifnumber,processID);
		SetTimer(1+processID,Intervaltime,NULL);
//		show1.DoModal();
		show1.Create(IDD_showdata,NULL);
		show1.ShowWindow(SW_SHOW);
		OnTimer(1+processID);
		}
	else { MessageBox("not support");}
	CDialog::OnOK();

}

void MonitorFormControl::collectif(CString snmpip)
{	int ifnum;
	int ifindex;
	ifnum = collectifnum(snmpip);
	ifnumber = ifnum;
	totalin = 0;
	totalout = 0;
	pktinrate = 0;
	totalpktin = 0;
	pktoutrate = 0;
	totalpktout = 0;
	tpktin = 0;
	tpktout = 0;
	ifspeed = 0;
	unicastinrate = 0;
	unicastoutrate = 0;
	multicastinrate = 0;
	multicastoutrate = 0;
	totalunicastin = 0;
	totalunicastout = 0;
	totalmulticastin = 0;
	totalmulticastout = 0;
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.4.3","0","public");
	freemutual();
	tpktin = atoi(snmpcollect.querydata);
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.4.10","0","public");
	freemutual();
	tpktout = atoi(snmpcollect.querydata);
	for (ifindex = 0;ifindex < ifnum;ifindex++)
		{
		if (ifindex == 50)
			{break;}
		if (ifindex == 0)
			{
			monitoringdata[ifindex] = initif(snmpip,0);
			inrate = 0;
			outrate = 0;
			totalin =0;
			totalout =0;
			erinrate =0;
			eroutrate =0;
			totalerin =0;
			totalerout =0;
			}
		else
			{
			monitoringdata[ifindex] = initif(snmpip,monitoringdata[ifindex-1].ifindex);
			}
	}
}

int MonitorFormControl::collectifnum(CString snmpip)
{	int returnifnum;
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.1","0","public");
	freemutual();
	returnifnum = atoi(snmpcollect.querydata);
	if(returnifnum >50)
		{returnifnum = 50;}
	return returnifnum;

}

monitordata MonitorFormControl::initif(CString snmpip,int oldifindex)
{
  monitordata returnvalue;
  CString ObjectID;
  CString newifindex;
  WSADATA wsaData;
  SOCKET sockRaw;
  char stroldifindex[5];
  char* toid;
  testmutual();
  WSAStartup(MAKEWORD(2,1),&wsaData);
  sockRaw = WSASocket (AF_INET,
					   SOCK_DGRAM,
					   IPPROTO_UDP,
					   NULL, 0,0);
    ObjectID = "1.3.6.1.2.1.2.2.1.1.";
	_itoa(oldifindex,stroldifindex,10);
	ObjectID += stroldifindex;
	toid = ObjectID.GetBuffer(1);
    Packet* snmppkt = new Packet(V1GETNEXTCOMMAND);
	snmppkt->Community("public");
	snmppkt->RequestId(123);
	OidVarbind* oid = new OidVarbind(toid);
    Varbind* vb = new StringVarbind();
    VbPair* vbp = new VbPair(oid, vb);
    snmppkt->Add(vbp);
	UdpClient* udp = new UdpClient(161,snmpip.GetBuffer(1));
    udp->Send(snmppkt);
	Packet* retP = udp->Receive(0);
	 if (retP && retP->RequestId() == 123)
	  if (retP->ErrorStatus() == NOERROR)
	{      
	returnvalue.ifindex = atoi(retP->VbData(1));
	newifindex = retP->VbData(1);
	}
	delete(snmppkt);
	delete(retP);
	delete(udp);

	WSACleanup();
	freemutual();
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.10",newifindex,"public");
	freemutual();
	returnvalue.inoct = atoi(snmpcollect.querydata);
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.14",newifindex,"public");
	freemutual();
	returnvalue.inerror = atoi(snmpcollect.querydata);
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.16",newifindex,"public");
	freemutual();
	returnvalue.outoct = atoi(snmpcollect.querydata);
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.20",newifindex,"public");
	freemutual();
	returnvalue.outerror = atoi(snmpcollect.querydata);
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.5",newifindex,"public");
	freemutual();
	ifspeed += atoi(snmpcollect.querydata);
	testmutual();
	if (snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.12",newifindex,"public"))
		{returnvalue.inmltcst = atoi(snmpcollect.querydata);}
	else
		{returnvalue.inmltcst = 0;}
	freemutual();
	testmutual();
	if (snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.18",newifindex,"public"))
		{returnvalue.outmltcst = atoi(snmpcollect.querydata);}
	else
		{returnvalue.outmltcst = 0;}
	freemutual();
	testmutual();
	if (snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.11",newifindex,"public"))
		{returnvalue.inunicst = atoi(snmpcollect.querydata);}
	else
		{returnvalue.inunicst = 0;}
	freemutual();
	testmutual();
	if (snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.17",newifindex,"public"))
		{returnvalue.outunicst = atoi(snmpcollect.querydata);}
	else
		{returnvalue.outunicst = 0;}
	freemutual();
	return returnvalue;
}

void MonitorFormControl::updatedata(CString snmpip)
{	monitordata infochange;
	UINT tinrate;
	UINT toutrate;
	UINT terinrate;
	UINT teroutrate;
	UINT tunicastinrate;
	UINT tunicastoutrate;
	UINT tmulticastinrate;
	UINT tmulticastoutrate;
	tinrate = totalin;
	toutrate = totalout;
	terinrate = totalerin;
	teroutrate = totalerout;
	tunicastinrate = totalunicastin;
	tunicastoutrate = totalunicastout;
	tmulticastinrate = totalmulticastin;
	tmulticastoutrate = totalmulticastout;
	int tindex;
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.4.3","0","public");
	freemutual();
	pktinrate = atoi(snmpcollect.querydata) - tpktin;
	totalpktin += pktinrate;
	tpktin = atoi(snmpcollect.querydata);
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.4.10","0","public");
	freemutual();
	pktoutrate = atoi(snmpcollect.querydata) - tpktout;
	totalpktout += pktoutrate;
	tpktout = atoi(snmpcollect.querydata);
	for (tindex = 0;tindex < ifnumber;tindex ++)
		{
		if (tindex == 50)
			{break;}
		infochange = getinfo(snmpip,monitoringdata[tindex].ifindex);
		changedata[tindex].inoct = infochange.inoct - monitoringdata[tindex].inoct;
		changedata[tindex].inerror = infochange.inerror - monitoringdata[tindex].inerror;
		changedata[tindex].outoct = infochange.outoct - monitoringdata[tindex].outoct;
		changedata[tindex].outerror = infochange.outerror - monitoringdata[tindex].outerror;
		changedata[tindex].inmltcst = infochange.inmltcst - monitoringdata[tindex].inmltcst;
		changedata[tindex].outmltcst = infochange.outmltcst - monitoringdata[tindex].outmltcst;
		changedata[tindex].inunicst = infochange.inunicst - monitoringdata[tindex].inunicst;
		changedata[tindex].outunicst = infochange.outunicst - monitoringdata[tindex].outunicst;
		monitoringdata[tindex].inerror = infochange.inerror;
		monitoringdata[tindex].inoct = infochange.inoct;
		monitoringdata[tindex].outerror = infochange.outerror;
		monitoringdata[tindex].outoct = infochange.outoct;
		monitoringdata[tindex].inmltcst = infochange.inmltcst;
		monitoringdata[tindex].outmltcst = infochange.outmltcst;
		monitoringdata[tindex].inunicst = infochange.inunicst;
		monitoringdata[tindex].outunicst = infochange.outunicst;
		totalin += changedata[tindex].inoct;
		totalout += changedata[tindex].outoct;
		totalerin += changedata[tindex].inerror;
		totalerout += changedata[tindex].outerror;
		totalunicastin += changedata[tindex].inunicst;
		totalmulticastin += changedata[tindex].inmltcst;
		totalunicastout += changedata[tindex].outunicst;
		totalmulticastout += changedata[tindex].outmltcst;
	}
	inrate = totalin - tinrate;
	outrate = totalout - toutrate;
	erinrate = totalerin - terinrate;
	eroutrate = totalerout - teroutrate;
	unicastinrate = totalunicastin - tunicastinrate;
	unicastoutrate = totalunicastout - tunicastoutrate;
	multicastinrate = totalmulticastin - tmulticastinrate;
	multicastoutrate = totalmulticastout - tmulticastoutrate;
}

monitordata MonitorFormControl::getinfo(CString snmpip,int ifindex)
{	char strifindex[2];
	monitordata returnvalue;
	_itoa(ifindex,strifindex,10);
	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.10",strifindex,"public");
	freemutual();
	returnvalue.inoct = atoi(snmpcollect.querydata);

	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.14",strifindex,"public");
	freemutual();
	returnvalue.inerror = atoi(snmpcollect.querydata);

	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.16",strifindex,"public");
	freemutual();
	returnvalue.outoct = atoi(snmpcollect.querydata);

	testmutual();
	snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.20",strifindex,"public");
	freemutual();
	returnvalue.outerror = atoi(snmpcollect.querydata);

	testmutual();
	if (snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.12",strifindex,"public"))
		{returnvalue.inmltcst = atoi(snmpcollect.querydata);}
	else
		{returnvalue.inmltcst = 0;}
	freemutual();

	testmutual();
	if (snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.18",strifindex,"public"))
		{returnvalue.outmltcst = atoi(snmpcollect.querydata);}
	else
		{returnvalue.outmltcst = 0;}
	freemutual();

	testmutual();
	if (snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.11",strifindex,"public"))
		{returnvalue.inunicst = atoi(snmpcollect.querydata);}
	else
		{returnvalue.inunicst = 0;}
	freemutual();

	testmutual();
	if (snmpcollect.SNMPopenagent(snmpip,"1.3.6.1.2.1.2.2.1.17",strifindex,"public"))
		{returnvalue.outunicst = atoi(snmpcollect.querydata);}
	else
		{returnvalue.outunicst = 0;}
	freemutual();

	return returnvalue;
}

void MonitorFormControl::OnCancel() 
{
	KillTimer(1+processID);
	CDialog::OnCancel();
}

UINT MonitorFormControl::Getinrate()
{
	UINT returnvalue;
	returnvalue = inrate;
	return returnvalue;
}

UINT MonitorFormControl::Getoutrate()
{
	UINT returnvalue;
	returnvalue = outrate;
	return returnvalue;

}

UINT MonitorFormControl::Geterrorinrate()
{
	UINT returnvalue;
	returnvalue = erinrate;
	return returnvalue;

}

UINT MonitorFormControl::Geterroroutrate()
{
	UINT returnvalue;
	returnvalue = eroutrate;
	return returnvalue;

}

void MonitorFormControl::startmon(CString ipadd)
{
	CEdit message;
	targetip = ipadd;
	testmutual();
	openagent = snmpcollect.SNMPopenagent(targetip,"1.3.6.1.2.1.1.5","0","public");
	freemutual();
	if (openagent)
		{
		collectif(ipadd);
		}
	else { message.MessageBox("not support");}
}

void MonitorFormControl::stopmon()
{
	KillTimer(1+processID);
}

UINT MonitorFormControl::Gettotalin()
{
	UINT returnvalue;
	returnvalue = totalin;
	return returnvalue;
}

UINT MonitorFormControl::Gettotalout()
{
	UINT returnvalue;
	returnvalue = totalout;
	return returnvalue;
}

UINT MonitorFormControl::Gettotalerrorin()
{
	UINT returnvalue;
	returnvalue = totalerin;
	return returnvalue;
}

UINT MonitorFormControl::Gettotalerrorout()
{
	UINT returnvalue;
	returnvalue = totalerout;
	return returnvalue;
}

UINT MonitorFormControl::Getifspeed()
{
	UINT returnvalue;
	returnvalue = ifspeed;
	return returnvalue;
}

UINT MonitorFormControl::Getpacketinrate()
{
	UINT returnvalue;
	returnvalue = pktinrate;
	return returnvalue;
}

UINT MonitorFormControl::Getpacketoutrate()
{
	UINT returnvalue;
	returnvalue = pktoutrate;
	return returnvalue;

}

UINT MonitorFormControl::Getmulticastinrate()
{
	UINT returnvalue;
	returnvalue = multicastinrate;
	return returnvalue;

}

UINT MonitorFormControl::Getmulticastoutrate()
{
	UINT returnvalue;
	returnvalue = multicastoutrate;
	return returnvalue;

}

UINT MonitorFormControl::Getunicastinrate()
{
	UINT returnvalue;
	returnvalue = unicastinrate;
	return returnvalue;

}

UINT MonitorFormControl::Getunicastoutrate()
{
	UINT returnvalue;
	returnvalue = unicastoutrate;
	return returnvalue;

}

UINT MonitorFormControl::Gettotalpacketin()
{
	UINT returnvalue;
	returnvalue = totalpktin;
	return returnvalue;

}

UINT MonitorFormControl::Gettotalpacketout()
{
	UINT returnvalue;
	returnvalue = totalpktout;
	return returnvalue;

}

UINT MonitorFormControl::Gettotalmulticastin()
{
	UINT returnvalue;
	returnvalue = totalmulticastin;
	return returnvalue;

}

UINT MonitorFormControl::Gettotalmulticastout()
{
	UINT returnvalue;
	returnvalue = totalmulticastout;
	return returnvalue;

}

UINT MonitorFormControl::Gettotalunicastin()
{
	UINT returnvalue;
	returnvalue = totalunicastin;
	return returnvalue;

}

UINT MonitorFormControl::Gettotalunicastout()
{
	UINT returnvalue;
	returnvalue = totalunicastout;
	return returnvalue;

}

void MonitorFormControl::setmutualex(int tprocessid,bool* tmutualex)
{
	processID = tprocessid;
	mutualex = tmutualex;
}

bool MonitorFormControl::testmutual()
{
	if (*mutualex == false)
		{
		*mutualex  = true;
		}
	else
		{
		while(*mutualex == true)
			{}
		*mutualex = true;
		}
	return true;
}

void MonitorFormControl::freemutual()
{
	*mutualex = false;
}
