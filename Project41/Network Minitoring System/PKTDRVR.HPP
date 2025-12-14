#ifndef __PKTDRVR_H
#define __PKTDRVR_H  1

#include "pktdef.hpp"

class PktDriver{
	private:
		PKTINFO *pktInfo;
		PKTPARAMS *pktParams;
		PKTSTATISTICS *pktStatistics;

		int pktInt;
		int pktError;
		int pktHandle;
/*   */		int length;
		unsigned char address[6];
		char buffer[1514];
		unsigned char check;

		void ScanForPktDriver();
		void DriverInfo(int intno);                                 /* Function 1 */
		void ShowInfo();
	public:
		PktDriver();		 /* Constructor*/
		void InitPktDriver();
		int AccessType(int if_type,int if_number,char *type,
			       unsigned typelen,int interrupt receiver());  /* Function 2 */
		int ReleaseType(int handle);                                /* Function 3 */
		int SendPacket(char far *buffer,unsigned length);           /* Function 4 */
		int TerminateDriver(int handle);			    /* Function 5 */
		int GetAddress();                                           /* Function 6 */
		int ResetInterface(int handle);				    /* Function 7 */
		void GetParameters();
		int AsSendPkt(char far *buffer,unsigned length,
			      int (far *upcall)); 			    /* Function 11*/
		int SetRCVmode(int handle,int mode);                        /* Function 20 */
		int GetRCVmode(int handle);  	  		  	    /* Function 21 */
		int SetMulticastList(char far *addrlst,int len);            /* Function 22 */
/*incomplete*/  int GetMulticastList ();				    /* Function 23 */
		int GetStatistics (int handle);			            /* Function 24 */
		int SetAddress(char far *addr,int len);                     /* Function 25 */
		int GetHandle();   /* For use this function must call AccessType function first */
		int GetError();
};

#endif
