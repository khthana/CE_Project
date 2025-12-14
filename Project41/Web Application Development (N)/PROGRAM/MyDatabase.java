package SEARCH;

import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;

public class MyDatabase
{  Statement stmt;
   Connection con;
//-----------------------------------------------
   public MyDatabase()
   {  try
      {  Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); 
         String url = "jdbc:odbc:search";
         String user = "purekik";
         String password = "purekik";
         con = DriverManager.getConnection(url, 
            user, password);
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
   public void insertToKeyTable(File f1) throws SQLException

   {  String command = "INSERT INTO KEY VALUES (";
      System.out.println("Start to insert to key");
      try
      {  FileReader fr = new FileReader(f1);
         BufferedReader br = new BufferedReader(fr);
         String temp="";
         boolean have = true;
         while(have)
         {  temp=br.readLine();
            while( temp!=null&&temp.equals("") ) 
            {  temp=br.readLine();
            }
            if (temp==null) have=false;
            else
            {  StringTokenizer st = new StringTokenizer(temp,"|");
               String keyword="";
               String urlnumber="";
               String priority="";
               int count=1;
               while(st.hasMoreTokens())
               {  if(count<4)
                  {  switch(count)
                     {  case 1:
                        {  keyword=st.nextToken().trim();
                           count++;
                           break;
                        }
                        case 2:
                        {  urlnumber=st.nextToken().trim();
                           count++;
                           break;
                        }
                        case 3:
                        {  priority=st.nextToken().trim();
                           count++;
                           break;
                        }
                     }                             // end switch
                  }                                // end if count
               }                                   // end while hasmore

               int unum = Integer.parseInt(urlnumber);
               int priori = Integer.parseInt(priority);

               String command1 = command+ "'"
                                 +keyword+ "'," 
                                 +unum+ ","  +priori+ ")";
               stmt.executeUpdate(command1);
            }                                      // else
         }                                         // end while temp
         br.close();
         System.out.println("INSERT TO KEY TABLE SUCCESSFUL");
      } catch(IOException ioe)
      {  System.out.println("io error: "+ioe);
      }
   }
//-----------------------------------------------------------
   public void insertToDataTable(File f1) throws SQLException

   {  String command = "INSERT INTO DATA VALUES (";
      System.out.println("Start to insert to data");
      try
      {  FileReader fr = new FileReader(f1);
         BufferedReader br = new BufferedReader(fr);
         String temp="";
         boolean have = true;
         while(have)
         {  temp=br.readLine();
            while( temp!=null&&temp.equals("") ) 
            {  temp=br.readLine();
            }
            if (temp==null) have=false;
            else
            {  StringTokenizer st = new StringTokenizer(temp,"|");
               String urlnumber="";
               String urlname="";
               String pagesize="";
               String description="";
               String title="";

               int count=1;
               while(st.hasMoreTokens())
               {  if(count<6)
                  {  switch(count)
                     {  case 1:
                        {  urlnumber=st.nextToken().trim();
                           count++;
                           break;
                        }
                        case 2:
                        {  urlname=st.nextToken().trim();
                           count++;
                           break;
                        }
                        case 3:
                        {  pagesize=st.nextToken().trim();
                           count++;
                           break;
                        }
                        case 4:
                        {  description=st.nextToken().trim();
                           count++;
                           break;
                        }
                        case 5:
                        {  title= st.nextToken().trim();
                           count++;
                           break;
                        }
                     }                             // end switch
                  }                                // ent if count

               }                                   // end while hasmore

               int unum = Integer.parseInt(urlnumber);
               int size = Integer.parseInt(pagesize);

               String command2 = command+urlnumber+ ",'" +urlname
               + "'," +pagesize+ ",'" +description + "','" +title+ "')";
               stmt.executeUpdate(command2);

            }                                      // else
         }                                         // end while temp
         br.close();
         System.out.println("INSERT TO DATA TABLE SUCCESSFUL!!!");        
      } catch(IOException ioe)
      {  System.out.println("io error: "+ioe);
      }
   }
//-----------------------------------------------------------
   public int insertToLinkTable(File f1,int linkorder) throws SQLException

   {  String command = "INSERT INTO LINKLIST VALUES ('";
      System.out.println("Start to insert to link");
      int order = linkorder;
      try
      {  FileReader fr = new FileReader(f1);
         BufferedReader br = new BufferedReader(fr);
         String temp="";
         boolean have = true;
         while(have)
         {  temp=br.readLine();
            while( temp!=null&&temp.equals("") ) 
            {  temp=br.readLine();
            }
            if (temp==null) have=false;
            else
            {  temp = temp.trim();
               boolean redunt = true;
               redunt = checkRepeat(temp);
               if( (temp.indexOf("'")== -1)&&(!(redunt)) )
               {  String command3 = command+temp+ "'," +order+ ")";
                  stmt.executeUpdate(command3);
                  order++;
               }
            }
         }
         br.close();
         System.out.println("INSERT TO LINK SUCCESS");
      } catch(IOException ioe)
      {  System.out.println("insert to linklist error: "+ioe);
      }
      return order;
   }
//-----------------------------------------------------------
   private boolean checkRepeat(String test) throws SQLException
   {  String linktable = "SELECT * FROM LINKLIST WHERE URLNAME ='" +test+ "'";
      String datatable = "SELECT * FROM DATA WHERE URLNAME ='" +test+ "'";

      ResultSet rslink = stmt.executeQuery(linktable);
      ResultSet rsdata = stmt.executeQuery(datatable);

      boolean isrepeat = false;

      if( (rslink.next()) || (rsdata.next()) )
      {  isrepeat = true;
      }
      else isrepeat = false;

      return isrepeat;
   }
//-------------------------------------------------------------
   public ResultSet selectLink() throws SQLException
   {  String command = "SELECT DISTINCT * FROM LINKLIST "+
                       "WHERE LINKNUMBER > 0 "+
                       "ORDER BY LINKNUMBER ASC";
      ResultSet linkset = stmt.executeQuery(command);
      System.out.println("select link complete");
      return linkset;
   }
//-------------------------------------------------------------
   public ResultSet getOperateKey() throws SQLException
   {  String command = "SELECT DISTINCT KEYWORDS "+
                       "FROM SEARCHED_KEY "+
                       "WHERE KEYTYPE=0";
      ResultSet linkset = stmt.executeQuery(command);
      System.out.println("select operate key complete");
      return linkset;
   }
//-------------------------------------------------------------
   public ResultSet getUpdateKey() throws SQLException
   {  String command = "SELECT DISTINCT KEYWORDS "+
                       "FROM SEARCHED_KEY "+
                       "WHERE KEYTYPE=1";
      ResultSet keyset = stmt.executeQuery(command);
      System.out.println("select update key complete");
      return keyset;
   }
//-------------------------------------------------------------
   public ResultSet getUpdateList(int up) throws SQLException
   {  String command = "SELECT DISTINCT * "+
                       "FROM DATA "+
                       "WHERE URLNUMBER > "+ up;
      ResultSet linkset = stmt.executeQuery(command);
      System.out.println("select update page list complete");
      return linkset;
   }
//-------------------------------------------------------------
   public int getPageOrder() throws SQLException
   {  String command = "SELECT STATEVALUE "+
                       "FROM STATE "+
                       "WHERE STATETYPE='PAGEORDER'";
      ResultSet stateset = stmt.executeQuery(command);
      int pageorder = 0;
      if( stateset.next() )
      {  pageorder = stateset.getInt("STATEVALUE");
      }
      System.out.println("select page order complete");
      return pageorder;
   }
//-------------------------------------------------------------
   public int getLinkOrder() throws SQLException
   {  String command = "SELECT STATEVALUE "+
                       "FROM STATE "+
                       "WHERE STATETYPE='LINKORDER'";
      ResultSet stateset = stmt.executeQuery(command);
      int linkorder = 0;
      if( stateset.next() )
      {  linkorder = stateset.getInt("STATEVALUE");
      }
      System.out.println("select link order complete");
      return linkorder;
   }
//-------------------------------------------------------------
   public int getUpdateNumber() throws SQLException
   {  String command = "SELECT STATEVALUE "+
                       "FROM STATE "+
                       "WHERE STATETYPE='PAGEUPDATE'";
      ResultSet stateset = stmt.executeQuery(command);
      int update = 0;
      if( stateset.next() )
      {  update = stateset.getInt("STATEVALUE");
      }
      System.out.println("select update complete");
      return update;
   }
//-------------------------------------------------------------
   public void keepState(int page,int link) throws SQLException
   {  String command1 = "UPDATE STATE "+
                        "SET STATEVALUE = " + page +
                        "WHERE STATETYPE = 'PAGEORDER'";
      String command2 = "UPDATE STATE "+
                        "SET STATEVALUE = " + link +
                        "WHERE STATETYPE = 'LINKORDER'";
      stmt.executeUpdate(command1);
      stmt.executeUpdate(command2);
      System.out.println("insert state to database complete");
   }

//-------------------------------------------------------------
   public void changeUpdateNumber(int update) throws SQLException
   {  String command3 = "UPDATE STATE "+
                        "SET STATEVALUE = " + update +
                        "WHERE STATETYPE = 'PAGEUPDATE'";
      stmt.executeUpdate(command3);
      System.out.println("change update state to database complete");
   }
//-------------------------------------------------------------
   public void setLinkToDelete(String linkname) throws SQLException
   {  String command = "UPDATE LINKLIST "+
                        "SET LINKNUMBER = 0 "+
                        "WHERE URLNAME = '" +linkname+ "'";
      stmt.executeUpdate(command);
      System.out.println("set link to delete complete");
   }
//-------------------------------------------------------------
   public void setKeyToDelete(String keyname) throws SQLException
   {  String command = "UPDATE UNSEARCH_KEY "+
                        "SET KEYTYPE = 0 "+
                        "WHERE KEYWORDS = '" +keyname+ "'";
      stmt.executeUpdate(command);
      System.out.println("set key in unsearch to delete complete");
   }
//-------------------------------------------------------------
   public void changeToCommonKey() throws SQLException
   {  String command = "UPDATE SEARCHED_KEY "+
                        "SET KEYTYPE = 0 "+
                        "WHERE KEYTYPE = 1";
      stmt.executeUpdate(command);
      System.out.println("change key to common in searched key complete");
   }
//-------------------------------------------------------------
   public void deleteFromLinkTable() throws SQLException
   {  String command = "DELETE FROM LINKLIST WHERE LINKNUMBER=0";
      stmt.executeUpdate(command);
      System.out.println("delete searched link complete");
   }
//-------------------------------------------------------------
   public void deleteUnSearchKey() throws SQLException
   {  String command = "DELETE FROM UNSEARCH_KEY WHERE KEYTYPE=0";
      stmt.executeUpdate(command);
      System.out.println("delete unsearch key complete");
   }
//-------------------------------------------------------------
   public int countUnSearchKey() throws SQLException
   {  String command = "SELECT DISTINCT * FROM UNSEARCH_KEY";
      ResultSet rs = stmt.executeQuery(command);
      int count=0;
      while( rs.next() )
      {  count++;
      }
      System.out.println("count unsearch key complete");
      return count;
   }
//-------------------------------------------------------------
   public ResultSet getUnSearchKey() throws SQLException
   {  String command = "SELECT DISTINCT * FROM UNSEARCH_KEY";
      ResultSet rs = stmt.executeQuery(command);
      System.out.println("get unsearch key for move complete");
      return rs;
   }
//-------------------------------------------------------------



//================ FOR TEST AND INITIAL DATABASE ================
   public void insertToUnSearchKey(File f1) throws SQLException

   {  String command = "INSERT INTO UNSEARCH_KEY VALUES ('";
      System.out.println("Start to insert to unsearch_key table");
      try
      {  FileReader fr = new FileReader(f1);
         BufferedReader br = new BufferedReader(fr);
         String temp="";
         boolean have = true;
         while(have)
         {  temp=br.readLine();
            while( temp!=null&&temp.equals("") ) 
            {  temp=br.readLine();
            }
            if (temp==null) have=false;
            else
            {  temp = temp.trim();
               if( (temp.indexOf("'")== -1) )
               {  String command3 = command+temp+ "',1)";
                  stmt.executeUpdate(command3);
               }
            }
         }
         br.close();
         System.out.println("INSERT TO UNSEARCH_KEY SUCCESS");
      } catch(IOException ioe)
      {  System.out.println("insert to unsearch_key table error: "+ioe);
      }
   }


//-----------------------------------------------------------
   public void insertToSearchedKey(File f1) throws SQLException

   {  String command = "INSERT INTO SEARCHED_KEY VALUES ('";
      System.out.println("Start to insert to searched key table");
      try
      {  FileReader fr = new FileReader(f1);
         BufferedReader br = new BufferedReader(fr);
         String temp="";
         boolean have = true;
         while(have)
         {  temp=br.readLine();
            while( temp!=null&&temp.equals("") ) 
            {  temp=br.readLine();
            }
            if (temp==null) have=false;
            else
            {  temp = temp.trim();
               if( (temp.indexOf("'")== -1) )
               {  String command3 = command+temp+ "',0)";
                  stmt.executeUpdate(command3);
               }
            }
         }
         br.close();
         System.out.println("INSERT TO SEARCHED_KEY SUCCESS");
      } catch(IOException ioe)
      {  System.out.println("insert to searched key table error: "+ioe);
      }
   }
//-------------------------------------------------------------
   public void insertToSearchedKey(String key,int type) throws SQLException
   {  
      String command = "INSERT INTO SEARCHED_KEY VALUES ('"+
                        key+  "',"+
                        type+  ")";
      stmt.executeUpdate(command);
      System.out.println("Complete to insert to searched key table");
   }
//-------------------------------------------------------------
   public void initialLinkTable(File f1) throws SQLException

   {  String command = "INSERT INTO LINKLIST VALUES (";
      System.out.println("Start to initial link table");
      try
      {  FileReader fr = new FileReader(f1);
         BufferedReader br = new BufferedReader(fr);
         String temp="";
         boolean have = true;
         while(have)
         {  temp=br.readLine();
            while( temp!=null&&temp.equals("") ) 
            {  temp=br.readLine();
            }
            if (temp==null) have=false;
            else
            {  StringTokenizer st = new StringTokenizer(temp,"|");
               String linkname="";
               String linkordertemp="";
               int count=1;
               while(st.hasMoreTokens())
               {  if(count<3)
                  {  switch(count)
                     {  case 1:
                        {  linkname=st.nextToken().trim();
                           count++;
                           break;
                        }
                        case 2:
                        {  linkordertemp=st.nextToken().trim();
                           count++;
                           break;
                        }
                     }                             // end switch
                  }                                // ent if count
               }                                   // end while hasmore

               int linkorder = Integer.parseInt(linkordertemp);

               String command1 = command+ "'"
                                 +linkname+ "'," 
                                 +linkorder+ ")";
               stmt.executeUpdate(command1);
            }                                      // else
         }                                         // end while temp
         br.close();
         System.out.println("INITIAL LINK TABLE SUCCESSFUL");
      } catch(IOException ioe)
      {  System.out.println("io error: "+ioe);
      }
   }
//-----------------------------------------------------------

}
//======================= end class MyDatabase ================
