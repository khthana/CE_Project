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

#ifndef __SCALAR64VARBIND_H__
#define __SCALAR64VARBIND_H__

#ifndef __SCALARVARBIND_H__
#include "Varbind.h"
#endif

#include "compat.h"

class Scalar64Varbind : public Varbind
{

  private:


  protected:

    __int64        mValue;

  public:


    Scalar64Varbind(unsigned short type, const char* typeString);
    Scalar64Varbind(unsigned char* &pduPart, 
		    unsigned short type, 
		    const char* typeString);
    Scalar64Varbind();
    virtual ~Scalar64Varbind(){};


    virtual void             Value(__int64 value);
    virtual __int64          Value() { return mValue; }

    virtual unsigned char*   Data();
    virtual const char*      Printable();
    virtual void             Build(unsigned char*& pdu);
      

};
#endif
