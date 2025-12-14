#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void CalAveConnect(void);

main()
{	FILE *fwtmp,*fh,*fuser;
	char str[80],usr[8],host[16],connect[7],filename[12];
	char usr_t[10],host_t[18]; 
	char *str1,*usr_t1,*host_t1; 	
	char *usr1,*host1,*conn1;
	int  i,j,end=0,f_end=0,count=1,flag=0;
// Create wtmp.txt
	system("last > /ids/wtmp.txt");	
// Open wtmp.txt to prepair profile
	if ((fwtmp = fopen("/ids/wtmp.txt","r")) == NULL)    
 	{	printf("Error in open file\n");
		exit(0);
	}
	usr1 = usr;
	host1 = host;
	conn1 = connect;

// Reading file wtmp.txt  except: reboot, runlevel, shutdown
	while (end != 1)  
	{	fgets(str,80,fwtmp);
		str1 = str;
		if (str1[0] == 'r' && str1[1] == 'e' && str1[2] == 'b' && str1[3] == 'o' && str1[4] == 'o'
		    && str1[5] == 't') continue;  
		if (str1[0] == 'r' && str1[1] == 'u' && str1[2] == 'n' && str1[3] == 'l' && str1[4] == 'e'  
		    && str1[5] == 'v' && str1[6] == 'e' && str1[7] == 'l' ) continue;
		if (str1[0] == 's' && str1[1] == 'h' && str1[2] == 'u' && str1[3] == 't' && str1[4] == 'd'  
		    && str1[5] == 'o' && str1[6] == 'w' && str1[7] == 'n') continue;
		if (str1[0] == '\n')
		{  end =1;
		   continue;
		}
//Cut text for user login name
		for(i=0;i<=8;++i)    
		{   usr1[i] = str1[i];
		    if(str1[i] == ' ' && f_end == 0)
		    {	usr1[i] = '\0';
			f_end = 1;
		    }
		}	
  		f_end = 0;

// Keep real logged on user name 
	if((fh = fopen("/ids/login.txt","r"))==NULL)
	{  
	   fh = fopen("/ids/login.txt","a");
	   fprintf(fh,"%s\n",usr);
	   fclose(fh);		
	}
	else
	{ fgets(usr_t,10,fh);
	  while(!feof(fh))
	  { usr_t1 = usr_t;
	    for (i=0;i<=10;++i)
		if (usr_t1[i] == ' ' || usr_t1[i] == '\n') usr_t1[i]='\0';
            if (strcmp(usr,usr_t)==0)
	    { 
	      flag =1;
            }			
            fgets(usr_t,10,fh);	
	  }
	  if (flag!=1)
	  { fclose(fh);
            fh = fopen("login.txt","a");
	    fprintf(fh,"%s\n",usr);	
	  }
	  flag=0;
	  fclose(fh);
	}
		
// Create user connect time profile
		strcpy(filename,usr);
		strcat(filename,".cnt\0");
		if ((fuser = fopen(filename,"a+")) == NULL) 
		{ 	printf("Error in open file\n");
			exit(2);
		}
		
		if (str1[62] == '(')
		{	j=0;
			for (i=63;i<=67;++i)
			{	conn1[j] = str1[i];
				++j;
			}
			conn1[5] = '\0';
			fprintf(fuser,"%s\n",connect);
		}
		fclose(fuser);

// Create user Remote hostname profile
		strcpy(filename,usr);
		strcat(filename,".hst\0");
		if (str1[19] != ' ') 
                {	j=0;
			for (i=19;i<=35;++i)
			{	host1[j] = str1[i];
				if (str1[i] == ' ' && f_end == 0)
			        { host1[j]='\0';
				  f_end=1;	
				  printf("%d\n",j);
				}
				++j;
			}
			f_end=0;
			if ((fuser = fopen(filename,"r")) == NULL) 
			{ 	
				fuser = fopen(filename,"a");
	   			fprintf(fuser,"%s\n",host);
	   			fclose(fuser);
			}
			else
			{ 	fgets(host_t,18,fuser);
	  			while(!feof(fuser))
	  			{ host_t1 = host_t;
		  	          for (i=0;i<=18;++i)
		  		  if (host_t1[i] == ' ' || host_t1[i] == '\n')
			              host_t1[i]='\0';   
				  if(strcmp(host,host_t)==0) 	    
				  { printf("True\n");
	      			    flag =1;
            			  }			
            			  fgets(host_t,18,fuser);	
	  			}
	  			if (flag!=1)
	  			{ fclose(fuser);
            			  fuser = fopen(filename,"a");
	    			  fprintf(fuser,"%s\n",host);	
				}
	  			flag=0;
				fclose(fuser);
			}
		}

	}
	fclose(fwtmp);
        CalAveConnect();
}

void CalAveConnect(void)
{	FILE *fp,*fn;
	char str[10],filename[13],hour[3],minute[3];
	char *str1,*filename1,*hour1,*minute1;
	int i,j,count;
        float sum;
	
	printf("Do CalAveConnect\n");
	if ((fp=fopen("/ids/login.txt","r")) == NULL)
	{ printf("Error in open Login.txt\n");
	  exit(0);
	}
	str1 = str;
	hour1 = hour;
	minute1 = minute;
	filename1 = filename;
	while(fgets(str,10,fp)!=NULL)
	{	printf(str1);
		i=0;
		while(str1[i]!='\n') 
		{ filename1[i]=str1[i];
		  ++i;
		}
		filename[i]='\0';
		strcat(filename,".cnt\0");
		printf("%s\n",filename);
		sum=0;
		count=0;
		fn = fopen(filename,"r");
		while(fgets(str,10,fn)!=NULL)
		{  i=0;
		   while (str1[i]!=':') 
		   {  hour1[i]=str1[i];
		      ++i;	
		   }
		   hour1[i]='\0';
		   ++i;
		   j=0;
		   while(str1[i]!='\n')
		   {  minute1[j]=str1[i];
		      ++j;
                      ++i;
		   }
		   minute1[j]='\0';
		   sum = sum+ atof(hour)*60 + atof(minute);
		   ++count;
		   printf("%f\n",sum);
		}
                fclose(fn);
		sum = sum/count;
		fn = fopen(filename,"w");
		fprintf(fn,"%f",sum);
		fclose(fn);
	}
	fclose(fp);
}
