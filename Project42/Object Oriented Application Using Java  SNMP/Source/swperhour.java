
import java.net.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.math.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.awt.*;
import Acme.JPM.Encoders.GifEncoder;
import javachart.chart.*;  // from Visual Engineering


public class swperhour extends HttpServlet{

  static final int WIDTH = 700;
  static final int HEIGHT = 320;


  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
  
	String inte = req.getParameter("inte");
	String type = req.getParameter("type");
	String back = req.getParameter("back");
	int backs = Integer.parseInt(back);

	String ainte = inte;
	String atype = type;
	

	if (inte.equals("Interface101")) inte="#1"; else
	if (inte.equals("Interface102")) inte="#2"; else
	if (inte.equals("Interface103")) inte="#3"; else
	if (inte.equals("Interface104")) inte="#4"; else
	if (inte.equals("Interface105")) inte="#5"; else
	if (inte.equals("Interface106")) inte="#6"; 


	if (type.equals("Packets")) type="hoctet"; else
	if (type.equals("CRCAlignErrors")) type="hcrc"; else	
	if (type.equals("Collisions")) type="hcolli"; 


	int timemill[] = new int[2401];  //0..2400
	int forthree[] = new int[2401];  //0..2400
	int ans[]      = new int[31];    //0..30   

	for (int i=1; i<31; i++ ) ans[i]= -1;

	int k=1;
	
try{	
////////////////////////////////////////
	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
	Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");

	Statement stmt = null;	
	stmt = conn.createStatement();
	ResultSet rs2 = stmt.executeQuery("select * from forswitch order by timemill");

	while (rs2.next())
	{
		if (rs2.getString("inter").equals("161.246.6.10"+inte) ){
			if (!rs2.getString(type).trim().equals("n")){
				timemill[k] = Integer.parseInt(rs2.getString("timemill"));	
				forthree[k] = Integer.parseInt(rs2.getString(type).trim());	
				k = k+1;
			}
		}

	}

} catch ( Exception ex) {     } 


	Vector vtimemill = new Vector();
	for (int p=1; p<2401; p++ )  
		if (timemill[p]!=0) vtimemill.addElement(new Integer(timemill[p]));	

	int rtimemill[] = new int[vtimemill.size()+1];
	for (int p=1; p<2401; p++ )  
		if (timemill[p]!=0) rtimemill[p] = (int)(timemill[p]);	

	int rforthree[] = new int[vtimemill.size()+1];
	for (int p=1; p<2401; p++ )  
		if (forthree[p]!=0) rforthree[p] = (int)(forthree[p]);	




	int ref = 53053130;
	while (rtimemill[vtimemill.size()]>ref) ref=ref+86400;

	int tref = ref;
	int ref2= 53053130;
	while (rtimemill[1]>ref2) ref2=ref2+86400;

	tref = (ref-ref2)/86400;

	int v=1;
	for (int i=1; i<(vtimemill.size()+1); i++){  // 0 to <1  do 1
		if(rtimemill[i]<(ref+300-backs*86400) && rtimemill[i]>(ref+3600-300-86400-backs*86400)){
			ans[v] = rforthree[i];
			v=v+1;
		}
	}



	Vector vappleData = new Vector();
	for (int p=1; p<31; p++ )  
		if (ans[p]!=-1) vappleData.addElement(new Double(ans[p]));	

  double appleData[];	
  if (tref>=backs){
  
	appleData = new double[vappleData.size()];
	for (int p=1; p<31; p++ )  
		if (ans[p]!=-1) appleData[p-1] = (double)(ans[p]);	

  }
  else  {appleData = new double[1]; }

	ServletOutputStream out2 = res.getOutputStream();

    Frame frame = null;
    Graphics g = null;

    try {
      // Create a simple chart
      BarChart chart = new BarChart("Octet in Interface1 Statistics (per day)");

      // Give it a title
      chart.getBackground().setTitleFont(new Font("Serif", Font.PLAIN, 24));
	  if (backs==0)
	      chart.getBackground().setTitleString(atype+" in "+ainte+" Statistics (per hour)  Today");	  
	  else	
	  if (backs==1)
	      chart.getBackground().setTitleString(atype+" in "+ainte+" Statistics (per hour)  Yesterday");	  
	  else		  
	      chart.getBackground().setTitleString(atype+" in "+ainte+" Statistics (per hour)  back "+backs);
  
      // Show, place, and customize its legend
      chart.setLegendVisible(false);
      chart.getLegend().setLlX(0.4);  // normalized from lower left
      chart.getLegend().setLlY(0.75); // normalized from lower left
      chart.getLegend().setIconHeight(0.04);
      chart.getLegend().setIconWidth(0.04);
      chart.getLegend().setIconGap(0.02);
      chart.getLegend().setVerticalLayout(false);

      // Give it its data and labels
      chart.addDataSet("", appleData );

      // Color apples red and oranges orange
      chart.getDatasets()[0].getGc().setFillColor(Color.red);

  
      // Name the axes
      chart.getXAxis().setTitleFont(new Font("Serif", Font.PLAIN, 24));
	  chart.getXAxis().setTitleString("Hour");
      chart.getYAxis().setTitleFont(new Font("Serif", Font.PLAIN, 24));
      chart.getYAxis().setTitleString("Number");
  
      // Size it appropriately
      chart.resize(WIDTH, HEIGHT);
      
      // Create an unshown frame
      frame = new Frame();
      frame.addNotify();
  
      // Get a graphics region of appropriate size, using the Frame
      Image image = frame.createImage(WIDTH, HEIGHT);
      g = image.getGraphics();

      // Ask the chart to draw itself to the off screen graphics context
      chart.drawGraph(g);

      // Encode and return what it painted
      res.setContentType("image/gif");
      GifEncoder encoder = new GifEncoder(image, out2);
      encoder.encode();
    }
    finally {
      // Clean up resources
      if (g != null) g.dispose();
      if (frame != null) frame.removeNotify();
    }

  } 
  
}

