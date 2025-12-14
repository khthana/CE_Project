package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class MapImage {
	private int MapImageID=0;
	private String ImageFile="";
	Calculate c = new Calculate();
/**
 * Position constructor comment.
 */
public MapImage() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public int getID() {
	return MapImageID;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public String getName() {
	return ImageFile;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void load(Connection conS,int id) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	ResultSet rset  = stmt.executeQuery
	("select * from MapImage where MapImageid = '"+id+"'");
	while (rset.next()) {
		MapImageID = c.toInt(""+rset.getString(1));
		ImageFile = ""+rset.getString(2);
	}
	rset.close();
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public void setID(int id) {
	MapImageID = id;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void setName(String st) {
	ImageFile = st;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void update(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update MapImage SET ImageFile = '"+ImageFile+"'"+
	 "where MapImageID = '"+MapImageID+"'") ;
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void upDate(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update MapImage SET ImageFile = '"+ImageFile+"'"+
	 "where MapImageID = '"+MapImageID+"'") ;
	stmt.close();
}
}