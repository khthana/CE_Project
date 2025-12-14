package Project_Information;

import java.io.*;
import java.sql.*;
import java.util.Date;
import java.util.GregorianCalendar;
/**
 * This type was created in VisualAge.
 */
public class Contract {
	private int ContractID = 0;
	private Date IssuedDate = null;
	private Date ExpiryDate = null;
	private String Status = "";
	private int HomeID = 0;
	private int ProjectID = 0;
	Month m = new Month();
	Calculate c = new Calculate();
	public int cusid = 0;
	public ContractType type = new ContractType(); // add aggregation 1 to 1
	
/**
 * Customer constructor comment.
 */
public Contract() {
	super();

}
/**
 * Customer constructor comment.
 */
public Contract(int id) {
	super();
	cusid = id;

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
	("select ContractID from Contract "+
	 "where customerid = '"+cusid+"'  "+
	 "order by ContractID");
	
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	ContractID = id;
	
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Contract "+
	 "(CustomerID,ContractID,IssuedDate,ExpiryDate,Status,HomeID,ProjectID)"+
	 " values "+
	 "(?,?,?,?,?,?,?)");
	
	
	System.out.println("ofen check 5");
	
	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){
		
		pstmt.setString (1,""+cusid);
		pstmt.setString (2,""+ContractID);
		pstmt.setString (3,(""+getDateString("IssuedDate")));
		pstmt.setString (4,(""+getDateString("ExpiryDate")));
		pstmt.setString (5,""+Status);	 
		pstmt.setString (6,""+HomeID);	 
		pstmt.setString (7,""+ProjectID);
		
		System.out.println("ofen check 6");
		
		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	} else { System.out.println("not add ..."); }


	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add(Connection conS,int cusid) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	ResultSet rset  = stmtS.executeQuery  
	("select ContractID from Contract "+
	 "where customerid = '"+cusid+"'  "+
	 "order by ContractID");
	
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	ContractID = id;
	
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Contract "+
	 "(CustomerID,ContractID,IssuedDate,ExpiryDate,Status,HomeID,ProjectID)"+
	 " values "+
	 "(?,?,?,?,?,?,?)");
	
	
	System.out.println("ofen check 5");
	
	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){
		
		pstmt.setString (1,""+cusid);
		pstmt.setString (2,""+ContractID);
		pstmt.setString (3,(""+getDateString("IssuedDate")));
		pstmt.setString (4,(""+getDateString("ExpiryDate")));
		pstmt.setString (5,""+Status);	 
		pstmt.setString (6,""+HomeID);	 
		pstmt.setString (7,""+ProjectID);
		
		System.out.println("ofen check 6");
		
		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	} else { System.out.println("not add ..."); }


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
	("select ContractID from Contract "+
	 "where customerid = '"+cusid+"'  "+
	 "order by ContractID");
	
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	ContractID = id;
	
	System.out.println("ofen check 3");
	rset.close();

	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){
	stmtS.executeQuery 
	("insert into Contract "+
	 "(CustomerID,ContractID,IssuedDate,ExpiryDate,Status,HomeID,ProjectID)"+
	 " values "+
	 "('"+cusid +
	 "','"+ContractID +
	 "','"+getDateString("IssuedDate") +
	 "','"+getDateString("ExpiryDate") +
	 "','"+Status +
	 "','"+HomeID +
	 "','"+ProjectID +"')");
		
	System.out.println("ofen check 5");
			
		System.out.println("add ok!");
	} else { System.out.println("not add ..."); }


	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add2(Connection conS,int cusid) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	ResultSet rset  = stmtS.executeQuery  
	("select ContractID from Contract "+
	 "where customerid = '"+cusid+"'  "+
	 "order by ContractID");
	
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	ContractID = id;
	
	System.out.println("ofen check 3");
	rset.close();

	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){
	stmtS.executeQuery 
	("insert into Contract "+
	 "(CustomerID,ContractID,IssuedDate,ExpiryDate,Status,HomeID,ProjectID)"+
	 " values "+
	 "('"+cusid +
	 "','"+ContractID +
	 "','"+getDateString("IssuedDate") +
	 "','"+getDateString("ExpiryDate") +
	 "','"+Status +
	 "','"+HomeID +
	 "','"+ProjectID +"')");
		
	System.out.println("ofen check 5");
			
		System.out.println("add ok!");
	} else { System.out.println("not add ..."); }


	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void clearAllInfo() {
	ContractID = 0;
	IssuedDate = null;
	ExpiryDate = null;
	Status = "";
	HomeID = 0;
	ProjectID = 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public Date getDate(String st) {
	if (st.equals("IssuedDate")) {return IssuedDate;}
	if (st.equals("ExpiryDate")) {return ExpiryDate;}
	return null;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String getDateString(String st) {
	if (st.equals("IssuedDate")) {
		if ((""+IssuedDate).length()>30) {
		return ((""+IssuedDate).substring(8,10)+"/"+
			    (""+IssuedDate).substring(4,7)+"/"+
			    (""+IssuedDate).substring(30,34));
		}
	}
	if (st.equals("ExpiryDate")) {
		if ((""+ExpiryDate).length()>30) {
		return ((""+ExpiryDate).substring(8,10)+"/"+
			  	(""+ExpiryDate).substring(4,7)+"/"+
			    (""+ExpiryDate).substring(30,34));
		}
	}

	return "";
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public int getNumber(String st) {
	if (st.equals("ContractID")) {return ContractID;}
	if (st.equals("HomeID")) {return HomeID;}
	if (st.equals("ProjectID")) {return ProjectID;}
	return 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String getString(String st) {
	if (st.equals("Status")) {return Status;}
	return "";
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
		("select * from contract             "+
		 "where contractid = '"+id+"'    and "+
		 "      customerid = '"+cusid+"' and "+
		 "IssuedDate is not null         and "+
		 "ExpiryDate is not null             ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if gound
			
		type.load(conS,c.toInt(""+rset.getString(7))); // define contracttype
			
		System.out.println("ofen2 check 3");
		setNumber("ContractID",c.toInt(""+rset.getString(2)));
		System.out.println("ofen2 check 4");
		setDate("IssuedDate",c.toInt(rset.getString(3).substring(0,4)),
							 m.toString(c.toInt(rset.getString(3).substring(5,7))),
							 c.toInt(rset.getString(3).substring(8,10)));
		setDate("ExpiryDate",c.toInt(rset.getString(4).substring(0,4)),
							 m.toString(c.toInt(rset.getString(4).substring(5,7))),
							 c.toInt(rset.getString(4).substring(8,10)));
		System.out.println("ofen2 check 5");
		setString("Status",""+rset.getString(5));
		setNumber("HomeID",c.toInt(""+rset.getString(6)));
		
		setNumber("ProjectID",c.toInt(""+rset.getString(8)));
		
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
public boolean load(Connection conS,int id,int cusid) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from contract             "+
		 "where contractid = '"+id+"'    and "+
		 "      customerid = '"+cusid+"' and "+
		 "IssuedDate is not null         and "+
		 "ExpiryDate is not null             ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		type.load(conS,c.toInt(""+rset.getString(7)));// define contracttype
		
		System.out.println("ofen2 check 3");
		setNumber("ContractID",c.toInt(""+rset.getString(2)));
		System.out.println("ofen2 check 4");
		setDate("IssuedDate",c.toInt(rset.getString(3).substring(0,4)),
							 m.toString(c.toInt(rset.getString(3).substring(5,7))),
							 c.toInt(rset.getString(3).substring(8,10)));
		setDate("ExpiryDate",c.toInt(rset.getString(4).substring(0,4)),
							 m.toString(c.toInt(rset.getString(4).substring(5,7))),
							 c.toInt(rset.getString(4).substring(8,10)));
		System.out.println("ofen2 check 5");
		setString("Status",""+rset.getString(5));
		setNumber("HomeID",c.toInt(""+rset.getString(6)));

		setNumber("ProjectID",c.toInt(""+rset.getString(8)));
		
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
	stmt.execute ("delete from contract "+
		          "where contractid = '"+ id  +"' "+
		          "  and customerid = '"+cusid+"' ");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void remove(Connection conS,int id,int cusid) throws SQLException, IOException	{
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from contract "+
		          "where contractid = '"+ id  +"' "+
		          "  and customerid = '"+cusid+"' ");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 */
public void setContractType(Connection conS,int typeid) throws SQLException, IOException {
	System.out.println("ofen check 1");
	Statement stmtS = conS.createStatement();
	System.out.println("ofen check 2");
	stmtS.execute("update Contract set						 "+
		          "	   ContractTypeID = '"+typeid+"'		 "+
		          "where  CustomerID = '"+cusid+"' 		 and "+
		          "       ContractID = '"+ContractID+"'      ");
	
	stmtS.close();
	System.out.println("set ContractType ok!");
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setDate(String st,int y,int m,int d) {
	GregorianCalendar cal = new GregorianCalendar(y,m-1,d,0,0,0);
	if (st.equals("IssuedDate")) {IssuedDate = cal.getTime();} else
	if (st.equals("ExpiryDate")) {ExpiryDate = cal.getTime();}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setDate(String st,int y,String mst,int d) {
	GregorianCalendar cal = new GregorianCalendar(y,(m.toInt(mst))-1,d,0,0,0);
	if (st.equals("IssuedDate")) {IssuedDate = cal.getTime();} else
	if (st.equals("ExpiryDate")) {ExpiryDate = cal.getTime();}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setDate2(String st,String d) {
	GregorianCalendar cal;
	if (d.length() == 10) {
		cal = new GregorianCalendar
		(c.toInt(d.substring(6,10)),(m.toInt( d.substring(2,5) ))-1,c.toInt(d.substring(0,1)),0,0,0);

	} else {
		cal = new GregorianCalendar
		(c.toInt(d.substring(7,11)),(m.toInt( d.substring(3,6) ))-1,c.toInt(d.substring(0,2)),0,0,0);
	}
	
	
	if (st.equals("IssuedDate")) {IssuedDate = cal.getTime();} else
	if (st.equals("ExpiryDate")) {ExpiryDate = cal.getTime();}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setNumber(String st,int i) {
	if (st.equals("ContractID")) {ContractID = i;} else
	if (st.equals("HomeID")) {HomeID = i;} else
	if (st.equals("ProjectID")) {ProjectID = i;}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setString(String st,String st2) {
	if (st.equals("Status")) {Status = st2;}
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id) throws SQLException, IOException {
	System.out.println("ofen check 1");

	ContractID = id;
	
	System.out.println("ofen check 3");
	
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Contract "+
	 "(CustomerID,ContractID,IssuedDate,ExpiryDate,Status,HomeID,ProjectID)"+
	 " values "+
	 "(?,?,?,?,?,?,?)");
	
	
	System.out.println("ofen check 5");
	
	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){
		pstmt.setString (1,""+ProjectID);
		pstmt.setString (2,""+cusid);
		pstmt.setString (3,""+ContractID);
		pstmt.setString (4,(""+getDateString("IssuedDate")));
		pstmt.setString (5,(""+getDateString("ExpiryDate")));
		pstmt.setString (6,""+Status);	 
		pstmt.setString (7,""+HomeID);	 

		
		System.out.println("ofen check 6");
		
		remove(conS,id,cusid);

		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	} else { System.out.println("not add ..."); }



	
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id) throws SQLException, IOException {
	System.out.println("ofen check 1");

	ContractID = id;

	Statement stmtS = conS.createStatement();
	System.out.println("ofen check 2");
	stmtS.execute("update Contract set						 "+
		          "	   CustomerID = '"+cusid+"' 			,"+
		          "	   ContractID = '"+id+"' 				,"+
		          "	   IssuedDate = '"+getDateString("IssuedDate")+"'  		,"+
		          "	   ExpiryDate = '"+getDateString("ExpiryDate")+"'  		,"+
		          "	   Status     = '"+Status+"'  			,"+
		          "	   HomeID     = '"+HomeID+"'  			,"+
		          "	   ProjectID  = '"+ProjectID+"'			 "+		          
		          "where  CustomerID = '"+cusid+"' 		 and "+
		          "       ContractID = '"+id+"'              ");
	
	stmtS.close();
	System.out.println("update ok!");
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id,int cusid) throws SQLException, IOException {
	System.out.println("ofen check 1");

	ContractID = id;
	
	System.out.println("ofen check 3");
	
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Contract "+
	 "(CustomerID,ContractID,IssuedDate,ExpiryDate,Status,HomeID,ProjectID)"+
	 " values "+
	 "(?,?,?,?,?,?,?)");
	
	
	System.out.println("ofen check 5");
	
	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){
		pstmt.setString (1,""+ProjectID);
		pstmt.setString (2,""+cusid);
		pstmt.setString (3,""+ContractID);
		pstmt.setString (4,(""+getDateString("IssuedDate")));
		pstmt.setString (5,(""+getDateString("ExpiryDate")));
		pstmt.setString (6,""+Status);	 
		pstmt.setString (7,""+HomeID);	 

		
		System.out.println("ofen check 6");
		
		remove(conS,id,cusid);

		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	} else { System.out.println("not add ..."); }



	
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id,int cusid) throws SQLException, IOException {
	System.out.println("ofen check 1");

	ContractID = id;

	Statement stmtS = conS.createStatement();
	System.out.println("ofen check 2");
	stmtS.execute("update Contract set						 "+
		          "	   CustomerID = '"+cusid+"' 			,"+
		          "	   ContractID = '"+id+"' 				,"+
		          "	   IssuedDate = '"+getDateString("IssuedDate")+"'  		,"+
		          "	   ExpiryDate = '"+getDateString("ExpiryDate")+"'  		,"+
		          "	   Status     = '"+Status+"'  			,"+
		          "	   HomeID     = '"+HomeID+"'  			,"+
		          "	   ProjectID  = '"+ProjectID+"'			 "+		          
		          "where  CustomerID = '"+cusid+"' 		 and "+
		          "       ContractID = '"+id+"'              ");
	
	stmtS.close();
	System.out.println("update ok!");
}
}