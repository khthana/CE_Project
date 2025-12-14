#include <stdio.h>

#ifdef _WIN32
#include <windows.h>
#else
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <string.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <stdlib.h>

typedef boolean_t BOOL;
//typedef boolean_t bool;
typedef int SOCKET;
typedef struct sockaddr_in SOCKADDR_IN;
typedef struct hostent HOSTENT;
typedef longlong_t __int64;

#define TRUE B_TRUE
#define FALSE B_FALSE
#define false B_FALSE
#define true B_TRUE
#define INVALID_SOCKET -1
#define INADDR_NONE -1
#define FIONBIO O_NDELAY

#define WSAGetLastError() errno
#define ioctlsocket(a, b, c) fcntl(a, b, c)
#define closesocket(x) close(x)
#define stricmp(a, b) strcasecmp(a, b)
#endif
