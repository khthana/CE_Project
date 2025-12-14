package DBandGUI_Management;

import DBandGUI_Management.*;
import Project_Information.*;
import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class Project_EditorTemp implements java.awt.event.ActionListener, java.awt.event.MouseListener, java.awt.event.WindowListener {
	// variable use in all part of system
	public Home[][] home;
	public MainDB mainDB = new MainDB();
	public Connection conS;
	public Project project = new Project();
	public Calculate c = new Calculate();
	public int[][] iMapArray;
	public com.sun.java.swing.JLabel[][] LMapArray;
	public int drawNumber = 0;
	public boolean canDraw = false;
	public int PressedX,ReleasedX,PressedY,ReleasedY;
	public boolean Pressed = false;
	public boolean Released = false;
	public boolean showGridB = true;
	public boolean homeManage = false;
	public int fNX,fNY;
	public int hX,hY,oType;
	private String oAddress="-";
	public int totalMap,totalHome;
	private com.sun.java.swing.JLabel ivjJLabel1 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel3 = null;
	private com.sun.java.swing.JMenu ivjJMenu1 = null;
	private com.sun.java.swing.JMenu ivjJMenu2 = null;
	private com.sun.java.swing.JMenu ivjJMenu3 = null;
	private com.sun.java.swing.JMenu ivjJMenu4 = null;
	private com.sun.java.swing.JFrame ivjFProject_Editor = null;
	private com.sun.java.swing.JMenuBar ivjFProject_EditorJMenuBar = null;
	private com.sun.java.swing.JPanel ivjJPanel2 = null;
	private java.awt.GridLayout ivjJPanel2GridLayout = null;
	private com.sun.java.swing.JLabel ivjLMainMap = null;
	private com.sun.java.swing.JPanel ivjFDrawMap = null;
	private com.sun.java.swing.JButton ivjBMap1 = null;
	private com.sun.java.swing.JButton ivjBMap10 = null;
	private com.sun.java.swing.JButton ivjBMap2 = null;
	private com.sun.java.swing.JButton ivjBMap3 = null;
	private com.sun.java.swing.JButton ivjBMap4 = null;
	private com.sun.java.swing.JButton ivjBMap5 = null;
	private com.sun.java.swing.JButton ivjBMap6 = null;
	private com.sun.java.swing.JButton ivjBMap7 = null;
	private com.sun.java.swing.JButton ivjBMap8 = null;
	private com.sun.java.swing.JButton ivjBMap9 = null;
	private com.sun.java.swing.JMenuItem ivjMIClearMap = null;
	private com.sun.java.swing.JSeparator ivjJSeparator1 = null;
	private com.sun.java.swing.JMenuItem ivjMIHideGrid = null;
	private com.sun.java.swing.JMenuItem ivjMIShowGrid = null;
	private com.sun.java.swing.JButton ivjBCancel = null;
	private com.sun.java.swing.JButton ivjBOK = null;
	private com.sun.java.swing.JDialog ivjDSetMap = null;
	private com.sun.java.swing.JPanel ivjJDialogContentPane = null;
	private com.sun.java.swing.JLabel ivjJLabel4 = null;
	private com.sun.java.swing.JLabel ivjJLabel5 = null;
	private com.sun.java.swing.JSeparator ivjJSeparator2 = null;
	private com.sun.java.swing.JMenuItem ivjMISetMap = null;
	private com.sun.java.swing.JTextField ivjTFX = null;
	private com.sun.java.swing.JTextField ivjTFY = null;
	private com.sun.java.swing.JButton ivjBMap0 = null;
	private com.sun.java.swing.JButton ivjBAddNewProject = null;
	private com.sun.java.swing.JButton ivjBUpdateProject = null;
	private com.sun.java.swing.JLabel ivjJLabel6 = null;
	private com.sun.java.swing.JLabel ivjJLabel8 = null;
	private com.sun.java.swing.JLabel ivjLSize = null;
	private com.sun.java.swing.JLabel ivjLTotalHome = null;
	private com.sun.java.swing.JLabel ivjLTotalMap = null;
	private com.sun.java.swing.JMenuItem ivjMIExit = null;
	private com.sun.java.swing.JTextField ivjTFProjectID = null;
	private com.sun.java.swing.JTextField ivjTFProjectName = null;
	private com.sun.java.swing.JButton ivjBMap11 = null;
	private com.sun.java.swing.JButton ivjBMap12 = null;
	private com.sun.java.swing.JButton ivjBBack = null;
	private com.sun.java.swing.JButton ivjBEnd = null;
	private com.sun.java.swing.JButton ivjBNext = null;
	private com.sun.java.swing.JButton ivjBOKset = null;
	private com.sun.java.swing.JDialog ivjDHomeInformation = null;
	private com.sun.java.swing.JPanel ivjJDialogContentPane1 = null;
	private com.sun.java.swing.JLabel ivjJLabel10 = null;
	private com.sun.java.swing.JLabel ivjJLabel11 = null;
	private com.sun.java.swing.JLabel ivjJLabel21 = null;
	private com.sun.java.swing.JLabel ivjJLabel31 = null;
	private com.sun.java.swing.JLabel ivjJLabel41 = null;
	private com.sun.java.swing.JLabel ivjJLabel51 = null;
	private com.sun.java.swing.JLabel ivjJLabel61 = null;
	private com.sun.java.swing.JLabel ivjJLabel7 = null;
	private com.sun.java.swing.JLabel ivjJLabel81 = null;
	private com.sun.java.swing.JLabel ivjJLabel9 = null;
	private com.sun.java.swing.JLabel ivjLImage = null;
	private com.sun.java.swing.JTextField ivjTFAddress = null;
	private com.sun.java.swing.JTextField ivjTFBathRoom = null;
	private com.sun.java.swing.JTextField ivjTFBedRoom = null;
	private com.sun.java.swing.JTextField ivjTFFloor = null;
	private com.sun.java.swing.JTextField ivjTFPrice = null;
	private com.sun.java.swing.JTextField ivjTFSpace = null;
	private com.sun.java.swing.JTextField ivjTFStatusID = null;
	private com.sun.java.swing.JTextField ivjTFStatusName = null;
	private com.sun.java.swing.JTextField ivjTFTypeID = null;
	private com.sun.java.swing.JTextField ivjTFTypeName = null;
	private com.sun.java.swing.JTextField ivjTFWidth = null;
	private com.sun.java.swing.JTextField ivjTFXY = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public Project_EditorTemp() {
	super();
	initialize();
}
/**
 * Method to handle events for the ActionListener interface.
 * @param e java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void actionPerformed(java.awt.event.ActionEvent e) {
	// user code begin {1}
	if ((e.getSource() == getMIShowGrid()) ) { // show grid
		showGrid();
	} else
	if ((e.getSource() == getMIHideGrid()) ) { // hide grid
		hideGrid();
	} else
	if ((e.getSource() == getMIClearMap()) ) { // clear map
		clearAllMap();
	} else
	
	if ((e.getSource() == getBCancel()) ) { // press cancel set map
		connEtoM1(e);
	} else
	if ((e.getSource() == getBOK()) ) { // set map
		setMapXY(c.toInt(""+(getTFX().getText())),c.toInt(""+(getTFY().getText())));
		connEtoM2(e);
	} else
	if ((e.getSource() == getBAddNewProject()) ) { // add new project to oracle database
		addNewProject();
		
	} else
	if ((e.getSource() == getTFProjectID()) ) { // load project
		loadProject();
		
	} else
	if ((e.getSource() == getTFStatusID()) ) { // load home status
		homeManageGetStatus();
		
	} else
	if ((e.getSource() == getTFTypeID()) ) { // load home type
		homeManageGetType();
		
	} else
	if ((e.getSource() == getTFAddress()) ) { // load home type
		homeManageOKset2();
		
	} else
	if ((e.getSource() == getBOKset()) ) { // save address to home
		homeManageOKset();
		
	} else
	if ((e.getSource() == getBNext()) ) { // goto next home
		homeManageNext();
		
	} else
	if ((e.getSource() == getBBack()) ) { // goto back home
		homeManageBack();
		
	} else
	if ((e.getSource() == getBUpdateProject()) ) { // update project
		updateProject();
		
	} 
	// user code end
	if ((e.getSource() == getBMap1()) ) {
		connEtoC1(e);
	}
	if ((e.getSource() == getBCancel()) ) {
		connEtoM1(e);
	}
	if ((e.getSource() == getBOK()) ) {
		connEtoM2(e);
	}
	if ((e.getSource() == getMISetMap()) ) {
		connEtoM3(e);
	}
	if ((e.getSource() == getBEnd()) ) {
		connEtoM4(e);
	}
	// user code begin {2}

	if ((e.getSource() == getBMap0()) ) { 
		drawNumber = 0;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\move.jpg"));
		} else
	if ((e.getSource() == getBMap1()) ) { 
		drawNumber = 1;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\ground.jpg"));
		} else
	if ((e.getSource() == getBMap2()) ) {
		drawNumber = 2;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));
		} else
	if ((e.getSource() == getBMap3()) ) {
		drawNumber = 3;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_side.jpg"));
		} else
	if ((e.getSource() == getBMap4()) ) {
		drawNumber = 4;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\tree.jpg"));
		} else
	if ((e.getSource() == getBMap5()) ) {
		drawNumber = 5;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\single1.jpg"));
		} else
	if ((e.getSource() == getBMap6()) ) {
		drawNumber = 6;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\single2.jpg"));
		} else
	if ((e.getSource() == getBMap7()) ) {
		drawNumber = 7;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\townhouse2.jpg"));
		} else
	if ((e.getSource() == getBMap8()) ) {
		drawNumber = 8;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\townhouse3.jpg"));
		} else
	if ((e.getSource() == getBMap9()) ) {
		drawNumber = 9;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\twin2.jpg"));
		} else
	if ((e.getSource() == getBMap10()) ) {
		drawNumber = 10;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\panit3.jpg"));
		} else
	if ((e.getSource() == getBMap11()) ) {
		drawNumber = 11;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\detail.jpg"));
		} else
	if ((e.getSource() == getBMap12()) ) {
		drawNumber = 12;
		getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\home.jpg"));
		} 
	// user code end
}

public void addNewProject() {

	project.setString("ProjectName",""+getTFProjectName().getText());
	project.setNumber("PLong",fNY*10);
	project.setNumber("PWidth",fNX*10);
	project.setString("District","-");
	project.setString("Province","Bangkok");
	project.setNumber("TotalHome",totalHome);
	project.setDate2("StartProject","1/Jan/2000");
	project.setDate2("EndProject","1/Jan/2999");
	project.setString("Status","T");
	project.setNumber("TotalMap",totalMap-totalHome);
	project.setNumber("X",fNX);
	project.setNumber("Y",fNY);
	project.setNumber("Xblock",25);
	project.setNumber("Yblock",25);
	try {
		// add project to database
  	    conS.close();
		conS = mainDB.connectServer();
		project.add2(conS);
		project.setProjectType(conS,3);
		project.load(conS,project.getNumber("ProjectID"));
		getTFProjectID().setText(""+(project.getNumber("ProjectID")));
		
		int countMapID = 0;
		int countHomeID = 0;
		for(int x=1;x<=fNX;x++)
	    for(int y=1;y<=fNY;y++) {
		    System.out.print(" add X="+x+" Y="+y);
		   if (iMapArray[x][y] == 12) {
			   // add home to database
   			  System.out.println(" * home type "+home[x][y].type.getNumber("HomeTypeID"));
		      project.home.setNumber("X",x);
		      project.home.setNumber("Y",y);
		      project.home.setString("Address",home[x][y].getString("Address"));
		      project.home.add3(conS,++countHomeID);
		      project.home.setHomeStatus(conS,home[x][y].status.getID()); 
		      project.home.setHomeType(conS,home[x][y].type.getNumber("HomeTypeID"));
	        //  project.home.setMapImage(conS,iMapArray[x][y]);
		   } else {
   		      // add map to database
   			  System.out.println(" * map");   		      
			   project.map.setNumber("X",x);
		 	   project.map.setNumber("Y",y);
			   project.map.add3(conS,++countMapID);
		       project.map.setMapImage(conS,iMapArray[x][y]);
		   }
	    }	
	}
	catch (IOException ie) {}
	catch (SQLException se) {}
}
/**
 * Comment
 */
public void bMap1_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	return;
}
/**
 * This method was created in VisualAge.
 */
public void changeAllIcon() {
boolean ro1,ro2,ro3,ro4;

	for(int x=1;x<=fNX;x++) {
	 for(int y=1;y<=fNY;y++) {
		if (iMapArray[x][y] == 2) {
			ro1 = checkMap1(iMapArray[x][y-1],2);
			ro2 = checkMap1(iMapArray[x][y+1],2);
			ro3 = checkMap1(iMapArray[x-1][y],2);
			ro4 = checkMap1(iMapArray[x+1][y],2);
			// check error 
		//	if (y == fNY) {ro2 = false;}
		//	if (x == fNX) {ro4 = false;}
if (!ro1 && !ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));} else
if (!ro1 && !ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));} else
if (!ro1 && !ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));} else
if (!ro1 && !ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));} else
if (!ro1 &&  ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\up.jpg"));} else
if (!ro1 &&  ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\northwest.jpg"));} else
if (!ro1 &&  ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\northeast.jpg"));} else
if (!ro1 &&  ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic3up.jpg"));} else
if ( ro1 && !ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\up.jpg"));} else
if ( ro1 && !ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\southwest.jpg"));} else
if ( ro1 && !ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\southeast.jpg"));} else
if ( ro1 && !ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic3down.jpg"));} else
if ( ro1 &&  ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\up.jpg"));} else
if ( ro1 &&  ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic3left.jpg"));} else
if ( ro1 &&  ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic3right.jpg"));} else
if ( ro1 &&  ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic.jpg"));}
			
		} // end if array == 2
		
		if (iMapArray[x][y] == 3) {
			ro1 = checkMap1(iMapArray[x][y-1],3);
			ro2 = checkMap1(iMapArray[x][y+1],3);
			ro3 = checkMap1(iMapArray[x-1][y],3);
			ro4 = checkMap1(iMapArray[x+1][y],3);
		//	// check error 
		//	if (y == fNY) {ro2 = false;}
		//	if (x == fNX) {ro4 = false;}
if (!ro1 && !ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_side.jpg"));} else
if (!ro1 && !ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_side.jpg"));} else
if (!ro1 && !ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_side.jpg"));} else
if (!ro1 && !ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_side.jpg"));} else
if (!ro1 &&  ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_up.jpg"));} else
if (!ro1 &&  ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_northwest.jpg"));} else
if (!ro1 &&  ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_northeast.jpg"));} else
if (!ro1 &&  ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_3up.jpg"));} else
if ( ro1 && !ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_up.jpg"));} else
if ( ro1 && !ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_southwest.jpg"));} else
if ( ro1 && !ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_southeast.jpg"));} else
if ( ro1 && !ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_3down.jpg"));} else
if ( ro1 &&  ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_up.jpg"));} else
if ( ro1 &&  ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_3left.jpg"));} else
if ( ro1 &&  ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_3right.jpg"));} else
if ( ro1 &&  ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_4.jpg"));}
			
		} // end if array == 3
		 
	 }} // end for x,y
}
/**
 * This method was created in VisualAge.
 */
public void changeAllIcon(int startX,int startY) {
boolean ro1,ro2,ro3,ro4;
int pX,pY;
pX = startX; pY = startY;
int endX,endY;
endX = startX+1; endY = startY+1;
if (startX > 1) {startX--;}
if (startY > 1) {startY--;}
if (endX < 30) {endX++;}
if (endY < 18) {endY++;}
	for(int x=startX;x<=endX;x++) {
	 for(int y=startY;y<=endY;y++) {
		 if (x == pX && y == pY)
		 switch (iMapArray[x][y]) {
			case 0:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\ground.jpg"));} break;
			case 1:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\ground.jpg"));} break;
			case 4:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\tree.jpg"));} break;
			case 5:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\single1.jpg"));} break;
			case 6:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\single2.jpg"));} break;
			case 7:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\townhouse2.jpg"));} break;
			case 8:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\townhouse3.jpg"));} break;
			case 9:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\twin2.jpg"));} break;
			case 10:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\panit3.jpg"));} break;
			case 12:{getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\home.jpg"));} break;			
		 }
		 
		// change for map == road
		if (iMapArray[x][y] == 2) {
			ro1 = checkMap1(iMapArray[x][y-1],2);
			ro2 = checkMap1(iMapArray[x][y+1],2);
			ro3 = checkMap1(iMapArray[x-1][y],2);
			ro4 = checkMap1(iMapArray[x+1][y],2);
			// check error 
		//	if (y == endY) {ro2 = false;}
		//	if (x == endX) {ro4 = false;}
if (!ro1 && !ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));} else
if (!ro1 && !ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));} else
if (!ro1 && !ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));} else
if (!ro1 && !ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));} else
if (!ro1 &&  ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\up.jpg"));} else
if (!ro1 &&  ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\northwest.jpg"));} else
if (!ro1 &&  ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\northeast.jpg"));} else
if (!ro1 &&  ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic3up.jpg"));} else
if ( ro1 && !ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\up.jpg"));} else
if ( ro1 && !ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\southwest.jpg"));} else
if ( ro1 && !ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\southeast.jpg"));} else
if ( ro1 && !ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic3down.jpg"));} else
if ( ro1 &&  ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\up.jpg"));} else
if ( ro1 &&  ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic3left.jpg"));} else
if ( ro1 &&  ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic3right.jpg"));} else
if ( ro1 &&  ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\traffic.jpg"));}
			
		} // end if array == 2
		
		// change for map == river
		if (iMapArray[x][y] == 3) {
			ro1 = checkMap1(iMapArray[x][y-1],3);
			ro2 = checkMap1(iMapArray[x][y+1],3);
			ro3 = checkMap1(iMapArray[x-1][y],3);
			ro4 = checkMap1(iMapArray[x+1][y],3);
			// check error 
		//	if (y == endY) {ro2 = false;}
		//	if (x == endX) {ro4 = false;}

if (!ro1 && !ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_side.jpg"));} else
if (!ro1 && !ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_side.jpg"));} else
if (!ro1 && !ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_side.jpg"));} else
if (!ro1 && !ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_side.jpg"));} else
if (!ro1 &&  ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_up.jpg"));} else
if (!ro1 &&  ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_northwest.jpg"));} else
if (!ro1 &&  ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_northeast.jpg"));} else
if (!ro1 &&  ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_3up.jpg"));} else
if ( ro1 && !ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_up.jpg"));} else
if ( ro1 && !ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_southwest.jpg"));} else
if ( ro1 && !ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_southeast.jpg"));} else
if ( ro1 && !ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_3down.jpg"));} else
if ( ro1 &&  ro2 && !ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_up.jpg"));} else
if ( ro1 &&  ro2 && !ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_3left.jpg"));} else
if ( ro1 &&  ro2 &&  ro3 && !ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_3right.jpg"));} else
if ( ro1 &&  ro2 &&  ro3 &&  ro4 ) {getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\river_4.jpg"));}
			
		} // end if array == 3
		 
	 }} // end for x,y
}
/**
 * Comment
 */
public void changeShowGrid(java.awt.event.ActionEvent actionEvent) {
// user code begin {1}
	if (showGridB) {
	    for(int x=1;x<=fNX;x++)
	      for(int y=1;y<=fNY;y++) {
		    getLMapArray(x,y,45+(x-1)*25,60+(y-1)*25,25,25);
		    showGridB = false; 
	    }
	}
	else {
		for(int x=1;x<=fNX;x++)
	     for(int y=1;y<=fNY;y++) {
		    getLMapArray(x,y,45+(x-1)*25,60+(y-1)*25,20,20);
		    showGridB = true;		    
		}
	}
	return;
}

public void changeSizeMap(int sx,int sy) {
	  for(int x=1;x<=fNX;x++) {
	     for(int y=1;y<=fNY;y++) {
 		 	 iMapArray[x][y] = 0;
		    // getLMapArray(x,y).disable();
	  }}
	
	 
}
/**
 * This method was created in VisualAge.
 */
public boolean checkMap1(int i1,int va) {
boolean b = false;
	if (i1 == va) {
		b = true;		
	}
return b;
}
/**
 * This method was created in VisualAge.
 */
public boolean checkMap1(int i1,int i2,int i3,int i4,int va) {
boolean b = false;
	if (i1 == va && i2 == va && i3 == va && i4 ==va) {
		b = true;		
	}
return b;
}

public void clearAllMap() {
	  for(int x=1;x<=30;x++) {
	     for(int y=1;y<=18;y++) {
 		 	 iMapArray[x][y] = 0;
 		 	 home[x][y].setString("Address","-");
		     home[x][y].status.setID(5);
		     home[x][y].type.setNumber("HomeTypeID",0);
	 		 System.out.println("set home info x="+x+" y="+y);
		     getLMapArray(x,y).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\ground.jpg"));
	  }}
	
	    totalHome = countTotalHome();
	    getLTotalHome().setText("Total Home = "+(totalHome));
	    getLTotalMap().setText("Total Map = "+(totalMap-totalHome));
	    drawNumber = 1;
	    getLMainMap().setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\ground.jpg"));
}
/**
 * connEtoC1:  (BMap1.action.actionPerformed(java.awt.event.ActionEvent) --> Project_Editor.bMap1_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC1(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.test_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC2:  (LMap.mouse.mousePressed(java.awt.event.MouseEvent) --> Project_Editor.lMap_MousePressed(Ljava.awt.event.MouseEvent;)V)
 * @param arg1 java.awt.event.MouseEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC2(java.awt.event.MouseEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.fDrawMap_MousePressed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC3:  (FDrawMap.mouse.mouseExited(java.awt.event.MouseEvent) --> Project_Editor.fDrawMap_MouseExited(Ljava.awt.event.MouseEvent;)V)
 * @param arg1 java.awt.event.MouseEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3(java.awt.event.MouseEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.fDrawMap_MouseExited(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC4:  (DHomeInformation.window.windowClosed(java.awt.event.WindowEvent) --> Project_Editor.dHomeInformation_WindowClosed(Ljava.awt.event.WindowEvent;)V)
 * @param arg1 java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC4(java.awt.event.WindowEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.dHomeInformation_WindowClosed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC6:  (FDrawMap.mouse.mouseReleased(java.awt.event.MouseEvent) --> Project_Editor.fDrawMap_MouseReleased(Ljava.awt.event.MouseEvent;)V)
 * @param arg1 java.awt.event.MouseEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC6(java.awt.event.MouseEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.fDrawMap_MouseReleased(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM1:  (BCancel.action.actionPerformed(java.awt.event.ActionEvent) --> DSetMap.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM1(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getDSetMap().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM2:  (BOK.action.actionPerformed(java.awt.event.ActionEvent) --> DSetMap.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM2(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getDSetMap().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM3:  (MISetMap.action.actionPerformed(java.awt.event.ActionEvent) --> DSetMap.show()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM3(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getDSetMap().show();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM4:  (BEnd.action.actionPerformed(java.awt.event.ActionEvent) --> DHomeInformation.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM4(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getDHomeInformation().dispose();
		// user code begin {2}
		homeManageEnd();
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * This method was created in VisualAge.
 */
public int countTotalHome() {
int count = 0;	
	for(int x=1;x<=fNX;x++) {
	 for(int y=1;y<=fNY;y++) {
		if (iMapArray[x][y] == 12 ) {
			count++;
		}
	 }}

return count;
}
/**
 * Comment
 */
public void dHomeInformation_WindowClosed(java.awt.event.WindowEvent windowEvent) {
	homeManageEnd();
}
/**
 * Comment
 */
public void dSetMap_WindowClosed(java.awt.event.WindowEvent windowEvent) {
	System.out.println("test OK");
	return;
}
/**
 * Comment
 */
public void fDrawMap_MouseClicked(java.awt.event.MouseEvent mouseEvent) {
	return;
}
/**
 * Comment
 */
public void fDrawMap_MouseDragged(java.awt.event.MouseEvent mouseEvent) {
	return;
}
/**
 * Comment
 */
public void fDrawMap_MouseExited(java.awt.event.MouseEvent mouseEvent) {
	return;
}
/**
 * Comment
 */
public void fDrawMap_MouseMotionEvents() {
	return;
}
/**
 * Comment
 */
public void fDrawMap_MousePressed(java.awt.event.MouseEvent mouseEvent) {
	return;
}
/**
 * Comment
 */
public void fDrawMap_MouseReleased(java.awt.event.MouseEvent mouseEvent) {
	return;
}
/**
 * Return the BAddNewProject property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBAddNewProject() {
	if (ivjBAddNewProject == null) {
		try {
			ivjBAddNewProject = new com.sun.java.swing.JButton();
			ivjBAddNewProject.setName("BAddNewProject");
			ivjBAddNewProject.setFont(new java.awt.Font("dialog", 1, 10));
			ivjBAddNewProject.setText("Add New Project");
			ivjBAddNewProject.setBounds(410, 12, 125, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBAddNewProject;
}
/**
 * Return the BBack property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBBack() {
	if (ivjBBack == null) {
		try {
			ivjBBack = new com.sun.java.swing.JButton();
			ivjBBack.setName("BBack");
			ivjBBack.setText("<");
			ivjBBack.setBounds(680, 30, 50, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBBack;
}
/**
 * Return the BCancel property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBCancel() {
	if (ivjBCancel == null) {
		try {
			ivjBCancel = new com.sun.java.swing.JButton();
			ivjBCancel.setName("BCancel");
			ivjBCancel.setText("Cancel");
			ivjBCancel.setBounds(179, 72, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBCancel;
}
/**
 * Return the BEnd property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBEnd() {
	if (ivjBEnd == null) {
		try {
			ivjBEnd = new com.sun.java.swing.JButton();
			ivjBEnd.setName("BEnd");
			ivjBEnd.setText("End");
			ivjBEnd.setBounds(680, 50, 105, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBEnd;
}
/**
 * Return the BMap0 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap0() {
	if (ivjBMap0 == null) {
		try {
			ivjBMap0 = new com.sun.java.swing.JButton();
			ivjBMap0.setName("BMap0");
			ivjBMap0.setText("");
			ivjBMap0.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap0.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap0.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\move.jpg"));
			ivjBMap0.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap0;
}
/**
 * Return the JToolBarButton1 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap1() {
	if (ivjBMap1 == null) {
		try {
			ivjBMap1 = new com.sun.java.swing.JButton();
			ivjBMap1.setName("BMap1");
			ivjBMap1.setText("");
			ivjBMap1.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap1.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap1.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\ground.jpg"));
			ivjBMap1.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap1;
}
/**
 * Return the JToolBarButton11 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap10() {
	if (ivjBMap10 == null) {
		try {
			ivjBMap10 = new com.sun.java.swing.JButton();
			ivjBMap10.setName("BMap10");
			ivjBMap10.setText("");
			ivjBMap10.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap10.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap10.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\panit3.jpg"));
			ivjBMap10.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap10;
}
/**
 * Return the BMap11 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap11() {
	if (ivjBMap11 == null) {
		try {
			ivjBMap11 = new com.sun.java.swing.JButton();
			ivjBMap11.setName("BMap11");
			ivjBMap11.setText("");
			ivjBMap11.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap11.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap11.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\detail.jpg"));
			ivjBMap11.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap11;
}
/**
 * Return the BMap12 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap12() {
	if (ivjBMap12 == null) {
		try {
			ivjBMap12 = new com.sun.java.swing.JButton();
			ivjBMap12.setName("BMap12");
			ivjBMap12.setText("");
			ivjBMap12.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap12.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap12.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\home.jpg"));
			ivjBMap12.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap12;
}
/**
 * Return the JToolBarButton2 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap2() {
	if (ivjBMap2 == null) {
		try {
			ivjBMap2 = new com.sun.java.swing.JButton();
			ivjBMap2.setName("BMap2");
			ivjBMap2.setText("");
			ivjBMap2.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap2.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap2.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\side.jpg"));
			ivjBMap2.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap2;
}
/**
 * Return the JToolBarButton3 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap3() {
	if (ivjBMap3 == null) {
		try {
			ivjBMap3 = new com.sun.java.swing.JButton();
			ivjBMap3.setName("BMap3");
			ivjBMap3.setText("");
			ivjBMap3.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap3.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap3.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\River_side.jpg"));
			ivjBMap3.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap3;
}
/**
 * Return the JToolBarButton4 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap4() {
	if (ivjBMap4 == null) {
		try {
			ivjBMap4 = new com.sun.java.swing.JButton();
			ivjBMap4.setName("BMap4");
			ivjBMap4.setText("");
			ivjBMap4.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap4.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap4.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\tree.jpg"));
			ivjBMap4.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap4;
}
/**
 * Return the JToolBarButton5 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap5() {
	if (ivjBMap5 == null) {
		try {
			ivjBMap5 = new com.sun.java.swing.JButton();
			ivjBMap5.setName("BMap5");
			ivjBMap5.setText("");
			ivjBMap5.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap5.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap5.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\single1.jpg"));
			ivjBMap5.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap5;
}
/**
 * Return the JToolBarButton6 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap6() {
	if (ivjBMap6 == null) {
		try {
			ivjBMap6 = new com.sun.java.swing.JButton();
			ivjBMap6.setName("BMap6");
			ivjBMap6.setText("");
			ivjBMap6.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap6.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap6.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\single2.jpg"));
			ivjBMap6.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap6;
}
/**
 * Return the JToolBarButton7 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap7() {
	if (ivjBMap7 == null) {
		try {
			ivjBMap7 = new com.sun.java.swing.JButton();
			ivjBMap7.setName("BMap7");
			ivjBMap7.setText("");
			ivjBMap7.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap7.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap7.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\townhouse2.jpg"));
			ivjBMap7.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap7;
}
/**
 * Return the JToolBarButton8 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap8() {
	if (ivjBMap8 == null) {
		try {
			ivjBMap8 = new com.sun.java.swing.JButton();
			ivjBMap8.setName("BMap8");
			ivjBMap8.setText("");
			ivjBMap8.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap8.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap8.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\townhouse3.jpg"));
			ivjBMap8.setMargin(new java.awt.Insets(0, 0, 0, 0));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap8;
}
/**
 * Return the JToolBarButton10 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBMap9() {
	if (ivjBMap9 == null) {
		try {
			ivjBMap9 = new com.sun.java.swing.JButton();
			ivjBMap9.setName("BMap9");
			ivjBMap9.setText("");
			ivjBMap9.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.CENTER);
			ivjBMap9.setVerticalTextPosition(com.sun.java.swing.SwingConstants.BOTTOM);
			ivjBMap9.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\twin2.jpg"));
			ivjBMap9.setMargin(new java.awt.Insets(0, 0, 0, 0));
			
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBMap9;
}
/**
 * Return the BNext property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBNext() {
	if (ivjBNext == null) {
		try {
			ivjBNext = new com.sun.java.swing.JButton();
			ivjBNext.setName("BNext");
			ivjBNext.setFont(new java.awt.Font("dialog", 1, 12));
			ivjBNext.setText(">");
			ivjBNext.setBounds(735, 30, 50, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBNext;
}
/**
 * Return the BOK property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBOK() {
	if (ivjBOK == null) {
		try {
			ivjBOK = new com.sun.java.swing.JButton();
			ivjBOK.setName("BOK");
			ivjBOK.setText("OK");
			ivjBOK.setBounds(57, 71, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBOK;
}
/**
 * Return the BOKset property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBOKset() {
	if (ivjBOKset == null) {
		try {
			ivjBOKset = new com.sun.java.swing.JButton();
			ivjBOKset.setName("BOKset");
			ivjBOKset.setText("OK");
			ivjBOKset.setBounds(680, 10, 105, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBOKset;
}
/**
 * Return the BUpdateProject property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBUpdateProject() {
	if (ivjBUpdateProject == null) {
		try {
			ivjBUpdateProject = new com.sun.java.swing.JButton();
			ivjBUpdateProject.setName("BUpdateProject");
			ivjBUpdateProject.setFont(new java.awt.Font("dialog", 1, 10));
			ivjBUpdateProject.setText("Update Project");
			ivjBUpdateProject.setBounds(410, 32, 125, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBUpdateProject;
}

public int getBX(int x) {
  return ((45+(x-1)*25)+ (375-(int)(fNX/2*25)));
}

public int getBY(int y) {
	return ((70+(y-1)*25))+ (225-(int)(fNY/2*25));
}
/**
 * Return the DHomeInformation property value.
 * @return com.sun.java.swing.JDialog
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JDialog getDHomeInformation() {
	if (ivjDHomeInformation == null) {
		try {
			ivjDHomeInformation = new com.sun.java.swing.JDialog();
			ivjDHomeInformation.setName("DHomeInformation");
			ivjDHomeInformation.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjDHomeInformation.setBounds(0, 0, 800, 108);
			ivjDHomeInformation.setTitle("Home Information");
			getDHomeInformation().setContentPane(getJDialogContentPane1());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjDHomeInformation;
}
/**
 * Return the DSetMap property value.
 * @return com.sun.java.swing.JDialog
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JDialog getDSetMap() {
	if (ivjDSetMap == null) {
		try {
			ivjDSetMap = new com.sun.java.swing.JDialog();
			ivjDSetMap.setName("DSetMap");
			ivjDSetMap.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjDSetMap.setBounds(232, 230, 335, 140);
			ivjDSetMap.setTitle("Set Map");
			getDSetMap().setContentPane(getJDialogContentPane());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjDSetMap;
}
/**
 * Return the JFrameContentPane property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPanel getFDrawMap() {
	if (ivjFDrawMap == null) {
		try {
			ivjFDrawMap = new com.sun.java.swing.JPanel();
			ivjFDrawMap.setName("FDrawMap");
			ivjFDrawMap.setFont(new java.awt.Font("dialog", 0, 12));
			ivjFDrawMap.setLayout(null);
			getFDrawMap().add(getJLabel1(), getJLabel1().getName());
			getFDrawMap().add(getJLabel2(), getJLabel2().getName());
			getFDrawMap().add(getJLabel3(), getJLabel3().getName());
			getFDrawMap().add(getJPanel2(), getJPanel2().getName());
			getFDrawMap().add(getLMainMap(), getLMainMap().getName());
			getFDrawMap().add(getJLabel6(), getJLabel6().getName());
			getFDrawMap().add(getLSize(), getLSize().getName());
			getFDrawMap().add(getJLabel8(), getJLabel8().getName());
			getFDrawMap().add(getLTotalHome(), getLTotalHome().getName());
			getFDrawMap().add(getLTotalMap(), getLTotalMap().getName());
			getFDrawMap().add(getTFProjectName(), getTFProjectName().getName());
			getFDrawMap().add(getTFProjectID(), getTFProjectID().getName());
			getFDrawMap().add(getBAddNewProject(), getBAddNewProject().getName());
			getFDrawMap().add(getBUpdateProject(), getBUpdateProject().getName());
			// user code begin {1}
			
			
			for(int x=1;x<=fNX;x++)
			 for(int y=1;y<=fNY;y++) {
				// getFDrawMap().add(getLMapArray(x,y, ((45+(x-1)*25)+ (375-(int)(fNX/2*25))), ((60+(y-1)*25))+ (225-(int)(fNY/2*25))), getLMapArray(x,y).getName());
				getLMapArray(x,y).setVisible(false);
				getFDrawMap().add( getLMapArray(x,y,getBX(x),getBY(y)), getLMapArray(x,y).getName() );
			 }
 			

		
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjFDrawMap;
}
/**
 * Return the FMainControl property value.
 * @return com.sun.java.swing.JFrame
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JFrame getFProject_Editor() {
	if (ivjFProject_Editor == null) {
		try {
			ivjFProject_Editor = new com.sun.java.swing.JFrame();
			ivjFProject_Editor.setName("FProject_Editor");
			ivjFProject_Editor.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjFProject_Editor.setJMenuBar(getFProject_EditorJMenuBar());
			ivjFProject_Editor.setBounds(0, 0, 800, 570);
			ivjFProject_Editor.setVisible(true);
			ivjFProject_Editor.setTitle("Project Editor");
			getFProject_Editor().setContentPane(getFDrawMap());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjFProject_Editor;
}
/**
 * Return the FProject_EditorJMenuBar property value.
 * @return com.sun.java.swing.JMenuBar
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuBar getFProject_EditorJMenuBar() {
	if (ivjFProject_EditorJMenuBar == null) {
		try {
			ivjFProject_EditorJMenuBar = new com.sun.java.swing.JMenuBar();
			ivjFProject_EditorJMenuBar.setName("FProject_EditorJMenuBar");
			ivjFProject_EditorJMenuBar.add(getJMenu1());
			ivjFProject_EditorJMenuBar.add(getJMenu2());
			ivjFProject_EditorJMenuBar.add(getJMenu3());
			ivjFProject_EditorJMenuBar.add(getJMenu4());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjFProject_EditorJMenuBar;
}
/**
 * Return the JDialogContentPane property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPanel getJDialogContentPane() {
	if (ivjJDialogContentPane == null) {
		try {
			ivjJDialogContentPane = new com.sun.java.swing.JPanel();
			ivjJDialogContentPane.setName("JDialogContentPane");
			ivjJDialogContentPane.setLayout(null);
			getJDialogContentPane().add(getJLabel4(), getJLabel4().getName());
			getJDialogContentPane().add(getJLabel5(), getJLabel5().getName());
			getJDialogContentPane().add(getBOK(), getBOK().getName());
			getJDialogContentPane().add(getBCancel(), getBCancel().getName());
			getJDialogContentPane().add(getTFX(), getTFX().getName());
			getJDialogContentPane().add(getTFY(), getTFY().getName());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJDialogContentPane;
}
/**
 * Return the JDialogContentPane1 property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPanel getJDialogContentPane1() {
	if (ivjJDialogContentPane1 == null) {
		try {
			ivjJDialogContentPane1 = new com.sun.java.swing.JPanel();
			ivjJDialogContentPane1.setName("JDialogContentPane1");
			ivjJDialogContentPane1.setLayout(null);
			getJDialogContentPane1().add(getJLabel11(), getJLabel11().getName());
			getJDialogContentPane1().add(getTFXY(), getTFXY().getName());
			getJDialogContentPane1().add(getBOKset(), getBOKset().getName());
			getJDialogContentPane1().add(getBBack(), getBBack().getName());
			getJDialogContentPane1().add(getBNext(), getBNext().getName());
			getJDialogContentPane1().add(getBEnd(), getBEnd().getName());
			getJDialogContentPane1().add(getJLabel21(), getJLabel21().getName());
			getJDialogContentPane1().add(getTFAddress(), getTFAddress().getName());
			getJDialogContentPane1().add(getJLabel31(), getJLabel31().getName());
			getJDialogContentPane1().add(getTFStatusID(), getTFStatusID().getName());
			getJDialogContentPane1().add(getTFStatusName(), getTFStatusName().getName());
			getJDialogContentPane1().add(getJLabel41(), getJLabel41().getName());
			getJDialogContentPane1().add(getTFTypeID(), getTFTypeID().getName());
			getJDialogContentPane1().add(getTFTypeName(), getTFTypeName().getName());
			getJDialogContentPane1().add(getJLabel51(), getJLabel51().getName());
			getJDialogContentPane1().add(getTFSpace(), getTFSpace().getName());
			getJDialogContentPane1().add(getJLabel61(), getJLabel61().getName());
			getJDialogContentPane1().add(getTFBedRoom(), getTFBedRoom().getName());
			getJDialogContentPane1().add(getJLabel7(), getJLabel7().getName());
			getJDialogContentPane1().add(getTFWidth(), getTFWidth().getName());
			getJDialogContentPane1().add(getJLabel81(), getJLabel81().getName());
			getJDialogContentPane1().add(getTFBathRoom(), getTFBathRoom().getName());
			getJDialogContentPane1().add(getJLabel9(), getJLabel9().getName());
			getJDialogContentPane1().add(getTFFloor(), getTFFloor().getName());
			getJDialogContentPane1().add(getJLabel10(), getJLabel10().getName());
			getJDialogContentPane1().add(getTFPrice(), getTFPrice().getName());
			getJDialogContentPane1().add(getLImage(), getLImage().getName());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJDialogContentPane1;
}
/**
 * Return the JLabel1 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel1() {
	if (ivjJLabel1 == null) {
		try {
			ivjJLabel1 = new com.sun.java.swing.JLabel();
			ivjJLabel1.setName("JLabel1");
			ivjJLabel1.setBorder(new com.sun.java.swing.plaf.metal.Flush3DBorder());
			ivjJLabel1.setText("Project Editor");
			ivjJLabel1.setForeground(new java.awt.Color(205,223,255));
			ivjJLabel1.setFont(new java.awt.Font("dialog", 1, 36));
			ivjJLabel1.setBounds(540, 5, 250, 50);
			ivjJLabel1.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel1;
}
/**
 * Return the JLabel10 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel10() {
	if (ivjJLabel10 == null) {
		try {
			ivjJLabel10 = new com.sun.java.swing.JLabel();
			ivjJLabel10.setName("JLabel10");
			ivjJLabel10.setText("Price");
			ivjJLabel10.setBounds(410, 40, 42, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel10;
}
/**
 * Return the JLabel11 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel11() {
	if (ivjJLabel11 == null) {
		try {
			ivjJLabel11 = new com.sun.java.swing.JLabel();
			ivjJLabel11.setName("JLabel11");
			ivjJLabel11.setText("Home");
			ivjJLabel11.setBounds(20, 5, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel11;
}
/**
 * Return the JLabel2 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel2() {
	if (ivjJLabel2 == null) {
		try {
			ivjJLabel2 = new com.sun.java.swing.JLabel();
			ivjJLabel2.setName("JLabel2");
			ivjJLabel2.setFont(new java.awt.Font("dialog", 1, 36));
			ivjJLabel2.setText("Project Editor");
			ivjJLabel2.setBounds(539, 4, 250, 50);
			ivjJLabel2.setForeground(new java.awt.Color(225,228,255));
			ivjJLabel2.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel2;
}
/**
 * Return the JLabel21 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel21() {
	if (ivjJLabel21 == null) {
		try {
			ivjJLabel21 = new com.sun.java.swing.JLabel();
			ivjJLabel21.setName("JLabel21");
			ivjJLabel21.setText("Address");
			ivjJLabel21.setBounds(80, 5, 51, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel21;
}
/**
 * Return the JLabel3 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel3() {
	if (ivjJLabel3 == null) {
		try {
			ivjJLabel3 = new com.sun.java.swing.JLabel();
			ivjJLabel3.setName("JLabel3");
			ivjJLabel3.setFont(new java.awt.Font("dialog", 1, 36));
			ivjJLabel3.setText("Project Editor");
			ivjJLabel3.setBounds(540, 6, 255, 50);
			ivjJLabel3.setForeground(new java.awt.Color(62,71,97));
			ivjJLabel3.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel3;
}
/**
 * Return the JLabel31 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel31() {
	if (ivjJLabel31 == null) {
		try {
			ivjJLabel31 = new com.sun.java.swing.JLabel();
			ivjJLabel31.setName("JLabel31");
			ivjJLabel31.setText("Status");
			ivjJLabel31.setBounds(200, 5, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel31;
}
/**
 * Return the JLabel4 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel4() {
	if (ivjJLabel4 == null) {
		try {
			ivjJLabel4 = new com.sun.java.swing.JLabel();
			ivjJLabel4.setName("JLabel4");
			ivjJLabel4.setText("X = ");
			ivjJLabel4.setBounds(50, 25, 35, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel4;
}
/**
 * Return the JLabel41 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel41() {
	if (ivjJLabel41 == null) {
		try {
			ivjJLabel41 = new com.sun.java.swing.JLabel();
			ivjJLabel41.setName("JLabel41");
			ivjJLabel41.setText("Type");
			ivjJLabel41.setBounds(350, 5, 34, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel41;
}
/**
 * Return the JLabel5 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel5() {
	if (ivjJLabel5 == null) {
		try {
			ivjJLabel5 = new com.sun.java.swing.JLabel();
			ivjJLabel5.setName("JLabel5");
			ivjJLabel5.setText("Y = ");
			ivjJLabel5.setBounds(170, 25, 26, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel5;
}
/**
 * Return the JLabel51 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel51() {
	if (ivjJLabel51 == null) {
		try {
			ivjJLabel51 = new com.sun.java.swing.JLabel();
			ivjJLabel51.setName("JLabel51");
			ivjJLabel51.setText("Width");
			ivjJLabel51.setBounds(20, 40, 37, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel51;
}
/**
 * Return the JLabel6 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel6() {
	if (ivjJLabel6 == null) {
		try {
			ivjJLabel6 = new com.sun.java.swing.JLabel();
			ivjJLabel6.setName("JLabel6");
			ivjJLabel6.setText("Project ID");
			ivjJLabel6.setBounds(70, 12, 66, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel6;
}
/**
 * Return the JLabel61 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel61() {
	if (ivjJLabel61 == null) {
		try {
			ivjJLabel61 = new com.sun.java.swing.JLabel();
			ivjJLabel61.setName("JLabel61");
			ivjJLabel61.setText("Space");
			ivjJLabel61.setBounds(80, 40, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel61;
}
/**
 * Return the JLabel7 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel7() {
	if (ivjJLabel7 == null) {
		try {
			ivjJLabel7 = new com.sun.java.swing.JLabel();
			ivjJLabel7.setName("JLabel7");
			ivjJLabel7.setText("BedRoom");
			ivjJLabel7.setBounds(270, 40, 65, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel7;
}
/**
 * Return the JLabel8 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel8() {
	if (ivjJLabel8 == null) {
		try {
			ivjJLabel8 = new com.sun.java.swing.JLabel();
			ivjJLabel8.setName("JLabel8");
			ivjJLabel8.setText("Name");
			ivjJLabel8.setBounds(180, 12, 38, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel8;
}
/**
 * Return the JLabel81 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel81() {
	if (ivjJLabel81 == null) {
		try {
			ivjJLabel81 = new com.sun.java.swing.JLabel();
			ivjJLabel81.setName("JLabel81");
			ivjJLabel81.setText("BathRoom");
			ivjJLabel81.setBounds(200, 40, 64, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel81;
}
/**
 * Return the JLabel9 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel9() {
	if (ivjJLabel9 == null) {
		try {
			ivjJLabel9 = new com.sun.java.swing.JLabel();
			ivjJLabel9.setName("JLabel9");
			ivjJLabel9.setText("Floor");
			ivjJLabel9.setBounds(350, 40, 37, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel9;
}
/**
 * Return the JMenu1 property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenu getJMenu1() {
	if (ivjJMenu1 == null) {
		try {
			ivjJMenu1 = new com.sun.java.swing.JMenu();
			ivjJMenu1.setName("JMenu1");
			ivjJMenu1.setText("File");
			ivjJMenu1.add(getMIExit());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenu1;
}
/**
 * Return the JMenu2 property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenu getJMenu2() {
	if (ivjJMenu2 == null) {
		try {
			ivjJMenu2 = new com.sun.java.swing.JMenu();
			ivjJMenu2.setName("JMenu2");
			ivjJMenu2.setText("Tools");
			ivjJMenu2.add(getMISetMap());
			ivjJMenu2.add(getJSeparator2());
			ivjJMenu2.add(getMIShowGrid());
			ivjJMenu2.add(getMIHideGrid());
			ivjJMenu2.add(getJSeparator1());
			ivjJMenu2.add(getMIClearMap());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenu2;
}
/**
 * Return the JMenu3 property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenu getJMenu3() {
	if (ivjJMenu3 == null) {
		try {
			ivjJMenu3 = new com.sun.java.swing.JMenu();
			ivjJMenu3.setName("JMenu3");
			ivjJMenu3.setText("Windows");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenu3;
}
/**
 * Return the JMenu4 property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenu getJMenu4() {
	if (ivjJMenu4 == null) {
		try {
			ivjJMenu4 = new com.sun.java.swing.JMenu();
			ivjJMenu4.setName("JMenu4");
			ivjJMenu4.setText("Help");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenu4;
}
/**
 * Return the JPanel2 property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPanel getJPanel2() {
	if (ivjJPanel2 == null) {
		try {
			ivjJPanel2 = new com.sun.java.swing.JPanel();
			ivjJPanel2.setName("JPanel2");
			ivjJPanel2.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJPanel2.setLayout(getJPanel2GridLayout());
			ivjJPanel2.setBackground(new java.awt.Color(204,204,204));
			ivjJPanel2.setBounds(4, 70, 35, 450);
			getJPanel2().add(getBMap0(), getBMap0().getName());
			getJPanel2().add(getBMap11(), getBMap11().getName());
			getJPanel2().add(getBMap1(), getBMap1().getName());
			getJPanel2().add(getBMap2(), getBMap2().getName());
			getJPanel2().add(getBMap3(), getBMap3().getName());
			getJPanel2().add(getBMap4(), getBMap4().getName());
			getJPanel2().add(getBMap12(), getBMap12().getName());
			getJPanel2().add(getBMap5(), getBMap5().getName());
			getJPanel2().add(getBMap6(), getBMap6().getName());
			getJPanel2().add(getBMap7(), getBMap7().getName());
			getJPanel2().add(getBMap8(), getBMap8().getName());
			getJPanel2().add(getBMap9(), getBMap9().getName());
			getJPanel2().add(getBMap10(), getBMap10().getName());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJPanel2;
}
/**
 * Return the JPanel2GridLayout property value.
 * @return java.awt.GridLayout
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private java.awt.GridLayout getJPanel2GridLayout() {
	java.awt.GridLayout ivjJPanel2GridLayout = null;
	try {
		/* Create part */
		ivjJPanel2GridLayout = new java.awt.GridLayout(14, 1);
	} catch (java.lang.Throwable ivjExc) {
		handleException(ivjExc);
	};
	return ivjJPanel2GridLayout;
}
/**
 * Return the JSeparator1 property value.
 * @return com.sun.java.swing.JSeparator
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JSeparator getJSeparator1() {
	if (ivjJSeparator1 == null) {
		try {
			ivjJSeparator1 = new com.sun.java.swing.JSeparator();
			ivjJSeparator1.setName("JSeparator1");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJSeparator1;
}
/**
 * Return the JSeparator2 property value.
 * @return com.sun.java.swing.JSeparator
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JSeparator getJSeparator2() {
	if (ivjJSeparator2 == null) {
		try {
			ivjJSeparator2 = new com.sun.java.swing.JSeparator();
			ivjJSeparator2.setName("JSeparator2");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJSeparator2;
}
/**
 * Return the LImage property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getLImage() {
	if (ivjLImage == null) {
		try {
			ivjLImage = new com.sun.java.swing.JLabel();
			ivjLImage.setName("LImage");
			ivjLImage.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\home.jpg"));
			ivjLImage.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjLImage.setText("");
			ivjLImage.setBounds(590, 10, 55, 55);
			ivjLImage.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjLImage;
}
/**
 * Return the LMap property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getLMainMap() {
	if (ivjLMainMap == null) {
		try {
			ivjLMainMap = new com.sun.java.swing.JLabel();
			ivjLMainMap.setName("LMainMap");
			ivjLMainMap.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\ground.jpg"));
			ivjLMainMap.setBorder(new com.sun.java.swing.plaf.metal.MetalInternalFrameBorder());
			ivjLMainMap.setText("");
			ivjLMainMap.setBounds(2, 10, 40, 40);
			ivjLMainMap.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjLMainMap;
}
// *************
// write by ofen
// *************
private com.sun.java.swing.JLabel getLMapArray(int x,int y) {
	if (LMapArray[x][y] == null) {
		try {
			LMapArray[x][y] = new com.sun.java.swing.JLabel();
			LMapArray[x][y].setName("LMapArray["+x+"]["+y+"]");			
			LMapArray[x][y].setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\ground.jpg"));
			LMapArray[x][y].setText("");
			LMapArray[x][y].setBounds(45, 60, 24, 24);
			LMapArray[x][y].setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return LMapArray[x][y];
}
// *************
// write by ofen
// *************
private com.sun.java.swing.JLabel getLMapArray(int x,int y,int X,int Y) {
	if (LMapArray[x][y] == null) {
		try {
			LMapArray[x][y] = new com.sun.java.swing.JLabel();
			LMapArray[x][y].setName("LMapArray["+x+"]["+y+"]");
			LMapArray[x][y].setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\ground.jpg"));
			LMapArray[x][y].setText("");
			LMapArray[x][y].setBounds(X, Y, 24, 24);
			LMapArray[x][y].setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return LMapArray[x][y];
}
// *************
// write by ofen
// *************
private com.sun.java.swing.JLabel getLMapArray(int x,int y,int X,int Y,int sx,int sy) {
			LMapArray[x][y].setBounds(X, Y, sx, sy);
	return LMapArray[x][y];
}
/**
 * Return the LSize property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getLSize() {
	if (ivjLSize == null) {
		try {
			ivjLSize = new com.sun.java.swing.JLabel();
			ivjLSize.setName("LSize");
			ivjLSize.setText("Size = [X,Y]");
			ivjLSize.setBounds(70, 32, 101, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjLSize;
}
/**
 * Return the LTotalHome property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getLTotalHome() {
	if (ivjLTotalHome == null) {
		try {
			ivjLTotalHome = new com.sun.java.swing.JLabel();
			ivjLTotalHome.setName("LTotalHome");
			ivjLTotalHome.setText("Total Home = 0");
			ivjLTotalHome.setBounds(180, 32, 116, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjLTotalHome;
}
/**
 * Return the LTotalMap property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getLTotalMap() {
	if (ivjLTotalMap == null) {
		try {
			ivjLTotalMap = new com.sun.java.swing.JLabel();
			ivjLTotalMap.setName("LTotalMap");
			ivjLTotalMap.setText("Total Map = 0");
			ivjLTotalMap.setBounds(300, 32, 106, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjLTotalMap;
}
/**
 * Return the MIClearMap property value.
 * @return com.sun.java.swing.JMenuItem
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuItem getMIClearMap() {
	if (ivjMIClearMap == null) {
		try {
			ivjMIClearMap = new com.sun.java.swing.JMenuItem();
			ivjMIClearMap.setName("MIClearMap");
			ivjMIClearMap.setText("Clear All Map");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMIClearMap;
}
/**
 * Return the MIExit property value.
 * @return com.sun.java.swing.JMenuItem
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuItem getMIExit() {
	if (ivjMIExit == null) {
		try {
			ivjMIExit = new com.sun.java.swing.JMenuItem();
			ivjMIExit.setName("MIExit");
			ivjMIExit.setText("Exit");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMIExit;
}
/**
 * Return the MIHideGrid property value.
 * @return com.sun.java.swing.JMenuItem
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuItem getMIHideGrid() {
	if (ivjMIHideGrid == null) {
		try {
			ivjMIHideGrid = new com.sun.java.swing.JMenuItem();
			ivjMIHideGrid.setName("MIHideGrid");
			ivjMIHideGrid.setText("Hide Grid");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMIHideGrid;
}
/**
 * Return the MISetMap property value.
 * @return com.sun.java.swing.JMenuItem
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuItem getMISetMap() {
	if (ivjMISetMap == null) {
		try {
			ivjMISetMap = new com.sun.java.swing.JMenuItem();
			ivjMISetMap.setName("MISetMap");
			ivjMISetMap.setText("Set Map      >");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMISetMap;
}
/**
 * Return the MIShowGrid property value.
 * @return com.sun.java.swing.JMenuItem
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuItem getMIShowGrid() {
	if (ivjMIShowGrid == null) {
		try {
			ivjMIShowGrid = new com.sun.java.swing.JMenuItem();
			ivjMIShowGrid.setName("MIShowGrid");
			ivjMIShowGrid.setText("Show Grid");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMIShowGrid;
}
/**
 * Return the TFAddress property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFAddress() {
	if (ivjTFAddress == null) {
		try {
			ivjTFAddress = new com.sun.java.swing.JTextField();
			ivjTFAddress.setName("TFAddress");
			ivjTFAddress.setBounds(80, 20, 90, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFAddress;
}
/**
 * Return the TFBathRoom property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFBathRoom() {
	if (ivjTFBathRoom == null) {
		try {
			ivjTFBathRoom = new com.sun.java.swing.JTextField();
			ivjTFBathRoom.setName("TFBathRoom");
			ivjTFBathRoom.setBounds(200, 55, 60, 15);
			ivjTFBathRoom.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFBathRoom;
}
/**
 * Return the TFBedRoom property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFBedRoom() {
	if (ivjTFBedRoom == null) {
		try {
			ivjTFBedRoom = new com.sun.java.swing.JTextField();
			ivjTFBedRoom.setName("TFBedRoom");
			ivjTFBedRoom.setBounds(270, 55, 60, 15);
			ivjTFBedRoom.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFBedRoom;
}
/**
 * Return the TFFloor property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFFloor() {
	if (ivjTFFloor == null) {
		try {
			ivjTFFloor = new com.sun.java.swing.JTextField();
			ivjTFFloor.setName("TFFloor");
			ivjTFFloor.setBounds(350, 55, 50, 15);
			ivjTFFloor.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFFloor;
}
/**
 * Return the TFPrice property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFPrice() {
	if (ivjTFPrice == null) {
		try {
			ivjTFPrice = new com.sun.java.swing.JTextField();
			ivjTFPrice.setName("TFPrice");
			ivjTFPrice.setBounds(410, 55, 100, 15);
			ivjTFPrice.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFPrice;
}
/**
 * Return the TFProjectID property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFProjectID() {
	if (ivjTFProjectID == null) {
		try {
			ivjTFProjectID = new com.sun.java.swing.JTextField();
			ivjTFProjectID.setName("TFProjectID");
			ivjTFProjectID.setText("000");
			ivjTFProjectID.setBounds(135, 12, 30, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFProjectID;
}
/**
 * Return the TFProjectName property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFProjectName() {
	if (ivjTFProjectName == null) {
		try {
			ivjTFProjectName = new com.sun.java.swing.JTextField();
			ivjTFProjectName.setName("TFProjectName");
			ivjTFProjectName.setBounds(220, 12, 179, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFProjectName;
}
/**
 * Return the TFSpace property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFSpace() {
	if (ivjTFSpace == null) {
		try {
			ivjTFSpace = new com.sun.java.swing.JTextField();
			ivjTFSpace.setName("TFSpace");
			ivjTFSpace.setBounds(80, 55, 90, 15);
			ivjTFSpace.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFSpace;
}
/**
 * Return the TFStatusID property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFStatusID() {
	if (ivjTFStatusID == null) {
		try {
			ivjTFStatusID = new com.sun.java.swing.JTextField();
			ivjTFStatusID.setName("TFStatusID");
			ivjTFStatusID.setBounds(200, 20, 20, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFStatusID;
}
/**
 * Return the TFStatusName property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFStatusName() {
	if (ivjTFStatusName == null) {
		try {
			ivjTFStatusName = new com.sun.java.swing.JTextField();
			ivjTFStatusName.setName("TFStatusName");
			ivjTFStatusName.setBounds(230, 20, 100, 15);
			ivjTFStatusName.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFStatusName;
}
/**
 * Return the TFTypeID property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFTypeID() {
	if (ivjTFTypeID == null) {
		try {
			ivjTFTypeID = new com.sun.java.swing.JTextField();
			ivjTFTypeID.setName("TFTypeID");
			ivjTFTypeID.setBounds(350, 20, 20, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFTypeID;
}
/**
 * Return the TFTypeName property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFTypeName() {
	if (ivjTFTypeName == null) {
		try {
			ivjTFTypeName = new com.sun.java.swing.JTextField();
			ivjTFTypeName.setName("TFTypeName");
			ivjTFTypeName.setBounds(380, 20, 170, 15);
			ivjTFTypeName.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFTypeName;
}
/**
 * Return the TFWidth property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFWidth() {
	if (ivjTFWidth == null) {
		try {
			ivjTFWidth = new com.sun.java.swing.JTextField();
			ivjTFWidth.setName("TFWidth");
			ivjTFWidth.setBounds(20, 55, 50, 15);
			ivjTFWidth.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFWidth;
}
/**
 * Return the JTextField1 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFX() {
	if (ivjTFX == null) {
		try {
			ivjTFX = new com.sun.java.swing.JTextField();
			ivjTFX.setName("TFX");
			ivjTFX.setBounds(80, 25, 70, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFX;
}
/**
 * Return the TFXY property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFXY() {
	if (ivjTFXY == null) {
		try {
			ivjTFXY = new com.sun.java.swing.JTextField();
			ivjTFXY.setName("TFXY");
			ivjTFXY.setBounds(20, 20, 50, 15);
			ivjTFXY.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFXY;
}
/**
 * Return the JTextField2 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFY() {
	if (ivjTFY == null) {
		try {
			ivjTFY = new com.sun.java.swing.JTextField();
			ivjTFY.setName("TFY");
			ivjTFY.setBounds(200, 25, 70, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFY;
}
/**
 * Called whenever the part throws an exception.
 * @param exception java.lang.Throwable
 */
private void handleException(Throwable exception) {

	/* Uncomment the following lines to print uncaught exceptions to stdout */
	// System.out.println("--------- UNCAUGHT EXCEPTION ---------");
	// exception.printStackTrace(System.out);
}

public void hideGrid() {
	if (showGridB) {
	    for(int x=1;x<=fNX;x++)
	      for(int y=1;y<=fNY;y++) {
		    getLMapArray(x,y,getBX(x),getBY(y),25,25);
		    showGridB = false;
	    }
	}
}

public void homeManageBack() {
	home[hX][hY].setString("Address",""+getTFAddress().getText());
	homeManageEnd2();
	for (int y=hY;y>=1;y--)
	 for(int x=fNX;x>=1;x--) {
		 if (y == hY && x >= hX) {x = hX-1;}
		 if (iMapArray[x][y] == 12) {hX = x; hY =y; x =1; y = 1;}
	 }
	//detail back
	homeManageInit2(hX,hY);
}

public void homeManageEnd() {
	setEnabledBMap(true);
	home[hX][hY].setString("Address",""+getTFAddress().getText());
	getLMapArray(hX,hY).setIcon (new com.sun.java.swing.ImageIcon
	("..\\test\\PictureAndIcon\\"+home[hX][hY].type.image.getName()+".jpg"));
	homeManage = false;
}

public void homeManageEnd2() {
	getLMapArray(hX,hY).setIcon (new com.sun.java.swing.ImageIcon
	("..\\test\\PictureAndIcon\\"+home[hX][hY].type.image.getName()+".jpg"));
}

public void homeManageGetStatus() {
		try {
		 home[hX][hY].status.load(conS,c.toInt(""+getTFStatusID().getText()));
		 getTFStatusName().setText(""+home[hX][hY].status.getName());
	}
	catch (IOException ie) {}
	catch (SQLException se) {}

}

public void homeManageGetType() {
	try {
		 home[hX][hY].type.load(conS,c.toInt(""+getTFTypeID().getText()));
		 oType = home[hX][hY].type.getNumber("HomeTypeID");
		 getTFTypeName().setText(""+home[hX][hY].type.getString("HomeTypeName"));
		 getTFWidth().setText(""+home[hX][hY].type.getNumber("Width"));
		 getTFSpace().setText(""+home[hX][hY].type.getNumber("Space"));
		 getTFFloor().setText(""+home[hX][hY].type.getNumber("Floor"));
		 getTFBedRoom().setText(""+home[hX][hY].type.getNumber("BedRoom"));
		 getTFBathRoom().setText(""+home[hX][hY].type.getNumber("BathRoom"));
		 getTFPrice().setText(""+home[hX][hY].type.getNumber("Price"));
		 
 		 getLImage().setIcon (new com.sun.java.swing.ImageIcon
		  ("..\\test\\PictureAndIcon\\"+home[hX][hY].type.image.getName()+"_big.jpg"));
	}
	catch (IOException ie) {}
	catch (SQLException se) {}

}

public void homeManageInit(int x,int y) {
	if (homeManage) {homeManageEnd2();}
	if (!homeManage) setEnabledBMap(false);
	homeManage = true;
	hX = x; hY = y;
	getLMapArray(hX,hY).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\detail.jpg"));
	getTFXY().setText("["+hX+"]["+hY+"]");
	try {
		 conS.close();
		 conS = mainDB.connectServer();
		
		 home[hX][hY].status.load(conS,home[hX][hY].status.getID());
		 getTFAddress().setText(""+home[hX][hY].getString("Address"));		 
		 getTFStatusID().setText(""+home[hX][hY].status.getID());
		 getTFStatusName().setText(""+home[hX][hY].status.getName());
		 home[hX][hY].type.load(conS,home[hX][hY].type.getNumber("HomeTypeID"));
		 getTFTypeID().setText(""+home[hX][hY].type.getNumber("HomeTypeID"));
		 getTFTypeName().setText(""+home[hX][hY].type.getString("HomeTypeName"));
		 getTFWidth().setText(""+home[hX][hY].type.getNumber("Width"));
		 getTFSpace().setText(""+home[hX][hY].type.getNumber("Space"));
		 getTFFloor().setText(""+home[hX][hY].type.getNumber("Floor"));
		 getTFBedRoom().setText(""+home[hX][hY].type.getNumber("BedRoom"));
		 getTFBathRoom().setText(""+home[hX][hY].type.getNumber("BathRoom"));
		 getTFPrice().setText(""+home[hX][hY].type.getNumber("Price"));
		 
 		 getLImage().setIcon (new com.sun.java.swing.ImageIcon
		  ("..\\test\\PictureAndIcon\\"+home[hX][hY].type.image.getName()+"_big.jpg"));
	}
	catch (IOException ie) {}
	catch (SQLException se) {}
}

public void homeManageInit2(int x,int y) {
	hX = x; hY = y;
	getLMapArray(hX,hY).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\detail.jpg"));
	getTFXY().setText("["+hX+"]["+hY+"]");
	try {
		 conS.close();
		 conS = mainDB.connectServer();
		 home[hX][hY].status.load(conS,home[hX][hY].status.getID());
		 getTFAddress().setText(""+home[hX][hY].getString("Address"));		 
		 getTFStatusID().setText(""+home[hX][hY].status.getID());
		 getTFStatusName().setText(""+home[hX][hY].status.getName());
		 home[hX][hY].type.load(conS,home[hX][hY].type.getNumber("HomeTypeID"));
		 getTFTypeID().setText(""+home[hX][hY].type.getNumber("HomeTypeID"));
		 getTFTypeName().setText(""+home[hX][hY].type.getString("HomeTypeName"));
		 getTFWidth().setText(""+home[hX][hY].type.getNumber("Width"));
		 getTFSpace().setText(""+home[hX][hY].type.getNumber("Space"));
		 getTFFloor().setText(""+home[hX][hY].type.getNumber("Floor"));
		 getTFBedRoom().setText(""+home[hX][hY].type.getNumber("BedRoom"));
		 getTFBathRoom().setText(""+home[hX][hY].type.getNumber("BathRoom"));
		 getTFPrice().setText(""+home[hX][hY].type.getNumber("Price"));
		 
 		 getLImage().setIcon (new com.sun.java.swing.ImageIcon
		  ("..\\test\\PictureAndIcon\\"+home[hX][hY].type.image.getName()+"_big.jpg"));
	}
	catch (IOException ie) {}
	catch (SQLException se) {}
}

public void homeManageInit3(int x,int y) {
	hX = x; hY = y;
	getLMapArray(hX,hY).setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\detail.jpg"));
	getTFXY().setText("["+hX+"]["+hY+"]");
	try {
		 conS.close();
		 conS = mainDB.connectServer();
		 home[hX][hY].status.load(conS,home[hX][hY].status.getID());
		 getTFAddress().setText(""+oAddress);
		 getTFStatusID().setText(""+home[hX][hY].status.getID());
		 getTFStatusName().setText(""+home[hX][hY].status.getName());
		 home[hX][hY].type.load(conS,oType);
		 getTFTypeID().setText(""+home[hX][hY].type.getNumber("HomeTypeID"));
		 getTFTypeName().setText(""+home[hX][hY].type.getString("HomeTypeName"));
		 getTFWidth().setText(""+home[hX][hY].type.getNumber("Width"));
		 getTFSpace().setText(""+home[hX][hY].type.getNumber("Space"));
		 getTFFloor().setText(""+home[hX][hY].type.getNumber("Floor"));
		 getTFBedRoom().setText(""+home[hX][hY].type.getNumber("BedRoom"));
		 getTFBathRoom().setText(""+home[hX][hY].type.getNumber("BathRoom"));
		 getTFPrice().setText(""+home[hX][hY].type.getNumber("Price"));
		 
 		 getLImage().setIcon (new com.sun.java.swing.ImageIcon
		  ("..\\test\\PictureAndIcon\\"+home[hX][hY].type.image.getName()+"_big.jpg"));
	}
	catch (IOException ie) {}
	catch (SQLException se) {}
}

public void homeManageNext() {
	home[hX][hY].setString("Address",""+getTFAddress().getText());
	homeManageEnd2();	
	for (int y=hY;y<=fNY;y++)
	 for(int x=1;x<=fNX;x++) {
		 if (y == hY && x <= hX) {x = hX+1;}
		 if (iMapArray[x][y] == 12) {hX = x; hY =y; x =fNX; y = fNY;}
	 }
	//detail next	
	homeManageInit2(hX,hY);
}

public void homeManageOKset() {
	home[hX][hY].setString("Address",""+getTFAddress().getText());
	homeManageEnd2();	
	for (int y=hY;y<=fNY;y++)
	 for(int x=1;x<=fNX;x++) {
		 if (y == hY && x <= hX) {x = hX+1;}
		 if (iMapArray[x][y] == 12) {hX = x; hY =y; x =fNX; y = fNY;}
	 }
	//detail next	
	homeManageInit3(hX,hY);
}

public void homeManageOKset2() {
	home[hX][hY].setString("Address",""+getTFAddress().getText());
	oAddress = ""+getTFAddress().getText();
	homeManageEnd2();	
	for (int y=hY;y<=fNY;y++)
	 for(int x=1;x<=fNX;x++) {
		 if (y == hY && x <= hX) {x = hX+1;}
		 if (iMapArray[x][y] == 12) {hX = x; hY =y; x =fNX; y = fNY;}
	 }
	//detail next	
	homeManageInit3(hX,hY);
}
/**
 * Initializes connections
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initConnections() {
	// user code begin {1}
	try {
	  conS = mainDB.connectServer();
	}
	catch (IOException ie) {}
	catch (SQLException se) {}
	
	
	
	
	// editor
	getTFProjectID().addActionListener(this);
	getTFStatusID().addActionListener(this);
	getTFTypeID().addActionListener(this);
	getTFAddress().addActionListener(this);
	// botton
	getBUpdateProject().addActionListener(this);
	getBAddNewProject().addActionListener(this);
	getBOKset().addActionListener(this);
	getBBack().addActionListener(this);
	getBNext().addActionListener(this);
	getBEnd().addActionListener(this);
	
	// menu item
	getMIExit().addActionListener(this);
	getMIClearMap().addActionListener(this);
	getMIShowGrid().addActionListener(this);
	getMIHideGrid().addActionListener(this);

	// toolbox
	getBMap0().addActionListener(this);
	getBMap1().addActionListener(this);
	getBMap2().addActionListener(this);
	getBMap3().addActionListener(this);
	getBMap4().addActionListener(this);
	getBMap5().addActionListener(this);
	getBMap6().addActionListener(this);
	getBMap7().addActionListener(this);
	getBMap8().addActionListener(this);
	getBMap9().addActionListener(this);
	getBMap10().addActionListener(this);
	getBMap11().addActionListener(this);
	getBMap12().addActionListener(this);
	// set variable home
	home = new Home[31][19];
	// end set
	

	for(int x=1;x<=30;x++)
	 for(int y=1;y<=18;y++) {
		getLMapArray(x,y).addMouseListener(this);
	 	home[x][y] = new Home();
	 }


	for(int x=0;x<=31;x++)
	 for(int y=0;y<=18;y++) {
	 	iMapArray[x][y] = 0;

	 }

	setMapXY(10,10);
	// user code end
	getFDrawMap().addMouseListener(this);
	getBMap1().addActionListener(this);
	getBCancel().addActionListener(this);
	getBOK().addActionListener(this);
	getMISetMap().addActionListener(this);
	getBEnd().addActionListener(this);
	getDHomeInformation().addWindowListener(this);
}
/**
 * Initialize the class.
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initialize() {
	// user code begin {1}
	fNX = 30;
	fNY = 18;
	hX = 0;
	hY = 0;
	LMapArray = new com.sun.java.swing.JLabel[32][20];
	iMapArray = new int[32][20];
	getFProject_Editor();
	getFProject_Editor().setVisible(true);
	getFProject_Editor().show();
	// user code end
	initConnections();
	// user code begin {2}
	
	// user code end
}
/**
 * Comment
 */
public void lMap_MousePressed(java.awt.event.MouseEvent mouseEvent) {
	return;
}

public void loadProject() {
	
	try {
		 conS.close();
		 conS = mainDB.connectServer();
		 project.load(conS,c.toInt(getTFProjectID().getText()));
	}
	catch(IOException ie){}
	catch(SQLException se){}
	setMapXY(project.getNumber("X"),project.getNumber("Y"));		
	getTFProjectName().setText(project.getString("ProjectName"));
//	System.out.println(""+project.getNumber("TotalHome"));
	totalHome = project.getNumber("TotalHome");
	getLTotalHome().setText("TotalHome = "+totalHome);
	getLTotalMap().setText("TotalMap = "+project.getNumber("TotalMap"));
	getLSize().setText("Size = ["+(project.getNumber("X"))+","+(project.getNumber("Y"))+"]");
	try {
		// add project to database
		int countMapID = project.getNumber("TotalMap");
		int countHomeID = totalHome;
		for(int l=1; l<=countMapID ; l++) {
		System.out.println("Load Map ID"+l);
project.map.load(conS,l);
iMapArray[project.map.getNumber("X")][project.map.getNumber("Y")]=project.map.image.getID();
changeAllIcon(project.map.getNumber("X"),project.map.getNumber("Y"));
		}
			int ox=1,oy=1;
		for(int l=1; l<=countHomeID ; l++) {
			int x,y;
			if ( l % 20 == 0 ) {
			 conS.close();
  	 	     conS = mainDB.connectServer();
			}
			project.home.load(conS,l);
			x = project.home.getNumber("X");
			y = project.home.getNumber("Y");
//			home[x][y] = project.home.copyObject();
			home[x][y].load(conS,l,project.getNumber("ProjectID"));
			System.out.println("old Load Home ID "+(l-1)+" ["+ox+"]["+oy+"] type "+home[ox][oy].type.getNumber("HomeTypeID"));			
			System.out.println("old Load Home ID "+(l-1)+" ["+ox+"]["+oy+"] image "+home[ox][oy].type.image.getID());
			System.out.println("old Load Home ID "+(l-1)+" ["+ox+"]["+oy+"] address "+home[ox][oy].getString("Address"));			
			ox = x;
			oy = y;
			System.out.println("Load Home ID "+l+" ["+x+"]["+y+"] type "+home[x][y].type.getNumber("HomeTypeID"));			
			System.out.println("Load Home ID "+l+" ["+x+"]["+y+"] image "+home[x][y].type.image.getID());
			System.out.println("Load Home ID "+l+" ["+x+"]["+y+"] address "+home[x][y].getString("Address"));			
			iMapArray[x][y]=12;
		    changeAllIcon(x,y);
			getLMapArray(x,y).setIcon (new com.sun.java.swing.ImageIcon
			("..\\test\\PictureAndIcon\\"+home[x][y].type.image.getName()+".jpg"));
		}
//		for
	}
	catch (IOException ie) {}
	catch (SQLException se) {}
//	clearAllMap();

}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		Project_Editor aProject_Editor;
		aProject_Editor = new Project_Editor();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
/**
 * Method to handle events for the MouseListener interface.
 * @param e java.awt.event.MouseEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void mouseClicked(java.awt.event.MouseEvent e) {
	// user code begin {1}
	// user code end

	
	// user code begin {2}
	
	for(int x=1;x<=fNX;x++) {
	 for(int y=1;y<=fNY;y++) {
		if (drawNumber == 11)  {
			if ((e.getSource() == getLMapArray(x,y)) && (iMapArray[x][y] == 12) ) {
				// show Dialog Home Information >>>>>
				getDHomeInformation().show();
				homeManageInit(x,y);
			}
		}
		else if ((drawNumber >= 1 && drawNumber <= 10)||drawNumber == 12)
		     if ((e.getSource() == getLMapArray(x,y)) ) {
			    iMapArray[x][y]=drawNumber;
			changeAllIcon(x,y);
			y = fNY; x = fNX;
			Pressed = false; Released = false;
		    totalHome = countTotalHome();
		    getLTotalHome().setText("Total Home = "+(totalHome));
	   		getLTotalMap().setText("Total Map = "+(totalMap-totalHome));
		} // end if drawnumber >=1 && drawnumber <=10
		
	 }} // end for x,y


		/*			switch (drawNumber) {
			  	case 1:{iMapArray[x][y]=1;}break;
		  	    case 2:{iMapArray[x][y]=2;}break;
	 		  	case 3:{iMapArray[x][y]=3;}break;
		  	    case 4:{iMapArray[x][y]=4;}break;
	 		  	case 5:{iMapArray[x][y]=5;}break;
		  	    case 6:{iMapArray[x][y]=6;}break;
		  	    case 7:{iMapArray[x][y]=7;}break;
		  	    case 8:{iMapArray[x][y]=8;}break;
		  	    case 9:{iMapArray[x][y]=9;}break;
		  	    case 10:{iMapArray[x][y]=10;}break;
			}*/


	// user code end

}
/**
 * Method to handle events for the MouseListener interface.
 * @param e java.awt.event.MouseEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void mouseEntered(java.awt.event.MouseEvent e) {
	// user code begin {1}
/*	System.out.println("Mouse Entered All");
	for(int x=1;x<=30;x++) {
	 for(int y=1;y<=18;y++) {
		if ((e.getSource() == getLMapArray(x,y)) ) {
				System.out.println("Mouse Entered in ["+x+"]["+y+"]");
			y = 18; x = 30;
		} // end if
		ivjLImage.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
		ivjLImage.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
	 }} // end for xy*/
	if (!Pressed && Released)
	
	for(int x=1;x<=fNX;x++) {
	 for(int y=1;y<=fNY;y++) {
		if ((e.getSource() == getLMapArray(x,y)) ) {
			ReleasedX = x;
			ReleasedY = y;
			if (drawNumber == 11) {
			
			} else
			if (drawNumber == 0) {
				int temp = iMapArray[ReleasedX][ReleasedY];
				iMapArray[ReleasedX][ReleasedY]=iMapArray[PressedX][PressedY];
				iMapArray[PressedX][PressedY]=temp; // input ground values to block
				changeAllIcon(PressedX,PressedY);
				changeAllIcon(ReleasedX,ReleasedY);
			}
			else
			if (ReleasedX == PressedX || ReleasedY == PressedY ) { // (0)
				if (ReleasedX == PressedX) { // (1)
					if (PressedY <= ReleasedY) { // (1).1
					  for(int yy=PressedY;yy<=ReleasedY;yy++){
						  iMapArray[PressedX][yy]=drawNumber;
						  changeAllIcon(PressedX,yy);
					  }
					} else
					if (PressedY >= ReleasedY) { // (1).2
					  for(int yy=PressedY;yy>=ReleasedY;yy--){
						  iMapArray[PressedX][yy]=drawNumber;
						  changeAllIcon(PressedX,yy);
					   }
					}
				} else // end if (1)
				if (ReleasedY == PressedY) { // (2)
					if (PressedX <= ReleasedX) { // (2).1
					  for(int xx=PressedX;xx<=ReleasedX;xx++){
						  iMapArray[xx][PressedY]=drawNumber;
						  changeAllIcon(xx,PressedY);
					  }
					} else
					if (PressedX >= ReleasedX) { // (2).2
					  for(int xx=PressedX;xx>=ReleasedX;xx--){
						  iMapArray[xx][PressedY]=drawNumber;
						  changeAllIcon(xx,PressedY);
					  }
					}
				} // end if (2)
			} // end if (0)
			else if (PressedX != ReleasedX && PressedY != ReleasedY) { //PressedXY not equals ReleasedXY
					  if (PressedX <= ReleasedX) { 
					  for(int xx=PressedX;xx<=ReleasedX;xx++){// px,py =>> rx,py
						  iMapArray[xx][PressedY]=drawNumber;
						  changeAllIcon(xx,PressedY);
					  }} else {
					  for(int xx=PressedX;xx>=ReleasedX;xx--){// px,py =>> rx,py
						  iMapArray[xx][PressedY]=drawNumber;
						  changeAllIcon(xx,PressedY);
					  }}

					  if (PressedY <= ReleasedY) { 
					  for(int yy=PressedY;yy<=ReleasedY;yy++){// rx,py =>> rx,ry
						  iMapArray[ReleasedX][yy]=drawNumber;
						  changeAllIcon(ReleasedX,yy);
					  }} else {
					  for(int yy=PressedY;yy>=ReleasedY;yy--){// rx,py =>> rx,ry
						  iMapArray[ReleasedX][yy]=drawNumber;
						  changeAllIcon(ReleasedX,yy);
					  }}

					  if (PressedY <= ReleasedY) { 
					  for(int yy=PressedY;yy<=ReleasedY;yy++){// px,py =>> px,ry
						  iMapArray[PressedX][yy]=drawNumber;
						  changeAllIcon(PressedX,yy);
					  }} else {
					  for(int yy=PressedY;yy>=ReleasedY;yy--){// px,py =>> px,ry
						  iMapArray[PressedX][yy]=drawNumber;
						  changeAllIcon(PressedX,yy);
					  }}

					  if (PressedX <= ReleasedX) { 
					  for(int xx=PressedX;xx<=ReleasedX;xx++){// px,ry =>> rx,ry
						  iMapArray[xx][ReleasedY]=drawNumber;
						  changeAllIcon(xx,ReleasedY);
					  }} else {
					  for(int xx=PressedX;xx>=ReleasedX;xx--){// px,ry =>> rx,ry
						  iMapArray[xx][ReleasedY]=drawNumber;
						  changeAllIcon(xx,ReleasedY);
					  }}
				
			}
		y = fNY; x = fNX;
	    totalHome = countTotalHome();
	    getLTotalHome().setText("Total Home = "+(totalHome));
	    getLTotalMap().setText("Total Map = "+(totalMap-totalHome));
		} // end if
	 }} // end for x,y
	
	
	Released = false;

	for(int x=1;x<=fNX;x++) {
	for(int y=1;y<=fNY;y++) {
	if (e.getSource() == getLMapArray(x,y)) {
		if (iMapArray[x][y] == 12 && drawNumber == 11) {
			getLMapArray(x,y).setCursor
			(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
		}

		if (showGridB) {
		   getLMapArray(x,y,getBX(x)+1,getBY(y)+1,22,22);
		} else {
		   getLMapArray(x,y,getBX(x)+1,getBY(y)+1,23,23);
		}
		x = fNX; y = fNY;
	}}}
	// user code end
	
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the MouseListener interface.
 * @param e java.awt.event.MouseEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void mouseExited(java.awt.event.MouseEvent e) {
	// user code begin {1}
	for(int x=1;x<=fNX;x++) {
	for(int y=1;y<=fNY;y++) {
	if (e.getSource() == getLMapArray(x,y)) {
		if (iMapArray[x][y] == 12 && drawNumber == 11) {
			getLMapArray(x,y).setCursor
			(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
		}
		if (showGridB) {
		    getLMapArray(x,y,getBX(x),getBY(y),24,24);
		} else {
		    getLMapArray(x,y,getBX(x),getBY(y),25,25);
		}
		x = fNX; y=fNY;
	}}}
	// user code end
	if ((e.getSource() == getFDrawMap()) ) {
		connEtoC3(e);
	}
	// user code begin {2}

	// user code end
}
/**
 * Method to handle events for the MouseListener interface.
 * @param e java.awt.event.MouseEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void mousePressed(java.awt.event.MouseEvent e) {
	// user code begin {1}
	for(int x=1;x<=fNX;x++) {
	 for(int y=1;y<=fNY;y++) {
		if ((e.getSource() == getLMapArray(x,y)) ) {
			Pressed = true;
			PressedX = x;
			PressedY = y;
			if (showGridB) {
		 		getLMapArray(x,y,getBX(x)+2,getBY(y)+2,20,20);
			} else {
	 			getLMapArray(x,y,getBX(x)+2,getBY(y)+2,21,21);
			}
//			iMapArray[x][y]=drawNumber;
//			changeAllIcon(x,y);
			y = fNY; x = fNX;
		} // end if
	 }} // end for xy
	
	
	// user code end
	if ((e.getSource() == getFDrawMap()) ) {
		connEtoC2(e);
	}
	// user code begin {2}
//	System.out.println(""+Pressed+" : "+PressedX+" : "+PressedY);
	// user code end
}
/**
 * Method to handle events for the MouseListener interface.
 * @param e java.awt.event.MouseEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void mouseReleased(java.awt.event.MouseEvent e) {
	// user code begin {1}
	if (Pressed)
	for(int x=1;x<=fNX;x++) {
	 for(int y=1;y<=fNY;y++) {
		if ((e.getSource() == getLMapArray(x,y)) ) {
			Pressed = false;
			Released = true;
//			iMapArray[x][y]=drawNumber; changeAllIcon(x,y);
			if (showGridB) {
			   getLMapArray(x,y,getBX(x),getBY(y),24,24);
			}else {
			   getLMapArray(x,y,getBX(x),getBY(y),25,25);
			}
			y = fNY; x = fNX;
		} // end if
	 }} // end for xy
	
	
	
/*	if ((e.getSource() == getFDrawMap()) ) {
		//connEtoC6(e);
	}*/
	// user code begin {2}
//	System.out.println(""+Pressed+" : "+ReleasedX+" : "+ReleasedY);
	// user code end
	if ((e.getSource() == getFDrawMap()) ) {
		connEtoC6(e);
	}
	// user code begin {2}
	// user code end
}

public void setEnabledBMap(boolean b) {
	getBMap0().setEnabled(b);
	getBMap1().setEnabled(b);
	getBMap2().setEnabled(b);
	getBMap3().setEnabled(b);
	getBMap4().setEnabled(b);
	getBMap5().setEnabled(b);
	getBMap6().setEnabled(b);
	getBMap7().setEnabled(b);
	getBMap8().setEnabled(b);
	getBMap9().setEnabled(b);
	getBMap10().setEnabled(b);
//  getBMap11() don't care
	getBMap12().setEnabled(b);

}
/**
 * This method was created in VisualAge.
 * @param x int
 * @param y int
 */
public void setMapXY(int mX,int mY) {
	for(int x=1;x<=fNX;x++)
	 for(int y=1;y<=fNY;y++) {
		 getLMapArray(x,y).setVisible(false);
		 getFDrawMap().remove(getLMapArray(x,y));
	 }	
	fNX = mX;
	fNY = mY;
	
   if (fNX > 30) fNX = 30;
   if (fNY > 18) fNY = 18;
   
   for(int x=1;x<=fNX;x++)
	for(int y=1;y<=fNY;y++) {
	   getFDrawMap().add(getLMapArray(x,y,getBX(x),getBY(y)), getLMapArray(x,y).getName() );
	   if (iMapArray[x][y] != 5) {
		 // reset home info
	     home[x][y].setString("Address","-");
	     home[x][y].status.setID(5);
	     home[x][y].type.setNumber("HomeTypeID",0);
	     System.out.println("set home info x="+x+" y="+y);
	   }
//	   System.out.print(" Add="+home[x][y].getString("Address"));
//	   System.out.print(" Status="+home[x][y].status.getID());
//	   System.out.print(" Type="+home[x][y].type.getNumber("HomeTypeID"));
//	   System.out.println(" Image="+home[x][y].type.image.getID());
	  // home[x][y].status.setString("Address","");
	   
   }
	
	for(int x=1;x<=fNX;x++) {
	for(int y=1;y<=fNY;y++) {
		if (showGridB) {
		    getLMapArray(x,y,getBX(x),getBY(y),24,24);
		    getLMapArray(x,y).setVisible(true);
		} else {
		    getLMapArray(x,y,getBX(x),getBY(y),25,25);
		    getLMapArray(x,y).setVisible(true);
		}
		
	}}
//	clearAllMap();
//	changeAllIcon();
	
   totalHome = countTotalHome();
   getLTotalHome().setText("Total Home = "+(totalHome));
   totalMap = fNX * fNY;
   
   getLSize().setText("Size = ["+fNX+","+fNY+"]");
   getLTotalMap().setText("Total Map = "+(totalMap-totalHome));
   
}

public void showGrid() {
	if (!showGridB) {
		for(int x=1;x<=fNX;x++)
	     for(int y=1;y<=fNY;y++) {
		    getLMapArray(x,y,getBX(x),getBY(y),24,24);
		    showGridB = true;		    
		}
	}
	 
}
/**
 * Comment
 */
public void test_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	return;
}

public void updateProject() {

	project.setString("ProjectName",""+getTFProjectName().getText());
	project.setNumber("PLong",fNY*10);
	project.setNumber("PWidth",fNX*10);
	project.setString("District","-");
	project.setString("Province","Bangkok");
	project.setNumber("TotalHome",totalHome);
	project.setDate2("StartProject","1/Jan/2000");
	project.setDate2("EndProject","1/Jan/2999");
	project.setString("Status","T");
	project.setNumber("TotalMap",totalMap-totalHome);
	project.setNumber("X",fNX);
	project.setNumber("Y",fNY);
	project.setNumber("Xblock",25);
	project.setNumber("Yblock",25);
	try {
		// add project to database
  	    conS.close();
		conS = mainDB.connectServer();
	//	System.out.println("Start update");
		project.upDate(conS,c.toInt(""+getTFProjectID().getText()));
		project.setProjectType(conS,3);
		project.load(conS,project.getNumber("ProjectID"));
		getTFProjectID().setText(""+(project.getNumber("ProjectID")));
		project.map.removeAll(conS);
		project.home.removeAll(conS);
			   
		int countMapID = 0;
		int countHomeID = 0;
		for(int x=1;x<=fNX;x++)
	    for(int y=1;y<=fNY;y++) {
		    System.out.print(" update X="+x+" Y="+y);
		   if (iMapArray[x][y] == 12) {
			   // add home to database
	 	      System.out.println(" * home type "+home[x][y].type.getNumber("HomeTypeID"));
		      project.home.setNumber("X",x);
		      project.home.setNumber("Y",y);
		      project.home.setString("Address",home[x][y].getString("Address"));
		      project.home.add3(conS,++countHomeID);
		      project.home.setHomeStatus(conS,home[x][y].status.getID()); 
		      project.home.setHomeType(conS,home[x][y].type.getNumber("HomeTypeID"));
	        //  project.home.setMapImage(conS,iMapArray[x][y]);
		   } else {
   		      // add map to database
 			  System.out.println(" * map");
			   project.map.setNumber("X",x);
		 	   project.map.setNumber("Y",y);
			   project.map.add3(conS,++countMapID);
		       project.map.setMapImage(conS,iMapArray[x][y]);
		   }
	    }	
	}
	catch (IOException ie) {}
	catch (SQLException se) {}
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowActivated(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowClosed(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	if ((e.getSource() == getDHomeInformation()) ) {
		connEtoC4(e);
	}
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowClosing(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowDeactivated(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowDeiconified(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowIconified(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowOpened(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
}