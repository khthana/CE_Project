	/* 	Stream socket for server implemant*/

#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<signal.h>
#include<stdio.h>
#include<netdb.h>

int s, ls;			/*connected and listen socket descriptor*/
struct hostent *client_name;	/*pointer to host info for remote hosts*/
struct servent *service_port;	/*pointer to services information*/
long timevar;			/*contains time returns by time() */
char *ctime();			/*declare time formatting routine*/
struct  linger linger;	    	/*graceful close used setting SO-LINGER*/
struct  sockaddr_in myaddr_in;	/*for local socket address*/
struct  sockaddr_in peeraddr_in;/*for peer socket address*/

#define BUFLEN  1024		/*size of buffer*/
main(argc, argv)
int argc;
char *argv[];
{
	int addrlen;

	/* clear out address structure*/
	memset ((char *)&myaddr_in, 0,sizeof(struct sockaddr_in));
	memset ((char *)&peeraddr_in, 0,sizeof(struct sockaddr_in));
	
	/* setup address structure for socket */
	myaddr_in.sin_family = AF_INET;
	myaddr_in.sin_addr.s_addr = INADDR_ANY;
	service_port = getservbyname("port_tcp", "tcp");
	if(service_port == NULL){
		fprintf(stderr, "%s: port_tcp not found in /etc/services \n",argv[0]);
		exit(1);
	}
        myaddr_in.sin_port = service_port->s_port;
        ls = socket(AF_INET, SOCK_STREAM, 0);
        if(ls == -1){
                perror(argv[0]);
                fprintf(stderr, "%s: unable to listen on socket\n", argv[0]);
                exit(1);
        }

	/* bind socket */
	if(bind (ls, &myaddr_in, sizeof(struct sockaddr_in)) == -1) {
		perror(argv[0]);
		fprintf(stderr, "%s: unable to bind address\n",argv[0]);
		exit(0);
	}

	/* listen socket so remote users can contact. */
	if(listen(ls, 5) == -1){
		perror(argv[0]);
		fprintf(stderr, "%s: unable to listen on socket\n", argv[0]);
		exit(1);
	}

        setpgrp();		/* set parent process */
	/* fork new process for new client connecting */
        switch(fork()) {
        case -1:
                perror(argv[0]);
                fprintf(stderr, "%s: unable to fork daemon\n", argv[0]);
                exit(1);
        case 0:
                fclose(stdin);
                fclose(stderr);
                signal(SIGCLD, SIG_IGN);
                for(;;) {		
                        addrlen = sizeof(struct sockaddr_in);

			/*Accept call will be block until 
			 *a new connection arrives,
			 *return the address  of peer connecting.
			*/
			s = accept(ls, &peeraddr_in, &addrlen);
                        if( s == -1) exit(1);

                        switch(fork()) {
                        case -1:
                                exit(1);
                        case 0:		/* Child process come here*/
                                server();
                                exit(0);

			/* Child process out of file descriptor space
			 * to close the new accept socket.
			*/
                        default:
                                close(s);
			}

        	}
         default:	/*parent process come here.*/
                exit(0);
	}
}

	/* Server procedure handle the new process from
	 * accept socket connecting from remote client.
	*/
server()
{
        int reqcnt = 0;		/*keeps count of request*/
        char buf[BUFLEN]; 	/*buffer keeps data 1024 bytes*/
	char *inet_ntoa();	
	char *hostname;		/*points to the remote host,s name*/
        int len, len1;

	/*close the listen socket*/	
        close(ls);

	/*Search internet address from the remote client
	 *by peer socket .
	*/
        client_name = gethostbyaddr((char *) &peeraddr_in.sin_addr,
                                    sizeof(struct in_addr),
                                    peeraddr_in.sin_family);
        if(client_name == NULL) {

		hostname = inet_ntoa(peeraddr_in.sin_addr);
        } else {
                hostname = client_name->h_name;		
          } 
        time (&timevar);
        printf("Connect from %s CLIENT on port %u at %s",
                hostname, ntohs(peeraddr_in.sin_port), ctime(&timevar));

		/*Set socket close ,when data sent on finish*/
        linger.l_onoff = 1;
        linger.l_linger =1;

        if(setsockopt(s, SOL_SOCKET, SO_LINGER, &linger,
                        sizeof(linger)) == -1) {
errout: printf("connection with %s aborted on error \n", hostname);
        exit(1);
        }

	/* When the remote client shutdown for sender, read call return zero */
	while(len = read(s, buf, BUFLEN - 1)){		
		if(len == -1) 	goto errout;	/* check no success recvice */
		sleep(1);
		buf[len]='\0';
		reqcnt++;	/* Increment the request counter */
		time(&timevar);
		printf(" SERVER return %s time at %s", buf, ctime(&timevar));

		/* write call send buf return to server  */
		len1 = write(s, buf, BUFLEN);
		if(len1 == -1) goto errout;  /* return buf to client */
	}

	/* close ls socket when connection finish */
    close(ls);
	/* print message finish */
    time(&timevar);
    printf("completed %s PORT %u, %d packets,TIME at %s \n",
            hostname, ntohs(peeraddr_in.sin_port), reqcnt, ctime(&timevar));
}
