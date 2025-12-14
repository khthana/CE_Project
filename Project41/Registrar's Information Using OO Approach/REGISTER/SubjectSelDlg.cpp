// SubjectSelDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "SubjectSelDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSubjectSelDlg dialog


CSubjectSelDlg::CSubjectSelDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSubjectSelDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSubjectSelDlg)
	m_subject_id = _T("");
	//}}AFX_DATA_INIT
}


void CSubjectSelDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSubjectSelDlg)
	DDX_Text(pDX, IDC_SUBJECT_ID, m_subject_id);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSubjectSelDlg, CDialog)
	//{{AFX_MSG_MAP(CSubjectSelDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSubjectSelDlg message handlers
BOOL CSubjectSelDlg::OnInitDialog()
{
	m_subject_id="";
	UpdateData(FALSE);
	return TRUE;
}