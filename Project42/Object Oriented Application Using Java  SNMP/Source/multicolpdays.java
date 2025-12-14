
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


public class multicolpdays extends HttpServlet{

  static final int WIDTH = 700;
  static final int HEIGHT = 320;


  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

  
  String ip = req.getParameter("ip");

  Vector vin  = new Vector();
  Vector vout = new Vector();
  Vector vinoctet1 = new Vector(); //add
  Vector vinoctet2 = new Vector(); //add
  Vector vmidd     = new Vector();
  int w;
  String temp1;

  int midtoday = findmids(52448330); //50725201   about 23.58 tuesday 7march2000

try{	
////////////////////////////////////////
	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
	Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");

	Statement stmt = null;	
	stmt = conn.createStatement();
	ResultSet rs2 = stmt.executeQuery("select * from inoutdevice order by timemill1");

	while (rs2.next())
	{
		if (rs2.getString("inter").equals(ip+"#2") ){
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

			int tempinoctet1 = Integer.parseInt(rs2.getString("multicol1").trim());	
			vinoctet1.addElement(new Integer(tempinoctet1));

			if (rs2.getString("multicol2").equals("e")){
				Statement stmt8 = null;	
				stmt8 = conn.createStatement();
				ResultSet rs8 = stmt8.executeQuery("select * from keepalltime");
				while (rs8.next())
				{
					if (rs8.getString("inter").equals(ip+"#2") ){
						int inoctetcur  = Integer.parseInt(rs8.getString("multicol").trim());
						vinoctet2.addElement(new Integer(inoctetcur));					
					}				
				}

			}
			else {
				int tempinoctet2 = Integer.parseInt(rs2.getString("multicol2").trim());	
				vinoctet2.addElement(new Integer(tempinoctet2));
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

	int inoctet1[] = new int[vinoctet1.size()+2];
	inoctet1[0] = 0;
	inoctet1[vinoctet1.size()+1] = 0;

	for (w=0; w<vinoctet1.size(); w++){
		temp1 = vinoctet1.elementAt(w).toString();
		inoctet1[w+1]  = (new Integer(temp1)).intValue();
	}

	int inoctet2[] = new int[vinoctet2.size()+2];
	inoctet2[0] = 0;
	inoctet2[vinoctet2.size()+1] = 0;

	for (w=0; w<vinoctet2.size(); w++){
		temp1 = vinoctet2.elementAt(w).toString();
		inoctet2[w+1]  = (new Integer(temp1)).intValue();
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
		int mi=0;

		for (k=0; k<ans.length; k++) ans[k]=-1;
		
		int checks;
//////////////////////////////////////
		int middy,middy2;

		while (out[i] != 0){

			n= checkCase(m,in[i],out[i]);
		
			if (n==1){
				temp[t] = inoctet2[i] - inoctet1[i];//temp[t] = out[i] - in[i];				
				t=t+1;
				i=i+1;

			}
			else
			if (n==2){
				middy = finddb(m,ip);
				temp[t] = middy - inoctet1[i];//temp[t] = m - in[i];

				te=0;
				for (k=1; k<30; k++ ) te = te+temp[k]; ans[a]= te;
				a=a+1;
				for (z=1; z<30; z++ ) temp[z]=0;
				t=1;

				temp[t] = inoctet2[i] - middy;//temp[t] = out[i] - m;
				checks  = out[i]-m; //add

				while (checks>86400){//while (temp[t]>86400){
					middy = finddb(m,ip);
					middy2 = finddb(m+86400,ip);
					ans[a]=middy2-middy;//ans[a]=midd[mi+1]-midd[mi];    //    ans[a]=86400;
					a=a+1;
					m=m+86400;
//					mi=mi+1;		// add
					middy = finddb(m,ip);
					temp[t]=inoctet2[i]-middy;//temp[t]=inoctet2[i]-midd[mi];  //    temp[t]=out[i]-m;
					checks =out[i]-m; //add
				}

				t=t+1;
				m=m+86400;
//				mi=mi+1;  //add
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
//				mi=mi+1;  //add				
			}

		}

		te=0;
		for (k=1; k<30; k++ ) te = te+temp[k]; ans[a]= te;
		a=a+1;
		for (z=1; z<30; z++ ) temp[z]=0;
		t=1;



	Vector vappleData = new Vector();
	for (int p=1; p<20; p++ )  
		if (ans[p]!=-1) vappleData.addElement(new Double(ans[p]));	

	double appleData[] = new double[vappleData.size()];
	for (int p=1; p<20; p++ )  
		if (ans[p]!=-1) appleData[p-1] = (double)(ans[p]);	



	ServletOutputStream out2 = res.getOutputStream();

    Frame frame = null;
    Graphics g = null;

    try {
      // Create a simple chart
      BarChart chart = new BarChart("Octet in Interface1 Statistics (per day)");

      // Give it a title
      chart.getBackground().setTitleFont(new Font("Serif", Font.PLAIN, 24));
      chart.getBackground().setTitleString("MultipleCollisionFrames Statistics(per Day)");
  
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
      chart.getDatasets()[0].getGc().setFillColor(Color.yellow);

  
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



  public static int finddb(int re,String ip){ 
   int wanted = 25000;
   try{ 
	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
	Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");

	Statement stmt88 = null;	
	stmt88 = conn.createStatement();
	ResultSet rs88 = stmt88.executeQuery("select * from datamid order by timemill");

bb:	while (rs88.next())
	{
		if (rs88.getString("inter").equals(ip+"#2") && 
			(Integer.parseInt(rs88.getString("timemill")) <=(re+480) &&  Integer.parseInt(rs88.getString("timemill")) >=(re-20) ) ){
			wanted = Integer.parseInt(rs88.getString("multicol").trim());	
			break bb;
		}
	}

   } catch ( Exception ex) {} 

   return wanted;

  }




}

