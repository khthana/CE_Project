package IsecQ;
import java.awt.*;
class warnningDialog extends Dialog
{  
      public warnningDialog(Frame parent ,String warnningText)
      {		super(parent, "Warnning.....", true);
			setLayout(new BorderLayout());
			setFont(new Font("DialogInput",Font.PLAIN ,12));
			add("Center",new Label("          "+warnningText+"          "));
			Panel p1 = new Panel();
		    p1.setLayout(new FlowLayout());
			p1.add(new Button("     Ok      "));
			p1.add(new Button("  Cancel  "));
		    add("South", p1);
			pack();
//			resize(370, 230);
			move(100, 100); 
			setResizable(false);
			setVisible(true);
   	}
	
	public boolean handleEvent(Event evt)
     {	if (evt.id == Event.WINDOW_DESTROY) { dispose(); return true; }
		if ("     Ok      ".equals(evt.arg)) 
		{	select = true;
			ok=true;
			dispose(); 
			return true;
		}else if ("  Cancel  ".equals(evt.arg)) 
		{	select = true;
			ok=false;
			dispose(); 
			return true;
		}
      	else return super.handleEvent(evt);
     }

	private boolean ok=false;
	private boolean select =false;
	public boolean isOK(){return ok;}
	public boolean isSelect(){return select;}




/*	 public static void main(String args[])
	 {
		Frame f=new Frame();
		f.setVisible(true);
		PwdError p=new PwdError(f);
	 }
*/
}