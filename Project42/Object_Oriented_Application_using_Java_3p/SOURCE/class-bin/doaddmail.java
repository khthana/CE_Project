// Class doaddmail

import java.io.*;
import java.lang.*;
import java.sql.*;
import SenderMessage;
import oracle.jdbc.driver.*;

public class doaddmail  implements HttpClassProcessor  {

    protected String data,length,account,password,index,sender,dates,subject,message,status;

    //-------------------------------------------------

    public void initRequest (HttpInputStream in)  throws  IOException
    {
      if (in.getMethod () != HTTP.METHOD_POST)
         throw new HttpException (HTTP.STATUS_NOT_ALLOWED,"Request method<TT>" + in.getMethod() + " </TT> not allowed.");
 // data = in.readLine(); 
 // data = HTTP.decodeString (data);
 data = "account=num&index=1&sender=s0013277@kmitl.ac.th&dates=12-01-2000&subject=Hi  หนุ่ม&message=pongtipakorn&status=1";
 account     = getCode(data);  data = cutString(data);
 index        = getCode(data);  data = cutString(data);
 sender  = getCode(data);  data = cutString(data);
  dates   = getCode(data);        data = cutString(data);
subject     = getCode(data);  data = cutString(data);
message     = getCode(data);  data = cutString(data);
status     = getCode(data);  data = cutString(data);

try{
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
addMail(account,index,sender,dates,subject,message,status);
// delMail(account,password,age);
  }
  catch (SQLException e) {}
   }
  
	//--------------------------------------------------

    public void processRequest(HttpOutputStream out) throws IOException
    {
     out.setHeader("Content-type","text/plain");
		if (out.sendHeaders() )
        {
        out.write(account +"\r\n ");
		out.write(index+" \r\n ");
		out.write(sender+" \r\n ");
		out.write(dates+" \r\n ");
		out.write(subject+" \r\n ");
		out.write(message+" \r\n ");
		out.write(status+" \r\n ");
        }
     }

      static String getCode(String str)
     {
        int index_equal = str.indexOf('=');
        int index_and   = str.indexOf('&');
            try
            {
              return (str.substring(index_equal+1,index_and));
            }
        catch (Exception e)
            {
              return (str.substring(index_equal+1));
            }
     }

     static String cutString(String str)
     {
        int index_equal = str.indexOf('=');
        int index_and   = str.indexOf('&');
            return (HTTP.decodeString(str.substring(index_and+1)));
     }

     static boolean checkPassWord(String truePwd,String passWord)
	  {
		    return (truePwd.equals(passWord) );
	  }

	  static boolean checkLoginName(String trueName,String loginName)
	  {
		    return (trueName.equals(loginName) );
	  }

    static boolean checkDualPassWord(String firstPwd,String secondPwd)
    {
        return (firstPwd.equals(secondPwd) );
    }

	public static void addMail(String account,String index,String sender,String dates,String subject,String message,String status)
	throws SQLException {
	String  sql = "INSERT INTO datamail VALUES(?,?,?,?,?,?,?)";
try {
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1,account);
	  pstmt.setString(2,index);
	  pstmt.setString(3,sender);
	  pstmt.setString(4,dates);
	  pstmt.setString(5,subject);
	  pstmt.setString(6,message);
	  pstmt.setString(7,status);
//	  pstmt.setInt(4,age);
	  pstmt.executeUpdate();
	  pstmt.close();
	    } catch (SQLException e) { System.err.println(e.getMessage()); }
    }  // end  addMail

public static void delMail(String account,String password,String age) // used account only
	throws SQLException {
	String  sql = "DELETE  FROM  Mail  Where account = ?";
try {
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1,account);
	  pstmt.executeUpdate();
	  pstmt.close();
	    } catch (SQLException e) { System.err.println(e.getMessage()); }
    }  // end  delMail



  }  // end class Echo.java
