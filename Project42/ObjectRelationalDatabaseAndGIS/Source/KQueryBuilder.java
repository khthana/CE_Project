
//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import com.sun.java.swing.border.*;
import com.sun.java.swing.event.*;
import java.awt.event.*;
import java.util.*;

public class KQueryBuilder extends JPanel {
  JScrollPane valuesSP ;
  JPanel jPanel1 = new JPanel();
  BorderLayout borderLayout1 = new BorderLayout();
  JScrollPane fieldSP ;
  JPanel jPanel2 = new JPanel();
  JButton equalBtn = new JButton();
  GridLayout gridLayout1 = new GridLayout();
  JButton andBtn = new JButton();
  JButton notEqualBtn = new JButton();
  JButton greaterBtn = new JButton();
  JButton greaterEqualBtn = new JButton();
  JButton orBtn = new JButton();
  JButton lessBtn = new JButton();
  JButton lessEqualBtn = new JButton();
  JButton notBtn = new JButton();
  JButton openParenBtn = new JButton();
  JButton closeParenBtn = new JButton();
  JButton clearBtn = new JButton();
  JScrollPane jScrollPane3 = new JScrollPane();
  Border fieldBorder, valuesBorder, operatorBorder, queryBorder;
  JTextField queryBoard = new JTextField();

  Vector fieldVector,valuesVector,thaiField;
  JList fieldList,valuesList;
  JButton okBtn = new JButton();
  BorderLayout borderLayout2 = new BorderLayout();
  KViewerPanel kViewerPanel;
  String tableName;
  int layerIndex = -1;

  public KQueryBuilder(KViewerPanel kV,Vector field,Vector thaiField,String tname,int layerindex) {
    try  {
      kViewerPanel = kV;
      fieldVector = field;
      tableName = tname;
      this.thaiField = thaiField;
      layerIndex = layerindex;
      fieldList = new JList(thaiField);
      fieldList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      fieldSP = new JScrollPane(fieldList);
      valuesList = new JList();
      valuesList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      valuesSP = new JScrollPane(valuesList);
      jbInit();

    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  public KQueryBuilder(KViewerPanel kV,Vector field,Vector thaiField,String tname) {
    try  {
      kViewerPanel = kV;
      fieldVector = field;
      tableName = tname;
      this.thaiField = thaiField;

      fieldList = new JList(thaiField);
      fieldList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      fieldSP = new JScrollPane(fieldList);
      valuesList = new JList();
      valuesList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      valuesSP = new JScrollPane(valuesList);
      jbInit();

    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    fieldBorder = BorderFactory.createTitledBorder("FIELD");
    valuesBorder = BorderFactory.createTitledBorder("VALUES");
    operatorBorder = BorderFactory.createTitledBorder("OPERATOR");
    queryBorder = BorderFactory.createTitledBorder("QUERY BOARD");

    this.setLayout(borderLayout1);
    borderLayout1.setVgap(2);
    fieldSP.setPreferredSize(new Dimension(100, 150));
    jPanel2.setBorder(operatorBorder);
    jPanel2.setLayout(gridLayout1);
    equalBtn.setText("=");
    equalBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        equalBtn_mouseClicked(e);
      }
    });
    gridLayout1.setColumns(3);
    gridLayout1.setVgap(2);
    andBtn.setText("AND");
    andBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        andBtn_mouseClicked(e);
      }
    });
    notEqualBtn.setText("<>");
    notEqualBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        notEqualBtn_mouseClicked(e);
      }
    });
    greaterBtn.setText(">");
    greaterBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        greaterBtn_mouseClicked(e);
      }
    });
    greaterEqualBtn.setText(">=");
    greaterEqualBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        greaterEqualBtn_mouseClicked(e);
      }
    });
    orBtn.setText("OR");
    orBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        orBtn_mouseClicked(e);
      }
    });
    lessBtn.setText("<");
    lessBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        lessBtn_mouseClicked(e);
      }
    });
    lessEqualBtn.setText("<=");
    lessEqualBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        lessEqualBtn_mouseClicked(e);
      }
    });
    notBtn.setText("NOT");
    notBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        notBtn_mouseClicked(e);
      }
    });
    openParenBtn.setText("(");
    openParenBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        openParenBtn_mouseClicked(e);
      }
    });
    closeParenBtn.setText(")");
    closeParenBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        closeParenBtn_mouseClicked(e);
      }
    });
    jScrollPane3.setPreferredSize(new Dimension(400, 80));
    jScrollPane3.setBorder(queryBorder);
    okBtn.setText("OK");
    okBtn.setPreferredSize(new Dimension(300, 20));
    okBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        okBtn_mouseClicked(e);
      }
    });
    clearBtn.setText("clear");
    clearBtn.setPreferredSize(new Dimension(100, 20));
    clearBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        clearBtn_mouseClicked(e);
      }
    });
    gridLayout1.setRows(4);
    gridLayout1.setHgap(2);

    jPanel1.setLayout(borderLayout2);
    this.setPreferredSize(new Dimension(400, 320));
    valuesSP.setPreferredSize(new Dimension(100, 150));
    jPanel1.setPreferredSize(new Dimension(400, 110));
    borderLayout1.setHgap(2);
    this.add(jPanel1, BorderLayout.SOUTH);
    jPanel1.add(jScrollPane3, BorderLayout.NORTH);
    jScrollPane3.getViewport().add(queryBoard, null);
    jPanel1.add(clearBtn, BorderLayout.CENTER);
    jPanel1.add(okBtn, BorderLayout.EAST);
    this.add(valuesSP, BorderLayout.EAST);
    this.add(fieldSP, BorderLayout.WEST);
    this.add(jPanel2, BorderLayout.CENTER);
    jPanel2.add(equalBtn, null);
    jPanel2.add(notEqualBtn, null);
    jPanel2.add(andBtn, null);
    jPanel2.add(greaterBtn, null);
    jPanel2.add(greaterEqualBtn, null);
    jPanel2.add(orBtn, null);
    jPanel2.add(lessBtn, null);
    jPanel2.add(lessEqualBtn, null);
    jPanel2.add(notBtn, null);
    jPanel2.add(openParenBtn, null);
    jPanel2.add(closeParenBtn, null);

    fieldSP.setBorder(fieldBorder);
    valuesSP.setBorder(valuesBorder);
    fieldList.addListSelectionListener(new ListSelectionListener(){
    public void valueChanged(ListSelectionEvent e) {
        fieldList_select(e);
    }});

    fieldList.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        fieldList_mouseClicked(e);
      }
    });


  }
  void fieldList_mouseClicked(MouseEvent e)
  {
      if (e.getClickCount()>1)
      {
                  int index = fieldList.getSelectedIndex();
                  addTextToQueryBoard((String)fieldVector.elementAt(index));

      }
  }
  void fieldList_select(ListSelectionEvent e)
  {
              if (e.getValueIsAdjusting())
                  return;

              JList theList = (JList)e.getSource();
              if (theList.isSelectionEmpty()) {

              } else {
                  int index = theList.getSelectedIndex();
                  getFieldValues((String)fieldVector.elementAt(index));

              }

  }
  void getFieldValues(String colName)
  {

        if (kViewerPanel.getTheme()==KViewerPanel.ROOM_THEME)
        {
        valuesVector = kViewerPanel.getRoomColumnValues(colName);
        }
        else if (kViewerPanel.getTheme()==KViewerPanel.BUILDING_THEME)
        {
            if (kViewerPanel.getOneSelectedLayer()==0)
            {
              valuesVector = kViewerPanel.getRoomColumnValues(colName);
            }
            else
            {
              if (kViewerPanel.getOneSelectedLayer()!=-1)
              {
              valuesVector = kViewerPanel.getColumnValues(tableName,colName);
              }
            }
        }

        valuesList = new JList(valuesVector);
        addListenerToValuesList();

        valuesSP.setViewportView(valuesList);
        valuesSP.revalidate();
  }
  void addListenerToValuesList()
  {
    valuesList.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        valuesList_mouseClicked(e);
      }
    });
  }
  void valuesList_mouseClicked(MouseEvent e)
  {
      if (e.getClickCount()>1)
      {
                  int index = valuesList.getSelectedIndex();
                  String r = new String((String)valuesVector.elementAt(index));
                  int indexField = fieldList.getSelectedIndex();
                  String f = (String)fieldVector.elementAt(indexField);
                  String p = new String(r);
                  /*
                  if (f.equalsIgnoreCase("ROOMTYPECODE"))
                  {
                  char[] c = new char[r.length()-2];
                  r.getChars(1,r.length()-1,c,0);
                  p = Integer.toString(KConnectionManager.getRoomTypeCode(new String(c)));
                  }
                  */
                  addTextToQueryBoard(p);
      }
  }


  void addTextToQueryBoard(String b)
  {
    String qTxt = queryBoard.getText();
    int caretPos =queryBoard.getCaretPosition();
    char[] a = null;
    char[] c = null;
    if (caretPos>0)
     a = new char[caretPos];
    if (caretPos != qTxt.length())
     c = new char[qTxt.length()-caretPos];

    if (a == null) // means start of txt
    {
      queryBoard.setText(b+" "+queryBoard.getText());
      return;
    }
    if (c == null) // means end of txt
    {
      queryBoard.setText(queryBoard.getText()+" "+b);
      return;
    }
    // means between start and end
    qTxt.getChars(0,caretPos,a,0);
    qTxt.getChars(caretPos,qTxt.length(),c,0);
    queryBoard.setText(a+" "+b+" "+c);

  }

  void equalBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard("=");
  }

  void notEqualBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard("<>");
  }

  void greaterBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard(">");
  }

  void greaterEqualBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard(">=");
  }

  void lessBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard("<");
  }

  void lessEqualBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard("<=");
  }

  void andBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard("AND");
  }

  void orBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard("OR");
  }

  void notBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard("NOT");
  }

  void openParenBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard("(");
  }

  void closeParenBtn_mouseClicked(MouseEvent e) {
     addTextToQueryBoard(")");
  }

  void okBtn_mouseClicked(MouseEvent e) {
    if (kViewerPanel.getTheme()==KViewerPanel.BUILDING_THEME)
    {
    

      if (kViewerPanel.getOneSelectedLayer()==0)
      {
      kViewerPanel.showQueryBuildingResult(queryBoard.getText());
      }
      else
      {
        if (kViewerPanel.getOneSelectedLayer()!=-1)
        {
          kViewerPanel.showQueryAnyResult(tableName,queryBoard.getText(),layerIndex);
        }
      }



    }
    else if (kViewerPanel.getTheme()==KViewerPanel.ROOM_THEME)
    {
      kViewerPanel.showQueryRoomResult(queryBoard.getText());
    }

  }

  void clearBtn_mouseClicked(MouseEvent e) {
    queryBoard.setText("");
  }

}


