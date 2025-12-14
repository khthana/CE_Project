#include "rmonit.h"
#include "HostCheck.h"
#include <netinet/in.h>

/**************************
** Function : ReadHostFromFile();
** Purpose  : read host list from file to host buffer 
** Argument : none
** Return   : none
***************************/
void ReadHostFromFile()
{
   FILE *fd;
   char block[18];
   char *num_read;
   struct in_addr in;

   hostend = 0;

   if ((fd = fopen(HostFile,"r")) == NULL) {
   printf("Can't open %s\n",HostFile);
   exit(1);
  }

  while ((num_read = fgets(block,sizeof(block),fd)) != NULL)
  {
    inet_aton(&num_read+1,&in);
    hostbuffer[hostend].ip = in.s_addr;
    hostend++;
  }
  close(fd); 

}


/**********************************
** Function : SearchHost(u_long ip,int hostflag);
** Purpose  : Search IP Address in Host Buffer
** Argument : u_long = ip address 
** Return   : 1 if found , else 0 
************************************/
int SearchHost(u_long ip,int hostflag)
{
   int found;
   found = 1;
   if (!hostflag) {
     found = 0;
     hostcount = 0;
     while (hostcount < hostend)
     {
        if (ip == hostbuffer[hostcount].ip) {
        found = 1;
        break;
        }
        hostcount++;
     } // while
   } // if
  return found;
}



