#include "IPCheck.h"

/************************************
**   Function : CountIPFrame(char *,int)
**   Purpose  : Counting IP Frame in IP Logfile
**   Argument : (char *) = IP Logfile, int = log flag 
**   Return   : none
************************************/
void CountIPFrame(char *datafile,int log)
{
   struct IPdata data;
   u_long i;

   i=0;
   if ((fd = open(datafile,O_RDONLY)) < 0 ) {
     perror("Can't open DATA File"); 
     exit(1);
   }
  while (read(fd,&data,sizeof(data)) > 0) {
   i++;
   }
  close(fd);

  if (!flag.log) {    // incase of logging.. open and write in logfile
     sprintf(logfile,"%s/%s",DEFAULT_ALERT_DIR,LogFileName);
 
     if ((logfd = open(logfile,O_CREAT|O_WRONLY|O_APPEND,644)) < 0){
      perror("Can't create PacketCount file\n");
      exit(1);
     } 
    sprintf(dat,"%s : %d Packets\n",datafile,i);
    write(logfd,&dat,strlen(dat));

    close(logfd);
  } else {     // for non logging .. print the result
  printf("\nCounting Packets...\n");
  printf("%s : %d package counted\n\n",datafile,i);
  }

}


/************************************
**   Function : FramePerMin(char *,int) 
**   Purpose  : Check Frame in Logfile Per Minute 
**   Argument : (char *) = IP Log file , int = log flag 
**   Return   : none
************************************/
void FramePerMin(char *datafile,int log)
{

   struct IPdata data;
   int mintmp;
   u_long count;

   strncpy (&hour[0],datafile,2);
   strcpy  (&hour[2],"\0");
   strncpy (&date[0],datafile+3,11);
   strcpy (&date[11],"\0");

   if ((fd = open(datafile,O_RDONLY)) < 0 ) {
     perror("Can't open DATA File"); 
     exit(1);
   }
  mintmp = 10; 
  count = 0;

  printf("Listing Packets per Minute ...\n");

if (!flag.log) {

     sprintf(logfile,"%s/FramePerMin",DEFAULT_ALERT_DIR);

     if ((logfd = open(logfile,O_CREAT|O_WRONLY|O_APPEND,644)) < 0){
      perror("Can't create PacketCount file\n");
      exit(1);
     } 

  while (read(fd,&data,sizeof(data)) > 0) {
    if (mintmp != data.min) {
         sprintf(dat,"%s : %s:%d:00 - %s:%d:59 = %d packets \n ",date,hour
                       ,mintmp,hour,mintmp,count);
         write(logfd,&dat,strlen(dat));
         count = 0;
         mintmp = data.min;
      }
   count++;
   }
  close(logfd);

} else {
  while (read(fd,&data,sizeof(data)) > 0) {
    if (mintmp != data.min) {
         printf("%s : %s:%d:00 - %s:%d:59 = %d packets \n ",date,hour
                       ,mintmp,hour,mintmp,count); 
         count = 0;
         mintmp = data.min;
      }
   count++;
   }
   printf("\n");
}

   close(fd);
}

/************************************
**   Function : FramePerHost(char *,int) 
**   Purpose  : Check Frame in Logfile Per Host 
**   Argument : (char *) = IP Log file ,int = log flag 
**   Return   : none
************************************/
void FramePerHost(char *datafile,int log)
{


   struct {
      u_long host;
      u_long count;
    } database[STD_BUF];

   struct IPdata data;
   int maxindex = 0;
   int count = 0;

   getDateHour(datafile);
   ip = (struct iphdr *)((unsigned long)&data.ip);
   printf ("Counting Packets per Host ...\n");
   if ((fd = open(datafile,O_RDONLY)) < 0 ) {
     perror("Can't open DATA File"); 
     exit(1);
   }

   while (read(fd,&data,sizeof(data)) > 0) {
      
/*     if ip isn't in database then add database;
       else update database;  */
    
    count=0; 
    while (count < maxindex){
       if (database[count].host == ip->daddr) {  // found in database
         database[count].count++;
         break; 
       }
       count++; 
    }
    if (count == maxindex) {            // don't found in database 
        maxindex++; 
        database[count].host = ip->daddr;
        database[count].count = 1;
    }
   }

/*   printdatabase   */

if (!flag.log) {
     sprintf(logfile,"%s/FramePerHost",DEFAULT_ALERT_DIR);
     if ((logfd = open(logfile,O_CREAT|O_WRONLY|O_APPEND,644)) < 0){
      perror("Can't create PacketCount file\n");
      exit(1);
     } 

      sprintf(dat,"%s : %s:00:00 - ",date,hour);
      write(logfd,&dat,strlen(dat));

      sprintf(dat,"%s:59:59\n",hour);
      write(logfd,&dat,strlen(dat));

  for(count=0;count<maxindex;count++)
   {  
      sprintf(dat,"%s := %d package \n",inet_ntoa(database[count].host),database[count].count);
      write(logfd,&dat,strlen(dat));
   }
      sprintf(dat,"\n");
      write(logfd,&dat,strlen(dat));
  close(logfd);

} else {

      printf("%s : %s:00:00 - ",date,hour);
      printf("%s:59:59\n",hour);

for(count=0;count<maxindex;count++)
   {  
      printf("%s := %d package \n",inet_ntoa(database[count].host),database[count].count);
   }
printf("\n");
}
close(fd);
}


