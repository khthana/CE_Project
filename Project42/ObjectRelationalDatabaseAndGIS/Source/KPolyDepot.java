
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

public class KPolyDepot extends Vector{
  private boolean visible = true;
//  private Vector columnNames = new Vector();
//  private Vector attributesData = new Vector();
  KPolyDepot fence ;
  public void setFence(KPolyDepot v){
    fence = v;
  }
  public KPolyDepot getFence(){
    return fence;
  }
  public int getFenceSize(){
    return fence.size();
  }
  public KPoly getKPolyFenceAt(int i){
    return (KPoly)fence.elementAt(i);
  }
/*
  public void setColumnName(Vector v){
    columnNames = v;
  }
  public void setAttributes(Vector v){
    attributesData = v;
  }
  public Vector getColumnNames(){
    return columnNames;
  }
  public Vector getAttributes(){
    return attributesData;
  }
 */
  public KPolyDepot(){
    super();
  }
  public void setVisible(boolean v){
    visible = v;

  }
  public boolean isVisible(){
    return(visible);
  }
  public void setColor(Color c){
    for (int i=0;i<this.size();i++){
      KPoly k = (KPoly)this.elementAt(i);
      k.setColor(c);
    }
  }
  public int getNoFenceGid(int x1,int y1){
    return getGid(x1,y1);
  }

  public int getFenceGid(int x1,int y1){
     if (fence != null){
        return fence.getGid(x1,y1);
     } else {
        //System.out.println("fence didn't initialized");
        KShareObject.showErrorMessage("ERROR","FENCE LAYER IS NULL");
        return -1;
     }
  }
  public KPoly getNoFenceSelectedGid(int x1,int y1){
    for (int i=0;i<this.size();i++){
      KPoly k = (KPoly)this.elementAt(i);
      if (k.isContainPoint(x1,y1)){
        return k;
      }
    }
    return null;
  }
    public void setFenceSelectedGid(int gid){
    for (int i=0;i<fence.size();i++){
      KPoly k = (KPoly)fence.elementAt(i);
      if (k.getGid()==gid){
        if (!k.isHilight()){
          k.setHilight();
        } else {
          k.setUnHilight();
        }
      }
    }

    }
    public void setFenceSelectedGid(int gid,boolean selected){
    for (int i=0;i<fence.size();i++){
      KPoly k = (KPoly)fence.elementAt(i);
      if (k.getGid()==gid){
        if (selected){
          k.setHilight();
        } else {
          k.setUnHilight();
        }
      }
    }

    }


    public Vector  setFenceSelectedGid(int x1,int y1){
    Vector v = new Vector();
    boolean found = false;
    boolean hilight = false;
    int foundGid = -1;
    int oldPos = -1;

    for (int i=0;i<fence.size()&&!found;i++){
      KPoly k = (KPoly)fence.elementAt(i);
      if (k.isContainPoint(x1,y1)){
            v.addElement(new Integer(k.getGid()));
            found = true;
            oldPos = i;
            foundGid = k.getGid();
         if (!k.isHilight()){
            k.setHilight();
            hilight = true;
            v.addElement(new Boolean(true));
         }
         else
         {
            k.setUnHilight();
            hilight = false;
            v.addElement(new Boolean(false));

         }
      }

    if (foundGid!=-1)
    {
    for (int j=0;j<fence.size();j++){
      KPoly k2 = (KPoly)fence.elementAt(j);
      if (k2.getGid()==foundGid&&j!=oldPos)
      {
         if (hilight)
         {
            k2.setHilight();
         }
         else
         {
            k2.setUnHilight();
         }
      }
    }
    }

/*      if (found&&k.getGid()==foundGid)
      {
         if (!k.isHilight()){
            k.setHilight();
            v.addElement(new Boolean(true));
         }
         else
         {
            k.setUnHilight();
            v.addElement(new Boolean(false));

         }

      }
*/
    }
    return v;

    }

public KPoly getFenceSelectedGid(int x1,int y1){
    for (int i=0;i<fence.size();i++){
      KPoly k = (KPoly)fence.elementAt(i);
      if (k.isContainPoint(x1,y1)){
        return k;
      }
    }
    return null;
  }

  private  int getGid(int x1,int y1){
    for (int i=0;i<this.size();i++){
      KPoly k = (KPoly)this.elementAt(i);
      if (k.isContainPoint(x1,y1)){
        return k.getGid();
      }
    }
    return -1; // can't find exactly gid
  }

  public void add(KPoly k){
    this.addElement(k);
  }
  public void remove(KPoly k){
    this.removeElement(k);
  }


}




