/* Filename : filter.cpp

   "Network Monitoring System" 1998
   written by MANEECHOTE SAMARNTHAI */


#if !defined(__NMUTIL_H)
#include "nmutil.h"

#include "filter.hpp"

int packetFilter::filterByIP(unsigned char currentFrame[],char sAddress[],char dAddress[])
{
char valid;   //represent that frame should be included to filterFrame[]
int ctrlLoopEx,ctrlLoopIn;
   int beginPoint;
      //find IP packet and store it to filterFrame[]
      valid='1';
      beginPoint=startPointOfNetworkLayer(currentFrame);
      if(whatProtocolTypeOfNetworkLayer(currentFrame)!=IP)
      {
	 valid='0';
      }
      //compare Address
      for(ctrlLoopIn=0;ctrlLoopIn<4;ctrlLoopIn++)   //IP address = 4 bytes
      {
	 if(valid!='0')
	 {
	    if(sAddress[ctrlLoopIn]!=currentFrame[ctrlLoopIn+beginPoint+12])
	    {
	       valid='0';   //'0' = false;
	    }
	    if(dAddress[ctrlLoopIn]!=currentFrame[ctrlLoopIn+beginPoint+16])
	    {
	       valid='0';
	    }
	 }
      }
      if(valid!='0')
      {
	 return 1;
      } else return 0;
}; //End of packetFilter::filterByIP

int packetFilter::filterByIP(int unUsed,unsigned char currentFrame[],char address[])
// 1 address
{
char valid,sAddr,dAddr;   //represent that frame should be included to filterFrame[]
int ctrlLoopEx,ctrlLoopIn;
int beginPoint;
      //find IP packet and store it to filterFrame[]
      valid='1';
      sAddr='1';
      dAddr='1';
      beginPoint=startPointOfNetworkLayer(currentFrame);
      if(whatProtocolTypeOfNetworkLayer(currentFrame)!=IP)
      {
	 valid='0';
      }
      //compare Address
      for(ctrlLoopIn=0;ctrlLoopIn<4;ctrlLoopIn++)   //IP address = 4 bytes
      {
	 if(valid!='0')
	 {
	    if(address[ctrlLoopIn]!=currentFrame[ctrlLoopIn+beginPoint+12])
	    {
	       sAddr='0';   //'0' = false;
	    }
	    if(address[ctrlLoopIn]!=currentFrame[ctrlLoopIn+beginPoint+16])
	    {
	       dAddr='0';   //'0' = false;
	    }
	 }
      }
      if((valid!='0') && ((sAddr!='0') || (dAddr!='0')))
      {
	 return 1;
      } else return 0;
}; //End of packetFilter::filterByIP (1 address)

int packetFilter::filterByMAC(unsigned char currentFrame[],char sAddress[],char dAddress[])
{
char valid;
int ctrlLoopEx,ctrlLoopIn;
      valid='1';
      //compare Address
      for(ctrlLoopIn=0;ctrlLoopIn<6;ctrlLoopIn++)
      {
	 if(valid!='0')
	 {
	    if(sAddress[ctrlLoopIn]!=currentFrame[ctrlLoopIn+6])
	    {
	       valid='0';   //'0' = false;
	    }
	    if(dAddress[ctrlLoopIn]!=currentFrame[ctrlLoopIn])
	    {
	       valid='0';   //'0' = false;
	    }
	 }
      }
      if(valid!='0')
      {
	 return 1;
      } else return 0;
}; //End of packetFilter::filterByMAC

int packetFilter::filterByMAC(int unUsed,unsigned char currentFrame[],char address[])
// 1 address
{
char valid,sAddr,dAddr;
int ctrlLoopEx,ctrlLoopIn;
      valid='1';
      sAddr='1';
      dAddr='1';
      //compare Address
      for(ctrlLoopIn=0;ctrlLoopIn<6;ctrlLoopIn++)
      {
	 if(valid!='0')
	 {
	    if(address[ctrlLoopIn]!=currentFrame[ctrlLoopIn+6])
	    {
	       sAddr='0';   //'0' = false;
	    }
	    if(address[ctrlLoopIn]!=currentFrame[ctrlLoopIn])
	    {
	       dAddr='0';   //'0' = false;
	    }
	 }
      }
      if((valid!='0') && ((sAddr!='0') || (dAddr!='0')))
      {
	 return 1;
      } else return 0;
}; //End of packetFilter::filterByMAC (1 address)

int packetFilter::filterByDtlProtocol(unsigned char currentFrame[],int dtlProtocol)
{
int ctrlLoop;
      if(whatTypeOfEth(currentFrame)==dtlProtocol)
      {
	 return 1;
      } else return 0;
}; //End of packetFilter::filterByDtlProtocol

int packetFilter::filterByNetworkProtocol(unsigned char currentFrame[],int netProtocol)
{
int ctrlLoop;
      if(whatProtocolTypeOfNetworkLayer(currentFrame)==netProtocol)
      {
	 return 1;
      } else return 0;
}; //End of packetFilter::filterByNetWorkProtocol

int packetFilter::filterByTransportProtocol(unsigned char currentFrame[],int transportProtocol)
{
int ctrlLoop;
      if(whatProtocolTypeOfTransportLayer(currentFrame)==transportProtocol)
      {
	 return 1;
      } return 0;
}; //End of packetFilter::filterByTransportProtocol

int packetFilter::filterByPortNumber(unsigned char currentFrame[],int portNo)
{
int ctrlLoop;
      int startTransport=startPointOfTransportLayer(currentFrame);
      if(startTransport!=0)  // not IP
      {
	 unsigned int sPortValue=twoChar2Int(currentFrame[startTransport],currentFrame[startTransport+1]);
	 unsigned int dPortValue=twoChar2Int(currentFrame[startTransport+2],currentFrame[startTransport+3]);
	 //+2 = first byte of destination port of both TCP&UDP
	 if((sPortValue==portNo) || (dPortValue==portNo))
	 {
	    return 1;
	 } else return 0;
      }
      return 0;
}; //End of packetFilter::filterByPortNumber

int packetFilter::filterBySize(unsigned char currentFrame[],unsigned int lowerBound=0,unsigned int upperBound=0)
{
int ctrlLoop;
unsigned int lOrTField,lengthFrame;
      lOrTField=twoChar2Int(currentFrame[12],currentFrame[13]);
      if(lOrTField>1500)
      {
	 //this is EthII ,have Type field
	 int netProtocol=whatProtocolTypeOfNetworkLayer(currentFrame);
	 if((netProtocol==IP) || (netProtocol==IPX))
	 {
	    int start=startPointOfNetworkLayer(currentFrame);
	    lengthFrame=twoChar2Int(currentFrame[start+2],currentFrame[start+3])+14;
	 } else if((netProtocol==ARP) || (netProtocol==RARP))
	 {
	    lengthFrame=42;   //28+14
	 } else return 0;

	 if(((lengthFrame<=upperBound) && (lengthFrame>=lowerBound)) || ((lengthFrame>=lowerBound) && (upperBound==0)) || ((lengthFrame<=upperBound) && (lowerBound==0)))
	 {
	    return 1;
	 } else return 0;
      } else
      {
	 //this is Eth802.3,802.2,SNAP ,have length field
	 if(((lOrTField<=upperBound) && (lOrTField>=lowerBound)) || ((lOrTField>=lowerBound) && (upperBound==0)) || ((lOrTField<=upperBound) && (lowerBound==0)))
	 {
	    return 1;
	 } else return 0;
      };
};  //End of packetFilter::filterBySize

#endif /* __NMUTIL_H */