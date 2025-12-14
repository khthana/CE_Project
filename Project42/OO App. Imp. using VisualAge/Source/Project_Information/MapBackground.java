package Project_Information;

import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class MapBackground {
	private int MapID = 0;
	private int X = 0;
	private int Y = 0;
	Calculate c = new Calculate();

	public int proid = 0;
	public MapImage image = new MapImage(); // add object aggregation 1 to 1
	
/**
 * Employee constructor comment.
 */
public MapBackground() {
	super();
}
/**
 * Employee constructor comment.
 */
public MapBackground(int pid) {
	super();
	proid = pid;
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
	("select MapID		 				"+
	 "from MapBackground				"+
	 "where ProjectID = '"+proid+"'  	"+
	 "order by MapID					");
	
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	MapID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into MapBackground "+
	 "(ProjectID,MapID,X,Y)"+
	 " values "+
	 "(?,?,?,?)");
	
	System.out.println("ofen check 4");

		pstmt.setString (1,""+(proid));
		pstmt.setString (2,""+(MapID));
		pstmt.setString (3,""+(X));
		pstmt.setString (4,""+(Y));	 		
		
	System.out.println("ofen check 6");
	
	pstmt.execute();
	pstmt.close();
	System.out.println("add ok!");
	
		stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add(Connection conS,int proid) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select MapID		 				"+
	 "from MapBackground				"+
	 "where ProjectID = '"+proid+"'  	"+
	 "order by MapID					");
	
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	MapID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into MapBackground "+
	 "(ProjectID,MapID,X,Y)"+
	 " values "+
	 "(?,?,?,?)");
	
	System.out.println("ofen check 4");

		pstmt.setString (1,""+(proid));
		pstmt.setString (2,""+(MapID));
		pstmt.setString (3,""+(X));
		pstmt.setString (4,""+(Y));	 		
		
	System.out.println("ofen check 6");
	
	pstmt.execute();
	pstmt.close();
	System.out.println("add ok!");
	
		stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add2(Connection conS) throws SQLException, IOException {
//	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select MapID		 				"+
	 "from MapBackground				"+
	 "where ProjectID = '"+proid+"'  	"+
	 "order by MapID					");
	
//	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	MapID = id;
	
	
//	System.out.println("ofen check 3");
	rset.close();
	
	stmtS.executeQuery
	("insert into MapBackground "+
	 "(ProjectID,MapID,X,Y)"+
	 " values "+
	 "('"+proid +"','"+MapID +"','"+X +"','"+Y +"')");
	
//	System.out.println("ofen check 4");

	System.out.println("add ok!");
	
		stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add2(Connection conS,int proid) throws SQLException, IOException {
	System.out.println("ofen check 1");
	int id = 1;
	boolean end = false;

	
	// find last row or empty row for insert data;
	Statement stmtS = conS.createStatement ();
	
	ResultSet rset  = stmtS.executeQuery  
	("select MapID		 				"+
	 "from MapBackground				"+
	 "where ProjectID = '"+proid+"'  	"+
	 "order by MapID					");
	
	System.out.println("ofen check 2");
	
	while (rset.next () && !end)
	 {
		if (!(rset.getString(1).equals(""+id)) ){
			end = true;
		} else { id++; }
	 }
	 
	MapID = id;
	
	
	System.out.println("ofen check 3");
	rset.close();
	
	stmtS.executeQuery
	("insert into MapBackground "+
	 "(ProjectID,MapID,X,Y)"+
	 " values "+
	 "('"+proid +"','"+MapID +"','"+X +"','"+Y +"')");
	
	System.out.println("ofen check 4");

	System.out.println("add ok!");
	
		stmtS.close();
	
}
/**
 * This method was created in VisualAge.
 */
public void add3(Connection conS,int id) throws SQLException, IOException {
	Statement stmtS = conS.createStatement ();
	MapID = id;
	stmtS.executeQuery
	("insert into MapBackground "+
	 "(ProjectID,MapID,X,Y)"+
	 " values "+
	 "('"+proid +"','"+MapID +"','"+X +"','"+Y +"')");
//	System.out.println("add ok!");
		stmtS.close();
}
/**
 * This method was created in VisualAge.
 */
public void clearAllInfo() {
	MapID = 0;
	X = 0;
	Y = 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public int getNumber(String st) {
	if (st.equals("MapID")) {return MapID;}
	if (st.equals("X")) {return X;}
	if (st.equals("Y")) {return Y;}	
	return 0;
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean load(Connection conS,int id) throws SQLException, IOException  {
boolean b = false;

		Statement stmt = conS.createStatement();
	//	System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from MapBackground      "+
		 "where	MapID		= '"+id+"' "+
		 "  and ProjectID   = '"+proid+"' ");
		
	//	System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
		
	//	System.out.println("ofen2 check 3");

		image.load(conS,c.toInt(""+rset.getString(5))); // define MapImage of MapBackground
		
		setNumber("MapID",c.toInt(""+rset.getString(2)));
		setNumber("X",c.toInt(""+rset.getString(3)));
		setNumber("Y",c.toInt(""+rset.getString(4)));

		}
		rset.close();

//	System.out.println("end load map");
	stmt.close();
return b;	
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public boolean load(Connection conS,int id,int proid) throws SQLException, IOException  {
boolean b = false;

		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from MapBackground      "+
		 "where	MapID		= '"+id+"' "+
		 "  and ProjectID   = '"+proid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
		
		System.out.println("ofen2 check 3");

		image.load(conS,c.toInt(""+rset.getString(5))); // define MapImage of MapBackground
		
		setNumber("MapID",c.toInt(""+rset.getString(2)));
		setNumber("X",c.toInt(""+rset.getString(3)));
		setNumber("Y",c.toInt(""+rset.getString(4)));

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
public boolean loadXY(Connection conS,int x,int y) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from MapBackground     "+
		 "where	X		= '"+x+"' 		  "+
		 "	and Y		= '"+y+"' 		  "+
		 "  and ProjectID   = '"+proid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		System.out.println("ofen2 check 3");

		image.load(conS,c.toInt(""+rset.getString(5))); // define MapImage of MapBackground
		
		setNumber("MapID",c.toInt(""+rset.getString(2)));
		setNumber("X",c.toInt(""+rset.getString(3)));
		setNumber("Y",c.toInt(""+rset.getString(4)));

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
public boolean loadXY(Connection conS,int x,int y,int proid) throws SQLException, IOException  {
boolean b = false;
		Statement stmt = conS.createStatement();
		System.out.println("ofen2 check 1");
		ResultSet rset = stmt.executeQuery
		("select * from MapBackground     "+
		 "where	X		= '"+x+"' 		  "+
		 "	and Y		= '"+y+"' 		  "+
		 "  and ProjectID   = '"+proid+"' ");
		
		System.out.println("ofen2 check 2");
		while (rset.next()) {
		b = true; // return true , if found
			
		System.out.println("ofen2 check 3");

		image.load(conS,c.toInt(""+rset.getString(5))); // define MapImage of MapBackground
		
		setNumber("MapID",c.toInt(""+rset.getString(2)));
		setNumber("X",c.toInt(""+rset.getString(3)));
		setNumber("Y",c.toInt(""+rset.getString(4)));

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
	stmt.execute ("delete from MapBackground	  "+
				  "where ProjectID  = '"+proid+"' "+
				  "  and MapID 		= '"+id+"'    ");
	System.out.println("mapBackground remove ok !");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void remove(Connection conS,int id,int proid) throws SQLException, IOException	{
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from MapBackground	  "+
				  "where ProjectID  = '"+proid+"' "+
				  "  and MapID 		= '"+id+"'    ");
	System.out.println("mapBackground remove ok !");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 * @param id int
 */
public void removeAll(Connection conS) throws SQLException, IOException	{
	Statement stmt = conS.createStatement();
	stmt.execute ("delete from MapBackground	  "+
				  "where ProjectID  = '"+proid+"' ");
	System.out.println("mapBackground removeAll ok !");
	stmt.close();
}
/**
 * This method was created in VisualAge.
 */
public void setMapImage(Connection conS,int imgid) throws SQLException, IOException {
//	System.out.println("MapImage update check 1");

	Statement stmtS = conS.createStatement();
	stmtS.execute("update Mapbackground set 		        "+
		          "	   MapImageID = '"+imgid+"'		  	    "+
		          "where  ProjectID   = '"+proid+"'  	and "+
		          "       MapID       = '"+MapID+"'         ");
	
	stmtS.close();
//	System.out.println("update ok!");
}
/**
 * This method was created in VisualAge.
 */
public void setMapImage(Connection conS,int imgid,int proid) throws SQLException, IOException {
	System.out.println("MapImage update check 1");

	Statement stmtS = conS.createStatement();
	stmtS.execute("update Mapbackground set 		        "+
		          "	   MapImageID = '"+imgid+"'		  	    "+
		          "where  ProjectID   = '"+proid+"'  	and "+
		          "       MapID       = '"+MapID+"'         ");
	
	stmtS.close();
	System.out.println("update ok!");
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setNumber(String st,int i) {
	if (st.equals("MapID")) {MapID = i;} else
	if (st.equals("X")) {X = i;} else
	if (st.equals("Y")) {Y = i;}	
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id) throws SQLException, IOException {
	System.out.println("ofen check 1");

	MapID = id;
	
	
	System.out.println("ofen check 3");

	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into MapBackground "+
	 "(ProjectID,MapID,X,Y)"+
	 " values "+
	 "(?,?,?,?)");
	
	System.out.println("ofen check 4");
		pstmt.setString (1,""+(Y));	 
		pstmt.setString (2,""+(proid));
		pstmt.setString (3,""+(MapID));
		pstmt.setString (4,""+(X));
		
	System.out.println("ofen check 6");

	remove(conS,id,proid);
	pstmt.execute();
	pstmt.close();
	System.out.println("add ok!");
		
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id) throws SQLException, IOException {
//	System.out.println("MapBackground update check 1");

	MapID = id;
	
	Statement stmtS = conS.createStatement();
	stmtS.execute("update MapBackground set 		     "+
		          "	   MapID = '"+id+"'		  		    ,"+
		          "	   X	   = '"+X+"'	 			,"+
		          "	   Y      = '"+Y+"'				     "+
		          "where  ProjectID   = '"+proid+"'  and "+
		          "       MapID       = '"+id+"'         ");
	
	stmtS.close();
//	System.out.println("update ok!");
}
/**
 * This method was created in VisualAge.
 */
public void update(Connection conS,int id,int proid) throws SQLException, IOException {
	System.out.println("ofen check 1");

	MapID = id;
	
	
	System.out.println("ofen check 3");

	
	PreparedStatement pstmt =conS.prepareStatement 
	("insert into MapBackground "+
	 "(ProjectID,MapID,X,Y)"+
	 " values "+
	 "(?,?,?,?)");
	
	System.out.println("ofen check 4");
		pstmt.setString (1,""+(Y));	 
		pstmt.setString (2,""+(proid));
		pstmt.setString (3,""+(MapID));
		pstmt.setString (4,""+(X));
		
	System.out.println("ofen check 6");

	remove(conS,id,proid);
	pstmt.execute();
	pstmt.close();
	System.out.println("add ok!");
		
}
/**
 * This method was created in VisualAge.
 */
public void upDate(Connection conS,int id,int proid) throws SQLException, IOException {
	System.out.println("MapBackground update check 1");

	MapID = id;
	
	Statement stmtS = conS.createStatement();
	stmtS.execute("update MapBackground set 		     "+
		          "	   MapID = '"+id+"'		  		    ,"+
		          "	   X	   = '"+X+"'	 			,"+
		          "	   Y      = '"+Y+"'				     "+
		          "where  ProjectID   = '"+proid+"'  and "+
		          "       MapID       = '"+id+"'         ");
	
	stmtS.close();
	System.out.println("update ok!");
}
}