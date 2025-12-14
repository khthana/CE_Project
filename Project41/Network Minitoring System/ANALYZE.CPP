/* Filename : analyze.cpp

   "Network Monitoring System" 1998
   written by MANEECHOTE SAMARNTHAI */

#if !defined(__NMUTIL_H)
#include "nmutil.h"

#include "analyze.hpp"

void packetAnalyzer::usedApp(unsigned char currentFrame[])
{
int portNo;

   portNo=whatPortNumber(currentFrame);
   if(portNo==FTP)
   {
      percentFTP++;
   } else
   if(portNo==TELNET)
   {
      percentTELNET++;
   } else
   if(portNo==SMTP)
   {
      percentSMTP++;
   } else
   if(portNo==GOPHER)
   {
      percentGOPHER++;
   } else
   if(portNo==HTTP)
   {
      percentHTTP++;
   } else
   if(portNo==POP3)
   {
      percentPOP3++;
   } else
   if(portNo==NNTP)
   {
      percentNNTP++;
   } else
   if(portNo==SNMP)
   {
      percentSNMP++;
   } else
   if(portNo==IRC)
   {
      percentIRC++;
   }
}; //End of packetAnalyzer::usedApp

void packetAnalyzer::usedTransport(unsigned char currentFrame[])
{
int transportProtocol;

      transportProtocol=whatProtocolTypeOfTransportLayer(currentFrame);
      if(transportProtocol==ICMP)
      {
	 percentICMP++;
      } else
      if(transportProtocol==TCP)
      {
	 percentTCP++;
      } else
      if(transportProtocol==UDP)
      {
	 percentUDP++;
      } else
      if(transportProtocol==SPX)
      {
	 percentSPX++;
      }
}; //End of packetAnalyzer::usedTransport

void packetAnalyzer::usedNetwork(unsigned char currentFrame[])
{
int networkProtocol;

      networkProtocol=whatProtocolTypeOfNetworkLayer(currentFrame);
      if(networkProtocol==IP)
      {
	 percentIP++;
      } else
      if(networkProtocol==ARP)
      {
	 percentARP++;
      } else
      if(networkProtocol==RARP)
      {
	 percentRARP++;
      } else
      if(networkProtocol==IPX)
      {
	 percentIPX++;
      }
}; //End of packetAnalyzer::usedNetwork

void packetAnalyzer::usedEthernet(unsigned char currentFrame[])
{
int ethernetType;

      ethernetType=whatTypeOfEth(currentFrame);
      if(ethernetType==Eth802_3)
      {
	 percent802_3++;
      } else
      if(ethernetType==Eth802_2)
      {
	 percent802_2++;
      } else
      if(ethernetType==EthSNAP)
      {
	 percentSNAP++;
      } else
      if(ethernetType==EthII)
      {
	 percentII++;
      }
}; //End of packetAnalyzer::usedEthernet

void packetAnalyzer::distributedSize(unsigned char currentFrame[])
{
unsigned int lOrTField;

      lOrTField=twoChar2Int(currentFrame[12],currentFrame[13]);
      if(lOrTField>1500)
      {
	 //this is EthII ,have Type field
	 int netProtocol=whatProtocolTypeOfNetworkLayer(currentFrame);
	 if((netProtocol==IP) || (netProtocol==IPX))
	 {
	    int start=startPointOfNetworkLayer(currentFrame);
	    lOrTField=twoChar2Int(currentFrame[start+2],currentFrame[start+3])+14;
	 } else if((netProtocol==ARP) || (netProtocol==RARP))
	 {
	    lOrTField=42;   //28+14;
	 } else lOrTField=0;
      }
      //lOrTField = length value
      if(lOrTField!=0)
      {
	 if(lOrTField>=60 && lOrTField<=420)
	 {
	    percent60_420++;
	 } else
	 if(lOrTField>=421 && lOrTField<=780)
	 {
	    percent421_780++;
	 } else
	 if(lOrTField>=781 && lOrTField<=1140)
	 {
	    percent781_1140++;
	 } else
	 if(lOrTField>=1141 && lOrTField<=1514)
	 {
	    percent1141_1514++;
	 }
      }
}; //End of packetAnalyzer::distributedSize

/*macAddr* packetAnalyzer::frequentSendingNode(unsigned int numOfFrame,frame* cF)
{
int ctrlLoop;
macAddr sAddress,nodeArray[500];
frame currentFrame;
int i,flag=0,increaser,currentPosition=0;
unsigned int countFrequent[500];

   for(ctrlLoop=0;ctrlLoop<=numOfFrame;ctrlLoop++)
   {
      currentFrame=*(cF+ctrlLoop);
      for(i=0;i<6;i++)
      {
	 sAddress.byte[i]=currentFrame.byte[i+6];
      }
      for(i=0;i<=currentPosition;i++)
      {
	 if((sAddress.byte[0]==nodeArray[i].byte[0]) && \
	    (sAddress.byte[1]==nodeArray[i].byte[1]) && \
	    (sAddress.byte[2]==nodeArray[i].byte[2]) && \
	    (sAddress.byte[3]==nodeArray[i].byte[3]) && \
	    (sAddress.byte[4]==nodeArray[i].byte[4]) && \
	    (sAddress.byte[5]==nodeArray[i].byte[5]))
	 {
	    increaser=i;
	    flag=1;
	    break;
	 }
      }
      if(flag==1)
      {
	 countFrequent[increaser]++;
	 flag=0;
      } else
      {
	 nodeArray[currentPosition]=sAddress;
	 currentPosition++;
      };
   }
   unsigned int maxUsed;
   for(i=0;i<currentPosition;i++)
   {
      if(countFrequent[i]>maxUsed)
      {
	 maxUsed=countFrequent[i];
      }
   }
   int numOfMaxUsedNode=0;
   macAddr maxUsedNode[500];
   //most frequently used node may more than 1
   for(i=0;i<currentPosition;i++)
   {
      if(countFrequent[i]==maxUsed)
      {
	 maxUsedNode[numOfMaxUsedNode]=nodeArray[i];
	 numOfMaxUsedNode++;
      }
   }
   return(maxUsedNode);
}; //End of packetAnalyzer::frequentUsedNode */

void packetAnalyzer::percentUsedNode(unsigned char currentFrame[],char sAddress[],char dAddress[])
{
unsigned int ctrlLoopEx,ctrlLoopIn;
char valid;

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
	 node++;
      }
}; //End of packetAnalyzer::percentUsedNode

void packetAnalyzer::percentUsedNode(int unUsed,unsigned char currentFrame[],char address[])
// 1 address
{
unsigned int ctrlLoopEx,ctrlLoopIn;
char valid,sAddr,dAddr;

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
	 node1Addr++;
      }
}; //End of packetAnalyzer::percentUsedNode (1 address)

void packetAnalyzer::percentUsedPacket(unsigned char currentFrame[],char sAddress[],char dAddress[])
{
char valid;
unsigned int ctrlLoopEx,ctrlLoopIn;
   int beginPoint;
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
	 packet++;
      }
}; //End of packetAnalyzer::percentUsedPacket

void packetAnalyzer::percentUsedPacket(int unUsed,unsigned char currentFrame[],char address[])
// 1 address
{
char valid,sAddr,dAddr;
unsigned int ctrlLoopEx,ctrlLoopIn;
   int beginPoint;
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
	 packet1Addr++;
      }
}; //End of packetAnalyzer::percentUsedPacket (1 address)

float packetAnalyzer::calPercent(float packet,unsigned int all)
{
   return ((packet/all)*100);
}; //End of packetAnalyzer::calPercent

#endif /* __NMUTIL_H */