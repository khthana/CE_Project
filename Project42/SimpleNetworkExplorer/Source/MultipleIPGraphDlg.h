#if !defined(AFX_MULTIPLEIPGRAPHDLG_H__9C285F38_1430_11D4_9350_00E02947F59E__INCLUDED_)
#define AFX_MULTIPLEIPGRAPHDLG_H__9C285F38_1430_11D4_9350_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MultipleIPGraphDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CMultipleIPGraphDlg dialog

class CMultipleIPGraphDlg : public CDialog
{
// Construction
public:
	int converttorate(int);
	int cshowvalue[4];
	int intervalnumber;
	bool testinterval;
	void setvalue(CStringArray* IPList, CString value, CString time);
	CMultipleIPGraphDlg(CWnd* pParent = NULL);   // standard constructor

//Attribute 
	bool* testmutual;
	int processID;
	CStringArray* theIPList;
	CObArray CMonitorArray;
	CString theValue;
	CString theTime;
	CStatic gvalue[4];

//Attribute for each IP
	//MonitorFormControl MonitorObject;
	CString IPaddress;
	CObArray NowPointArray;
	CObArray PointListArray;
	CBrush m_brush;
	CStatic Nametext1,Nametext2,Nametext3,Nametext4,Nametext5,time;
	CRect textrect1,textrect2,textrect3,textrect4,textrect5,timerect;	
	CStatic Nametext12,Nametext22,Nametext32,Nametext42,Nametext52;
	CRect textrect12,textrect22,textrect32,textrect42,textrect52;	
	
//Method
	void setmutual(int,bool*);

	void DrawInitLineXY();
	//method to draw the Line X axis and Y axis
	int ConvertValueToYPoint(float value);
	//method to convert the value of Data's Volume to Y point on graph
	//  by return to integer(Y Point)
	void DrawLine(CPoint StartPoint,CPoint TerminalPoint,int ID);
	//method to draw one Line from NowPoint to TerminalPoint
	void DeleteOldGraph();
	//method to draw the white line replace the old one
	void ShiftGraph();
	//method to shift the data in array and draw the new line graph

	
// Dialog Data
	//{{AFX_DATA(CMultipleIPGraphDlg)
	enum { IDD = IDD_MultipleIPGraphDlg };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMultipleIPGraphDlg)
	public:
	virtual int DoModal(CStringArray* IPList, CString value, CString time);
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL
	
// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CMultipleIPGraphDlg)
	afx_msg void OnStart();
	afx_msg void OnTimer(UINT nIDEvent);
	virtual void OnCancel();

	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MULTIPLEIPGRAPHDLG_H__9C285F38_1430_11D4_9350_00E02947F59E__INCLUDED_)
