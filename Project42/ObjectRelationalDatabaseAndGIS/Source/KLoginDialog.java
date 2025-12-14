
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

public class KLoginDialog extends JDialog {
  JPanel panel1 = new JPanel();
  JLabel jLabel1 = new JLabel();
  JTextField jTextField1 = new JTextField();
  JLabel jLabel2 = new JLabel();
  JPasswordField jPasswordField1 = new JPasswordField();
  JButton jButton1 = new JButton();
  JButton jButton2 = new JButton();

  
  public KLoginDialog(Frame frame, String title, boolean modal) {
    super(frame, title, modal);
    try  {
      jbInit();
      pack();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  
  public KLoginDialog() {
    this(null, "", false);
  }

  void jbInit() throws Exception {
    panel1.setLayout(null);
    panel1.setPreferredSize(new Dimension(358, 172));
    panel1.setMinimumSize(new Dimension(358, 172));
    jLabel1.setText("username");
    jLabel1.setBounds(new Rectangle(24, 10, 90, 26));
    jTextField1.setBounds(new Rectangle(130, 5, 160, 37));
    jLabel2.setText("password");
    jLabel2.setBounds(new Rectangle(23, 53, 90, 36));
    jPasswordField1.setBounds(new Rectangle(130, 58, 159, 38));
    jButton1.setText("Log on");
    jButton1.setBounds(new Rectangle(97, 128, 70, 29));
    jButton1.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jButton1_mouseClicked(e);
      }
    });
    jButton2.setText("Exit");
    jButton2.setBounds(new Rectangle(192, 128, 68, 29));
    getContentPane().add(panel1);
    panel1.add(jLabel1, null);
    panel1.add(jTextField1, null);
    panel1.add(jLabel2, null);
    panel1.add(jPasswordField1, null);
    panel1.add(jButton1, null);
    panel1.add(jButton2, null);

  }

  void jButton1_mouseClicked(MouseEvent e) {
    this.show(false);
    this.dispose();
  }
}

                                  
