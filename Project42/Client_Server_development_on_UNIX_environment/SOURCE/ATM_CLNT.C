#include <rpc/rpc.h>
#include "atm.h"
#include <time.h>

#ifdef hpux

#ifndef NULL
#define NULL  0
#endif  /* NULL */

#endif  /* hpux */
#define DATAUSR "customer.dat"
#define DATABL "balance.dat"
#define TEMP "temp.dat"
#define TEMP_DS "temp_des.dat"

/* Default timeout can be changed using clnt_control() */
static struct timeval TIMEOUT = { 25, 0 };

usrinfo *
validate_1(argp, clnt)
	usrinfo *argp;
	CLIENT *clnt;
{
	static usrinfo res;

	bzero((char *)&res, sizeof(res));
	if (clnt_call(clnt, VALIDATE, xdr_usrinfo, argp, xdr_usrinfo, &res, TIMEOUT) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&res);
}

balance_resulttype *
check_balance_1(argp, clnt)
	char **argp;
	CLIENT *clnt;
{
	static balance_resulttype res;

	bzero((char *)&res, sizeof(res));
	if (clnt_call(clnt, CHECK_BALANCE, xdr_wrapstring, argp, xdr_balance_resulttype, &res, TIMEOUT) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&res);
}

balance_resulttype *
withdraw_1(argp, clnt)
	withdraw_moneytype *argp;
	CLIENT *clnt;
{
	static balance_resulttype res;

	bzero((char *)&res, sizeof(res));
	if (clnt_call(clnt, WITHDRAW, xdr_withdraw_moneytype, argp, xdr_balance_resulttype, &res, TIMEOUT) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&res);
}

transfer_resulttype *
transfer_1(argp, clnt)
	transfer_moneytype *argp;
	CLIENT *clnt;
{
	static transfer_resulttype res;

	bzero((char *)&res, sizeof(res));
	if (clnt_call(clnt, TRANSFER, xdr_transfer_moneytype, argp, xdr_transfer_resulttype, &res, TIMEOUT) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&res);
}
