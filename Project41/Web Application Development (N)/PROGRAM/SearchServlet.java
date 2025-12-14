import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.*;
import java.net.*;
import java.sql.*;
import oracle.jdbc.*;

public class SearchServlet extends HttpServlet
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
   public void doPost(HttpServletRequest req,HttpServletResponse res)
       throws ServletException,IOException
   {  res.setContentType("text/html");
      boolean ins = false;
      boolean only = false;

      try
      {  OutputStream os = res.getOutputStream(); 
         OutputStreamWriter osw = new OutputStreamWriter(os,"cp874");
         PrintWriter toClient = new PrintWriter(osw);
         
         
         toClient.println("<html>");
         toClient.println("<head>");
         toClient.println("<title>Search Result from my Search engine</title>");
         toClient.println("</head>");
         toClient.print("<body text=\"#000099\" bgcolor=\"#0FFFFFF\" ");
         toClient.println("alink=\"#FF00FF\" background=\"/snowbg.gif\" >");
         toClient.print("<br><h3><b><a href=\"/searchpage.html\"> ");
         toClient.print(" main page </a>&nbsp;||&nbsp;<a href=\"/realsearch.html\">");
         toClient.print(" real time search </a> &nbsp;||&nbsp<a href=\"/testlink.html\">");
         toClient.println(" show link</a></b></h3>");
         toClient.flush();
         
         toClient.println("<br>");
         toClient.println("<h1>RESULT FOR YOUR SEARCH</h1>");
         toClient.println("<br>");
         
         String value = req.getParameterValues("keyword")[0];
         value = value.trim();
         
         String matchtype = req.getParameterValues("matchtype")[0];
         if( matchtype!=null )
         {  matchtype = matchtype.trim();
         
            if( matchtype.equalsIgnoreCase("yes") )
            {  only = true;
            }
            else
            {  only = false;
            }
         }
         
         String inserttype = req.getParameterValues("inserttype")[0];
         if( inserttype!=null )
         {  inserttype = inserttype.trim();
         
            if( inserttype.equalsIgnoreCase("no") )
            {  ins = false;
            }
            else
            {  ins = true;
            }
         }
         
         StringBufferInputStream sbis = new StringBufferInputStream(value);
         InputStreamReader isr = new InputStreamReader(sbis,"cp874");

         int i = 0;
         char c=' ';
         String temp="";
         while(i!=-1)
         {  i=isr.read();
            if(i!=-1)
            {  c = (char) i;
               temp=temp+c;    
            }
         }

         toClient.print("<i><big>You're searching for : </i></big><big>");
         toClient.println("<big><font color=\"red\"><b>"+temp+"</b></big></big></font><br>");
         String searchQuery =  "SELECT DISTINCT * "+
                              "FROM KEY,DATA "+
                              "WHERE KEY.URLNUMBER = DATA.URLNUMBER "+
                              "AND KEY.KEYWORDS ";

         String searchkey = "";
         if( only )
         {  searchkey = searchQuery+ "= '" +temp+ "' "+
                            "ORDER BY KEY.PRIORITY DESC";
         }
         else
         {  searchkey = searchQuery+ "LIKE '%" +temp+ "%' "+ 
                        "ORDER BY KEY.PRIORITY DESC";
         }
         
         toClient.println("<h2>RESULTS ARE</h2>");
        
         ResultSet rs = state.executeQuery(searchkey);
         
         int count=1;
         
         while(rs.next())
         {  
            int priority = rs.getInt("PRIORITY");
            String urlname = rs.getString("URLNAME");
            String description = rs.getString("DESCRIPTION");
            int pagesize = rs.getInt("PAGESIZE");
            String title = rs.getString("TITLE");
            toClient.println("<h2>" +count+ ". " + "<a href=\"" +urlname+ "\">"+urlname+"</a></h2>");
            toClient.print("<b><font color=\"red\"><big>RATING :  </big></font></b>");
            if( priority <= 20 )
            {  toClient.println("<IMG SRC=\"/stars1.gif\" boder=0 height=12 width=64>");
            }
            if( (priority>20)&&(priority<=70) )
            {  toClient.println("<IMG SRC=\"/stars2.gif\" boder=0 height=12 width=64>");
            }                                
            if( (priority>70)&&(priority<=120) )
            {  toClient.println("<IMG SRC=\"/stars3.gif\" boder=0 height=12 width=64>");
            }
            if( (priority>120)&&(priority<=170) )
            {  toClient.println("<IMG SRC=\"/stars4.gif\" boder=0 height=12 width=64>");
            }
            if( priority > 170 )
            {  toClient.println("<IMG SRC=\"/stars5.gif\" boder=0 height=12 width=64>");
            }
            toClient.println("<br><b>SIZE : </b>"+pagesize+"<b> bytes</b>");
            toClient.println("<br><b>TITLE : </b>"+title);
            toClient.println("<br><b>DESCRIPTION : </b>"+description);
            count++;
         }
         
         if(count==1)
         {  toClient.println("&nbsp;");
            toClient.println("<center>");
            toClient.println("<br><img SRC=\"/kik2.gif\" height=97 width=638>");
            toClient.println("<br>&nbsp;");
            toClient.println("<p><img SRC=\"/kik5.gif\" height=40 width=650>");
            toClient.println("<p><img SRC=\"/pulleye.gif\" height=130 width=96></center>");
            
            if( ins )
            {  String checkupdate = "SELECT * FROM SEARCHED_KEY WHERE KEYWORDS = '"+
                                  temp +"'";
               ResultSet ck = state.executeQuery(checkupdate);
               if( ck.next() )
               {
               }
               else
               {  String up = "INSERT INTO UNSEARCH_KEY VALUES ('"+
                           temp+ "',1)";
                  state.executeUpdate(up);
               }
            }
         }   
         else
         {  toClient.println("<br><center><h2><font color=\"red\">END SEARCH</h2></center></font>");
         }
         toClient.println("</body>");
         toClient.println("</html>");
         toClient.flush();
         toClient.close();
      } catch(Exception exc)
      {  printreport("checkpoint2",exc);
      }
   }     //end dopost
//------------------------------------------------------
   public void doGet(HttpServletRequest req,HttpServletResponse res)
       throws ServletException,IOException
   {  res.setContentType("text/html");
      
      String command  =    "SELECT DISTINCT * "+
                              "FROM KEY,DATA "+
                              "WHERE KEY.URLNUMBER = DATA.URLNUMBER "+
                              "AND KEY.KEYWORDS = ";

      try
      {  OutputStream os = res.getOutputStream(); 
         OutputStreamWriter osw = new OutputStreamWriter(os,"cp874");
         PrintWriter toClient = new PrintWriter(osw);
         
         
         toClient.println("<html>");
         toClient.println("<head>");
         toClient.println("<title>Search Result from my Search engine:Get method</title>");
         toClient.println("</head>");
         toClient.print("<body text=\"#000099\" bgcolor=\"#0FFFFFF\" ");
         toClient.println("alink=\"#FF00FF\" background=\"/snowbg.gif\" >");
         toClient.print("<br><h3><b><a href=\"/searchpage.html\"> ");
         toClient.print(" main page </a>&nbsp;||&nbsp;<a href=\"/realsearch.html\">");
         toClient.print(" real time search </a> &nbsp;||&nbsp<a href=\"/testlink.html\">");
         toClient.println(" show link</a></b></h3>");
         toClient.flush();
         
         toClient.println("<br>");
         toClient.println("<h1>RESULT FOR YOUR SEARCH</h1>");
         toClient.println("<br>");
         String value = req.getQueryString();
         value = value.trim();
         
         StringBufferInputStream sbis = new StringBufferInputStream(value);
         InputStreamReader isr = new InputStreamReader(sbis,"cp874");

         int i = 0;
         char c=' ';
         String temp="";
         while(i!=-1)
         {  i=isr.read();
            if(i!=-1)
            {  c = (char) i;
               temp=temp+c;    
            }
         }
         toClient.print("<i><big>You're searching for : </i></big>");
         toClient.println("<big><big><font color=\"red\"><b>"+temp+"</b></big></big></font><br>");

         String searchkey = command+ "'" +temp+ "' "+
                            "ORDER BY KEY.PRIORITY DESC";
         
         toClient.println("<h2>RESULTS ARE</h2>");
        
         ResultSet rs = state.executeQuery(searchkey);
         
         int count=1;
         
         while(rs.next())
         {  
            int priority = rs.getInt("PRIORITY");
            String urlname = rs.getString("URLNAME");
            String description = rs.getString("DESCRIPTION");
            int pagesize = rs.getInt("PAGESIZE");
            String title = rs.getString("TITLE");
            toClient.println("<h2>" +count+ ". " + "<a href=\"" +urlname+ "\">"+urlname+"</a></h2>");
            
            toClient.print("<b><font color=\"red\"><big>RATING : </big></font></b>");
            if( priority <= 20 )
            {  toClient.println("<IMG SRC=\"/stars1.gif\" boder=0 height=12 width=64>");
            }
            if( (priority>20)&&(priority<=70) )
            {  toClient.println("<IMG SRC=\"/stars2.gif\" boder=0 height=12 width=64>");
            }                                
            if( (priority>70)&&(priority<=120) )
            {  toClient.println("<IMG SRC=\"/stars3.gif\" boder=0 height=12 width=64>");
            }
            if( (priority>120)&&(priority<=170) )
            {  toClient.println("<IMG SRC=\"/stars4.gif\" boder=0 height=12 width=64>");
            }
            if( priority > 170 )
            {  toClient.println("<IMG SRC=\"/stars5.gif\" boder=0 height=12 width=64>");
            }
            
            toClient.println("<br><b>SIZE : </b>"+pagesize+"<b> bytes</b>");
            toClient.println("<br><b>TITLE : </b>"+title);
            toClient.println("<br><b>DESCRIPTION : </b>"+description);
            count++;
         }
         if(count==1)
         {  toClient.println("&nbsp;");
            toClient.println("<center>");
            toClient.println("<br><img SRC=\"/kik2.gif\" height=97 width=638>");
            toClient.println("<br>&nbsp;");
            toClient.println("<p><img SRC=\"/kik5.gif\" height=40 width=650>");
            toClient.println("<p><img SRC=\"/pulleye.gif\" height=130 width=96></center>");

         }   
         else
         {  toClient.println("<br><center><h2><font color=\"red\">END SEARCH</h2></center></font>");
         }
         
         toClient.println("</body>");
         toClient.println("</html>");
         toClient.flush();
         toClient.close();
      } catch(Exception exc)
      {  printreport("checkpoint A",exc);
      }
   }
//------------------------------------------------------   
   public void printreport(String mes,Exception ee )
   {  try
      {  FileWriter fw = new FileWriter("d:\\project\\purelog1.txt",true);
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
   {  return "Search Engine Servlet";
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
//=================== END CLASS SEARCHSERVLET ===============
