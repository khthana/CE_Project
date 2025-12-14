package KCOM;

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import java.util.Vector;
import com.sun.java.swing.*;
import com.sun.java.accessibility.*;

public class KPoly {
int gid;
float x[];
float y[];
int count;
Color color;
Color prevColor = Color.white;
boolean hilight =false;
  public KPoly(int gid,float x[],float y[],int c,Color color){
  this.gid = gid;
  this.x = x;
  this.y = y;
  this.count = c;
  this.color = color;
  }
  public void setHilight(){
    hilight = true;
    prevColor = color;
    setColor(Color.yellow);
  }
  public void setUnHilight(){
    hilight = false;
    setColor(prevColor);
  }
  public boolean  isHilight(){
    return hilight;
  }
  public void setColor(Color c){
    color = c;
    prevColor = c;
  }
  public Color getColor(){
    return(color);
  }
  public int[] getX(float z){
  int xz[] = new int[count];
    for (int i=0;i<count;i++){
//      Float dummy = new Float (z*x[i]);
//      xz[i] =  dummy.intValue();
        xz[i] = Math.round(z*x[i]);
    }
  return(xz);
  }
  public int[] getY(float z){
  int yz[] =  new int[count];
    for (int i=0;i<count;i++){
//      Float dummy = new Float(z*y[i]);
//      yz[i] = dummy.intValue();
        yz[i] = Math.round(z*y[i]);
    }
  return(yz);
  }

  public float [] getX(){
  return(x);
  }
  public float []getY(){
  return (y);
  }
  public int getCount(){
  return (count);
  }
  public int getGid(){
  return (gid);
  }
  public boolean isContainPoint(int ax, int ay){
  Polygon poly = new Polygon(getX(1f),getY(1f),count);
  return(poly.inside(ax,ay));
  }
  public Point getCenterPoint(float z){
  Polygon poly = new Polygon(getX(z),getY(z),count);
  Rectangle r = poly.getBoundingBox();
  return new Point(r.getLocation().x,r.getLocation().y);
  }



}
