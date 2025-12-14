package Project_Information;

import java.io.*;
import java.sql.*;
import java.util.Date;
import java.util.GregorianCalendar;
/**
 * This type was created in VisualAge.
 */
public class Project {
	private int 	ProjectID = 0;
	private String 	ProjectName = "";
	private int 	PLong = 0;
	private int 	PWidth = 0;
	private	String  District = "";
	private String  Province = "";
	private int		TotalHome = 0;
	private Date	StartProject = null;
	private Date	EndProject = null;
	private	String  Status = "";
	private int     TotalMap = 0;
	private int		X = 0;
	private	int		Y = 0;
	private	int 	Xblock = 0;
	private int		Yblock = 0;
	Month m = new Month();
	Calculate c = new Calculate();

	public ProjectType type = new ProjectType(); // add type object aggregation 1 to 1
	public Home home; // add home object aggregation 1 to many
	public MapBackground map; // add map object aggregation 1 to many
/**
 * Project constructor comment.
 */
public Project() {
	super();
}
/**
 * This method was created in VisualAge.
 */
public void add(Connection conS) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	ResultSet rset  = stmtS.executeQuery  
	("select ProjectID from Project order by ProjectID");
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	ProjectID = id;
	System.out.println("ofen check 3");
	rset.close();
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Project "+
	 "(ProjectID,ProjectName,PLong,PWidth,District,Province,TotalHome,StartProject,EndProject,"+
	 " Status,TotalMap,X,Y,Xblock,Yblock)"+
	 " values "+
	 "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	System.out.println("ofen check 4");
	
	System.out.println(""+getDateString("StartProject"));
	System.out.println(""+getDateString("EndProject"));
	
	System.out.println("ofen check 5");
	
	if ( !(getDateString("StartProject").equals("")) && 
		 !(getDateString("EndProject").equals(""))  ){

		pstmt.setString (1,""+ProjectID);
		pstmt.setString (2,""+ProjectName);
		pstmt.setString (3,""+PLong);	 
		pstmt.setString (4,""+PWidth);	 
		pstmt.setString (5,""+District);	 
		pstmt.setString (6,""+Province);	 
		pstmt.setString (7,""+TotalHome);	 
		pstmt.setString (8,""+getDateString("StartProject"));	
		pstmt.setString (9,""+getDateString("EndProject"));	
		pstmt.setString (10,""+Status);	
		pstmt.setString (11,""+TotalMap);
		pstmt.setString (12,""+X);
		pstmt.setString (13,""+Y);	 
		pstmt.setString (14,""+Xblock);
		pstmt.setString (15,""+Yblock);
		
		System.out.println("ofen check 6");
		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	} else { System.out.println("not add ..."); }


	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add2(Connection conS) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	ResultSet rset  = stmtS.executeQuery  
	("select ProjectID from Project order by ProjectID");
	System.out.println("ofen check 2");
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	ProjectID = id;
	System.out.println("ofen check 3");
	rset.close();

	if ( !(getDateString("StartProject").equals("")) && 
		 !(getDateString("EndProject").equals(""))  ){
	stmtS.executeQuery
	("insert into Project "+
	 "(ProjectID,ProjectName,PLong,PWidth,District,Province,TotalHome,StartProject,EndProject,"+
	 " Status,TotalMap,X,Y,Xblock,Yblock)"+
	 " values "+
	 "('"+ProjectID +
	 "','"+ProjectName +
	 "','"+PLong +
	 "','"+PWidth +
	 "','"+District +
	 "','"+Province +
	 "','"+TotalHome +
	 "','"+getDateString("StartProject") +
	 "','"+getDateString("EndProject") +
	 "','"+Status +
	 "','"+TotalMap +
	 "','"+X +
	 "','"+Y +
	 "','"+Xblock +
	 "','"+Yblock +
	 "')");
	System.out.println("ofen check 4");
	
	System.out.println(""+getDateString("StartProject"));
	System.out.println(""+getDateString("EndProject"));
	
	System.out.println("ofen check 5");
	System.out.println("add ok!");
	} else { System.out.println("not add ..."); }


	stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void clearAllInfo() {
	 	ProjectID = 0;
	 	ProjectName = "";
	 	PLong = 0;
	 	PWidth = 0;
		District = "";
	  	Province = "";
		TotalHome = 0;
		StartProject = null;
		EndProject = null;
		Status = "";
	    TotalMap = 0;
		X = 0;
		Y = 0;
		Xblock = 0;
		Yblock = 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public Date getDate(String st) {
	if (st.equals("StartProject")) {return StartProject;}
	if (st.equals("EndProject")) {return EndProject;}
	return null;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String getDateString(String st) {
	if (st.equals("StartProject")) {
		if ((""+StartProject).length()>30) {
		return ((""+StartProject).substring(8,10)+"/"+
			    (""+StartProject).substring(4,7)+"/"+
			    (""+StartProject).substring(30,34));
		}
	}
	if (st.equals("EndProject")) {
		if ((""+EndProject).length()>30) {
		return ((""+EndProject).substring(8,10)+"/"+
			  	(""+EndProject).substring(4,7)+"/"+
			    (""+EndProject).substring(30,34));
		}
	}
	return "";
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public int getNumber(String st) {
	if (st.equals("ProjectID")) {return ProjectID;} 
	if (st.equals("PLong")) {return PLong;}
	if (st.equals("PWidth")) {return PWidth;} 
	if (st.equals("TotalHome")) {return TotalHome;} 
	if (st.equals("TotalMap")) {return TotalMap;} 
	if (st.equals("X")) {return X;} 
	if (st.equals("Y")) {return Y;} 
	if (st.equals("Xblock")) {return Xblock;}
	if (st.equals("Yblock")) {return Yblock;}
	return 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String getString(String st) {
	if (st.equals("ProjectName")) {return ProjectName;}
	if (st.equals("District")) {return District;}
	if (st.equals("Province")) {return Province;}
	if (st.equals("Status")) {return Status;}
	return "";
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean load(Connection conS,int id) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from Project          "+
		 "where ProjectID = '"+id+"' and "+
		 "StartProject is not null      and "+
		 "EndProject is not null          ");
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		home = new Home(id);// define projectid to home object
		map = new MapBackground(id);// define projectid to mapbackground object
		type.load(conS,c.toInt(""+rset.getString(7)));// define object projecttype of project
		System.out.println("Type Project := "+rset.getString(7));


		
		System.out.println("ofen2 check 3");
		setNumber("ProjectID",c.toInt(""+rset.getString(1)));
		setString("ProjectName",""+rset.getString(2));
		setNumber("PLong",c.toInt(""+rset.getString(3)));
		setNumber("PWidth",c.toInt(""+rset.getString(4)));
		setString("District",""+rset.getString(5));
		setString("Province",""+rset.getString(6));
		setNumber("TotalHome",c.toInt(""+rset.getString(8)));
		System.out.println("ofen2 check 4 totalhome = "+c.toInt(""+rset.getString(8)));
		setDate("StartProject",c.toInt(""+rset.getString(9).substring(0,4)),
							 m.toString(c.toInt(""+rset.getString(9).substring(5,7))),
							 c.toInt(""+rset.getString(9).substring(8,10)));
		setDate("EndProject",c.toInt(""+rset.getString(10).substring(0,4)),
							 m.toString(c.toInt(""+rset.getString(10).substring(5,7))),
							 c.toInt(""+rset.getString(10).substring(8,10)));
		setString("Status",""+rset.getString(11));
		setNumber("TotalMap",c.toInt(""+rset.getString(12)));
		setNumber("X",c.toInt(""+rset.getString(13)));
		setNumber("Y",c.toInt(""+rset.getString(14)));
		setNumber("Xblock",c.toInt(""+rset.getString(15)));
		setNumber("Yblock",c.toInt(""+rset.getString(16)));
		System.out.println("ofen2 check 5");

		

		System.out.println(""+getDateString("StartProject"));
		System.out.println(""+getDateString("EndProject"));
		
		System.out.println(""+StartProject+" : "+c.toInt(rset.getString(9).substring(0,4))+
							 m.toString(c.toInt(rset.getString(9).substring(5,7)))+
							 c.toInt(rset.getString(9).substring(8,10)));
		System.out.println(""+EndProject+" : "+c.toInt(rset.getString(10).substring(0,4))+
							 m.toString(c.toInt(rset.getString(10).substring(5,7)))+
							 c.toInt(rset.getString(10).substring(8,10)));
		
		}
		rset.close();

	System.out.println("end load");
	stmt.close();
return b;	
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void remove(Connection conS,int id) throws SQLException, IOException	{
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from project where projectid = '"+id+"'");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setDate(String st,int y,int m,int d) {
	GregorianCalendar cal = new GregorianCalendar(y,m-1,d,0,0,0);
	if (st.equals("StartProject")) {StartProject = cal.getTime();} else
	if (st.equals("EndProject")) {EndProject = cal.getTime();}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setDate(String st,int y,String mst,int d) {
	GregorianCalendar cal = new GregorianCalendar(y,(m.toInt(mst))-1,d,0,0,0);
	if (st.equals("StartProject")) {StartProject = cal.getTime();} else
	if (st.equals("EndProject")) {EndProject = cal.getTime();}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setDate2(String st,String d) {
	GregorianCalendar cal;
	if (d.length() == 10) {
		cal = new GregorianCalendar
		(c.toInt(d.substring(6,10)),(m.toInt( d.substring(2,5) ))-1,c.toInt(d.substring(0,1)),0,0,0);

	} else {
		cal = new GregorianCalendar
		(c.toInt(d.substring(7,11)),(m.toInt( d.substring(3,6) ))-1,c.toInt(d.substring(0,2)),0,0,0);
	}
	
	
	if (st.equals("StartProject")) {StartProject = cal.getTime();} else
	if (st.equals("EndProject")) {EndProject = cal.getTime();}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setNumber(String st,int i) {
	if (st.equals("ProjectID")) {ProjectID = i;} else
	if (st.equals("PLong")) {PLong = i;} else
	if (st.equals("PWidth")) {PWidth = i;} else
	if (st.equals("TotalHome")) {TotalHome = i;} else
	if (st.equals("TotalMap")) {TotalMap = i;} else
	if (st.equals("X")) {X = i;} else
	if (st.equals("Y")) {Y = i;} else
	if (st.equals("Xblock")) {Xblock = i;} else
	if (st.equals("Yblock")) {Yblock = i;}
}
/**
 * This method was created in VisualAge.
 */
public void setProjectType(Connection conS,int id) throws SQLException, IOException {
System.out.println("setProjectType check 1");
	Statement stmtS = conS.createStatement();
	
	stmtS.execute("update Project set							 "+
		          "	   ProjectTypeID 	= '"+id+"' 				 "+
		          "where  ProjectID = '"+ProjectID	+"'   	 	 ");
	
	stmtS.close();
System.out.println("set ProjectType ok!");
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setString(String st,String st2) {
	if (st.equals("ProjectName")) {ProjectName = st2;}
	if (st.equals("District")) {District = st2;}
	if (st.equals("Province")) {Province = st2;}
	if (st.equals("Status")) {Status = st2;}
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id) throws SQLException, IOException {
	System.out.println("ofen check 1");
	
		ProjectID = id;
		
	System.out.println("ofen check 3");
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into Project "+
	 "(ProjectID,ProjectName,PLong,PWidth,District,Province,TotalHome,StartProject,EndProject,"+
	 " Status,TotalMap,X,Y,Xblock,Yblock)"+
	 " values "+
	 "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	System.out.println("ofen check 4");
	
	System.out.println(""+getDateString("StartProject"));
	System.out.println(""+getDateString("EndProject"));
	
	System.out.println("ofen check 5");
	
	if ( !(getDateString("StartProject").equals("")) && 
		 !(getDateString("EndProject").equals(""))  ){
		pstmt.setString (1,""+Yblock);
		pstmt.setString (2,""+ProjectID);
		pstmt.setString (3,""+ProjectName);
		pstmt.setString (4,""+PLong);	 
		pstmt.setString (5,""+PWidth);	 
		pstmt.setString (6,""+District);	 
		pstmt.setString (7,""+Province);	 
		pstmt.setString (8,""+TotalHome);	 
		pstmt.setString (9,""+getDateString("StartProject"));	
		pstmt.setString (10,""+getDateString("EndProject"));	
		pstmt.setString (11,""+Status);	
		pstmt.setString (12,""+TotalMap);
		pstmt.setString (13,""+X);
		pstmt.setString (14,""+Y);	 
		pstmt.setString (15,""+Xblock);
		
		System.out.println("ofen check 6");
		remove(conS,id);
		pstmt.execute();
		pstmt.close();
		System.out.println("add ok!");
	} else { System.out.println("not add ..."); }


	
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id) throws SQLException, IOException {
System.out.println("project update check 1");
	ProjectID = id;	
	Statement stmtS = conS.createStatement();
	
	stmtS.execute("update Project set							 "+
		          "	   ProjectName 	= '"+ProjectName+"' 		,"+
		          "	   PLong 		= '"+PLong		+"'  		,"+
		          "	   PWidth	 	= '"+PWidth		+"' 		,"+
		          "	   District	 	= '"+District	+"'		 	,"+
		          "	   Province 	= '"+Province	+"' 		,"+
		          "	   TotalHome	= '"+TotalHome	+"' 		,"+
		          "	   StartProject = '"+getDateString("StartProject")+"' 	,"+
		          "	   EndProject	= '"+getDateString("EndProject")  +"' 	,"+
		          "	   Status	 	= '"+Status		+"' 		,"+
		          "	   TotalMap	 	= '"+TotalMap	+"'	 		,"+
		          "	   X	 		= '"+X			+"' 		,"+
		          "	   Y  			= '"+Y			+"' 		,"+
		          "	   Xblock	 	= '"+Xblock		+"' 		,"+
		          "	   Yblock	 	= '"+Yblock		+"' 	 	 "+
		          "where  ProjectID = '"+ProjectID	+"'   	 	 ");
	
	stmtS.close();
	System.out.println("update ok!");
}
}