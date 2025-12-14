// MultipleIPGraphDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "MultipleIPGraphDlg.h"
#include "MonitorFormControl.h"
#include "GraphPoint.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMultipleIPGraphDlg dialog


CMultipleIPGraphDlg::CMultipleIPGraphDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CMultipleIPGraphDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CMultipleIPGraphDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CMultipleIPGraphDlg::DoDataExchange(CDataExchange* pDX)
{
	SetWindowText(theValue);
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CMultipleIPGraphDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CMultipleIPGraphDlg, CDialog)
	//{{AFX_MSG_MAP(CMultipleIPGraphDlg)
	ON_BN_CLICKED(ID_Start, OnStart)
	ON_WM_TIMER()
	ON_WM_CREATE()
	ON_WM_TIMER()
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMultipleIPGraphDlg message handlers

void CMultipleIPGraphDlg::OnStart() 
{	RECT rect1;
	int LastIndex = theIPList->GetSize()-1;
	for (int i=0; i<=LastIndex; i++)
	{	
		MonitorFormControl* MonitorObject = new MonitorFormControl();
		MonitorObject->setmutualex(0,testmutual);
		MonitorObject->startmon(theIPList->GetAt(i));
		CMonitorArray.Add(MonitorObject);
	// PointListArray for keep Point List of every IP
	// PointList for keep Point List of each IP
		CObArray* PointList = new CObArray();
		PointListArray.Add(PointList);
	// NowPoint for keep now Point each IP
	// NowPointArray for keep now Point List of every IP
		CGraphPoint* NowPoint = new CGraphPoint();
		NowPoint->thePoint.x = 34;
		NowPoint->thePoint.y = 0;
		NowPointArray.Add(NowPoint);
	}
	timerect.SetRect(120,545,200,570);
	time.Create(theTime,WS_VISIBLE|SS_LEFT,timerect,this,66061);
	CString scale;
	if (theValue =="Percentage Utilization")
	{
		scale = "1 %";
	}
	else if (theValue =="Byte In Rate")
	{
		scale = "4000 byte/sec";
	}
	else if (theValue =="Byte Out Rate")
	{
		scale = "4000 byte/sec";
	}
	else if (theValue =="Packet In Rate")
	{
		scale = "40 packet/sec";
	}
	else if (theValue =="Packet Out Rate")
	{
		scale = "40 packet/sec";
	}
	else if (theValue =="Error In Rate")
	{
		scale = "4 packet/sec";
	}
	else if (theValue =="Error Out Rate")
	{
		scale = "4 packet/sec";
	}
	else if (theValue =="Muticast Packet In Rate")
	{
		scale = "40 packet/sec";
	}
	else if (theValue =="Muticast Packet Out Rate")
	{
		scale = "40 packet/sec";
	}
	else if (theValue =="Unicast Packet In Rate")
	{
		scale = "40 packet/sec";
	}
	else if (theValue =="Unicast Packet Out Rate")
	{
		scale = "40 packet/sec";
	}
	
	if (LastIndex>=0)
	{
		textrect1.SetRect(70,490,170,505);
		Nametext1.Create(theIPList->GetAt(0),WS_VISIBLE|SS_LEFT,textrect1,this,66066);
		textrect12.SetRect(180,490,280,505);
		Nametext12.Create(scale,WS_VISIBLE|SS_CENTER,textrect12,this,77077);
		CDC *theLine1;
		theLine1 = this->GetDC();
		CPen Pen1(PS_DASHDOTDOT,2,RGB(0,0,255)); // Blue
		theLine1->SelectObject(&Pen1) ;
		theLine1->MoveTo(20,498);
		theLine1->LineTo(30,498);
		this->ReleaseDC(theLine1);// release the device context 
		rect1.top = 490;
		rect1.bottom = 505;
		rect1.left = 285;
		rect1.right = 355;
		gvalue[0].Create("0",WS_VISIBLE|SS_RIGHT,rect1,this,6000+processID);
	} 
	if (LastIndex>=1)
	{
		textrect2.SetRect(70,510,170,525);
		Nametext2.Create(theIPList->GetAt(1),WS_VISIBLE|SS_LEFT,textrect2,this,66065);
		textrect22.SetRect(180,510,280,525);
		Nametext22.Create(scale,WS_VISIBLE|SS_CENTER,textrect22,this,77076);
		CDC *theLine2;
		theLine2 = this->GetDC();
		CPen Pen2(PS_DASHDOTDOT,2,RGB(255,0,0)); // Red
		theLine2->SelectObject(&Pen2);
		theLine2->MoveTo(20,518);
		theLine2->LineTo(30,518);
		this->ReleaseDC(theLine2);// release the device context 
		rect1.top = 510;
		rect1.bottom = 525;
		rect1.left = 285;
		rect1.right = 355;
		gvalue[1].Create("0",WS_VISIBLE|SS_RIGHT,rect1,this,6001+processID);

	} 
	if (LastIndex>=2)
	{
		textrect3.SetRect(450,490,550,505);
		Nametext3.Create(theIPList->GetAt(2),WS_VISIBLE|SS_LEFT,textrect3,this,66064);
		textrect32.SetRect(560,490,660,505);
		Nametext32.Create(scale,WS_VISIBLE|SS_CENTER,textrect32,this,77075);
		CDC *theLine3;
		theLine3 = this->GetDC();
		CPen Pen3(PS_DASHDOTDOT,2,RGB(0,255,0)); // Green
		theLine3->SelectObject(&Pen3) ;
		theLine3->MoveTo(410,498);
		theLine3->LineTo(420,498);
		this->ReleaseDC(theLine3);// release the device context 
		rect1.top = 490;
		rect1.bottom = 505;
		rect1.left = 670;
		rect1.right = 740;
		gvalue[2].Create("0",WS_VISIBLE|SS_RIGHT,rect1,this,6002+processID);

	} 
	if (LastIndex>=3)
	{
		textrect4.SetRect(450,510,550,525);
		Nametext4.Create(theIPList->GetAt(3),WS_VISIBLE|SS_LEFT,textrect4,this,66063);
		textrect42.SetRect(560,510,660,525);
		Nametext42.Create(scale,WS_VISIBLE|SS_CENTER,textrect42,this,77074);
		CDC *theLine4;
		theLine4 = this->GetDC();
		CPen Pen4(PS_DASHDOTDOT,2,RGB(255,255,0)); // Yellow
		theLine4->SelectObject(&Pen4);
		theLine4->MoveTo(410,518);
		theLine4->LineTo(420,518);
		this->ReleaseDC(theLine4);// release the device context 
		rect1.top = 510;
		rect1.bottom = 525;
		rect1.left = 670;
		rect1.right = 740;
		gvalue[3].Create("0",WS_VISIBLE|SS_RIGHT,rect1,this,6003+processID);

	}

	int time;
	if (theTime =="2 sec.")
		time = 2000;
	else if (theTime =="5 sec.")
		time = 5000;
	else if (theTime =="10 sec.")
		time = 10000;
	else if (theTime =="30 sec.")
		time = 30000;
	else if (theTime =="1 min.")
		time = 60000;
	else if (theTime =="5 min.")
		time = 300000;
	else if (theTime =="10 min.")
		time = 600000;
	SetTimer(2+processID,time,NULL);	
	OnTimer(2);
}

int CMultipleIPGraphDlg::DoModal(CStringArray* IPList, CString value, CString time)
{
	theIPList =IPList;
	theValue =value;
	theTime =time;
	return CDialog::DoModal();
}

void CMultipleIPGraphDlg::setmutual(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutual = tptstmutual;
}

int CMultipleIPGraphDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	return 0;
}

HBRUSH CMultipleIPGraphDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{
	DrawInitLineXY();
	HBRUSH hbr = CDialog::OnCtlColor(pDC,pWnd, nCtlColor);
	// set the background color
	COLORREF color = RGB(255,255,255);
	pDC->SetBkColor(color);
	if (m_brush.GetSafeHandle() == NULL)
	{
		// create a brush the first time this function is called
		m_brush.CreateSolidBrush(color);
	}
	if (nCtlColor == CTLCOLOR_DLG || nCtlColor == CTLCOLOR_STATIC)
	{
		// set the color of the dialog and selected controls
		hbr = (HBRUSH) m_brush.GetSafeHandle();
	}
	return hbr;
}

void CMultipleIPGraphDlg::OnTimer(UINT nIDEvent) 
{	char tempdata[7];
	if (testinterval == false)
		{
		testinterval = true;
		int YPoint[4];
		int LastID = CMonitorArray.GetSize()-1;
		MonitorFormControl* theMonitorObject;
		CObArray* thePointList;
		for (int i=0; i<=LastID; i++)
		{
			theMonitorObject = (MonitorFormControl *)CMonitorArray.GetAt(i);
			theMonitorObject->updatedata(theIPList->GetAt(i));		
			
			if (theValue =="Percentage Utilization")
				{
			// Get the value of the Data_Error_In_Rate
				float ByteInRate = float(theMonitorObject->Getinrate());
				float ByteOutRate = float(theMonitorObject->Getoutrate());
				float InterfaceSpeed = float(theMonitorObject->Getifspeed());
				float Utilization = (ByteInRate + ByteOutRate);
				Utilization = (Utilization*100/(InterfaceSpeed/8));
				if (Utilization < 0)
					{Utilization = 0;}
				if (Utilization > 100)
					{Utilization = 100;}
				cshowvalue[i] = Utilization;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				// set value of 'Utilization' to be the value of errorinrate
				YPoint[i] = ConvertValueToYPoint(Utilization);
				}
			else if (theValue =="Byte In Rate")
				{
				float InDataRate = float(theMonitorObject->Getinrate());
				if (InDataRate < 0)
					{InDataRate = 0;}
				if (InDataRate > 8000000)
					{InDataRate = 8000000;}
				cshowvalue[i] = InDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				InDataRate = InDataRate/40000;
				// Max value = 4000 kByte	
				// devide by 40000
				//   so Ratio= 1:40000 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(InDataRate);
				}
			else if (theValue =="Byte Out Rate")
				{
				float OutDataRate = float(theMonitorObject->Getoutrate());
				if (OutDataRate < 0)
					{OutDataRate = 0;}
				if (OutDataRate > 8000000)
					{OutDataRate = 8000000;}
				cshowvalue[i] = OutDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				OutDataRate = OutDataRate/40000;
				// Max value = 4000 kByte	
				// devide by 40000
				//   so Ratio= 1:40000 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(OutDataRate);
				}
			else if (theValue =="Packet In Rate")
				{
				float PacketInDataRate = float(theMonitorObject->Getpacketinrate());
				if (PacketInDataRate < 0)
					{PacketInDataRate = 0;}
				if (PacketInDataRate > 8000)
					{PacketInDataRate = 8000;}
				cshowvalue[i] = PacketInDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				PacketInDataRate = PacketInDataRate/40;
				// Max value = 4000 Packet	
				// devide by 40
				//   so Ratio= 1:40 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(PacketInDataRate);
				}
			else if (theValue =="Packet Out Rate")
				{
				float PacketOutDataRate = float(theMonitorObject->Getpacketoutrate());
				if (PacketOutDataRate < 0)
					{PacketOutDataRate = 0;}
				if (PacketOutDataRate > 8000)
					{PacketOutDataRate = 8000;}
				cshowvalue[i] = PacketOutDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				PacketOutDataRate = PacketOutDataRate/40;
				// Max value = 4000 Packet	
				// devide by 40
				//   so Ratio= 1:40 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(PacketOutDataRate);
				}
			else if (theValue =="Error In Rate")
				{
				float ErrorInDataRate = float(theMonitorObject->Geterrorinrate());
				if (ErrorInDataRate < 0)
					{ErrorInDataRate = 0;}
				if (ErrorInDataRate > 800)
					{ErrorInDataRate = 800;}
				cshowvalue[i] = ErrorInDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				ErrorInDataRate = ErrorInDataRate/4;
				// Max value = 400 Packet	
				// devide by 4
				//   so Ratio= 1:4 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(ErrorInDataRate);
				}
			else if (theValue =="Error Out Rate")
				{
				float ErrorOutDataRate = float(theMonitorObject->Geterroroutrate());
				if (ErrorOutDataRate < 0)
					{ErrorOutDataRate = 0;}
				if (ErrorOutDataRate > 800)
					{ErrorOutDataRate = 800;}
				cshowvalue[i] = ErrorOutDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				ErrorOutDataRate = ErrorOutDataRate/4;
				// Max value = 400 Packet	
				// devide by 4
				//   so Ratio= 1:4 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(ErrorOutDataRate);
				}
			else if (theValue =="Muticast Packet In Rate")
				{
				float MulticastInDataRate = float(theMonitorObject->Getmulticastinrate());
				if (MulticastInDataRate < 0)
					{MulticastInDataRate = 0;}
				if (MulticastInDataRate > 800)
					{MulticastInDataRate = 800;}
				cshowvalue[i] = MulticastInDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				MulticastInDataRate = MulticastInDataRate/40;
				// Max value = 400 Packet	
				// devide by 40
				//   so Ratio= 1:40 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(MulticastInDataRate);
				}
			else if (theValue =="Muticast Packet Out Rate")
				{
				float MulticastOutDataRate = float(theMonitorObject->Getmulticastoutrate());
				if (MulticastOutDataRate < 0)
					{MulticastOutDataRate = 0;}
				if (MulticastOutDataRate > 800)
					{MulticastOutDataRate = 800;}
				cshowvalue[i] = MulticastOutDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				MulticastOutDataRate = MulticastOutDataRate/40;
				// Max value = 400 Packet	
				// devide by 40
				//   so Ratio= 1:40 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(MulticastOutDataRate);
				}	
			else if (theValue =="Unicast Packet In Rate")
				{
				float UnicastInDataRate = float(theMonitorObject->Getunicastinrate());
				if (UnicastInDataRate < 0)
					{UnicastInDataRate = 0;}
				if (UnicastInDataRate > 800)
					{UnicastInDataRate = 800;}
				cshowvalue[i] = UnicastInDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				UnicastInDataRate = UnicastInDataRate/40;
				// Max value = 400 Packet	
				// devide by 40
				//   so Ratio= 1:40 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(UnicastInDataRate);
				}	
			else if (theValue =="Unicast Packet Out Rate")
				{
				float UnicastOutDataRate = float(theMonitorObject->Getunicastoutrate());
				if (UnicastOutDataRate < 0)
					{UnicastOutDataRate = 0;}
				if (UnicastOutDataRate > 800)
					{UnicastOutDataRate = 800;}
				cshowvalue[i] = UnicastOutDataRate;
				cshowvalue[i] = converttorate(cshowvalue[i]);
				UnicastOutDataRate = UnicastOutDataRate/40;
				// Max value = 400 Packet	
				// devide by 40
				//   so Ratio= 1:40 -> Graph Value:Real Value
				YPoint[i] = ConvertValueToYPoint(UnicastOutDataRate);
				}
			
		}
		for ( i=0; i<=LastID; i++)
		{
			_itoa(cshowvalue[i],tempdata,10);
			gvalue[i].SetWindowText(tempdata);
			CGraphPoint *NewPoint = new CGraphPoint();
			CGraphPoint* theNowPoint;
			theNowPoint = (CGraphPoint *)NowPointArray.GetAt(i);
			if (theNowPoint->thePoint.x !=700)
				NewPoint->SetValue(theNowPoint->thePoint.x+6,YPoint[i]);
			else if (theNowPoint->thePoint.x =700) // if reach the Max of x then Not add 20
				NewPoint->SetValue(theNowPoint->thePoint.x,YPoint[i]);
	//*** Draw Line When No reach edge
			if (theNowPoint->thePoint.x <700)
				{
	      		// Draw the Data_Error_In_Rate Line
				if (NewPoint->thePoint.x >= 40)
					{
					// Draw Line
					DrawLine(theNowPoint->thePoint,NewPoint->thePoint,i);
					}
				// Keep point to array
				thePointList = (CObArray *)PointListArray.GetAt(i);
				thePointList->Add(NewPoint);
				theNowPoint->thePoint = NewPoint->thePoint;
				} // of if <700
			else // theNowPoint.x >= 700
				{
				if (i == 0)
					{
					DeleteOldGraph();
					// Delete All Old Graph Line
					DrawInitLineXY();
					ShiftGraph();
					// Shift All Graph Line
					}
				thePointList = (CObArray *)PointListArray.GetAt(i);
				int Last = thePointList->GetSize()-1;
				CGraphPoint* theNowPoint;
				theNowPoint = (CGraphPoint *)NowPointArray.GetAt(i);
				// Draw the new Line of Data Error In Rate
				theNowPoint = (CGraphPoint *)thePointList->GetAt(Last);
				DrawLine(theNowPoint->thePoint,NewPoint->thePoint,i);
				thePointList->Add(NewPoint);
				theNowPoint->thePoint = NewPoint->thePoint;
				}
			} // for i= 0->LastID of CMonitorArray
		intervalnumber = 1;
		testinterval = false;
		}
	else
		{
		intervalnumber++;
		}
	CDialog::OnTimer(nIDEvent);
}

void CMultipleIPGraphDlg::OnCancel() 
{
	KillTimer(2+processID);
	CDialog::OnCancel();
}

//////////////////////////////////////////////////////////////////////////
// Methods

//method to draw the Line X axis and Y axis
void CMultipleIPGraphDlg::DrawInitLineXY()
{
	int x1 =40;
	int y1 =40;
	int x2 =700;
	int y2 =440;
	CDC *LinkLine;
	LinkLine = this->GetDC();
	LinkLine->MoveTo(x1,y1);//StartPoint
	LinkLine->LineTo(x1,y2);// Draw Y axis
	LinkLine->LineTo(x2,y2);//Draw X axis
// draw scales of Y axis
	// value of each scale = 20 draw until 400 === 50->1000
	for (int i=20;i<=400;i+=20)
	{
		LinkLine->MoveTo(x1-3,y2-i);//	50
		LinkLine->LineTo(x1+3,y2-i);
	}
  //draw the scale of X axis
	// value of each scale = 15 draw until 660 === 5->220
	for (int j=15;j<=660;j+=15)
	{
		LinkLine->MoveTo(x1+j,y2-2);// 5 second
		LinkLine->LineTo(x1+j,y2+4);
	}
	this->ReleaseDC(LinkLine);// release the device context 
}

//method to convert the value of Data's Volume to Y point on graph
//  by return to integer(Y Point)
int CMultipleIPGraphDlg::ConvertValueToYPoint(float value)
{
	int time;  // at second
	if (theTime =="2 sec.")
		time = 2;
	else if (theTime =="5 sec.")
		time = 5;
	else if (theTime =="10 sec.")
		time = 10;
	else if (theTime =="30 sec.")
		time = 30;
	else if (theTime =="1 min.")
		time = 60;
	else if (theTime =="5 min.")
		time = 300;
	else if (theTime =="10 min.")
		time = 600;

	
	int Y = int(value*4);  // * 4 because Ratio Graph Value:Real value = 4:L1
	Y = Y/(time * intervalnumber);
	if (Y>=440)  Y = 40;  // when Y value excess the max of graph
	else Y = 440-Y;		// 440 is the Point of Y axis
	return Y;
}

//method to draw one Line from theNowPoint to TerminalPoint
void CMultipleIPGraphDlg::DrawLine(CPoint StartPoint,CPoint TerminalPoint,int ID)
{
	COLORREF color;
	if (ID==0)
			color = RGB(0,0,255);
	else if (ID==1)
			color = RGB(255,0,0);
	else if (ID==2)
			color = RGB(0,255,0);
	else if (ID==3)
			color = RGB(255,255,0);
	if (!(StartPoint.x==34 && StartPoint.y==0))
	{
		CDC *theLine;
		theLine = this->GetDC();
		// to set the color of Line and 
		//	  to set theNowPoint to be the new point
		CPen Pen(PS_DASHDOTDOT,2,color);  // Blue
		theLine->SelectObject(&Pen) ;
		theLine->MoveTo(StartPoint);
		theLine->LineTo(TerminalPoint);
		this->ReleaseDC(theLine);// release the device context 
	}
}

//method to draw the white line replace the old one
void CMultipleIPGraphDlg::DeleteOldGraph()
{
	CDC *BlankLine;
	BlankLine = this->GetDC();
	CPen Pen(PS_DASHDOTDOT,2,RGB(255,255,255));  // White
	BlankLine->SelectObject(&Pen) ;
    CPoint thePoint1;
	CPoint thePoint2;
	CObArray* thePointList;
	CGraphPoint* theObject;
	int LastIDofList,LastIDofArray,i,j;
	//Delete the Data Error In Rate Line
	LastIDofArray = PointListArray.GetSize()-1;
	for (j=0; j<=LastIDofArray; j++)
	{
		thePointList = (CObArray *)PointListArray.GetAt(j);
		theObject = (CGraphPoint *)thePointList->GetAt(0);
		thePoint1 = theObject->thePoint;		
		BlankLine->MoveTo(thePoint1);
		LastIDofList = thePointList->GetSize()-1;
		for (i=1;i<=LastIDofList;i++)
		{
			theObject = (CGraphPoint *)thePointList->GetAt(i);
			thePoint2 = theObject->thePoint;		
			BlankLine->LineTo(thePoint2);
		}
	}	
	this->ReleaseDC(BlankLine);// release the device context 
}

//method to shift the data in array and draw the new line graph	
void CMultipleIPGraphDlg::ShiftGraph()
{
	CDC *NewLine;
	NewLine = this->GetDC();
	CPoint thePoint1;
	CPoint thePoint2;

	CObArray* thePointList;
	CGraphPoint* theObject;
	int LastIDofList,LastIDofArray,i,j;

	//Shift the Data Error In Rate Line
	LastIDofArray = PointListArray.GetSize()-1;
	for (j=0; j<=LastIDofArray; j++)
	{
		thePointList = (CObArray *)PointListArray.GetAt(j);
		thePointList->RemoveAt(0,1);
		theObject = (CGraphPoint *)thePointList->GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIDofList = thePointList->GetSize()-1;
		COLORREF color;
		if (j==0)
				color = RGB(0,0,255);
		else if (j==1)
				color = RGB(255,0,0);
		else if (j==2)
				color = RGB(0,255,0);
		else if (j==3)
				color = RGB(255,255,0);
		for (i=0; i<=LastIDofList; i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,color);  // Blue
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)thePointList->GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
//			theObject->SetValue(theObject->thePoint.x-3,theObject->thePoint.y);			
			thePoint2 = theObject->thePoint;		
			NewLine->LineTo(thePoint2);
		}
	}
	this->ReleaseDC(NewLine);// release the device context 
}

void CMultipleIPGraphDlg::setvalue(CStringArray* IPList, CString value, CString time)
{
	theIPList =IPList;
	theValue =value;
	theTime =time;
	testinterval = false;
	intervalnumber = 1;
//	return CDialog::DoModal();
}

int CMultipleIPGraphDlg::converttorate(int value)
{	int returnvalue;
	int time;  // at second
	if (theTime =="2 sec.")
		time = 2;
	else if (theTime =="5 sec.")
		time = 5;
	else if (theTime =="10 sec.")
		time = 10;
	else if (theTime =="30 sec.")
		time = 30;
	else if (theTime =="1 min.")
		time = 60;
	else if (theTime =="5 min.")
		time = 300;
	else if (theTime =="10 min.")
		time = 600;
	returnvalue = value / (time * intervalnumber);
	return returnvalue;
}
