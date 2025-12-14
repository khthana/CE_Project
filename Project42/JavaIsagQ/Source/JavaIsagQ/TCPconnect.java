package IsecQ;
import java.awt.*;
import java.io.*;
import java.net.*;
import java.math.BigInteger;
import IsecQ.*;

public class  TCPconnect extends Frame
{	static TextArea		ta;
	static TextField		tf;
	static UserAllInfo		myallinfo;
	static DES				edes = new DES();
	static CHANNEL_INIT msg_init=new CHANNEL_INIT();
	static CHANNEL_MESSAGE msg_send=new CHANNEL_MESSAGE();
	static Util u=new Util();
	static short packet_len;
//================== CONSTRUCTOR =========================
	TCPconnect(){}
//================== CONSTRUCTOR =========================
	public void Connect(UserAllInfo myallinfo ,TextArea ta)
	{	this.myallinfo=myallinfo;
		this.ta=ta;
		setTitle("TCP connect");
		ta.setFont(new Font("DialogInput",Font.PLAIN,12));
		add(ta);
		pack();
		setVisible(true);
	}
//================== SEND NORMAL MESSAGE =========================
	public void sendMessage(UserAllInfo uAllInfo ,String message)
	{	String remoteip=u.IPint2String(uAllInfo.getIP());
		int remoteport=(int)uAllInfo.getPort();
		ta.append("Remote IP "+remoteip+"   remote port "+remoteport+":\n");
		try	
		{	Socket connect=new Socket(remoteip ,remoteport);
			DataOutputStream snd_os=new DataOutputStream(connect.getOutputStream());
			ta.append("connected address: "+connect.getInetAddress()+"  connect port: "+connect.getPort()+"\n");
			ta.append("****************** SEND INIT ****************\n");
			msg_init.init(myallinfo.getUIN() ,myallinfo.getIP() ,myallinfo.getPort());
			ta.append("init length: "+msg_init.getPacketLen());
			msg_init.printAll(ta);
			snd_os.write(u.short2BytesSW(msg_init.getPacketLen()));
			snd_os.write(msg_init.getAllBytes());
			ta.append("****************** SEND MESSAGE ****************\n");
			msg_send.setSendCMD();
			msg_send.setUIN			(myallinfo.getUIN());
			msg_send.setPort			(myallinfo.getPort());
			msg_send.setMessage	(message);
			msg_send.setMsgType	((short)1);
			msg_send.setIP				(myallinfo.getIP());
			msg_send.setTCP_SEQ(0xcfffffff);
			ta.append("message packet length: "+msg_send.getPacketLen());
			msg_send.printAll(ta);
			snd_os.write(u.short2BytesSW(msg_send.getPacketLen()));
			snd_os.write(msg_send.getAllBytes());
			connect.close();
		}
		catch (UnknownHostException u)
		{	System.out.println("UnknownHostException "+u);
		}	
		catch (IOException e)
		{	System.out.println("IOException "+e);
		}	
	}
//================== SEND ENCRYPT MESSAGE =========================
	public void sendEncryptMessage(UserAllInfo uAllInfo ,String message)
	{	
		byte[] msg_byte=edes.paddingMessage(message.getBytes() ,uAllInfo.getKey_DES().length);
		edes.setKey(uAllInfo.getKey_DES());
		byte[] encrypt_msg = edes.encrypt(msg_byte);

		BigInteger encrypt_DES =new BigInteger (encrypt_msg);
		String en_des_str =encrypt_DES.toString();

		String remoteip=u.IPint2String(uAllInfo.getIP());
		int remoteport=(int)uAllInfo.getPort();
		ta.append("Remote IP "+remoteip+"   remote port "+remoteport+":\n");
		try	
		{	Socket connect=new Socket(remoteip ,remoteport);
			DataOutputStream snd_os=new DataOutputStream(connect.getOutputStream());
			ta.append("connected address: "+connect.getInetAddress()+"  connect port: "+connect.getPort()+"\n");
			ta.append("****************** SEND INIT ****************\n");
			msg_init.init(myallinfo.getUIN() ,myallinfo.getIP() ,myallinfo.getPort());
			ta.append("init length: "+msg_init.getPacketLen());
			msg_init.printAll(ta);
			snd_os.write(u.short2BytesSW(msg_init.getPacketLen()));
			snd_os.write(msg_init.getAllBytes());
			ta.append("****************** SEND MESSAGE ****************\n");
			msg_send.SendEncryptMsgCMD();
			msg_send.setUIN			(myallinfo.getUIN());
			msg_send.setPort			(myallinfo.getPort());
			msg_send.setMessage	(en_des_str);
			msg_send.setMsgType	((short)1);
			msg_send.setIP				(myallinfo.getIP());
			msg_send.setTCP_SEQ(0xcfffffff);
			ta.append("message packet length: "+msg_send.getPacketLen());
			msg_send.printAll(ta);
			snd_os.write(u.short2BytesSW(msg_send.getPacketLen()));
			snd_os.write(msg_send.getAllBytes());
			connect.close();
		}
		catch (UnknownHostException u)
		{	System.out.println("UnknownHostException "+u);
		}	
		catch (IOException e)
		{	System.out.println("IOException "+e);
		}	
	}
//=================== SEND KEY TO EVERYONE WHO ONLINE========================
	public void sendKey(UserAllInfo[] usrArr)
	{
		try	
		{	for (int i = 0 ;i < usrArr.length ;i++ )
			{	if (usrArr[i].getOnline())
				{	String remoteip=u.IPint2String(usrArr[i].getIP());
					int remoteport=(int)usrArr[i].getPort();
					ta.append("Remote IP "+remoteip+"   remote port "+remoteport+":\n");
					Socket connect=new Socket(remoteip ,remoteport);
					DataOutputStream snd_os=new DataOutputStream(connect.getOutputStream());
					ta.append("connected address: "+connect.getInetAddress()+"  connect port: "+connect.getPort()+"\n");
					ta.append("****************** SEND Public Key E ****************\n");
					msg_send.SendPublicKeyCMD();
					msg_send.setUIN			(myallinfo.getUIN());
					msg_send.setPort			(myallinfo.getPort());
					msg_send.setMessage	(myallinfo.getKey_E().toString());
					msg_send.setMsgType	((short)1);
					msg_send.setIP				(myallinfo.getIP());
					msg_send.setTCP_SEQ(0xcfffffff);
					ta.append("message packet length: "+msg_send.getPacketLen());
					msg_send.printAll(ta);
					snd_os.write(u.short2BytesSW(msg_send.getPacketLen()));
					snd_os.write(msg_send.getAllBytes());
					ta.append("****************** SEND Public Key N ****************\n");
					msg_send.SendPublicKeyCMD();
					msg_send.setUIN			(myallinfo.getUIN());
					msg_send.setPort			(myallinfo.getPort());
					msg_send.setMessage	(myallinfo.getKey_N().toString());
					msg_send.setMsgType	((short)1);
					msg_send.setIP				(myallinfo.getIP());
					msg_send.setTCP_SEQ(0xcfffffff);
					ta.append("message packet length: "+msg_send.getPacketLen());
					msg_send.printAll(ta);
					snd_os.write(u.short2BytesSW(msg_send.getPacketLen()));
					snd_os.write(msg_send.getAllBytes());
					connect.close();
				}
			}
		}
		catch (UnknownHostException u)
		{	System.out.println("UnknownHostException "+u);
		}	
		catch (IOException e)
		{	System.out.println("IOException "+e);
		}	
	}
//================== EVENT HANDLE =========================
	public boolean handleEvent(Event evt)
	{	if(evt.id==Event.WINDOW_DESTROY)
		{	dispose();
		}
		return super.handleEvent(evt);
	}
//=========================================================
	public void close()
	{	// dispose();
	}
}// end class