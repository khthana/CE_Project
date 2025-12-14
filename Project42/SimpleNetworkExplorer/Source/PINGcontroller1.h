#if !defined(AFX_PINGCONTROLLER1_H__B8AF7254_05F4_11D4_B2C2_002018384C47__INCLUDED_)
#define AFX_PINGCONTROLLER1_H__B8AF7254_05F4_11D4_B2C2_002018384C47__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "Showstatus.h"
// PINGcontroller1.h : header file
//
typedef struct iphdr {
	unsigned int h_len:4;          // length of the header
	unsigned int version:4;        // Version of IP
	unsigned char tos;             // Type of service
	unsigned short total_len;      // total length of the packet
	unsigned short ident;          // unique identifier
	unsigned short frag_and_flags; // flags
	unsigned char  ttl; 
	unsigned char proto;           // protocol (TCP, UDP etc)
	unsigned short checksum;       // IP checksum
	unsigned int sourceIP;
	unsigned int destIP;

}IpHeader;

// ICMP header

typedef struct _ihdr {
  BYTE i_type;
  BYTE i_code; /* type sub code */
  USHORT i_cksum;
  USHORT i_id;
  USHORT i_seq;
  /* This is not the std header, but we reserve space for time */
  ULONG timestamp;
}IcmpHeader;

#define STATUS_FAILED 0xFFFF
#define DEF_PACKET_SIZE 32
#define MAX_PACKET 1024
#define xmalloc(s) HeapAlloc(GetProcessHeap(),HEAP_ZERO_MEMORY,(s))
#define xfree(p)   HeapFree (GetProcessHeap(),0,(p))

#define WIN32_LEAN_AND_MEAN
#define ICMP_ECHO 8
#define ICMP_ECHOREPLY 0
#define ICMP_MIN 8



/////////////////////////////////////////////////////////////////////////////
// PINGcontroller dialog

class PINGcontroller : public CDialog
{
// Construction
public:
//	int pingstatus;
	Showstatus showingstatus;
	ipfields activeip[1000];
	CStatic pingingip;
	CStatic pingingstatus;
	int returntime;
	void fill_icmp_data(char *, int);
	USHORT checksum(USHORT *, int);
	void decode_resp(char *,int ,struct sockaddr_in *);
	ipfields collectip(char*);
	ipfields increaseip(ipfields);
	char chr(byte);
	CString ipinttostr(ipfields);
	int ping(CString);
	PINGcontroller(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(PINGcontroller)
	enum { IDD = IDD_Ping };
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(PINGcontroller)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(PINGcontroller)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PINGCONTROLLER1_H__B8AF7254_05F4_11D4_B2C2_002018384C47__INCLUDED_)
