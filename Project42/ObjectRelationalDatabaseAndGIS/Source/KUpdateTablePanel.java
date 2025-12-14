
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import java.util.*;
import com.sun.java.swing.*;

public class KUpdateTablePanel extends JPanel {
  BorderLayout borderLayout1 = new BorderLayout();
  JTextArea jTextArea = new JTextArea();
  JScrollPane jScrollPane1 = new JScrollPane(jTextArea);
  JPanel jPanel1 = new JPanel();
  FlowLayout flowLayout1 = new FlowLayout();
  JButton updateBtn = new JButton();
  JButton clearBtn = new JButton();
  JButton cancelBtn = new JButton();


  public KUpdateTablePanel(Vector v) {
    try  {
      jbInit();
      for (int i=0;i<v.size();i++)
      {
        jTextArea.append((String)v.elementAt(i)+"\n");
      }

    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setLayout(borderLayout1);
    jPanel1.setLayout(flowLayout1);
    updateBtn.setText("UPDATE DB");
    clearBtn.setText("CLEAR CMD");
    cancelBtn.setText("CANCEL");
    this.setPreferredSize(new Dimension(402, 308));
    this.setMinimumSize(new Dimension(402, 308));
    jScrollPane1.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
    this.add(jScrollPane1, BorderLayout.CENTER);
    this.add(jPanel1, BorderLayout.SOUTH);
    jPanel1.add(updateBtn, null);
    jPanel1.add(clearBtn, null);
    jPanel1.add(cancelBtn, null);
    jTextArea.setLineWrap(true);
  }
}

