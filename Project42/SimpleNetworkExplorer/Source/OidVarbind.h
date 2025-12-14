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



#ifndef __OIDVARBIND_H__
#define __OIDVARBIND_H__

#ifndef __VARBIND_H__
#include "Varbind.h"
#endif

#include "SnmpTypes.h"

class OidVarbind : public Varbind
{
  private:

    unsigned char*    mData;

  protected:



  public:
    
    OidVarbind();
    OidVarbind(unsigned char* &pduPart);
    OidVarbind(char* string);
    ~OidVarbind();
  
    void                   Value(char* value);
    const char*            Value();
    virtual const char*    Printable();

    virtual void           Build(unsigned char*& pdu);
    virtual unsigned char* Data();
};
#endif
