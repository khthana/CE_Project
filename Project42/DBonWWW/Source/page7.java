import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;
import java.util.*;
import java.lang.*;

public class page7 extends HttpServlet
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
   
   String customer_id="";
  
   String codex_page4="";
   values=req.getParameterValues("codex_page4");
   if(values!=null) 
     {
      codex_page4=values[0];
      //out.println("found!");
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
   out.println(stockx_page4); */
   
   String view="";
   values=req.getParameterValues("view");
   if(values!=null) 
     {
      view=values[0];
     // out.println(view);
     }         

   String customer_name="";
   values=req.getParameterValues("customer_name");
   if(values!=null) 
     {
      customer_name=values[0];
     }    

   String lastname="";
   values=req.getParameterValues("lastname");
   if(values!=null) 
     {
      lastname=values[0];
     }    
     
   String telephone="";
   values=req.getParameterValues("telephone");
   if(values!=null) 
     {
      telephone=values[0];
     }    
     
   String email="";
   values=req.getParameterValues("email");
   if(values!=null) 
     {
      email=values[0];
     }    

   String address="";
   values=req.getParameterValues("address");
   if(values!=null) 
     {
      address=values[0];
     }    
     
   String postcode="";
   values=req.getParameterValues("postcode");
   if(values!=null) 
     {
      postcode=values[0];
     }    
     
   String username="";
   values=req.getParameterValues("username");
   if(values!=null) 
     {
      username=values[0];
     // out.println(username);
     }    
     
   String password="";
   values=req.getParameterValues("password");
   if(values!=null) 
     {
      password=values[0];
     // out.println(password);
     }    


   out.println("<html>");
   out.println("<br>");
   out.println("<head>");
   out.println("<title>Confirm</title>");
//   out.println("please enter information for none member");
   out.println("</head>");
   out.println("<body background=\"/image/41.gif\">");
   out.println("<center><img src=\"http://"+connect.hostname+"/image/bar4.gif\"></center>");      
   	out.println("<br>");
   	out.println("<center><font color=\"#000080\"><h3>6) ยืนยันการสั่งซื้อ</h3></font></center>");
   	
   if(view.compareTo("nonmember")==0)
     {
      if(customer_name.compareTo("")==0)
        {
         out.println("PLEASE ENTRY YOUR NAME");
        }
      else
        {
         out.println("<b>"+"ชื่อ :<font color=\"#000080\">"+customer_name+"</font><b>");
         out.println("<br>");
         out.println("<b>"+"นามสกุล :<font color=\"#000080\">"+lastname+"</font><b>");         
         out.println("<br>");
         out.println("<b>"+"เบอร์โทรศัพท์ :<font color=\"#000080\">"+telephone+"</font><b>");         
         out.println("<br>");
         out.println("<b>"+"EMAIL :<font color=\"#000080\">"+email+"</font><b>");         
         out.println("<br>");
         out.println("<b>"+"ที่อยู่ที่จะจัดส่งสินค้าไปให้ :<font color=\"#000080\">"+address+"</font><b>");         
         out.println("<br>");
         out.println("<b>"+"รหัสไปรษณีย์ :<font color=\"#000080\">"+postcode+"</font><b>");         
         out.println("<br>");
        }  
     }
   if(view.compareTo("member")==0)
     {
      String query="select customer_id,firstname,lastname,telephone,email,address,postcode from customer where username='"+username+"' and password='"+password+"'";
      
      rs = stmt.executeQuery(query);
      rs.next();      
      
      customer_id=rs.getString(1);
      customer_name=rs.getString(2);
      lastname=rs.getString(3);
      telephone=rs.getString(4);
      email=rs.getString(5);
      address=rs.getString(6);
      postcode=rs.getString(7);
      
      /*
      if(rs==null)
        {
         out.println("WRONG ENTRY");
        }
      else  
      */
      
      out.println("<b>"+"NAME		:<font color=\"#AA0000\">"+customer_name+"</font><b>");
      out.println("<br>");
      out.println("<b>"+"LAST NAME	:<font color=\"#AA0000\">"+lastname+"</font><b>");         
      out.println("<br>");
      out.println("<b>"+"TELEPHONE 	:<font color=\"#AA0000\">"+telephone+"</font><b>");         
      out.println("<br>");
      out.println("<b>"+"EMAIL 		:<font color=\"#AA0000\">"+email+"</font><b>");         
      out.println("<br>");
      out.println("<b>"+"ADDRESS 	:<font color=\"#AA0000\">"+address+"</font><b>");         
      out.println("<br>");
      out.println("<b>"+"POSTCODE 	:<font color=\"#AA0000\">"+postcode+"</font><b>");         
      out.println("<br>");       
     }  
if((customer_name.compareTo("")==0)&&(view.compareTo("nonmember")==0))
  {
  }     
else
  {   
   out.println("<form method=POST action=\""+"http://"+connect.hostname+"/servlet/page5\">");
out.println("<input type=hidden name=customer_name value=\""+customer_name+"\">");   
out.println("<input type=hidden name=lastname value=\""+lastname+"\">");
out.println("<input type=hidden name=telephone value=\""+telephone+"\">");
out.println("<input type=hidden name=email value=\""+email+"\">");
out.println("<input type=hidden name=address value=\""+address+"\">");
out.println("<input type=hidden name=postcode value=\""+postcode+"\">");
   out.println("<input type=submit name=submit value=\" >> ยืนยันการสั่งซื้อ >> \">");
   out.println("<input type=hidden name=codex_page4 value=\""+codex_page4+"\">");
   out.println("<input type=hidden name=stockx_page4 value=\""+stockx_page4+"\">");
out.println("<input type=hidden name=customer_id value=\""+customer_id+"\">");
out.println("<input type=hidden name=view value=\""+view+"\">");
   out.println("</form>");
 }
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