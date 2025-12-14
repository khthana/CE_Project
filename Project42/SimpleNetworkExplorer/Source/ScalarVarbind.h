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

#ifndef __SCALARVARBIND_H__
#define __SCALARVARBIND_H__

#ifndef __VARBIND_H__
#include "Varbind.h"
#endif

class ScalarVarbind : public Varbind
{

  private:


  protected:

    unsigned long        mValue;

  public:


    ScalarVarbind(unsigned short type, const char* typeString);
    ScalarVarbind(unsigned char* &pduPart, 
		  unsigned short type, 
		  const char* typeString);
    ScalarVarbind();
    virtual ~ScalarVarbind(){};


    virtual void             Value(unsigned long value);
    virtual unsigned long    Value() { return mValue; }

    virtual unsigned char*   Data();
    virtual const char*      Printable();
    virtual void             Build(unsigned char*& pdu);
      
  

};
#endif
