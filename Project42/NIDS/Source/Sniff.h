#include <sys/socket.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <linux/if.h>
#include <linux/socket.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/icmp.h>
#include <linux/udp.h>
#include <linux/if_ether.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include "Fragment.h"

// time in sec modulus this value = Period
// This value can be 1,2,3,4,5,6,10...(60 factor) up to network traffic..
#define Check 3                    // Less than 60
#define PacketLimit 6000           // equal to 2000 * Check 
#define STD_BUF 256
/*  DATA STRUCTURE **************/
struct etherpacket {
	struct ethhdr  eth;
        struct iphdr   ip;
	char  data[8225];
};


/* Variable **********/
        int fd_ip;  //,fd_tcp,fd_udp,fd_icmp; 
        int linktype;
	struct etherpacket ep;
	struct sockaddr dest;
	struct iphdr *ip;
        struct ethhdr *eth; 
        struct tm *cookedtime;
	struct timeval timeout;
	time_t t;
	fd_set rd,wr;
	int dlen,i;
   	char logdir[STD_BUF];
	char buff[30];
	char *timestr;
        int tmptime;


/* PROCEDURE & FUNCTION ************/

int initdevice(char*, int);
void OpenDataFile();
void CloseDataFile();
void Sniff(int,int,int,int);
void PrintFrame(int,int,int,struct etherpacket);
void KeepData();

