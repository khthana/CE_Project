import java.io.*;
import java.net.*;
import java.awt.*;
import decode_byte;

class FileServerThread extends Thread
{
/*====================ServerMail()===========*/

	TextArea display;
	Label displayRecipiend;
	Font myFont;
	Socket connect;
	DataInputStream inStream;
	DataOutputStream outStream;
	StringBuffer close = new StringBuffer("close");
	Frame frame;

	FileServerThread(Socket connection,String hostConnect) throws IOException
	{
		frame = new Frame(hostConnect);
		frame.setLayout(null);
		frame.setBackground(Color.black);
		frame.setForeground(Color.blue);
		myFont = new Font("Cordia New",Font.BOLD,15);
		frame.setFont(myFont);
		frame.add(displayRecipiend = new Label("-- DataInlist List --"));
		frame.add(display = new TextArea(100,100));
		displayRecipiend.setBounds(50,50,65,30);
		display.setBounds(50,80,100,100);
		display.setSize(200,200);
		frame.show();
		frame.setSize(400,400);
		frame.setBounds(50,50,300,400);

		 connect = connection;
		inStream = new DataInputStream(connection.getInputStream());
		outStream = new DataOutputStream(connection.getOutputStream());
	}

	public void run()
	{
		System.out.println("Run");
		try
		{
			String sub = inStream.readLine();System.out.println("Sub = " + sub);
			String fileName = inStream.readLine();System.out.println("fileName = " + fileName);
			FileOutputStream fout = new FileOutputStream("c:/webcgi/"+ sub+"/"+  fileName);
			//String fileName = inStream.readLine();System.out.println("fileName = " + fileName);
			
			int byteValue = Integer.parseInt(inStream.readLine());System.out.println("byteValue = " + byteValue);
			byte[] byteStream = new byte[byteValue];
			
			inStream.readFully(byteStream);System.out.println("3");
			
			fout.write(byteStream);System.out.println("4");
			fout.close();System.out.println("5");
		}
		catch (Exception e)
		{
			System.out.println("Exception new File" + e);
		}
		try
		{
			connect.close();System.out.println("connect.close() ");
		}
		catch (IOException e)
		{
			System.out.println("--Exception-- FileServerThread.run() " + e);
		}
		frame.setVisible(false);
		System.out.println("this.stop()");
		this.stop();
	}

}
