
import java.net.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.math.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class viewall extends HttpServlet{

  String flag [] = {"dead","dead","dead","dead","dead","dead","dead","dead","dead","dead","dead","dead","dead"};	
	//  0..12
  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

	res.setContentType("text/html");  
	PrintWriter out = res.getWriter();

	out.println("<head>");
	out.println("<title>View all</title>");
	out.println("<META HTTP-EQUIV=PRAGMA CONTENT=NO-CACHE>");
	out.println("</head>");

  
try{	

	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
	Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");

	Statement stmt = null;	
	stmt = conn.createStatement();
	ResultSet rs2 = stmt.executeQuery("select * from keepalltime");


	String flag[] = new String[13]; //0..12
	for (int y=1; y<13; y++) flag[y]="dead";
	
	while (rs2.next())
	{
     if (rs2.getString("inter").equals("161.246.6.117#1") ) flag[1]= "live"; else
     if (rs2.getString("inter").equals("161.246.6.121#1") ) flag[2]= "live"; else
     if (rs2.getString("inter").equals("161.246.6.127#1") ) flag[3]= "live"; else
     if (rs2.getString("inter").equals("161.246.6.130#1") ) flag[4]= "live"; else
     if (rs2.getString("inter").equals("161.246.6.157#1") ) flag[5]= "live"; else
     if (rs2.getString("inter").equals("161.246.6.52#1") )  flag[6]= "live"; else
     if (rs2.getString("inter").equals("161.246.6.53#1") )  flag[7]= "live"; else
     if (rs2.getString("inter").equals("161.246.6.54#1") )  flag[8]= "live"; else
     if (rs2.getString("inter").equals("161.246.6.58#1") )  flag[9]= "live"; else
     if (rs2.getString("inter").equals("161.246.6.70#1") )  flag[10]= "live";else
     if (rs2.getString("inter").equals("161.246.4.3#1") )   flag[11]= "live";else
     if (rs2.getString("inter").equals("161.246.6.10#1") )  flag[12]= "live";	 
     
	}


		out.println("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");
		out.println("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");

		if (flag[12].equals("dead")) 
			out.println("<a href=http://161.246.6.160/sw610.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/switch610d.bmp\"></a>");
		else 
			out.println("<a href=http://161.246.6.160/sw610.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/switch610u.bmp\"></a>");

		out.println("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");
		out.println("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");
		out.println("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");

		if (flag[11].equals("dead")) 
			out.println("<a href=http://161.246.6.160/serv43.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/server43d.bmp\"></a><br>");
		else
			out.println("<a href=http://161.246.6.160/serv43.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/server43u.bmp\"></a><br>");

		out.println("<img width=100% height=30 src=\"http://161.246.6.160/images/pipes.bmp\">");

		out.println("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");
		if (flag[1].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc6117.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc117d.bmp\"></a>");
		else
			out.println("<a href=http://161.246.6.160/pc6117.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc117u.bmp\"></a>");

		if (flag[2].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc6121.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc121d.bmp\"></a>");
		else
			out.println("<a href=http://161.246.6.160/pc6121.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc121u.bmp\"></a>");

		if (flag[3].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc6127.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc127d.bmp\"></a>");
		else
			out.println("<a href=http://161.246.6.160/pc6127.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc127u.bmp\"></a>");

		if (flag[4].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc6130.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc130d.bmp\"></a>");
		else
			out.println("<a href=http://161.246.6.160/pc6130.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc130u.bmp\"></a>");

		if (flag[5].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc6157.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc157d.bmp\"></a>");
		else
			out.println("<a href=http://161.246.6.160/pc6157.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc157u.bmp\"></a>");

		out.println("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=blue size=6 face=\"Comic Sans MS\">Main Map</font><br>");
		out.println("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");
		if (flag[6].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc652.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc52d.bmp\"></a>");
		else
			out.println("<a href=http://161.246.6.160/pc652.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc52u.bmp\"></a>");

		if (flag[7].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc653.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc53d.bmp\"></a>");
		else
			out.println("<a href=http://161.246.6.160/pc653.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc53u.bmp\"></a>");

		if (flag[8].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc654.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc54d.bmp\"></a>");
		else
			out.println("<a href=http://161.246.6.160/pc654.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc54u.bmp\"></a>");

		if (flag[9].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc658.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc58d.bmp\"></a>");
		else
			out.println("<a href=http://161.246.6.160/pc658.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc58u.bmp\"></a>");

		if (flag[10].equals("dead")) 
			out.println("<a href=http://161.246.6.160/pc670.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc70d.bmp\"></a><br>");
		else
			out.println("<a href=http://161.246.6.160/pc670.shtml target=\"_blank\"><img border=0 src=\"http://161.246.6.160/images/pc70u.bmp\"></a><br>");

		
	out.println("<br>");	
	out.println("<center>");	
	out.println("<a href=http://161.246.6.160/directquery.html target=\"_blank\">Click here for Direct Query</a>");
	out.println("</center>");
	out.println("<br>");	
	out.println("<br>");	

    } catch ( Exception ex) {     }
	out.println("</body>");
    out.close();
  } 
  


  


}
