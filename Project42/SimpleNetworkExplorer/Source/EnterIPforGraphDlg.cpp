// EnterIPforGraphDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "EnterIPforGraphDlg.h"
#include "GraphDialog.h"
#include "ErrorGraphDlg.h"
#include "UtilizationGraphDlg.h"
#include "PacketGraphDlg.h"
#include "UnicastPacketGraphDlg.h"
#include "MulticastPacketGraphDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CEnterIPforGraphDlg dialog


CEnterIPforGraphDlg::CEnterIPforGraphDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CEnterIPforGraphDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CEnterIPforGraphDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CEnterIPforGraphDlg::DoDataExchange(CDataExchange* pDX)
{
  // Check the Byte In Radio Button checked default
	CButton *ByteInButton;
	ByteInButton = (CButton*)GetDlgItem(IDC_ByteInRadio);
	ByteInButton->SetCheck(1);
  //***
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CEnterIPforGraphDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CEnterIPforGraphDlg, CDialog)
	//{{AFX_MSG_MAP(CEnterIPforGraphDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CEnterIPforGraphDlg message handlers

void CEnterIPforGraphDlg::OnOK() 
{
	char IpAddress[16];
	GetDlgItemText(IDC_IPForGraph,IpAddress,16);

	CButton *ByteInOutButton;
	ByteInOutButton = (CButton*)GetDlgItem(IDC_ByteInOutRadio);
	if (ByteInOutButton->GetCheck()== 1)
	{
		CGraphDialog GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"ByteInOut");
	}

	CButton *ByteInButton;
	ByteInButton = (CButton*)GetDlgItem(IDC_ByteInRadio);
	if (ByteInButton->GetCheck()== 1)
	{
		CGraphDialog GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"ByteIn");
	}

	CButton *ByteOutButton;
	ByteOutButton = (CButton*)GetDlgItem(IDC_ByteOutRadio);
	if (ByteOutButton->GetCheck()== 1)
	{
		CGraphDialog GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"ByteOut");
	}

	CButton *UtilizationButton;
	UtilizationButton = (CButton*)GetDlgItem(IDC_UtilizationRadio);
	if (UtilizationButton->GetCheck()== 1)
	{
		CUtilizationGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress);
	}

	CButton *PacketInOutButton;
	PacketInOutButton = (CButton*)GetDlgItem(IDC_PacketInOutRadio);
	if (PacketInOutButton->GetCheck()== 1)
	{
		CPacketGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"PacketInOut");
	}

	CButton *PacketInButton;
	PacketInButton = (CButton*)GetDlgItem(IDC_PacketInRadio);
	if (PacketInButton->GetCheck()== 1)
	{
		CPacketGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"PacketIn");
	}

	CButton *PacketOutButton;
	PacketOutButton = (CButton*)GetDlgItem(IDC_PacketOutRadio);
	if (PacketOutButton->GetCheck()== 1)
	{
		CPacketGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"PacketOut");
	}

	CButton *ErrorInOutButton;
	ErrorInOutButton = (CButton*)GetDlgItem(IDC_ErrorInOutRadio);
	if (ErrorInOutButton->GetCheck()== 1)
	{
		CErrorGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"ErrorInOut");
	}

	CButton *ErrorInButton;
	ErrorInButton = (CButton*)GetDlgItem(IDC_ErrorInRadio);
	if (ErrorInButton->GetCheck()== 1)
	{
		CErrorGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"ErrorIn");
	}

	CButton *ErrorOutButton;
	ErrorOutButton = (CButton*)GetDlgItem(IDC_ErrorOutRadio);
	if (ErrorOutButton->GetCheck()== 1)
	{
		CErrorGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"ErrorOut");
	}

	CButton *UnicastPacketInOutButton;
	UnicastPacketInOutButton = (CButton*)GetDlgItem(IDC_UnicastPacketInOutRadio);
	if (UnicastPacketInOutButton->GetCheck()== 1)
	{
		CUnicastPacketGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"UnicastPacketInOut");
	}

	CButton *UnicastPacketInButton;
	UnicastPacketInButton = (CButton*)GetDlgItem(IDC_UnicastPacketInRadio);
	if (UnicastPacketInButton->GetCheck()== 1)
	{
		CUnicastPacketGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"UnicastPacketIn");
	}

	CButton *UnicastPacketOutButton;
	UnicastPacketOutButton = (CButton*)GetDlgItem(IDC_UnicastPacketOutRadio);
	if (UnicastPacketOutButton->GetCheck()== 1)
	{
		CUnicastPacketGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"UnicastPacketOut");
	}

	CButton *MulticastPacketInOutButton;
	MulticastPacketInOutButton = (CButton*)GetDlgItem(IDC_MulticastPacketInOutRadio);
	if (MulticastPacketInOutButton->GetCheck()== 1)
	{
		CMulticastPacketGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"MulticastPacketInOut");
	}

	CButton *MulticastPacketInButton;
	MulticastPacketInButton = (CButton*)GetDlgItem(IDC_MulticastPacketInRadio);
	if (MulticastPacketInButton->GetCheck()== 1)
	{
		CMulticastPacketGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"MulticastPacketIn");
	}

	CButton *MulticastPacketOutButton;
	MulticastPacketOutButton = (CButton*)GetDlgItem(IDC_MulticastPacketOutRadio);
	if (MulticastPacketOutButton->GetCheck()== 1)
	{
		CMulticastPacketGraphDlg GraphDialog;
		GraphDialog.setmutual(processID,testmutualex);
		GraphDialog.DoModal(IpAddress,"MulticastPacketOut");
	}

	CDialog::OnOK();
}

void CEnterIPforGraphDlg::setmutualex(int tpid,bool* tptstmutual)
{
	processID = tpid;
	testmutualex = tptstmutual;
}
