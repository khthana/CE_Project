
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;

public class KToolBarPanel extends JPanel {
  BorderLayout borderLayout1 = new BorderLayout();
  JTabbedPane jTabbedPane1 = new JTabbedPane();

  
  public KToolBarPanel() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setPreferredSize(new Dimension(600, 70));
    this.setMinimumSize(new Dimension(600, 70));
    this.setSize(new Dimension(600, 70));
    this.setLayout(borderLayout1);
    jTabbedPane1.addTab("BASIC TOOL",new KUserToolBarPanel());
    //jTabbedPane1.addTab("BUILDER TOOL",new KBuilderToolBarPanel());
    jTabbedPane1.addTab("Options",new KAdvanceToolBarPanel());
    jTabbedPane1.addTab("Samples",new KSamplesToolBarPanel());
    this.add(jTabbedPane1, BorderLayout.CENTER);
  }
}

 