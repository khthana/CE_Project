#include "rmonit.h"
#include "BombCheck.h"

/***********************************
** Function : BombCheck();
** Purpose  : Checking Enomous Packet to host
** Argument : none
** Return   : none
***********************************/
void BombCheck()
{
  int i;
  Bcount = 0;
  while (Bcount < Bendcount) {
     if (BombBuff[Bcount].ip == ip->daddr) {   // Found in Buffer
        BombBuff[Bcount].count++;
        break;
     }
    Bcount++;
  }
  if (Bcount == Bendcount) {
      Bendcount++;
      BombBuff[Bcount].ip = ip->daddr;
      BombBuff[Bcount].count = 1;
  }

 if (Bendcount == BUFSIZE) {
     Bendcount = 0;
     perror ("Buffer Overflow in Bomb Buffer");
 }

}

/****************************
** Function : ShowBombResult()
** Purpose  : Show Bombing Data
** Argument : min and sec in int 
** Return   : none
******************************/
void ShowBombResult(int min,int sec)
{
  if (Bendcount > 0){     
    if (!flag.log) {   // ** if alert to log file 
   
      sprintf(logfile,"%s/%s",DEFAULT_ALERT_DIR,LogFileName);
      if ((logfd = open(logfile,O_CREAT|O_WRONLY|O_APPEND,644)) < 0) {
         perror("Can't create Bombing Alert File\n");
         exit(1);
      }

 //   sprintf(dat,"%s : Many Packet\n",date);
 //   write(logfd,&dat,strlen(dat));

    for (Bcount=0;Bcount<Bendcount;Bcount++)
    {
     if (BombBuff[Bcount].count > PacketLimit) {
       sprintf(dat,"%s : %s : %s:%d:%d = %d [BomB]\n"
         ,date,inet_ntoa(BombBuff[Bcount].ip)
         ,hour,min,sec,BombBuff[Bcount].count);
       write(logfd,&dat,strlen(dat));
     }
    }

//      sprintf(dat,"\n");
//      write(logfd,&dat,strlen(dat));
      close(logfd);


    } else {    // if log

    /* non logging */
//    printf("%s : Many Packet\n",date);
    for (Bcount=0;Bcount<Bendcount;Bcount++)
    {
     if (BombBuff[Bcount].count > PacketLimit) {
       printf("%s : %s : %s:%d:%d = %d [BomB]\n"
         ,date,inet_ntoa(BombBuff[Bcount].ip)
         ,hour,min,sec,BombBuff[Bcount].count);
     }
    }
//    printf("\n");

    }  // else

   Bcount = 0;
   Bendcount = 0;
 
  } // if Bendcount

}



