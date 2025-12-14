
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;

public class KTablePanel extends JPanel {
  BorderLayout borderLayout1 = new BorderLayout();
  JTable jTable1 = new JTable();

  
  public KTablePanel() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setLayout(borderLayout1);
    this.add(jTable1, BorderLayout.CENTER);
  }
}

 
