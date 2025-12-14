package IsecQ;

import java.awt.*;
import IsecQ.DATA_REF;

public class SelectServer extends Frame //implements Runnable
{  // AddServer addserver;
	TextField Server, Port;
	TextArea Tx;
	DATA_REF  Data;

	public SelectServer()
    {   setTitle("SelectServer");
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
		Panel p1 = new	Panel();	p1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p1.setLayout(new FlowLayout());
		//-----------------------------------------------------------------------------------------------------------------
		// เก็บไว้ก่อน เพราะเป็นการ Get ค่า Server : Port ขึ้นมาเพื่อส่งให้กับ TextArea ตอนเริ่มต้น
		//String s = Data.SERVER.substring(0, (Data.SERVER.length() -1)) +":" +Data.PORT;
		//-----------------------------------------------------------------------------------------------------------------
		String s = Data.SERVER.substring(0, (Data.SERVER.length() -1)) +":" +Data.PORT;
		 
		p1.add(Tx = new TextArea(s, 7, 38, TextArea.SCROLLBARS_BOTH));
		add("North", p1);
		Panel p2 = new Panel();	p2.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p2.setLayout(new FlowLayout());
   		p2.add(new Label("Server:"));		
		Server = new TextField(20);		
		p2.add(Server);
		p2.add(new Label("Port:"));			
		Port = new TextField(4);			
		p2.add(Port);
		p2.add(new Button(" Add  "));		
		add("Center", p2);
    	Panel p3 = new Panel();	p3.setFont(new Font("DialogInput",Font.PLAIN ,12));
        p3.setLayout(new FlowLayout());
        p3.add(new Button("   OK   "));		
		p3.add(new Button("Cancel"));
        add("South", p3);
		
		pack();		//resize(420, 190);
		setResizable(false);
        show();
   }

   public boolean handleEvent(Event evt)
   {	if (evt.id == Event.WINDOW_DESTROY) dispose();
		return super.handleEvent(evt);
   }
   
   public boolean action(Event evt, Object arg)
   {	if (arg.equals("   OK   ")) 
			{	System.out.println(Server.getText() +":"+ Port.getText()); dispose(); 
				
			}
		else if (arg.equals("Cancel"))	dispose();
		else if (arg.equals(" Add  ")) 
		{		String s = Server.getText();	Tx.appendText(s +":");
				String p = Port.getText();		Tx.appendText(p +"\n");
		}
		else return super.action(evt, arg);
		return true;
   }
  
}


