// Diagram.cpp : implementation file
//

#include "stdafx.h"
#include "Diagram.h"
#include "SimpleNetworkExplorer.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDiagram
CPoint m_downPt;  // Pointer variable used to keep pointer value at Left Button Down.

CDiagram::CDiagram()
{
	Exist = FALSE;
}

CDiagram::~CDiagram()
{
}


BEGIN_MESSAGE_MAP(CDiagram, CStatic)
	//{{AFX_MSG_MAP(CDiagram)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		ON_WM_LBUTTONDOWN()
		ON_WM_MOUSEMOVE()
		ON_WM_LBUTTONUP()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDiagram message handlers

// method to display this Diagram at rect in pParentWnd(Window) by nBitmapID(Bitmap)
void CDiagram::Show(CWnd * pParentWnd,CRect &rect,UINT nBitmapID)
{  
	ParentWnd = pParentWnd;
	// use to be the pointer for "CNetworkDiagramDlg" Class
	BitmapRect = rect;
	m_Bitmap.LoadBitmap(nBitmapID);  //Set m_Bitmap to be Resouce Bitmap ID that passed into this function
	Create(NULL,WS_CHILD|WS_VISIBLE|SS_BITMAP|SS_CENTERIMAGE|SS_NOTIFY,rect,pParentWnd);
	SetBitmap(m_Bitmap);
	Pos =rect.TopLeft();	// Pos is CPoint of TopLeft of Bitmap
	CRect InitBoundRect;  
	//GetParent() is the Dialog that call CDiagram
	GetParent()->GetClientRect(InitBoundRect);  // get Initial Boundary Rect of Dialog's coordinate that call CDiagram
	SetBoundRect(InitBoundRect); // Set Boundary of Dragging
}

//method to set the boundary of Dragging Diagram
void CDiagram::SetBoundRect(CRect &boundRect)
{
	CRect rect;
	GetClientRect(rect);  //get the rectangular(CRect Class) of CStatic's coordinte to variable(rect) 
	m_BoundingRect=boundRect; // set Initial Boundary Rect of Dialog's coordinate that call CDiagram  
	m_BoundingRect.right=m_BoundingRect.right-rect.Width();//Subtract the Boundary Rect by the width of CDiagram
	m_BoundingRect.bottom=m_BoundingRect.bottom-rect.Height();//Subtract the Boundary Rect by the hight of CDiagram
}

CRect CDiagram::MoveDiagram(CPoint point)
{
//this code finds the difference between the points where the mouse was initially set down and where it is now and moves the window by that much distance  
//There are 3 coordinates in this code
	// 1.whole screen's coordinate
	// 2.Dialog's coordinate that call Class CDiagram
	// 3.CStatic(Class CDiagram)'s coordinate

	CRect rect;  
//	CPoint scrPt=m_downPt;  // keep value of Point that LButtonDown
	CPoint translation=point-m_downPt; //calculate the distance of Mouse move from LButtonDown to now
//	ClientToScreen(&scrPt); //convert Point(scrPt) from CStatic's coordinate to Whole Screen's coordinate
	GetClientRect(rect);    //get the rectangular(CRect Class) of CStatic's coordinte to variable(rect)
	ClientToScreen(rect);   //convert 'rect' from CStatc's coordinate to Whole Screen's coordinate
//**** core statement****	
	rect.OffsetRect(translation);  //move 'rect' by the distance defined in 'translation'
//***********************	
	GetParent()->ScreenToClient(rect); // convert 'rect' from Whole Screen's coordinate to Dialog's coordinate that call CDiagram
    int nWidth=rect.Width();  
	int nHeight=rect.Height();  
	if (rect.left>m_BoundingRect.right)  //If CDiagram's Left more than Boundary Rect's Right
	{    
		rect.left=m_BoundingRect.right;  //   then set CDiagram's Left equal Boundary Rect's Right
		rect.right=m_BoundingRect.right+nWidth;  // and set CDiagram's Right too
	}  
	if (rect.left<m_BoundingRect.left)  //If CDiagram's Left less than Boundary Rect's Right
	{      
		rect.left=m_BoundingRect.left;      
		rect.right=m_BoundingRect.left+nWidth;  
	}  
	if (rect.top>m_BoundingRect.bottom)  //If CDiagram's Top more than Boundary Rect's Buttom
	{      
		rect.top=m_BoundingRect.bottom;      
		rect.bottom=m_BoundingRect.bottom+nHeight;  
	}  
	if (rect.top<m_BoundingRect.top)     //If CDiagram's Top less than Boundary Rect's Buttom
	{    
		rect.top=m_BoundingRect.top;    
		rect.bottom=m_BoundingRect.top+nHeight;  
	}  
	MoveWindow(rect);  //Move CDiagram follow to rect
	Pos = rect.TopLeft();
	return rect;
}

void CDiagram::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CStatic::OnLButtonDown(nFlags, point);
    SetCapture(); //this ensures that if we drag very fast even then the mouse will stay with us, even if we go outside the main window  
	m_downPt=point; //this holds the point where we initially pressed the mouse button
}


void CDiagram::OnLButtonUp(UINT nFlags, CPoint point) 
{
	CStatic::OnLButtonUp(nFlags, point);
    ReleaseCapture(); //this releases the mouse for other windows
}

CRect CDiagram::OnMouseMove(UINT nFlags, CPoint point) 
{
	CRect NewRect;
	CStatic::OnMouseMove(nFlags, point);
	if (nFlags==MK_LBUTTON)  
	{
		NewRect =MoveDiagram(point); // if Left Button Downed then Move Diagram
	}
	return NewRect;
}

void CDiagram::SetExist(BOOLEAN BeExisted)
{
	Exist = BeExisted;
}

CPoint CDiagram::GetPosition()
{
	// code for change from Pos to the center Point of Bitmap
	int x,y;
	CPoint Position;
	x = BitmapRect.Width()/2;
	y = BitmapRect.Height()/2;
	Position.x = Pos.x+x;
	Position.y = Pos.y+y;
	return Position;
}