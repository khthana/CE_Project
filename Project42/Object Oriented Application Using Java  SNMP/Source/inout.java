
import java.net.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.math.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class inout extends HttpServlet{

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


	out.println("<head>");
	out.println("<title>In-Out Statistics</title>");
	out.println("<META HTTP-EQUIV=PRAGMA CONTENT=NO-CACHE>");
	out.println("</head>");



    out.println("<center>");
	out.println("<br><font color=blue size=6>In-Out Statistics of </font>"+"<font color=red size=6>"+ip+"</font><br><br>");
	
	out.println("<table width=90% cellspacing=0 cellpadding=5 border=1>");

	out.println("<tr>");
    out.println("<th>No.</th>");
    out.println("<th>In</th>");
    out.println("<th>Out</th>");
    out.println("<th>Total of Times</th>");
    out.println("</tr>");

	int count=0;

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
		int timecur = (int)(System.currentTimeMillis()/1000-900000000);
		int startti = timecur-Integer.parseInt(rs2.getString("timemill1"));
	    out.println("<td align=center>"+calbeau(startti)+"</td>");
       }
	   else{
		int differ=caltime(rs2.getString("timemill2"),rs2.getString("timemill1"));
        out.println("<td align=center>"+calbeau(differ)+"</td>");
	   }	

		out.println("</tr>");

     }
	}

    out.println("</table>");
    out.println("</center><br>");

    } catch ( Exception ex) {     }
	out.println("</body>");
    out.close();
  } 
  

  public static int caltime (String pname2,String pname1) {
		int time2 = Integer.parseInt(pname2);
		int time1 = Integer.parseInt(pname1);

		int res = time2-time1;
		return res;
  }

  public static String calbeau(int x)
	{

	String output = "";

	int s = x % 60;
		x /=60;
	int m = x % 60;
		x /=60;
	int h = x % 24;
	int d = x / 24;

	if (m == 0)
		output = s +"s";
	else if (h == 0)
		output = m + "m " + s +"s";
	else if (d == 0)
		output = h + "h " + m + "m " + s +"s";
	else 
		output = d + "d " + h + "h " + m + "m " + s +"s";
	return output;

	}


}
