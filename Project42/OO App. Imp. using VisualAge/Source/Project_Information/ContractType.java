package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class ContractType {
	private int ContractTypeID=0;
	private String ContractTypeName="";
	Calculate c = new Calculate();
	
/**
 * Position constructor comment.
 */
public ContractType() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public int getID() {
	return ContractTypeID;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param id int
 */
public String getName() {
	return ContractTypeName;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void load(Connection conS,int id) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	ResultSet rset  = stmt.executeQuery
	("select * from ContractType where ContractTypeid = '"+id+"'");
	while (rset.next()) {
		ContractTypeID = c.toInt(""+rset.getString(1));
		ContractTypeName = ""+rset.getString(2);
	}
	rset.close();
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void setName(String st) {
	ContractTypeName = st;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void update(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update ContractType SET ContractTypeName = '"+ContractTypeName+"'"+
	 "where ContractTypeID = '"+ContractTypeID+"'") ;
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void upDate(Connection conS) throws SQLException, IOException {
	Statement stmt = conS.createStatement();
	stmt.executeQuery
	("Update ContractType SET ContractTypeName = '"+ContractTypeName+"'"+
	 "where ContractTypeID = '"+ContractTypeID+"'") ;
	stmt.close();
}
}