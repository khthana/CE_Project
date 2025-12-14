import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Form111 extends HttpServlet {
  private ConnectionPool pool;

  public void init(ServletConfig config) throws ServletException {
  super.init(config);
}
    
  public void service(HttpServletRequest req, HttpServletResponse res)
                               throws ServletException, IOException {
    
    String values[]; 
    
   String sp_namex="";
   values=req.getParameterValues("sp_namex");
   if(values!=null) 
     {
      sp_namex=values[0];
     }    

    String lastpage="";
    values=req.getParameterValues("lastpage");
    if(values!=null) 
      {
       lastpage=values[0];
      }    


    String master = "";
    values = req.getParameterValues("master");
    if (values!=null) { master = values[0]; }

    String menufacture = "";
    values = req.getParameterValues("menufacture");
    if (values!=null) { menufacture = values[0]; }
         
    String model = "";
    values = req.getParameterValues("model");
    if (values!=null) { model = values[0]; }
    
    String year = "";
    values = req.getParameterValues("year");
    if (values!=null) { year = values[0]; }

    res.setContentType("text/html");
    PrintWriter out = res.getWriter(); 
 
   	out.println("<HTML><HEAD><TITLE>Choose Car</TITLE></HEAD>");
   out.println("<body background=\"/image/41.gif\">");
	out.println("<center><img src=\"http://"+connect.hostname+"/image/bar2.gif\"></center>");      
   	out.println("<br>");
//----------------------------------------------------------
     	out.println("<FORM METHOD=\"POST\" ACTION=\"http://"+connect.hostname+"/servlets/page3\">");

        out.println("<INPUT TYPE=\"hidden\" NAME=\"sp_namex\" VALUE=\""+sp_namex+"\">");
        out.println("<INPUT TYPE=\"hidden\" NAME=\"lastpage\" VALUE=\""+lastpage+"\">");                  
        out.println("<INPUT TYPE=\"hidden\" NAME=\"master\" VALUE=\""+master+"\">");
        out.println("<CENTER><p><font color=\"#000080\" size=4><strong>3) โปรดเลือกชนิดของรถ (ถ้ามี)</strong></font></p>");
	out.println("<TABLE bgColor=#FF80FF border=2 borderColor=#0000ff borderColorDark=#0000ff borderColorLight=#0000ff cellPadding=2 cellSpacing=0 width=500>");		
	out.println("<TBODY><TR><TD><CENTER><TABLE bgColor=#ffeff6 border=0 cellPadding=2 cellSpacing=1 width=500><TBODY>");
	out.println("<TR><TD width=\"40%\"><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp;&nbsp;ผู้ผลิตรถยนต์</FONT></TD>");
	out.println("<TD width=\"60%\"><FONT face=Arial size=2>&nbsp;&nbsp;");

//------------------------1---------------------------------

        out.println("<SELECT NAME=\"menufacture\" SIZE=\"1\">");
        out.println("<OPTION SELECTED VALUE=\"" +menufacture+ "\">" +menufacture+ "</OPTION>" );
 	out.println("</SELECT>");      
  
//----------------------------------------------------------
	out.println("</FONT></TD></TR>");
	out.println("<TR><TD><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp;&nbsp;รุ่น</FONT></TD>");
	out.println("<TD><FONT face=Arial size=2>&nbsp;&nbsp;");	
//------------------------2---------------------------------    

	out.println("<SELECT NAME=\"model\" SIZE=\"1\">");
        out.println("<OPTION SELECTED VALUE=\"" +model+ "\">" +model+ "</OPTION>" );
 	out.println("</SELECT>");      

//----------------------------------------------------------
	out.println("</FONT></TD></TR>");
	out.println("<TR><TD><FONT face=Arial size=2>&nbsp;&nbsp;&nbsp;&nbsp;ปี</FONT></TD>");
	out.println("<TD><FONT face=Arial size=2>&nbsp;&nbsp;");	
//------------------------3---------------------------------    

	out.println("<SELECT NAME=\"year\" SIZE=\"1\">");
        out.println("<OPTION SELECTED VALUE=\"" +year+ "\">" +year+ "</OPTION>" );
 	out.println("</SELECT>");      

//------------------------END---------------------------------

  	out.println("</FONT></TD></TR>");
     	out.println("</TBODY></TABLE></CENTER></TD></TR></TBODY></TABLE></CENTER>");
       
	out.println("<BR><div align=\"center\"><center><p>");
	out.println("<INPUT TYPE=\"submit\" value=\"ค้นหาอะไหล่\" name=\"B1\">");
     	out.println("<A href=\"http://"+connect.hostname+"/servlets/Sap\"><FONT color=\"#0000FF\" size=4>ย้อนกลับ</FONT></A>");
     	out.println("</p></center></div>");
	out.println("</FORM>");
      	out.println("</BODY>");
      	out.println("</HTML>");
        out.close();
  }
  }