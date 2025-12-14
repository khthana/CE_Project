#include "Sniff.h"

/*******************************************
** Function : initdevice(char *,int);
** Purpose  : Initialize NIC to Promiscuous Mode
** Argument : device => device name;
**            pflag => flag of mode;
** Return   : Socket ID or exit;
*********************************************/

int
initdevice(device,pflag)
	char *device;
	int pflag;
{
//#define PROTO htons(0x0800)  /* Ethernet Code for IP protocol*/  
#define PROTO htons(0x0003)  /* non-DIX type for all packet */  
	int if_fd=0;
	struct ifreq ifr;

	if ((if_fd=socket(AF_INET,SOCK_PACKET,PROTO)) < 0)  
		{
		perror("Can't get Socket");
		exit(2);
		}
        
	strcpy(ifr.ifr_name,device);               /* interface we use */
	if(ioctl(if_fd,SIOCGIFFLAGS,&ifr) < 0 )   /* get flags */
		{
		close(if_fd);
		perror("Can't get flags");
		exit(2);
		}

	if(pflag)
		ifr.ifr_flags |= IFF_PROMISC;	   /* set promiscuous mode */
	else 
		ifr.ifr_flags &= ~(IFF_PROMISC);

	if (ioctl(if_fd,SIOCSIFFLAGS,&ifr)<0)      /* set flags */
		{
		close(if_fd);
		perror("Can't set flags");
		exit(2);
		}

	return if_fd;

}



/****************************************
** Function : OpenDataFile();
** Purpose  : Open IP file to contain data of IP Packet
** Argument : none
** Return   : none
*****************************************/

void OpenDataFile()
{
      char logfile[STD_BUF];

       time(&t);
       tmptime = localtime(&t)->tm_hour;
       timestr=asctime(localtime(&t));

       strncpy(&buff[0],&timestr[11],2);
       strcpy(&buff[2],"_");
       strncpy(&buff[3],&timestr[8],2);
       if (buff[3] == 0x20) { strcpy(&buff[3],"0");
                              strncpy(&buff[4],&timestr[9],1);  } 
       strcpy(&buff[5],"_"); 
       strncpy(&buff[6],&timestr[4],3);
       strcpy(&buff[9],"_");
       strncpy(&buff[10],&timestr[20],4);
       strcpy(&buff[14],"\0");

       sprintf(logfile,"%s/%s\n",logdir,buff); 
       printf("%s\n",logfile);

	if ((fd_ip=open(logfile,O_CREAT|O_WRONLY|O_APPEND,0644)) < 0){
            perror("Can't create IP datafile\n");
 	    exit(1);
        }

}

/****************************************
** Function : CloseDataFile();
** Purpose  : Close all file  
** Argument : none
** Return   : none
*****************************************/

void CloseDataFile()
{
   close(fd_ip);
}

/****************************************
** Function : ExitProgram();
** Purpose  : Call Close all file and normal exit
** Argument : none
** Return   : none
*****************************************/
void ExitProgram()
{
  initdevice("eth0",0);
  printf("Program Terminated\n");
  CloseDataFile();
  exit(0);
}

/****************************************
** Function : Sniff(int,int,int);
** Purpose  : Grep all packet in the network
** Argument : int for sniff ,verbose ,realtime and host list mode 
** Return   : none
*****************************************/
void Sniff(int sniff,int verbose,int Realtime,int host)
{
        char *timestr;
        int bakmin = 100;
        int lock;
	int if_eth_fd=initdevice("eth0",1);
        signal(SIGINT,ExitProgram);
        signal(SIGTERM,ExitProgram);


        time(&t);
        cookedtime=localtime(&t);
        lock = (cookedtime -> tm_sec + Check) % 60;
        if (!sniff) OpenDataFile();
        if (!Realtime) Initialize();

//
// Start Sniffing
//
	ip=(struct iphdr *)(((unsigned long)&ep.ip)-2);
        eth=(struct ethhdr *)((unsigned long)&ep.eth); 


        for(;;)
	{ 
        bzero(&dest,sizeof(dest));
 	dlen=0;
	FD_ZERO(&rd);
	FD_ZERO(&wr);
	FD_SET(if_eth_fd,&rd);

	timeout.tv_sec=0;
	timeout.tv_usec=0;
	
	while (timeout.tv_sec==0 && timeout.tv_usec==0)
	{
	timeout.tv_sec=10;
	timeout.tv_usec=0;
	select(20,&rd,&wr,NULL,&timeout);

	if (FD_ISSET(if_eth_fd,&rd))
		recvfrom(if_eth_fd,&ep,sizeof(ep),0,&dest,&dlen);
	}

//
//  Get data to file , verbose or Realtime Checking.
//

if (ntohs(ep.eth.h_proto) == ETH_P_IP) {

   if (SearchHost(ip->daddr,host)) {


   time(&t);
   cookedtime=localtime(&t);

    if (!verbose) {
      PrintFrame(cookedtime->tm_hour,cookedtime->tm_min,cookedtime->tm_sec,ep); 
    }

    if (!sniff) {
     KeepData();
    }

   if (!Realtime) {

     data.min = cookedtime->tm_min;
     data.sec = cookedtime->tm_sec; 
     timestr=asctime(localtime(&t));
     strncpy(&hour[0],&timestr[11],2);
     strcpy(&hour[2],"\0");

     strncpy(&date[0],&timestr[0],11);
     strncpy(&date[11],&timestr[20],4);
     strcpy(&date[15],"\0");


     BombCheck();
     if (data.sec == lock) {
        ShowBombResult(data.min,data.sec);
        lock = (data.sec +Check) % 60;
     } 

     Land();
     RealTimeFragChk();

     if (bakmin != data.min) {
          ShowResult();
          ShowLandResult();
          ShowFloodResult();
          bakmin = data.min;
     }

   }  // SearchHost
   }  // if realtime

 } // if eth_p_ip

 } // for

} 



/**************************
** Function : KeepData()
** Purpose  : Keep data to Data file
** Argument : none
** Return   : none
**************************/
void KeepData()
{
        if (cookedtime->tm_hour != tmptime) 
        {
               CloseDataFile();
               OpenDataFile();
	} 	

	if(ep.eth.h_proto==ntohs(ETH_P_IP))
          { 
            write(fd_ip,&cookedtime->tm_sec,sizeof(int));       
            write(fd_ip,&cookedtime->tm_min,sizeof(int));
	    write(fd_ip,ip,sizeof(ep.ip));
	  }

}


/**************************
** Function : PrintFrame(hour,min,sec,IPFrame);
** Purpose  : Show Time and IP Frame
** Argument : Time and IP packet 
** Return   : none
**************************/
void PrintFrame(int hour,int min,int sec,struct etherpacket ep)
{
 if (ntohs(ep.eth.h_proto) == ETH_P_IP) {

 fprintf(stderr,"%d:%d:%d  ",hour,min,sec);
 fprintf (stderr,"%.2x:%.2x:%.2x:%.2x:%.2x:%.2x -> ",
          ep.eth.h_source[0],ep.eth.h_source[1],
          ep.eth.h_source[2],ep.eth.h_source[3],
          ep.eth.h_source[4],ep.eth.h_source[5]);
 fprintf (stderr,"%.2x:%.2x:%.2x:%.2x:%.2x:%.2x \n",
          ep.eth.h_dest[0],ep.eth.h_dest[1],
          ep.eth.h_dest[2],ep.eth.h_dest[3],
          ep.eth.h_dest[4],ep.eth.h_dest[5]);

 fprintf (stderr,"PROTO:%.4x   ",ntohs(ep.eth.h_proto));
 switch (ntohs(ep.eth.h_proto))
 {
 case ETH_P_LOOP :  
                 fprintf (stderr,"Ethernet Loopback Packet");
                 break;
 case ETH_P_ECHO :  
                 fprintf (stderr,"Ethernet Echo Packet");
                 break;
 case ETH_P_PUP :  
                 fprintf (stderr,"Xerox PUP Packet");
                 break;
 case ETH_P_IP :  
                 fprintf (stderr,"Internet Protocal Packet");
                 break;
 case ETH_P_X25 :  
                 fprintf (stderr,"CCITT X.25");
                 break;
 case ETH_P_ARP :  
                 fprintf (stderr,"Address Resolution Packet");
                 break;
 case ETH_P_BPQ :  
                 fprintf (stderr,"G8BPQ AX.25 Ethernet Packet");
                 break;
 case ETH_P_DEC :  
                 fprintf (stderr,"DEC Assigned proto");
                 break;
 case ETH_P_DNA_DL :  
                 fprintf (stderr,"DEC DNA Dump/Load");
                 break;
 case ETH_P_DNA_RC :  
                 fprintf (stderr,"DEC DNA Remote Console");
                 break;
 case ETH_P_DNA_RT :  
                 fprintf (stderr,"DEC DNA Routing");
                 break;
 case ETH_P_LAT :  
                 fprintf (stderr,"DEC LAT");
                 break;
 case ETH_P_DIAG :  
                 fprintf (stderr,"DEC Diagnostics");
                 break;
 case ETH_P_CUST :  
                 fprintf (stderr,"DEC Customer use");
                 break;
 case ETH_P_SCA :  
                 fprintf (stderr,"DEC Systems Comms Arch");
                 break;
 case ETH_P_RARP :  
                 fprintf (stderr,"Reverse Addr Res Packet");
                 break;
 case ETH_P_ATALK :  
                 fprintf (stderr,"Appletalk DDP");
                 break;
 case ETH_P_AARP :  
                 fprintf (stderr,"Appletalk AARP");
                 break;
 case ETH_P_IPX :  
                 fprintf (stderr,"IPX over DIX");
                 break;
 case ETH_P_IPV6 :  
                 fprintf (stderr,"IPv6 over bluebook");
                 break;
 case ETH_P_802_3 :  
                 fprintf (stderr,"802.3 Frames");
                 break;
 case ETH_P_802_2 :  
                 fprintf (stderr,"802.2 Frame");
                 break;
  default : 
                 fprintf (stderr,"*********");
                 break;
 }

 fprintf (stderr,"\n");
} // if
 
 if (ntohs(ep.eth.h_proto) == ETH_P_IP ) { 
 fprintf(stderr,"%s -> ",inet_ntoa(ip->saddr));
 fprintf(stderr,"%s ",inet_ntoa(ip->daddr));
 switch (ip->protocol) 
 {
   case IPPROTO_ICMP:
                      fprintf(stderr," ICMP");
                      break;
   case IPPROTO_TCP:
                      fprintf(stderr," TCP");
                      break;
   case IPPROTO_UDP:
                      fprintf(stderr," UDP");
                      break;
   default : break;  
 }

  fprintf(stderr,"\n");

 fprintf(stderr,"ID:%d  Fragment Offset: 0x%.4X ",htons(ip->id),htons(ip->frag_off) & 0x1fff );
 fprintf(stderr,"Length: 0x%.4X ",ntohs(ip->tot_len));
 if ((htons(ip->frag_off) & 0x4000 ) != 0) {
      fprintf(stderr," [DF]");
 }
 if ((htons(ip->frag_off) & 0x2000 ) != 0) {
      fprintf(stderr," [MF]");
 }

 fprintf(stderr,"\n\n");
} else { 
 //fprintf(stderr,"\n");
}
}

