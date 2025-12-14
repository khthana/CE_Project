package IsecQ;
import java.io.*;
import java.net.*;
import java.awt.*;
import IsecQ.*;

class ClientToServerCMD extends SendHeadPacket 
{
	static InetAddress server; 
	static DatagramSocket ds;
	static int serverPort;
	static TextArea ta;
	ClientToServerCMD(InetAddress addr ,int port, DatagramSocket dsocket,TextArea tx)
	{
		server=addr;
		ds=dsocket;
		serverPort=port;
		setSeqNum((short)0);
		ta=tx;
	}
	ClientToServerCMD()
	{
	}
	static short ACK=10;
	static short SEND_MESSAGE=270;
	static short LOGIN=1000;
	static short REG_NEW_USER=1020;
	static short CONTACT_LIST=1030;
	static short SEARCH_UIN=1050;
	static short SEARCH_USER=1060;
	static short KEEP_ALIVE=1070;
	static short SEND_TEXT_CODE=1080;
	static short ACK_MESSAGES=1090;
	static short LOGIN_1=1100;
	static short MSG_TO_NEW_USER=1110;
	static short INFO_REQ=1120;
	static short EXT_INFO_REQ=1130;
	static short CHANGE_PW=1180;
	static short NEW_USER_INTO=1190;
	static short UPDATE_EXT_INFO=1200;
	static short QUERY_SERVERS=1210;
	static short QUERY_ADDONS=1220;
	static short STATUS_CHANGE=1240;
	static short NEW_USER_1=1260;
	static short UPDATE_INFO=1290;
	static short AUTH_UPDATE=1300;
	static short KEEP_ALIVE2=1310;
	static short LOGIN_2=1320;
	static short ADD_TO_LIST=1340;
	static short RAND_SET=1380;
	static short RAND_SEARCH=1390;
	static short META_USER=1610;
	static short INVIS_LIS=1700;
	static short VIS_LIS=1710;
	static short UPDATE_LIST=1720;

	Util u=new Util();
	
	public void incSeqNum(){seq_num++;}
	public void resetSeqNum(){seq_num=(short)0;}
//-------------------------------------------------------------------------------------------------
	public byte[] ACK(short seq)throws IOException // 10
	{
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)ACK));
		dataO.write(u.short2BytesSW((short)seq));
		dataO.write(u.int2BytesSW(getUIN()));
		return byteO.toByteArray();		
	}
//-------------------------------------------------------------------------------------------------
	public byte[] SEND_MESSAGE(int remote_uin ,short msg_type ,String msg)throws IOException  // 0E 01 (270)
	{
		incSeqNum();
//		short	msg_type=(short)4;   // 01 00 -> normal message ; 04 00 -> URL (two part separate by FE) 
		short	msg_len=0; //include null
		msg_len=(short)(msg.length()+1);
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)SEND_MESSAGE));
		dataO.write(u.short2BytesSW(getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.write(u.int2BytesSW(remote_uin));
		dataO.write(u.short2BytesSW(msg_type));
		dataO.write(u.short2BytesSW(msg_len));
		dataO.write(msg.getBytes());
		dataO.writeByte((byte)0);
		return byteO.toByteArray();		
	}	
//-------------------------------------------------------------------------------------------------
	public byte[] LOGIN(LOGIN_DATA logData)throws IOException  //1000
	{
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)LOGIN));
		dataO.write(u.short2BytesSW((short)0));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.write(u.short2BytesSW(logData.port));
		dataO.writeShort(logData.ext_port);
		dataO.write(u.short2BytesSW(logData.pass_len));
		dataO.write(logData.password.getBytes());
//		dataO.writeBytes(logData.password);
		dataO.writeByte(logData.endpwd);
		dataO.writeInt(logData.x1);
		dataO.writeInt(logData.IP);
		dataO.writeByte(logData.x2);
		dataO.writeInt(logData.status);
		dataO.writeInt(logData.x3);
		dataO.write(u.int2BytesSW(logData.log_seq_num));
		dataO.writeInt(logData.x4);
		dataO.writeShort(logData.x5);
		return byteO.toByteArray();		
	}
//-------------------------------------------------------------------------------------------------
	public byte[] CONTACT_LIST(String filename)throws IOException // 1030
	{
		incSeqNum();
		int[] uin=readContactlistFile(filename+".lis");
		int num_contacts=(byte)uin.length;
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)CONTACT_LIST));
		dataO.write(u.short2BytesSW(getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.writeByte(num_contacts);
		for (int i=0;i<num_contacts ;i++ )
		{
			dataO.write(u.int2BytesSW(uin[i]));
		}
		return byteO.toByteArray();		
	}// end getBytes

	public int[] readContactlistFile(String filename) throws IOException
	{
		int num_uin=0;
		FileInputStream file_in=new FileInputStream(filename);
		DataInputStream data_in=new DataInputStream(file_in);
		num_uin=data_in.readInt();
		int[] ret_uin=new int[num_uin];
		for(int i=0;i<num_uin;i++)
		{
			ret_uin[i]=data_in.readInt();
			System.out.println(ret_uin[i]);
		}
		data_in.close();
		return ret_uin;
	}
//-------------------------------------------------------------------------------------------------
	public byte[] CONTACT_LIST(int[] arrayUIN)throws IOException // 1030
	{
		incSeqNum();
		int num_contacts=(byte)arrayUIN.length;
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)CONTACT_LIST));
		dataO.write(u.short2BytesSW(getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.writeByte(num_contacts);
		for (int i=0;i<num_contacts ;i++ )
		{
			dataO.write(u.int2BytesSW(arrayUIN[i]));
		}
		return byteO.toByteArray();		
	}// end getBytes

//-------------------------------------------------------------------------------------------------
	public byte[] SEARCH_UIN(int search_uin)throws IOException //1050
	{
		incSeqNum();
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();	
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)SEARCH_UIN));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.write(u.short2BytesSW(getSearchSeq()));
		dataO.write(u.int2BytesSW(search_uin));
		decSearchSeq();
		return byteO.toByteArray();		
	}
//-------------------------------------------------------------------------------------------------
	public byte[] SEARCH_USER(UserInfo user )throws IOException //1060
	{
		incSeqNum();
		short search_seq=(short)0xefff;
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)SEARCH_USER));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.write(u.short2BytesSW(search_seq));
		dataO.write(u.short2BytesSW((short)(user.getNick().length()+1)));
		dataO.write(user.getNick().getBytes());
//		dataO.writeBytes(user.getNick());
		dataO.writeByte((short)0);// end null (end string)
		dataO.write(u.short2BytesSW((short)(user.getFirst().length()+1)));
		dataO.write(user.getFirst().getBytes());
//		dataO.writeBytes(user.getFirst());
		dataO.writeByte((short)0);// end null (end string)
		dataO.write(u.short2BytesSW((short)(user.getLast().length()+1)));
		dataO.write(user.getLast().getBytes());
//		dataO.writeBytes(user.getLast());
		dataO.writeByte((short)0);// end null (end string)
		dataO.write(u.short2BytesSW((short)(user.getEmail().length()+1)));
		dataO.write(user.getEmail().getBytes());
//		dataO.writeBytes(user.getEmail());
		dataO.writeByte((short)0);// end null (end string)
		decSearchSeq();
		return byteO.toByteArray();
	}
//-------------------------------------------------------------------------------------------------
	public byte[] KEEP_ALIVE() throws IOException //1070
	{
		incSeqNum();
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)KEEP_ALIVE));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		return byteO.toByteArray();
	}
//-------------------------------------------------------------------------------------------------
	public byte[] KEEP_ALIVE2() throws IOException //1070
	{
		incSeqNum();
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)KEEP_ALIVE2));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		return byteO.toByteArray();
	}
//-------------------------------------------------------------------------------------------------
	public byte[] DISCONNECT() throws IOException //1080
	{
		incSeqNum();
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)SEND_TEXT_CODE));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.write(u.short2BytesSW((short)19));
		dataO.writeBytes("B_USER_DISCONNECTED");
		dataO.writeByte((byte)0);
		dataO.write(u.short2Bytes((short)0x0500));
		return byteO.toByteArray();
	}
//-------------------------------------------------------------------------------------------------
	public byte[] ACK_MESSAGES()throws IOException //1090
	{
		incSeqNum();
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)ACK_MESSAGES));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		return byteO.toByteArray();		
	}
//-------------------------------------------------------------------------------------------------
	public byte[] LOGIN_1() throws IOException //1100
	{
		incSeqNum();
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)LOGIN_1));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.write(u.short2BytesSW((short)19));
//		dataO.writeBytes("B_USER_DISCONNECTED");
//		dataO.writeByte((byte)0);
		dataO.write(u.short2Bytes((short)0x0500));
		return byteO.toByteArray();		
	}

	public byte[] INFO_REQ(int search_uin)throws IOException //1120
	{
		incSeqNum();
		short search_seq=(short)0xbefc;
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)INFO_REQ));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.write(u.short2BytesSW(search_seq));
		dataO.write(u.int2Bytes(search_uin));
		return byteO.toByteArray();		
	}
//-------------------------------------------------------------------------------------------------
	private	short search_seq = (short)0xcfff;
	private void	 decSearchSeq()	 {	search_seq--;}
	private void	 incSearchSeq()	 {	search_seq++;}
	private short getSearchSeq(){return search_seq;}
//-------------------------------------------------------------------------------------------------
	public byte[] EXT_INFO_REQ(int search_uin)throws IOException //1230
	{
		incSeqNum();
//		incSearchSeq();
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)EXT_INFO_REQ));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
//		dataO.write(u.short2BytesSW(getSearchSeq()));
		dataO.write(u.short2BytesSW(u.seqRandom()));
		dataO.write(u.int2BytesSW(search_uin));
		return byteO.toByteArray();		
	}
//-------------------------------------------------------------------------------------------------
	public byte[] ADD_TO_LIST(int addUIN)throws IOException //1340
	{
		incSeqNum();
		ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.short2BytesSW(getVersion()));
		dataO.write(u.short2BytesSW((short)ADD_TO_LIST));
		dataO.write(u.short2BytesSW((short)getSeqNum()));
		dataO.write(u.int2BytesSW(getUIN()));
		dataO.write(u.int2BytesSW(addUIN));
		return byteO.toByteArray();		
	}
//-------------------------------------------------------------------------------------------------
	public static void sendPacket(byte[] data)throws IOException
	{
		DatagramPacket theOutput=new DatagramPacket(data,data.length,server,serverPort);
		ds.send(theOutput);
		ta.appendText("SEND length"+data.length+" :->"+Util.bytes2HxStr(data)+"\n");
	}// end sendPacket

//-------------------------------------------------------------------------------------------------
}