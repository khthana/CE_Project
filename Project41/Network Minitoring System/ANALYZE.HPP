/* Filename : analyze.hpp

   Declare class packetAnalyzer
   "Network Monitoring System"
   written by MANEECHOTE SAMARNTHAI */

class packetAnalyzer
{
   public:
      /*************************
      Class member
      -- declare public for easily use.
       *************************/

      //used with method usedApp
      float percentFTP;
      float percentTELNET;
      float percentSMTP;
      float percentGOPHER;
      float percentHTTP;
      float percentPOP3;
      float percentNNTP;
      float percentSNMP;
      float percentIRC;

      //used with method usedTransport
      float percentICMP;
      float percentTCP;
      float percentUDP;
      float percentSPX;

      //used with method usedNetwork
      float percentIP;
      float percentARP;
      float percentRARP;
      float percentIPX;

      //used with method usedEthernet
      float percent802_3;
      float percent802_2;
      float percentSNAP;
      float percentII;

      //used with method distributedSize
      float percent60_420;
      float percent421_780;
      float percent781_1140;
      float percent1141_1514;

      //used with method percentUsedNode
      float node;

      //used with method percentUsedNode 1 address
      float node1Addr;

      //used with method percentUsedPacket
      float packet;

      //used with method percentUsedPacket
      float packet1Addr;

      /*************************
       Class method: usedApp
       Description:  seperate each frame by well-known port of
		     APPLICATION LAYER that used
		     1. FTP port 20
		     2. TELNET port 23
		     3. SMTP port 25
		     4. GOPHER port 70
		     5. HTTP port 80
		     6. POP3 port 110
		     7. NEWS port 144
		     8. SNMP port 161
		     9. IRC port 194
       Parameter:
		     1. frame that want to analyze
       Return:       not return anything.
		     But you can get result of this method from class member
		     1. percentFTP
		     2. percentTELNET
		     3. percentSMTP
		     4. percentGOPHER
		     5. percentHTTP
		     6. percentPOP3
		     7. percentNEWS
		     8. percentSNMP
		     9. percentIRC
       *************************/
   void usedApp(unsigned char[]);

      /*************************
       Class method: usedTransport
       Description:  seperate each frame by transport protocol
		     such as
		     1. ICMP
		     2. TCP
		     3. UDP
		     4. SPX
       Parameter:
		     1. frame want to analyze
       Return:       not return anything.
		     But you can get result of this method from class member
		     1. percentICMP
		     2. percentTCP
		     3. percentUDP
		     4. percentSPX
       *************************/
   void usedTransport(unsigned char[]);

      /*************************
       Class method: usedNetwork
       Description:  seperate each frame by network protocol
		     such as
		     1. IP
		     2. ARP
		     3. RARP
		     4. IPX
       Parameter:
		     1. frame want to analyze
       Return:       not return anything.
		     But you can get result of this method from class member
		     1. percentIP
		     2. percentARP
		     3. percentRARP
		     4. percentIPX
       *************************/
   void usedNetwork(unsigned char[]);

      /*************************
       Class method: usedEthernet
       Description:  seperate each frame by ethernet type
		     1. Ethernet 802.3
		     2. Ethernet 802.2
		     3. Ethernet SNAP
		     4. Ethernet II
       Parameter:
		     1. frame want to analyze
       Return:       not return anything.
		     But you can get result of this method from class member
		     1. percent802_3
		     2. percent802_2
		     3. percentSNAP
		     4. percentII
       *************************/
   void usedEthernet(unsigned char[]);

      /*************************
       Class method: distributedSize
       Description:  calculate size in use in many range
       Parameter:
		     1. fram want to analyze
       Return:       not return anything.
		     But you can get result of this method from class member
		     1. percent60_420
		     2. percent421_780
		     3. percent781_1140
		     4. percent1141_1514
       *************************/
   void distributedSize(unsigned char[]);

      /*************************
       Class method: frequentUsedNode
       Description:  find most frequently used nodes
       Parameter:
		     1. frame want to analyze
       Return:
       *************************/
   //macAddr* frequentSendingNode(unsigned int,frame*);

      /*************************
       Class method: percentUsedNode
       Description:  calculate percent the node is used
		     by MAC address
		     1. broadcast
		     2. multicast
		     3. source-destination
       Parameter:
		     1. frame wante to analyze
		     2. char[] = 6 bytes of source address
		     3. char[] = 6 bytes of destination address
			this parameter have default argument = not think
			about it in case of what node generate frame so much
       Return:       float = percent used node
       *************************/
   void percentUsedNode(unsigned char[],char[],char[]);

      /*************************
       Class method: percentUsedNode
       Description:  calculate percent the node is used
		     by MAC address
		     1. broadcast
		     2. multicast
		     3. source-destination
       Parameter:
		     1. frame want to analyze
		     2. char[] = 6 bytes of address
			this parameter have default argument = not think
			about it in case of what node generate frame so much
       Return:       float = percent used node
       *************************/
   void percentUsedNode(int,unsigned char[],char[]);

      /*************************
       Class method: percentUsedPacket
       Description:  calculate percent the packet from or to
		     some address used by IP address
       Parameter:
		     1. frame want to analyze
		     2. char[] = 4 bytes of source address
		     3. char[] = 4 bytes of destination address
       Return:       float = percent used packet
       *************************/
   void percentUsedPacket(unsigned char[],char[],char[]);

      /*************************
       Class method: percentUsedPacket
       Description:  calculate percent the packet from or to
		     some address used by IP address
       Parameter:
		     1. frame want to analyze
		     2. char[] = 4 bytes of address
       Return:       float = percent used packet
       *************************/
   void percentUsedPacket(int,unsigned char[],char[]);

   float calPercent(float,unsigned int);
};