import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.text.*;
import java.lang.*;

public class page2 extends HttpServlet
{
  String values[];
  Vector v;
  Vector v1;
  Connection con = null;
  Statement stmt = null;
  ResultSet rs = null;

 public void service(HttpServletRequest req,HttpServletResponse resp)
 throws ServletException,java.io.IOException
 {
   connectdb();
   getspec(req,resp);   
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

 public void getspec(HttpServletRequest req,HttpServletResponse resp)
 {
  try
  {
   resp.setContentType("text/html");
   PrintWriter out = resp.getWriter(); 

   v=new Vector();
   v1=new Vector();
   
   resp.setHeader("Content-Language","en");
   Locale locale=new Locale("en","");
   DateFormat fmt=DateFormat.getDateTimeInstance(DateFormat.LONG,DateFormat.LONG,locale);
   fmt.setTimeZone(TimeZone.getDefault());
//   out.println(fmt.format(new java.util.Date()));
   
   out.println("<html>");
   out.println("<head>");
   out.println("<title>Choose Spare Part</title>");
   out.println("</head>");
   out.println("<body background=\"/image/41.gif\">");
   out.println("<center><img src=\"http://"+connect.hostname+"/image/bar11.gif\"></center>");      
   out.println("<br>");
   
   out.println("<center><font color=\"#000080\"><h3>2) เลือกชิ้นส่วนอะไหล่ที่ต้องการ</h3></font></center>");
   
//   out.println("this part you choose");
   String master="";
   values=req.getParameterValues("master");
   if(values!=null) 
     {
      master=values[0];
      master=master.replace('.',' ');
      master=master.trim();
      //out.println(master+"kkkkkkkkkk");
     }
//   out.println(master); 
//   out.println("<br>");

    String lastpage="";
    values=req.getParameterValues("lastpage");
    if(values!=null) 
      {
       lastpage=values[0];
      }


  String  query=null;
  int count=0;
  query="select distinct sp_name from spare_part where sp_master="+"'"+master+"' order by sp_name";
  rs = stmt.executeQuery(query);
   int temp=0;
   while(rs.next())
    { 
     v.addElement(rs.getString(1));
//     out.println(rs.getString(1));
     temp++;
//     out.println(temp);
    }
//    out.println(temp);
   int i,j;
   j=v.size();
   out.println("<form method=POST action=\""+"http://"+connect.hostname+"/servlet/Form"+"\">");
   out.println("<select name=sp_namex size=1>");
   for(i=0;i<j;i++)
      {
       out.println("<option value=\""+(String)v.elementAt(i)+"\">"+(String)v.elementAt(i)+"");
      }
   clearelement(v);//remove all in vector

   out.println("</select>"); 
   out.println("<br>");
   out.println("<br>");
   out.println("<br>");
   out.println("<br>");
   out.println("<br>");
   out.println("<br>");
   out.println("<input type=hidden name=master value=\""+master+"\">");
   out.println("<input type=hidden name=lastpage value=\""+lastpage+"\">");
   out.println("<input type=submit name=find value=\""+" >> เลือกรุ่นรถ  >> "+"\"align=middle>");
   
   out.println("</form>");  
   out.println("</body>");
   out.println("</html>");
   out.flush();
   con.close();
   
  }
  catch(Exception ex)
  {
   ex.printStackTrace();
  }
 }
 
 public void clearelement(Vector vec)
 {
  String dummy;
  int i,j;
  
  j=vec.size();
  for(i=0;i<j;i++)
     {
      dummy=(String)vec.elementAt(0);
      vec.removeElement(dummy);
     }
 } 

}
