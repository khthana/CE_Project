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


#ifndef __NTPACKET_H__
#define	__NTPACKET_H__

#include <snmp.h>
#include "GenericPacket.h"

const int VBTYPE=100;
const int VBDATA=200;

class NtPacket : public GenericPacket
{

  private:

    AsnObjectIdentifier mEnterprise;
    AsnNetworkAddress   mIPAddress;
    AsnInteger          mGenerictrap;
    AsnInteger          mSpecifictrap;
    AsnTimeticks        mTimestamp;
    RFC1157VarBindList  mVariablebindings;

    const char*         DecodeVb(int whichVb, int whichMember);
    int                 LengthOf(unsigned long value);
    int                 VbLength();
    unsigned int        PduLength();

    char                mData[1024];

  protected:



  public:

    NtPacket();
    ~NtPacket();

    NtPacket*            Next;

    AsnObjectIdentifier* Enterprise();
    void                 Enterprise(AsnObjectIdentifier oid);

    AsnNetworkAddress*   IPAddress();
    void                 IPAddress(AsnNetworkAddress addr);

    AsnInteger*          Generictrap();
    void                 Generictrap(AsnInteger type);

    AsnInteger*          Specifictrap();
    void                 Specifictrap(AsnInteger specific);

    AsnTimeticks*        Timestamp();
    void                 Timestamp(AsnTimeticks tt);

    RFC1157VarBindList*  Variablebindings();
    void                 Variablebindings(RFC1157VarBindList vblist);

    virtual unsigned int  TotalLength();
    virtual void          Build(unsigned char*& pdu);

    virtual int           Version();
    virtual const char*   Community(); 
    virtual int           VbListLength();
    virtual const char*   VbOID(int which);
    virtual const char*   VbType(int which);
    virtual const char*   VbData(int which);
    virtual int           RequestId();
    virtual int           ErrorIndex();
    virtual int           ErrorStatus();
    virtual int           GenericTrapType();
    virtual int           SpecificTrapType();
    virtual unsigned long TimeTicks();
    virtual const char*   SenderIP();
    virtual const char*   SenderOID();
    virtual unsigned char Type();
  

};
#endif
