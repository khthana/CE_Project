// ComponentDiagram.h: interface for the CComponentDiagram class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_COMPONENTDIAGRAM_H__90CB7C0B_E5C4_11D3_92E1_00E02947F59E__INCLUDED_)
#define AFX_COMPONENTDIAGRAM_H__90CB7C0B_E5C4_11D3_92E1_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Diagram.h"
#include "NetworkInterface.h"
#include "LinkDiagram.h"
#include "SimpleNetworkExplorer.h"

class CComponentDiagram : public CDiagram  
{
public:
	CComponentDiagram(CObArray* theLinkList);
	virtual ~CComponentDiagram();

//Attributes
private:
	int		CID;		 // Component ID no. start at index 0
	CString CName;		 // Component Name 
	CString CType;		 // Component Type	
	int		IF_No;       // Interface Number
	CObArray InterfaceList;
//	CNetworkInterface InterfaceObject;
	// represent CType's Symbol (Component Type)
	//		Router = 0		Server = 1		Workstation = 2
	//		Switch = 3		Hub	   = 4
	CStringArray NetworkIPList;
	CObArray* LinkDiagramList;
	CStatic IPtext;		// CStatic text that show the IP of Network
	CRect DiagramRect;
	CRect textrect;

//Methods
public:
	void SetValue(CStringArray* DataIn);//(int ID,CString name,BYTE type,int IFno);
	// method to set initial value of Component in Network
	CString* GetName();
	// method to return value of 'CName' (***Must return with pointer of CString)
	CString* GetType();
	// method to return value of 'CType' (***Must return with pointer of CString)
	ipfields* IPString_to_IPField(CString inIP);
	// method to split the IP String to field by .(dot)
	CString* IPField_to_IPString(ipfields inip);
	// method to include 4 fields of IP to String IP
	char chr(byte inconvert);
	// method to convert Integer (byte) to char
	CStringArray* ListofConnectedNetwork();
	// method to find the IP of network that this Interface is connected
    void Show(CWnd* pParentWnd,CPoint position);
	// method to display this Diagram in pParentWnd(Window)


public:
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CComponentDiagram)
	//}}AFX_VIRTUAL

// Generated message map functions
protected:
	//{{AFX_MSG(CComponentDiagram)
		// NOTE - the ClassWizard will add and remove member functions here.
		afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
		afx_msg void OnMouseMove(UINT nFlags, CPoint point);
		afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()

};

#endif // !defined(AFX_COMPONENTDIAGRAM_H__90CB7C0B_E5C4_11D3_92E1_00E02947F59E__INCLUDED_)
