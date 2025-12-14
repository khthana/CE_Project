// Agent.java
// 
// Copyright 1998 Sven Dörr, Germany.
// 
//   # java jmgmt.examples.Agent
// 
//
//

//package jmgmt.examples ;


import jmgmt.asn1.*;
import jmgmt.snmp.io.*;

import java.net.*;
import java.io.*;
import java.util.*;


/** Very simple agent demo framework.

  This code illustrates how the SNMP server side could look like.

  This demo is very simple and does not contain
  the processing of a mib tree.
  All requests are simply answered with a constant value.
  Exceptions are not handled.

*/
public class Agent  implements Runnable {

  static PrintWriter err = new PrintWriter(System.err);


  /** the server peer for this agent instance.
  */
  SnmpPeer peer;


  public Agent (SnmpPeer peer)
  {
    this.peer=peer;
  }


  public byte[] service(InputStream request)
    throws IOException, SnmpException
  {
    return service(Asn1Value.decode(request)).encode();
  }


  /** decode a SNMP message and service it.
  */
  public Asn1Value service(Asn1Value request)
    throws IOException, SnmpException
  {
    err.print("request: "); request.print(err); err.println();
    Asn1Value response = service(SnmpMessage.decode(request)).encode();
    err.print("response: "); response.print(err); err.println();
    return response;
  }


  /** service a message.
  */
  public SnmpMessage service(SnmpMessage request)
    throws SnmpException
  {
    if (request.community != peer.community) {
      // wrong community: NO_SUCH_NAME
      //   ... ... ...
    }
    SnmpPdu responsePdu = service(request.pdu);
    return new SnmpMessage( request.community, responsePdu );
  }


  /** service a PDU.
  */
  public SnmpPdu service(SnmpPdu request)
  {
    Varbind[] varbinds = request.getVarbindArray();
    SnmpPdu response = new SnmpPdu(SMI.GET_RESPONSE_ID, request.requestId);
    response.addVarbinds(service(request.id, varbinds));
    return response;
  }


  /** service a sequence of varbinds.
  */
  public Varbind[] service(int requestTag, Varbind[] varbinds)
  {
    Varbind[] responseVarbinds = new Varbind[varbinds.length];
    for (int i=0; i<varbinds.length; i++)
	{
     if (i == 0)
   	 responseVarbinds[0] = new Varbind(new OID("1.3.6.1.2.1.1.1"), new Asn1Value("My java Agent"));
	 else if (i == 3)
	 responseVarbinds[3] = new Varbind(new OID("1.3.6.1.2.1.1.4"), new Asn1Value("Group 25"));
	 else if (i ==  4)
	 responseVarbinds[4] = new Varbind(new OID("1.3.6.1.2.1.1.5"), new Asn1Value("Agent on 161.246.6.127"));
	 else if (i ==  5)
	 responseVarbinds[5] = new Varbind(new OID("1.3.6.1.2.1.1.6"), new Asn1Value("Computer Mpp07 at Computer Room"));
	 else 	responseVarbinds[i] = service(requestTag, varbinds[i]);
	}
    return responseVarbinds;
  }


  /** service a single variable of a request.
  */
  public Varbind service(int requestTag, Varbind varbind) 
  {

     return new Varbind(varbind.name); //new Asn1Value("kai"));
	
  }



  /** answer requests.
  */
  public void run()
  {
    try {
    DatagramSocket socket = new DatagramSocket(peer.port, peer.address);
    byte[] buffer = new byte[peer.mtu];
    while (true) {
      // must create a new DatagramPacket each time. otherwise getLength is not correct.
      DatagramPacket request = new DatagramPacket(buffer, buffer.length);
      socket.receive(request);
      byte[] data = request.getData();
      int length = request.getLength();
      err.print("received bytes = " );
      err.println(length);
      Asn1Value.printHex(err, request.getData(), length);
      err.println();
	  err.flush();
      ByteArrayInputStream in = new ByteArrayInputStream(data, 0, length);
      byte[] response = service(in);
      DatagramPacket responsePacket =
        new DatagramPacket(response, response.length, request.getAddress(), request.getPort());
      socket.send(responsePacket);
      err.flush();
    }
    } catch (Exception e) {
      err.println("Agent: caught Exception, terminating.");
      e.printStackTrace();
    }
  }


  /** run an agent demo on the standard port.
  */
  public static void main(String args[])
    throws IOException
  {
    SnmpPeer peer = new SnmpPeer("localhost", InetAddress.getByName("161.246.6.127"), SMI.PUBLIC );
    new Agent(peer).run();
  }


}

