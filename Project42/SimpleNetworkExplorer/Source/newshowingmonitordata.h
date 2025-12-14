#if !defined(AFX_NEWSHOWINGMONITORDATA_H__56B52F75_03BC_11D4_9325_00E02947F59E__INCLUDED_)
#define AFX_NEWSHOWINGMONITORDATA_H__56B52F75_03BC_11D4_9325_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// newshowingmonitordata.h : header file
//



/////////////////////////////////////////////////////////////////////////////
// newshowingmonitordata dialog

class newshowingmonitordata : public CDialog
{
// Construction
public:
	int processID;
	int hourcount;
	int minuitcount;
	UINT hourbyte;
	UINT minuitbyte;
	UINT totalunicastout;
	UINT totalunicastin;
	UINT totalmulticastout;
	UINT totalmulticastin;
	UINT multicastoutrate;
	UINT multicastinrate;
	UINT unicastoutrate;
	UINT unicastinrate;
	UINT totalpacketout;
	UINT totalpacketin;
	UINT packetoutrate;
	UINT packetinrate;
	void setstaticvar(int,UINT,int,int);
	UINT ifspeed;
	int ifnumber;
	int intervaltime;
	UINT totalerout;
	UINT totalerin;
	UINT erinrate;
	UINT eroutrate;
	bool exited;
	bool canexit;
	bool startupdate;
	UINT totalout;
	UINT totalin;
	UINT outrate;
	UINT inrate;
//	int ifnumber;
	void setifnumber(UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,UINT,int);
	CStatic label[26];
	CStatic data[38];
	CBrush m_brush;
	void updatedata(int);
	void createdata();

	newshowingmonitordata(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(newshowingmonitordata)
	enum { IDD = IDD_showdata };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(newshowingmonitordata)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(newshowingmonitordata)
	virtual void OnOK();
	virtual void OnCancel();
	//afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_NEWSHOWINGMONITORDATA_H__56B52F75_03BC_11D4_9325_00E02947F59E__INCLUDED_)
