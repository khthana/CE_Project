
//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import com.sun.java.swing.event.*;

public class KViewerInternalFrame extends JInternalFrame   {
  BorderLayout borderLayout1 = new BorderLayout();
  KViewerPanel kViewerPanel;
  String frameTitle;



  public KViewerInternalFrame(KViewerPanel kV) {
    try  {
      kViewerPanel = kV;
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.getContentPane().setLayout(borderLayout1);
    this.getContentPane().add(kViewerPanel, BorderLayout.CENTER);
    this.setIconifiable(true);
    this.setPreferredSize(new Dimension(300, 200));
    this.setMinimumSize(new Dimension(300, 200));
    this.setClosable(true);
    this.setMaximizable(true);
    this.setResizable(true);
    this.setBounds(0,0,300,200);
    this.setVisible(true);
    this.addInternalFrameListener(new com.sun.java.swing.event.InternalFrameAdapter() {
      public void internalFrameClosed(InternalFrameEvent e) {
        this_internalFrameClosed(e);
      }
    });

    this.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);

  }
  void setZoomRatio(float z){
    kViewerPanel.setZoomRatio(z);
    this.setTitle(frameTitle+"("+Integer.toString(Math.round(100*z))+"%)");

  }
  float getZoomRatio(){
    return kViewerPanel.getZoomRatio();
  }
  boolean canZoomOut(){
    return kViewerPanel.canZoomOut();
  }
  boolean canZoomIn(){
    return kViewerPanel.canZoomIn();
  }
  float getAdjustRatioValue(){
    return kViewerPanel.getAdjustRatioValue();
  }

  void this_internalFrameClosed(InternalFrameEvent e) {
    kViewerPanel = null;
    this.setVisible(false);
    this.dispose();

  }

  public KViewerPanel getViewerPanel(){
    return kViewerPanel;
  }


}


