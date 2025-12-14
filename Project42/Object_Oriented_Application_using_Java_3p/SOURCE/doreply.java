// Class dologin
import java.io.*;
import java.lang.*;
import java.sql.*;
import oracle.jdbc.driver.*;
import doaddmail;

public class doreply implements HttpClassProcessor  {

    protected String message,length,account,index,sender;
	//-------------------------------------------------

    public void initRequest (HttpInputStream in)  throws  IOException
    {
      if (in.getMethod () != HTTP.METHOD_GET)
         throw new HttpException (HTTP.STATUS_NOT_ALLOWED,"Request method<TT>" + in.getMethod() + " </TT> not allowed.");

	length  =  in.getHeader("Content-length");
	    message = HTTP.decodeString (in.getQueryString() );
    account  = getCode(message);  message = cutString(message);
    sender  = getCode(message);  message = cutString(message);
	index     = getCode(message);  message = cutString(message);
    
    }   
    //--------------------------------------------------

    public void processRequest(HttpOutputStream out) throws IOException
    {
     out.setHeader("Content-type","text/html");
      	if (out.sendHeaders() )
        {
out.write("<html>");
 String text  =  doaddmail.convertText("เว็บเซิร์ฟเวอร์และเมล์เซิร์ฟเวอร์");
out.write("<font color="+"#ff0000"+"> <CENTER><h1>"+text+" </h1> </CENTER> </font>");
out.write( "<body text = " + "#ff0000" + "> <hr> <body background="+"http://161.246.6.119:8888/Gravel.gif"+">");
out.write("<TABLE  width = " + "100%" + " border=1 cellpadding=50 cellspacing = 2  bordercolor=lightblue>");
out.write("<tr> <td rowspan = 400 valign = buttom > <img src= " + "http://161.246.6.119:8888/children.gif" + " width = 100 height=100 border=2> </td>");

 out.write("<td> <form  method= " + "post " + " action= " + "/class-bin/dosendmail"+ " >");
text  =  doaddmail.convertText("ผู้ส่ง   :  ");
out.write(" <b>"+text+"  &nbsp&nbsp&nbsp</b>    <INPUT TYPE=  text  NAME = " + "sender" + " value = " +account+"@venus09.ce.kmitl.ac.th " + "  SIZE = 30 MAXLENGTH =45 > <br>"); 
if (sender.indexOf('@') == -1)
{
sender = "&nbsp";
}
  text  =  doaddmail.convertText("ผู้รับ   :  ");
out.write(" <b> "+text+" &nbsp&nbsp&nbsp </b>  <INPUT TYPE = text  NAME = " + "recipient" + " value = "+sender+"  SIZE = 30  MAXLENGTH = 45 >   <br>");

text  =  doaddmail.convertText("หัวเรื่อง   :  ");
out.write("  <b>"+text+"  </b>  <INPUT TYPE =  text  NAME = " + "headers" + "  SIZE = 30 MAXLENGTH =35 >  <br> ");
  text  =  doaddmail.convertText("ข้อความ : ");
out.write("  <b>"+text+" </b>  <TEXTAREA NAME =  MESSAGE  ROWS = 4  COLS = 50  WRAP > </TEXTAREA> <p>");
  text  =  doaddmail.convertText("&nbsp&nbspส่ง&nbsp&nbsp");
out.write("<input type =  submit  value =  "+text+" > &nbsp");
  text  =  doaddmail.convertText("&nbsp&nbspลบ&nbsp&nbsp");
out.write("<input type = reset  value =  "+text+" >");
out.write("</form> </td> </TABLE></html>");
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
  }  // end class doreply.java
