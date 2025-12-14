
//Title:       GIS
//Version:     
//Copyright:   Copyright (c) 1998
//Author:      Sakshart Ngamluan
//Company:     KMITL
//Description: Your description

//Title:        GIS
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

package KCOM;

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import com.sun.java.swing.*;


 import com.sun.java.swing.UIManager;
public class KBar extends JApplet {
  boolean isStandalone = false;
  JScrollPane jScrollPane1 = new JScrollPane();
  JPanel jPanel1 = new JPanel();
  GridLayout gridLayout1 = new GridLayout();
  JButton jButton1 = new JButton();
  Bean1 b[]= new Bean1[10];
  int counter =0;
  JLabel jLabel1 = new JLabel();
  JPopupMenu jPopupMenu1 = new JPopupMenu();
  JMenuItem jMenuItem1 = new JMenuItem();
  JMenuItem jMenuItem2 = new JMenuItem();
  JMenuItem jMenuItem3 = new JMenuItem();
  JMenuBar jMenuBar1 = new JMenuBar();
  JMenu jMenu1 = new JMenu();
  JMenuItem jMenuItem4 = new JMenuItem();
  JMenuItem jMenuItem5 = new JMenuItem();
  JMenuItem jMenuItem6 = new JMenuItem();
  JButton jButton2 = new JButton();
  Bean1 bean11 = new Bean1();
//Get a parameter value

  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }

  //Construct the applet

  public KBar() {
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
  static {
    try {
  //    //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.metal.MetalLookAndFeel());
        UIManager.setLookAndFeel(new com.sun.java.swing.plaf.motif.MotifLookAndFeel());
  //    UIManager.setLookAndFeel(new com.sun.java.swing.plaf.windows.WindowsLookAndFeel());
    }
    catch (Exception e) {}
  }
//Component initialization

  private void jbInit() throws Exception {
    this.getContentPane().setLayout(null);
    this.setSize(500,500);
    //jPanel1.setSize(180,1000);
    this.setJMenuBar(jMenuBar1);
    jScrollPane1.setBounds(new Rectangle(44, 26, 145, 200));
    jPanel1.setLayout(gridLayout1);
    jPanel1.setBounds(new Rectangle(28, 13, 221, 1000));

    gridLayout1.setRows(10);

    jButton1.setText("add Layer");
    jButton1.setToolTipText("add dynamic layer");

    jButton1.setBounds(new Rectangle(53, 252, 126, 23));
    jLabel1.setBounds(new Rectangle(75, 222, 79, 14));
    jPopupMenu1.setInvoker(jPanel1);
    jPopupMenu1.setLabel("Hello");
    jMenuItem1.setLabel("Motiff");



    jMenuItem1.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jMenuItem1_mouseClicked(e);
      }
    });
    jMenuItem2.setLabel("Java");
    jMenuItem2.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jMenuItem2_mouseClicked(e);
      }
    });
    jMenuItem3.setLabel("Windows");
    jMenu1.setText("Look");
    jMenuItem4.setText("Windows");
    jMenuItem4.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jMenuItem4_mouseClicked(e);
      }
    });
    jMenuItem5.setText("Motiff");
    jMenuItem5.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jMenuItem5_mouseClicked(e);
      }
    });
    jMenuItem6.setText("Java");
    jButton2.setText("jButton2");
    jButton2.setLabel("del Layer");
    jButton2.setToolTipText("delete layer");
    jButton2.setBounds(new Rectangle(54, 279, 126, 24));
    jButton2.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(ActionEvent e) {
        jButton2_actionPerformed(e);
      }
    });
    jMenuItem6.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jMenuItem6_mouseClicked(e);
      }
    });
    jMenuItem3.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jMenuItem3_mouseClicked(e);
      }
    });
    jButton1.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(ActionEvent e) {
        jButton1_actionPerformed(e);
      }
    });
    this.getContentPane().add(jScrollPane1, null);
    this.getContentPane().add(jButton1, null);
    this.getContentPane().add(jLabel1, null);
    this.getContentPane().add(jButton2, null);
    //this.getContentPane().add(jPanel1, null);
    jPopupMenu1.add(jMenuItem2);
    jPopupMenu1.add(jMenuItem1);
    jPopupMenu1.add(jMenuItem3);
    jMenuBar1.add(jMenu1);
    jMenu1.add(jMenuItem6);
    jMenu1.add(jMenuItem4);
    jMenu1.add(jMenuItem5);
    jPanel1.add(bean11, null);

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

  void jButton1_actionPerformed(ActionEvent e) {
    if (counter<10) {
    b[counter]= new Bean1();
    jPanel1.add(b[counter],null);
    b[counter].setLayer_name("Layer "+new Integer(counter).toString());
    counter++;


    SwingUtilities.updateComponentTreeUI(jPanel1);


    }

  }

  void jMenuItem2_mouseClicked(MouseEvent e) {
  try {

    UIManager.setLookAndFeel(new com.sun.java.swing.plaf.metal.MetalLookAndFeel());
       }
       catch(Exception ex){;}


  }

  void jMenuItem1_mouseClicked(MouseEvent e) {
   try {
    UIManager.setLookAndFeel(new com.sun.java.swing.plaf.motif.MotifLookAndFeel());
       }
       catch(Exception ex){;}

  }

  void jMenuItem3_mouseClicked(MouseEvent e) {
   try {
      UIManager.setLookAndFeel(new com.sun.java.swing.plaf.windows.WindowsLookAndFeel());
       }
       catch(Exception ex){;}

  }

  void jMenuItem6_mouseClicked(MouseEvent e) {
  try {

    UIManager.setLookAndFeel(new com.sun.java.swing.plaf.metal.MetalLookAndFeel());
       }
       catch(Exception ex){;}


  }

  void jMenuItem4_mouseClicked(MouseEvent e) {
  try {
    UIManager.setLookAndFeel(new com.sun.java.swing.plaf.motif.MotifLookAndFeel());
       }
       catch(Exception ex){;}

  }

  void jMenuItem5_mouseClicked(MouseEvent e) {
   try {
    //  UIManager.setLookAndFeel(new com.sun.java.swing.plaf.windows.WindowsLookAndFeel());
	    	   UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
           SwingUtilities.updateComponentTreeUI(this);
       }
       catch(Exception ex){;}

  }

  void jButton2_actionPerformed(ActionEvent e) {
    
  }
}



