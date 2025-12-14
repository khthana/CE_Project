package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
*/
import java.awt.*;
import java.io.*;
import IsecQ.ReadDataLine;

public class SendMessage extends Frame 
{	private	TextArea				ta;
	private	TextField				isecq ,nickname ,email;
	private UserAllInfo			uallinfo;
	private ServerConnect	sconnect;
	private TCPconnect		tcpConnect;

	private Checkbox			ThroughServer ,ClientDirect;
	private boolean				tcp = false;
	private DES						des = new DES();

	SendMessage( UserAllInfo uallinfo ,ServerConnect sconnect, TCPconnect tcpConnect)
//	SendMessage()
	{	setTitle("SendMessage");
		this.uallinfo = uallinfo;
		this.sconnect = sconnect;
		this.tcpConnect = tcpConnect;
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
		Panel p1 = new Panel();
		p1.setFont(new Font("DialogInput",Font.PLAIN ,10));
		p1.setLayout(new FlowLayout());
		p1.add(new Label("IsecQ#"));
		isecq = new TextField(6);
		p1.add(isecq);
		p1.add(new Label("Nick:"));
		nickname = new TextField(3);
		p1.add(nickname);
		p1.add(new Label("Email :"));
		email = new TextField(15);
		p1.add(email);
		add("North", p1);
		ta = new TextArea("", 6, 50, TextArea.SCROLLBARS_VERTICAL_ONLY);
		ta.setFont(new Font("DialogInput",Font.PLAIN ,10));
		add("Center", ta);
		Panel p4 = new Panel();
		CheckboxGroup g = new CheckboxGroup();
		p4.add(ThroughServer = new Checkbox("Through Server" ,g ,true));
		p4.add(ClientDirect = new Checkbox("Direct Client", g ,false));
		p4.setFont(new Font("DialogInput",Font.PLAIN ,10));
		p4.setLayout(new FlowLayout());
		p4.add(new Button(" Send "));
		p4.add(new Button("Cancel"));
		add("South", p4);
		//------------------------------------------------------------------------
		 isecq.setText(Integer.toString(uallinfo.getUIN()));
		 isecq.setEnabled(false);
		 nickname.setText(uallinfo.getNick());
		 nickname.setEnabled(false);
		 email.setText(uallinfo.getEmail());
		 email.setEnabled(false);
//		 ta.append(uallinfo.getNick() + "\r\n");
//		 ta.append(Integer.toHexString(uallinfo.getIP()) + "\r\n");
//		 ta.append(Integer.toHexString(uallinfo.getReal_IP()) + "\r\n");
//		 ta.append(uallinfo.getPort() + "\r\n");
//		 ta.append(uallinfo.getStatus() + "\r\n");
		 //--------------------------------------------------------------------
		 // print show to output. 
		 //--------------------------------------------------------------------
		 System.out.println(isecq.getText());
		 System.out.println(nickname.getText());
		 //-------------------------------------------------------------------- 
		//resize(400, 210);		
		pack();
		setResizable(true);
		setVisible(true);
	}
/*	
	public static void main(String args[])
	{	Frame f=new SendMessage();
	}
*/
	public boolean handleEvent(Event evt)
	{	if (evt.id == Event.WINDOW_DESTROY) dispose();
		else return super.handleEvent(evt);
		return true;
	}
   
	public boolean action(Event evt, Object arg)
	{	if (evt.target.equals(ThroughServer))
		{	tcp=false;
		}
		else if (evt.target.equals(ClientDirect))
		{	tcp=true;
		}
		else if (arg.equals(" Send ")) 
		{	
/*			String f="\n";	
			int a=0;
			for (int i=0; i<ta.getText().length();i++ )
			{	int n=ta.getText().indexOf(f);
				if  ( n>=0  &&  f.length()>0 )	
				{	ta.replaceText("\r\n",n,n+f.length());
					a++;
				}
				else break;
			}
			ta.append("loop: "+a);
*/
			try
			{	if (tcp)
				{	if (uallinfo.getOnline()) // send message on TCP with user online
					{	if (uallinfo.getIsagQ()) // send message to IsagQ user
						{	tcpConnect.sendEncryptMessage(uallinfo ,ta.getText());
						}
						else // send message to normal user
						{ tcpConnect.sendMessage(uallinfo ,ta.getText());
						}
						//tcpConnect.sendKey(uallinfo);
					}
					else sconnect.sendMessage(uallinfo.getUIN(),(short)1,ta.getText());				
				}
				else sconnect.sendMessage(uallinfo.getUIN(),(short)1,ta.getText());				
			}catch(IOException e){}
			ta.replaceText(" ", 0, 1000);	//Delete 0 ----> 1000 charector	
			dispose();
		}
		else if (arg.equals("Cancel"))
		{	dispose();
		}
		else return super.action(evt, arg);
		return true;
	}
}