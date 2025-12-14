#if !defined(AFX_ERRORGRAPHDLG_H__6CAAA566_0D3D_11D4_9343_00E02947F59E__INCLUDED_)
#define AFX_ERRORGRAPHDLG_H__6CAAA566_0D3D_11D4_9343_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ErrorGraphDlg.h : header file
//

#include "MonitorFormControl.h"

/////////////////////////////////////////////////////////////////////////////
// CErrorGraphDlg dialog

class CErrorGraphDlg : public CDialog
{
// Construction
public:
	bool* testmutual;
	int processID;
	void setmutual(int,bool*);
	CErrorGraphDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CErrorGraphDlg)
	enum { IDD = IDD_ErrorGraphDlg };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

//Attribute
	MonitorFormControl MonitorObject;
	CString IPaddress;
	CString GraphType;
	CPoint ErrInRateNowPoint;
	CPoint ErrOutRateNowPoint;
	CObArray ErrInRatePointList;
	CObArray ErrOutRatePointList;
	CBrush m_brush;
	CStatic Nametext1;
	CStatic Nametext2;
	CRect textrect1;	
	CRect textrect2;

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CErrorGraphDlg)
	public:
	virtual int DoModal(CString IPAddress,CString Type);
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Methods
	void DrawInitLineXY();
	//method to draw the Line X axis and Y axis
	int ConvertValueToYPoint(unsigned int value);
	//method to convert the value of Data's Volume to Y point on graph
	//  by return to integer(Y Point)
	void DrawLine(CString Type,CPoint StartPoint,CPoint TerminalPoint);
	//method to draw one Line from NowPoint to TerminalPoint
	void DeleteOldGraph();
	//method to draw the white line replace the old one
	void ShiftGraph();
	//method to shift the data in array and draw the new line graph

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CErrorGraphDlg)
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

#endif // !defined(AFX_ERRORGRAPHDLG_H__6CAAA566_0D3D_11D4_9343_00E02947F59E__INCLUDED_)
