// LinkDiagram.h: interface for the CLinkDiagram class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_LINKDIAGRAM_H__B6E2322B_020B_11D4_931E_00E02947F59E__INCLUDED_)
#define AFX_LINKDIAGRAM_H__B6E2322B_020B_11D4_931E_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CLinkDiagram : public CStatic  
{

public:
	CLinkDiagram(CWnd* PWnd);
	virtual ~CLinkDiagram();

// Attributes
public:
	int ID;
	int NetDiagramID; // ID of NetworkDiagram that has this Link
	int ComDiagramID; // ID of ComponentDiagram that has this Link
	CWnd* ParentWnd;  // use to be the pointer for "CNetworkDiagramDlg"	Class

private:
	CPoint NetPoint; // the Position of NetworkDiagram that has this link
	CPoint ComPoint; // the Position of ComponentDiagram that has this link

// Methods
public:
	void SetNetPoint(CPoint Pos);
	// method to set the value of 'NetPoint'
	void SetComPoint(CPoint Pos);
	// method to set the value of 'ComPoint'
	void CreateLink(int LinkID,int NetID,int ComID,CPoint NetPos,CPoint ComPos);
	// method to create the link line from NetworkDiagram to Component Diagram
	void MoveLinkComponent(CPoint NewComPos);
	// method to move the link follow the ComponentDiagram
	//  that Drag&Drop by user
	void MoveLinkNetwork(CPoint NewNetPos);
	// method to move the link follow the NetworkDiagram
	//  that Drag&Drop by user
};

#endif // !defined(AFX_LINKDIAGRAM_H__B6E2322B_020B_11D4_931E_00E02947F59E__INCLUDED_)
