package Project_Information;

import java.io.*;
import java.sql.*;
import java.util.*;
/**
 * This type was created in VisualAge.
 */
public class Company {
	private String CompanyName  = "";
	private int TotalProject = 0;
	Calculate c = new Calculate();
	
/**
 * Company constructor comment.
 */
public Company() {
	super();
}
/**
 * This method was created in VisualAge.
 * @param conS java.sql.Connection
 */
public int countAllCustomer(Connection conS) throws SQLException, IOException {
	int count = 0;
	
	Statement stmt = conS.createStatement();
	ResultSet rset = stmt.executeQuery
	("select count(*) from customer");
	
	while (rset.next()){
		count = c.toInt(""+rset.getString(1));
	}
	rset.close();

	return count;
}
/**
 * This method was created in VisualAge.
 * @param conS java.sql.Connection
 */
public int countAllEmployee(Connection conS) throws SQLException, IOException {
	int count = 0;
	
	Statement stmt = conS.createStatement();
	ResultSet rset = stmt.executeQuery
	("select count(*) from employee");
	
	while (rset.next()){
		count = c.toInt(""+rset.getString(1));
	}
	rset.close();

	return count;
}
/**
 * This method was created in VisualAge.
 * @param conS java.sql.Connection
 */
public int countAllHome(Connection conS) throws SQLException, IOException {
	int count = 0;
	
	Statement stmt = conS.createStatement();
	ResultSet rset = stmt.executeQuery
	("select count(*) from Home");
	
	while (rset.next()){
		count = c.toInt(""+rset.getString(1));
	}
	rset.close();

	return count;
}
/**
 * This method was created in VisualAge.
 * @param conS java.sql.Connection
 */
public int countAllProject(Connection conS) throws SQLException, IOException {
	int count = 0;
	
	Statement stmt = conS.createStatement();
	ResultSet rset = stmt.executeQuery
	("select count(*) from project");
	
	while (rset.next()){
		count = c.toInt(""+rset.getString(1));
	}
	rset.close();

	return count;
}
/**
 * This method was created in VisualAge.
 * @param st java.lang.String
 */
public String getName() {
	return CompanyName;
}
/**
 * This method was created in VisualAge.
 * @param st java.lang.String
 */
public int getTotalProject() {
	return TotalProject;
}
/**
 * This method was created in VisualAge.
 * @param conS java.sql.Connection
 */
public void load(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	ResultSet rset = stmt.executeQuery
	("select CompanyName,TotalProject from Company");
	
	while(rset.next()) {
		CompanyName = ""+rset.getString(1);
		TotalProject = c.toInt(""+rset.getString(2));
	}
	rset.close();
	System.out.println("company load ok");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param st java.lang.String
 */
public void setName(String st) {
	CompanyName = st;
}
/**
 * This method was created in VisualAge.
 * @param st java.lang.String
 */
public void setTotalProject(int i) {
	TotalProject = i;
}
/**
 * This method was created in VisualAge.
 * @param conS java.sql.Connection
 */
public void update(Connection conS) throws SQLException, IOException {
	Statement stmtS = conS.createStatement();
	stmtS.executeQuery("delete from Company");
	stmtS.executeQuery
	("insert into Company "+
	 "(CompanyName,TotalProject)"+
	 "values"+
	 "( '"+CompanyName+"' , '"+TotalProject+"' )");
	stmtS.close();
	System.out.println("company update ok");
}
/**
 * This method was created in VisualAge.
 * @param conS java.sql.Connection
 */
public void upDate(Connection conS) throws SQLException, IOException {
	Statement stmtS = conS.createStatement();
	stmtS.executeQuery("delete from Company");
	stmtS.executeQuery
	("insert into Company "+
	 "(CompanyName,TotalProject)"+
	 "values"+
	 "( '"+CompanyName+"' , '"+TotalProject+"' )");
	stmtS.close();
	System.out.println("company update ok");
}
}