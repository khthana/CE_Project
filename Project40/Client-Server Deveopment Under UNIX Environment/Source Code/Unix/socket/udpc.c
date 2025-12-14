/*  Datagram socket for client implement */
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/errno.h>
#include <netinet/in.h>
#include <stdio.h>
#include <signal.h>
#include <netdb.h>

extern int errno;

int s;				/* socket descriptor */

struct hostent *server_name;		/* pointer to host info for nameserver host */
struct servent *service_port;		/* pointer to service information */

struct sockaddr_in myaddr_in;	/* for local socket address */
struct sockaddr_in servaddr_in;	/* for server socket address */

#define RETRIES	5		/* number of times to retry before givin up */
#define BUFFERSIZE 1024		/* maximum size of packet to be read into */

char buffer[BUFFERSIZE];	/*buffer for packet to be read into */
/*
 *			H A N D L E R
 *
 *	This routine is the signal handler for the alarm signal.
 *	It simply re-installs itself as the handler and returns.
 */
handler()
{
	signal(SIGALRM, handler);
}

main(argc, argv)
int argc;
char *argv[];
{
	int i,count ;
	int retry = RETRIES;		/* holds the retry count */
	char *inet_ntoa();

	if (argc != 3) {
		fprintf(stderr, "Usage: %s <nameserver> <message> \n", argv[0]);
		exit(1);
	}

		/* clear out address structures */
	memset ((char *)&myaddr_in, 0, sizeof(struct sockaddr_in));
	memset ((char *)&servaddr_in, 0, sizeof(struct sockaddr_in));

		/* Set up the server address. */
	servaddr_in.sin_family = AF_INET;
		/* Get the host information for the server's hostname*/ 
	server_name = gethostbyname (argv[1]);
	if ( server_name == NULL) {
		fprintf(stderr, "%s: %s not found in /etc/hosts\n",
				argv[0], argv[1]);
		exit(1);
	}
	servaddr_in.sin_addr.s_addr = ((struct in_addr *)(server_name->h_addr))->s_addr;

		/* Search port number from /etc/services */
	service_port = getservbyname ("port_udp", "udp");
	if (service_port == NULL) {
		fprintf(stderr, "%s: port_udp not found in /etc/services\n",
				argv[0]);
		exit(1);
	}
	servaddr_in.sin_port = service_port->s_port;

		/* Create the socket. */
	s = socket (AF_INET, SOCK_DGRAM, 0);
	if (s == -1) {
		perror(argv[0]);
		fprintf(stderr, "%s: unable to create socket\n", argv[0]);
		exit(1);
	}
		/* Bind socket to some local address so that the
		 * server can send the reply back.  A port number
		 * of zero will be used so that the system will
		 * assign any available port number.  An address
		 * of INADDR_ANY will be used so we do not have to
		 * look up the internet address of the local host.
		 */
	myaddr_in.sin_family = AF_INET;
	myaddr_in.sin_port = 0;
	myaddr_in.sin_addr.s_addr = INADDR_ANY;
	if (bind(s, &myaddr_in, sizeof(struct sockaddr_in)) == -1) {
		perror(argv[0]);
		fprintf(stderr, "%s: unable to bind socket\n", argv[0]);
		exit(1);
	}
		/* Set up alarm signal handler. */
	signal(SIGALRM, handler);

	for (count = 1; count <= 10; count ++) {

		/* Send the request to the nameserver. */
again:	if (sendto (s, argv[2], strlen(argv[2]), 0, &servaddr_in,
				sizeof(struct sockaddr_in)) == -1) {
		perror(argv[0]);
		fprintf(stderr, "%s: unable to send request\n", argv[0]);
		exit(1);
	}
		/* Set up a timeout so I don't hang in case the packet
		 * gets lost.  After all, UDP does not guarantee
		 * delivery.
		 */
	alarm(5);
		/* Wait for the reply to come in.  We assume that
		 * no messages will come from any other source,
		 * so that we do not need to do a recvfrom nor
		 * check the responder's address.
		 */
	if (recv (s, &buffer, BUFFERSIZE, 0) == -1) {
		if (errno == EINTR) {
				/* Alarm went off and aborted the receive.
				 * Need to retry the request if we have
				 * not already exceeded the retry limit.
				 */
			if (--retry) {
				goto again;
			} else {
				printf("Unable to get response from");
				printf(" %s after %d attempts.\n",
						argv[1], RETRIES);
				exit(1);
			}
		} else {
			perror(argv[0]);
			fprintf(stderr, "%s: unable to receive response\n",
								argv[0]);
			exit(1);
		}
	}
	alarm(0);
	printf(" Recived message< %s >from server\n",buffer);
	}
}

