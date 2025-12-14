package TERMINAL;
import  java.io.*;
import  java.net.*;
import  java.awt.*;
import  java.math.BigInteger;
import  SSH.*;
import  Utility.*;
public class SshIO implements Runnable,DATA_TERMINAL
{
	public static boolean DEBUG = false;
	public static SshTerminal _SshTerminal;
	public static Display _Display;
	public static Xterminal _Xterminal;
	public static String Host = "";
	public static int     Port = 22;
	private static String  Loginname = null;
	private static String  Password = null;
	public static Socket  ClientSocket;
	public static BufferedInputStream  is;
	public static BufferedOutputStream os;
	public static Thread       THREAD = null;
	public static boolean echo;
	public static String  term = "ANSI";
	public static boolean firstterm = true;
	public static boolean periodwork =false;
	private int phase = 0;
	private final int PHASE_STRING_VERSION = 0;
	private final int PHASE_BINARY_PUBLICKEY  = 1;
	private final int PHASE_BINARY_AUTHEN_PASSWORD = 2;
	private final int PHASE_SSH_CMSG_REQUEST_PTY = 3;
	private final int PHASE_SSH_CMSG_EXEC_SHELL = 4;
	private final int PHASE_INTERACTION       = 5; 
	private String identification_client_string = "SSH-1.5-1.2.26\n";
	public  static final int SSH_MSG_ANY	=				   -1;
	public  static final int SSH_MSG_NONE =					0;
	public  static final int SSH_MSG_DISCONNECT =				1;
	private static final int SSH_SMSG_PUBLIC_KEY =			2;
	private static final int SSH_CMSG_SESSION_KEY =		    3;	
	private static final int SSH_CMSG_USER =				    4;
	private static final int SSH_CMSG_AUTH_PASSWORD =			9;
	private static final int SSH_CMSG_REQUEST_PTY =		    10;
	private static final int SSH_CMSG_EXEC_SHELL =			12;
	private static final int SSH_SMSG_SUCCESS =			    14;
	private static final int SSH_SMSG_FAILURE =			    15;
	public  static final int SSH_CMSG_STDIN_DATA =			16;
	public  static final int SSH_SMSG_STDOUT_DATA =		    17;
	public  static final int SSH_MSG_CHANNEL_DATA =			23;
	public  static final int SSH_SMSG_STDERR_DATA =		    18;
	private static final int SSH_SMSG_EXITSTATUS =			20;
	public  static final int SSH_MSG_IGNORE =				    32;
	private static final int SSH_CMSG_EXIT_CONFIRMATION =		33;
	public  static final int SSH_MSG_DEBUG       =			36;
	private static int SSH_CIPHER_NONE = 0;	 // No encryption						//not supported on thor
	private static int SSH_CIPHER_IDEA = 1;  // IDEA in CFB mode				//Supported on thor, iplemented !
	private static int SSH_CIPHER_DES  = 2;  // DES in CBC mode						//not supported on thor
	private static int SSH_CIPHER_3DES = 3;  // Triple-DES in CBC mode			//Supported on thor, not implemented !
	private static int SSH_CIPHER_TSS  = 4;  // An experimental stream cipher		//not supported on thor
	private static int SSH_CIPHER_RC4  = 5;  // RC4
	public  static int CIPHER_BLOWFISH = 6; // Bruce Schneier's Blowfish */
	public  static int CIPHER_RESERVED = 7; // Reserved for 40 bit crippled encryption,

	public final static String[][] cipherClasses = 
	{
		{ "NoEncrypt", "none"     }, // No encryption
		{ null,        "idea"     }, // IDEA in CFB mode
		{ "DES",       "des"      }, // DES in CBC mode
		{ "DES3",      "3des"     }, // Triple-DES in CBC mode
    };
	// authentication methods 

	private static final int SSH_AUTH_RHOSTS =		1;   //.rhosts or /etc/hosts.equiv
	private static final int SSH_AUTH_RSA =			2;   //pure RSA authentication
	private static final int SSH_AUTH_PASSWORD =	    3;   //password authentication, implemented !
	private static final int SSH_AUTH_RHOSTS_RSA =   4;   //.rhosts with RSA host authentication
	private  int    TTY_OP_END	     = 0;
	private  int    TTY_VINTR   = 1;
	private  int    TTY_PARMRK = 31;
	private KeyPair srvServerKey;
	private KeyPair srvHostKey;
	private byte[]  srvCookie;
	private int     protocolFlags;
	private int     supportedCiphers;
	private int     supportedAuthTypes;
	private byte[] sessionKey;
	private byte[] sessionId;
	private String srvVersion;
	public final static int    SESSION_KEY_LENGTH = 256; // !!! Must be multiple of 8
	public final static int    SERVER_KEY_LENGTH  = 768;
	public final static int    HOST_KEY_LENGTH    = 1024;
	public static SecureRandom SR=null;
	public static int  cipherType = SSH_CIPHER_3DES;//SSH_CIPHER_IDEA; //74 (1,3,6)
	public static int  AuthTypes  = SSH_AUTH_PASSWORD;
	public static Cipher sndCipher;
	public static Cipher rcvCipher;

	public SshIO(String L,String P)
	{
		Loginname = L;
		Password  = P;
		Host = _Xterminal.getHost();
		_SshTerminal = new SshTerminal();
		_Display = new Display();
  		_Display.ClearAll();
	}//constructor Normal

	//@role: this is method used initial contact server port and buffer for receive and sent data stream
	//input : host name
	//output : connection
	public void connect(String H)
	{
		if (DEBUG) System.out.println("Connected XXXXXXXXX");
		echo = false;
  		try
		{
			if((ClientSocket = new Socket(Host,Port)) == null) //request contact server
			{
				_Xterminal.Switch = false;
	   			Display("Xterminal Failed to Connect to Host"+Host+"\n");
				return;
			}
		}//try
		catch(UnknownHostException e)
		{
			_Xterminal.Switch = false;
			Display("Host "+Host+" not found\n");
			return;
		}//catch1
		catch(IOException e)
		{
			_Xterminal.Switch = false;
			Display("Xterminal Failed to connect to host "+Host+"\n");
			return;
		}//catch2
		catch(Exception e)
		{
			_Xterminal.Switch = false;
			Display("Xterminal Security violation on socket for host "+Host+"\n");
			return;
		}//catch3
		try
		{
			is = new BufferedInputStream(ClientSocket.getInputStream(),8192); //prepare create input buffer 
		}//try1
		catch(IOException e)
		{
			Display("Xterminal Failed to get stream from socket");
			System.exit(5);
		}//catch datain
		try
		{
			os = new BufferedOutputStream(ClientSocket.getOutputStream());  //prepare create output buffer
		}//try2
		catch(IOException e)
		{
			Display("Xterminal Failed to put stream on socket");
			System.exit(5);
		}//catch dataout

		Display("Xterminal Connect to "+Host+" Port "+Port+"  Complete\n");
		THREAD = new Thread(this);
		THREAD.start();
	}//method connect()

	//@role:  this is method used display string on screen
	//input : string message
	//output : display message
	public void Display(String str)
	{
		for(int i =0;i<str.length();i++)
		DisplayCh(str.charAt(i));
	}//method Display()

	public void DisplayCh(char c)		  //
	{
  		_SshTerminal.DisplayChar(c);
		_SshTerminal.Paint();
	}
  
	//@role: this is method used for cancel connection
	//input : none
	//output : disconnect socket,stop!  thread used receive 
	public void Disconnect()
	{
  		if(THREAD != null)
		{  
			try
			{
				Display("\n\rDisconnect from "+Host+"completely");
				Ssh_Msg_Disconnect();
			}
			catch(Exception e)
			{
				System.out.println("Xterminal Disconnected From "+Host+"Uncomplete");
			}
			THREAD.stop();
			THREAD = null;
			ClientSocket = null;
			is = null;os = null;
		}//if
        if (DEBUG) System.out.println("Secure Shell Disconnect OK");              
        Display("\n\rXterminal Disconnected From "+Host);
	}//method Disconnect()

	//@role: this is method used receive data from server, used by THREAD
	//input : none
	//output : data bytes
	public void run()					 /////////
	{ 
		while(THREAD != null)
		{  
			try
			{	 //THREAD.sleep(1000);
				switch(phase)
				{
					case PHASE_STRING_VERSION:  //inspection version of server 
					if(GetVersionString()){++phase;};
					Display("\n\r[ Command ] Client sent  String  Version OK....");     
					break;
					case PHASE_BINARY_PUBLICKEY: //receive binary packet for generate public key  and private key
						Display("\n\r[ Command ] Received and Calculation session Key...");	  
						receiveServerData();
						generateSessionId();//16 byte length;
						generateSessionKey();//32 byte length;
						initClientCipher();
						if(DEBUG) System.out.println("cipherType ===="+cipherType);
						sendSessionKey(cipherType); //cipherType = 3DES'
						Display("\n\r[ Command ] Send Session Key success ...");		   
						phase++;
						break;
					case PHASE_BINARY_AUTHEN_PASSWORD : //sent user and password for authentication 
						Display("\n\r[ Command ] Client Authentication...");
						if(DEBUG) System.out.println("Client Authentication...");
						authenticateUser();
						Display("\r\n[ Command ] Client Authentication success...");
						phase++;
						break;
					case PHASE_SSH_CMSG_REQUEST_PTY:  //request to server for set terminal for appropriate respond
						Display("\n\r[ Command ] Client request PTY...");  
						Ssh_Cmsg_Request_Pty();
						phase++;
						break;
					case  PHASE_SSH_CMSG_EXEC_SHELL:   //start shell for interaction
						Display("\n\rClient request Execute Shell ...");
						Ssh_Exec_Shell();
						_Display.start();
						phase++;
						break;
					case  PHASE_INTERACTION :        //receive data is standard vt100
						InteractionLoop();
						break;
					default: System.out.println("out fo phase");
						phase=0;
						break;
				 }//switch
			}catch(Exception e){System.out.println("Recived Error !-->"+e);THREAD = null;}
		}//while
	}//run

	//@role: this is method used for receive data from server and send to assosiation part for  separate packet
	//input : packet binary
	//output : data packet is bytes 
	public void receive() throws IOException
	{     
  		if(ClientSocket == null) throw new IOException("Connection close "); 
		byte buff[] = null;
		int start = 0;
		if (buff==null)
		{
			if(DEBUG) System.out.println("Listining........");
			int count = is.available();
	 		buff = new byte[count];
			count = is.read(buff,0, buff.length);
			if(count < 0) System.out.println("End of file ................");
			if (count<=buff.length) 
			{
				byte[] newBuff = new byte[count];
				for(int i=0; i<count; i++) newBuff[i] = buff[i];
				buff = newBuff;
			}
			Displaystream(buff,count);
		}
	}//end of receive()

	//@role: this is method used only first time for get server string version of server and respond our string version go back server
	//input : string version server
	//output : sent our string version 
	private boolean GetVersionString() throws IOException 
	{
		byte[] buf = new byte[256];
		int    len;
		String srvVersion;
		len = is.read(buf);
		srvVersion = new String(buf, 0, len);
		if(srvVersion.indexOf("SSH-1.5") != 0)
		Display("Version mismatch, can't talk to server");
		Display("\n\r Server sent string Version ---> "+srvVersion);
		byte[] StringByte = new byte[identification_client_string.length()];
		identification_client_string.getBytes(0,identification_client_string.length(),StringByte,0);
		os.write(StringByte);
		os.flush();
		return true;
	}

	//@role: this is essential method of encryption RSA type for generate public key and private key.
	// input : read packet binary 
	//output : separate packet type 
	private void receiveServerData() throws IOException 
	{
		SSHBufferInputStream Din = new SSHBufferInputStream(SSH_SMSG_PUBLIC_KEY,null);
		Din.readFrom(is);	   //read data cal check sum and type
        
	       	int bits;
			BigInteger e, n;
			srvCookie = new byte[8];
			Din.read(srvCookie, 0, 8);
             
			bits = Din.readInt();
			e = Din.readBigInteger();
			n = Din.readBigInteger();
			srvServerKey = new KeyPair(new RSAPublicKey(e, n), null);
             
			bits = Din.readInt();
			e = Din.readBigInteger();
			n = Din.readBigInteger();
			srvHostKey = new KeyPair(new RSAPublicKey(e, n), null);
			
			protocolFlags      = Din.readInt();
			supportedCiphers   = Din.readInt();//default = 74;
			supportedAuthTypes = Din.readInt();//dafault = 30;
			if(!isCipherSupported(cipherType))
			{
				if(DEBUG) System.out.println("Sorry, server does not support cipherType"); 
				throw new IOException("Sorry, server does not support type");
			}         
	}

	//@role: this is method used check server support cipher (Example -> DES,3DES,IDEA)
	//input : cipher type (this project used 3DES)
	//output : return ture if server support cipher
	public boolean isCipherSupported(int cipherType) 
	{
		int cipherMask = (0x01 << cipherType);
		if((cipherMask & supportedCiphers) != 0)
		return true;
		return false;
	}

	//@role: this is method used for generate session id by concatenate server key + host key + cookie (Ex -> [server key][host key][cookie])
	//         and  we are session id bring entry MD5 process  for  16 bytes remain   
	//input : server key(768 bits),host key(1024 bits),cookie(64 bits)
	//output :  16 bytes session id
	void generateSessionId() throws IOException 
	{
		if(DEBUG) System.out.println("SshIO generrateSessionID ...");
		byte[]			message;
		byte[]			srvKey = ((RSAPublicKey)srvServerKey.getPublic()).getN().toByteArray();
		byte[]			hstKey = ((RSAPublicKey)srvHostKey.getPublic()).getN().toByteArray();
		int				i, len = srvKey.length + hstKey.length + srvCookie.length;

		if(srvKey[0] == 0)	len -= 1;
		if(hstKey[0] == 0)	len -= 1;
		message = new byte[len];
		if(hstKey[0] == 0) 
		{
			System.arraycopy(hstKey, 1, message, 0, hstKey.length - 1);
			len = hstKey.length - 1;
		} 
		else 
		{
			System.arraycopy(hstKey, 0, message, 0, hstKey.length);
			len = hstKey.length;
		}
		if(srvKey[0] == 0) 
		{
			System.arraycopy(srvKey, 1, message, len, srvKey.length - 1);
			len += srvKey.length - 1;
		} 
		else 
		{
			System.arraycopy(srvKey, 0, message, len, srvKey.length);
			len += srvKey.length;
		}
		System.arraycopy(srvCookie, 0, message, len, srvCookie.length);
		try 
		{
			MessageDigest md5;
			md5 = MessageDigest.getInstance("MD5");
			md5.update(message);
			sessionId = md5.digest();
		} 
		catch(Exception e) 
		{
			if(DEBUG) System.out.println("MD5 not implemented, can't generate session-id");
			throw new IOException("MD5 not implemented, can't generate session-id");
		}
	}

	 //@role: this is method used for generate 32 bytes session key with integer not zero random consist
	 //input : expect 32 bytes integer random 
	 //output : 32 bytes random
	private void generateSessionKey() 
	{
		if(DEBUG) System.out.println("SshIO generrateSessionKey ...");
		SecureRandom rand = secureRandom();
		sessionKey = new byte[SESSION_KEY_LENGTH / 8];
		rand.nextBytes(sessionKey);
	}

	//@role: this is method used for generate number integer is not zero
	//input : none
	//output : bytes random
	 public static SecureRandom secureRandom() 
	 {
		if(SR == null) 
		{
			SR = new SecureRandom();
		}
		return SR;
	}	 

	private void initClientCipher() 
	{
		initCipher();
	}

	//@role: this is method used for determine cipher (Ex -> 3DES)
	//input : cipher name
	//output : cipher class
	private void initCipher() 
	{
		sndCipher = Cipher.getInstance(cipherClasses[cipherType][0]);
		rcvCipher = Cipher.getInstance(cipherClasses[cipherType][0]);
		sndCipher.setKey(sessionKey);
		rcvCipher.setKey(sessionKey);
	}
 
	//@role: this is method used for calculate RSA encryption type and sent session key success calcuated  go to server
	//input : cipher type
	//output : send encrypted session key send to server 
	private void sendSessionKey(int cipherType) throws IOException 
	{
		byte[]					key = new byte[sessionKey.length + 1];
		BigInteger		encKey;
		RSACipher		rsa;
		SSHBufferOutputStream pdu;
		key[0] = 0;
		System.arraycopy(sessionKey, 0, key, 1, sessionKey.length);
		for(int i = 0; i < sessionId.length; i++)	
			key[i + 1] ^= sessionId[i];
		encKey = new BigInteger(key);
		if(((RSAPublicKey)(srvServerKey.getPublic())).bitLength() < ((RSAPublicKey)(srvHostKey.getPublic())).bitLength()) 
		{
			BigInteger padded;
			rsa = new RSACipher(srvServerKey);
			padded = rsa.doPad(encKey, ((RSAPublicKey)srvServerKey.getPublic()).bitLength(), secureRandom());//random padding 
			encKey = rsa.doPublic(padded); //mod and power
			rsa = new RSACipher(srvHostKey);
			padded = rsa.doPad(encKey, ((RSAPublicKey)srvHostKey.getPublic()).bitLength(), secureRandom());
			encKey = rsa.doPublic(padded);
		} 
		else 
		{
			BigInteger padded;
			rsa = new RSACipher(srvHostKey);
			padded = rsa.doPad(encKey, ((RSAPublicKey)srvHostKey.getPublic()).bitLength(), secureRandom());
			encKey = rsa.doPublic(padded);
			rsa = new RSACipher(srvServerKey);
			padded = rsa.doPad(encKey, ((RSAPublicKey)srvServerKey.getPublic()).bitLength(), secureRandom());
			encKey = rsa.doPublic(padded);
		}
	pdu = new SSHBufferOutputStream(SSH_CMSG_SESSION_KEY, null); //data output stream
	pdu.writeByte((byte)cipherType);    //data output stream
	pdu.write(srvCookie, 0, srvCookie.length); //buffer inputstream
	pdu.writeBigInteger(encKey);//buffer inputstream
	pdu.writeInt(protocolFlags);//buffer inputstream
	pdu.writeTo(os);
	if(!isSuccess())
	{
		if(DEBUG) System.out.println("Error while sending session key!!!! ");
		throw new IOException("Error while sending session key!");}
	}

	//@role: this is method used check message respond from server
	//input : message type
	//output : return true if message success
	private boolean isSuccess() throws IOException 
	{
		boolean success = false;
		SSHBufferInputStream inpdu = null;
		inpdu = new SSHBufferInputStream(SSH_MSG_ANY, rcvCipher);	
		inpdu.readFrom(is);
		if(inpdu.type == SSH_SMSG_SUCCESS)
		{
			if(DEBUG) System.out.println("SSH_SMSG_SUCCESS");
			Display("\r\nSSH_SMSG_SUCCESS");
			success = true;
		}
		else if(inpdu.type == SSH_SMSG_FAILURE)
			success = false;
		else if(inpdu.type == SSH_MSG_DISCONNECT)
			throw new IOException("Server disconnected: " + inpdu.readString());
		else 
			throw new IOException("Protocol error: got " + inpdu.type + " when expecting success/failure");
		return success;
	}

	//@role: this is method used for check of bug JDK text field ,while you get text field It's have lead space (_)
	//input : string message
	//output : return without lead space of string
	private String CheckSpace(String s) throws IOException
	{
		byte[] Lo = s.getBytes();  
		if(Lo[0] != 32) return s;
		byte[]  temp = new byte[Lo.length-1];
		System.arraycopy(Lo,1,temp,0,temp.length);
		Lo = temp;
		return new String(Lo);
	}

	//@role: this is method used for user name and password authentication strategic
	//input : user name 
	//output : return true if server correct authentication  
	private void authenticateUser() throws IOException 
	{
		SSHBufferOutputStream auout;
		auout = new SSHBufferOutputStream(SSH_CMSG_USER, sndCipher);
		String Login =  CheckSpace(Loginname);
		auout.writeString(Login);
		auout.writeTo(os);
		if(isSuccess()) 
		{
			if(DEBUG) System.out.println("Authentication Ok ...");         
			return;
		} 
		if(!isAuthTypeSupported())
		{
			throw new IOException("Server does not support authentication");  
		}
		SSHBufferOutputStream passout;
		passout = new SSHBufferOutputStream(SSH_CMSG_AUTH_PASSWORD, sndCipher);
		String Pass =  CheckSpace(Password);
		passout.writeString(Pass);
		passout.writeTo(os);
		if(!isSuccess())
		{
			Display("\n\rSecure Shell does not support authentication");
			throw new IOException("Secure Shell does not support authentication !!!");
		}
	}

	private boolean isAuthTypeSupported() 
	{
		int authTypeMask = (0x01 << AuthTypes);
		if((authTypeMask & supportedAuthTypes) != 0)
		return true;
		return false;
	}
	
	//@role: this is method used for client tell message disconnect type  go to server
	//input : message(order 1)
	//output : binary packet disconnect
	private void Ssh_Msg_Disconnect() throws IOException 
	{
		SSHBufferOutputStream Disout;
		Disout = new SSHBufferOutputStream(SSH_MSG_DISCONNECT, sndCipher);
		Disout.writeTo(os);
	}

	//@role: this is method used request pseudo-terminal goto server
	//input : message(order 10)
	//output : binary packet request pty
	private void Ssh_Cmsg_Request_Pty() throws IOException
	{
		SSHBufferOutputStream Ptyout = new SSHBufferOutputStream(SSH_CMSG_REQUEST_PTY,sndCipher);
		Ptyout.writeString(termType);
		Ptyout.writeInt(_Display.Char_Canvas_Height);
		Ptyout.writeInt(_Display.Char_Canvas_Width);
		Ptyout.writeInt(_Display.WINDOWS_WIDTH);
		Ptyout.writeInt(_Display.WINDOWS_HEIGHT);
		Ptyout.writeByte((byte)TTY_OP_END);
		Ptyout.writeTo(os);
		if(!isSuccess())
		{
			System.out.println("Error requesting PTY !!!");
			throw new IOException("Error requesting PTY !!!");
		}
	}  

	//@role: starts s shell and enters interactive session mode
	//input : message(order 13)
	//output : binary packet starts shell
	private void Ssh_Exec_Shell() throws IOException 
	{
		SSHBufferOutputStream Exout = new SSHBufferOutputStream(SSH_CMSG_EXEC_SHELL, sndCipher);
		Exout.writeTo(os);
	}

	//@role: this is method used for interaction mode 
	//input : bytes of vt100
	//output : respond command of vt100 
	private void InteractionLoop() throws IOException 
	{
		SSHBufferInputStream action = new SSHBufferInputStream(SSH_MSG_ANY, rcvCipher);
		action.readFrom(is);
		switch(action.type)
		{
			case SSH_SMSG_STDOUT_DATA:
				byte[] Dou = new byte[action.readInt()];
         		action.read(Dou,0,Dou.length);
				Displaystream(Dou,Dou.length);
 				break;
			case SSH_SMSG_STDERR_DATA: 
				byte[] Drr = new byte[action.readInt()];
         		action.read(Drr,0,Drr.length);
				Displaystream(Drr,Drr.length);
				break;
			case SSH_SMSG_EXITSTATUS: 
				byte[] Exi = new byte[action.readInt()];
         		action.read(Exi,0,Exi.length);
				Display(" ******************* Server Exit Status ******************* ");
				Displaystream(Exi,Exi.length);
				Ssh_Client_Exit_Confirm();
				THREAD = null;
				ClientSocket = null;
				is = null;os = null;
                                System.exit(0);
				break; 
		}//switch()
	}

	//@role: this is method used for client confirm  disconnection
	//input : message (order 33)
	//output : packet confirm disconnection
	private void Ssh_Client_Exit_Confirm() throws IOException 
	{
		SSHBufferOutputStream confirm = new SSHBufferOutputStream(SSH_CMSG_EXIT_CONFIRMATION,sndCipher);  
		confirm.writeTo(os);
	}

	//@role: this is method used for display massage from server
	//input : bytes ,bytes length
	//output : draw message on screen 
	public void DisplayByte(byte b[],int len)
	{
 		_SshTerminal.HoldFore   = _SshTerminal.ForeGround;
		_SshTerminal.HoldBack   = _SshTerminal.BackGround;
		_SshTerminal.ForeGround = _SshTerminal.CharForeGroundArray[_SshTerminal.Line][_SshTerminal.Column];
		_SshTerminal.BackGround = _SshTerminal.CharBackGroundArray[_SshTerminal.Line][_SshTerminal.Column];
		_SshTerminal.DisplayCharOnScreen(_SshTerminal.CharArray[_SshTerminal.Line][_SshTerminal.Column]);
		_SshTerminal.ForeGround = _SshTerminal.HoldFore;
		_SshTerminal.BackGround = _SshTerminal.HoldBack;
		int i = 0;
		while(i<len)
		{
			if(b[i] == 255-256)
			{
	  			i++;
				if(b[i] == 250-256)
				{
					while((i<len) && (b[i] != 240-256)) i++;
					i++;
				}//if()2
				else 
				{
					i +=2;
				}//else of if()2
			}//if()1
			else
			{
				if(b[i] < 0)
					_SshTerminal.DisplayChar((char)(((char)b[i])+256));
				else
					_SshTerminal.DisplayChar((char)b[i]);
				i++;
			}  
		}//while(i < len)
		_SshTerminal.SetGraphicsColor(_SshTerminal.CharForeGroundArray[_SshTerminal.Line][_SshTerminal.Column].brighter());
		_SshTerminal.DrawString("_",(_SshTerminal.Column*_SshTerminal.CharWidth),(_SshTerminal.Line+1)*_SshTerminal.CharHeight-_SshTerminal.CharDescent);
	}//method DisplayByte()


	//****************************************************************
	//		           part of transmit char of key down & key up
	//****************************************************************

	public void Displaystream(byte b[],int len)
	{
		DisplayByte(b,len);
		_SshTerminal.Paint();
	}//method DisplayStream()

	//@role: this is used for send key press from client to server
	//input : string 
	//output : message
	public static void SendHost(String string)throws IOException 
	{
		SSHBufferOutputStream send = new SSHBufferOutputStream(SSH_CMSG_STDIN_DATA,sndCipher);
		send.writeString(string);
		send.writeTo(os);
	}

}//class Normal  
