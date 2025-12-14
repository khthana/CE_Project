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



#ifndef __V1PDU_H__
#define __V1PDU_H__

#ifndef __PDU_H__
#include "Pdu.h"
#endif

class IntVarbind;


class V1Pdu : public Pdu
{
  private:

    IntVarbind*      mRequestIdVb;
    IntVarbind*      mErrorStatusVb;
    IntVarbind*      mErrorIndexVb;


  protected:

    unsigned char    mType;

  public:

    V1Pdu();
    virtual ~V1Pdu();
    V1Pdu(const V1Pdu& right);

    virtual int              RequestId();
    virtual void             RequestId(int value);

    virtual int              ErrorIndex();
    virtual void             ErrorIndex(int value);

    virtual int              ErrorStatus();
    virtual void             ErrorStatus(int value);

    virtual void             Parse(unsigned char*& buffer);

    virtual void             Build(unsigned char*& pdu);
    virtual unsigned int     Length();

    virtual void             MakeResponsePdu();

    virtual unsigned char    Type() { return mType; }

};
#endif
