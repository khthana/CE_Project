package DBandGUI_Management;

import java.io.*;
import java.sql.*;
import oracle.jdbc.driver.*;
import oracle.jdbc.oci7.*;
import java.lang.Integer;
import java.lang.*;
/**
 * This type was created in VisualAge.
 */
public class MainDB {
	static Integer i ;

/**
 * DB constructor comment.
 */
public MainDB() {
	super();
}
/**
 * This method was created in VisualAge.
	 */
public void bacModelTableBac_StudentNew(Connection conS,Connection conDW,String Y) throws SQLException, IOException {
	Statement stmtS = conS.createStatement ();
	Statement stmtDW = conDW.createStatement ();
	Statement stmtY = conS.createStatement ();
	Statement stmtG = conS.createStatement ();
	Statement stmtB = conS.createStatement ();
	
	PreparedStatement pstmt;
	int Yint = toInt(Y);
	boolean di2 = false;
	
	System.out.print ("BacModel Check OUTYR from Student ...");
	ResultSet rset2 = stmtS.executeQuery 
	("select outyr from ungrad.student_ where outyr = "+(Yint-1-2500)+"group by outyr");
	if (rset2.next()) { di2 = true;}

  
	if ( di2 ) {
  	 System.out.println (" Complete !!! = "+"25"+rset2.getString(1));
	 rset2.close();
	System.out.print ("BacModel Check YEAR from Bac_StudentNew1 ...");	  
	
	 ResultSet rset3 = stmtDW.executeQuery 
	 ("select year from bac_studentnew1 where year = '"+(toInt(Y))+"'");

	 boolean di1 = true;

	 if (rset3.next ()) {
		 	di1 = false;
	  	    if (rset3.getString(1).equals( ""+(toInt(Y)) )  ) {di1 = false;}
   	 }
	 rset3.close();


	if ( di1 )  {
	 System.out.println (" Complete !!!");
	 
	System.out.print (" Define Statement for Insert to Bac_StudentNew1 ...");

	ResultSet rset = stmtS.executeQuery
	("select s.facid,c.brnid,s.sex,s.year#,s.stdstate,count(*)     "+
	"from ungrad.student_ s,ungrad.curriculum_ c				  "+
	"where (s.stdstate = '1' or s.stdstate = '2')                 "+
	"  and c.crcid = s.crcid                                      "+
	"  and c.facid = s.facid                                      "+
	"  and s.sex is not null                                      "+
	"  and year# is not null								      "+
	"group by s.facid,c.brnid,s.sex,s.year#,s.stdstate            "+
	"order by s.facid,c.brnid,s.sex,s.year#,s.stdstate            ");

/*	(" select s.facid,c.brnid,s.sex,s.year#,s.stdstate,count(s.year#) "+
	 "  from ungrad.student_ s,ungrad.curriculum_ c                   "+
	 "  where (s.stdstate = '1' or s.stdstate = '2')				  "+
	 "	and c.crcid = s.crcid										  "+
   	 "	and s.sex is not null										  "+
	 " 	and year# is not null										  "+
	 "  group by s.facid,c.brnid,s.sex,s.year#,s.stdstate			  "+
	 "  order by s.facid,c.brnid,s.sex,s.year#,s.stdstate 			  ");
*/
 	pstmt =conDW.prepareStatement 
 	("insert into bac_studentnew1 										"+
	 "(Branch,campus,Sex,y_1,y_2,y_3,y_4,y_5,y_6,y_7,y_8,bachelor,Year) "+
	 "values (?,?,?,?,?,?,?,?,?,?,?,?,?)					    	    ");
 	
	System.out.println (" OK !!!");	  
	
	
	String FACID, BRNID, SEX; // variable for server
	FACID=BRNID=SEX="";
	String branch,campus,sex,year;
	branch=campus=sex=year="";
	int y_1,y_2,y_3,y_4,y_5,y_6,y_7,y_8,bachelor; // variable for DW
	y_1=y_2=y_3=y_4=y_5=y_6=y_7=y_8=bachelor=0;   // initial values
	
	System.out.println ("BacModel Insert to DW Table Bac_StudentNew1 Start ...");

//  server         col = s.facid,c.brnid,s.sex,s.year#,s.stdstate,count(s.year#)
//  server to data warehouse
//  data warehouse col = Branch,campus,Sex,y_1,y_2,y_3,y_4,y_5,y_6,y_7,y_8,bachelor,Year

	boolean nextRow = false;
	boolean startInsert = true;
	boolean countBachelor = false;
	
	while (rset.next ())
	 {

	  	if ( !FACID.equals(rset.getString(1)) ){FACID  =  rset.getString(1);nextRow = true;}
	 	if ( !BRNID.equals(rset.getString(2)) ){BRNID  =  rset.getString(2);nextRow = true;}
	 	if ( !SEX.equals(rset.getString(3))   ){SEX    =  rset.getString(3);nextRow = true;}
	 	

	  if (nextRow) {
		if (!startInsert) {
			pstmt.setString (1,year);
	 		pstmt.setString (2,branch);
		 	pstmt.setString (3,campus);
	 		pstmt.setString (4,sex);
	 		pstmt.setString (5,""+y_1);
	 		pstmt.setString (6,""+y_2);
	 		pstmt.setString (7,""+y_3);
	 		pstmt.setString (8,""+y_4);
	 		pstmt.setString (9,""+y_5);
	 		pstmt.setString (10,""+y_6);
	 		pstmt.setString (11,""+y_7);
	 		pstmt.setString (12,""+y_8);
	 		pstmt.setString (13,""+bachelor);
		  	pstmt.execute ();
		 // System.out.println 
	 			//("write row = "+branch+" "+campus+" "+sex+
	  			// " "+y_1+" "+y_2+" "+y_3+" "+y_4+" "+y_5+
	  			// " "+y_6+" "+y_7+" "+y_8+" "+bachelor+" "+year);
	 	  y_1=y_2=y_3=y_4=y_5=y_6=y_7=y_8=bachelor=0;
	 	}

	  	branch  = "0"+FACID+BRNID;
	  	campus  = "C1";
	  	sex = SEX;
	  	year = Y;
	    nextRow = false;
	    startInsert = false;
	  }
  

	 if( rset.getString(5).equals("2") ) {
		countBachelor = true;
	 } else countBachelor = false;

	 if (countBachelor) {
		 bachelor+=toInt(rset.getString(6));
	 }
	 else {
		 switch ( rset.getString(4).charAt(0) ) {
			 case '1':y_1=toInt(rset.getString(6));break;
			 case '2':y_2=toInt(rset.getString(6));break;
			 case '3':y_3=toInt(rset.getString(6));break;
			 case '4':y_4=toInt(rset.getString(6));break;
			 case '5':y_5=toInt(rset.getString(6));break;
			 case '6':y_6=toInt(rset.getString(6));break;
			 case '7':y_7=toInt(rset.getString(6));break;
			 case '8':y_8=toInt(rset.getString(6));break;
		 }
	 }
	 
  	} // end while
	
	 System.out.println ("Bac Model Table Bac_StudentNew1 Finisted !!!");
	
   } else {
	    System.out.println ("");
   		System.out.println ("Year input have in Data Warehouse,now. Can't insert !!!");
   	 }
  } else {
		System.out.println ("");
  		System.out.println ("OUTYR have not in server KMITL,now. Can't Query !!!");
  	 }
}
/**
 * This method was created in VisualAge.
 */
public Connection connectServer() throws SQLException, IOException {
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
Connection conS =
DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.121:1521:orcl","Project","july97");
return conS;
}
/**
 * This method was created in VisualAge.
 * @param args java.lang.String[]
 */
public static void main(String args[]) {
}
/**
 * This method was created in VisualAge.
 * @return Int
 * @param st java.lang.String
 */
public int toInt(String st) {
	return Integer.parseInt(st);
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param st java.lang.String
 */
public String toThai(String st) {
	StringBuffer database = new StringBuffer ();
 	for(int l=0;l < st.length();l++) {
		database.append((char)(160+((int)(st.charAt(l))))); 
	}
	return (database.toString ().trim ());
}
}