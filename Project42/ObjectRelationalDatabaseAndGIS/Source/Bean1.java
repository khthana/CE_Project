
//Title:        GIS
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import com.sun.java.swing.border.*;

public class Bean1 extends JPanel {
  private String layer_name = "layer_name";
  Color c = Color.blue;
  JPanel jPanel2 = new JPanel();
  GridLayout gridLayout1 = new GridLayout();
  JCheckBox jCheckBox1 = new JCheckBox();
  JPanel jPanel1 = new JPanel();
  Border br;
  Border br2;




  public Bean1() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  private void jbInit() throws Exception {
    this.setSize(165,55);
    br = BorderFactory.createBevelBorder(0);
    br2 = BorderFactory.createLineBorder(Color.black);
    jPanel2.setLayout(gridLayout1);
    this.setPreferredSize(new Dimension(165, 55));
    this.setBorder(br);
    this.setMinimumSize(new Dimension(165, 55));
    jPanel2.setBorder(br2);
    jPanel2.setBounds(new Rectangle(12, 7, 144, 44));
    gridLayout1.setRows(2);
    jCheckBox1.setText(layer_name);
    jPanel1.setBackground(c);
    this.setLayout(null);
    this.add(jPanel2, null);
    jPanel2.add(jCheckBox1, null);
    jPanel2.add(jPanel1, null);


  }

  public String getLayer_name() {
    return layer_name;
  }

  public void setLayer_name(String newSample) {
    layer_name = newSample;
    jCheckBox1.setText(newSample);
  }
}

    
