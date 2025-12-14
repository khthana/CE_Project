// Class dodelete

import java.io.*;
import java.lang.*;
import java.sql.*;
import SenderMessage;
import oracle.jdbc.driver.*;

public class dodelete implements HttpClassProcessor  {

    protected String message,length,account;


    //-------------------------------------------------

    public void initRequest (HttpInputStream in)  throws  IOException
    {
      if (in.getMethod () != HTTP.METHOD_POST)
         throw new HttpException (HTTP.STATUS_NOT_ALLOWED,"Request method<TT>" + in.getMethod() + " </TT> not allowed.");

      //  message = in.readPost();
	    message = in.readLine();
		message = HTTP.decodeString (message);
    }
    //--------------------------------------------------

    public void processRequest(HttpOutputStream out) throws IOException
    {
     out.setHeader("Content-type","text/html");

		if (out.sendHeaders() )
        {
		account  = getCode(message);  message = cutString(message); 
                   for(;;) 
				    {
					String index  = getCode(message);  message = cutString(message); 
					try 
					{
   					 deleteMail(account,index);
					}
					catch (Exception e)
					{	System.out.print(e);   }

						  if (message == "-1")  break;			  
		            }  // for




try{
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver()); 
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	Statement stmt = conn.createStatement ();
	String sql = "SELECT sender,subject,datas,indexs FROM datamail  where account= '"+account+"'";
    ResultSet rset = stmt.executeQuery (sql);
                 File file = new File("overview.html");     
			    FileInputStream in = new FileInputStream(file);  
			     out.write(in);
		       in.close();

out.write("<TABLE width= 50% border= 0  cellspacing= 0  cellpadding= 0  bgcolor= #000000 > ");
out.write("<TR><TD> <TABLE width= 100% border= 0  cellspacing= 1  cellpadding= 0 > ");
out.write(" <TR bgcolor = #00779E> ");
out.write("<TD align = center  width = 120 onmouseover = mOvr(this,'#3FBBEF');  onmouseout = mOut(this);  onclick= mClk(this);> ");
String text  =  doaddmail.convertText("คลิ้กที่นี่เพื่อเขียนจดหมาย" );
out.write(" <A class = toolLnk  href = 'doreply?username="+account+"&index=1'  title =  " + text + "  > ");
text  =  doaddmail.convertText("เขียนจดหมาย");
out.write(" <FONT size = 2 face = MS Sans Serif  color = #FFFFFF >  " + text + " </FONT> ");
out.write(" </A> </TD>");
out.write(" <TD align = center  width = 120 onmouseover = mOvr(this,'#3FBBEF');  onmouseout = mOut(this);  onclick = mClk(this); >");
text  =  doaddmail.convertText("ลบจดหมาย คลิ้กมาที่นี่เลยพี่");
out.write(" <A class = toolLnk  href = 'register.html' title = " + text + " > ");
text  =  doaddmail.convertText("ลบจดหมาย");
out.write(" <FONT size = 2  face = MS Sans Serif  color = #FFFFFF > " + text + " </FONT> ");
out.write("</A>  </TD>   </TR>   </TABLE>   </TD>   </TR>   </TABLE>");
out.write("<TABLE width = 100% border = 0  cellspacing = 0  cellpadding = 0 bgcolor = #000000 > ");
 


    String count =  doaddmail.countMail(account);
   String cnewmail = doaddmail.countNewMail(account);
  text  =  doaddmail.convertText(account+"@ce.kmitl.ac.th       คุณมีจดหมาย "+ count +" ฉบับ ยังไม่ได้อ่าน "+ cnewmail+ "  ฉบับ" );
   out.write("<tr> <CENTER>" + text + "  </CENTER>");
 out.write(" <tr> <td bgcolor=" + "#008040" + " ><font size= "+ "-1" + " >  &nbsp&nbsp&nbsp&nbsp </td>");
text  =  doaddmail.convertText("จาก" );
 out.write(" <td bgcolor= "+ "#008040" + " ><font size=" + "-1" +" >"+ text +"</td>");  
text  =  doaddmail.convertText("หัวข้อ" );
 out.write(" <td bgcolor= "+ "#008040"  + " ><font size= " + "-1" + " >"+  text +"</td>"); 
text  =  doaddmail.convertText("วันที่" );
  out.write(" <td bgcolor= "+ "#008040"  + " ><font size= " + "-1" + " >"+  text  +"</td>"); 

out.write ("<form method="+" post "+" action="+"/class-bin/dodelete"+">");
out.write("<input type =  "+"hidden"+" name = account  value = "+ account +" >");
	while ( rset.next ()  )
    {
	   String  sender = rset.getString(1);
   	   String  subject = rset.getString(2);
   	   String  date     = rset.getString(3);
	   String  index   = rset.getString(4);
	   date = date.substring(0,(date.indexOf(':')+6) );

  	   sender = sender.replace('<','[');
	   sender = sender.replace('>',']');

/*	  out.write("<tr><td> &nbsp&nbsp&nbsp<input type="+"checkbox" +" name = " + "msgdelete"+"  value="+index+">");*/
		  out.write("<tr> <td bgcolor="+"#CCFFCC"+" ><font size="+"-1"+"> &nbsp&nbsp<input type="+"checkbox" +" name = " + "msgdelete"+"  value="+index+">");
	  out.write("<td bgcolor="+"#CCFFCC"+" ><font size="+"-1"+">"+sender+"  </td><td bgcolor="+"#CCFFCC"+" ><font size="+"-1"+">" +  "<a  href="+"doreadmail?username="+account+"&index="+index+">"  +subject+"</td> <td bgcolor="+"#CCFFCC"+" ><font size="+"-1"+">" +date+"</td>");  
	} // while loop     
text  =  doaddmail.convertText(" ลบจดหมาย " );
out.write("</table><br> <input type = " + "submit " + "value = "+ text + ">" );
out.write ("</form>"); 


   }  // try
   catch (SQLException e) {}  

//////////////////////////////////////////////////////////////////
			  out.write("</body></html>");
        
 			  

















        } // if
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
		if (index_and == -1)
		    return ("-1");
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


public static void deleteMail(String account,String indexs)
	throws SQLException {
	String  sql = "DELETE  FROM  datamail where account = ?  and indexs=?";
//String  sql = "DELETE  FROM  datamail account = ?";
try {
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	PreparedStatement pstmt = conn.prepareStatement(sql);
	//pstmt.setInt(1,"dom");
      pstmt.setString(1,account);
      pstmt.setString(2,indexs);
	  pstmt.executeUpdate();
	  pstmt.close();
	    } catch (SQLException e) { System.err.println(e.getMessage()); }
    }  // end  deleteMail

  }  // end class dodelete.java
