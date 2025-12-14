
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


public class inoutpday extends HttpServlet{

  static final int WIDTH = 700;
  static final int HEIGHT = 320;

  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

  
  String ip = req.getParameter("ip");

  Vector vin  = new Vector();
  Vector vout = new Vector();
  int w;
  String temp1;

  int midtoday = findmids(52448330); //50725201 about 23.58 tuesday 7march2000

try{	
////////////////////////////////////////
	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
	Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");

	Statement stmt = null;	
	stmt = conn.createStatement();
	ResultSet rs2 = stmt.executeQuery("select * from inoutdevice order by timemill1");

	while (rs2.next())
	{
		if (rs2.getString("inter").equals(ip+"#1") ){
			int temptimemill1 = Integer.parseInt(rs2.getString("timemill1"));	
			vin.addElement(new Integer(temptimemill1));

			if (rs2.getString("timemill2").equals("e")){
				int ctime = (int)(System.currentTimeMillis()/1000-900000000);
				vout.addElement(new Integer(ctime));					
			}
			else {
				int temptimemill2 = Integer.parseInt(rs2.getString("timemill2"));	
				vout.addElement(new Integer(temptimemill2));
			}
		}
	}

	int in[] = new int[vin.size()+2];
	in[0] = 0;
	in[vin.size()+1] = 0;

	for (w=0; w<vin.size(); w++){
		temp1 = vin.elementAt(w).toString();
		in[w+1]  = (new Integer(temp1)).intValue();
	}

	int out[] = new int[vout.size()+2];
	out[0] = 0;
	out[vout.size()+1] = 0;

	for (w=0; w<vout.size(); w++){
		temp1 = vout.elementAt(w).toString();
		out[w+1]  = (new Integer(temp1)).intValue();
	}
//////////////////////////////////////

	int ref = 52448330;

	while (in[1]>ref)
			ref = ref + 86400;

	int m = ref;

		int ans[]  = new int[20]; //0..19
		int temp[] = new int[30]; //0..29

		int i=1;
		int a=1;
		int t=1;    int n,k,z,te;

		for (k=0; k<ans.length; k++) ans[k]=1;
		
		while (out[i] != 0){

			n= checkCase(m,in[i],out[i]);
		
			if (n==1){
				temp[t] = out[i] - in[i];
				t=t+1;
				i=i+1;

			}
			else
			if (n==2){
				temp[t] = m - in[i];

				te=0;
				for (k=1; k<30; k++ ) te = te+temp[k]; ans[a]= te;
				a=a+1;
				for (z=1; z<30; z++ ) temp[z]=0;
				t=1;

				temp[t] = out[i] - m;

				while (temp[t]>86400){
					ans[a]=86400;
					a=a+1;
					m=m+86400;
					temp[t]=out[i]-m;
				}
				t=t+1;
				m=m+86400;
				i=i+1;
			}
			else
			if (n==3){
				te=0;
				for (k=1; k<30; k++ ) te = te+temp[k]; ans[a]= te;
				a=a+1;
				for (z=1; z<30; z++ ) temp[z]=0;
				t=1;
				
				m=m+86400;			
			}

		}

		te=0;
		for (k=1; k<30; k++ ) te = te+temp[k]; ans[a]= te;
		a=a+1;
		for (z=1; z<30; z++ ) temp[z]=0;
		t=1;


	Vector vappleData = new Vector();
	for (int p=1; p<20; p++ )  
		if (ans[p]!=1) vappleData.addElement(new Double(ans[p]));	

	double appleData[] = new double[vappleData.size()];
	for (int p=1; p<20; p++ )  
		if (ans[p]!=1) appleData[p-1] = (double)(ans[p]);	



	ServletOutputStream out2 = res.getOutputStream();

    Frame frame = null;
    Graphics g = null;

    try {
      // Create a simple chart
      BarChart chart = new BarChart("Use per day Statistics");

      // Give it a title
      chart.getBackground().setTitleFont(new Font("Serif", Font.PLAIN, 24));
      chart.getBackground().setTitleString("Use per day Statistics");
  
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
      chart.getYAxis().setTitleString("Sec");
  
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

    } catch ( Exception ex) {     } 

  } 
  

  public static int caltime (String pname2,String pname1) {
		int time2 = Integer.parseInt(pname2);
		int time1 = Integer.parseInt(pname1);

		int res = time2-time1;
		return res;
  }

  public static int checkCase(int mid, int in, int out){
		if (mid>in && mid>out) return 1; else
		if (mid>in && mid<out) return 2; else
		if (mid<in && mid<out) return 3; 

		return 4;
		
  }	

  public static int findmids(int wanted){ 

			int timec = (int)(System.currentTimeMillis()/1000-900000000);
			System.out.println(timec);		
			
			if (timec > wanted){

				int forcu = timec - wanted;
				System.out.println(forcu);

				int be = forcu/86400+1;
				System.out.println(be);

				be = wanted + 86400*be;

				return be;
			}

			return wanted;

  }

}

