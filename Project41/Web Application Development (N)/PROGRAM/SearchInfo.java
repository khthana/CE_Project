import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.*;
import java.net.*;
import java.sql.*;
import search.*;
import oracle.jdbc.*;

public class SearchInfo extends HttpServlet
{  Connection con;
   Statement state;
//-----------------------------------------------------
   public void init(ServletConfig config) throws ServletException
   {  super.init(config);
      
      String url = "jdbc:oracle:thin:@PURE:1521:orcl";
      String user="purekik";
      String password="purekik";
      try
      {  Class.forName("oracle.jdbc.driver.OracleDriver");
         con=DriverManager.getConnection(url,user,password);
         state = con.createStatement();
      
      }  catch (Exception e)
      {  printreport("checkpoint1",e);
      }
   
   }                   
//--------------------------------------------------------
   public void doGet(HttpServletRequest req,HttpServletResponse res)
       throws ServletException,IOException
   {  res.setContentType("text/html");
      String mycheck = req.getQueryString();
      if( mycheck!=null ) mycheck= mycheck.substring(mycheck.indexOf('=')+1);
      String searchQuery =    "SELECT DISTINCT * "+
                              "FROM ";
      try
      {  OutputStream os = res.getOutputStream(); 
         OutputStreamWriter osw = new OutputStreamWriter(os,"cp874");
         PrintWriter toClient = new PrintWriter(osw);
         
         toClient.println("<html>");
         toClient.println("<head>");
         toClient.println("<title>KEYWORDS IN DATABASE</title>");
         toClient.println("</head>");
         toClient.print("<body text=\"#000099\" bgcolor=\"#0FFFFFF\" ");
         toClient.println("alink=\"#FF00FF\" background=\"/snowbg.gif\" >");
         toClient.print("<br><h3><b><a href=\"/searchpage.html\"> ");
         toClient.print(" main page </a>&nbsp;||&nbsp;<a href=\"/realsearch.html\">");
         toClient.print(" real time search </a> &nbsp;||&nbsp<a href=\"/testlink.html\">");
         toClient.println(" show link</a></b></h3>");
         toClient.flush();
         
         toClient.println("<br>");
         toClient.println("<h1>THESE ARE KEYWORDS IN <font color=\"red\" >"+mycheck+"</font></h1>");
         toClient.println("<br>");
         
         String searchkey = searchQuery+ mycheck;        
         ResultSet rs = state.executeQuery(searchkey);
         
         int count=1;
         while(rs.next())
         {  
            String key = rs.getString("KEYWORDS");
            toClient.print("<b>" +count+ ".</b>&nbsp"); 
            toClient.println("<a href=\"/servlet/SearchServlet?" +key+ "\">" +key+ "</a><br>");
            count++;
         }
         if(count==1)
         {  toClient.println("<h2><font color=\"red\"><center> SORRY,DON'T HAVE KEY IN DATABASE </h2></font></center>");
         }   
         toClient.println("</body>");
         toClient.println("</html>");
         toClient.flush();
         toClient.close();
      } catch(Exception exc)
      {  printreport("checkpoint2 ",exc);
      }
   }     //end doGET
//----------------------------------------------------
   public void printreport(String mes,Exception ee )
   {  try
      {  FileWriter fw = new FileWriter("d:\\project\\SearchInfo.err",true);
         BufferedWriter bw = new BufferedWriter(fw);
         bw.write("have error at "+mes+" : "+ee.getMessage());
         bw.newLine();
         bw.flush();
         bw.close();
      } catch(IOException ioe)
      {  System.out.println("have error while write error log.");
      }
   }
      
//-------------------------------------------------------   
   public String getServletInfo()
   {  return "Search Information Engine Servlet";
   }
//-------------------------------------------------------
   public void destroy()
   {  try
      {  con.close();
      } catch(Exception e)
      {  printreport("checkpoint4",e);
      }
   }
}
