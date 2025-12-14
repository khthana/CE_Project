#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h> 



#define STD_BUF 256
#define HostFile "/etc/isagnid.host"


/**** Structure ****/

struct Hostfix {
  u_long ip;
  u_long count;
};

struct Hostfix hostbuffer[STD_BUF];

int hostflag;                    // 0 if don't have HostFile or 
                                 //   HostFile have none host


int hostcount; 
int hostend;

/**** Procedure & Function ****/
void ReadHostFromFile();
int SearchHost(u_long,int);

