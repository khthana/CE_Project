
//Title:        GIS
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import com.sun.java.swing.border.*;


public class Bean2 extends JPanel implements Scrollable{
  private String layer_name = "layer_name";
  Color c = Color.blue;
  JPanel jPanel2 = new JPanel();
  GridLayout gridLayout1 = new GridLayout();
  JCheckBox jCheckBox1 = new JCheckBox();
  JPanel jPanel1 = new JPanel();
  Border br;
  Border br2;




  public Bean2() {
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  private void jbInit() throws Exception {
    this.setSize(165,55);
    br = BorderFactory.createBevelBorder(0);
    br2 = BorderFactory.createLineBorder(Color.black);
    jPanel2.setLayout(gridLayout1);
    this.setMaximumSize(new Dimension(165, 55));
    this.setPreferredSize(new Dimension(165, 55));
    this.setBorder(br);
    this.setMinimumSize(new Dimension(165, 55));
    jPanel2.setBorder(br2);
    jPanel2.setBounds(new Rectangle(12, 7, 144, 44));
    gridLayout1.setRows(2);
    jCheckBox1.setText(layer_name);
    jPanel1.setBackground(c);
    this.setLayout(null);
    this.add(jPanel2, null);
    jPanel2.add(jCheckBox1, null);
    jPanel2.add(jPanel1, null);


  }

  public String getLayer_name() {
    return layer_name;
  }

  public void setLayer_name(String newSample) {
    layer_name = newSample;
    jCheckBox1.setText(newSample);
  }

   /**
     * Returns the preferred size of the viewport for a view component.
     * For example the preferredSize of a JList component is the size
     * required to acommodate all of the cells in its list however the
     * value of preferredScrollableViewportSize is the size required for
     * JList.getVisibleRowCount() rows.   A component without any properties
     * that would effect the viewport size should just return
     * getPreferredSize() here.
     *
     * @return The preferredSize of a JViewport whose view is this Scrollable.
     * @see JViewport#getPreferredSize
     */
    public Dimension getPreferredScrollableViewportSize(){
             return getPreferredSize();
//     return(new Dimension(165,55));
    }


    /**
     * Components that display logical rows or columns should compute
     * the scroll increment that will completely expose one new row
     * or column, depending on the value of orientation.  Ideally,
     * components should handle a partially exposed row or column by
     * returning the distance required to completely expose the item.
     * <p>
     * Scrolling containers, like JScrollPane, will use this method
     * each time the user requests a unit scroll.
     *
     * @param visibleRect The view area visible within the viewport
     * @param orientation Either SwingConstants.VERTICAL or SwingConstants.HORIZONTAL.
     * @param direction Less than zero to scroll up/left, greater than zero for down/right.
     * @return The "unit" increment for scrolling in the specified direction
     * @see JScrollBar#setUnitIncrement
     */
    public int getScrollableUnitIncrement(Rectangle visibleRect, int orientation, int direction){
        switch(orientation) {
        case SwingConstants.VERTICAL:
            return visibleRect.height / 10;
        case SwingConstants.HORIZONTAL:
            return visibleRect.width / 10;
        default:
            throw new IllegalArgumentException("Invalid orientation: " + orientation);
        }

    }


    /**
     * Components that display logical rows or columns should compute
     * the scroll increment that will completely expose one block
     * of rows or columns, depending on the value of orientation.
     * <p>
     * Scrolling containers, like JScrollPane, will use this method
     * each time the user requests a block scroll.
     *
     * @param visibleRect The view area visible within the viewport
     * @param orientation Either SwingConstants.VERTICAL or SwingConstants.HORIZONTAL.
     * @param direction Less than zero to scroll up/left, greater than zero for down/right.
     * @return The "block" increment for scrolling in the specified direction.
     * @see JScrollBar#setBlockIncrement
     */
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


    /**
     * Return true if a viewport should always force the width of this
     * Scrollable to match the width of the viewport.  For example a noraml
     * text view that supported line wrapping would return true here, since it
     * would be undesirable for wrapped lines to disappear beyond the right
     * edge of the viewport.  Note that returning true for a Scrollable
     * whose ancestor is a JScrollPane effectively disables horizontal
     * scrolling.
     * <p>
     * Scrolling containers, like JViewport, will use this method each
     * time they are validated.
     *
     * @return True if a viewport should force the Scrollables width to match its own.
     */
    public boolean getScrollableTracksViewportWidth(){
     return false;
    }

    /**
     * Return true if a viewport should always force the height of this
     * Scrollable to match the height of the viewport.  For example a
     * columnar text view that flowed text in left to right columns
     * could effectively disable vertical scrolling by returning
     * true here.
     * <p>
     * Scrolling containers, like JViewport, will use this method each
     * time they are validated.
     *
     * @return True if a viewport should force the Scrollables height to match its own.
     */
    public boolean getScrollableTracksViewportHeight(){
    return false;
    }
}


