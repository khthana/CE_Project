package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class Privilege {
	private int PrivilegeID = 0;
	private int ProjectID = 0;
	Calculate c = new Calculate();
	public int empid = 0;
/**
 * Employee constructor comment.
 */
public Privilege() {
	super();
}
/**
 * Employee constructor comment.
 */
public Privilege(int eid) {
	super();
	empid = eid;
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
	("select PrivilegeID 				"+
	 "from Privilege 					"+
	 "where EmployeeID = '"+empid+"'  	"+
	 "order by PrivilegeID				");
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	PrivilegeID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Privilege "+
	 "(EmployeeID,PrivilegeID,ProjectID)"+
	 " values "+
	 "(?,?,?)");
	
	System.out.println("ofen check 4");

		pstmt.setString (1,""+(empid));
		pstmt.setString (2,""+(PrivilegeID));
		pstmt.setString (3,""+(ProjectID));	 		
		
		System.out.println("ofen check 6");
		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	
		stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add(Connection conS,int empid) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select PrivilegeID 				"+
	 "from Privilege 					"+
	 "where EmployeeID = '"+empid+"'  	"+
	 "order by PrivilegeID				");
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	PrivilegeID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Privilege "+
	 "(EmployeeID,PrivilegeID,ProjectID)"+
	 " values "+
	 "(?,?,?)");
	
	System.out.println("ofen check 4");

		pstmt.setString (1,""+(empid));
		pstmt.setString (2,""+(PrivilegeID));
		pstmt.setString (3,""+(ProjectID));	 		
		
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
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select PrivilegeID 				"+
	 "from Privilege 					"+
	 "where EmployeeID = '"+empid+"'  	"+
	 "order by PrivilegeID				");
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	PrivilegeID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	stmtS.executeQuery
	("insert into Privilege "+
	 "(EmployeeID,PrivilegeID,ProjectID)"+
	 " values "+
	 "('"+empid+"','"+PrivilegeID +"','"+ProjectID +"')");
	
	System.out.println("ofen check 4");
		
	System.out.println("add ok!");
	
		stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add2(Connection conS,int empid) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select PrivilegeID 				"+
	 "from Privilege 					"+
	 "where EmployeeID = '"+empid+"'  	"+
	 "order by PrivilegeID				");
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	PrivilegeID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	stmtS.executeQuery
	("insert into Privilege "+
	 "(EmployeeID,PrivilegeID,ProjectID)"+
	 " values "+
	 "('"+empid+"','"+PrivilegeID +"','"+ProjectID +"')");
	
	System.out.println("ofen check 4");
		
	System.out.println("add ok!");
	
		stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean checkPri(Connection conS,int proid) throws SQLException, IOException  {
boolean b = false;

		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from Privilege      "+
		 "where ProjectID = '"+proid+"' "+
		 "  and EmployeeID  = '"+empid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true;
		System.out.println("ofen2 check 3");
		setNumber("PrivilegeID",c.toInt(""+rset.getString(2)));
		setNumber("ProjectID",c.toInt(""+rset.getString(3)));		
		}
		rset.close();

	System.out.println("end checkPri");
	stmt.close();
return b;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean checkPri(Connection conS,int empid,int proid) throws SQLException, IOException  {
boolean b = false;

		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from Privilege      "+
		 "where ProjectID = '"+proid+"' "+
		 "  and EmployeeID  = '"+empid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true;
		System.out.println("ofen2 check 3");
		setNumber("PrivilegeID",c.toInt(""+rset.getString(2)));
		setNumber("ProjectID",c.toInt(""+rset.getString(3)));		
		}
		rset.close();

	System.out.println("end checkPri");
	stmt.close();
return b;
}
/**
 * This method was created in VisualAge.
 */
public void clearAllInfo() {
	PrivilegeID = 0;
	ProjectID = 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public int getNumber(String st) {
	if (st.equals("PrivilegeID")) {return PrivilegeID;}
	if (st.equals("ProjectID")) {return ProjectID;}
	return 0;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean load(Connection conS,int id) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from Privilege      "+
		 "where Privilegeid = '"+id+"' "+
		 "  and EmployeeID  = '"+empid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
				
		System.out.println("ofen2 check 3");
		
		setNumber("PrivilegeID",c.toInt(""+rset.getString(2)));
		setNumber("ProjectID",c.toInt(""+rset.getString(3)));		
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
public boolean load(Connection conS,int id,int empid) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from Privilege      "+
		 "where Privilegeid = '"+id+"' "+
		 "  and EmployeeID  = '"+empid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		System.out.println("ofen2 check 3");
		
		setNumber("PrivilegeID",c.toInt(""+rset.getString(2)));
		setNumber("ProjectID",c.toInt(""+rset.getString(3)));		
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
	stmt.execute ("delete from Privilege 		   "+
				  "where EmployeeID  = '"+empid+"' "+
				  "  and PrivilegeID = '"+id+"'    ");
	System.out.println("remove ok !");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void remove(Connection conS,int id,int empid) throws SQLException, IOException	{
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from Privilege 		   "+
				  "where EmployeeID  = '"+empid+"' "+
				  "  and PrivilegeID = '"+id+"'    ");
	System.out.println("remove ok !");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setNumber(String st,int i) {
	if (st.equals("PrivilegeID")) {PrivilegeID = i;}
	if (st.equals("ProjectID")) {ProjectID = i;}
	
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id) throws SQLException, IOException {
	System.out.println("ofen check 1");

	PrivilegeID = id;
	
	System.out.println("ofen check 3");
	
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Privilege "+
	 "(EmployeeID,PrivilegeID,ProjectID)"+
	 " values "+
	 "(?,?,?)");
	
	System.out.println("ofen check 4");
		pstmt.setString (1,""+(ProjectID));	 
		pstmt.setString (2,""+(empid));
		pstmt.setString (3,""+(PrivilegeID));
		
		
		System.out.println("ofen check 6");
		remove(conS,id,empid);
		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	
		
	
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id) throws SQLException, IOException {
	System.out.println("privilege update check 1");
	PrivilegeID = id;	
	Statement stmtS = conS.createStatement();	
	stmtS.execute("update Privilege set							 "+
		          "	   PrivilegeID	 	= '"+PrivilegeID+"' 	,"+
		          "	   ProjectID 		=  '"+ProjectID+   "' 	,"+
		          "	   EmployeeID 		= '"+empid+    "'  		 "+
		          "where  PrivilegeID   = '"+PrivilegeID+"'  and "+
		          "       EmployeeID    = '"+empid+    "'        ");
	
	stmtS.close();
	System.out.println("update ok!");
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id,int empid) throws SQLException, IOException {
	System.out.println("ofen check 1");

	PrivilegeID = id;
	
	System.out.println("ofen check 3");
	
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Privilege "+
	 "(EmployeeID,PrivilegeID,ProjectID)"+
	 " values "+
	 "(?,?,?)");
	
	System.out.println("ofen check 4");
		pstmt.setString (1,""+(ProjectID));	 
		pstmt.setString (2,""+(empid));
		pstmt.setString (3,""+(PrivilegeID));
		
		
		System.out.println("ofen check 6");
		remove(conS,id,empid);
		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	
		
	
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id,int empid) throws SQLException, IOException {
	System.out.println("privilege update check 1");
	PrivilegeID = id;	
	Statement stmtS = conS.createStatement();	
	stmtS.execute("update Privilege set							 "+
		          "	   PrivilegeID	 	= '"+PrivilegeID+"' 	,"+
		          "	   ProjectID 		=  '"+ProjectID+   "' 	,"+
		          "	   EmployeeID 		= '"+empid+    "'  		 "+
		          "where  PrivilegeID   = '"+PrivilegeID+"'  and "+
		          "       EmployeeID    = '"+empid+    "'        ");
	
	stmtS.close();
	System.out.println("update ok!");
}
}