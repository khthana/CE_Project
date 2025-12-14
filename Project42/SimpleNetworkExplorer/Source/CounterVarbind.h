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



#ifndef __COUNTERVARBIND_H__
#define __COUNTERVARBIND_H__

#ifndef __SCALARVARBIND_H__
#include "ScalarVarbind.h"
#endif

#include "Build.h"
#include "SnmpTypes.h"

class CounterVarbind : public ScalarVarbind
{
  private:


  protected:



  public:
    
    CounterVarbind();
    CounterVarbind(unsigned char* &pduPart);
    CounterVarbind(unsigned long counter);
    ~CounterVarbind();

    virtual void            Build(unsigned char*& pdu);
};
#endif
