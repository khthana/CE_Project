
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

public class KColorPickerInternalFrame extends JInternalFrame{
  private static JScrollBar RControl = new JScrollBar();
  private static JScrollBar GControl = new JScrollBar();
  private static JScrollBar BControl = new JScrollBar();
  private static JPanel DispColor = new JPanel();
  private static KLayerButton kLayerButton1;
  private static JButton OK = new JButton();
  private static JButton Cancel = new JButton();
  private static KColorPickerInternalFrame _kI;
  static {
      try {
      _kI = new KColorPickerInternalFrame();
      jbInit();
      } catch(Exception ex){

      }
  }
  synchronized static void showColorPickerInternalFrame(KLayerButton kLBtn){
      KShareObject.getDesktopPane().add(_kI, JLayeredPane.MODAL_LAYER);
      kLayerButton1 = kLBtn;
      _kI.setBounds(0,0,313,210);
      _kI.pack();
      _kI.show();
      _kI.moveToFront();
      KShareObject.getDesktopPane().repaint();
  }

  static void jbInit() throws Exception {
    _kI.getContentPane().setLayout(null);
    _kI.setTitle("กรุณาเลือกสี");
    _kI.setPreferredSize(new Dimension(313, 206));
    _kI.setMinimumSize(new Dimension(313, 206));
    _kI.setBounds(0,0,313,210);
    _kI.pack();
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

    OK.setBounds(new Rectangle(34, 151, 72, 29));
    OK.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        OK_mouseClicked(e);
      }
    });
    Cancel.setText("ยกเลิก");

    Cancel.setBounds(new Rectangle(125, 151, 80, 29));
    Cancel.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        Cancel_mouseClicked(e);
      }
    });
    _kI.getContentPane().add(RControl, null);
    _kI.getContentPane().add(GControl, null);
    _kI.getContentPane().add(BControl, null);
    _kI.getContentPane().add(DispColor, null);
    _kI.getContentPane().add(OK, null);
    _kI.getContentPane().add(Cancel, null);
    _kI.setMaximizable(false);
    _kI.setIconifiable(false);
    _kI.setClosable(false);



  }

  static void OK_mouseClicked(MouseEvent e) {
    kLayerButton1.setLayerColor(new Color(RControl.getValue(),GControl.getValue(),BControl.getValue()));
    //kLayerButton1.repaintDisplay();
    //_kI.setVisible(false);
    JDesktopPane jp =KShareObject.getDesktopPane();
    jp.remove(_kI);
    jp.repaint();


  }

  static   void Cancel_mouseClicked(MouseEvent e) {
    JDesktopPane jp =KShareObject.getDesktopPane();
    jp.remove(_kI);
    jp.repaint();
  }

  static   void setDispColor()
  {
      DispColor.setBackground(new Color(RControl.getValue(),GControl.getValue(),BControl.getValue()));
      DispColor.repaint();
  }
  static   void RControl_adjustmentValueChanged(AdjustmentEvent e) {
      setDispColor();
  }

  static   void GControl_adjustmentValueChanged(AdjustmentEvent e) {
      setDispColor();
  }

  static   void BControl_adjustmentValueChanged(AdjustmentEvent e) {
      setDispColor();
  }
}


