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



#ifndef __INTVARBIND_H__
#define __INTVARBIND_H__

#ifndef __SCALARVARBIND_H__
#include "ScalarVarbind.h"
#endif

#include "SnmpTypes.h"

unsigned int  ComputeIntValue(unsigned char* &pduPart);
unsigned long ComputeLongValue(unsigned char* &pduPart);

class IntVarbind : public ScalarVarbind
{
  private:



  protected:



  public:
    
    IntVarbind();
    IntVarbind(unsigned char* &pduPart);
    IntVarbind(int value);
    ~IntVarbind();

    virtual void              Build(unsigned char*& pdu);
};
#endif
