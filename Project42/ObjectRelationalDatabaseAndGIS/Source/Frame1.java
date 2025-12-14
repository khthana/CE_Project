
//Title:      GIS
//Version:    
//Copyright:  Copyright (c) 1998
//Author:     Sakshart Ngamluan
//Company:    KMITL
//Description:Your description
package KCOM;

import java.awt.*;
import java.awt.event.*;
import com.sun.java.swing.*;

public class Frame1 extends JFrame {

  //Construct the frame
  BorderLayout borderLayout1 = new BorderLayout();
  JLabel statusBar = new JLabel();
  JPopupMenu jPopupMenu1 = new JPopupMenu();
  JMenuItem jMenuItem1 = new JMenuItem();
  
  public Frame1() {
    enableEvents(AWTEvent.WINDOW_EVENT_MASK);
    try  {
      jbInit();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
//Component initialization
  
  private void jbInit() throws Exception  {
    this.getContentPane().setLayout(borderLayout1);
    this.setSize(new Dimension(400, 300));
    this.setTitle("Frame Title");
    statusBar.setText(" ");
    jPopupMenu1.setInvoker(this);
    jMenuItem1.setText("Show");
    this.getContentPane().add(statusBar, BorderLayout.SOUTH);
    jPopupMenu1.add(jMenuItem1);
  }
//Overriden so we can exit on System Close
  
  protected void processWindowEvent(WindowEvent e) {
    super.processWindowEvent(e);
    if (e.getID() == WindowEvent.WINDOW_CLOSING) {
      System.exit(0);
    }
  }
}

    
