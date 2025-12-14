package SEARCH;

import java.io.*;
import java.util.*;
import java.net.*;
import java.sql.*;

public class MyProject
{  
   private int pagenumber;              // number of page have get
   private int linknumber;
   private int updatenumber;
   private int operatetype;

   private int turn_number;
   
   File linklist = new File("linklist.lst");
   File key = new File("key.ins");
   File data = new File("data.ins");
   
//---------------------------------------------------
   public MyProject(int round)
   {  turn_number = round;
      deleteFileContent();
      getState();
      operatetype = getType();
      System.out.println("TYPE OF OPERATION IS "+operatetype);
   }
//---------------------------------------------------
   public void getStart()
   {  switch(operatetype)
      {  case 1:
         {  continueUpdate();
            break;
         }
         case 2:
         {  moveKey();
            continueUpdate();
            break;
         }
         case 3:
         {  continueSearch();
            break;
         }
      }
   }

//---------------------------------------------------
   private void getState()             //  for get status of search
   {  try
      {  MyDatabase mystate = new MyDatabase();
         pagenumber = mystate.getPageOrder();
         System.out.println("pagenumber: "+pagenumber);
         linknumber = mystate.getLinkOrder();
         System.out.println("linknumber: "+linknumber);
         updatenumber = mystate.getUpdateNumber();
         System.out.println("updatenumber: "+updatenumber);
         mystate.getClose();
      } catch(SQLException ioe)
      {  System.out.println("get state error: "+ioe);
      }
      System.out.println("get state complete");
   }
//----------------------------------------------------
   private void saveState()              // for set status of search
   {  try
      {  MyDatabase save = new MyDatabase();
         save.keepState(pagenumber,linknumber);
         save.getClose();
      } catch(SQLException sse)
      {  System.out.println("save state error: "+sse);
      }
      System.out.println("save state complete");
  }
//----------------------------------------------------
   private void moveKey()
   {  try
      {  MyDatabase mymove = new MyDatabase();
         ResultSet move = mymove.getUnSearchKey();
         while( move.next() )
         {  String un_key = move.getString("KEYWORDS");
            un_key = un_key.trim();
            try
            {  MyDatabase settodel = new MyDatabase();
               settodel.setKeyToDelete(un_key);
               settodel.insertToSearchedKey(un_key,1);
               settodel.getClose();
            } catch(SQLException sx)
            {  System.out.println("error while move key");
            }
         }
         mymove.deleteUnSearchKey();
         mymove.getClose();
         System.out.println();
         System.out.print("              ");
         System.out.println("MOVE KEY COMPLETE");
         
      }  catch(SQLException s)
      {  System.out.println("error when move key and is: "+s);
      }
   }
            
//----------------------------------------------------
   private void saveData()
   {  try
      {  System.out.println("Start to save data to database");
         MyDatabase mydatabase4 = new MyDatabase();
         mydatabase4.insertToKeyTable(key);
         mydatabase4.insertToDataTable(data);
         mydatabase4.getClose();
      } catch(SQLException eee)
      {  System.out.println("error while keep key and data: "+eee);
      }
      try
      {  MyDatabase mydatabase5 = new MyDatabase();
         linknumber = mydatabase5.insertToLinkTable(linklist,linknumber);
         mydatabase5.getClose();
         
      }  catch(SQLException ss)
      {  System.out.println("error while insert to database: "+ss);
      }
      try
      {  MyDatabase mydatabase6 = new MyDatabase();
         mydatabase6.deleteFromLinkTable();
         mydatabase6.getClose();
         System.out.println("save data complete");
      }  catch(SQLException sos)
      {  System.out.println("error while delete from link table: "+sos);
      }
      deleteFileContent();
      saveState();
   }
//---------------------------------------------------
   private void saveUpdateData()
   {  try
      {  System.out.println("Start to save update data to database");
         MyDatabase mydatabase7 = new MyDatabase();
         mydatabase7.insertToKeyTable(key);
         mydatabase7.changeUpdateNumber(updatenumber);
         mydatabase7.getClose();
      } catch(SQLException eee)
      {  System.out.println("error while keep key and data: "+eee);
      }
      deleteFileContent();
      
   }
//---------------------------------------------------
   private int getType()
   {  int o_type = 3;
      if( updatenumber!=0 )
      {  o_type = 1;
      }
      else
      {  int countkey=0;
         try
         {  MyDatabase keytype = new MyDatabase();
            countkey = keytype.countUnSearchKey();
            keytype.getClose();
            if( countkey>30 )
            {  o_type = 2;
            }
            else 
            {  o_type = 3;
            }
         } catch(SQLException sq)
         {  System.out.println("get Type error: "+sq);
         }
      }
      return o_type;
   }
//---------------------------------------------------
   private void deleteFileContent()
   {  System.out.println("Try to delete file after insert to database");
      try
      {  FileWriter fw1 = new FileWriter(linklist);
         BufferedWriter bw1 = new BufferedWriter(fw1);

         FileWriter fw2 = new FileWriter(key);
         BufferedWriter bw2 = new BufferedWriter(fw2);

         FileWriter fw3 = new FileWriter(data);
         BufferedWriter bw3 = new BufferedWriter(fw3);

         bw1.write("");
         bw1.flush();
         bw1.close();

         bw2.write("");
         bw2.flush();
         bw2.close();

         bw3.write("");
         bw3.flush();
         bw3.close();
      }  catch(IOException ioex)
      {  System.out.println("delete file content error: "+ioex);
      }
      System.out.println("delete file complete");
   }
//---------------------------------------------------
   private void continueSearch()
   {  System.out.println("             START TO OPERATE CONTINUE SEARCH...");
      int counter = 1;
      int counterror = 0;

      OPER:
      while( counter<=turn_number )
      {  String pagename="";
         try
         {  MyDatabase mydatabase1 = new MyDatabase();
            ResultSet pagelist = mydatabase1.selectLink();
            System.out.println("get page list complete");
      
            if( pagelist.next() )
            {  pagename = pagelist.getString("urlname").trim();
               System.out.println("get page name: "+pagename);
               System.out.println("counter: "+counter);
               System.out.println("Page number: "+pagenumber);
               
               MyPageFile mypage = new MyPageFile(pagename);
               mypage.getToFile();
            
               if( mypage.isUsable() )
               {                    
                  MyLink mylink = new MyLink(pagename,mypage.getURLFile());
                  mylink.getLink();
                  
                  MyOperate myoperate = new MyOperate(mypage.getURLFile());
                  System.out.println("Start to get key");
                  int ii = 1;
                  try
                  {  FileWriter fw1 = new FileWriter("key.ins",true);
                     BufferedWriter bw1 = new BufferedWriter(fw1);
          
                     FileWriter fw2 = new FileWriter("data.ins",true);
                     BufferedWriter bw2 = new BufferedWriter(fw2);
                     try
                     {  String keyword ="";
                        MyDatabase mydatabase2 = new MyDatabase();
                        ResultSet keylist = mydatabase2.getOperateKey();
                        while( keylist.next() )
                        {  keyword=keylist.getString("KEYWORDS");
                           keyword = keyword.trim();
                           System.out.println("get key: "+ii);
                           int priority = myoperate.getValue(keyword);
                           if( priority>0 )
                           {  bw1.write(keyword+ "|" +pagenumber+ "|" +priority);
                              bw1.newLine();
                              bw1.flush();
                           }   
                           System.out.println("page number "+pagenumber+
                           ". get key complete while counter = "+counter);
                           ii++;
                        }             // END WHILE HAVE KEYWORD

                        mydatabase2.getClose();
                     }  catch(SQLException ex)
                     {  System.out.println("keyword error: "+ex);
                     }
                     bw1.close();

                     bw2.write("" +pagenumber+ "|" +pagename+ "|" +myoperate.getSize()+
                        "|" +myoperate.getDescription()+ "|" +myoperate.getTitle() );
                     bw2.newLine();
                     bw2.flush();
                     bw2.close();
                   
                     System.out.println("operate page: "+ pagename+ " . COMPLETE");
                     System.out.println();
                     
                     pagenumber++;
                     

                  }  catch(IOException ioe1)
                  {  System.out.println("error while save data: "+ioe1);
                  }
               }              // end if mypage is usable
               else
               {  System.out.print("                     ");
                  System.out.println("THIS PAGE IS NOT USABLE");
                  if( mypage.getConnectionErrorFlag() )
                  {  System.out.println("    because of CE PROXY !!!!!!");
                     try
                     {  FileWriter fw3 = new FileWriter("linklist.lst",true);
                        BufferedWriter bw3 = new BufferedWriter(fw3);
                        bw3.write(pagename);
                        bw3.newLine();
                        bw3.flush();
                        bw3.close();
                     }  catch(IOException io)
                     {  System.out.println("error while write connection failed link");
                     }
                     counterror++;
                  }
               }
               try
               {  MyDatabase mydatabase3 = new MyDatabase();
                  mydatabase3.setLinkToDelete(pagename);
                  mydatabase3.getClose();
               } catch(SQLException sqlexcept)
               {  System.out.println("set to delete error: "+sqlexcept);
               }
            }                 // end if pagelist.next();
            else 
            {  System.out.println("Don't have page list in database");
            }
            mydatabase1.getClose();

         } catch(SQLException s_exception)
         {  System.out.println("list error : "+s_exception);
         }
         if( (counter!=0)&&((counter%5)==0) ) 
         {  saveData();
         }
         counter++;
         if( counterror==10 )
         {  break OPER;
         }
      }                 // END WHILE COUNTER <= TURN_NUMBER
      if( counterror==10 )
      {  System.out.println("TERMINATE BECAUSE NETWORK PROBLEM");
      }
      else
      {  System.out.println("OPERATION COMPLETE");
      }
      saveData();
      getState();
   }
//---------------------------------------------------
   private void continueUpdate()
   {  System.out.println("             START TO CONTINUE UPDATE...");
      int counter = 1;
      int counterror=0;
      try
      {  MyDatabase myupdate = new MyDatabase();
         ResultSet updatelist = myupdate.getUpdateList(updatenumber);
         ENDING:
         while( updatelist.next() )
         {  int order = updatelist.getInt("URLNUMBER");
            String pagename = updatelist.getString("urlname").trim();
            System.out.println("get page name: "+pagename);
            System.out.println("counter: "+counter);
            System.out.println("Page number: "+order);
               
            MyPageFile mypage = new MyPageFile(pagename);
            mypage.getToFile();
            
            if( mypage.isUsable() )
            {  File pagefile = mypage.getURLFile();
               MyOperate myoperate = new MyOperate(pagefile);
               System.out.println("Start to get key for update");
               int up_count = 1;
               try
               {  FileWriter fw1 = new FileWriter("key.ins",true);
                  BufferedWriter bw1 = new BufferedWriter(fw1);
                  try
                  {  String keyword ="";
                     MyDatabase mydatabase2 = new MyDatabase();
                     ResultSet updatekeylist = mydatabase2.getUpdateKey();
                     while( updatekeylist.next() )
                     {  keyword= updatekeylist.getString("KEYWORDS");
                        keyword = keyword.trim();
                        System.out.println("get key: "+up_count);
                        int priority = myoperate.getValue(keyword);
                        if( priority>0 )
                        {  bw1.write(keyword+ "|" +order+ "|" +priority);
                           bw1.newLine();
                           bw1.flush();
                        }   
                        System.out.println("page number "+order+
                           ". get key complete while counter = "+counter);
                        up_count++;
                     }             // END WHILE HAVE KEYWORD

                     mydatabase2.getClose();
                  }  catch(SQLException ex)
                  {  System.out.println("keyword while update error: "+ex);
                  }
                  bw1.close();
                  System.out.println("operate page: "+ order+ " . COMPLETE");
                  System.out.println();
                  updatenumber = order ;
                  if( counter == turn_number ) 
                  {  break ENDING;
                  }
                  
               }  catch(IOException ioe1)
               {  System.out.println("error while save data: "+ioe1);
               }
            }              // end if mypage is usable
            else
            {  System.out.print("                     ");
               System.out.println("THIS PAGE IS NOT USABLE");
               if( mypage.getConnectionErrorFlag() )
               {  System.out.println("    NETWORK PROBLEM");
                  counterror++;
               }
            }
            if( counterror==5 )
            {  break ENDING;
            }
            counter++;
         }                 // end while updatelist.next();
         myupdate.getClose();

      } catch(SQLException s_exception)
      {  System.out.println("list error : "+s_exception);
      }
      saveUpdateData();
      if ( (updatenumber+1) == pagenumber )
      {  setUpdateComplete();
      }
      if( counterror==5 )
      {  System.out.println("UPDATE TERMINATE BECAUSE OF NETWORK PROBLEM");
      }
      else
      {  System.out.println("OPERATION UPDATE COMPLETE");
      }
      getState();
   }
//---------------------------------------------------
   private void setUpdateComplete()
   {  try
      {  MyDatabase updatecomplete = new MyDatabase();
         updatecomplete.changeUpdateNumber(0);
         updatecomplete.changeToCommonKey();
         updatecomplete.getClose();
      } catch(SQLException sw)
      {  System.out.println("error while set update from completeness: "+sw);
      }
   }
//---------------------------------------------------   
   public static void main(String[] args)
   {  int each = 0;
      try
      {  InputStreamReader isr = new InputStreamReader(System.in);
         BufferedReader br = new BufferedReader(isr);
         GETTURN:
         while(true)
         {  System.out.print("Enter number of operation: ");
            String temp = br.readLine().trim();
            try
            {  each = Integer.parseInt(temp);
               break GETTURN;
            } catch(Exception ee)
            {  System.out.println("error while get turn: "+ee);
            }
            System.out.println();
            
         }
         br.close();
      }  catch(Exception e)
      {  System.out.println("error while get turn2: "+e);
      }
      MyProject myproject = new MyProject(each);
      myproject.getStart();
   }
}
//=================== end class project ==============
