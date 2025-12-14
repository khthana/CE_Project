import java.io.*;
import java.net.*;
import java.util.*;
import Time;
import NSLookup;
import coding_quoted;

public class SenderMessage {
  private String host,message,recipient,sender,subject;
  private int port;
  private Socket connector;
  private DataInputStream inputStream;
  private DataOutputStream outputStream;
  static final String EOL = "\r\n";

//===========================SenderMessage(String,String,String)=================================

  SenderMessage(String sender,String recipient,
                String message) throws IOException {
    port = 25;
    host = NSLookup.findMailAddress(recipient);
	this.recipient = recipient;
    this.sender = sender;
    this.message =  coding_quoted.coding(message);
    sendStep();
  }

//===========================SenderMessage(String,String,String,String)=================================

  SenderMessage(String sender,String recipient,
                String subject,String message) throws IOException {
    int atIdx = recipient.indexOf ("@yahoo.com");
    host = (atIdx > -1) ?   "mx2.mail.yahoo.com":NSLookup.findMailAddress(recipient);
    //host = NSLookup.findMailAddress(recipient) :    host = "mx2.mail.yahoo.com";
	port = 25;
    this.recipient = recipient;
    this.sender = sender;
    this.message = coding_quoted.coding(message);
	this.subject = subject;
    sendStep();
  }

//===========================connect()=======================================

  private void connect() throws IOException{
    connector = new Socket(host,port);
    inputStream = new DataInputStream(connector.getInputStream());
    outputStream = new DataOutputStream(connector.getOutputStream());
  }

//===========================close()=========================================

  public void close() throws IOException
  {
    connector.close();
    connector = null;
  }

//===========================getResponse()=======================================

  private String getResponse() throws IOException{
    String line = inputStream.readLine();
    System.out.println(line);
    return line;
  }

//===========================sendStream(String)=======================================

  private void sendMessage(String stream) throws IOException{
    Time date = new Time();
    outputStream.writeBytes("Date: " + date.time());
	System.out.println("Date: " + date.time());
    outputStream.writeBytes(EOL);
    outputStream.writeBytes("From: <" + sender + ">");
	System.out.println("From: <" + sender + ">");
    outputStream.writeBytes(EOL);
    outputStream.writeBytes("To: " + recipient);
	System.out.println("To: " + recipient);
    outputStream.writeBytes(EOL);
    outputStream.writeBytes("Subject: " + subject);
    System.out.println("Subject: " + subject);
	outputStream.writeBytes(EOL);
	outputStream.writeBytes("MIME-Version: 1.0");
	System.out.println("MIME-Version: 1.0");
    outputStream.writeBytes(EOL);
    outputStream.writeBytes("Content-Type: TEXT/PLAIN; charset=ISO-8859-1");
    System.out.println("Content-Type: TEXT/PLAIN; charset=ISO-8859-1");
	outputStream.writeBytes(EOL);
    outputStream.writeBytes("Content-Transfer-Encoding: QUOTED-PRINTABLE");
    System.out.println("Content-Transfer-Encoding: QUOTED-PRINTABLE");
	outputStream.writeBytes(EOL);
    outputStream.writeBytes("Content-Transfer-Encoding: QUOTED-PRINTABLE");
    System.out.println("Content-Transfer-Encoding: QUOTED-PRINTABLE");
	outputStream.writeBytes(EOL);
    outputStream.writeBytes("");
	System.out.println("");
    outputStream.writeBytes(EOL);
    outputStream.writeBytes("\r\n"+stream+"\r\n");
	System.out.println("\r\n"+stream+"\r\n");
    outputStream.writeBytes(EOL);
    outputStream.writeBytes("");
    System.out.println("");
	outputStream.writeBytes(EOL);
  }

//===========================doCommand(String)=======================================

  protected String doCommand(String commandString) throws IOException{
    outputStream.writeBytes(commandString+EOL);
    String response = getResponse();
    return response;
  }

//===========================sendStep()=======================================

  private void sendStep() throws IOException{
    
	System.out.println("sendStep");

    System.out.println("connect");

    connect();

    String response = getResponse();

    /*if (response.charAt(0) != '2') {
      throw new IOException(response);
    }*/

    response = doCommand("HELO 161.246.6.150");

    /*if (response.charAt(0) != '2') {
      throw new IOException(response);
    }*/

    System.out.println("sender = "+sender);

    response = doCommand("MAIL FROM: " + sender);

    /*if (response.charAt(0) != '2') {
      throw new IOException(response);
    }*/

    System.out.println("recipient = " +recipient);

    response = doCommand("RCPT TO: " + recipient);

    /*if (response.charAt(0) != '2') {
      throw new IOException(response);
    }*/

    response = doCommand("DATA");

    /*if (response.charAt(0) != '3') {
      throw new IOException(response);
    }*/

    System.out.println("message = " +message);

    sendMessage(message);

    System.out.println("End message = . " );

    response = doCommand(".");
	
	/*if (response.charAt(0) != '2') {
      throw new IOException(response);
    }*/
	
	response = doCommand("QUIT");
	
	/*if (response.charAt(0) != '2') {
      throw new IOException(response);
    }*/

	close();

  }

}
