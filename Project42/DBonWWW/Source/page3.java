import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;


public class page3 extends HttpServlet
{
 String values[];
 Connection con = null;

 public void service(HttpServletRequest req,HttpServletResponse resp)
 throws ServletException,java.io.IOException
 {
  connectdb();
  getsparepart(req,resp);
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
    }
  catch(SQLException ex)
  {
   System.out.println("error while initializingg database connection"+ex.toString());
  } 
 } 

 public void getsparepart(HttpServletRequest req,HttpServletResponse resp)
 {
  try
  {
   resp.setContentType("text/html");
   PrintWriter out = resp.getWriter(); 
  
   HttpSession session=req.getSession(true);

   Statement stmt,stmt1 = null;
   ResultSet rs,rs1 = null; 
   stmt = con.createStatement();
   stmt1= con.createStatement();
   String query="";
  
   Vector vector_code   =new Vector(); 
   Vector vector_menufac=new Vector(); 
   Vector vector_price  =new Vector(); 
   Vector vector_stock  =new Vector(); 
   Vector vector_model  =new Vector();    
   Vector vector_lr     =new Vector();
   Vector vector_year   =new Vector();
   Vector vector_pic    =new Vector();
   Vector vector_des    =new Vector();
   Vector vector_piccode=new Vector();
   Vector vector_codex;
   Vector vector_stockx;
   
   out.println("<html>");
   out.println("<head>");
   out.println("<title>Shopping Spare Part</title>");
   out.println("</head>");
   out.println("<body background=\"/image/41.gif\">");
  out.println("<center><img src=\"http://"+connect.hostname+"/image/bar3.gif\"></center>");      
   out.println("<br>");
   
   out.println("<center><font color=\"#000080\"><h3>4) สั่งซื้อชิ้นส่วนอะไหล่ที่ต้องการ</h3></font></center>");
   out.println("<center><font size=2>การสั่งซื้ออะไหล่ทำได้โดยเลือกจำนวนอะไหล่ แล้วกดปุ่ม <font color=#AA0000 size=5>PICK</font> ในกรณีที่ต้องการยกเลิกการสั่งซื้อทำได้โดยกดปุ่ม <font color=#AA0000 size=5>UNPICK </font></font></center>");
   
   String sp_namex="";
   values=req.getParameterValues("sp_namex");
   if(values!=null) 
     {
      sp_namex=values[0];
      sp_namex=sp_namex.replace('.',' ');
      sp_namex=sp_namex.trim();      
     }
     
     out.println("<h3><b>อะไหล่ที่คุณเลือก : <font color=\"#000080\">"+sp_namex+"</font></b></h3>");
   out.println("<br>");

   out.println("<br>");        

   String lastpage="";
   values=req.getParameterValues("lastpage");
   if(values!=null) 
     {
      lastpage=values[0];
     }    


/*   out.println("your spare part you choose is");
   out.println(sp_namex);  
   out.println("<br>");*/
   
   
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


   String codex="";
   values=req.getParameterValues("codex");
   if(values!=null) 
     {
      codex=values[0];
     }
     
   String stockx="";
   values=req.getParameterValues("stockx");
   if(values!=null) 
     {
      stockx=values[0];
     }

     
   String findx="";
   values=req.getParameterValues("findx");
   if(values!=null) 
     {
      findx=values[0];
     }
    // out.println(findx);
   
//  out.println(findx);
  vector_codex=(Vector)session.getValue("mycodex");  
  vector_stockx=(Vector)session.getValue("mystockx");
  
  if(vector_codex==null)
    {
     vector_codex=new Vector();
    }
  if(vector_stockx==null)
    {
     vector_stockx=new Vector();
    }
    
    //out.println(lastpage);
    
  if(lastpage.compareTo("yes")==0)  //if have submit page 5 before
    {
     lastpage="no";
     clearelement(vector_codex);
     clearelement(vector_stockx);
     //out.println("it's have go to last page before");
    }  
  
  if(findx.compareTo("PICK")==0)
     {  
      int ff=0;
      for(ff=0;ff<vector_codex.size();ff++)
         {
          if(codex.compareTo((String)vector_codex.elementAt(ff))==0)
            {
             vector_codex.removeElement((String)vector_codex.elementAt(ff));
             vector_stockx.removeElement((String)vector_stockx.elementAt(ff));  
             //out.println("remove same value");           
            }          
         } 
       //out.println("OK buy this one");       
      vector_codex.addElement(codex);     
      vector_stockx.addElement(stockx);
     }

   if(findx.compareTo("UNPICK")==0)   
     {
      vector_codex.removeElement(codex);
      vector_stockx.removeElement(stockx);
     }
   session.putValue("mycodex",vector_codex);
   session.putValue("mystockx",vector_stockx);
   
   //test===========
/*     int test=0;
     for(test=0;test<vector_codex.size();test++)
        {
         out.println((String)vector_codex.elementAt(test));
         out.println((String)vector_stockx.elementAt(test));
        }*/
   //===========test  
   if((menufacture.compareTo("")==0)&&(model.compareTo("")==0)&&(year.compareTo("")==0))
  { 
   //out.println("000");
   query="select sp_code,sp_menufac,sp_lr,sp_stock,sp_price,model,year,sp_des,sp_pic,sp_piccode FROM spare_part s,car c WHERE sp_name='"+sp_namex+"' AND car_code IN (SELECT car_code FROM match WHERE sp_code=s.sp_code)";
  }
//out.println("<br>");
   
if((menufacture.compareTo("")==0)&&(model.compareTo("")==0)&&(year.compareTo("")!=0))
  { //out.println("001");
    query="select sp_code,sp_menufac,sp_lr,sp_stock,sp_price,model,year,sp_des,sp_pic,sp_piccode FROM spare_part s,car c WHERE sp_name='"+sp_namex+"' AND year='"+year+"' AND car_code IN (SELECT car_code FROM match WHERE sp_code=s.sp_code)";
  }
//out.println("<br>");

if((menufacture.compareTo("")==0)&&(model.compareTo("")!=0)&&(year.compareTo("")==0))
  { //out.println("010");
    query="select sp_code,sp_menufac,sp_lr,sp_stock,sp_price,model,year,sp_des,sp_pic,sp_piccode FROM spare_part s,car c WHERE sp_name='"+sp_namex+"' AND model='"+model+"' AND car_code IN (SELECT car_code FROM match WHERE sp_code=s.sp_code)";
  }
//out.println("<br>");

if((menufacture.compareTo("")==0)&&(model.compareTo("")!=0)&&(year.compareTo("")!=0))
  { //out.println("011");
    query="select sp_code,sp_menufac,sp_lr,sp_stock,sp_price,model,year,sp_des,sp_pic,sp_piccode FROM spare_part s,car c WHERE sp_name='"+sp_namex+"' AND year='"+year+"' AND model='"+model+"' AND car_code IN (SELECT car_code FROM match WHERE sp_code=s.sp_code)";
  }
//out.println("<br>");

if((menufacture.compareTo("")!=0)&&(model.compareTo("")==0)&&(year.compareTo("")==0))
  { //out.println("100");
    query="select sp_code,sp_menufac,sp_lr,sp_stock,sp_price,model,year,sp_des,sp_pic,sp_piccode FROM spare_part s,car c WHERE sp_name='"+sp_namex+"' AND sp_menufac='"+menufacture+"' AND car_code IN (SELECT car_code FROM match WHERE sp_code=s.sp_code)";
  }
//out.println("<br>");

if((menufacture.compareTo("")!=0)&&(model.compareTo("")==0)&&(year.compareTo("")!=0))
  { //out.println("101");
    query="select sp_code,sp_menufac,sp_lr,sp_stock,sp_price,model,year,sp_des,sp_pic,sp_piccode FROM spare_part s,car c WHERE sp_name='"+sp_namex+"' AND year='"+year+"' AND sp_menufac='"+menufacture+"' AND car_code IN (SELECT car_code FROM match WHERE sp_code=s.sp_code)";
  }
//out.println("<br>");

if((menufacture.compareTo("")!=0)&&(model.compareTo("")!=0)&&(year.compareTo("")==0))
  { //out.println("110");
    query="select sp_code,sp_menufac,sp_lr,sp_stock,sp_price,model,year,sp_des,sp_pic,sp_piccode FROM spare_part s,car c WHERE sp_name='"+sp_namex+"' AND sp_menufac='"+menufacture+"' AND model='"+model+"' AND car_code IN (SELECT car_code FROM match WHERE sp_code=s.sp_code)";
  }
//out.println("<br>");

if((menufacture.compareTo("")!=0)&&(model.compareTo("")!=0)&&(year.compareTo("")!=0))
  { //out.println("111");
    query="select sp_code,sp_menufac,sp_lr,sp_stock,sp_price,model,year,sp_des,sp_pic,sp_piccode FROM spare_part s,car c WHERE sp_name='"+sp_namex+"' AND sp_menufac='"+menufacture+"' AND model='"+model+"' AND year='"+year+"' AND car_code IN (SELECT car_code FROM match WHERE sp_code=s.sp_code)";
  }
//out.println("<br>");

     rs=stmt.executeQuery(query);
//     out.println("<br>");
     while(rs.next())
          {
           vector_code.addElement(rs.getString(1));           
           vector_menufac.addElement(rs.getString(2));
           vector_lr.addElement(rs.getString(3));
           vector_stock.addElement(rs.getString(4));
           vector_price.addElement(rs.getString(5));
           vector_model.addElement(rs.getString(6));  
           vector_year.addElement(rs.getString(7));
           vector_des.addElement(rs.getString(8));
           vector_pic.addElement(rs.getString(9));
           vector_piccode.addElement(rs.getString(10));
          } 

      int i=0;
//      out.println(vector_code.size());
      for(i=0;i<vector_code.size();i++)
         {    
          out.println("<table border width=100%>");    
          out.println("<table border>");              
          
          if((((String)vector_pic.elementAt(i)).compareTo("NULL")!=0)&&(((String)vector_pic.elementAt(i)).compareTo("null")!=0))
          {
          out.println("<tr><td><b>PRODUCT CODE:</b></td><td>"+"<a href=\"http://"+connect.hostname+"/servlet/pic/?pic="+(String)vector_pic.elementAt(i)+"&code="+(String)vector_piccode.elementAt(i)+"\""+">"+(String)vector_code.elementAt(i)+"</a></td></tr>");
           }
         else
           {
out.println("<tr><td><b>PRODUCT CODE:</b></td><td>"+(String)vector_code.elementAt(i)+"</td></tr>");           
           }  
           
 out.println("<tr><td><b>MENUFACTURE:</b></td><td>"+(String)vector_menufac.elementAt(i)+"</td></tr>");    
 out.println("<tr><td><b>SIDE:</b></td><td>"+(String)vector_lr.elementAt(i)+"</td></tr>");
 out.println("<tr><td><b>DESCRIBE:</b></td><td>"+(String)vector_des.elementAt(i)+"</td></tr>");
 out.println("<tr><td><b>PRICE:</b></td><td>"+(String)vector_price.elementAt(i)+"</td></tr>");    
 out.println("<tr><td><b>MODEL:</b></td><td>"+(String)vector_model.elementAt(i)+"</td></tr>");
 out.println("<tr><td><b>YEAR:</b></td><td>"+(String)vector_year.elementAt(i)+"</td></tr>");

          out.println("</table>");                                  
          out.println("</table>");                                  
         
          out.println("<form method=POST action=\""+"http://"+connect.hostname+"/servlet/page3"+"\">");         
          out.println("<input type=submit name=findx value=\""+"PICK"+"\">");
          out.println("<input type=submit name=findx value=\""+"UNPICK"+"\">");
          out.println("<input type=hidden name=sp_namex value=\""+sp_namex+"\">");
          out.println("<input type=hidden name=lastpage value=\""+lastpage+"\">");
          out.println("<input type=hidden name=codex value=\""+(String)vector_code.elementAt(i)+"\">");
          out.println("<input type=hidden name=menufacture value=\""+menufacture+"\">");      
          out.println("<input type=hidden name=model value=\""+model+"\">");
          out.println("<input type=hidden name=year value=\""+year+"\">");
          
          

          int stk=Integer.parseInt((String)vector_stock.elementAt(i));
          int k=0;
          out.println("<select name=stockx size=1>");
          for(k=1;k<stk+1;k++)
             {
              String k2=Integer.toString(k);
              out.println("<option value=\""+k2+"\">"+k2+"");
             }   
          out.println("</select>");                           
          
          out.println("</form>"); 
         }    
//   out.println("<br>");
   
if((vector_code.size()<=0))
  {
   out.println("<font size=3 color=#AA00000><b>\"ไม่พบอะไหล่ที่คุณต้องการ\"</font></b>");
   out.println("<br><br>");
   
  }


if((vector_codex.size()<=0)&&(vector_code.size()<=0))
  {
   out.println("");
  }
else
  {  
   out.println("<form method=POST action=\""+"http://"+connect.hostname+"/servlet/page4"+"\">");
   out.println("<input type=submit name=view value=\" >> ดูรายการสินค้าที่เลือกซื้อ >> \">");
   if(vector_codex.size()>0)
     {
      String send=null;
      String send2=null;
      if(vector_codex.size()>1)
        {
         send="<input type=hidden name=codex_page3 value=\"";
         send2="<input type=hidden name=stockx_page3 value=\"";
         for(i=0;i<vector_codex.size()-1;i++)
            {
             send=send+(String)vector_codex.elementAt(i);
             send2=send2+(String)vector_stockx.elementAt(i);
             send=send+" ";
             send2=send2+" ";
            }
         send=send+(String)vector_codex.elementAt(i);   
         send2=send2+(String)vector_stockx.elementAt(i);   
         send=send+"\">";
         send2=send2+"\">";
        }//if
      else
        {
         if(vector_codex.size()==1)
           {
            send="<input type=hidden name=codex_page3 value=\""+(String)vector_codex.elementAt(0)+"\">";
            send2="<input type=hidden name=stockx_page3 value=\""+(String)vector_stockx.elementAt(0)+"\">";                       
           }//if
        }//else       
      out.println(send);
      out.println(send2);
     }//if
    out.println("<input type=hidden name=sp_namex value=\""+sp_namex+"\">");
    out.println("<input type=hidden name=lastpage value=\""+lastpage+"\">");
    out.println("<input type=hidden name=menufacture value=\""+menufacture+"\">"); 
    out.println("<input type=hidden name=model value=\""+model+"\">");
    out.println("<input type=hidden name=year value=\""+year+"\">");
    out.println("</form>");     
   }
   out.println("<a href=\"http://"+connect.hostname+"/servlet/Sap\">เลือกซื้ออะไหล่เพิ่มเติม</a>");   

   out.println("</body>");
   out.println("</html>");
   
   clearelement(vector_code);
   clearelement(vector_menufac);
   clearelement(vector_price);
   clearelement(vector_stock);
   clearelement(vector_model);
   clearelement(vector_lr);
   clearelement(vector_year);
   stmt.close();
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
  
  if(vec.size()!=0)
    {
     j=vec.size();
     for(i=0;i<j;i++)
        {
         dummy=(String)vec.elementAt(0);
         vec.removeElement(dummy);
        }
    } 
 } 
}
