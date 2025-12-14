
//Title:       GIS
//Version:     
//Copyright:   Copyright (c) 1998
//Author:      Sakshart Ngamluan
//Company:     KMITL
//Description: Your description

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
import com.sun.java.swing.*;
import com.sun.java.swing.border.*;

//import com.sun.java.swing.UIManager;

//import com.sun.java.swing.UIManager;
public class GISViewer extends JApplet {
  boolean isStandalone = false;
  JScrollPane jScrollPane1 = new JScrollPane();
  JPanel jPanel1 = new JPanel();
  GridLayout gridLayout1 = new GridLayout();
  JButton jButton4 = new JButton();
  JLabel jLabel1 = new JLabel();
  Border br1, br2;

  Bean1 b[]= new Bean1[10];
  int counter =0;
  JButton jButton1 = new JButton();
  JButton jButton2 = new JButton();
  JButton jButton3 = new JButton();
  JButton jButton5 = new JButton();
  JScrollPane jScrollPane2 = new JScrollPane();
  JViewport port = new JViewport();
  JButton jButton6 = new JButton();
  JButton jButton7 = new JButton();
  JButton jButton8 = new JButton();
  JButton jButton9 = new JButton();
  JPanel jPanel2 = new JPanel();
  GridLayout gridLayout2 = new GridLayout();
  Bean1 bean11 = new Bean1();


  //Get a parameter value

  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }

  //Construct the applet
  
  public GISViewer() {
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
    this.getContentPane().setLayout(null);
    this.setSize(400,300);
    br1 = BorderFactory.createLineBorder(Color.green);
    br2 = BorderFactory.createLineBorder(Color.blue,10);
    jScrollPane1.setAutoscrolls(true);
    jScrollPane1.setBorder(br1);
    jScrollPane1.setBounds(new Rectangle(13, 46, 111, 193));
    jPanel1.setLayout(gridLayout1);
    jPanel1.setAutoscrolls(true);
    jPanel1.setOpaque(false);
    jPanel1.setBorder(br1);
    //jPanel1.setBounds(new Rectangle(28, 13, 500, 500));
    jPanel1.setSize(200,1000);

    jPanel2.setLayout(gridLayout2);
    gridLayout1.setRows(10);
    jButton4.setText("jButton4");
    jButton4.setLabel("Add Button");
    jButton4.setBorder(br1);
    jButton4.setBounds(new Rectangle(88, 6, 114, 31));
    jLabel1.setBounds(new Rectangle(52, 4, 171, 27));
    jButton1.setText("jButton1");
    jButton2.setText("jButton1");
    jButton3.setText("jButton1");
    jButton5.setText("jButton1");
    jScrollPane2.setViewport(port);
    jScrollPane2.setBounds(new Rectangle(138, 46, 127, 192));
    port.setView(jPanel2);
    port.setViewSize(new Dimension(500, 500));
    port.setViewPosition(new Point(10, 10));
    port.setExtentSize(new Dimension(500, 500));
    jButton6.setText("jButton1");
    jButton7.setText("jButton1");
    jButton8.setText("jButton1");
    jButton9.setText("jButton1");
    jPanel2.setBounds(new Rectangle(39, 260, 115, 69));
    gridLayout2.setRows(10);
    jButton4.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(ActionEvent e) {
        jButton4_actionPerformed(e);
      }
    });
    this.getContentPane().add(jScrollPane1, null);
    this.getContentPane().add(jButton4, null);
    this.getContentPane().add(jLabel1, null);
    this.getContentPane().add(jScrollPane2, null);
    jPanel1.add(jButton1, null);
    jPanel1.add(jButton2, null);
    jPanel1.add(jButton3, null);
    jPanel1.add(jButton5, null);
    jPanel2.add(bean11, null);
    //this.getContentPane().add(jPanel1, null);
    jScrollPane1.setViewportView(jPanel1);
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

  void jButton4_actionPerformed(ActionEvent e) {
  if (counter<10) {
    jPanel1.add(new JButton());
  /*  b[counter]= new Bean1();
    jPanel1.add(b[counter],null);
    b[counter].setLayer_name("Layer "+new Integer(counter).toString());
    counter++;

    */
    SwingUtilities.updateComponentTreeUI(jPanel1);


    }


  }
}


