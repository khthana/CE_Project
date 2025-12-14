package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
*/
import java.awt.*;
import java.net.*;
import java.io.*;

public class OldAnotherReg extends Frame
{
	IsagQ isagq;
	ServerConnect sconnect;

	public OldAnotherReg(IsagQ isagq ,ServerConnect sconnect)
   {  setTitle("OldAnotherReg");
		this.isagq = isagq;
		this.sconnect = sconnect;
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);			
		Panel p1 = new Panel();
		p1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p1.setLayout(new FlowLayout());
		p1.add(new Label("Isec#"));
		isecq = new TextField(15);
		p1.add(isecq);
		add("North", p1);

		Panel p2 = new Panel();
		p2.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p2.setLayout(new FlowLayout());
		p2.add(new Label("Password:"));
		password = new TextField("" ,8);
		password.setEchoChar('*');
		p2.add(password);
		add("Center", p2);

		Panel p3 = new Panel();
		p3.setFont(new Font("DialogInput",Font.PLAIN ,12));
        p3.setLayout(new FlowLayout());
        p3.add(new Button("  Yes  "));
        p3.add(new Button("  No   "));
        add("South", p3);

		resize(200, 120);
		setResizable(false);
        show();
   }
   
   public boolean handleEvent(Event evt)
   {  if (evt.id == Event.WINDOW_DESTROY) dispose();
		else return super.handleEvent(evt);
	  return true;
   }
   
   public boolean action(Event evt, Object arg)
   {  if (arg.equals("  Yes  ")) 
		{	UserAllInfo newUser =new UserAllInfo();
			newUser.setPWD(password.getText());
			UserAllInfo[] userDummy = new UserAllInfo[0];
			try
			{	newUser.UserOnlineInfo(isagq.createMyInfo(Integer.parseInt(isecq.getText())));
				sconnect.login(newUser ,userDummy ,0);
			}
			catch (UnknownHostException un)
			{	System.err.println("OldAnotherReg "+un);
			}
			catch (IOException io)
			{	System.err.println("OldAnotherReg "+io);
			}
			
			if (sconnect.canlogin())
			{	isagq.addOwner(newUser);
				isagq.setTitle(Integer.toString(newUser.getUIN()));		
			}
			else new PwdError(this);

			dispose();
		}
      else if (arg.equals("  No   ")) dispose();
      else return super.action(evt, arg);
      return true;
   }
   
/*	public static void main(String[] args)
   {  Frame f = new OldAnotherReg();
      f.resize(200, 120);
		f.setResizable(false);
      f.show();
   }*/
	 private TextField isecq, password;
}


