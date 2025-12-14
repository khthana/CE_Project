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

 

#ifndef __VARBIND_H__
#define __VARBIND_H__

#include "Build.h"

unsigned int  ComputeIntValue(unsigned char* &pduPart, 
			      unsigned int size);
unsigned long ComputeLongValue(unsigned char* &pduPart, 
			       unsigned int size);

unsigned int  calculateLengthLength(unsigned int len);
unsigned int  calculateTotalLengthLength(unsigned int len);


extern void  decodeLength(unsigned char* &pduField, 
			  long* value);
extern void  encodeLength(unsigned char* &pduField, 
			  long value);

extern void  decodeTag(unsigned char* &pduField, 
		       long* value);
extern void  encodeTag(unsigned char* &pduField, 
		       long value);

extern void  decodeOID(unsigned char* &pduField, 
		       long* value);
extern void  encodeOID(unsigned char* newvalue, 
		       int pduField, 
		       unsigned int& encodedLength);

extern void  decodeFirstSubId(unsigned char* &dataStart,
			      unsigned short* First,		       
			      unsigned short* Second);
extern void  encodeFirstSubId(unsigned char* &pduField,
			      int First,		       
			      int Second);

class Varbind : public Builder
{
  private:

    unsigned short  mLength;
    unsigned short  mType;
    const    char*  mTypeString;

  protected:

    char*           mPrintable;

  public:
    
    Varbind(unsigned short type, const char* typeString);
    Varbind(unsigned char* &pduPart, 
	    unsigned short type, 
	    const char* typeString);
    Varbind();
    virtual ~Varbind();

    
    unsigned short     Type()                       { return mType; } 
    // type is only set in constructor

    unsigned short     DataLength()                 { return mLength; }
    void               DataLength(unsigned short length){ mLength = length; }

    unsigned int       Length();

    virtual unsigned char*   Data() = 0;

    virtual const char* Printable() = 0;

    const char*         TypeString()                 { return mTypeString; }
    virtual void        Build(unsigned char*& pdu) = 0;
    
    Varbind*        Next;

};
#endif

