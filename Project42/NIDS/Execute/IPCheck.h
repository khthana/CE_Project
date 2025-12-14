#include "rmonit.h"

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/ip.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define FloodCount 100
#define LogFileName "DoS.log"
/* structure of IP datafile */
struct IPdata  //_ipdata
{
  int sec;
  int min;
  struct iphdr ip;
};

/* Procedure && Function ***************/
void CountIPFrame(char *,int);        // Counting IP Frame in IP Log File
void FramePerMin(char *,int);         // Conting IP Frame Per Minute 
void FramePerHost(char *,int);        // Counting IP Frame Per Host 

