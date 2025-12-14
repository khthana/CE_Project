// MultipleValueGraphInputDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "MultipleValueGraphInputDlg.h"
#include "MonitorFormControl.h"
//#include "MultipleValueGraphDlg.h"
#include "multiplevaluedlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMultipleValueGraphInputDlg dialog


CMultipleValueGraphInputDlg::CMultipleValueGraphInputDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CMultipleValueGraphInputDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CMultipleValueGraphInputDlg)
	//}}AFX_DATA_INIT
}


void CMultipleValueGraphInputDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CMultipleValueGraphInputDlg)
	DDX_Control(pDX, IDC_ValueListBox, m_ValueListBox);
	DDX_Control(pDX, IDC_IntervalTimeComboBox, m_IntervalTimeComboBox);
	DDX_Control(pDX, IDC_ValueComboBox, m_ValueComboBox);
	//}}AFX_DATA_MAP
	m_ValueComboBox.AddString("% Utilization");
	m_ValueComboBox.AddString("Byte In");
	m_ValueComboBox.AddString("Byte Out");
	m_ValueComboBox.AddString("Packet In");
	m_ValueComboBox.AddString("Packet Out");
	m_ValueComboBox.AddString("Error In");
	m_ValueComboBox.AddString("Error Out");
	m_ValueComboBox.AddString("Muticast Packet In");
	m_ValueComboBox.AddString("Muticast Packet Out");
	m_ValueComboBox.AddString("Unicast Packet In");
	m_ValueComboBox.AddString("Unicast Packet Out");
	m_ValueComboBox.SetCurSel(0);

	m_IntervalTimeComboBox.AddString("2 sec.");
	m_IntervalTimeComboBox.AddString("5 sec.");
	m_IntervalTimeComboBox.AddString("10 sec.");
	m_IntervalTimeComboBox.AddString("30 sec.");
	m_IntervalTimeComboBox.AddString("1 min.");
	m_IntervalTimeComboBox.AddString("5 min.");
	m_IntervalTimeComboBox.AddString("10 min.");
	m_IntervalTimeComboBox.SetCurSel(0);
}


BEGIN_MESSAGE_MAP(CMultipleValueGraphInputDlg, CDialog)
	//{{AFX_MSG_MAP(CMultipleValueGraphInputDlg)
	ON_BN_CLICKED(IDC_Add, OnAdd)
	ON_BN_CLICKED(IDC_Delete, OnDelete)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMultipleValueGraphInputDlg message handlers

void CMultipleValueGraphInputDlg::OnAdd() 
{
	CString theValue;	
	int P =m_ValueComboBox.GetCurSel();
	m_ValueComboBox.GetLBText(P,theValue);
	int i = m_ValueListBox.GetCount();
	if (i<4)
		m_ValueListBox.AddString(theValue);
}

void CMultipleValueGraphInputDlg::OnDelete() 
{
	int Pos =m_ValueListBox.GetCurSel();
	m_ValueListBox.DeleteString(Pos);
}

void CMultipleValueGraphInputDlg::OnOK() 
{
	char IPAddress[16]; 
	CString str,IP,time;
	int number = m_ValueListBox.GetCount();
	for (int i=0; i<=number-1; i++)
	{
		m_ValueListBox.GetText(i,str);
		ValueList.Add(str);
	}

	GetDlgItemText(IDC_EnterIP,IPAddress,16);
	IP = IPAddress;

	int P =m_IntervalTimeComboBox.GetCurSel();
	m_IntervalTimeComboBox.GetLBText(P,time);

	CMultipleValueGraphDlg theDialog;
	theDialog.setmutual(processID,testmutual);
//	theDialog.setvalue(IP,&ValueList,time);
//	theDialog.DoModal(IP,&ValueList,time);
//	theDialog.Create(IDD_MultipleValueGraphDlg,NULL);
//	theDialog.ShowWindow(SW_SHOW);
	CWinThread* thread = AfxBeginThread(RUNTIME_CLASS(multiplevaluedlg),0,0,CREATE_SUSPENDED,NULL);
//	_ASSERTE(thread && thread->IsKindOf(RUNTIME_CLASS(multithreadcontroller));
	multiplevaluedlg* st = (multiplevaluedlg *) thread;
	st->SetParam(processID,testmutual,IP,time,&ValueList);
	st->ResumeThread();
	CDialog::OnOK();
}

void CMultipleValueGraphInputDlg::setmutual(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutual = tptstmutual;
}
