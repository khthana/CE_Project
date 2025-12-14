/*  Flood Checking */
/*  many ID to victim host  */

#include <fcntl.h>
#include <linux/ip.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define STD_BUF 256
#define LogFileName "DoS.log"

struct FloodData
{
  u_long ip;
  u_long count;
  int start_min;
  int start_sec;
  int end_min;
  int end_sec;
};

int Fcount;
int Fendcount;
struct IPdata data;
struct FloodData flood[STD_BUF];

/* Procedure && Function ***************/
void CheckFlood();          // Check Flooding to Host  <per Sec>
void ShowFloodResult();     // Show Data of Flooding
