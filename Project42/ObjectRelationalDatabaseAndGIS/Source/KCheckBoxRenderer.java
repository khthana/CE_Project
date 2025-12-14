
//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;
import java.util.*;
import java.awt.*;
import com.sun.java.swing.table.*;
import com.sun.java.swing.*;

class MyTableModel extends DefaultTableModel
{
        public MyTableModel(Vector d,Vector h)
        {
          super(d,h);
        }
        public boolean isCellEditable(int row, int col) {
            //Note that the data/cell address is constant,
            //no matter where the cell appears onscreen.
            if (col > 0) {
                return false;
            } else {
                return true;
            }
        }
}



class KCheckBoxRenderer extends JCheckBox implements TableCellRenderer
{
  public KCheckBoxRenderer()
  {
    super();
    setHorizontalAlignment(JCheckBox.CENTER);
    setOpaque(true);

  }
  public Component getTableCellRendererComponent(
                      JTable table,
                      Object value,
                      boolean isSelected,
                      boolean hasFocus,
                      int row,
                      int column)
 {
    Boolean b = (Boolean)value;
    if (b != null){
      setSelected(b.booleanValue());
    }
    if (isSelected)
    {
      setBackground(getForeground());
      setForeground(SystemColor.window);
    }
    else
    {
      setBackground(SystemColor.window);
      setForeground(getForeground());

    }
    return this;
 }
}
