// NetworkDiagram.cpp: implementation of the CNetworkDiagram class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "NetworkDiagram.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CNetworkDiagram::CNetworkDiagram(CObArray* theLinkList)
{
	LinkDiagramList = theLinkList;
}

CNetworkDiagram::~CNetworkDiagram()
{

}

BEGIN_MESSAGE_MAP(CNetworkDiagram, CStatic)
	//{{AFX_MSG_MAP(CNetworkDiagram)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		ON_WM_LBUTTONDOWN()
		ON_WM_MOUSEMOVE()
		ON_WM_LBUTTONUP()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CNetworkDiagram message handlers

void CNetworkDiagram::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CDiagram::OnLButtonDown(nFlags, point);
    SetCapture(); //this ensures that if we drag very fast even then the mouse will stay with us, even if we go outside the main window  
	//m_downPt=point; //this holds the point where we initially pressed the mouse button
}

void CNetworkDiagram::OnLButtonUp(UINT nFlags, CPoint point) 
{
	CDiagram::OnLButtonUp(nFlags, point);
    ReleaseCapture(); //this releases the mouse for other windows
}

void CNetworkDiagram::OnMouseMove(UINT nFlags, CPoint point) 
{
	CRect NewBitmapRect =CDiagram::OnMouseMove(nFlags, point);
	if (nFlags==MK_LBUTTON)  
	{
		int LastID = LinkDiagramList->GetSize()-1;
		// used to keep the last index of LinkDiagramList.(must -1 because index start at 0)
		for(int i=0;i<=LastID;i++)
		{
			CLinkDiagram* LinkObject;
			// declare 'LinkObject' be pointer to 'CLinkObject' 
			LinkObject = (CLinkDiagram *)LinkDiagramList->GetAt(i);
			// get CLinkDiagram Object from 'LinkDiagramList'
			if (NetID == LinkObject->NetDiagramID)
			{
				LinkObject->MoveLinkNetwork(GetPosition());
			}// of if map Network ID
		}// of for 
		int x1 = NewBitmapRect.left;
		int y1 = NewBitmapRect.bottom;//+DiagramRect.Height();
		int x2 = NewBitmapRect.right;
		int y2 = y1+20;
		textrect.SetRect(x1,y1,x2,y2);
		IPtext.MoveWindow(textrect,TRUE);//point.x,point.y,textrect.Width(),textrect.Height(),TRUE); 
	}// of if MK_LBUTTON
}

//////////////////////////////////////////////////////////////////////
//Methods
//////////////////////////////////////////////////////////////////////

// method to set initial value of Network Part
//     Must pass parameter that be Class by use pointer
void CNetworkDiagram::SetValue(CStringArray* DataIn)//(int ID,CString name,char netclass,BYTE type)
{
//index 0=ID ;1=Network Name ;2=Network Class ;3=Network Type
//In File "NetName//NetClass//NetType#" that insert 'NetID' at index 0
	NetID    =atoi(DataIn->GetAt(0));		// Network ID no.
	NetName  =DataIn->GetAt(1);				// Network Name
	NetClass =DataIn->GetAt(2).GetAt(0);	// Network Class
	NetType	 =DataIn->GetAt(3);  			// Network Type
}

int CNetworkDiagram::GetID()
{
	return NetID;
	// method to return value of 'NetID'
}

CString* CNetworkDiagram::GetName()
{
	return &NetName;
	// can't return value with CString because it's Class.
	// must return with pointer of CString
}

CString* CNetworkDiagram::GetType()
{
	return &NetType;
}

// method to display this Diagram at position in pParentWnd(Window)
void CNetworkDiagram::Show(CWnd* pParentWnd,CPoint position)
{
	if (NetType=="Ethernet")
	{
		DiagramRect.SetRect(position.x,position.y,position.x+136,position.y+22);
		CDiagram::Show(pParentWnd,DiagramRect,IDB_Ethernet);
	}
	else if (NetType=="Token Ring")
	{
		DiagramRect.SetRect(position.x,position.y,position.x+120,position.y+38);
		CDiagram::Show(pParentWnd,DiagramRect,IDB_TokenRing);
	}
	else if (NetType=="FDDI")
	{
		DiagramRect.SetRect(position.x,position.y,position.x+68,position.y+68);
		CDiagram::Show(pParentWnd,DiagramRect,IDB_FDDI);
	}
	else
	{
		DiagramRect.SetRect(position.x,position.y,position.x+73,position.y+73);
		CDiagram::Show(pParentWnd,DiagramRect,IDB_othernet);
	}
	int x1 = position.x-5;
	int y1 = position.y+DiagramRect.Height();
	int x2 = position.x+DiagramRect.Width()+5;
	int y2 = y1+20;
	textrect.SetRect(x1,y1,x2,y2);
	IPtext.Create(NetName,WS_VISIBLE|SS_CENTER,textrect,pParentWnd,5555+NetID);
}
