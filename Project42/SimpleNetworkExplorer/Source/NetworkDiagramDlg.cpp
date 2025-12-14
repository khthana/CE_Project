// NetworkDiagramDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "NetworkDiagramDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CNetworkDiagramDlg dialog


CNetworkDiagramDlg::CNetworkDiagramDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CNetworkDiagramDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CNetworkDiagramDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
//	CWinApp::SetDialogBkColor(RGB(0,0,0));// Set dialog background color to black
}


void CNetworkDiagramDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CNetworkDiagramDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}



BEGIN_MESSAGE_MAP(CNetworkDiagramDlg, CDialog)
	//{{AFX_MSG_MAP(CNetworkDiagramDlg)
	ON_WM_CREATE()
	ON_WM_CONTEXTMENU()
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CNetworkDiagramDlg message handlers

int CNetworkDiagramDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	NetworkList.SetSize(0,1);
	ComponentList.SetSize(0,1);
	OpenFile("network.txt",1);
	//Open file and get data to 'NetworkList'(Set parameter'type' =1 to be network set)
	OpenFile("support.txt",2);
	//Open file and get data to 'ComponentList'(Set parameter'type' =2 to be component set)
	return 0;
}

HBRUSH CNetworkDiagramDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{
	HBRUSH hbr = CDialog::OnCtlColor(pDC,pWnd, nCtlColor);
	// set the background color
	COLORREF color = RGB(255,255,255);
	pDC->SetBkColor(color);
	if (m_brush.GetSafeHandle() == NULL)
	{
		// create a brush the first time this function is called
		m_brush.CreateSolidBrush(color);
	}
	if (nCtlColor == CTLCOLOR_DLG || nCtlColor == CTLCOLOR_STATIC)
	{
		// set the color of the dialog and selected controls
		hbr = (HBRUSH) m_brush.GetSafeHandle();
	}
	return hbr;
}

// this method to open data file(.txt) and ge data from this file to Object Attribute
void CNetworkDiagramDlg::OpenFile(CString FileName,BYTE type)
{
// This code is used to open file to read data.
	CStdioFile NetworkData;//(FileName,CFile::modeRead);
	if( !NetworkData.Open(FileName,CFile::modeRead))
	{
		#ifdef _DEBUG
		  afxDump << "Unable to open file" << "\n";
	   #endif
	   exit( 1 );
	}
	//Declare 'NetworkData' to be derived from CStdioFile class to	
	//		reference to file(NetworkDB.txt)
	CString data;		//Declare 'data' to be CString class
	CStringArray List;	//Declare 'List' to be CStringArray
	// CStringArray like the link list that don't define size 
	while (!feof(NetworkData.m_pStream))
	{
		NetworkData.ReadString(data);
		if (data== "")// && feof(NetworkData.m_pStream))
		{
			MessageBox("No Data To Display !",FileName);
			break;
		}
		data+="$";	// Add the signal to tell that end of String
		List.Add(data);// Add 'data' to Array 'List'
	}
	// Example of List's member: 161.246.4.0//c//FDDI#
// This code is used to save data from File to Array of Object.
	CString theString;
	// theString is used to keep string in each line of data file
	CStringArray Item;
	// Item is used to keep string in each line of data file 
	//    but separated to each member of CStringArray 
	//    that be used to be parameter that passed to 'SetValue' method
	//	  index 0=ID ;1=Network Name ;2=Network Class ;3=Network Type
	
	int LastID = List.GetSize()-1;
	// used to keep the last index of List.(must -1 because index start at 0)
	int IDint;
	// 'IDint' is used to keep ID number value of each NetworkDiagram(Object)

	for(IDint=0;IDint<=LastID;IDint++)
	{
		int id_of_Item = 0;
		// 'id_of_Item' is used to keep index of 'Item' CStringArray
		theString = List.GetAt(IDint);
		char IDString[2];
		 //used to be char[] buffer of IDint that [2] because ID is 2 digits.
		// itoa cannot change int to CString or char* (Must only be char[])
		itoa(IDint,IDString,10);
		// convert from int 'IDint' to char[] 'IDString' 
		//    that used to put value in 'temp'
		CString temp(IDString);
		// CString 'temp' is used to keep string that gotten from 'theString'  
		Item.InsertAt(id_of_Item,temp);
		// Insert first member of 'Item' to be ID number
		temp.Empty(); 
		// Delete all string in 'temp' for keep new string in next
		id_of_Item = id_of_Item+1;
		
		char signal;
		// 'signal' is used to keep each character from each line of data file
		int id_of_theString = 0;
		// 'id_of_theString' is used to keep index of character from each line 'theString'
		signal = theString[id_of_theString];
		//
		BOOL FirstSlash=FALSE;//if FirstSlash=True then Find the '/' first.
		// this while to get data in each line that separated by '$'
		while (signal!='$')
		{
			
			// this while is to get each Item that separated by '//'
			// Do until find '//' or '$'
			while ((signal!='/' || !FirstSlash )&& signal!='$')
			{
				if (signal=='/')
					FirstSlash =TRUE; 
					// Now find the first '/' of '//' 
				else 
					temp.Insert(id_of_theString,signal);
					// Insert char 'signal' to the end of 'temp' CString
				id_of_theString = id_of_theString+1;
				signal = theString[id_of_theString];
			} // while do until find '//' or '$'

			if (signal!='$')	
			{
				id_of_theString = id_of_theString+1;
				signal =theString[id_of_theString];
			} // No Increase 'id_of_theString' ,if find '$' at the end of line
			
			Item.InsertAt(id_of_Item,temp); 
			// Insert string value in 'temp' variable to CStringArray 'Item'
			temp.Empty(); 
			// Delete all string in temp to keep new string in next loop
			FirstSlash =FALSE; // Set 'FirstSlash' back to False
			id_of_Item =id_of_Item+1;	   
		}// while do until find '$'
		//*** Can not Pass Parameter that Be Object Variable 
		//     must be address pointer of that Object
		CStringArray* NetDatas; //=new CStringArray;
		// used to be address pointer of 'Item' CStringArray
		NetDatas =&Item;
		// set pointer 'NetDatas' point to 'Item' object

		// if declare with 
		//		CNetworkDiagram NetworkObject;
		// the value in NetworkObject will lose when exit this method.
		// So must declare with Create new pointer that point to that Object
		// Beside,must declare both 'NetworkObject' and 'ComponentObject'
		//   every times that be loop. 
		//   Otherwith the pointer that keep in all member of 
		//   'NetwokList' and 'ComponentList' CObArray will point 
		//   at the same Object. 
		CNetworkDiagram *NetworkObject = new CNetworkDiagram(&LinkList);
		// create 'NetworkObject' be pointer to 'CNetworkDiagram' 
		//   to will keep in 'NetworkList'(CObArray)
		CComponentDiagram *ComponentObject = new CComponentDiagram(&LinkList);
		// create 'ComponentObject' be pointer to 'CComponentDiagram' 
		//   to will keep in 'ComponentList'(CObArray)
		if (type ==1)
		{
			NetworkObject->SetValue(NetDatas);
			// call mehtod 'Setvalue' to set the value of NetworkObject
			NetworkList.InsertAt(IDint,NetworkObject);
			// insert this 'NetworkObject' in 'NetworkList' CObArray
		}
		else if (type ==2)
		{
			ComponentObject->SetValue(NetDatas);
			// call mehtod 'Setvalue' to set the value of ComponentObject
			ComponentList.InsertAt(IDint,ComponentObject);
			// insert this 'ComponentObject' in 'ComponentList' CObArray
		}
		Item.RemoveAll();
		// Reset all value in Item to used in next loop
	} // of for(IDint=first ID to last ID of 'List')
} // of OpenFile method

void CNetworkDiagramDlg::OnContextMenu(CWnd* pWnd, CPoint point) 
{
//Syntax to get Object from CObArray
//code:	 ObjectClass* Object;
//		 Object = (ObjectClass *)CObArrayName.GetAt(index);

//****************** Network ****************
// part of Create pop-up menu of Network	
	
	CMenu NetDisplay,*NetPopUp1,*NetPopUp2;
	NetDisplay.LoadMenu(IDR_DiagramPopUpMenu);
	// Load 'IDR_DiagramPopUpMenu' Menu to 'Display' CMenu
	NetPopUp1 =NetDisplay.GetSubMenu(0);
	// Get sub menu of popup menu 'Display'
	NetPopUp2 =NetPopUp1->GetSubMenu(0);
	// Get sub menu of popup menu 'NetPopUp1'
	
	int NetPos;
	int LastNetObjectID = NetworkList.GetSize()-1;
	// used to keep the last index of NetworkList.(must -1 because index start at 0)

	for(int i=0;i<=LastNetObjectID;i++)
	{
	    CNetworkDiagram* NetObject;
		// declare 'NetObject' be pointer to 'CNetworkObject' 
		NetObject = (CNetworkDiagram *)NetworkList.GetAt(i);
		// get CNetworkDiagram Object from 'NetworkList'
		// 'NetworkList'is an Array of Object (CObArray)

		if (!NetObject->Exist)//if this Object exist on diagram then don't display on menu
		{
			CString NetworkName = *NetObject->GetName();
			// set value of 'NetworkName' to be the value that pointed by 'NetObject->GetName()' which keep the pointer
			NetPos = NetPopUp2->GetMenuItemCount();
			//Get all number of Item in 'popup2'
			NetPopUp2->InsertMenu(NetPos,MF_BYPOSITION,54000+i,NetworkName);
			//Insert 'NetworkName' to the end 'pos' of 'popup2'
		}// of If ! Exist
	}
	//**** Can't Insert new Item if not have the first Item (initialized)
	NetPopUp2->RemoveMenu(0,MF_BYPOSITION);
	//Remove menu Item at first position 'Diagram1'
//	NetDisplay.DestroyMenu();

//************ Component ********************
// part of Create pop-up menu of Component

	CMenu ComDisplay,*ComPopUp1,*ComPopUp2;
	ComDisplay.LoadMenu(IDR_DiagramPopUpMenu);
	// Load 'IDR_DiagramPopUpMenu' Menu to 'Display' CMenu
	int q=ComDisplay.GetMenuItemCount();
	ComPopUp1 =ComDisplay.GetSubMenu(0);
	// Get sub menu of popup menu 'Display'
	ComPopUp2 =ComPopUp1->GetSubMenu(1);
	// Ge1t sub menu of popup menu 'ComPopUp1'
	
	int ComPos;
	int LastComObjectID = ComponentList.GetSize()-1; 
	// used to keep the last index of ComponentList.(must -1 because index start at 0)
	for(int j=0;j<=LastComObjectID;j++)
	{
	    CComponentDiagram* ComObject;
		// declare 'ComObject' be pointer to 'CComponentObject' 
		ComObject = (CComponentDiagram *)ComponentList.GetAt(j);
		// get CComponentDiagram Object from 'ComponentList'
		// 'ComponentList'is an Array of Object (CObArray)
		if (!ComObject->Exist) //if this Object exist on diagram then don't display on menu
		{
			CString ComponentName = *ComObject->GetName();
			// set value of 'ComponentName' to be the value that pointed by 'ComObject->GetName()' which keep the pointer
			ComPos = ComPopUp2->GetMenuItemCount();
			//Get all number of Item in 'ComPopUp2'
			ComPopUp2->InsertMenu(ComPos,MF_BYPOSITION,55000+j,ComponentName);
			//Insert 'ComponentName' to the end 'pos' of 'ComPopUp2'
		}// of If ! Exist
	}
	//**** Can't Insert new Item if not have the first Item (initialized)
	ComPopUp2->RemoveMenu(0,MF_BYPOSITION);
	//Remove menu Item at first position 'Diagram2'

//************** Network ******************
	CString string;
	UINT flags = 0;
	int ClickNetID =NetPopUp1->TrackPopupMenu(TPM_LEFTALIGN|TPM_RIGHTBUTTON|TPM_RETURNCMD|TPM_NONOTIFY,point.x,point.y,this);
	// Display 'NetPopUp1' menu to this Dialog at position that defined by 'point'
	//   and return ID of that Popup menu item to 'ClickNetID'
	if(ClickNetID)
	{
		NetPopUp2->GetMenuString(ClickNetID,string,flags);
	}
//*** this statement to show the Diagram that be selected from popup menu
	if (string!="")
	{
		for(int x=0;x<=LastNetObjectID;x++)
		{
			CNetworkDiagram* NetObject;
			// declare 'NetObject' be pointer to 'CNetworkObject' 
			NetObject = (CNetworkDiagram *)NetworkList.GetAt(x);
			// get CNetworkDiagram Object from 'NetworkList'
			// 'NetworkList'is an Array of Object (CObArray)
			CString NetworkName = *NetObject->GetName();
			// set value of 'NetworkName' to be the value that pointed by 'NetObject->GetName()'		
			if (NetworkName == string)
			{
				NetObject->SetExist(TRUE);
				// set Exist of Network Diagram
				NetObject->Show(this,point);

				CPoint NoExist(-1,-1);
				int theLastComID = ComponentList.GetSize()-1;
				// do loop until reach the number of ComponentDiagram
				for (int theComID=0; theComID<=theLastComID; theComID++)
				{
					CPoint theComPoint = *GetComponentPoint(theComID,&NetworkName);
					if (theComPoint!=NoExist) //compare CPoint
					{
						CLinkDiagram *LinkObject = new CLinkDiagram(this);
						// create 'LinkObject' be pointer to 'CLinkDiagram' 
						//   to will keep in 'LinkList'(CObArray)
						int LinkIndex = LinkList.GetSize();
						LinkObject->CreateLink(LinkIndex,NetObject->GetID(),theComID,NetObject->GetPosition(),theComPoint);
						//CreateLink(int LinkID,int NetID,int ComID,CPoint NetPos,CPoint ComPos)
						LinkList.InsertAt(LinkIndex,LinkObject);
						// insert this 'LinkObject' in 'LinkList' CObArray
					}// of if
				}// of for count the number of ComponentDiagram

			} // of if (NetworkName == string)
		} // of for (x->LastNetObject)
		NetPopUp2->DeleteMenu(x,MF_BYPOSITION);
	} // if (string != "")

//************** Component ******************
	int ClickComID = ComPopUp1->TrackPopupMenu(TPM_LEFTALIGN|TPM_RIGHTBUTTON|TPM_RETURNCMD|TPM_NONOTIFY,point.x,point.y,this);
	// Display 'popup' menu to this Dialog at position that defined by 'point'
	//   and return ID of that Popup menu item to 'ClickComID'
	if(ClickComID)
	{
		ComPopUp2->GetMenuString(ClickComID,string,flags);
	}
//*** this statement to show the Diagram that be selected from popup menu
	if (string!="")
	{
		for(int x=0;x<=LastComObjectID;x++)
		{
			CComponentDiagram* ComObject;
			// declare 'ComObject' be pointer to 'CComponentObject' 
			ComObject = (CComponentDiagram *)ComponentList.GetAt(x);
			// get CComponentDiagram Object from 'ComponentList'
			// 'ComponentList'is an Array of Object (CObArray)
			CString ComponentName = *ComObject->GetName();
			// set value of 'ComponentName' to be the value that pointed by 'ComObject->GetName()'		
			if (ComponentName == string)
			{
				ComObject->SetExist(TRUE);
				// set Exist of Network Diagram
				ComObject->Show(this,point);

				CPoint NoExist(-1,-1);
				CStringArray* IpList= new CStringArray();
				// to get the List of Network IP that this component connected
				IpList = ComObject->ListofConnectedNetwork();
				int LastIndex = IpList->GetSize()-1;
				// Do loop until finish the number of Interface Card of this Component
				for (int m=0; m<=LastIndex; m++)
				{
	    			CString theIP = IpList->GetAt(m); 
					int theNetDiagramID;
					CPoint theNetPoint = *GetNetworkPoint(theIP,theNetDiagramID);
					if (theNetPoint!=NoExist)
					{
						CLinkDiagram *LinkObject = new CLinkDiagram(this);
						// create 'LinkObject' be pointer to 'CLinkDiagram' 
						//   to will keep in 'LinkList'(CObArray)
						int LinkIndex = LinkList.GetSize();
						LinkObject->CreateLink(LinkIndex,theNetDiagramID,x,theNetPoint,ComObject->GetPosition());
						//CreateLink(int LinkID,int NetID,int ComID,CPoint NetPos,CPoint ComPos)
						LinkList.InsertAt(LinkIndex,LinkObject);
						// insert this 'LinkkObject' in 'LinkList' CObArray
					} //of if 
				}//of for

			} // of if (ComponentName == string)
		} // of for (x->LastComObject)
	} // if (string != "")
} // of OnContextMenu

// Method to check that 'theIP' exist on the diagram screen?
//    If Yes, then return the CPoint of the NetworkDiagram that is 'theIP' 
//		else if No, then return (-1,-1)
CPoint* CNetworkDiagramDlg::GetNetworkPoint(CString theIP,int& NetDiagramID)
{
	BOOLEAN PointSet=FALSE;
	CPoint NoExist(-1,-1);
	int LastID = NetworkList.GetSize()-1;
	// used to keep the last index of NetworkList.(must -1 because index start at 0)
	for(int i=0;i<=LastID;i++)
	// do loop until reach the number of Network in Network List
	{
	    CNetworkDiagram* theNetObject;
		// declare 'NetObject' be pointer to 'CNetworkObject' 
		theNetObject = (CNetworkDiagram *)NetworkList.GetAt(i);
		if (!PointSet)
		{
			if ((theNetObject->Exist) && (theIP==*theNetObject->GetName()))
			{
				ReturnPoint = theNetObject->GetPosition();
				NetDiagramID = i;
				PointSet = TRUE;
			}
			else 
			{
				ReturnPoint = NoExist;
				// NoExist is the CPoint that be (-1,-1) declare in header
			} // of if
		}
	} // of for
	return &ReturnPoint;
}

// Method to check that 'ComDiagramID' exist on the diagram screen?
//    If Yes, then return the CPoint of the NetworkDiagram that is 'theIP' 
//		else if No, then return (-1,-1)
CPoint* CNetworkDiagramDlg::GetComponentPoint(int ComDiagramID,CString* NetworkName)
{
	BOOLEAN PointSet=FALSE;
	CPoint NoExist(-1,-1);
	CComponentDiagram* ComObject;
	// declare 'ComObject' be pointer to 'CComponentObject' 
	ComObject = (CComponentDiagram *)ComponentList.GetAt(ComDiagramID);
	// get CComponentDiagram Object from 'ComponentList'
	CStringArray* ComIpList= new CStringArray();
	// to get the List of Network IP that this component connected
	ComIpList = ComObject->ListofConnectedNetwork();
	int LastIndex = ComIpList->GetSize()-1;
	// Do loop until finish the number of Interface Card of this Component
	for (int i=0; i<=LastIndex; i++)
	{
	    CString theIP = ComIpList->GetAt(i); 		
		if (!PointSet)
		{
			if ((ComObject->Exist) && (theIP==*NetworkName))
			{
				ReturnPoint = ComObject->GetPosition();
				PointSet = TRUE;
			}
			else 
			{
				ReturnPoint = NoExist;
				// NoExist is the CPoint that be (-1,-1) declare in header
			} // of if
		}// of PointSet
	}// of for
	return &ReturnPoint;
}