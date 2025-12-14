
//Title:       Your Product Name
//Version:
//Copyright:   Copyright (c) 1998
//Author:      Sakshart Ngamluan
//Company:     KMITL
//Description: Your description
package KCOM;

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import java.util.Vector;
import com.sun.java.swing.*;
import com.sun.java.accessibility.*;

//import com.sun.java.swing.UIManager;
public class KMainDisplayScrollPane extends JPanel {

  BorderLayout borderLayout1 = new BorderLayout();
  KPolyDepot Data ;
  JScrollPane jScrollPane1 = new JScrollPane();
  KMainDisplayPanel jPanel1 ;

  //Get a parameter value


  public KMainDisplayScrollPane(JLabel V,JLabel H) {

    jPanel1= new KMainDisplayPanel();
    init();
    jScrollPane1.setRowHeaderView(V);
    jScrollPane1.setColumnHeaderView(H);

  }
//Initialize the applet

  public void init() {
    try {
    jbInit();
    }
    catch (Exception e) {
    e.printStackTrace();
    }
  }
  private void jbInit() throws Exception {
    this.setLayout(borderLayout1);
    this.setSize(400,300);
    jPanel1.setPreferredSize(new Dimension(2500,1600));
    jPanel1.setBackground(Color.black);

    this.add(jScrollPane1, BorderLayout.CENTER);
    jScrollPane1.getViewport().add(jPanel1, null);

  }
  public void addData(KPolyDepot kpd){
    jPanel1.addData(kpd);
  }
  public void setLayerColor(int i,Color c){
    jPanel1.setDataElementColor(i,c);
  }
  public void setZoomRatio(float z){
    jPanel1.setZoomRatio(z);
  }
  public float getZoomRatio(){
    return(jPanel1.getZoomRatio());
  }

  /*
  void jPanel1_mouseClicked(MouseEvent e) {
  Float x= new Float(e.getX()/jPanel1.getZoomRatio());
  Float y= new Float(e.getY()/jPanel1.getZoomRatio());
    //kConMgr.getFenceGid("engineer_b2",x.intValue(),y.intValue());

  }
  */

}

