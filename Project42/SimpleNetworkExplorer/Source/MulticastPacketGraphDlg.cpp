// MulticastPacketGraphDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "MulticastPacketGraphDlg.h"
#include "MonitorFormControl.h"
#include "GraphPoint.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMulticastPacketGraphDlg dialog


CMulticastPacketGraphDlg::CMulticastPacketGraphDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CMulticastPacketGraphDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CMulticastPacketGraphDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CMulticastPacketGraphDlg::DoDataExchange(CDataExchange* pDX)
{
	if (GraphType == "MulticastPacketInOut")
		SetWindowText("Multicast Packet In/Out Graph");
	else 	if (GraphType == "MulticastPacketIn")
		SetWindowText("Multicast Packet In Graph");
	else	if (GraphType == "MulticastPacketOut")
		SetWindowText("Multicast Packet Out Graph");

	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CMulticastPacketGraphDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CMulticastPacketGraphDlg, CDialog)
	//{{AFX_MSG_MAP(CMulticastPacketGraphDlg)
	ON_BN_CLICKED(ID_Start, OnStart)
	ON_WM_CREATE()
	ON_WM_TIMER()
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMulticastPacketGraphDlg message handlers

void CMulticastPacketGraphDlg::OnStart() 
{
	if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketIn")
	{
		textrect1.SetRect(25,472,140,503);
		Nametext1.Create(":Multicast Packet In",WS_VISIBLE|SS_CENTER,textrect1,this,43333);
		CDC *theLine;
		theLine = this->GetDC();
		CPen Pen(PS_DASHDOTDOT,3,RGB(255,0,0)); // Red
		theLine->SelectObject(&Pen) ;
		theLine->MoveTo(15,495);
		theLine->LineTo(22,480);
		this->ReleaseDC(theLine);// release the device context 
	} 
	if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketOut")
	{
		textrect2.SetRect(160,472,280,503);
		Nametext2.Create(":Multicast Packet Out",WS_VISIBLE|SS_CENTER,textrect2,this,43334);
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

int CMulticastPacketGraphDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;

	MulticastPacketInRateNowPoint.x = 34;
	MulticastPacketInRateNowPoint.y = 0;

	MulticastPacketOutRateNowPoint.x = 34;	
	MulticastPacketOutRateNowPoint.y = 0;

	return 0;
}

HBRUSH CMulticastPacketGraphDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
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
void CMulticastPacketGraphDlg::DrawInitLineXY()
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
int CMulticastPacketGraphDlg::ConvertValueToYPoint(unsigned int value)
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

void CMulticastPacketGraphDlg::OnTimer(UINT nIDEvent) 
{
	MonitorObject.updatedata(IPaddress);
	CGraphPoint *MulticastPacketInRateNewPoint = new CGraphPoint();
	CGraphPoint *MulticastPacketOutRateNewPoint = new CGraphPoint();
	
	if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketIn")
	{
	// Get the value of the Multicast_Packet_In_Rate
		unsigned int MulticastPacketInDataRate = MonitorObject.Getmulticastinrate();
		// set value of 'MulticastPacketInDataRate' to be the value of MulticastPacketinrate
		int MulticastPacketInRateYPoint = ConvertValueToYPoint(MulticastPacketInDataRate);
		if (MulticastPacketInRateNowPoint.x !=700)
			MulticastPacketInRateNewPoint->SetValue(MulticastPacketInRateNowPoint.x+6,MulticastPacketInRateYPoint);
		else if (MulticastPacketInRateNowPoint.x =700) // if reach the Max of x then Not add 20
			MulticastPacketInRateNewPoint->SetValue(MulticastPacketInRateNowPoint.x,MulticastPacketInRateYPoint);
	}
	
	if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketOut")
	{
	// Get the value of the Multicast_Packet_Out_Rate
		unsigned int MulticastPacketOutDataRate = MonitorObject.Getmulticastoutrate();
		// set value of 'InDataRate' to be the value of MulticastPacketoutrate
		int MulticastPacketOutRateYPoint = ConvertValueToYPoint(MulticastPacketOutDataRate);
		if (MulticastPacketOutRateNowPoint.x !=700)
			MulticastPacketOutRateNewPoint->SetValue(MulticastPacketOutRateNowPoint.x+6,MulticastPacketOutRateYPoint);
		else if (MulticastPacketOutRateNowPoint.x =700) // if reach the Max of x then Not add 20
			MulticastPacketOutRateNewPoint->SetValue(MulticastPacketOutRateNowPoint.x,MulticastPacketOutRateYPoint);
	}// of GraphType
//***Draw Line
	if (MulticastPacketInRateNowPoint.x <700)
	{

		if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketIn")
		{
		// Draw the Multicast_Packet_In_Rate Line
			if (MulticastPacketInRateNewPoint->thePoint.x >= 40)
			{
				// Draw Line
				DrawLine("MulticastPacketInRate",MulticastPacketInRateNowPoint,MulticastPacketInRateNewPoint->thePoint);
			}
			// Keep point to array
			MulticastPacketInRatePointList.Add(MulticastPacketInRateNewPoint);
			MulticastPacketInRateNowPoint = MulticastPacketInRateNewPoint->thePoint;
		}// of GraphType

		if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketOut")
		{
		// Draw the Multicast_Packet_Out_Rate Line
			if (MulticastPacketOutRateNewPoint->thePoint.x >= 40)
			{
				// Draw Line
				DrawLine("MulticastPacketOutRate",MulticastPacketOutRateNowPoint,MulticastPacketOutRateNewPoint->thePoint);
			}	
			// Keep point to array
			MulticastPacketOutRatePointList.Add(MulticastPacketOutRateNewPoint);
			MulticastPacketOutRateNowPoint = MulticastPacketOutRateNewPoint->thePoint;
		}// of GraphType
	
	} // of if <700
	else // NowPoint.x >= 700
	{
		DeleteOldGraph();
		// Delete All Old Graph Line
		DrawInitLineXY();
		ShiftGraph();
		// Shift All Graph Line
		int LastID = MulticastPacketInRatePointList.GetSize()-1;
	    CGraphPoint* theNowPoint;

		if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketIn")
		{
			// Draw the new Line of Multicast Packet In Rate
			theNowPoint = (CGraphPoint *)MulticastPacketInRatePointList.GetAt(LastID);
			DrawLine("MulticastPacketInRate",theNowPoint->thePoint,MulticastPacketInRateNewPoint->thePoint);
			MulticastPacketInRatePointList.Add(MulticastPacketInRateNewPoint);
			MulticastPacketInRateNowPoint = MulticastPacketInRateNewPoint->thePoint;
		}// of GraphType
  
		if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketOut")
		{
			// Draw the new Line of Multicast Packet Out Rate
			theNowPoint = (CGraphPoint *)MulticastPacketOutRatePointList.GetAt(LastID);
			DrawLine("MulticastPacketOutRate",theNowPoint->thePoint,MulticastPacketOutRateNewPoint->thePoint);		
			MulticastPacketOutRatePointList.Add(MulticastPacketOutRateNewPoint);
			MulticastPacketOutRateNowPoint = MulticastPacketOutRateNewPoint->thePoint;
		}// of GraphType
	}
	CDialog::OnTimer(nIDEvent);
}

//method to draw one Line from NowPoint to TerminalPoint
void CMulticastPacketGraphDlg::DrawLine(CString Type,CPoint StartPoint,CPoint TerminalPoint)
{
	if (!(StartPoint.x==34 && StartPoint.y==0))
	{
		CDC *theLine;
		theLine = this->GetDC();
		// to set the color of Line and 
		//	  to set NowPoint to be the new point
		if (Type == "MulticastPacketInRate")
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0));  // Red
			theLine->SelectObject(&Pen) ;
			theLine->MoveTo(StartPoint);
			theLine->LineTo(TerminalPoint);
		}
		else if (Type == "MulticastPacketOutRate")
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
void CMulticastPacketGraphDlg::DeleteOldGraph()
{
	CDC *BlankLine;
	BlankLine = this->GetDC();
	CPen Pen(PS_DASHDOTDOT,2,RGB(255,255,255));  // White
	BlankLine->SelectObject(&Pen) ;
    CPoint thePoint1;
	CPoint thePoint2;
	CGraphPoint* theObject;
	int LastIndex,i;
	
	if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketIn")
	{
	//Delete the Multicast Packet In Rate Line
		theObject = (CGraphPoint *)MulticastPacketInRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;		
		BlankLine->MoveTo(thePoint1);
		LastIndex = MulticastPacketInRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)MulticastPacketInRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;		
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketOut")
	{
	//Delete the Multicast Packet Out Rate Line
		theObject = (CGraphPoint *)MulticastPacketOutRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;	
		BlankLine->MoveTo(thePoint1);
		LastIndex = MulticastPacketOutRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)MulticastPacketOutRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;	
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(BlankLine);// release the device context 
}

//method to shift the data in array and draw the new line graph	
void CMulticastPacketGraphDlg::ShiftGraph()
{
	CDC *NewLine;
	NewLine = this->GetDC();
	CPoint thePoint1;
	CPoint thePoint2;
	int LastIndex,i;
	CGraphPoint* theObject= new CGraphPoint();;

	if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketIn")
	{
	//Shift the Multicast Packet In Rate Line
		MulticastPacketInRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)MulticastPacketInRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = MulticastPacketInRatePointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0));  // Red
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)MulticastPacketInRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;		
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "MulticastPacketInOut" || GraphType == "MulticastPacketOut")
	{
	//Shift the Multicast Packet Out Rate Line
		MulticastPacketOutRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)MulticastPacketOutRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = MulticastPacketOutRatePointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(0,0,255));  // Blue
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)MulticastPacketOutRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;	
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(NewLine);// release the device context 
}

void CMulticastPacketGraphDlg::OnCancel() 
{
	KillTimer(2);
	CDialog::OnCancel();
}

int CMulticastPacketGraphDlg::DoModal(CString IPAddress,CString Type) 
{
	IPaddress = IPAddress;
	GraphType = Type;
	return CDialog::DoModal();
}
void CMulticastPacketGraphDlg::setmutual(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutual = tptstmutual;
}