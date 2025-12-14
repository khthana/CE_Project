import java.awt.*;					
import java.io.*;
import java.sql.*;
import oracle.jdbc.driver.*;
import oracle.ovc.PlayerFactory;	
import oracle.ovc.PlayerException;
import oracle.ovc.Player;
import oracle.ovc.*;


public class OVCPlayer extends Frame 
{
	static	Player			 player       = null;
	static	Component		 playerUI     = null;
	static	String			 m_MediaFile  = "";
			StmOpts			 optStream 	  = null;
			CheckboxMenuItem lowVol,midVol,hiVol,normScr,fullScr,autoStart,autoLoop;
	static	TextField		 showStatus;
	static	List			 list,clipList;   
	static	boolean			 load,fromServer;
	static  String			 m_Name,protocol,serverName,portName;
			Dialog			 n;

	public OVCPlayer()
	{
        setTitle("Movie Player");
		setIconImage(getToolkit().getImage("OvcIcon.jpg"));
		MenuBar menubar = new MenuBar();
		Menu menu = new Menu("File");
		menu.add(new MenuItem("Load Content"));
		menu.add(new MenuItem("Unload"));
		menu.addSeparator();
		menu.add(new MenuItem("Quit"));
		menubar.add(menu);
		menu = new Menu("Playback");
		menu.add(new MenuItem("Play"));
		menu.add(new MenuItem("Pause"));
		menu.add(new MenuItem("Stop"));
		menu.addSeparator();
		Menu videoSize =new Menu("Video Size");
		normScr = new CheckboxMenuItem("Normal");
		normScr.setState(true);
		videoSize.add(normScr);
		fullScr = new CheckboxMenuItem("Full Screen");
		videoSize.add(fullScr);
		menu.add(videoSize);
		Menu volume = new Menu("Volume");
		lowVol = new CheckboxMenuItem("Low");
		lowVol.setState(true);
		volume.add(lowVol);
		midVol = new CheckboxMenuItem("Medium");
		volume.add(midVol);
		hiVol = new CheckboxMenuItem("High");
		volume.add(hiVol);
		menu.add(volume);
		menubar.add(menu);
		menu=new Menu("Preferences");
		autoStart = new CheckboxMenuItem("Auto Start");
		autoLoop  = new CheckboxMenuItem("Auto Loop");
		menu.add(autoStart);
		menu.add(autoLoop);
		menu.addSeparator();
		menu.add(new MenuItem("Network Setting"));
		menubar.add(menu);
		menu=new Menu("Help");
		menu.add(new MenuItem("About"));
		menubar.add(menu);
		setMenuBar(menubar);
		setBackground(Color.black);
		resize(450,400);		
		optStream = new StmOpts();
		optStream.m_autoStart = false;
		optStream.m_loop = false;				
		showStatus = new TextField();
		add("South",showStatus);
		clipList = new List(4,false);
        n = new NetworkSet(this);
	 }   
	 
	 public static void main(String args[])
     {
         OVCPlayer app = new OVCPlayer();                        
	     app.addPlayer();
		 app.add(playerUI);
		 app.show();
     } 

	 public boolean handleEvent(Event evt)
	 {
		 if(evt.id==Event.WINDOW_DESTROY && evt.target == this)
		 {
			showStatus.setText("Shutting down the java client ...");
            if (player != null)
			{
				try
				{ 
					showStatus.setText("Player state before exiting: " + player.getState());
					player.unload ();
					player.term ();
				} 
				catch (PlayerException e) {
					showStatus.setText("exception while unloading: " + e);
				}
			}
	 		System.exit(0);
		}
		if (evt.id==Event.MOUSE_DOWN )
		{
			if (fullScr.getState())
			{
				normScr.setState(true);
			    fullScr.setState(false);
			 	try { 
					player.setFullScreen(false);
					} 		
					catch (PlayerException e) {
					showStatus.setText("exception while set normal screen : " + e);
					}
			}
		}
		return super.handleEvent(evt);
	 }
	 
	 public boolean action(Event evt,Object arg)
	 {	
		 if (evt.target == normScr)
		 {
			normScr.setState(true);
			fullScr.setState(false);
			try { 
				player.setFullScreen(false);
			} 		
			catch (PlayerException e) {
			showStatus.setText("exception while set normal screen : " + e);
			}
		 }
		 else
 		 if (evt.target == fullScr)
		 {
			normScr.setState(false);
			fullScr.setState(true);
			try { 
				player.setFullScreen(true);
			} 		
			catch (PlayerException e) {
			showStatus.setText("exception while set full screen : " + e);
			}
		 }
		 else
  		 if (evt.target == lowVol)
		 {
			lowVol.setState(true);
			midVol.setState(false);
			hiVol.setState(false);
			try { 
				player.setVol(33);
			} 		
			catch (PlayerException e) {
			showStatus.setText("exception while set low volume : " + e);
			}
		 }
		 else
  		 if (evt.target == midVol)
		 {
			lowVol.setState(false);
			midVol.setState(true);
			hiVol.setState(false);
			try { 
				player.setVol(66);
			} 		
			catch (PlayerException e) {
			showStatus.setText("exception while set medium volume : " + e);
			}
		 }
		 else
  		 if (evt.target == hiVol)
		 {
			lowVol.setState(false);
			midVol.setState(false);
			hiVol.setState(true);
			try { 
				player.setVol(100);
			} 		
			catch (PlayerException e) {
			showStatus.setText("exception while set high volume : " + e);
			}
		 }
		 else
 		 if (evt.target == autoStart)
		 {
			if (autoStart.getState())
			{
				optStream.m_autoStart=true;
			}
			else 
			{
				optStream.m_autoStart=false;
			}
		 }
		 else
 		 if (evt.target == autoLoop)
		 {
			if (autoLoop.getState())
			{
				optStream.m_loop=true;
			}
			else 
			{
				optStream.m_loop=false;
			}
		 }
		 else
		 if (evt.target	instanceof MenuItem)	 
		 {
			 if (arg.equals("Load Content"))
			 {
				  Dialog d = new LoadDialog(this);
				  d.show();
				  if (load)
				  {
					try { 
						player.unload ();					
					} 
					catch (PlayerException e) {
					showStatus.setText("exception while unloading: " + e);
					}
					loadMediaFile();
				  }
			 }
			 if (arg.equals("Unload"))
			 {
                  if (player != null)
				  {
					try { 
						showStatus.setText("Player state before unloading: " + player.getState());
						player.unload ();
						load=false;
					} 
					catch (PlayerException e) {
					showStatus.setText("exception while unloading: " + e);
					}
				  }
			 }
			 if (arg.equals("Quit"))
			 {
			      showStatus.setText("Shutting down the java client ...");
                  if (player != null)
				  {
					try { 
						showStatus.setText("Player state before exiting: " + player.getState());
						player.unload ();
						player.term ();
					} 
					catch (PlayerException e) {
					showStatus.setText("exception while unloading: " + e);
					}
				  }
	 
				  System.exit(0);
			 }
			if (arg.equals("Play"))
			{
				  if (load)
				  {

					try { 
						if (player.getState() == Player.ST_PAUSED) player.resume ();
						else player.play();
					} 
					catch (PlayerException e) {
					showStatus.setText("exception while play : " + e);
					}		
				   }
			}
			if (arg.equals("Pause"))
			{
				  if (load)
				  {
					try { 					
						player.pause ();
					} 
					catch (PlayerException e) {
					showStatus.setText("exception while pause : " + e);
					}		
				  }
			}			
			if (arg.equals("Stop"))
			{
				  if (load)
				  {
					try { 					
						player.stop ();
					} 
					catch (PlayerException e) {
					showStatus.setText("exception while stop : " + e);
					}		
				   }
			}		
			if (arg.equals("Network Setting"))
			{
				  n.show();
			}		

     		if (arg.equals("About"))
			{
			      Dialog d = new AboutDialog(this);
				  d.show();
			}
		 }
		 else return false;
		 return true;	 	 
	 }
	 
	 public void addPlayer()
     {
         try {
             player = PlayerFactory.getPlayer ();
         }
         catch ( UnsatisfiedLinkError e ) {
         showStatus.setText(e.getMessage());
         }
         catch ( PlayerException e ) {
         showStatus.setText("Unable to create a Player object: " + e);
         }
         try {
             playerUI = player.getPlayerUI ();
         }
         catch ( PlayerException e ) {
         showStatus.setText("exception in getPlayerUI: " + e);
         }          
     } 

    public void loadMediaFile()
    {
		 try {
			player.load(m_MediaFile,optStream);
         }
         catch ( PlayerException e ) {
         showStatus.setText("Could not load content: " + e);
         }
     }
}

class NetworkSet extends Dialog
{
	Checkbox	tcp,udp;
	TextField	t1,t2;
	public NetworkSet(Frame parent)
	{	
		super(parent,"Network Setting",true);
		Panel p = new Panel();
		p.setBackground(Color.lightGray);
		resize(280,150);
		setResizable(false);		
		p.setLayout(null);		
		Label label1 = new Label("Enter Server Address   :   Port");
		label1.reshape(5,5,200,20);
		p.add(label1);
		t1 = new TextField("161.246.6.118",11);
		t1.reshape(20,30,120,20);
		p.add(t1);
		t2 = new TextField("5000",5);
		t2.reshape(140,30,60,20);
		p.add(t2);
		Button ok = new Button("OK");
		ok.reshape(210,40,50,20);
		p.add(ok);
    	Button preview = new Button("Cancel");
		preview.reshape(210,70,50,20);
		p.add(preview);
		Label label2 = new Label("Transport Protocol");
		label2.reshape(10,60,120,20);
		p.add(label2);
		tcp = new Checkbox("TCP",null,false);
		tcp.reshape(20,70,60,50);
		p.add(tcp);		
		udp  = new Checkbox("UDP",null,true);
		udp.reshape(130,70,80,50);
		p.add(udp);
		add("Center",p);
		OVCPlayer.protocol="vsudp://";
		OVCPlayer.serverName= "161.246.6.118"+":";
		OVCPlayer.portName= "5000"+"/vscontsrv:";
	}

	public boolean action(Event evt,Object arg)
	{
		if (evt.target instanceof Button)
		{
			if (arg.equals("OK"))	 
			{
				if (udp.getState())
				{
					OVCPlayer.protocol="vsudp://";
				}
				else
				{
					OVCPlayer.protocol="vstcp://";
				}
				OVCPlayer.serverName= t1.getText()+":";
				OVCPlayer.portName= t2.getText()+"/vscontsrv:";
				dispose();							
			}		

			if (arg.equals("Cancel")) 
			{
				dispose();
			}
		}
		else 
		if (evt.target instanceof Checkbox)
		{
			if (evt.target.equals(tcp)) 
			{
				tcp.setState(true);
				udp.setState(false);
			}
			else
			if (evt.target.equals(udp)) 
			{
				tcp.setState(false);
				udp.setState(true);
			}
		}
		else return false;
		return true;
	}
}


class AboutDialog extends Dialog
{
	public AboutDialog(Frame parent)
	{
		super(parent,"About the Auther",true);
		Panel p= new Panel();
		p.setBackground(Color.lightGray);
		resize(200,150);
		setResizable(false);		
		p.setLayout(null);
		Label label1 = new Label("Written By");
		label1.reshape(65,15,60,15);
		p.add(label1);
		Label label2 = new Label("Mr.Sivanath Massurang");
		label2.reshape(25,35,140,15);
		p.add(label2);		
		Label label3 = new Label("Mr.Wirat Wasinpiyamongkol");
		label3.reshape(25,55,140,15);
		p.add(label3);		
		Button ok = new Button("OK");
		ok.reshape(65,90,50,20);
		p.add(ok);
		add("Center",p);
	}

	public boolean action(Event evt,Object arg)
	{
		if (arg.equals("OK")) dispose();
		else return false;
		return true;
	}
}

class LoadDialog extends Dialog
{
	Checkbox server,local;
	public LoadDialog(Frame parent)
	{	
		super(parent,"Load Content",true);
		Panel p = new Panel();
		p.setBackground(Color.lightGray);
		resize(320,220);
		setResizable(false);		
		p.setLayout(null);		
		Label label1 = new Label("Enter Content URL : ");
		label1.reshape(5,5,120,20);
		p.add(label1);
		Panel p1 = new Panel();	
		OVCPlayer.list = new List(4,false);
		OVCPlayer.list.reshape(10,30,200,100);
		p1.add("South",OVCPlayer.list);
		p1.reshape(10,30,200,100);
		p.add(p1);
		Button ok = new Button("Fullview");
		ok.reshape(245,45,50,20);
		p.add(ok);
    	Button preview = new Button("Preview");
		preview.reshape(245,75,50,20);
		p.add(preview);
		Button cancel = new Button("Cancel");
		cancel.reshape(245,105,50,20);
		p.add(cancel);		
		Button browse = new Button("Browse");
		browse.reshape(245,155,50,20);
		p.add(browse);
		Label label2 = new Label("Content Query ");
		label2.reshape(10,140,120,20);
		p.add(label2);
		server = new Checkbox("Server",null,true);
		server.reshape(20,150,60,50);
		p.add(server);		
		local  = new Checkbox("Local Disk",null,false);
		local.reshape(130,150,80,50);
		p.add(local);
		add("Center",p);			
	}

	public boolean action(Event evt,Object arg)
	{
		if (evt.target instanceof Button)
		{
			if (arg.equals("Fullview"))	 
			{
				if (OVCPlayer.fromServer)
				{
					OVCPlayer.m_MediaFile=OVCPlayer.protocol+
					OVCPlayer.serverName+OVCPlayer.portName+
					OVCPlayer.list.getSelectedItem();
				}
				else
				{
					OVCPlayer.m_MediaFile=OVCPlayer.list.getSelectedItem();					
				}
				dispose();							
				OVCPlayer.load=true;
			}		

			if (arg.equals("Preview"))	 
			{
				if (OVCPlayer.fromServer)
				{
					OVCPlayer.m_MediaFile=OVCPlayer.protocol+
					OVCPlayer.serverName+OVCPlayer.portName+
					OVCPlayer.clipList.getItem(OVCPlayer.list.getSelectedIndex());

				}
				else
				{
					OVCPlayer.m_MediaFile=OVCPlayer.list.getSelectedItem();					
				}
				dispose();							
				OVCPlayer.load=true;
			}	
			if (arg.equals("Cancel")) 
			{
				dispose();
				OVCPlayer.load=false;
			}
			
			if (arg.equals("Browse")) 
			{	
				OVCPlayer.list.clear();
				OVCPlayer.clipList.clear();
					if (local.getState())
					{
						LoadFileDialog loadFile = new LoadFileDialog();
						if (OVCPlayer.m_Name != null)
						{
							OVCPlayer.list.addItem(OVCPlayer.m_MediaFile);
							OVCPlayer.showStatus.setText(OVCPlayer.m_MediaFile);
							OVCPlayer.fromServer=false;
						}
					}
					if (server.getState())
					{   
						try
						{
							ConnectDB connec = new ConnectDB();
						}
						catch (SQLException e){}
						catch (IOException e) {}
						OVCPlayer.fromServer=true;
					}
				OVCPlayer.list.select(0);		
			}
		}
		else 
		if (evt.target instanceof Checkbox)
		{
			if (evt.target.equals(server)) 
			{
				server.setState(true);
				local.setState(false);
			}
			else
			if (evt.target.equals(local)) 
			{
				server.setState(false);
				local.setState(true);
			}
		}
		else return false;
		return true;
	}
}

class LoadFileDialog 
{
	LoadFileDialog()
	{	
		FileDialog fd = new FileDialog(new Frame(),null,FileDialog.LOAD);
		fd.setDirectory("D:\\MyDocument\\Project");
		fd.setFile("*.mpg");
		fd.setVisible(true); 
		OVCPlayer.m_MediaFile=fd.getDirectory()+fd.getFile();
		OVCPlayer.m_Name=fd.getFile();
	}
}

class ConnectDB 
{
	ConnectDB() throws SQLException, IOException
	{
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		Connection conn =
		DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","ovs","oraclevideoserver");
		Statement stmt = conn.createStatement ();	
		String sql = "select content,clips from  preview";
		ResultSet rset = stmt.executeQuery (sql);	
		while (rset.next ()) 
		{
			OVCPlayer.list.addItem(rset.getString(1));
			OVCPlayer.clipList.addItem(rset.getString(2));
		} 
		conn.close();
	}
}