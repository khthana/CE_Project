package IsecQ;
import java.awt.event.*;
import java.awt.*;
import java.io.*;
import java.net.*;

import IsecQ.*;

public class  TCP extends Frame implements WindowListener,ActionListener 
{
	static  TextArea ta;
//	public TCP(Socket remoteSocket, String message)
	public TCP()
	{	setTitle("tcp test");
		Panel p=new Panel();
		p.setLayout(new FlowLayout());
		ta=new TextArea();
		ta.setFont(new Font("DialogInput",Font.PLAIN,20));
		add("Center",ta);
		addWindowListener(this);
		resize(800,800);
		show();	
	}

	CHANNEL_INIT init_send=new CHANNEL_INIT();
	CHANNEL_MESSAGE msg_send=new CHANNEL_MESSAGE();
	public static void main(String args[])throws UnknownHostException, IOException
	{
		Socket connect=new Socket("localhost",29652);
		System.out.println("connect port 29652");
		sendMessage(1,"hello");
	}

	public void sendMessage(int msg_type, String msg)
	{	msg_send.setMsgCmd((short)0xda07);
		msg_send.setUIN1(24376329);
		msg_send.setPort(14045);
		msg_send.setMessage(msg);
		msg_send.setMsgType((short)msg_type);
		msg_send.setIP(connect.getInetAddress().getAddress());
		msg_send.setIPReal(connect.getInetAddress().getAddress());
		msg_send.setCmdType((short)0x0000);
		msg_send.setTCP_SEQ(0);
	}

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
	
/* public static void main(String[] args) throws IOException 
	{
		Frame f=new TCPconnect();
		f.resize(800,800);
		f.show();	

		Socket server=accept(14245);
		Socket connect=new Socket("localhost",8605);
		Util u=new Util();
		try
		{
			ta.appendText("test\n");	
			ta.appendText("วันนี้วันที่ 17 ทดสอบภาษาไทย\n");	
			InputStream i=server.getInputStream();
			OutputStream o=connect.getOutputStream();
			DataInputStream is=new DataInputStream(i);
			DataOutputStream os=new DataOutputStream(o);
			short packet_len;
			CHANNEL_INIT init_rcv=new CHANNEL_INIT();
			CHANNEL_INIT init_send=new CHANNEL_INIT();
			CHANNEL_MESSAGE msg_send=new CHANNEL_MESSAGE();
			CHANNEL_MESSAGE msg_receive=new CHANNEL_MESSAGE();
			packet_len=is.readShort();	
			packet_len=u.bytes2Short(u.short2BytesSW(packet_len));
			ta.appendText("CHANNEL_INIT Packet length :"+packet_len+"\n");
			byte[] bytes_packet=new byte[packet_len];
			is.read(bytes_packet);
			ta.appendText(u.bytes2HxStr(bytes_packet)+"\n");			
			init_rcv.receiveData(bytes_packet);
			while(true)
			{
				ta.appendText("****************** RECEIVE MESSAGE ****************\n");
				packet_len=is.readShort();	
				packet_len=u.bytes2Short(u.short2BytesSW(packet_len));
				ta.appendText("CHANNEL_MESSAGE Packet length :"+packet_len+"\n");
				bytes_packet=new byte[packet_len];
				is.read(bytes_packet);
				msg_receive.receiveData(bytes_packet);
				ta.appendText(u.bytes2HxStr(bytes_packet)+"\n");			
				msg_receive.printAll(ta);
				
				ta.appendText("****************** REPLY ****************\n");
				msg_send.setMsgCmd((short)0xda07);
				msg_send.setUIN1(msg_receive.getUIN1());
				msg_send.setPort(msg_receive.getPort());
				msg_send.setMessage("");
				msg_send.setMsgType((short)16);
				msg_send.setIP(server.getInetAddress().getAddress());
				msg_send.setIPReal(server.getInetAddress().getAddress());
				msg_send.setCmdType((short)0x0000);
				msg_send.setTCP_SEQ(msg_receive.getTCP_SEQ());
				ta.appendText("reply packet length: "+msg_send.getPacketLen());
				os.write(msg_receive.getPacketLenB());				
				os.write(msg_receive.getAllBytes());				
				msg_send.printAll(ta);
			}// end while
		}// end try
		finally
		{
			System.out.println("Closing");
			server.close();
		}
	}// end main
*/
}// end class