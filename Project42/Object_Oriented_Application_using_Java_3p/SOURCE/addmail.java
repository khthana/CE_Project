import doaddmail;
import java.sql.*;
import oracle.jdbc.driver.*;


public class addmail
{
   public static void main(String args[])
   {
  try {
   DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
   doaddmail.addMail("kong","1","s0013277@kmitl.ac.th","1231","12312","test addmail","1");
      } catch (Exception e) {}
   }
}