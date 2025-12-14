import java.awt.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class Editor extends Frame
{	
	private Panel cards;
	private Panel tabs;
	private CardLayout layout;

	DialogClass		editClass;
	DialogGroup		editGroup;
	DialogQuestion	editQuestion;

	ErrorFrame		error;

	String flag = null;

	Editor()
	{
		setTitle("Editor");

		tabs = new Panel();
		tabs.add(new Button("ระดับชั้น"));	// Class
		tabs.add(new Button("หมวดคำถาม"));	// Group
		tabs.add(new Button("คำถาม"));		// Question
		add("North",tabs);

		cards = new Panel();
		layout = new CardLayout();
		cards.setLayout(layout);

		cards.add("ระดับชั้น",editClass = new DialogClass(this));
		cards.add("หมวดคำถาม",editGroup = new DialogGroup(this));
		cards.add("คำถาม"	 ,editQuestion = new DialogQuestion(this));

		add("Center",cards);

		error = new ErrorFrame();

		Font f = new Font("Dialog",Font.PLAIN,16);
		setFont(f);
	}

	public String loadClassdB()
	{
		String DB = "",DB2 = "";
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
//System.out.println("SELECT Class FROM Index GROUP BY Class");
			ResultSet rs1 = condB.query("SELECT Class FROM Index GROUP BY Class");

			boolean bb = rs1.next();
			while (bb)
			{
				DB += rs1.getString(1);
				bb = rs1.next();
				if (bb == true) DB += "|";
			}

			StringBufferInputStream in = new StringBufferInputStream(DB);
			InputStreamReader rin = new InputStreamReader(in);
			LineNumberReader  lin = new LineNumberReader(rin);

			DB2 += lin.readLine();

			in.close();
			
			rs1.close();
			condB.close();
		}
		catch (Exception ex) {}
		return DB2;
	}

	public String loadGroupdB(String classdB)
	{
		String DB = "",DB2 = "";

		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
//System.out.println("SELECT Group FROM Index WHERE [Class] = " +"'" +classdB +"'");
			ResultSet rs1 = condB.query("SELECT Group FROM Index WHERE [Class] = " +"'" +classdB +"'");

			boolean bb = rs1.next();
			while (bb)
			{
				DB += rs1.getString(1);
				bb = rs1.next();
				if (bb == true) DB += "|";
			}

			StringBufferInputStream in = new StringBufferInputStream(DB);
			InputStreamReader rin = new InputStreamReader(in);
			LineNumberReader  lin = new LineNumberReader(rin);

			DB2 += lin.readLine();

			in.close();
			
			rs1.close();
			condB.close();
		}
		catch (Exception ex) {}
		return DB2;
	}

	public String Convert2Thai(String text) 
	{
		StringBuffer buffer = new StringBuffer();
		
	 	for (int i=0; i<text.length(); i++)
		{
			int c = (int)text.charAt(i);
			if (c > 255)
			{
				c -=3424;
				buffer.append((char)c);
			}
			else buffer.append((char)c);
		}

		return buffer.toString().trim();
	}

	public boolean action(Event evt,Object arg)
	{
		if (evt.target instanceof Component && ((Component)evt.target).getParent().equals(tabs))
		{
			if (arg.equals("ระดับชั้น")) editClass.init();
			if (arg.equals("หมวดคำถาม")) editGroup.init();
			if (arg.equals("คำถาม"))	 editQuestion.init();
			layout.show(cards,(String)arg);
		}
		if (arg.equals("Exit"))
		{
			System.exit(1);
		}
		else return super.action(evt,arg);
		return true;
	}

	public boolean handleEvent(Event evt)
	{
		if (evt.id == Event.WINDOW_DESTROY)
		{
			System.exit(1);
		}
		return super.handleEvent(evt);
	}

	public static void main(String[] args)
	{
		Frame f = new Editor();
		f.resize(650,400);
		f.setBackground(Color.lightGray);
		f.show();
	}
}
/*************************************************************************************/
class DialogClass extends Panel
{
	Editor		edit;

	Button		onApply,onDelete,onInsert,onExit;
	List		tClass,tGroup;
	TextField	editClass;

	DialogClass(Editor edit)
	{
		this.edit = edit;

		GridBagLayout gbl = new GridBagLayout();
		setLayout(gbl);

		GridBagConstraints gbc = new GridBagConstraints();

		gbc.anchor = GridBagConstraints.CENTER;
		add(new Label("ระดับชั้น : ")		,gbl,gbc,1,0,1,1);
		add(tClass		= new List(3,false)	,gbl,gbc,1,1,2,1);
		gbc.anchor = GridBagConstraints.WEST;
		add(new Label("หมวดคำถาม : ")		,gbl,gbc,4,0,1,1);
		add(tGroup		= new List(5,false)	,gbl,gbc,4,1,2,1);
		gbc.anchor = GridBagConstraints.CENTER;
		add(new Label("")					,gbl,gbc,1,2,1,1);
		add(new Label("ระดับชั้น : ")		,gbl,gbc,0,3,1,1);
		add(editClass	= new TextField(40)	,gbl,gbc,1,3,5,1);

		gbc.fill = GridBagConstraints.HORIZONTAL;
		add(new Label("")						,gbl,gbc,1,4,1,1);
		add(onApply		= new Button("Apply")	,gbl,gbc,1,5,1,1);
		add(onInsert	= new Button("เพิ่ม")	,gbl,gbc,2,5,1,1);
		add(onDelete	= new Button("ลบออก")	,gbl,gbc,3,5,1,1);
		add(onExit		= new Button("Exit")	,gbl,gbc,5,5,1,1);

		onApply.disable();
		onInsert.disable();
		onDelete.disable();
	}

	private void add(Component c,GridBagLayout gbl,GridBagConstraints gbc,int x,int y,int width,int height)
	{
		gbc.gridx = x;
		gbc.gridy = y;
		gbc.gridwidth = width;
		gbc.gridheight = height;
		gbl.setConstraints(c,gbc);
		add(c);
	}

	public void init()
	{
		tClass.clear();				//*********************************************
		tGroup.clear();				//**		Clear all
		editClass.setText("");		//*********************************************

		StringTokenizer st = new StringTokenizer(edit.loadClassdB(),"|");
		while (st.hasMoreTokens())
		{
			tClass.addItem(st.nextToken());
		}
		onApply.disable();
		onInsert.disable();
		onDelete.disable();
	}

	private boolean chkRecur(String s)
	{
		boolean have = false;
		for (int i=0; i<tClass.countItems(); i++)
		{
			if (s.compareTo(tClass.getItem(i))==0) have = true;
		}

		return have;
	}

	private void deleteC(String s)
	{
		String bb;
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);

			for (int i=0; i<tGroup.countItems(); i++)
			{
				bb = s +"|" +edit.Convert2Thai(tGroup.getItem(i));
//System.out.println("DROP TABLE [" +bb +"]");
				condB.update("DROP TABLE [" +bb +"]");
			}

//System.out.println("DELETE * FROM Index WHERE Class = '" +s +"'");
				condB.update("DELETE * FROM Index WHERE Class = '" +s +"'");
				condB.close();
		}
		catch (Exception ex)
		{
			System.out.println("! " +ex);
		}
	}

	private void insertC(String s)
	{
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
//System.out.println("INSERT INTO Index ([Class],[Group]) VALUES ('" +s +"','empty')");
				condB.update("INSERT INTO Index ([Class],[Group]) VALUES ('" +s +"','empty')");
				condB.close();
		}
		catch (Exception ex)
		{
			System.out.println("! " +ex);
		}
	}

	public void showGroup(String s)
	{
		tGroup.clear();

		StringTokenizer st = new StringTokenizer(edit.loadGroupdB(edit.Convert2Thai(s)),"|");
		while (st.hasMoreTokens())
		{
			tGroup.addItem(st.nextToken());
		}
	}

	public boolean action(Event evt,Object arg)
	{
		if (evt.target.equals(tClass))
		{
			showGroup(tClass.getSelectedItem());
			editClass.setText(tClass.getSelectedItem());
			onApply.enable();
			onInsert.enable();
			onDelete.enable();
		}
		else if (evt.target.equals(onApply))
		{
			init();
		}
		else if (evt.target.equals(onInsert))
		{
			String tmp = editClass.getText().trim();
			if (editClass.getText().compareTo("") != 0)
			{
				if ( ! chkRecur(tmp)) insertC(edit.Convert2Thai(tmp));
				else editClass.setText("error");
			}
			else 
			{
				edit.error.ErrorMsg("คุณต้องใส่ระดับชั้นก่อน");
			}
		}
		else if (evt.target.equals(onDelete))
		{
			String tmp = editClass.getText().trim();
			if (chkRecur(tmp)) deleteC(edit.Convert2Thai(tmp));
			else edit.error.ErrorMsg("คุณต้องใส่ระดับชั้นก่อน");
			editClass.setText("");
		}
		else return super.action(evt,arg);

		return true;
	}
}
/*************************************************************************************/
class DialogGroup extends Panel
{
	Editor edit;

	Button		onApply,onDelete,onInsert,onExit;
	List		tClass,tGroup;
	TextField	editGroup;

	DialogGroup(Editor edit)
	{
		this.edit = edit;

		GridBagLayout gbl = new GridBagLayout();
		setLayout(gbl);

		GridBagConstraints gbc = new GridBagConstraints();

		gbc.fill = GridBagConstraints.BOTH;
		add(new Label("ระดับชั้น : ")		,gbl,gbc,0,0,1,1);
		add(new Label("หมวดคำถาม : ")		,gbl,gbc,0,1,1,1);
		add(tClass		= new List(2,false)	,gbl,gbc,1,0,2,1);
		add(tGroup		= new List(5,false)	,gbl,gbc,1,1,3,1);
		add(new Label("")					,gbl,gbc,1,2,1,1);
		add(new Label("หมวดคำถาม : ")		,gbl,gbc,0,3,1,1);
		add(editGroup	= new TextField(40)	,gbl,gbc,1,3,5,1);

		gbc.fill = GridBagConstraints.HORIZONTAL;
		add(new Label("")						,gbl,gbc,1,4,1,1);
		add(onApply		= new Button("Apply")	,gbl,gbc,1,5,1,1);
		add(onInsert	= new Button("เพิ่ม")	,gbl,gbc,2,5,1,1);
		add(onDelete	= new Button("ลบออก")	,gbl,gbc,3,5,1,1);
		add(onExit		= new Button("Exit")	,gbl,gbc,5,5,1,1);
		add(new Label("      ")					,gbl,gbc,4,5,1,1);

		onApply.disable();
		onInsert.disable();
		onDelete.disable();
	}

	private void add(Component c,GridBagLayout gbl,GridBagConstraints gbc,int x,int y,int width,int height)
	{
		gbc.gridx = x;
		gbc.gridy = y;
		gbc.gridwidth = width;
		gbc.gridheight = height;
		gbl.setConstraints(c,gbc);
		add(c);
	}

	public void init()
	{
		tClass.clear();				//*********************************************
		tGroup.clear();				//**		Clear all
		editGroup.setText("");		//*********************************************

		StringTokenizer st = new StringTokenizer(edit.loadClassdB(),"|");
		while (st.hasMoreTokens())
		{
			tClass.addItem(st.nextToken());
		}

		onApply.disable();
		onInsert.disable();
		onDelete.disable();
	}

	private boolean chkRecur(String s)
	{
		boolean have = false;
		for (int i=0; i<tClass.countItems(); i++)
		{
			if (s.compareTo(tClass.getItem(i))==0) have = true;
		}

		return have;
	}

	public void showGroup(String s)
	{
		tGroup.clear();

		StringTokenizer st = new StringTokenizer(edit.loadGroupdB(edit.Convert2Thai(s)),"|");
		while (st.hasMoreTokens())
		{
			tGroup.addItem(st.nextToken());
		}
	}

	private void insertG2Index(String C,String G)
	{
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
			
//System.out.println("DELETE * FROM [Index] WHERE [Class] = '" +C +"' AND [Group] = 'empty'");
				condB.update("DELETE * FROM [Index] WHERE [Class] = '" +C +"' AND [Group] = 'empty'");
//System.out.println("INSERT INTO [Index] ([Class],[Group]) VALUES ('"+C +"','" +G +"')");
				condB.update("INSERT INTO [Index] ([Class],[Group]) VALUES ('"+C +"','" +G +"')");
			condB.close();
		}
		catch (Exception ex)
		{
			System.out.println("! " +ex);
		}
	}

	private void insertG(String Table)
	{
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
			
//System.out.println("CREATE TABLE [" +Table +"] ([problem] TEXT(120),[choice 1] TEXT(120), [choice 2] TEXT(120),[choice 3] TEXT(120),[choice 4] TEXT(120),[answer] TEXT(1))");
			condB.update("CREATE TABLE [" +Table +"] ([problem] TEXT(120),[choice 1] TEXT(120), [choice 2] TEXT(120),[choice 3] TEXT(120),[choice 4] TEXT(120),[answer] TEXT(1))");
			condB.close();
		}
		catch (Exception ex)
		{
			System.out.println("! " +ex);
		}
	}

	private void deleteG(String C,String G)
	{
		String bb;
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);

				condB.update("DROP TABLE [" +C +"|" +G +"]");
				condB.update("DELETE * FROM Index WHERE [Class] = '" +C +"' AND [Group] = '" +G +"'");
				condB.close();
		}
		catch (Exception ex)
		{
			System.out.println("! " +ex);
		}
	}

	public boolean action(Event evt,Object arg)
	{
		if (evt.target.equals(tClass))
		{
			showGroup(tClass.getSelectedItem());
			onApply.enable();
			onInsert.enable();
		}
		if (evt.target.equals(tGroup))
		{
			editGroup.setText(tGroup.getSelectedItem());
			onDelete.enable();
		}
		if (evt.target.equals(onApply))
		{
			editGroup.setText("");
			showGroup(tClass.getSelectedItem());
		}
		if (evt.target.equals(onInsert))
		{
			if (editGroup.getText().compareTo("") != 0)
			{
				if (chkRecur(editGroup.getText()))
				{
					String tmp1 = edit.Convert2Thai(tClass.getSelectedItem());
					String tmp2 = edit.Convert2Thai(editGroup.getText().trim());

					insertG2Index(tmp1,tmp2);
					insertG(tmp1 +"|" +tmp2);
					editGroup.setText("");
				}
				else 
				{
					edit.error.ErrorMsg("กรุณาเปลี่ยนชื่อใหม่");
				}
			}
			else 
			{
				edit.error.ErrorMsg("คุณต้องใส่หมวดคำถามก่อน");
			}
		}
		if (evt.target.equals(onDelete))
		{
			if (editGroup.getText().compareTo("") != 0)
			{
				if ( ! chkRecur(editGroup.getText()))
				{
					deleteG(edit.Convert2Thai(tClass.getSelectedItem()),edit.Convert2Thai(tGroup.getSelectedItem()));
					editGroup.setText("");
				}
				else 
				{
					edit.error.ErrorMsg("กรุณาเปลี่ยนชื่อใหม่");
				}
			}
			else 
			{
				edit.error.ErrorMsg("คุณต้องใส่หมวดคำถามก่อน");
			}
		}
		else return super.action(evt,arg);
		return true;
	}
}
/*************************************************************************************/
class DialogQuestion extends Panel
{
	Editor		edit;
	int			count = 1;
	Vector		listQ = new Vector();
	Button		onPrev,onNext,onApply,onGo,onChange,onDelete,onInsert,onExit;
	TextField	tQuestion,tc1,tc2,tc3,tc4,tAnswer,no;
	List		tClass,tGroup;
	Label		tlabel;
	CheckboxGroup g;
	Checkbox	ch1,ch2,ch3,ch4;

	DialogQuestion(Editor edit)
	{
		this.edit = edit;

		GridBagLayout gbl = new GridBagLayout();
		setLayout(gbl);

		GridBagConstraints gbc = new GridBagConstraints();

		gbc.fill = GridBagConstraints.BOTH;
		add(new Label("ระดับชั้น : ")		,gbl,gbc,0,0,1,1);
		add(new Label("หมวดคำถาม : ")		,gbl,gbc,0,1,1,1);
		add(new Label("คำถาม : ")			,gbl,gbc,0,2,1,1);
		add(new Label("ตัวเลือกที่ 1 : ")	,gbl,gbc,0,3,1,1);
		add(new Label("ตัวเลือกที่ 2 : ")	,gbl,gbc,0,4,1,1);
		add(new Label("ตัวเลือกที่ 3 : ")	,gbl,gbc,0,5,1,1);
		add(new Label("ตัวเลือกที่ 4 : ")	,gbl,gbc,0,6,1,1);

		g = new CheckboxGroup();
		add(tClass		= new List(2,false)		,gbl,gbc,1,0,2,1);
		add(tGroup		= new List(3,false)	,gbl,gbc,1,1,3,1);
		add(tQuestion	= new TextField(80)	,gbl,gbc,1,2,11,1);
		add(tc1			= new TextField(50)	,gbl,gbc,1,3,7,1);
		add(tc2			= new TextField(50)	,gbl,gbc,1,4,7,1);
		add(tc3			= new TextField(50)	,gbl,gbc,1,5,7,1);
		add(tc4			= new TextField(50)	,gbl,gbc,1,6,7,1);
		gbc.anchor = GridBagConstraints.CENTER;
		add(ch1			= new Checkbox("Ans 1",g,false)	,gbl,gbc,8,3,1,1);
		add(ch2			= new Checkbox("Ans 2",g,false)	,gbl,gbc,8,4,1,1);
		add(ch3			= new Checkbox("Ans 3",g,false)	,gbl,gbc,8,5,1,1);
		add(ch4			= new Checkbox("Ans 4",g,false)	,gbl,gbc,8,6,1,1);
		gbc.fill = GridBagConstraints.NONE;
		add(onPrev		= new Button("<Prev")	,gbl,gbc,1,9,1,1);
		add(no			= new TextField(3)		,gbl,gbc,2,9,1,1);
		add(onGo		= new Button("Go")		,gbl,gbc,3,9,1,1);
		add(onNext		= new Button("Next>")	,gbl,gbc,4,9,1,1);
		add(onApply		= new Button("Apply")	,gbl,gbc,5,9,1,1);
		gbc.fill = GridBagConstraints.BOTH;
		add(onInsert	= new Button("เพิ่ม")	,gbl,gbc,8,9,1,1);
		add(onChange	= new Button("แก้ไข")	,gbl,gbc,9,9,1,1);
		add(onDelete	= new Button("ลบออก")	,gbl,gbc,10,9,1,1);
		add(onExit		= new Button("Exit")	,gbl,gbc,11,9,1,1);

		gbc.anchor = GridBagConstraints.WEST;
		add(tlabel		= new Label("จำนวน : ")	,gbl,gbc,0,9,1,1);

		no.setEditable(false);
		no.setBackground(Color.white);
//		initDialogQuestion();
	}

	private void add(Component c,GridBagLayout gbl,GridBagConstraints gbc,int x,int y,int width,int height)
	{
		gbc.gridx = x;
		gbc.gridy = y;
		gbc.gridwidth = width;
		gbc.gridheight = height;
		gbl.setConstraints(c,gbc);
		add(c);
	}

	public void init()
	{
		tClass.clear();				//*********************************************
		tGroup.clear();				//**
		tQuestion.setText("");		//**		Clear all
		tc1.setText("");			//**
		tc2.setText("");			//**
		tc3.setText("");			//**
		tc4.setText("");			//**
		ch1.setState(false);		//**
		ch2.setState(false);		//**
		ch3.setState(false);		//**
		ch4.setState(false);		//**
		no.setEditable(false);		//**
		no.setText("");				//**
		tlabel.setText("จำนวน : ");	//*********************************************

		StringTokenizer st = new StringTokenizer(edit.loadClassdB(),"|");
		while (st.hasMoreTokens())
		{
			tClass.addItem(st.nextToken());
		}
		onPrev.disable();
		onGo.disable();
		onNext.disable();
		onApply.disable();
		onInsert.disable();
		onChange.disable();
		onDelete.disable();
	}

	public void showGroup(String s)
	{
		tGroup.clear();

		StringTokenizer st = new StringTokenizer(edit.loadGroupdB(edit.Convert2Thai(s)),"|");
		while (st.hasMoreTokens())
		{
			tGroup.addItem(st.nextToken());
		}
	}

	public void showOneQ()
	{	
		String tmp = (String)listQ.elementAt(0);
		if (tmp.compareTo("empty") != 0)
		{
			tlabel.setText("จำนวน : " +listQ.size());
			StringTokenizer st = new StringTokenizer((String)listQ.elementAt(count-1),"|");
			while (st.hasMoreTokens())
			{
				no.setText(count +"");

				tQuestion.setText(st.nextToken());
				tc1.setText(st.nextToken());
				tc2.setText(st.nextToken());
				tc3.setText(st.nextToken());
				tc4.setText(st.nextToken());
				String result = st.nextToken();
				if (result.compareTo("1")==0) g.setCurrent(ch1);
				else if (result.compareTo("2")==0) g.setCurrent(ch2);
				else if (result.compareTo("3")==0) g.setCurrent(ch3);
				else if (result.compareTo("4")==0) g.setCurrent(ch4);
			}
		}
		else 
		{
			tQuestion.setText("empty");

			tc1.setText("");			//*********************************************
			tc2.setText("");			//**
			tc3.setText("");			//**
			tc4.setText("");			//**
			ch1.setState(false);		//**
			ch2.setState(false);		//**
			ch3.setState(false);		//**
			ch4.setState(false);		//**
			no.setEditable(false);		//**
			no.setText("");				//**
			tlabel.setText("จำนวน : ");	//*********************************************

		}
	}

	private String tableName()
	{
		return tClass.getSelectedItem() +"|" +tGroup.getSelectedItem();
	}

	private String newQuestion()
	{
		int ans = 0;
		if (ch1.getState()) ans = 1;
		else if (ch2.getState()) ans = 2;
		else if (ch3.getState()) ans = 3;
		else if (ch4.getState()) ans = 4;

		if (tQuestion.getText().compareTo("Empty")==0) tQuestion.setText("empty");
		if (tc1.getText().compareTo("")==0) tc1.setText("empty");
		if (tc2.getText().compareTo("")==0) tc2.setText("empty");
		if (tc3.getText().compareTo("")==0) tc3.setText("empty");
		if (tc4.getText().compareTo("")==0) tc4.setText("empty");

		return tQuestion.getText() +"|" +tc1.getText() +"|" +tc2.getText() +"|" +tc3.getText() +"|" +tc4.getText() +"|" +ans;
	}

	private String changeQ(int i)
	{
		StringTokenizer st = new StringTokenizer((String)listQ.elementAt(i),"|");

		return st.nextToken();
	}

	private void loadQ2listQ(String list)
	{
		listQ.removeAllElements();
		
		if (list.compareTo("null") == 0) listQ.addElement("empty");
		else
		{
			StringTokenizer st = new StringTokenizer(list,"&");
			while (st.hasMoreTokens())
			{
				listQ.addElement(st.nextToken());
			}
		}
	}

	private int String2Int(String number)
	{
		int tmp = 0;
		boolean first = true;
	 	for (int i=0; i<number.length(); i++)
		{
			int c = (int)number.charAt(i);
			if (c >= 48 & c <= 57)	// 48 <= c <= 57
			{
				if ( ! first) tmp *= 10;

				if (c == 48) tmp += 0;
				if (c == 49) tmp += 1;
				if (c == 50) tmp += 2;
				if (c == 51) tmp += 3;
				if (c == 52) tmp += 4;
				if (c == 53) tmp += 5;
				if (c == 54) tmp += 6;
				if (c == 55) tmp += 7;
				if (c == 56) tmp += 8;
				if (c == 57) tmp += 9;
			}
			else // it's mean 'number' is not integer
			{
				tmp = 0;
				break;
			}
			first = false;
		}
System.out.println("no : " +tmp);
		return tmp;
	}

	public String loadQ(String Table)
	{
		String DB = "",DB2 = "";
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
//System.out.println("SELECT * FROM [" +Table +"] ORDER BY [problem]");
			ResultSet rs1 = condB.query("SELECT * FROM [" +Table +"] ORDER BY [problem]");

			boolean bb = rs1.next();
			while (bb)
			{
				DB += rs1.getString(1) +"|" +rs1.getString(2) +"|" +rs1.getString(3) +"|" +rs1.getString(4) +"|" +rs1.getString(5) +"|" +rs1.getString(6);
				bb = rs1.next();
				if (bb == true) DB += "&";
			}

			StringBufferInputStream in = new StringBufferInputStream(DB);
			InputStreamReader rin = new InputStreamReader(in);
			LineNumberReader  lin = new LineNumberReader(rin);

			DB2 += lin.readLine();
			in.close();
			
			rs1.close();
			condB.close();
		}
		catch (Exception ex) {}

		return DB2;
	}

	public void insertQ(String Table,String Q)
	{
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
			
				StringTokenizer st = new StringTokenizer(Q,"|");
//System.out.println("INSERT INTO [" +Table +"] ([problem],[choice 1],[choice 2],[choice 3],[choice 4],[answer]) VALUES ('" +st.nextToken() +"','" +st.nextToken() +"','" +st.nextToken() +"','" +st.nextToken() +"','" +st.nextToken() +"','" +st.nextToken() +"')");
				condB.update("INSERT INTO [" +Table +"] ([problem],[choice 1],[choice 2],[choice 3],[choice 4],[answer]) VALUES ('" +st.nextToken() +"','" +st.nextToken() +"','" +st.nextToken() +"','" +st.nextToken() +"','" +st.nextToken() +"','" +st.nextToken() +"')");
				condB.close();
		}
		catch (Exception ex)
		{
			System.out.println("! " +ex);
		}
	}

	public void changeQ(String Table,String Q,String problem)
	{
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
			
			StringTokenizer st = new StringTokenizer(Q,"|");

//System.out.println("UPDATE [" +Table +"] SET [Problem] = " +"'" +st.nextToken() +"'" +" ,[choice 1] = " +"'" +st.nextToken() +"'" +" ,[choice 2] = " +"'" +st.nextToken() +"'" +" ,[choice 3] = " +"'" +st.nextToken() +"'" +" ,[choice 4] = " +"'" +st.nextToken() +"'" +" ,[answer] = " +"'" +st.nextToken() +"'" +" WHERE [problem] = '" +problem +"'");
				condB.update("UPDATE [" +Table +"] SET [Problem] = " +"'" +st.nextToken() +"'" +" ,[choice 1] = " +"'" +st.nextToken() +"'" +" ,[choice 2] = " +"'" +st.nextToken() +"'" +" ,[choice 3] = " +"'" +st.nextToken() +"'" +" ,[choice 4] = " +"'" +st.nextToken() +"'" +" ,[answer] = " +"'" +st.nextToken() +"'" +" WHERE [problem] = '" +problem +"'");
				condB.close();
		}
		catch (Exception ex)
		{
			System.out.println("! " +ex);
		}
	}

	public void deleteQ(String Table,String problem)
	{
//System.out.println("delete Q= " +problem);
		try 
		{
			Connect condB = new Connect();
			String db_name = "Touch";	// Database Name
			condB.connected(db_name);
			
//System.out.println("DELETE * FROM [" +Table +"] WHERE [problem] = '" +problem +"'");
				condB.update("DELETE * FROM [" +Table +"] WHERE [problem] = '" +problem +"'");
				condB.close();
		}
		catch (Exception ex)
		{
			System.out.println("! " +ex);
		}
	}

	public boolean action(Event evt,Object arg)
	{
		if (arg.equals("<Prev"))
		{
			if (count-1 > 0)
			{
				count--;
			}
			else
			{
				count = listQ.size();
			}
			showOneQ();
		}
		if (arg.equals("Next>"))
		{
			if (count < listQ.size())
			{
				count++;
			}
			else
			{
				count = 1;
			}
			showOneQ();
		}
		if (arg.equals("Go"))
		{
			int tmp = String2Int(no.getText());

			if ((0 < tmp)&(tmp <= listQ.size())) count = tmp;
			else if (tmp > listQ.size()) count = listQ.size();
			else if (tmp <= 0) count = 1;
			showOneQ();
		}
		if (evt.target.equals(onApply))
		{
			loadQ2listQ(loadQ(edit.Convert2Thai(tableName())));
			showOneQ();
		}
		if (evt.target.equals(onInsert))
		{
			insertQ(edit.Convert2Thai(tableName()),edit.Convert2Thai(newQuestion()));
		}
		if (evt.target.equals(onChange))
		{
			changeQ(edit.Convert2Thai(tableName()),edit.Convert2Thai(newQuestion()),edit.Convert2Thai(changeQ(count-1)));
		}
		if (evt.target.equals(onDelete))
		{
			deleteQ(edit.Convert2Thai(tableName()),edit.Convert2Thai(tQuestion.getText()));
		}
		if (evt.target.equals(tClass))
		{
			tGroup.clear();				//*********************************************
			tQuestion.setText("");		//**
			tc1.setText("");			//**
			tc2.setText("");			//**
			tc3.setText("");			//**
			tc4.setText("");			//**
			ch1.setState(false);		//**		Clear all
			ch2.setState(false);		//**
			ch3.setState(false);		//**
			ch4.setState(false);		//**
			no.setEditable(false);		//**
			no.setText("");				//**
			tlabel.setText("จำนวน : ");	//**
			onDelete.disable();			//*********************************************

			showGroup(tClass.getSelectedItem());
		}
		if (evt.target.equals(tGroup))
		{
			onPrev.enable();
			onGo.enable();
			onNext.enable();
			onApply.enable();
			onInsert.enable();
			onChange.enable();
			onDelete.enable();

			no.setEditable(true);
			loadQ2listQ(loadQ(edit.Convert2Thai(tableName())));
			showOneQ();
		}

		else return super.action(evt,arg);
		return true;
	}
}
/*************************************************************************************/
class ErrorFrame extends Frame
{
	Label label;

	public ErrorFrame()
	{
		setTitle(" Error ! ");
		setBackground(Color.lightGray);
		setResizable(false);
		resize(300,100);

		setLayout( new FlowLayout() );
		add("Center",label = new Label(""));

		Font f = new Font("Dialog",Font.PLAIN,18);
		setFont(f);
	}

	public void ErrorMsg(String ErrorMsg)
	{
		label.setText(ErrorMsg);
		this.show();
	}

	public boolean handleEvent(Event evt)
	{
		if (evt.id == Event.WINDOW_DESTROY && evt.target == this)
			this.dispose();
		return super.handleEvent(evt);
	}

}
/*************************************************************************************/
class Connect 
{
	private Statement stmt;
	private ResultSet result;
	private Connection con;
	private int ct;
	
	public Connect() 
	{}

	public void connected(String db_name) 
	{
		try 
		{
			// connect to ODBC database
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			String url = "jdbc:odbc:" + db_name;

			// connect
			con = DriverManager.getConnection(url);
			stmt = con.createStatement();
		}
		catch (Exception e) 
		{
			System.err.println("You found error in connected(String ) METHOD : " + e.getMessage());
		}
	}

	public ResultSet query(String s) throws SQLException 
	{
		try 
		{
			result = stmt.executeQuery(s);
		}
		catch (SQLException e) 
		{
			System.err.println("You found error in query METHOD : " + e.getMessage());
		}
		return result;
	}

	public synchronized int update(String s) throws SQLException 
	{
		try 
		{
			ct = stmt.executeUpdate(s);
		}
		catch (SQLException e) 
		{
			System.err.println("You found error in update METHOD : " + e.getMessage());
		}
		return ct;
	}

	public void close() throws SQLException 
	{
		try 
		{
			result.close();
			stmt.close();
			con.close();
		}
		catch (SQLException e) 
		{
			System.err.println("You can't close Connect package. Because Query maybe false : " + e.getMessage());
		}
	}
}
