package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class Position {
	private int PositionID=0;
	private String PositionName="";
	Calculate c = new Calculate();

/**
 * Position constructor comment.
 */
public Position() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public int getID() {
	return PositionID;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public String getName() {
	return PositionName;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void load(Connection conS,int id) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	ResultSet rset  = stmt.executeQuery
	("select * from position where positionid = '"+id+"'");
	while (rset.next()) {
		PositionID = c.toInt(rset.getString(1));
		PositionName = rset.getString(2);
	}
	rset.close();
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void setName(String st) {
	PositionName = st;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void update(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update Position SET PositionName = '"+PositionName+"'"+
	 "where PositionID = '"+PositionID+"'") ;
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void upDate(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update Position SET PositionName = '"+PositionName+"'"+
	 "where PositionID = '"+PositionID+"'") ;
	stmt.close();
}
}