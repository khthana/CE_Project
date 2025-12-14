package Project_Information;

import java.io.*;
import java.sql.*;

/**
 * This type was created in VisualAge.
 */
public class Account {
	private int AccountID = 0;
	private String AccountName = "";
	private String Password = "";
	private String Visible = "";
	Calculate c = new Calculate();
	
/**
 * Employee constructor comment.
 */
public Account() {
	super();
}
/**
 * This method was created in VisualAge.
 */
public void add(Connection conS) throws SQLException, IOException {
	System.out.println("account add check 1");
	int id = 0;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	ResultSet rset  = stmtS.executeQuery  
	("select AccountID from Account order by AccountID");
	System.out.println("account add check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	AccountID = id;
	System.out.println("account add check 3");
	rset.close();
	// end find last row

	// start insert with preparedStatement
	PreparedStatement pstmt = conS.prepareStatement 
	("insert into Account "+
	 "(AccountID,AccountName,Password,Visible)"+
	 " values "+
	 "(?,?,?,?)");
	
	System.out.println("account add check 4");
	

		pstmt.setString (1,""+AccountID);
		pstmt.setString (2,""+AccountName);
		pstmt.setString (3,""+Password);	 
		pstmt.setString (4,""+Visible);
		
		System.out.println("account add check 5");
		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
		stmtS.close();
	// end insert complete !!!
}
/**
 * This method was created in VisualAge.
 */
public void add2(Connection conS) throws SQLException, IOException {
	System.out.println("account add check 1");
	int id = 0;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	ResultSet rset  = stmtS.executeQuery  
	("select AccountID from Account order by AccountID");
	System.out.println("account add check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	AccountID = id;
	System.out.println("account add check 3");
	rset.close();
	// end find last row

	// start insert with preparedStatement
	stmtS.executeQuery
	("insert into Account"+
	 "(AccountID,AccountName,Password,Visible)"+
	 "values"+
	 "('"+AccountID+"','"+AccountName+"','"+Password+"','"+Visible+"' )");
	
		System.out.println("account add check 5");
		
		System.out.println("add ok!");
		stmtS.close();
	// end insert complete !!!
}
/**
 * This method was created in VisualAge.
 */
public void clearAllInfo() {
	AccountID = 0;
	AccountName = "";
	Password = "";
	Visible = "";
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public int getNumber(String st) {
	if (st.equals("AccountID")) {return AccountID;}
	return 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String getString(String st) {
	if (st.equals("AccountName")) {return AccountName;}
	if (st.equals("Password")) {return Password;}
	if (st.equals("Visible")) {return Visible;}
	return "";
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean load(Connection conS,int id) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("account load check 1");
		ResultSet rset = stmt.executeQuery
		("select * from account          "+
		 "where accountid = '"+id+"'");
		System.out.println("account load check 2");
		while (rset.next()) {
		b = true; // return true , if found
		
		 System.out.println("account load check 3");
		 setNumber("AccountID",c.toInt(""+rset.getString(1)));
		 setString("AccountName",""+rset.getString(2));
		 setString("Password",""+rset.getString(3));
		 setString("Visible",""+rset.getString(4));
		
		}
		rset.close();

	System.out.println("end load");
	stmt.close();
return b;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void remove(Connection conS,int id) throws SQLException, IOException	{
	System.out.println("account remove check 1");
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from account where accountid = '"+id+"'");
	System.out.println("remove ok");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean search(Connection conS,String an,String p) throws SQLException, IOException  {

boolean b = false;

		Statement stmt = conS.createStatement();
		System.out.println("account search check 1");
		ResultSet rset = stmt.executeQuery
		("select *			      			 "+
		 "from account          			 "+
		 "where  accountname = '"+an+"'  and "+
		 "		 password    = '"+p+ "'  and "+
		 "       visible     = 'T'           ");
		
		System.out.println("account search check 2");
		while (rset.next()) {
		 b = true;		
		 System.out.println("account search check 3");
		 setNumber("AccountID",c.toInt(""+rset.getString(1)));
		 setString("AccountName",""+rset.getString(2));
		 setString("Password",""+rset.getString(3));
		 setString("Visible",""+rset.getString(4));
		}
		rset.close();

	System.out.println("end search");
	stmt.close();
	return b;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setNumber(String st,int i) {
	if (st.equals("AccountID")) {AccountID = i;}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setString(String st,String st2) {
	if (st.equals("AccountName")) {AccountName = st2;} else
	if (st.equals("Password")) {Password = st2;} else
	if (st.equals("Visible")) {Visible = st2;}
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id) throws SQLException, IOException {
	System.out.println("account update check 1");

	AccountID = id;
	

	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Account "+
	 "(AccountID,AccountName,Password,Visible)"+
	 " values "+
	 "(?,?,?,?)");
	
	System.out.println("account update check 2");
	
		pstmt.setString (1,""+Visible);
		pstmt.setString (2,""+AccountID);
		pstmt.setString (3,""+AccountName);
		pstmt.setString (4,""+Password);	 
	
	System.out.println("account update check 3");
		remove(conS,id);
		pstmt.execute();
		pstmt.close();
		System.out.println("update ok!");
	
	
	
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id) throws SQLException, IOException {
	System.out.println("account update check 1");
	AccountID = id;
	Statement stmtS = conS.createStatement();
	stmtS.execute("update Account set						"+
		          "	   AccountName = '"+AccountName+"' ,"+
		          "	   Password	   = '"+Password+   "' ,"+
		          "	   Visible     = '"+Visible+    "'  "+
		          "where  AccountID   = '"+id+"'  ");
	
	stmtS.close();
	System.out.println("update ok!");
}
}