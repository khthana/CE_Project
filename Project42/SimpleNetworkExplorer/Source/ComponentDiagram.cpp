// ComponentDiagram.cpp: implementation of the CComponentDiagram class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "ComponentDiagram.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CComponentDiagram::CComponentDiagram(CObArray* theLinkList)
{
	LinkDiagramList = theLinkList;
}

CComponentDiagram::~CComponentDiagram()
{
}

BEGIN_MESSAGE_MAP(CComponentDiagram, CStatic)
	//{{AFX_MSG_MAP(CComponentDiagram)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		ON_WM_LBUTTONDOWN()
		ON_WM_MOUSEMOVE()
		ON_WM_LBUTTONUP()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CComponentDiagram message handlers

void CComponentDiagram::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CDiagram::OnLButtonDown(nFlags, point);
    SetCapture(); //this ensures that if we drag very fast even then the mouse will stay with us, even if we go outside the main window  
	//m_downPt=point; //this holds the point where we initially pressed the mouse button
}


void CComponentDiagram::OnLButtonUp(UINT nFlags, CPoint point) 
{
	CDiagram::OnLButtonUp(nFlags, point);
    ReleaseCapture(); //this releases the mouse for other windows
}

void CComponentDiagram::OnMouseMove(UINT nFlags,CPoint point) 
{
	CRect NewBitmapRect =CDiagram::OnMouseMove(nFlags,point);
	if (nFlags==MK_LBUTTON)  
	{
		int LastID = LinkDiagramList->GetSize()-1;
		// used to keep the last index of LinkDiagramList.(must -1 because index start at 0)
		for(int i=0;i<=LastID;i++)
		{
			CLinkDiagram* LinkObject;
			// declare 'LinkObject' be pointer to 'CLinkObject' 
			LinkObject = (CLinkDiagram *)LinkDiagramList->GetAt(i);
			// get CLinkDiagram Object from 'LinkDiagramList'
			if (CID == LinkObject->ComDiagramID)
			{
				LinkObject->MoveLinkComponent(GetPosition());
			}// of if map Conponent ID
		}// of for 
		int x1 = NewBitmapRect.left-40;
		int y1 = NewBitmapRect.bottom;//+DiagramRect.Height();
		int x2 = NewBitmapRect.right+40;
		int y2 = y1+40;
		textrect.SetRect(x1,y1,x2,y2);
		IPtext.MoveWindow(textrect,TRUE);//point.x,point.y,textrect.Width(),textrect.Height(),TRUE); 
	}// of if MK_LBUTTON
}


//////////////////////////////////////////////////////////////////////
//Methods
//////////////////////////////////////////////////////////////////////

// method to set initial value of Component in Network
void CComponentDiagram::SetValue(CStringArray* DataIn)//(int ID,CString name,BYTE type,int IFno)
{
//index 0=ID ;1=Component Name ;2=Component Type ;3=Interface Number
//      4=@0 ;5=Interface IP   ;6=Interface Type ;7=Interface Subnet 
//In File "CName//CType//IF_No//@IF_ID//IF_IP//IF_Type//IF_Subnet#" 
//     that insert 'CID' at index 0
	CID		=atoi(DataIn->GetAt(0));		// Component ID no.
	CName	=DataIn->GetAt(1);	            // Component Name 
	CType	=DataIn->GetAt(2);				// Component Type	
	IF_No	=atoi(DataIn->GetAt(3));        // Interface Number
	InterfaceList.SetSize(IF_No,1);
	
	int IndexDataIn=5;
	//Index of 'DataIn' start at index 5 that the first Interface IP
	
	if (IF_No>19)
	{
		IF_No = 19;
	}
	//for to set value of Interface begin first(index=0) 
	//   to last(index=IF_No-1)
	CString IP;
	CString type;
	CString subnet;
	for(int IFindex=0;IFindex<=IF_No-1;IFindex++)
	{
		IP = DataIn->GetAt(IndexDataIn);
		type = DataIn->GetAt(IndexDataIn+1);
		subnet = DataIn->GetAt(IndexDataIn+2);
		
		// must create the new pointer to CNetworkInterface 
		//	to save the value that pointed and to create new in every loop.
		CNetworkInterface *InterfaceObject = new CNetworkInterface();
		// create 'InterfaceObject' be pointer to 'CNetworkInterface' 
		//   to will keep in 'InterfaceList'(CObArray)
		
		InterfaceObject->SetValue(IFindex,IP,type,subnet);
		InterfaceList.InsertAt(IFindex,InterfaceObject);
		IndexDataIn = IndexDataIn+4;
		// Move Index 'IndexDataIn' to next Interface so must +4
	}//of for first(0) to last index of InterfaceList
}// of SetValue Method
	// example CType (Component Type)
	//		Computer = 0    Router = 1
	//		Switch = 2		Hub	   = 3

CString* CComponentDiagram::GetName()
{
	return &CName;
	// can't return value with CString because it's Class.
	// must return with pointer of CString
}

CString* CComponentDiagram::GetType()
{
	return &CType;
}

// method to display this Diagram in pParentWnd(Window)
void CComponentDiagram::Show(CWnd* pParentWnd,CPoint position)
{
	if (CType=="Computer" || CType=="Other")
	{
		DiagramRect.SetRect(position.x,position.y,position.x+39,position.y+35);
		CDiagram::Show(pParentWnd,DiagramRect,IDB_Computer);
	}
	else if (CType=="Router")
	{
		DiagramRect.SetRect(position.x,position.y,position.x+50,position.y+14);
		CDiagram::Show(pParentWnd,DiagramRect,IDB_Router);
	}
	else if (CType=="Switch")
	{
		DiagramRect.SetRect(position.x,position.y,position.x+50,position.y+14);
		CDiagram::Show(pParentWnd,DiagramRect,IDB_Router);
	}
	else if (CType=="Hub")
	{
		DiagramRect.SetRect(position.x,position.y,position.x+50,position.y+14);
		CDiagram::Show(pParentWnd,DiagramRect,IDB_Hub);
	}
	else if (CType=="Unsupport")
	{
		DiagramRect.SetRect(position.x,position.y,position.x+39,position.y+35);
		CDiagram::Show(pParentWnd,DiagramRect,IDB_Unsupport);
	}

	int x1 = position.x-40;
	int y1 = position.y+DiagramRect.Height();
	int x2 = position.x+DiagramRect.Width()+40;
	int y2 = y1+40;
	textrect.SetRect(x1,y1,x2,y2);
	IPtext.Create(CName,WS_VISIBLE|SS_CENTER,textrect,pParentWnd,4444+CID);
}


// Method to split the value in IP String form to 4 fields of 'ipfields' 
ipfields* CComponentDiagram::IPString_to_IPField(CString inIP)
{
	int iplength;
	int fieldindex;
	int fieldslot;
	int ipindex;
	char chrtemp;
	char field1[3];
	char field2[3];
	char field3[3];
	char field4[3];
	ipfields *tempip = new ipfields();

	fieldindex =1;
	fieldslot =0;

	iplength = strlen(inIP);
	for(ipindex = 0;ipindex < iplength;ipindex++)
	{
		chrtemp = inIP[ipindex];
		if ( chrtemp != '.')
		{ 
			switch(fieldindex)
			{
			case 1:
				field1[fieldslot]=chrtemp;
				fieldslot++;
				break;
			case 2:
				field2[fieldslot]=chrtemp;
				fieldslot++;
				break;
			case 3:
				field3[fieldslot]=chrtemp;
				fieldslot++;
				break;
			case 4:
				field4[fieldslot]=chrtemp;
				fieldslot++;
				break;
			} // of switch
		}
		else
		{
			switch(fieldindex)
			{
			case 1:
				field1[fieldslot]=NULL;
				fieldindex++;
				fieldslot = 0;
				break;
			case 2:
				field2[fieldslot]=NULL;
				fieldindex++;
				fieldslot = 0;
				break;
			case 3:
				field3[fieldslot]=NULL;
				fieldindex++;
				fieldslot = 0;
				break;
			} // of switch
		}// of if
	}// of for
	field4[fieldslot]=NULL;
	tempip->field1 = atoi(field1);
	tempip->field2 = atoi(field2);
	tempip->field3 = atoi(field3);
	tempip->field4 = atoi(field4);
	return tempip;
} // of Split_IPtoField()

// method to include 4 fields of IP to String IP
CString* CComponentDiagram::IPField_to_IPString(ipfields inip)
{
	CString *returnip = new CString();
	int divtemp;
	char iptemp;
	int iplength;
	bool empty = true;
	divtemp = inip.field1/100;
	if ( divtemp > 0 )
	{ 
		iptemp = chr(divtemp);
		*returnip += iptemp;
		empty = false;
	}
	divtemp = (inip.field1/10)%10;
	
	if (divtemp > 0)
	{
		iptemp = chr(divtemp);
		*returnip += iptemp;
	}
	else
	{
		if (empty == false)
		{	
			iptemp = chr(divtemp);
			*returnip += iptemp;
		}
	}
	divtemp = inip.field1 % 10;
	iptemp = chr(divtemp);
	*returnip += iptemp;
	*returnip += '.';
	divtemp = inip.field2/100;
	if ( divtemp > 0 )
	{
		iptemp = chr(divtemp);
		*returnip += iptemp;	
	}
	divtemp = (inip.field2/10)%10;
	if (divtemp > 0)
	{
		iptemp = chr(divtemp);
		*returnip += iptemp;
	}
	else
	{
		iplength = strlen(*returnip);
		if (returnip->GetAt(iplength - 1) != '.')
		{
			iptemp = chr(divtemp);
			*returnip += iptemp;
		}
	}
	divtemp = inip.field2 % 10;
	iptemp = chr(divtemp);
	*returnip += iptemp;
	*returnip += '.';
	divtemp = inip.field3/100;
	if ( divtemp > 0 )
	{ 
		iptemp = chr(divtemp);
		*returnip += iptemp;
	}
	divtemp = (inip.field3/10)%10;
	if (divtemp > 0)
	{
		iptemp = chr(divtemp);
		*returnip += iptemp;
	}
	else
	{
		iplength = strlen(*returnip);
		if (returnip->GetAt(iplength - 1) != '.')
		{
			iptemp = chr(divtemp);
			*returnip += iptemp;
		}
	}
	divtemp = inip.field3 % 10;
	iptemp = chr(divtemp);
	*returnip += iptemp;
	*returnip += '.';
	divtemp = inip.field4/100;
	if ( divtemp > 0 )
	{ 
		iptemp = chr(divtemp);
		*returnip += iptemp;
	}
	divtemp = (inip.field4/10)%10;
	if (divtemp > 0)
	{
		iptemp = chr(divtemp);
		*returnip += iptemp;
	}
	else
	{
		iplength = strlen(*returnip);
		if (returnip->GetAt(iplength - 1) != '.')
		{
			iptemp = chr(divtemp);
			*returnip += iptemp;
		}
	}
	divtemp = inip.field4 % 10;
	iptemp = chr(divtemp);
	*returnip += iptemp;
	return returnip;
}

// method to convert Integer (byte) to char
char CComponentDiagram::chr(byte inconvert)
{	
	char chrret;
	switch(inconvert)
	{
	case 0:
		chrret = '0';
		break;
	case 1:
		chrret = '1';
		break;
	case 2:
		chrret = '2';
		break;
	case 3:
		chrret = '3';
		break;
	case 4:
		chrret = '4';
		break;
	case 5:
		chrret = '5';
		break;
	case 6:
		chrret = '6';
		break;
	case 7:
		chrret = '7';
		break;
	case 8:
		chrret = '8';
		break;
	case 9:
		chrret = '9';
		break;
	}
	return chrret;
}

// Method to find the IP of network that this Interface is connected
CStringArray* CComponentDiagram::ListofConnectedNetwork()
{
	CNetworkInterface* thisInterface;
	// declare 'theInterface' be pointer to 'CNetworkInterface' 
	for(int i=0 ;i<IF_No ;i++)
	{
		thisInterface = (CNetworkInterface *)InterfaceList.GetAt(i);
	    // InterfaceList is CObArray of Interface Object
		// get 'CNetworkInterface' Object from 'InterfaceList'
		ipfields ifiptemp =*IPString_to_IPField(*thisInterface->GetIP());
		// Get the IP of Interface to 'ifiptemp'
		ipfields ifclasstemp =*IPString_to_IPField(*thisInterface->GetSubnet());
		// Get the Subnet mask of Interface to 'ifclasstemp'
		ipfields NetworkIP;
		// Calculate the IP of network that Interface connected 
		//	by And "Interface IP"(ifiptemp) with "Subnet Mask"(ifclasstemp)
		NetworkIP.field1 = ifiptemp.field1 & ifclasstemp.field1;
		NetworkIP.field2 = ifiptemp.field2 & ifclasstemp.field2;
		NetworkIP.field3 = ifiptemp.field3 & ifclasstemp.field3;
		NetworkIP.field4 = ifiptemp.field4 & ifclasstemp.field4;
		CString *NetworkIPString = new CString();
		NetworkIPString = IPField_to_IPString(NetworkIP);
		// convert the IP field to String IP
		NetworkIPList.Add(*NetworkIPString);
		// NetworkIPList is CStringArray that be member of this Class
		// Add 'NetworkIP' to Array 'NetworkIPList'
		CString test=NetworkIPList.GetAt(i); 
	}
	return &NetworkIPList;
}
