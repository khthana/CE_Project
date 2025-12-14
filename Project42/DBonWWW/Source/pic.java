import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;
import java.util.*;
import java.lang.*;

public class pic extends HttpServlet
{
 String values[];
 
 public void service(HttpServletRequest req,HttpServletResponse resp)
 throws ServletException,java.io.IOException
 {
    resp.setContentType("text/html");
   PrintWriter out = resp.getWriter(); 
 
   String pic="";
   values=req.getParameterValues("pic");
   if(values!=null) 
     {
      pic=values[0];
      //out.println(pic);
     } 
     
   String code="";
   values=req.getParameterValues("code");
   if(values!=null) 
     {
      code=values[0];
      //out.println(pic);
     }      
     
   out.println("<html>");
   out.println("<head>");
   out.println("<title>test car query</title>");
   out.println("</head>");     
   
   out.println("<body background=\"/image/41.gif\">");   
   out.println("<center><h3>รหัสสินค้า คือ"+" <font color=\"#AA0000\" size=5>"+code+"</font></h3></center>");  
   out.println("<center><p><img border = \"1\" src=\"http://"+connect.hostname+"/image/"+pic+".jpg\"></p></center>");  
   
      out.println("</body>");
   out.println("</html>");
 } 
}  