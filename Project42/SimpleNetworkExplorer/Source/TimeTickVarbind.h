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



#ifndef __TIMETICKVARBIND_H__
#define __TIMETICKVARBIND_H__

#ifndef __SCALARVARBIND_H__
#include "ScalarVarbind.h"
#endif

#include "SnmpTypes.h"

class TimetickVarbind : public ScalarVarbind
{
  private:


  protected:



  public:
    
    TimetickVarbind();
    TimetickVarbind(unsigned char* &pduPart);
    TimetickVarbind(unsigned long timetick);
    ~TimetickVarbind();

    virtual void           Build(unsigned char*& pdu);
   
};
#endif
