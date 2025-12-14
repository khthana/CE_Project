
//Title:       Your Product Name
//Version:
//Copyright:   Copyright (c) 1998
//Author:      Sakshart Ngamluan
//Company:     KMITL
//Description: Your description
package KCOM;

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import java.util.Vector;
import com.sun.java.swing.*;
import com.sun.java.accessibility.*;
public class KDisplayPanel extends JPanel implements Scrollable{
  BorderLayout borderLayout1 = new BorderLayout();
  Vector dataCollector = new Vector();
  KPolyDepot selectedPolygon ;
  boolean selected= false;
  int mousePressedX = 0;
  private float zoomRatio= 1;

  public void setSelectedPolygon(boolean b,KPolyDepot s){
    selected = b;
    selectedPolygon = s;
  }
  public void addData(KPolyDepot kPd){
    dataCollector.addElement((KPolyDepot)kPd);
  }
  public void setDataElementColor(int i,Color c){
    KPolyDepot ktmp =(KPolyDepot)dataCollector.elementAt(i);
    ktmp.setColor(c);
  }

  public void setZoomRatio(float z){
    zoomRatio = z;
  }
  public float getZoomRatio(){
    return(zoomRatio);
  }
  public void setLayerColor(int i,Color c){
    setDataElementColor(i,c);
  }


  public KDisplayPanel() {
    try  {

      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.setPreferredSize(new Dimension(1500, 1500));
    this.setBackground(Color.black);
    this.setMinimumSize(new Dimension(1500, 1500));
/*
    this.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mousePressed(MouseEvent e) {
        this_mousePressed(e);
      }
      public void mouseEntered(MouseEvent e) {
        this_mouseEntered(e);
      }
      public void mouseClicked(MouseEvent e) {
        display_mouseClicked(e);
      }
      public void mouseExited(MouseEvent e) {
        this_mouseExited(e);
      }
    });

    this.addMouseMotionListener(new java.awt.event.MouseMotionAdapter() {
      public void mouseDragged(MouseEvent e) {
        this_mouseDragged(e);
      }
    });
*/

    this.setLayout(borderLayout1);

  }
  public void paintComponent(Graphics g){
     KPoly tmp;
     KPolyDepot tmpD;
     super.paintComponent(g);
     g.setColor(Color.white);
     //String zStr = " VIEW SIZE="+ Integer.toString(Math.round(100*getZoomRatio()))+" %";
     //g.drawString(zStr,5,15);
     for (int j=0;j<dataCollector.size();j++){
        tmpD = (KPolyDepot)dataCollector.elementAt(j);

     if (tmpD.isVisible()){
     for (int i=0;i<tmpD.size();i++){
        tmp = (KPoly)tmpD.elementAt(i);
        g.setColor(tmp.getColor());
        g.drawPolyline(tmp.getX(zoomRatio),tmp.getY(zoomRatio),tmp.getCount());
     }
     }
     }

     for (int j=0;j<dataCollector.size();j++){
     KPolyDepot tmpFence = (KPolyDepot)dataCollector.elementAt(j);
     if (tmpFence != null){
     for (int p=0;p<tmpFence.getFenceSize()&&tmpFence.isVisible();p++){
       tmp = (KPoly)tmpFence.getKPolyFenceAt(p);
       if (tmp.isHilight()){
         g.setColor(tmp.getColor());
         g.fillPolygon(tmp.getX(zoomRatio),tmp.getY(zoomRatio),tmp.getCount());
         Point pT = tmp.getCenterPoint(zoomRatio);
         g.setColor(Color.green);
         g.drawString("GID = "+tmp.getGid(),pT.x,pT.y);

       }
     }}

     }


/*
     if (selected && selectedPolygon!=null){
     tmpD = selectedPolygon;
     //tmpD.setColor(Color.yellow);
     for (int i=0;i<tmpD.size();i++){
        tmp = (KPoly)tmpD.elementAt(i);
        g.setColor(Color.yellow);
        g.fillPolygon(tmp.getX(zoomRatio),tmp.getY(zoomRatio),tmp.getCount());
        Point p = tmp.getCenterPoint(zoomRatio);
        g.setColor(Color.green);
        g.drawString("GID = "+tmp.getGid(),p.x,p.y);
     }
     }
*/
    }

    public Dimension getPreferredScrollableViewportSize(){
             return getPreferredSize();
    }

    public int getScrollableUnitIncrement(Rectangle visibleRect, int orientation, int direction){
        switch(orientation) {
        case SwingConstants.VERTICAL:
            return visibleRect.height / 25;
        case SwingConstants.HORIZONTAL:
            return visibleRect.width / 25;
        default:
            throw new IllegalArgumentException("Invalid orientation: " + orientation);
        }

    }

    public int getScrollableBlockIncrement(Rectangle visibleRect, int orientation, int direction){
         switch(orientation) {
        case SwingConstants.VERTICAL:
            return visibleRect.height;
        case SwingConstants.HORIZONTAL:
            return visibleRect.width;
        default:
            throw new IllegalArgumentException("Invalid orientation: " + orientation);
        }


    }

    public boolean getScrollableTracksViewportWidth(){
     return false;
    }
    public boolean getScrollableTracksViewportHeight(){
    return false;
    }



}

