package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
*/
import java.awt.*;

public class HelpTopic extends Frame
{  public HelpTopic()
   {  setTitle("HelpTopic");
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);			
		Panel p1 = new Panel();
		p1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p1.setLayout(new GridLayout(1, 2, 2, 5));
		p1.add(new Label("Help Topic:"));
		add("North", p1);

		Panel p2 = new Panel();
		p2.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p2.setLayout(new FlowLayout());
		p2.add(new Button("   OK   "));
		p2.add(new Button("Cancel"));
		add("South", p2);
		
        ta = new TextArea();
	    ta.setFont(new Font("DialogInput",Font.PLAIN ,12));
        add("Center", ta);

		resize(350, 400);
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
		{	System.out.println(ta.getText());
			dispose();
		}
      else if (arg.equals("Cancel")) dispose();
      else return super.action(evt, arg);
      return true;
   }
   
/*   public static void main(String[] args)
   {  Frame f = new HelpTopic();
      f.resize(330, 200);
		f.setResizable(false);
      f.show();
   }*/
   
   private TextArea ta;
}


