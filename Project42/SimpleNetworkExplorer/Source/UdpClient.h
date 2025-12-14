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


#ifndef __UDPCLIENT_H__
#define __UDPCLIENT_H__

#include "Udp.h"

class UdpClient : public Udp
{

 private:

  char*                mHost;
  void                 CommonInit();

 protected:


 public:

  UdpClient();
  UdpClient(int port, char* host);
  ~UdpClient();

  char*                Host() { return mHost; }
  void                 Host(char* host);

  int                  Send(const char* buffer, 
			    unsigned int length);
    
  int                  Send(Packet* p);
  Packet*              Receive(int);

  const char*          Receive();
};

#endif
