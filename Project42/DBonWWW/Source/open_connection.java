import java.io.*;
import java.sql.*;

public class open_connection
{
  Connection con = null;
  Statement stmt = null;

 public void connectdb()
 {
  try
  {
   DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
   // Get a Connection to the database
    con=DriverManager.getConnection("jdbc:oracle:thin:@"+connect.hostname+":"+
                                    connect.portnumber+":"+connect.databaseSID
                                    ,connect.username,connect.password);
  
   stmt = con.createStatement();
  }
  catch(SQLException ex)
  {
   System.out.println("error while initializingg database connection"+ex.toString());
  } 
 }
}