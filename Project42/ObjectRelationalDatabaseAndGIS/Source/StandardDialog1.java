// This snippet creates a new dialog box
// with buttons on the bottom.

//Title:
//Version:
//Copyright:
//Author:
//Company:
//Description:

package  KCOM;

import java.awt.*;
import java.awt.event.*;
import borland.jbcl.layout.*;
import borland.jbcl.control.*;

public class StandardDialog1 extends Dialog {
  Panel panel1 = new Panel();
  XYLayout xYLayout1 = new XYLayout();
  BevelPanel bevelPanel1 = new BevelPanel();
  Button button1 = new Button();
  Button button2 = new Button();

  public StandardDialog1(Frame frame, String title, boolean modal) {
    super(frame, title, modal);
    try {
      jbInit();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    add(panel1);
    pack();
  }

  public StandardDialog1(Frame frame, String title) {
    this(frame, title, false);
  }

  public StandardDialog1(Frame frame) {
    this(frame, "", false);
  }

  private void jbInit() throws Exception {
    xYLayout1.setWidth(320);
    xYLayout1.setHeight(243);
    button1.setLabel("OK");
    button1.addActionListener(new StandardDialog1_button1_actionAdapter(this));
    button2.setLabel("Cancel");
    button2.addActionListener(new StandardDialog1_button2_actionAdapter(this));
    this.addWindowListener(new StandardDialog1_this_windowAdapter(this));
    panel1.setLayout(xYLayout1);
    panel1.add(bevelPanel1, new XYConstraints(9, 10, 298, 191));
    panel1.add(button1, new XYConstraints(67, 211, 74, 25));
    panel1.add(button2, new XYConstraints(163, 211, 77, 25));
  }

  // OK
  void button1_actionPerformed(ActionEvent e) {
    dispose();
  }

  // Cancel
  void button2_actionPerformed(ActionEvent e) {
    dispose();
  }
  
  void this_windowClosing(WindowEvent e) {
    dispose();
  }
}

class StandardDialog1_button1_actionAdapter implements ActionListener {
  StandardDialog1 adaptee;

  StandardDialog1_button1_actionAdapter(StandardDialog1 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.button1_actionPerformed(e);
  }
}

class StandardDialog1_button2_actionAdapter implements ActionListener {
  StandardDialog1 adaptee;

  StandardDialog1_button2_actionAdapter(StandardDialog1 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.button2_actionPerformed(e);
  }
}

class StandardDialog1_this_windowAdapter extends WindowAdapter {
  StandardDialog1 adaptee;

  StandardDialog1_this_windowAdapter(StandardDialog1 adaptee) {
    this.adaptee = adaptee;
  }

  public void windowClosing(WindowEvent e) {
    adaptee.this_windowClosing(e);
  }
}
 