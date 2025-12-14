package SEARCH;

import java.io.*;
import java.net.*;
import java.util.*;

public class MyPageFile
{  URL myurl;
   String urlname;
   File myfile = new File("tempurl");
   boolean errorflag;
//----------------------------------------------------
   public MyPageFile(String url)
   {  errorflag = false;
      try
      {  urlname= url;
         myurl = new URL(urlname);
      } catch(MalformedURLException mal)
      {  System.out.println("myurlobj error: constructor: "+mal);
      }
   }  
//-----------------------------------------------------
   public String getHostName()
   {  return myurl.getHost();
   }
//----------------------------------------------
   public String getFileName()
   {  return myurl.getFile();
   }
//----------------------------------------------
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
   public void getToFile()
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
         System.out.println("page: "+ urlname);
         System.out.println("Retrive Successful!");
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
