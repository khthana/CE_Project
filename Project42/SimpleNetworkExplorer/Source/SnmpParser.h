//  Copyright (c) 1997 Network Computing Technologies, Inc.
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



#ifndef __SNMPPARSER_H__
#define __SNMPPARSER_H__

#if _WIN32
#  include <windows.h>
#else
#include "compat.h"
#endif

class Packet;

class SnmpParser
{

  private:

    BOOL         mIown;
    Packet*      mPacket;
    unsigned int mIndex;

    void         decodeLength(unsigned char* pduField, long* value);
    void         encodeLength(unsigned char* pduField, long* value);

    void         decodeTag(unsigned char* pduField, long* value);
    void         encodeTag(unsigned char* pduField, long* value);


  protected:



  public:

    SnmpParser(unsigned char* pdu, unsigned int length);
    ~SnmpParser();

    Packet*  packet();

};
#endif
