// PacketGraphDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "PacketGraphDlg.h"
#include "MonitorFormControl.h"
#include "GraphPoint.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CPacketGraphDlg dialog


CPacketGraphDlg::CPacketGraphDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CPacketGraphDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CPacketGraphDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CPacketGraphDlg::DoDataExchange(CDataExchange* pDX)
{
	if (GraphType == "PacketInOut")
		SetWindowText("Packet In/Out Graph");
	else 	if (GraphType == "PacketIn")
		SetWindowText("Packet In Graph");
	else	if (GraphType == "PacketOut")
		SetWindowText("Packet Out Graph");

	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPacketGraphDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CPacketGraphDlg, CDialog)
	//{{AFX_MSG_MAP(CPacketGraphDlg)
	ON_BN_CLICKED(ID_Start, OnStart)
	ON_WM_CREATE()
	ON_WM_TIMER()
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPacketGraphDlg message handlers

void CPacketGraphDlg::OnStart() 
{
	if (GraphType == "PacketInOut" || GraphType == "PacketIn")
	{
		textrect1.SetRect(60,480,130,495);
		Nametext1.Create(": Packet In",WS_VISIBLE|SS_CENTER,textrect1,this,43333);
		CDC *theLine;
		theLine = this->GetDC();
		CPen Pen(PS_DASHDOTDOT,3,RGB(255,0,0)); // Red
		theLine->SelectObject(&Pen) ;
		theLine->MoveTo(50,495);
		theLine->LineTo(57,480);
		this->ReleaseDC(theLine);// release the device context 
	} 
	if (GraphType == "PacketInOut" || GraphType == "PacketOut")
	{
		textrect2.SetRect(160,480,250,495);
		Nametext2.Create(": Packet Out",WS_VISIBLE|SS_CENTER,textrect2,this,43334);
		CDC *theLine2;
		theLine2 = this->GetDC();
		CPen Pen2(PS_DASHDOTDOT,3,RGB(0,0,255)); // Blue
		theLine2->SelectObject(&Pen2) ;
		theLine2->MoveTo(150,495);
		theLine2->LineTo(157,480);
		this->ReleaseDC(theLine2);// release the device context 
	}
	MonitorObject.setmutualex(processID,testmutual);
	MonitorObject.startmon(IPaddress);
	SetTimer(2,2000,NULL);
}

int CPacketGraphDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;

	PacketInRateNowPoint.x = 34;
	PacketInRateNowPoint.y = 0;

	PacketOutRateNowPoint.x = 34;	
	PacketOutRateNowPoint.y = 0;

	return 0;
}

HBRUSH CPacketGraphDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{
	DrawInitLineXY();
	HBRUSH hbr = CDialog::OnCtlColor(pDC,pWnd, nCtlColor);
	// set the background color
	COLORREF color = RGB(255,255,255); // White
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

//////////////////////////////////////////////////////////////////////////
// Methods

//method to draw the Line X axis and Y axis
void CPacketGraphDlg::DrawInitLineXY()
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
int CPacketGraphDlg::ConvertValueToYPoint(unsigned int value)
{
	float Ypoint;
	Ypoint = float(value/200.000);
	Ypoint = Ypoint/2;			// devide by 2 because convert YPoint from per 2 Sec to per sec
	Ypoint = Ypoint*20;
	int Y = int(Ypoint);
	if (Y>=440)  Y = 40;  // when Y value excess the max of graph
	else Y = 440-Y;		// 440 is the Point of Y axis
	return Y;
}

void CPacketGraphDlg::OnTimer(UINT nIDEvent) 
{
	MonitorObject.updatedata(IPaddress);
	CGraphPoint *PacketInRateNewPoint = new CGraphPoint();
	CGraphPoint *PacketOutRateNewPoint = new CGraphPoint();
	
	if (GraphType == "PacketInOut" || GraphType == "PacketIn")
	{
	// Get the value of the Packet_In_Rate
		unsigned int PacketInDataRate = MonitorObject.Getpacketinrate();
		// set value of 'PacketInDataRate' to be the value of Packetinrate
		int PacketInRateYPoint = ConvertValueToYPoint(PacketInDataRate);
		if (PacketInRateNowPoint.x !=700)
			PacketInRateNewPoint->SetValue(PacketInRateNowPoint.x+6,PacketInRateYPoint);
		else if (PacketInRateNowPoint.x =700) // if reach the Max of x then Not add 20
			PacketInRateNewPoint->SetValue(PacketInRateNowPoint.x,PacketInRateYPoint);
	}
	
	if (GraphType == "PacketInOut" || GraphType == "PacketOut")
	{
	// Get the value of the Packet_Out_Rate
		unsigned int PacketOutDataRate = MonitorObject.Getpacketoutrate();
		// set value of 'InDataRate' to be the value of Packetoutrate
		int PacketOutRateYPoint = ConvertValueToYPoint(PacketOutDataRate);
		if (PacketOutRateNowPoint.x !=700)
			PacketOutRateNewPoint->SetValue(PacketOutRateNowPoint.x+6,PacketOutRateYPoint);
		else if (PacketOutRateNowPoint.x =700) // if reach the Max of x then Not add 20
			PacketOutRateNewPoint->SetValue(PacketOutRateNowPoint.x,PacketOutRateYPoint);
	}// of GraphType
//***Draw Line
	if (PacketInRateNowPoint.x <700)
	{

		if (GraphType == "PacketInOut" || GraphType == "PacketIn")
		{
		// Draw the Packet_In_Rate Line
			if (PacketInRateNewPoint->thePoint.x >= 40)
			{
				// Draw Line
				DrawLine("PacketInRate",PacketInRateNowPoint,PacketInRateNewPoint->thePoint);
			}
			// Keep point to array
			PacketInRatePointList.Add(PacketInRateNewPoint);
			PacketInRateNowPoint = PacketInRateNewPoint->thePoint;
		}// of GraphType

		if (GraphType == "PacketInOut" || GraphType == "PacketOut")
		{
		// Draw the Packet_Out_Rate Line
			if (PacketOutRateNewPoint->thePoint.x >= 40)
			{
				// Draw Line
				DrawLine("PacketOutRate",PacketOutRateNowPoint,PacketOutRateNewPoint->thePoint);
			}	
			// Keep point to array
			PacketOutRatePointList.Add(PacketOutRateNewPoint);
			PacketOutRateNowPoint = PacketOutRateNewPoint->thePoint;
		}// of GraphType
	
	} // of if <700
	else // NowPoint.x >= 700
	{
		DeleteOldGraph();
		// Delete All Old Graph Line
		DrawInitLineXY();
		ShiftGraph();
		// Shift All Graph Line
		int LastID = PacketInRatePointList.GetSize()-1;
	    CGraphPoint* theNowPoint;

		if (GraphType == "PacketInOut" || GraphType == "PacketIn")
		{
			// Draw the new Line of Packet In Rate
			theNowPoint = (CGraphPoint *)PacketInRatePointList.GetAt(LastID);
			DrawLine("PacketInRate",theNowPoint->thePoint,PacketInRateNewPoint->thePoint);
			PacketInRatePointList.Add(PacketInRateNewPoint);
			PacketInRateNowPoint = PacketInRateNewPoint->thePoint;
		}// of GraphType
  
		if (GraphType == "PacketInOut" || GraphType == "PacketOut")
		{
			// Draw the new Line of Packet Out Rate
			theNowPoint = (CGraphPoint *)PacketOutRatePointList.GetAt(LastID);
			DrawLine("PacketOutRate",theNowPoint->thePoint,PacketOutRateNewPoint->thePoint);		
			PacketOutRatePointList.Add(PacketOutRateNewPoint);
			PacketOutRateNowPoint = PacketOutRateNewPoint->thePoint;
		}// of GraphType
	}
	CDialog::OnTimer(nIDEvent);
}

//method to draw one Line from NowPoint to TerminalPoint
void CPacketGraphDlg::DrawLine(CString Type,CPoint StartPoint,CPoint TerminalPoint)
{
	if (!(StartPoint.x==34 && StartPoint.y==0))
	{
		CDC *theLine;
		theLine = this->GetDC();
		// to set the color of Line and 
		//	  to set NowPoint to be the new point
		if (Type == "PacketInRate")
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0));  // Red
			theLine->SelectObject(&Pen) ;
			theLine->MoveTo(StartPoint);
			theLine->LineTo(TerminalPoint);
		}
		else if (Type == "PacketOutRate")
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(0,0,255));  // Blue
			theLine->SelectObject(&Pen) ;
			theLine->MoveTo(StartPoint);
			theLine->LineTo(TerminalPoint);
		}	
		this->ReleaseDC(theLine);// release the device context 
	}
}

//method to draw the white line replace the old one
void CPacketGraphDlg::DeleteOldGraph()
{
	CDC *BlankLine;
	BlankLine = this->GetDC();
	CPen Pen(PS_DASHDOTDOT,2,RGB(255,255,255));  // White
	BlankLine->SelectObject(&Pen) ;
    CPoint thePoint1;
	CPoint thePoint2;
	CGraphPoint* theObject;
	int LastIndex,i;
	
	if (GraphType == "PacketInOut" || GraphType == "PacketIn")
	{
	//Delete the Packet In Rate Line
		theObject = (CGraphPoint *)PacketInRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;		
		BlankLine->MoveTo(thePoint1);
		LastIndex = PacketInRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)PacketInRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;		
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "PacketInOut" || GraphType == "PacketOut")
	{
	//Delete the Packet Out Rate Line
		theObject = (CGraphPoint *)PacketOutRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;	
		BlankLine->MoveTo(thePoint1);
		LastIndex = PacketOutRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)PacketOutRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;	
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(BlankLine);// release the device context 
}

//method to shift the data in array and draw the new line graph	
void CPacketGraphDlg::ShiftGraph()
{
	CDC *NewLine;
	NewLine = this->GetDC();
	CPoint thePoint1;
	CPoint thePoint2;
	int LastIndex,i;
	CGraphPoint* theObject= new CGraphPoint();;

	if (GraphType == "PacketInOut" || GraphType == "PacketIn")
	{
	//Shift the Packet In Rate Line
		PacketInRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)PacketInRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = PacketInRatePointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0));  // Red
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)PacketInRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;		
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "PacketInOut" || GraphType == "PacketOut")
	{
	//Shift the Packet Out Rate Line
		PacketOutRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)PacketOutRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = PacketOutRatePointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(0,0,255));  // Blue
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)PacketOutRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;	
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(NewLine);// release the device context 
}

void CPacketGraphDlg::OnCancel() 
{
	KillTimer(2);
	CDialog::OnCancel();
}

int CPacketGraphDlg::DoModal(CString IPAddress,CString Type) 
{
	IPaddress = IPAddress;
	GraphType = Type;
	return CDialog::DoModal();
}
void CPacketGraphDlg::setmutual(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutual = tptstmutual;
}
