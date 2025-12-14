package IsecQ;

import java.awt.*;
import java.io.*;
import IsecQ.ReadDataLine;

public class AddInfo extends Frame 
{	public TextField isecq, firstname, lastname, nickname, email, phone; 
   
	public AddInfo()
	{	setTitle("AddInfo");
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
		//------------------------------------------------------------------------
		// set Frame Addinfo & Field all.
            //------------------------------------------------------------------------
		Panel p1 = new Panel();		p1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p1.setLayout(new GridLayout(7, 2, 0, 4));
		p1.add(new Label("IsecQ#"));		      p1.add(isecq = new TextField());
		p1.add(new Label("First Name:"));		p1.add(firstname = new TextField());
		p1.add(new Label("Last Name:"));		p1.add(lastname = new TextField());
		p1.add(new Label("Nick Name:"));		p1.add(nickname = new TextField());
		p1.add(new Label("Email:"));     		p1.add(email = new TextField());
		p1.add(new Label("Phone:"));    		p1.add(phone = new TextField());
		add("Center", p1);
		Panel p2 = new Panel();	 	p2.setFont(new Font("DialogInput",Font.PLAIN ,12));
            p2.setLayout(new FlowLayout());
            p2.add(new Button("   OK   "));
            p2.add(new Button("Cancel"));
            add("South", p2);
		Panel p3 = new Panel();		p3.add(new Label("      "));		add("West", p3);
		Panel p4 = new Panel();		p4.add(new Label("      "));		add("East",  p4);
		//------------------------------------------------------------------------
		try
		{	ReadDataLine r = new ReadDataLine();
			isecq.setText(r.ret(1, "test.zzz"));
			firstname.setText(r.ret(3, "test.zzz"));
			lastname.setText(r.ret(4, "test.zzz"));
			nickname.setText(r.ret(2, "test.zzz"));
			email.setText(r.ret(5, "test.zzz"));
			//--------------------------------------------------------------------
			// print show to output. 
			//--------------------------------------------------------------------
			System.out.println(isecq.getText());
			System.out.println(firstname.getText());
			System.out.println(lastname.getText());
			System.out.println(nickname.getText());
			System.out.println(email.getText());
			//--------------------------------------------------------------------
		}
		catch (IOException e) {	 System.out.println(e);	}
		
		pack();            setResizable(false);            show();
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
		}	else if ("Cancel".equals(evt.arg)) dispose();
		            else return super.handleEvent(evt);
	      return true;	
	}
}