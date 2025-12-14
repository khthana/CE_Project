import java.io.*;
import java.net.*;
import java.awt.*;

class FileServer extends Frame
{


	static TextArea display;
	Label displayRecipiend;
	Font myFont;

/*====================FileServer()===========*/	

	FileServer()
	{
		super("FileServer");
		setLayout(null);
		myFont = new Font("Cordia New",Font.BOLD,15);
		setFont(myFont);
		add(displayRecipiend = new Label("-- FileSender List --"));
		add(display = new TextArea(100,100));
		displayRecipiend.setBounds(50,50,65,30);
		display.setBounds(50,80,100,100);
		display.setSize(200,200);
		show();
		setSize(400,400);
		setBounds(50,50,300,400);
	}

/*====================handleEvent(Event)===========*/

	public boolean handleEvent(Event e)
	{
		if(e.id == Event.WINDOW_DESTROY)
		{
			hide();
			dispose();
			System.exit(0);
		}
		return super.handleEvent(e);
	}

/*====================run()===========*/

	static ServerSocket serverSocket;

	public static void run()
	{
		try
		{
			serverSocket = new ServerSocket(8080);	
		}
		catch (Exception e)
		{
			System.out.println("--Exception-- MailServer.run1() " + e);
		}
		do
		{
			try
			{
				Socket connection = serverSocket.accept();
				InetAddress machine = connection.getInetAddress();
				display.appendText("--- connectionHost ---" + "\r\n" + machine.getHostName() + "[" + machine.getHostAddress() + "]" + "\r\n");
				FileServerThread t = new FileServerThread(connection,machine.getHostName());
				t.start();
			} 
			catch (Exception e)
			{
				System.out.println("--Exception-- FileServer.run2()" + e);
			}
		}
		while (true);
	}

/*====================main(String[])===========*/

	public static void main(String[] args)
	{
		System.out.println("Hello World!");
		FileServer server = new FileServer();
		server.run();
	}
}
