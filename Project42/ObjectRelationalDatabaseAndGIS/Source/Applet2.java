
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
import java.util.*;
//import com.sun.java.swing.*;

//import com.sun.java.swing.UIManager;
public class Applet2 extends Applet {
  boolean isStandalone = false;
  KQueryBuilder kQ;

//Get a parameter value

  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }

  //Construct the applet

  public Applet2() {
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
    this.setLayout(new BorderLayout());
    this.setSize(400,300);
    Vector v = new Vector();
    for (int i=0;i<20;i++)
    {
      v.addElement(new Integer(i+1));
    }
    //kQ = new KQueryBuilder(v);
    this.add(kQ,BorderLayout.CENTER);
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


