
//Title:      Your Product Name
//Version:    
//Copyright:  Copyright (c) 1998
//Author:     Your Name
//Company:    Your Company
//Description:Your description
package KCOM;

import com.sun.java.swing.UIManager;
import java.awt.*;

public class KGisDesktop {
  boolean packFrame = false;

  //Construct the application
  
  public KGisDesktop() {
    KGisDesktopFrame frame = new KGisDesktopFrame();
    //Validate frames that have preset sizes
    //Pack frames that have useful preferred size info, e.g. from their layout
    if (packFrame)
      frame.pack();
    else
      frame.validate();
    //Center the window
    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
    Dimension frameSize = frame.getSize();
    if (frameSize.height > screenSize.height)
      frameSize.height = screenSize.height;
    if (frameSize.width > screenSize.width)
      frameSize.width = screenSize.width;
    frame.setLocation((screenSize.width - frameSize.width) / 2, (screenSize.height - frameSize.height) / 2);
    frame.setVisible(true);
  }
//Main method
  
  public static void main(String[] args) {
/*
    try  {
      UIManager.setLookAndFeel(new com.sun.java.swing.plaf.windows.WindowsLookAndFeel());
      //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.motif.MotifLookAndFeel());
      //UIManager.setLookAndFeel(new com.sun.java.swing.plaf.metal.MetalLookAndFeel());
    }
    catch (Exception e) {
    }
*/    
    new KGisDesktop();
  }
}


 