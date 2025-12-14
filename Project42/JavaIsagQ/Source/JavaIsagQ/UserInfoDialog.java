package IsecQ;

import java.awt.*;
import java.io.*;

public class UserInfoDialog extends Frame 
{	private TextField	isecq, firstname, lastname, nickname, email, 
								city ,ctcode ,ctstatus ,state ,age ,sex ,phone ,homepage ;
	private TextArea  about ; 
	private 	UserExtInfo uextinfo =new UserExtInfo();

	public UserInfoDialog()
	{	setTitle("User Information");
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
		//------------------------------------------------------------------------
		// set Frame Addinfo & Field all.
            //---------------------------------------------------------------------
		Panel p1 = new Panel();		p1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p1.setLayout(new GridLayout(13, 2));
		p1.add(new Label("IsagQ#"));				p1.add(isecq = new TextField(""));
		p1.add(new Label("Nick Name:"));		p1.add(nickname = new TextField(""));
		p1.add(new Label("First Name:"));		p1.add(firstname = new TextField(""));
		p1.add(new Label("Last Name:"));		p1.add(lastname = new TextField(""));
		p1.add(new Label("Email:"));				p1.add(email = new TextField(""));
		p1.add(new Label("City:"));					p1.add(city = new TextField(""));
		p1.add(new Label("Country Code:"));	p1.add(ctcode = new TextField(""));
		p1.add(new Label("Country Status:"));	p1.add(ctstatus = new TextField(""));
		p1.add(new Label("State:"));     			p1.add(state = new TextField(""));
		p1.add(new Label("Age:"));     			p1.add(age = new TextField(""));
		p1.add(new Label("Sex:"));     			p1.add(sex = new TextField(""));
		p1.add(new Label("Phone:"));     		p1.add(phone = new TextField(""));
		p1.add(new Label("Homepage:"));     p1.add(homepage = new TextField(""));

		add("Center", p1);
		Panel p2 = new Panel();	 	p2.setFont(new Font("DialogInput",Font.PLAIN ,12));
            p2.setLayout(new BorderLayout());
			Panel p2_1= new Panel();
			p2_1.setLayout(new FlowLayout());
			p2_1.add(new Label("   "));
			p2_1.add(new Label("About:"));    			
			p2_1.add(about = new TextArea("" ,5 ,30));
		p2.add("Center" ,p2_1);
			Panel p2_2= new Panel();
			p2_2.setLayout(new FlowLayout());
            p2_2.add(new Button("   Close   "));
		p2.add("South" ,p2_2);
        add("South", p2);
		Panel p3 = new Panel();		p3.add(new Label("   "));		add("West", p3);
		Panel p4 = new Panel();		p4.add(new Label("   "));		add("East",  p4);
		//------------------------------------------------------------------------
		//--------------------------------------------------------------------
		// print show to output. 
		//--------------------------------------------------------------------
/*		System.out.println(isecq.getText());
		System.out.println(firstname.getText());
		System.out.println(lastname.getText());
		System.out.println(nickname.getText());
		System.out.println(email.getText());
*/		//--------------------------------------------------------------------
		pack();
		setResizable(false);
		setVisible(true);
	}

	public void setUserInfo(UserInfo uinfo ,ServerConnect sconnect)
	{	try
		{		sconnect.SearchExtInfo(uinfo.getUIN());
		}catch (IOException e)
		{	System.out.println("IOException "+e);
		}
		while(true)
		{	try
			{	Thread.sleep(10);
			}
			catch (InterruptedException i)
			{	System.out.print("InterruptedException "+i);
			}
			if (sconnect.foundExtInfo())
			{	uextinfo = sconnect.getExtInfo();
				break;
			}
		}
		isecq.setText(Integer.toString(uinfo.getUIN()));
		nickname.setText(uinfo.getNick());
		firstname.setText(uinfo.getFirst());
		lastname.setText(uinfo.getLast());
		email.setText(uinfo.getEmail());
		city.setText(uextinfo.getCity());
		ctcode.setText(uextinfo.getCountryCode()+"");
		ctstatus.setText(uextinfo.getCountryStatus()+"");
		state.setText(uextinfo.getState());
		String agestr="";
		if (uextinfo.getSex() == (short)0xffff)
		{	agestr ="N/A";
		}
		else agestr=uextinfo.getAge()+"";
		age.setText(agestr);
		String sexstr="" ;
		if (uextinfo.getSex() == 0)
		{	sexstr ="N/A";
		}
		else if(uextinfo.getSex() == 1)
		{	sexstr = "Female";
		}
		else if(uextinfo.getSex() == 2)
		{	sexstr = "Male";
		}
		sex.setText(sexstr);
		phone.setText(uextinfo.getPhone());
		homepage.setText(uextinfo.getHomepage());
		about.append(uextinfo.getAbout());
	}// end setUserInfo(UserInfo uinfo ,ServerConnect sconnect)

	public void setUserInfo(UserAllInfo uallinfo ,ServerConnect sconnect)
	{	try
		{		sconnect.SearchExtInfo(uallinfo.getUIN());
		}catch (IOException e)
		{	System.out.println("IOException "+e);
		}
		while(true)
		{	try
			{	Thread.sleep(10);
			}
			catch (InterruptedException i)
			{	System.out.print("InterruptedException "+i);
			}
			if (sconnect.foundExtInfo())
			{	uextinfo = sconnect.getExtInfo();
				uallinfo.UserExtInfo(uextinfo);
				break;
			}
		}
		isecq.setText(Integer.toString(uallinfo.getUIN()));
		nickname.setText(uallinfo.getNick());
		firstname.setText(uallinfo.getFirst());
		lastname.setText(uallinfo.getLast());
		email.setText(uallinfo.getEmail());
		city.setText(uallinfo.getCity());
		ctcode.setText(uallinfo.getCountryCode()+"");
		ctstatus.setText(uallinfo.getCountryStatus()+"");
		state.setText(uallinfo.getState());
		String agestr="";
		if (uallinfo.getSex() == (short)0xffff)
		{	agestr ="N/A";
		}
		else agestr=uallinfo.getAge()+"";
		age.setText(agestr);
		String sexstr="" ;
		if (uallinfo.getSex() == 0)
		{	sexstr ="N/A";
		}
		else if(uallinfo.getSex() == 1)
		{	sexstr = "Female";
		}
		else if(uallinfo.getSex() == 2)
		{	sexstr = "Male";
		}
		sex.setText(sexstr);
		phone.setText(uallinfo.getPhone());
		homepage.setText(uallinfo.getHomepage());
		about.append(uallinfo.getAbout());
	}
	
	public static void main(String arg[])
	{	Frame f = new UserInfoDialog();
	}

	public boolean handleEvent(Event evt)
	{	if (evt.id == Event.WINDOW_DESTROY) { dispose(); return true; }
		if ("   OK   ".equals(evt.arg)) 
		{	System.out.println("------------------Output-------------------");
			System.out.println(isecq.getText());		
			System.out.println(firstname.getText());
			System.out.println(lastname.getText());
			System.out.println(nickname.getText());
			System.out.println(email.getText());
			System.out.println(phone.getText());
			System.out.println("----------------End Output---------------");
			dispose();
		}	else if ("   Close   ".equals(evt.arg)) dispose();
		            else return super.handleEvent(evt);
	      return true;	
	}
}