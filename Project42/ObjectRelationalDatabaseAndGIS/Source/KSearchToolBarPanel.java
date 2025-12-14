

//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import java.awt.event.*;

public class KSearchToolBarPanel extends JPanel {
  GridLayout gridLayout1 = new GridLayout();
  JButton jButton1 = new JButton();
  JButton jButton2 = new JButton();
  JButton jButton3 = new JButton();
  JButton jButton4 = new JButton();
  JButton jButton5 = new JButton();
  JButton jButton6 = new JButton();

  public KSearchToolBarPanel() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setSize( 30,126);
    this.setMaximumSize(new Dimension(180, 32));
    this.setPreferredSize(new Dimension(180, 32));
    this.setLayout(gridLayout1);
    this.setMinimumSize(new Dimension(180, 32));
    gridLayout1.setColumns(6);
    jButton1.setText("jButton1");
    jButton2.setText("jButton2");
    jButton3.setText("jButton3");
    jButton4.setText("jButton4");
    jButton5.setText("jButton5");
    jButton6.setText("jButton6");
    this.add(jButton1, null);
    this.add(jButton2, null);
    this.add(jButton3, null);
    this.add(jButton4, null);
    this.add(jButton5, null);
    this.add(jButton6, null);

  }
}


