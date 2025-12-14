import java.io.*;
import java.net.*;
import java.awt.*;
import java.util.*;
import decode_quoted;
import decode_base64;
import decode_byte;
import Server25;
import SenderMessage;
import NSLookup;
import java.sql.*;
import oracle.jdbc.driver.*;
import doaddmail;
import coding_quoted;


public class Socket25 extends Thread
{
    public static Server25 server;
    public Socket connection;
    private String mail = "" ;
    protected DataInputStream inStream;
    protected DataOutputStream outStream;
    private char decodeType = 'N';
    private int count2 = 0,
				nextCommand = 1;
	private InetAddress myself,machine;
	private String sender = "nomaneSender",
						  recipient = "nonameRecipient",
						  fromSender = "nomaneSender",
						  toRecipient = "nonameRecipient",
						  EOL = " \r\n",
						  addressRecipient = "_Null_",
						  addressSender = "_Null_",
						  date = "_Null_",
						  subject = "nonameSubject";

	
	public Socket25(Server25 s){
        server = s;
    }

    public void run(){
        runSocket();
    }

     protected String getInput()
     throws IOException
     {
		String input = "";

        int value;
		//Date begin = new Date();
        while(true){
		value = inStream.read();	
		if(value == 13) break;
        else if (value != 10 && value!= 0) input = input + decode_byte.decode(value);		  
        

        }
        return input;
     }

     protected String detectCommand(String command) throws IOException
     {
        String input="_Null_";
        /*if(command.length()==1)
        {
		  if (command.charAt(0) == '.') 
		  {
             //if(decodeType == 'b'){
              //server.display.appendText("\n Message: "+ mail + "\n");
			  //mail = decode_base64.decode(mail);	
			  server.display.appendText("=======Message=======\r\n"+ mail + "\r\n");	//}
			  count2 = 0;																//count2 = 0;
              decodeType = 'N';														//decodeType = 'N';
              //mail = "";
              input=".";
			  try{
					SenderMessage senderMessage
					= new SenderMessage(sender,recipient,subject,mail);
			  }
			  catch(Exception ex){
					System.out.println("SenderMessage Error: " + ex);
			  }
			  sender = "nomaneSender";
			  recipient = "nonameRecipient";
			  subject = "nonameSubject";
			  mail = "";
          }
        } 	
		else*/ if(command.length()>=4)
		{
			
		  if ((command.charAt(0) == 'H' || command.charAt(0) == 'h' ) && 
			  (command.charAt(1) == 'E' || command.charAt(1) == 'e' ) && 
			  (command.charAt(2) == 'L' || command.charAt(2) == 'l' ) && 
			  (command.charAt(3) == 'O' ||	 command.charAt(3) == 'o') ) 
		  {
			input="HELO";
          }
          else if (command.length() >=10 &&
		      (command.charAt(0) == 'M' || command.charAt(0) == 'm') && 
              (command.charAt(1) == 'A' || command.charAt(1) == 'a') &&
              (command.charAt(2) == 'I' || command.charAt(2) == 'i' ) &&
              (command.charAt(3) == 'L' || command.charAt(3) == 'l') &&
			  (command.charAt(4) == ' ' ) && 
              (command.charAt(5) == 'F' || command.charAt(5) == 'f') &&
              (command.charAt(6) == 'R' || command.charAt(6) == 'r' ) &&
              (command.charAt(7) == 'O' || command.charAt(7) == 'o') && 
			  (command.charAt(8) == 'M' || command.charAt(8) == 'm') && 
              (command.charAt(9) == ':' )  ) 
		  {
			if(command.length() >10)
			{
				sender = command.substring(10);
				sender = sender.trim();
				if (sender.charAt(0)=='<')
				{
					sender = sender.substring(1,(sender.length() - 1));
				}
			}
			else
			{
				sender = "nonameSender";
			}
			/*if (sender.charAt(0)=='<')
			{
				sender = sender.substring(1,(sender.length() - 1));
			}*/
			System.out.println("sender: " + sender);
			input="MAIL FROM:";
          }
          else if (command.length() >=8 &&
		      (command.charAt(0) == 'R' || command.charAt(0) == 'r' ) &&
              (command.charAt(1) == 'C' || command.charAt(1) == 'c' ) &&
              (command.charAt(2) == 'P' || command.charAt(2) == 'p' ) &&
              (command.charAt(3) == 'T' || command.charAt(3) == 't' ) &&
			  (command.charAt(4) == ' ' ) && 
              (command.charAt(5) == 'T' || command.charAt(5) == 't') &&
              (command.charAt(6) == 'O' || command.charAt(6) == 'o' ) &&
              (command.charAt(7) == ':' ) ) 
		  {
			if(command.length() >8)
			{
				recipient = command.substring(8);
				recipient = recipient.trim();
				if (recipient.charAt(0)=='<')
				{
					recipient = recipient.substring(1,(recipient.length() - 1));
				}
			}
			else
			{
				recipient = "nonameRecipient";
			}
			//recipient = command.substring(8);
			/*if (recipient.charAt(0)=='<')
			{
				recipient = recipient.substring(1,(recipient.length() - 1));
			}*/
			System.out.println("recipient: " + recipient);
			input="RCPT TO:";
          }
          else if ((command.charAt(0) == 'D' || command.charAt(0) == 'd' ) &&
              (command.charAt(1) == 'A' || command.charAt(1) == 'a' ) &&
              (command.charAt(2) == 'T' || command.charAt(2) == 't' ) &&
              (command.charAt(3) == 'A' || command.charAt(3) == 'a' )) 
		  {
			input="DATA";
		  }
          else if ((command.charAt(0) == 'E' || command.charAt(0) == 'e' ) &&
              (command.charAt(1) == 'H' || command.charAt(1) == 'h') &&
              (command.charAt(2) == 'L' || command.charAt(2) == 'l')&&
              (command.charAt(3) == 'O' || command.charAt(3) == 'o') ) 
		  {
			input="HELO";
		  }
          else if ((command.charAt(0) == 'R' || command.charAt(0) == 'r' ) &&
              (command.charAt(1) == 'S' || command.charAt(1) == 's') &&
              (command.charAt(2) == 'E' || command.charAt(2) == 'e') &&
			  (command.charAt(3) == 'T' || command.charAt(3) == 't')) 
	      {
			input="QUIT";
		  }
		  else if ((command.charAt(0) == 'Q' || command.charAt(0) == 'q' ) &&
              (command.charAt(1) == 'U' || command.charAt(1) == 'u' ) &&
              (command.charAt(2) == 'I' || command.charAt(2) == 'i') &&
			  (command.charAt(3) == 'T' || command.charAt(3) == 't')) 
	      {
			input="QUIT";
		  }
          /*else if (command.length() > 34     &&
              (command.charAt(0)  == 'C' || command.charAt(0) == 'c') &&
              (command.charAt(8)  == 'T' || command.charAt(8) == 't') &&
              (command.charAt(17) == 'E' || command.charAt(17) == 'e') &&
              (command.charAt(27) == 'Q' || command.charAt(27) == 'q') &&
              (command.charAt(34) == 'P' || command.charAt(34) == 'p'))
		  {
            input="Code_QUOTED-PRINTABLE";
            decodeType = 'Q';
          }*/
          /*else if (command.length() > 27     &&
              (command.charAt(0)  == 'C' || command.charAt(0) == 'c') &&
              (command.charAt(8)  == 'T' || command.charAt(8) == 't') && 
              (command.charAt(17) == 'E' || command.charAt(17) == 'e') &&
              (command.charAt(27) == 'B' || command.charAt(27) == 'b'))
          {
			input="Code_base64";
            decodeType = 'b';
            count2 = 1;
          }*/
        }  

		/*if (decodeType == 'Q' && 
		    input.length() == 6)			// input = _Null_ 
		{
			//server.display.appendText("Decode: "+ decode_quoted.decode(command) + "\n");
			mail = mail + decode_quoted.decode(command) + EOL;
        }
        if (decodeType == 'b' && 
		    input.length() == 6 )
		{
            //if(count2==0)mail = mail +command.trim();
			if(count2==0)mail = mail + decode_base64.decode(command) + EOL;
			else if(command.length()==0)count2=0;
        }*/
        server.display.appendText("inputStream: " + command + "\n");
        if(input == "_Null_")
			input = command;
		return input;
     }

     protected String selectReply(String inputCommand) throws IOException
     {
          String reply = "";
		  String input = "_Null_";
          if(inputCommand == "HELO")
          {
			  switch(nextCommand)
			  {
			  case 1/*"HELO"*/:reply = "250 " + myself.getHostName() + " hello " + machine.getHostName() + 
													  "[" + machine.getHostAddress() + "]" + " pleased to meet you";
										  nextCommand++;
										  break;
			  case 2/*"MAIL FROM:"*/:
			  case 3/*"RCPT TO:"*/:
			  case 4/*"DATA"*/:reply = "503 " + myself.getHostName() + " Duplicate HELO/HELO";
			                             break;
			  case 5/*"InData"*/:
			  case 6/*"."*/:reply = "_Null_";
								 break;
			  }
			  /*reply = (nextCommand == inputCommand)?  "250 " + myself.getHostName() + " hello " + 
																					 machine.getHostName() + "[" + machine.getHostAddress() + 
																					 "]" + " pleased to meet you"
			  																		 :"503 " + myself.getHostName() + " Duplicate HELO/HELO";
			  if(reply.charAt(0)==2)
					nextCommand = "MAIL FROM:";*/
          }
		  else if(inputCommand == "MAIL FROM:")
          {
			  //reply ="250 " + "sender " + sender + " okey ja";
			  switch(nextCommand)
			  {
			  case 1/*"HELO"*/:reply = "503 Polite people say HELO first";
										 break;
			  case 2/*"MAIL FROM:"*/:int indexChar = sender.indexOf("@");
									 if (indexChar!=-1)
									 {
										addressSender = NSLookup.findMailAddress(sender);
												   if (addressSender=="_Null_")
												   {
														reply ="501 " + sender + "...Sender domain must exist";
												   }  	
												   else
												   {
														reply ="250 " + sender + "...Sender ok ja";
												        nextCommand++;
														//addressSender = "_Null_";
												   }
									}
									else if (sender == "nonameSender")
										reply ="501 Syntax error in parameters scanning " + '"' + "from" + '"'; 
									else 
										reply ="553 " + sender + "... Domain name required";

									break;	
			  case 3/*"RCPT TO:"*/:
			  case 4/*"DATA"*/:reply = "503 Sender already specified";
									     break;
			  case 5/*"InData"*/:
			  case 6/*"."*/:reply = "_Null_";
								 break;
			  }
          }
		  else if(inputCommand == "RCPT TO:")
          {
		      //reply ="250 " + "recipient " + recipient + " okey ja";
			  switch(nextCommand)
			  {
			  case 1/*"HELO"*/:
			  case 2/*"MAIL FROM:"*/:reply = "503 Need MAIL before RCPT"; 
												   break;
			  case 3/*"RCPT TO:"*/:	
			  case 4/*"DATA"*/:int indexChar = recipient.indexOf("@");
							   if (indexChar!=-1)
							   {
								   addressRecipient = NSLookup.findMailAddress(recipient);
										 if (addressRecipient=="_Null_")
										 {
												reply ="501 "  + recipient + "...Recipient domain must exist";
										 }  	
										 else
										 {
												reply ="250 " + recipient + "...Recipient ok ja";
												nextCommand++;
												//addressRecipient = "_Null_";
										 }
			                   
							   }
							   else if (recipient == "nonameRecipient")
									reply ="501 Syntax error in parameters scanning " + '"' + "rcpt" + '"'; 
							   else {
									reply ="553 " + recipient + "... Domain name required";
									System.out.println("recipient.length(): " + recipient.length());
									}

							   break;
			  case 5/*"InData"*/:
			  case 6/*"."*/:reply = "_Null_";
			                     break;
			  }
		  }
          else if(inputCommand == "DATA")
          {
			  //reply ="354 " + "Enter mail ,end  with " + '"' + '.' + '"' + "on a line by itself";
			  switch(nextCommand)
			  {
			  case 1/*"HELO"*/:
			  case 2/*"MAIL FROM:"*/:reply = "503 Need MAIL command" ;
												   break;
			  case 3/*"RCPT TO:"*/:reply = "503 Need RCPT (recipient)" ;
												break; 	
			  case 4/*"DATA"*/:reply ="354 " + "Enter mail end  with " + '"' + '.' + '"' + " on a line by itself";
										 mail = "";
										 nextCommand++;
										 break;
			  case 5/*"InData"*/:
			  case 6/*"."*/:reply = "_Null_"; 
								  break;
			  }
		  }
		  else if(inputCommand == "RSET")
              reply ="250";	
         // else if(inputCommand == ".")
         // {
		//	  //reply ="250 " + "Message accepted for delivery";
		//	  switch(nextCommand)
		//	  {
		//	  case 1/*"HELO"*/:
		//	  case 2/*"MAIL FROM:"*/: 	
		//	  case 3/*"RCPT TO:"*/:
		//	  case 4/*"DATA"*/:reply = "500 Command unrecognized: " + '"' + '.' + '"';
		//	                             break;
		//	  case 5/*"InData"*/:reply ="250 " + "Message accepted for delivery";
		//								   nextCommand = 2;			
		//	  case 6/*"."*/:break;
		//	  }	      
		// }
		  else if(inputCommand == "QUIT")
              reply ="221 " + myself.getHostName() + " closing connection";
          else 
		  {
			  switch(nextCommand)
			  {
			  case 1/*"HELO"*/:
			  case 2/*"MAIL FROM:"*/: 	
			  case 3/*"RCPT TO:"*/:
			  case 4/*"DATA"*/:reply = "500 Command unrecognized: " + '"' + inputCommand + '"';
			                             break;
			  case 5/*"InData"*/:/*String outlook = "_Null_";
											if (inputCommand.length() >= 16)
											{
												outlook = inputCommand.substring(0,16);
											} */
											if(inputCommand.length()==1)// || outlook.equals("------=_NextPart"))
										   {
												//server.display.appendText("Outlook: " + outlook + "  \r\n");
												//------=_NextPart
												if ( inputCommand.charAt(0) == '.' )//|| outlook.equals("------=_NextPart")) 
												{
													server.display.appendText("=======Message=======\r\n"+ mail + "\r\n"
																	               + "Subject" + subject + "\r\n"
																				   + "Sender" + sender + "\r\n"
																				   + "Recient" + recipient + "\r\n"
																				   + "Date" + date + "\r\n");
													count2 = 0;																//count2 = 0;
													decodeType = 'N';														//decodeType = 'N';
													//mail = "";
													input=".";
													//int index = recipient.indexOf("@");				
													//String hostRecipient = recipient.substring(index + 1);
													InetAddress hostReceipt = InetAddress.getByName(addressRecipient);
													String receipt,server_1;
													receipt = hostReceipt.getHostAddress();
													server_1 = myself.getHostAddress();
													server.display.appendText(receipt + " R VS S " +
																			  server_1 + "\r\n" + 
																			  (receipt == server_1) +
																			  "\r\n");
													
													String typeMail = "localMail";
													if (server_1.length() == receipt.length())
													{
														for (int i=0;i<server_1.length();i++)
														{
															if (server_1.charAt(i)!=receipt.charAt(i))
															{
																typeMail = "NotLocalMail";
															}
														}
													}
													else
														typeMail = "NotLocalMail";

													server.display.appendText("typeMail: " + typeMail + "\r\n");
													if(typeMail == "NotLocalMail")
													{
														try
														{
															SenderMessage senderMessage
															= new SenderMessage(sender,recipient,subject,mail);
														}
														catch(Exception ex)
														{
															System.out.println("SenderMessage Error: " + ex);
														}
													}
													else
													{
														int index = recipient.indexOf("@");
														recipient = recipient.substring(0,index);
														try{
														  DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                                                              
															String indexs = doaddmail.selectIndex(recipient);
															System.out.println("index is : " + indexs);
															System.out.println("  step 1 pass");
																											
															 //mail = coding_quoted.coding(mail);  */
															doaddmail.addMail(recipient,indexs,fromSender,date,subject,mail,"1");  //1=read  ready
															System.out.println("Step 2 pass");
															}
															  catch (SQLException e) { System.out.println(e); }
                                                        }
														
													sender = "nomaneSender";
													recipient = "nonameRecipient";
													subject = "nonameSubject";
													mail = "";
													reply ="250 " + "Message accepted for delivery";
												    nextCommand = 2;	
												}
											} 	
											else	if(inputCommand.length()>=4)
											{
											    if ((inputCommand.charAt(0)  == 'T' || inputCommand.charAt(0) == 't') &&
												  (inputCommand.charAt(1)  == 'O' || inputCommand.charAt(1) == 'o') &&
												  (inputCommand.charAt(2) == ':' ) &&
												  (inputCommand.charAt(3) == ' ' || inputCommand.charAt(3) == 'q') )
												{
													toRecipient = inputCommand.substring(4);
												}
												if ((inputCommand.length()>=6) &&
												  (inputCommand.charAt(0)  == 'D' || inputCommand.charAt(0) == 'd') &&
												  (inputCommand.charAt(1)  == 'A' || inputCommand.charAt(1) == 'a') &&
												  (inputCommand.charAt(2)  == 'T' || inputCommand.charAt(2) == 't') &&
												  (inputCommand.charAt(3)  == 'E' || inputCommand.charAt(3) == 'e') &&
												  (inputCommand.charAt(4) == ':' ) &&
												  (inputCommand.charAt(5) == ' ' ) )
												{
													date = inputCommand.substring(6);
												}
												//inputStream: X-Mailer: Poppymail  4 (http://www.poppymail.com)
												
												else if ( inputCommand.length()>=10 &&
												  (inputCommand.charAt(0)  == 'X' || inputCommand.charAt(0) == 'x') &&
												  (inputCommand.charAt(1)  == '-' ) &&
												  (inputCommand.charAt(2) == 'M' || inputCommand.charAt(2) == 'm') &&
												  (inputCommand.charAt(3) == 'A' || inputCommand.charAt(3) == 'a') &&
												  (inputCommand.charAt(4) == 'I' || inputCommand.charAt(4) == 'i') &&
												  (inputCommand.charAt(5) == 'L' || inputCommand.charAt(5) == 'l') &&
												  (inputCommand.charAt(6) == 'E' || inputCommand.charAt(6) == 'e') &&
												  (inputCommand.charAt(7) == 'R' || inputCommand.charAt(7) == 'r') &&
												  (inputCommand.charAt(8) == ':' ) &&
												  (inputCommand.charAt(9) == ' ' ))
												{
													input="Content-Type";
													decodeType = 'C';
													count2 = 1;
													mail = "";
												}
												
												else if (inputCommand.length()>=9 &&
												  (inputCommand.charAt(0)  == 'S' || inputCommand.charAt(0) == 's') &&
												  (inputCommand.charAt(1)  == 'U' || inputCommand.charAt(1) == 'u') &&
												  (inputCommand.charAt(2) == 'B' || inputCommand.charAt(2) == 'b') &&
												  (inputCommand.charAt(3) == 'J' || inputCommand.charAt(3) == 'j') &&
												  (inputCommand.charAt(4)  == 'E' || inputCommand.charAt(4) == 'e') &&
												  (inputCommand.charAt(5) == 'C' || inputCommand.charAt(5) == 'c') &&
												  (inputCommand.charAt(6) == 'T' || inputCommand.charAt(6) == 't') &&
												  (inputCommand.charAt(7) == ':' ) &&
												  (inputCommand.charAt(8) == ' ' ))
												{
													subject = inputCommand.substring(9);
												}
												else if (inputCommand.length()>=6 &&
												  (inputCommand.charAt(0)  == 'F' || inputCommand.charAt(0) == 'f') &&
												  (inputCommand.charAt(1)  == 'R' || inputCommand.charAt(1) == 'r') &&
												  (inputCommand.charAt(2) == 'O' || inputCommand.charAt(2) == 'o') &&
												  (inputCommand.charAt(3) == 'M' || inputCommand.charAt(3) == 'm') &&
												  (inputCommand.charAt(4) == ':' ) &&
												  (inputCommand.charAt(5) == ' ' ))
												{
													fromSender = inputCommand.substring(6);
												}
												else if (inputCommand.length() > 35     &&
												  (inputCommand.charAt(0)  == 'C' || inputCommand.charAt(0) == 'c') &&
												  (inputCommand.charAt(8)  == 'T' || inputCommand.charAt(8) == 't') &&
												  (inputCommand.charAt(17) == 'E' || inputCommand.charAt(17) == 'e') &&
												  (inputCommand.charAt(27) == 'Q' || inputCommand.charAt(27) == 'q') &&
												  (inputCommand.charAt(34) == 'P' || inputCommand.charAt(34) == 'p'))
												{
													input="Code_QUOTED-PRINTABLE";
													decodeType = 'Q';
													count2 = 1;
													mail = "";
												}
												else if (inputCommand.length() > 28     &&
														  (inputCommand.charAt(0)  == 'C' || inputCommand.charAt(0) == 'c') &&
                                                          (inputCommand.charAt(8)  == 'T' || inputCommand.charAt(8) == 't') && 
														  (inputCommand.charAt(17) == 'E' || inputCommand.charAt(17) == 'e') &&
														  (inputCommand.charAt(27) == 'B' || inputCommand.charAt(27) == 'b'))
												{
													input="Code_base64";
													decodeType = 'b';
													count2 = 1;
													mail = "";
												}
												//Content-Type: TEXT/PLAIN; charset=US-ASCII
												else if (inputCommand.length() > 20     &&
														  (inputCommand.charAt(0)  == 'C' || inputCommand.charAt(0) == 'c') &&
                                                          (inputCommand.charAt(8)  == 'T' || inputCommand.charAt(8) == 't') && 
														  (inputCommand.charAt(14) == 'T' || inputCommand.charAt(14) == 't') &&
														  (inputCommand.charAt(19) == 'P' || inputCommand.charAt(19) == 'p'))
												{
													//Content-Type: text/plain; format=flowed
													input="Content-Type";
													decodeType = 'C';
													count2 = 1;
													mail = "";
												}
											}  
											if (decodeType == 'Q' && 
												input.length() == 6)			// input = _Null_ 
											{
												if(count2==0)mail = mail + decode_quoted.decode(inputCommand) + EOL;
												else if(inputCommand.length()==0)
												{
													count2=0;
													mail = "";
												}
												//server.display.appendText("mail_Q: "+ mail + "\r\n");
											}
											else if (decodeType == 'b' && 
												input.length() == 6 )
											{
												if(count2==0)mail = mail + decode_base64.decode(inputCommand) + EOL;
												else if(inputCommand.length()==0)
												{
													count2=0;
													mail = "";
												}
												//server.display.appendText("mail_b: "+ mail + "\r\n");
											}
											else 
											{
												if(count2==0)//System.out.println("mail: " + mail);
													mail = mail + inputCommand + EOL;
												else if (inputCommand.length()==0)
												{
													count2=0;
													mail = "";
												}
											}
			  case 6/*"."*/:if(!(nextCommand == 2))
										reply ="_Null_";			
								 break;
			  }	
		  }

		  //reply = inputCommand;
          return reply;
     }


     protected void reply(String case_reply)
     throws IOException
     {
          if(case_reply.charAt(0) == '2'||case_reply.charAt(0) == '3'||case_reply.charAt(0) == '5')
          {
            server.display.appendText("reply_reply: "+ case_reply +"\n");
            case_reply=case_reply+"\r\n";
            outStream.writeBytes(case_reply);  
          }

     }

    private void runSocket()
    {
        try
        {
            server.display.appendText("Socket25.runSocket...\n");

            connection = server.waitConnect(connection);
			connection.setSoTimeout(30000);

            Socket25 sk = new Socket25(server);
            sk.start();

            inStream = new DataInputStream(
            connection.getInputStream());
            outStream = new DataOutputStream(
            connection.getOutputStream());

            server.display.setText("Connection received...\n");
    
            machine = connection.getInetAddress();
			myself = InetAddress.getLocalHost();
			//myself.getHostAddress();

			reply("220 SMTP LoveMail myName: " + myself.getHostName() + "[" + myself.getHostAddress() + "]");
            String replyString = "000";
            while(!(replyString.charAt(0)=='2' && replyString.charAt(1)=='2' && replyString.charAt(2)=='1')){
              //System.out.println("replyString: " + replyString + " " + !(replyString.charAt(0)=='2' && replyString.charAt(1)==2 && replyString.charAt(2)==1));
			  try
			  {
				replyString = selectReply(detectCommand(getInput()));
				reply(replyString);
			  //System.out.println("reply: " + replyString.charAt(0) + replyString.charAt(1) + replyString.charAt(2));
              }
			  catch(InterruptedIOException ex)
			  {
				//System.out.println(ex);
				replyString = "221 " + myself.getHostName() + " closing connection because timeout ";
			  }
			  //reply(replyString);
            }
            System.out.println("---------------close connection---------------");
			//Thread.sleep(1);
			connection.close();
			System.out.println("----------------------------------------------");
			//connection.close();
			//System.out.println("--------------------close---------------------");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

}
