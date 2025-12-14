package IsecQ;
import java.awt.*;
import java.io.*;
import java.net.*;
import java.math.BigInteger;
import IsecQ.*;

public class  TCPreceiveThread extends Thread
{	
	private int								numUIN;
	private IsagQ						f = new IsagQ();
	private UserAllInfo				myallinfo;
	private UserAllInfo[]				usrArr;
	private TextArea					ta;
	private ReceiveMessage	receiveMessage;
	private Socket						socket ,remote;
	private DataInputStream		is;
	private DataOutputStream	os;
	private ServerConnect		sconnect;
	private TCPconnect			tcpConnect;
	private CHANNEL_INIT				init_rcv				= new CHANNEL_INIT();
	private CHANNEL_MESSAGE	msg_send		= new CHANNEL_MESSAGE();
	private CHANNEL_MESSAGE	msg_receive	= new CHANNEL_MESSAGE();

	private short packet_len;
	private byte[] bytes_packet;
	private short msg_type=1;

	private RSA	 rsa		=new RSA();
	private DES ddes	=new DES();
	private Util	 u			=new Util();

	private BigInteger	E = new BigInteger("0");
	private BigInteger	D = new BigInteger("0");
	private BigInteger	N = new BigInteger("0");
	private BigInteger	DESencrypted = new BigInteger("0");
	private byte[]			DES = new byte[0];

//============================ CONSTRUCTOR ===================================
	TCPreceiveThread(){};
//============================ CONSTRUCTOR ===================================
	
	public void setInformation( IsagQ f ,UserAllInfo myallinfo ,UserAllInfo[] usrArr ,int numUIN ,
									 ServerConnect sconnect	,TCPconnect tcpConnect	,TextArea ta )throws IOException
	{	this.f = f;
		this.myallinfo = myallinfo;
		this.usrArr = usrArr;
		this.numUIN = numUIN;
		this.sconnect = sconnect;
		this.tcpConnect = tcpConnect;
		this.ta = ta;
	}

//=========================== RUN THREAD =======================================
	public void run()
	{	try
		{	ta.append("receive thread started\n");
			ta.append("accept port"+myallinfo.getPort()+"\n");
			msg_send.setUIN			(myallinfo.getUIN());
			msg_send.setPort			(myallinfo.getPort());
			msg_send.setIP				(myallinfo.getIP());
			
			while(true)
			{	socket=accept((int)myallinfo.getPort());
				is=new DataInputStream(socket.getInputStream());
				packet_len=is.readShort();	
				packet_len=u.bytes2Short(u.short2BytesSW(packet_len));
				bytes_packet=new byte[packet_len];
				if (packet_len==26) // if imcomming packet is channel_init
				{	is.	read(bytes_packet);
					ta.append("****************** RECEIVE INIT ****************\n");
					ta.append(u.bytes2HxStr(bytes_packet)+"\n");
					ta.append("length :"+packet_len+"\n");
					System.out.print("****************** RECEIVE INIT ****************\n");
					System.out.print(u.bytes2HxStr(bytes_packet)+"\n");
					System.out.print("length :"+packet_len+"\n");
					init_rcv.receiveData(bytes_packet);
					packet_len=is.readShort();	
					packet_len=u.bytes2Short(u.short2BytesSW(packet_len));
				} // end if channel_init
				ta.append("****************** RECEIVE MESSAGE ****************\n");
				ta.append("Packet length :"+packet_len+"\n");
				System.out.print("****************** RECEIVE MESSAGE ****************\n");
				System.out.print("Packet length :"+packet_len+"\n");
				bytes_packet=new byte[packet_len];
				is.read(bytes_packet);
				msg_receive.receiveData(bytes_packet);
				ta.append(u.bytes2HxStr(bytes_packet)+"\n");
				System.out.print(u.bytes2HxStr(bytes_packet)+"\n");
				msg_receive.printAll(ta);
				msg_receive.printAll();
	
				//---------------------------- if received message is not  acknowledge message-------------------------------
				if (!msg_receive.getMessage().equals("")) 
				{	
					//************************** CHECK SECURE COMMAND ***************************************************
					// -------------------------Check send RSA Public key  command-------------------------------------
//					if (msg_receive.getMsgCmd() == msg_receive.getSendPublicKeyCMD())
					if ((msg_receive.getMsgCmd() == msg_receive.getSendPublicKeyCMD()) || 
						(msg_receive.getMsgCmd() == msg_receive.getSendPublicKeyCMD2()))
					{	//------------------- Check message for ask IsagQ question --------------------------
						ta.append("****************** Receive Public Key E ****************\n");
						System.out.print("****************** Receive Public Key E ****************\n");
						E = new BigInteger(msg_receive.getMessage());

						ta.append("****************** Receive Public Key N ****************\n");
						System.out.print("****************** Receive Public Key N ****************\n");
						packet_len = is.readShort();	
						packet_len = u.bytes2Short(u.short2BytesSW(packet_len));
						ta.append("Packet length :" + packet_len + "\n");
						System.out.print("Packet length :" + packet_len + "\n");
						bytes_packet = new byte[packet_len];
						is.read(bytes_packet);
						msg_receive.receiveData(bytes_packet);
						ta.append(u.bytes2HxStr(bytes_packet) + "\n");
						System.out.print(u.bytes2HxStr(bytes_packet) + "\n");
						msg_receive.printAll(ta);
						msg_receive.printAll();
						N = new BigInteger(msg_receive.getMessage());
						ta.append("\n");
						ta.append("****************** Send Encrypted DES Key ****************\n");
						System.out.print("****************** Send Encrypted DES Key ****************\n");
						ta.append("Key E =\n"+E+"\n");
						ta.append("Key N =\n"+N+"\n");
						ta.append("My DES Key = \n");
						DES =myallinfo.getKey_DES();
						for (int i=0 ;i<DES.length ;i++ )
						{	ta.append(DES[i]+" ");
						}
						ta.append("\n");
						String DES_en_str = encryptDESKey(E ,N ,myallinfo.getKey_DES());
						msg_send.SendEnCrytedDESKeyCMD();
						msg_send.setMessage	(DES_en_str);
						msg_send.setMsgType	(msg_type);
						msg_send.setTCP_SEQ(msg_receive.getTCP_SEQ());
						ta.append("reply packet length: "+msg_send.getPacketLen()+"\n");
						System.out.print("reply packet length: "+msg_send.getPacketLen()+"\n");
						for (int i=0;i<numUIN ;i++ )
						{	if (msg_receive.getUIN1()==usrArr[i].getUIN())
							{	usrArr[i].setKey_DES(myallinfo.getKey_DES());
								remote = new Socket(usrArr[i].getIPStr() ,usrArr[i].getPort());
								usrArr[i].setIsagQ();
							}
						}
						clearAllKey();
						f.repaint();
						os = new DataOutputStream(remote.getOutputStream());
						os.write(u.short2BytesSW(msg_send.getPacketLen()));
						os.write(msg_send.getAllBytes());
						msg_send.printAll(ta);
						msg_receive.printAll();
						remote.close();
					} // end check secure command
					else if ((msg_receive.getMsgCmd() == msg_receive.getSendEnCrytedDESKeyCMD()) ||
								(msg_receive.getMsgCmd() == msg_receive.getSendEnCrytedDESKeyCMD2())   )
					{	//------------------- Check message for ask IsagQ question --------------------------
						ta.append("****************** Receive Encryted DES Key ****************\n");
						System.out.print("****************** Receive Encryted DES Key ****************\n");
						ta.append("My Key D =\n " + myallinfo.getKey_D() + "\n");
						ta.append("My Key N =\n " + myallinfo.getKey_N() + "\n");
						ta.append("Rcv Msg  =\n " + msg_receive.getMessage() + "\n");
						DES = getDESKey(myallinfo.getKey_D() ,myallinfo.getKey_N() ,msg_receive.getMessage());
						ta.append("\n Receive DES = \n ");
						for (int i=0 ;i<DES.length ;i++ )
						{	ta.append(DES[i]+" ");
						}
						ta.append("\n");
						for (int i=0 ;i<numUIN ;i++ )
						{	if (msg_receive.getUIN1() == usrArr[i].getUIN())
							{	usrArr[i].setKey_DES(DES);
								usrArr[i].setIsagQ();
							}
						}
						clearAllKey();
						f.repaint();
					}
					else if ((msg_receive.getMsgCmd() == msg_receive.getSendEncryptMsgCMD()) ||
								(msg_receive.getMsgCmd() == msg_receive.getSendEncryptMsgCMD2())   )
					{	//------------------- received encrypted message --------------------------
						ta.append("****************** Receive Encryted Message ****************\n");
						System.out.print("****************** Receive Encryted Message ****************\n");
						for (int i=0 ;i<numUIN ;i++ )
						{	if (msg_receive.getUIN1() == usrArr[i].getUIN()) 
							{	DES = usrArr[i].getKey_DES();
								ta.append(" DES = \n");
								for (int j=0 ;j<DES.length ;j++ )
								{	ta.append(DES[j]+" ");
								}
								ta.append("\n");
								ddes.setKey(usrArr[i].getKey_DES());
								BigInteger msg_big = new BigInteger(msg_receive.getMessage());
								byte[] msg_byte =	msg_big.toByteArray();
								byte[] msg_dec = ddes.decrypt(msg_byte);
								byte[] msg_depad = ddes.dePaddingMessage(msg_dec);
								ta.append(" msg depad length ="+msg_depad.length+"\n");
								String real_msg = new String(msg_depad);
								ta.append("message after decrypted = "+real_msg+"\n");
								clearAllKey();
								receiveMessage = new ReceiveMessage(usrArr[i] ,real_msg ,sconnect ,tcpConnect);
								remote = new Socket(usrArr[i].getIPStr() ,usrArr[i].getPort());
								os = new DataOutputStream(remote.getOutputStream());
							}
						}								
						ta.append("****************** REPLY ****************\n");
						System.out.print("****************** REPLY ****************\n");
						msg_send.setReplyCMD();
						msg_send.setMessage("");
						msg_send.setMsgType(msg_type);
						msg_send.setTCP_SEQ(msg_receive.getTCP_SEQ());
						ta.append("reply packet length: "+msg_send.getPacketLen()+"\n");
						System.out.print("reply packet length: "+msg_send.getPacketLen()+"\n");
						os.write(u.short2BytesSW(msg_send.getPacketLen()));
						os.write(msg_send.getAllBytes());
						msg_send.printAll(ta);
						msg_receive.printAll();
						remote.close();
					}
					//**************************** END RESPONSE ISAGQ QUESTION **************************************
					else 							//--------------------------------------- receive normal message -----------------------------------
					{	boolean inlist = false;
						for (int i=0 ;i<numUIN ;i++ )
						{	if (msg_receive.getUIN1() == usrArr[i].getUIN())
							{	//------------- receive message and create socket for user that in my contact list -------------------------------
								receiveMessage = new ReceiveMessage(usrArr[i] ,msg_receive.getMessage(),sconnect ,tcpConnect);
								remote = new Socket(usrArr[i].getIPStr() ,usrArr[i].getPort());
								os = new DataOutputStream(remote.getOutputStream());
								inlist = true;
							}
						}								
/*						if (!inlist)//------------- receive message and create socket for user that can't find in my contact list ------------------------
						{	receiveMessage=new ReceiveMessage(msg_receive.getUIN1() ,msg_receive.getMessage(),sconnect ,tcpConnect);
							remote = new Socket(msg_receive.getIPStr() ,msg_receive.getPort());
							os = new DataOutputStream(remote.getOutputStream());
						}
*/						ta.append("****************** REPLY ****************\n");
						System.out.print("****************** REPLY ****************\n");
						msg_send.setReplyCMD();
						msg_send.setMessage("");
						msg_send.setMsgType(msg_type);
						msg_send.setTCP_SEQ(msg_receive.getTCP_SEQ());
						ta.append("reply packet length: "+msg_send.getPacketLen()+"\n");
						System.out.print("reply packet length: "+msg_send.getPacketLen()+"\n");
						os.write(u.short2BytesSW(msg_send.getPacketLen()));
						os.write(msg_send.getAllBytes());
						msg_send.printAll(ta);
						msg_receive.printAll();
						remote.close();
					}// end receive normal message
				} // end check not ack message;
				socket.close();
			} //end while
		}// end try
		catch (IOException e)
		{	System.out.println(e);
		}
	}
//=================== CLEAR ALL KEY ====================================
	public void clearAllKey()
	{	E =new BigInteger("0");	// clear key E
		N =new BigInteger("0");	// clear key N
		DESencrypted  = new BigInteger("0");	// clear key DESecrypted
		DES = new byte[0];
	}
//=================== ENCRYPTED DES KEY ====================================
	public String encryptDESKey(BigInteger e ,BigInteger n ,byte[] des)
	{	BigInteger des_big = new BigInteger(des);
		BigInteger des_en = rsa.Encrypt(e ,n ,des_big);
		return des_en.toString();
	}

//=================== GET DES KEY FROM ENCRYPTED MESSAGE ====================================
	public byte[] getDESKey(BigInteger d ,BigInteger n ,String msg)
	{	BigInteger des_en_big = new BigInteger(msg);
		BigInteger des_dec = rsa.Decrypt(d ,n ,des_en_big);
		return des_dec.toByteArray();
	}
//=========================== CREATE SERVER SOCKET =======================================
	Socket accept(int port) throws IOException
	{	ta.append("Starting on port "+port+"\n");
		ServerSocket server=new ServerSocket(port);
		ta.append("Waiting\n");
		Socket client=server.accept();
		server.close();
		System.out.print("Starting on port "+port+"\n");
		System.out.println("Waiting\n");
		return client;
	}// end accept
}// end class