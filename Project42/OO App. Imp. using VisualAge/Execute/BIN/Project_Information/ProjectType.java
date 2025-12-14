package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class ProjectType {
	private int ProjectTypeID=0;
	private String ProjectTypeName="";
	Calculate c = new Calculate();
	
/**
 * Position constructor comment.
 */
public ProjectType() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public int getID() {
	return ProjectTypeID;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public String getName() {
	return ProjectTypeName;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void load(Connection conS,int id) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	ResultSet rset  = stmt.executeQuery
	("select * from ProjectType where ProjectTypeid = '"+id+"'");
	while (rset.next()) {
		ProjectTypeID = c.toInt(""+rset.getString(1));
		ProjectTypeName = ""+rset.getString(2);
	}
	rset.close();
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void setName(String st) {
	ProjectTypeName = st;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void update(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update ProjectType SET ProjectTypeName = '"+ProjectTypeName+"'"+
	 "where ProjectTypeID = '"+ProjectTypeID+"'") ;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void upDate(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update ProjectType SET ProjectTypeName = '"+ProjectTypeName+"'"+
	 "where ProjectTypeID = '"+ProjectTypeID+"'") ;
}
}