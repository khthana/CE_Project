
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.JFrame;

public  class KColorPickFrame extends JFrame {
  public KColorPickFrame() {
    this.setSize(200,100);
    this.getContentPane().setLayout(new BorderLayout());
   // this.getContentPane().add(new ColorPickPanel(this));
  }
  public static void showFrame(){
    //this.show(true);
  }

}

 