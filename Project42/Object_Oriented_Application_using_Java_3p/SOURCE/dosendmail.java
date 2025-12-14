// Class dosendmail.java

import java.io.*;
import java.lang.*; 
import java.sql.*;
import SenderMessage;
import oracle.jdbc.driver.*;
import doaddmail;

public class dosendmail  implements HttpClassProcessor  {

    protected String message,length,sender,recipient,header,data,a,b;
	protected int error = 0;
    //-------------------------------------------------

    public void initRequest (HttpInputStream in)  throws  IOException
    {
      if (in.getMethod () != HTTP.METHOD_POST)
         throw new HttpException (HTTP.STATUS_NOT_ALLOWED,"Request method<TT>" + in.getMethod() + " </TT> not allowed.");

	  //  message = in.readPost();
    message = in.readLine();
	a= message;
	message = HTTP.decodeString (message);
	b = message;
    sender     = getCode(message);  message = cutString(message);
	if (sender.equals("") )  error = 1; 
    recipient  = getCode(message);  message = cutString(message);
	if (recipient.equals(" ") ) error = 1; 
   header   = getCode(message);  message = cutString(message);
   	if (header.equals("") )   error = 1; 
    data  = getCode(message);  message = cutString(message);
	if (data.equals(" ") )      error = 1; 
    }
    //--------------------------------------------------

    public void processRequest(HttpOutputStream out) throws IOException
    {
     out.setHeader("Content-type","text/html");
		if (out.sendHeaders() )
        {
         if (error == 1)
         {
		  String text  =  doaddmail.convertText("การส่งจดหมายผิดพลาด");
    	out.write("<html> <title>"+text+" </title> <body bgcolor="+"#CCFFCC"+" ><font size= -1 > <hr><br>");
		out.write (" <font color = #ff0000 > "); 
		out.write(" <CENTER> <h1> "+text+" </h1> </CENTER> </font> ");
		out.write (" <font color = #ff0000 > "); 
		text  =  doaddmail.convertText("เนื่องจากกรอกแบบฟอร์มผิด กรุณาแก้ไขให้ถูกต้อง");
    	out.write(" <CENTER> <h1> "+text+" </h1> </CENTER> </font> ");
		out.write("<br><hr></body></html>");
         }
		
		else 
		{

 try{
          SenderMessage senderMessage
            = new SenderMessage(sender,recipient,header,data);
          }
        catch(Exception ex){
          try
																{
																	SenderMessage return_senderMessage = new SenderMessage(recipient,sender,header,data + "\r\n" + "----Return----");
																}
																catch (Exception e)
																{
																	System.out.println("--Exception-- Return Mail " + e);
																}
																System.out.println("SenderMessage Error: " + ex);
        }



      String text  =  doaddmail.convertText("ส่งจดหมายเสร็จเรียบร้อย");
		out.write("<html> <title>"+text+" </title> <body bgcolor="+"#CCFFCC"+" ><font size= -1 >");

		out.write("<hr><br> "+text);
//		       out.write("<br> a: "+ a);
//		        out.write("<br> b: "+b);
     	text  =  doaddmail.convertText("ผู้ส่ง : ");
        out.write("<br> "+text + sender);
    	text  =  doaddmail.convertText("ผู้รับ : ");
        out.write("<br> " +text+ recipient);     
    	text  =  doaddmail.convertText("หัวข้อ : ");
        out.write("<br> "+text+ header);          
     	text  =  doaddmail.convertText("ข้อความ : ");
        out.write("<br> "+text + data+"<br>");            

text  =  doaddmail.convertText("ตู้จดหมาย");
sender = sender.substring(0,sender.indexOf("@") );
out.write("<br><a  href="+"dologin?username="+sender+"&pwd=admin&pwd=admin> <b>  "+text+" </b> </A><br>");  

		out.write("<br><hr></body></html>");

        }   // else 
        }  // if

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

  }  // end class Echo.java
