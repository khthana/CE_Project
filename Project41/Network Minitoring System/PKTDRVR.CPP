/*******************************************************************************
**   FileName: PktDrvr.cpp
**   Description: Turbo C++  Object to interface with Crynrware
**		  packet drivers.
** ----------------------------------------------------------
**   Compiler: Turbo C++ Version 3.0  Borland International.
**   Last Edit: 4-April-1999
**   OS-Version: MS-DOS 6.0
**   Version: 1.04  Build 1204
** ----------------------------------------------------------
**   Author : Thanathip Tharavanich (Luisekm)
**
**   Email  : luisekm75@hotmail.com
**            luisekm@gang4d.com
**
**   Copyright: (C) 1999 LuiseKm.
**
**   Released to public domain.
**   The author can not be held responsible for any damages resulting
**   from the use of this software.
*******************************************************************************/

#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <dos.h>
#include "pktdrvr.hpp"

/*************************************************************************
**  Constructor PktDriver
**  Description: Set pktError=0  ** assume it had not error
**				 ** it had error when carry flag was set
**               Set check=0     ** 0: for not enter DriverInfo function
**		                 ** 1: for enter DriverInfo function
*************************************************************************/
PktDriver::PktDriver(){
	pktError=0;
	check=0;
}

/*************************************************************************
**  Function: void DriverInfo(int intno)
**  Description: - Returns some information on the assigned packet driver
**		   at intno interrupt number
**		 - Fill PKTINFO struct
**
**  Input : int intno  interrupt number
**
**  Output: none
**************************************************************************/
void PktDriver::DriverInfo(int intno){
	union REGS regs;
	struct SREGS sregs;

	regs.h.ah=DRIVER_INFO;
	regs.h.al=255;
	int86x(intno,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){
		pktError=regs.h.dh;
	}
	else{
		pktInfo->Name=(char far *)MK_FP(sregs.ds,regs.x.si);
		pktInfo->Version=regs.x.bx;
		pktInfo->Class=regs.h.ch;
		pktInfo->Type=regs.x.dx;
		pktInfo->Number=regs.h.cl;
		pktInfo->Functionality=regs.h.al;
	}
	check=1;
}

/*************************************************************************
**  Function: int AccessType(int if_type,int if_number,
**			     char *type,unsigned typelen,int interrupt (*receiver)())
**  Description:  - Accesses the packet driver.
**		  - Starts reception of type packets from device driver.
**                - Initiates reception of packets of specified
**                  type to receive function <receiver>,
**                  You can select a device number from 0 to 3.
**
**		    If <type>=NULL and <typelen>=0, ALL packets
**                  will be received.
**
**
**  Input : int if_type   interface type    # 0xffff   anytype ,we don't care whose it is
**	    int if_number interface number  # 0        we want the first piece of hardware
**          char *type  		    # pointer to Type string or NULL
**          unsigned typelen                # length of type (0000h for all packets)
**                                          # length of Type string or 0
**          int interrupt (*receiver)       # pointer to receiver function
**
**  Output: pktHandle
*************************************************************************/
int PktDriver::AccessType(int if_type,int if_number,char *type,unsigned typelen,int interrupt (*receiver)()){

	union REGS regs;
	struct SREGS sregs;

	segread(&sregs);
	regs.h.ah=ACCESS_TYPE;              // 2
	regs.h.al=pktInfo->Class;           // Class
	regs.x.bx=if_type;                  // Type
	regs.h.dl=if_number;                // Number
	sregs.ds=FP_SEG(type);              // DS:SI->type ,packet type template
	regs.x.si=FP_OFF(type);             //
	regs.x.cx=typelen;		    // Length of type
	sregs.es=FP_SEG(receiver);          // ES:DI->receiver ,address of receiver handler
	regs.x.di=FP_OFF(receiver);         //
	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){          // possible errors:
		pktError=regs.h.dh;         //          NO_CLASS
	}                                   //          NO_TYPE
	else {                              //          NO_NUMBER
		pktHandle=regs.x.ax;        //          BAD_TYPE
	}                                   //          NO_SPACE
					    //          TYPE_INUSE
	return (pktHandle);
}

/*************************************************************************
**  Function: int ReleaseType(int handle)
**  Description: - Release a specific type handle.
**               - Ends reception of type packets from device
**                 driver.
**
**  Input : int handle
**
**  Output: 0 if successful (CF clear)
*************************************************************************/
int PktDriver::ReleaseType(int handle){
	union REGS regs;
	struct SREGS sregs;

	regs.h.ah=RELEASE_TYPE;               // 3
	regs.x.bx=handle;
	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){           // possible errors:
		pktError=regs.h.dh;          //          BAD_HANDLE
	}else{
		pktError=0;
	}
	return 0;
}

/*************************************************************************
**  Function: int SendPacket(char far *buffer,unsigned length)
**  Description: - Send a data packet by accessing the packet driver.
**   		 - Transmits <length> bytes of data, starting at
**                 <buffer>.  The application must supply the
**		   entire packet, including network headers.
**
**                 For example Ethernet:
**		          12 bytes Dest,12 bytes Src,2 bytes type.
**
**
**  Input : char far *buffer - Pointer to send data buffer.
**	    unsigned length  - Bytes to send.
**  Output: 0 if successful (CF clear)
*************************************************************************/
int PktDriver::SendPacket(char far *buffer,unsigned length){

	union REGS regs;
	struct SREGS sregs;

	segread(&sregs);
	regs.h.ah=SEND_PKT;                   // 4
	sregs.ds=FP_SEG(buffer);              // DS:SI->buffer
	regs.x.si=FP_OFF(buffer);
	regs.x.cx=length;
	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){           // possible errors :
		pktError=regs.h.dh;          //          CANT_SEND
	}else{
		pktError=0;
	}
	return 0;
}

/*************************************************************************
**  Function: int TerminateDriver(int handle)
**  Description: - Terminates the device driver associated with pktHandle
**                 If possible, the driver will exit and allow
**                 MS_DOS to reclaim its memory.
**
**
**  Input : int handle
**  Output: 0 if successful (CF clear)
*************************************************************************/
int PktDriver::TerminateDriver(int handle){

	union REGS regs;
	struct SREGS sregs;

	regs.h.ah=TERMINATE;                  // 5
	regs.x.bx=handle;
	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){           //  possible errors :
		pktError=regs.h.dh;          //          BAD_HANDLE
	}else{                               //          CANT_TERMINATE
		pktError=0;
	}
	return 0;
}

/************************************************************************
**  Function: int GetAddress()
**  Description: - Gets the hardware address from the driver.
**		 - or Copy the local net address associated with the handle into
**                 the specified buffer.
**  Input :  none
**
**  Output: - 0 if successful (CF clear)
**          - CX = length
**	    - ES:DI->buffer filled
*************************************************************************/
int PktDriver::GetAddress(){

	union REGS regs;
	struct SREGS sregs;

	segread(&sregs);
	regs.h.ah=GET_ADDRESS;                // 6
//	regs.x.bx=handle;
	sregs.es=FP_SEG(address);             // ES:DI -> buffer for address
	regs.x.di=FP_OFF(address);
	regs.x.cx=6;
	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){           // possible errors :
		pktError=regs.h.dh;          //           BAD_HANDLE
	}else{                               //           NO_SPACE
		pktError=0;
	}
	return 0;
}

/*************************************************************************
**  Function: int ResetInterface(int handle)
**  Description: - Resets device driver.
**               - Aborts any transmits in process.
**               - Reinitializes the receiver.
**
**  Input : int handle
**
**  Output: 0 if successful (CF clear)
**************************************************************************/
int PktDriver::ResetInterface(int handle){

	union REGS regs;
	struct SREGS sregs;

	segread(&sregs);
	regs.h.ah=RESET_INTERFACE;            // 7
	regs.x.bx=handle;
	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){           // possible errors :
		pktError=regs.h.dh;          //         BAD_HANDLE
	}else{                               //         CANT_RESET
		pktError=0;
	}
	return 0;
}

/*************************************************************************
**  Function:  void GetParameters()
**  Description: - Gets specification parameters from the driver.
**  		   Not all drivers support this function.
**
**  Input : none
**
**  Output: if successful (CF clear)
**          	ES:DI -> parameter table
**          else error code
**
*************************************************************************/
void PktDriver::GetParameters(){

	union REGS regs;
	struct SREGS sregs;

	regs.h.ah=GET_PARAMETERS;             // 10
	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){            // possible errors:
		pktError=regs.h.dh;           //        BAD_COMMAND
	}
	else{                  		      // If Successful return ES:DI->param table
		pktParams=(PKTPARAMS *)MK_FP(sregs.es,regs.x.di);
	}
}

/*****************************************************************************
**   ##################   HIGH-PERFORMANCE DRIVER FUNCTION   #################
**
**
**  Function:  int AsSendPkt(char far *buffer,unsigned length,int (far *upcall))    ** Function 11
**  Description: - Sends a data packet by accessing the packet driver.
**		   Upcall is called when order was placed.
**
**
**  Input : char far *buffer        #
**	    but ES:DI->Far function to call when buffer becomes available.
**  Output: if successful (CF clear)
**          else error code
**
***************************************************************************/
int PktDriver::AsSendPkt(char far *buffer,unsigned length,int (far *upcall)){ /* Function 11*/

	union REGS regs;
	struct SREGS sregs;


	regs.h.ah=AS_SEND_PKT;                // 11
	regs.x.cx=length;
	sregs.ds=FP_SEG(buffer);
	regs.x.si=FP_OFF(buffer);
	sregs.es=FP_SEG(upcall);
	regs.x.di=FP_OFF(upcall);

	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){            // possible errors :
		pktError=regs.h.dh;           //         CANT_SEND      transmit error , re-entered,etc.
	}                                     //         BAD_COMMAND    Level 0 or 1 driver
	return 0;
}

/*************************************************************************
**  #####################   EXTENDED DRIVER FUNCTION   ###################
**
**  Function:  int SetRCVmode(int handle,int mode)    // Function 20
**  Description: - Sets the receiver mode of the driver.
**	         - For meaning of mode see "packet_d.109"
**  		 - Selects receive mode of type filter.
**                	(1)  turn off receiver
**                	(2)  receive IF address packets only
**                	(3)  mode 2 + broadcasts
**                	(4)  mode 3 + limited multicasts
**                	(5)  mode 3 + all multicasts
**                	(6)  all packets
**              note: most packet drivers support mode 3 only.
**  Input : int handle
**          int mode
**  Output: if successful (CF clear)
**          else error code
**
**************************************************************************/
int PktDriver::SetRCVmode(int handle,int mode){

	union REGS regs;
	struct SREGS sregs;

	regs.h.ah=SET_RCV_MODE;               // 20
	regs.x.bx=handle;
	regs.x.cx=mode;

	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){           // possible errors :
		pktError=regs.h.dh;          //             BAD_HANDLE
	}                                    //            BAD_MODE
	return 0;
}

/*************************************************************************
**  #####################   EXTENDED DRIVER FUNCTION   ###################
**
**  Function:  int GetRCVmode(int handle,int mode)    ** Function 21
**  Description: - Gets the receiver from the driver.
**	           For meaning of mode see "packet_d.109"
**
**
**  Input : int handle
**
**  Output: if successful (CF clear)
**          return mode
**
**          else error code
**
**************************************************************************/
int PktDriver::GetRCVmode(int handle){

	union REGS regs;
	struct SREGS sregs;

	regs.h.ah=GET_RCV_MODE;             // 21
	regs.x.bx=handle;

	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){          // possible errors:
		pktError=regs.h.dh;         //          BAD_HANDLE
	}else{
		pktError=0;
	}
	return (regs.x.ax);
}

/*************************************************************************
**  #####################   EXTENDED DRIVER FUNCTION   ###################
**
**  Function:  int SetMulticastList (char far *addrlst,int len)    ** Function 22
**  Description: - Assigns a multicast list to the drivers.
**
**  Input : int handle
**
**  Output: if successful (CF clear)
**          return   - int len   CX
**                   - char far *addrlst  ES:DI;
**
**          else error code
**
***************************************************************************/
int PktDriver::SetMulticastList(char far *addrlst,int len){

	union REGS regs;
	struct SREGS sregs;


	regs.h.ah=SET_MULTICAST_LIST;                   // 22
	regs.x.cx=len;
	sregs.es=FP_SEG(addrlst);
	regs.x.di=FP_OFF(addrlst);

	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){                     // possible errors :
		pktError=regs.h.dh;                    //             NO_MULTICAST
	}else{                                         //            NO_SPACE
		pktError=0;                            //            BAD_ADDRESS
	}

	return 0;
}

/**************************************************************************
**  #####################   EXTENDED DRIVER FUNCTION   ###################
**
**  Function:  int GetMulticastList ()    			** Function 23
**  Description: - Retrives a pointer to a multicastlist.
**
**  Input : none
**
**  Output: If successful (CF clear)
**	    return   - int len   CX
**                   - char far *addrlst  ES:DI;
**
***************************************************************************/
int PktDriver::GetMulticastList(){

	union REGS regs;
	struct SREGS sregs;


	regs.h.ah=GET_MULTICAST_LIST;			// 23

	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){                      // possible errors :
		pktError=regs.h.dh;                     //            NO_MULTICAST
	}else{                                          //            NO_SPACE
		pktError=0;
	}
	return 0;
}

/*************************************************************************
**  #####################   EXTENDED DRIVER FUNCTION   ###################
**
**  Function:  int GetStatistics (int handle)    			** Function 24
**  Description: - Retrives statistics about received and sent packet
**	           ,bytes,errors.
**               - Gets pointer to device driver's stat structure.
**  Input : int handle
**
**  Output: If successful (CF clear)
**	    return   - int len   CX
**                   - char far *addrlst  ES:DI;
**
***************************************************************************/
int PktDriver::GetStatistics(int handle){

	union REGS regs;
	struct SREGS sregs;


	regs.h.ah=GET_STATISTICS;                       // 24
	regs.x.bx=handle;

	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){                     // possible errors :
		pktError=regs.h.dh;                    //             BAD_HANDLE
	}else{
		pktError=0;
	       _fmemcpy(pktStatistics,(PKTSTATISTICS *)MK_FP(sregs.ds,regs.x.si),sizeof(PKTSTATISTICS)-1);
	}
	return 0;
}

/**************************************************************************
**  #####################   EXTENDED DRIVER FUNCTION   ###################
**
**  Function:  int SetAddress (char far *addr,int len)    			** Function 25
**  Description: -
**
**  Input : char far *addr
**          int len
**
**  Output: If successful (CF clear)
**	    return   - int length   CX
**
***************************************************************************/
int PktDriver::SetAddress(char far *addr,int len){

	union REGS regs;
	struct SREGS sregs;

	regs.h.ah=SET_ADDRESS;                          // 25
	regs.x.cx=len;
	sregs.es=FP_SEG(addr);
	regs.x.di=FP_OFF(addr);

	int86x(pktInt,&regs,&regs,&sregs);

	if (regs.x.cflag & CARRY){                     // possible errors :
		pktError=regs.h.dh;                    //            CANT_SET
	}else{                                         //            BAD_ADDRESS
		pktError=0;
		length=regs.x.cx;
	}
	return 0;
}

/**************************************************************************
**  Function: int GetHandle()
**  Description: - Returns the accessed handle.
**
**  Input : none
**
**  Output: none
*************************************************************************/
int PktDriver::GetHandle(){
	return (pktHandle);
}

/**************************************************************************
**  Function: int GetError()
**  Description: - Returns error messages.
**
**  Input : none
**
**  Output: none
*************************************************************************/
int PktDriver::GetError(){
	return pktError;
}

/**************************************************************************
**  Function: void ScanForPktDriver()
**  Description: - Scans interrupts (0x60-0x7e) for packet driver.
**               - Find and Compare Pkt_Sig ("PKT DRVR") , if ok,call
**                 DriverInfo() function to fill information at that pktInt
**		 - register pktInt
**               - Stop if it has found a valid driver.
**               - if intno out of range 0x60-0x7e , Display "No Packet Found"
**
**  Input : none
**
**  Output: none
**************************************************************************/
void PktDriver::ScanForPktDriver(){
	char far *temp;

	printf("Initializing packet driver ");
	for (int i=0;i<6;i++){
		delay(220);
		printf(".");
	}

	for (int intno=IntFirst;intno<=IntLast;intno++){
		temp=(char far*)getvect(intno);
		if (!_fmemcmp(&temp[3],Pkt_Sig,strlen(Pkt_Sig))){
			DriverInfo(intno);
			pktInt=intno;
			break;
		}
	}

	if (intno>IntLast){
		printf("\n\nNo Packet Driver Found !!\n\n");
	}
}

/**************************************************************************
**  Function: void ShowInfo()
**  Description: - Show Error message if packet driver installed has error.
**               - Show packet driver int. , version , name , class ,type
**		   and funtionality.
**               - Show MAC Address.
**
**  Input : none
**
**  Output: none
**************************************************************************/
void PktDriver::ShowInfo(){

	if ((pktError>0) && (pktError<=15) && check){
		printf("Packet Driver Error : %s",Error[pktError]);
	}
	else if (check){
		printf("\n\nPacket driver for %Fs.com ",_fstrlwr(pktInfo->Name));
		printf(",version %d\n",pktInfo->Version);
		printf("Packet driver software interrupt is 0x%02xh (%d)\n",pktInt,pktInt);
		printf("Class: %s\n",Class[pktInfo->Class]);
		printf("Type: %xh (%d)\n",pktInfo->Type,pktInfo->Type);
		printf("Number: %d\n",pktInfo->Number);
		printf("Status:  ");

		switch (pktInfo->Functionality)
		{
			case 1:    printf("Basic\n"); break;
			case 2:    printf("Basic and Extended\n"); break;
			case 5:    printf("Basic and High-performance"); break;
			case 6:    printf("Basic,High-performance and Extended"); break;
			case 255:  printf("Not Installed\n"); break;
			default:   printf("Unknown\n");
		}
		//  Show MAC Address
		if (!GetAddress())
			printf("My Ethernet Address = %02X:%02X:%02X:%02X:%02X:%02X\n",address[0],address[1],address[2],address[3],address[4],address[5]);
	}
}

/**************************************************************************
**  Function: void InitPktDriver()
**  Description: -Initializes the PKT library functions.
**               - Call ScanForPktDriver() for scan packet driver.
**               - Call Show() for show information of packet driver.
**
**  Input : none
**
**  Output: none
**************************************************************************/
void PktDriver::InitPktDriver(){
	ScanForPktDriver();
	ShowInfo();
}

// ----------------------------------- END -------------------------------------