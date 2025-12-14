
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

public class KAdvanceToolBarPanel extends JPanel {
  GridLayout gridLayout1 = new GridLayout();
  JButton winBtn = new JButton();
  JButton motifBtn = new JButton();
  JButton javaBtn = new JButton();
  Border normalBorder;
  JButton aboutBtn = new JButton();

  public KAdvanceToolBarPanel() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    normalBorder = BorderFactory.createEtchedBorder(Color.cyan,Color.blue);

    this.setPreferredSize(new Dimension(570, 68));
    this.setMinimumSize(new Dimension(570, 68));
    this.setSize(new Dimension(399, 70));
    gridLayout1.setColumns(8);
    winBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        winBtn_mouseClicked(e);
      }
    });
    motifBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        motifBtn_mouseClicked(e);
      }
    });
    javaBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        javaBtn_mouseClicked(e);
      }
    });
    this.setLayout(gridLayout1);
    winBtn.setText("Windows");
    winBtn.setBorder(normalBorder);
    winBtn.setToolTipText("วินโดวส์");

    motifBtn.setText("Motif");

    motifBtn.setBorder(normalBorder);
    motifBtn.setToolTipText("โมทิพ");

    javaBtn.setText("Java");

    javaBtn.setBorder(normalBorder);
    javaBtn.setToolTipText("จาวา");


    aboutBtn.setText("About");
    aboutBtn.setBorder(normalBorder);
    aboutBtn.setToolTipText("เกี่ยวกับโปรแกรม");

    aboutBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    aboutBtn.setVerticalTextPosition(AbstractButton.BOTTOM);
    this.add(winBtn, null);
    this.add(motifBtn, null);
    this.add(javaBtn, null);
    this.add(aboutBtn, null);
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
    winBtn.setIcon(new ImageIcon(k.getImage("Windows")));
    motifBtn.setIcon(new ImageIcon(k.getImage("Motif")));
    javaBtn.setIcon(new ImageIcon(k.getImage("Java")));
    aboutBtn.setIcon(new ImageIcon(k.getImage("About")));


    winBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    winBtn.setVerticalTextPosition(AbstractButton.BOTTOM);

    motifBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    motifBtn.setVerticalTextPosition(AbstractButton.BOTTOM);

    javaBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    javaBtn.setVerticalTextPosition(AbstractButton.BOTTOM);

    aboutBtn.setHorizontalTextPosition(AbstractButton.CENTER);
    aboutBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        aboutBtn_mouseClicked(e);
      }
    });
    aboutBtn.setVerticalTextPosition(AbstractButton.BOTTOM);


  }

  void winBtn_mouseClicked(MouseEvent e) {
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

  void motifBtn_mouseClicked(MouseEvent e) {
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

  void javaBtn_mouseClicked(MouseEvent e) {
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

  void configBtn_mouseClicked(MouseEvent e) {
       KShareObject.getShareObject().setUserToolCode(14);
  }

  void aboutBtn_mouseClicked(MouseEvent e) {
       KShareObject.showAboutDialog();
  }
}


