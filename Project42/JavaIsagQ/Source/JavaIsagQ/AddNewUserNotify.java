package IsecQ;
import java.awt.*;
class AddNewUserNotify extends Dialog
{  
      public AddNewUserNotify(Frame parent ,int uin)
      {		super(parent, "Add New User Notify ", true);
			setLayout(new BorderLayout());
			setFont(new Font("DialogInput",Font.PLAIN ,12));
			add("Center",new Label("          Add user "+uin+" complete          "));
			Panel p1 = new Panel();
		    p1.setLayout(new FlowLayout());
			p1.add(new Button("   OK   "));
		    add("South", p1);
			pack();
//			resize(370, 230);
			move(100, 100); 
			setResizable(false);
			setVisible(true);
   	}
	
	public boolean handleEvent(Event evt)
     {	if (evt.id == Event.WINDOW_DESTROY) { dispose(); return true; }
		if ("   OK   ".equals(evt.arg)) { dispose(); return true; }
      	else return super.handleEvent(evt);
     }

/*	 public static void main(String args[])
	 {
		Frame f=new Frame();
		f.setVisible(true);
		PwdError p=new PwdError(f);
	 }
*/
}