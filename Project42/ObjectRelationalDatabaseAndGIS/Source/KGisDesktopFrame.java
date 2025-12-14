
//Title:      Your Product Name
//Version:
//Copyright:  Copyright (c) 1998
//Author:     Your Name
//Company:    Your Company
//Description:Your description
package KCOM;

import com.sun.java.swing.*;
import com.sun.java.swing.preview.*;
import com.sun.java.swing.event.*;
import com.sun.java.swing.text.*;
import com.sun.java.swing.border.*;
import com.sun.java.accessibility.*;

import java.awt.event.*;
import java.awt.*;
import java.util.*;
import java.io.*;
import java.net.*;

public class KGisDesktopFrame extends JFrame {

  //Construct the frame
  JLabel statusBar = new JLabel();

  KViewerPanel kMainPanel;
  KConnectionManager kConMgr;
  KShareObject kShareObject =new KShareObject();
  KImageUtil kImageUtil;
  KToolBarPanel kToolBarPanel ;
  JDesktopPane kDesktopPane = new JDesktopPane();
  int makeCount = 0;
  JInternalFrame maker;
  BorderLayout borderLayout1 = new BorderLayout();
  BorderLayout borderLayout2 = new BorderLayout();

  Color[] kColor ={Color.green,Color.blue,Color.cyan,Color.red,Color.pink,Color.yellow};
  int indexColor = 0;

  public KGisDesktopFrame() {
    enableEvents(AWTEvent.WINDOW_EVENT_MASK);
    try  {
      init();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
//Overriden so we can exit on System Close

  protected void processWindowEvent(WindowEvent e) {
    //super.processWindowEvent(e);
    if (e.getID() == WindowEvent.WINDOW_CLOSING) {
       KShareObject.exitProgram();
      //System.exit(0);
    }
  }


  public void init() {
    try {
    initImageUtil();
    kInit();
    jbInit();

    }
    catch (Exception e) {
    e.printStackTrace();
    }
  }
  public Image getImg(String pFile){
    //return getImage(getDocumentBase(),pFile);
    Toolkit tk = Toolkit.getDefaultToolkit();//this.getToolkit();
    Image image = tk.getImage(pFile);
              //while (!tk.prepareImage(image, -1, -1,this)) {
              //}
    return image;
  }
  public void kInit(){
    //kConMgr =KConnectionManager.getConnectionManager();
    kShareObject.initDesktop(this);
    kShareObject.initDesktopPane(kDesktopPane);
  }

  private void jbInit() throws Exception {
        this.setSize(600,400);
        this.getContentPane().setLayout(borderLayout2);
        kDesktopPane.setDoubleBuffered(true);
        kDesktopPane.setOpaque(false);
        //kDesktopPane.putClientProperty("JDesktopPane.dragMode", "outline");

        maker = createLoginFrame();
        kDesktopPane.add(maker,JLayeredPane.DRAG_LAYER);
        this.getContentPane().add("Center",kDesktopPane);

        kToolBarPanel = new KToolBarPanel();
        this.getContentPane().add(kToolBarPanel, BorderLayout.NORTH);
        kToolBarPanel.setVisible(false);


  }
//Start the applet
//======================== CHECK CODE CONSISTENCY=====================

  public void initImageUtil(){
    kImageUtil = KImageUtil.getImageUtil();
    //kImageUtil.putImage("DatabaseManager",getImg("DatabaseManager.gif"));
    //kImageUtil.putImage("EditMain",getImg("EditMain.gif"));
    //kImageUtil.putImage("EditRoom",getImg("EditRoom.gif"));
    kImageUtil.putImage("ZoomIn",getImg("ZoomIn.gif"));
    kImageUtil.putImage("ZoomOut",getImg("ZoomOut.gif"));
    kImageUtil.putImage("ObjectInfo",getImg("ObjectInfo.gif"));
    kImageUtil.putImage("ObjectToTable",getImg("ObjectToTable.gif"));
    kImageUtil.putImage("InsideBuilding",getImg("InsideBuilding.gif"));
    kImageUtil.putImage("Search",getImg("Search.gif"));
    kImageUtil.putImage("Options",getImg("Options.gif"));
    kImageUtil.putImage("Exit",getImg("Exit.gif"));

    kImageUtil.putImage("Windows",getImg("Windows.gif"));
    kImageUtil.putImage("Motif",getImg("Motif.gif"));
    kImageUtil.putImage("Java",getImg("Java.gif"));
    kImageUtil.putImage("About",getImg("About.gif"));
    kImageUtil.putImage("Clear",getImg("Clear.gif"));

    
    kImageUtil.putImage("NEW",getImg("New.gif"));
    kImageUtil.putImage("OPEN",getImg("Open.gif"));
    kImageUtil.putImage("SAVE",getImg("Save.gif"));
    kImageUtil.putImage("DELETE",getImg("Delete.gif"));
    kImageUtil.putImage("ADD",getImg("Add.gif"));
    kImageUtil.putImage("REMOVE",getImg("Remove.gif"));


    kImageUtil.putImage("OneWayCommunication",getImg("OneWayCommunication.gif"));
    kImageUtil.putImage("TwoWayCommunication",getImg("TwoWayCommunication.gif"));
//    kImageUtil.putImage("UserManager",getImg("UserManager.gif"));
//    kImageUtil.putImage("HorizontalRule",getImg("HorizontalRule.gif"));
//    kImageUtil.putImage("VerticalRule",getImg("VerticalRule.gif"));
    System.out.println("Load Image Completed");
  }

    public JInternalFrame createLoginFrame(){
        JInternalFrame w;
      	Container contentPane;

        w = new KLoginInternalFrame();//JInternalFrame("Login");
	      //contentPane = w.getContentPane();
        //contentPane.setLayout(new GridLayout(0, 1));
        //contentPane.add(new KLoginPanel());

    Dimension screenSize = this.getSize();
    Dimension frameSize = w.getSize();
    if (frameSize.height > screenSize.height)
      frameSize.height = screenSize.height;
    if (frameSize.width > screenSize.width)
      frameSize.width = screenSize.width;
    w.setBounds((screenSize.width - frameSize.width) / 4, (screenSize.height - frameSize.height) / 4,320,220);
    w.setVisible(true);
        w.setClosable(false);
        //w.setMaximizable(true);
        w.setResizable(false);
        w.setIconifiable(false);
        return w;

    }
    public void createFirst(){
        //KConnectionManager.setInitParam(username,password,ip);
        kInit();
        createMainMapFrame();
        kToolBarPanel.setVisible(true);
        this.getContentPane().validate();

    }
    public JInternalFrame createConnectionBar(){
        JInternalFrame w;
      	Container contentPane;
        w = new JInternalFrame("Connection..");
	      contentPane = w.getContentPane();
        contentPane.setLayout(new GridLayout(0, 1));
        contentPane.add(new KConnectionMonitorPanel());
        w.setBounds(0,0,250,100);
        w.setClosable(true);
        w.setIconifiable(true);

        return w;
    }
    public void createMainMapFrame() {
        kMainPanel= new KViewerPanel("MAIN");
        kMainPanel.setTheme(KViewerPanel.BUILDING_THEME);
        // 9 layers
        Vector mainMap = KConnectionManager.getLayerNameOfMainMap();
        KMainMapInfo  kmm= null;
        //KShareObject.showMessage("haha",Integer.toString(mainMap.size()));
        for (int i=0;i<mainMap.size();i++)
        {
        kmm = (KMainMapInfo)mainMap.elementAt(i);
        indexColor = (indexColor+1)%6;
        kMainPanel.addMainData(kmm.title,kmm.layerName,kmm.tableInfoName,kColor[indexColor]);
        kMainPanel.setLayerColor(i,kColor[indexColor]);
        }
        /*
        kMainPanel.addMainData("อาคาร","KMITL_BUILDING","BUILDING_VIEW",Color.blue);// KMITL MAIN MAP MUST BE LAYER 0(FIRST LAYER)...
        kMainPanel.addMainData("หมุดหลักถาวร","BMP","BMP_FENCE",Color.red);

        kMainPanel.addMainData("ถนนเส้นหลัก","ROAD","BUILDING_VIEW",Color.yellow);
        kMainPanel.addMainData("เส้นทางรถไฟ","RAILWAY","BUILDING_VIEW",Color.green);
        System.out.println("Load Complete");

        kMainPanel.addMainData("ถนนเส้นรอง","ROAD2","KMITL_BUILDING",Color.yellow);
        kMainPanel.addMainData("ที่จอดรถ","CAR_PARK","KMITL_BUILDING",Color.green);
        kMainPanel.addMainData("contour","CONTOUR","KMITL_BUILDING",Color.cyan);
        kMainPanel.addMainData("แนวกำแพง","FENCE_WALL","KMITL_BUILDING",Color.blue);
        kMainPanel.addMainData("สระน้ำ","WATER_LINE","KMITL_BUILDING",Color.red);
        kMainPanel.addMainData("แนวสายไฟ","ELEC_LINE","KMITL_BUILDING",Color.yellow);

        kMainPanel.setLayerColor(0,Color.blue);
        kMainPanel.setLayerColor(1,Color.red);
        kMainPanel.setLayerColor(2,Color.yellow);
        kMainPanel.setLayerColor(3,Color.green);


        kMainPanel.setLayerColor(1,Color.red);
        kMainPanel.setLayerColor(4,Color.cyan);
        kMainPanel.setLayerColor(5,Color.darkGray);
        kMainPanel.setLayerColor(6,Color.magenta);
        kMainPanel.setLayerColor(7,Color.pink);
        kMainPanel.setLayerColor(8,Color.green);
        */


        kMainPanel.setAdjustRatioValue(0.2f);
        kMainPanel.setMinZoomRatio(0.4f);
        kMainPanel.setMaxZoomRatio(3f);
        kMainPanel.setZoomRatio(0.2f);
        kMainPanel.setDisplaySize(10000,10000);
        KViewerInternalFrame w= new KViewerInternalFrame(kMainPanel);
        w.setTitle("KMITL MAP");
        w.frameTitle=w.getTitle();
        w.setClosable(false);
        w.setResizable(true);
        kDesktopPane.add(w, JLayeredPane.PALETTE_LAYER);
    }
    public void createBuildingMap(int buildingGid){

        Vector layerNames = KConnectionManager.getConnectionManager().getLayerNameOfBuilding(buildingGid);
        if (layerNames.size()>0){
            KViewerPanel building= new KViewerPanel("");
            building.setTheme(KViewerPanel.ROOM_THEME);
            String layerName;
            for (int i=0;i<layerNames.size();i++){
              layerName = (String)layerNames.elementAt(i);
              building.addData("ชั้น "+Integer.toString(i+1),layerName,i==0?true:false);

            }

            KViewerInternalFrame bf = new KViewerInternalFrame(building);

            bf.setZoomRatio(4f); // Display 4x
            bf.setTitle(KConnectionManager.getConnectionManager().getBuildingTitle(buildingGid));
            kDesktopPane.add(bf, JLayeredPane.PALETTE_LAYER);
            bf.moveToFront();
            bf.frameTitle = bf.getTitle();
        }

    }

    public void createNewMap()
    {
            KViewerPanel building= new KViewerPanel("");
            building.setTheme(KViewerPanel.NEW_THEME);
            KViewerInternalFrame bf = new KViewerInternalFrame(building);
            bf.setZoomRatio(1f); // Display 1x
            bf.setTitle("");
            kDesktopPane.add(bf, JLayeredPane.PALETTE_LAYER);
            bf.moveToFront();
            bf.frameTitle = bf.getTitle();
    }

}

