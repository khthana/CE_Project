import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.lang.*;

public class sparequery extends HttpServlet
{ 
    public void service(HttpServletRequest req, HttpServletResponse res)
                               throws ServletException, IOException {
    String values[];
    
   String sp_namex="";
   values=req.getParameterValues("sp_namex");
   if(values!=null) 
     {
      sp_namex=values[0];
      sp_namex=sp_namex.replace('.',' ');
      sp_namex=sp_namex.trim();
     }    
    
    String lastpage="";
    values=req.getParameterValues("lastpage");
    if(values!=null) 
      {
       lastpage=values[0];
      }    
    
    
    String menufacture = "";
    values = req.getParameterValues("menufacture");
    if (values!=null) { menufacture = values[0]; }
         
    String model = "";
    values = req.getParameterValues("model");
    if (values!=null) { model = values[0]; }
    
    String year = "";
    values = req.getParameterValues("year");
    if (values!=null) { year = values[0]; }
       
    String master = "";
    values = req.getParameterValues("master");
    if (values!=null) { master = values[0]; }

    res.setContentType("text/html");
    PrintWriter out = res.getWriter(); 
 
   	out.println("<HTML><HEAD><TITLE>Query Spare part</TITLE></HEAD>");
   out.println("<body background=\"/image/61.gif\"><center>");

        out.println("ผู้ผลิตรถยนต์(menufacture) :<font color=\"#AA0000\">"+menufacture+"</font><br>");
        out.println("รุ่น(model) :<font color=\"#AA000077\">"+model+"</font><br>");
	out.println("ปี(year) :<font color=\"#AA0000\">"+year+"</font><br>");
        
	out.println("อะไหล่(master) :<font color=\"#AA0000\">"+master+"</font><br>");
	out.println("spare_part:"+sp_namex);


        out.println("</center></body></html>");
        
  out.println("<form method=POST action=\""+"http://"+connect.hostname+"/servlet/"+"page3"+"\">");
   out.println("<input type=submit name=view value=\"view\">");
   out.println("<input type=hidden name=sp_namex value=\""+sp_namex+"\">");
   out.println("<INPUT TYPE=\"hidden\" NAME=\"lastpage\" VALUE=\""+lastpage+"\">");
   out.println("<input type=hidden name=menufacture value=\""+menufacture+"\">");
   out.println("<input type=hidden name=model value=\""+model+"\">");   
   out.println("<input type=hidden name=year value=\""+year+"\">");   
   out.println("</form>");            


out.close();
        }
}
 
