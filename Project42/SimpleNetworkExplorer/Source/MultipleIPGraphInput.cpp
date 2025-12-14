// MultipleIPGraphInput.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "MultipleIPGraphInput.h"
#include "MonitorFormControl.h"
//#include "MultipleIPGraphDlg.h"
#include "multipleipdlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMultipleIPGraphInput dialog


CMultipleIPGraphInput::CMultipleIPGraphInput(CWnd* pParent /*=NULL*/)
	: CDialog(CMultipleIPGraphInput::IDD, pParent)
{
	//{{AFX_DATA_INIT(CMultipleIPGraphInput)
	//}}AFX_DATA_INIT
}


void CMultipleIPGraphInput::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CMultipleIPGraphInput)
	DDX_Control(pDX, IDC_IPList, m_IPListBox);
	DDX_Control(pDX, IDC_IntervalTimeComboBox, m_IntervalTimeComboBox);
	DDX_Control(pDX, IDC_ValueComboBox, m_ValueComboBox);
	//}}AFX_DATA_MAP
	m_ValueComboBox.AddString("Percentage Utilization");
	m_ValueComboBox.AddString("Byte In Rate");
	m_ValueComboBox.AddString("Byte Out Rate");
	m_ValueComboBox.AddString("Packet In Rate");
	m_ValueComboBox.AddString("Packet Out Rate");
	m_ValueComboBox.AddString("Error In Rate");
	m_ValueComboBox.AddString("Error Out Rate");
	m_ValueComboBox.AddString("Muticast Packet In Rate");
	m_ValueComboBox.AddString("Muticast Packet Out Rate");
	m_ValueComboBox.AddString("Unicast Packet In Rate");
	m_ValueComboBox.AddString("Unicast Packet Out Rate");
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


BEGIN_MESSAGE_MAP(CMultipleIPGraphInput, CDialog)
	//{{AFX_MSG_MAP(CMultipleIPGraphInput)
	ON_BN_CLICKED(IDC_Add, OnAdd)
	ON_BN_CLICKED(IDC_Delete, OnDelete)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMultipleIPGraphInput message handlers

void CMultipleIPGraphInput::OnAdd() 
{
	char IPAddress[16]; 
	GetDlgItemText(IDC_EnterIP,IPAddress,16);
	int i = m_IPListBox.GetCount();
	if (i<4)
		m_IPListBox.AddString(IPAddress);
}

void CMultipleIPGraphInput::OnDelete() 
{
	int Pos =m_IPListBox.GetCurSel();
	m_IPListBox.DeleteString(Pos);
}

void CMultipleIPGraphInput::OnOK() 
{
	CString str,theValue,time;
	int number = m_IPListBox.GetCount();
	for (int i=0; i<=number-1; i++)
	{
		m_IPListBox.GetText(i,str);
		IPList.Add(str);
	}

	int P =m_ValueComboBox.GetCurSel();
	m_ValueComboBox.GetLBText(P,theValue);

	P =m_IntervalTimeComboBox.GetCurSel();
	m_IntervalTimeComboBox.GetLBText(P,time);

	CMultipleIPGraphDlg theDialog;
//	theDialog.setmutual(processID,testmutual);
//	theDialog.DoModal(&IPList,theValue,time);
//	theDialog.setvalue(&IPList,theValue,time);
//	theDialog.Create(IDD_MultipleIPGraphDlg,NULL);
//	theDialog.ShowWindow(SW_SHOW);
	CWinThread* thread = AfxBeginThread(RUNTIME_CLASS(multipleipdlg),0,0,CREATE_SUSPENDED,NULL);
//	_ASSERTE(thread && thread->IsKindOf(RUNTIME_CLASS(multithreadcontroller));
	multipleipdlg* st = (multipleipdlg *) thread;
	st->SetParam(processID,testmutual,time,theValue,&IPList);
	st->ResumeThread();
	CDialog::OnOK();
}

void CMultipleIPGraphInput::setmutual(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutual = tptstmutual;
}
