
//Title:       Your Product Name
//Version:     
//Copyright:   Copyright (c) 1998
//Author:      Your Name
//Company:     Your Company
//Description: Your description
package KCOM;

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import com.sun.java.swing.*;

//import com.sun.java.swing.UIManager;
public class KDisplayApplet extends JApplet {
  boolean isStandalone = false;
  BorderLayout borderLayout1 = new BorderLayout();
  KDisplayScrollPane jPanel1;
  KConnectionManager kc;

//Get a parameter value

  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }

  //Construct the applet

  public KDisplayApplet() {
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
  //static {
  //  try {
  //    //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.metal.MetalLookAndFeel());
  //    //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.motif.MotifLookAndFeel());
  //    UIManager.setLookAndFeel(new com.sun.java.swing.plaf.windows.WindowsLookAndFeel());
  //  }
  //  catch (Exception e) {}
  //}
//Component initialization

  private void jbInit() throws Exception {
    this.getContentPane().setLayout(borderLayout1);
    this.setSize(500,500);
    kc =KConnectionManager.getConnectionManager();
    KPolyDepot kpd = kc.getGraphicsQuery("engineer_b2_fence");
//    JLabel L1 = new JLabel(new ImageIcon(getImage(getDocumentBase(),"HorizontalRule.gif")));
//    JLabel L2 = new JLabel(new ImageIcon(getImage(getDocumentBase(),"VerticalRule.gif")));
    JLabel L1 = new JLabel(new ImageIcon(createImage(1500,20)));
    JLabel L2 = new JLabel(new ImageIcon(createImage(20,1500)));
    //jPanel1 = new KDisplayScrollPane(L2,L1);
    jPanel1.setZoomRatio(1f);
    this.getContentPane().add(jPanel1, BorderLayout.CENTER);
    Image d;

  }
//Start the applet

  public void start() {
  }
//Stop the applet

  public void stop() {
  }
//Destroy the applet
  
  public void destroy() {
  }
//Get Applet information
  
  public String getAppletInfo() {
    return "Applet Information";
  }
//Get parameter info
  
  public String[][] getParameterInfo() {
    return null;
  }
}

 
