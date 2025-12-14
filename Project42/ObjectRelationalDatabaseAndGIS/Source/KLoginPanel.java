
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

public class KLoginPanel extends JPanel {
  JPasswordField jPassword = new JPasswordField();
  JTextField jUsername = new JTextField();
  JLabel jLabel1 = new JLabel();
  JLabel jLabel2 = new JLabel();
  JLabel jLabel3 = new JLabel();
  JLabel jLabel4 = new JLabel();
  JTextField jIp = new JTextField();

  
  public KLoginPanel() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setPreferredSize(new Dimension(342, 168));
    this.setMinimumSize(new Dimension(342, 168));
    this.setSize(new Dimension(347, 172));
    jPassword.setFont(new Font("SansSerif", 1, 20));
    jPassword.setToolTipText("กรุณาใส่รหัสผ่าน");
    jPassword.setBounds(new Rectangle(142, 64, 125, 21));
    jUsername.setText("guest");
    jUsername.setFont(new Font("Dialog", 0, 16));
    jUsername.setToolTipText("กรุณาใส่ชื่อ username");
    jUsername.setBounds(new Rectangle(143, 34, 125, 22));


   

    jLabel1.setText("USERNAME");
    jLabel1.setFont(new Font("Dialog", 0, 16));
    jLabel1.setBounds(new Rectangle(52, 35, 83, 21));
    jLabel2.setText("PASSWORD");
    jLabel2.setFont(new Font("Dialog", 0, 16));
    jLabel2.setBounds(new Rectangle(51, 65, 89, 20));
    jLabel3.setText("DATABASE ");
    jLabel3.setFont(new Font("Dialog", 0, 16));
    jLabel3.setBounds(new Rectangle(51, 90, 91, 28));
    jLabel4.setText("SERVER IP");
    jLabel4.setFont(new Font("Dialog", 0, 16));
    jLabel4.setBounds(new Rectangle(54, 118, 89, 20));
    jIp.setText("127.0.0.1");
    jIp.setFont(new Font("Dialog", 0, 16));
    jIp.setToolTipText("หมายเลข ip ของเครื่องเซิร์ฟเวอร์ฐานข้อมูล");
    jIp.setBounds(new Rectangle(144, 111, 125, 22));
    this.setLayout(null);
    this.add(jPassword, null);
    this.add(jUsername, null);
    this.add(jLabel1, null);
    this.add(jLabel2, null);
    this.add(jIp, null);
    this.add(jLabel3, null);
    this.add(jLabel4, null);
  }

}

                                     
