package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
*/

import java.awt.*;

public class ChangeActiveUser extends Frame
{  public ChangeActiveUser()
   {  setTitle("Password Verification");
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);			
		Panel p1 = new Panel();
		p1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p1.setLayout(new FlowLayout());
		p1.add(new Label("NICK:"));
		isecq = new TextField(15);
		p1.add(isecq);
		add("North", p1);

		Panel p2 = new Panel();
		p2.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p2.setLayout(new FlowLayout());
		p2.add(new Label("Password:"));
		password = new TextField(8);
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
		{  System.out.println(isecq.getText());
         System.out.println(password.getText());
			dispose();}
      else if (arg.equals("  No   ")) dispose();
			else return super.action(evt, arg);
      return true;
   }
   
/*   public static void main(String[] args)
   {  Frame f = new ChangeActiveUser();
      f.resize(200, 120);
		f.setResizable(false);
      f.show();
   }
	*/
	 private TextField isecq, password;
}