#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <fcntl.h>
#include <rpc/rpc.h>
#include "atm.h"

FILE	*fp,*fp1,*ftemp,*ftemp_des;
char    lock_file[] = "/home/dech/complete/LCK.test";
int     fildes;
extern  int  errno;

/*function check destination ID*/
int check_dest(number)
char *number;
{
   FILE *file;
   char x4[15],x5[5];
   int  re_check;
   re_check=0;
   file = fopen("customer.dat","r+");
   
   while (!feof(file))
   {
      fread(&x4,sizeof(x4),1,file);
      fseek(file,0L,SEEK_CUR);
      fread(&x5,sizeof(x5),1,file);
      fputs(x4,stdout);
         if ((strcmp(number,x4))==0)
		re_check=1;
	}
    if(re_check==1) return(1);
    else return(0);
}


transfer_resulttype *
transfer_1(num_transfer)
transfer_moneytype *num_transfer;
{
	static transfer_resulttype result_transfer=NULL;
	static balance dbbl_src=NULL,dbbl_des=NULL;
	char x1[15],x2[15],x3[15],x4[15],x5[15],x6[15];
	long n,n1,n2,n3;
	int i,j,check;
	time_t lowlevel_time;
	n=0;
	(void)time(&lowlevel_time);
	
	do{
	/*create lock file*/
	fildes = open(lock_file, O_RDWR | O_CREAT | O_EXCL,0444);
	if (fildes == -1) {
		printf(" %d - Lock already present\n",getpid());
		result_transfer.errno=1;
		}
		else {
	printf(" %d - I have exclusive access\n",getpid());
        
	/*	result_transfer.errno=0;*/
	check=check_dest(num_transfer->Destination_id);
	fprintf(stderr,"\n%d",check);
	
	if(check==1)
    {
	
	  fp=fopen(DATABL,"r+");
	  fp1=fopen(DATABL,"r+");
	  while(!feof(fp))
	  {
		/*read value source ID from database*/
		fread(&x1,sizeof(x1),1,fp);
		dbbl_src.ID_account=malloc(sizeof(x1));
		memcpy(dbbl_src.ID_account,x1,sizeof(x1));
		fseek(fp,50L,SEEK_CUR);  /*move pointer to field balance*/
		
		/*read value source balance from database*/
		fread(&x2,sizeof(x2),1,fp);
		dbbl_src.Balance=malloc(sizeof(x2));
		memcpy(dbbl_src.Balance,x2,sizeof(x2));
		
		if((strcmp(num_transfer->ID_account,dbbl_src.ID_account))==0)
		{
			/*move old source balance value to temp.dat*/
			ftemp=fopen(TEMP,"w+");		
				fwrite(&x1,sizeof(x1),1,ftemp);
				fwrite(&x2,sizeof(x2),1,ftemp);
			fclose(ftemp);
			
			/*change string to long int*/			
			n=atol(dbbl_src.Balance);	
			n1=atol(num_transfer->Num_trans);	
		
			/*check source money in database*/	
		if (n1 > n)
		{
			fclose(fp);
			(void)close(fildes);
			(void)unlink(lock_file);
			result_transfer.errno=2;
			return(&result_transfer);
		}	
			
			n=n-n1;											/*debit in database*/
			fseek(fp,-15L,SEEK_CUR);		/*move pointer to field balance*/
			dbbl_src.Balance=ltoa(n);		/*change long int to string*/
			memcpy(x3,dbbl_src.Balance,sizeof(x3));
			fwrite(&x3,sizeof(x3),1,fp);		/*write new value to database*/
			
			/*result of source ID account*/
			result_transfer.transfer_resulttype_u.transfer.Balance=malloc(sizeof(x2));
			result_transfer.transfer_resulttype_u.transfer.Date_Time=ctime(&lowlevel_time);
			result_transfer.transfer_resulttype_u.transfer.Date_Time[30]='\0';
			memcpy(result_transfer.transfer_resulttype_u.transfer.Balance,dbbl_src.Balance,sizeof(x2));
			
			while(!feof(fp1))
			{
				/*read value destination ID from database*/
				fread(&x4,sizeof(x4),1,fp1);
				dbbl_des.ID_account=malloc(sizeof(x4));
				memcpy(dbbl_des.ID_account,x4,sizeof(x4));
				fseek(fp1,50L,SEEK_CUR);		/*move pointer to field balance*/
				
				/*read value destination balance from database*/
				fread(&x5,sizeof(x5),1,fp1);
				dbbl_des.Balance=malloc(sizeof(x5));
				memcpy(dbbl_des.Balance,x5,sizeof(x5));
				

			if ((strcmp(num_transfer->Destination_id,dbbl_des.ID_account))==0)
				{
				/*move old destination balance value to temp_des.dat*/
				ftemp_des=fopen(TEMP_DS,"w+");
				fwrite(&x4,sizeof(x4),1,ftemp_des);
				fwrite(&x5,sizeof(x5),1,ftemp_des);
				fclose(ftemp_des);
					
					/*change string to long int*/			
					n2=atol(dbbl_des.Balance);
					n3=atol(num_transfer->Num_trans);
					
					n2=n2+n3;			/*add money to destination ID*/
					fseek(fp1,-15L,SEEK_CUR);
					dbbl_des.Balance=ltoa(n2);
					memcpy(x6,dbbl_des.Balance,sizeof(x6));
					fwrite(x6,sizeof(x6),1,fp1);   /*write new value to database*/
									
					fclose(fp);
					fclose(fp1);
					(void)close(fildes);
			        (void)unlink(lock_file);
					result_transfer.errno=0;
					return(&result_transfer);
				} /*if compare destination ID*/				
			}     /*loop while (!feof(fp1))*/
		}		  /*if compare source ID*/				
	 }			  /*loop while (!feof(fp))*/
	}	else result_transfer.errno=1;/*check destination ID*/
	
	fclose(fp);
	fclose(fp1);
	(void)close(fildes);
	(void)unlink(lock_file);
	return(&result_transfer);
	
	}
	/*delay lock file*/
	for (i=0;i<500;i++)
		for(j=0;j<30000;j++);
	}while(fildes!=0);
	
	fclose(fp);
	fclose(fp1);
	result_transfer.errno=0;
	return(&result_transfer);
}

balance_resulttype *
withdraw_1(num_money)
withdraw_moneytype *num_money;
{
	static balance_resulttype result_withdraw=NULL;
	static balance dbbl;
	char x1[15],x2[15],x3[15];
	int x,i,j,found;
	long n,n1;
/*	char *test="test";*/
	char ch;
	time_t lowlevel_time;
		
	do{
	/*create lock file*/
	fildes = open(lock_file, O_RDWR | O_CREAT | O_EXCL,0444); 
	
		if (fildes == -1) 
		{
		printf(" %d - Lock already present\n",getpid());
		}
		else {
			printf(" %d - I have exclusive access\n",getpid());
	        n=0;
		    found=0;
			x=1;
	
		/*result_withdraw.errno=0;*/
		fp=fopen(DATABL,"r+");
	while(!feof(fp))
	{
		/*read value ID from database*/
		fread(&x1,sizeof(x1),1,fp);
		dbbl.ID_account=malloc(sizeof(x1));
		memcpy(dbbl.ID_account,x1,sizeof(x1));
		fseek(fp,50L,SEEK_CUR);/*move pointer to field balance*/

		/*read value balance from database*/
		fread(&x2,sizeof(x2),1,fp);
		dbbl.Balance=malloc(sizeof(x2));
		memcpy(dbbl.Balance,x2,sizeof(x2));
	
		if ((strcmp(num_money->ID_account,dbbl.ID_account))==0)
		{
			/*move old balance value to temp.dat*/
			ftemp=fopen(TEMP,"w+");		
			fwrite(&x1,sizeof(x1),1,ftemp);
			fwrite(&x2,sizeof(x2),1,ftemp);
			fclose(ftemp);
			
			/*change string to long int*/			
			n=atol(dbbl.Balance);
			n1=atol(num_money->Amount_money);
			
			/*check money in database*/
				if ( n1 > n)
				{
					fclose(fp);
					(void)close(fildes);
					(void)unlink(lock_file);
					result_withdraw.errno=2;		/*2 is show money not enough*/
					return(&result_withdraw);
				}
			
				n=n-n1;											/*debit in database*/
				fseek(fp,-15L,SEEK_CUR);		/*move pointer to field balance*/
			    dbbl.Balance=ltoa(n);					/*change long int to string*/
	        	memcpy(x3,dbbl.Balance,sizeof(x3));		
			    fwrite(&x3,sizeof(x3),1,fp);		/*write new value to database*/
		
			result_withdraw.balance_resulttype_u.balances.Balance=malloc(sizeof(x3));
			memcpy(result_withdraw.balance_resulttype_u.balances.Balance,dbbl.Balance,sizeof(x3));
		
			result_withdraw.balance_resulttype_u.balances.ID_account=malloc(sizeof(x1));
			memcpy(result_withdraw.balance_resulttype_u.balances.ID_account,dbbl.ID_account,sizeof(x1));
		
			result_withdraw.balance_resulttype_u.balances.Date_Time=ctime(&lowlevel_time);

			/*display time*/
			(char *)time(&lowlevel_time);
			printf("The date is: %s",ctime(&lowlevel_time));
			
			fclose(fp);
			(void)close(fildes);
			(void)unlink(lock_file);
			result_withdraw.errno=0;		/*0 is result complete*/
			return(&result_withdraw);
		
		}    /*if compare ID*/
		 
	  }		 /*loop while(!feof(fp))*/
	
	}       /*else of lock file*/
		for (i=0;i<500;i++)
		for(j=0;j<30000;j++);
	}while(fildes!=0); /*loop do while*/
	fclose(fp);  
	return(&result_withdraw);
}

balance_resulttype *
check_balance_1(ID_number)
char **ID_number;
{
	static balance_resulttype result_check_balance=NULL;
	static balance dbbl;
	time_t lowlevel_time;
	char x1[15],x2[15];
	
	(char *)time(&lowlevel_time);
	printf("The date is: %s",ctime(&lowlevel_time));
	
	fp=fopen(DATABL,"rb");
	while (!feof(fp))
	{
		/*read value ID from database*/
		fread(&x1,sizeof(x1),1,fp);
		dbbl.ID_account=malloc(sizeof(x1));
		memcpy(dbbl.ID_account,x1,sizeof(x1));
		fseek(fp,50L,SEEK_CUR);/*move pointer to field balance*/
		
		/*read value balance from database*/
		fread(&x2,sizeof(x2),1,fp);
		dbbl.Balance=malloc(sizeof(x2));
		memcpy(dbbl.Balance,x2,sizeof(x2));
		
		/*compare ID*/
		if((strcmp(*ID_number,dbbl.ID_account))==0)
		{
		result_check_balance.balance_resulttype_u.balances.ID_account=malloc(sizeof(x1));
		memcpy(result_check_balance.balance_resulttype_u.balances.ID_account,dbbl.ID_account,sizeof(x1));
	
		result_check_balance.balance_resulttype_u.balances.Balance=malloc(sizeof(x2));
		memcpy(result_check_balance.balance_resulttype_u.balances.Balance,dbbl.Balance,sizeof(x2));			
		
		result_check_balance.balance_resulttype_u.balances.Date_Time=ctime(&lowlevel_time);
		}
	}	
	fclose(fp);
	return(&result_check_balance);
}

usrinfo *
validate_1(info_user)
usrinfo *info_user;
{ 
	static usrinfo result_validate,dbusr;
	char x1[15],x2[5];
	
	/*allocate memory*/
	result_validate.ID_account=malloc(sizeof(x1));
	result_validate.Password=malloc(sizeof(x2));
	dbusr.ID_account=malloc(sizeof(x1));
	dbusr.Password=malloc(sizeof(x2));
	
	fp=fopen(DATAUSR,"rb");
	while (!feof(fp))
	{	
		/*read value ID from database*/
		fread(&x1,sizeof(x1),1,fp);	
		memcpy(dbusr.ID_account,x1,sizeof(x1));
		
		/*read value password from database*/
		fread(&x2,sizeof(x2),1,fp);
		memcpy(dbusr.Password,x2,sizeof(x2));

		/*compare ID*/
		if ((strcmp(info_user->ID_account,dbusr.ID_account))==0)
		{
	        	memcpy(result_validate.ID_account,dbusr.ID_account,sizeof(x1));			
		   /*compare password*/
		   if ((strcmp(info_user->Password,dbusr.Password))==0)
		       	memcpy(result_validate.Password,dbusr.Password,sizeof(x2));			
		    
			fclose(fp);
			return(&result_validate);
	         }
	}
	fclose(fp);
	return(&result_validate);
}
