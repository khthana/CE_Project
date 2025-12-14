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

public class NSLookup {
  static Vector nameserver; 
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
	  Enumeration authorities = query.getAuthorities ();
	  Enumeration answers = query.getAnswers ();
	  nameserver = new Vector();
	  while (authorities.hasMoreElements ()) {
			dns = authorities.nextElement ().toString();
	  		if (dns.indexOf("nameserver = ") != -1)
			{
				int atIdx = dns.indexOf ("nameserver = ");
				dns = dns.substring(atIdx + 13);
				nameserver.addElement(dns);
				System.out.println("nameserver1: " + dns);
				atIdx = dns.indexOf (" ");
				if (atIdx!=-1)
				{
					dns = dns.substring(0,atIdx);
					System.out.println("nameserver2: " + dns);
				}
				atIdx = dns.indexOf("	");
				if (atIdx!=-1)
				{
					dns = dns.substring(0,atIdx);
					System.out.println("nameserver2: " + dns);
				}
			}
			else
			{
				int atIdx = dns.indexOf (" ");
				if (atIdx!=-1)
				{
					dns = dns.substring(0,atIdx);
					System.out.println("nameserver2: " + dns);
				}
				atIdx = dns.indexOf("	");
				if (atIdx!=-1)
				{
					dns = dns.substring(0,atIdx);
					System.out.println("nameserver2: " + dns);					}		
				}
			}
    } catch (IOException ex) {
      System.out.println (ex);
    }
	
	int index = 0;
	do
	{
		dns = nameserver.elementAt(index).toString();
		index++;
		System.out.println("dns: " + dns);
		nameServer =  dns;
		System.out.println ("Nameserver: " + nameServer);
		System.out.println ("Request: " + hostName);
		DNSQuery query1 = new DNSQuery (hostName, DNS.TYPE_ANY, DNS.CLASS_IN);
		try 
		{
			Socket socket = new Socket (nameServer, DNS.DEFAULT_PORT);
			socket.setSoTimeout (10000);
			sendQuery (query1, socket);
			getResponse (query1, socket);
			socket.close ();
			Enumeration answers = query1.getAnswers ();
			 while (answers.hasMoreElements ()) 
			 {
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
					break;
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
		} 
		catch (IOException ex) 
		{
			dns = "_Null_";
		}
	}
	while (dns == "_Null_" && index < nameserver.size());
	String mailExchange = "_Null_";
	try
	{
		InetAddress testDNS = InetAddress.getByName(dns);
		mailExchange = testDNS.getHostAddress();
	} catch (IOException ex) {
      System.out.println (ex);
    }
	
	System.out.println("MailExchange: " + mailExchange);
	
	return mailExchange;
  
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
