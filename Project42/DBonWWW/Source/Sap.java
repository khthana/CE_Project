import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Sap extends HttpServlet
{ 
    public void service(HttpServletRequest req, HttpServletResponse res)
                               throws ServletException, IOException {
       
    res.setContentType("text/html");
    PrintWriter out = res.getWriter(); 
    String values[];
    String lastpage="";
    values=req.getParameterValues("lastpage");
    if(values!=null) 
      {
       lastpage=values[0];
      }
    if(lastpage.compareTo("yes")!=0)  
      {
       lastpage="no";
      }
    
   	out.println("<HTML><HEAD><TITLE>Choose Spare part</TITLE></HEAD>");
        out.println("<BODY bgcolor=\"#000102\">");  
         
        out.println("<center><img src=\"http://"+connect.hostname+"/image/bar1.gif\"></center>");      
        out.println("<br>");
        
        out.println("<CENTER><FORM NAME=spare METHOD=\"GET\" ACTION=\"http://"+connect.hostname+"/servlets/Form\"><FONT face=Arial size=2 color=\"#AA0000\">");
                
	out.println("<font color=\"#c1c1ff\" size=2><strong>1) โปรดเลือกประเภทอะไหล่</strong></font>");
	out.println("<INPUT name=master value=\"ประเภทอะไหล่!\"></FONT></FORM>");

        out.println("<p><img src=\"http://161.246.6.156/image/sap.jpg\" border=\"0\" width=\"493\" height=\"227\" alt=\"sap.jpg (27461 bytes)\" usemap=\"#sap\"></p>");
        out.println("<MAP name=\"sap\">");

        out.println("<area shape=\"polygon\" coords=\"199,81,194,85,203,107,214,116,217,113,215,101,207,87,199,79,197,80\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2/?master=พวงมาลัย&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='พวงมาลัย';spare.master.value='พวงมาลัย';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"101,104,117,105,117,133,114,135,113,154,117,153,117,170,100,169,101,151,109,150,107,135,97,135,97,103,100,105\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=กันสะเทือน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='กันสะเทือน';spare.master.value='กันสะเทือน';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"380,105,390,105,387,126,393,125,391,136,384,136,382,155,388,155,387,167,370,167,370,153,376,153,380,133,371,133,372,120,381,122,380,104\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=กันสะเทือน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='กันสะเทือน';spare.master.value='กันสะเทือน';return true\" >");

        out.println("<area shape=\"rect\" coords=\"404,116,427,138\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ถังน้ำมัน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='ถังน้ำมัน';spare.master.value='ถังน้ำมัน';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"424,46,433,54,440,71,441,80,439,91,421,100,407,104,446,100,462,88,465,79,456,53,446,44,423,44,427,47\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=สปอยเลอร์&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='สปอยเลอร์';spare.master.value='สปอยเลอร์';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"133,163,138,176,137,190,136,192,149,185,141,158,139,155,132,162,134,166\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ยางกันโคลน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
	out.println("onmouseover=\"window.status='ยางกันโคลน';spare.master.value='ยางกันโคลน';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"400,149,410,155,416,164,418,171,419,183,409,190,411,170,396,149,400,149\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ยางกันโคลน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='ยางกันโคลน';spare.master.value='ยางกันโคลน';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"95,74,136,75,131,108,79,104,98,72\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=เครื่อง&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='เครื่อง';spare.master.value='เครื่อง';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"160,113,148,107,148,75,155,59,170,50,156,69,153,78,154,102,160,113\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ก้านปัดน้ำฝน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='ก้านปัดน้ำฝน';spare.master.value='ก้านปัดน้ำฝน';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"13,134,21,142,32,145,40,140,42,134,48,135,49,141,74,141,76,133,84,154,77,163,75,176,76,188,67,189,24,170,19,152,17,149,12,133,20,139\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=กันชน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='กันชน';spare.master.value='กันชน';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"461,90,454,106,463,128,460,136,442,149,442,169,439,178,458,170,466,161,472,142,470,129,468,111,460,94,460,92,454,105\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=กันชน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='กันชน';spare.master.value='กันชน';return true\" >");

        out.println("<area shape=\"circle\" coords=\"31,135,14\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ไฟ&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='ไฟ';spare.master.value='ไฟ';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"442,146,441,126,458,116,463,130,462,137,443,148,442,139\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ไฟ&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='ไฟ';spare.master.value='ไฟ';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"114,153,118,153,131,163,135,157,133,112,129,106,116,106,112,156,119,153\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=แอร์&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='แอร์';spare.master.value='แอร์';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"134,127,155,121,157,118,152,130,150,143,154,157,158,176,162,185,149,185,132,155,135,125,145,125\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=บังโคลน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='บังโคลน';spare.master.value='บังโคลน';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"77,134,85,117,99,117,99,133,110,136,108,150,100,154,85,153,74,135\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=หม้อกรอง&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='หม้อกรอง';spare.master.value='หม้อกรอง';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"53,139,51,106,71,88,89,88,81,105,100,105,95,115,77,142,49,141,52,104\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=หม้อน้ำ&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='หม้อน้ำ';spare.master.value='หม้อน้ำ';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"14,136,16,117,32,99,28,119,14,137\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=หน้ากระจัง&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='หน้ากระจัง';spare.master.value='หน้ากระจัง';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"31,97,48,78,81,61,141,51,171,49,156,59,149,75,151,107,161,114,155,119,141,130,42,140,23,117,36,92\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=กระโปรง&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='กระโปรง';spare.master.value='กระโปรง';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"391,45,424,46,431,48,444,76,437,93,423,99,416,105,425,74,414,52,389,46,405,45\""); 
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=กระโปรง&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='กระโปรง';spare.master.value='กระโปรง';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"227,27,223,45,223,58,226,72,251,64,289,63,322,66,342,72,341,29,308,22,281,20,249,21,227,27,224,42\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=หลังคา.&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='หลังคา.';spare.master.value='หลังคา.';return true\" >");

        out.println("<area shape=\"circle\" coords=\"109,176,32\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ล้อ&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='ล้อ';spare.master.value='ล้อ';return true\" >");

        out.println("<area shape=\"circle\" coords=\"380,177,34\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ล้อ&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='ล้อ';spare.master.value='ล้อ';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"170,48,198,38,238,24,227,39,223,42,224,70,181,95,162,113,151,98,152,74,170,48,179,45\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=กระจกบังลม&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='กระจกบังลม';spare.master.value='กระจกบังลม';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"341,28,379,42,404,48,419,57,427,75,420,94,354,77,341,74,341,37,341,26,343,30\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=กระจกบังลม&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='กระจกบังลม';spare.master.value='กระจกบังลม';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"162,185,151,155,150,126,163,106,235,61,288,58,331,68,362,104,360,108,308,111,288,113,288,180,282,185,188,185,157,185,149,133,162,106\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ประตู&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='ประตู';spare.master.value='ประตู';return true\" >");

        out.println("<area shape=\"polygon\" coords=\"283,184,302,185,348,185,421,183,442,177,443,125,461,117,461,88,322,67,353,103,282,109,284,181,285,186\"");
        out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=บังโคลน&lastpage="+lastpage+"\"");
        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
        out.println("onmouseover=\"window.status='บังโคลน';spare.master.value='บังโคลน';return true\" >");

//        out.println("<area shape=\"default\"");
//	out.println("href=\"http://"+connect.hostname+"/servlets/page2?master=ทั้งหมด!&lastpage="+lastpage+"\"");
//        out.println("onmouseout=\"spare.master.value=spare.master.defaultValue;return true\"");
//        out.println("onmouseover=\"window.status='ทั้งหมด!';spare.master.value='ทั้งหมด!';return true\" >");

        out.println("</MAP></CENTER></BODY></HTML>");

        out.close();
        }
}
 
