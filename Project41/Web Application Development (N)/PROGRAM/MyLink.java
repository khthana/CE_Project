package SEARCH;

import java.io.*;
import java.util.*;
import java.net.*;

public class MyLink
{  File pagefile;
   String urlname;
   String urlbase;
   String urlhost;

//------------------------------------------------------
// constructor accept 2 parameters are URL and File for store temp content
   public MyLink(String uname,File myfile)
   {  pagefile = myfile;
      urlname =uname;
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
   public void getLink()
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

      System.out.println("H: "+urlhost+":");
      System.out.println("B: "+urlbase+":");

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
      System.out.println("get link complete");
   }                                    // end main
//---------------------------------------------------------
   private void writeFile(String llist)
   {  llist = llist.toLowerCase();
      String temp ="";
      boolean yes = true;
      try
      {  FileWriter fw = new FileWriter("linklist.lst",true);
         BufferedWriter bw = new BufferedWriter(fw);

         if( llist.startsWith("http://") )
         {  try
            {  URL myu = new URL(llist);
               String temphost = myu.getHost().toLowerCase();
               if( temphost.endsWith(".th") )
               {  temp = llist;
               }
               else yes = false;
            } catch(MalformedURLException mfe)
            {  System.out.println("this link is malformed: "+llist);
               yes=false;
            }
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
}
//========================= END CLASS MYLINK =======================
