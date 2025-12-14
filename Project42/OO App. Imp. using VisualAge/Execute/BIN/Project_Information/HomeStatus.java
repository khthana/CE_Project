package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class HomeStatus {
	private int HomeStatusID=0;
	private String HomeStatusName="";
	Calculate c = new Calculate();

/**
 * Position constructor comment.
 */
public HomeStatus() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public int getID() {
	return HomeStatusID;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public String getName() {
	return HomeStatusName;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void load(Connection conS,int id) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	ResultSet rset  = stmt.executeQuery
	("select * from HomeStatus where HomeStatusid = '"+id+"'");
	while (rset.next()) {
		HomeStatusID = c.toInt(""+rset.getString(1));
		HomeStatusName = ""+rset.getString(2);
	}
	rset.close();
	stmt.close();
//	System.out.println("end home status load");
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public void setID(int id) {
	HomeStatusID = id;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void setName(String st) {
	HomeStatusName = st;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void update(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update HomeStatus SET HomeStatusName = '"+HomeStatusName+"'"+
	 "where HomeStatusID = '"+HomeStatusID+"'") ;
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void upDate(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update HomeStatus SET HomeStatusName = '"+HomeStatusName+"'"+
	 "where HomeStatusID = '"+HomeStatusID+"'") ;
	stmt.close();
}
}