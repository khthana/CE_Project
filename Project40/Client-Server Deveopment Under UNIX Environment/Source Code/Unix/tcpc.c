	/*  Stream socket for client implement  */

#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<stdio.h>
#include<netdb.h>

int s;				/*connected socket desriptor */
struct hostent *server_name;	/* pointer for name's the remote host*/
struct servent *service_port;	/* pointer for services information*/
long timevar;			/*contain time return time()*/
char *ctime();

struct sockaddr_in myaddr_in;	/*local socket address */
struct sockaddr_in peeraddr_in;	/*peer socket address */
#define BUFLEN 1024		/* size of buffer*/

main(argc, argv)
int argc;
char *argv[];
{
        int addrlen, i, check;
        char buf[BUFLEN];
        if(argc != 2) {
                fprintf(stderr, "usage: %s<remote host>\n", argv[0]);
                exit(2);
        }
	/* clear out address structure*/
        memset((char *)&myaddr_in, 0, sizeof(struct sockaddr_in));
        memset((char *)&peeraddr_in, 0, sizeof(struct sockaddr_in));

	/* Setup address structure socket for will connect*/
        peeraddr_in.sin_family = AF_INET;  
	        server_name = gethostbyname(argv[1]);
        if(server_name == NULL) {
                fprintf(stderr, "%s: %s not found in /etc/hosts \n",
                                argv[0], argv[1]);
                exit(1);
         }
         peeraddr_in.sin_addr.s_addr = ((struct in_addr *)(server_name->h_addr))->s_addr;

	 /* Search number port from name port*/
	 service_port = getservbyname("port_tcp", "tcp");
          if(service_port == NULL) {
                    fprintf(stderr, "%s: port_tcp not found in /etc/services\n",
                                        argv[0]);
                    exit(1);
           }

           peeraddr_in.sin_port = service_port->s_port;	/* get number port to endpoint */ 

	   /* create  the socket */
           s = socket( AF_INET, SOCK_STREAM, 0);
           if(s == -1) {
                perror(argv[0]);
                fprintf(stderr, "%s: unable to create socket\n", argv[0]);
                exit(1);
           }

		/* Try connect to remote server at peeraddr */
           if(connect(s, &peeraddr_in, sizeof(struct sockaddr_in)) == -1) {
                perror(argv[0]);
                fprintf(stderr, "%s: unable to  connect to remote\n", argv[0]);
                exit(1);
            }

            addrlen = sizeof(struct sockaddr_in);
            if(getsockname(s, &myaddr_in, &addrlen) == -1) {
                perror(argv[0]);
                fprintf(stderr, "%s: unable to read socket address\n", argv[0]);
                exit(1);
             }
             time(&timevar);
             printf("Connect to %s SERVER on port %u at %s",
                        argv[1], ntohs(myaddr_in.sin_port), ctime(&timevar));
             sleep(2);

		/* send buf and recives buf from the remote server*/
             for(i=1; i<=10; i++) {
                *buf =  47+i;
                check = write(s, buf, BUFLEN -1 ) ;
		if( check == -1 ) {
                        fprintf(stderr, "%s connection aborted on error ", argv[0]);
                	fprintf(stderr, " on send order number %d\n",i );
                        exit(1);
              	}
		buf[check]='\0';
                check = read(s, buf, BUFLEN);
                if(check == -1) {
                   perror(argv[0]);
                   fprintf(stderr, "%s: errer reading result\n", argv[0]);
                   exit(1);
                }
                printf("Received result number %s\n ",buf);
	    }	

		/* Disconnect with the remote server*/
	    if(shutdown(s, 1) == -1) {
		   perror(argv[0]);
	           fprintf(stderr,  "%s: unable to shutdown socket\n", argv[0]);
	           exit(1);
	    }

		/* Print message end of connection the remote server*/
              	time(&timevar);
              	printf("All done at %s", ctime(&timevar));

}
