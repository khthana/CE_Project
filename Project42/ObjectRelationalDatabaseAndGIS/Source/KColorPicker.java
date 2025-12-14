
//Title:       GIS
//Version:
//Copyright:   Copyright (c) 1998
//Author:      Sakshart Ngamluan
//Company:     KMITL
//Description: Your description
package KCOM;

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import java.lang.*;


//import com.sun.java.swing.UIManager;
public class KColorPicker extends Applet {
  boolean isStandalone = false;

  int counter = 0;


  Button button1 = new Button();
  ScrollPane scrollPane1 = new ScrollPane();
  Panel panel1 = new Panel();
  GridLayout gridLayout1 = new GridLayout();
  Button button2 = new Button();
  TextArea txt = new TextArea();
  Button button3 = new Button();





  //Get a parameter value

  public String getParameter(String key, String def) {
    return isStandalone ? System.getProperty(key, def) :
      (getParameter(key) != null ? getParameter(key) : def);
  }

  //Construct the applet

  public KColorPicker() {
  }
//Initialize the applet

  public void init() {
    try {
    jbInit();
    }
    catch (Exception e) {
    e.printStackTrace();
    }
  }
  //static {
  //  try {
  //    //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.metal.MetalLookAndFeel());
  //    //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.motif.MotifLookAndFeel());
  //    UIManager.setLookAndFeel(new com.sun.java.swing.plaf.windows.WindowsLookAndFeel());
  //  }
  //  catch (Exception e) {}
  //}
//Component initialization

  private void jbInit() throws Exception {


    scrollPane1.setBounds(new Rectangle(25, 16, 166, 372));
    panel1.setSize(200,1000);
    gridLayout1.setRows(20);
    button2.setBounds(new Rectangle(206, 57, 74, 33));
    button2.setLabel("Remove");
    txt.setBounds(new Rectangle(209, 100, 123, 212));
    button3.setBounds(new Rectangle(226, 336, 63, 30));
    button3.setLabel("button3");
    button3.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(ActionEvent e) {
        button3_actionPerformed(e);
      }
    });
    button2.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        button2_mouseClicked(e);
      }
    });

    panel1.setLayout(gridLayout1);
    this.setSize(new Dimension(354, 432));
    this.setLayout(null);

    button1.setBounds(new Rectangle(205, 16, 75, 33));
    button1.setLabel("Add");
    button1.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(ActionEvent e) {
        button1_actionPerformed(e);
      }
    });

    //Image i1 =getImage(getDocumentBase(),"help.gif");
    Image i2 =getImage(getDocumentBase(),"openFile.gif");
    Image i3 =getImage(getDocumentBase(),"closeFile.gif");




    this.setSize(400,300);
    this.add(button1, null);
    this.add(scrollPane1, null);
    scrollPane1.add(panel1);
    this.add(button2, null);
    this.add(txt, null);
    this.add(button3, null);



  }
//Start the applet
  
  public void start() {
  }
//Stop the applet
  
  public void stop() {
  }
//Destroy the applet
  
  public void destroy() {
  }
//Get Applet information
  
  public String getAppletInfo() {
    return "Applet Information";
  }
//Get parameter info

  public String[][] getParameterInfo() {
    return null;
  }


  void button1_actionPerformed(ActionEvent e) {
    panel1.add(new KAWTLayer());
    this.validateTree();
    txt.append(new Integer(panel1.getComponentCount()).toString()+"\n");
  }

  void button2_mouseClicked(MouseEvent e) {


     for (int i=0;i<panel1.getComponentCount();i++){
        KAWTLayer kl = (KAWTLayer)panel1.getComponent(i);
        if (kl.selected){
        panel1.remove(i);
        i = -1;
        this.validateTree();

        }



    }

  }

  void button3_actionPerformed(ActionEvent e) {
     int c = panel1.getComponentCount()  ;
     for (int i=0;i<c;i++){
      KAWTLayer kl = (KAWTLayer)panel1.getComponent(i);
        txt.append(new Integer(i).toString()+" "+kl.checkbox1.toString()+"\n");
     }

  }

}


