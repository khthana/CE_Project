package IsecQ;
import java.io.*;
import java.awt.*;
import java.awt.image.*;
import java.awt.event.*;
import java.util.*;
import java.net.*;
import IsecQ.*;

public class IsagQ extends Frame 
{				HelpTopic				helptopic;			// help topic widnow 
				SelectServer			selectserver;	//  config about server window
				AddAnother				addanother;		// 
				AddInfo					addinfo;			//
	static	ChangeActiveUser	changeactiveuser,EnterPassword;
				SendMessage			sendmessage;
				TSecure					tsecure;
	static	Properties		h = new Properties();
				Font					font1 = new Font("DialogInput",Font.PLAIN ,12);
				Button				button1 = new Button(),
										button2 = new Button(),
										button3 = new Button();
				PopupMenu	//m		= new PopupMenu(),
										staicq	= new PopupMenu(),
										micq	= new PopupMenu(),
										rightClick = new PopupMenu();
				Panel				panel1 = new Panel();
				Image				i1, i2, i3, i4;
				int x = 25;
				int y = 1;
	static	int xXx; // = 0;
	static	int yYy; // = 0;
	static	Search search; // window for search user
	static	List searchList;
//---------------------------------------------CONSTRUCTOR-----------------------------------------------------
    public IsagQ() 
	{	this.setLayout(new BorderLayout());
		this.setFont(new Font("DialogInput",Font.BOLD ,12));
		this.setTitle("No...");
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
		Toolkit tk = getToolkit();
		this.setIconImage(tk.getImage("IsecQ/images/SICQ01.jpg"));
		i1 = tk.getImage("IsecQ/images/M.jpg");	i2 = tk.getImage("IsecQ/images/F.jpg");
		i3 = tk.getImage("IsecQ/images/U.jpg");	i4 = tk.getImage("IsecQ/images/C.jpg");
		panel1.setLayout(new BorderLayout());
		panel1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		button1.setLabel("Search");
		button2.setLabel("Status");
		button3.setLabel("IsagQ");
		panel1.add("West", button1);
		panel1.add("Center", button2);
		panel1.add("South", button3);
		this.add("South", panel1);
		MenuItem	r1   = new MenuItem("Message"),
//							r2   = new MenuItem("URL"),
//							r3   = new MenuItem("Contacts"),
							r4   = new MenuItem("User's Details"),
							r5   = new MenuItem("Delete User");
		rightClick.add(r1);
//		rightClick.add(r2);
//		rightClick.add(r3);
		rightClick.add(r4);
		rightClick.addSeparator();
		rightClick.add(r5);
		add(rightClick);
		MyActionListener b = new MyActionListener();
		r1.addActionListener(b);	
//		r2.addActionListener(b);
//		r3.addActionListener(b);	
		r4.addActionListener(b);
		r5.addActionListener(b);	

		MenuItem	w1   = new MenuItem("Server"),
							w2   = new MenuItem("Change Active User"),
							w3   = new MenuItem("Add Another User"),
							w4   = new MenuItem("Remove User"),
							w5   = new MenuItem("Change/View My Details"),
							w6   = new MenuItem("Security"),
							w7   = new MenuItem("Preference"),
							w81 = new MenuItem("About"), //, new ImageIcon("SICQ01.jpg")),
							w82 = new MenuItem("HelpTopic");
		Menu	w8  = new Menu("Help");
		micq.add(w1);	micq.addSeparator();	micq.add(w2);	micq.add(w3);
		micq.add(w4);	micq.add(w5);				micq.add(w6);	micq.addSeparator();
		micq.add(w7); micq.addSeparator();	micq.add(w8);	add(micq);
		w8.add(w81);	w8.add(w82);
		
		MenuItem	s1 = new MenuItem("Online"),
							s2 = new MenuItem("Offline");
//							s3 = new MenuItem("+Secure"),
//							s4 = new MenuItem("+Away"),
//							s5 = new MenuItem("+N/A"),
//							s6 = new MenuItem("+Occupied"),
//							s7 = new MenuItem("+DND"),
//							s8 = new MenuItem("+Privacy"),
//							s9 = new MenuItem("+Free for Chat");

		staicq.add(s1); 	staicq.add(s2);
/*		staicq.addSeparator();	staicq.add(s9);
		staicq.add(s4);	staicq.add(s5);				staicq.add(s6);
		staicq.add(s7);	staicq.addSeparator();	staicq.add(s8);
		staicq.add(s9);	staicq.addSeparator();
*/	
		add(staicq);

		r1.setFont(font1);	//	r2.setFont(font1);//	r3.setFont(font1);
		r4.setFont(font1);	r5.setFont(font1);	
		s1.setFont(font1);	s2.setFont(font1);	
/*		s3.setFont(font1);
		s4.setFont(font1);	s5.setFont(font1);	s6.setFont(font1);
		s7.setFont(font1);	s8.setFont(font1);	s9.setFont(font1);
*/		w1.setFont(font1);	w2.setFont(font1); 	w3.setFont(font1);
		w4.setFont(font1);	w5.setFont(font1);	w6.setFont(font1);
		w7.setFont(font1);	w8.setFont(font1);
		w81.setFont(font1);    w82.setFont(font1);

	}

	private static String					serverName	=	"icq.mirabilis.com";
	private static int						serverPort		=	4000;
	private static ServerConnect	sconnect	 = new ServerConnect();
	private static UserOnlineInfo	myonline			=	new UserOnlineInfo();	
	private static TCPconnect		tcpConnect		=	new TCPconnect();
	private static ServerListener	serverListener	=	new ServerListener();
	private static TCPreceiveThread		receive_thread =	 new TCPreceiveThread();
	private static KEEP_ALIVE_Thread	keepAlive	 ;
	private static int						max_remoteUIN	=	500 ,num_remoteUIN = 0 ,max_owner =10 ,num_owner = 0;
	private static UserAllInfo[]		UserArr			=	new UserAllInfo[max_remoteUIN];
	private static UserAllInfo[]		UserOwner		=	new UserAllInfo[max_owner];
	private static UserAllInfo			myallinfo			=	new UserAllInfo();
	private static IsagQ					f						=	new IsagQ();
	private static TextArea			TCPtextarea	=	new TextArea();
	private static TextArea			UDPtextarea	=	new TextArea();
	private static Util						u						=	new Util();
//-------------------------------------------------------------------------------------------------------------------------
//									 Main Program IsagQ
//-------------------------------------------------------------------------------------------------------------------------
//	private static UserDATA[] userdata=new UserDATA[4];

	public static void Begin() throws IOException,UnknownHostException
	{	f = new IsagQ(); 
		f.setSize(135, 345);
		f.move(100, 100);
		f.setVisible(true);

		getOwnerList();

/*		for (int i = 0 ;i < max_owner ;i++ )
		{	UserOwner[i] = new UserAllInfo();
		}
				
		UserOwner[0].setUIN(60710412);
		UserOwner[0].setNick("ann");
		UserOwner[0].setPWD("noey&hem");

		UserOwner[1].setUIN(24376329);
		UserOwner[1].setNick("kenji");
		UserOwner[1].setPWD("hi'icq");

		UserOwner[2].setUIN(60710154);
		UserOwner[2].setNick("noey");
		UserOwner[2].setPWD("noey&hem");
		
//		UserOwner[3].setUIN(60710361);
//		UserOwner[3].setNick("kenji");
//		UserOwner[3].setPWD("noey&hem");

		num_owner = 3;
*/	

		loginToICQServer(UserOwner);

//		for (int i=0 ;i<num_remoteUIN ;i++ )
//		{	try{Thread.sleep(1000);}catch (InterruptedException ie)	{System.err.println("InterruptedException: "+ie);}
//			sconnect.SearchExtInfo(UserArr[i].getUIN());
//		}
//		try{Thread.sleep(10000);}catch (InterruptedException ie)	{System.err.println("InterruptedException: "+ie);}
//		sconnect.SearchExtInfo(60710412);
	}
//------------------------GET TCP CONNECTION ------------------------------------------------------------------------------------
	static TCPconnect getTcpConnect()
	{	return tcpConnect;
	}
//------------------------GET TCP CONNECTION -----------------------------------------------------------------------------------------------
	static List getSearchList()
	{	return searchList;
	}
//------------------------LOGIN TO ICQ SERVER--------------------------------------------------------------------------------------------------
//	static private boolean newuser =false;
	static void loginToICQServer(UserAllInfo[] ownerinfo)throws IOException,UnknownHostException
	{	
				//			Get user active information 
		myallinfo =clientAuthentication(ownerinfo ,num_owner);	
			
//		System.out.println(" select uin " +selectedUser.getUIN());
				 //			set string at title bar of IsagQ windows
		f.setTitle(Integer.toString(myallinfo.getUIN()));				
				//			Get remote user from data file to contact list
		getContactList(myallinfo.getUIN());
		System.out.println(" contact");
				//			Put class active user online information to class all information 
		myallinfo.UserOnlineInfo(createMyInfo(myallinfo.getUIN()));
				//			Create own RSA and DES keys
		genMyKey();
		System.out.println(" gen key");
				//			Login to ICQ server
		sconnect.Connect(serverName ,serverPort ,UDPtextarea);
		sconnect.login(myallinfo ,UserArr ,num_remoteUIN);
		System.out.println(" login");
				//			Get Infomation of user in contact list 
//		for (int i=0;i<3 ;i++ )
//		{	sconnect.SearchUIN(UserArr[i].getUIN());
//		}
				//			Create server listenner for receive command from server
		if (sconnect.canlogin())
		{	serverListener.setInformation(f ,sconnect ,UserArr );
			serverListener.start();
					//			Create TCP connection
			tcpConnect.Connect(myallinfo ,TCPtextarea);
					//			Send RSA public key to IsagQ user
			tcpConnect.sendKey(UserArr);
					//			Create TCP listenner for receive message from remote clients
			receive_thread.setInformation( f ,myallinfo , UserArr , num_remoteUIN ,sconnect ,tcpConnect ,TCPtextarea);
			receive_thread.start();
					//			Send keep alive for online along time
			keepAlive=new KEEP_ALIVE_Thread(sconnect);
			keepAlive.start();
		}else sconnect.logOut();
	}
//----------------------------------------CREATE MY KEY------------------------------------------------------------------------------------
	static void genMyKey()
	{	RSA rsa = new RSA();
		rsa.genKey();
		myallinfo.setKey_E(rsa.getE());
		myallinfo.setKey_D(rsa.getD());
		myallinfo.setKey_N(rsa.getN());
		DES des =new DES();
		myallinfo.setKey_DES(des.genKey(16));
	}
//---------------------------------CLIENT AUTHENTICATION-------------------------------------------------------------------------------
//	PwdVerification PwdVer	= new PwdVerification();

	static UserAllInfo clientAuthentication(UserAllInfo[] ownerinfo ,int num_owner)
	{	//PwdVer.Verification(userdata);
		PwdVerification PwdVer = new PwdVerification(f ,ownerinfo ,num_owner);
		if(PwdVer.getOK().equals("Cancel"))System.exit(0);
		return PwdVer.getSelectedUser();
	}
//---------------------------------CREATE MY INFO-----------------------------------------------------------------------------------------
	static UserOnlineInfo createMyInfo(int uin)
	{	UserOnlineInfo myonlineinfo=new UserOnlineInfo();
		try
		{
			myonlineinfo.setUIN(uin);
			myonlineinfo.setIP(InetAddress.getLocalHost().getAddress());	//	 for LOGIN to icq server
			myonlineinfo.setPort(u.portGen());											//
			myonlineinfo.setStatus(0);															//----------------------------------------------
		}
		catch (UnknownHostException un)
		{	System.err.println("createMyInfo "+un);
		}
		return myonlineinfo;
	}
//---------------------------------GET CONTACT LIST-----------------------------------------------------------------------------------------
	static void  getContactList(int ownerUIN)throws IOException 
	{
		ReadAllDataFile readContact = new ReadAllDataFile();
		UserAllInfo[]  temp = readContact.ReadFile(ownerUIN+".ctl");
		num_remoteUIN = temp.length;
		for (int i=0;i<max_remoteUIN;i++ )
		{	UserArr[i] = new UserAllInfo(); // remote user
		}
		for (int i=0;i<num_remoteUIN;i++ )
		{	UserArr[i]=temp[i]; // remote user
		}
		f.repaint();	// show uin in contact list to main icq
	}
//--------------------------------- ADD REMOTE UIN ------------------------------------------------------------------------------------------
	public void addRemoteUIN(UserInfo uinfo)
	{	UserArr[num_remoteUIN].UserInfo(uinfo);
		num_remoteUIN++;
		f.repaint();
		System.out.println("add user "+UserArr[num_remoteUIN].getUIN());
	}
//--------------------------------- REMOVE REMOTE UIN ------------------------------------------------------------------------------------------
	public void removeRemoteUIN(int uin)
	{	int remove_index = max_remoteUIN;
		
		for (int i = 0;i < num_remoteUIN ;i++ )
		{	if (UserArr[i].getUIN() == uin)
			{	remove_index = i;
				System.out.println("remove user "+UserArr[num_remoteUIN].getUIN());
			}
		}
		for (int i = remove_index ;i < num_remoteUIN ;i++ )
		{	UserArr[i]=UserArr[i+1];
		}
		num_remoteUIN--;
		f.repaint();
	}
//---------------------------------GET SERVER CONNECTION------------------------------------------------------------------------------
	public ServerConnect getServerConnect(){ return sconnect;}

//---------------------------------GET NUM REMOTE UIN ------------------------------------------------------------------------------------
	public int getNumRemoteUIN(){ return num_remoteUIN;}
//---------------------------------INCREMENT NUMBER OF REMOTE UIN--------------------------------------------------------------
	public void incNumRemoteUIN(){ num_remoteUIN++;}
//---------------------------------Increment number of remote UIN---------------------------------------------------------------------------
//	public UserAllInfo[] getUser(){ return UserArr;}

//---------------------------------GET OWNER LIST-----------------------------------------------------------------------------------------
	static void  getOwnerList()throws IOException 
	{
		ReadAllDataFile readOwner = new ReadAllDataFile();
		UserAllInfo[]  temp = readOwner.ReadFile("IsagQ.ifo");
		num_owner = temp.length;
		for (int i = 0 ; i < max_owner ;i++ )
		{	UserOwner[i] = new UserAllInfo(); // remote user
		}
		for (int i = 0 ; i < num_owner ; i++ )
		{	UserOwner[i]=temp[i]; 
		}
	}
//---------------------------------GET NUM OWNER--------------------------------------------------------------------------------------------
	public int getNumOwner(){ return num_owner;}
//---------------------------------INCREMENT NUMBER OF OWNER---------------------------------------------------------------------
	public void incNumOwner(){ num_owner++;}
//--------------------------------- ADD OWNER UIN ------------------------------------------------------------------------------------------
	public void addOwner(UserAllInfo uallinfo)
	{	UserOwner[num_owner] = uallinfo;
		num_owner++;
//		f.repaint();
		System.out.println("add user "+UserOwner[num_owner].getUIN());
	}
//--------------------------------- REMOVE OWNER UIN ------------------------------------------------------------------------------------------
	public void removeOwner(int uin)
	{	int remove_index = max_owner;
		
		for (int i = 0;i < num_owner ;i++ )
		{	if (UserOwner[i].getUIN() == uin)
			{	remove_index = i;
				System.out.println("remove user "+UserOwner[num_owner].getUIN());
			}
		}
		for (int i = remove_index ;i < num_owner ;i++ )
		{	UserOwner[i]=UserOwner[i+1];
		}
		num_owner--;
//		f.repaint();
	}

//---------------------------LOGOUT-------------------------------------------------------------
	void LogOut()throws IOException
	{	
		sconnect.logOut();
//		tcpConnect.close();
		serverListener.stop();
		receive_thread.stop();
		keepAlive.stop();
		sconnect.CloseSocket();
		for (int i = 0 ;i < num_remoteUIN ;i++ )
		{	UserArr[i].setOffline();
		}
		WriteAllData contact = new WriteAllData(myallinfo.getUIN()+".ctl" ,UserArr ,num_remoteUIN);
		WriteAllData myinfo = new WriteAllData("isagQ.ifo" ,UserOwner ,num_owner);

		for (int i = 0 ;i < num_remoteUIN ;i++ )
		{	UserArr[i] = new UserAllInfo();
		}
		num_remoteUIN=0;

		logout = true;
		repaint();
	}
//---------------------------QUIT ICQ-------------------------------------------------------------
	boolean logout =false;
	void QuitICQ()throws IOException
	{	if (!logout)
		{	LogOut();
		}
//		LogOut();
		System.exit(0);
	}

//----------------------------------PAINT()--------------------------------------------------
	 /* YIpos= Y positoin for Image  , YSpos= Y position for draw String */
	public  void paint(Graphics g) 
	{	try
		{	//---------------------------------paint Secure uin --------------------------------
			g.setFont(new Font("DialogInput",Font.BOLD ,12));
			g.setColor(Color.lightGray);
			Rectangle r = this.getBounds();//<<---------xxxxxxxxxxxx
			g.fill3DRect(5, 23, (r.width-9), (r.height-72), true);
			g.fill3DRect(5, 30, (r.width-5), 2, false);	//<<---------xxxxxxxxxxxx
			g.fillRect(((r.width/2)-30), 30, 56, 2);	//<<---------xxxxxxxxxxxx
			g.setColor(Color.black);
			g.drawString("Secure", ((r.width/2)-20), 35);//<<---------xxxxxxxxxxxx
			int YIpos=39,YSpos=50,HashIndex=4 ;  
			g.setFont(new Font("DialogInput",Font.PLAIN ,12));
			g.setColor(Color.magenta);
			for (int i=0 ;i<num_remoteUIN ;i++)
			{	if (UserArr[i].getOnline() && UserArr[i].getIsagQ())
				{	g.drawImage(i1, 10, YIpos, this);
					g.drawString(UserArr[i].getDisplayStr(), 33, YSpos);	
					String ss =  Integer.toString(HashIndex);
					h.put( ss,Integer.toString(UserArr[i].getUIN()));
//					System.out.println("get Hash : "+h.get(ss));
					YIpos+=20;YSpos+=20;HashIndex+=2;
				}
			}// end for
			//---------------------------------paint online uin --------------------------------
			g.setFont(new Font("DialogInput",Font.BOLD ,12));
			g.setColor(Color.lightGray);
			g.fill3DRect(5, YSpos-5, (r.width-5), 2, false);	//<<---------xxxxxxxxxxxx
			g.fillRect(((r.width/2)-30), YSpos-5, 56, 2);	//<<---------xxxxxxxxxxxx
			g.setColor(Color.black);
			g.drawString("Online", ((r.width/2)-20), YSpos);//<<---------xxxxxxxxxxxx
			YIpos+=20;YSpos+=20;HashIndex+=2;
			g.setFont(new Font("DialogInput",Font.PLAIN ,12));
			g.setColor(Color.blue);
			for (int i=0 ;i<num_remoteUIN ;i++)
			{	if (UserArr[i].getOnline() && !UserArr[i].getIsagQ())
				{	g.drawImage(i1, 10, YIpos, this);	//7
					g.drawString(UserArr[i].getDisplayStr(), 33, YSpos);	//27
					String ss =  Integer.toString(HashIndex);
					h.put( ss,Integer.toString(UserArr[i].getUIN()));
//					System.out.println("get Hash : "+h.get(ss));
					YIpos+=20;YSpos+=20;HashIndex+=2;
				}
			}// end for
			//---------------------------------paint offline uin --------------------------------
			g.setFont(new Font("DialogInput",Font.BOLD ,12));
			g.setColor(Color.lightGray);
			g.fill3DRect(5, YSpos-5, (r.width-5), 2, false);	//<<---------xxxxxxxxxxxx
			g.fillRect(((r.width/2)-30), YSpos-5, 56, 2);	//<<---------xxxxxxxxxxxx
			g.setColor(Color.black);
			g.drawString("Offline", ((r.width/2)-20), YSpos);//<<---------xxxxxxxxxxxx
			YIpos+=20;YSpos+=20;HashIndex+=2;
			g.setFont(new Font("DialogInput",Font.PLAIN ,12));
			g.setColor(Color.red);
			for (int i=0 ;i<num_remoteUIN ;i++)
			{	if (!UserArr[i].getOnline())
				{	g.drawImage(i1, 10, YIpos, this);	
					g.drawString(UserArr[i].getDisplayStr(), 33, YSpos);	
					String ss =  Integer.toString(HashIndex);
					h.put( ss,Integer.toString(UserArr[i].getUIN()));
//					System.out.println("get Hash : "+h.get(ss));
					YIpos+=20;YSpos+=20;HashIndex+=2;
				}
			}// end for
			FileOutputStream	foo	= new FileOutputStream("HashConfig");
			h.save(foo, "My Properties Files"); 
			foo.close();	
		}
		catch (Exception e)	 {System.err.println("Exception error "+e);}
	} // end paint()
//--------------------------------HANDLE EVENT----------------------------------------------
	public boolean handleEvent(Event evt)
	{	try
		{	FileInputStream	fins	= new FileInputStream("HashConfig");
			Properties			ppt1	= new Properties();
			ppt1.load(fins);
			//System.out.println("handle event : "+evt.id);
			if (evt.id == Event.WINDOW_DESTROY) 
			{	QuitICQ();
				return true; 
			}
			else	if (evt.id == Event.MOUSE_DOWN)
			{	String s =Integer.toString(evt.y/10);
				if ((ppt1.containsKey(s)) && evt.clickCount == 2)
				{		System.out.println("Mouse Down handelEvent : "+evt.x +","+ evt.y);
						System.out.println("Get HashTable : "+ppt1.get(s));
						String ss = String.valueOf(ppt1.get(s));
	 					for (int i=0;i<UserArr.length ;i++ )
							if (UserArr[i].getUIN()==Integer.parseInt(ss))
								sendmessage = new SendMessage(UserArr[i] ,sconnect ,tcpConnect);
				}else if (metaDown(evt)) 
					{	System.out.println("+++ Mouse Right Clicked +++"+evt.x+","+evt.y );
						xXx = evt.x;
						yYy = evt.y;
						rightClick.show(this, evt.x, evt.y); 
						return true;	
					}
			}
			else if ("IsagQ".equals(evt.arg)) 
			{	System.out.println("Test Graphic handelEvent() "+evt.x+","+evt.y );
				micq.show(panel1, 4, -150); 
				return true; 
			}
			else if ("Status".equals(evt.arg))		{ staicq.show(panel1, evt.x, -20); return true; }
		 	else if ("About".equals(evt.arg))		{ Abouts ab = new Abouts(this); ab.show(); return true; }
			else if ("HelpTopic".equals(evt.arg))	{ helptopic = new HelpTopic(); return true; }
//		 	else if ("Add Info".equals(evt.arg))	
//					{
//						addinfo = new AddInfo(); return true; 
//					}
		 	else if ("Security".equals(evt.arg))	{ tsecure = new TSecure(); return true; }
			else if ("Server".equals(evt.arg))	{ selectserver = new SelectServer(); return true; }
			else if ("Change Active User".equals(evt.arg))
					{	LogOut();
						loginToICQServer(UserOwner);
					}
			else if ("Add Another User".equals(evt.arg)) 
					{	LogOut();
						AddAnother add = new AddAnother(f ,sconnect); 
						return true; 
					}
			else if ("Remove User".equals(evt.arg)) 
					{	LogOut();
						RemoveUser ru= new RemoveUser(f ,UserOwner ,num_owner);
						WriteAllData myinfo = new WriteAllData("isagQ.ifo" ,UserOwner ,num_owner);
						return true;
					}
					
			else if ("Change/View My Details".equals(evt.arg)) 
					{	UserInfoDialog uinfoDialog = new UserInfoDialog();
						uinfoDialog.setUserInfo(myallinfo ,sconnect);
						return true;
					}

			else if ("Online".equals(evt.arg))	
				{	//OKDialog.createOKDialog("     Online !  Press OK to Continue.");return true;
//					sconnect.Connect(serverName ,serverPort);
					getContactList(myallinfo.getUIN());
					sconnect.Connect(serverName ,serverPort ,UDPtextarea);
					sconnect.login(myallinfo ,UserArr ,num_remoteUIN);
					repaint();
					serverListener.start();
					receive_thread.start();
					tcpConnect.sendKey(UserArr);
//					tcpConnect.Connect(myallinfo ,TCPtextarea);
					keepAlive.start();
					logout = false;
				}
			else if ("+Away".equals(evt.arg))		{OKDialog.createOKDialog("     Away !  Press OK to Continue.");return true;}	
			else if ("+N/A".equals(evt.arg))	{OKDialog.createOKDialog("     N/A !  Press OK to Continue.");return true;}
			else if ("+Occupied".equals(evt.arg))	{OKDialog.createOKDialog("     Occupied !  Press OK to Continue.");return true;}
			else if ("+DND".equals(evt.arg))	{OKDialog.createOKDialog("     DND !  Press OK to Continue.");return true;}
			else if ("+Privacy".equals(evt.arg))	{OKDialog.createOKDialog("     Privacy !  Press OK to Continue.");return true;}
			else if ("+Free for Chat".equals(evt.arg))	{OKDialog.createOKDialog("     Free for chat !  Press OK to Continue.");return true;}
			else if ("Offline".equals(evt.arg))		{ LogOut();  return true; }
			else if ("Search".equals(evt.arg)) {	search = new Search(this);}///<--------------- test area object 
				{	Rectangle r = this.getBounds();
//					System.out.println(r.x +", "+r.y +", "+r.width+", "+r.height );
					return true;
				}
		}
		catch (Exception e)	{	/*No Operations*/	}
        return super.handleEvent(evt);
	}
	//------------------------------------------------------------------------------
	// Method Mouse Event
	//------------------------------------------------------------------------------
	public boolean mouseDown(Event e, int x, int y)
	{	//System.out.println("mouseDown : "+x+","+y); 		
		return true;	}
	public boolean mouseUp(Event e, int x, int y)
	{	//System.out.println("Event mouseUp : "+x+","+y); 
		return true;	}
	public boolean mouseDrag(Event e, int x, int y)
	{	//System.out.println("Event mouseDrag : "+x+","+y); 
		return true;	}
	public boolean mouseMove(Event e, int x, int y)
	{	//System.out.println("mouseMove : "+x+","+y); 
		return true;	}
	public boolean mouseEnter(Event e, int x, int y)
	{	//System.out.println(" Event mouseEnter : "+x+","+y); 
		return true;	}
	public boolean mouseExit(Event e, int x, int y)
	{	//System.out.println(" Event mouseExit : "+x+","+y); 
		return true;	}	
	public boolean metaDown(Event evt)
	{	//System.out.println(" Event META_MASK : "+x+","+y); 
		return (evt.modifiers & evt.META_MASK) != 0;	    }	
	//--------------------------------------------------------------------------------
	// จัดการกับการแสดง Action ออกทางจอภาพโดยบอก Action ที่กระทำ
	// ในที่นี้คือรับการกระทำจากการคลิกขวาที่ panel เพื่อทำการส่ง .....
	//--------------------------------------------------------------------------------
	class MyActionListener implements ActionListener
	{	
		public void actionPerformed(ActionEvent evt)
		{	try
			{	FileInputStream	fins	= new FileInputStream("HashConfig");
				Properties			ppt2	= new Properties();
				ppt2.load(fins);
				System.out.println("MyActionListener");//show output.
				String string = evt.getActionCommand();

				if (string.equals("Message")) 
				{	System.out.println("Show Dialog SendMessage  XXXXXXXXX ");
					String s =Integer.toString(yYy/10);
					if (ppt2.containsKey(s)) 
					{		String ss = String.valueOf(ppt2.get(s));
							for (int i = 0 ;i < num_remoteUIN ;i++ )
								if (UserArr[i].getUIN()==Integer.parseInt(ss))
									sendmessage = new SendMessage(UserArr[i] ,sconnect ,tcpConnect);
					}
				}// end Message
/*				else if (string.equals("Files"))
				{	System.out.println("Show Dialog Files Load");
					FileDialog fd = new FileDialog(new Frame(), 
					"Send file to user.", FileDialog.LOAD);
					fd.setDirectory(".");	fd.setVisible(true);	
					System.out.println(fd.getFile());
				}
*/
				else if (string.equals("User's Details"))
				{	
					String s =Integer.toString(yYy/10);
					if (ppt2.containsKey(s)) 
					{		String ss = String.valueOf(ppt2.get(s));
							for (int i = 0 ;i < num_remoteUIN ;i++ )
							{	if (UserArr[i].getUIN()==Integer.parseInt(ss))
								{	UserInfoDialog uinfoDialog = new UserInfoDialog();
									uinfoDialog.setUserInfo(UserArr[i] ,sconnect);
								}// end if
							}// end for
					}// end if ppt2
				}// end User's Details

				else if (string.equals("URL"))
				{	
					String s =Integer.toString(yYy/10);
					if (ppt2.containsKey(s)) 
					{		String ss = String.valueOf(ppt2.get(s));
							for (int i=0;i<num_remoteUIN ;i++ )
							{
								if (UserArr[i].getUIN()==Integer.parseInt(ss))
								{
								}// end if
							}// end for
					}// end if ppt2
				}// end URL

				else if (string.equals("Delete User"))
				{	String s =Integer.toString(yYy/10);
					if (ppt2.containsKey(s)) 
					{		String ss = String.valueOf(ppt2.get(s));
							for (int i=0;i<num_remoteUIN ;i++ )
							{
								if (UserArr[i].getUIN()==Integer.parseInt(ss))
								{	warnningDialog warnning = new warnningDialog(f ,"Are you sure to delete user "+ss+" ("+UserArr[i].getNick()+") ");
									while (!warnning.isSelect())
									{	try{	Thread.sleep(100);}
										catch (InterruptedException ie){System.out.println("InterruptedException "+ie);}
									} // end while
									if (warnning.isOK())	removeRemoteUIN(UserArr[i].getUIN());
									
								}// end if
							}// end for
					}// end if ppt2
				}// end Delete User
				System.out.println("Action: "+evt.getActionCommand());
			}
			catch (Exception e)		{System.out.println("Exception "+e);		}
		}
	}
}