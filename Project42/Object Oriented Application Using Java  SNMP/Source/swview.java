
import java.net.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.math.*;
import sck.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class swview extends HttpServlet{

  public String sys[]   = new String[8];//0..7
  public String inter[] = new String[19];//0..18
  public String ip="";

  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

  res.setContentType("text/html");  
  PrintWriter out = res.getWriter();


//  ip = req.getParameter("ip");
	ip = "161.246.6.10";

	out.println("<head>");
	out.println("<title>sss</title>");
	out.println("<META HTTP-EQUIV=PRAGMA CONTENT=NO-CACHE>");
	out.println("</head>");

	
try{	

	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
	Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");

	out.println("<u><font color=red>System Group</font></u><br><br>"); 
	Statement stmt2 = null;	
	stmt2 = conn.createStatement();
	ResultSet rs = stmt2.executeQuery("select * from device");

	while (rs.next())
	{
		if ( rs.getString("ip").equals(ip) ){

			sys[1] = rs.getString("description");
		    sys[2] = rs.getString("objectid");
		    sys[3] = rs.getString("uptime");
		    sys[4] = rs.getString("contact");
		    sys[5] = rs.getString("name");
		    sys[6] = rs.getString("location") ;
            sys[7] = rs.getString("services");
		}
	}

    out.println("<center>");
    out.println("<table width=75% cellspacing=0 cellpadding=5 border=1>");

	out.println("<tr>");
    out.println("<th>Variable</th>");
    out.println("<th>Value</th>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td><font color=blue>Description &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+sys[1]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td><font color=blue>ObjectID &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+sys[2]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td><font color=blue>Contact &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+sys[4]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td><font color=blue>Name &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+sys[5]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td><font color=blue>Location &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+sys[6]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td><font color=blue>Services &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+sys[7]+"</td>");
    out.println("</tr>");

    out.println("</table>");
    out.println("</center><br>");


	String timeup = cutString(queryHost(ip,"1.3.6.1.2.1.1.3.0"));
	
	out.println("<center>");
	out.println("<font color=blue>Total Times that Machine UPs : &nbsp&nbsp&nbsp</font>");
	out.println("<font color=red>"+timeup+"</font>");
	out.println("</center><br>");

//////////////////////////////////////

	out.println("<u><font color=red>Interface Group</font></u><br><br>"); 
	Statement stmt3 = null;	
	stmt3 = conn.createStatement();
	ResultSet rs3 = stmt3.executeQuery("select * from interface");

	while (rs3.next())
	{
		if ( rs3.getString("inter").equals(ip+"#1") ){
			inter[1] = rs3.getString("description");
		    inter[2] = rs3.getString("type");
		    inter[3] = rs3.getString("speed");
		}
		
		if ( rs3.getString("inter").equals(ip+"#2") ){
			inter[4] = rs3.getString("description");
		    inter[5] = rs3.getString("type");
		    inter[6] = rs3.getString("speed");
		}
		if ( rs3.getString("inter").equals(ip+"#3") ){
			inter[7] = rs3.getString("description");
		    inter[8] = rs3.getString("type");
		    inter[9] = rs3.getString("speed");
		}
		
		if ( rs3.getString("inter").equals(ip+"#4") ){
			inter[10] = rs3.getString("description");
		    inter[11] = rs3.getString("type");
		    inter[12] = rs3.getString("speed");
		}
		if ( rs3.getString("inter").equals(ip+"#5") ){
			inter[13] = rs3.getString("description");
		    inter[14] = rs3.getString("type");
		    inter[15] = rs3.getString("speed");
		}
		
		if ( rs3.getString("inter").equals(ip+"#6") ){
			inter[16] = rs3.getString("description");
		    inter[17] = rs3.getString("type");
		    inter[18] = rs3.getString("speed");
		}
	}

	for (int i=1; i<19; i++ ) if (inter[i].equals("6 ")) inter[i]="ethernet-csmacd";


    out.println("<center>");
    out.println("<table width=75% cellspacing=0 cellpadding=5 border=1>");

	out.println("<tr align=center>");
    out.println("<th>number</th>");
    out.println("<th>Description</th>");
    out.println("<th>Type</th>");
    out.println("<th>Speed</th>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td align=center><font color=blue>1 &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+inter[1]+"</td>");
    out.println("<td align=center>"+inter[2]+"</td>");
    out.println("<td align=center>"+inter[3]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td align=center><font color=blue>2 &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+inter[4]+"</td>");
    out.println("<td align=center>"+inter[5]+"</td>");
    out.println("<td align=center>"+inter[6]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td align=center><font color=blue>3 &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+inter[7]+"</td>");
    out.println("<td align=center>"+inter[8]+"</td>");
    out.println("<td align=center>"+inter[9]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td align=center><font color=blue>4 &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+inter[10]+"</td>");
    out.println("<td align=center>"+inter[11]+"</td>");
    out.println("<td align=center>"+inter[12]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td align=center><font color=blue>5 &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+inter[13]+"</td>");
    out.println("<td align=center>"+inter[14]+"</td>");
    out.println("<td align=center>"+inter[15]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td align=center><font color=blue>6 &nbsp&nbsp&nbsp</font></td>");
    out.println("<td>"+inter[16]+"</td>");
    out.println("<td align=center>"+inter[17]+"</td>");
    out.println("<td align=center>"+inter[18]+"</td>");
    out.println("</tr>");

    out.println("</table><br><br>");
//////////////////////////////////


	String temph = "5.";
	String sumh  = "";

	for (int i=1; i<19; i++){  //1..18  1..6    1,2,3  4,5,6
		sumh = "1.3.6.1.2.1.16.1.1.1." + temph + java.lang.Integer.toString((i-1)/3+1+100);
		inter[i] = cutString(queryHost(ip,sumh));

		if (temph.equals("5.")) temph="8."; else if(temph.equals("8.")) temph="13."; else temph="5.";
	}


	out.println("&nbsp&nbsp&nbsp&nbsp<font color=blue>Value Now!</font><br><br>"); 
    out.println("<table width=75% cellspacing=0 cellpadding=5 border=1>");

	out.println("<tr align=center>");
    out.println("<th>Description</th>");
    out.println("<th>Packets</th>");
    out.println("<th>CRCAlignErrors</th>");
    out.println("<th>Collisions</th>");
    out.println("</tr>");


    out.println("<tr>");
    out.println("<td align=center><font color=blue>Interface 101</font></td>");
    out.println("<td align=center>"+inter[1]+"</td>");
    out.println("<td align=center>"+inter[2]+"</td>");
    out.println("<td align=center>"+inter[3]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td align=center><font color=blue>Interface 102</font></td>");
    out.println("<td align=center>"+inter[4]+"</td>");
    out.println("<td align=center>"+inter[5]+"</td>");
    out.println("<td align=center>"+inter[6]+"</td>");
    out.println("</tr>");
	
    out.println("<tr>");
    out.println("<td align=center><font color=blue>Interface 103</font></td>");
    out.println("<td align=center>"+inter[7]+"</td>");
    out.println("<td align=center>"+inter[8]+"</td>");
    out.println("<td align=center>"+inter[9]+"</td>");
    out.println("</tr>");
	
    out.println("<tr>");
    out.println("<td align=center><font color=blue>Interface 104</font></td>");
    out.println("<td align=center>"+inter[10]+"</td>");
    out.println("<td align=center>"+inter[11]+"</td>");
    out.println("<td align=center>"+inter[12]+"</td>");
    out.println("</tr>");

    out.println("<tr>");
    out.println("<td align=center><font color=blue>Interface 105</font></td>");
    out.println("<td align=center>"+inter[13]+"</td>");
    out.println("<td align=center>"+inter[14]+"</td>");
    out.println("<td align=center>"+inter[15]+"</td>");
    out.println("</tr>");
	
    out.println("<tr>");
    out.println("<td align=center><font color=blue>Interface 106</font></td>");
    out.println("<td align=center>"+inter[16]+"</td>");
    out.println("<td align=center>"+inter[17]+"</td>");
    out.println("<td align=center>"+inter[18]+"</td>");
    out.println("</tr>");

	out.println("</table><br><br>");

	out.println("</center>");

    } 
	catch ( Exception ex) { 
      out.println("Error in : ");
      out.println(ex);
    }
	
	out.close();
  } 
  

  public static String queryHost(String host, String oid) {
	String temp = "#";
	try { 
 
		InetAddress snmpHost = InetAddress.getByName(host);
		DatagramSocket sock = new DatagramSocket();
		sock.setSoTimeout(3000);

	    // create pdu.
		Var var = new Var(oid);
		OctetString c = new OctetString("public");
		sck.Integer requestId = new sck.Integer(0);
		sck.Integer errorIndex = new sck.Integer(0);
		sck.Integer errorStatus = new sck.Integer(0);
		PduCmd pdu = new PduCmd(Pdu.GET,requestId,errorStatus,errorIndex,new VarList(var));
		sck.Message m = new sck.Message(c,pdu);

		// send
		byte[] b = m.codeBer();
		DatagramPacket packet = new DatagramPacket(b,b.length,snmpHost,161);
		byte[] b2 = new byte[1024];
		DatagramPacket p2 = new DatagramPacket(b2,b2.length);

	    sock.send(packet);
		sock.receive(p2); 
        
	    // display 
	    ByteArrayInputStream ber = new ByteArrayInputStream(b2,1,p2.getLength()-1); // without tag !
		sck.Message m2 = new sck.Message(ber);
  
		temp = m2.getPdu().getVarList().elementAt(0).toString();	
	} 
	catch ( Exception ex) { 	}
	return temp;	
  }


	public static String cutString(String forcut){
		String ready = "";
		StringTokenizer st = new StringTokenizer(forcut);
		String s1 = st.nextToken();
		String s2 = st.nextToken();
		while (st.hasMoreTokens())
			ready = ready + st.nextToken() + " ";
		return ready;
	}


}
