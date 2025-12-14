
//Title:        GIS
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

package KCOM;

import java.awt.*;
import java.awt.event.*;

public class ColorPickerPanel extends Panel {
  Button OK = new Button();
  Button Cancel = new Button();
  Scrollbar BControl = new Scrollbar();
  Scrollbar GControl = new Scrollbar();
  Scrollbar RControl = new Scrollbar();
  Panel ColorDisplay = new Panel();
  Panel Colorbox;


  public ColorPickerPanel(Panel p) {
    try  {
      jbInit();
      Colorbox = p;
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setSize(new Dimension(311, 247));
    OK.setBounds(new Rectangle(55, 212, 54, 21));
    OK.setLabel("OK");
    OK.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        OK_mouseClicked(e);
      }
    });
    Cancel.setBounds(new Rectangle(132, 211, 55, 23));
    Cancel.setLabel("Cancel");
    Cancel.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        Cancel_mouseClicked(e);
      }
    });
    BControl.setBounds(new Rectangle(260, 25, 27, 181));
    BControl.setMaximum(255);
    BControl.addAdjustmentListener(new java.awt.event.AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e) {
        BControl_adjustmentValueChanged(e);
      }
    });
    GControl.setBounds(new Rectangle(220, 25, 27, 181));
    GControl.setMaximum(255);
    GControl.addAdjustmentListener(new java.awt.event.AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e) {
        GControl_adjustmentValueChanged(e);
      }
    });
    RControl.setBounds(new Rectangle(180, 25, 27, 181));
    RControl.setMaximum(255);
    RControl.addAdjustmentListener(new java.awt.event.AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e) {
        RControl_adjustmentValueChanged(e);
      }
    });
    ColorDisplay.setBackground(Color.black);
    ColorDisplay.setBounds(new Rectangle(42, 26, 115, 166));
    this.setLayout(null);
    this.add(OK, null);
    this.add(Cancel, null);
    this.add(BControl, null);
    this.add(GControl, null);
    this.add(RControl, null);
    this.add(ColorDisplay, null);
  }

  void RControl_adjustmentValueChanged(AdjustmentEvent e) {
    ControlColor();
  }

  void GControl_adjustmentValueChanged(AdjustmentEvent e) {
    ControlColor();
  }

  void BControl_adjustmentValueChanged(AdjustmentEvent e) {
    ControlColor();
  }
  void ControlColor(){
    ColorDisplay.setBackground(new Color(RControl.getValue(),GControl.getValue(),BControl.getValue()));
    ColorDisplay.repaint();
  }

  void OK_mouseClicked(MouseEvent e) {
      Colorbox.setBackground(new Color(RControl.getValue(),GControl.getValue(),BControl.getValue()));
      Frame f = (Frame)this.getParent();
      f.dispose();


  }

  void Cancel_mouseClicked(MouseEvent e) {
      Frame f = (Frame)this.getParent();
      f.dispose();



  }

}


