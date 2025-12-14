
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
import com.sun.java.swing.border.*;


public class KSamplesToolBarPanel extends JPanel {
  JButton kReservInfo = new JButton();
  final static int ROOMRESERVINFO_TOOL = 100;
  Border normalBorder;
  BorderLayout borderLayout1 = new BorderLayout();

  public KSamplesToolBarPanel() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    normalBorder = BorderFactory.createEtchedBorder(Color.green,Color.blue);
    KImageUtil k = KImageUtil.getImageUtil();

    this.setSize( 30,126);
    this.setMaximumSize(new Dimension(570, 68));
    this.setPreferredSize(new Dimension(570, 68));
    this.setToolTipText("ออกจากโปรแกรม");
    this.setMinimumSize(new Dimension(570, 68));
    this.setSize(new Dimension(731, 70));
    kReservInfo.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        kReservInfo_mouseClicked(e);
      }
    });
    this.setLayout(borderLayout1);

    kReservInfo.setMaximumSize(new Dimension(26, 21));
    kReservInfo.setText("ข้อมูลการจอง");
    kReservInfo.setPreferredSize(new Dimension(100, 50));


    this.add(kReservInfo, BorderLayout.WEST);
    kReservInfo.setIcon(new ImageIcon(k.getImage("ObjectInfo")));
    kReservInfo.setBorder(normalBorder);
    kReservInfo.setToolTipText("ดูข้อมูลการจอง");
    kReservInfo.setMinimumSize(new Dimension(26, 21));


    kReservInfo.setHorizontalTextPosition(AbstractButton.CENTER);

    kReservInfo.setVerticalTextPosition(AbstractButton.BOTTOM);


  }
  void kReservInfo_mouseClicked(MouseEvent e) {
       KShareObject.getShareObject().setUserToolCode(ROOMRESERVINFO_TOOL);
  }

}


