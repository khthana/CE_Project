// Class doreadmail
import java.io.*;
import java.lang.*;
import java.sql.*;
import oracle.jdbc.driver.*;
import decode_quoted;
import doaddmail;

public class doreadmail implements HttpClassProcessor  {

    protected String message,account,index,sender,cutsender,date,subject;
	//-------------------------------------------------

    public void initRequest (HttpInputStream in)  throws  IOException
    {
      if (in.getMethod () != HTTP.METHOD_GET)
         throw new HttpException (HTTP.STATUS_NOT_ALLOWED,"Request method<TT>" + in.getMethod() + " </TT> not allowed.");
    message = HTTP.decodeString (in.getQueryString() );
    account = getCode(message);  message = cutString(message);
    index   = getCode(message);  message = cutString(message);

	

try{
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver()); 
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	Statement stmt = conn.createStatement ();
	String sql = "SELECT sender,datas,subject,message FROM datamail where account = '"+account+"'  and indexs = '"+index+"'";
    ResultSet rset = stmt.executeQuery (sql);

	while ( rset.next () )  
    {
	     sender = rset.getString(1);
	     date = rset.getString(2);
		 subject = rset.getString(3);
	     message = rset.getString(4);
	} // while loop     
	   sender = sender.replace('<','[');
	   sender = sender.replace('>',']');
if (sender.indexOf('[') == -1)
cutsender = sender;

else  cutsender = sender.substring(sender.indexOf('[')+1,sender.indexOf(']'));  

	doaddmail.clearStatus(account,index);
   }
   catch (SQLException e) {}
    }
    //--------------------------------------------------

    public void processRequest(HttpOutputStream out) throws IOException
    {
     out.setHeader("Content-type","text/html");
      	if (out.sendHeaders() )
        {   
out.write ("<BODY BGCOLOR= #CCFFCC > " );
String text  =  doaddmail.convertText("ผู้ส่ง   :  ");
   out.write(text + sender+"<br>");
   text  =  doaddmail.convertText("หัวข้อ  :  ");
  out.write(text + subject+"<br>");
  text  =  doaddmail.convertText("วันที่ส่ง :  ");
  out.write(text + date+"<br>");
  text  =  doaddmail.convertText("ผู้รับ   :  ");
   out.write(text + account+"@venus09.ce.kmitl.ac.th<br>");
   out.write("<hr><br>");
message = message+" ";  // resolve bug

int  c = message.indexOf("http://");
if (c != -1)
{
String heads="";
String center="";
String tail="";
String temp=message;
message = "";

while ( c != -1)
{
   try
   {
	heads = temp.substring(0,c);
	temp = temp.substring(c);
	c = temp.indexOf(" ");
	center = temp.substring(0,c);
	temp = temp.substring(c);
	message =  message+heads+"<a href="+center+">"+center+"</a>";
	c = temp.indexOf("http://");
	if (c==-1)   message = message+temp;	

	}
		catch(Exception e)  
		   { 
		   System.out.println("Error  "+e);
			}
 } // while
 } //if







int j=0;
for (int i=0;i<message.length() ; i++)
{
  int cthai = (int ) message.charAt(i);
   if ( cthai  >  255  )
   {
   cthai-=3424;
   }

   if ( cthai==13  )
   {
   out.write("<br>");   i++;
   }
   out.write(cthai);
} // for
   text  =  doaddmail.convertText("ตอบจดหมาย");
out.write("<br><a  href="+"doreply?username="+account+"&sender="+cutsender+"&index="+index+"><b>  "+text+" </b> </A><br>");  

		} //if		



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


  }  // end class dologin.java
