/*	Datagram socket server implement */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <netdb.h>

int s;				/* socket descriptor */

#define BUFFERSIZE	1024	/* maximum size of packets to be received */
int cc;				/* contains the number of bytes read */
char buffer[BUFFERSIZE];	/* buffer for packets to be read into */

struct hostent *client_name;	/* pointer host info for the remote client*/
struct servent *service_port;	/* pointer service information */

struct sockaddr_in myaddr_in;	/* for local socket address */
struct sockaddr_in clientaddr_in;	/* for client's socket address */

main(argc, argv)
int argc;
char *argv[];
{
	int addrlen;
	char *ctime();
	long timevar;		/*contain time return by time()*/
	char *inet_ntoa();	
	char *hostname;		/*points to remote host's name */
		/* clear out address structures */
	memset ((char *)&myaddr_in, 0, sizeof(struct sockaddr_in));
	memset ((char *)&clientaddr_in, 0, sizeof(struct sockaddr_in));

		/* Set up address structure for the socket. */
	myaddr_in.sin_family = AF_INET;
	service_port = getservbyname ("port_udp", "udp");
	if (service_port == NULL) {
		printf("%s: port_udp not found in /etc/services\n",
				argv[0]);
		exit(1);
	}
	myaddr_in.sin_port = service_port->s_port;

		/* Create the socket. */
	s = socket (AF_INET, SOCK_DGRAM, 0);
	if (s == -1) {
		perror(argv[0]);
		printf("%s: unable to create socket\n", argv[0]);
		exit(1);
	}
		/* Bind the server's address to the socket. */
	if (bind(s, &myaddr_in, sizeof(struct sockaddr_in)) == -1) {
		perror(argv[0]);
		printf("%s: unable to bind address\n", argv[0]);
		exit(1);
	}

	setpgrp();	/* set parent process */

	switch (fork()) {	/* Get new process for parent process */
	case -1:		/* Unable to fork, for some reason. */
		perror(argv[0]);
		printf("%s: unable to fork daemon\n", argv[0]);
		exit(1);

	case 0:			/* The child process (daemon) comes here. */
			/* Close stdin, stdout, and stderr so that they will
			 * not be kept open.  From now on, the daemon will
			 * not report any error messages.  This daemon
			 * will loop forever, waiting for requests and
			 * responding to them.
			 */
		close(stdin);
		close(stdout);
		close(stderr);
			/* This will open the /etc/hosts file and keep
			 * it open.  This will make accesses to it faster.
			 */
		sethostent(1);
		for(;;) {
			addrlen = sizeof(struct sockaddr_in);
				/* Recvfrom call will block until 
				 * new the remote client connect 
				 * arrives,return the address
				 * of client on clientaddr_in pointer
				 * and end of buffer on cc intger.
				 */
			cc = recvfrom(s, buffer, BUFFERSIZE - 1, 0,
						&clientaddr_in, &addrlen);
			if ( cc == -1) exit(1);

			/* Search  the remote name from /etc/hosts */
			client_name = gethostbyaddr((char *)&clientaddr_in.sin_addr,
						sizeof(struct in_addr),
						clientaddr_in.sin_family);
			if( client_name == NULL) {
				hostname = inet_ntoa(clientaddr_in.sin_addr);
			} else {
				hostname = client_name->h_name;
			}
				 /* Make null terminated in buffer */
			buffer[cc]='\0';
			sleep(1);

			time(&timevar);
                        printf(" Request from %s Client message<%s> at %s", 
					hostname, buffer, ctime(&timevar));
			sendto (s, buffer, BUFFERSIZE,
					0, &clientaddr_in, addrlen);
		}

	default:		/* Parent process comes here. */
		exit(0);
	}
}
