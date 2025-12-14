package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
*/
import java.awt.*;
import java.net.*;
import java.io.*;

public class RemoveUser extends Dialog
{
	IsagQ isagq;
	UserAllInfo[] owneruser;
	int num_owner;

	public RemoveUser(IsagQ isagq ,UserAllInfo[] owneruser ,int num_owner)
   {	super(isagq, "Remove User ", true);
		this.isagq = isagq;
		this.owneruser = owneruser;
		this.num_owner = num_owner;
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);			
		setFont(new Font("DialogInput",Font.PLAIN ,12));
		
		Panel p1 = new Panel();

		p1.setLayout(new BorderLayout());
			Panel p1_1 = new Panel();
			p1_1.setLayout(new FlowLayout());
			p1_1.add(new Label("Enter ICQ number for remove"));
		p1.add(p1_1);
			Panel p1_2 = new Panel();
			p1_2.setLayout(new FlowLayout());
			p1_2.add(new Label("Isec#"));
			isecq = new TextField(15);
			p1_2.add(isecq);
		p1.add(p1_2);
		add("North", p1);

		Panel p2 = new Panel();
		p2.setLayout(new FlowLayout());
		p2.add(new Label("Password:"));
		password = new TextField("" ,8);
		password.setEchoChar('*');
		p2.add(password);
		add("Center", p2);

		Panel p3 = new Panel();
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
		{	
			boolean found = false;
			for (int i = 0;i < num_owner ;i++ )
			{	
				if (owneruser[i].getUIN() == Integer.parseInt(isecq.getText()) ) // check user
				{	found = true;
					if (owneruser[i].getPWD().equals(password.getText())) // check password
					{	warnningDialog warn =new warnningDialog(isagq ,"Are you sure remove user :"+owneruser[i].getUIN()+" ("+owneruser[i].getNick()+") ");
						if (warn.isOK()) // check ok
						{	isagq.removeOwner(owneruser[i].getUIN());
						}// end check ok
					}// end check password
					else new PwdError(isagq);
				}	// end checkuser
			}// end for
			if (!found)
			{	warnningDialog2 warn =new warnningDialog2(isagq ,"User :"+isecq.getText()+" not found");
			}
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


