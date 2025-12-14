// GraphDialog.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "GraphDialog.h"
#include "MonitorFormControl.h"
#include "GraphPoint.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CGraphDialog dialog


CGraphDialog::CGraphDialog(CWnd* pParent /*=NULL*/)
	: CDialog(CGraphDialog::IDD, pParent)
{
	//{{AFX_DATA_INIT(CGraphDialog)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CGraphDialog::DoDataExchange(CDataExchange* pDX)
{
	if (GraphType == "ByteInOut")
		SetWindowText("Byte In/Out Graph");
	else	if (GraphType == "ByteInt")
		SetWindowText("Byte In Graph");
	else	if (GraphType == "ByteInOut")
		SetWindowText("Byte Out Graph");

	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CGraphDialog)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CGraphDialog, CDialog)
	//{{AFX_MSG_MAP(CGraphDialog)
	ON_BN_CLICKED(ID_Start, OnStart)
	ON_WM_CREATE()
	ON_WM_TIMER()
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CGraphDialog message handlers

void CGraphDialog::OnStart() 
{
	if (GraphType == "ByteInOut" || GraphType == "ByteIn")
	{
		textrect1.SetRect(60,480,130,495);
		Nametext1.Create(": Byte In",WS_VISIBLE|SS_CENTER,textrect1,this,43333);
		CDC *theLine;
		theLine = this->GetDC();
		CPen Pen(PS_DASHDOTDOT,3,RGB(255,0,0)); // Red
		theLine->SelectObject(&Pen) ;
		theLine->MoveTo(50,495);
		theLine->LineTo(57,480);
		this->ReleaseDC(theLine);// release the device context 
	} 
	if (GraphType == "ByteInOut" || GraphType == "ByteOut")
	{
		textrect2.SetRect(160,480,230,495);
		Nametext2.Create(": Byte Out",WS_VISIBLE|SS_CENTER,textrect2,this,43334);
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
//	MonitorObject.SetTimer(1,5000,NULL);
//	MonitorObject.OnTimer(1);
	SetTimer(2,2000,NULL);
}

int CGraphDialog::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	InRateNowPoint.x = 34;
	InRateNowPoint.y = 0;

	OutRateNowPoint.x = 34;
	OutRateNowPoint.y = 0;

	return 0;
}

HBRUSH CGraphDialog::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
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

//////////////////////////////////////////////////////////////////////////
// Methods

//method to draw the Line X axis and Y axis
void CGraphDialog::DrawInitLineXY()
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
int CGraphDialog::ConvertValueToYPoint(unsigned int value)
{
	float Ypoint;
	Ypoint = float(value/200000.000);
	Ypoint = Ypoint*20;
	int Y = int(Ypoint);
	if (Y>=440)  Y = 40;  // when Y value excess the max of graph
	else Y = 440-Y;		// 440 is the Point of Y axis
	return Y;
}

void CGraphDialog::OnTimer(UINT nIDEvent) 
{
	MonitorObject.updatedata(IPaddress);
	CGraphPoint *InRateNewPoint = new CGraphPoint();
	CGraphPoint *OutRateNewPoint = new CGraphPoint();
//	MonitorFormControl* MonitorObject;
	// declare 'MonitorObject' be pointer to 'MonitorFormControl' 
	if (GraphType == "ByteInOut" || GraphType == "ByteIn")
	{
	// Get the value of the Data_In_Rate
		unsigned int InDataRate = MonitorObject.Getinrate();
		// set value of 'InDataRate' to be the value of inrate
		int InRateYPoint = ConvertValueToYPoint(InDataRate);
		if (InRateNowPoint.x !=700)
			InRateNewPoint->SetValue(InRateNowPoint.x+6,InRateYPoint);
		else if (InRateNowPoint.x =700) // if reach the Max of x then Not add 20
			InRateNewPoint->SetValue(InRateNowPoint.x,InRateYPoint);
	}

	if (GraphType == "ByteInOut" || GraphType == "ByteOut")
	{
	// Get the value of the Data_Out_Rate
		unsigned int OutDataRate = MonitorObject.Getoutrate();
		// set value of 'OutDataRate' to be the value of outrate
		int OutRateYPoint = ConvertValueToYPoint(OutDataRate);
		if (OutRateNowPoint.x !=700)
			OutRateNewPoint->SetValue(OutRateNowPoint.x+6,OutRateYPoint);
		else if (OutRateNowPoint.x =700) // if reach the Max of x then Not add 20
			OutRateNewPoint->SetValue(OutRateNowPoint.x,OutRateYPoint);
	}
	
//***Draw Line
	if (InRateNowPoint.x <700)
	{
		if (GraphType == "ByteInOut" || GraphType == "ByteIn")
		{
		// Draw the Data_In_Rate Line
			if (InRateNowPoint.x >= 40)
			{			
				// Draw Line
				DrawLine("InRate",InRateNowPoint,InRateNewPoint->thePoint);
			}
			// Keep point to array
			InRatePointList.Add(InRateNewPoint);
			InRateNowPoint = InRateNewPoint->thePoint;
		}// of GraphType
		
		if (GraphType == "ByteInOut" || GraphType == "ByteOut")
		{
		// Draw the Data_Out_Rate Line
			if (OutRateNewPoint->thePoint.x >= 40)
			{
				// Draw Line
				DrawLine("OutRate",OutRateNowPoint,OutRateNewPoint->thePoint);
			}
			// Keep point to array
			OutRatePointList.Add(OutRateNewPoint);
			OutRateNowPoint = OutRateNewPoint->thePoint;
		}// of GraphType

	} // of if <700
	else // NowPoint.x >= 700
	{
		DeleteOldGraph();
		// Delete All Old Graph Line
		DrawInitLineXY();
		ShiftGraph();
		// Shift All Graph Line
//		CDC *NewLine;
//		NewLine = this->GetDC();
		int LastID = InRatePointList.GetSize()-1;
	    CGraphPoint* theNowPoint;

		if (GraphType == "ByteInOut" || GraphType == "ByteIn")
		{
		// Draw the new Line of Data In Rate
			theNowPoint = (CGraphPoint *)InRatePointList.GetAt(LastID);
			DrawLine("InRate",theNowPoint->thePoint,InRateNewPoint->thePoint);
			InRatePointList.Add(InRateNewPoint);
			InRateNowPoint = InRateNewPoint->thePoint;
		}// of GraphType

		if (GraphType == "ByteInOut" || GraphType == "ByteOut")
		{
		// Draw the new Line of Data Out Rate
			theNowPoint = (CGraphPoint *)OutRatePointList.GetAt(LastID);
			DrawLine("OutRate",theNowPoint->thePoint,OutRateNewPoint->thePoint);
			OutRatePointList.Add(OutRateNewPoint);
			OutRateNowPoint = OutRateNewPoint->thePoint;
		}// of GraphType
	}
	CDialog::OnTimer(nIDEvent);
}

//method to draw one Line from NowPoint to TerminalPoint
void CGraphDialog::DrawLine(CString Type,CPoint StartPoint,CPoint TerminalPoint)
{
	if (!(StartPoint.x==34 && StartPoint.y==0))
	{
		CDC *theLine;
		theLine = this->GetDC();
		// to set the color of Line and 
		//	  to set NowPoint to be the new point
		if (Type == "InRate")
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0)); // Red
			theLine->SelectObject(&Pen) ;
			theLine->MoveTo(StartPoint);
			theLine->LineTo(TerminalPoint);
		}
		else if (Type == "OutRate")
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
void CGraphDialog::DeleteOldGraph()
{
	CDC *BlankLine;
	BlankLine = this->GetDC();
	CPen Pen(PS_DASHDOTDOT,2,RGB(255,255,255));  // White
	BlankLine->SelectObject(&Pen) ;
    CPoint thePoint1;
	CPoint thePoint2;
	CGraphPoint* theObject;
	int LastIndex,i;

	if (GraphType == "ByteInOut" || GraphType == "ByteIn")
	{
	//Delete the Data In Rate Line
		theObject = (CGraphPoint *)InRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;
		BlankLine->MoveTo(thePoint1);
		LastIndex = InRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)InRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "ByteInOut" || GraphType == "ByteOut")
	{
	//Delete the Data Out Rate Line
		theObject = (CGraphPoint *)OutRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;	
		BlankLine->MoveTo(thePoint1);
		LastIndex = OutRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)OutRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;	
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(BlankLine);// release the device context 
}

//method to shift the data in array and draw the new line graph	
void CGraphDialog::ShiftGraph()
{
	CDC *NewLine;
	NewLine = this->GetDC();
	CPoint thePoint1;
	CPoint thePoint2;
	CGraphPoint* theObject= new CGraphPoint();;
	int LastIndex,i;

	if (GraphType == "ByteInOut" || GraphType == "ByteIn")
	{
	//Shift the Data In Rate Line
		InRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)InRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = InRatePointList.GetSize()-1;
		for (int i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0)); // Red
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)InRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			InRatePointList.SetAt(i,theObject);
			thePoint2 = theObject->thePoint;
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "ByteInOut" || GraphType == "ByteIn")
	{
	//Shift the Data Out Rate Line
		OutRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)OutRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = OutRatePointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(0,0,255));  // Blue
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)OutRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;	
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(NewLine);// release the device context 
}

void CGraphDialog::OnCancel() 
{
//	MonitorObject.stopmon();
	KillTimer(2);
	CDialog::OnCancel();
}

int CGraphDialog::DoModal(CString IPAddress,CString Type) 
{
	IPaddress = IPAddress;
	GraphType = Type;
	return CDialog::DoModal();
}

void CGraphDialog::setmutual(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutual = tptstmutual;
}
