// LinkDiagram.cpp: implementation of the CLinkDiagram class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "LinkDiagram.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CLinkDiagram::CLinkDiagram(CWnd* PWnd)
{
	ParentWnd = PWnd;
}

CLinkDiagram::~CLinkDiagram()
{

}

//////////////////////////////////////////////////////////////////////
// Method
//////////////////////////////////////////////////////////////////////

// method to set the value of 'NetPoint'
void CLinkDiagram::SetNetPoint(CPoint Pos)
{
	NetPoint = Pos;
}

// method to set the value of 'ComPoint'
void CLinkDiagram::SetComPoint(CPoint Pos)
{
	ComPoint = Pos;
}

// method to create the Link Line 
void CLinkDiagram::CreateLink(int LinkID,int NetID,int ComID,CPoint NetPos,CPoint ComPos)
{
	ID = LinkID;
	NetDiagramID = NetID;
	ComDiagramID = ComID;
    NetPoint = NetPos;
	ComPoint = ComPos;
	CDC *LinkLine;
	LinkLine = ParentWnd->GetDC();
	LinkLine->MoveTo(NetPos);
	LinkLine->LineTo(ComPos);
	ParentWnd->ReleaseDC(LinkLine);// release the device context 
}

// CDC::SetROP2(R2_XORPEN) 
//  is the method to set the Pen to XOR mode that change the value on pixel by XOR
//  the sample,if 00000000 pixel(black pixel) is drawed by XOR Pen
//  then it change to 11111111 pixel(white pixel)

// method to move the link follow the ComponentDiagram that Drag&Drop by user
void CLinkDiagram::MoveLinkComponent(CPoint NewComPos)
{
	CDC *LinkLine;
	LinkLine = ParentWnd->GetDC();
	int oldmode = LinkLine->SetROP2(R2_WHITE);// Change to XOR Mode 
	LinkLine->MoveTo(NetPoint);
	LinkLine->LineTo(ComPoint);	   // delete the old one by draw XOR Line
	LinkLine->SetROP2(oldmode);	   // switch off the XOR mode 
	LinkLine->MoveTo(NetPoint);
	LinkLine->LineTo(NewComPos);   // draw the new line
	ParentWnd->ReleaseDC(LinkLine);// release the device context 
	ComPoint = NewComPos;
}

// method to move the link follow the NetworkDiagram that Drag&Drop by user
void CLinkDiagram::MoveLinkNetwork(CPoint NewNetPos)
{
	CDC *LinkLine;
	LinkLine = ParentWnd->GetDC();
	int oldmode = LinkLine->SetROP2(R2_WHITE);// Change to XOR Mode 
	LinkLine->MoveTo(ComPoint);
	LinkLine->LineTo(NetPoint);	   // delete the old one by draw XOR Line
	LinkLine->SetROP2(oldmode);	   // switch off the XOR mode 
	LinkLine->MoveTo(ComPoint);
	LinkLine->LineTo(NewNetPos);   // draw the new line
	ParentWnd->ReleaseDC(LinkLine);// release the device context 
	NetPoint = NewNetPos;
}