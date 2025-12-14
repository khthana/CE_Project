#include "Fragment.h"
#include "Analys2.h"

/************************************
**   Function : CheckFlood() 
**   Purpose  : Check Frame to Host Per Sec and WARNING !!
**   Argument : (char *) = IP Log file , int = log flag 
**   Return   : none
************************************/
void CheckFlood()
{
  
  int i;
  for (i=0;i<endindex;i++){
     Fcount = 0;
       while (Fcount < Fendcount){      // found in database;
         if (flood[Fcount].ip == buffer[i].ip) {
            flood[Fcount].count += buffer[i].count;         
            flood[Fcount].end_min = data.min;
            flood[Fcount].end_sec = data.sec;
          break;
          }                
        Fcount++;
       }
       if (Fcount == Fendcount) {        // don't found in database;
         Fendcount++;
         flood[Fcount].ip = buffer[i].ip;
         flood[Fcount].count = buffer[i].count;
         flood[Fcount].start_min = data.min;
         flood[Fcount].start_sec = data.sec;
         flood[Fcount].end_min = data.min;
         flood[Fcount].end_sec = data.sec;
       }

       if (Fendcount == STD_BUF) {
         Fendcount = 0;
         perror("Buffer Overflow in Flood Buffer");

       }

  }
}

/*************************************
** Function : ShowFloodResult()
** Purpose  : Show Data of Flooding 
** Argument : none
** Return   : none
***************************************/
void ShowFloodResult()
{
  

  if (Fendcount > 0){
       if (!flag.log) {
           sprintf(logfile,"%s/%s",DEFAULT_ALERT_DIR,LogFileName);
           if ((logfd = open(logfile,O_CREAT|O_WRONLY|O_APPEND,644)) < 0) {
              perror("Can't create FloodCount File\n");
              exit(1);
           }
    sprintf(dat,"%s : Flood Attack\n",date);
    write(logfd,&dat,strlen(dat));
   for (Fcount = 0;Fcount < Fendcount;Fcount++)
    {
       sprintf(dat,"%s : %s:%d:%d - %s:%d:%d = %d\n"
          ,inet_ntoa(flood[Fcount].ip)
          ,hour,flood[Fcount].start_min,flood[Fcount].start_sec
          ,hour,flood[Fcount].end_min,flood[Fcount].end_sec
          ,flood[Fcount].count);     
       write(logfd,&dat,strlen(dat));
    }
      sprintf(dat,"\n");
      write(logfd,&dat,strlen(dat));
      close(logfd);

   } else {    // if loging

    /*  non logging */

   printf("%s : Flood Attack\n",date);
   for (Fcount = 0;Fcount < Fendcount;Fcount++)
    {
       printf("%s : %s:%d:%d - %s:%d:%d = %d\n"
          ,inet_ntoa(flood[Fcount].ip)
          ,hour,flood[Fcount].start_min,flood[Fcount].start_sec
          ,hour,flood[Fcount].end_min,flood[Fcount].end_sec
          ,flood[Fcount].count);     
    }
   printf("\n");

   }  // else

  Fcount = 0;
  Fendcount = 0;
}
}

