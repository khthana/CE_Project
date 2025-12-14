package Project_Information;

import java.io.*;
import java.sql.*;
import java.util.Date;
import java.util.GregorianCalendar;
/**
 * This type was created in VisualAge.
 */
public class Customer extends Person { // customer inheritance from person
	private int CustomerID = 0;
	private String IssuedAt = "";
	private Date IssuedDate = null;
	private Date ExpiryDate = null;
	private String Occupation = "";
	private String Company = "";
	private int TotalContract = 0;
	public Contract con; // add aggregation 1 to many
/**
 * Customer constructor comment.
 */
public Customer() {
	super();
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
	("select CustomerID from Customer order by CustomerID");
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	CustomerID = id;
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Customer "+
	 "(CustomerID,FirstName,LastName,Sex,Nationality,Race,Religion,Status,PresentAddress,"+
	 " Street,District,Province,Telephone,Pager,IDcardNumber,IssuedAt,IssuedDate,"+
	 " ExpiryDate,Occupation,Company,Salary,EnterID,TotalContract)"+
	 " values "+
	 "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	System.out.println("ofen check 4");
	
	System.out.println(""+getDateString("IssuedDate"));
	System.out.println(""+getDateString("ExpiryDate"));
	
	System.out.println("ofen check 5");
	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){
		
		pstmt.setString (1,""+CustomerID);
		pstmt.setString (2,""+Firstname);
		pstmt.setString (3,""+Lastname);	 
		pstmt.setString (4,""+Sex);	 
		pstmt.setString (5,""+Nationality);	 
		pstmt.setString (6,""+Race);	 
		pstmt.setString (7,""+Religion);	 
		pstmt.setString (8,""+Status);	
		pstmt.setString (9 ,""+PresentAddress);	
		pstmt.setString (10,""+Street);	
		pstmt.setString (11,""+District);
		pstmt.setString (12,""+Province);
		pstmt.setString (13,""+Telephone);	 
		pstmt.setString (14,""+Pager);	 
		pstmt.setString (15,""+IDcardNumber);	 
		pstmt.setString (16,""+IssuedAt);
		pstmt.setString (17,(""+getDateString("IssuedDate")));
		pstmt.setString (18,(""+getDateString("ExpiryDate")));
		pstmt.setString (19,""+Occupation);
		pstmt.setString (20,""+Company);	 
		pstmt.setString (21,""+Salary);	 
		pstmt.setString (22,""+EnterID);
		pstmt.setString (23,""+TotalContract);
		System.out.println("ofen check 6");
		pstmt.execute();
		System.out.println("ofen check 7");
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
	("select CustomerID from Customer order by CustomerID");
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	CustomerID = id;
	System.out.println("ofen check 3");
	rset.close();

	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){
	stmtS.executeQuery
	("insert into Customer "+
	 "(CustomerID,FirstName,LastName,Sex,Nationality,Race,Religion,Status,PresentAddress,"+
	 " Street,District,Province,Telephone,Pager,IDcardNumber,IssuedAt,IssuedDate,"+
	 " ExpiryDate,Occupation,Company,Salary,EnterID,TotalContract)"+
	 " values "+
	 "('"+CustomerID +
	 "','"+Firstname +
	 "','"+Lastname +
	 "','"+Sex +
	 "','"+Nationality +
	 "','"+Race +
	 "','"+Religion +
	 "','"+Status +
	 "','"+PresentAddress +
	 "','"+Street +
	 "','"+District +
	 "','"+Province +
	 "','"+Telephone +
	 "','"+Pager +
	 "','"+IDcardNumber +
	 "','"+IssuedAt +
	 "','"+getDateString("IssuedDate") +
	 "','"+getDateString("ExpiryDate") +
	 "','"+Occupation +
	 "','"+Company +
	 "','"+Salary +
	 "','"+EnterID +
	 "','"+TotalContract +
	 "')");
	System.out.println("ofen check 4");
	
	System.out.println(""+getDateString("IssuedDate"));
	System.out.println(""+getDateString("ExpiryDate"));
	
	System.out.println("ofen check 5");
		
	System.out.println("add ok!");
	} else { System.out.println("not add ..."); }


	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add3(Connection conS) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	ResultSet rset  = stmtS.executeQuery  
	("select CustomerID from Customer order by CustomerID");
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	CustomerID = id;
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Customer "+
	 "(CustomerID,FirstName,LastName,Sex,Nationality,Race,Religion,Status,PresentAddress,"+
	 " Street,District,Province,Telephone,Pager,IDcardNumber,IssuedAt,IssuedDate,"+
	 " ExpiryDate,Occupation,Company,Salary,EnterID,TotalContract)"+
	 " values "+
	 "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	System.out.println("ofen check 4");
	
	System.out.println(""+getDateString("IssuedDate"));
	System.out.println(""+getDateString("ExpiryDate"));
	
	System.out.println("ofen check 5");
	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){

	 	pstmt.setString (1,""+TotalContract);
		pstmt.setString (2,""+CustomerID);
		pstmt.setString (3,""+Firstname);
		pstmt.setString (4,""+Lastname);	 
		pstmt.setString (5,""+Sex);	 
		pstmt.setString (6,""+Nationality);	 
		pstmt.setString (7,""+Race);	 
		pstmt.setString (8,""+Religion);	 
		pstmt.setString (9,""+Status);	
		pstmt.setString (10 ,""+PresentAddress);	
		pstmt.setString (11,""+Street);	
		pstmt.setString (12,""+District);
		pstmt.setString (13,""+Province);
		pstmt.setString (14,""+Telephone);	 
		pstmt.setString (15,""+Pager);	 
		pstmt.setString (16,""+IDcardNumber);	 
		pstmt.setString (17,""+IssuedAt);
		pstmt.setString (18,(""+getDateString("IssuedDate")));
		pstmt.setString (19,(""+getDateString("ExpiryDate")));
		pstmt.setString (20,""+Occupation);
		pstmt.setString (21,""+Company);	 
		pstmt.setString (22,""+Salary);	 
		pstmt.setString (23,""+EnterID);
		
		System.out.println("ofen check 6");
		pstmt.execute();
		System.out.println("ofen check 7");
		pstmt.close();
		System.out.println("add ok!");
	} else { System.out.println("not add ..."); }


	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void clearAllInfo() {
	CustomerID = 0;
	IssuedAt = "";
	IssuedDate = null;
	ExpiryDate = null;
	Occupation = "";
	Company = "";
	TotalContract = 0;
	Firstname = "";
	Lastname = "";
	Sex = "";
	Nationality = "";
	Race = "";
	Religion = "";
	Status = "";
	PresentAddress = "";
	Street = "";
	District = "";
	Province = "";
	Telephone = "";
	Pager = "";
	IDcardNumber = "";
	Salary = 0;
	EnterID = 0;	
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
	if (st.equals("Salary")) {return Salary;}
	if (st.equals("EnterID")) {return EnterID;}
	if (st.equals("CustomerID")) {return CustomerID;}
	if (st.equals("TotalContract")) {return TotalContract;}
	return 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String getString(String st) {
	if (st.equals("Firstname")) {return Firstname;}
	if (st.equals("Lastname")) {return Lastname;}
	if (st.equals("Sex")) {return Sex;}
	if (st.equals("Nationality")) {return Nationality;}
	if (st.equals("Race")) {return Race;}
	if (st.equals("Religion")) {return Religion;}
	if (st.equals("Status")) {return Status;}
	if (st.equals("PresentAddress")) {return PresentAddress;}
	if (st.equals("Street")) {return Street;}
	if (st.equals("District")) {return District;}
	if (st.equals("Province")) {return Province;}
	if (st.equals("Telephone")) {return Telephone;}
	if (st.equals("Pager")) {return Pager;}
	if (st.equals("IDcardNumber")) {return IDcardNumber;}
	if (st.equals("IssuedAt")) {return IssuedAt;}
	if (st.equals("Occupation")) {return Occupation;}
	if (st.equals("Company")) {return Company;}
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
		("select * from customer          "+
		 "where customerid = '"+id+"' and "+
		 "IssuedDate is not null      and "+
		 "ExpiryDate is not null          ");
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		con = new Contract(id); // add new contract into customer
		
		System.out.println("ofen2 check 3");
		setNumber("CustomerID",c.toInt(""+rset.getString(1)));
		setString("Firstname",""+rset.getString(2));
		setString("Lastname",""+rset.getString(3));
		setString("Sex",""+rset.getString(4));
		setString("Nationality",""+rset.getString(5));
		setString("Race",""+rset.getString(6));
		setString("Religion",""+rset.getString(7));
		setString("Status",""+rset.getString(8));
		setString("PresentAddress",""+rset.getString(9));
		setString("Street",""+rset.getString(10));
		setString("District",""+rset.getString(11));
		setString("Province",""+rset.getString(12));
		setString("Telephone",""+rset.getString(13));
		setString("Pager",""+rset.getString(14));
		setString("IDcardNumber",""+rset.getString(15));
		setString("IssuedAt",""+rset.getString(16));

		System.out.println("ofen2 check 4");
		setDate("IssuedDate",c.toInt(rset.getString(17).substring(0,4)),
							 m.toString(c.toInt(rset.getString(17).substring(5,7))),
							 c.toInt(rset.getString(17).substring(8,10)));
		setDate("ExpiryDate",c.toInt(rset.getString(18).substring(0,4)),
							 m.toString(c.toInt(rset.getString(18).substring(5,7))),
							 c.toInt(rset.getString(18).substring(8,10)));
		
		System.out.println("ofen2 check 5");
		setString("Occupation",""+rset.getString(19));
		setString("Company",""+rset.getString(20));
		setNumber("Salary",c.toInt(""+rset.getString(21)));
		setNumber("EnterID",c.toInt(""+rset.getString(22)));
		setNumber("TotalContract",c.toInt(""+rset.getString(23)));

		
/*		System.out.println(""+CustomerID+" : "+c.toInt(rset.getString(1)));
		System.out.println(""+Firstname+" : "+rset.getString(2));
		System.out.println(""+Lastname+" : "+rset.getString(3));
		System.out.println(""+Sex+" : "+rset.getString(4));
		System.out.println(""+Nationality+" : "+rset.getString(5));
		System.out.println(""+Race+" : "+rset.getString(6));
		System.out.println(""+Religion+" : "+rset.getString(7));
		System.out.println(""+Status+" : "+rset.getString(8));
		System.out.println(""+PresentAddress+" : "+rset.getString(9));
		System.out.println(""+Street+" : "+rset.getString(10));
		System.out.println(""+District+" : "+rset.getString(11));
		System.out.println(""+Province+" : "+rset.getString(12));
		System.out.println(""+Telephone+" : "+rset.getString(13));
		System.out.println(""+Pager+" : "+rset.getString(14));
		System.out.println(""+IssuedAt+" : "+rset.getString(16));
		System.out.println(""+getDateString("IssuedDate"));
		System.out.println(""+getDateString("ExpiryDate"));
		System.out.println(""+IssuedDate+" : "+c.toInt(rset.getString(17).substring(0,4))+
							 m.toString(c.toInt(rset.getString(17).substring(5,7)))+
							 c.toInt(rset.getString(17).substring(8,10)));
		System.out.println(""+ExpiryDate+" : "+c.toInt(rset.getString(18).substring(0,4))+
							 m.toString(c.toInt(rset.getString(18).substring(5,7)))+
							 c.toInt(rset.getString(18).substring(8,10)));
		System.out.println(""+Occupation+" : "+rset.getString(19));
		System.out.println(""+Company+" : "+rset.getString(20));
		System.out.println(""+Salary+" : "+c.toInt(rset.getString(21)));
		System.out.println(""+EnterID+" : "+c.toInt(rset.getString(22)));
		System.out.println(""+TotalContract+" : "+c.toInt(rset.getString(23)));*/
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
	stmt.execute ("delete from customer where customerid = '"+id+"'");
	System.out.print("remove customer !!!");
	stmt.close();
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
	if (st.equals("Salary")) {Salary = i;} else
	if (st.equals("EnterID")) {EnterID = i;} else
	if (st.equals("CustomerID")) {CustomerID = i;} else
	if (st.equals("TotalContract")) {TotalContract = i;}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setString(String st,String st2) {
	if (st.equals("Firstname")) {Firstname = st2;} else
	if (st.equals("Lastname")) {Lastname = st2;} else
	if (st.equals("Sex")) {Sex = st2;} else
	if (st.equals("Nationality")) {Nationality = st2;} else
	if (st.equals("Race")) {Race = st2;} else
	if (st.equals("Religion")) {Religion = st2;} else
	if (st.equals("Status")) {Status = st2;} else
	if (st.equals("PresentAddress")) {PresentAddress = st2;} else
	if (st.equals("Street")) {Street = st2;} else
	if (st.equals("District")) {District = st2;} else
	if (st.equals("Province")) {Province = st2;} else
	if (st.equals("Telephone")) {Telephone = st2;} else
	if (st.equals("Pager")) {Pager = st2;} else
	if (st.equals("IDcardNumber")) {IDcardNumber = st2;} else
	if (st.equals("IssuedAt")) {IssuedAt = st2;} else 
	if (st.equals("Occupation")) {Occupation = st2;} else
	if (st.equals("Company")) {Company = st2;}

}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id) throws SQLException, IOException {
	System.out.println("delete & update ofen check 1");
	
	// find last row or empty row for insert data;
	CustomerID = id;


	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Customer "+
	 "(CustomerID,FirstName,LastName,Sex,Nationality,Race,Religion,Status,PresentAddress,"+
	 " Street,District,Province,Telephone,Pager,IDcardNumber,IssuedAt,IssuedDate,"+
	 " ExpiryDate,Occupation,Company,Salary,EnterID,TotalContract)"+
	 " values "+
	 "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	System.out.println("ofen check 4");
	
	System.out.println(""+getDateString("IssuedDate"));
	System.out.println(""+getDateString("ExpiryDate"));
	
	System.out.println("ofen check 5");
	if ( !(getDateString("IssuedDate").equals("")) && 
		 !(getDateString("ExpiryDate").equals(""))  ){
		pstmt.setString (1,""+TotalContract);
		pstmt.setString (2,""+CustomerID);
		pstmt.setString (3,""+Firstname);
		pstmt.setString (4,""+Lastname);	 
		pstmt.setString (5,""+Sex);	 
		pstmt.setString (6,""+Nationality);	 
		pstmt.setString (7,""+Race);	 
		pstmt.setString (8,""+Religion);	 
		pstmt.setString (9,""+Status);	
		pstmt.setString (10,""+PresentAddress);	
		pstmt.setString (11,""+Street);	
		pstmt.setString (12,""+District);
		pstmt.setString (13,""+Province);
		pstmt.setString (14,""+Telephone);	 
		pstmt.setString (15,""+Pager);	 
		pstmt.setString (16,""+IDcardNumber);	 
		pstmt.setString (17,""+IssuedAt);
		pstmt.setString (18,(""+getDateString("IssuedDate")));
		pstmt.setString (19,(""+getDateString("ExpiryDate")));
		pstmt.setString (20,""+Occupation);
		pstmt.setString (21,""+Company);	 
		pstmt.setString (22,""+Salary);	 
		pstmt.setString (23,""+EnterID);
		System.out.println("ofen check 6");
		remove(conS,id);
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
	
	CustomerID = id;
	
	Statement stmtS = conS.createStatement();
	System.out.println("ofen check 2");

	stmtS.execute("update Customer set									 "+
		          "	   EnterID = '"+EnterID+"'	 						,"+
		          "	   Salary  = '"+Salary+"' 							,"+
		          "	   Company = '"+Company+"' 							,"+
		          "	   Occupation = '"+Occupation+"' 					,"+
		          "	   IssuedDate = '"+getDateString("IssuedDate")+"'  	,"+
		          "	   ExpiryDate = '"+getDateString("ExpiryDate")+"'  	,"+
  		          "	   IssuedAt = '"+IssuedAt+"' 						,"+
		          "	   IDcardNumber = '"+IDcardNumber+"' 				,"+
		          "	   Pager = '"+Pager+"' 								,"+
		          "	   Telephone = '"+Telephone+"' 						,"+
		          "	   Province = '"+Province+"' 						,"+
		          "	   District = '"+District+"' 						,"+
		          "	   Street = '"+Street+"' 							,"+
		          "	   PresentAddress = '"+PresentAddress+"' 			,"+
		          "	   Status = '"+Status+"' 							,"+
		          "	   Religion = '"+Religion+"' 						,"+		          
		          "	   Race = '"+Race+"' 								,"+
		          "	   Nationality     = '"+Nationality+"'  			,"+
		          "	   Sex     = '"+Sex+"'  							,"+
		          "	   Lastname     = '"+Lastname+"'  					,"+
		          "	   Firstname     = '"+Firstname+"'  				,"+
		          "	   CustomerID     = '"+CustomerID+"'  				,"+
		          "	   TotalContract     = '"+TotalContract+"'  		 "+
	   	          "where  CustomerID = '"+CustomerID+"' 		  		 ");
	
	stmtS.close();
	System.out.println("update ok!");
}
}