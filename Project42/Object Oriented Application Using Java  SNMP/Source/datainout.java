
import java.net.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.sql.*;
import java.math.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class datainout extends HttpServlet{

  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

  res.setContentType("text/html");  
  PrintWriter out = res.getWriter();
  
  String ip = req.getParameter("ip");

try{	

	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
	Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");

	Statement stmt = null;	
	stmt = conn.createStatement();
	ResultSet rs2 = stmt.executeQuery("select * from inoutdevice order by timemill1");


	out.println("<title>Octet Statistics</title>");

    out.println("<center>");
	out.println("<br><font color=blue size=6>Octet Statistics of </font>"+"<font color=red size=6>"+ip+" Interface 1</font><br><br>");
	
	out.println("<table width=98% cellspacing=0 cellpadding=5 border=1>");

	out.println("<tr>");
    out.println("<th>No.</th>");
    out.println("<th>In</th>");
    out.println("<th>Out</th>");
    out.println("<th>T InOctet</th>");
    out.println("<th>T OutOctet</th>");
    out.println("</tr>");

	int count=0,inoctetcur=0,outoctetcur=0;

	while (rs2.next())
	{
     if (rs2.getString("inter").equals(ip+"#1") ){

	   
	    out.println("<tr>");
		count=count+1;
		out.println("<td align=center><font color=blue>"+count+"</font></td>");

	   if (rs2.getString("backing").equals("true")) 
	    out.println("<td>"+rs2.getString("date1")+" <font color=red>&nbsp (backing)</font>"+"</td>");
	   else
		out.println("<td>"+rs2.getString("date1")+"</td>");

	   if (rs2.getString("date2").equals("e")) {
		java.util.Date dz = new java.util.Date();
		String datez = dz.toString();
	    out.println("<td>"+datez+" <font color=red>&nbsp (playing)</font>"+"</td>");
       }
	   else
		out.println("<td>"+rs2.getString("date2")+"</td>");


	   if (rs2.getString("date2").equals("e")) {
		Statement stmt8 = null;	
		stmt8 = conn.createStatement();
		ResultSet rs8 = stmt8.executeQuery("select * from keepalltime");
		while (rs8.next())
		{
			if (rs8.getString("inter").equals(ip+"#1") ){
				inoctetcur  = Integer.parseInt(rs8.getString("inoctet").trim());
				outoctetcur = Integer.parseInt(rs8.getString("outoctet").trim());
			}
		}
		int intoshow  = inoctetcur-Integer.parseInt(rs2.getString("inoctet1").trim());
		int outtoshow = outoctetcur-Integer.parseInt(rs2.getString("outoctet1").trim());
	    out.println("<td align=center>"+intoshow+"</td>");
	    out.println("<td align=center>"+outtoshow+"</td>");
       }
	   else{
		int differ1=caltime(rs2.getString("inoctet2").trim(),rs2.getString("inoctet1").trim());
		int differ2=caltime(rs2.getString("outoctet2").trim(),rs2.getString("outoctet1").trim());
        out.println("<td align=center>"+differ1+"</td>");
        out.println("<td align=center>"+differ2+"</td>");
	   }	

		out.println("</tr>");

     }
	}

    out.println("</table><br><br><br>");

	
	out.println("<br><font color=blue size=6>Octet Statistics of </font>"+"<font color=red size=6>"+ip+" Interface 2</font><br><br>");
	
	out.println("<table width=98% cellspacing=0 cellpadding=5 border=1>");

	out.println("<tr>");
    out.println("<th>No.</th>");
    out.println("<th>In</th>");
    out.println("<th>Out</th>");
    out.println("<th>T InOctet</th>");
    out.println("<th>T OutOctet</th>");
    out.println("</tr>");

	int count2=0,inoctetcur2=0,outoctetcur2=0;
	Statement stmtz = null;	
	stmtz = conn.createStatement();
	rs2 = stmtz.executeQuery("select * from inoutdevice order by timemill1");

	while (rs2.next())
	{
     if (rs2.getString("inter").equals(ip+"#2") ){

	   
	    out.println("<tr>");
		count2=count2+1;
		out.println("<td align=center><font color=blue>"+count2+"</font></td>");

	   if (rs2.getString("backing").equals("true")) 
	    out.println("<td>"+rs2.getString("date1")+" <font color=red>&nbsp (backing)</font>"+"</td>");
	   else
		out.println("<td>"+rs2.getString("date1")+"</td>");

	   if (rs2.getString("date2").equals("e")) {
		java.util.Date dz2 = new java.util.Date();
		String datez2 = dz2.toString();
	    out.println("<td>"+datez2+" <font color=red>&nbsp (playing)</font>"+"</td>");
       }
	   else
		out.println("<td>"+rs2.getString("date2")+"</td>");


	   if (rs2.getString("date2").equals("e")) {
		Statement stmt9 = null;	
		stmt9 = conn.createStatement();
		ResultSet rs9 = stmt9.executeQuery("select * from keepalltime");
		while (rs9.next())
		{
			if (rs9.getString("inter").equals(ip+"#2") ){
				inoctetcur2 = Integer.parseInt(rs9.getString("inoctet").trim());
				outoctetcur2= Integer.parseInt(rs9.getString("outoctet").trim());
			}
		}
		int intoshow2 = inoctetcur2-Integer.parseInt(rs2.getString("inoctet1").trim());
		int outtoshow2= outoctetcur2-Integer.parseInt(rs2.getString("outoctet1").trim());
	    out.println("<td align=center>"+intoshow2+"</td>");
	    out.println("<td align=center>"+outtoshow2+"</td>");
       }
	   else{
		int differ1a=caltime(rs2.getString("inoctet2").trim(),rs2.getString("inoctet1").trim());
		int differ2a=caltime(rs2.getString("outoctet2").trim(),rs2.getString("outoctet1").trim());
        out.println("<td align=center>"+differ1a+"</td>");
        out.println("<td align=center>"+differ2a+"</td>");
	   }	

		out.println("</tr>");

     }
	}

    out.println("</table>");
	out.println("</center><br><br><br><br>");

    } catch ( Exception ex) {
      out.println("Error in : ");
      out.println(ex);	
	}
	out.println("</body>");
    out.close();
  } 
  

  public static int caltime (String pname2,String pname1) {
		int time2 = Integer.parseInt(pname2);
		int time1 = Integer.parseInt(pname1);

		int res = time2-time1;
		return res;
  }



}
