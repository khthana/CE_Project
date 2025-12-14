package SEARCH;

import java.util.*;
import java.net.*;
import java.io.*;

public class MyOperate
{  File htmlfile;
   String[] opentag = {"<comment>","<title>","<big>","<i>","<b>","<u>","<strong>","<em>","<h1>","<h2>","<h3>","<h4>","<h5>","<h6>"};
   String[] closetag = {"</comment>","</title>","</big>","</i>","</b>","</u>","</strong>","</em>","</h1>","</h2>","</h3>","</h4>","</h5>","</h6>"};
   int[] value = {0,30,7,7,7,7,7,7,20,17,14,11,9,8};
//---------------------------------------------------
   public MyOperate(File file)
   {  htmlfile = file;
   }
//---------------------------------------------------
   public MyOperate(String tofile)
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
   public int getSize()
   {  return (int) htmlfile.length();
   } 
//---------------------------------------------------
   public String getTitle()
   {  char input=' ';
      int i = 0;

      String title = "";
      String tag = "";

      boolean doing = true;
      boolean istag = false;
      boolean istitle = false;

      try
      {  FileReader fr = new FileReader(htmlfile);
         BufferedReader br = new BufferedReader(fr);
   
         while( (doing)&&(i!=-1) )
         {  i = br.read();
            input = (char) i;
       
            if(input=='<')
            {  istag=true;
               tag = "";
            }
            if(istag)
            {  tag = tag+input;
            }
            if(istitle)
            {  title = title+input;
            }

            if(tag.equalsIgnoreCase("<title>"))
            {  istitle = true;
            }
            if(tag.equalsIgnoreCase("</title>"))
            {  istitle = false;
               doing = false;
            }
            if(tag.equalsIgnoreCase("</head>"))
            {  doing = false;
            }
   
            if(input =='>')
            {  istag = false;
            }

         }
         br.close();
      } catch(IOException ioe)
      {  System.out.println("error: "+ioe);
      }
      if (title.length()>=8)
      {  title = title.substring(0,title.length()-8);
      
         if( title.indexOf('\'') >=0 )
         {  title = getDoubleQuote(title);
         }
         if(title.length()>100) title = title.substring(0,99);
         while( title.endsWith("'") )
         {  title = title.substring(0,title.length()-1);
         }
         title = title.replace('|',',');
         title = title.replace('\r',' ');
         title = title.replace('\n',' ');
      }

      if(title.length()==0) title="NONE";
      title = title.trim();
      return title;

   }
//---------------------------------------------------
   public String getDescription()
   {  char input=' ';
      int i = 0;
      int count = 0;

      String description = "";
      String tag = "";

      boolean doing = true;
      boolean istag = false;
      boolean isdescription = false;
      boolean haveddes=true;
      boolean allow = true;

      try
      {  FileReader fr = new FileReader(htmlfile);
         BufferedReader br = new BufferedReader(fr);
   
         while( (doing)&&(i!=-1) )
         {  i = br.read();
            input = (char) i;
       
            if(input=='<')
            {  istag=true;
               tag = "";
            }
            if(istag)
            {  tag = tag+input;
            }
            if(isdescription)
            {  description = description+input;
            }

            if(tag.equalsIgnoreCase("<meta name=\"description\" content="))
            {  isdescription = true;
               haveddes = true;
            }
            if( (isdescription) && (input=='>') )
            {  isdescription = false;
               doing = false;
            }
            if( !(haveddes) )
            {  if( (tag.startsWith("<script")) || (tag.startsWith("<SCRIPT")) )
               {  allow = false;
               }
               if( tag.equalsIgnoreCase("</script>") )
               {  allow = true;
               }

               if( (!(istag)) )
               {  if( (allow)&&(input!='\r')&&(input!='\n')&&(input!='\t') )
                  {  description = description+input;
                     count++;
                  }
                  if( (description.endsWith("     ")) || (description.endsWith("&nbsp"))
                     || (description.endsWith("&NBSP")) )
                  {
                     {  description = description.substring(0,description.length()-5);
                        count = count -5;
                     }
                  }
                  if (count==200)
                  {  doing = false;
                  }
               }
            }
            if( (tag.equalsIgnoreCase("</head>"))&&(description.length()==0) )
            {  haveddes = false;
            }
   
            if(input =='>')
            {  istag = false;
            }

         }
         br.close();
      } catch(IOException ioe)
      {  System.out.println("error: "+ioe);
      }

      if (description.length()==0)
      {  description ="NONE";
      }
      else
      {  if( description.indexOf('\'') >=0 )
         {  description = getDoubleQuote(description);
         }
         if(description.length()>200) description = description.substring(0,199);
         while( (description.endsWith("'")) || (description.endsWith("\"")) ||
         (description.endsWith(">")) )
         {  description = description.substring(0,description.length()-1);
         }
         while ( description.startsWith("\"") )
         {  description = description.substring(1);
         }
         description = description.replace('|',',');
         description = description.replace('\r',' ');
         description = description.replace('\n',' ');
      }
      description = description.trim();
      return description;
   }
//---------------------------------------------------

   private String getDoubleQuote(String sttest)
   {  int from =0;
      int to = 0;
      String temp="";
      while((to=sttest.indexOf('\'',from))>=0)
      {  temp += sttest.substring(from,to) +"''";
         from = to+1;
      }
      temp+=sttest.substring(from);
      return temp;
   }
//---------------------------------------------------
}
//======================== END CLASS MyOperate =========
