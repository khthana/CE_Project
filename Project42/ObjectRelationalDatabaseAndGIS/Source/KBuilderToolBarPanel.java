

//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import com.sun.java.swing.JComponent;
import java.awt.event.*;
import com.sun.java.swing.border.*;

public class KBuilderToolBarPanel extends JPanel {
  GridLayout gridLayout1 = new GridLayout();
  JButton openBtn = new JButton();
  JButton saveBtn = new JButton();
  JButton deleteBtn = new JButton();
  JButton newBtn = new JButton();
  Border normalBorder;
  JButton addBtn = new JButton();
  JButton removeBtn = new JButton();

  public KBuilderToolBarPanel() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    normalBorder = BorderFactory.createEtchedBorder(Color.orange,Color.red);

    this.setPreferredSize(new Dimension(570, 68));
    this.setMinimumSize(new Dimension(570, 68));
    this.setSize(new Dimension(434, 70));
    gridLayout1.setColumns(8);
    openBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        openBtn_mouseClicked(e);
      }
    });
    saveBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        saveBtn_mouseClicked(e);
      }
    });
    deleteBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        deleteBtn_mouseClicked(e);
      }
    });
    newBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        newBtn_mouseClicked(e);
      }
    });
    this.setLayout(gridLayout1);
    openBtn.setText("OPEN");
    openBtn.setBorder(normalBorder);
    openBtn.setToolTipText("");

    saveBtn.setText("SAVE");

    saveBtn.setBorder(normalBorder);
    saveBtn.setToolTipText("");

    deleteBtn.setText("DELETE");

    deleteBtn.setBorder(normalBorder);
    deleteBtn.setToolTipText("");
    newBtn.setText("NEW");
    newBtn.setBorder(normalBorder);
    newBtn.setToolTipText("");


    addBtn.setText("ADD");
    addBtn.setBorder(normalBorder);
    addBtn.setToolTipText("");
    removeBtn.setText("REMOVE");
    removeBtn.setBorder(normalBorder);
    removeBtn.setToolTipText("");
    removeBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    removeBtn.setVerticalTextPosition(AbstractButton.BOTTOM);

    removeBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    removeBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        removeBtn_mouseClicked(e);
      }
    });
    removeBtn.setVerticalTextPosition(AbstractButton.BOTTOM);

    addBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    addBtn.setVerticalTextPosition(AbstractButton.BOTTOM);
    this.add(newBtn, null);
    this.add(openBtn, null);
    this.add(saveBtn, null);
    this.add(deleteBtn, null);
    this.add(addBtn, null);
    this.add(removeBtn, null);
/*
    KImageUtil k = KImageUtil.getImageUtil();
    jButton1.setIcon(new ImageIcon(k.getImage("DatabaseManager")));
    jButton1.setMinimumSize(new Dimension(26, 21));
    jButton2.setIcon(new ImageIcon(k.getImage("UserManager")));
    jButton2.setMinimumSize(new Dimension(26, 21));
    jButton3.setIcon(new ImageIcon(k.getImage("EditMain")));
    jButton3.setMinimumSize(new Dimension(26, 21));
    jButton4.setIcon(new ImageIcon(k.getImage("EditRoom")));
    jButton4.setMinimumSize(new Dimension(26, 21));
*/
    KImageUtil k = KImageUtil.getImageUtil();
    newBtn.setIcon(new ImageIcon(k.getImage("NEW")));
    openBtn.setIcon(new ImageIcon(k.getImage("OPEN")));
    saveBtn.setIcon(new ImageIcon(k.getImage("SAVE")));
    deleteBtn.setIcon(new ImageIcon(k.getImage("DELETE")));
    addBtn.setIcon(new ImageIcon(k.getImage("ADD")));
    removeBtn.setIcon(new ImageIcon(k.getImage("REMOVE")));


    newBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    newBtn.setVerticalTextPosition(AbstractButton.BOTTOM);

    openBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    openBtn.setVerticalTextPosition(AbstractButton.BOTTOM);

    saveBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    saveBtn.setVerticalTextPosition(AbstractButton.BOTTOM);

    deleteBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    deleteBtn.setVerticalTextPosition(AbstractButton.BOTTOM);

    addBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    addBtn.setVerticalTextPosition(AbstractButton.BOTTOM);


    addBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        addBtn_mouseClicked(e);
      }
    });



  }

  void openBtn_mouseClicked(MouseEvent e) {
    try  {
      UIManager.setLookAndFeel(new com.sun.java.swing.plaf.windows.WindowsLookAndFeel());
      //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.motif.MotifLookAndFeel());
      //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.metal.MetalLookAndFeel());
      KShareObject.setLookAndFeel();
    }
    catch (Exception ex) {
    }

    //   KShareObject.getShareObject().setUserToolCode(11);
  }

  void saveBtn_mouseClicked(MouseEvent e) {
    try  {
      //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.windows.WindowsLookAndFeel());
      UIManager.setLookAndFeel(new com.sun.java.swing.plaf.motif.MotifLookAndFeel());
      //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.metal.MetalLookAndFeel());
      //    SwingUtilities.updateComponentTreeUI(this);
      KShareObject.setLookAndFeel();
    }
    catch (Exception ex) {
    }

  //       KShareObject.getShareObject().setUserToolCode(12);
  }

  void deleteBtn_mouseClicked(MouseEvent e) {
    try  {
      //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.windows.WindowsLookAndFeel());
      //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.motif.MotifLookAndFeel());
      UIManager.setLookAndFeel(new com.sun.java.swing.plaf.metal.MetalLookAndFeel());
      //    SwingUtilities.updateComponentTreeUI(this);
      KShareObject.setLookAndFeel();
    }
    catch (Exception ex) {
    }

      // KShareObject.getShareObject().setUserToolCode(13);
  }

  void newBtn_mouseClicked(MouseEvent e) {
    KShareObject.createNewMap();
  }

  void addBtn_mouseClicked(MouseEvent e) {
       KShareObject.showAboutDialog();
  }
  void removeBtn_mouseClicked(MouseEvent e){
  }
}


