// StdAddDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "StdAddDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CStdAddDlg dialog


CStdAddDlg::CStdAddDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CStdAddDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CStdAddDlg)
	m_stdadd_addrborder = _T("");
	m_stdadd_addrcode = _T("");
	m_stdadd_addrdistinct = _T("");
	m_stdadd_addrfax = _T("");
	m_stdadd_addrno = _T("");
	m_stdadd_addrpager = _T("");
	m_stdadd_addrprovince = _T("");
	m_stdadd_addrroad = _T("");
	m_stdadd_addrsoi = _T("");
	m_stdadd_addrtel = _T("");
	m_stdadd_birthday = _T("");
	m_stdadd_caddrborder = _T("");
	m_stdadd_caddrcode = _T("");
	m_stdadd_caddrdistinct = _T("");
	m_stdadd_caddrfax = _T("");
	m_stdadd_caddrno = _T("");
	m_stdadd_caddrprovince = _T("");
	m_stdadd_caddrroad = _T("");
	m_stdadd_caddrsoi = _T("");
	m_stdadd_caddrtel = _T("");
	m_stdadd_citizen = _T("");
	m_stdadd_nameeng = _T("");
	m_stdadd_namethai = _T("");
	m_stdadd_nation = _T("");
	m_stdadd_stdno = _T("");
	m_stdadd_religion = _T("");
	m_stdadd_sex = _T("");
	m_stdadd_surnameeng = _T("");
	m_stdadd_surnamethai = _T("");
	m_stdadd_titleeng = _T("");
	m_stdadd_titlethai = _T("");
	//}}AFX_DATA_INIT
}


void CStdAddDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CStdAddDlg)
	DDX_Text(pDX, IDC_STDADD_ADDRBORDER, m_stdadd_addrborder);
	DDX_Text(pDX, IDC_STDADD_ADDRCODE, m_stdadd_addrcode);
	DDX_Text(pDX, IDC_STDADD_ADDRDISTINCT, m_stdadd_addrdistinct);
	DDX_Text(pDX, IDC_STDADD_ADDRFAX, m_stdadd_addrfax);
	DDX_Text(pDX, IDC_STDADD_ADDRNO, m_stdadd_addrno);
	DDX_Text(pDX, IDC_STDADD_ADDRPAGER, m_stdadd_addrpager);
	DDX_Text(pDX, IDC_STDADD_ADDRPROVINCE, m_stdadd_addrprovince);
	DDX_Text(pDX, IDC_STDADD_ADDRROAD, m_stdadd_addrroad);
	DDX_Text(pDX, IDC_STDADD_ADDRSOI, m_stdadd_addrsoi);
	DDX_Text(pDX, IDC_STDADD_ADDRTEL, m_stdadd_addrtel);
	DDX_Text(pDX, IDC_STDADD_BIRTHDAY, m_stdadd_birthday);
	DDX_Text(pDX, IDC_STDADD_CADDRBORDER, m_stdadd_caddrborder);
	DDX_Text(pDX, IDC_STDADD_CADDRCODE, m_stdadd_caddrcode);
	DDX_Text(pDX, IDC_STDADD_CADDRDISTINCT, m_stdadd_caddrdistinct);
	DDX_Text(pDX, IDC_STDADD_CADDRFAX, m_stdadd_caddrfax);
	DDX_Text(pDX, IDC_STDADD_CADDRNO, m_stdadd_caddrno);
	DDX_Text(pDX, IDC_STDADD_CADDRPROVINCE, m_stdadd_caddrprovince);
	DDX_Text(pDX, IDC_STDADD_CADDRROAD, m_stdadd_caddrroad);
	DDX_Text(pDX, IDC_STDADD_CADDRSOI, m_stdadd_caddrsoi);
	DDX_Text(pDX, IDC_STDADD_CADDRTEL, m_stdadd_caddrtel);
	DDX_CBString(pDX, IDC_STDADD_CITIZEN, m_stdadd_citizen);
	DDX_Text(pDX, IDC_STDADD_NAMEENG, m_stdadd_nameeng);
	DDX_Text(pDX, IDC_STDADD_NAMETHAI, m_stdadd_namethai);
	DDX_CBString(pDX, IDC_STDADD_NATION, m_stdadd_nation);
	DDX_Text(pDX, IDC_STDADD_NO, m_stdadd_stdno);
	DDX_CBString(pDX, IDC_STDADD_RELIGION, m_stdadd_religion);
	DDX_CBString(pDX, IDC_STDADD_SEX, m_stdadd_sex);
	DDX_Text(pDX, IDC_STDADD_SURNAMEENG, m_stdadd_surnameeng);
	DDX_Text(pDX, IDC_STDADD_SURNAMETHAI, m_stdadd_surnamethai);
	DDX_CBString(pDX, IDC_STDADD_TITLEENG, m_stdadd_titleeng);
	DDX_CBString(pDX, IDC_STDADD_TITLETHAI, m_stdadd_titlethai);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CStdAddDlg, CDialog)
	//{{AFX_MSG_MAP(CStdAddDlg)
	ON_BN_CLICKED(IDC_EXIT, OnExit)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStdAddDlg message handlers

void CStdAddDlg::OnExit() 
{
	// TODO: Add your control notification handler code here
	CDialog::OnOK();
}

void CStdAddDlg::OnOK() 
{
	// TODO: Add extra validation here
	UpdateData(TRUE);
if( !m_CStdset.IsOpen( ))    
	{
	m_CStdset.Open(CRecordset::snapshot,"select * from student",NULL);
}
	m_CStdset.AddNew();
	m_CStdset.m_Std_Id=m_stdadd_stdno;
	m_CStdset.m_Std_Name_thai=m_stdadd_namethai;
	m_CStdset.m_Std_name_Eng=m_stdadd_nameeng;
	m_CStdset.m_Std_title_thai=m_stdadd_titlethai;
	m_CStdset.m_Std_title_Eng=m_stdadd_titleeng;
	m_CStdset.m_Std_Surname_thai=m_stdadd_surnamethai;
	m_CStdset.m_Std_Surname_Eng=m_stdadd_surnameeng;
	m_CStdset.m_Std_Sex=m_stdadd_sex;
	m_CStdset.m_Std_Citizen=m_stdadd_citizen;
	m_CStdset.m_Std_Nation=m_stdadd_nation;
	m_CStdset.m_Std_Religion=m_stdadd_religion;
	m_CStdset.m_Std_Addrborder=m_stdadd_addrborder;
	m_CStdset.m_Std_Addrcode=m_stdadd_addrcode;
	m_CStdset.m_Std_Addrdistinct=m_stdadd_addrdistinct;
	m_CStdset.m_Std_Addrfax=m_stdadd_addrfax;
	m_CStdset.m_Std_Addrno=m_stdadd_addrno;
	m_CStdset.m_Std_Addrpager=m_stdadd_addrpager;
	m_CStdset.m_Std_Addrprovince=m_stdadd_addrprovince;
	m_CStdset.m_Std_Addrroad=m_stdadd_addrroad;
	m_CStdset.m_Std_Addrsoi=m_stdadd_addrsoi;
	m_CStdset.m_Std_Addrtel=m_stdadd_addrtel;
	m_CStdset.m_Std_Birthday=m_stdadd_birthday;
	m_CStdset.m_Std_Caddrborder=m_stdadd_caddrborder;
	m_CStdset.m_Std_Caddrcode=m_stdadd_caddrcode;
	m_CStdset.m_Std_Caddrdistinct=m_stdadd_caddrdistinct;
	m_CStdset.m_Std_Caddrfax=m_stdadd_caddrfax;
	m_CStdset.m_Std_Caddrno=m_stdadd_caddrno;
	m_CStdset.m_Std_Caddrprovince=m_stdadd_caddrprovince;
	m_CStdset.m_Std_Caddrroad=m_stdadd_caddrroad;
	m_CStdset.m_Std_Caddrsoi=m_stdadd_caddrsoi;
	m_CStdset.m_Std_Caddrtel=m_stdadd_caddrtel;
	m_CStdset.Update();
	//m_CStdset.Requery();
	//m_CStdset.MoveLast();
//	CDialog::OnOK();

}
