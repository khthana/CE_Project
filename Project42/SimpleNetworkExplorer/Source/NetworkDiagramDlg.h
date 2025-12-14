#if !defined(AFX_NETWORKDIAGRAMDLG_H__7E0109D4_039D_11D4_9325_00E02947F59E__INCLUDED_)
#define AFX_NETWORKDIAGRAMDLG_H__7E0109D4_039D_11D4_9325_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// NetworkDiagramDlg.h : header file
//

#include "NetworkDiagram.h"
#include "ComponentDiagram.h"
#include "LinkDiagram.h"

/////////////////////////////////////////////////////////////////////////////
// CNetworkDiagramDlg dialog

class CNetworkDiagramDlg : public CDialog//,CWinApp
{
// Construction
public:
	CNetworkDiagramDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CNetworkDiagramDlg)
	enum { IDD = IDD_NETWORKDIAGRAM };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CNetworkDiagramDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

//Attributes
public:
	CObArray NetworkList;
	CObArray ComponentList;
	CObArray LinkList;
	CBrush m_brush;

// Variable that used for return value
private:
	CPoint ReturnPoint;

//Methods
public:
	void OpenFile(CString FileName,BYTE type);
	// method to open data file(.txt) and ge data from this file to Object Attribute
	//   'type'->  1 = Open Network File ,0 = Open Component File
	CPoint* GetNetworkPoint(CString theIP,int& NetDiagramID);
	// method to test that theIP (input parameter) exist on the diagram 
	//   if Yes,then return the value of Position that NetworkDiagram(theIP) be
	//   else if No,then return CPoint = (-1,-1)
	CPoint* GetComponentPoint(int ComDiagramID,CString* NetworkName);
	// method to test that theIP (input parameter) exist on the diagram 
	//   if Yes,then return the value of Position that NetworkDiagram(theIP) be
	//   else if No,then return CPoint = (-1,-1)


// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CNetworkDiagramDlg)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_NETWORKDIAGRAMDLG_H__7E0109D4_039D_11D4_9325_00E02947F59E__INCLUDED_)
