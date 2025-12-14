package IsecQ;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.awt.*;
import IsecQ.Util;

class CHANNEL_MESSAGE
{
	short		packet_len = 0;
	int				uin1 = 0; 
	short		version = 2;
	short		msg_cmd = 0;  //reply DA 07 send EE 07
	short		x1 = 0;
	short		msg_type = 0;
	short		msg_len = 0;
	String		msg = "";
//	byte[]		msg_byte;
	byte			endmsg = 0;
	int				ip = 0;
	int				ip_real = 0;
	short		port = 0;
	short		ext_port = 0;
	byte			tcp_flag = 4;
	short		tcp_status = 0;
	short		cmd_type = 0x1000; //reply 00 00 , send 10 00
	int				tcp_seq = 0;
	int				fix_len = 39;
	String		IPstring = "";

	Util u = new Util();
//========================= CONSTRUCTOR ==========================
	public CHANNEL_MESSAGE(){}

	public CHANNEL_MESSAGE(UserOnlineInfo myonline)
	{	uin1	=	myonline.getUIN();
		ip	=	myonline.getIP();
		port	=	myonline.getPort();
	}
	public void init(int uin	,int ip ,short port)
	{	this.uin1 = uin;
		this.ip = ip;
		this.port = port;
	}
//========================= MESSAGE COMMAND ==========================
	public void setReplyCMD()
	{	msg_cmd = (short)0xda07;
		cmd_type = (short)0x0000;
	}
	public void setSendCMD()
	{	msg_cmd = (short)0xee07;
		cmd_type = (short)0x1000;
	}
	public short	getReply_MsgCmd()			{return (short)	0xda07;}
	public short	getSend_MsgCmd()			{return (short)	0xee07;}
	public short getReplyCmdType()			{return (short)	0x0000;}
	public short getSendCmdType()			{return (short)	0x1000;}
//========================= SECURE COMMAND ==========================
	public void SendEncryptMsgCMD()
	{	msg_cmd = (short)0xaa4f;
		cmd_type = (short)0x1000;
	}
	public void SendPublicKeyCMD()
	{	msg_cmd = (short)0xfcea;
		cmd_type = (short)0x1000;
	}
	public void SendEnCrytedDESKeyCMD()
	{	msg_cmd = (short)0x07d9;
		cmd_type = (short)0x1000;
	}
	public short	getSendEncryptMsgCMD()				{return (short)	0xaa4f;}
	public short	getSendEncryptMsgCMD2()				{return (short)	0x4faa;}
	public short	getSendPublicKeyCMD()					{return (short)	0xfcea;}
	public short	getSendPublicKeyCMD2()					{return (short)	0xeafc;}
	public short getSendEnCrytedDESKeyCMD()		{return (short)	0x07d9;}
	public short getSendEnCrytedDESKeyCMD2()	{return (short)	0xd907;}
	public short getSendKeySuccessCMD()				{return (short)	0xbbfa;}
//========================= GET FUNCTION =========================
	public short		getPacketLen()	{return packet_len;}
	public int			getUIN1()				{return uin1;}
	public short		getVersion()		{return version;}
	public short		getMsgCmd()		{return msg_cmd;}
	public short		getMsgType()		{return msg_type;}
	public short		getMsgLen()		{return (short)(msg_len-1);}
	public String	getMessage()		{return msg;}
//	public byte[] 	getMessageByte()		{return msg_byte;}
	public int			getIP()					{return ip;}
	public short		getPort()				{return port;}
	public short		getExtPort()			{return ext_port;}
	public byte		getTCPFlag()		{return tcp_flag;}
	public short		getTCPStatus()	{return tcp_status;}
	public short		getCmdType()		{return cmd_type;}
	public int			getTCP_SEQ()	{return tcp_seq;}
	public String	getIPStr()				{return IPstring;}

	byte[] getAllBytes()throws IOException
	{	ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.int2BytesSW(uin1));
		dataO.write(u.short2BytesSW(version));
		dataO.writeShort(msg_cmd);
		dataO.writeShort(x1);
		dataO.write(u.int2BytesSW(uin1)); // uin2
		dataO.write(u.short2BytesSW(msg_type));
		dataO.write(u.short2BytesSW(msg_len));
		dataO.write(msg.getBytes());
		dataO.writeByte(endmsg);
		dataO.writeInt(ip);
		dataO.writeInt(ip); // real ip
		dataO.write(u.short2BytesSW(port));
		dataO.writeShort(ext_port);
		dataO.writeByte(tcp_flag);
		dataO.writeShort(tcp_status);
		dataO.writeShort(cmd_type);
		dataO.writeInt(tcp_seq);
		return byteO.toByteArray();
	}
/*
	byte[] getAllBytes2()throws IOException
	{	ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.write(u.int2BytesSW(uin1));
		dataO.write(u.short2BytesSW(version));
		dataO.writeShort(msg_cmd);
		dataO.writeShort(x1);
		dataO.write(u.int2BytesSW(uin1)); // uin2
		dataO.write(u.short2BytesSW(msg_type));
		dataO.write(u.short2BytesSW(msg_len));
		dataO.write(msg_byte);
		dataO.writeByte(endmsg);
		dataO.writeInt(ip);
		dataO.writeInt(ip); // real ip
		dataO.write(u.short2BytesSW(port));
		dataO.writeShort(ext_port);
		dataO.writeByte(tcp_flag);
		dataO.writeShort(tcp_status);
		dataO.writeShort(cmd_type);
		dataO.writeInt(tcp_seq);
		return byteO.toByteArray();
	}
*/
//========================= SET FUNCTION =========================
	public void setPacketLen(short l){packet_len=l;}
	public void setUIN(int uin){uin1=uin;}
	public void setVersion(short v){version=v;}
	public void setMsgCmd(short mc){msg_cmd=mc;}
	public void setMsgType(short mt){msg_type=mt;}
	public void setMessage(String str,short type)
	{	msg=str;
		msg_len=(short)(str.length()+1);
		packet_len=(short)(fix_len+msg_len);
		msg_type=type;
	}
/*
	public void setMessageByte(byte[] msg_b)
	{	msg_byte=msg_b;
		msg_len=(short)(msg_b.length+1);
		packet_len=(short)(fix_len+msg_len);
	}
*/
	public void setMessage(String str)
	{	msg=str;
		msg_type=(short)1;
		msg_len=(short)(str.length()+1);
		packet_len=(short)(fix_len+msg_len);
	//	printAll();
	}
	void setIP(int ip){this.ip=ip; this.ip_real=ip;}
	void setPort(short p){port=p;}
	void setCmdType(short ct){cmd_type=ct;}
	void setTCP_SEQ(int ts){tcp_seq=ts;}

//======================= PRINT INFO FUNCTION =======================
	void printAll(TextArea ta)throws IOException
	{	ta.append(u.bytes2HxStr(getAllBytes())+"\n");			
		ta.append("Length: "+packet_len+" ("+u.bytes2HxStr(u.short2BytesSW(packet_len))+")\n");
		ta.append("Uin: "+uin1+" ("+u.bytes2HxStr(u.int2BytesSW(uin1))+")    ");
		ta.append("Version: "+version+" ("+u.bytes2HxStr(u.short2BytesSW(version))+")    ");
		ta.append("Command: "+msg_cmd+" ("+u.bytes2HxStr(u.short2Bytes(msg_cmd))+")\n");
		ta.append("Type: "+msg_type+" ("+u.bytes2HxStr(u.short2BytesSW(msg_type))+")    ");
		ta.append("Lenght: "+msg_len+" ("+u.bytes2HxStr(u.short2BytesSW(msg_len))+")    ");
		ta.append("Message: "+msg+"\n");
		ta.append("Real ip: "+u.bytes2HxStr(u.int2BytesSW(ip_real))+"    ");
		ta.append("Ip: "+u.bytes2HxStr(u.int2BytesSW(ip))+"    ");
		ta.append("Port: "+port+" ("+u.bytes2HxStr(u.short2BytesSW(port))+")\n");
		ta.append("Tcp flag: "+tcp_flag+"    ");
		ta.append("Tcp status: " +tcp_status+" ("+u.bytes2HxStr(u.short2BytesSW(tcp_status))+")    ");
		ta.append("Cmd type: "+cmd_type+" ("+u.bytes2HxStr(u.short2BytesSW(cmd_type))+")    ");
		ta.append("Tcp sequence: "+u.bytes2HxStr(u.int2Bytes(tcp_seq))+"\n");
	}

	void printAll()throws IOException
	{
		System.out.print(u.bytes2HxStr(getAllBytes())+"\n");			
		System.out.print("Length: "+packet_len+" ("+u.bytes2HxStr(u.short2BytesSW(packet_len))+")\n");
		System.out.print("Uin: "+uin1+" ("+u.bytes2HxStr(u.int2BytesSW(uin1))+")    ");
		System.out.print("Version: "+version+" ("+u.bytes2HxStr(u.short2BytesSW(version))+")    ");
		System.out.print("Command: "+msg_cmd+" ("+u.bytes2HxStr(u.short2Bytes(msg_cmd))+")\n");
		System.out.print("Type: "+msg_type+" ("+u.bytes2HxStr(u.short2BytesSW(msg_type))+")    ");
		System.out.print("Lenght: "+msg_len+" ("+u.bytes2HxStr(u.short2BytesSW(msg_len))+")    ");
		System.out.print("Message: "+msg+"\n");
		System.out.print("Real ip: "+u.bytes2HxStr(u.int2BytesSW(ip_real))+"    ");
		System.out.print("Ip: "+u.bytes2HxStr(u.int2BytesSW(ip))+"    ");
		System.out.print("Port: "+port+" ("+u.bytes2HxStr(u.short2BytesSW(port))+")\n");
		System.out.print("Tcp flag: "+tcp_flag+"    ");
		System.out.print("Tcp status: " +tcp_status+" ("+u.bytes2HxStr(u.short2BytesSW(tcp_status))+")    ");
		System.out.print("Cmd type: "+cmd_type+" ("+u.bytes2HxStr(u.short2BytesSW(cmd_type))+")    ");
		System.out.print("Tcp sequence: "+u.bytes2HxStr(u.int2Bytes(tcp_seq))+"\n");
	}
//========================= RECEIVE DATA FUNCTION =========================
	public void receiveData(byte[] d)
	{
		packet_len=(short)d.length;
//--------------------- uin1 ------------------------
		byte[] bytes4=new byte[4];
		byte[] bytes2=new byte[2];
		bytes4[0]=d[0];
		bytes4[1]=d[1];
		bytes4[2]=d[2];
		bytes4[3]=d[3];
		uin1=u.bytes2IntSW(bytes4);
//--------------------- version ------------------------
		bytes2[0]=d[4];
		bytes2[1]=d[5];
		version=u.bytes2ShortSW(bytes2);
//--------------------- msg_cmd ------------------------
		bytes2[0]=d[6];
		bytes2[1]=d[7];
		msg_cmd=u.bytes2ShortSW(bytes2);
//--------------------- x1 ------------------------
		bytes2[0]=d[8];
		bytes2[1]=d[9];
		x1=u.bytes2Short(bytes2);
//--------------------- uin2 ------------------------
/*		bytes4[0]=d[10];
		bytes4[1]=d[11];
		bytes4[2]=d[12];
		bytes4[3]=d[13];
		uin2=u.bytes2IntSW(bytes4);
*/
//--------------------- msg_type ------------------------
		bytes2[0]=d[14];
		bytes2[1]=d[15];
		msg_type=u.bytes2Short(bytes2);
//--------------------- msg_len ------------------------
		bytes2[0]=d[16];
		bytes2[1]=d[17];
		msg_len=u.bytes2ShortSW(bytes2);
//--------------------- msg ------------------------
		msg=new String(d ,18 ,(int)(msg_len-1));
//--------------------- ip_real ------------------------
		bytes4[0]=d[18+(int)msg_len];
		bytes4[1]=d[19+(int)msg_len];
		bytes4[2]=d[20+(int)msg_len];
		bytes4[3]=d[21+(int)msg_len];
		ip_real=u.bytes2IntSW(bytes4);

//--------------------- ip ------------------------
		bytes4[0]=d[22+(int)msg_len];
		bytes4[1]=d[23+(int)msg_len];
		bytes4[2]=d[24+(int)msg_len];
		bytes4[3]=d[25+(int)msg_len];
		ip=u.bytes2IntSW(bytes4);
		IPstring=u.IPint2String(ip);
//--------------------- port ------------------------
		bytes2[0]=d[26+(int)msg_len];
		bytes2[1]=d[27+(int)msg_len];
		port=u.bytes2ShortSW(bytes2);
//--------------------- ext_port ------------------------
		bytes2[0]=d[28+(int)msg_len];
		bytes2[1]=d[29+(int)msg_len];
		ext_port=u.bytes2ShortSW(bytes2);
//--------------------- tcp_flag ------------------------
		tcp_flag=d[30+(int)msg_len];
//--------------------- tcp_statis ------------------------
		bytes2[0]=d[31+(int)msg_len];
		bytes2[1]=d[32+(int)msg_len];
		tcp_status=u.bytes2ShortSW(bytes2);
//--------------------- cmd_type ------------------------
		bytes2[0]=d[33+(int)msg_len];
		bytes2[1]=d[34+(int)msg_len];
		cmd_type=u.bytes2ShortSW(bytes2);
//--------------------- tcp_seq ------------------------
		bytes4[0]=d[35+(int)msg_len];
		bytes4[1]=d[36+(int)msg_len];
		bytes4[2]=d[37+(int)msg_len];
		bytes4[3]=d[38+(int)msg_len];
		tcp_seq=u.bytes2Int(bytes4);
	}
}