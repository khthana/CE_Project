
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import java.awt.event.*;

public class ColorPickPanel extends JPanel {
  JScrollBar RControl = new JScrollBar();
  JScrollBar GControl = new JScrollBar();
  JScrollBar BControl = new JScrollBar();
  JPanel DispColor = new JPanel();
  KLayerButton kLayerButton1;
  JButton OK = new JButton();
  JButton Cancel = new JButton();
  JLabel jLabel1 = new JLabel();


  public ColorPickPanel(KLayerButton kLBttn) {
    try  {

      kLayerButton1=kLBttn;
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setLayout(null);

    this.setPreferredSize(new Dimension(313, 206));
    this.setMinimumSize(new Dimension(313, 206));
    RControl.setMaximum(255);
    RControl.setToolTipText("สีแดง");
    RControl.setBounds(new Rectangle(179, 31, 19, 97));
    RControl.addAdjustmentListener(new java.awt.event.AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e) {
        RControl_adjustmentValueChanged(e);
      }
    });
    GControl.setMaximum(255);
    GControl.setToolTipText("สีเขียว");
    GControl.setBounds(new Rectangle(209, 31, 19, 97));
    GControl.addAdjustmentListener(new java.awt.event.AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e) {
        GControl_adjustmentValueChanged(e);
      }
    });
    BControl.setMaximum(255);
    BControl.setToolTipText("สีน้ำเงิน");
    BControl.setBounds(new Rectangle(239, 31, 19, 97));
    BControl.addAdjustmentListener(new java.awt.event.AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e) {
        BControl_adjustmentValueChanged(e);
      }
    });
    DispColor.setBackground(Color.black);
    DispColor.setBounds(new Rectangle(28, 36, 120, 90));
    OK.setText("ตกลง");
    OK.setLabel("OK");
    OK.setBounds(new Rectangle(34, 151, 72, 29));
    OK.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        OK_mouseClicked(e);
      }
    });
    Cancel.setText("ยกเลิก");
    Cancel.setLabel("Cancel");
    Cancel.setBounds(new Rectangle(125, 151, 80, 29));
    jLabel1.setText("Select Color");
    jLabel1.setFont(new Font("SansSerif", 1, 30));
    jLabel1.setBounds(new Rectangle(22, 7, 243, 19));
    Cancel.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        Cancel_mouseClicked(e);
      }
    });
    this.add(RControl, null);
    this.add(GControl, null);
    this.add(BControl, null);
    this.add(DispColor, null);
    this.add(OK, null);
    this.add(Cancel, null);
    this.add(jLabel1, null);
  }

  void OK_mouseClicked(MouseEvent e) {
    kLayerButton1.setLayerColor(new Color(RControl.getValue(),GControl.getValue(),BControl.getValue()));
    kLayerButton1.repaintDisplay();
    kLayerButton1.setHaveColorPickerFrame(false);

  }

  void Cancel_mouseClicked(MouseEvent e) {
    kLayerButton1.setHaveColorPickerFrame(false);
  }

  void setDispColor()
  {
      DispColor.setBackground(new Color(RControl.getValue(),GControl.getValue(),BControl.getValue()));
      DispColor.repaint();
  }
  void RControl_adjustmentValueChanged(AdjustmentEvent e) {
      setDispColor();
  }

  void GControl_adjustmentValueChanged(AdjustmentEvent e) {
      setDispColor();
  }

  void BControl_adjustmentValueChanged(AdjustmentEvent e) {
      setDispColor();
  }
}


