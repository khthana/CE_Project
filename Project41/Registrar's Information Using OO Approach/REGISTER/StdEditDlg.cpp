// StdEditDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "StdEditDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CStdEditDlg dialog


CStdEditDlg::CStdEditDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CStdEditDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CStdEditDlg)
	m_stdedit_namethai = _T("");
	m_stdedit_surnamethai = _T("");
	m_stdedit_nameeng = _T("");
	m_stdedit_surnameeng = _T("");
	m_stdedit_no = _T("");
	m_stdedit_titleeng = _T("");
	m_stdedit_titlethai = _T("");
	m_stdedit_sex = _T("");
	m_stdedit_birthday = _T("");
	m_stdedit_religion = _T("");
	m_stdedit_nation = _T("");
	m_stdedit_citizen = _T("");
	m_stdedit_addrborder = _T("");
	m_stdedit_addrcode = _T("");
	m_stdedit_addrdistinct = _T("");
	m_stdedit_addrfax = _T("");
	m_stdedit_addrno = _T("");
	m_stdedit_addrpager = _T("");
	m_stdedit_addrprovince = _T("");
	m_stdedit_addrroad = _T("");
	m_stdedit_addrsoi = _T("");
	m_stdedit_addrtel = _T("");
	m_stdedit_caddrborder = _T("");
	m_stdedit_caddrcode = _T("");
	m_stdedit_caddrdistinct = _T("");
	m_stdedit_caddrfax = _T("");
	m_stdedit_caddrno = _T("");
	m_stdedit_caddrprovince = _T("");
	m_stdedit_caddrroad = _T("");
	m_stdedit_caddrsoi = _T("");
	m_stdedit_caddrtel = _T("");
	//}}AFX_DATA_INIT
}


void CStdEditDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CStdEditDlg)
	DDX_Text(pDX, IDC_STDEDIT_NAMETHAI, m_stdedit_namethai);
	DDX_Text(pDX, IDC_STDEDIT_SURNAMETHAI, m_stdedit_surnamethai);
	DDX_Text(pDX, IDC_STDEDIT_NAMEENG, m_stdedit_nameeng);
	DDX_Text(pDX, IDC_STDEDIT_SURNAMEENG, m_stdedit_surnameeng);
	DDX_Text(pDX, IDC_STDEDIT_NO, m_stdedit_no);
	DDX_CBString(pDX, IDC_STDEDIT_TITLEENG, m_stdedit_titleeng);
	DDX_CBString(pDX, IDC_STDEDIT_TITLETHAI, m_stdedit_titlethai);
	DDX_CBString(pDX, IDC_STDEDIT_SEX, m_stdedit_sex);
	DDX_Text(pDX, IDC_STDEDIT_BIRTHDAY, m_stdedit_birthday);
	DDX_CBString(pDX, IDC_STDEDIT_RELIGIONCOMBO, m_stdedit_religion);
	DDX_CBString(pDX, IDC_STDEDIT_NATIONCOMBO, m_stdedit_nation);
	DDX_CBString(pDX, IDC_STDEDITCITIZENCOMBO, m_stdedit_citizen);
	DDX_Text(pDX, IDC_STDEDIT_ADDRBORDER, m_stdedit_addrborder);
	DDX_Text(pDX, IDC_STDEDIT_ADDRCODE, m_stdedit_addrcode);
	DDX_Text(pDX, IDC_STDEDIT_ADDRDISTINCT, m_stdedit_addrdistinct);
	DDX_Text(pDX, IDC_STDEDIT_ADDRFAX, m_stdedit_addrfax);
	DDX_Text(pDX, IDC_STDEDIT_ADDRNO, m_stdedit_addrno);
	DDX_Text(pDX, IDC_STDEDIT_ADDRPAGER, m_stdedit_addrpager);
	DDX_Text(pDX, IDC_STDEDIT_ADDRPROVINCE, m_stdedit_addrprovince);
	DDX_Text(pDX, IDC_STDEDIT_ADDRROAD, m_stdedit_addrroad);
	DDX_Text(pDX, IDC_STDEDIT_ADDRSOI, m_stdedit_addrsoi);
	DDX_Text(pDX, IDC_STDEDIT_ADDRTEL, m_stdedit_addrtel);
	DDX_Text(pDX, IDC_STDEDIT_CADDRBORDER, m_stdedit_caddrborder);
	DDX_Text(pDX, IDC_STDEDIT_CADDRCODE, m_stdedit_caddrcode);
	DDX_Text(pDX, IDC_STDEDIT_CADDRDISTINCT, m_stdedit_caddrdistinct);
	DDX_Text(pDX, IDC_STDEDIT_CADDRFAX, m_stdedit_caddrfax);
	DDX_Text(pDX, IDC_STDEDIT_CADDRNO, m_stdedit_caddrno);
	DDX_Text(pDX, IDC_STDEDIT_CADDRPROVINCE, m_stdedit_caddrprovince);
	DDX_Text(pDX, IDC_STDEDIT_CADDRROAD, m_stdedit_caddrroad);
	DDX_Text(pDX, IDC_STDEDIT_CADDRSOI, m_stdedit_caddrsoi);
	DDX_Text(pDX, IDC_STDEDIT_CADDRTEL, m_stdedit_caddrtel);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CStdEditDlg, CDialog)
	//{{AFX_MSG_MAP(CStdEditDlg)
	ON_BN_CLICKED(IDC_STDEDIT_PREVIOUS, OnStdeditPrevious)
	ON_BN_CLICKED(IDC_STDEDIT_NEXT, OnStdeditNext)
	ON_BN_CLICKED(IDC_EXIT, OnExit)
	ON_BN_CLICKED(IDC_CANCEL, OnCancel)
	ON_BN_CLICKED(IDC_DELETE, OnDelete)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStdEditDlg message handlers
BOOL CStdEditDlg::OnInitDialog()
{

	CDialog::OnInitDialog();
	m_CStdSelectDlg.DoModal();
if( !m_CStdset.IsOpen( ))    
{
	m_CStdset.sql=m_CStdSelectDlg.m_sql;
	m_CStdset.Open(CRecordset::snapshot,NULL,CRecordset::useBookmarks);
	 if( m_CStdset.IsBOF( )) // if no slect record
	{
		MessageBox("ไม่พบนักศึกษาที่เลือก");
		CDialog::OnOK();
		m_CStdset.Close();
	}
}

RestoreFromDatabase();

	return TRUE;
}


void CStdEditDlg::OnOK() 
{
	// TODO: Add extra validation here
	int iResults;
	iResults=MessageBox("แก้ไขข้อมูล?","ยืนยันการแก้ไข",MB_YESNO|MB_ICONQUESTION);
	if (iResults==IDYES)
	{
	//	MessageBox("YES");
	UpdateData(TRUE);
	m_CStdset.Edit();
	
	SaveToDatabase();

	m_CStdset.Update();
	}
	else
	{
		RestoreFromDatabase();
	}
	//CDialog::OnOK();
}

void CStdEditDlg::OnStdeditPrevious() 
{
	// TODO: Add your control notification handler code here
	if( !m_CStdset.IsBOF())  
	{
//	MessageBox("Prev");

	m_CStdset.MovePrev();
	RestoreFromDatabase();


	if(m_CStdset.IsBOF())
	{
	m_CStdset.MoveNext();
//	MessageBox("nnn");
	}	

	}
}

void CStdEditDlg::OnStdeditNext() 
{
	// TODO: Add your control notification handler code here
if(!m_CStdset.IsEOF())
{
	m_CStdset.MoveNext();
	MessageBox("Next");
}	

RestoreFromDatabase();
// Move back if EOF
	if(m_CStdset.IsEOF())
	{
	m_CStdset.MovePrev();
	MessageBox("pppp");
	}	
}

void CStdEditDlg::OnExit() 
{
	// TODO: Add your control notification handler code here
	m_CStdset.Close();
	CDialog::OnOK();
}

void CStdEditDlg::OnCancel() 
{
	// TODO: Add your control notification handler code here
RestoreFromDatabase();
}

void CStdEditDlg::OnDelete() 
{
	// TODO: Add your control notification handler code here
		int i;
	i=MessageBox("ลบข้อมูล?","ยืนยันการลบ",MB_YESNO|MB_ICONQUESTION);
	if (i==IDYES)
	{
	m_CStdset.Delete();
	m_CStdset.Requery();
//	m_CStdset.MovePrev();
	RestoreFromDatabase();
	}
	else
	{
	RestoreFromDatabase();
	}

}

void CStdEditDlg::SaveToDatabase()
{
	UpdateData(TRUE);
	m_CStdset.m_Std_Name_thai=m_stdedit_namethai;
	m_CStdset.m_Std_Surname_thai=m_stdedit_surnamethai;
	m_CStdset.m_Std_name_Eng=m_stdedit_nameeng;
	m_CStdset.m_Std_Surname_Eng=m_stdedit_surnameeng;
	m_CStdset.m_Std_title_thai=m_stdedit_titlethai;
	m_CStdset.m_Std_title_Eng=m_stdedit_titleeng;
	m_CStdset.m_Std_Id=m_stdedit_no;
	m_CStdset.m_Std_Sex=m_stdedit_sex;
	m_CStdset.m_Std_Birthday=m_stdedit_birthday;
	m_CStdset.m_Std_Religion=m_stdedit_religion;
	m_CStdset.m_Std_Nation=m_stdedit_nation;
	m_CStdset.m_Std_Citizen=m_stdedit_citizen;
	m_CStdset.m_Std_Addrno=m_stdedit_addrno;
	m_CStdset.m_Std_Addrsoi=m_stdedit_addrsoi;
	m_CStdset.m_Std_Addrroad=m_stdedit_addrroad;
	m_CStdset.m_Std_Addrprovince=m_stdedit_addrprovince;
	m_CStdset.m_Std_Addrborder=m_stdedit_addrborder;
	m_CStdset.m_Std_Addrdistinct=m_stdedit_addrdistinct;
	m_CStdset.m_Std_Addrcode=m_stdedit_addrcode;
	m_CStdset.m_Std_Addrtel=m_stdedit_addrtel;
	m_CStdset.m_Std_Addrfax=m_stdedit_addrfax;
	m_CStdset.m_Std_Addrpager=m_stdedit_addrpager;
	
}

void CStdEditDlg::RestoreFromDatabase()
{

	m_stdedit_namethai=m_CStdset.m_Std_Name_thai;
	m_stdedit_surnamethai=m_CStdset.m_Std_Surname_thai;
	m_stdedit_nameeng=m_CStdset.m_Std_name_Eng;
	m_stdedit_surnameeng=m_CStdset.m_Std_Surname_Eng;
	m_stdedit_titlethai=m_CStdset.m_Std_title_thai;
	m_stdedit_titleeng=m_CStdset.m_Std_title_Eng;
	m_stdedit_no=m_CStdset.m_Std_Id;
	m_stdedit_sex=m_CStdset.m_Std_Sex;
	m_stdedit_birthday=m_CStdset.m_Std_Birthday;
	m_stdedit_religion=m_CStdset.m_Std_Religion;
	m_stdedit_nation=m_CStdset.m_Std_Nation;
	m_stdedit_citizen=m_CStdset.m_Std_Citizen;
	m_stdedit_addrno=m_CStdset.m_Std_Addrno;
	m_stdedit_addrsoi=m_CStdset.m_Std_Addrsoi;
	m_stdedit_addrroad=m_CStdset.m_Std_Addrroad;
	m_stdedit_addrprovince=m_CStdset.m_Std_Addrprovince;
	m_stdedit_addrborder=m_CStdset.m_Std_Addrborder;
	m_stdedit_addrdistinct=m_CStdset.m_Std_Addrdistinct;
	m_stdedit_addrcode=m_CStdset.m_Std_Addrcode;
	m_stdedit_addrtel=m_CStdset.m_Std_Addrtel;
	m_stdedit_addrfax=m_CStdset.m_Std_Addrfax;
	m_stdedit_addrpager=m_CStdset.m_Std_Addrpager;
	
	m_stdedit_caddrno=m_CStdset.m_Std_Caddrno;
	m_stdedit_caddrsoi=m_CStdset.m_Std_Caddrsoi;
	m_stdedit_caddrroad=m_CStdset.m_Std_Caddrroad;
	m_stdedit_caddrprovince=m_CStdset.m_Std_Caddrprovince;
	m_stdedit_caddrborder=m_CStdset.m_Std_Caddrborder;
	m_stdedit_caddrdistinct=m_CStdset.m_Std_Caddrdistinct;
	m_stdedit_caddrcode=m_CStdset.m_Std_Caddrcode;
	m_stdedit_caddrtel=m_CStdset.m_Std_Caddrtel;
	m_stdedit_caddrfax=m_CStdset.m_Std_Caddrfax;

	UpdateData(FALSE);
}
