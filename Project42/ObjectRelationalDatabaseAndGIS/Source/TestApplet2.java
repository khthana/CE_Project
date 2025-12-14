
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
public class TestApplet2 extends JApplet {

  boolean isStandalone = false;
  BorderLayout borderLayout1 = new BorderLayout();
  KPanel jPanel1 = new KPanel();
//Get a parameter value

  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }

  //Construct the applet

  public TestApplet2() {
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
    this.getContentPane().add(jPanel1, BorderLayout.CENTER);
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

class KPanel extends JPanel{
  public void paint(Graphics g){
  g.drawRect(0,0,20,300);

  }

}
