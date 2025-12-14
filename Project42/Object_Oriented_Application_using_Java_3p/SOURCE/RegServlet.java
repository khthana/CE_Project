import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

 public class RegServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException	{
                resp.setContentType("text/html");
                PrintWriter out = new PrintWriter(resp.getOutputStream());
	// to do: code goes here.
                out.println("<HTML>");
	out.println("<HEAD><TITLE>test RegServlet Output</TITLE></HEAD>");
                out.println("<BODY>");
                out.println("touch test nim");
               // to do: your HTML goes here.
	out.println("</BODY>");
	out.println("</HTML>");
	out.close();
}
} 

/*public class RegServlet extends HttpServlet { 

    public void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException
    {
        // set header field first
        res.setContentType("text/html");

        // then get the writer and write the response data
        PrintWriter out = res.getWriter();        
        out.println("<HEAD><TITLE> SimpleServlet Output</TITLE></HEAD><BODY>");
        out.println("<h1> SimpleServlet Output </h1>");
        out.println("<P>This is output is from SimpleServlet.");
        out.println("</BODY>");
        out.close();
    }

    public String getServletInfo() {
        return "A simple servlet";
    }

}
*/

/*public class RegServlet extends HttpServlet
{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException
	{
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();

        // to do: code goes here.
        String data;
        int data2;
        data = req.getMethod();
		out.println("<HTML>");
		out.println("<HEAD><TITLE>RegServlet Output</TITLE></HEAD>");
		out.println("<BODY>");

		// to do: your HTML goes here.

        out.println("<h1>touch</h1>");

        out.println("<h1>");
        out.println(data);
        out.println( "</h1>" );
		out.println("</BODY>");
		out.println("</HTML>");
		out.close();
	}

}*/