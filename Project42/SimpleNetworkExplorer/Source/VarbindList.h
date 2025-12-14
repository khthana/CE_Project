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



#ifndef __VARBINDLIST_H__
#define __VARBINDLIST_H__

#include "Build.h"

class VbPair;

class VarbindList : public Builder
{
  private:

    VbPair*       mHead;

  protected:



  public:

    VarbindList();
    VarbindList(VbPair* vbp);
    ~VarbindList();	  
    
    VarbindList(const VarbindList& right);

    unsigned int  Length();

    void           Add(VbPair* vbp);
    VbPair*        AddFirst(VbPair* vbp);

    VbPair*        FirstVbPair();

    virtual void   Build(unsigned char*& pdu);
};
#endif
