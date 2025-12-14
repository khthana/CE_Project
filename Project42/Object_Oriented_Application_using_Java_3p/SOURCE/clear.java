import java.io.*;
import java.lang.*;
import java.sql.*;
import oracle.jdbc.driver.*;
import doaddmail;


class   clear  	
{
	public static void main(String[] args)  	
	{
		System.out.println("Hello World!");
		try{
// clearStatus("kong","1");		
  test("kong");
           }
		   catch(SQLException e) { System.out.println(e.getMessage()); }
	}


	public static void clearStatus(String account,String index) 	throws SQLException
{
	String sql = "update datamail  set  status = ?  where account= "+"'"+account+"'"+" and indexs = "+"'"+index+"'";
   try
   {
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
   	PreparedStatement  pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,"0");
	pstmt.executeUpdate();
	pstmt.close();
   }
   catch (SQLException e)
   {
   System.err.println(e.getMessage());
   }  
   } // clear status

   public static void test (String account)  	throws SQLException {
try{
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver()); 
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	Statement stmt = conn.createStatement ();
	String sql = "SELECT sender FROM datamail where account= "+"'"+account+"'";
    ResultSet rset = stmt.executeQuery (sql);
	while ( rset.next () )
	{
	     String  sender = rset.getString(1);
          System.out.println(sender);
      }
   } //try
   catch (SQLException e) {  System.out.print(e);   }    
    }  // end  addMail

}
