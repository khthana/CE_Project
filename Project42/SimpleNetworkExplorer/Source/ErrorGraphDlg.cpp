// ErrorGraphDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "ErrorGraphDlg.h"
#include "MonitorFormControl.h"
#include "GraphPoint.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CErrorGraphDlg dialog


CErrorGraphDlg::CErrorGraphDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CErrorGraphDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CErrorGraphDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CErrorGraphDlg::DoDataExchange(CDataExchange* pDX)
{
	if (GraphType == "ErrorInOut")
		SetWindowText("Error In/Out Graph");
	else 	if (GraphType == "ErrorIn")
		SetWindowText("Error In Graph");
	else	if (GraphType == "ErrorOut")
		SetWindowText("Error Out Graph");

	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CErrorGraphDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CErrorGraphDlg, CDialog)
	//{{AFX_MSG_MAP(CErrorGraphDlg)
	ON_BN_CLICKED(ID_Start, OnStart)
	ON_WM_CREATE()
	ON_WM_TIMER()
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CErrorGraphDlg message handlers

void CErrorGraphDlg::OnStart() 
{
	if (GraphType == "ErrorInOut" || GraphType == "ErrorIn")
	{
		textrect1.SetRect(60,480,130,495);
		Nametext1.Create(": Error In",WS_VISIBLE|SS_CENTER,textrect1,this,43333);
		CDC *theLine;
		theLine = this->GetDC();
		CPen Pen(PS_DASHDOTDOT,3,RGB(255,0,0)); // Red
		theLine->SelectObject(&Pen) ;
		theLine->MoveTo(50,495);
		theLine->LineTo(57,480);
		this->ReleaseDC(theLine);// release the device context 
	} 
	if (GraphType == "ErrorInOut" || GraphType == "ErrorOut")
	{
		textrect2.SetRect(160,480,230,495);
		Nametext2.Create(": Error Out",WS_VISIBLE|SS_CENTER,textrect2,this,43334);
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

int CErrorGraphDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;

	ErrInRateNowPoint.x = 34;
	ErrInRateNowPoint.y = 0;

	ErrOutRateNowPoint.x = 34;	
	ErrOutRateNowPoint.y = 0;

	return 0;
}

HBRUSH CErrorGraphDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
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
void CErrorGraphDlg::DrawInitLineXY()
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
int CErrorGraphDlg::ConvertValueToYPoint(unsigned int value)
{
	int Y = int(value);
	Y = Y/2;			// devide by 2 because convert YPoint from per 2 Sec to per sec
	if (Y>=440)  Y = 40;  // when Y value excess the max of graph
	else Y = 440-Y;		// 440 is the Point of Y axis
	return Y;
}

void CErrorGraphDlg::OnTimer(UINT nIDEvent) 
{
	MonitorObject.updatedata(IPaddress);
	CGraphPoint *ErrInRateNewPoint = new CGraphPoint();
	CGraphPoint *ErrOutRateNewPoint = new CGraphPoint();
	
	if (GraphType == "ErrorInOut" || GraphType == "ErrorIn")
	{
	// Get the value of the Data_Error_In_Rate
		unsigned int ErrInDataRate = MonitorObject.Geterrorinrate();
		// set value of 'ErrInDataRate' to be the value of errorinrate
		int ErrInRateYPoint = ConvertValueToYPoint(ErrInDataRate);
		if (ErrInRateNowPoint.x !=700)
			ErrInRateNewPoint->SetValue(ErrInRateNowPoint.x+6,ErrInRateYPoint);
		else if (ErrInRateNowPoint.x =700) // if reach the Max of x then Not add 20
			ErrInRateNewPoint->SetValue(ErrInRateNowPoint.x,ErrInRateYPoint);
	}
	
	if (GraphType == "ErrorInOut" || GraphType == "ErrorOut")
	{
	// Get the value of the Data_Error_Out_Rate
		unsigned int ErrOutDataRate = MonitorObject.Geterroroutrate();
		// set value of 'InDataRate' to be the value of erroroutrate
		int ErrOutRateYPoint = ConvertValueToYPoint(ErrOutDataRate);
		if (ErrOutRateNowPoint.x !=700)
			ErrOutRateNewPoint->SetValue(ErrOutRateNowPoint.x+6,ErrOutRateYPoint);
		else if (ErrOutRateNowPoint.x =700) // if reach the Max of x then Not add 20
			ErrOutRateNewPoint->SetValue(ErrOutRateNowPoint.x,ErrOutRateYPoint);
	}// of GraphType
//***Draw Line
	if (ErrInRateNowPoint.x <700)
	{

		if (GraphType == "ErrorInOut" || GraphType == "ErrorIn")
		{
		// Draw the Data_Error_In_Rate Line
			if (ErrInRateNewPoint->thePoint.x >= 40)
			{
				// Draw Line
				DrawLine("ErrInRate",ErrInRateNowPoint,ErrInRateNewPoint->thePoint);
			}
			// Keep point to array
			ErrInRatePointList.Add(ErrInRateNewPoint);
			ErrInRateNowPoint = ErrInRateNewPoint->thePoint;
		}// of GraphType

		if (GraphType == "ErrorInOut" || GraphType == "ErrorOut")
		{
		// Draw the Data_Error_Out_Rate Line
			if (ErrOutRateNewPoint->thePoint.x >= 40)
			{
				// Draw Line
				DrawLine("ErrOutRate",ErrOutRateNowPoint,ErrOutRateNewPoint->thePoint);
			}	
			// Keep point to array
			ErrOutRatePointList.Add(ErrOutRateNewPoint);
			ErrOutRateNowPoint = ErrOutRateNewPoint->thePoint;
		}// of GraphType
	
	} // of if <700
	else // NowPoint.x >= 700
	{
		DeleteOldGraph();
		// Delete All Old Graph Line
		DrawInitLineXY();
		ShiftGraph();
		// Shift All Graph Line
		int LastID = ErrInRatePointList.GetSize()-1;
	    CGraphPoint* theNowPoint;

		if (GraphType == "ErrorInOut" || GraphType == "ErrorIn")
		{
			// Draw the new Line of Data Error In Rate
			theNowPoint = (CGraphPoint *)ErrInRatePointList.GetAt(LastID);
			DrawLine("ErrInRate",theNowPoint->thePoint,ErrInRateNewPoint->thePoint);
			ErrInRatePointList.Add(ErrInRateNewPoint);
			ErrInRateNowPoint = ErrInRateNewPoint->thePoint;
		}// of GraphType
  
		if (GraphType == "ErrorInOut" || GraphType == "ErrorOut")
		{
			// Draw the new Line of Data Error Out Rate
			theNowPoint = (CGraphPoint *)ErrOutRatePointList.GetAt(LastID);
			DrawLine("ErrOutRate",theNowPoint->thePoint,ErrOutRateNewPoint->thePoint);		
			ErrOutRatePointList.Add(ErrOutRateNewPoint);
			ErrOutRateNowPoint = ErrOutRateNewPoint->thePoint;
		}// of GraphType
	}
	CDialog::OnTimer(nIDEvent);
}

//method to draw one Line from NowPoint to TerminalPoint
void CErrorGraphDlg::DrawLine(CString Type,CPoint StartPoint,CPoint TerminalPoint)
{
	if (!(StartPoint.x==34 && StartPoint.y==0))
	{
		CDC *theLine;
		theLine = this->GetDC();
		// to set the color of Line and 
		//	  to set NowPoint to be the new point
		if (Type == "ErrInRate")
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0));  // Red
			theLine->SelectObject(&Pen) ;
			theLine->MoveTo(StartPoint);
			theLine->LineTo(TerminalPoint);
		}
		else if (Type == "ErrOutRate")
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
void CErrorGraphDlg::DeleteOldGraph()
{
	CDC *BlankLine;
	BlankLine = this->GetDC();
	CPen Pen(PS_DASHDOTDOT,2,RGB(255,255,255));  // White
	BlankLine->SelectObject(&Pen) ;
    CPoint thePoint1;
	CPoint thePoint2;
	CGraphPoint* theObject;
	int LastIndex,i;
	
	if (GraphType == "ErrorInOut" || GraphType == "ErrorIn")
	{
	//Delete the Data Error In Rate Line
		theObject = (CGraphPoint *)ErrInRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;		
		BlankLine->MoveTo(thePoint1);
		LastIndex = ErrInRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)ErrInRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;		
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "ErrorInOut" || GraphType == "ErrorOut")
	{
	//Delete the Data Error Out Rate Line
		theObject = (CGraphPoint *)ErrOutRatePointList.GetAt(0);
		thePoint1 = theObject->thePoint;	
		BlankLine->MoveTo(thePoint1);
		LastIndex = ErrOutRatePointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)ErrOutRatePointList.GetAt(i);
			thePoint2 = theObject->thePoint;	
			BlankLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(BlankLine);// release the device context 
}

//method to shift the data in array and draw the new line graph	
void CErrorGraphDlg::ShiftGraph()
{
	CDC *NewLine;
	NewLine = this->GetDC();
	CPoint thePoint1;
	CPoint thePoint2;
	int LastIndex,i;
	CGraphPoint* theObject= new CGraphPoint();;

	if (GraphType == "ErrorInOut" || GraphType == "ErrorIn")
	{
	//Shift the Data Error In Rate Line
		ErrInRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)ErrInRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = ErrInRatePointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(255,0,0));  // Red
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)ErrInRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;		
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType

	if (GraphType == "ErrorInOut" || GraphType == "ErrorOut")
	{
	//Shift the Data Error Out Rate Line
		ErrOutRatePointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)ErrOutRatePointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = ErrOutRatePointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(0,0,255));  // Blue
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)ErrOutRatePointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-6,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;	
			NewLine->LineTo(thePoint2);
		}
	}// of GraphType
	this->ReleaseDC(NewLine);// release the device context 
}

void CErrorGraphDlg::OnCancel() 
{
	KillTimer(2);
	CDialog::OnCancel();
}

int CErrorGraphDlg::DoModal(CString IPAddress,CString Type) 
{
	IPaddress = IPAddress;
	GraphType = Type;
	return CDialog::DoModal();
}
void CErrorGraphDlg::setmutual(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutual = tptstmutual;
}