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



#ifndef __V1GETPDU_H__
#define __V1GETPDU_H__

#ifndef __V1PDU_H__
#include "V1Pdu.h"
#endif

class IntVarbind;


class V1GetPdu : public V1Pdu
{
  private:


  protected:



  public:

    V1GetPdu();
    ~V1GetPdu();
    V1GetPdu(const V1GetPdu& right);

};
#endif
