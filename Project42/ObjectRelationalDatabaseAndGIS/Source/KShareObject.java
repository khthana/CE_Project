
//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;


import java.lang.*;
import com.sun.java.swing.*;
import com.sun.java.swing.preview.*;
import com.sun.java.swing.event.*;
import com.sun.java.swing.text.*;
import com.sun.java.swing.border.*;
import java.awt.*;

public class KShareObject {
private static int userToolCode = Integer.MAX_VALUE;
private static KShareObject _shareObject;
private static KDesktop _shareDesktop;
private static KGisDesktopFrame _shareDesktopFrame;
private static JDesktopPane _shareDesktopPane;
private static boolean showError = false;
static boolean isDebug = true;

  public KShareObject() {
  }
//  public static boolean isDebug(){
//    return isDebug;
//  }
  public void initDesktopPane(JDesktopPane jd){
    _shareDesktopPane = jd;
  }


  public static JDesktopPane getDesktopPane(){
    return _shareDesktopPane;
  }
  public void initDesktop(KDesktop k){
    _shareDesktop = k;
  }
  public void initDesktop(KGisDesktopFrame f){
    _shareDesktopFrame = f;
  }

/*  public static KDesktop getDesktop(){
    //return _shareDesktop;
    return _shareDesktopFrame;

  }
*/
  public static KShareObject getShareObject(){
  if (_shareObject == null){
    _shareObject = new KShareObject();
  }
  return _shareObject;
  }
  public  int getUserToolCode(){
    return userToolCode;
  }
  public  void setUserToolCode(int code){
    userToolCode = code;
  }
  public static KViewerPanel getShowingViewerPanel(){
    return getShowingInternalFrame().getViewerPanel();
  }
  public static KViewerInternalFrame getShowingInternalFrame(){
       for (int i=0;i<_shareDesktopPane.getComponentCount();i++){
          if (_shareDesktopPane.getComponent(i) instanceof KViewerInternalFrame){
          KViewerInternalFrame f = (KViewerInternalFrame)_shareDesktopPane.getComponent(i);
          if (f.isShowing()){
            //System.out.println(f.getTitle());
            return f;
          }
          }
       }
       return null;
  }
 public  static void showMessage(String title,String str)
 {
    if (_shareDesktop!=null)
    {
        JOptionPane.showMessageDialog(_shareDesktop,str,title,JOptionPane.NO_OPTION);
    }
    else
    {
        //int n = JOptionPane.showConfirmDialog(_shareDesktopPane,str,title,JOptionPane.YES_OPTION);
        JOptionPane.showMessageDialog(_shareDesktopFrame,str,title,JOptionPane.NO_OPTION);
    }


 }
 public static void showErrorMessage(String title,String str)
 {
    if (_shareDesktop!=null)
    {

        //int n = JOptionPane.showConfirmDialog(_shareDesktopPane,str,title,JOptionPane.YES_OPTION);
        JOptionPane.showMessageDialog(_shareDesktop,str,title,JOptionPane.OK_OPTION);
    }
    else
    {
        //int n = JOptionPane.showConfirmDialog(_shareDesktopPane,str,title,JOptionPane.YES_OPTION);
        JOptionPane.showMessageDialog(_shareDesktopFrame,str,title,JOptionPane.OK_OPTION);

    }

 }
/*
 public  static void showMessage(String title,String str)
 {
    if (_shareDesktop!=null)
    {
        JOptionPane.showInternalMessageDialog(_shareDesktopPane,str,title,JOptionPane.NO_OPTION);
    }
    else
    {
        //int n = JOptionPane.showConfirmDialog(_shareDesktopPane,str,title,JOptionPane.YES_OPTION);
        JOptionPane.showMessageDialog(_shareDesktopFrame,str,title,JOptionPane.NO_OPTION);
    }


 }
 public static void showErrorMessage(String title,String str)
 {
    if (_shareDesktop!=null)
    {

        //int n = JOptionPane.showConfirmDialog(_shareDesktopPane,str,title,JOptionPane.YES_OPTION);
        JOptionPane.showInternalMessageDialog(_shareDesktopPane,str,title,JOptionPane.OK_OPTION);
    }
    else
    {
        //int n = JOptionPane.showConfirmDialog(_shareDesktopPane,str,title,JOptionPane.YES_OPTION);
        JOptionPane.showMessageDialog(_shareDesktopFrame,str,title,JOptionPane.OK_OPTION);

    }

 }
*/

 public static void createBuildingMapInDesktop(int buildingGid)
 {
    if (_shareDesktop!=null)
    {
        _shareDesktop.createBuildingMap(buildingGid);
    }
    else
    {
        _shareDesktopFrame.createBuildingMap(buildingGid);
    }
 }
 public static void repaintDesktop()
 {
    if (_shareDesktop!=null)
    {
        _shareDesktop.getContentPane().repaint();
    }
    else
    {
        _shareDesktopFrame.getContentPane().repaint();
    }

 }
 public static boolean createFirstInDesktop()
 {
    if (_shareDesktop!=null)
    {
        _shareDesktop.createFirst();
    }
    else
    {
        _shareDesktopFrame.createFirst();
    }
    if(KConnectionManager.haveConnection())
    {
       return true;
    }
    else
    {
        return false;
    }
 }

  public static void exitProgram()
 {
    if (_shareDesktop!=null)     //Applet
    {

    }
    else
    {
      int n = JOptionPane.showConfirmDialog(_shareDesktopFrame,
    "Would you like to exit program now?",
    "EXIT PROGRAM",
    JOptionPane.YES_NO_OPTION);
      if (n ==JOptionPane.YES_OPTION)
      {
        KConnectionManager.closeConnection();
        System.exit(0);
      }
    }
 }

 public static void setLookAndFeel()
 {
    if (_shareDesktop!=null)     //Applet
    {
        SwingUtilities.updateComponentTreeUI(_shareDesktop);
    }
    else
    {
        SwingUtilities.updateComponentTreeUI(_shareDesktopFrame);
    }
 }
 public static void showAboutDialog()
 {
    if (_shareDesktop!=null)     //Applet
    {

    }
    else
    {
        JOptionPane.showMessageDialog(_shareDesktopFrame,"ระบบสารสนเทศอาคารและสถานที่(สจล.) 2543\nพัฒนาโดย นายศักดิ์ชาติ งามล้วน\nนายสุระศักดิ์ พณิชย์วิวัฒน์\nคณะวิศวกรรมศาสตร์\nสจล.","About",JOptionPane.NO_OPTION,new ImageIcon(KImageUtil.getImageUtil().getImage("About")));
    }

 }
 public static void createNewMap()
 {
    if (_shareDesktop!=null)     //Applet
    {

    }
    else
    {
        
    }

 }
}