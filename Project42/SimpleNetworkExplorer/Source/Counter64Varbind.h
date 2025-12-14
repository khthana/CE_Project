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



#ifndef __COUNTER64VARBIND_H__
#define __COUNTER64VARBIND_H__

#ifndef __SCALAR64VARBIND_H__
#include "Scalar64Varbind.h"
#endif

#include "Build.h"
#include "SnmpTypes.h"

class Counter64Varbind : public Scalar64Varbind
{
  private:


  protected:



  public:
    
    Counter64Varbind();
    Counter64Varbind(unsigned char* &pduPart);
    Counter64Varbind(__int64 counter);
    ~Counter64Varbind();

    virtual void            Build(unsigned char*& pdu);
};
#endif
