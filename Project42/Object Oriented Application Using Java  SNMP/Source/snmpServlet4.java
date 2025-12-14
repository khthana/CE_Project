
import java.net.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.math.*;
import sck.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class snmpServlet4 extends HttpServlet{

  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {


  res.setContentType("text/html");
  
  
  PrintWriter out = res.getWriter();

	out.println("<head>");
	out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=TIS-620\">");
	out.println("<title>Direct Query</title>");
	
	out.println("</head>");

	out.println("<BODY BGCOLOR=\"#FFFFFF\" text=\"#000000\" LINK=\"#ff0000\" VLINK=\"#faafbe\" >"); 

  
  String host = req.getParameter("host");
  String  oid = req.getParameter("oid");
  

  out.println("<center><br><br><font color=blue><h2> This is data from :" +host + "</h2></font></center><P>");

  int snmpPort = 161;
  int snmpTimeout  = 20000; 
  String community = new String("public");
//  sck.Message request; 

 
  try { 
    InetAddress snmpHost = InetAddress.getByName(host);
    DatagramSocket sock = new DatagramSocket();
    sock.setSoTimeout(snmpTimeout);

    // create pdu.
    Var var = new Var(oid);
    OctetString c = new OctetString(community);
    sck.Integer requestId = new sck.Integer(0);
    sck.Integer errorIndex = new sck.Integer(0);
    sck.Integer errorStatus = new sck.Integer(0);
    PduCmd pdu = new PduCmd(Pdu.GET,requestId,errorStatus,errorIndex,new VarList(var));
    sck.Message m = new sck.Message(c,pdu);

    // send
    byte[] b = m.codeBer();
    DatagramPacket packet = new DatagramPacket(b,b.length,snmpHost,snmpPort);
    byte[] b2 = new byte[2048];  //1024
    DatagramPacket p2 = new DatagramPacket(b2,b2.length);

    long startTime = System.currentTimeMillis();
    sock.send(packet);
    sock.receive(p2); // block or ... timeout.
    long time = (System.currentTimeMillis() - startTime);
        
    // display 
    ByteArrayInputStream ber = new ByteArrayInputStream(b2,1,p2.getLength()-1); // without tag !
    sck.Message m2 = new sck.Message(ber);


	out.println("<center><table width=70% cellspacing=0 cellpadding=5 border=1>");

	out.println("<tr>");
	out.println("<td align=center><font color=red>Host</font></td>");
	out.println("<td>"+host+"</td>");
	out.println("</tr>");	

	out.println("<tr>");
	out.println("<td align=center><font color=red>ObjectID</font></td>");
	out.println("<td>"+oid+"</td>");
	out.println("</tr>");	

	out.println("<tr>");
	out.println("<td align=center><font color=red>Value</font></td>");
	out.println("<td>"+cutString(m2.getPdu().getVarList().elementAt(0).toString())+"</td>");
	out.println("</tr>");	

	out.println("</table></center>");

   } 
   catch ( Exception ex) {
	  out.println("Errors in : <br>");
      out.println(ex);  
   }
	out.println("</body>");
    out.close();
  } 

  

	public String cutString(String forcut){
		String ready = "";
		StringTokenizer st = new StringTokenizer(forcut);
		String s1 = st.nextToken();
		String s2 = st.nextToken();
		while (st.hasMoreTokens())
			ready = ready + st.nextToken() + " ";
		return ready;
	}



}
