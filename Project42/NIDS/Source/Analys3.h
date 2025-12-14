/*   Many Packet Checking */
/*   it has many packet to victim host */

#include <fcntl.h>
#include <linux/ip.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define LimitCount 20000 
#define STD_BUF 256


struct BombStruct 
{
  u_long ip;
  u_long count;
  int start_min;
  int start_sec;
  int end_min;
  int end_sec;
};

int Pcount;
int Pendcount;
struct IPdata data;
struct BombStruct bomb[STD_BUF];

/* Procedure && Function ***************/
