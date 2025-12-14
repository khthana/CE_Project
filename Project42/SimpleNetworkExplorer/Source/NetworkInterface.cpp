// NetworkInterface.cpp: implementation of the CNetworkInterface class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "NetworkInterface.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CNetworkInterface::CNetworkInterface()
{

}

CNetworkInterface::~CNetworkInterface()
{

}

//////////////////////////////////////////////////////////////////////
//Methods
//////////////////////////////////////////////////////////////////////

// method to set data of Interface Card of this Component
void CNetworkInterface::SetValue(int ID,CString IP,CString type,CString subnet)
{
	IF_ID	 =ID;		// ID no. of Interface card
	IF_IP	 =IP;		// IP Number of Interface card
	CString test= IF_IP;
	IF_Type	 =type;		// Type of network connected to Interface card
	IF_Subnet=subnet;	// Subnet Mask of Interface card
} // of SetValue

CString* CNetworkInterface::GetIP()
{
	return &IF_IP;
}


CString* CNetworkInterface::GetSubnet()
{
	return &IF_Subnet;
}