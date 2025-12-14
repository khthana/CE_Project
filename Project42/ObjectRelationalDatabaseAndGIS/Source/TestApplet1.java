
//Title:       GIS
//Version:
//Copyright:   Copyright (c) 1998
//Author:      Sakshart Ngamluan
//Company:     KMITL
//Description: Your description
package KCOM;

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import java.util.*;
import com.sun.java.swing.*;
import com.sun.java.swing.table.*;

//import com.sun.java.swing.UIManager;
public class TestApplet1 extends JApplet {
  boolean isStandalone = false;
  KConnectionManager kc;
  int counter = 0;
  int cursorType = Cursor.DEFAULT_CURSOR;
  JTable table;
  JScrollPane scrollPane;
  BorderLayout borderLayout1 = new BorderLayout();
  KConnectionManager k;
  JPanel jPanel1 = new JPanel();
  JButton Check = new JButton();
//Get a parameter value

  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }

  //Construct the applet

  public TestApplet1() {
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

    this.requestFocus();
    this.setSize(500,500);

           k = KConnectionManager.getConnectionManager();
           Vector data = k.getRoomData();
           Vector columnNames = k.getColumnNames("PLACE");//new Vector();
          // columnNames.addElement(new String("op"));
          // columnNames.addElement(new String("op2"));
          // columnNames.addElement(new String("op3"));

          table = new JTable(data,columnNames);
          scrollPane = JTable.createScrollPaneForTable(table);
          table.setPreferredScrollableViewportSize(new Dimension(100,50));



    Check.setText("jButton1");
    Check.setLabel("Check");

    Check.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        Check_mouseClicked(e);
      }
    });

          TableColumn sportColumn = table.getColumnModel().getColumn(2);

          JComboBox comboBox = new JComboBox();
          Hashtable h = k.getRoomTypeNames();
          for (int i=1;i<=12;i++){
            comboBox.addItem((String)h.get(String.valueOf(i)));
          }


          sportColumn.setCellEditor(new DefaultCellEditor(comboBox));



          this.getContentPane().setLayout(borderLayout1);
           table.setGridColor(Color.green);
    /*
           TableColumn t;
           for (int i=0;i<table.getColumnModel().getColumnCount();i++){
           t  = table.getColumnModel().getColumn(i);
           t.setMinWidth(80);
           }
      */

    this.getContentPane().add(scrollPane,BorderLayout.CENTER);
//    this.getContentPane().add(table,BorderLayout.CENTER);
    this.getContentPane().add(jPanel1, BorderLayout.NORTH);
    jPanel1.add(Check, null);



//Start the applet
    }
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


  void Check_mouseClicked(MouseEvent e) {
        System.out.println("");
  }




}


