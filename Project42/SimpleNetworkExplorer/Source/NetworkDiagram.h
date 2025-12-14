// NetworkDiagram.h: interface for the CNetworkDiagram class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_NETWORKDIAGRAM_H__90CB7C0A_E5C4_11D3_92E1_00E02947F59E__INCLUDED_)
#define AFX_NETWORKDIAGRAM_H__90CB7C0A_E5C4_11D3_92E1_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Diagram.h"
#include "LinkDiagram.h"

class CNetworkDiagram : public CDiagram  // Class NetworkDiagram is derived from Class CDiagram
{
public:
	CNetworkDiagram(CObArray* theLinkList);
	virtual ~CNetworkDiagram();

//Attributes
private:
	int		NetID;		// Network ID no. start at index 0
	CString	NetName;	// Network Name
	char	NetClass;	// Network Class
	CString	NetType;	// Network Type
	// example NetType (Network Type)
	//		Ethernet = 0		Token Ring = 1		FDDI = 2
	//		ATM		 = 3		Frame Rely = 4		Star = 5
	CStringArray NetworkIPList;
	CObArray* LinkDiagramList;
	CStatic IPtext;
	CRect DiagramRect;
	CRect textrect;

//Methods
public:
	void SetValue(CStringArray* DataIn);//(int ID,CString name,char netclass,BYTE type);//
	// method to set initial value of Network Part
	int GetID();
	// method to return value of 'NetID'
	CString* GetName();
	// method to return value of 'NetName' (***Must return with pointer of CString)
	CString* GetType();
	// method to return value of 'NetType' (***Must return with pointer of CString)
    void Show(CWnd* pParentWnd,CPoint position);
	// method to display this Diagram at position in pParentWnd(Window)

	
public:
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CNetworkDiagram)
	//}}AFX_VIRTUAL

// Generated message map functions
protected:
	//{{AFX_MSG(CNetworkDiagram)
		// NOTE - the ClassWizard will add and remove member functions here.
		afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
		afx_msg void OnMouseMove(UINT nFlags, CPoint point);
		afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()

};

#endif // !defined(AFX_NETWORKDIAGRAM_H__90CB7C0A_E5C4_11D3_92E1_00E02947F59E__INCLUDED_)
