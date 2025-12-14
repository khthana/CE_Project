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



#ifndef __V1GETNEXTPDU_H__
#define __V1GETNEXTPDU_H__

#ifndef __V1PDU_H__
#include "V1Pdu.h"
#endif

class IntVarbind;


class V1GetNextPdu : public V1Pdu
{
  private:


  protected:



  public:

    V1GetNextPdu();
    ~V1GetNextPdu();
    V1GetNextPdu(const V1GetNextPdu& right);

};
#endif
