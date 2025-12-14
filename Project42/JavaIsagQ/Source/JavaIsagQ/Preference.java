package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
*/
import java.awt.*;

public class Preference extends Frame
{  public Preference()
   {  setTitle("Preference");
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);			
		Panel p1 = new Panel();
		p1.setLayout(new GridLayout(3, 1, 2, 5));
		p1.add(new Label("Accept file:"));
		p1.add(new Label("Default Incoming File(s) Path"));
		filepath = new TextField();
		p1.add(filepath);
		add("North", p1);

		Panel p3 = new Panel();
      p3.setLayout(new FlowLayout());
      p3.add(new Button("   OK   "));
      p3.add(new Button("Cancel"));
      add("South", p3);

		resize(220, 130);
		setResizable(false);
      show();
   }
   
   public boolean handleEvent(Event evt)
   {  if (evt.id == Event.WINDOW_DESTROY) dispose();
		else return super.handleEvent(evt);
	  return true;
   }
   
   public boolean action(Event evt, Object arg)
   {  if (arg.equals("   OK   ")) 
		{  System.out.println(filepath.getText());
			dispose();
		}
      else if (arg.equals("Cancel")) dispose();
      else return super.action(evt, arg);
      return true;
   }
   
/*   public static void main(String[] args)
   {  Frame f = new Preference();
      f.resize(220, 130);
		f.setResizable(false);
      f.show();
   }*/
	 private TextField filepath;
}


