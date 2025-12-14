
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;

public class ViewerPanel extends JPanel {
  BorderLayout borderLayout1 = new BorderLayout();
  KLayerPanel kLayerPanel1 = new KLayerPanel(new KViewerPanel());
  JScrollPane jScrollPane1 = new JScrollPane();
  KDisplayScrollPane kDisplay ;

  public void setZoomRatio(float z){
    kDisplay.setZoomRatio(z);
  }
  public void addData(String layerName,String tableName){
    KPolyDepot kpd = KConnectionManager.getConnectionManager().getGraphicsQuery(tableName);
    kDisplay.addData(kpd);
    kLayerPanel1.addData(new KLayerButton(layerName,tableName,kpd));
  }
  public void addData(String layerName,String tableName,boolean visible){
    KPolyDepot kpd = KConnectionManager.getConnectionManager().getGraphicsQuery(tableName);
    kDisplay.addData(kpd);
    KLayerButton kLB1 = new KLayerButton(layerName,tableName,kpd);
    kLB1.setLayerVisible(visible);
    kLayerPanel1.addData(kLB1);
  }

  public void setLayerColor(int i,Color c){
    kDisplay.setLayerColor(i,c);
  }
  public ViewerPanel(KDisplayScrollPane k) {
    try  {
      jbInit();
      kDisplay = k;
      this.add(kDisplay, BorderLayout.CENTER);
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setLayout(borderLayout1);
    this.setPreferredSize(new Dimension(600, 330));
    this.setMinimumSize(new Dimension(600, 330));
    jScrollPane1.setPreferredSize(new Dimension(500, 500));
    jScrollPane1.setMinimumSize(new Dimension(500, 500));
    this.add(kLayerPanel1, BorderLayout.EAST);
  }
}

 
