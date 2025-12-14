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


#ifndef __GENERICPACKET_H__
#define __GENERICPACKET_H__

#ifndef __BUILD_H__
#  include "Build.h"
#endif

#ifdef _AFXDLL
#  include "stdafx.h"
#else
#  if _WIN32
#    include "windows.h"
#  else
#    include <pthread.h>
#  endif
#endif

#include <time.h>
#include "compat.h"

class GenericPacket : public Builder
{
  private:

    bool           mWasLogged;
    bool           mWasDisplayed;
    bool           mLocked;
    int            mWasChecked;
    int            mSequenceNumber;
    time_t         mTimeStamp;

#if _WIN32
    HANDLE         mPacketLock;
#else
    pthread_mutex_t  mPacketLock;
#endif

  protected:


  public:

    GenericPacket();
    virtual ~GenericPacket();

    bool           WasLogged() { return mWasLogged; }
    void           WasLogged(bool logged) { mWasLogged = logged; }

    bool           WasDisplayed() { return mWasDisplayed; }
    void           WasDisplayed(bool displayed) { mWasDisplayed = displayed; }

    int            WasChecked() { return mWasChecked; }
    void           WasChecked(int checked) { mWasChecked = checked; }

    bool           IsLocked() { return mLocked; }

    void           Lock();
    void           Unlock();

    time_t         TimeStamp() { return mTimeStamp; }
    void           TimeStamp(time_t t) { mTimeStamp = t; }

    GenericPacket* Next;

    virtual unsigned int     TotalLength() = 0;
    virtual int              Version() = 0;
    virtual const char*      Community() = 0; 
    virtual int              VbListLength() = 0;
    virtual const char*      VbOID(int which) = 0;
    virtual const char*      VbType(int which) = 0;
    virtual const char*      VbData(int which) = 0;
    virtual int              RequestId() = 0;
    virtual int              ErrorIndex() = 0;
    virtual int              ErrorStatus() = 0;
    virtual int              GenericTrapType() = 0;
    virtual int              SpecificTrapType() = 0;
    virtual unsigned long    TimeTicks() = 0;
    virtual const char*      SenderIP() = 0;
    virtual const char*      SenderOID() = 0;
    virtual unsigned char    Type() = 0;
    virtual void             AddV2TrapVarbinds(unsigned long counterValue,
					       char* trapOidValue,
	                                       int genericType = 6,
	                                       int specificType = 1) {};
    
};

#endif










