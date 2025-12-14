// Class doaddinfo

import java.io.*;
import java.lang.*;
import java.sql.*;
import SenderMessage;
import oracle.jdbc.driver.*;
import doaddmail;

public class doaddinfo  implements HttpClassProcessor  {

    protected String data,length,account,name,password,address,telephone,sex,age,work,part,icq;

    //-------------------------------------------------

    public void initRequest (HttpInputStream in)  throws  IOException
    {
      if (in.getMethod () != HTTP.METHOD_POST)
         throw new HttpException (HTTP.STATUS_NOT_ALLOWED,"Request method<TT>" + in.getMethod() + " </TT> not allowed.");
 data = in.readLine(); 
 data = HTTP.decodeString (data);
 account      =	 getCode(data);	  data = cutString(data);
 password   =	getCode(data);		  data = cutString(data);
 password   =	getCode(data);		  data = cutString(data);
 name         =	getCode(data);		  data = cutString(data); 
address      =	getCode(data);       data = cutString(data);
telephone   =	getCode(data);		  data = cutString(data);
icq             =	getCode(data);		  data = cutString(data);
sex            =		getCode(data);		  data = cutString(data);
age			 =		getCode(data);		  data = cutString(data);
work		 =		getCode(data);		  data = cutString(data);
part			 =		getCode(data);		  data = cutString(data);

try{
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
addMail(account,name,password,address,telephone,sex,age,work,part,icq);
// delMail(account,password,age);
  }
  catch (SQLException e) {}
   }
  
	//--------------------------------------------------

    public void processRequest(HttpOutputStream out) throws IOException
    {
     out.setHeader("Content-type","text/html");
		if (out.sendHeaders() )
        {
String createdir = "c:/webcgi/" + account;
    File f = new File(createdir);
    if (!f.mkdir())
    {
    System.out.println("create dir error");
    }


//        out.write(account +"\r\n ");
 //       out.write(name +"\r\n ");
//		 out.write(password +"\r\n ");
//		  out.write(address +"\r\n ");
//		   out.write(telephone +"\r\n ");
//		    out.write(sex +"\r\n ");
//			 out.write(age +"\r\n ");
//			  out.write(work +"\r\n ");
//			   out.write(part +"\r\n ");
//			    out.write(icq +"\r\n\r\n ");
out.write("<html>  <body bgcolor = #CCFFCC > ");
    	out.write (" <font color = #ff0000 > "); 
String		text  =  doaddmail.convertText("ลงทะเบียนเสร็จเรียบร้อยแล้ว");
    	out.write(" <CENTER> <h1> "+text+" </h1> </CENTER> </font> ");

		out.write (" <font color = #ff0000 > "); 
		text  =  doaddmail.convertText("ท่านสามารถเข้าใช้งานเซิร์ฟเวอร์โดยคลิ๊กที่ กลับหน้าจอหลัก");
    	out.write(" <CENTER> <h1> "+text+" </h1> </CENTER> </font> ");

out.write (" <font color = #ff0000 > "); 
text  =  doaddmail.convertText("กลับหน้าจอหลัก");
out.write("<br><a  href="+"http://161.246.6.119:8888"+"><b> "+text+" </b> </A><br>");  
	out.write(" </body> </html> ");
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

	public static void addMail(String account,String name,String password,String address,String telephone,String sex,String age,String work,String part,String icq)
	throws SQLException {
	String  sql = "INSERT INTO infomail VALUES(?,?,?,?,?,?,?,?,?,?)";
try {
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1,account);
	  pstmt.setString(2,name);
	  pstmt.setString(3,password);
	  pstmt.setString(4,address);
	  pstmt.setString(5,telephone);
	  pstmt.setString(6,sex);
	  pstmt.setString(7,age);
 	  pstmt.setString(8,work);
  	  pstmt.setString(9,part);
  	  pstmt.setString(10,icq);
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
