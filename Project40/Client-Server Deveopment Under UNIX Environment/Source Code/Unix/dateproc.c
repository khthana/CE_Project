/*
 * dateproc.c - remote procedures; called by server stub.
 */

#include <rpc/rpc.h>
#include <time.h>

/*
 * Return the binary date and time.
 */

long *bin_date_1()
{
	static long timeval;	/* must be static */

	timeval = time((long *)0);

	return(&timeval);
}

/*
 * Convert a binary time and return a human readable sring.
 */

char **str_date_1(bintime)
long *bintime;
{
	static char *ptr;		/* must be static */

	ptr = ctime(bintime);


	return (&ptr);
}
