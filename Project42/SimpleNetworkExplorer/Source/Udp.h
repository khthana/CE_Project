//  Copyright (c) 1999 Network Computing Technologies, Inc.
//  All rights reserved.
// 
//  Redistribution and use of executable software is never 
//  permitted without the express written permission of 
//  Network Computing Technologies, Inc.
// 
//  Distribution of the source is never permitted without 
//  the express written permission of 
//  Network Computing Technologies, Inc.
// 
//  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
//  IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
//  WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.


#ifndef __UDP_H__
#define __UDP_H__

#include <string.h>
#include <stdlib.h>

#ifdef _WIN32
#include <winsock.h>
#endif

#include "compat.h"

class Packet;

class Udp
{

 private:

  int                     mPort;
  unsigned int            mReadBufferSize;
  char*                   mReadBuffer;
  int                     mReadLength;
  long                    mErrorCode;
  unsigned int            mTimeout;
  void                    CommonInit();



 protected:

  SOCKET                  mSocket;  
  struct sockaddr_in      mSaddr;
  struct sockaddr_in      mLaddr;
  BOOL                    mIsReady;
  void                    GetErrorCode();
  int                     Send(const char* buffer, 
			       unsigned int length,
			       struct sockaddr* s,
			       int sLen);

  int                     Send(Packet* p,
			       struct sockaddr* s,
			       int sLen);
  Packet*                 Receive(int);

  const char*             Receive(struct sockaddr* s,
				  int* sLen);

 public:

  Udp();
  Udp(int port, unsigned int timeout = 5);
  ~Udp();

  void         ReadBufferSize(unsigned int size);
  unsigned int ReadBufferSize() { return mReadBufferSize; }

  void         Port(int port);
  int          Port()  { return mPort; }

  SOCKET       Socket() { return mSocket; }

  BOOL         IsReady()  { return mIsReady; }

  int          ReadLength() { return mReadLength; }

  long         ErrorCode()  { return mErrorCode; }

  unsigned int Timeout() { return mTimeout; }
  void         Timeout(unsigned int timeout) { mTimeout = timeout; }

};

#endif


























