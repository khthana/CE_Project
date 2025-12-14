/* Filename : fields.cpp

   "Network Monitoring System" 1998
   written by MANEECHOTE SAMARNTHAI */


#if !defined __NMUTIL_H
#include "nmutil.h"

#include <fstream.h>
#include <ctype.h>
#include "fields.hpp"

Fields::Fields(ofstream *fileOutput)
{
   file=fileOutput;
   num=1;
}   // End of constructor

Fields::~Fields()
{
}   // End of destructor

void Fields::realData(unsigned char currentFrame[])
{
   *file << "*** Data section ***" << endl;
   int loop;
   unsigned char c;
   while(count<size)
   {
      for(loop=0;loop<80;loop++)
      {
	 if(count>=size) break;
	 c=currentFrame[count++];
	 c=isprint(c)? c : '.';
	 *file << c;
      }
      *file << endl;
   }
   *file << "--------------------------------------------------------------------------------" << endl;
}   // End of Fields::realData

void Fields::isTCP(unsigned char currentFrame[])
{
   *file << "*** TCP protocol ***" << endl;
   *file << "Source port : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Destination port : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Sequence number : ";
   *file << dec << fourChar2Int(currentFrame[count],currentFrame[count+1],currentFrame[count+2],currentFrame[count+3]) << endl;
   count+=4;
   *file << "Acknowledgement number : ";
   *file << dec << fourChar2Int(currentFrame[count],currentFrame[count+1],currentFrame[count+2],currentFrame[count+3]) << endl;
   count+=4;
   int datOffset;
   *file << "Data offset : ";
   *file << dec << (datOffset=((0xf0 & currentFrame[count++]) >> 4)) << endl;
   // Reserved field not use = 6 bits
   *file << "Control bits" << endl;
   *file << "     " << "URG : " << ((0x20 & currentFrame[count]) >> 5) << endl;
   *file << "     " << "ACK : " << ((0x10 & currentFrame[count]) >> 4) << endl;
   *file << "     " << "PSH : " << ((0x8 & currentFrame[count]) >> 3) << endl;
   *file << "     " << "RST : " << ((0x4 & currentFrame[count]) >> 2) << endl;
   *file << "     " << "SYN : " << ((0x2 & currentFrame[count]) >> 1) << endl;
   *file << "     " << "FIN : " << (0x1 & currentFrame[count++]) << endl;
   *file << "Window : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Checksum : ";
   *file << "0x" << hex << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Urgent pointer : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;

   // may have Option & Padding fields, I get rid of it.
   datOffset-=5;
   count+=datOffset;
   realData(currentFrame);
}   // End of Fields::isTCP

void Fields::isUDP(unsigned char currentFrame[])
{
   *file << "*** UDP protocol ***" << endl;
   *file << "Source port : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Destination port : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Length : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "UDP checksum : ";
   *file << "0x" << hex << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   realData(currentFrame);
}   // End of Fields::isUDP

void Fields::isSPX(unsigned char currentFrame[])
{
   *file << "*** SPX protocol ***" << endl;
   *file << "Connection control : ";
   *file << "0x" << hex << oneChar2Int(currentFrame[count++]) << endl;
   *file << "Datastream type : ";
   *file << "0x" << hex << oneChar2Int(currentFrame[count++]) << endl;
   *file << "Source connection ID : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Destination connection ID : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Sequence number : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Acknowledgement number : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Allocation number : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   realData(currentFrame);
}   // End of Fields::isSPX

void Fields::isICMP(unsigned char currentFrame[])
{
   *file << "*** ICMP protocol ***" << endl;
   int type;
   *file << "Type : ";
   *file << dec << (type=currentFrame[count++]);
   switch(type)
   {
      case 0:
	*file << " (Echo reply)" << endl;
	break;
      case 3:
	*file << " (Destination unreachable)" << endl;
	break;
      case 4:
	if(currentFrame[count]==0)  // code field=0
	{
	   *file << " (Source quench)" << endl;
	} else {
	   *file << " (Unknown type)" << endl;
	}
	break;
      case 5:
	*file << " (Route change request)" << endl;
	break;
      case 8:
	*file << " (Echo request)" << endl;
	break;
      case 9:
	*file << " (Router advertisement)" << endl;
	break;
      case 10:
	*file << " (Router solicitation)" << endl;
	break;
      case 11:
	*file << " (Time exceeded for datagram)" << endl;
	break;
      case 12:
	*file << " (Parameter problem)" << endl;
	break;
      case 13:
	*file << " (Time stamp request)" << endl;
	break;
      case 14:
	*file << " (Time stamp reply)" << endl;
	break;
      case 15:
	*file << " (Information request)" << endl;
	break;
      case 16:
	*file << " (Information reply)" << endl;
	break;
      case 17:
	*file << " (Address mask request)" << endl;
	break;
      case 18:
	*file << " (Address mask reply)" << endl;
	break;
      default:
	*file << " (Unknown type)" << endl;
	break;
   }
   *file << "Code : ";
   *file << dec << (type=currentFrame[count++]) << endl;
   *file << "Checksum : ";
   *file << "0x" << hex << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   realData(currentFrame);
}   // End of Fields::isICMP

void Fields::isIP(unsigned char currentFrame[])
{
   *file << "*** IP protocol ***" << endl;
   *file << "Version : ";
   *file << "0x" << hex << ((0xf0 & currentFrame[count]) >> 4) << endl;
   *file << "Internet Header Length : ";
   int headerLen;
   *file << "0x" << hex << (headerLen=(0xf & currentFrame[count++])) << endl;
   *file << "Type of Service" << endl;
   *file << "     " << "Priority : " << hex << ((0xe0 & currentFrame[count]) >> 5) << endl;
   *file << "     " << "D - flag : " << ((0x10 & currentFrame[count]) >> 4) << endl;
   *file << "     " << "T - flag : " << ((0x8 & currentFrame[count]) >> 3) << endl;
   *file << "     " << "R - flag : " << ((0x4 & currentFrame[count]) >> 2) << endl;
   *file << "     " << "C - flag : " << ((0x2 & currentFrame[count]) >> 1) << endl;
   *file << "     " << "not used : " << (0x1 & currentFrame[count++]) << endl;
   *file << "Total length : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Identification : ";
   *file << "0x" << hex << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Flags" << endl;
   *file << "     Not used : " << ((0x80 & currentFrame[count]) >> 7) << endl;
   *file << "     Do not fragment : " << ((0x40 & currentFrame[count]) >> 6) << endl;
   *file << "     More flag : " << ((0x20 & currentFrame[count]) >> 5) << endl;
   *file << "Fragment offset : ";
   *file << "0x" << hex << twoChar2Int((currentFrame[count] & 0x1f),currentFrame[count+1]) << endl;
   count+=2;
   *file << "Time to live : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
   *file << "Protocol : ";
   int transType;
   *file << "0x" << hex << (transType=currentFrame[count++]);
   switch(transType)
   {
      case 17:  //UDP
	*file << " (UDP)" << endl;
	break;
      case 6:   //TCP
	*file << " (TCP)" << endl;
	break;
      case 1:   //ICMP
	*file << " (ICMP)" << endl;
	break;
      default:
	*file << " (Unknown)" << endl;
	break;
   }
   *file << "Header checksum : ";
   *file << "0x" << hex << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Source IP address : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
   *file << "Destination IP address : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;

   // may have Option & Padding fields, I get rid of it.
   headerLen-=5;
   count+=headerLen;
   switch(transType)
   {
      case 17:  //UDP
	isUDP(currentFrame);
	break;
      case 6:   //TCP
	isTCP(currentFrame);
	break;
      case 1:   //ICMP
	isICMP(currentFrame);
	break;
      default:
	realData(currentFrame);
	break;
   }
}   // End of Fields::isIP

void Fields::isIPX(unsigned char currentFrame[])
{
   *file << "*** IPX protocol ***" << endl;
   *file << "Checksum : ";
   *file << "0x" << hex << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Length : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Transport control : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
   *file << "Packet type : ";
   int type;
   *file << dec << (type=currentFrame[count++]);
   switch(type)
   {
      case 0:
	*file << " (IPX)" << endl;
	break;
      case 4:
	*file << " (IPX)" << endl;
	break;
      case 5:
	*file << " (SPX)" << endl;
	break;
      case 17:
	*file << " (NCP communications)" << endl;
	break;
      default:
	*file << " (Unknown)" << endl;
	break;
   }
   *file << "Destination network address : 0x";
   for(int i=0;i<4;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=4;
   *file << "Destination node address : 0x";
   for(i=0;i<6;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=6;
   *file << "Destination socket : 0x";
   for(i=0;i<2;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=2;
   *file << "Source network address : 0x";
   for(i=0;i<4;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=4;
   *file << "Source node address : 0x";
   for(i=0;i<6;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=6;
   *file << "Source socket : 0x";
   for(i=0;i<2;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=2;

   switch(type)
   {
      case 0:
	isIPX(currentFrame);
	break;
      case 4:
	isIPX(currentFrame);
	break;
      case 5:
	isSPX(currentFrame);
	break;
      default:
	realData(currentFrame);
	break;
   }
}   // End of Fields::isIPX

void Fields::isARP(unsigned char currentFrame[])
{
   *file << "*** ARP protocol ***" << endl;
   *file << "Hardware : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Protocol : ";
   *file << "0x" << hex << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "HLEN : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
   *file << "PLEN : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
   *file << "Operation code : ";
   int code;
   *file << dec << (code=twoChar2Int(currentFrame[count],currentFrame[count+1]));
   count+=2;
   switch(code)
   {
      case 1:
	*file << " (ARP request)" << endl;
	break;
      case 2:
	*file << " (ARP response)" << endl;
	break;
      default:
	*file << " (Unknown type)" << endl;
	break;
   }
   *file << "Sender Hardware Address : 0x";
   for(int i=0;i<6;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=6;
   *file << "Sender Internet Address : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
   *file << "Target Hardware Address : 0x";
   for(i=0;i<6;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=6;
   *file << "Target Internet Address : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
}   // End of Fields::isARP

void Fields::isRARP(unsigned char currentFrame[])
{
   *file << "*** RARP protocol ***" << endl;
   *file << "Hardware : ";
   *file << dec << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "Protocol : ";
   *file << "0x" << hex << twoChar2Int(currentFrame[count],currentFrame[count+1]) << endl;
   count+=2;
   *file << "HLEN : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
   *file << "PLEN : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
   *file << "Operation code : ";
   int code;
   *file << dec << (code=twoChar2Int(currentFrame[count],currentFrame[count+1]));
   count+=2;
   switch(code)
   {
      case 3:
	*file << " (RARP request)" << endl;
	break;
      case 4:
	*file << " (RARP response)" << endl;
	break;
      default:
	*file << " (Unknown type)" << endl;
	break;
   }
   *file << "Sender Hardware Address : 0x";
   for(int i=0;i<6;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=6;
   *file << "Sender Internet Address : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
   *file << "Target Hardware Address : 0x";
   for(i=0;i<6;i++)
   {
      *file << hex << oneChar2Int(currentFrame[count+i]) << " ";
   }
   *file << endl;
   count+=6;
   *file << "Target Internet Address : ";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << ".";
   *file << dec << oneChar2Int(currentFrame[count++]) << endl;
}   // End of Fields::isRARP

void Fields::seperate(unsigned char currentFrame[],unsigned int packet_len)
{
   size=packet_len;
   int ethType=whatTypeOfEth(currentFrame);

   if(ethType==Eth802_3)
   {
      *file << "Frame " << num++ << " :" << endl;
      *file << "*** Ethernet 802.3 ***" << endl;
      *file << "Destination MAC Address : 0x";
      for(int i=0;i<6;i++)
      {
	 *file << hex << oneChar2Int(currentFrame[i]) << " ";
      }
      *file << endl;
      *file << "Source MAC Address : 0x";
      for(i=6;i<12;i++)
      {
	 *file << hex << oneChar2Int(currentFrame[i]) << " ";
      }
      *file << endl;
      *file << "Length field : ";
      *file << dec << twoChar2Int(currentFrame[12],currentFrame[13]) << endl;
      count=14;
      isIPX(currentFrame);
      return;
   } else
   if(ethType==Eth802_2)
   {
      *file << "Frame " << num++ << " :" << endl;
      *file << "*** Ethernet 802.2 ***" << endl;
      *file << "Destination MAC Address : 0x";
      for(int i=0;i<6;i++)
      {
	 *file << hex << oneChar2Int(currentFrame[i]) << " ";
      }
      *file << endl;
      *file << "Source MAC Address : 0x";
      for(i=6;i<12;i++)
      {
	 *file << hex << oneChar2Int(currentFrame[i]) << " ";
      }
      *file << endl;
      *file << "Length field : ";
      *file << dec << twoChar2Int(currentFrame[12],currentFrame[13]) << endl;
      *file << "DSAP : ";
      *file << "0x" << hex << oneChar2Int(currentFrame[14]) << endl;
      *file << "SSAP : ";
      *file << "0x" << hex << oneChar2Int(currentFrame[15]) << endl;
      *file << "Control : ";
      *file << "0x" << hex << oneChar2Int(currentFrame[16]) << endl;
      count=17;
   } else
   if(ethType==EthSNAP)
   {
      *file << "Frame " << num++ << " :" << endl;
      *file << "*** Ethernet SNAP ***" << endl;
      *file << "Destination MAC Address : 0x";
      for(int i=0;i<6;i++)
      {
	 *file << hex << oneChar2Int(currentFrame[i]) << " ";
      }
      *file << endl;
      *file << "Source MAC Address : 0x";
      for(i=6;i<12;i++)
      {
	 *file << hex << oneChar2Int(currentFrame[i]) << " ";
      }
      *file << endl;
      *file << "Length field : ";
      *file << dec << twoChar2Int(currentFrame[12],currentFrame[13]) << endl;
      *file << "DSAP : ";
      *file << "0x" << hex << oneChar2Int(currentFrame[14]) << endl;
      *file << "SSAP : ";
      *file << "0x" << hex << oneChar2Int(currentFrame[15]) << endl;
      *file << "Control : ";
      *file << "0x" << hex << oneChar2Int(currentFrame[16]) << endl;
      *file << "Organization code : ";
      for(i=0;i<3;i++)
      {
	 *file << hex << oneChar2Int(currentFrame[i+17]) << " ";
      }
      *file << endl;
      *file << "Ethernet type : ";
      *file << "0x" << hex << twoChar2Int(currentFrame[20],currentFrame[21]) << endl;
      count=22;
   } else
   if(ethType==EthII)
   {
      *file << "Frame " << num++ << " :" << endl;
      *file << "*** Ethernet II ***" << endl;
      *file << "Destination MAC Address : 0x";
      for(int i=0;i<6;i++)
      {
	 *file << hex << oneChar2Int(currentFrame[i]) << " ";
      }
      *file << endl;
      *file << "Source MAC Address : 0x";
      for(i=6;i<12;i++)
      {
	 *file << hex << oneChar2Int(currentFrame[i]) << " ";
      }
      *file << endl;
      *file << "Type field : ";
      *file << "0x" << hex << twoChar2Int(currentFrame[12],currentFrame[13]) << endl;
      count=14;
   }

   // Eth802_3 not entry here
   int netP=whatProtocolTypeOfNetworkLayer(currentFrame);
   switch(netP)
   {
      case IP:
		isIP(currentFrame);
		break;
      case IPX:
		isIPX(currentFrame);
		break;
      case ARP:
		isARP(currentFrame);
		break;
      case RARP:
		isRARP(currentFrame);
		break;
   }
   return;
}   // End of Fields::seperate

#endif