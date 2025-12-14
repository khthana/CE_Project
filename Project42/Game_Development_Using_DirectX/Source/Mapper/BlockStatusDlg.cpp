// BlockStatusDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Mapper.h"
#include "BlockStatusDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CBlockStatusDlg dialog


CBlockStatusDlg::CBlockStatusDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CBlockStatusDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CBlockStatusDlg)
	m_i = 0;
	m_j = 0;
	m_Level = 0;
	m_Reserved = 0;
	m_Type = -1;
	//}}AFX_DATA_INIT
}


void CBlockStatusDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CBlockStatusDlg)
	DDX_Text(pDX, IDC_I, m_i);
	DDX_Text(pDX, IDC_J, m_j);
	DDX_Text(pDX, IDC_LEVEL, m_Level);
	DDV_MinMaxInt(pDX, m_Level, 0, 20);
	DDX_Text(pDX, IDC_RESERVED, m_Reserved);
	DDX_CBIndex(pDX, IDC_TYPE, m_Type);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CBlockStatusDlg, CDialog)
	//{{AFX_MSG_MAP(CBlockStatusDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CBlockStatusDlg message handlers
