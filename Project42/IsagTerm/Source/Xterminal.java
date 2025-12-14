package TERMINAL; 
import  java.awt.*;
import  java.io.IOException;
import  java.awt.event.*;
public class Xterminal extends Frame implements DATA_TERMINAL
{
	private boolean DEBUG = false;
	public static int CTRL_MASK;
	public static String HOST_NAME = "";
	public static int PORT_NUMBER = 22;
	public static String USER_NAME = null;
	public static String PASSWORD  = null;
	public static Canvas  canvas;
	public static SshTerminal _SshTerminal;
	public static SshIO _SshIO;
	public static Display _Display;
	private TextField HostField;
	private TextField UserField;
	private TextField PasswordField;
	private Choice PortField;
	private Choice FontField;
	private Choice FontSizeField;
	public  static boolean Switch = false; 
	public  boolean Echo = false;
	public  boolean About = false;
	//public  boolean setFont = false;

	public  static  FontMetrics Fm;
	public  static  Font  NormalFont;                                     
	public  static  int   CharWidth;                                          //hold width of FontMetrics 
	public  static  int   CharHeight;                                         //hold height of FontMetrics
	public  static  int   CharDescent;										//hold descent of FontMetrics
	public  static  Graphics g;                             //keep the object Graphics for drawing
	public static int Xterm = 650;
	public static int Yterm = 450; 
    
	public Xterminal()
	{
		setTitle("IsagTerm");
		canvas = new Canvas();
		add("Center",canvas);
		Panel p = new Panel();
		p.setLayout(new FlowLayout(FlowLayout.LEFT));
		p.add(new Label("Host name"));
		HostField = new TextField("",10);
		p.add(HostField);
		p.add(new Label("User name"));
		UserField = new TextField("",6);
		p.add(UserField); 
		p.add(new Label("Password"));
		PasswordField = new TextField("",5);
		p.add(PasswordField); 
		p.add(new Button("Connect"));
		p.add(new Button("Disconnect"));
		add("North",p);
		Panel p1 = new Panel();
		p1.add(new Button("About  "));
//		p1.add(new Button("Swap Thai Font  "));
		p1.add(new Label("Font Name -> "));
		FontField = new Choice();
		FontField.addItem("Courier");
		FontField.addItem("Dialog");
		FontField.addItem("Helvetica");
		FontField.addItem("DialogInput");
		p1.add(FontField);
		p1.add(new Label("Font Size -> "));
		FontSizeField = new Choice();
		FontSizeField.addItem("12");
		FontSizeField.addItem("15");
		FontSizeField.addItem("16");
		FontSizeField.addItem("20");
		FontSizeField.addItem("22");
		p1.add(FontSizeField);
		add("South",p1);
		resize(Xterminal,Yterminal);
		show();
		setResizable(false);
		InitialSshTerminal();
		//Disclaimer();

	}//constructor TERMINAL

	public void Disclaimer()
	{
		_SshTerminal = new SshTerminal();
//		_SshTerminal.DisplayString("11111111112222222222333333333344444444445555555555666666666677777777778888888888\n\r");	//Line
//		_SshTerminal.DisplayString("01234567890123456789012345678901234567890123456789012345678901234567890123456789\n\r");	//Line
		_SshTerminal.DisplayString("                                   Disclaimer. \n\r");									//Line1
		_SshTerminal.DisplayString("\n\r");																					//Line2
		_SshTerminal.DisplayString("\n\r");																					//Line3
		_SshTerminal.DisplayString("      The Program, named 'IsagTerm', is owned by the software developers who are");		//Line4
		_SshTerminal.DisplayString("Mr.Chaowanin Saiyasombat, Mr.Suchart Khummanee, advised by Mr.Akkradach Watchara");		//Line5
		_SshTerminal.DisplayString("pupong and Mr. Thana Hongsuwan, supported by Information Security Advisory Group");		//Line6
		_SshTerminal.DisplayString(" (ISAG) under Computer Engineering of King Mongkut's Institute of Technology Lad");		//Line7
		_SshTerminal.DisplayString("krabang (KMITL),Thailand and sponsored by National Electronics and Computer Tech");		//Line8
		_SshTerminal.DisplayString("nology Center (NECTEC) under National Science and Technology Department Agency  ");		//Line9
		_SshTerminal.DisplayString("(NSTDA), Thailand government. And it is copyrighted and licensed, not sold.\n\r ");		//Line10
		_SshTerminal.DisplayString("\n\r");																					//Line11
		_SshTerminal.DisplayString("\n\r");																					//Line12
		_SshTerminal.DisplayString("     In using the Program, you agree that its services are provided 'as is' with");		//Line13
		_SshTerminal.DisplayString("out warranty, express or implied,and that your use the Program at your own risk.");		//Line14
		_SshTerminal.DisplayString("The Program  is  designed, manufactured and intended for educational and/or non-");		//Line15
		_SshTerminal.DisplayString("commercial purpose only, do not use or resale it as on-line control equipment in");		//Line16
		_SshTerminal.DisplayString("hazardous environments requiring fail-safe performance in which the failure of  ");		//Line17
		_SshTerminal.DisplayString("the Program could lead directly to death, personal injury, or severe physical or");		//Line18	
		_SshTerminal.DisplayString("environmental damage ('High Risk Activities').\n\r");									//Line19
		_SshTerminal.DisplayString("\n\r");																					//Line20
		_SshTerminal.DisplayString("\n\r");																					//Line21
		_SshTerminal.DisplayString("      All other trademarks mentioned  in  the Program are the property of their ");		//Line22
		_SshTerminal.DisplayString("respective owners.");																	//Line23
		_SshTerminal.Paint();
	}

	//@ role: this is method used for intial class display and working start
	//input : none
	//output : intial and start display
	public void InitialSshTerminal()
	{
		try
		{
			_Display = new Display();
			_Display.Start(canvas);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}//initial Ssh terminal class

	//@role: this is method used intial font size and graphics canvas
	//input : name font, size font
	//output : set font and font name
	public void InitialSshTerminal(String str,int sizestr)
	{
		try
		{
			_Display = new Display();
			_Display.Start(canvas,str,sizestr);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}//initial Ssh terminal class

	public static void setHost(String str){HOST_NAME = str;}			//nethod setHost()
	public static String getHost(){return HOST_NAME;}						// method getString()
	public static void setPort(int port){PORT_NUMBER = port;}		//nethod setHost()
	public static int getPort(){return PORT_NUMBER;}						// method getString()
	public static void setUser(String user){USER_NAME = user;}	//nethod setusername()
	public static String getUser(){return USER_NAME;}						// method getString()
	public static void setPassword(String pass){PASSWORD = pass;}//nethod setpassword()
	public static String getPassword(){return PASSWORD;}			// method getString()

	//@ role: this is method uesd for receive event from key board
	//input : event key
	//output : respond event occrrence
	public boolean handleEvent(Event evt)
	{
		try
		{
			if(evt.id == Event.WINDOW_DESTROY)									//event distroy frame windows
				System.exit(0);
			 // if (evt.id == Event.KEY_PRESS && evt.key == '\r' ) {  //event key return carrier //}
			if (evt.controlDown() && (evt.id == Event.KEY_ACTION && evt.key == Event.RIGHT ))  
			{ //event key null
				_SshIO.SendHost("\0");
			}
			if(evt.target == PasswordField && evt.id == Event.KEY_PRESS && Echo == false)
			{
				PasswordField.setEchoCharacter((char)'*');
				Echo = true;
			} //set echo  
		}catch(Exception e){};
		return super.handleEvent(evt);
	}//handleEvent

	//@role: initial all value necessary
	//input : none 
	//output : initial all value
	public void InitialConnect()throws IOException
	{
		String Host = HostField.getText();
		setHost(Host); 
		String User = UserField.getText();
		setUser(User);
		String Password = PasswordField.getText();
		setPassword(Password);
		String str  = FontField.getSelectedItem();
		String size    = FontSizeField.getSelectedItem();
		int  sizestr = Integer.parseInt(size);
		InitialSshTerminal(str,sizestr);
		_SshIO = new SshIO(USER_NAME,PASSWORD);
		if(checkText(Host)) throw new IOException("Host name is not correct !");
		if(checkText(Password)) throw new IOException("Password  is not correct !");
		Switch = true;
		PasswordField.setText("");
		_Display.STOP = false;
		_SshIO.connect(HOST_NAME);
	}//mathod InitialConnect()

	//@role: inspect field of user name and password on key press 
	//input : user name,password
	//output : return string message
	private boolean checkText(String s)
	{
		byte[] b = s.getBytes();
		if(b[0] != 32) return false;
		else return true;
	}

	//@role : respond event occur of key press
	//input : key press
	//output : respond appropriate activity 
	public boolean action(Event evt,Object what)
	{
		if(what.equals("Connect"))
		{
			About = true;
			String fontname  = FontField.getSelectedItem();
			String size    = FontSizeField.getSelectedItem();
			if(DEBUG) System.out.println("test "+fontname+" "+size);
			int  fontsize = Integer.parseInt(size);
			if(DEBUG) System.out.println("Font ="+fontsize);
			NormalFont = new Font(fontname,Font.PLAIN,fontsize);					//set font 
			g = canvas.getGraphics();																			//get graphics for drawing
			if(NormalFont != null) g.setFont(NormalFont);
			Fm = g.getFontMetrics(NormalFont);
			CharWidth  = Fm.getMaxAdvance();														//get  font metrics of width 
			CharHeight = Fm.getHeight();																	// get font metrics of height */
			CharDescent= Fm.getDescent();																//get descent metrics
			Xterm = CharWidth * 80;
			Yterm = (CharHeight+CharDescent) *25;
			System.out.println(Xterm+" - " +Yterm);
			resize(Xterm,Yterm);
			show();
   
			try
			{
				InitialConnect();
			}
			catch(Exception e)
			{
				_SshIO.Display("\n\rXterminal [Host name or Password not correct !]");
			}
			return true;
		}//if Connect
		else if(what.equals("Disconnect"))
		{
			Switch = false;
			try
			{
				_SshIO.Disconnect();
				_Display.STOP = true;
				About = false;
				return true;
			}
			catch(Exception e)
			{
				_SshTerminal.DisplayString("\n\rIsagTerm Disconnect");
			}
			
		}//if Disconnect


		else if(what.equals("About  "))
		{
			try
			{
				if(About == false){
				 Disclaimer();
				 About = true;
				 return true;}
				 return false;
			}
			catch(Exception e)
			{
				_SshTerminal.DisplayString("\n\rIsagTerm About");
			}
			
		}//if About


/*		else if(what.equals("Swap Thai Font  "))
		{
			try
			{
			   if(_Display.setfont == false) _Display.setfont = true;
			  else _Display.setfont = false;
			}	
			catch(Exception e)
			{
				_SshTerminal.DisplayString("\n\rIsagTerm setFont");
			}
			
		}//if About
*/

		return false;
	}//action 

	//*******************************************************
	//                 part of key press
	//*******************************************************
	public boolean keyDown(Event evt, int k)
    {
		try
		{
			if(!Switch) return false; 
			if(evt.key == 1004){_SshIO.SendHost("\u001bOA");return true;} //key up
			else if(evt.key == 1005){_SshIO.SendHost("\u001bOB");return true;}//key down
			else if(evt.key == 1006){_SshIO.SendHost("\u001bOD");return true;}//key left
			else if(evt.key == 1007){_SshIO.SendHost("\u001bOC");return true;} //key right
			else if (evt.key == '\n' && !evt.controlDown() ){ _SshIO.SendHost(""+(char)(evt.key+3)); return true;}
			else if (evt.key == '\r' ) {  _SshIO.SendHost("\r");return true;}
			if(	(evt.key >=1&& evt.key <=255) || (evt.key >= 1004 && evt.key <= 1007) || (evt.key >= 3424)) 
			{	//Key F1-F12,Home, End, Page Up Down, Num Lock and other key does not display
				_SshIO.SendHost((char)evt.key+"");
				if(DEBUG) System.out.println(evt.key);
			}
			return true;
		}
		catch(Exception e) {}
		return true;
    }//keyDown
      
 //**********************************************************
}//	class TERMINAL