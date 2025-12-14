// newshowingmonitordata.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "newshowingmonitordata.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// newshowingmonitordata dialog


newshowingmonitordata::newshowingmonitordata(CWnd* pParent /*=NULL*/)
	: CDialog(newshowingmonitordata::IDD, pParent)
{
	//{{AFX_DATA_INIT(newshowingmonitordata)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void newshowingmonitordata::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(newshowingmonitordata)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(newshowingmonitordata, CDialog)
	//{{AFX_MSG_MAP(newshowingmonitordata)
	ON_WM_CTLCOLOR()
	ON_WM_CANCELMODE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// newshowingmonitordata message handlers
void newshowingmonitordata::createdata()
{
	CDC *theLine;
	theLine = this->GetDC();
// Draw the First Table
	theLine->MoveTo(20,120);
	theLine->LineTo(20,230);
	theLine->LineTo(605,230);
	theLine->LineTo(605,120);
	theLine->LineTo(20,120);

	theLine->MoveTo(99,120);
	theLine->LineTo(99,230);

	theLine->MoveTo(195,120);
	theLine->LineTo(195,230);

	theLine->MoveTo(295,120);
	theLine->LineTo(295,230);

	theLine->MoveTo(395,120);
	theLine->LineTo(395,230);

	theLine->MoveTo(495,120);
	theLine->LineTo(495,230);

	theLine->MoveTo(20,155);
	theLine->LineTo(605,155);

// Draw the Second Table
	theLine->MoveTo(20,240);
	theLine->LineTo(20,350);
	theLine->LineTo(495,350);
	theLine->LineTo(495,240);
	theLine->LineTo(20,240);

	theLine->MoveTo(99,240);
	theLine->LineTo(99,350);

	theLine->MoveTo(195,240);
	theLine->LineTo(195,350);

	theLine->MoveTo(295,240);
	theLine->LineTo(295,350);

	theLine->MoveTo(395,240);
	theLine->LineTo(395,350);

	theLine->MoveTo(20,275);
	theLine->LineTo(495,275);

// Draw the Third Table
	theLine->MoveTo(20,360);
	theLine->LineTo(20,470);
	theLine->LineTo(295,470);
	theLine->LineTo(295,360);
	theLine->LineTo(20,360);

	theLine->MoveTo(99,360);
	theLine->LineTo(99,470);

	theLine->MoveTo(195,360);
	theLine->LineTo(195,470);

	theLine->MoveTo(295,360);
	theLine->LineTo(295,470);

	theLine->MoveTo(20,395);
	theLine->LineTo(295,395);

	this->ReleaseDC(theLine);// release the device context 

	RECT rect1;
	char tdata1[3];
	CString tdata2;
	minuitbyte = 0;
	hourbyte = 0;
	minuitcount = 0;
	hourcount = 0;

//	CDC* pDC;
//	pDC = this->GetDC();
//	pDC->SetTextColor(RGB(0,0,255));

	rect1.top =10;
	rect1.bottom = 30;
	rect1.left = 50;
	rect1.right = 200;
	label[1].Create("Interface Number",WS_VISIBLE|WS_CHILD,rect1,this,8001+processID);
	rect1.left = 240;
	rect1.right = 390;
	label[2].Create("Total Interface Speed",WS_VISIBLE|WS_CHILD,rect1,this,8002+processID);
	rect1.top = 40;
	rect1.bottom = 60;
	rect1.left = 50;
	rect1.right = 130;
	label[3].Create("Utilization",WS_VISIBLE|WS_CHILD,rect1,this,8003+processID);
	rect1.left = 240;
	rect1.right = 390;
	label[4].Create("1 Minute Average",WS_VISIBLE|WS_CHILD,rect1,this,8004+processID);
	rect1.top = 60;
	rect1.bottom = 80;
	label[5].Create("1 Hour Average",WS_VISIBLE|WS_CHILD,rect1,this,8005+processID);
	rect1.top = 130;
	rect1.bottom = 150;
	rect1.left = 100;
	rect1.right = 190;
	label[6].Create("Packet",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8006+processID);
	rect1.left = 200;
	rect1.right = 290;
	label[7].Create("Byte",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8007+processID);
	rect1.left = 300;
	rect1.right = 390;
	label[8].Create("Packet/s",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8008+processID);
	rect1.left = 400;
	rect1.right = 490;
	label[9].Create("Byte/s",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8009+processID);
	rect1.left = 500;
	rect1.right = 590;
	label[10].Create("% Utilization",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8010+processID);
	rect1.top = 170;
	rect1.bottom = 190;
	rect1.left = 50;
	rect1.right = 99;
	label[11].Create("In",WS_VISIBLE|WS_CHILD,rect1,this,8011+processID);
	rect1.top = 190;
	rect1.bottom = 210;
	label[12].Create("Out",WS_VISIBLE|WS_CHILD,rect1,this,8012+processID);
	rect1.top = 210;
	rect1.bottom = 230;
	label[13].Create("Total",WS_VISIBLE|WS_CHILD,rect1,this,8013+processID);
	rect1.top = 250;
	rect1.bottom = 270;
	rect1.left = 100;
	rect1.right = 190;
	label[14].Create("Unicast",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8014+processID);
	rect1.left = 200;
	rect1.right = 290;
	label[15].Create("Multicast",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8015+processID);
	rect1.left = 300;
	rect1.right = 390;
	label[16].Create("Unicast/s",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8016+processID);
	rect1.left = 400;
	rect1.right = 490;
	label[17].Create("Multicast/s",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8017+processID);
	rect1.top = 290;
	rect1.bottom = 310;
	rect1.left = 50;
	rect1.right = 99;
	label[20].Create("In",WS_VISIBLE|WS_CHILD,rect1,this,8020+processID);
	rect1.top = 310;
	rect1.bottom = 330;
	label[21].Create("Out",WS_VISIBLE|WS_CHILD,rect1,this,8021+processID);
	rect1.top = 330;
	rect1.bottom = 350;
	label[22].Create("Total",WS_VISIBLE|WS_CHILD,rect1,this,8022+processID);
	rect1.top = 370;
	rect1.bottom = 390;
	rect1.left = 100;
	rect1.right = 190;
	label[18].Create("Error",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8018+processID);
	rect1.left = 200;
	rect1.right = 290;
	label[19].Create("Error/s",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,8019+processID);
	rect1.top = 410;
	rect1.bottom = 430;
	rect1.left = 50;
	rect1.right = 99;
	label[23].Create("In",WS_VISIBLE|WS_CHILD,rect1,this,8023+processID);
	rect1.top = 430;
	rect1.bottom = 450;
	label[24].Create("Out",WS_VISIBLE|WS_CHILD,rect1,this,8024+processID);
	rect1.top = 450;
	rect1.bottom = 470;
	label[25].Create("Total",WS_VISIBLE|WS_CHILD,rect1,this,8025+processID);
	rect1.top = 170;
	rect1.bottom = 190;
	rect1.left = 200;
	rect1.right = 290;
	data[7].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9007+processID);
	rect1.top = 190;
	rect1.bottom = 210;
	data[8].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9008+processID);
	rect1.top = 210;
	rect1.bottom = 230;
	data[9].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9009+processID);
	rect1.top = 170;
	rect1.bottom = 190;
	rect1.left = 400;
	rect1.right = 490;
	data[13].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9013+processID);
	rect1.top = 190;
	rect1.bottom = 210;
	data[14].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9014+processID);
	rect1.top = 210;
	rect1.bottom = 230;
	data[15].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9015+processID);
	rect1.top = 410;
	rect1.bottom = 430;
	rect1.left = 100;
	rect1.right = 190;
	data[31].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9031+processID);
	rect1.top = 430;
	rect1.bottom = 450;
	data[32].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9032+processID);
	rect1.top = 450;
	rect1.bottom = 470;
	data[33].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9033+processID);
	rect1.top = 410;
	rect1.bottom = 430;
	rect1.left = 200;
	rect1.right = 290;
	data[34].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9034+processID);
	rect1.top = 430;
	rect1.bottom = 450;
	data[35].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9035+processID);
	rect1.top = 450;
	rect1.bottom = 470;
	data[36].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9036+processID);
	rect1.top = 170;
	rect1.bottom = 190;
	rect1.left = 500;
	rect1.right = 590;
	data[16].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9016+processID);
	rect1.top = 190;
	rect1.bottom = 210;
	data[17].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9017+processID);
	rect1.top = 210;
	rect1.bottom = 230;
	data[18].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9018+processID);
	rect1.top = 170;
	rect1.bottom = 190;
	rect1.left = 300;
	rect1.right = 390;
	data[10].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9010+processID);
	rect1.top = 190;
	rect1.bottom = 210;
	data[11].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9011+processID);
	rect1.top = 210;
	rect1.bottom = 230;
	data[12].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9012+processID);
	rect1.top = 170;
	rect1.bottom = 190;
	rect1.left = 100;
	rect1.right = 190;
	data[4].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9004+processID);
	rect1.top = 190;
	rect1.bottom = 210;
	data[5].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9005+processID);
	rect1.top = 210;
	rect1.bottom = 230;
	data[6].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9006+processID);

	rect1.top = 290;
	rect1.bottom = 310;
	rect1.left = 300;
	rect1.right = 390;
	data[25].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9025+processID);
	rect1.top = 310;
	rect1.bottom = 330;
	data[26].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9026+processID);
	rect1.top = 330;
	rect1.bottom = 350;
	data[27].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9027+processID);

	rect1.top = 290;
	rect1.bottom = 310;
	rect1.left = 400;
	rect1.right = 490;
	data[28].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9028+processID);
	rect1.top = 310;
	rect1.bottom = 330;
	data[29].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9029+processID);
	rect1.top = 330;
	rect1.bottom = 350;
	data[30].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9030+processID);

	rect1.top = 290;
	rect1.bottom = 310;
	rect1.left = 100;
	rect1.right = 190;
	data[19].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9019+processID);
	rect1.top = 310;
	rect1.bottom = 330;
	data[20].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9020+processID);
	rect1.top = 330;
	rect1.bottom = 350;
	data[21].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9021+processID);

	rect1.top = 290;
	rect1.bottom = 310;
	rect1.left = 200;
	rect1.right = 290;
	data[22].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9022+processID);
	rect1.top = 310;
	rect1.bottom = 330;
	data[23].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9023+processID);
	rect1.top = 330;
	rect1.bottom = 350;
	data[24].Create("0",WS_VISIBLE|SS_RIGHT|WS_CHILD,rect1,this,9024+processID);

	_itoa(ifnumber,tdata1,10);
	tdata2 = tdata1;
	rect1.top = 10;
	rect1.bottom = 30;
	rect1.left = 180;
	rect1.right = 200;
	data[1].Create(tdata2,WS_VISIBLE,rect1,this,9001+processID);
	rect1.top = 40;
	rect1.bottom = 60;
	data[2].Create("0",WS_VISIBLE,rect1,this,9002+processID);
	rect1.top = 60;
	rect1.bottom = 80;
	data[3].Create("0",WS_VISIBLE,rect1,this,9003+processID);
	_itoa(ifspeed,tdata1,10);
	tdata2 = tdata1;
	rect1.top = 10;
	rect1.bottom = 30;
	rect1.left = 400;
	rect1.right = 530;
	data[37].Create(tdata2,WS_VISIBLE,rect1,this,9037+processID);

	startupdate = true;
}

void newshowingmonitordata::updatedata(int intervalnumber)
{	char tempdata1[12];
	CString tempdata2;
	canexit = false;
	_itoa(totalin,tempdata1,10);
	tempdata2 = tempdata1;
	data[7].SetWindowText(tempdata2);
	_itoa(totalout,tempdata1,10);
	tempdata2 = tempdata1;
	data[8].SetWindowText(tempdata2);
	_itoa(totalin + totalout,tempdata1,10);
	tempdata2 = tempdata1;
	data[9].SetWindowText(tempdata2);
	_itoa((inrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[13].SetWindowText(tempdata2);
	_itoa((outrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[14].SetWindowText(tempdata2);
	_itoa((inrate + outrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[15].SetWindowText(tempdata2);
	_itoa(totalerin,tempdata1,10);
	tempdata2 = tempdata1;
	data[31].SetWindowText(tempdata2);
	_itoa(totalerout,tempdata1,10);
	tempdata2 = tempdata1;
	data[32].SetWindowText(tempdata2);
	_itoa(totalerin + totalerout,tempdata1,10);
	tempdata2 = tempdata1;
	data[33].SetWindowText(tempdata2);
	_itoa((erinrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[34].SetWindowText(tempdata2);
	_itoa((eroutrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[35].SetWindowText(tempdata2);
	_itoa((erinrate + eroutrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[36].SetWindowText(tempdata2);
	_itoa((((inrate * 8 * 100)/(intervaltime * intervalnumber))/ifspeed),tempdata1,10);
	tempdata2=tempdata1;
	data[16].SetWindowText(tempdata2);
	_itoa((((outrate * 8 * 100)/(intervaltime * intervalnumber))/ifspeed),tempdata1,10);
	tempdata2=tempdata1;
	data[17].SetWindowText(tempdata2);
	_itoa(((((outrate + inrate) * 8 * 100)/(intervaltime * intervalnumber))/ifspeed),tempdata1,10);
	tempdata2=tempdata1;
	data[18].SetWindowText(tempdata2);
	_itoa((packetinrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[10].SetWindowText(tempdata2);
	_itoa((packetoutrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[11].SetWindowText(tempdata2);
	_itoa((packetinrate + packetoutrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[12].SetWindowText(tempdata2);
	_itoa(totalpacketin,tempdata1,10);
	tempdata2 = tempdata1;
	data[4].SetWindowText(tempdata2);
	_itoa(totalpacketout,tempdata1,10);
	tempdata2 = tempdata1;
	data[5].SetWindowText(tempdata2);
	_itoa(totalpacketin + totalpacketout,tempdata1,10);
	tempdata2 = tempdata1;
	data[6].SetWindowText(tempdata2);

	_itoa((multicastinrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[28].SetWindowText(tempdata2);
	_itoa((multicastoutrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[29].SetWindowText(tempdata2);
	_itoa((multicastinrate + multicastoutrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[30].SetWindowText(tempdata2);

	_itoa((unicastinrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[25].SetWindowText(tempdata2);
	_itoa((unicastoutrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[26].SetWindowText(tempdata2);
	_itoa((unicastinrate + unicastoutrate)/(intervaltime * intervalnumber),tempdata1,10);
	tempdata2 = tempdata1;
	data[27].SetWindowText(tempdata2);

	_itoa(totalunicastin,tempdata1,10);
	tempdata2 = tempdata1;
	data[19].SetWindowText(tempdata2);
	_itoa(totalunicastout,tempdata1,10);
	tempdata2 = tempdata1;
	data[20].SetWindowText(tempdata2);
	_itoa(totalunicastin + totalunicastout,tempdata1,10);
	tempdata2 = tempdata1;
	data[21].SetWindowText(tempdata2);

	_itoa(totalmulticastin,tempdata1,10);
	tempdata2 = tempdata1;
	data[22].SetWindowText(tempdata2);
	_itoa(totalmulticastout,tempdata1,10);
	tempdata2 = tempdata1;
	data[23].SetWindowText(tempdata2);
	_itoa(totalmulticastin + totalmulticastout,tempdata1,10);
	tempdata2 = tempdata1;
	data[24].SetWindowText(tempdata2);

	if (minuitcount > 59)
		{
		_itoa((((minuitbyte * 8 * 100)/60)/ifspeed),tempdata1,10);
		tempdata2 = tempdata1;
		data[2].SetWindowText(tempdata2);
		minuitcount = 0;
		minuitbyte = 0;
		}
	if (hourcount > 3599)
		{
		_itoa((((hourbyte * 8 * 100) / 3600) / ifspeed),tempdata1,10);
		tempdata2 = tempdata1;
		data[3].SetWindowText(tempdata2);
		hourcount = 0;
		hourbyte = 0;
		}

	canexit = true;

}

void newshowingmonitordata::OnOK() 
{
	createdata();
//	CDialog::OnOK();
}

void newshowingmonitordata::setifnumber(UINT inr,UINT outr,UINT tin,UINT tout,UINT erinr,UINT eroutr,UINT erint,UINT eroutt,UINT pinrate,UINT poutrate,UINT tpktin,UINT tpktout,UINT unicstinrate,UINT unicstoutrate,UINT mltcstinrate,UINT mltcstoutrate,UINT ttlunicstin,UINT ttlunicstout,UINT ttlmltcstin,UINT ttlmltcstout,int intervalnumber)
{
inrate = inr;
totalin = tin;
outrate = outr;
totalout = tout;
erinrate = erinr;
eroutrate = eroutr;
totalerin = erint;
totalerout = eroutt;
packetinrate = pinrate;
packetoutrate = poutrate;
totalpacketin = tpktin;
totalpacketout = tpktout;
unicastinrate = unicstinrate;
unicastoutrate = unicstoutrate;
multicastinrate = mltcstinrate;
multicastoutrate = mltcstoutrate;
totalunicastin = ttlunicstin;
totalunicastout = ttlunicstout;
totalmulticastin = ttlmltcstin;
totalmulticastout = ttlmltcstout;
minuitbyte += inrate;
hourbyte += inrate;
minuitcount += (intervaltime * intervalnumber);
hourcount += (intervaltime * intervalnumber);
}



void newshowingmonitordata::OnCancel() 
{
	// TODO: Add extra cleanup here
	while (canexit == false)
	{}
	exited = true;
	CDialog::OnCancel();
}

void newshowingmonitordata::setstaticvar(int inttime,UINT ifspeeds,int datain,int tprocessid)
{
	ifnumber = datain;
	ifspeed = ifspeeds;
	intervaltime = inttime;
	processID = tprocessid;
}

/*HBRUSH newshowingmonitordata::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor) 
{
	HBRUSH hbr = CDialog::OnCtlColor(pDC, pWnd, nCtlColor);
	switch (nCtlColor)
	{         
		//Edit controls need white background and black text         
		//Note the 'return hbr' which is needed to draw the Edit
		//control's internal background (as opposed to text background)
		case CTLCOLOR_EDIT:                 
			pDC->SetTextColor(RGB(0,0,0));
			pDC->SetBkColor(RGB(255,255,255));
			return hbr;
		//Static controls need black text and same background as m_brush
		case CTLCOLOR_STATIC:		//there it is..                 
			LOGBRUSH logbrush;
			m_brush.GetLogBrush( &logbrush );
			pDC->SetTextColor(RGB(0,0,0));
			pDC->SetBkColor(logbrush.lbColor);
			return m_brush;
		//For listboxes, scrollbars, buttons, messageboxes and dialogs,
		//use the new brush (m_brush)
		case CTLCOLOR_LISTBOX:	
		case CTLCOLOR_SCROLLBAR:
		case CTLCOLOR_BTN:
		case CTLCOLOR_MSGBOX:
		case CTLCOLOR_DLG:
			return m_brush;
		//This shouldn't occurr since we took all the cases, but 
		//JUST IN CASE, return the new brush  
		default:   
			return m_brush;
	}
}*/