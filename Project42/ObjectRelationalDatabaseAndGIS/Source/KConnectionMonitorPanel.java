
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;

public class KConnectionMonitorPanel extends JPanel {
  JLabel jLabel1 = new JLabel(new ImageIcon(KImageUtil.getImageUtil().getImage("TwoWayCommunication")));
  public KConnectionMonitorPanel() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setMaximumSize(new Dimension(340, 155));
    this.setPreferredSize(new Dimension(340, 155));
    this.setMinimumSize(new Dimension(340, 155));
    this.setSize(new Dimension(334, 84));
    jLabel1.setText("Connecting to ...");
    jLabel1.setFont(new Font("Dialog", 0, 15));
    jLabel1.setBounds(new Rectangle(3, 1, 265, 65));
    this.setLayout(null);
    this.add(jLabel1, null);

  }
}

                   
