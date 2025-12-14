
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
import java.util.Random;
import com.sun.java.swing.*;

//import com.sun.java.swing.UIManager;
public class TestLayerPanel extends JApplet {
  boolean isStandalone = false;
  JScrollPane jScrollPane1 = new JScrollPane();
  KDisplayPanel Disp = new KDisplayPanel();
  BorderLayout borderLayout1 = new BorderLayout();
  JButton jButton1 = new JButton();
  JLabel geom;
  int ly;
//Get a parameter value
  
  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }

  //Construct the applet
  
  public TestLayerPanel() {
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
    this.setSize(500,500);
    this.getContentPane().setLayout(borderLayout1);
    Disp.setPreferredSize(new Dimension(1000, 1000));
    Disp.setLayout(null);
    Disp.setMinimumSize(new Dimension(1000, 1000));
    jButton1.setText("jButton1");
    jButton1.setLabel("Add");
    jButton1.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jButton1_mouseClicked(e);
      }
    });
    this.getContentPane().add(jScrollPane1, BorderLayout.CENTER);
    jScrollPane1.getViewport().add(Disp, null);
    this.getContentPane().add(jButton1, BorderLayout.NORTH);
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

  void jButton1_mouseClicked(MouseEvent e) {
     //Disp.getGraphics().drawRect(10,10,20,50);
  }
}


