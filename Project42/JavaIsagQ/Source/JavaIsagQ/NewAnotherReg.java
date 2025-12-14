package IsecQ;

import java.awt.*;

public class NewAnotherReg extends Frame
{	private TextField	isecq, firstname, lastname, nickname, email, 
								city ,ctcode ,ctstatus ,state ,age ,sex ,phone ,homepage ;
	private TextArea  about ; 

	IsagQ isagq;
	ServerConnect sconnect;

      public NewAnotherReg(IsagQ isagq ,ServerConnect sconnect)
      {	setTitle("NewAnotherReg");
		this.isagq = isagq;
		this.sconnect = sconnect;
	      this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
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
            p2_2.add(new Button("   Register   "));
            p2_2.add(new Button("   Cancel   "));
		p2.add("South" ,p2_2);
        add("South", p2);
		Panel p3 = new Panel();		p3.add(new Label("   "));		add("West", p3);
		Panel p4 = new Panel();		p4.add(new Label("   "));		add("East",  p4);
	}
  
	public boolean handleEvent(Event evt)
	{	if (evt.id == Event.WINDOW_DESTROY) { dispose(); return true; }
	    if ("   Register   ".equals(evt.arg))
		{	dispose();
		}	
		else if ("   Cancel   ".equals(evt.arg)) dispose();
        else return super.handleEvent(evt);
	    return true;
	}
}