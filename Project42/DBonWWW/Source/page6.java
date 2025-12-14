import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;
import java.util.*;
import java.lang.*;

public class page6 extends HttpServlet
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
     // out.println("found!");
     }
/*   out.println("your code you choose is");
   out.println(codex_page4);
   out.println(stockx_page4);*/
   
   String view="";
   values=req.getParameterValues("view");
   if(values!=null) 
     {
      view=values[0];
     // out.println(view);
     }    
       
   out.println("<html>");
   out.println("<br>");
   out.println("<head>");
   out.println("<title>Please enter information for none member</title>");
   
   out.println("</head>");
   out.println("<body background=\"/image/41.gif\">");
   
   out.println("<SCRIPT LANGUAGE=\"JavaScript\">");

   out.println("function checkinput(CheckForm) {");
                   out.println("if (empty(CheckForm.customer_name.value)) {");
                   out.println("  var nofullname=\"You must include your name.\";");
                   out.println("  alert(nofullname);");
                   out.println("}");
                   out.println("else if (empty(CheckForm.address.value)) {");
                   out.println("  var noaddress=\"You must include your address.\";");
                   out.println("  alert(noaddress) ");
                   out.println("}");
                   out.println("else if (empty(CheckForm.postcode.value)) {");
                   out.println("  var nopostcode=\"You must include your postcode.\";");
                   out.println("  alert(nopostcode) ");
                   out.println("}");
	   out.println("else if (empty(CheckForm.telephone.value)) {");
                    out.println(" var nophone=\"You must include your phone number.\";");
                    out.println(" alert(nophone) ");
                   out.println("}");
                   out.println(" else return true ");
                   out.println("return false ");
                   out.println("}");

          out.println("function empty(inputStr) {");
                  out.println(" if (inputStr == \"\" || inputStr == null) {");
                  out.println("       return true");
                  out.println("   }");
                  out.println(" return false");
                  out.println(" }");
   out.println("</SCRIPT>");
   //test===============
   String pagex="page7";
   /*
   if(enter all)
     {pagex=page5;}
   else
     {pagex=page7;}  
   */
   //===============test 
   
   out.println("<center><img src=\"http://"+connect.hostname+"/image/bar4.gif\"></center>");      
   	out.println("<br>");
out.println("<CENTER><FONT color=#000080  size=5>5) โปรดกรอกรายละเอียด</FONT>");
out.println("<TABLE bgColor=#ffffe0 border=2 widht=\"100%\">");
out.println("<TBODY>");
out.println("<TR><TD>");

out.println("<center>");
out.println("<table border=0 cellspacing=2 cellpadding=2 width=100%>");

   out.println("<form name=ThisForm method=POST action=\""+"http://"+connect.hostname+"/servlet/"+pagex+"\" onSubmit=\"return checkinput(document.ThisForm)\">");
   
 out.println("<div align=\"center\">");
 out.println("<tr><td align=right><img alt=\"Gift!\" width=18 height=17 src=\"/image/tiny-gift-click-box.gif\"></td><td align=left></td></tr>");

 out.println("<tr><td align=right><strong><FONT face=Arial size=-1>ชื่อลูกค้า&nbsp;</font></strong><br><font face=Arial size=-2>( ชื่อเต็ม ):</font></td><td><input type=\"text\" name=customer_name value=\"\" size=50 maxlength=50></td></tr>");

 out.println("<tr><td align=right><strong><font face=Arial size=-1>นามสกุลลูกค้า&nbsp;</font></strong><br><font face=Arial size=-2>( ถ้ามี ):</font></td><td><input type=\"text\" name=lastname value=\"\" size=50 maxlength=50></td></tr>");

 out.println("<tr><td align=right><strong><font face=Arial size=-1>ที่อยู่&nbsp;</font></strong><br><font face=Arial size=-2>(ในการจัดส่งสินค้า):</font></td><td><input type=\"text\" name=address value=\"\" size=50 maxlength=100></td></tr>");

 out.println("<tr><td align=right><strong><font face=Arial size=-1>รหัสไปรษณีย์&#58;&nbsp;</font></strong></td><td><input type=\"text\" name=postcode value=\"\" size=20></td></tr>");

 out.println("<tr><td align=right><strong><font face=Arial size=-1>เบอร์โทรศัพท์&#58;&nbsp;</font></strong></td><td><input type=\"text\" name=telephone value=\"\" size=20></td></tr>");

 out.println("<tr><td align=right><strong><font face=Arial size=-1>e&#45;mail address&#58;</font></strong>&nbsp;</td><td valign=top><input type=text name=email  maxlength=30 size=30 ></td></tr>");

 out.println("<tr><td>&nbsp;</td><td>");

 out.println("<input type=image src=\"/image/continue-orange.gif\" border=0 value=\"Continue\" name=submit alt=\"Continue\" height=23 width=89>");

 out.println("</td></tr></td></tr></table></center></div>");

/*   out.println("FIRST NAME");
   out.println("<input type=text name=customer_name>");
   out.println("LAST NAME");
   out.println("<input type=text name=lastname>");
   out.println("<br>");
   out.println("TELEPHONE");
   out.println("<input type=text name=telephone>");
   out.println("<br>");
   out.println("EMAIL");
   out.println("<input type=text name=email>");
   out.println("<br>");
   out.println("ADDRESS");
   out.println("<input type=text name=address>");
   out.println("POSTCODE");
   out.println("<input type=text name=postcode>");
   out.println("<br>");   
   out.println("<input type=submit name=submit value=\"submit\">");*/
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