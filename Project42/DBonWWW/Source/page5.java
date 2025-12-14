import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.lang.*;
import java.text.*;

public class page5 extends HttpServlet
{
 String values[];
 Connection con = null;
 Statement stmt = null;
 ResultSet rs = null;

 public void service(HttpServletRequest req,HttpServletResponse resp)
 throws ServletException,java.io.IOException
 {
  connectdb();
  change_db(req,resp);
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
 
 public void change_db(HttpServletRequest req,HttpServletResponse resp)
 {
  try
  {
   Vector vector_code   =new Vector(); 
   Vector vector_stockx =new Vector();   
   Vector vector_total=new Vector();      
   
   String customer_idx;
   String username="member1";
   String password="iammember1";
   String invoice_id;
   String invoice_date;
   String sale_id;
   int total_price=0;
   
   resp.setContentType("text/html");
   PrintWriter out = resp.getWriter(); 

   resp.setHeader("Content-Language","en");      
   Locale locale=new Locale("en","");
   DateFormat fmt=DateFormat.getDateTimeInstance(DateFormat.LONG,DateFormat.LONG,locale);
   fmt.setTimeZone(TimeZone.getDefault());
   //out.println(fmt.format(new java.util.Date()));   
   String st_date=fmt.format(new java.util.Date());
   //out.println(st_date);
   StringTokenizer tk_date=new StringTokenizer(st_date);
   String month=tk_date.nextToken();
   String day=tk_date.nextToken();
          day=day.substring(0,2);
   String year=tk_date.nextToken();
   //out.println(day+"-"+month+"-"+year);
   invoice_date=day+"-"+month+"-"+year;

   String customer_id="";
   values=req.getParameterValues("customer_id");
   if(values!=null) 
     {
      customer_id=values[0];
      //out.println("customer id "+customer_id+" ");
     }
     
   String view="";
   values=req.getParameterValues("view");
   if(values!=null) 
     {
      view=values[0];
      //out.println(view);
     }         
  
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
      //out.println("found!");
     }
     
   String customer_name="";
   values=req.getParameterValues("customer_name");
   if(values!=null) 
     {
      customer_name=values[0];
      //out.println(customer_name);
     }
     
   String lastname="";
   values=req.getParameterValues("lastname");
   if(values!=null) 
     {
      lastname=values[0];
      //out.println(lastname);
     }
     
   String telephone="";
   values=req.getParameterValues("telephone");
   if(values!=null) 
     {
      telephone=values[0];
      //out.println(telephone);
     }
     
   String email="";
   values=req.getParameterValues("email");
   if(values!=null) 
     {
      email=values[0];
      //out.println(email);
     }
     
   String address="";
   values=req.getParameterValues("address");
   if(values!=null) 
     {
      address=values[0];
      //out.println(address);
     }
     
   String postcode="";
   values=req.getParameterValues("postcode");
   if(values!=null) 
     {
      postcode=values[0];
      //out.println(postcode);
     }
     
/*   out.println("your code you choose is");
   out.println(codex_page4);
   out.println(stockx_page4);     */
   
   StringTokenizer tk=new StringTokenizer(codex_page4);
   while(tk.hasMoreTokens())
        {
         vector_code.addElement(tk.nextToken());
        }
   StringTokenizer sk=new StringTokenizer(stockx_page4);
   while(sk.hasMoreTokens())
        {
         vector_stockx.addElement(sk.nextToken());
        }

    //add total price to vector
    int i=0;
    for(i=0;i<vector_code.size();i++)
       {
        String query="select sp_price from spare_part where sp_code='"+vector_code.elementAt(i)+"'";
        rs = stmt.executeQuery(query);        
        rs.next();
        int p1=Integer.parseInt((String)vector_stockx.elementAt(i));        
        int p2=p1*rs.getInt(1);
      
        if(view.compareTo("member")==0)
          {
           p2=(int)p2*80/100;
          }      
        
        total_price=total_price+p2; //total money in the invoice
        
        String dummy=""+p2;
        vector_total.addElement(dummy);
        //out.println(dummy);                                       
       }
     stmt.close();
     rs=null;  
     //out.println("<br>");   

    //update stock
    update_stock(vector_code,vector_stockx);
        
    //check if not member
    stmt = con.createStatement();
    if(view.compareTo("nonmember")==0)
      {
 customer_idx=insert_customertable(customer_name,lastname,telephone,email,address,postcode);
       out.println("insert non member to customer table"+customer_idx);
      }
    else //if member
      {
       customer_idx=customer_id;
      }
    
    out.println("<br>");  
    out.println(customer_idx);  
      
   //insert data to invoice
   invoice_id=update_invoice(customer_idx,total_price,invoice_date);
   
   //insert data into sale
   sale_id=update_sale(invoice_id,vector_code,vector_stockx,out);
   /*out.println("sale id:");
   out.println(sale_id);      
   out.println("<br>");*/

   out.println("<html>");
   out.println("<head>");
   out.println("<title>test car query</title>");
   out.println("</head>");
    out.println("<body background=\"/image/41.gif\">");
   out.println("<center><img src=\"http://"+connect.hostname+"/image/bar5.gif\"></center>");      
   	out.println("<br>");
   
   out.println("<br>");
   out.println("<b>"+"INVOICE ID : "+invoice_id+"</b>");
   out.println("<br>");
   out.println("<b>"+"DATE :"+invoice_date+"</b>");
   out.println("<br>");

   stmt = con.createStatement();   
   String query="select firstname from customer where customer_id='"+customer_idx+"'";
   rs = stmt.executeQuery(query);
   rs.next();   
   out.println("<b>"+"NAME :"+rs.getString(1)+"</b>");
   rs=null;
   
   out.println("<table border width=100%>");
 out.println("<tr><th>code</th><th>name</th><th>side</th><th>number</th><th>totalprice</th></tr>");   

   i=0;
   for(i=0;i<vector_code.size();i++)
      {
       query="select sp_name,sp_lr from spare_part where sp_code='"+(String)vector_code.elementAt(i)+"'";
       rs = stmt.executeQuery(query);
       rs.next();
out.println("<tr><td>"+(String)vector_code.elementAt(i)+"</td><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+(String)vector_stockx.elementAt(i)+"</td><td>"+(String)vector_total.elementAt(i)+"</td></tr>");                
      }
 out.println("<tr><td>"+" "+"</td><td>"+" "+"</td><td>"+" "+"</td><td>"+" "+"</td><td>"+total_price+"</td></tr>");      
   out.println("</table>");         
   
out.println("<a href=\"http://"+connect.hostname+"/servlet/Sap/?lastpage=yes\">home</a>");
   out.println("</body>");
   out.println("</html>");   
   con.close();
  }
  catch(Exception ex)
  {
   ex.printStackTrace();
  }
 }   
 
 public String insert_customertable(String cn,String ln,String tl,String em,String ad,String pc)
 {
  int customer_id=0;
  String zero="";
  try
  { 
   String query="select MAX(CUSTOMER_ID) from CUSTOMER";
   rs = stmt.executeQuery(query);
   rs.next();
   customer_id=rs.getInt(1);
   customer_id++;
   stmt.close();
   rs=null;
   
   zero=getzero(4,customer_id);
   stmt=con.createStatement();
   query="INSERT INTO CUSTOMER VALUES('"+zero+customer_id+"','1',NULL,NULL,'"+cn+"','"+ln+"','"+tl+"','"+em+"','"+ad+"','"+pc+"')";
   
   stmt.executeUpdate(query);
   con.commit();
   stmt.close();
   stmt=con.createStatement();
  }
  catch(Exception ex)
  {
   ex.printStackTrace();
  } 
  String re_type=zero+customer_id;
  return re_type;
 }  
 
 public void update_stock(Vector code,Vector stockx)
 {
  try
  {  
  int i=0;
  int stock,bought;
  String query;
  for(i=0;i<code.size();i++)
     { 
      stmt=con.createStatement();     
      //select thhe old stock
      query="select sp_stock from spare_part where sp_code='"+(String)code.elementAt(i)+"'";
      rs = stmt.executeQuery(query);
      rs.next();
      bought=Integer.parseInt((String)stockx.elementAt(i));
      stock=rs.getInt(1)-bought;
      stmt.close();
      rs=null;
      
      //put new stock to database
      stmt=con.createStatement();      
      query="UPDATE SPARE_PART SET sp_stock="+stock+"where sp_code='"+(String)code.elementAt(i)+"'";
      stmt.executeUpdate(query);
      stmt.close();
     }  
   con.commit();    
  }
  catch(Exception ex)
  {
   ex.printStackTrace();  
  }
 }
 
 public String update_invoice(String customer_id,int total_price,String invoice_date)
 {
  String st_invoice_id="";
  String zero;
  int in_invoice_id;
  try
  {
   //get the max invoice id
   stmt=con.createStatement();
   String query="select MAX(INVOICE_ID) from INVOICE";
   rs = stmt.executeQuery(query);
   rs.next();
   in_invoice_id=rs.getInt(1);
   in_invoice_id++;
   stmt.close();
   rs=null;   
      
   //insert
   zero=getzero(4,in_invoice_id);
   st_invoice_id=zero+in_invoice_id;
   
   stmt=con.createStatement();
   query="INSERT INTO INVOICE VALUES('"+st_invoice_id+"','"+customer_id+"','"+invoice_date+"',"+total_price+")";
   stmt.executeUpdate(query);
   con.commit();
   stmt.close();
   rs=null;   
  }
  catch(Exception ex)
  {
   ex.printStackTrace();  
  }
  return st_invoice_id; 
 }
 
 public String update_sale(String invoice_id,Vector code,Vector item,PrintWriter out)
 {String zero="";
  String st_sale_id="";
  int in_sale_id=0;
  try
  {
   //out.println("xxxxxxxxxxxxxxxxxx");
   stmt=con.createStatement();
   String query="select MAX(SALE_ID) from SALE";
   rs = stmt.executeQuery(query);
   rs.next();
   in_sale_id=rs.getInt(1);
   stmt.close();
   rs=null;     
   //out.println(in_sale_id);
   //out.println("yyyyyyyyyyyyyyyyyy");
    //insert
   stmt=con.createStatement();
   int i=0;
   for(i=0;i<code.size();i++)
   {
    in_sale_id++;
    zero=getzero(6,in_sale_id);
    //out.println(":"+zero+":");
    st_sale_id=zero+in_sale_id;
      
    query="INSERT INTO SALE VALUES('"+st_sale_id+"','"+invoice_id+"','"+(String)code.elementAt(i)+"',"+(String)item.elementAt(i)+")";
    stmt.executeUpdate(query);
    
   }
   con.commit();
   stmt.close();
   rs=null;     
  }
  catch(SQLException ex)
  {
   System.out.println("error while initializingg database connection"+ex.toString());
  }  
  return st_sale_id;
 }
 
 public String getzero(int its_digit,int any_id)
 {
  String zero="";
  String id="";
  int differ;

  id=id+any_id;  
  differ=its_digit-id.length();  
  while(differ>0)
       {
        differ--;
        zero=zero+"0";
       }
  return zero; 
 }
}