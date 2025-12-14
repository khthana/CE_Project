// InitServer.cpp : implementation file
//
#include "stdafx.h"
#include "SnmpAgent.h"
#include "InitServer.h"

#include "MainFrm.h"
#include "SnmpAgentDoc.h"
#include "SnmpAgentView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// InitServer



InitServer::InitServer()
{
	Init_MIB();
	Init_MIB_Handler();
	Init_Connection();
	
	for(;;){
	snmp_message_length=0;
	current_snmp_message_pointer=0;
	current_snmp_message_for_send_pointer=0;
	snmp_message_length=0;

	snmp_message_length=ReceiveFrom(snmp_message
		   ,512
		   ,remote_address
		   ,remote_port,0);
	Init_MIB_Handler();
		if (Examine_snmp_message()==SNMP_MESSAGE_OK) {
			Send_snmp_message();
		}else {
			Send_error_message_to_nms();
		}
	} 
	Close();
}

InitServer::~InitServer()
{
}

// Initial  MIB and its definition handler

void InitServer::Init_MIB()
{
	char computer_name[90];
	CString cpu_type;
	DWORD	n=sizeof(computer_name);
	SYSTEM_INFO	sysinfo;

	access_counter=-1;
	UCHAR oid_0[] = {7,0x2B,6,1,2,1,1,1};
	UCHAR oid_1[] = {7,0x2B,6,1,2,1,1,2};
	UCHAR oid_2[] = {6,0x2B,6,1,3,11,1};
	UCHAR oid_3[] = {6,0x2B,6,1,3,11,2};
	UCHAR oid_4[] = {6,0x2B,6,1,3,11,3};
	UCHAR oid_5[] = {6,0x2B,6,1,3,11,4};
	UCHAR oid_6[] = {6,0x2B,6,1,3,11,5};
	UCHAR oid_7[] = {6,0x2B,6,1,3,11,6};

	memcpy(&oid[0][0],&oid_0[0],8);	// Register oid
	memcpy(&oid[1][0],&oid_1[0],8);	// Register oid
	memcpy(&oid[2][0],&oid_2[0],7);	// Register oid
	memcpy(&oid[3][0],&oid_3[0],7);	// Register oid

	memcpy(&oid[4][0],&oid_4[0],7);	// Register oid
	memcpy(&oid[5][0],&oid_5[0],7);	// Register oid
	memcpy(&oid[6][0],&oid_6[0],7);	// Register oid
	memcpy(&oid[7][0],&oid_7[0],7);	// Register oid
	number_of_oid=8;  //Have got 9 Registed oid

	// Static OID value assign here

	// Get Host name
	GetComputerName(computer_name,&n); 
	UCHAR int_to_char=n;
	UCHAR oid_4_value[]={4,int_to_char};
	memcpy(&mib_handle[4][0],&oid_4_value[0],sizeof(oid_4_value));
	memcpy(&mib_handle[4][2],computer_name,int_to_char);
	
	// Get CPU Type
	ZeroMemory(&sysinfo,sizeof(SYSTEM_INFO));
	GetSystemInfo((SYSTEM_INFO *)&sysinfo);
	switch(sysinfo.dwProcessorType)
	{
	case PROCESSOR_INTEL_386: 
		cpu_type="Intel 80386"; 
		break;
		
	case PROCESSOR_INTEL_486:
		cpu_type="Intel 80486"; 
		break;

	case PROCESSOR_INTEL_PENTIUM:
		cpu_type="Intel Pentium(r)";
		break;

	case PROCESSOR_MIPS_R4000: 
		cpu_type="MIPS Processor"; 
		break;

	case PROCESSOR_ALPHA_21064:
		cpu_type="ALPHA Processor"; 
		break;
	}
	int_to_char=cpu_type.GetLength();
	UCHAR oid_7_value[]={4,int_to_char};
	memcpy(&mib_handle[7][0],&oid_7_value[0],sizeof(oid_7_value));
	memcpy(&mib_handle[7][2],cpu_type,cpu_type.GetLength());

//	UCHAR oid_8_value[]={4,2,"HP"};
//	memcpy(&mib_handle[8][0],&oid_8_value[0],sizeof(oid_8_value));

} 


// End initial MIB
void InitServer::Init_Connection()
{
	UINT SNMP_PORT=161;
	snmp_message_length=0;
	current_snmp_message_pointer=0; 
	Create(SNMP_PORT,SOCK_DGRAM);
}

void InitServer::Send_snmp_message()
{
	SendTo(snmp_message_for_send,snmp_message_for_send_length,
		remote_port,remote_address,MSG_DONTROUTE);
}

BOOL InitServer::GetTag()
{
	if (snmp_message[current_snmp_message_pointer]==0x30)
	{
		current_snmp_message_pointer++;
		return TRUE ;
	}
	else
	{
		current_snmp_message_pointer++;
		return FALSE;
	}
}

int InitServer::GetASN1Length()
{
	int temp=0;
	int counter=0;
	if ((snmp_message[current_snmp_message_pointer]>0x00)&&
	   (snmp_message[current_snmp_message_pointer]<0x80))
	{
		temp=snmp_message[current_snmp_message_pointer];
		current_snmp_message_pointer++;
		return temp;
	}
	counter=snmp_message[current_snmp_message_pointer]&0x7F;
	current_snmp_message_pointer++;
		memcpy(&temp,&snmp_message[current_snmp_message_pointer],counter);
		temp=htonl(temp);
		temp=_rotr(temp,((4-counter)*8));
		current_snmp_message_pointer +=counter;
		return temp;
}

BOOL InitServer::IsValidLengthValue()
{		
		int length_temp;
		length_temp=GetASN1Length();
		if ((snmp_message_length - current_snmp_message_pointer)==length_temp) {
			return TRUE;
		}
		else {
			return FALSE;
		}
}
BOOL InitServer::GetVersion()	
{
	if (snmp_message[current_snmp_message_pointer]==0x02) {
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		current_snmp_message_pointer++;
		return FALSE;
	}
}

BOOL InitServer::IsValidVersionNumber1()
{
	int length_temp;
	length_temp=GetASN1Length();
	if ((length_temp==1)&&(snmp_message[current_snmp_message_pointer]==0)) {
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		return FALSE;
	}
}

BOOL InitServer::GetCommunityName()
{
	if (snmp_message[current_snmp_message_pointer]==0x04) {
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		return FALSE;
	}
}

BOOL InitServer::IsValidCommunityName()
{
	community_name="public"; // default value
	int length_temp,i;
	length_temp=GetASN1Length(); 
	for(i=0;i<length_temp;i++) {
		if (snmp_message[current_snmp_message_pointer]!=community_name[i]) {
			return FALSE;
		}
		current_snmp_message_pointer++;
	}
	return TRUE;
} 
BOOL InitServer::GetPDUTag()
{
	if (snmp_message[current_snmp_message_pointer]==0xA0) {
		snmp_command="GetRequest";
		current_snmp_message_pointer++;
	}
	if (snmp_message[current_snmp_message_pointer]==0xA1) {
		snmp_command="GetNextRequest";
		current_snmp_message_pointer++;
		return TRUE;
	}
	if (snmp_message[current_snmp_message_pointer]==0xA3) {
		snmp_command="SetRequest";
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		return FALSE;
	}
}

BOOL InitServer::IsValidCommandLength()
{
		int length_temp;
		length_temp=GetASN1Length();
		if ((snmp_message_length - current_snmp_message_pointer)==length_temp) {
			return TRUE;
		}
		else {
			return FALSE;
		}
}
BOOL InitServer::GetRequestIDField()
{
	if (snmp_message[current_snmp_message_pointer]==0x02) {
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		return FALSE;
	}
}
BOOL InitServer::GetRequestIDValue()
{
	int length_temp;
	request_id[0]=0;
	request_id[1]=0;
	request_id[2]=0;
	request_id[3]=0;
	length_temp=GetASN1Length(); 
	memcpy(&request_id[4-length_temp],&snmp_message[current_snmp_message_pointer],length_temp);
	current_snmp_message_pointer+=length_temp;
	// prepare request id for send
	UCHAR init_oid_for_send[]={0x30,0x84,0,0,0,35,2,1,0,0x4,6,'p','u','b','l','i','c',
		0xA2,0x84,0,0,0,18,2,4,request_id[0],request_id[1],request_id[2],request_id[3],
		2,1,0,2,1,0,0x30,0x84,0,0,0,0};
	memcpy(snmp_message_for_send,init_oid_for_send,sizeof(init_oid_for_send));
	current_snmp_message_for_send_pointer=sizeof(init_oid_for_send);
	snmp_message_for_send_length=current_snmp_message_for_send_pointer;
	//end prepar request if for send

	return TRUE;
} 

BOOL InitServer::GetErrorStatusField()
{
	int n=00;
	if (snmp_message[current_snmp_message_pointer]==0x02) {
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		return FALSE;
	}
}

BOOL InitServer::GetErrorStatusValue()
{
	int length_temp;
	length_temp=GetASN1Length();
	if ((length_temp==1)
		&&(snmp_message[current_snmp_message_pointer]==0x00)) {
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		return FALSE;
	}
}

BOOL InitServer::GetErrorIndexField()
{
	if (snmp_message[current_snmp_message_pointer]==0x02) {
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		return FALSE;
	}
}

BOOL InitServer::GetErrorIndexValue()
{
	int length_temp;
	length_temp=GetASN1Length();
	if ((length_temp==1)
		&&(snmp_message[current_snmp_message_pointer]==0x00)) {
		current_snmp_message_pointer++;
		return TRUE; 
	}
	else {
		return FALSE;
	}
}
BOOL InitServer::GetVarBindTag()
{
	if (snmp_message[current_snmp_message_pointer]==0x30) {
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		return FALSE;
	}
}

BOOL InitServer::GetVarBindLength()
{
	int length_temp;
	length_temp=GetASN1Length();
	if (snmp_message_length-current_snmp_message_pointer==length_temp) {
		return TRUE;
	}
	else {
		return FALSE;
	}
}

BOOL InitServer::GetVarTag()
{
	if (snmp_message[current_snmp_message_pointer]==0x30) {
		current_snmp_message_pointer++;
		return TRUE;
	}
	else {
		return FALSE;
	}
}

void InitServer::GetOID()
{
	CSnmpAgentView * dc = CSnmpAgentView::GetView();
	int PDU_length_temp;
	int i;
	CTime t= CTime::GetCurrentTime(); // 10:15PM March 19, 1999

	do{
	  PDU_length_temp=GetASN1Length();
	  current_snmp_message_pointer++;
	  i=FindOID(); 
	  if (i<10) {
	     Make_snmp_message(i);
		 dc->Display("Get node %s from ip %s when %i/%i/%i\r\n",GetNode(i),remote_address
			 ,t.GetDay(),t.GetMonth(),t.GetYear());
	  }else {
		 Send_error_message_to_nms();
		 break;
	  }
	  current_snmp_message_pointer += PDU_length_temp;
	}while(current_snmp_message_pointer < snmp_message_length);
}



int InitServer::Examine_snmp_message()
{
// Check for length of SNMP message 

	if (GetTag()==FALSE) {
		return BAD_TAG_VALUE;
	}
	if (IsValidLengthValue()==FALSE) {		
		return BAD_LENGTH_VALUE;
	}

// Check for Version number of SNMP is version 1 
	if (GetVersion()==FALSE) {		
		return BAD_VERSION_FORMAT;
	}
	if (IsValidVersionNumber1()==FALSE) {
		return BAD_VERSION_VALUE;
	}

// Check for Community name of SNMP is valid 
	if (GetCommunityName()==FALSE) {
		return BAD_COMMUNITY_NAME_FORMAT;
	}
	if (IsValidCommunityName()==FALSE) {
		return BAD_COMMUNITY_NAME_VALUE;
	}

// Check for Command in the SNMP message 
// In this step i don't check for value in the message 
// because if message is valid it will only return 
// 0xA0 , 0xA1 or 0xA3
	if (GetPDUTag()==FALSE) {
		return BAD_PDU_FORMAT;
	}
	if (IsValidCommandLength()==FALSE) {
		return BAD_PDU_LENGTH;
	}

// Check for Request field
	if (GetRequestIDField()==FALSE) {
		return BAD_REQUEST_ID_FORMAT;
	}
	GetRequestIDValue();


// Check for Error status field
	if (GetErrorStatusField()==FALSE) {
		return BAD_ERROR_STATUS_FORMAT;
	}
	if (GetErrorStatusValue()==FALSE) {
		return INVALID_ERROR_STATUS_RCVD;
	}
// Check for Error index field
	if (GetErrorIndexField()==FALSE) {
		return BAD_ERROR_INDEX_FORMAT;
	}
	if (GetErrorIndexValue()==FALSE) {
		return INVALID_ERROR_INDEX_RCVD;
	}

// Check for Variable bind list
// In this step i don't check for value
// Because not importan
	if (GetVarBindTag()==FALSE) {
		return BAD_VARBINDLIST_TAG_VALUE;
	}
	if (GetVarBindLength()==FALSE) {
		return BAD_VARBINDLIST_TAG_LENGTH;
	}

// Check for Variable
// also like variable bind list not important 
// to check value 

		if (GetVarTag()==FALSE) {
			return BAD_VARIABLE_TAG_VALUE;
		}
		
		GetOID();
	return SNMP_MESSAGE_OK;
}


// Do not edit the following lines, which are needed by ClassWizard.
#if 0
BEGIN_MESSAGE_MAP(InitServer, CSocket)
	//{{AFX_MSG_MAP(InitServer)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
#endif	// 0



void InitServer::Send_error_message_to_nms()
{
	UCHAR error_message[]={48,40,2,1,0,4,6,0x70,0x75,0x62,0x6c,0x69,0x63,0xa2,25,2,4
		,request_id[3],request_id[2],request_id[1],request_id[0],2,1,0,2,1,0,48,13,48,11,6,7,0x2b,6,1,2,1,1,10,5,0};
	SendTo(error_message,sizeof(error_message),remote_port,remote_address,MSG_DONTROUTE);
}

int InitServer::FindOID()
{
	UCHAR data[30];
	int i;
	memcpy(&data[0],&snmp_message[current_snmp_message_pointer],
		snmp_message[current_snmp_message_pointer]+1);
	for(i=0;i<number_of_oid;i++) {
		if (memcmp(data,oid[i],snmp_message[current_snmp_message_pointer]+1)==0) 
			return i;
	}
	return 10; // if you want make oid more here you will append both
			   // oid variable and mib_handle variable but now is 10
}

void InitServer::Make_snmp_message(int i)
{
	UCHAR pdu[127];
	int pdu_length=0;
	pdu[0]=6;
	pdu[1]=oid[i][0];
	memcpy(&pdu[2],&oid[i][1],oid[i][0]);
	pdu_length=2+oid[i][0];
	memcpy(&pdu[pdu_length],&mib_handle[i][0],
		mib_handle[i][1] + 2);
	pdu_length+=2+mib_handle[i][1];

	snmp_message_for_send[current_snmp_message_for_send_pointer]=0x30;
	snmp_message_for_send[current_snmp_message_for_send_pointer+1]=pdu_length;
	current_snmp_message_for_send_pointer+=2;

	memcpy(&snmp_message_for_send[current_snmp_message_for_send_pointer],
		pdu,pdu_length);

	current_snmp_message_for_send_pointer = 
		current_snmp_message_for_send_pointer + pdu_length;
	pdu_length+=2; 
	snmp_message_for_send_length +=	pdu_length;
	Add_length(1,pdu_length);
	Add_length(18,pdu_length);
	Add_length(36,pdu_length);
}

void InitServer::Add_length(int pt, int op)
{
	int length_temp;
	pt++;
	memcpy(&length_temp,&snmp_message_for_send[pt],4);
	length_temp = _lrotr(length_temp,24);

	length_temp+=op;
	length_temp= _lrotl(length_temp,24);
	memcpy(&snmp_message_for_send[pt],&length_temp,4);
}

CString InitServer::GetNode(int i)
{
	int length=oid[i][0]; 
	int j;
	CString s="";
	for(j=0;j<length;j++){
		switch( oid[i][j+1] ) 
			{
			case 0:
					s+=".0";
					break;
			case 1:
					s+=".1";
					break;
			case 2:
					s+=".2";
					break;
			case 3:
					s+=".3";
					break;
			case 4:
					s+=".4";
					break;
			case 5:
					s+=".5";
					break;
			case 6:
					s+=".6";
					break;
			case 7:
					s+=".7";
					break;
			case 8:
					s+=".8";
					break;
			case 9:
					s+=".9";
					break;
			case 10:
					s+=".10";
					break;
			case 11:
					s+=".11";
					break;
			case 0x2b:
					s+=".1.3";
					break;
			}
	}
	return s;		 
}

void InitServer::Init_MIB_Handler()
{
	access_counter++;
	unsigned long r;
	

	UCHAR oid_0_value[]={4,39,"Hello Network Management System Project"};	
	UCHAR oid_1_value[]={6,10,0x2b,6,1,4,1,11,2,3,2,3};	
	UCHAR oid_2_value[]={0x40,4};	
	UCHAR oid_3_value[]={2,1,access_counter};	

	UCHAR oid_5_value[6]={2,4,0,0,0,0};
	UCHAR oid_6_value[6]={2,4,0,0,0,0};

	r=inet_addr(remote_address);
  	 memcpy(&mib_handle[0][0],&oid_0_value[0],sizeof(oid_0_value));
	 memcpy(&mib_handle[1][0],&oid_1_value[0],sizeof(oid_1_value));
	//   In comming IP
	 memcpy(&mib_handle[2][0],&oid_2_value[0],sizeof(oid_2_value));
	 memcpy(&mib_handle[2][2],&r,sizeof(r));
	 memcpy(&mib_handle[3][0],&oid_3_value[0],sizeof(oid_3_value));

	//	 Get Free Disk Space
	UINT disk_space=GetDiskSpace();
	disk_space= _lrotr(disk_space,24);
	memcpy(&oid_5_value[2],&disk_space,4);
	memcpy(&mib_handle[5][0],&oid_5_value[0],sizeof(oid_5_value));

	//	 Get Free Memory Space
	UINT mem_space=GetFreeMem();
	mem_space= _lrotr(mem_space,24);
	memcpy(&oid_6_value[2],&mem_space,4);
	memcpy(&mib_handle[6][0],&oid_6_value[0],sizeof(oid_6_value));
}

UINT InitServer::GetDiskSpace()
{
	ULARGE_INTEGER  a,b,c;
	ZeroMemory(&a,sizeof(ULARGE_INTEGER));
	ZeroMemory(&b,sizeof(ULARGE_INTEGER));
	ZeroMemory(&c,sizeof(ULARGE_INTEGER));
	GetDiskFreeSpaceEx("\\",(ULARGE_INTEGER *)&a,(ULARGE_INTEGER *)&b,
		(ULARGE_INTEGER *)&c);
	return c.QuadPart;	
}

UINT InitServer::GetFreeMem()
{
	MEMORYSTATUS mem_status;
	ZeroMemory(&mem_status,sizeof(MEMORYSTATUS));
	mem_status.dwLength=sizeof(MEMORYSTATUS);
	GlobalMemoryStatus((MEMORYSTATUS *)&mem_status);
	return mem_status.dwAvailVirtual;
}
