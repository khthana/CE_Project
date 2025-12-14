#include "rmonit.h"
#include "Analys1.h"

int i;
/************************************
**   Function : LANDCheck(char *,int )
**   Purpose  : checking Land Drop ( package that source ip = des ip
**   Argument : (char *) = IP Logfile , int = log flag
**   Return   : none
************************************/
void LANDCheck(char *datafile,int log)
{

   getDateHour(datafile);
   ip = (struct iphdr *)((unsigned long)&data.ip);
   if ((fd = open(datafile,O_RDONLY)) < 0 ) {
     perror("Can't open DATA File"); 
     exit(1);
   }

  while (read(fd,&data,sizeof(data)) > 0) {
    Land();
  }

  close(fd);

  ShowLandResult();
}




void Land()
{
    if (ip->saddr == ip->daddr) { 

/*     if ip isn't in buffer then add data in buffer;
       else update buffer;  */

    Lcount = 0;  
    while (Lcount < Lmaxindex){
       if (land[Lcount].host == ip->daddr) {  // found in database
         land[Lcount].count++;
         land[Lcount].end_min = data.min;
         land[Lcount].end_sec = data.sec;
         break; 
       }
       Lcount++; 
    }
    if (Lcount == Lmaxindex) {            // don't found in database 
        Lmaxindex++; 
        land[Lcount].start_min = data.min;
        land[Lcount].start_sec = data.sec;
        land[Lcount].end_min = data.min;
        land[Lcount].end_sec = data.sec;

//        if (Lmaxindex > STD_BUF) Lmaxindex = 0;
//   so .. it don't have queue buffer ... it is only array

        land[Lcount].host = ip->daddr;
        land[Lcount].count = 1;


    } // if

  } // if

}



void ShowLandResult()
{
if (Lmaxindex > 0) {
    if (!flag.log) {                    // in case of logging .. open logfile
       sprintf(logfile,"%s/%s",DEFAULT_ALERT_DIR,LogFileName);
       if ((logfd = open(logfile,O_CREAT|O_WRONLY|O_APPEND,644)) < 0){
           perror("Can't create LANDCount file\n");
           exit(1);
        } 

   sprintf(dat,"%s : LAND Attack\n",date);
   write(logfd,&dat,strlen(dat));

for(Lcount=0;Lcount<Lmaxindex;Lcount++)
   {  
      sprintf(dat," %s : %s:%d:%d-%s:%d:%d = %d\n"
         ,inet_ntoa(land[Lcount].host)
         ,hour,land[Lcount].start_sec,land[Lcount].start_min
         ,hour,land[Lcount].end_sec,land[Lcount].end_min
         ,land[Lcount].count);
      write(logfd,&dat,strlen(dat));
   }
     sprintf(dat,"\n");
     write(logfd,&dat,strlen(dat));
    close(logfd);
} else {                       // Summary to Terminal

   printf("%s : LAND Attack\n",date);
for(Lcount=0;Lcount<Lmaxindex;Lcount++)
   {  
      printf("%s : %s:%d:%d-%s:%d:%d = %d\n"
         ,inet_ntoa(land[Lcount].host)
         ,hour,land[Lcount].start_sec,land[Lcount].start_min
         ,hour,land[Lcount].end_sec,land[Lcount].end_min
         ,land[Lcount].count);
   }

   printf("\n");
}

  Lcount = 0;
  Lmaxindex = 0;
}

}
