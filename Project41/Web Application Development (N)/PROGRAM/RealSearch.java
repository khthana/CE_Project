import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.*;
import java.net.*;
import java.sql.*;
import oracle.jdbc.*;

public class RealSearch extends HttpServlet
        implements SingleThreadModel
{  
//-----------------------------------------------------
   public void init(ServletConfig config) throws ServletException
   {  super.init(config);
   }                   
//--------------------------------------------------------
   public void doPost(HttpServletRequest req,HttpServletResponse res)
       throws ServletException,IOException
   {  res.setContentType("text/html");
      
      boolean numerr = false;
      boolean haveinsearch = false;
      boolean haveinrealsearch=false;
      
      int max = 0;
      int turn = 0;
      int counter = 1;
      int current=0;
      
      String keyword = null;

      try
      {  OutputStream os = res.getOutputStream(); 
         OutputStreamWriter osw = new OutputStreamWriter(os,"cp874");
         PrintWriter toClient = new PrintWriter(osw);
         
         toClient.println("<html>");
         toClient.println("<head>");
         toClient.println("<title>Real Time Search Engine</title>");
         toClient.println("</head>");
         toClient.print("<body text=\"#000099\" bgcolor=\"#0FFFFFF\" ");
         toClient.println("alink=\"#FF00FF\" background=\"/snowbg.gif\" >");
         toClient.print("<br><h3><b><a href=\"/searchpage.html\"> ");
         toClient.print(" main page </a>&nbsp;||&nbsp;<a href=\"/realsearch.html\">");
         toClient.print(" search again</a> &nbsp;||&nbsp<a href=\"/testlink.html\">");
         toClient.println(" show link</a></b></h3>");
         toClient.flush();
         
         toClient.println("<br>");
         
         try
         {  RealDatabase real0 = new RealDatabase();
            max = real0.getMaxOrder();
            real0.getClose();
         } catch(SQLException s0)
         {  printreport("checkpoint0",s0);
         }
         
         String value = req.getParameterValues("key")[0];
         value = value.trim();
         
         String num = req.getParameterValues("count")[0];
         if( num!=null )
         {  num = num.trim();
            try
            {  turn = Integer.parseInt(num);
            } catch(NumberFormatException n)
            {  numerr=true;
               printreport("checkpoint1",n);
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
         keyword=temp;
         if( numerr )
         {  toClient.println("<h1><font color=\"red\">SORRY, YOU ENTER WRONG ARGUMENTS</h1></font>");
         }
         else
         {  toClient.print("<i><big>You're searching for : </i></big><big>");
            toClient.print("<big><font color=\"red\"><b>&nbsp;"+keyword);
            toClient.print("&nbsp; within &nbsp " + turn+ "&nbsp;page</b></big></big></font><br>");
            toClient.flush();
            try
            {  RealDatabase real1 = new RealDatabase();
               ResultSet rs1 = real1.getInSearchKey(keyword);
               
               if( rs1.next() )
               {  haveinsearch=true;
               }
               else
               {  haveinsearch = false;
               }
               real1.getClose();
            } catch(SQLException s1)
            {  printreport("checkpoint2",s1);
            }
            
            if( haveinsearch )
            {  toClient.print("<b><big><big>Your key have in our database, to view it click");
               toClient.println(" &nbsp;<a href=\"/servlet/SearchServlet?" +keyword+ "\">here</a></b></big></big>");
            }
            else
            {  try
               {  RealDatabase real2 = new RealDatabase();
                  ResultSet rs2 = real2.getInRealSearch(keyword);
                  if( rs2.next() )
                  {  haveinrealsearch=true;
                     current = rs2.getInt("UPCURRENT");
                  }
                  else 
                  {  haveinrealsearch=false;
                  }   
                  real2.getClose();
               } catch(SQLException s2)
               {  printreport("checkpoint3",s2);
               }
//------------------------------------------------------
               try
               {  RealDatabase real3 = new RealDatabase();
                  ResultSet updatelist = real3.getUpdateList(current);
                  ENDING:
                  while( updatelist.next() )
                  {  int order = updatelist.getInt("URLNUMBER");
                     String pagename = updatelist.getString("urlname").trim();
                     
                     toClient.print("<b>SEARCHING</b> &nbsp;&nbsp;<big><big> " +counter); 
                     toClient.println(".&nbsp;&nbsp;" +pagename+ "</big></big><br>");
                     toClient.flush();
                     MyP mypage = new MyP(pagename);
                     if( mypage.isUsable() )
                     {  MyOp myoperate = new MyOp(mypage.getURLFile());
                        
                        int priority = myoperate.getValue(keyword);
                        if( priority>0 )
                        {  try
                           {  RealDatabase real4 = new RealDatabase();
                              real4.insertToKey(keyword,order,priority);
                              real4.getClose();
                           } catch(SQLException s4)
                           {  printreport("checkpoint5",s4);
                           }
                        }   
                        toClient.println("<font color=\"red\"> COMPLETE</font><br>");
                        toClient.flush();
                        current = order ;
                     }              // end if mypage is usable
                     else
                     {  toClient.print("<font color=\"black\">");
                        toClient.println("THIS PAGE IS NOT USABLE</font><br>");
                        toClient.flush();
                     }
                     
                     if( counter == turn ) 
                     {  break ENDING;
                     }
                     counter++;
                  }                 // end while updatelist.next();
                  real3.getClose();

               } catch(SQLException s3)
               {  printreport("checkpoint4",s3);
               }
               
               if( current+1==max )
               {  try
                  {  RealDatabase real6 = new RealDatabase();
                     real6.insertToSearchedKey(keyword,0);
                     real6.deleteFromRealSearch(keyword);
                     real6.getClose();
                  }  catch(SQLException s6)
                  {  printreport("checkpoint7",s6);
                  }
                  toClient.print("<br><h2><font color=\"red\">");
                  toClient.println("EMPTY LINK IN DATABASE!!!</h2></font>");
                  toClient.flush();
               }                
               else
               {  if( !(haveinrealsearch) )
                  {  try
                     {  RealDatabase real7 = new RealDatabase();
                        real7.insertToRealSearch(keyword,current);
                        real7.getClose();
                     }  catch(SQLException s7)
                     {  printreport("checkpoint8",s7);
                     }
                  }
                  else
                  {  try
                     {  RealDatabase real8 = new RealDatabase();
                        real8.changeUpCurrent(keyword,current);
                        real8.getClose();
                     }  catch(SQLException s8)
                     {  printreport("checkpoint9",s8);
                     }
                  }
               }                // END    IF CURRENT+1== MAX
            }                   // END ELSE IF HAVEINSEARCH

         }                      // END ELSE IF NUMERR
         toClient.println("<br>");
         if( (!(haveinsearch))&&(!(numerr)) )
         {  toClient.println("<h2><font color=\"red\">OPERATION COMPLETE.</font></h2><b><big>click &nbsp;<a href=\"/servlet/SearchServlet?");
            toClient.println(keyword+"\"><big> here </big> </a>&nbsp; for result</b></big><br>");
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
   public void printreport(String mes,Exception ee )
   {  try
      {  FileWriter fw = new FileWriter("realsearch.err",true);
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
   {  return "Real Time Search Engine Servlet";
   }
//-------------------------------------------------------
   public void destroy()
   {  
   }
}
//=============== END CLASS REALSEARCH ===================

class RealDatabase
{  Statement stmt;
   Connection con;
//-----------------------------------------------
   public RealDatabase()
   {  try
      {  Class.forName("oracle.jdbc.driver.OracleDriver"); 
         String url = "jdbc:oracle:thin:@PURE:1521:orcl";
         String user = "purekik";
         String password = "purekik";
         con = DriverManager.getConnection(url, user, password);
         stmt = con.createStatement();

      } catch(SQLException sqlex)
      {  System.out.println("error: "+sqlex);
      }
        catch(java.lang.Exception ex)
      {  System.out.println("exception error: "+ex);
      }
   }
//---------------------------------------------
   public void getClose() throws SQLException
   {  stmt.close();
      con.close();
      System.out.println("Close database complete");
   }
//---------------------------------------------
   public ResultSet getInSearchKey(String key) throws SQLException
   {  String command = "SELECT * FROM SEARCHED_KEY WHERE KEYWORDS = '"+key+"'";
      return stmt.executeQuery(command);
   }
//---------------------------------------------
   public ResultSet getInRealSearch(String key) throws SQLException
   {  String command = "SELECT * FROM REALSEARCH WHERE KEYWORDS = '"+key+"'";
      return stmt.executeQuery(command);
   }
//---------------------------------------------
   public ResultSet getUpdateList(int up) throws SQLException
   {  String command = "SELECT DISTINCT * "+
                       "FROM DATA "+
                       "WHERE URLNUMBER > "+ up;
      ResultSet linkset = stmt.executeQuery(command);
      return linkset;
   }
//-------------------------------------------------------------
   public int getMaxOrder() throws SQLException
   {  String command = "SELECT STATEVALUE "+
                       "FROM STATE "+
                       "WHERE STATETYPE='PAGEORDER'";
      ResultSet stateset = stmt.executeQuery(command);
      int pageorder = 0;
      if( stateset.next() )
      {  pageorder = stateset.getInt("STATEVALUE");
      }
      return pageorder;
   }
//-------------------------------------------------------------
   public void insertToKey(String key,int unum,int pri) throws SQLException
   {  
      String command = "INSERT INTO KEY VALUES ('"+
                        key+  "',"+
                        unum+  "," +pri+ ")";
      stmt.executeUpdate(command);
   }
//-------------------------------------------------------------
   public void insertToSearchedKey(String key,int type) throws SQLException
   {  
      String command = "INSERT INTO SEARCHED_KEY VALUES ('"+
                        key+  "',"+
                        type+  ")";
      stmt.executeUpdate(command);
   }
//-------------------------------------------------------------
   public void deleteFromRealSearch(String key) throws SQLException
   {  String command = "DELETE FROM REALSEARCH WHERE KEYWORDS='" +key+ "'";
      stmt.executeUpdate(command);
   }
//-------------------------------------------------------------
   public void insertToRealSearch(String key,int cur) throws SQLException
   {  
      String command = "INSERT INTO REALSEARCH VALUES ('"+
                        key+  "',"+
                        cur+  ")";
      stmt.executeUpdate(command);
   }
//-------------------------------------------------------------
   public void changeUpCurrent(String key,int cur) throws SQLException
   {  String command3 = "UPDATE REALSEARCH "+
                        "SET UPCURRENT = " + cur +
                        " WHERE KEYWORDS = '"+key+"'";
      stmt.executeUpdate(command3);
   }
}
//======================= END CLASS REALDATABASE ================

class MyOp
{  File htmlfile;
   String[] opentag = {"<comment>","<title>","<big>","<i>","<b>","<u>","<strong>","<em>","<h1>","<h2>","<h3>","<h4>","<h5>","<h6>"};
   String[] closetag = {"</comment>","</title>","</big>","</i>","</b>","</u>","</strong>","</em>","</h1>","</h2>","</h3>","</h4>","</h5>","</h6>"};
   int[] value = {0,30,7,7,7,7,7,7,20,17,14,11,9,8};
//---------------------------------------------------
   public MyOp(File file)
   {  htmlfile = file;
   }
//---------------------------------------------------
   public MyOp(String tofile)
   {  htmlfile = new File(tofile);
   }
//---------------------------------------------------
   private int getTagValue(int nowvalue,String tag)
   {  
      for(int k=0; k<opentag.length; k++)
      {  if(tag.equalsIgnoreCase(opentag[k]))
         {  return nowvalue+value[k];
         }
         if(tag.equalsIgnoreCase(closetag[k]))
         {  if(nowvalue>value[k])
            {  nowvalue= nowvalue-value[k];
            }
            return nowvalue;
         }
      }
      return nowvalue;
   }
//---------------------------------------------------
   public int getValue(String keyword)
   {  int keyvalue=0;
      int tagvalue=2;
      int i =0;

      char input=' ';
      
      String matchkey ="";
      String matchtag="";
      String matchmeta="";
      
      boolean ismeta=false;
      boolean istag = false;

      for(int j=0; j<keyword.length(); j++)
      {  matchkey = matchkey+" ";
      }

      try
      {  FileReader fr = new FileReader(htmlfile);
         BufferedReader br = new BufferedReader(fr);
         while(i!=-1)
         {  i = br.read();
            input = (char) i;
            matchkey = matchkey.substring(1)+input;

            if(input=='<') istag=true;

            if(matchkey.equals(keyword))
            {  keyvalue+=tagvalue;
            }

            if(istag)
            {  matchtag = matchtag+input;
               if(matchtag.equalsIgnoreCase("<meta"))       //  meta tag
               {  ismeta = true;                            //
                  tagvalue+=50;
               }
               if(ismeta) matchmeta=matchtag;
               if(input=='>')
               {  if(ismeta) 
                  {  ismeta=false;    //check about meta tag
                     tagvalue-=50;
                  }   
                  
                  istag = false;
                  tagvalue = getTagValue(tagvalue,matchtag);
                  matchtag="";           // CLEAR MATCHTAG
               }
            }                           // END IF(ISTAG)
         }                              // END WHILE (I!=-1)
         br.close();
      } catch(IOException ioe)
      {  System.out.println("error: "+ioe);
      }
      return keyvalue;
   }
//---------------------------------------------
}
//======================== END CLASS MyOp =========
class MyP
{  URL myurl;
   String urlname;
   File myfile = new File("real.tmp");
   boolean errorflag;
//----------------------------------------------------
   public MyP(String url)
   {  clearFile();
      errorflag = false;
      urlname= url;
      getToFile();
   }  
//-----------------------------------------------------
   public File getURLFile()
   {  return myfile;
   }
//----------------------------------------------
   public boolean isUsable()
   {  boolean doit=true;
      boolean page = false;
      boolean content = false;

      String temp = "";
      String lower ="";
      try
      {  FileReader fr = new FileReader(myfile);
         BufferedReader br = new BufferedReader(fr);
         while(doit)
         {  temp=br.readLine();
            if( temp==null )
            {  doit = false;
            }
            else
            {  lower = temp.toLowerCase().trim();
               if( lower.startsWith("<html>") )
               {  doit = false;
               }
               if( lower.startsWith("http/1.0 2") )
               {  page = true;
               }
               if( (lower.equals("content-type: text/html")) ||
                  (lower.equals("content-type: text/plain")) )
               {  content = true;
               }
            }
         }
         br.close();
      } catch(IOException ioe)
      {  System.out.println("error: "+ioe);
      }
      System.out.println("check page complete");
      return (page&&content);
   }
//----------------------------------------------
   public synchronized void getToFile()
   {  InputStreamReader in;
      BufferedReader  br;
      FileWriter fw;
      BufferedWriter bw;
      try
      {  Socket socket = new Socket("proxy.ce.kmitl.ac.th",3128);  
         socket.setSoTimeout(120000);
         OutputStream rawOut = socket.getOutputStream();
         InputStream rawIn = socket.getInputStream();
          
         DataOutputStream dos = new DataOutputStream(rawOut);
         dos.writeBytes("Get "+urlname+ " HTTP/1.0\r\n\r\n");
         in = new InputStreamReader(rawIn);
         br = new BufferedReader(in);
         fw = new FileWriter(myfile);
         bw = new BufferedWriter(fw);
         String temp="";
         while( (temp=br.readLine())!=null )
         {  bw.write(temp);
            bw.newLine();
            bw.flush();
         }
         bw.close();
      } catch(IOException ioe)
      {  System.out.println("getToFile error: "+ioe);
         errorflag=true;
         clearFile();
      }
   }
//----------------------------------------------
   public boolean getConnectionErrorFlag()
   {  return errorflag;
   }
//----------------------------------------------
   private void clearFile()
   {  try
      {  FileWriter fw1 = new FileWriter(myfile);
         BufferedWriter bw1 = new BufferedWriter(fw1);
         bw1.write("");
         bw1.flush();
         bw1.close();
      } catch(IOException ioe)
      {  System.out.println("clear file error: "+ioe);
      }
   }
}
//================= end class MyP ============

