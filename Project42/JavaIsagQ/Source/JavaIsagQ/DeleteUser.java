package IsecQ;
/**
 * @version 1.00 6 Jan 2000 
 * @author Weera
 * @modify by Teerapong
*/

import java.awt.*;
import java.util.*;

public class DeleteUser extends Dialog
{  
//	Vector udataVect=new Vector();
	UserAllInfo[] ownerinfo;
//	UserDATA[] userdata;
	Frame parent;

    public DeleteUser(Frame parent ,UserAllInfo[] ownerinfo ,int num_owner)
	{	super(parent,"Password Verification", true);
		this.parent = parent;
//		setTitle("Password Verification");
		this.setForeground(Color.black);
		this.setBackground(Color.lightGray);
		Panel p1 = new Panel();
		p1.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p1.setLayout(new FlowLayout());
		p1.add(new Label("User:"));
		userChoice=new Choice();
	
		Dimension d=userChoice.getSize();
		d.width=40;
		userChoice.setSize(d);
		p1.add(userChoice);
		add("North", p1);

		Panel p2 = new Panel();
		p2.setFont(new Font("DialogInput",Font.PLAIN ,12));
		p2.setLayout(new FlowLayout());
		p2.add(new Label("Password:"));
		password = new TextField("",8);
		password.setEchoChar('*');
		p2.add(password);
		add("Center", p2);

		Panel p3 = new Panel();
		p3.setFont(new Font("DialogInput",Font.PLAIN ,12));
        p3.setLayout(new FlowLayout());
        p3.add(new Button("  Yes  "));
        p3.add(new Button("  Cancel  "));
//        p3.add(new Button("  Add new user  "));
       add("South", p3);
	
		this.ownerinfo = ownerinfo;
	   	for (int i=0;i< num_owner;i++)
		{	if (!ownerinfo[i].getNick().equals(""))
			{	userChoice.addItem(ownerinfo[i].getNick());
			}else userChoice.addItem(ownerinfo[i].getUIN()+"");
		}
		userChoice.select(2);
		password.setText("");
		System.out.println("verification");
		OK="NO_OK";
		System.out.println(OK);
		System.out.println(indexSel);
		System.out.println(pwdSel);
        resize(300, 130);
		setResizable(false);
		setVisible(true);		
//	   pack();
	}
/*
	public void Verification()
   {
   }
*/   
   public boolean handleEvent(Event evt)
   {  if (evt.id == Event.WINDOW_DESTROY) 
		{
			OK="Cancel";
			setVisible(false);
//			dispose();
		}
		else return super.handleEvent(evt);
	  return true;
   }
   
   public boolean action(Event evt, Object arg)
   {  	if (arg.equals("  Yes  ")) 
		{
			pwdSel=password.getText();
			indexSel=userChoice.getSelectedIndex();
			if(ownerinfo[indexSel].getPWD().equals(pwdSel))
			{	System.out.println(" ok loop ");
				selectedUser =ownerinfo[indexSel];
				OK="OK";
//				setVisible(false);
				dispose();
			}else new PwdError(parent);
		}
		else if(arg.equals("  Cancel  "))
		{	OK="Cancel";
//			setVisible(true);
			dispose();
		}
//		else if (arg.equals("  Add new user  "))
//		{	AddAnother add = new AddAnother();
//		}

      return true;
   }
	public String getOK(){return OK;}

	public UserAllInfo getSelectedUser()
	{	return selectedUser;
	}
//	public int getInx(){return indexSel;}
//	public String getPwd(){return pwdSel;}
   
/*   public static void main(String[] args)
   {  Frame f = new ChangeActiveUser();
      f.resize(200, 120);
		f.setResizable(false);
      f.show();
   }
	*/
	String OK="NO_OK";
	private UserAllInfo selectedUser = new UserAllInfo();
	private int indexSel;
	private String pwdSel;
	private Choice userChoice;
	private TextField isecq, password;
}