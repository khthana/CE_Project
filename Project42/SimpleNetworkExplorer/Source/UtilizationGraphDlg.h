#if !defined(AFX_UTILIZATIONGRAPHDLG_H__A7953704_0EA9_11D4_9347_00E02947F59E__INCLUDED_)
#define AFX_UTILIZATIONGRAPHDLG_H__A7953704_0EA9_11D4_9347_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// UtilizationGraphDlg.h : header file
//

#include "MonitorFormControl.h"

/////////////////////////////////////////////////////////////////////////////
// CUtilizationGraphDlg dialog

class CUtilizationGraphDlg : public CDialog
{
// Construction
public:
	bool* testmutual;
	int processID;
	void setmutual(int,bool*);
	CUtilizationGraphDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CUtilizationGraphDlg)
	enum { IDD = IDD_UtilizationGraphDlg };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

//Attribute
	MonitorFormControl MonitorObject;
	CString IPaddress;
	CPoint UtilNowPoint;
	CObArray UtilPointList;
	CBrush m_brush;
	CStatic Nametext1;
	CRect textrect1;	

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CUtilizationGraphDlg)
	public:
	virtual int DoModal(CString IPAddress);
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Methods
	void DrawInitLineXY();
	//method to draw the Line X axis and Y axis
	int ConvertValueToYPoint(float value);
	//method to convert the value of Data's Volume to Y point on graph
	//  by return to integer(Y Point)
	void DrawLine(CPoint StartPoint,CPoint TerminalPoint);
	//method to draw one Line from NowPoint to TerminalPoint
	void DeleteOldGraph();
	//method to draw the white line replace the old one
	void ShiftGraph();
	//method to shift the data in array and draw the new line graph

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CUtilizationGraphDlg)
	afx_msg void OnStart();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	virtual void OnCancel();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_UTILIZATIONGRAPHDLG_H__A7953704_0EA9_11D4_9347_00E02947F59E__INCLUDED_)
