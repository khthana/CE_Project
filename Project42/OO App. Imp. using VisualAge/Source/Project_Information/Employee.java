package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class Employee extends Person { // employee inheritance from person
	private int EmployeeID = 0;
	private int TotalPrivilege = 0;
	public Position pos  = new Position(); // add object aggregation 1 to 1
	public Account  acc  = new Account();  // add object aggregation 1 to 1
	public Privilege pri;  // add object aggregation 1 to many
/**
 * Employee constructor comment.
 */
public Employee() {
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
	("select EmployeeID from Employee order by EmployeeID");
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	EmployeeID = id;
	System.out.println("ofen check 3");
	rset.close();
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Employee "+
	 "(EmployeeID,FirstName,LastName,Sex,Nationality,Race,Religion,Status,PresentAddress,"+
	 " Street,District,Province,Telephone,Pager,IDcardNumber,Salary,EnterID,"+
	 " TotalPrivilege)"+
	 " values "+
	 "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	
	System.out.println("ofen check 4");
	

		pstmt.setString (1,""+EmployeeID);
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
		pstmt.setString (16,""+Salary);
		pstmt.setString (17,""+EnterID);
		pstmt.setString (18,""+TotalPrivilege);		
		
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
	("select EmployeeID from Employee order by EmployeeID");
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	EmployeeID = id;
	
	System.out.println("ofen check 3");
	rset.close();

	System.out.println("ofen check 4");
	stmtS.executeQuery
	("insert into Customer "+
 	 "(EmployeeID,FirstName,LastName,Sex,Nationality,Race,Religion,Status,PresentAddress,"+
	 " Street,District,Province,Telephone,Pager,IDcardNumber,Salary,EnterID,"+
	 " TotalPrivilege)"+
	 " values "+
	 "( "+
	        "'"+ EmployeeID    +    "'  ,"+
	        "'"+ Firstname     +    "'  ,"+
	        "'"+ Lastname      +    "'  ,"+
			"'"+ Sex           +    "'  ,"+
			"'"+ Nationality   +    "'  ,"+
			"'"+ Race          +    "'  ,"+
			"'"+ Religion      +    "'  ,"+
			"'"+ Status        +    "'  ,"+
			"'"+ PresentAddress+    "'  ,"+
			"'"+ Street        +    "'  ,"+
			"'"+ District      +    "'  ,"+
		    "'"+ Province      +    "'  ,"+
		    "'"+ Telephone     +    "'  ,"+
		    "'"+ Pager         +    "'  ,"+
		    "'"+ IDcardNumber  +    "'  ,"+
		    "'"+ Salary        +    "'  ,"+
		    "'"+ EnterID       +    "'  ,"+
		    "'"+ TotalPrivilege+    "'   "+
	 ") ");
	System.out.println("ofen check 5");	

		System.out.println("add ok!");



stmtS.close();



}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean checkAcc(Connection conS,int accid) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("employee checkAccount 1");
		ResultSet rset = stmt.executeQuery
		("select * from employee           "+
		 "where accountid = '"+accid+"'      ");
		System.out.println("employee checkAccount 2");
		while (rset.next() & !b) {

		b = true;			

		System.out.println("employee checkAccount 3");
		setNumber("EmployeeID",c.toInt(""+rset.getString(1)));
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
		setNumber("Salary",c.toInt(""+rset.getString(16)));
		setNumber("EnterID",c.toInt(""+rset.getString(17)));
		setNumber("TotalPrivilege",c.toInt(""+rset.getString(18)));

		pri = new Privilege(EmployeeID); // add new privilege object into employee
		pos.load(conS, c.toInt(""+rset.getString(19))); // define position to object position
		acc.load(conS, c.toInt(""+rset.getString(20))); // define accountid to object account

		
		}
		
		
		rset.close();

	System.out.println("end checkAccount");
	stmt.close();
return b;
}
/**
 * This method was created in VisualAge.
 */
public void clearAllInfo() {
	EmployeeID = 0;
	TotalPrivilege = 0;
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
public int getNumber(String st) {
	if (st.equals("Salary")) {return Salary;}
	if (st.equals("EnterID")) {return EnterID;}
	if (st.equals("EmployeeID")) {return EmployeeID;}
	if (st.equals("TotalPrivilege")) {return TotalPrivilege;}
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
		("select * from employee           "+
		 "where employeeid = '"+id+"'      ");
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		pri = new Privilege(id); // add new privilege object into employee
		pos.load(conS, c.toInt(""+rset.getString(19))); // define position to object position
		acc.load(conS, c.toInt(""+rset.getString(20))); // define accountid to object account
 		
		System.out.println("ofen2 check 3");
		setNumber("EmployeeID",c.toInt(""+rset.getString(1)));
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
		setNumber("Salary",c.toInt(""+rset.getString(16)));
		setNumber("EnterID",c.toInt(""+rset.getString(17)));
		setNumber("TotalPrivilege",c.toInt(""+rset.getString(18)));
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
	stmt.execute ("delete from employee where employeeid = '"+id+"'");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param conS java.sql.Connection
 * @param id int
 */
public void setAccount(Connection conS,int aid) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update Employee SET AccountID = '"+aid+"'"+
	 "where EmployeeID = '"+EmployeeID+"'") ;
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setNumber(String st,int i) {
	if (st.equals("Salary")) {Salary = i;} else
	if (st.equals("EnterID")) {EnterID = i;} else
	if (st.equals("EmployeeID")) {EmployeeID = i;} else
	if (st.equals("TotalPrivilege")) {TotalPrivilege = i;}
}
/**
 * This method was created in VisualAge.
 * @param conS java.sql.Connection
 * @param id int
 */
public void setPosition(Connection conS,int pid) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update Employee SET PositionID = '"+pid+"'"+
	 "where EmployeeID = '"+EmployeeID+"'") ;
	stmt.close();
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
	if (st.equals("IDcardNumber")) {IDcardNumber = st2;}

}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id) throws SQLException, IOException {
	System.out.println("ofen check 1");

	EmployeeID = id;
	
	System.out.println("ofen check 3");
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Employee "+
	 "(EmployeeID,FirstName,LastName,Sex,Nationality,Race,Religion,Status,PresentAddress,"+
	 " Street,District,Province,Telephone,Pager,IDcardNumber,Salary,EnterID,"+
	 " TotalPrivilege)"+
	 " values "+
	 "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	
	System.out.println("ofen check 4");
	
		pstmt.setString (1,""+TotalPrivilege);
		pstmt.setString (2,""+EmployeeID);
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
		pstmt.setString (17,""+Salary);
		pstmt.setString (18,""+EnterID);

		System.out.println("ofen check 6");
		remove(conS,id);
		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	
	
	
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id) throws SQLException, IOException {
	System.out.println("ofen check 1");
	
	EmployeeID = id;
	
	Statement stmtS = conS.createStatement();
	System.out.println("ofen check 2");

	stmtS.execute("update Employee set									 "+
		          "	   EnterID = '"+EnterID+"'	 						,"+
		          "	   Salary  = '"+Salary+"' 							,"+
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
		          "	   TotalPrivilege     = '"+TotalPrivilege+"'  		 "+
	   	          "where  EmployeeID = '"+EmployeeID+"' 		  		 ");
	
	stmtS.close();
	System.out.println("update ok!");

}
}