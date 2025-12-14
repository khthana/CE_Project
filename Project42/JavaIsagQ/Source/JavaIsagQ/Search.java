 package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
*/
import java.awt.*;
import java.io.*;
import java.util.Vector;
import IsecQ.*;
public class Search extends Frame
{	TextField email_field ,nick_field, first_field, last_field, icq_field;
	int field_len=15;
//	TextArea tx1;
	Label			email_label	= new Label("         Email:");
	Label			nick_label	= new Label("         Nick Name:");
	Label			first_label		= new Label("         First Name:");
	Label			last_label		= new Label("         Last Name:");
	Label			icq_label		= new Label("         ICQ#: ");
	CheckboxGroup cg		= new CheckboxGroup();
	Checkbox	c1				= new Checkbox("   Search by Email:", cg, false);
	Checkbox	c2				= new Checkbox("   Search by any of the following parameters:", cg, true);
	Checkbox	c3				= new Checkbox("   Search by ICQ Number(UIN):", cg, false);
	Button			search			= new Button("     Search      ");
	Button			stop				= new Button(" Stop Search ");
	Button			newSearch	= new Button(" New Search ");
	Button			addUser		= new Button("  Add User  ");
	Button			info				= new Button("      Info      ");
	Button			close			= new Button("    Close    ");
	List				searchList	= new List(8 ,false);
	ServerConnect				sconnect;
	CheckSearchResultThread	checkSearchResult;
	Vector foundUserVector=new Vector();

	UserAllInfo[] usrArr ;
//	int num_remoteUIN;
	IsagQ isagq;

	public Search(IsagQ isagq)
	{	setTitle("Search");
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
		this.sconnect = isagq.getServerConnect();
//		this.usrArr = usrArr;
//		this.num_remoteUIN = isagq.getNumRemoteUIN();
		this.isagq = isagq;

		Panel p1 = new Panel();
		p1.setFont(new Font("DialogInput",Font.PLAIN ,10));
		p1.setLayout(new BorderLayout());
			Panel tp1 = new Panel();
			tp1.setLayout(new BorderLayout());
			tp1.add("North", c1);
			tp1.add("West", email_label);
			tp1.add("Center", email_field = new TextField(field_len));
			tp1.add("East",new Label("                           "));
			p1.add("North", tp1);
			Panel tp2 = new Panel();
			tp2.setLayout(new BorderLayout());
			tp2.add("North", c2);
			tp2.add("West", nick_label);
			tp2.add("Center", nick_field = new TextField(field_len));
			tp2.add("East",new Label("                           "));
			p1.add("Center", tp2);
			Panel tp3 = new Panel();
			tp3.setLayout(new BorderLayout());
			tp3.add("West", first_label);
			tp3.add("Center", first_field = new TextField(field_len));
			tp3.add("East",new Label("                           "));
			p1.add("South", tp3);
		add("North", p1);

		Panel p2 = new Panel();
		p2.setFont(new Font("DialogInput",Font.PLAIN ,10));
		p2.setLayout(new BorderLayout());
			Panel tp4 = new Panel();
			tp4.setLayout(new BorderLayout());
			tp4.add("West", last_label);
			tp4.add("Center", last_field = new TextField(field_len));
			tp4.add("East",new Label("                           "));
			p2.add("North", tp4);
			Panel tp5 = new Panel();
			tp5.setLayout(new BorderLayout());
			tp5.add("North", c3);
			tp5.add("West", icq_label);
			tp5.add("Center", icq_field = new TextField(field_len));
			tp5.add("East",new Label("                           "));
			p2.add("South", tp5);
		add("Center", p2);

		Panel p3 = new Panel();
		p3.setFont(new Font("DialogInput",Font.PLAIN ,10));
		p3.setLayout(new BorderLayout());
			Panel p4 = new Panel();
			p4.setLayout(new FlowLayout());
			p4.add(search);
			p4.add(stop);
			p4.add(newSearch);
		p3.add("North", p4);
			Panel p6 = new Panel();
			p6.setLayout(new BorderLayout());
			p6.add("North",searchList);
				Panel p7 = new Panel();
				p7.setLayout(new FlowLayout());
				p7.add(addUser);
				p7.add(info);
				p7.add(close);
			p6.add("Center",p7 );
		p3.add("South", p6);
		add("South", p3);

		email_field.setEnabled(false);	
		nick_field.setEnabled(true);
		first_field.setEnabled(true);	
		last_field.setEnabled(true);	
		icq_field.setEnabled(false);	
   		pack();
		setVisible(true);
		setResizable(true);
   }
   
   public boolean handleEvent(Event evt)
   {  if (evt.id == Event.WINDOW_DESTROY) dispose();
		else return super.handleEvent(evt);
	  return true;
   }
   
   public boolean action(Event evt, Object arg)
   { if (evt.target instanceof Checkbox)
	{	boolean b1 = c1.getState();
		boolean b2 = c2.getState();
		boolean b3 = c3.getState();
		if (b1)
		{	email_field.setText("");	nick_field.setText("");	first_field.setText("");
			last_field.setText("");	icq_field.setText("");//	tx1.setText("");	
			email_field.setEnabled(true);		nick_field.setEnabled(false);
			first_field.setEnabled(false);		last_field.setEnabled(false);
			icq_field.setEnabled(false);
		}else if (b2)
			{	email_field.setText("");	nick_field.setText("");	first_field.setText("");
				last_field.setText("");	icq_field.setText("");//	tx1.setText("");
				email_field.setEnabled(false);		nick_field.setEnabled(true);
				first_field.setEnabled(true);		last_field.setEnabled(true);
				icq_field.setEnabled(false);
			}else if (b3)
				{	email_field.setText("");	nick_field.setText("");	first_field.setText("");
					last_field.setText("");	icq_field.setText("");
					email_field.setEnabled(false);		nick_field.setEnabled(false);
					first_field.setEnabled(false);		last_field.setEnabled(false);
					icq_field.setEnabled(true);
				}
	} 

	if (arg.equals("     Search      "))
		{	try
			{
				boolean b1 = c1.getState();
				boolean b2 = c2.getState();
				boolean b3 = c3.getState();

				if (b1)
				{	sconnect.SearchUser(email_field.getText() ,"" ,"" ,"");
				}
				else if (b2)
				{	sconnect.SearchUser("" ,nick_field.getText() ,first_field.getText() ,last_field.getText());
				}
				else if (b3)
				{	sconnect.SearchUIN(Integer.parseInt(icq_field.getText()));
				}
				checkSearchResult = new CheckSearchResultThread(sconnect , this);
				checkSearchResult.start();
				searchStop = false;
				search.setEnabled(false);
			}// end try
			catch (IOException e)
			{	System.err.println("IOException "+e);
			}
		}
		else if (arg.equals(" Stop Search ")){ checkSearchResult.stop(); searchStop = true;}
		else if (arg.equals(" New Search "))
		{	email_field.setText("");	nick_field.setText("");	first_field.setText("");
			last_field.setText("");	icq_field.setText("");//	tx1.setTe;
			search.setEnabled(true);
			searchList.removeAll();
			foundUserVector.removeAllElements();
			
		}	
		else if (arg.equals("  Add User  ")) 
		{	UserInfo u =(UserInfo)foundUserVector.elementAt(searchList.getSelectedIndex());
			AddNewUserNotify addNotify =new AddNewUserNotify(this ,u.getUIN());
			isagq.addRemoteUIN(u);
			try
			{	sconnect.addToList(u.getUIN());
			}
			catch (IOException e)
			{	System.out.println("IOException "+e);
			}
		}
		else if (arg.equals("      Info      "))
		{	//System.out.println("item select "+searchList.getSelectedIndex());
			UserInfo u =(UserInfo)foundUserVector.elementAt(searchList.getSelectedIndex());
			//System.out.println("select uin" +u.getUIN());
			UserInfoDialog uinfoDialog = new UserInfoDialog();
			uinfoDialog.setUserInfo(u ,sconnect);
		}
		else if (arg.equals("    Close    ")) 
		{	if (!searchStop)
			{	checkSearchResult.stop();
			}
			dispose();
		}
		else return super.action(evt, arg);
		return true;
	}// end action

	private boolean searchStop = true;

	public List getSearchList(){return searchList;}

	public void addFoundUser(UserInfo uinfo)
	{	foundUserVector.addElement(uinfo);
		UserInfo u = new UserInfo();
		for (int i = 0 ;i <foundUserVector.size() ; i++)
		{	u = (UserInfo)foundUserVector.elementAt(i);
//			System.out.println("n: "+i+"  "+u.getUIN());
		}
	}


/*
   public static void main(String[] args)
   {	Frame f = new Search();
   		f.pack();
//		f.resize(500,500);
		f.setVisible(true);
		f.setResizable(true);
   }
*/
}