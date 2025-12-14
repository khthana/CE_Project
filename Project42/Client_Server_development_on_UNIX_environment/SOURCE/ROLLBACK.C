#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <netdb.h>

#define PORT 0x1233 
#define SIZE 8192
char temp_file[]="temp.dat";

main(argc, argv)
int argc;
char *argv[];
 {
   FILE *fp,*fp1,*ftemp,*ftemp_des;
   struct sockaddr_in sin;
   struct sockaddr_in pin;
   char buf[SIZE],x0[15],x1[15],x2[15],x3[15],x4[15],x5[15],x6[15];
   char *ch1,*ch2;
   int i,count,s,ns;
   ch1="1";ch2="1"; 
   count=0;
	if ((s = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
     	perror("tomd: socket");
     	exit(1);
     	}
     bzero(&sin, sizeof(sin));
     sin.sin_family=AF_INET;
     sin.sin_port=htons(PORT);
     sin.sin_addr.s_addr=htonl(INADDR_ANY);

     if (bind(s, (struct sockaddr *) &sin, sizeof(sin)) == -1) {
     	perror("tomd: bind");
     	exit(1);
     	}
     
     if (listen(s, 5) == -1) {
     	perror("tomd: listen");
     	exit(1);
     	}
   
  while(1){
     if ((ns = accept(s, 0, 0)) == -1) {
         perror("tomd: accept");
         exit(1);
     	}
     if(recv(ns,buf,sizeof(buf),0)==-1){
         perror("recv");
         exit(1);
       }
     for(i=0;i<strlen(buf);i++)
      {      
       if(i<4) ch1[i] = buf[i];     
       else ch2[i-4] = buf[i];          
      } 
      fputs(buf,stdout); 
      ftemp=fopen("temp.dat","r+");
                fread(&x1,sizeof(x1),1,ftemp);
                fread(&x2,sizeof(x2),1,ftemp);
        fclose(ftemp);
        fputs(x1,stdout);
        if ((strcmp(ch1,x1))==0) fputs("string ok",stdout);

        ftemp_des=fopen("temp_des.dat","r+");
                fread(&x5,sizeof(x5),1,ftemp_des);
                fread(&x6,sizeof(x6),1,ftemp_des);
        fclose(ftemp_des);

        fp=fopen("balance.dat","r+");
        while(!feof(fp) && (count<2))
        {
                fread(&x3,sizeof(x3),1,fp);
                fseek(fp,50L,SEEK_CUR);
                fread(&x4,sizeof(x4),1,fp);

                if ((strcmp(x1,x3))==0)
                {
                        fputs("ok",stdout);
                        fseek(fp,-15L,SEEK_CUR);
                        fwrite(&x2,sizeof(x2),1,fp);
                        count++;

                }
                else if ((strcmp(x5,x3))==0)
                        {
                        fputs("ok2",stdout);
                        fseek(fp,-15L,SEEK_CUR);
                        fwrite(&x6,sizeof(x6),1,fp);
                        count++;
                        }

        }
        fclose(fp);       
    if(send(ns,"ok",strlen("ok"),0)==-1){
      perror("send");
      exit(1);
     }
    close(ns);
    count=0;   
 }
 close(s);
}
