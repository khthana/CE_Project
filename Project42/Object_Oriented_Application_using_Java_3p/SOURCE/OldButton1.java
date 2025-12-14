// OldButton1.java
import java.awt.*;
import java.applet.*;
import java.io.*;
import java.net.*;

public class OldButton1 extends Applet {
	public String s ;
	
	public void init() {
		setFont(new Font("Courier New",Font.PLAIN,18));
		add(new Button("SendFile"));
		s = "Hello ja";
	}

	public void paint(Graphics g)
	{
		g.drawString("touch",10,10);
	}
	
	public boolean action(Event e,Object a)  {
		if (e.target instanceof Button) {
			if (a.equals("SendFile"))
			{
				FileDialog d = new FileDialog(new Frame(), "My FileDialog", FileDialog.LOAD);
				d.setDirectory(".");
				d.setVisible(true);
				
				System.out.println(d.getDirectory());
				System.out.println(d.getFile());
				
				String s = d.getDirectory();
				String s1 = d.getFile();//File fileUPLoad = File(d.getDirectory(),d.getFile());
				this.s = s;
				repaint();
				try
				{
					Send send = new Send("venus09.ce.kmitl.ac.th",8080);
					send.run(s,s1);
					setBackground(Color.blue);
				}
				catch (Exception ex)
				{
					setBackground(Color.red);
				}
				
			}
			if (a.equals("Hi"))
				System.out.println("Hi");
			if (a.equals("What's up?"))
				System.out.println("What's up?");
		}
		return true;
	}
}
// <applet code="OldButton1" width=230 height=90> </applet>
