#include <stdio.h>
#include <stdlib.h>
#include <curses.h>
#include <malloc.h>
#include <signal.h>
#include <unistd.h>
#include <netdb.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <rpc/rpc.h>
#include "atm.h"

#define  SIZE 8192
#define  PORT 0x1233  /*define port communication*/

static void sig_pipe();
void roll_back();
int Flag_check=0;
CLIENT *cl;					  /*define client handle*/

WINDOW *win;
char id[15],passwd[5],iwm[15],itm[15],di[15];
usrinfo   info,*result_validate=NULL;
transfer_moneytype   transfer_money;
withdraw_moneytype   withdraw_money;
transfer_resulttype   *result_transfer=NULL;
balance_resulttype   *result_check_balance=NULL,*result_withdraw=NULL;
struct servent *sp;

int  *flag_dest_id=0;
char *host = "161.246.5.240";
extern  int errno;

/*function validate ID and password*/
int validate()
{
	int flag,flag_id,flag_pwd;
	flag=0;flag_id=0;flag_pwd=0;
	if ((strcmp(info.ID_account,result_validate->ID_account))!=0) flag_id=-1;
	if ((strcmp(info.Password,result_validate->Password))!=0) flag_pwd=-1;
		
		if (flag_id==-1) 
		    {
		    mvwprintw(win,13,10,"ID_account wrong");
		    mvwprintw(win,13,40,"%s",result_validate->ID_account);
		    mvwprintw(win,16,10,"Press return key for reagain");
		    flag=flag_id;
		    wgetch(win);
		    return(flag);
		    }
		    else if (flag_pwd==-1)
		         {
			 mvwprintw(win,13,10,"Password wrong");
		         mvwprintw(win,16,10,"Press return key for reagain");
			 flag=flag_pwd;
			 wgetch(win);
			 return(flag);
			 }
}


main(argc,argv)
int argc;
char *argv[];
{
	int  i,count=1;
	struct timeval tv;	
	char  *server;
	int  ck=0;
	char ch;

		if (argc!=2) 
		{
			fprintf(stderr,"usage: %s ip of hostname\n",argv[0]);
			exit(1);
		}

	/*create client handle*/
	server=argv[1];
	cl=clnt_create(server,ATMPROG,ATMVERS,"tcp");
	
		if (cl == NULL) 
		{
			clnt_pcreateerror(server);
			exit(1);
		}
	
	initscr();

	/*loop do while input password */
	do{
	win = newwin(20,70,2,4);
	box(win,'|','-');
	mvwprintw(win,3,20,"Welcome to ATM Simulation");
	mvwprintw(win,17,50,"Ctrl C : Cancel");
	mvwprintw(win,6,10,"Please input ID Account: ");
	noecho();			
	
		wmove(win,6,35);
		i=0;
		while((id[i] = wgetch(win))!='\n') 
		{	
		   wprintw(win,"%c",id[i]);
		   i++;
		}
		id[i]='\0';
	
	mvwprintw(win,8,10,"Please input Password: ");
		wmove(win,8,35);
		i=0;
		while((passwd[i] = wgetch(win))!='\n') 
		{
		   wprintw(win,"*");
		   i++;
		}
		passwd[i]='\0';
	
	/*input value to procedure on remote*/
	info.ID_account=id;
	info.Password=passwd;

	/*call procedure validate on remote*/
	result_validate=validate_1(&info,cl);   
	ck=validate();
	echo();
	count++;
	}  while ((ck==-1) && (count<4));
    
    
    if ((count<5) && (ck!=-1))  
    {	
	wclear(win);
	box(win,'|','-');
	mvwprintw(win,3,20,"%s","Welcome to ATM Simulation");
	mvwprintw(win,6,10,"%s","Select Service");
	mvwprintw(win,8,10,"%s","1.Check Balance");
	mvwprintw(win,10,10,"%s","2.Withdrawal");
	mvwprintw(win,12,10,"%s","3.Transfer");
	mvwprintw(win,17,50,"Ctrl C : Cancel");
	mvwprintw(win,14,10,"%s","Please input service: ");
	wmove(win,14,32);
	
	/*select services*/
	ch=wgetch(win);wprintw(win,"%c",ch);
	switch(ch) {

		/*check balance*/
		case '1': wclear(win);
			  box(win,'|','-');
			  mvwprintw(win,3,20,"%s","Welcome to ATM Simulation");
			  mvwprintw(win,6,10,"%s","Check Balance Service");
			  mvwprintw(win,17,50,"Ctrl C : Cancel");

			  /*call procedure check balance on remote*/
			  result_check_balance=check_balance_1(&info.ID_account,cl);
			  /*show result from remote*/
			  mvwprintw(win,8,10,"Balance = %s",result_check_balance->balance_resulttype_u.balances.Balance);
	  		  mvwprintw(win,10,10,"ID Account = %s",result_check_balance->balance_resulttype_u.balances.ID_account);
			  mvwprintw(win,12,10,"Date/Time %s",result_check_balance->balance_resulttype_u.balances.Date_Time);
			  box(win,'|','-');
			  break;

		/*withdraw*/
		case '2': wclear(win);
			  box(win,'|','-');
			  mvwprintw(win,3,20,"%s","Welcome to ATM Simulation");
			  mvwprintw(win,6,10,"%s","Withdrawal Service");
			  mvwprintw(win,17,50,"Ctrl C : Cancel");
			  mvwprintw(win,8,10,"%s","Please input withdraw money: ");
			  wgetstr(win,iwm);

			  /*input value to procedure on remote*/ 
			  withdraw_money.ID_account=id;
			  withdraw_money.Amount_money=iwm;
			  
			  /*define and set wait time*/
			  tv.tv_sec=25;
			  tv.tv_usec=0;
			  clnt_control(cl,CLSET_TIMEOUT,&tv);
		  	  
			  /*check signal Ctrl-C*/
			  signal(SIGINT,sig_pipe);
			  count=0;
			   
			   do{	
				result_withdraw=withdraw_1(&withdraw_money,cl);
				if (result_withdraw==NULL) 
				{
					count++;
				}
					
			}while ((count<2) && (result_withdraw==NULL));	
			 
			 /*check cancel*/
			 if(Flag_check==0) 
			 { 
			 /*0 is result return complete*/
			 /*2 is money not enough*/
			 if (result_withdraw->errno==0){
				mvwprintw(win,12,10,"Balance = %s",result_withdraw->balance_resulttype_u.balances.Balance);
	  		    mvwprintw(win,14,10,"ID Account = %s",result_withdraw->balance_resulttype_u.balances.ID_account);
			  	mvwprintw(win,16,10,"Date/Time %s",result_withdraw->balance_resulttype_u.balances.Date_Time);
			  	box(win,'|','-');
				}
				else		mvwprintw(win,15,10,"Money not enough");
			 } 
			  else mvwprintw(win,15,10,"Cancel");
			  break;

		/*transfer*/
		case '3': 
			  wclear(win);
			  box(win,'|','-');
			  mvwprintw(win,3,20,"%s","Welcome to ATM Simulation");
			  mvwprintw(win,6,10,"%s","Transfer Service");
			  mvwprintw(win,17,50,"Ctrl C : Cancel");
			  mvwprintw(win,8,10,"%s","Please input Destination ID Account: ");
			  wgetstr(win,di);
			  mvwprintw(win,10,10,"%s","Please input Transfer money: ");
			  wgetstr(win,itm);
          	
			  /*input value to procedure on remote*/ 
			  transfer_money.ID_account=id;
			  transfer_money.Destination_id=di;
			  transfer_money.Num_trans=itm;
			  count=0;

			  /*define and set wait time*/
			  tv.tv_sec=25;
			  tv.tv_usec=0;
			  clnt_control(cl,CLSET_TIMEOUT,&tv);

			  /*check signal Ctrl-C*/
			  signal(SIGINT,sig_pipe);
			  do{
				result_transfer=transfer_1(&transfer_money,cl);
				if (result_transfer==NULL) 
				{
					count++;
				}
			      }while ((count<2) && (result_transfer==NULL));	

			 /*check cancel*/
			 if(Flag_check==0) 
			 {
			  /*0 is result return complete*/
			  /*1 is destination ID wrong*/
			  /*2 is money not enough*/
			  if (result_transfer->errno==0)
			     {
			  	mvwprintw(win,12,10,"Balance = %s",result_transfer->transfer_resulttype_u.transfer.Balance);
			  	mvwprintw(win,13,10,"From ID account: %s",id); 
			  	mvwprintw(win,14,10,"To ID account:   %s",di);
			  	mvwprintw(win,15,10,"Date/Time %s",result_transfer->transfer_resulttype_u.transfer.Date_Time);
			  	box(win,'|','-');
			      }	
			  else if (result_transfer->errno==1)
							mvwprintw(win,15,10,"Destination ID account wrong");
			  else  if (result_transfer->errno==2)
							mvwprintw(win,15,10,"Money not enough");
			  }
			  else mvwprintw(win,15,10,"Cancel");
			  break;
			}	 
		wrefresh(win);
		endwin();
	}
	wrefresh(win);
	endwin();
}

/*function rollback*/
void roll_back()
{
	int sd,i,k;
	char *ch2,*ch1,ch4[8];
	struct sockaddr_in client_addr;
	struct hostent *hp;
	char buf[SIZE];
	int nread;
	ch1 = transfer_money.ID_account;
	ch2 = transfer_money.Destination_id;
	bzero(ch4,sizeof(ch4));
	for(k=0;k<4;k++)
	ch4[k] = ch1[k];
	for(i=0;i<4;i++)
	ch4[i+k] = ch2[i];

	/* clear memory of structure */
	bzero((char *)&client_addr,sizeof(client_addr));

	/* specific for communication */
	client_addr.sin_family = AF_INET;
	client_addr.sin_addr.s_addr = inet_addr("161.246.5.240");
	client_addr.sin_port = htons(PORT);
	
	/* create socket */
	    if((sd=socket(AF_INET,SOCK_STREAM,0)) < 0)
		   {
		   perror("create fail\n");
		   exit(1);
		  }

        /* connection request to host */
	   if((connect(sd,(struct client_addr *)&client_addr,sizeof(client_addr))) < 0)
	       {
		    perror("connect to host fail\n");
		    exit(1);
	        }

	if(send(sd,ch4,sizeof(ch4),0)==-1){
        perror("send");
	exit(1);
	     }
	 if(recv(sd,buf,SIZE,0)==-1){
	     perror("recv");
	     exit(1);
	     }
		mvwprintw(win,15,10,"%s",buf);
	        close(sd);
}

/*function check signal interrupt*/
static void sig_pipe(t)
int t;
{
    Flag_check = 1;
    /*call function roll_back on local system*/
/*	roll_back();*/
    clnt_destroy(cl);
    roll_back();
    return;
}

