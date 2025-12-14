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


#ifndef __UDPSERVER_H__
#define __UDPSERVER_H__

#include "Udp.h"

class UdpServer : public Udp
{

 private:


 protected:


 public:

  UdpServer(int port, unsigned int timeout = 5);
  ~UdpServer();

  int                  Send(const char* buffer, 
			    unsigned int length);
    
  int                  Send(Packet* p);
  Packet*              Receive(int);

  const char*          Receive();
};


#endif












