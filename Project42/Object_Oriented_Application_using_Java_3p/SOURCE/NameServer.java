/*
 * Java Network Programming, Second Edition
 * Merlin Hughes, Michael Shoffner, Derek Hamner
 * Manning Publications Company; ISBN 188477749X
 *
 * http://nitric.com/jnp/
 *
 * Copyright (c) 1997-1999 Merlin Hughes, Michael Shoffner, Derek Hamner;
 * all rights reserved; see license.txt for details.
 */

package record;

import java.io.*;

import DNSRR;
import DNSInputStream;

public class NameServer extends DNSRR {
  private String nameServer;

  protected void decode (DNSInputStream dnsIn) throws IOException {
    nameServer = dnsIn.readDomainName ();
  }

  public String getNameServer () {
    return nameServer;
  }

  public String toString () {
    return getRRName () + "\tnameserver = " + nameServer;
  }
}
