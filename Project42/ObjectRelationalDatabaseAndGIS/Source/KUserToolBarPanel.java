
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import java.awt.event.*;
import com.sun.java.swing.border.*;


public class KUserToolBarPanel extends JPanel {
  GridLayout gridLayout1 = new GridLayout();
  JButton kObjectInfoBtn = new JButton();
  JButton kZoomInBtn = new JButton();
  JButton kZoomOutBtn = new JButton();
  JButton kObjectToTableBtn = new JButton();
  JButton kInsideBuildingBtn = new JButton();
  JButton kQueryBtn = new JButton();
  final static int ZOOMIN_TOOL = 1;
  final static int ZOOMOUT_TOOL = 2;
  final static int OBJECTINFO_TOOL = 3;
  final static int OBJECTTOTABLE_TOOL = 4;
  final static int INSIDEBUILDING_TOOL = 5;
  final static int QUERY_TOOL = 6;
  final static int OPTIONS_TOOL = 7;
  final static int EXIT_TOOL = 8;

  Border normalBorder;
  JButton kExitBtn = new JButton();
  JButton kClearBtn = new JButton();

  public KUserToolBarPanel() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    normalBorder = BorderFactory.createEtchedBorder(Color.green,Color.blue);
    KImageUtil k = KImageUtil.getImageUtil();

    this.setSize( 30,126);
    this.setMaximumSize(new Dimension(570, 68));
    this.setPreferredSize(new Dimension(570, 68));
    this.setToolTipText("ออกจากโปรแกรม");
    this.setMinimumSize(new Dimension(570, 68));
    this.setSize(new Dimension(731, 70));
    gridLayout1.setColumns(8);
    gridLayout1.setRows(0);
    gridLayout1.setHgap(1);
    kObjectInfoBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        kObjectInfoBtn_mouseClicked(e);
      }
    });
    kZoomInBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        kZoomInBtn_mouseClicked(e);
      }
    });
    kZoomOutBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        kZoomOutBtn_mouseClicked(e);
      }
    });
    kObjectToTableBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        kObjectToTableBtn_mouseClicked(e);
      }
    });
    this.setLayout(gridLayout1);
    kObjectInfoBtn.setMaximumSize(new Dimension(26, 21));
    kObjectInfoBtn.setText("Info");
    kObjectInfoBtn.setPreferredSize(new Dimension(26, 21));
    kZoomInBtn.setMaximumSize(new Dimension(26, 21));
    kZoomInBtn.setText("ZOOM IN");
    kZoomInBtn.setPreferredSize(new Dimension(26, 21));
    kZoomOutBtn.setMaximumSize(new Dimension(26, 21));
    kZoomOutBtn.setText("Zoom Out");
    kZoomOutBtn.setPreferredSize(new Dimension(26, 21));
    kObjectToTableBtn.setMaximumSize(new Dimension(26, 21));
    kObjectToTableBtn.setText("Info Table");
    kObjectToTableBtn.setPreferredSize(new Dimension(26, 21));
    kInsideBuildingBtn.setMaximumSize(new Dimension(26, 21));
    kInsideBuildingBtn.setText("Inside Building");
    kInsideBuildingBtn.setPreferredSize(new Dimension(26, 21));
    kExitBtn.setMaximumSize(new Dimension(26, 21));
    kExitBtn.setText("Exit");
    kExitBtn.setPreferredSize(new Dimension(26, 21));
    kExitBtn.setIcon(new ImageIcon(k.getImage("Exit")));
    kExitBtn.setBorder(normalBorder);
    kExitBtn.setToolTipText("ออกจากโปรแกรม");
    kExitBtn.setMinimumSize(new Dimension(26, 21));
    kClearBtn.setMaximumSize(new Dimension(26, 21));
    kClearBtn.setText("Clear");
    kClearBtn.setPreferredSize(new Dimension(26, 21));

    kClearBtn.setIcon(new ImageIcon(k.getImage("Clear")));
    kClearBtn.setBorder(normalBorder);
    kClearBtn.setToolTipText("เคลียร์วัตถุที่ถูกเลือก");
    kClearBtn.setMinimumSize(new Dimension(26, 21));
    kClearBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        kClearBtn_mouseClicked(e);
      }
    });
    kClearBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    kClearBtn.setVerticalTextPosition(AbstractButton.BOTTOM);
    kExitBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        kExitBtn_mouseClicked(e);
      }
    });

    kQueryBtn.setMaximumSize(new Dimension(26, 21));
    kQueryBtn.setText("Query");
    kQueryBtn.setPreferredSize(new Dimension(26, 21));
    this.add(kZoomInBtn, null);
    this.add(kZoomOutBtn, null);
    this.add(kObjectInfoBtn, null);
    this.add(kObjectToTableBtn, null);
    this.add(kInsideBuildingBtn, null);
    this.add(kQueryBtn, null);
    this.add(kClearBtn, null);
    this.add(kExitBtn, null);
    kObjectInfoBtn.setIcon(new ImageIcon(k.getImage("ObjectInfo")));
    kObjectInfoBtn.setBorder(normalBorder);
    kObjectInfoBtn.setToolTipText("ดูข้อมูลวัตถุเฉพาะ");
    kObjectInfoBtn.setMinimumSize(new Dimension(26, 21));
    kZoomInBtn.setIcon(new ImageIcon(k.getImage("ZoomIn")));
    kZoomInBtn.setText("Zoom In");
    kZoomInBtn.setBorder(normalBorder);
    kZoomInBtn.setToolTipText("ขยายออก");
    kZoomInBtn.setMinimumSize(new Dimension(26, 21));
    kZoomOutBtn.setIcon(new ImageIcon(k.getImage("ZoomOut")));
    kZoomOutBtn.setBorder(normalBorder);
    kZoomOutBtn.setToolTipText("ขยายเข้า");
    kZoomOutBtn.setMinimumSize(new Dimension(26, 21));
    kObjectToTableBtn.setIcon(new ImageIcon(k.getImage("ObjectToTable")));
    kObjectToTableBtn.setBorder(normalBorder);
    kObjectToTableBtn.setToolTipText("ดูข้อมูลวัตถุเฉพาะเทียบกับตาราง");
    kObjectToTableBtn.setMinimumSize(new Dimension(26, 21));
    kInsideBuildingBtn.setIcon(new ImageIcon(k.getImage("InsideBuilding")));
    kInsideBuildingBtn.setBorder(normalBorder);
    kInsideBuildingBtn.setToolTipText("เข้าไปดูข้อมูลห้องในตึก");
    kInsideBuildingBtn.setMinimumSize(new Dimension(26, 21));
    kInsideBuildingBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        kInsideBuildingBtn_mouseClicked(e);
      }
    });
    kQueryBtn.setIcon(new ImageIcon(k.getImage("Search")));
    kQueryBtn.setBorder(normalBorder);
    kQueryBtn.setToolTipText("สืบค้นข้อมูล");
    kQueryBtn.setMinimumSize(new Dimension(26, 21));

    kQueryBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        kQueryBtn_mouseClicked(e);
      }
    });

    kZoomInBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    kZoomOutBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    kObjectInfoBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    kObjectToTableBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    kInsideBuildingBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    kQueryBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    kExitBtn.setHorizontalTextPosition(AbstractButton.CENTER);

    kZoomInBtn.setVerticalTextPosition(AbstractButton.BOTTOM);
    kZoomOutBtn.setVerticalTextPosition(AbstractButton.BOTTOM);
    kObjectInfoBtn.setVerticalTextPosition(AbstractButton.BOTTOM);
    kObjectToTableBtn.setVerticalTextPosition(AbstractButton.BOTTOM);
    kInsideBuildingBtn.setVerticalTextPosition(AbstractButton.BOTTOM);
    kQueryBtn.setVerticalTextPosition(AbstractButton.BOTTOM);
    kExitBtn.setVerticalTextPosition(AbstractButton.BOTTOM);


  }
  void kObjectInfoBtn_mouseClicked(MouseEvent e) {
       KShareObject.getShareObject().setUserToolCode(OBJECTINFO_TOOL);
  }

  void kZoomInBtn_mouseClicked(MouseEvent e) {
       //KShareObject.getShareObject().setUserToolCode(ZOOMIN_TOOL);
       KViewerInternalFrame shViewer = KShareObject.getShowingInternalFrame();
       if (shViewer != null)
       if (shViewer.canZoomIn()){
          shViewer.setZoomRatio(shViewer.getZoomRatio()+shViewer.getAdjustRatioValue());
          shViewer.repaint();
       }
  }

  void kZoomOutBtn_mouseClicked(MouseEvent e) {
       //KShareObject.getShareObject().setUserToolCode(ZOOMOUT_TOOL);
       KViewerInternalFrame shViewer = KShareObject.getShowingInternalFrame();
       if (shViewer != null)
       if (shViewer.canZoomOut()){
          shViewer.setZoomRatio(shViewer.getZoomRatio()-shViewer.getAdjustRatioValue());
          shViewer.repaint();
       }

  }

  void kObjectToTableBtn_mouseClicked(MouseEvent e) {
       KShareObject.getShareObject().setUserToolCode(OBJECTTOTABLE_TOOL);
       //KViewerInternalFrame shViewer = getShowingInternalFrame();
       //if (shViewer != null){
       //     shViewer.createSummaryTable();
       //}

  }

  void kInsideBuildingBtn_mouseClicked(MouseEvent e) {
       KShareObject.getShareObject().setUserToolCode(INSIDEBUILDING_TOOL);

  }

  void kQueryBtn_mouseClicked(MouseEvent e) {
       //KShareObject.getShareObject().setUserToolCode(QUERY_TOOL);
       KViewerInternalFrame shViewer = KShareObject.getShowingInternalFrame();
       if (shViewer != null)
       {
           KViewerPanel kV = shViewer.getViewerPanel();
           if (kV.getTheme()==KViewerPanel.BUILDING_THEME)
           {
             if (kV.getOneSelectedLayer()==0)
             {
             kV.queryByBuilding();
             }
             else
             {
             kV.queryByAny();
             }

           }
           else if (kV.getTheme()==KViewerPanel.ROOM_THEME)
           {
            kV.queryByRoom();
           }

       }

  }

  void kExitBtn_mouseClicked(MouseEvent e) {
          KShareObject.exitProgram();
  }
  void kClearBtn_mouseClicked(MouseEvent e) {
       KViewerInternalFrame shViewer = KShareObject.getShowingInternalFrame();
       if (shViewer != null)
       {
           KViewerPanel kV = shViewer.getViewerPanel();
           kV.clearSelectedArea();

       }

  }
}


