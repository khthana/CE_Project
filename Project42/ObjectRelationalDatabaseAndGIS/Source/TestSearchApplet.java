
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
//import com.sun.java.swing.*;

//import com.sun.java.swing.UIManager;
public class TestSearchApplet extends Applet {
  boolean isStandalone = false;
  TextArea txt1 = new TextArea();
  Panel panel1 = new Panel();
  TextField tX = new TextField();
  TextField tY = new TextField();
  Button button1 = new Button();
  KPoly kp ;
  Button button2 = new Button();
//Get a parameter value

  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }

  //Construct the applet

  public TestSearchApplet() {
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
    this.setLayout(null);
    this.setSize(new Dimension(413, 300));
    txt1.setBounds(new Rectangle(184, 7, 223, 168));
    txt1.setText("textArea1");
    panel1.setBackground(Color.black);
    panel1.setBounds(new Rectangle(5, 5, 172, 170));
    tX.setBounds(new Rectangle(102, 226, 84, 21));
    tX.setText("0");
    tY.setBounds(new Rectangle(102, 253, 85, 21));
    tY.setText("0");
    button1.setBounds(new Rectangle(251, 208, 68, 22));
    button1.setLabel("button1");
    button1.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        button1_mouseClicked(e);
      }
    });
    this.setSize(400,300);
    button2.setBounds(new Rectangle(251, 246, 71, 22));
    this.add(txt1, null);
    this.add(panel1, null);
    this.add(tX, null);
    this.add(tY, null);
    this.add(button1, null);
    this.add(button2, null);

    float x[] = {10,30,30,50,50,60,60,20,20,10};
    float y[] = {10,10,20,20,10,10,40,40,30,30};
    int c = 10;
    kp = new KPoly(0,x,y,c,Color.white);
    button2.setLabel("button2");
    button2.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        button2_mouseClicked(e);
      }
    });
    panel1.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        panel1_mouseClicked(e);
      }
    });
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

  void button1_mouseClicked(MouseEvent e) {
    Graphics g = panel1.getGraphics();
    g.setColor(kp.getColor());
    g.drawPolygon(kp.getX(1),kp.getY(1),kp.getCount());
  }

  void panel1_mouseClicked(MouseEvent e) {
/*    if (kp.isContainPoint(e.getX(),e.getY())){
     txt1.appendText("Wow !!!, You just click on this Area\n");
    }  else {
     txt1.appendText(" Not Good\n");
    }                                  */
  }

  void button2_mouseClicked(MouseEvent e) {

/*    if (kp.isContainPoint( Integer.parseInt(tX.getText()),Integer.parseInt(tY.getText()))){
     txt1.appendText("Wow !!!, You just click on this Area\n");
    }  else {
     txt1.appendText(" Not Good\n");
    }                                */

  }
}


