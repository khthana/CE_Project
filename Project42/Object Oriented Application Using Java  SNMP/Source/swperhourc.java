
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


public class swperhourc extends HttpServlet{

  static final int WIDTH = 900;
  static final int HEIGHT = 320;


  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

	String type = req.getParameter("type");
	String back = req.getParameter("back");
	int backs = Integer.parseInt(back);

	String atype = type;
	

	if (type.equals("Packets")) type="hoctet"; else
	if (type.equals("CRCAlignErrors")) type="hcrc"; else	
	if (type.equals("Collisions")) type="hcolli"; 


	int timemill[] = new int[2401];  //0..2400

	int forthree[]  = new int[2401];  //0..2400
	int forthree2[] = new int[2401];  //0..2400
	int forthree3[] = new int[2401];  //0..2400
	int forthree4[] = new int[2401];  //0..2400
	int forthree5[] = new int[2401];  //0..2400
	int forthree6[] = new int[2401];  //0..2400
	int ans[]      = new int[31];    //0..30   
	int ans2[]     = new int[31];    //0..30   
	int ans3[]     = new int[31];    //0..30   
	int ans4[]     = new int[31];    //0..30   
	int ans5[]     = new int[31];    //0..30   
	int ans6[]     = new int[31];    //0..30   


	for (int i=1; i<31; i++ ) {
		ans[i]  = -1;
		ans2[i] = -1;
		ans3[i] = -1;
		ans4[i] = -1;
		ans5[i] = -1;
		ans6[i] = -1;
	}

	int k=1,k2=1,k3=1,k4=1,k5=1,k6=1;
	
try{	
////////////////////////////////////////
	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
	Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");

	Statement stmt = null;	
	stmt = conn.createStatement();
	ResultSet rs2 = stmt.executeQuery("select * from forswitch order by timemill");

	while (rs2.next())
	{
		if (rs2.getString("inter").equals("161.246.6.10#1") ){
			if (!rs2.getString(type).trim().equals("n")){
				timemill[k] = Integer.parseInt(rs2.getString("timemill"));	
				forthree[k] = Integer.parseInt(rs2.getString(type).trim());	
				k = k+1;
			}
		}
		if (rs2.getString("inter").equals("161.246.6.10#2") ){
			if (!rs2.getString(type).trim().equals("n")){
				forthree2[k2] = Integer.parseInt(rs2.getString(type).trim());	
				k2 = k2+1;
			}
		}
		if (rs2.getString("inter").equals("161.246.6.10#3") ){
			if (!rs2.getString(type).trim().equals("n")){
				forthree3[k3] = Integer.parseInt(rs2.getString(type).trim());	
				k3 = k3+1;
			}
		}
		if (rs2.getString("inter").equals("161.246.6.10#4") ){
			if (!rs2.getString(type).trim().equals("n")){
				forthree4[k4] = Integer.parseInt(rs2.getString(type).trim());	
				k4 = k4+1;
			}
		}
		if (rs2.getString("inter").equals("161.246.6.10#5") ){
			if (!rs2.getString(type).trim().equals("n")){
				forthree5[k5] = Integer.parseInt(rs2.getString(type).trim());	
				k5 = k5+1;
			}
		}
		if (rs2.getString("inter").equals("161.246.6.10#6") ){
			if (!rs2.getString(type).trim().equals("n")){
				forthree6[k6] = Integer.parseInt(rs2.getString(type).trim());	
				k6 = k6+1;
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

	int rforthree2[] = new int[vtimemill.size()+1];
	for (int p=1; p<2401; p++ )  
		if (forthree2[p]!=0) rforthree2[p] = (int)(forthree2[p]);	

	int rforthree3[] = new int[vtimemill.size()+1];
	for (int p=1; p<2401; p++ )  
		if (forthree3[p]!=0) rforthree3[p] = (int)(forthree3[p]);	

	int rforthree4[] = new int[vtimemill.size()+1];
	for (int p=1; p<2401; p++ )  
		if (forthree4[p]!=0) rforthree4[p] = (int)(forthree4[p]);	

	int rforthree5[] = new int[vtimemill.size()+1];
	for (int p=1; p<2401; p++ )  
		if (forthree5[p]!=0) rforthree5[p] = (int)(forthree5[p]);	

	int rforthree6[] = new int[vtimemill.size()+1];
	for (int p=1; p<2401; p++ )  
		if (forthree6[p]!=0) rforthree6[p] = (int)(forthree6[p]);	


	int ref = 53053130;
	while (rtimemill[vtimemill.size()]>ref) ref=ref+86400;

	int tref = ref;
	int ref2= 53053130;
	while (rtimemill[1]>ref2) ref2=ref2+86400;

	tref = (ref-ref2)/86400;


 
	int v=1;
	for (int i=1; i<(vtimemill.size()+1); i++){  // 0 to <1  do 1
		if(rtimemill[i]<(ref+300-backs*86400) && rtimemill[i]>(ref+3600-300-86400-backs*86400)){
			ans[v]  = rforthree[i];
			ans2[v] = rforthree2[i];
			ans3[v] = rforthree3[i];
			ans4[v] = rforthree4[i];
			ans5[v] = rforthree5[i];
			ans6[v] = rforthree6[i];
			v=v+1;
		}
	}



	Vector vappleData = new Vector();
	for (int p=1; p<31; p++ )  
		if (ans[p]!=-1) vappleData.addElement(new Double(ans[p]));	


  double appleData[];	
  double appleData2[];	
  double appleData3[];	
  double appleData4[];	
  double appleData5[];	
  double appleData6[];	
  if (tref>=backs){
  
	appleData = new double[vappleData.size()];
	appleData2 = new double[vappleData.size()];
	appleData3 = new double[vappleData.size()];
	appleData4 = new double[vappleData.size()];
	appleData5 = new double[vappleData.size()];
	appleData6 = new double[vappleData.size()];
	for (int p=1; p<31; p++ ){  
		if (ans[p]!=-1) appleData[p-1] = (double)(ans[p]);	
		if (ans2[p]!=-1) appleData2[p-1] = (double)(ans2[p]);	
		if (ans3[p]!=-1) appleData3[p-1] = (double)(ans3[p]);	
		if (ans4[p]!=-1) appleData4[p-1] = (double)(ans4[p]);	
		if (ans5[p]!=-1) appleData5[p-1] = (double)(ans5[p]);	
		if (ans6[p]!=-1) appleData6[p-1] = (double)(ans6[p]);	
	}

  }
  else  {appleData = new double[1]; appleData2 = new double[1]; appleData3 = new double[1]; appleData4 = new double[1]; appleData5 = new double[1]; appleData6 = new double[1];}

	ServletOutputStream out2 = res.getOutputStream();

    Frame frame = null;
    Graphics g = null;

    try {
      // Create a simple chart
      BarChart chart = new BarChart("Octet in Interface1 Statistics (per day)");

      // Give it a title
      chart.getBackground().setTitleFont(new Font("Serif", Font.PLAIN, 24));
	  if (backs==0)
	      chart.getBackground().setTitleString(atype+" Statistics (per hour)  Today");	  
	  else	
	  if (backs==1)
	      chart.getBackground().setTitleString(atype+" Statistics (per hour)  Yesterday");	  
	  else		  
	      chart.getBackground().setTitleString(atype+" Statistics (per hour)  back "+backs);
  
      // Show, place, and customize its legend
      chart.setLegendVisible(true);
      chart.getLegend().setLlX(0.25);  // normalized from lower left
      chart.getLegend().setLlY(0.75); // normalized from lower left
      chart.getLegend().setIconHeight(0.04);
      chart.getLegend().setIconWidth(0.02);
      chart.getLegend().setIconGap(0.02);
      chart.getLegend().setVerticalLayout(false);

      // Give it its data and labels
	  chart.addDataSet("101", appleData );
      chart.addDataSet("102", appleData2 );
      chart.addDataSet("103", appleData3 );
      chart.addDataSet("104", appleData4 );
      chart.addDataSet("105", appleData5 );
      chart.addDataSet("106", appleData6 );

	  String[] labels =	new String[vappleData.size()];
	  for (int q=0; q<vappleData.size(); q++ ){
		labels[q] = Integer.toString(q+1);
	  }

	  chart.getXAxis().addLabels(labels);
		

      // Color apples red and oranges orange
      chart.getDatasets()[0].getGc().setFillColor(Color.red);
      chart.getDatasets()[1].getGc().setFillColor(Color.orange);
      chart.getDatasets()[2].getGc().setFillColor(Color.yellow);
      chart.getDatasets()[3].getGc().setFillColor(Color.green);
      chart.getDatasets()[4].getGc().setFillColor(Color.blue);
      chart.getDatasets()[5].getGc().setFillColor(Color.black);

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

