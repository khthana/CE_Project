package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
*/
import java.awt.*;
import IsecQ.NewAnotherReg;
import IsecQ.OldAnotherReg;
/*import NewAnotherReg;
import OldAnotherReg;*/

public class AddAnother extends Frame
{   NewAnotherReg newanotherreg;
	OldAnotherReg oldanotherreg;
	IsagQ isagq;
	ServerConnect sconnect;

	public AddAnother(IsagQ isagq ,ServerConnect sconnect)
   {	setTitle("AddAnother");
		this.isagq = isagq;
		this.sconnect = sconnect;
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);			
		Panel p1 = new Panel();
		p1.setFont(new Font("DialogInput",Font.BOLD ,12));
		p1.setLayout(new FlowLayout());
		p1.add(new Label("Click button to select Registeration :"));
		add("North", p1);


		Panel pb = new Panel();
		pb.setLayout(new GridLayout(3 ,1));
		pb.setFont(new Font("DialogInput",Font.PLAIN ,12));
			Panel pb1 = new Panel();
			pb1.setLayout(new FlowLayout());
			pb1.add(new Button("   Registered User  "));
		pb.add(pb1);
			Panel pb2 = new Panel();
			pb2.setLayout(new FlowLayout());
			pb2.add(new Button(" Unregistered User "));
		pb.add(pb2);
			Panel pb3 = new Panel();
			pb3.setLayout(new FlowLayout());
			pb3.add(new Button("     Cancel       "));
		pb.add(pb3);
		add("Center", pb);

		pack();
//		resize(200, 100);
		setResizable(false);
		show();
   }
   
   public boolean handleEvent(Event evt)
   {  if (evt.id == Event.WINDOW_DESTROY) dispose();
		else return super.handleEvent(evt);
	  return true;
   }
   
   public boolean action(Event evt, Object arg)
   {  if (arg.equals(" Unregistered User ")) newanotherreg = new NewAnotherReg(isagq ,sconnect);
		else if (arg.equals("   Registered User  ")) oldanotherreg = new OldAnotherReg(isagq ,sconnect);
			else if (arg.equals("     Cancel       ")) dispose();
				else return super.action(evt, arg);
      dispose();
	  return true;
   }
   
/*   public static void main(String[] args)
   {  Frame f = new AddAnother();
      f.resize(200, 100);
		f.setResizable(false);
      f.show();
   }*/
}


