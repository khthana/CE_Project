import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.*;
import java.net.*;
import java.sql.*;

public class SearchLink extends HttpServlet
        implements SingleThreadModel
{  
//-----------------------------------------------------
   public void init(ServletConfig config) throws ServletException
   {  super.init(config);
   }                   
//--------------------------------------------------------
   public void doGet(HttpServletRequest req,HttpServletResponse res)
       throws ServletException,IOException
   {  res.setContentType("text/html");
      boolean uerr = false;
      boolean cando = true;
      boolean malform = false;
      String urlname = req.getQueryString();
      urlname = urlname.toLowerCase();
      urlname = urlname.substring(urlname.indexOf('=')+1);
      if( urlname.length()== 0 )
      {  uerr=true;
         cando = false;
      }
      else
      {  int from =0;
         int to = 0;
         String temp="";
         while( (to=urlname.indexOf("%2f",from))>=0 )
         {  temp += urlname.substring(from,to) +"/";
            from = to+3;
         }
         temp+=urlname.substring(from);
         if( temp.endsWith("%2f") )
         {  temp = temp.substring(0,temp.length()-3)+"/";
         }
         from =0;
         to = 0;
         String temp2="";
         while( (to=temp.indexOf("%3a",from))>=0 )
         {  temp2 += temp.substring(from,to) +":";
            from = to+3;
         }
         temp2+=temp.substring(from);
         if( temp2.endsWith("%3a") )
         {  temp2 = temp2.substring(0,temp.length()-3)+":";
         }

         urlname=temp2;
      }
      if( !uerr )
      {  if( !(urlname.startsWith("http")) )
         {  urlname="http://"+urlname;
         }
      }
      try
      {  URL myu = new URL(urlname);
      }
      catch (MalformedURLException d)
      {  malform = true;
         cando = false;
         printreport("checkpoint 1",d);
      }
      try
      {  OutputStream os = res.getOutputStream(); 
         OutputStreamWriter osw = new OutputStreamWriter(os,"cp874");
         PrintWriter toClient = new PrintWriter(osw);
         
         toClient.println("<html>");
         toClient.println("<head>");
         toClient.println("<title>show link</title>");
         toClient.println("</head>");
         toClient.println("<body>");
         toClient.print("<body text=\"#000099\" bgcolor=\"#0FFFFFF\" ");
         toClient.println("alink=\"#FF00FF\" background=\"/snowbg.gif\" >");
         toClient.print("<br><h3><b><a href=\"/searchpage.html\"> ");
         toClient.print(" main page </a>&nbsp;||&nbsp;<a href=\"/testlink.html\"> ");
         toClient.print("show link again </a>&nbsp;||&nbsp;<a href=\"/realsearch.html\">");
         toClient.println("real time search</a></b></h3>");

         toClient.println("<h1><font color=\"red\">THIS SERVLET SHOW FIND LINK FROM PAGE</font></h1>");
         if( uerr )         
         {  toClient.print("<b><big><big>SORRY, YOU DON'T INSERT URL. PLEASE &nbsp;");
            toClient.println("<a href=\"/testlink.html\">  TRY AGAIN</a></b></big></big><br>");
         }
         if( (!(uerr))&&(malform) )
         {  toClient.print("<b><big>SORRY, YOUR URL IS MALFORMED. PLEASE &nbsp;");
            toClient.println("<a href=\"/testlink.html\">  TRY AGAIN</a></b></big><br>");
         }
         

         if ( cando )
         {  
            MyPageFile mypage = new MyPageFile(urlname);
            if( mypage.getConnectionErrorFlag() )
            {  toClient.println("<h1><font color=\"red\"> SORRY! CONNECTION ERROR</font></h1>");
            }
            else
            {  if( !(mypage.isUsable()) )
               {  toClient.print("<b><big><big><font color=\"red\">THIS PAGE IS NOT USABLE. PLEASE &nbsp;</font>");
                  toClient.println("<a href=\"/testlink.html\">  TRY AGAIN</a></b></big></big><br>");
               }
               else
               {  toClient.print("SEARCHING FROM &nbsp;&nbsp;<big><big><font color=\"red\">");
                  toClient.println(urlname+"</big></big></font><br>");
                  toClient.flush();
                  MyLink mylink = new MyLink(urlname,mypage.getURLFile());
                  FileReader fr = new FileReader(mylink.getLinkFile());
                  BufferedReader br = new BufferedReader(fr);
                  String mytemp ="";
                  while( (mytemp=br.readLine())!=null )
                  {  if( !(mytemp.equals("")) )
                     {  toClient.print("<LI><h3><a href=\"" +mytemp+ "\">");
                        toClient.print(mytemp+ "</h3></a>");
                        toClient.flush();
                     }
                  }
               }
               
            }
            toClient.println("<center><h2><font color=\"red\">END PAGE</h2></center></font>");
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
      {  FileWriter fw = new FileWriter("d:\\project\\SearchLink.err",true);
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
   {  return "This Servlet show how to find link from URL";
   }
//-------------------------------------------------------
   public void destroy()
   {  
   }
}
//====================== END CLASS SEARCHLINK ==========

class MyPageFile
{  URL myurl;
   String urlname;
   File myfile = new File("ttlink.tmp");
   boolean errorflag;
//----------------------------------------------------
   public MyPageFile(String url)
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
//================= end class MyPageFile ============

class MyLink
{  File pagefile;
   File lin = new File("ttlink.lst");
   String urlname;
   String urlbase;
   String urlhost;

//------------------------------------------------------
   public MyLink(String uname,File myfile)
   {  clearFile();
      pagefile = myfile;
      urlname =uname;
      getLink();
   }
//------------------------------------------------------
   public File getLinkFile()
   {  return lin;
   }
//------------------------------------------------------
   private String getDeciseBase(String oldbase)
   {  String newbase ="";
      if( oldbase.endsWith("/") )
      {  newbase = oldbase;
      }
      else
      {  int from = oldbase.lastIndexOf("/");
         int comma = oldbase.indexOf(".",from+1);
         if (from >10)
         {  if( comma!= -1 )
            {  newbase = oldbase.substring(0,from+1);
            }
            else
            {  newbase = oldbase+"/";
            }
         }
         else newbase = oldbase+"/";
      }
      return newbase;
   }
      
//------------------------------------------------------
   private void getLink()
   {  boolean islink = false;
      boolean have = true;

      int i=0;

      char input;

      String link="";
      String compare = "  ";
      String refer = "     ";

      urlbase = getBase();
      if( urlbase==null ) urlbase = urlname;

      urlbase = getDeciseBase(urlbase);

      int slash = urlbase.indexOf("/",10) ;
      if( slash!= -1 ) urlhost = urlbase.substring(0,slash);
      else urlhost = urlbase;

      try
      {  FileReader fr = new FileReader(pagefile);
         BufferedReader br = new BufferedReader(fr);
         readlink:
         while(have)
         {  i = br.read();
            if(i==32) i=br.read();
            if(i!=-1)
            {  input = (char) i;
               compare = compare.substring(1,2)+input;

               if(compare.equalsIgnoreCase("<a"))
               {  islink = true;
               }                           //end if(compare...

               while(islink)
               {  i = br.read();
                  if(i==32) i=br.read();
                  if(i==-1) break readlink;
                  input = (char) i;
                  refer = refer.substring(1,5)+input;
                  if(refer.equalsIgnoreCase("href="))
                  {  link="";
                     int countfun=0;
                     boolean end = true;
                     i=br.read();
                     if(i==-1) break readlink;   
                     while((i==32)||(i==34)||(i==13))
                     {  if(i==32) i=br.read();
                        if(i==13)
                        {  i=br.read();
                           i=br.read();
                        }
                        if(i==34)
                        {  countfun++;
                           i=br.read();
                           if(countfun==2) end=false;
                        }
                        if(i==-1) break readlink;
                     }
                     input = (char) i;
                     while(end)
                     {  link = link+input;
                        i = br.read();
                        if(i==-1) break readlink;
                        input = (char) i;
                        if( (i==32)||(i==34)||(input=='>') ) end=false;  
                     }                     // end while(input...
                     boolean check = link.equals("");
                     if(!check) 
                     {  writeFile(link);
                     }
                     islink=false;
                  }                        // end if(refer...
               }                           // end while(islink)         

            }                              //end if
            else
            {  have = false;
            }                              // end else if
         }                                 // end while(have)
         br.close();
      }                                    // end try
      catch(IOException ioe)
      {  System.out.println(ioe);
      }
   }                                    // end main
//---------------------------------------------------------
   private void writeFile(String llist)
   {  llist = llist.toLowerCase();
      String temp ="";
      boolean yes = true;
      try
      {  FileWriter fw = new FileWriter("ttlink.lst",true);
         BufferedWriter bw = new BufferedWriter(fw);

         if( llist.startsWith("http://") )
         {  
            temp=llist;
            if( yes )
            {  if( (llist.endsWith(".exe")) || (llist.endsWith(".gif")) ||
                    (llist.endsWith(".zip")) || (llist.endsWith(".jpg")) )
               {  yes = false;
               }
            }
         }
         else
         {  if(llist.indexOf(":")==-1 )
            {  if( llist.startsWith("/") )
               {  temp = urlhost+llist;
               }
               else
               {  if( llist.startsWith("../") )
                  {  int j = urlbase.lastIndexOf("/",urlbase.length()-2);
                     temp = urlbase.substring(0,j)+llist.substring(2);
                  }
                  else temp = urlbase+llist;
               }
            }
            else
            {  yes = false;
            }
         }
         if( (llist.indexOf(".asp?"))!=-1 )
         {  yes = false;
         }
         if( yes )
         {  if( temp.indexOf("#") != -1 )
            {  temp = temp.substring(0, temp.indexOf("#") );
            }
            temp = temp.trim();
            if( (!(temp.endsWith("/"))) )
            {  int k = temp.lastIndexOf("/");
               if( k<10 )
               {  temp = temp+"/";
               }
               else
               {  int from = temp.indexOf(".",k);
                  if( from == -1 )
                  {  temp = temp+"/";
                  }
               }
            }
            bw.write(temp);
            bw.newLine();
            bw.flush();
            bw.close();
         }
      }
      catch(IOException ioe)
      {  System.out.println(ioe);
      }
   }
//-----------------------------------------------------
   private String getBase()
   {  int i=0;

      char input = ' ';

      String tag ="";
      String base="";

      boolean doit= true;
      boolean nothavebase = true;
      boolean istag = false;
      boolean isbase = false;

      try
      {  FileReader fr = new FileReader(pagefile);
         BufferedReader br  = new BufferedReader(fr);

         while( (doit)&&(nothavebase) )
         {  i = br.read();
            input = (char) i;
            if( i== -1 )
            {  doit = false;
            }
            if( input=='<' )
            {  istag = true;
            }
            if( istag )
            {  tag = tag+input;
            }
            if( isbase )
            {  base = base +input;
            }
            if( tag.equalsIgnoreCase("<base") )
            {  isbase = true;
            }
            if( tag.equalsIgnoreCase("</head>") )
            {  doit = false;
            }
            if( input=='>' )
            {  istag = false;
               tag ="";
            }
            if( (isbase)&&(input=='>') )
            {  nothavebase = false;
            }
         }                      // END while
      } catch(IOException ioe)
      {  System.out.println("error: "+ioe);
      }

      if( base.length()>0 )
      {  base = base.trim();
         String temp = base.toLowerCase();
         int k= temp.indexOf("href=");
         if( k!=-1 )
         {   
               base = base.substring(k+5);
               base = base.trim();

               base = base.replace('\r',' ');
               base = base.replace('\n',' ');

               StringTokenizer st = new StringTokenizer(base);
               if( st.hasMoreTokens() )
               {  base = st.nextToken();
               }

               while( base.startsWith("\"") )
               {  base = base.substring(1);
                  base = base.trim();
               }
               while( (base.endsWith("\"")) || (base.endsWith(">")) )
               {  base = base.substring(0,base.length()-1);
                  base = base.trim();
               }
         }
         else  base = null;
         if( (base!=null) && (!(base.startsWith("http://"))) &&
            (!(base.startsWith("HTTP://"))) )
         {  base = null;
         }
      }
      else base = null;

      return base;
   }
//-----------------------------------------------------
   private void clearFile()
   {  
      try
      {  FileWriter fw = new FileWriter(lin);
         BufferedWriter bw = new BufferedWriter(fw);
         bw.write("");
         bw.flush();
         bw.close();
      }
      catch(IOException ioe)
      {  System.out.println(ioe);
      }

   }   
}
//========================= END CLASS MYLINK =======================

