

package KCOM;
//Title:        GIS
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Sakshart Ngamluan
//Company:      KMITL
//Description:  Your description

import java.awt.*;
import com.sun.java.swing.*;
import com.sun.java.swing.border.*;
import java.awt.event.*;
import java.beans.*;


public class KLayerButton extends JPanel implements Scrollable{

  private String layer_name = "layer_name";
  String tableName = "DUAL";
  KPolyDepot kPd;
  Color c = Color.gray;
  JPanel jPanel2 = new JPanel();
  JCheckBox jCheckBox1 = new JCheckBox();
  Border br, br2;
  Border selected_br;
  boolean selected =false;
  JPanel jPanel1 = new JPanel();
  BorderLayout borderLayout1 = new BorderLayout();
  KLayerPanel _kLayerPanel;

  void setLayerPanel(KLayerPanel kL){
    _kLayerPanel = kL;
  }
  public void setTableName(String t){
    tableName = t;
  }
  public String getTableName(){
    return tableName;
  }
  public KLayerButton(String l,String t,KPolyDepot kpd,Color c) {
    this.c = c;
    try  {
       setLayername(l);
       setTableName(t);
       kPd =kpd;
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }

  }
  public KLayerButton(String l,String t,KPolyDepot kpd) {
    try  {
       setLayername(l);
       setTableName(t);
       kPd =kpd;
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
    selected_br = BorderFactory.createBevelBorder(1,Color.yellow,Color.yellow);
    jPanel2.setLayout(borderLayout1);
    this.setMaximumSize(new Dimension(170, 80));
    this.setPreferredSize(new Dimension(170, 80));
    this.setBorder(br);
    this.setMinimumSize(new Dimension(170, 80));
    this.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        this_mouseClicked(e);
      }
    });
    jPanel2.setBorder(br2);
    jPanel2.setBounds(new Rectangle(12, 16, 144, 44));
    jCheckBox1.setText(layer_name);
    jCheckBox1.setSelected(true);
    jPanel1.setBackground(c);
    jPanel1.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jPanel1_mouseClicked(e);
      }
    });
    jCheckBox1.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        jCheckBox1_mouseClicked(e);
      }
    });
    this.setLayout(null);
    this.add(jPanel2, null);
    jPanel2.add(jCheckBox1, BorderLayout.NORTH);
    jPanel2.add(jPanel1, BorderLayout.CENTER);


  }

  public String getLayername() {
    return layer_name;
  }

  public void setLayername(String newSample) {
    layer_name = newSample;
    jCheckBox1.setText(newSample);
  }

  public boolean isChkSelected(){
    return(jCheckBox1.isSelected());
  }
  public void setChkSelected(boolean b){
    jCheckBox1.setSelected(b);
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

  public boolean isSelected() {
     return(selected);
  }
  public void setSelected(boolean t){
     if (t){
     _kLayerPanel.clearOneSelectedLayer();
     this.setBorder(selected_br);
     _kLayerPanel.showRoomDescription(_kLayerPanel.getIndexLayer(this));
     }else {
     this.setBorder(br);
     _kLayerPanel.removeRoomDescription();
     }
     selected = t;
     _kLayerPanel.clearSelectedPolygon();
  }

  void setLayerColor(Color c){
    kPd.setColor(c);
    jPanel1.setBackground(c);
  }

  void jPanel1_mouseClicked(MouseEvent e) {
    KColorPickerInternalFrame.showColorPickerInternalFrame(this);

  }
  void setLayerVisible(boolean v){
     jCheckBox1.setSelected(v);
     kPd.setVisible(v);
  }
  void repaintDisplay(){
   JRootPane jP= SwingUtilities.getRootPane(this);
   jP.repaint();
  }
  void jCheckBox1_mouseClicked(MouseEvent e) {
    kPd.setVisible(jCheckBox1.isSelected());
     //this.validateTree();
     //SwingUtilities.updateComponentTreeUI(this);
     JRootPane jP= SwingUtilities.getRootPane(this);
     jP.repaint();
  }
  void this_mouseClicked(MouseEvent e) {
     setSelected(!isSelected());
     _kLayerPanel.repaint();
     SwingUtilities.updateComponentTreeUI(_kLayerPanel);

  }

}


