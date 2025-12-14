package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class HomeType {
	private int HomeTypeID = 0;
	private String HomeTypeName = "";
	private int Width = 0;
	private int Space = 0;
	private int BedRoom = 0;
	private int BathRoom = 0;
	private int Floor = 0;
	private int Price = 0;
	Calculate c = new Calculate();
	public MapImage image = new MapImage(); // add object aggregation 1 to 1
	
/**
 * Employee constructor comment.
 */
public HomeType() {
	super();
}
/**
 * This method was created in VisualAge.
 */
public void add(Connection conS) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 0;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	ResultSet rset  = stmtS.executeQuery  
	("select HomeTypeID from HomeType order by HomeTypeID");
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	HomeTypeID = id;
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into HomeType "+
	 "(HomeTypeID,HomeTypeName,Width,Space,BedRoom,BathRoom,Floor,Price)"+
	 " values "+
	 "(?,?,?,?,?,?,?,?)");
	
	System.out.println("ofen check 4");

		pstmt.setString (1,""+(HomeTypeID));
		pstmt.setString (2,""+(HomeTypeName));
		pstmt.setString (3,""+(Width));
		pstmt.setString (4,""+(Space));	 
		pstmt.setString (5,""+(BedRoom));	 
		pstmt.setString (6,""+(BathRoom));	 
		pstmt.setString (7,""+(Floor));	 
		pstmt.setString (8,""+(Price));	 		
		
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
	int id = 0;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	ResultSet rset  = stmtS.executeQuery  
	("select HomeTypeID from HomeType order by HomeTypeID");
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	HomeTypeID = id;
	System.out.println("ofen check 3");
	rset.close();
	
	stmtS.executeQuery
	("insert into HomeType "+
	 "(HomeTypeID,HomeTypeName,Width,Space,BedRoom,BathRoom,Floor,Price)"+
	 " values "+
	 "('"+HomeTypeID +
	 "','"+HomeTypeName +
	 "','"+Width +
	 "','"+Space +
	 "','"+BedRoom +
	 "','"+BathRoom +
	 "','"+Floor +
	 "','"+Price +
	 "')");
	
	System.out.println("ofen check 4");

				
		
		
		
		System.out.println("add ok!");
	
		stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void clearAllInfo() {
	HomeTypeID = 0;
	HomeTypeName = "";
	Width = 0;
	Space = 0;
	BedRoom = 0;
	BathRoom = 0;
	Floor = 0;
	Price = 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public int getNumber(String st) {
	if (st.equals("HomeTypeID")) {return HomeTypeID;}
	if (st.equals("Width")) {return Width;}
	if (st.equals("Space")) {return Space;}
	if (st.equals("BedRoom")) {return BedRoom;}
	if (st.equals("BathRoom")) {return BathRoom;}
	if (st.equals("Floor")) {return Floor;}
	if (st.equals("Price")) {return Price;}
	return 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String getString(String st) {
	if (st.equals("HomeTypeName")) {return HomeTypeName;}
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
		("select * from hometype          "+
		 "where hometypeid = '"+id+"'");
	//	System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
	//	System.out.println("ofen2 check 3");

		image.load(conS,c.toInt(""+rset.getString(9))); // define image object of hometype
		
		setNumber("HomeTypeID",c.toInt(""+rset.getString(1)));
		setString("HomeTypeName",""+rset.getString(2));
		setNumber("Width",c.toInt(""+rset.getString(3)));
		setNumber("Space",c.toInt(""+rset.getString(4)));
		setNumber("BedRoom",c.toInt(""+rset.getString(5)));
		setNumber("BathRoom",c.toInt(""+rset.getString(6)));
		setNumber("Floor",c.toInt(""+rset.getString(7)));
		setNumber("Price",c.toInt(""+rset.getString(8)));

		}
		rset.close();

//	System.out.println("end hometype load");
	stmt.close();
return b;	
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void remove(Connection conS,int id) throws SQLException, IOException	{
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from HomeType where HomeTypeID = '"+id+"'");
	System.out.println("remove ok");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 */
public void setMapImage(Connection conS,int imgid) throws SQLException, IOException {
	System.out.println("HomeType update check 1");
	Statement stmtS = conS.createStatement();
	stmtS.execute("update HomeType set 		     	       		  "+
		          "	   MapImageID 	   = '"+imgid+"'			  "+
		          "where  HomeTypeID   = '"+HomeTypeID+"'   	  ");
	
	stmtS.close();
	System.out.println("update ok!");
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setNumber(String st,int i) {
	if (st.equals("HomeTypeID")) {HomeTypeID = i;}
	if (st.equals("Width")) {Width = i;}
	if (st.equals("Space")) {Space = i;}
	if (st.equals("BedRoom")) {BedRoom = i;}
	if (st.equals("BathRoom")) {BathRoom = i;}
	if (st.equals("Floor")) {Floor = i;}
	if (st.equals("Price")) {Price = i;}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setString(String st,String st2) {
	if (st.equals("HomeTypeName")) {HomeTypeName = st2;}
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id) throws SQLException, IOException {
	System.out.println("ofen check 1");

	HomeTypeID = id;
	
	System.out.println("ofen check 3");

	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into HomeType "+
	 "(HomeTypeID,HomeTypeName,Width,Space,BedRoom,BathRoom,Floor,Price)"+
	 " values "+
	 "(?,?,?,?,?,?,?,?)");
	
	System.out.println("ofen check 4");
	
		pstmt.setString (1,""+(Price));	 
		pstmt.setString (2,""+(HomeTypeID));
		pstmt.setString (3,""+(HomeTypeName));
		pstmt.setString (4,""+(Width));
		pstmt.setString (5,""+(Space));	 
		pstmt.setString (6,""+(BedRoom));	 
		pstmt.setString (7,""+(BathRoom));	 
		pstmt.setString (8,""+(Floor));	 

		
		System.out.println("ofen check 6");
		remove(conS,id);
		pstmt.execute();
		pstmt.close();
		System.out.println("update ok!");
	
	
	
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id) throws SQLException, IOException {
	System.out.println("HomeType update check 1");

	HomeTypeID = id;
	
	Statement stmtS = conS.createStatement();
	stmtS.execute("update HomeType set 		     	       		  "+
		          "	   Price 		   = '"+Price+"'			 ,"+
		          "	   HomeTypeName	   = '"+HomeTypeName+"'		 ,"+
   	              "	   Width 		   = '"+Width+"'			 ,"+
   	              "	   Space 		   = '"+Space+"'			 ,"+
   	              "	   BedRoom 		   = '"+BedRoom+"'			 ,"+
   	              "	   BathRoom	       = '"+BathRoom+"'			 ,"+
   	              "	   Floor 		   = '"+Floor+"'			 ,"+    	              
		          "where  HomeTypeID   = '"+id+"'   			  ");
	
	stmtS.close();
	System.out.println("update ok!");
}
}