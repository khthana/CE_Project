
//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import java.util.*;
import com.sun.java.swing.table.*;
import com.sun.java.swing.*;

public class KTableInternalFrame extends JInternalFrame {
  BorderLayout borderLayout1 = new BorderLayout();
  JTable jTable;
  JPanel jPanel1 = new JPanel();
  JButton jButton1 = new JButton();
  JButton jButton2 = new JButton();
  JScrollPane jScrollPane1 ;
  public KTableInternalFrame() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.getContentPane().setLayout(borderLayout1);
    jButton1.setText("jButton1");
    jButton2.setText("jButton2");
    this.getContentPane().add(jPanel1, BorderLayout.SOUTH);
    jPanel1.add(jButton1, null);
    jPanel1.add(jButton2, null);

    this.setIconifiable(true);
    this.setMaximizable(true);
    this.setResizable(true);
    this.setClosable(true);
    //createTable();
    this.show(true);
}
/*
  public void createTable(){

           KConnectionManager k = KConnectionManager.getConnectionManager();
           Vector data = k.getRoomData();
           Vector columnNames = k.getRoomColumnNames();//new Vector();
           jTable = new JTable(data,columnNames);
           jTable.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
           jScrollPane1 = JTable.createScrollPaneForTable(jTable);
           jTable.setPreferredScrollableViewportSize(new Dimension(100,50));
           this.getContentPane().add(jScrollPane1, BorderLayout.CENTER);

  }
  */

}

