#if !defined(AFX_INITSERVER_H__F4E51E54_8162_11D2_AA9B_008048FBB1F4__INCLUDED_)
#define AFX_INITSERVER_H__F4E51E54_8162_11D2_AA9B_008048FBB1F4__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// InitServer.h : header file
//



/////////////////////////////////////////////////////////////////////////////
// InitServer command target

class InitServer : public CSocket
{
// Attributes
public:
	UCHAR mib_handle[10][50];
// Operations
public:
	InitServer();
	virtual ~InitServer();

// Overrides
public:
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(InitServer)
	public:
	//}}AFX_VIRTUAL

	// Generated message map functions
	//{{AFX_MSG(InitServer)
	//}}AFX_MSG

// Implementation


private:
	UINT GetFreeMem();
	UINT GetDiskSpace();
	UCHAR access_counter;
	void Init_MIB_Handler();
	CString GetNode(int i);
	void Add_length(int pt,int op);
	UCHAR request_id[4];
	int number_of_oid;
	CString  snmp_command;
// message from Manager Station
	UCHAR  snmp_message[512];
	int snmp_message_length;
	int current_snmp_message_pointer;
//	OID Value
	UCHAR oid[10][30];
// message from Agent to Manager Station
	UCHAR  snmp_message_for_send[512];
	int snmp_message_for_send_length;
	int current_snmp_message_for_send_pointer;

	CString remote_address;
	CString community_name;
	UINT remote_port;
// private member function
	void Make_snmp_message(int i);
	int FindOID();
	void Send_error_message_to_nms();
	void Init_Connection();
	void Init_MIB();
//	UINT Init_MIB_Handler(LPVOID pParam);
	int Examine_snmp_message();
	void Send_snmp_message();
	BOOL GetTag();
	int  GetASN1Length();
	BOOL IsValidLengthValue();
	BOOL GetVersion();
	BOOL IsValidVersionNumber1();
	BOOL GetCommunityName();
	BOOL IsValidCommunityName();
	BOOL GetPDUTag();
	BOOL IsValidCommandLength();
	BOOL GetRequestIDField();
	BOOL GetRequestIDValue();
	BOOL GetErrorStatusField();
	BOOL GetErrorStatusValue();
	BOOL GetErrorIndexField();
	BOOL GetErrorIndexValue();
	BOOL GetVarBindTag();
	BOOL GetVarBindLength();
	BOOL GetVarTag();
	void GetOID();
//	BOOL retrive_OID();
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INITSERVER_H__F4E51E54_8162_11D2_AA9B_008048FBB1F4__INCLUDED_)
