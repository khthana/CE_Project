#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <utmp.h>
#include <pwd.h>

#define UTMP "/var/log/utmp"
#define NAMELEN 8

void ReadFileW(char *n1,char *tty,int&);
void ReadIdsDft(int&,int&,int&,int&,int&,int&,float&,float&,float&,float&);
void Equation(char *name,float,float,char *host,float,time_t,
	      int,int,int,int,int,int,float,float,int,int,float,float);
FILE *rs;

void main()
{	
	FILE *ps,*lg;
	char str[90],name[8],cpu[6],mem[6],cpu_n[8],mem_n[8],c_tty[8],m_tty[8];
 	char *str1,*name1,*cpu1,*mem1,*c_tty1,*m_tty1;
 	int i,k,j,c_flag,m_flag,SamePerson,cnotlogin=0,mnotlogin=0;
 	float maxcpu=0.0,tmpcpu,maxmem=0.0,tmpmem,MaxCpu_m,MaxMem_c; 	
	char tty[8];
	char *tty1;
	int DayIn,DayOut,NiIn,NiOut,XIn,XOut;
	float DefCpu,DefMem,cricpu,crimem;

	FILE *fp,*fw;   // variable for Reading UTMP      
	struct utmp u;
	struct passwd *p;
	char tmp[NAMELEN+1];
	time_t time_now,CLogTime,MLogTime;
	char *spt;
	char chost[16],mhost[16],cloging[7],mloging[7];
	float c_connect,m_connect;
	int cBingo,mBingo;
	
// Look process table by command ps	
	system("ps -aux > /ids/ps.txt");
// Open file result.txt for keeping result
	if ((rs = fopen("/ids/result.txt","a")) == NULL)    
 	{	printf("Error in open result.txt\n");
		exit(0);
	}

// Open file ps.txt for read-only : checking %CPU and %MEM
	if ((ps = fopen("/ids/ps.txt","r")) == NULL)    
 	{	fprintf(rs,"Error in open ps.txt\n");
		exit(0);
	}

// Reading file ps.txt  except: root
// ps.txt format: USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
	fgets(str,90,ps);
	while ( fgets(str,90,ps)!=NULL)	 //Read ps.txt one record
	{	str1 = str;
		if (str1[0] == 'r' && str1[1] == 'o' && str1[2] == 'o'
		    && str1[3] == 't') continue;  
		i=0;
		while(str1[i]!=' ')
		{	name1 = name;
			name1[i]=str1[i];
			++i;
		}
		name1[i]='\0';
		while(str1[i]==' ') ++i; // Skip space
		while(str1[i]!=' ') ++i; //Skip PID
		while(str1[i]==' ') ++i; // Skip space

		j=0;
		cpu1 = cpu;
		while(str1[i]!= ' ') //Keep %CPU in variable "cpu"
		{    	cpu1[j]=str1[i];
			++i;
			++j;
		}
		cpu1[j]='\0';
		tmpcpu = atof(cpu);

		while(str1[i] ==' ') ++i;// Skip space 
		j=0;
		while(str1[i]!= ' ') //Keep %MEM in variable "mem"
		{	mem1 = mem;
			mem1[j]=str1[i];
			++i;
			++j;
		}
		mem1[j]='\0';
		tmpmem = atof(mem);

		while(str1[i]==' ') ++i; // Skip space
		while(str1[i]!=' ') ++i; //Skip VSZ
		while(str1[i]==' ') ++i; // Skip space
		while(str1[i]!=' ') ++i; //Skip RSS
		while(str1[i]==' ') ++i; // Skip space
		j=0;
		while(str1[i]!= ' ') //Keep TTY in variable "tty"
		{	tty1 = tty;
			tty1[j]=str1[i];
			++i;
			++j;
		}
		tty1[j]='\0';
		
		c_flag = 0;
		if (tmpcpu > maxcpu) //Find user who use maximum %CPU
		{ 	maxcpu = tmpcpu;
			strcpy(cpu_n,name);
			strcpy(c_tty,tty);
			c_flag = 1;
		}
		if (tmpmem > maxmem) //Find user who use maximum %MEM
		{	maxmem = tmpmem;
			strcpy(mem_n,name);
			strcpy(m_tty,tty);
// MaxMem is not the same person as MaxCpu, Keep %CPU for MaxMem
			if (c_flag != 1)   MaxMem_c = tmpcpu; 	
// MaxMem is the same person as MaxCpu
			else 
			{  MaxMem_c = maxcpu;
			   MaxCpu_m = maxmem;
			} 	
		}
// MaxMem is not the same person as MaxCpu, Keep %MEM for MaxCpu
		else if (tmpmem < maxmem && c_flag == 1) MaxCpu_m = tmpmem;
	} 	
	fclose(ps);

//Has this user ever logged on before?
	if ((lg = fopen("/ids/login.txt","r")) == NULL)    
	{	fprintf(rs,"Error in open login.txt\n");
		exit(0);
	}
//Is MaxMem & MaxCpu the same person?
	SamePerson =0;
	if (maxcpu==MaxMem_c && MaxCpu_m==maxmem && (strcmp(cpu_n,mem_n)==0))
	{	
		SamePerson = 1;
		name1 = name;
		c_flag =0; m_flag =0;
		while(fgets(name,8,lg)!=NULL)
		{  i=0;
		   while(name1[i]!= '\n') ++i;
		   name1[i]='\0';	
		   if (strcmp(cpu_n,name)==0) c_flag = 1; //Ever logged on
  		} 		
	}
	else // MaxMem & MaxCpu is not the same person
	{
		c_flag = 0;
		m_flag = 0;
	   	name1 = name;
		while(fgets(name,8,lg)!=NULL)
		{  i=0;
		   while(name1[i]!= '\n') ++i;
		   name1[i]='\0';	
		   if (strcmp(cpu_n,name)==0) c_flag = 1; //Ever logged on
		   if (strcmp(mem_n,name)==0) m_flag = 1; //Ever logged on
		}
	}
	fclose(lg);

// Read UTMP to find Time of Login and HostName
	cBingo =0;
	mBingo =0;
	if ((fp =fopen(UTMP, "r")) == NULL)
	{  fprintf(rs,"Error in open UTMP\n");
	   exit(0);
	}
	while (fread((char *)&u, sizeof(u), 1, fp) != 0)
	{  	if (u.ut_name[0] == 0) continue;
		strncpy(tmp, u.ut_name, NAMELEN);
		if  ((p = getpwnam(tmp)) == NULL) continue;
		// A suspector ever logged on.
		if (SamePerson ==1 && (maxcpu>0.0 || maxmem>0.0))
		{	if (strcmp(u.ut_line,c_tty)==0) 
			{	CLogTime = u.ut_time;
				chost = u.ut_host;
				time_now = time('\0');
				c_connect = difftime(time_now,u.ut_time)/60; 
				cBingo = 1; 
				mBingo = 1; 	
				cnotlogin=1;
				if (strcmp(cpu_n,u.ut_name)!=0)
				    strcpy(cpu_n,u.ut_name);
				break;
			}      
		}
		else
		{   if (maxcpu > 0.0)
		    { 	if (strcmp(u.ut_line,c_tty)==0)
			{ 	CLogTime = u.ut_time;
				chost = u.ut_host;
				time_now = time('\0');
				c_connect = difftime(time_now,u.ut_time)/60;
				cBingo =1;
				cnotlogin =1;
				if (strcmp(cpu_n,u.ut_name)!=0)
		  	            strcpy(cpu_n,u.ut_name);				
			}
		    }
		    if (maxmem > 0.0)
		    { 	if (strcmp(u.ut_line,m_tty)==0)
			{	MLogTime = u.ut_time;
				mhost = u.ut_host;	
				time_now = time('\0');
				m_connect = difftime(time_now,u.ut_time)/60;
				mBingo =1;
				mnotlogin = 1;
				if (strcmp(mem_n,u.ut_name)!=0)
				    strcpy(mem_n,u.ut_name);
 	 		}
		   }
		}

	}
	fclose(fp);

//In case Checking TTY not found : Matching name and command
	if ((cBingo!=1 && maxcpu > 0.0) || (mBingo!=1 && maxmem > 0.0))
	{    system("w > /ids/w.txt");
	     if (cBingo !=1)
	     {ReadFileW(cpu_n,c_tty,cnotlogin);
	      if (cnotlogin ==1)	
	      {	if ((fp =fopen(UTMP, "r")) == NULL)
		{  perror(UTMP);
		   exit(0);
		}
		while (fread((char *)&u, sizeof(u), 1, fp) != 0)
		{  	if (u.ut_name[0] == 0) continue;
			strncpy(tmp, u.ut_name, NAMELEN);
			if  ((p = getpwnam(tmp)) == NULL) continue;
			if (strcmp(u.ut_line,c_tty)==0) 
		    	{	CLogTime = u.ut_time;
				chost = u.ut_host;
   			 	time_now =time('\0');
		 		c_connect =difftime(time_now,u.ut_time)/60;
  				break;
		        }      
		}
		fclose(fp);
	      }
	     }
	     if (mBingo!=1)
	     {ReadFileW(mem_n,m_tty,mnotlogin);
              if (mnotlogin ==1)	
	      {	if ((fp =fopen(UTMP, "r")) == NULL)
		{  perror(UTMP);
		   exit(0);
		}
		while (fread((char *)&u, sizeof(u), 1, fp) != 0)
		{  	if (u.ut_name[0] == 0) continue;
			strncpy(tmp, u.ut_name, NAMELEN);
			if  ((p = getpwnam(tmp)) == NULL) continue;
			if (strcmp(u.ut_line,c_tty)==0) 
		    	{	MLogTime = u.ut_time;
				mhost = u.ut_host;
   			 	time_now =time('\0');
   		 		m_connect=difftime(time_now,u.ut_time)/60; 
		 		break;
 		        }      
		}
		fclose(fp);
	      }
	     }
	}
//Read ids.dft to get Default Setting
  ReadIdsDft(DayIn,DayOut,NiIn,NiOut,XIn,XOut,DefCpu,DefMem,cricpu,crimem);

//Do the Equation
	if ((SamePerson == 1) &&((maxcpu>0.0)||(maxmem>0.0)))
	   Equation(cpu_n,maxcpu,maxmem,chost,c_connect,CLogTime,
             DayIn,DayOut,NiIn,NiOut,XIn,XOut,DefCpu,DefMem,c_flag,cnotlogin,
	     cricpu,crimem);
 	else
	{ if (maxcpu > 0.0)
	     Equation(cpu_n,maxcpu,MaxCpu_m,chost,c_connect,CLogTime,
              DayIn,DayOut,NiIn,NiOut,XIn,XOut,DefCpu,DefMem,c_flag,cnotlogin,
	      cricpu,crimem);
  	  if (maxmem > 0.0)  	    
	    Equation(mem_n,MaxMem_c,maxmem,mhost,m_connect,MLogTime,
	     DayIn,DayOut,NiIn,NiOut,XIn,XOut,DefCpu,DefMem,m_flag,mnotlogin,
	     cricpu,crimem);
 	}
	fclose(rs);
}

void ReadFileW(char *n1,char *tname,int& notlogin)
{	FILE *fw;
	char str[120],name[8],cmd[40],tty[8];
	char *str1,*name1,*cmd1,*tty1;
	int i,j;

	if ((fw=fopen("/ids/w.txt","r"))==NULL)
	{	fprintf(rs,"Error in open w.txt\n");
		exit(0);
	}
	fgets(str,120,fw);//Throw away 2 records
	fgets(str,120,fw);
	str1=str;
	name1=name;
	tty1=tty;
	cmd1=cmd;

	while(fgets(str,120,fw)!=NULL)
	{	i=0;
		j=0;
		while(str1[i]!=' ') //Cut name
		{ name1[j] = str1[i];
		  ++i;
		  ++j;
		}
		name1[j]='\0';
		while(str1[i]==' ') ++i; //Skip space

		j=0;
		while(str1[i]!=' ') //Cut TTY
		{ tty1[j] = str1[i];
		  ++j;
		  ++i;
		}
		tty1[j]='\0';
		while(str1[i]==' ') ++i; //Skip space
		while(str1[i]!=' ') ++i;//Skip HostName
		while(str1[i]==' ') ++i; //Skip space
		while(str1[i]!=' ') ++i;//Skip Time of Login
		while(str1[i]==' ') ++i; //Skip space
		while(str1[i]!=' ') ++i; //Skip IDLE
		while(str1[i]==' ') ++i; //Skip space
		while(str1[i]!=' ') ++i; //Skip JCPU
		while(str1[i]==' ') ++i; //Skip space
		while(str1[i]!=' ') ++i; //Skip PCPU
		while(str1[i]==' ') ++i; //Skip space
		
		j=0;
		while(str1[i]!='\n') //Cut Command
		{ cmd1[j] = str1[i];
		  ++j;
 		  ++i;
		}
		cmd1[j]='\0';
		
		j=0;
		if (strcmp(n1,name)==0)
		{	if((strcmp(tty,"tty1")==0)||(strcmp(tty,"tty2")==0)||                
	   	           (strcmp(tty,"tty3")==0)||(strcmp(tty,"tty4")==0)|| 
	   	           (strcmp(tty,"tty5")==0)||(strcmp(tty,"tty6")==0)&&
			   (strcmp(cmd,"sh /usr/X11R6/b")==0))
			    strcpy(tname,tty);    
			notlogin =1;
			if ((notlogin == 1)&&(strcmp(tname,tty)!=0))
				strcpy(tname,tty);
	   	 }	 	 
	} 
	fclose(fw);
}

void ReadIdsDft(int& DayIn1,int& DayOut1,int& NiIn1,int& NiOut1,int& XIn1,
	int& XOut1,float& DefCpu1,float& DefMem1,float& cricpu1,float& crimem1)
{	FILE *fp;
	char str1[90],str2[90],tmptime[5],hour[3],minute[3],cpu[5],mem[5];
	int i,j,k;
 	char *str11,*str21,*tmptime1,*hour1,*minute1,*cpu1,*mem1; 	

	if ((fp=fopen("/ids/ids.dft","r"))==NULL)
	{ 	fprintf(rs,"Error in open ids.dft\n");
		exit(0);
	}

	tmptime1=tmptime;
	hour1=hour;
	minute1=minute;
	cpu1=cpu;
	mem1=mem;
	str11=str1;
	str21=str2;
	fgets(str1,90,fp); //Skip Header Column
	fgets(str1,90,fp);
	fgets(str2,90,fp);
	fclose(fp);
	i=0;
	j=0;
	while(str11[i]!=' ') // Read DayIn
	{    tmptime1[j] = str11[i];
	     ++i;
	     ++j;
	}
	tmptime1[j]='\0';
	for(j=0;j<=1;++j) hour1[j]=tmptime1[j];
	hour1[2]='\0';
	k=0;
	for(j=3;j<=4;++j) 
	{   minute1[k]=tmptime1[j];
	    ++k;
	}
	minute1[2]='\0';
	DayIn1 = atoi(hour)*60 + atoi(minute);
	while(str11[i]==' ') ++i; //Skip space	

	j=0;
	while(str11[i]!=' ') // Read NightIn
	{    tmptime1[j] = str11[i];
	     ++i;
	     ++j;
	}
	tmptime1[j]='\0';
	for(j=0;j<=1;++j) hour1[j]=tmptime1[j];
	hour1[2]='\0';
	k=0;
	for(j=3;j<=4;++j) 
	{   minute1[k]=tmptime1[j];
	    ++k;
	}
	minute1[2]='\0';
	NiIn1 = atoi(hour)*60 + atoi(minute);
	while(str11[i]==' ') ++i; //Skip space	

	j=0;
	while(str11[i]!=' ') // Read CriticalIn
	{    tmptime1[j] = str11[i];
	     ++i;
	     ++j;
	}
	tmptime1[j]='\0';
	for(j=0;j<=1;++j) hour1[j]=tmptime1[j];
	hour1[2]='\0';
	k=0;
	for(j=3;j<=4;++j) 
	{   minute1[k]=tmptime1[j];
	    ++k;
	}
	minute1[2]='\0';
	XIn1 = atoi(hour)*60 + atoi(minute);
	while(str11[i]==' ') ++i; //Skip space	

	j=0;
	while(str11[i]!=' ') // Read %CPU
	{    cpu1[j] = str11[i];
	     ++i;
	     ++j;
	}
	cpu1[j]='\0';
	DefCpu1 = atof(cpu);
	while(str11[i]==' ') ++i; //Skip space	

	j=0;
	while((str11[i]!=' ') && (str11[i]!='\n')) // Read %MEM
	{    mem1[j] = str11[i];
	     ++i;
	     ++j;
	}
	mem1[j]='\0';
	DefMem1 = atof(mem);	

	i=0;
	j=0; 
	while(str21[i]!=' ') // Read DayOut
	{    tmptime1[j] = str21[i];
	     ++i;
	     ++j;
	}
	tmptime1[j]='\0';
	for(j=0;j<=1;++j) hour1[j]=tmptime1[j];
	hour1[2]='\0';
	k=0;
	for(j=3;j<=4;++j) 
	{   minute1[k]=tmptime1[j];
	    ++k;
	}
	minute1[2]='\0';
	DayOut1 = atoi(hour)*60 + atoi(minute);
	while(str21[i]==' ') ++i; //Skip space	

	j=0;
	while(str21[i]!=' ') // Read NightOut
	{    tmptime1[j] = str21[i];
	     ++i;
	     ++j;
	}
	tmptime1[j]='\0';
	for(j=0;j<=1;++j) hour1[j]=tmptime1[j];
	hour1[2]='\0';
	k=0;
	for(j=3;j<=4;++j) 
	{   minute1[k]=tmptime1[j];
	    ++k;
	}
	minute1[2]='\0';
	NiOut1 = atoi(hour)*60 + atoi(minute);
	
	while(str21[i]==' ') ++i; //Skip space	
	j=0;
	while(str21[i]!=' ') // Read CriticalOut
	{    tmptime1[j] = str21[i];
	     ++i;
	     ++j;
	}
	tmptime1[j]='\0';
	for(j=0;j<=1;++j) hour1[j]=tmptime1[j];
	hour1[2]='\0';
	k=0;
	for(j=3;j<=4;++j) 
	{   minute1[k]=tmptime1[j];
	    ++k;
	}
	minute1[2]='\0';
	XOut1 = atoi(hour)*60 + atoi(minute);
	while(str11[i]==' ') ++i; //Skip space	

	j=0;
	while(str11[i]!=' ') // Read criCPU
	{    cpu1[j] = str11[i];
	     ++i;
	     ++j;
	}
	cpu1[j]='\0';
	cricpu1 = atof(cpu);
	while(str11[i]==' ') ++i; //Skip space	

	j=0;
	while((str11[i]!=' ') && (str11[i]!='\n')) // Read criMEM
	{    mem1[j] = str11[i];
	     ++i;
	     ++j;
	}
	mem1[j]='\0';
	crimem1 = atof(mem);	
}

void Equation(char *name,float cpu,float mem,char *host,float connect,
	      time_t Logtime,int dayin1,int dayout1,int niin1,int niout1,
	      int xin1,int xout1,float defcpu1,float defmem1,int flag,
	      int notlogin,float cricpu1,float crimem1) 
{	char temptime[30],hour[3],minute[3],sec[3],filename[14],str[30];
 	char tempw[3],add[60];
	char *temptime1,*hour1,*minute1,*sec1,*tempw1,*str1;
	int  i,j,login,min;
	float x1,x2,x3,x4,x5,x6,avecon,w1,w2,w3,w4,w5,w6,sumeq,maxcon;
	FILE *fh,*al;
	time_t time_now;

    if (notlogin ==1)	
    {
// x1 : Time of Login
	strcpy(temptime,ctime(&Logtime));
	temptime1 = temptime;
	hour1 = hour;
	minute1 = minute;
	sec1 = sec;
	i=0;
	while (temptime1[i]!=' ') ++i; //Skip Day
	while (temptime1[i]==' ') ++i; //Skip space		
	while (temptime1[i]!=' ') ++i; //Skip Month
	while (temptime1[i]==' ') ++i; //Skip space		
	while (temptime1[i]!=' ') ++i; //Skip Date
	while (temptime1[i]==' ') ++i; //Skip space
	for(j=0;j<=1;++j) 
	{  hour1[j]=temptime1[i];
	   ++i;
	}
	hour1[2]='\0';
	++i; //Skip ":"
	for(j=0;j<=1;++j) 
	{  minute1[j]=temptime1[i];
	   ++i;
	}
	minute1[2]='\0';
	++i; //Skip ":"
	for(j=0;j<=1;++j) 
	{  sec1[j]=temptime1[i];
	   ++i;
	}
	sec1[2]='\0';
	login = ((atoi(hour)*60*60) + (atoi(minute)*60) + atoi(sec))/60;

	if ((login > xin1) &&(login <= xout1)) x1=1;
	else if ((login > niin1) &&(login <= niout1)) x1=0.5;
	else if ((login > dayin1) &&(login <= dayout1)) x1=0;
// x2 : LOCATION
	if (strcmp(host,"\0")!= 0) x2 =1; // Login from Remote Host
	else x2 =0;
	if (flag == 1 && x2 == 1)
	{  strcpy(filename,name);
	   strcat(filename,".hst\0");
   	   if ((fh = fopen(filename,"r"))== NULL)
	   { 	fprintf(rs,"Error in open %s\n",filename);
	      	exit(0);
	   }
	   str1 = str;
	   while(fgets(str,30,fh)!=NULL)
	   {	i=0;
		while(str1[i]!='\n') ++i;
		str1[i]='\0';		
		if (strcmp(host,str)==0) x2 = 0;
	   }
	   fclose(fh);		
	   if (x2 ==0 )
           {  if ((fh = fopen("/ids/blackhost","r"))== NULL)
	      {	fprintf(rs,"Error in open blackhost\n");
		exit(0);
	      }
	      str1=str;
	      while(fgets(str,30,fh)!=NULL)
	      {	i=0;
		while(str1[i]!='\n') ++i;
		str[1]='\0';
		if (strcmp(host,str)==0) x2 = 0.5;
	      }
	      fclose(fh);
	   }
	}
// x3 : CONNECT
   	if (flag == 1) 
	{ strcpy(filename,name);
	  strcat(filename,".cnt\0");
	  if ((fh = fopen(filename,"r"))== NULL)
	  { fprintf(rs,"Error in open %s\n",filename);
	    exit(0);
	  }
	  fscanf(fh,"%f %f",&avecon,&maxcon);
  	  if (connect > maxcon) x3 = 1;
	  else if ((connect <maxcon) && (connect>avecon)) x3=0.5;
	  else x3 = 0;
	  fclose(fh);
	}
	else x3 = 1; //Have no profile for this user
// x4 : %CPU
	if (cpu > cricpu1) x4 = 1;
	else if ((cpu>defcpu1)&&(cpu<= cricpu1)) x4=0.5;
	else x4 = 0;

// x5 : %MEM
	if (mem > crimem1) x5 = 1;
	else if ((mem>defmem1)&&(mem<= crimem1)) x5=0.5;
	else x5 = 0;

// x6 : NEVER LOGGED ON 
	if (flag == 1) x6 =0;
	else x6 = 1;
// Calculate Equation
	if ((fh = fopen("/ids/weight.dft","r"))==NULL)
	{ fprintf(rs,"Error in open weight.dft\n");
	  exit(0);
	}
	fgets(str,30,fh); // Skip Header 
	fgets(str,30,fh); // Get Weight
        str1 = str;
	tempw1 = tempw;
	i=0;
	j=0;
	while(str1[i]!=' ')
	{ tempw1[j] = str1[i];
	  ++i;
	  ++j;
	}
	tempw1[j]='\0';
	w1 = atof(tempw);
	while(str1[i]==' ') ++i; //Skip space
	j=0;
	while(str1[i]!=' ')
	{ tempw1[j] = str1[i];
	  ++i;
	  ++j;
	}
	tempw1[j]='\0';
	w2 = atof(tempw);
	while(str1[i]==' ') ++i; //Skip space
	j=0;
	while(str1[i]!=' ')
	{ tempw1[j] = str1[i];
	  ++i;
	  ++j;
	}
	tempw1[j]='\0';
	w3 = atof(tempw);
	while(str1[i]==' ') ++i; //Skip space
	j=0;
	while(str1[i]!=' ')
	{ tempw1[j] = str1[i];
	  ++i;
	  ++j;
	}
	tempw1[j]='\0';
	w4 = atof(tempw);
	while(str1[i]==' ') ++i; //Skip space
	j=0;
	while(str1[i]!=' ')
	{ tempw1[j] = str1[i];
	  ++i;
	  ++j;
	}
	tempw1[j]='\0';
	w5 = atof(tempw);
	while(str1[i]==' ') ++i; //Skip space
	j=0;
	while(str1[i]!=' ')
	{ tempw1[j] = str1[i];
	  ++i;
	  ++j;
	}
	tempw1[j]='\0';
	w6 = atof(tempw);
	while(str1[i]==' ') ++i; //Skip space
	j=0;
	while(str1[i]!=' ')
	{ tempw1[j] = str1[i];
	  ++i;
	  ++j;
	}
	tempw1[j]='\0';
	min = atoi(tempw);
	fclose(fh);
	sumeq = (w1*x1) + (w2*x2) + (w3*x3) + (w4*x4) + (w5*x5) + (w6*x6);
	time_now = time('\0');
	if (sumeq > 20){
 	 fprintf(rs,"%s %s %f %f %f %s",
	   	name,host,connect,cpu,mem,ctime(&Logtime));
	 fprintf(rs,"%s %f %f %f %f %f %f %f\n",
		ctime(&time_now),x1,x2,x3,x4,x5,x6,sumeq);
	}
	if (sumeq > min){
	   if ((al = fopen("/ids/letter","w"))==NULL)
	   { fprintf(rs,"Error in open letter\n");
	     exit(0);
	   }
	   if ((fh = fopen("/ids/anomaly","a"))==NULL)
	   { fprintf(rs,"Error in open anomaly\n");
	     exit(0);
	   }
	   fprintf(fh,"%s %s",name,ctime(&time_now));
	   fprintf(al,"%s\n",ctime(&time_now));
	   fprintf(al,"Intrusion Detection System found that\n");
	   fprintf(al,"%s %MEM = %f, %CPU = %f\n",name,mem,cpu);
	   fclose(al);
	   fclose(fh);
	   if ((fh = fopen("/ids/admail","r"))==NULL)
	   { fprintf(rs,"Error in open admail\n");
	     exit(0);
	   }
	   str1 = str;
	   while(fgets(str,30,fh)!=NULL)
	   { 	i=0;
		strcpy(add,"sendmail ");
		while (str1[i]!='\n') ++i;
		str1[i]='\0';
		strcat(add,str);
                strcat(add," < /ids/letter");
           	system(add);	
	   }
	}	
   }
}
