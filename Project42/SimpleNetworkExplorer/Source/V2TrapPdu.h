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



#ifndef __V2TRAPPDU_H__
#define __V2TRAPPDU_H__

#ifndef __V1PDU_H__
#include "V1Pdu.h"
#endif


class V2TrapPdu : public V1Pdu
{
  private:


  protected:


  public:

    V2TrapPdu();
    ~V2TrapPdu();
    V2TrapPdu(const V2TrapPdu& right);

};
#endif
