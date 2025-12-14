import java.net.*;
import java.io.*;
import java.util.*;
import decode_quoted;
import decode_base64;
import decode_byte;
import SenderMessage;
import NSLookup;
import java.sql.*;
//import oracle.jdbc.driver.*;
//import doaddmail;
import FileRW;

class MailServerThread extends Thread

{

/*====================MailServerThread(Socket)===========*/

	Socket connection;
	DataInputStream inStream;
	DataOutputStream outStream;
	PrintWriter writerStream;

	char decodeType = 'N';
	int count2 = 0,
				nextCommand = 1;
	InetAddress myself,machine;
	String	mail = "",
				sender = "nomaneSender",
				recipient = "nonameRecipient",
				fromSender = "nomaneSender",
				toRecipient = "nonameRecipient",
				EOL = "\r\n",
				addressRecipient = "_Null_",
				addressSender = "_Null_",
				date = "_Null_",
				subject = "nonameSubject",
				temp = "";

	MailServerThread(Socket connection)
	{
		try
		{
			this.connection = connection;
			connection.setSoTimeout(30000);
			inStream = new DataInputStream(
							connection.getInputStream());
			outStream = new DataOutputStream(
							connection.getOutputStream());
			writerStream = new PrintWriter(outStream);
		}
		catch (Exception e)
		{
			System.out.println("--Exception-- MailServerThread.MailServerThread(Socket) " + e);
		}
	}

/*====================closeSocket()===========*/
	public void closeSocket()
	{
		try
		{
			connection.close();
		}
		catch (Exception e)
		{
			System.out.println("Error closeSocket = " + e);
		}
	}

/*====================getInput()===========*/

	String inputStream;

	public String getInput()
	{
		try
		{
			inputStream = "";
			int value;
			while(true)
			{
				value = inStream.read();
				if(value == 13) break;
				else if (value != 10 && value!= 0)inputStream = inputStream + decode_byte.decode(value);
			}
		}
		catch (Exception e)
		{
			System.out.println("--Exception-- MailServerThread.getInput() " + e);
			closeSocket();
			this.stop();
		}

		System.out.println("InputStream: " + inputStream);

		return inputStream;
	}

/*====================selectReply(String)===========*/

	public String selectReply(String inputCommand)
	{
		String reply = "";
		String input = "_Null_";
		if(inputCommand.regionMatches(true,0,"Helo ",0,5)||inputCommand.regionMatches(true,0,"Ehlo ",0,5))
		{
			switch(nextCommand)
			{
				case 1/*"HELO"*/:	reply = "250 " + myself.getHostName() + "hello" +
											machine.getHostName() + "[" + machine.getHostAddress() +
											"]" + " pleased to meet you";
									nextCommand++;
									break;
				case 2/*"MAIL FROM:"*/:
				case 3/*"RCPT TO:"*/:
				case 4/*"DATA"*/:	reply = "503 " + myself.getHostName() + " Duplicate HELO/HELO";
									break;
				case 5/*"InData"*/:
				case 6/*"."*/:	reply = "_Null_";
								break;
			}
		}
		else if(inputCommand.regionMatches(true,0,"MAIL FROM:",0,10))
		{
			switch(nextCommand)
			{
				case 1/*"HELO"*/:reply = "503 Polite people say HELO first";
										 break;
				case 2/*"MAIL FROM:"*/:	
										
										if(inputCommand.length() > 10)
											sender = inputCommand.substring(10);
										//sender = sender.trim();
										System.out.println("Sender: " + sender);
										if(sender.charAt(0) == '<')
										{
											sender = sender.substring(1,(sender.length()-1));
										}
										System.out.println("Sender: " + sender);
										int indexChar = sender.indexOf("@");
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
											}
										}
										else if (sender == "nonameSender")
											reply ="501 Syntax error in parameters scanning " + '"' + 
												"from" + '"'; 
										else 
											reply ="553 " + sender + "... Domain name required";
										break;	
				case 3/*"RCPT TO:"*/:
				case 4/*"DATA"*/:	reply ="503 Sender already specified";
									break;
				case 5/*"InData"*/:
				case 6/*"."*/:reply =	"_Null_";
										break;
			}
		}
		else if(inputCommand.regionMatches(true,0,"RCPT TO:",0,8))
		{
			switch(nextCommand)
			{
				case 1/*"HELO"*/:
				case 2/*"MAIL FROM:"*/:	reply = "503 Need MAIL before RCPT"; 
										break;
				case 3/*"RCPT TO:"*/:	
				case 4/*"DATA"*/:	
									
									if(inputCommand.length() > 8)
										recipient = inputCommand.substring(8);
									//recipient = recipient.trim();
									if(recipient.charAt(0) == '<')
									{
										recipient = recipient.substring(1,(recipient.length()-1));
									}
									int indexChar = recipient.indexOf("@");
									if (indexChar!=-1)
									{
										addressRecipient = NSLookup.findMailAddress(recipient);
										if (addressRecipient=="_Null_")
										{
											reply ="501 "  + recipient + 
												"...Recipient domain must exist";
										}
										else
										{
											reply ="250 " + recipient + "...Recipient ok ja";
											nextCommand++;
										}
									}
									else if (recipient == "nonameRecipient")
										reply ="501 Syntax error in parameters scanning " + '"' + 
											"rcpt" + '"'; 
									else 
									{
										reply ="553 " + recipient + "... Domain name required";
										System.out.println("recipient.length(): " +
											recipient.length());
									}
									break;
				case 5/*"InData"*/:
				case 6/*"."*/:	reply = "_Null_";
								break;
			}
		}
		else if(inputCommand.regionMatches(true,0,"Data",0,4))
		{
			switch(nextCommand)
			{
				case 1/*"HELO"*/:
				case 2/*"MAIL FROM:"*/:	reply = "503 Need MAIL command" ;
										break;
				case 3/*"RCPT TO:"*/:	reply =	"503 Need RCPT (recipient)" ;
										break; 	
				case 4/*"DATA"*/:	reply = "354 " + "Enter mail end  with " + '"' + '.' + '"' +
											" on a line by itself";
									mail = "";
									nextCommand++;
									break;
				case 5/*"InData"*/:
				case 6/*"."*/:	reply = "_Null_"; 
								break;
			}
		}
		else if(inputCommand.regionMatches(true,0,"Rset",0,4))
			reply ="250";	
		else if(inputCommand.regionMatches(true,0,"Quit",0,4))
			reply ="221 " + myself.getHostName() + " closing connection";
		else 
		{
			switch(nextCommand)
			{
				case 1/*"HELO"*/:
				case 2/*"MAIL FROM:"*/: 	
				case 3/*"RCPT TO:"*/:
				case 4/*"DATA"*/:	reply = "500 Command unrecognized: " + '"' + inputCommand + '"';
									break;
				case 5/*"InData"*/:	if(inputCommand.length()==1 && inputCommand.charAt(0) == '.')
													{
														System.out.println("Mail: " +mail);
														System.out.println("temp: " + temp);
														System.out.println("Sender: " + sender);
														System.out.println("Subject: " + subject);
														count2 = 0;
														decodeType = 'N';
														input=".";
														String	receipt = "_Null_",
																	server_1 = "Null";
														try
														{
															InetAddress hostReceipt = InetAddress.getByName(addressRecipient);
															receipt = hostReceipt.getHostAddress();
															server_1 = myself.getHostAddress();
														}
														catch (Exception e)
														{
															System.out.println("--Exception-- MailServerThread.selectReply(String)_1 " + e);
														}
														String typeMail = "localMail";
														if (server_1.regionMatches(true,0,receipt,0,server_1.length()))
														{
															typeMail = "localMail";
														}
														else 
															typeMail = "NotLocalMail";
														System.out.println(server_1 + " VS " + receipt);
														System.out.println("AddressRecipient: " + addressRecipient);
														System.out.println("TypeMail: " + typeMail);
														if(typeMail == "NotLocalMail")
														{
															try
															{
																SenderMessage senderMessage = new SenderMessage(sender,recipient,subject,mail);
															}
															catch(Exception e)
															{
																try
																{
																	SenderMessage return_senderMessage = new SenderMessage(recipient,sender,subject,mail + "\r\n" + "----Return----");
																}
																catch (Exception ex)
																{
																	System.out.println("--Exception-- Return Mail " + ex);
																}
																System.out.println("--Exception-- MailServerThread.selectReply(String)_2 " + e);
															}
														}
														else
														{
															int index = recipient.indexOf("@");
															recipient = recipient.substring(0,index);
															/*try
															{
																DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
																doaddmail.addMail(recipient,"1",sender,date,subject,mail,"1");
															}
															catch (SQLException e) 
															{
																System.out.println("--Exception-- MailServerThread.selectReply(String)_3 " + e);
															}*/
															try
															{
																	FileRW.B_File(date,fromSender,recipient,subject,mail,(recipient+".java"));
															}
															catch (Exception e)
															{
																System.out.println(e);
															}
															
														}
														sender = "nomaneSender";
														recipient = "nonameRecipient";
														subject = "nonameSubject";
														mail = "";
														reply ="250 " + "Message accepted for delivery";
														nextCommand = 2;	
													}
													else	if(inputCommand.regionMatches(true,0,"To: ",0,4))
													{
														toRecipient = inputCommand.substring(4);
													}
													else if (inputCommand.regionMatches(true,0,"Subject: ",0,9))
													{
														subject = inputCommand.substring(9);
													}
													else if (inputCommand.regionMatches(true,0,"From: ",0,6))
													{
														fromSender = inputCommand.substring(6);
													}
													else if (inputCommand.regionMatches(true,0,"Date: ",0,6))
													{
														date = inputCommand.substring(6);
													}
													else if (inputCommand.regionMatches(true,0,"Content-Transfer-Encoding: QUOTED-PRINTABLE",0,43))
													{
														input="Code_QUOTED-PRINTABLE";
														decodeType = 'Q';
														count2 = 1;
													}
													else if (inputCommand.regionMatches(true,0,"Content-Transfer-Encoding: base64",0,33))
													{
														input="Code_base64";
														decodeType = 'b';
														count2 = 1;
													}
													else if (inputCommand.regionMatches(true,0,"Content-Type: ",0,14))
													{
														input="Content-Type";
														decodeType = 'C';
														count2 = 1;
													}
													if (decodeType == 'Q' && input.length() == 6)	// input = _Null_ 
													{
														if(count2==0)
														{
															mail = mail + decode_quoted.decode(inputCommand) + EOL;
															temp = temp + inputCommand + EOL;
														}
														else if(inputCommand.length()==0)
														{
															count2=0;
															mail = "";
														}
													}
													else if (decodeType == 'b' && input.length() == 6 )
													{
														if(count2==0)
															mail = mail + decode_base64.decode(inputCommand) + EOL;
														else if(inputCommand.length()==0)
														{
															count2=0;
															mail = "";
														}
													}
													else 
													{
														if(count2==0)
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
		return reply;
	}

/*====================reply(String)===========*/

	protected void reply(String case_reply) throws IOException
	{
		if(case_reply.charAt(0) == '2'||case_reply.charAt(0) == '3'||case_reply.charAt(0) == '5')
		{
			case_reply=case_reply+EOL;
			outStream.writeBytes(case_reply);  
		}
	}

/*====================run()===========*/

	
	public void run()
	{
		try
		{
			machine = connection.getInetAddress();
			myself = InetAddress.getLocalHost();
			String replyString = new String("220 SMTP LoveMail myName: " + myself.getHostName() + 
					"[" + myself.getHostAddress() + "]");
			reply(replyString);
			do
			{
				replyString = selectReply(getInput());
				reply(replyString);
				replyString = replyString.substring(0,3);
			}
			while (!replyString.regionMatches(0,"221",0,3));
			System.out.println("--------------- close connection ---------------");
			sleep(100);
			connection.close();
			System.out.println("----------------------------------------------");
		}
		catch(Exception e)
		{
			System.out.println("--Exception-- MailServerThread.run() " + e);
		}
	}

}
