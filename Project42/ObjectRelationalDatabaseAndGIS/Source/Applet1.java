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
import com.sun.java.swing.table.*;
import java.util.*;


//import com.sun.java.swing.UIManager;
public class Applet1 extends JApplet {
  boolean isStandalone = false;
  JDesktopPane jp = new JDesktopPane();
  BorderLayout borderLayout1 = new BorderLayout();
  JPanel jPanel1 = new JPanel();
  JPanel jPanel2 = new JPanel();
  BorderLayout borderLayout2 = new BorderLayout();
  JTable jTable;
  JLabel jLabel1 = new JLabel();
  JButton jButton1 = new JButton();
  int s = 0;
  TableSorter sorter;
  JButton jButton2 = new JButton();
  JScrollPane jScrollPane;
  JTextArea   jTextArea;
  JButton jButton3 = new JButton();
  //Get a parameter value

  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }
  //Construct the applet
  public Applet1() {
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
    //this.setLayeredPane(jp);
    //jp.setDoubleBuffered(true);
    this.getContentPane().setLayout(borderLayout1);
    jPanel2.setLayout(borderLayout2);
    jLabel1.setText("jLabel1");
    this.getContentPane().add("Center",jp);
    this.setSize(400,300);
    this.getContentPane().add(jPanel1, BorderLayout.CENTER);
    jPanel1.add(jButton2, null);
    jPanel1.add(jLabel1, null);
    jPanel1.add(jButton1, null);
    jPanel1.add(jButton3, null);
    this.getContentPane().add(jPanel2, BorderLayout.SOUTH);
    jTextArea = new JTextArea();
    jScrollPane = new JScrollPane(jTextArea);
    jScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
    jScrollPane.setPreferredSize(new Dimension(250, 250));
    this.getContentPane().add(jScrollPane, BorderLayout.EAST);


           //KConnectionManager k = KConnectionManager.getConnectionManager();
           //Vector data = k.getRoomData();
           //Vector columnNames = k.getColumnNames("PLACE");//new Vector();
           Vector d = new Vector();
           d.addElement(new Boolean(true));
           d.addElement(new Boolean(true));
           d.addElement(new String("1"));
           d.addElement(new String("1"));
           d.addElement(new String("1"));

           Vector d2 = new Vector();
           d2.addElement(new Boolean(true));
           d2.addElement(new Boolean(true));
           d2.addElement(new String("2"));
           d2.addElement(new String("2"));
           d2.addElement(new String("2"));


           Vector d3 = new Vector();
           d3.addElement(new Boolean(true));
           d3.addElement(new Boolean(true));
           d3.addElement(new String("3"));
           d3.addElement(new String("3"));
           d3.addElement(new String("3"));

           Vector d4 = new Vector();
           d4.addElement(new Boolean(true));
           d4.addElement(new Boolean(true));
           d4.addElement(new String("4"));
           d4.addElement(new String("4"));
           d4.addElement(new String("4"));

           Vector data = new Vector();
           data.addElement(d);
           data.addElement(d2);
           data.addElement(d3);
           data.addElement(d4);
           Vector columnNames = new Vector();
           columnNames.addElement("view");
           columnNames.addElement("col1");
           columnNames.addElement("col2");
           columnNames.addElement("col3");
           columnNames.addElement("col4");

           DefaultTableModel dT = new DefaultTableModel(data,columnNames);
            sorter = new TableSorter(dT); //ADDED THIS
           jTable = new JTable(sorter);
    jButton3.setText("jButton3");
    jButton3.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jButton3_mouseClicked(e);
      }
    });
            sorter.addMouseListenerToHeaderInTable(jTable); //ADDED THIS

//           jTable.getColumnModel().set
//           DefaultTableColumnModel model = (DefaultTableColumnModel)jTable.getColumnModel();

 /*
            TableColumnModel cModel = jTable.getColumnModel();
//            cModel.addColumnModelListener(this);


            TableColumn col = cModel.getColumn(0);
            KCheckBoxRenderer cB = new KCheckBoxRenderer();
            JCheckBox cbox = new JCheckBox();
            cbox.setHorizontalAlignment(JCheckBox.CENTER);
            DefaultCellEditor editor = new DefaultCellEditor(cbox);
            col.setCellRenderer(cB);
            col.setCellEditor(editor);

*/



    jButton1.setText("jButton1");
    jButton1.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jButton1_mouseClicked(e);
      }
    });
    jButton2.setText("jButton2");

    jButton2.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jButton2_mouseClicked(e);
      }
      public void mouseEntered(MouseEvent e) {
        jButton2_mouseEntered(e);
      }
    });


           JScrollPane jScrollPane1 = JTable.createScrollPaneForTable(jTable);
           jTable.setPreferredScrollableViewportSize(new Dimension(100,50));
           jTable.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

           jPanel2.add(jScrollPane1, BorderLayout.SOUTH);
           SwingUtilities.updateComponentTreeUI(this);

  }


  void jButton1_mouseClicked(MouseEvent e) {
        //jTable.clearSelection();
        //sorter.sortSearchResult(jTable);

        //TableSorter mT = (TableSorter)jTable.getModel();
        //mT.setEdit(true);
        JOptionPane.showInternalMessageDialog(this,"Hello","No Title",JOptionPane.NO_OPTION);

  }

  void jButton2_mouseClicked(MouseEvent e) {
       for (int i=0;i<20;i++)
       {
       jTextArea.append("Hello-------------------------XXXX----------------------------\n");
       }
  }

  void jButton3_mouseClicked(MouseEvent e) {
       jScrollPane.setAlignmentY(jScrollPane.CENTER_ALIGNMENT);
       jScrollPane.setAlignmentX(jScrollPane.CENTER_ALIGNMENT);
       jScrollPane.updateUI();
       jScrollPane.validate();

  }

  void jButton2_mouseEntered(MouseEvent e) {
      jButton2.setCursor(new Cursor(Cursor.CROSSHAIR_CURSOR));
  }

}

