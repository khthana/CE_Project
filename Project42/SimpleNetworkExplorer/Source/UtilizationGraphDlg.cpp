// UtilizationGraphDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "UtilizationGraphDlg.h"
#include "MonitorFormControl.h"
#include "GraphPoint.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CUtilizationGraphDlg dialog


CUtilizationGraphDlg::CUtilizationGraphDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CUtilizationGraphDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CUtilizationGraphDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CUtilizationGraphDlg::DoDataExchange(CDataExchange* pDX)
{
	SetWindowText("Utilization Graph");

	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CUtilizationGraphDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CUtilizationGraphDlg, CDialog)
	//{{AFX_MSG_MAP(CUtilizationGraphDlg)
	ON_BN_CLICKED(ID_Start, OnStart)
	ON_WM_CREATE()
	ON_WM_TIMER()
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CUtilizationGraphDlg message handlers

void CUtilizationGraphDlg::OnStart() 
{
	textrect1.SetRect(60,480,150,495);
	Nametext1.Create(": Utilization",WS_VISIBLE|SS_CENTER,textrect1,this,43333);
	CDC *theLine;
	theLine = this->GetDC();
	CPen Pen(PS_DASHDOTDOT,3,RGB(0,0,255)); // Blue
	theLine->SelectObject(&Pen) ;
	theLine->MoveTo(50,495);
	theLine->LineTo(57,480);
	this->ReleaseDC(theLine);// release the device context
	MonitorObject.setmutualex(processID,testmutual);
	MonitorObject.startmon(IPaddress);
	SetTimer(2,2000,NULL);
}

int CUtilizationGraphDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;

	UtilNowPoint.x = 34;
	UtilNowPoint.y = 0;

	return 0;
}

HBRUSH CUtilizationGraphDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
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
void CUtilizationGraphDlg::DrawInitLineXY()
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
int CUtilizationGraphDlg::ConvertValueToYPoint(float value)
{
	int Y = int(value*4);
	if (Y>=440)  Y = 40;  // when Y value excess the max of graph
	else Y = 440-Y;		// 440 is the Point of Y axis
	return Y;
}

void CUtilizationGraphDlg::OnTimer(UINT nIDEvent) 
{
	MonitorObject.updatedata(IPaddress);
	CGraphPoint *UtilNewPoint = new CGraphPoint();
	
	// Get the value of the Data_Error_In_Rate
		float ByteInRate = float(MonitorObject.Getinrate());
		float ByteOutRate = float(MonitorObject.Getoutrate());
		float InterfaceSpeed = float(MonitorObject.Getifspeed());
		float Utilization = (ByteInRate + ByteOutRate)/2;
		Utilization = (Utilization*100/(InterfaceSpeed/8));
		// set value of 'Utilization' to be the value of errorinrate
		int UtilYPoint = ConvertValueToYPoint(Utilization);
		if (UtilNowPoint.x !=700)
			UtilNewPoint->SetValue(UtilNowPoint.x+6,UtilYPoint);
		else if (UtilNowPoint.x =700) // if reach the Max of x then Not add 20
			UtilNewPoint->SetValue(UtilNowPoint.x,UtilYPoint);
	
//***Draw Line
	if (UtilNowPoint.x <700)
	{
                                                                       		// Draw the Data_Error_In_Rate Line
		if (UtilNewPoint->thePoint.x >= 40)
		{
			// Draw Line
			DrawLine(UtilNowPoint,UtilNewPoint->thePoint);
		}
		// Keep point to array
		UtilPointList.Add(UtilNewPoint);
		UtilNowPoint = UtilNewPoint->thePoint;
	} // of if <700
	else // NowPoint.x >= 700
	{
		DeleteOldGraph();
		// Delete All Old Graph Line
		DrawInitLineXY();
		ShiftGraph();
		// Shift All Graph Line
		int LastID = UtilPointList.GetSize()-1;
	    CGraphPoint* theNowPoint;
		// Draw the new Line of Data Error In Rate
		theNowPoint = (CGraphPoint *)UtilPointList.GetAt(LastID);
		DrawLine(theNowPoint->thePoint,UtilNewPoint->thePoint);
		UtilPointList.Add(UtilNewPoint);
		UtilNowPoint = UtilNewPoint->thePoint;
	}
	CDialog::OnTimer(nIDEvent);
}

//method to draw one Line from NowPoint to TerminalPoint
void CUtilizationGraphDlg::DrawLine(CPoint StartPoint,CPoint TerminalPoint)
{
	if (!(StartPoint.x==34 && StartPoint.y==0))
	{
		CDC *theLine;
		theLine = this->GetDC();
		// to set the color of Line and 
		//	  to set NowPoint to be the new point
			CPen Pen(PS_DASHDOTDOT,2,RGB(0,0,255));  // Blue
			theLine->SelectObject(&Pen) ;
			theLine->MoveTo(StartPoint);
			theLine->LineTo(TerminalPoint);
		this->ReleaseDC(theLine);// release the device context 
	}
}

//method to draw the white line replace the old one
void CUtilizationGraphDlg::DeleteOldGraph()
{
	CDC *BlankLine;
	BlankLine = this->GetDC();
	CPen Pen(PS_DASHDOTDOT,2,RGB(255,255,255));  // White
	BlankLine->SelectObject(&Pen) ;
    CPoint thePoint1;
	CPoint thePoint2;
	CGraphPoint* theObject;
	int LastIndex,i;
	//Delete the Data Error In Rate Line
		theObject = (CGraphPoint *)UtilPointList.GetAt(0);
		thePoint1 = theObject->thePoint;		
		BlankLine->MoveTo(thePoint1);
		LastIndex = UtilPointList.GetSize()-1;
		for (i=1;i<=LastIndex;i++)
		{
			theObject = (CGraphPoint *)UtilPointList.GetAt(i);
			thePoint2 = theObject->thePoint;		
			BlankLine->LineTo(thePoint2);
		}
	this->ReleaseDC(BlankLine);// release the device context 
}

//method to shift the data in array and draw the new line graph	
void CUtilizationGraphDlg::ShiftGraph()
{
	CDC *NewLine;
	NewLine = this->GetDC();
	CPoint thePoint1;
	CPoint thePoint2;
	int LastIndex,i;
	CGraphPoint* theObject= new CGraphPoint();;
	//Shift the Data Error In Rate Line
		UtilPointList.RemoveAt(0,1);
		theObject = (CGraphPoint *)UtilPointList.GetAt(0);
		thePoint1.x = theObject->thePoint.x-6;
		thePoint1.y = theObject->thePoint.y;
		NewLine->MoveTo(thePoint1);
		LastIndex = UtilPointList.GetSize()-1;
		for (i=0;i<=LastIndex;i++)
		{
			CPen Pen(PS_DASHDOTDOT,2,RGB(0,0,255));  // Blue
			NewLine->SelectObject(&Pen) ;
			theObject = (CGraphPoint *)UtilPointList.GetAt(i);
			theObject->SetValue(theObject->thePoint.x-3,theObject->thePoint.y);
			thePoint2 = theObject->thePoint;		
			NewLine->LineTo(thePoint2);
		}
	this->ReleaseDC(NewLine);// release the device context 
}

void CUtilizationGraphDlg::OnCancel() 
{
	KillTimer(2);
	CDialog::OnCancel();
}

int CUtilizationGraphDlg::DoModal(CString IPAddress) 
{
	IPaddress = IPAddress;
	return CDialog::DoModal();
}
void CUtilizationGraphDlg::setmutual(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutual = tptstmutual;
}
