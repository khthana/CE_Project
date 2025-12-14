
//Title:        Your Product Name
//Version:      
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.JTable;
import com.sun.java.swing.table.*;
import com.sun.java.swing.*;
import java.util.*;


public class KTable extends JTable{
JTable table;
TableSorter sorter;
  public JTable getTable(){
      return table;
  }
  public KTable(Vector data,Vector columnNames) {

            DefaultTableModel dT = new MyTableModel(data,columnNames);
            sorter = new TableSorter(dT); //ADDED THIS
            sorter.addMouseListenerToHeaderInTable(table); //ADDED THIS
            table = new JTable(sorter);
            TableColumnModel cModel = table.getColumnModel();
            TableColumn col = cModel.getColumn(0);
            KCheckBoxRenderer cB = new KCheckBoxRenderer();
            JCheckBox cbox = new JCheckBox();
            cbox.setHorizontalAlignment(JCheckBox.CENTER);
            DefaultCellEditor editor = new DefaultCellEditor(cbox);
            col.setCellRenderer(cB);
            col.setCellEditor(editor);
            table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
  }

}


   /*
           JTable jTable = kRoomDescription.getDescriptionAt(layerIndex);

           kRoomDescriptionScrollPane = JTable.createScrollPaneForTable(jTable);
           jTable.setPreferredScrollableViewportSize(new Dimension(100,50));
           this.add(kRoomDescriptionScrollPane, BorderLayout.SOUTH);
           SwingUtilities.updateComponentTreeUI(this);
*/


