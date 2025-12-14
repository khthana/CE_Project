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



#ifndef __VBPAIR_H__
#define __VBPAIR_H__


#ifndef __OIDVARBIND_H__
#include "OidVarbind.h"
#endif

#ifndef __VARBIND_H__
#include "Varbind.h"
#endif

#include "Build.h"


class VbPair : public Builder
{

  private:

    OidVarbind*   mOidVarbind;
    Varbind*      mVarbind;


  protected:



  public:

    VbPair();
    VbPair(OidVarbind* oidvb, Varbind* vb);
    VbPair(const VbPair& right);
    ~VbPair();

    VbPair*       Next;

    unsigned int  Length();

    OidVarbind*   OIDVarbind();
    void          OIDVarbind(OidVarbind* oidvb);

    Varbind*      VarBind();
    void          VarBind(Varbind* vb);

    virtual void  Build(unsigned char*& pdu);
};
#endif









