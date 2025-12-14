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

import java.io.*;

import java.net.*;
import java.util.*;

public class NSLookupxx {
  public static String findMailAddress(String dns) {
	int atIdx1 = dns.indexOf ("@");
    String nameServer =  "ns1";
    String hostName = dns.substring (atIdx1 + 1);
    dns = hostName;
	System.out.println ("Nameserver: " + nameServer);
    System.out.println ("Request: " + hostName);
    DNSQuery query = new DNSQuery (hostName, DNS.TYPE_ANY, DNS.CLASS_IN);
    try {
      Socket socket = new Socket (nameServer, DNS.DEFAULT_PORT);
      socket.setSoTimeout (10000);
      sendQuery (query, socket);
      getResponse (query, socket);
      socket.close ();
	 
	  Enumeration answers = query.getAnswers ();
	  while (answers.hasMoreElements ()) {
			dns = answers.nextElement ().toString();
	  		if (dns.indexOf("mail exchanger = ") != -1)
			{
				int atIdx = dns.indexOf ("mail exchanger = ");
				dns = dns.substring(atIdx + 17);
				System.out.println("Mail Exchange1: " + dns);
				atIdx = dns.indexOf (" ");
				if (atIdx!=-1)
				{
					dns = dns.substring(0,atIdx);
					System.out.println("Mail Exchange2: " + dns);
				}
				atIdx = dns.indexOf("	");
				if (atIdx!=-1)
				{
					dns = dns.substring(0,atIdx);
					System.out.println("Mail Exchange2: " + dns);
				}
			}
			else
			{
				int atIdx = dns.indexOf (" ");
				if (atIdx!=-1)
				{
					dns = dns.substring(0,atIdx);
					System.out.println("Mail Exchange2: " + dns);
				}
				atIdx = dns.indexOf("	");
				if (atIdx!=-1)
				{
					dns = dns.substring(0,atIdx);
					System.out.println("Mail Exchange2: " + dns);					}		
				}
			}
    } catch (IOException ex) {
      System.out.println (ex);
    }
	System.out.println("dns: " + dns);
	return dns;
  }
  public static void main (String[] args) {
     System.out.println("MailAddress: " + findMailAddress (args[0]));
  }
  public static void sendQuery (DNSQuery query, Socket socket) throws IOException {
    BufferedOutputStream bufferedOut =
      new BufferedOutputStream (socket.getOutputStream ());
    DataOutputStream dataOut = new DataOutputStream (bufferedOut);
    byte[] data = query.extractQuery ();
    dataOut.writeShort (data.length);
    dataOut.write (data);
    dataOut.flush ();
  }

  public static void getResponse (DNSQuery query, Socket socket) throws IOException {
    InputStream bufferedIn =
      new BufferedInputStream (socket.getInputStream ());
    DataInputStream dataIn = new DataInputStream (bufferedIn);
    int responseLength = dataIn.readUnsignedShort ();
    byte[] data = new byte[responseLength];
    dataIn.readFully (data);
    query.receiveResponse (data, responseLength);
  }

}
