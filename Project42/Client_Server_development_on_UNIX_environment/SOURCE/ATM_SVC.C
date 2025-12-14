#include <stdio.h>
#include <rpc/rpc.h>
#include <signal.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <sys/resource.h>
#include <syslog.h>
#include "atm.h"

#ifdef DEBUG
#define RPC_SVC_FG
#endif
#define _RPCSVC_CLOSEDOWN 120
#define DATAUSR "customer.dat"
#define DATABL "balance.dat"
#define TEMP "temp.dat"
#define TEMP_DS "temp_des.dat"

static void atmprog_1();
static void closedown();

static int _rpcpmstart = 0;		/* Started by a port monitor ? */
static int _rpcfdtype = 0;		/* Whether Stream or Datagram ? */
static int _rpcsvcdirty = 0;		/* Still serving ? */

main()
{
	register SVCXPRT *transp;
	int sock;
	int proto;
	struct sockaddr_in saddr;
	int asize = sizeof(saddr);

	if (getsockname(0, (struct sockaddr *)&saddr, &asize) == 0) {
		int ssize = sizeof(int);

		if (saddr.sin_family != AF_INET)
			exit(1);
		if (getsockopt(0, SOL_SOCKET, SO_TYPE,
				(char *)&_rpcfdtype, &ssize) == -1)
			exit(1);
		sock = 0;
		_rpcpmstart = 1;
		proto = 0;
		openlog("atm", LOG_PID, LOG_DAEMON);
	} else {
#ifndef RPC_SVC_FG
		int size;
		struct rlimit rl;
		int i, pid;

		pid = fork();
		if (pid < 0) {
			perror("cannot fork");
			exit(1);
		}
		if (pid)
			exit(0);
		rl.rlim_max = 0;
		getrlimit(RLIMIT_NOFILE, &rl);
		if ((size = rl.rlim_max) == 0)
			exit(1);
		for (i = 0 ; i < size ; i++)
			(void) close(i);
		i = open("/dev/console", O_RDWR);
		(void) dup2(i, 1);
		(void) dup2(i, 2);
		setsid();
		openlog("atm", LOG_PID, LOG_DAEMON);
#endif
		sock = RPC_ANYSOCK;
		(void) pmap_unset(ATMPROG, ATMVERS);
	}

	if ((_rpcfdtype == 0) || (_rpcfdtype == SOCK_DGRAM)) {
		transp = svcudp_create(sock);
		if (transp == NULL) {
			_msgout("cannot create udp service.");
			exit(1);
		}
		if (!_rpcpmstart)
			proto = IPPROTO_UDP;
		if (!svc_register(transp, ATMPROG, ATMVERS, atmprog_1, proto)) {
			_msgout("unable to register (ATMPROG, ATMVERS, udp).");
			exit(1);
		}
	}

	if ((_rpcfdtype == 0) || (_rpcfdtype == SOCK_STREAM)) {
		if (_rpcpmstart)
			transp = svcfd_create(sock, 0, 0);
		else
			transp = svctcp_create(sock, 0, 0);
		if (transp == NULL) {
			_msgout("cannot create tcp service.");
			exit(1);
		}
		if (!_rpcpmstart)
			proto = IPPROTO_TCP;
		if (!svc_register(transp, ATMPROG, ATMVERS, atmprog_1, proto)) {
			_msgout("unable to register (ATMPROG, ATMVERS, tcp).");
			exit(1);
		}
	}

	if (transp == (SVCXPRT *)NULL) {
		_msgout("could not create a handle");
		exit(1);
	}
	if (_rpcpmstart) {
		(void) signal(SIGALRM, closedown);
		(void) alarm(_RPCSVC_CLOSEDOWN);
	}
	svc_run();
	_msgout("svc_run returned");
	exit(1);
	/* NOTREACHED */
}

static void
atmprog_1(rqstp, transp)
	struct svc_req *rqstp;
	register SVCXPRT *transp;
{
	union {
		usrinfo validate_1_arg;
		char *check_balance_1_arg;
		withdraw_moneytype withdraw_1_arg;
		transfer_moneytype transfer_1_arg;
	} argument;
	char *result;
	bool_t (*xdr_argument)(), (*xdr_result)();
	char *(*local)();

	_rpcsvcdirty = 1;
	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply(transp, xdr_void, (char *)NULL);
		_rpcsvcdirty = 0;
		return;

	case VALIDATE:
		xdr_argument = xdr_usrinfo;
		xdr_result = xdr_usrinfo;
		local = (char *(*)()) validate_1;
		break;

	case CHECK_BALANCE:
		xdr_argument = xdr_wrapstring;
		xdr_result = xdr_balance_resulttype;
		local = (char *(*)()) check_balance_1;
		break;

	case WITHDRAW:
		xdr_argument = xdr_withdraw_moneytype;
		xdr_result = xdr_balance_resulttype;
		local = (char *(*)()) withdraw_1;
		break;

	case TRANSFER:
		xdr_argument = xdr_transfer_moneytype;
		xdr_result = xdr_transfer_resulttype;
		local = (char *(*)()) transfer_1;
		break;

	default:
		svcerr_noproc(transp);
		_rpcsvcdirty = 0;
		return;
	}
	bzero((char *)&argument, sizeof(argument));
	if (!svc_getargs(transp, xdr_argument, &argument)) {
		svcerr_decode(transp);
		_rpcsvcdirty = 0;
		return;
	}
	result = (*local)(&argument, rqstp);
	if (result != NULL && !svc_sendreply(transp, xdr_result, result)) {
		svcerr_systemerr(transp);
	}
	if (!svc_freeargs(transp, xdr_argument, &argument)) {
		_msgout("unable to free arguments");
		exit(1);
	}
	_rpcsvcdirty = 0;
	return;
}

static
_msgout(msg)
	char *msg;
{
#ifdef RPC_SVC_FG
	if (_rpcpmstart)
		syslog(LOG_ERR, msg);
	else
		(void) fprintf(stderr, "%s\n", msg);
#else
	syslog(LOG_ERR, msg);
#endif
}

static void
closedown()
{
	if (_rpcsvcdirty == 0) {
		extern fd_set svc_fdset;
		static int size;
		int i, openfd;

		if (_rpcfdtype == SOCK_DGRAM)
			exit(0);
		if (size == 0) {
			struct rlimit rl;

			rl.rlim_max = 0;
			getrlimit(RLIMIT_NOFILE, &rl);
			if ((size = rl.rlim_max) == 0) {
				return;
			}
		}
		for (i = 0, openfd = 0; i < size && openfd < 2; i++)
			if (FD_ISSET(i, &svc_fdset))
				openfd++;
		if (openfd <= 1)
			exit(0);
	}
	(void) alarm(_RPCSVC_CLOSEDOWN);
}
