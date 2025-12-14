// UnicastPacketGraphDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "UnicastPacketGraphDlg.h"
#include "MonitorFormControl.h"
#include "GraphPoint.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CUnicastPacketGraphDlg dialog


CUnicastPacketGraphDlg::CUnicastPacketGraphDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CUnicastPacketGraphDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CUnicastPacketGraphDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CUnicastPacketGraphDlg::DoDataExchange(CDataExchange* pDX)
{
	if (GraphType == "UnicastPacketInOut")
		SetWindowText("Unicast Packet In/Out Graph");
	else 	if (GraphType == "UnicastPacketIn")
		SetWindowText("Unicast Packet In Graph");
	else	if (GraphType == "UnicastPacketOut")
		SetWindowText("Unicast Packet Out Graph");

	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CUnicastPacketGraphDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CUnicastPacketGraphDlg, CDialog)
	//{{AFX_MSG_MAP(CUnicastPacketGraphDlg)
	ON_BN_CLICKED(ID_Start, OnStart)
	ON_WM_CREATE()
	ON_WM_TIMER()
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CUnicastPacketGraphDlg message handlers

void CUnicastPacketGraphDlg::OnStart() 
{
	if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketIn")
	{
		textrect1.SetRect(25,472,140,503);
		Nametext1.Create(":Unicast Packet In",WS_VISIBLE|SS_CENTER,textrect1,this,43333);
		CDC *theLine;
		theLine = this->GetDC();
		CPen Pen(PS_DASHDOTDOT,3,RGB(255,0,0)); // Red
		theLine->SelectObject(&Pen) ;
		theLine->MoveTo(15,495);
		theLine->LineTo(22,480);
		this->ReleaseDC(theLine);// release the device context 
	} 
	if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketOut")
	{
		textrect2.SetRect(160,472,280,503);
		Nametext2.Create(":Unicast Packet Out",WS_VISIBLE|SS_CENTER,textrect2,this,43334);
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

int CUnicastPacketGraphDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;

	UnicastPacketInRateNowPoint.x = 34;
	UnicastPacketInRateNowPoint.y = 0;

	UnicastPacketOutRateNowPoint.x = 34;	
	UnicastPacketOutRateNowPoint.y = 0;

	return 0;
}

HBRUSH CUnicastPacketGraphDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
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
void CUnicastPacketGraphDlg::DrawInitLineXY()
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
int CUnicastPacketGraphDlg::ConvertValueToYPoint(unsigned int value)
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

void CUnicastPacketGraphDlg::OnTimer(UINT nIDEvent) 
{
	MonitorObject.updatedata(IPaddress);
	CGraphPoint *UnicastPacketInRateNewPoint = new CGraphPoint();
	CGraphPoint *UnicastPacketOutRateNewPoint = new CGraphPoint();
	
	if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketIn")
	{
	// Get the value of the Unicast_Packet_In_Rate
		unsigned int UnicastPacketInDataRate = MonitorObject.Getunicastinrate();
		// set value of 'UnicastPacketInDataRate' to be the value of UnicastPacketinrate
		int UnicastPacketInRateYPoint = ConvertValueToYPoint(UnicastPacketInDataRate);
		if (UnicastPacketInRateNowPoint.x !=700)
			UnicastPacketInRateNewPoint->SetValue(UnicastPacketInRateNowPoint.x+6,UnicastPacketInRateYPoint);
		else if (UnicastPacketInRateNowPoint.x =700) // if reach the Max of x then Not add 20
			UnicastPacketInRateNewPoint->SetValue(UnicastPacketInRateNowPoint.x,UnicastPacketInRateYPoint);
	}
	
	if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketOut")
	{
	// Get the value of the Unicast_Packet_Out_Rate
		unsigned int UnicastPacketOutDataRate = MonitorObject.Getunicastoutrate();
		// set value of 'InDataRate' to be the value of UnicastPacketoutrate
		int UnicastPacketOutRateYPoint = ConvertValueToYPoint(UnicastPacketOutDataRate);
		if (UnicastPacketOutRateNowPoint.x !=700)
			UnicastPacketOutRateNewPoint->SetValue(UnicastPacketOutRateNowPoint.x+6,UnicastPacketOutRateYPoint);
		else if (UnicastPacketOutRateNowPoint.x =700) // if reach the Max of x then Not add 20
			UnicastPacketOutRateNewPoint->SetValue(UnicastPacketOutRateNowPoint.x,UnicastPacketOutRateYPoint);
	}// of GraphType
//***Draw Line
	if (UnicastPacketInRateNowPoint.x <700)
	{

		if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketIn")
		{
		// Draw the Unicast_Packet_In_Rate Line
			if (UnicastPacketInRateNewPoint->thePoint.x >= 40)
			{
				// Draw Line
				DrawLine("UnicastPacketInRate",UnicastPacketInRateNowPoint,UnicastPacketInRateNewPoint->thePoint);
			}
			// Keep point to array
			UnicastPacketInRatePointList.Add(UnicastPacketInRateNewPoint);
			UnicastPacketInRateNowPoint = UnicastPacketInRateNewPoint->thePoint;
		}// of GraphType

		if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketOut")
		{
		// Draw the Unicast_Packet_Out_Rate Line
			if (UnicastPacketOutRateNewPoint->thePoint.x >= 40)
			{
				// Draw Line
				DrawLine("UnicastPacketOutRate",UnicastPacketOutRateNowPoint,UnicastPacketOutRateNewPoint->thePoint);
			}	
			// Keep point to array
			UnicastPacketOutRatePointList.Add(UnicastPacketOutRateNewPoint);
			UnicastPacketOutRateNowPoint = UnicastPacketOutRateNewPoint->thePoint;
		}// of GraphType
	
	} // of if <700
	else // NowPoint.x >= 700
	{
		DeleteOldGraph();
		// Delete All Old Graph Line
		DrawInitLineXY();
		ShiftGraph();
		// Shift All Graph Line
		int LastID = UnicastPacketInRatePointList.GetSize()-1;
	    CGraphPoint* theNowPoint;

		if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketIn")
		{
			// Draw the new Line of Unicast Packet In Rate
			theNowPoint = (CGraphPoint *)UnicastPacketInRatePointList.GetAt(LastID);
			DrawLine("UnicastPacketInRate",theNowPoint->thePoint,UnicastPacketInRateNewPoint->thePoint);
			UnicastPacketInRatePointList.Add(UnicastPacketInRateNewPoint);
			UnicastPacketInRateNowPoint = UnicastPacketInRateNewPoint->thePoint;
		}// of GraphType
  
		if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketOut")
		{
			// Draw the new Line of Unicast Packet Out Rate
			theNowPoint = (CGraphPoint *)UnicastPacketOutRatePointList.GetAt(LastID);
			DrawLine("UnicastPacketOutRate",theNowPoint->thePoint,UnicastPacketOutRateNewPoint->thePoint);		
			UnicastPacketOutRatePointList.Add(UnicastPacketOutRateNewPoint);
			UnicastPacketOutRateNowPoint = UnicastPacketOutRateNewPoint->thePoint;
		}// of GraphType
	}
	CDialog::OnTimer(nIDEvent);
}

//method to draw one Line from NowPoint to TerminalPoint
void CUnicastPacketGraphDlg::DrawLine(CString Type,CPoint StartPoint,CPoint TerminalPoint)
{
	if (!(StartPoint.x==34 && StartPoint.y==0))
	{
		CDC *theLine;
		theLine = this->GetDC();
		// to set the color of Line and 
		//	  to set NowPoint to be the new point
		if (Type == "UnicastPacketInRate")
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0));  // Red
			theLine->SelectObject(&Pen) ;
			theLine->MoveTo(StartPoint);
			theLine->LineTo(TerminalPoint);
		}
		else if (Type == "UnicastPacketOutRate")
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
void CUnicastPacketGraphDlg::DeleteOldGraph()
{
	CDC *BlankLine;
	BlankLine = this->GetDC();
	CPen Pen(PS_DASHDOTDOT,2,RGB(255,255,255));  // White
	BlankLine->SelectObject(&Pen) ;
    CPoint thePoint1;
	CPoint thePoint2;
	CGraphPoint* theObject;
	int LastIndex,i;
	
	if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketIn")
	{
	//Delete the Unicast Packet In Rate Line
		theObject = (CGraphPoint *)UnicastPacketInRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;		
		BlankLine->MoveTo(thePoint1);
		LastIndex = UnicastPacketInRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)UnicastPacketInRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;		
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketOut")
	{
	//Delete the Unicast Packet Out Rate Line
		theObject = (CGraphPoint *)UnicastPacketOutRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;	
		BlankLine->MoveTo(thePoint1);
		LastIndex = UnicastPacketOutRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)UnicastPacketOutRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;	
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(BlankLine);// release the device context 
}

//method to shift the data in array and draw the new line graph	
void CUnicastPacketGraphDlg::ShiftGraph()
{
	CDC *NewLine;
	NewLine = this->GetDC();
	CPoint thePoint1;
	CPoint thePoint2;
	int LastIndex,i;
	CGraphPoint* theObject= new CGraphPoint();;

	if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketIn")
	{
	//Shift the Unicast Packet In Rate Line
		UnicastPacketInRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)UnicastPacketInRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = UnicastPacketInRatePointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0));  // Red
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)UnicastPacketInRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;		
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "UnicastPacketInOut" || GraphType == "UnicastPacketOut")
	{
	//Shift the Unicast Packet Out Rate Line
		UnicastPacketOutRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)UnicastPacketOutRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = UnicastPacketOutRatePointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(0,0,255));  // Blue
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)UnicastPacketOutRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;	
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(NewLine);// release the device context 
}

void CUnicastPacketGraphDlg::OnCancel() 
{
	KillTimer(2);
	CDialog::OnCancel();
}

int CUnicastPacketGraphDlg::DoModal(CString IPAddress,CString Type) 
{
	IPaddress = IPAddress;
	GraphType = Type;
	return CDialog::DoModal();
}
void CUnicastPacketGraphDlg::setmutual(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutual = tptstmutual;
}