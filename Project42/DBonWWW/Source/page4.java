import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;
import java.util.*;
import java.lang.*;

public class page4 extends HttpServlet
{
 
 String values[];
 Connection con = null;
 Statement stmt = null;
 ResultSet rs = null; 
 

 public void service(HttpServletRequest req,HttpServletResponse resp)
 throws ServletException,java.io.IOException
 {
  connectdb();
  list_goods(req,resp);
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
 
 public void list_goods(HttpServletRequest req,HttpServletResponse resp)
 {
  try
  {
   Vector vector_code   =new Vector(); 
   Vector vector_menufac=new Vector(); 
   Vector vector_price  =new Vector(); 
   Vector vector_stock  =new Vector(); 
   Vector vector_name   =new Vector();    
   Vector vector_lr     =new Vector();   
   Vector vector_model  =new Vector();
   Vector vector_year   =new Vector();
   Vector vector_stockx =new Vector();
   
   resp.setContentType("text/html");
   PrintWriter out = resp.getWriter(); 
  
   
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
     
    // out.println(lastpage+"pppppp");
     
     
   String menufacture="";
   values=req.getParameterValues("menufacture");
   if(values!=null) 
     {
      menufacture=values[0];
     }
/*   out.println("your menufacture you choose is");
   out.println(menufacture);  
   out.println("<br>");*/
   
   String model="";
   values=req.getParameterValues("model");
   if(values!=null) 
     {
      model=values[0];
     }
/*   out.println("your model you choose is");
   out.println(model);  
   out.println("<br>");*/
      
   String year="";
   values=req.getParameterValues("year");
   if(values!=null) 
     {
      year=values[0];
     }
/*   out.println("your year you choose is");
   out.println(year);  
   out.println("<br>");*/
     

   String codex_page3="";
   values=req.getParameterValues("codex_page3");
   if(values!=null) 
     {
      codex_page3=values[0];
      //out.println("found!");
     }
     
   String stockx_page3="";
   values=req.getParameterValues("stockx_page3");
   if(values!=null) 
     {
      stockx_page3=values[0];
      //out.println("found!");
     }
     
/*   out.println("your code you choose is");
   out.println(codex_page3);
   out.println(stockx_page3);     */
   
   StringTokenizer tk=new StringTokenizer(codex_page3);
   while(tk.hasMoreTokens())
        {
         vector_code.addElement(tk.nextToken());
        }
   StringTokenizer sk=new StringTokenizer(stockx_page3);
   while(sk.hasMoreTokens())
        {
         vector_stockx.addElement(sk.nextToken());
        }
        

   int i=0;
   for(i=0;i<vector_code.size();i++)
      {
       String query="select sp.sp_name,sp.sp_menufac,sp.sp_stock,sp.sp_lr,c.model,c.year,sp.sp_price from spare_part sp,car c where sp.sp_code='"+(String)vector_code.elementAt(i)+"' and c.car_code=(select car_code from match where sp_code='"+(String)vector_code.elementAt(i)+"')";
 
       rs = stmt.executeQuery(query);
       rs.next();
       vector_name.addElement(rs.getString(1));
       vector_menufac.addElement(rs.getString(2));
       vector_stock.addElement(rs.getString(3));
       vector_lr.addElement(rs.getString(4));
       vector_model.addElement(rs.getString(5));
       vector_year.addElement(rs.getString(6));
       vector_price.addElement(rs.getString(7));
      }
      
   out.println("<html>");
   out.println("<head>");
      out.println("<title>Shopping Spare Part</title>");
   out.println("</head>");
   out.println("<body background=\"/image/41.gif\">");

   
   out.println("<center><img src=\"http://"+connect.hostname+"/image/bar3.gif\"></center>"); 
   out.println("<h4><font color=\"#000080\">รายการสินค้าที่สั่งซื้อ มีดังนี้</font></h4>");
   //out.println("<br>");
   
   out.println("<table border width=80%>");
   out.println("<tr><th>code</th><th>name</th><th>menufac</th><th>number</th><th>side</th><th>model</th><th>year</th><th>price</th><th>totalprice</th></tr>");
   int pn1=0;
   for(i=0;i<vector_code.size();i++)
      {
       int p1=Integer.parseInt((String)vector_price.elementAt(i));
       int n1=Integer.parseInt((String)vector_stockx.elementAt(i));//number that the user buy
       int n2=Integer.parseInt((String)vector_stock.elementAt(i));//number of stock
       if(n1>n2) //if user buy more than stock have
         {
          n1=n2;          
         }
       int pn=p1*n1;
       pn1=pn1+pn;
 
 out.println("<tr><td>"+(String)vector_code.elementAt(i)+"</td><td>"+(String)vector_name.elementAt(i)+"</td><td>"+(String)vector_menufac.elementAt(i)+"</td><td>"+(String)vector_stockx.elementAt(i)+"</td><td>"+(String)vector_lr.elementAt(i)+"</td><td>"+(String)vector_model.elementAt(i)+"</td><td>"+(String)vector_year.elementAt(i)+"</td><td>"+(String)vector_price.elementAt(i)+"</td><td>"+pn+"</td></tr>");
      }
 out.println("<tr><td>"+" "+"</td><td>"+" "+"</td><td>"+" "+"</td><td>"+" "+"</td><td>"+" "+"</td><td>"+" "+"</td><td>"+" "+"</td><td>"+" "+"</td><td>"+pn1+"</td></tr>");      
   out.println("</table>");   
//   out.println("<a href=\"http://"+connect.hostname+"/sap2.html\">CHOOSE MORE</a>");

     
  out.println("<form method=POST action=\""+"http://"+connect.hostname+"/servlet/"+"page3"+"\">");
   out.println("<input type=submit name=view value=\" แก้ไขรายการอะไหล่ที่สั่งซื้อ \">");
   out.println("<input type=hidden name=sp_namex value=\""+sp_namex+"\">");
   out.println("<INPUT TYPE=\"hidden\" NAME=\"lastpage\" VALUE=\""+lastpage+"\">");
   out.println("<input type=hidden name=menufacture value=\""+menufacture+"\">");
   out.println("<input type=hidden name=model value=\""+model+"\">");
   out.println("<input type=hidden name=year value=\""+year+"\">");
    out.println("<a href=\"http://"+connect.hostname+"/servlet/Sap\">เลือกซื้ออะไหล่เพิ่มเติม</a>"); 
   out.println("</form>");
    
  
   out.println("<br>");   
   
   out.println("<form method=POST action=\""+"http://"+connect.hostname+"/servlet/"+"page6"+"\">");
   out.println("<input type=submit name=view value=\"nonmember\">");
   out.println("<input type=hidden name=codex_page4 value=\""+codex_page3+"\">");
   out.println("<input type=hidden name=stockx_page4 value=\""+stockx_page3+"\">");
   out.println("</form>"); 
   
   //out.println("<br>");   
   
  out.println("<form method=POST action=\""+"http://"+connect.hostname+"/servlet/"+"login"+"\">");
  
   out.println("<input type=submit name=view value=\"member\">");
   out.println("<input type=hidden name=codex_page4 value=\""+codex_page3+"\">");
   out.println("<input type=hidden name=stockx_page4 value=\""+stockx_page3+"\">");
   out.println("</form>");   

      
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