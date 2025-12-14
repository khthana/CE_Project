
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


public class swperday extends HttpServlet{

  static final int WIDTH = 700;
  static final int HEIGHT = 320;


  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

  
	String inte = req.getParameter("inte");
	String type = req.getParameter("type");

	String ainte = inte;
	String atype = type;
	

	if (inte.equals("Interface101")) inte="#1"; else
	if (inte.equals("Interface102")) inte="#2"; else
	if (inte.equals("Interface103")) inte="#3"; else
	if (inte.equals("Interface104")) inte="#4"; else
	if (inte.equals("Interface105")) inte="#5"; else
	if (inte.equals("Interface106")) inte="#6"; 


	if (type.equals("Packets")) type="octet"; else
	if (type.equals("CRCAlignErrors")) type="crc"; else	
	if (type.equals("Collisions")) type="colli"; 


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
			timemill[k] = Integer.parseInt(rs2.getString("timemill"));	
			forthree[k] = Integer.parseInt(rs2.getString(type).trim());	
			k = k+1;
		}

	}

} catch ( Exception ex) {     } 


	int ref = 53053130;
	while (timemill[1]>ref) ref=ref+86400;

	k=1;
	int m=1;

	while (timemill[k]!=0){

		int start = forthree[k];

		while (timemill[k]<(ref+300)  && timemill[k]!=0) k=k+1;
		
		ans[m] = forthree[k-1]-start;
		m=m+1;
		ref= ref+86400;
	}


	Vector vappleData = new Vector();
	for (int p=1; p<31; p++ )  
		if (ans[p]!=-1) vappleData.addElement(new Double(ans[p]));	

	double appleData[] = new double[vappleData.size()];
	for (int p=1; p<31; p++ )  
		if (ans[p]!=-1) appleData[p-1] = (double)(ans[p]);	



	ServletOutputStream out2 = res.getOutputStream();

    Frame frame = null;
    Graphics g = null;

    try {
      // Create a simple chart
      BarChart chart = new BarChart("Octet in Interface1 Statistics (per day)");

      // Give it a title
      chart.getBackground().setTitleFont(new Font("Serif", Font.PLAIN, 24));
      chart.getBackground().setTitleString(atype+" in "+ainte+" Statistics (per day)");
  
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
	  chart.getXAxis().setTitleString("Day");
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

