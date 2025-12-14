#if !defined(AFX_MULTIPLEIPGRAPHINPUT_H__9C285F34_1430_11D4_9350_00E02947F59E__INCLUDED_)
#define AFX_MULTIPLEIPGRAPHINPUT_H__9C285F34_1430_11D4_9350_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MultipleIPGraphInput.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CMultipleIPGraphInput dialog

class CMultipleIPGraphInput : public CDialog
{
// Construction
public:
	CMultipleIPGraphInput(CWnd* pParent = NULL);   // standard constructor

//Attribute
	bool* testmutual;
	int processID;
	CStringArray IPList;

//Method
	void setmutual(int,bool*);

// Dialog Data
	//{{AFX_DATA(CMultipleIPGraphInput)
	enum { IDD = IDD_Multiple_IP_Graph_Input };
	CListBox	m_IPListBox;
	CComboBox	m_IntervalTimeComboBox;
	CComboBox	m_ValueComboBox;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMultipleIPGraphInput)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CMultipleIPGraphInput)
	afx_msg void OnAdd();
	afx_msg void OnButton2();
	afx_msg void OnDelete();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MULTIPLEIPGRAPHINPUT_H__9C285F34_1430_11D4_9350_00E02947F59E__INCLUDED_)
