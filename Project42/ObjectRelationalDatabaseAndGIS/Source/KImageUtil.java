
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description


package KCOM;
import java.awt.*;
import java.util.*;
import com.sun.java.swing.*;

public class KImageUtil {
static KImageUtil _kIU;
static Hashtable imgTable= new Hashtable();
  public static KImageUtil getImageUtil(){
    if (_kIU ==null){
      _kIU = new KImageUtil();
    }
    return _kIU; // make sure _kIU never null
  }
  public  void putImage(String picName,Object picImage){
    imgTable.put(picName,picImage);
  }
  public Image getImage(String picName){

    if (imgTable.containsKey(picName)){
            return (Image)imgTable.get(picName);

    } else {
      System.out.println("Can't return =>"+picName);
      return (Image)imgTable.get(new String("Question"));

    }
  }
}