// NetworkInterface.h: interface for the CNetworkInterface class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_NETWORKINTERFACE_H__90CB7C0E_E5C4_11D3_92E1_00E02947F59E__INCLUDED_)
#define AFX_NETWORKINTERFACE_H__90CB7C0E_E5C4_11D3_92E1_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CNetworkInterface : public CObject
{
public:
	CNetworkInterface();
	virtual ~CNetworkInterface();

//Attributes
private: 
	int		IF_ID;		// ID no. of Interface card start at index 0
	CString IF_IP;		// IP Number of Interface card
	CString IF_Type;	// Type of network connected to Interface card
	CString IF_Subnet;	// Subnet Mask of Interface card
	// represent IF_Type's Symbol (Network Type that Interface connect)
	//		Ethernet = 0		Token Ring = 1		FDDI = 2
	//		ATM		 = 3		Frame Rely = 4		Star = 5

//Methods
public:
	void SetValue(int ID,CString IP,CString type,CString subnet);
	// method to set value in Interface
	CString* GetIP();
	// method to return the value of IF_ID
	CString* GetSubnet();
	// method to return the value of IF_Subnet
};

#endif // !defined(AFX_NETWORKINTERFACE_H__90CB7C0E_E5C4_11D3_92E1_00E02947F59E__INCLUDED_)

