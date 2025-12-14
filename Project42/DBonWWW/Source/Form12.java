import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Form12 extends HttpServlet {
  private ConnectionPool pool;

  public void init(ServletConfig config) throws ServletException {
  super.init(config);
  try {
    pool = new ConnectionPool("jdbc:oracle:thin:@"+connect.hostname+":"+connect.portnumber+":"+connect.databaseSID,connect.username,connect.password,"oracle.jdbc.driver.OracleDriver", 10, 5);
      }
  catch(Exception e) { 
      throw new UnavailableException(this, "Couldn't create connection pool");
      }
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
    
    //out.println(sp_namex);
 
   	out.println("<HTML><HEAD><TITLE>Choose Car</TITLE></HEAD>");
   out.println("<body background=\"/image/41.gif\">");
   	out.println("<center><img src=\"http://"+connect.hostname+"/image/bar2.gif\"></center>");      
   	out.println("<br>");
   
	out.println("<SCRIPT language=JavaScript>");

	out.println("function doReload111(entry) {");
	out.println("var current1,current2,current3;");		
	out.println("var menufacture,model,year,master,url;");
	out.println("current1 = entry.menufacture.selectedIndex;");
	out.println("menufacture = entry.menufacture.options[current1].value;");
	out.println("current2 = entry.model.selectedIndex;");
	out.println("model = entry.model.options[current2].value;");
	out.println("current3 = entry.year.selectedIndex;");
	out.println("year = entry.year.options[current3].value;");
        out.println("master = entry.master.value;");
        out.println("sp_namex=entry.sp_namex.value;");        
        out.println("lastpage=entry.lastpage.value;");        
	out.println("url = \"http://"+connect.hostname+"/servlets/Form111?master=\"+master+\"&menufacture=\"+menufacture+\"&model=\"+model+\"&year=\"+year+\"&sp_namex=\"+sp_namex+\"&lastpage=\"+lastpage;");
	out.println("if (model!=\"\")"); 
	out.println("window.location.href = url;");
	out.println("}");

	out.println("</SCRIPT>");

	Connection con = null;
	PreparedStatement pstmt = null;
        ResultSet rs = null;
try {	
      con = pool.getConnection();  
      con.setAutoCommit(false);	
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

      pstmt = con.prepareStatement("SELECT distinct model FROM car WHERE car_menufacturer="+"'"+menufacture+"' AND year="+"'"+year+"' ORDER BY model ASC");
      rs = pstmt.executeQuery();

	out.println("<SELECT NAME=\"model\" SIZE=\"1\" onchange=\"doReload111(this.form)\">");
	out.println("<OPTION SELECTED VALUE=\"\">----------------------</OPTION>");

      while(rs.next()) {
        out.println("<OPTION VALUE=\"" + rs.getObject("model").toString() + "\">" + rs.getObject("model").toString() + "</OPTION>" ); 	
      } 
      out.println("</SELECT>");    
    
	pstmt = null;
	rs = null;

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

   	con.commit();
	pstmt.close();
	rs.close();	
  	
    }
    catch(Exception e) { 
      try {
      con.rollback();
      }
      catch (Exception ignored) { }	
      //out.println("can not create connection in FORM "+ e.getMessage());    
    }
    finally {
      if (con != null) pool.returnConnection(con);
      }            

      	out.println("</BODY>");
      	out.println("</HTML>");
        out.close();
  }
  }