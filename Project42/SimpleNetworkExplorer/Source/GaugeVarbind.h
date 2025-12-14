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



#ifndef __GAUGEVARBIND_H__
#define __GAUGEVARBIND_H__

#ifndef __SCALARVARBIND_H__
#include "ScalarVarbind.h"
#endif

#include "SnmpTypes.h"

class GaugeVarbind : public ScalarVarbind
{
  private:

   

  protected:



  public:
    
    GaugeVarbind();
    GaugeVarbind(unsigned char* &pduPart);
    GaugeVarbind(unsigned long value);
    ~GaugeVarbind();

    virtual void             Build(unsigned char*& pdu);
};
#endif
