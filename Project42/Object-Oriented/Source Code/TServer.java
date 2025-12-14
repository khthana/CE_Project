import java.awt.*;
import java.io.*;
import java.net.*;
import java.util.*;
import java.applet.*;
import java.sql.*;

public class TServer extends Frame
{
	public SWServer server;
	protected Thread runner;

	Font f;

	TextArea display;
	Button onClear,onStart,onStop,onExit;

	GridBagLayout gbLayout;
	GridBagConstraints gbConstraints;

	public TServer()
	{
		gbLayout = new GridBagLayout();
		setLayout(gbLayout);
		gbConstraints = new GridBagConstraints();

		onClear   = new Button("Clear");
		onStart   = new Button("Start");
		onStop    = new Button("Stop");
		onExit    = new Button("Exit");
		display	  = new TextArea(20,100);
		display.setEditable(false);

		gbConstraints.fill = GridBagConstraints.BOTH;
		addComponent(display,gbLayout,gbConstraints,0,0,4,1);
		addComponent(onClear,gbLayout,gbConstraints,1,0,1,1);
		addComponent(onStart,gbLayout,gbConstraints,1,1,1,1);
		addComponent(onStop,gbLayout,gbConstraints,1,2,1,1);
		addComponent(onExit,gbLayout,gbConstraints,1,3,1,1);
		

		f = new Font("Dialog",Font.PLAIN,16);
		setBackground(Color.lightGray);
		setFont(f);
		display.setForeground(Color.green);
		display.setBackground(Color.black);

	}

	public void addComponent(Component c,GridBagLayout g,GridBagConstraints gc,int row,int column,int width,int height)
	{
		gc.gridx = column;
		gc.gridy = row;

		gc.gridwidth = width;
		gc.gridheight = height;

		g.setConstraints(c,gc);
		add(c);
	}

	public void onServer()
	{
println("OnStartServer");

		try
		{
			if (server == null)
			{	
				server = new SWServer(5000,this);
				server.start();
println("Run Server OK!");
			}
		}
		catch (Exception ex)
		{
println("Error : " +ex);
			ex.printStackTrace();
		}
	}

	public void onDisServer()
	{
		if (server != null)
			{
				server.Stop();
			}
	}

	public void println(String msg)
	{
		display.appendText(msg +"\n");
	}

	public boolean action(Event evt,Object arg)
	{
		if (evt.arg.equals("Clear"))
		{
			display.setText("");
		}
		if (evt.arg.equals("Start"))
		{
			onServer();
		}
		if (evt.arg.equals("Stop"))
		{
			onDisServer();
		}
		if (evt.arg.equals("Exit"))
		{
			onDisServer();
			System.exit(0);
		}
		return true;
	}

	public boolean handleEvent(Event evt)
	{
		if (evt.id == Event.WINDOW_DESTROY)
		{
			onDisServer();
			System.exit(0);
		}

		return super.handleEvent(evt);
	}

	public static void main(String args[])
	{
		TServer s = new TServer();
		s.setTitle(" Server box");
		s.resize(640,480);
		s.show();
	}
}
//---------------------------------------------------------------
class SWSocketServer extends Object 
{
	int Number;
	String name;
	public Socket socket;
	protected DataInputStream i;
	protected DataOutputStream o;

	SWSocketServer(Socket s) 
	{
		try 
		{
			socket = s;
			i = new DataInputStream(s.getInputStream());
			o = new DataOutputStream(s.getOutputStream());
	    } 
		catch (IOException ex) 
		{}
	}
  
	public String Get() 
	{
		String st;    

		try 
		{
			st = i.readUTF();
		}
		catch (IOException ex)
		{
			ex.printStackTrace();
			st = null;
		}

		return st;
	}
  
	public void Send(String msg) 
	{
		try 
		{
			synchronized (o) 
			{
				o.writeUTF(msg);
				o.flush();
			}
		}
		catch (IOException ex)
		{}
	}

	public void setName(String s)
	{
		name = s;
	}

	public String getName()
	{
		return name;
	}
}
//-----------------------------------------------
class SWServer extends Thread 
{
	public SWMonitor monitor;
    public ServerSocket server;

	TServer main;
  
	SWServer(int port,TServer game)
	{
		main = game;

		try
		{
			server  = new ServerSocket(port);
			monitor = new SWMonitor(main);
		}
		catch(IOException e)
		{}
	}

	public void run() 
	{
		try 
		{
			monitor.StartTalk();
			monitor.start();
			while (true) 
			{
main.println("Server:Waiting...");
				monitor.Connect(server.accept());

			}
		} 
		catch (IOException ex)
		{}
	}
	
	public void Stop() 
	{
		try 
		{
			monitor.Stop();
			server.close();
			this.stop(); 
main.println("Server:Stoped.");
		}
		catch (IOException ex)
		{} 
	}
}
/****************************************************************************************/
//****************************************************************************************
/****************************************************************************************/
//****************************************************************************************
class SWHandler extends Thread 
{
	SWMonitor owner;
	SWSocketServer sw;

	String command,information;
  
	SWHandler(SWMonitor owner,SWSocketServer sw)
	{
		super("SWHandler "+sw.getName());
		this.owner = owner;
		this.sw = sw;
	}
  
	public void run()
	{
		String str;

		while (true) 
		{
owner.main.println("Hanler Waiting...");
			str = sw.Get();
owner.main.println("Handler: receive > " +str +" from " +sw.getName());

// receive command & information from Client
			StringTokenizer st = new StringTokenizer(str,"&&");
			command     = st.nextToken();
			information = st.nextToken();

			if (command.compareTo("GroupDB")==0)
			{
				owner.SendToAll("GroupDB&&" +owner.loadGroupdB(owner.Convert2Thai(information)));
			}
			if (command.compareTo("StartGame") == 0)
			{
				owner.SendToAll("LogPrompt&& ");
				owner.canNotConnect = true;
//				owner.whatFile(information);
				owner.initFile(owner.Convert2Thai(information));

				owner.setFlagName(sw.getName());
				owner.SendToAll("StartGame&&" +sw.getName() +"||" +owner.RandomMap() +"||" +owner.listAllPlayer());
			}
			if (command.compareTo("Dice") == 0)
			{
				owner.SendToAll(str);
			}
			if (command.compareTo("WhoAreAns") == 0)
			{
				owner.SendToAll("WhoAreAns&&" +information +"@@" +owner.OpenRandomFile());
//owner.SendToAll("Question&&" +owner.OpenRandomFile());
			}
			if (command.compareTo("getQuestion") == 0)
			{
				owner.SendToAll("Question&&" +owner.OpenRandomFile());
			}
			if (command.compareTo("Answer") == 0)
			{
				owner.SendToAll("Answer&&" +information);
			}
			if (command.compareTo("NextPlayer") == 0) 
			{
				owner.SendToAll("NextPlayer&&" +owner.NextToPlayer(information));
			}
			if (command.compareTo("Disconnect") == 0) 
			{
				owner.SendToAll("RemoveInfo&&" +sw.getName());
				if (owner.chkFlagName(sw.getName())) owner.SendToAll("NextPlayer&&" +owner.NextToPlayer(sw.getName()));
				owner.Disconnect(sw);
				owner.h.removeElement(this);
				break;
			}
			if (command.compareTo("History") == 0)
			{
				owner.arrangeHistory(information);
			}
			if (command.compareTo("Message") == 0)
			{
				owner.SendToAll("Message&&" +information);
			}
// receive command & information from Client
		}
	}
}
//-----------------------------------------------
class SWMonitor extends Thread 
{
	protected boolean isTalkStart = false;
	protected Vector v = new Vector(); //list of obvious player name
	protected Vector h = new Vector(); //list of handler socket

	public boolean canNotConnect = false;

	int		lineOfQuestion,countQuestion = 0;
	int[]	arrayRandomQuestion;
	String  fileName = "Questions/questions.txt";

	public String FlagName;
	Vector NameList = new Vector();

	TServer main;
	
	SWMonitor(TServer game)
	{
		main = game;
	}
		
	public void Connect(Socket s) 
	{
		if (v.isEmpty()) canNotConnect = false;

		SWSocketServer sw = new SWSocketServer(s);
		SWHandler handler;

		sw.Send("Name?");
		sw.setName(sw.Get());

		boolean canConnect = true;
		// check name hasn't recurrent
		for (int i=0; i<v.size(); i++)
		{
			SWSocketServer sw2 = (SWSocketServer)v.elementAt(i);
			if (sw2.getName().compareTo(sw.getName()) == 0)
			{
main.println("********** Found this name!!");
				sw.Send("NameIsRecur");
				canConnect = false;
			}
	}
	// if game playing can't another player login 
	if (canNotConnect) 
		{
main.println("\n********** Game has Play !!");
			sw.Send("CanNotConnect");
			canConnect = false;
		}

		if ((v.size() < 4) & canConnect)
		{		
			sw.Send("");
			v.addElement(sw);

main.println("\nServer: receive > "+sw.getName());
							
			handler=new SWHandler(this,sw);
			h.addElement(handler);
			handler.start();
			SendStatus();		// send all Player had already login
		}
		else 
		{
main.println("\nServer:> refluse join,game Full!");
			sw.Send("Full!");
			try 
			{
				sw.socket.close();
			}
			catch (IOException ex)
			{}
		}
	}

	public void Disconnect(SWSocketServer sw) 
	{
main.println("Server:"+sw.getName()+" Disconnected");

		v.removeElement(sw);
		try 
		{
			sw.socket.close();
		}
		catch (IOException ex)
		{}

		SendStatus();
	}

	public int NumberOfPlayer()
	{
		return v.size();
	}
	
	public void StartTalk()
	{
		isTalkStart=true;
	}

	public void SendStatus()
	{
		SendToAll("ClassDB&&" +loadClassdB());
		SendToAll("LoginStatus&&" +listAllPlayer());
	}

	public void setFlagName(String flag)
	{
		FlagName = flag;
	}

	public boolean chkFlagName(String flag)
	{
		boolean temp = false;
//main.println("* + * + * + * " +FlagName +" : " +flag);
		
if (canNotConnect) 
		if (FlagName.compareTo(flag) == 0) temp = true;

		return temp;
	}

	public String listAllPlayer()
	{
		String str = "";

		for(int i=0; i<v.size(); i++) 
		{
			SWSocketServer sw = (SWSocketServer)v.elementAt(i);
			str = str + sw.getName();

			if (i+1 != v.size()) str = str + "@@";
//* + * + * + * + * + * + * + * + * + *
NameList.addElement(sw.getName());
		}
		return str;
	}

	public String loadClassdB()
	{
		String DB = "",DB2 = "";
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
			ResultSet rs1 = condB.query("SELECT Class FROM Index GROUP BY Class");

			boolean bb = rs1.next();
			while (bb)
			{
				DB += rs1.getString(1);
				bb = rs1.next();
				if (bb == true) DB += "|";
			}

			StringBufferInputStream in = new StringBufferInputStream(DB);
			InputStreamReader rin = new InputStreamReader(in);
			LineNumberReader  lin = new LineNumberReader(rin);

			DB2 += lin.readLine();

			in.close();
			
			rs1.close();
			condB.close();
		}
		catch (Exception ex) {}
		return DB2;
	}

	public String loadGroupdB(String classdB)
	{
		String DB = "",DB2 = "";

		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
			ResultSet rs1 = condB.query("SELECT Group FROM Index WHERE [Class] = " +"'" +classdB +"'");

			boolean bb = rs1.next();
			while (bb)
			{
				DB += rs1.getString(1);
				bb = rs1.next();
				if (bb == true) DB += "|";
			}

			StringBufferInputStream in = new StringBufferInputStream(DB);
			InputStreamReader rin = new InputStreamReader(in);
			LineNumberReader  lin = new LineNumberReader(rin);

			DB2 += lin.readLine();

			in.close();
			
			rs1.close();
			condB.close();
		}
		catch (Exception ex) {}
		return DB2;
	}

	private String TableName,DB = "";
	Vector classDB = new Vector();
	Vector groupDB = new Vector();

/*	public void whatFile(String typeOfFile)
	{
		if (typeOfFile.compareTo("0")==0)		TableName = "Science1";
		else if (typeOfFile.compareTo("1")==0)	TableName = "Science2";
		else if (typeOfFile.compareTo("2")==0)	TableName = "English";
		else if (typeOfFile.compareTo("3")==0)	TableName = "ArtStrength";
		else if (typeOfFile.compareTo("4")==0)	TableName = "Social";
		else if (typeOfFile.compareTo("5")==0)	TableName = "MoralBuddhist";

		initFile();
	}
*/
	public void initFile(String Table)
	{
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
			ResultSet rs1 = condB.query("SELECT *  FROM [" +Table +"] ORDER BY problem");

			boolean bb = rs1.next();
			while (bb)
			{
				DB += rs1.getString(1) +"|" +rs1.getString(2) +"|" +rs1.getString(3) +"|" +rs1.getString(4) +"|" +rs1.getString(5)+"|" +rs1.getString(6);
				bb = rs1.next();
				if (bb == true) DB += "\n";
				lineOfQuestion++;
			}
			rs1.close();
			condB.close();
		}
		catch (SQLException ex) { main.println("init : " +ex); }

		try
		{
			FileOutputStream	out = new FileOutputStream("Question.dat");
			DataOutputStream   dout = new DataOutputStream(out);

			dout.writeBytes(DB);
			
			dout.close();
		}
		catch (Exception ex) { main.println("toFile : " +ex); }

		arrayRandomQuestion = new int[lineOfQuestion];
		for (int i=0; i >=arrayRandomQuestion.length; i++)
		{
			arrayRandomQuestion[i] = 0;
		}
	}

	public String OpenRandomFile()
	{
		String s = "|||||";

		try 
		{
			FileInputStream    in = new FileInputStream("Question.dat");
			InputStreamReader rin = new InputStreamReader(in);
			LineNumberReader  lin = new LineNumberReader(rin);

			countQuestion = (int)(Math.random()*lineOfQuestion);
			while (arrayRandomQuestion[countQuestion] == 1) 
			{
				countQuestion = (int)(Math.random()*lineOfQuestion);
			}
			arrayRandomQuestion[countQuestion] = 1;
			countQuestion++;

			for (int i=0; i<countQuestion; i++) 
			{
				s = lin.readLine();
			}
		}
		catch (Exception ex){ main.println("Open : " +ex); }
		return s;
	}
//************************************************************************************
	public String Convert2Thai(String text) 
	{
		StringBuffer buffer = new StringBuffer();
		
	 	for (int i=0; i<text.length(); i++)
		{
			int c = (int)text.charAt(i);
			if (c > 255)
			{
				c -=3424;
				buffer.append((char)c);
			}
			else buffer.append((char)c);
		}

		return buffer.toString().trim();
	}

	public String ReadHistoryFile()
	{
		String s = "",s2 = null;

		try 
		{
			FileInputStream    in = new FileInputStream("History.dat");
			InputStreamReader rin = new InputStreamReader(in);
			LineNumberReader  lin = new LineNumberReader(rin);

			s2 = lin.readLine();
			if (s2 != null) s = s2;
		}
		catch (Exception ex)
		{
main.println(" " +ex);
		}
		return s;	//.substring(1);
	}

	public void WriteHistoryFile(String history)
	{
		try 
		{
			FileOutputStream	out = new FileOutputStream("History.dat");
			DataOutputStream   dout = new DataOutputStream(out);

			dout.writeBytes(Convert2Thai(history));
			dout.close();
		}
		catch (Exception ex)
		{
main.println(" " +ex);
		}
	}

	Vector RofHis	= new Vector();
	Vector RofHisN	= new Vector();

	public void arrangeHistory(String newHistory)
	{
		boolean chk = false;

		StringTokenizer st = new StringTokenizer(newHistory,"@@");
		// new history
		while (st.hasMoreTokens())
		{
			RecordOfHistory R = new RecordOfHistory();

			StringTokenizer st2 = new StringTokenizer(st.nextToken(),"||");
			R.setName(st2.nextToken());
			R.setScore(st2.nextToken());

			RofHisN.addElement(R);
		}

		StringTokenizer st3 = new StringTokenizer(ReadHistoryFile(),"@@");
		// history before update (it's come from file)
		while (st3.hasMoreTokens())
		{
			RecordOfHistory R = new RecordOfHistory();

			StringTokenizer st4 = new StringTokenizer(st3.nextToken(),"||");
			R.setName(st4.nextToken());
			R.setScore(st4.nextToken());

			RofHis.addElement(R);
		}

		RecordOfHistory RO = new RecordOfHistory();
		RecordOfHistory RN = new RecordOfHistory();

		for (int i=0; i<RofHisN.size(); i++)
		{
			RN = (RecordOfHistory)RofHisN.elementAt(i);
			chk = false;
			for (int j=0; j<RofHis.size(); j++)
			{
				if (RN.getScore().substring(0,1).compareTo("-")==0) break;
				RO = (RecordOfHistory)RofHis.elementAt(j);
			// if counter of char > then insert new history
				if (RN.getScore().length() > RO.getScore().length())
				{
					RofHis.insertElementAt(RN,j);
					break;
				}
			// if counter of char = then chk each character
				else if (RN.getScore().length() == RO.getScore().length())
				{
				// if compare score
					if (RN.getScore().compareTo(RO.getScore())==0)
					{
						RofHis.insertElementAt(RN,j);
						break;
					}
					else
					{
						for (int k=0; k<RN.getScore().length(); k++)
						{
							if (RN.getScore().substring(k,k+1).compareTo(RO.getScore().substring(k,k+1)) > 0)
							{
									RofHis.insertElementAt(RN,j);
									chk = true;
									break;
							}
							else if (RN.getScore().substring(k,k+1).compareTo(RO.getScore().substring(k,k+1)) < 0) break;
						}
						if (chk) break;
					}
				}
			// if counter of char < then Nothing
			}
		}

String history = "";

for (int i=0; i<RofHis.size(); i++)
{
	RecordOfHistory R = (RecordOfHistory)RofHis.elementAt(i);

	if (i <= 9)
	{
		history += R.getName() +"||" +R.getScore();
		if (i+1 != RofHis.size() & i<9) history +="@@";
	}
//main.print(R.getName());
//main.println("\t" +R.getScore());
}
main.println(history);
WriteHistoryFile(history);
SendToAll("History&&" +history);
	}

	public String RandomMap()
	{
		int temp = 0;
		String arrangeMap = "";
		int[]	randomMap = new int[32];

		// initial all block to "Normal block"
		for(int i=0; i < 32; i++)
		{
			randomMap[i] = 0;
		}
		// set block number 0(0-31) to "Bonus block"
		randomMap[0] = 2;
		// set block number 16(0-31) to "Death block"
		randomMap[16] = 3;
		// random for 15 block to "Question block"
		for (int i=0; i<15; i++)
		{
			while ( temp == 0 | temp < 2 | temp > 29 | temp == 16)
			{
				temp = (int)(Math.random() * 32);
			}
			// if it has question "*_*" or "**_" or "_**" not random question 
			if ((randomMap[temp] == 1) |
 			   ((randomMap[temp -1] == 1) & (randomMap[temp +1] == 1 )) |
			   ((randomMap[temp +1] == 1) & (randomMap[temp +2] == 1 )) |
			   ((randomMap[temp -1] == 1) & (randomMap[temp -2] == 1 )) )
			{
				i--;
			}
			else randomMap[temp] = 1;
		temp = 0;
		}

		for(int i=0; i<32; i++)
		{
			arrangeMap = arrangeMap + randomMap[i];
			if (i+1 != 32) arrangeMap = arrangeMap + "@@";
		}
		return arrangeMap;
	}

	public String NextToPlayer(String oldPlayer)
	{
		String temp = oldPlayer;
		SWSocketServer sw;
		for(int i=0; i<v.size(); i++) 
		{
			sw = (SWSocketServer)v.elementAt(i);
			if (sw.getName().compareTo(oldPlayer) == 0) 
			{
				if (i+1 < v.size()) sw = (SWSocketServer)v.elementAt(i+1);
				else sw = (SWSocketServer)v.elementAt(0);
				temp = sw.getName();
			}
		}

		setFlagName(temp);
		return temp;
	}

	public void run() 
	{
		SWSocketServer sw;
		String str;
		SWHandler handler;
		while (true) 
		{
			while (isTalkStart) 
			{
				try 
				{
					wait(10000);
				}
				catch (Exception ex) 
				{}
			}
		} 
	}
	
	public void SendToAll(String msg)
	{
		for(int i=0; i<v.size(); i++) 
		{
			SWSocketServer sw = (SWSocketServer)v.elementAt(i);
			sw.Send(msg);
main.println("SWMonitor sending all> "+msg);
		}
	}

	public void Stop() 
	{
		try 
		{
			for(int i=0; i<v.size(); i++) 
			{
				SWSocketServer sw = (SWSocketServer)v.elementAt(i);
				sw.Send("Stoped!");
				sw.socket.close();
			}  
			for(int i=0; i<h.size(); i++) 
			{
				SWHandler handler = (SWHandler)h.elementAt(i);
				handler.stop();
			}

			this.stop();
		} 
		catch ( IOException ex) 
		{}
	}
}
/****************************************************************************************/
//****************************************************************************************
/****************************************************************************************/
//****************************************************************************************
class RecordOfHistory
{
	String		name;
	String		score;

	public void setName(String n)
	{
		name = n;
	}

	public String getName()
	{
		return name;
	}

	public void setScore(String s)
	{
		score = s;
	}

	public String getScore()
	{
		return score;
	}
}

class Connect 
{
	private Statement stmt;
	private ResultSet result;
	private Connection con;
	private int ct;
	
	public Connect() 
	{}

	public void connected(String db_name) 
	{
		try 
		{
			// connect to ODBC database
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			String url = "jdbc:odbc:" + db_name;

			// connect
			con = DriverManager.getConnection(url);
			stmt = con.createStatement();
		}
		catch (Exception e) 
		{
			System.err.println("You found error in connected(String ) METHOD : " + e.getMessage());
		}
	}

	public ResultSet query(String s) throws SQLException 
	{
		try 
		{
			result = stmt.executeQuery(s);
		}
		catch (SQLException e) 
		{
			System.err.println("You found error in query METHOD : " + e.getMessage());
		}
		return result;
	}

	public synchronized int update(String s) throws SQLException 
	{
		try 
		{
			ct = stmt.executeUpdate(s);
		}
		catch (SQLException e) 
		{
			System.err.println("You found error in update METHOD : " + e.getMessage());
		}
		return ct;
	}

	public void close() throws SQLException 
	{
		try 
		{
			result.close();
			stmt.close();
			con.close();
		}
		catch (SQLException e) 
		{
			System.err.println("You can't close Connect package. Because Query maybe false : " + e.getMessage());
		}
	}
}
