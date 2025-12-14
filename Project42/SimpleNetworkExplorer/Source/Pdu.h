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



#ifndef __PDU_H__
#define __PDU_H__

#include "Build.h"

#if _WIN32
#  include <windows.h>
#endif

class Pdu : public Builder
{

  private:


  protected:


  public:

    Pdu(){};
    Pdu(const Pdu& right){};
    virtual ~Pdu(){};

    virtual int                RequestId()                 { return 0;    }
    virtual void               RequestId(int value)        {};

    virtual int                ErrorIndex()                { return 0;    }
    virtual void               ErrorIndex(int value)       {};

    virtual int                ErrorStatus()               { return 0;    }
    virtual void               ErrorStatus(int value)      {};

    virtual int                GenericTrapType()           { return 0;    }
    virtual void               GenericTrapType(int value)  {};

    virtual int                SpecificTrapType()          { return 0;    }
    virtual void               SpecificTrapType(int value) {};

    virtual unsigned long      TimeTicks()                 { return 0;    }
    virtual void               TimeTicks(unsigned long value)         {};

    virtual const char*        SenderIP()                  { return 0L; }
    virtual void               SenderIP(const char* value)            {};

    virtual const char*        SenderOID()                 { return 0L; }
    virtual void               SenderOID(const char* value)           {};


    // I (that is class Pdu) do not know how to do this!
    virtual unsigned int       Length() = 0;
    virtual void               Parse(unsigned char* &buffer) = 0;
    virtual void               Build(unsigned char*& pdu) = 0;
    virtual unsigned char      Type() = 0;

};

#endif

