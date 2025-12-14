// Class doaddmail

import java.io.*;
import java.lang.*;
import java.sql.*;
import SenderMessage;
import oracle.jdbc.driver.*;

public class doaddmail  {

protected int counts = 0;

public static void main(String args[]) 
{
/*String s="kong";
s = "'"+s+"'";
String  a = countMail(s);
int b = Integer.parseInt(a) ;
b++;
a = ""+b;
System.out.println("Count : " +a);*/
//String a = selectIndex("kong");
//System.out.println("index :"+a);

//while (   int c = message.indexOf("http://") != -1 ) 
String message="http://www.kmitl.ac.th http://www.ce.kmitl.ac.th ";

int  c = message.indexOf("http://");
if (c != -1)
{
String heads="";
String center="";
String tail="";
String temp=message;
message = "";

while ( c != -1)
{
   try
   {
	heads = temp.substring(0,c);
	temp = temp.substring(c);
	c = temp.indexOf(" ");
	center = temp.substring(0,c);
	temp = temp.substring(c);
	message =  message+heads+"<a href="+center+">"+center+"</a>";
	c = temp.indexOf("http://");
	if (c==-1)   message = message+temp;	
	}
		catch(Exception e)  
		   { 
		   System.out.println("Error  "+e);
			}
 } // while
 } //if
 

System.out.println("newmessage is:"  + message);
}



public  static String  selectIndex(String name)
{
int temp[] = new int[30];
int  nubmail = 0,values=0;
try{
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver()); 
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	Statement stmt = conn.createStatement ();
	String sql = "SELECT indexs FROM datamail where account = '"+name+"'";
//   System.out.println(sql);
    ResultSet rset = stmt.executeQuery (sql);
	
		  while ( rset.next () )
		  {
		  String index = rset.getString(1);
          temp[nubmail++]  =  Integer.parseInt(index); 
		  }
    
//		 for (int j=0 ;   j<nubmail  ;  j++ )
//		     for (int i=j+1;  i<nubmail ;  i++ )
 //                if (temp[j] > temp[i])
  //               {
   //                  int   a = temp[i];
//					 temp[i]  = temp[j];
//					 temp[j]=a;
 //                }
 System.out.print("name is:"+name);
for (int i=0;i<nubmail ;i++ )
{
 System.out.print(temp[i]+"   ");
}
System.out.print("Show total number =  "+nubmail+" \n");

  } // try
    catch (SQLException e)    {  System.out.print(e);   }
	catch(Exception e)   {  System.out.print(e);    }

boolean  check=false;
int j=0;

		if ( temp[0] > 1)  
		   {
	   	    values = temp[0] - 1;
			System.out.print("(1)");
			check = true;
			}
 
else		
 {
 for(j=0  ; j<(nubmail-1); j++)
  {
   System.out.print("  j="+j);
       if (   ( temp[j+1] > temp[j] ) && (temp[j+1] != temp[j]+1)   )
         {
          values = temp[j+1]-1;
 			System.out.print("(2)");
			check = true;
		  break;
		  }
  } // for
} // else

		 if (!check)
		{
		System.out.print("  j="+j);
		values = temp[j]+1;
    	System.out.print("(3) ");
		}

/*String index = ""+values;
				try
           	{
				values = Integer.parseInt(index);	
				values++;
				}
				catch (Exception e)
				{ values = 0; }*/
				
String index = ""+values;
System.out.print("  index is: " +  index);
 return (index);
}  // end selectindex   


public static String  countMail(String name)
{
String count="";
try{
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver()); 
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	// conn.setTransactionIsolation(connect.TRANSACTION_READ_COMMITTED);
	// conn.setAutoCommit(false);
	// conn.commit();
	Statement stmt = conn.createStatement ();
	String sql = "SELECT count(*) FROM datamail where account = '"+name+"' group by account";
   System.out.println(sql);
    ResultSet rset = stmt.executeQuery (sql);
		  while ( rset.next () )
		  count = rset.getString(1);
  } // try
    catch (SQLException e)    {  System.out.println(e);   }
	try
	{
	int i = Integer.parseInt(count);	
	}
	catch (Exception e)
	{
       return("0");
	}
return(count);
}  // end countmail


	public static void addMail(String account,String index,String sender,String dates,String subject,String message,String status)
	throws SQLException {
	String  sql = "INSERT INTO datamail VALUES(?,?,?,?,?,?,?)";
try {
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1,account);
	  pstmt.setString(2,index);
	  pstmt.setString(3,sender);
	  pstmt.setString(4,dates);
	  pstmt.setString(5,subject);
	  pstmt.setString(6,message);
	  pstmt.setString(7,status);
	  pstmt.executeUpdate();
	  pstmt.close();
	    } catch (SQLException e) { System.err.println(e.getMessage()); }
    }  // end  addMail


public static String convertText(String message)
{
String text="";
for (int i=0;i<message.length() ; i++)
{
  int cthai = (int ) message.charAt(i);
   if ( cthai  >  255  )
   {
   cthai-=3424;
   }
  text = text +( (char) cthai );
}
return (text);
} // end convertText


public static void clearStatus(String account,String index) 	throws SQLException
{
	String sql = "update datamail  set  status = ?  where account= '"+account+"' and indexs = '"+index+"'";
   try
   {
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
   	PreparedStatement  pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,"0");
	pstmt.executeUpdate();
	pstmt.close();
   }
   catch (SQLException e)
   {
   System.err.println(e.getMessage());
   }  
   } // clear status




public static String countNewMail (String account)  	throws SQLException {
String count = "0";
try{
	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver()); 
    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@dbserver:1521:orcl","num","num");
	Statement stmt = conn.createStatement ();
  String sql = "Select count(*) from datamail where account='"+account+"' and status = '1' "; 

	ResultSet rset = stmt.executeQuery (sql);
	if ( rset.next () )
             count = rset.getString(1);
   }
   catch (SQLException e) {  System.out.print(e);   }    

return (count);
    }  // end  addMail


  }  // end class Echo.java
