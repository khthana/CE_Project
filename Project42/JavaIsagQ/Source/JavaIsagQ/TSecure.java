package IsecQ;

import java.awt.*;

public class TSecure extends Frame
{  
	private Panel cards,tabs;
	private CardLayout layout;
	public TextField isecq, firstname, lastname,nickname, email, phone, password, cpassword;
	public TextArea ta1, ta2, ta3, ta4;

      public TSecure()
   	{  	setTitle("Security");
		tabs = new Panel(); 
		tabs.setForeground(Color.black);
		tabs.setBackground(Color.lightGray);
            tabs.setLayout(new FlowLayout());
            tabs.add(new Button(" < "));
		tabs.add(new Button("Security"));
		tabs.add(new Button("Ignore List"));
		tabs.add(new Button("Invisible List"));
		tabs.add(new Button("Visible List"));
		tabs.add(new Button(" > "));
		add("North", tabs);

		cards = new Panel();
		cards.setForeground(Color.black);
		cards.setBackground(Color.lightGray);
		layout = new CardLayout();
		cards.setLayout(layout);
		cards.add("Security", new Sec01("Security"));
		cards.add("Ignore List", new Sec02("Ignore List"));
		cards.add("Invisible List", new Sec03("Invisible List"));
		cards.add("Visible List", new Sec04("Visible List"));
		add("Center", cards);

		Panel p1 = new Panel();
		p1.setForeground(Color.black);
		p1.setBackground(Color.lightGray);
		p1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p1.setLayout(new FlowLayout());
		p1.add(new Button("   OK   "));
		p1.add(new Button("Cancel"));
		add("South", p1);

		resize(400, 300);
            setResizable(false);
            show();

   	}

      public boolean handleEvent(Event evt)
      {	if (evt.id == Event.WINDOW_DESTROY) dispose();
		else return super.handleEvent(evt);
		return true;
      }
   
      public boolean action(Event evt, Object arg)
      {	if (evt.target instanceof Component && 
				 ((Component)evt.target).getParent().equals(tabs))
		{	if (arg.equals(" < "))	layout.previous(cards);
			else if (arg.equals(" > "))  layout.next(cards);
					 else layout.show(cards,  (String)arg);
		}   
		else if (arg.equals("   OK   ") & (password.getText().equals(cpassword.getText())) )
		{	System.out.println(password.getText().equals(cpassword.getText()));
			dispose();	 	return true;
		}
		else if (arg.equals("Cancel"))	{  	System.out.println("false ");		dispose();	 	return true;	}
		else return super.action(evt, arg);
		return false;
	}
      
	public class Sec01 extends Panel
	{	
	Sec01(String name)
	{	Panel pp = new Panel();
		pp.setLayout(new BorderLayout());
	      pp.setForeground(Color.black);
	      pp.setBackground(Color.lightGray);
		pp.add("North", new Label("  "+name));
            Panel pt1 = new Panel(); pt1.add(new Label("         ")); pp.add("West", pt1);
            Panel pt2 = new Panel(); pt2.add(new Label("         ")); pp.add("East", pt2);
            Panel p3 = new Panel();
	 	p3.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p3.setLayout(new GridLayout(2,5,10,10));
            p3.add(new Label("Password:"));
		p3.add(password = new TextField(10));		
		password.setEchoChar('*');
            p3.add(new Label("Confirm Password:"));
		p3.add(cpassword = new  TextField(10));	
		cpassword.setEchoChar('*');
            pp.add("Center", p3);
            add(pp);
      }
	public void paint(Graphics g) 
	{	g.setColor(Color.gray);
		g.drawRect(10, 1, 370, 199);
	}}

	public class Sec02 extends Panel
	{	
	Sec02(String name)
	{	Panel ppp = new Panel();
		ppp.setForeground(Color.black);
	      ppp.setBackground(Color.lightGray);
		ppp.setLayout(new BorderLayout());
		ppp.add("North", new Label("  "+name));
		ta1 = new TextArea(10,50);
		ta1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		ppp.add("Center", ta1);
		add("Center",ppp);
	}
	public void paint(Graphics g) 
	{	g.setColor(Color.gray);
		g.drawRect(10, 1, 370, 199);
	}}

	public class Sec03 extends Panel
	{	
	Sec03(String name)
	{	Panel pppp = new Panel();
		pppp.setForeground(Color.black);
	      pppp.setBackground(Color.lightGray);
		pppp.setLayout(new BorderLayout());
		pppp.add("North", new Label("  "+name));
		ta2 = new TextArea(10, 50);
		ta2.setFont(new Font("DialogInput",Font.PLAIN ,12));
		pppp.add("Center", ta2);
		add("Center",pppp);
	}
	public void paint(Graphics g) 
	{	g.setColor(Color.gray);
		g.drawRect(10, 1, 370, 199);
	}}

	public class Sec04 extends Panel
	{	
	Sec04(String name)
      {	Panel ppppp = new Panel();
		ppppp.setForeground(Color.black);
	      ppppp.setBackground(Color.lightGray);
		ppppp.setLayout(new BorderLayout());
		ppppp.add("North", new Label("  "+name));
		ta3 = new TextArea(10, 50);
		ta3.setFont(new Font("DialogInput",Font.PLAIN ,12));
		ppppp.add("Center", ta3);
		add("Center",ppppp);
	}
	public void paint(Graphics g) 
	{	g.setColor(Color.gray);
		g.drawRect(10, 1, 370, 199);
	}}
	
}
