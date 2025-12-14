#if !defined(AFX_ROOMDLG_H__F5C46B70_FA12_11D2_95B3_00E029377C4C__INCLUDED_)
#define AFX_ROOMDLG_H__F5C46B70_FA12_11D2_95B3_00E029377C4C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// RoomDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CRoomDlg dialog

class CRoomDlg : public CDialog
{
// Construction
public:
	CRoomDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CRoomDlg)
	enum { IDD = IDD_ROOM_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CRoomDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CRoomDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ROOMDLG_H__F5C46B70_FA12_11D2_95B3_00E029377C4C__INCLUDED_)
