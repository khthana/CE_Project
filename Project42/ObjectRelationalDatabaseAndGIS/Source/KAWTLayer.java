
//Title:        GIS
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

package KCOM;

import java.awt.*;
import java.awt.event.*;
import java.lang.String;

public class KAWTLayer extends Panel {
  private String sample = "Sample";
  Panel panel1 = new Panel();
  GridLayout gridLayout1 = new GridLayout();
  Checkbox checkbox1 = new Checkbox();
  Panel panel2 = new Panel();
  boolean selected = false;


  public KAWTLayer() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  private void jbInit() throws Exception {
    this.setBackground(Color.lightGray);
    this.setSize(new Dimension(172, 79));
    this.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        this_mouseClicked(e);
      }
    });
    panel1.setBounds(new Rectangle(12, 12, 148, 54));
    gridLayout1.setRows(2);
    checkbox1.setLabel("layer_name");
    panel2.setBackground(Color.red);
    panel2.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        panel2_mouseClicked(e);
      }
    });
    panel1.setLayout(gridLayout1);
    this.setLayout(null);
    this.add(panel1, null);
    panel1.add(checkbox1, null);
    panel1.add(panel2, null);
  }

  public String getSample() {
    return sample;
  }

  public void setSample(String newSample) {
    sample = newSample;
  }

  void panel2_mouseClicked(MouseEvent e) {
    Frame f = new Frame("Configure Color");
    ColorPickerPanel c = new ColorPickerPanel(panel2);
    f.add(c);
    f.setSize(300,260);
    f.show();
  }

  void this_mouseClicked(MouseEvent e) {
    if (! selected){
      this.setBackground(Color.green);
      selected = ! selected;
    }else{
      this.setBackground(Color.lightGray);
      selected = ! selected;
    }



  }

 
 
}


