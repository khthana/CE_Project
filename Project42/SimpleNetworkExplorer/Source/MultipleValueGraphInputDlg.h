#if !defined(AFX_MULTIPLEVALUEGRAPHINPUTDLG_H__333883C4_14DF_11D4_9351_00E02947F59E__INCLUDED_)
#define AFX_MULTIPLEVALUEGRAPHINPUTDLG_H__333883C4_14DF_11D4_9351_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MultipleValueGraphInputDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CMultipleValueGraphInputDlg dialog

class CMultipleValueGraphInputDlg : public CDialog
{
// Construction
public:
	CMultipleValueGraphInputDlg(CWnd* pParent = NULL);   // standard constructor

//Attribute
	bool* testmutual;
	int processID;
	CStringArray ValueList;

//Method
	void setmutual(int,bool*);

// Dialog Data
	//{{AFX_DATA(CMultipleValueGraphInputDlg)
	enum { IDD = IDD_MultipleValueGraphInput };
	CListBox	m_ValueListBox;
	CComboBox	m_IntervalTimeComboBox;
	CComboBox	m_ValueComboBox;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMultipleValueGraphInputDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CMultipleValueGraphInputDlg)
	afx_msg void OnAdd();
	afx_msg void OnDelete();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MULTIPLEVALUEGRAPHINPUTDLG_H__333883C4_14DF_11D4_9351_00E02947F59E__INCLUDED_)
