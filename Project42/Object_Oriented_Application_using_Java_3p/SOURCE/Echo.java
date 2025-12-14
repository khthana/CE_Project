// Class ckpwd

import java.io.*;
import java.lang.*;
import java.sql.*;
// import oracle.jdbc.driver.*;

public class Echo implements HttpClassProcessor  {

    protected String message,length,account,password,name,email,pwd,a;
    protected int i=0,error=1;


    //-------------------------------------------------

    public void initRequest (HttpInputStream in)  throws  IOException
    {
      if (in.getMethod () != HTTP.METHOD_GET)
         throw new HttpException (HTTP.STATUS_NOT_ALLOWED,"Request method<TT>" + in.getMethod() + " </TT> not allowed.");

    }
    //--------------------------------------------------

    public void processRequest(HttpOutputStream out) throws IOException
    {




     out.setHeader("Content-type","text/html");

		if (out.sendHeaders() )
        {

        out.write("<html>");
        out.write("<title>");
        out.write("Test Nim");
		
        out.write("</title>");
        out.write("<body>");
//    	out.write("<INPUT TYPE =  file NAME =  kong >");  
        out.write("<applet code = upload.class> </applet>");
        out.write("<br>Successfulddd");


        out.write("</body>");
        out.write("</html>");

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

	public static void addMail(String account,String password,String message,int age)
	throws SQLException {
	String  sql = "INSERT INTO Mail VALUES(?,?,?,?)";
try {
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	PreparedStatement pstmt = conn.prepareStatement(sql);
	//pstmt.setInt(1,"dom");
    pstmt.setString(1,account);
	  pstmt.setString(2,password);
	  pstmt.setString(3,message);
	  pstmt.setInt(4,age);
	  pstmt.executeUpdate();
	  pstmt.close();
	    } catch (SQLException e) { System.err.println(e.getMessage()); }
    }  // end  addMail

public static void delMail(String account,String password,String message,int age)
	throws SQLException {
	String  sql = "DELETE  FROM  Mail account = ?";
try {
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	PreparedStatement pstmt = conn.prepareStatement(sql);
	//pstmt.setInt(1,"dom");

      pstmt.setString(1,account);
	  pstmt.executeUpdate();
	  pstmt.close();
	    } catch (SQLException e) { System.err.println(e.getMessage()); }
    }  // end  delMail



  }  // end class Echo.java
