
/* Packet driver interface classes */
#define	CL_NONE		0
#define	CL_ETHERNET	1
#define	CL_PRONET_10	2
#define	CL_IEEE8025	3
#define	CL_OMNINET	4
#define	CL_APPLETALK	5
#define	CL_SERIAL_LINE	6
#define	CL_STARLAN	7
#define	CL_ARCNET	8
#define	CL_AX25		9
#define	CL_KISS		10
#define CL_IEEE8023	11
#define CL_FDDI 	12
#define CL_INTERNET_X25 13
#define CL_LANSTAR	14
#define CL_SLFP 	15
#define	CL_PPP	        16
#define CL_802.5	17

/* Packet driver function call numbers. From Appendix B. */
#define  DRIVER_INFO		1
#define  ACCESS_TYPE    	2
#define  RELEASE_TYPE		3
#define  SEND_PKT       	4
#define  TERMINATE		5
#define  GET_ADDRESS    	6
#define  RESET_INTERFACE	7
#define  GET_PARAMETERS    	10
#define  AS_SEND_PKT		11
#define  SET_RCV_MODE		20
#define  GET_RCV_MODE		21
#define  SET_MULTICAST_LIST   	22
#define  GET_MULTICAST_LIST	23
#define  GET_STATISTICS    	24
#define  SET_ADDRESS		25

/* Packet driver error return codes. From Appendix C. */
#define	NO_ERROR	0
#define	BAD_HANDLE	1	/* invalid handle number */
#define	NO_CLASS	2	/* no interfaces of specified class found */
#define	NO_TYPE		3	/* no interfaces of specified type found */
#define	NO_NUMBER	4	/* no interfaces of specified number found */
#define	BAD_TYPE	5	/* bad packet type specified */
#define	NO_MULTICAST	6	/* this interface does not support multicast */
#define	CANT_TERMINATE	7	/* this packet driver cannot terminate */
#define	BAD_MODE	8	/* an invalid receiver mode was specified */
#define	NO_SPACE	9	/* operation failed because of insufficient space */
#define	TYPE_INUSE	10	/* the type had previously been accessed, and not released */
#define	BAD_COMMAND	11	/* the command was out of range, or not	implemented */
#define	CANT_SEND	12	/* the packet couldn't be sent (usually	hardware error) */
#define CANT_SET	13	/* hardware address couldn't be changed (> 1 handle open) */
#define BAD_ADDRESS	14	/* hardware address has bad length or format */
#define CANT_RESET	15	/* couldn't reset interface (> 1 handle open) */

#define	CARRY       	1
#define ANYTYPE         0xFFFF

#define REGISTERS       unsigned bp,unsigned di,unsigned si,unsigned ds,unsigned es,unsigned dx,unsigned cx,unsigned bx,unsigned ax,unsigned ip,unsigned cs,unsigned flags

const int BROARDCAST[6]={0xFF,0xFF,0xFF,0xFF,0xFF,0xFF};
const int UNKNOWADDRESS[6]={0,0,0,0,0,0};

#define IntFirst 0x60
#define IntLast  0x7E

/*#define IP 			0x0800
#define ARP 			0x0806
#define HP 			0x8005
#define ICMP			1
#define IGMP			2
#define TCP			6
#define UDP			17*/



//typedef unsigned char  byte;      /*  8 bits */
//typedef unsigned int   word;      /* 16 bits */
//typedef unsigned long  longword;  /* 32 bits */

typedef struct{
	unsigned int Version;
	unsigned char Class;
	unsigned int Type;
	unsigned char Number;
	char far *Name;
	unsigned char Functionality;
}PKTINFO;

typedef struct{
	unsigned char  major_rev;         //major revision ID of packet driver specification to which driver conforms
	unsigned char  minor_rev;         //minor revision ID of packet driver specification
	unsigned char  length;		  //length of structure in bytes
	unsigned char  addr_len;          //length of MAC-layer address
	unsigned short mtu;               //maximum transfer unit,including MAC headers
	unsigned short multicast_aval;    //buffer size for multicast addr
	unsigned short rcv_bufs;	  //number of receive buffers (one less than back-to-back MTU receivers)
	unsigned short xml_bufs;          //number of transmit buffers
	unsigned short int_num;           //interrupt number to hook for post-EOI processing,00h=none
}PKTPARAMS;

typedef struct{
	unsigned long  packets_in;
	unsigned long  packets_out;
	unsigned long  bytes_in;
	unsigned long  bytes_out;
	unsigned long  errors_in;
	unsigned long  errors_out;
	unsigned long  packets_lost;
}PKTSTATISTICS;

/***********************************************************************/
typedef struct {
    unsigned int contentlength;		  // longueur des donnees d'une trame
    unsigned char src[7];	  // adresse source
    unsigned char dest[7];	  // adresse destination
    unsigned int type;			  // type ou longueur
//    unsigned char content[1501];  // les donnees
}ETHFRAME;

typedef struct {
    unsigned int version;
    unsigned int IPHeaderLength;
    unsigned int TypeOfService;
    unsigned int SizeOfDatagram;
    unsigned int identification;
    int flags;
    unsigned int fragmentationOffset;
    int ttl;
    int protocol;
    int headerchecksum;
    unsigned char src[5];
    unsigned char dest[5];
//    unsigned char content[1481];
}IPFRAME;

typedef struct{
    unsigned int srcport;
    unsigned int destport;
    unsigned long seqnumber;
    unsigned long acknumber;
    char headerlength;
    char flags;
    unsigned int windowsize;
    unsigned int tcpchecksum;
    unsigned int urgentpointer;
//    unsigned char content[1461];
}TCPFRAME;

typedef struct {
    unsigned int srcport;
    unsigned int destport;
    unsigned int udplength;
    unsigned int udpchecksum;
//    unsigned char content[1461];
}UDPFRAME;



/***********************************************************************/
static char *Error[]={
	"BAD HANDLE",
	"NO CLASS",
	"NO TYPE",
	"NO NUMBER",
	"BAD TYPE",
	"NO MULTICAST",
	"CANT TERMINATE",
	"BAD MODE",
	"NO SPACE",
	"TYPE INUSE",
	"BAD COMMAND",
	"CANT SEND",
	"CANT SET",
	"BAD ADDRESS",
	"CANT RESET"
};

static char *Pkt_Sig="PKT DRVR";
static char *Class[]={
	"Unknown Class (0)",
	"Ethernet/IEEE 802.3 (1h)",
	"ProNET-10 (2h)",
	"IEEE 802.5/ProNET-4 (without expanded RIFs) (3h)",
	"Omninet (4h)",
	"Appletalk (5h)",
	"Serial Line (6h)",
	"StarLAN (subsumed by Ethernet class) (7h)",
	"ARCnet (8h)",
	"AX.25  (9h)",
	"KISS (0Ah)",
	"IEEE 802.3 with 802.2 headers (0Bh)",
	"FDDI with 802.2 headers (0Ch)",
	"Internet X.25 (0Dh)",
	"N.T. LANSTAR (encapsulating DIX Ethernet) (0Eh)",
	"SLFP(MIT serial specification) (0Fh)",
	"PPP (Point-to-Point Protocaol) (10h)",
	"802.5 with expanded RIFs (11h)",
	"reserved for LCP/NCPs (12h)"
};


