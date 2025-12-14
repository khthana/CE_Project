package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
*/
import java.awt.*;
import java.io.*;

public class ReceiveMessage extends Frame 
{	TextArea ta;
    TextField isecq, nickname, email;
	
	ServerConnect sconnect;
	UserAllInfo uallinfo;
	TCPconnect tcpConnect;
	public ReceiveMessage(int senderUIN ,String msg ,ServerConnect sconnect ,TCPconnect tcpConnect)
	{	setTitle("ReceiveMessage");
		this.sconnect=sconnect;
		this.tcpConnect=tcpConnect;
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
		
		Panel p1 = new Panel();
		p1.setFont(new Font("DialogInput",Font.PLAIN ,10));
		p1.setLayout(new FlowLayout());
		p1.add(new Label("IsecQ#"));
		isecq = new TextField(Integer.toString(senderUIN));
		isecq.setEnabled(false);
		p1.add(isecq);
		p1.add(new Label("Nick:"));
		nickname = new TextField("");
		nickname.setEnabled(false);
		p1.add(nickname);
		p1.add(new Label("Email:"));
		email = new TextField("");
		nickname.setEnabled(false);
		p1.add(email);
		add("North", p1);
		
		ta = new TextArea("", 6, 15, TextArea.SCROLLBARS_BOTH);
		ta.setFont(new Font("DialogInput",Font.PLAIN ,10));
		ta.append(msg);
		ta.setEditable(false);
		add("Center", ta);

		Panel p2 = new Panel();
		p2.setFont(new Font("DialogInput",Font.PLAIN ,10));
		p2.setLayout(new FlowLayout());
		p2.add(new Button(" Reply "));
		p2.add(new Button(" Close "));
		add("South", p2);
		pack();
		setResizable(true);
		setVisible(true);
	}
	
	public ReceiveMessage(UserAllInfo uallinfo ,String msg ,ServerConnect sconnect ,TCPconnect tcpConnect)
	{	setTitle("ReceiveMessage");
		this.uallinfo=uallinfo;
		this.sconnect=sconnect;
		this.tcpConnect=tcpConnect;
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
		
		Panel p1 = new Panel();
		p1.setFont(new Font("DialogInput",Font.PLAIN ,10));
		p1.setLayout(new FlowLayout());
		p1.add(new Label("IsecQ#"));
		isecq = new TextField(6);
		isecq.setEnabled(false);
		p1.add(isecq);
		p1.add(new Label("Nick:"));
		nickname = new TextField(3);
		nickname.setEnabled(false);
		p1.add(nickname);
		p1.add(new Label("Email:"));
		email = new TextField(15);
		nickname.setEnabled(false);
		p1.add(email);
		add("North", p1);

		 isecq.setText(Integer.toString(uallinfo.getUIN()));
		 isecq.setEnabled(false);
		 nickname.setText(uallinfo.getNick());
		 nickname.setEnabled(false);
		 email.setText(uallinfo.getEmail());
		 email.setEnabled(false);

		
		ta = new TextArea("", 5, 15, TextArea.SCROLLBARS_BOTH);
		ta.setFont(new Font("DialogInput",Font.PLAIN ,10));
		ta.append(msg);
		ta.setEditable(false);
		add("Center", ta);

		Panel p2 = new Panel();
		p2.setFont(new Font("DialogInput",Font.PLAIN ,10));
		p2.setLayout(new FlowLayout());
		p2.add(new Button(" Reply "));
		p2.add(new Button(" Close "));
		add("South", p2);
		pack();
		setResizable(false);
		setVisible(true);
	}
   
	public boolean handleEvent(Event evt)
	{	if (evt.id == Event.WINDOW_DESTROY) dispose();
			else return super.handleEvent(evt);
		return true;
	}
   
	public boolean action(Event evt, Object arg)
	{	if (arg.equals(" Reply ")) 
		{	ta.replaceText(" ", 0, 1000);	//Delete 0 ----> 1000 charector	
			SendMessage sndmsg=new SendMessage(uallinfo ,sconnect ,tcpConnect);
			dispose();
		}
		else if (arg.equals(" Close "))
		{	dispose();
		}
      else return super.action(evt, arg);
      return true;
   }
}