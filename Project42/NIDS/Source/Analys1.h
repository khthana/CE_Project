/*  LAND Checking */
/*  Source and Destination host address is the same */

#include <fcntl.h>
#include <linux/ip.h>
#include <linux/if_ether.h>
#include <netinet/in.h>

#define STD_BUF 256
#define LogFileName "DoS.log"
/***********
** CheckLand Routine
************/
struct IPdata
{
   int min;
   int sec;
   struct iphdr ip;

};

struct LandData
{
   u_long host;
   int count;
   int start_min;
   int start_sec;
   int end_min;
   int end_sec;
   struct ethhdr eth;

};

int Lmaxindex=0;
int Lcount=0;

struct IPdata data;
struct LandData land[STD_BUF];

/* Procedure && Function ***************/
void LANDCheck(char *,int);           // Check Landdrop
void Land();
void ShowLandResult();

