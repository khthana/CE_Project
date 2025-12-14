
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

public class KLoginInternalFrame extends JInternalFrame implements Runnable{
  KLoginPanel jPanel1;
  JPanel jPanel3;
  BorderLayout borderLayout1 = new BorderLayout();
  JButton jButton2 = new JButton();
  JPanel jPanel2 = new JPanel();
  JButton jButton1 = new JButton();
  Thread conThread = new Thread(this);


  public KLoginInternalFrame() {
    try  {
      jbInit();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  private void jbInit() throws Exception {
//    JOptionPane.showInternalMessageDialog(KShareObject.getDesktop(),"title","hello",JOptionPane.ERROR_MESSAGE);
    this.setTitle("ระบบสารสนเทศอาคารและสถานที่ สจล.2543");
    this.setSize(350,220);
    this.getContentPane().setLayout(borderLayout1);
    this.show(true);
    jPanel1 = new KLoginPanel();

    jButton2.setFont(new Font("Dialog", 0, 15));
    jButton2.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jButton2_mouseClicked(e);
      }
    });
    jButton1.setText("OK");
    jButton1.setFont(new Font("Dialog", 0, 15));
    jButton1.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jButton1_mouseClicked(e);
      }
    });
    jButton2.setText("Cancel");
    this.getContentPane().add(jPanel1, BorderLayout.CENTER);
    this.getContentPane().add(jPanel2, BorderLayout.SOUTH);
    jPanel2.add(jButton1, null);
    jPanel2.add(jButton2, null);
    this.setClosable(false);
    this.setMaximizable(false);
    this.setIconifiable(false);
  }

  void jButton1_mouseClicked(MouseEvent e) {
    //KConnectionManager.getConnectionManager().testInsert(tf1.getText());
    KConnectionManager.setInitParam(jPanel1.jUsername.getText(),jPanel1.jPassword.getText(),jPanel1.jIp.getText());
    KConnectionManager.createConnection();
    if (KConnectionManager.haveConnection())
    {
    conThread.start();
    this.getContentPane().remove(jPanel1);
    this.getContentPane().remove(jPanel2);
    //jPanel1 = new KConnectionMonitorPanel();
    this.getContentPane().add(new KConnectionMonitorPanel(), BorderLayout.CENTER);
    this.validateTree();
    this.getContentPane().repaint();
    }
    else
    {
      KShareObject.showErrorMessage("ERROR","INVALID USERNAME AND PASSWORD");
    }
  }
  public void run(){
    System.out.println("Start");
    KShareObject.createFirstInDesktop();
    this.setVisible(false);
    KShareObject.repaintDesktop();

  }

  void jButton2_mouseClicked(MouseEvent e) {
    KShareObject.exitProgram();
  }

}


