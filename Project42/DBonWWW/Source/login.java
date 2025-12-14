import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;
import java.util.*;
import java.lang.*;

public class login extends HttpServlet
{
 String values[];
 Connection con = null;
 Statement stmt = null;
 ResultSet rs = null;

 public void service(HttpServletRequest req,HttpServletResponse resp)
 throws ServletException,java.io.IOException
 {
  connectdb();
  addinfo(req,resp);
  //con.close();
 } 

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
 
 public void addinfo(HttpServletRequest req,HttpServletResponse resp)
 {
  try
  {
   resp.setContentType("text/html");
   PrintWriter out = resp.getWriter(); 
  
   String codex_page4="";
   values=req.getParameterValues("codex_page4");
   if(values!=null) 
     {
      codex_page4=values[0];
     // out.println("found!");
     }
     
   String stockx_page4="";
   values=req.getParameterValues("stockx_page4");
   if(values!=null) 
     {
      stockx_page4=values[0];
      //out.println("found!");
     }
/*   out.println("your code you choose is");
   out.println(codex_page4);
   out.println(stockx_page4);*/
   
   String view="";
   values=req.getParameterValues("view");
   if(values!=null) 
     {
      view=values[0];
      //out.println(view);
     }    


out.println("<html>");
out.println("<head><title>Please Login as Member</title></head>");

   out.println("<body background=\"/image/41.gif\">");
      out.println("<center><img src=\"http://"+connect.hostname+"/image/bar4.gif\"></center>"); 
out.println("<br>");

out.println("<CENTER><FONT color=#000080 size=5>5) โปรดล๊อคอินเข้าระบบ</FONT>");
out.println("<TABLE bgColor=#ffffe0 border=2 widht=\"100%\">");
out.println("<TBODY>");
out.println("<TR><TD>");

out.println("<form method=\"POST\" action=\"http://"+connect.hostname+"/servlet/page7\">");
out.println("<div align=\"center\"><center><table border=\"0\" width=\"100%\"height=\"151\">");
out.println("<tr>");
out.println("<td width=\"50%\" height=\"27\"><div align=\"right\"><p><big><big><font color=\"#000080\">USERNAME              : </font></big></big></td>");
out.println("<td width=\"50%\" height=\"27\"><input type=\"text\" name=\"username\" size=\"20\"></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width=\"50%\" height=\"27\"><div align=\"right\"><p><big><big><font color=\"#000080\">PASSWORD              : </font></big></big></td>");
out.println("<td width=\"50%\" height=\"27\"><input type=\"password\" name=\"password\" size=\"20\"></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width=\"50%\" height=\"25\"><div align=\"right\"><p><input type=\"submit\" value=\"Submit\"      name=\"B1\"></td>");
out.println("<td width=\"50%\" height=\"25\"><input type=\"reset\" value=\"Reset\" name=\"B2\"></td>");
out.println("</tr>");
out.println("</table>");
out.println("</center></div>");
   out.println("<input type=hidden name=codex_page4 value=\""+codex_page4+"\">");
   out.println("<input type=hidden name=stockx_page4 value=\""+stockx_page4+"\">");
out.println("<input type=hidden name=view value=\""+view+"\">");
out.println("</form>");

out.println("</TD></TR></TBODY></TABLE></CENTER>");
out.println("</body>");
out.println("</html>");

   con.close();
  }
  catch(Exception ex)
  {
   ex.printStackTrace();
  }
 }   
}