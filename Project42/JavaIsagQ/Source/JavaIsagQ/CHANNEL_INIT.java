package IsecQ;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.awt.*;
import IsecQ.Util;


class CHANNEL_INIT
{
	short		packet_len=(short)26;
	byte			init_ident=(byte)0xff;
	short		version=2;
	short		revision=0;
	int				msg_port=0;   // always 00 00 00 00
	int				uin=0; // 60710412
	int     		ip_real=0;
	int     		ip=0;
	byte			tcp_flag=04;
	short		port=0; // 14245
	short		ext_port=0;
	Util u=new Util();

	public CHANNEL_INIT(){}
	public CHANNEL_INIT(UserOnlineInfo myonline)
	{	uin=myonline.getUIN();
		ip=myonline.getIP();
		port=myonline.getPort();
	}

	public void init(int uin ,int ip ,short port)
	{	this.uin=uin;
		this.ip=ip;
		this.port=port;
	}

	byte[] getAllBytes()throws IOException
	{	ByteArrayOutputStream byteO=new ByteArrayOutputStream();
		DataOutputStream dataO=new DataOutputStream(byteO);
		dataO.writeByte(init_ident);
		dataO.write(u.short2BytesSW(version));
		dataO.writeShort(revision);
		dataO.writeInt(msg_port);
		dataO.write(u.int2BytesSW(uin));
		dataO.writeInt(ip);
		dataO.writeInt(ip); // real ip
		dataO.writeByte(tcp_flag);
		dataO.write(u.short2BytesSW(port));
		dataO.writeShort(ext_port);
		return byteO.toByteArray();
	}

	void receiveData(byte[] d)
	{	byte[] bytes4=new byte[4];
		byte[] bytes2=new byte[2];
//----------- init_ident ----------------		
		init_ident=d[0];
//----------- version ----------------		
		bytes2[0]=d[1];
		bytes2[1]=d[2];
		version=u.bytes2ShortSW(bytes2);
//----------- revision ----------------		
		bytes2[0]=d[3];
		bytes2[1]=d[4];
		revision=u.bytes2ShortSW(bytes2);
//----------- tcp msg port ----------------		
		bytes4[0]=d[5];
		bytes4[1]=d[6];
		bytes4[2]=d[7];
		bytes4[3]=d[8];
		msg_port=u.bytes2Int(bytes4);
//-----------uin----------------		
		bytes4[0]=d[9];
		bytes4[1]=d[10];
		bytes4[2]=d[11];
		bytes4[3]=d[12];
		uin=u.bytes2Int(bytes4);
//----------- IP----------------		
		bytes4[0]=d[13];
		bytes4[1]=d[14];
		bytes4[2]=d[15];
		bytes4[3]=d[16];
		ip=u.bytes2Int(bytes4);
//-----------real IP----------------		
		bytes4[0]=d[17];
		bytes4[1]=d[18];
		bytes4[2]=d[19];
		bytes4[3]=d[20];
		ip_real=u.bytes2Int(bytes4);
//----------- tcp_flag----------------		
		tcp_flag=d[21];
//------------- port------------------		
		bytes2[0]=d[22];
		bytes2[1]=d[23];
		port=u.bytes2Short(bytes2);
//----------- ext_port----------------		
		bytes2[0]=d[24];
		bytes2[1]=d[25];
		ext_port=u.bytes2Short(bytes2);
	}

	void printAll(TextArea ta)throws IOException
	{	ta.append(u.bytes2HxStr(getAllBytes())+"\n");			
		ta.append("Length: "+packet_len+" ("+u.bytes2HxStr(u.short2BytesSW(packet_len))+")   ");
		ta.append("Init ident: "+init_ident+" ("+u.bytes2HxStr(u.short2BytesSW(init_ident))+")\n");
		ta.append("Version: "+version+" ("+u.bytes2HxStr(u.short2BytesSW(version))+")    ");
		ta.append("Revision: "+revision+" ("+u.bytes2HxStr(u.short2BytesSW(revision))+")    ");
		ta.append("Msg_port: "+msg_port+" ("+u.bytes2HxStr(u.int2BytesSW(msg_port))+")\n");
		ta.append("Uin: "+uin+" ("+u.bytes2HxStr(u.int2BytesSW(uin))+")\n");
		ta.append("Ip: "+u.bytes2HxStr(u.int2BytesSW(ip))+"    ");
		ta.append("Real ip: "+u.bytes2HxStr(u.int2BytesSW(ip))+"    ");
		ta.append("Tcp_flag: "+tcp_flag+" ("+u.bytes2HxStr(u.short2BytesSW(tcp_flag))+")   ");
		ta.append("Port: "+port+" ("+u.bytes2HxStr(u.short2BytesSW(port))+")\n");
//		ta.append("remote ext port: "+ext_port+" ("+u.bytes2HxStr(u.short2BytesSW(ext_port))+")\n");
	}

	void printAll()throws IOException
	{	System.out.print(u.bytes2HxStr(getAllBytes())+"\n");			
		System.out.print("Length: "+packet_len+" ("+u.bytes2HxStr(u.short2BytesSW(packet_len))+")   ");
		System.out.print("Init ident: "+init_ident+" ("+u.bytes2HxStr(u.short2BytesSW(init_ident))+")\n");
		System.out.print("Version: "+version+" ("+u.bytes2HxStr(u.short2BytesSW(version))+")    ");
		System.out.print("Revision: "+revision+" ("+u.bytes2HxStr(u.short2BytesSW(revision))+")    ");
		System.out.print("Msg_port: "+msg_port+" ("+u.bytes2HxStr(u.int2BytesSW(msg_port))+")\n");
		System.out.print("Uin: "+uin+" ("+u.bytes2HxStr(u.int2BytesSW(uin))+")\n");
		System.out.print("Ip: "+u.bytes2HxStr(u.int2BytesSW(ip))+"    ");
		System.out.print("Real ip: "+u.bytes2HxStr(u.int2BytesSW(ip))+"    ");
		System.out.print("Tcp_flag: "+tcp_flag+" ("+u.bytes2HxStr(u.short2BytesSW(tcp_flag))+")   ");
		System.out.print("Port: "+port+" ("+u.bytes2HxStr(u.short2BytesSW(port))+")\n");
	}

	
	public short getPacketLen(){return packet_len;}
}