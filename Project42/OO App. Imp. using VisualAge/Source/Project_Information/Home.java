package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class Home {
	private int HomeID = 0;
	private String Address = "";
	private int X = 0;
	private int Y = 0;
	Calculate c = new Calculate();
	public HomeStatus status = new HomeStatus(); // add object aggregation 1 to 1
	public HomeType type = new HomeType(); // add object aggregation 1 to 1
	public int proid = 0;
	
/**
 * Employee constructor comment.
 */
public Home() {
	super();
}
/**
 * Employee constructor comment.
 */
public Home(int pid) {
	super();
	proid = pid;
}
/**
 * This method was created in VisualAge.
 */
public void add(Connection conS) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select HomeID		 				"+
	 "from Home          				"+
	 "where ProjectID = '"+proid+"'  	"+
	 "order by HomeID					");
	
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	HomeID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Home "+
	 "(ProjectID,HomeID,X,Y,Address)"+
	 " values "+
	 "(?,?,?,?,?)");
	
	System.out.println("ofen check 4");
	

		pstmt.setString (1,""+(proid));
		pstmt.setString (2,""+(HomeID));
		pstmt.setString (3,""+(X));
		pstmt.setString (4,""+(Y));
		pstmt.setString (5,""+(Address));	 		
		
	System.out.println("ofen check 6");
	
	pstmt.execute();
	pstmt.close();
	System.out.println("add ok!");
	
	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add(Connection conS,int proid) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select HomeID		 				"+
	 "from Home          				"+
	 "where ProjectID = '"+proid+"'  	"+
	 "order by HomeID					");
	
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	HomeID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Home "+
	 "(ProjectID,HomeID,X,Y,Address)"+
	 " values "+
	 "(?,?,?,?,?)");
	
	System.out.println("ofen check 4");
	

		pstmt.setString (1,""+(proid));
		pstmt.setString (2,""+(HomeID));
		pstmt.setString (3,""+(X));
		pstmt.setString (4,""+(Y));
		pstmt.setString (5,""+(Address));	 		
		
	System.out.println("ofen check 6");
	
	pstmt.execute();
	pstmt.close();
	System.out.println("add ok!");
	
	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add2(Connection conS) throws SQLException, IOException {
//	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select HomeID		 				"+
	 "from Home          				"+
	 "where ProjectID = '"+proid+"'  	"+
	 "order by HomeID					");
	
//	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	HomeID = id;
	
	
//	System.out.println("ofen check 3");
	rset.close();
	
	stmtS.executeQuery
	("insert into Home "+
	 "(ProjectID,HomeID,X,Y,Address)"+
	 " values "+
	 "('"+proid +"','"+HomeID +"','"+X +"','"+Y +"','"+Address +"')");
	
//	System.out.println("ofen check 4");
	

	System.out.println("add ok!");
	
	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add2(Connection conS,int proid) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select HomeID		 				"+
	 "from Home          				"+
	 "where ProjectID = '"+proid+"'  	"+
	 "order by HomeID					");
	
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	HomeID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	stmtS.executeQuery
	("insert into Home "+
	 "(ProjectID,HomeID,X,Y,Address)"+
	 " values "+
	 "('"+proid +"','"+HomeID +"','"+X +"','"+Y +"','"+Address +"')");
	
	System.out.println("ofen check 4");
	

	System.out.println("add ok!");
	
	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add3(Connection conS,int id) throws SQLException, IOException {
	Statement stmtS = conS.createStatement ();
	HomeID = id;
	stmtS.executeQuery
	("insert into Home "+
	 "(ProjectID,HomeID,X,Y,Address)"+
	 " values "+
	 "('"+proid +"','"+HomeID +"','"+X +"','"+Y +"','"+Address +"')");
//	System.out.println("add ok!");
	stmtS.close();
}
/**
 * This method was created in VisualAge.
 */
public void clearAllInfo() {
	HomeID = 0;
	Address = "";
	X = 0;
	Y = 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public int getNumber(String st) {
	if (st.equals("HomeID")) {return HomeID;}
	if (st.equals("X")) {return X;}
	if (st.equals("Y")) {return Y;}	
	return 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String getString(String st) {
	if (st.equals("Address")) {return Address;}
	return "";
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean load(Connection conS,int id) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
	//	System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from Home	       "+
		 "where	HomeID		= '"+id+"' "+
		 "  and ProjectID   = '"+proid+"' ");
		
	//	System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
	//	System.out.println("ofen2 check 3");
		
		type.load(conS,c.toInt(""+rset.getString(6)));// define  object hometype of home
		status.load(conS,c.toInt(""+rset.getString(7)));// define  object homestatus of home

		
		setNumber("HomeID",c.toInt(""+rset.getString(2)));
		setNumber("X",c.toInt(""+rset.getString(3)));
		setNumber("Y",c.toInt(""+rset.getString(4)));
		setString("Address",(""+rset.getString(5)));
		
		}
		rset.close();

//	System.out.println("end load home");
	stmt.close();
return b;	
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean load(Connection conS,int id,int proid) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from Home	       "+
		 "where	HomeID		= '"+id+"' "+
		 "  and ProjectID   = '"+proid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		System.out.println("ofen2 check 3");
		
		type.load(conS,c.toInt(""+rset.getString(6)));// define  object hometype of home
		status.load(conS,c.toInt(""+rset.getString(7)));// define  object homestatus of home

		
		setNumber("HomeID",c.toInt(""+rset.getString(2)));
		setNumber("X",c.toInt(""+rset.getString(3)));
		setNumber("Y",c.toInt(""+rset.getString(4)));
		setString("Address",(""+rset.getString(5)));
		
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
public boolean loadXY(Connection conS,int x,int y) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from Home	       "+
		 "where	X		= '"+x+"' 	   "+
		 "  and Y		= '"+y+"' 	   "+
		 "  and ProjectID   = '"+proid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		System.out.println("ofen2 check 3");
		
		type.load(conS,c.toInt(""+rset.getString(6)));// define  object hometype of home
		status.load(conS,c.toInt(""+rset.getString(7)));// define  object homestatus of home

		
		setNumber("HomeID",c.toInt(""+rset.getString(2)));
		setNumber("X",c.toInt(""+rset.getString(3)));
		setNumber("Y",c.toInt(""+rset.getString(4)));
		setString("Address",(""+rset.getString(5)));
		
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
public boolean loadXY(Connection conS,int x,int y,int proid) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from Home	       "+
		 "where	X		= '"+x+"' 	   "+
		 "  and Y		= '"+y+"' 	   "+
		 "  and ProjectID   = '"+proid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		System.out.println("ofen2 check 3");
		
		type.load(conS,c.toInt(""+rset.getString(6)));// define  object hometype of home
		status.load(conS,c.toInt(""+rset.getString(7)));// define  object homestatus of home

		
		setNumber("HomeID",c.toInt(""+rset.getString(2)));
		setNumber("X",c.toInt(""+rset.getString(3)));
		setNumber("Y",c.toInt(""+rset.getString(4)));
		setString("Address",(""+rset.getString(5)));
		
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
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from Home	  			  "+
				  "where ProjectID  = '"+proid+"' "+
				  "  and HomeID 	= '"+id+"'    ");
	System.out.println("remove ok");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void remove(Connection conS,int id,int proid) throws SQLException, IOException	{
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from Home	  			  "+
				  "where ProjectID  = '"+proid+"' "+
				  "  and HomeID 	= '"+id+"'    ");
	System.out.println("remove ok");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void removeAll(Connection conS) throws SQLException, IOException	{
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from Home	  			  "+
				  "where ProjectID  = '"+proid+"' ");
	System.out.println("removeAll ok");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 */
public void setHomeStatus(Connection conS,int id) throws SQLException, IOException {
//System.out.println("home status update check 1");
	Statement stmtS = conS.createStatement();
	stmtS.execute("update Home set					 "+
		          "	   HomeStatusID  = '"+id+"'		 "+
		          "where  ProjectID   = '"+proid+"'  and"+
	              "	      HomeID = '"+HomeID+"' 		");

	
	stmtS.close();
//System.out.println("update ok!");
}
/**
 * This method was created in VisualAge.
 */
public void setHomeType(Connection conS,int id) throws SQLException, IOException {
//System.out.println("home type update check 1");
	Statement stmtS = conS.createStatement();
	stmtS.execute("update Home set					 "+
		          "	   HomeTypeID  = '"+id+"'		 "+
				  "where  ProjectID   = '"+proid+"'  and"+
	              "	      HomeID = '"+HomeID+"' 		");
	
	stmtS.close();
//System.out.println("update ok!");
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setNumber(String st,int i) {
	if (st.equals("HomeID")) {HomeID = i;} else
	if (st.equals("X")) {X = i;} else
	if (st.equals("Y")) {Y = i;}	
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setString(String st,String st2) {
	if (st.equals("Address")) {Address = st2;}
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id) throws SQLException, IOException {
	System.out.println("ofen check 1");

	HomeID = id;
	
	
	System.out.println("ofen check 3");
	
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Home "+
	 "(ProjectID,HomeID,X,Y,Address)"+
	 " values "+
	 "(?,?,?,?,?)");
	
	System.out.println("ofen check 4");
	
		pstmt.setString (1,""+(Address));	 
		pstmt.setString (2,""+(proid));
		pstmt.setString (3,""+(HomeID));
		pstmt.setString (4,""+(X));
		pstmt.setString (5,""+(Y));
		
	System.out.println("ofen check 6");
	
	remove(conS,id,proid);
	
	pstmt.execute();
	pstmt.close();
	System.out.println("add ok!");
	

}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id) throws SQLException, IOException {
//	System.out.println("home update check 1");
	
	HomeID = id;
	
	Statement stmtS = conS.createStatement();
//	System.out.println("home update check 2 id="+HomeID);
//	System.out.println("home update check 3 X="+X);
//	System.out.println("home update check 3 Y="+Y);
	stmtS.execute("update Home set					 "+
		          "	   X	   = '"+X+"'  			,"+
		          "	   Y     = '"+Y+"'  			,"+
		          "	   Address  = '"+Address+"'		 "+
		          "where  ProjectID   = '"+proid+"'  and"+
	              "	      HomeID = '"+HomeID+"' 		");
//	System.out.println("home update check 3 id="+HomeID);

	stmtS.close();
//	System.out.println("update ok!");


}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id,int proid) throws SQLException, IOException {
	System.out.println("ofen check 1");

	HomeID = id;
	
	
	System.out.println("ofen check 3");
	
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Home "+
	 "(ProjectID,HomeID,X,Y,Address)"+
	 " values "+
	 "(?,?,?,?,?)");
	
	System.out.println("ofen check 4");
	
		pstmt.setString (1,""+(Address));	 
		pstmt.setString (2,""+(proid));
		pstmt.setString (3,""+(HomeID));
		pstmt.setString (4,""+(X));
		pstmt.setString (5,""+(Y));
		
	System.out.println("ofen check 6");
	
	remove(conS,id,proid);
	
	pstmt.execute();
	pstmt.close();
	System.out.println("add ok!");
	

}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id,int proid) throws SQLException, IOException {
	System.out.println("home update check 1");
	
	HomeID = id;
	
	Statement stmtS = conS.createStatement();
	System.out.println("home update check 2 id="+HomeID);
	System.out.println("home update check 3 X="+X);
	System.out.println("home update check 3 Y="+Y);
	stmtS.execute("update Home set					 "+
		          "	   X	   = '"+X+"'  			,"+
		          "	   Y     = '"+Y+"'  			,"+
		          "	   Address  = '"+Address+"'		 "+
		          "where  ProjectID   = '"+proid+"'  and"+
	              "	      HomeID = '"+HomeID+"' 		");
	System.out.println("home update check 3 id="+HomeID);

	stmtS.close();
	System.out.println("update ok!");


}
}