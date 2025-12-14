
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;


import java.awt.*;
import com.sun.java.swing.*;
import java.util.*;
import java.awt.event.*;

public class KAllTablePanel extends JPanel {
  BorderLayout borderLayout1 = new BorderLayout();
  JList tableList;
  JScrollPane jScrollPane1 ;
  JPanel jPanel1 = new JPanel();
  JButton okBtn = new JButton();
  JButton cancelBtn = new JButton();


  public KAllTablePanel(Vector tableV) {
    try  {
      tableList = new JList(tableV);
      jScrollPane1 = new JScrollPane(tableList);
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setLayout(borderLayout1);
    okBtn.setText("OK");
    okBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        okBtn_mouseClicked(e);
      }
    });
    cancelBtn.setText("CANCEL");
    cancelBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        cancelBtn_mouseClicked(e);
      }
    });
    this.add(jScrollPane1, BorderLayout.CENTER);
    this.add(jPanel1, BorderLayout.SOUTH);
    jPanel1.add(okBtn, null);
    jPanel1.add(cancelBtn, null);
  }

  void okBtn_mouseClicked(MouseEvent e) {

  }

  void cancelBtn_mouseClicked(MouseEvent e) {

  }
}

               
