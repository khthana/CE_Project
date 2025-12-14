/* This is header file in use with "Network Monitoring System" project
   written by MANEECHOTE SAMARNTHAI */

#if !defined(__NMUTIL_H)
#define __NMUTIL_H

/* -----------------------------

   Data structure

   ----------------------------- */

//represent frame
typedef struct
{
   unsigned char byte[1514];
} frame;

typedef struct
{
   unsigned char byte[6];
} macAddr;

/* constant for protocol
   declare by programmer -- MANEECHOTE SAMARNTHAI -- */

//***** Data Link *****
const int Eth802_3=21;
const int Eth802_2=22;
const int EthSNAP=23;
const int EthII=24;
//***** Network *****
const int IP=31;
const int ARP=32;
const int RARP=33;
const int IPX=34;
//***** Transport *****
const int ICMP=41;
const int TCP=42;
const int UDP=43;
const int SPX=44;
//***** Application *****
const int FTP=51;
const int TELNET=52;
const int SMTP=53;
const int GOPHER=54;
const int HTTP=55;
const int POP3=56;
const int NNTP=57;
const int SNMP=58;
const int IRC=59;

/* ----------------------------

   Function

   ---------------------------- */

/****************************
 Function name: twoChar2Int
 Description:   calculate 2 characters to Integer value
 Parameter:     1. unsigned int = higher order character
		2. unsigned int = lower order character
 Return:        unsigned int = Integer value of the characters
 ****************************/
unsigned int twoChar2Int(unsigned int one,unsigned int zero)
{
   one*=256;   // 2^8=256
   one+=zero;
   return(one);
}; //End of twoChar2Int

unsigned int oneChar2Int(unsigned int zero)
{
   return(zero);
}; //End of oneChar2Int

unsigned int fourChar2Int(unsigned int three,unsigned int two,unsigned int one,unsigned int zero)
{
   three*=256*256*256;   // 2^24=2^8*2^8*2^8
   two*=256*256;
   one*=256;
   return(three+two+one+zero);
}; //End of fourChar2Int

/****************************
 Function name: whatTypeOfEth
 Description:   determine what type of frame -> 802.3, 802.2, SNAP, II
 Parameter:     1. char[] = determined frame
 Return:        int = type of frame value equals to declare above
 ****************************/
int whatTypeOfEth(unsigned char currentFrame[])
{
unsigned int typeOrLenF=twoChar2Int(currentFrame[12],currentFrame[13]);
// 12,13 are position of length or type field

   if(typeOrLenF>1500)
   {
      return(EthII);   //this is EthII
   }
   else {
      if((currentFrame[14]==0xFF) && (currentFrame[15]==0xFF))
      {
	 return(Eth802_3);   //this is Eth802.3
      }
      else {
	 if((currentFrame[14]==0xAA) && (currentFrame[15]==0xAA))
	 {
	    return(EthSNAP);
	 } else {
	    return(Eth802_2);
	 }
      }
   }
}; //End of whatTypeOfEth

/****************************
 Function name: startPointOfNetworkLayer
 Description:   find start point of network protocol
 Parameter:     1. char[] = determined frame
 Return:        int = first byte of network protocol in the frame
 ****************************/
int startPointOfNetworkLayer(unsigned char currentFrame[])
{
//return beginPoint
int ctrlLoop,ethType;

   ethType=whatTypeOfEth(currentFrame);
   if(ethType==Eth802_3)   //this is Eth802.3
   {
      return 14;
   } else
   if(ethType==Eth802_2)   //this is Eth802.2
   {
      return 17;
   } else
   if(ethType==EthSNAP)   //this is EthSNAP
   {
      return 22;
   } else
   if(ethType==EthII)   //this is EthII
   {
      return 14;
   }
   return 0;   //never return 0 coz' value return from
	       //whatTypeOfEth in range 1-4
}; //End of startPointOfNetworkLayer

/****************************
 Function name: whatProtocolTypeOfNetworkLayer
 Description:   find network protocol that frame use
 Parameter:     1. char[] = determined frame
 Return:        int = type of frame value equals to declare above
 ****************************/
int whatProtocolTypeOfNetworkLayer(unsigned char currentFrame[])
{
int dtlType=whatTypeOfEth(currentFrame);
   if(dtlType==Eth802_3)
   {
      return(IPX);
   } else
   if(dtlType==Eth802_2)
   {
      if(currentFrame[15]==0x06)   //field SSAP
      {
	 return(IP);
      } else
      if(currentFrame[15]==0xE0) //field SSAP
      {
	 return(IPX);
      }
   } else
   if(dtlType==EthSNAP)
   {
      if(currentFrame[20]==0x08 && currentFrame[21]==0x00)
      {
	 return(IP);
      } else
      if(currentFrame[20]==0x08 && currentFrame[21]==0x06)
      {
	 return(ARP);
      } else
      if(currentFrame[20]==0x80 && currentFrame[21]==0x35)
      {
	 return(RARP);
      } else
      if(currentFrame[20]==0x81 && currentFrame[21]==0x37)
      {
	 return(IPX);
      }
   } else
   if(dtlType==EthII)
   {
      if(currentFrame[12]==0x08 && currentFrame[13]==0x00)
      {
	 return(IP);
      } else
      if(currentFrame[12]==0x08 && currentFrame[13]==0x06)
      {
	 return(ARP);
      } else
      if(currentFrame[12]==0x80 && currentFrame[13]==0x35)
      {
	 return(RARP);
      } else
      if(currentFrame[12]==0x81 && currentFrame[13]==0x37)
      {
	 return(IPX);
      }
   }
   return(0);   //return 0 mean this program don't know
		//that protocol the frame use
}; //End of whatProtocolTypeOfNetworkLayer

/****************************
 Function name: whatProtocolTypeOfTransportLayer
 Description:   find transport protocol the frame use
 Parameter:     1. char[] = determined frame
 Return:        int = type of frame value equals to declare above
 ****************************/
int whatProtocolTypeOfTransportLayer(unsigned char currentFrame[])
{
int start=startPointOfNetworkLayer(currentFrame);
int protocolField=start+9;
int netType=whatProtocolTypeOfNetworkLayer(currentFrame);

   if(netType==IP)
   {
      if(currentFrame[protocolField]==0x01)
      {
	 return(ICMP);
      } else
      if(currentFrame[protocolField]==0x06)
      {
	 return(TCP);
      } else
      if(currentFrame[protocolField]==0x11)   // = decimal 17
      {
	 return(UDP);
      }
   } else
   if(netType==IPX)
   {
      if(currentFrame[start+5]==5)
      {
	 return(SPX);
      }
   }
   return(0);   //return 0 mean this program don't know
		//that protocol the frame use
}; //End of whatProtocolTypeOfTransportLayer

/****************************
 Function name: startPointOfTransportLayer
 Description:   find start byte of transport protocol
 Parameter:     1. char[] = determined frame
 Return:        first byte of transport protocol
		if return 0 = not IP
 ****************************/
int startPointOfTransportLayer(unsigned char currentFrame[])
{
int netProtocol=whatProtocolTypeOfNetworkLayer(currentFrame);

   if(netProtocol==IP)
   {
      int startNet=startPointOfNetworkLayer(currentFrame);
      int IPheader=(currentFrame[startNet] & 0xf) * 4;
      // IPheader=20 byte by default
      return(startNet+IPheader);
   } else {
   return 0;   //not IP
   }
}; //End of startPointOfTransportLayer

/****************************
 Function name: whatPortNumber
 Description:   determine what port the frame use
 Parameter:     1. char[] = determined frame
 Return:        int = type of frame value equals to declare above
		return 0 = not TCP/UDP and not 9 known port
 ****************************/
int whatPortNumber(unsigned char currentFrame[])
{
int startTransport=startPointOfTransportLayer(currentFrame);

   if(startTransport!=0)
   {
      unsigned int sPortValue=twoChar2Int(currentFrame[startTransport],currentFrame[startTransport+1]);
      unsigned int dPortValue=twoChar2Int(currentFrame[startTransport+2],currentFrame[startTransport+3]);
      //+2 = first byte of destination port of both TCP&UDP
      if((sPortValue==20) || (dPortValue==20))
      {
	 return FTP;
      } else
      if((sPortValue==23) || (dPortValue==23))
      {
	 return TELNET;
      } else
      if((sPortValue==25) || (dPortValue==25))
      {
	 return SMTP;
      } else
      if((sPortValue==70) || (dPortValue==70))
      {
	 return GOPHER;
      } else
      if((sPortValue==80) || (dPortValue==80))
      {
	 return HTTP;
      } else
      if((sPortValue==110) || (dPortValue==110))
      {
	 return POP3;
      } else
      if((sPortValue==119) || (dPortValue==119))
      {
	 return NNTP;
      } else
      if((sPortValue==161) || (dPortValue==161))
      {
	 return SNMP;
      } else
      if((sPortValue==194) || (dPortValue==194))
      {
	 return IRC;
      }
   }
   return 0;   // unknown this port or unidentified frame
}; //End of whatPortNumber

#endif