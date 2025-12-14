
//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import java.awt.event.*;
import java.util.Vector;

public class KLayerPanel extends JPanel {
  BorderLayout borderLayout1 = new BorderLayout();
  JScrollPane jScrollPane1 = new JScrollPane();
  JPanel jPanel2 = new JPanel();
  GridLayout gridLayout1 = new GridLayout();
  KViewerPanel _kViewerPanel;


  public KLayerPanel(KViewerPanel kV) {
    try  {
      _kViewerPanel = kV;
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setLayout(borderLayout1);
    this.setPreferredSize(new Dimension(157, 328));
    this.setMinimumSize(new Dimension(157, 328));

    gridLayout1.setRows(20);
    jPanel2.setLayout(gridLayout1);
    this.add(jScrollPane1, BorderLayout.CENTER);
    jScrollPane1.getViewport().add(jPanel2, null);
  }
  int getLayerCount()
  {
    return this.getComponentCount();
  }
  int[] getSelectedLayer(){
     Vector v = new Vector();
     KLayerButton kLBtn;
     for (int i=0;i<jPanel2.getComponentCount();i++){
       kLBtn = (KLayerButton)jPanel2.getComponent(i);
       if (kLBtn.isSelected()){
         v.addElement(new Integer(i));
       }

     }
     int [] r = new int[v.size()];
     for (int j=0;j<v.size();j++){
       Integer It = (Integer)v.elementAt(j);
       r[j] = It.intValue();
     }
     return r;
  }
  int getOneSelectedLayer(){
     KLayerButton kLBtn;
     for (int i=0;i<jPanel2.getComponentCount();i++){
       kLBtn = (KLayerButton)jPanel2.getComponent(i);
       if (kLBtn.isSelected()){
            return i;
       }

     }
     return -1;
  }
  void addData(KLayerButton kLB){
    jPanel2.add(kLB);
    kLB.setLayerPanel(this);
    this.validateTree();
    SwingUtilities.updateComponentTreeUI(this);

  }
  int getIndexLayer(KLayerButton kLBtn){
   for (int i=0;i<jPanel2.getComponentCount();i++){
       if (kLBtn.equals((KLayerButton)jPanel2.getComponent(i))){
            return i;
       }

     }
    return -1;

  }
  void clearOneSelectedLayer(){
     if (getOneSelectedLayer()>=0){
        KLayerButton kLBtn = (KLayerButton)jPanel2.getComponent(getOneSelectedLayer());
        kLBtn.setSelected(false);
       //this.validateTree();
        //SwingUtilities.updateComponentTreeUI(this);

     }
  }
  void showRoomDescription(int layerIndex){
    _kViewerPanel.showRoomDescription(layerIndex);
  }
  void removeRoomDescription()
  {
    _kViewerPanel.removeRoomDescription();
  }
  void clearSelectedPolygon(){
    _kViewerPanel.clearSelectedPolygon();
  }
}



