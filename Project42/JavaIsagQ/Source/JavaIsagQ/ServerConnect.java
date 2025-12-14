package IsecQ;
import java.awt.event.*;
import java.awt.*;
import java.util.*;
import java.net.*;
import java.io.*;
import IsecQ.*;

public class ServerConnect extends Frame implements WindowListener,ActionListener 
{	static Util u=new Util();
	static TextArea ta;
	static InetAddress serverAddr;
	static DatagramSocket datagramSocket;
	int	 serverPort;	
	ClientToServerCMD cmd=new ClientToServerCMD();
	HeadPacket rcvHeadPacket=new HeadPacket();
		
	ServerConnect()
	{}

//	public void init(String serverName, int sPort)throws IOException,UnknownHostException
	public void Connect (String serverName, int sPort ,TextArea ta)throws IOException,UnknownHostException
	{	serverPort=sPort;
		setTitle("Server connect test");
		Panel p=new Panel();
		p.setLayout(new FlowLayout());
		this.ta = ta;
//		ta=new TextArea();
		ta.setFont(new Font("DialogInput",Font.PLAIN,15));
		add("Center",ta);
		addWindowListener(this);
		setSize(1000,1000);
		setVisible(true);

		serverAddr=InetAddress.getByName(serverName);
		datagramSocket=new DatagramSocket(14245);
		ta.append("Local Port : "+datagramSocket.getLocalPort()+"\n");
    }

//=============================================================================================
	short rcv_version=0,rcv_command=0,rcv_seq_num=0,snd_seq_num=0;
	ServerToClientCMD response=new ServerToClientCMD();
	UserOnlineInfo onlineInfo=new UserOnlineInfo();
	UserAllInfo[] usrArr;

	public void login(UserAllInfo myallinfo ,UserAllInfo[] usrArr ,int num_remoteUIN)throws IOException
	{	ta.append("====LOGIN========\n");
		this.usrArr=usrArr;
		int[] arrayUIN=new int[num_remoteUIN];
		for (int i=0;i<num_remoteUIN;i++ )
		{	arrayUIN[i]=usrArr[i].getUIN();
		}
		ta.append("SEND LOGIN:\n");
		cmd.setUIN(myallinfo.getUIN());
		LOGIN_DATA loginData=new LOGIN_DATA();
		loginData.setPassword(myallinfo.getPWD());
		loginData.setIP(myallinfo.getIP());
		loginData.setPort(myallinfo.getPort());

		SYS_MSG s_msg=new SYS_MSG();
		USER_MSG u_msg=new USER_MSG();
		sendPacket(cmd.LOGIN(loginData));
		UserOnlineInfo onlineInfo=new UserOnlineInfo();

		do
		{	byte[] receivedData=receivePacket();
			rcvHeadPacket.receiveData(receivedData);
			rcv_version=rcvHeadPacket.getVersion();
			rcv_command=rcvHeadPacket.getCommand();
			rcv_seq_num=rcvHeadPacket.getSeqNum();
			ta.append("RECEIVE :"+u.bytes2HxStr(receivedData)+"\n");
			ta.append("version :"+rcv_version+" | seq_num :"+rcv_seq_num+" | command :"+rcv_command);
			switch (rcv_command)
			{	case  10:		ta.append(": ACK\n");
									break;
				case  40:		ta.append(" : GO_AWAY\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
/*				case  70:		ta.append(": NEW UIN\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
*/				case  90:		ta.append(" : LOGIN_REPLY\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									ta.append(" :=== SEND LOGIN_1 ===\n");
									sendPacket(cmd.LOGIN_1());
									ta.append(" :=== SEND CONTACT LIST ===\n");
									sendPacket(cmd.CONTACT_LIST(arrayUIN));
									break;
				case  100:	ta.append(" :BAD_PASS\n ");
									sendPacket(cmd.ACK(rcv_seq_num));
									login = false;
									break;
				case  110:	ta.append(" : USER ONLINE\n");
									onlineInfo=response.USER_ONLINE(receivedData);
									ta.append("uin:"+onlineInfo.getUIN()+"\n");
									ta.append("ip:"+Integer.toHexString(onlineInfo.getIP())+"\n");
									ta.append("port:"+onlineInfo.getPort()+"\n");
									ta.append("real IP"+Integer.toHexString(onlineInfo.getReal_IP())+"\n");
									ta.append("status"+onlineInfo.getStatus()+"\n");
									ta.append("status"+onlineInfo.getStatusStr()+"\n");
									for (int i=0;i<num_remoteUIN ;i++ )
										if (usrArr[i].getUIN()==onlineInfo.getUIN()) usrArr[i].UserOnlineInfo(onlineInfo);
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  120:	ta.append(" : USER OFFLINE\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  130:	ta.append(" : QUERY\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
/*				case  140:	ta.append(" : USER_FOUND\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
*/				case  160:	ta.append(" :END OF SEARCH\n ");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  180:	ta.append(" : NEW USER\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  200:	ta.append(" : UPDATE EXT\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  220:	ta.append(" : RECV MESSAGE\n");
									response.RECV_MESSAGE(receivedData);
									ta.append(" : Sender UIN "+response.getSender()+"\n");
									ta.append(" : Date: "+ response.getDate()+"\n");
									ta.append(" : Time: "+response.getTime()+"\n");
									ta.append(" : Msg type: "+response.getMsgType()+"\n");
									ta.append(" : Msg len: "+response.getMsgLen()+"\n");
									ta.append(" : Message: "+ response.getMessage()+"\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									AckMessage();

							 		break;
				case  230:	ta.append(" : X2\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									login = true;
									break;
				case  240:	ta.append(" : NOT CONNECT\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  250:	ta.append(" : TRY AGAIN\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  260:	ta.append(" : SYS DELIVERED MESS\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									response.SYS_DELIVERED_MESS(receivedData);
									ta.append(" : Sender UIN "+ response.getSender()+"\n");
									ta.append(" : Msg type: "+response.getMsgType()+"\n");
									ta.append(" : Msg len: "+response.getMsgLen()+"\n");
									ta.append(" : Message: "+response.getMessage()+"\n");
									break;
				case  280:	ta.append(" : INFO REPLY\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  290:	ta.append(" : EXT INFO REPLY\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  300:	ta.append(" : NO INFO AVAILABLE\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  310:	ta.append(" : NO EXT INFO AVAILABLE\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  420:	ta.append(" : STATUS UPDATE\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  450:	ta.append(" : SYSTEM MESSAGE\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  480:	ta.append(" : UPDATE SUCCESS\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  490:	ta.append(" : UPDATE FAIL\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  500:	ta.append(" : AUTH UPDATE\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  530:	ta.append(" : MULTI PACKET\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  540:	ta.append(" : X1\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  590:	ta.append(" : RAN USER\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				case  990:	ta.append(" : META USER\n");
									sendPacket(cmd.ACK(rcv_seq_num));
									break;
				default :		ta.append(" : Invalid command\n");
									sendPacket(cmd.ACK(rcv_seq_num));
			}// end switch
		}while((rcv_command != 230) && (rcv_command != 100) );
	}// end sendFirstPacket
	
	private boolean login=false;
	public boolean canlogin(){return login;}
//=============================================================================================
	boolean searchComplete = false;
	boolean haveNewFound=false;
	boolean foundExtInfo=false;
	UserInfo usrFoundInfo = new UserInfo();
	UserExtInfo usrExtInfo = new UserExtInfo();
	//--------------------------------------------------------------------------------------------------------------
	public boolean foundExtInfo(){ return foundExtInfo ;}
	
	public void receiveExtInfo(UserExtInfo uextinfo)
	{	usrExtInfo = uextinfo;
		foundExtInfo = true;
	}
	public UserExtInfo getExtInfo()
	{	foundExtInfo = false;
		return usrExtInfo;
	}
	//--------------------------------------------------------------------------------------------------------------
	public void newFoundUser(UserInfo uinfo)
	{	usrFoundInfo.setUIN(uinfo.getUIN());
		usrFoundInfo.setNick(uinfo.getNick());
		usrFoundInfo.setFirst(uinfo.getFirst());
		usrFoundInfo.setLast(uinfo.getLast());
		usrFoundInfo.setAuth(uinfo.getAuth());
		haveNewFound=true;
	}
	//--------------------------------------------------------------------------------------------------------------
	public UserInfo getFoundInfo()
	{			
		haveNewFound=false;
		return usrFoundInfo;
	}
	//--------------------------------------------------------------------------------------------------------------
	public boolean isSearchComplete()		{return searchComplete;	}
	public void setSearchComplete(boolean b)	{searchComplete = b;	}
	public boolean haveNewFound(){return haveNewFound;}
//=============================================================================================
	public void sendACK(short seq)throws IOException
	{	ta.append("=== SEND ACK ===\n");
		sendPacket(cmd.ACK(seq));
	}
	//--------------------------------------------------------------------------------------------------------------
/*	public void sendMsgAuthReq(int remote_uin ,String nick ,String first ,String last ,String email ,String reason)throws IOException
	{	ta.append("=== SEND MSG USER ADDED ===\n");
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(nick.getBytes());
		dataO.writeByte((byte)0xfe);
		dataO.write(first.getBytes());
		dataO.writeByte((byte)0xfe);
		dataO.write(last.getBytes());
		dataO.writeByte((byte)0xfe);
		dataO.write(email.getBytes());
		dataO.writeByte((byte)0xfe);
		dataO.write(reason.getBytes());
		String msg = new String(byteO.toByteArray());
		ta.append("send to "+Integer.toString(remote_uin)+" message "+msg+"\n");
		sendPacket(cmd.SEND_MESSAGE(remote_uin ,(short)6 ,msg));
	}
	//--------------------------------------------------------------------------------------------------------------
	public void sendMsgURL(int remote_uin ,String description ,String url)throws IOException
	{	ta.append("=== SEND URL ===\n");
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(description.getBytes());
		dataO.writeByte((byte)0xfe);
		dataO.write(url.getBytes());
		String msg = new String(byteO.toByteArray());
		ta.append("send to "+Integer.toString(remote_uin)+" message "+msg+"\n");
		sendPacket(cmd.SEND_MESSAGE(remote_uin ,(short)4 ,msg));
	}
	//--------------------------------------------------------------------------------------------------------------
	public void sendMsgUserAdded(int remote_uin ,String nick ,String first ,String last ,String email)throws IOException
	{	ta.append("=== SEND MSG USER ADDED ===\n");
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(nick.getBytes());
		dataO.writeByte((byte)0xfe);
		dataO.write(first.getBytes());
		dataO.writeByte((byte)0xfe);
		dataO.write(last.getBytes());
		dataO.writeByte((byte)0xfe);
		dataO.write(email.getBytes());
		dataO.writeByte((byte)0xfe);
		String msg = new String(byteO.toByteArray());
		ta.append("send to "+Integer.toString(remote_uin)+" message "+msg+"\n");
		sendPacket(cmd.SEND_MESSAGE(remote_uin ,(short)12 ,msg));
	}
*/	//--------------------------------------------------------------------------------------------------------------
	public void sendMessage(int remote_uin ,short msg_type ,String msg)throws IOException
	{
		ta.append("=== SEND MESSAGE ===\n");
		ta.append("send to "+Integer.toString(remote_uin)+" message "+msg+"\n");
		sendPacket(cmd.SEND_MESSAGE(remote_uin ,msg_type ,msg));
	}
	//--------------------------------------------------------------------------------------------------------------
	public void AckMessage()throws IOException
	{	ta.append(" : ACK_MESSAGES\n");
		sendPacket(cmd.ACK_MESSAGES());
	}
	//--------------------------------------------------------------------------------------------------------------
	public void infoRequest(int req_uin)throws IOException
	{	ta.append("=== INFO REQ ===\n");
		ta.append("Req Uin :"+req_uin+"\n");
		sendPacket(cmd.INFO_REQ(req_uin));
	}
	//--------------------------------------------------------------------------------------------------------------
	public void SearchUIN(int req_uin)throws IOException
	{	searchComplete = false;
//		num_userFound=0;
		ta.append("=== SEARCH UIN ===\n");
		ta.append("Search Uin :"+req_uin+"\n");
		sendPacket(cmd.SEARCH_UIN(req_uin));
	}
	//--------------------------------------------------------------------------------------------------------------
/*	public void SearchUIN(int[] req_uin)throws IOException
	{	searchComplete = false;
//		num_userFound=0;
		for (int i=0;i<req_uin.length ;i++ )
		{	ta.append("=== SEARCH UIN ===\n");
			ta.append("Search Uin :"+req_uin[i]+"\n");
			sendPacket(cmd.SEARCH_UIN(req_uin[i]));
		}
	}
*/	//--------------------------------------------------------------------------------------------------------------
	public void SearchUser(String email, String nick ,String first ,String last)throws IOException
	{	searchComplete = false;
//		num_userFound=0;
		ta.append("=== SEARCH USER ===\n");
		ta.append("Search Email: "+email+"   Nick: "+nick+"   First: "+first+"   Last: "+last);
		UserInfo uinfo=new UserInfo();
		uinfo.setNick(nick);
		uinfo.setFirst(first);
		uinfo.setLast(last);
		uinfo.setEmail(email);
		sendPacket(cmd.SEARCH_USER(uinfo));		
	}
	//--------------------------------------------------------------------------------------------------------------
	public void SearchExtInfo(int req_uin)throws IOException
	{	searchComplete = false;
//		num_userFound=0;
		ta.append("=== SEARCH EXT INFO ===\n");
		ta.append("Search Uin :"+req_uin+"\n");
		sendPacket(cmd.EXT_INFO_REQ(req_uin));
	}
	//--------------------------------------------------------------------------------------------------------------
/*	public void SearchExtInfo(int[] req_uin)throws IOException
	{	searchComplete = false;
//		num_userFound=0;
		for (int i=0;i<req_uin.length ;i++ )
		{	ta.append("=== SEARCH EXT INFO ===\n");
			ta.append("Search Uin :"+req_uin[i]+"\n");
			sendPacket(cmd.EXT_INFO_REQ(req_uin[i]));
		}
	}
*/ //--------------------------------------------------------------------------------------------------------------
	public void addToList(int addUIN)throws IOException
	{	ta.append("=== ADD TO LIST ===\n");
		sendPacket(cmd.ADD_TO_LIST(addUIN));
	}
//--------------------------------------------------------------------------------------------------------------
	public void sendKeepAlive()throws IOException
	{	ta.append("=== SEND KEEP ALIVE ===\n");
		sendPacket(cmd.KEEP_ALIVE());
		sendPacket(cmd.KEEP_ALIVE2());
	}
	//--------------------------------------------------------------------------------------------------------------
	public void logOut()throws IOException
	{	sendPacket(cmd.DISCONNECT());
		cmd.resetSeqNum();
//		datagramSocket.close();
//		dispose();
	}
	public void CloseSocket()
	{	datagramSocket.close();
	}
//=============================================================================================
	public static byte[] receivePacket() throws IOException 
	{	byte[] buffer=new byte[65507];
		int datagramLen=0;
		DatagramPacket dp=new DatagramPacket(buffer, buffer.length);
		datagramSocket.receive(dp);
		datagramLen=dp.getLength();
		ta.append("RECEIVE length :"+datagramLen+"\n");
		ByteArrayInputStream byteI=new ByteArrayInputStream(dp.getData(),0,datagramLen);
		DataInputStream dataI=new DataInputStream(byteI);
		byte[] recData=new byte[datagramLen];
		dataI.read(recData);
		return recData;
	}// end receivePacket
//=============================================================================================
	public static void sendPacket(byte[] data)throws IOException
	{	int serverPort=4000;
		DatagramPacket theOutput=new DatagramPacket(data,data.length,serverAddr,serverPort);
		datagramSocket.send(theOutput);
		ta.append("SEND length"+data.length+" :->"+u.bytes2HxStr(data)+"\n");
	}// end sendPacket
//=============================================================================================
    public void windowClosed(WindowEvent event) {
    }
    public void windowDeiconified(WindowEvent event) {
    }
    public void windowIconified(WindowEvent event) {
    }
    public void windowActivated(WindowEvent event) {
    }
    public void windowDeactivated(WindowEvent event) {
    }
    public void windowOpened(WindowEvent event) {
    }
	public void windowClosing(WindowEvent event) {System.exit(0);}
	public void actionPerformed(ActionEvent event) {
    }
	
	public TextArea getTextArea(){return ta;}
}// end icq3 class