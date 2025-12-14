/* Filename : filter.hpp

   Declare Class packetFilter
   "Network Monitoring System" 1998
   written by MANEECHOTE SAMARNTHAI */

class packetFilter
{
   public:
      /*************************
       Class method: filterByIP
       Description:  filter captured frame by IP (may include IP address).
       Parameter:    1. frame that want to filter
		     2. array of char = source IP address 4 bytes
		     3. array of char = destination IP address 4 bytes
       Return:	     int if = 1 this frame is successful.
       *************************/
      int filterByIP(unsigned char[],char[],char[]);

      /*************************
       Class method: filterByIP
       Description:  filter captured frame by IP (may include IP address).
       Parameter:    1. frame that want to filter
		     2. array of char = IP address 4 bytes
       Return:       int if = 1 this frame is successful.
       *************************/
      int filterByIP(int,unsigned char[],char[]);

      /*************************
       Class method: filterByMAC
       Description:  filter captured frame by MAC address
       Parameter:
		     1. frame that want to filter
		     2. array of char = source MAC address 6 bytes
		     3. array of char = destination MAC address 6 bytes
       Return:       int if = 1 this frame is successful.
       *************************/
      int filterByMAC(unsigned char[],char[],char[]);

      /*************************
       Class method: filterByMAC
       Description:  filter captured frame by MAC address
       Parameter:    1. frame that want to filter
		     2. array of char = MAC address 6 bytes

       Return:       int if = 1 this frame is successful.
       *************************/
      int filterByMAC(int,unsigned char[],char[]);

      /* ID of protocol declared by programmer
	 ***** Data Link *****
	 Ethernet 802.3 = 21
	 Ethernet 802.2 = 22
	 EthernetSNAP   = 23
	 EthernetII     = 24
	 ***** Network *****
	 IP   = 31
	 ARP  = 32
	 RARP = 33
	 IPX  = 34
	 ***** Transport *****
	 ICMP = 41
	 TCP = 42
	 UDP = 43
	 SPX = 44 */

      /*************************
       Class method: filterByDtlProtocol
       Description:  filter each Ethernet type(DataLink layer)
       Parameter:
		     1. int = datalink protocol ID declare in NMUTIL.H
		     2. frame that want to filter
       Return:       int if = 1 this frame is successful.
       *************************/
      int filterByDtlProtocol(unsigned char[],int);

      /*************************
       Class method: filterByNetworkProtocol
       Description:  filter protocol on network layer but if you'd like
		     to filter IP you should call filterByIP that can
		     filter IP address.
       Parameter:
		     1. int = network protocol ID declare in NMUTIL.H
		     2. frame that want to filter
       Return:	     int if = 1 this frame is successful.
       *************************/
      int filterByNetworkProtocol(unsigned char[],int);

      /*************************
       Class method: filterByTransportProtocol
       Description:  filter transport protocol include
		     ICMP(Network layer protocol)
       Parameter:
		     1. int = transport protocol ID declare in NMUTIL.H
		     2. frame that want filter
       Return:       int if = 1 this frame is successful.
       *************************/
      int filterByTransportProtocol(unsigned char[],int);

      /*************************
       Class method: filterByPortNumber
       Description:  filter captured frame by port number
       Parameter:
		     1. int = port number that wanted to filter
		     2. frame want to filter
       Return:       int if = 1 this frame is successful.
       *************************/
       int filterByPortNumber(unsigned char[],int);

      /*************************
       Class method: filterBySize
       Description:  filter captured frame by size
       Parameter:    1. frame that want to filter
		     2. integer = Lower bound of size
		     3. integer = Upper bound of size
       Return:       int if = 1 this frame is successful.
       *************************/
      int filterBySize(unsigned char[],unsigned int,unsigned int);
};
