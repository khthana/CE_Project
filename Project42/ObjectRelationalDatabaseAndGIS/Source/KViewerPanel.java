
//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;

import java.awt.*;
import com.sun.java.swing.*;
import com.sun.java.swing.JComponent.*;
import com.sun.java.swing.event.*;
import com.sun.java.swing.table.*;
import java.awt.event.*;
import java.util.*;

public class KViewerPanel extends JPanel implements Runnable{

  //int orgId, buildingId;
  //boolean isMain = false;
  static   final int BUILDING_THEME = 1;
  static   final int ROOM_THEME = 2;
  static   final int NEW_THEME = 3;
  int theme = 0;


  BorderLayout borderLayout1 = new BorderLayout();
  KDisplayPanel kDisplayPanel;
  KLayerPanel kLayerPanel = new KLayerPanel(this);
  KDisplayScrollPane kDisplayScrollPane ;
  KRoomDescription kRoomDescription= new KRoomDescription();
  JScrollPane kRoomDescriptionScrollPane;
  private float minZoomRatio = 1f;
  private float maxZoomRatio = 10f;
  private float adjustRatioValue = 1f;
  //001 JPanel tablePanel = new JPanel();
  //001 JPanel tableToolBarPanel = new JPanel();
  BorderLayout borderLayout2 = new BorderLayout();
  FlowLayout flowLayout1 = new FlowLayout();
  JButton updateBtn = new JButton();
  JButton startEditBtn = new JButton();
  Vector tmpV = new Vector();
  Vector layerNameFactory = new Vector();
  private Cursor waitCursor = new Cursor(Cursor.WAIT_CURSOR);
  private Cursor defaultCursor = new Cursor(Cursor.DEFAULT_CURSOR);
  private Cursor handCursor = new Cursor(Cursor.HAND_CURSOR);
  private Thread workingThread;
  private boolean haveWork = false;

  public KViewerPanel(String type){
    //if (type.equalsIgnoreCase("MAIN")){
    //kDisplayPanel = new KMainDisplayPanel();
    //} else {
    kDisplayPanel= new KDisplayPanel();
    //}
    try  {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    //------------------------------------------------------
    // kDisplayScrollPane.setRowHeaderView(new JLabel(new ImageIcon(KImageUtil.getImageUtil().getImage("VerticalRule"))));
    // kDisplayScrollPane.setColumnHeaderView(new JLabel(new ImageIcon(KImageUtil.getImageUtil().getImage("HorizontalRule"))));
    //------------------------------------------------------

  }
  public KViewerPanel() {
    this("NULL");
  }

  void jbInit() throws Exception {

          workingThread = new Thread(this);
          workingThread.setPriority(Thread.MAX_PRIORITY);

          workingThread.start();
          haveWork = true;
          workingThread.suspend();



    kDisplayScrollPane = new KDisplayScrollPane(kDisplayPanel);
    this.setLayout(borderLayout1);
    //001 tablePanel.setPreferredSize(new Dimension(458, 175));
    //001 tablePanel.setLayout(borderLayout2);
    //001 tablePanel.setMinimumSize(new Dimension(458, 175));
    updateBtn.setText("UPDATE");
    updateBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        updateBtn_mouseClicked(e);
      }
    });
    startEditBtn.setText("START EDIT");
    startEditBtn.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseClicked(MouseEvent e) {
        startEditBtn_mouseClicked(e);
      }
    });
    /*001
    tableToolBarPanel.setLayout(flowLayout1);
    tablePanel.add(tableToolBarPanel,BorderLayout.NORTH);
    tableToolBarPanel.add(startEditBtn, null);
    tableToolBarPanel.add(updateBtn, null);
    */

    this.add(kLayerPanel, BorderLayout.EAST);
    this.add(kDisplayScrollPane, BorderLayout.CENTER);


    kDisplayPanel.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mousePressed(MouseEvent e) {
        kDisplayPanel_mousePressed(e);
      }
      public void mouseEntered(MouseEvent e) {
        kDisplayPanel_mouseEntered(e);
      }
      public void mouseClicked(MouseEvent e) {
        kDisplayPanel_mouseClicked(e);
      }
      public void mouseExited(MouseEvent e) {
        kDisplayPanel_mouseExited(e);
      }
      public void mouseMoved(MouseEvent e) {
        kDisplayPanel_mouseMoved(e);
      }

    });

    kDisplayPanel.addMouseMotionListener(new java.awt.event.MouseMotionAdapter() {
      public void mouseDragged(MouseEvent e) {
        kDisplayPanel_mouseDragged(e);
      }
    });

  }
  public void setTheme(int themeType)
  {
    theme = themeType;
  }
  public int  getTheme()
  {
    return theme;
  }
  public void setZoomRatio(float z){
    kDisplayPanel.setZoomRatio(z);

  }

  public float getMinZoomRatio(){
    return minZoomRatio;
  }
  public float getMaxZoomRatio(){
    return maxZoomRatio;
  }
  public void setMinZoomRatio(float z){
    minZoomRatio = z;
  }

  public void setMaxZoomRatio(float z){
    maxZoomRatio = z;
  }
  public boolean canZoomOut(){
    return getZoomRatio()>getMinZoomRatio();
  }
  public boolean canZoomIn(){
    return getZoomRatio()<getMaxZoomRatio();
  }
  public float  getZoomRatio(){
    return kDisplayPanel.getZoomRatio();
  }
  public void  setAdjustRatioValue(float z){
    adjustRatioValue = z;
  }
  public float  getAdjustRatioValue(){
    return adjustRatioValue;
  }

  public void setDisplayCursor(Cursor c){
     kDisplayPanel.setCursor(c);
  }
  public void setDisplaySize(int w,int h){
     kDisplayPanel.setPreferredSize(new Dimension(w,h));
     kDisplayScrollPane.repaint();
  }
  public void addMainData(String layerName,String tableName,String infoTableName,Color c){
    KPolyDepot kpd = KConnectionManager.getConnectionManager().getQuery(tableName);
    kDisplayPanel.addData(kpd);
    layerNameFactory.addElement(layerName);
    kLayerPanel.addData(new KLayerButton(layerName,tableName,kpd,c));
    kRoomDescription.addDescription(infoTableName,getTableDescription(infoTableName));

  }
/*
  public void addData(String layerName,String tableName,Color c){
    KPolyDepot kpd = KConnectionManager.getConnectionManager().getQuery(tableName);
    kDisplayPanel.addData(kpd);
    layerNameFactory.addElement(layerName);
    kLayerPanel.addData(new KLayerButton(layerName,tableName,kpd,c));
    kRoomDescription.addDescription(tableName,getRoomDescription(tableName));
  }
  public void addData(String layerName,String tableName){
    KPolyDepot kpd = KConnectionManager.getConnectionManager().getQuery(tableName);
    kDisplayPanel.addData(kpd);
    layerNameFactory.addElement(layerName);
    kLayerPanel.addData(new KLayerButton(layerName,tableName,kpd));
    kRoomDescription.addDescription(tableName,getRoomDescription(tableName));
  }
*/
  public void addData(String layerName,String tableName,boolean visible){
    KPolyDepot kpd = KConnectionManager.getConnectionManager().getQuery(tableName);
    kDisplayPanel.addData(kpd);
    layerNameFactory.addElement(layerName);
    KLayerButton kLB1 = new KLayerButton(layerName,tableName,kpd);
    kLB1.setLayerVisible(visible);
    kLayerPanel.addData(kLB1);
    kRoomDescription.addDescription(tableName,getRoomDescription(tableName));
  }

  public void setLayerColor(int i,Color c){
    kDisplayPanel.setLayerColor(i,c);
  }
  public void setLayerVisible(boolean v){

  }

//---------------------------------------------------------------
  void kDisplayPanel_mouseDragged(MouseEvent e) {

  }

  void kDisplayPanel_mousePressed(MouseEvent e) {

  }
  void kDisplayPanel_mouseMoved(MouseEvent e){


  }
  void kDisplayPanel_mouseEntered(MouseEvent e) {
      int toolCode =KShareObject.getShareObject().getUserToolCode();
      int cursorCode = Cursor.DEFAULT_CURSOR;
      switch(toolCode){
      case KUserToolBarPanel.INSIDEBUILDING_TOOL:cursorCode = Cursor.HAND_CURSOR;
      break;
      case KUserToolBarPanel.OBJECTINFO_TOOL:cursorCode = Cursor.HAND_CURSOR;
      break;
      case KUserToolBarPanel.OBJECTTOTABLE_TOOL:cursorCode = Cursor.HAND_CURSOR;
      break;
      default:
      }
      kDisplayPanel.setCursor(new Cursor(cursorCode));
  }

   void showRoomMap(MouseEvent e){
      if (getTheme()==KViewerPanel.BUILDING_THEME)
      {
          int r = kLayerPanel.getOneSelectedLayer();
          if (r==0){ // first layer = kmitl building layer
          KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(r);
          int kGid = ktest.getFenceGid(Math.round(e.getX()/kDisplayPanel.getZoomRatio()),Math.round(e.getY()/kDisplayPanel.getZoomRatio()));
          if (kGid>=0)
          {
              KShareObject.createBuildingMapInDesktop(kGid);
          }
          else
          {
              KShareObject.showErrorMessage("RESULT","ไม่พบ");
          }

          }
          else
          {
              KShareObject.showErrorMessage("ERROR","กรุณาเลือก LAYER แรกซึ่งเป็น LAYER อาคาร");
          }
      }
      else
      {
          KShareObject.showErrorMessage("ERROR","TOOL นี้ใช้กับ แผนที่อาคารหลักเท่านั้น");
      }

   }


  void createTableInternalFrame(String title,JTable jTable)
  {
   jTable.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
   JScrollPane jScrollPane = JTable.createScrollPaneForTable(jTable);
   jTable.setPreferredScrollableViewportSize(new Dimension(400,300));
   JInternalFrame uf = new JInternalFrame(title);
   jScrollPane.setSize(400,300);
   uf.setSize(410,350);
   uf.setBounds(0,0,410,350);
   uf.getContentPane().setLayout(new BorderLayout());
   uf.getContentPane().add(jScrollPane,BorderLayout.CENTER);
   uf.show(true);
   uf.setResizable(true);
   uf.setClosable(true);
   uf.setIconifiable(true);
   KShareObject.getDesktopPane().add(uf, JLayeredPane.MODAL_LAYER);
   uf.moveToFront();
  }


   void showRoomReservation(MouseEvent e)
   {
          KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(kLayerPanel.getOneSelectedLayer());
          int kGid = ktest.getFenceGid(Math.round(e.getX()/kDisplayPanel.getZoomRatio()),Math.round(e.getY()/kDisplayPanel.getZoomRatio()));
          if (kGid>=0)
          {
              int layerIndex = getOneSelectedLayer();
              if (layerIndex>=0)
              {
              String roomCode = KConnectionManager.getRoomCodeFromLayerNameAndRoomGid(kRoomDescription.getTableName(layerIndex),kGid);
                  if (roomCode!=null)
                  {

                  Vector d = KConnectionManager.getRoomReservationData(roomCode);
                  DefaultTableModel dT = new MyTableModel((Vector)d.elementAt(0),(Vector)d.elementAt(1));
                  TableSorter sorter = new TableSorter(dT); //ADDED THIS
                  JTable jTable = new JTable(sorter);
                  setUpIntegerEditor(jTable);
                  createTableInternalFrame("ROOM RESERVATION",jTable);
                  }
                  else
                  {
                    KShareObject.showMessage("NOT FOUND","ไม่พบ");
                  }
              }

          }

   }
   void showAttributes(MouseEvent e)
   {
          KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(kLayerPanel.getOneSelectedLayer());
          int kGid = ktest.getFenceGid(Math.round(e.getX()/kDisplayPanel.getZoomRatio()),Math.round(e.getY()/kDisplayPanel.getZoomRatio()));
          if (kGid>=0){
            int layerIndex =kLayerPanel.getOneSelectedLayer();
            if (layerIndex>=0)
            {
               JTable jT = kRoomDescription.getDescriptionAt(layerIndex);

               boolean found = false;

               for (int i=0;i<jT.getRowCount() && !found;i++){
                  int gidColumn = kRoomDescription.getGidColumnAt(layerIndex);//jT.getColumnModel().getColumnIndex("ROOM_GID");
                  if (gidColumn ==-1)
                  {
                    KShareObject.showErrorMessage("ERROR","ไม่พบ GID COLUMN");
                    return;
                  }

                  int viewColumn = jT.getColumnModel().getColumnIndex("view");
                  Integer tmp = null;
                  try{
                  tmp = (Integer)jT.getValueAt(i,gidColumn);
                  } catch(Exception eX){
                  }

                  if (tmp.intValue()==kGid){
                    found = true;
                    String result= "";
                    for (int j=0;j<jT.getColumnCount();j++){
                      if (j!=viewColumn){

                        if (jT.getColumnClass(j).getName().equals("java.lang.Integer")){
                            try {
                            Integer tmpI = (Integer)jT.getValueAt(i,j);
                            result=result+jT.getColumnName(j)+"="+tmpI.toString()+"\n";
                            } catch(Exception eX){

                            }

                        }else {
                            result=result+jT.getColumnName(j)+"="+(String)jT.getValueAt(i,j)+"\n";
                        }

                      }
                    }
                     KShareObject.showMessage("RESULT",result);
                  }
               }
               if (!found){
                     KShareObject.showErrorMessage("NOT FOUND","ไม่มีข้อมูลรายละเอียด");
               }
            }
            else
            {
              KShareObject.showErrorMessage("ERROR","กรุณาเลือก LAYER..");
            }
          }
          else
          {
              KShareObject.showErrorMessage("RESULT","ไม่พบ");

          }

   }

   void selectArea(MouseEvent e){
          KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(kLayerPanel.getOneSelectedLayer());
          Vector vTmp = ktest.setFenceSelectedGid(Math.round(e.getX()/kDisplayPanel.getZoomRatio()),Math.round(e.getY()/kDisplayPanel.getZoomRatio()));
          if (vTmp.size()>0)
          {
             Integer iGid = (Integer)vTmp.elementAt(0);
             int kGid = iGid.intValue();
             Boolean newValue = (Boolean)vTmp.elementAt(1);

          if (kGid>=0)
          {

            int layerIndex =kLayerPanel.getOneSelectedLayer();
            if (layerIndex>=0)
            {
               JTable jT = kRoomDescription.getDescriptionAt(layerIndex);
               for (int i=0;i<jT.getRowCount();i++)
               {

                  int gidColumn = kRoomDescription.getGidColumnAt(layerIndex);//jT.getColumnModel().getColumnIndex("ROOM_GID");
                  if (gidColumn ==-1)
                  {
                    KShareObject.showErrorMessage("ERROR","ไม่พบ GID COLUMN");
                    return;
                  }
                  int viewColumn = jT.getColumnModel().getColumnIndex("view");
                  Integer tmp = (Integer)jT.getValueAt(i,gidColumn);
                  if (tmp.intValue()==kGid)
                  {
                     //Boolean tmpB = (Boolean)jT.getValueAt(i,0);
                     //boolean tB = true;//!tmpB.booleanValue();
                     jT.setValueAt(newValue,i,viewColumn);
                     TableSorter s = (TableSorter)jT.getModel();
                     s.reallocateIndexes();
                     s.sortSearchResult(jT);
                  }
               }
            }

          }

          }
          kDisplayPanel.repaint();

   }
   public void run(){
      while (haveWork)
      {
        kDisplayPanel.setCursor(waitCursor);
        /*try
        {
          workingThread.sleep(100);
        }
        catch (Exception ex){}
        */
      }
   }

   void kDisplayPanel_mouseClicked(MouseEvent e) {
      int tool = KShareObject.getShareObject().getUserToolCode();
      if (kDisplayPanel.getZoomRatio()>=1f)
      {
          //haveWork = true;

      if (tool ==KUserToolBarPanel.INSIDEBUILDING_TOOL )
      {
          //workingThread.resume();
          //try
          //{
          //Thread.sleep(100);
          //}
          //catch (Exception ex){}
          showRoomMap(e);
          //workingThread.suspend();
          kDisplayPanel.setCursor(handCursor);

      }
      if (tool == KUserToolBarPanel.OBJECTINFO_TOOL )
      {
          showAttributes(e);

      }

      if (tool == KUserToolBarPanel.OBJECTTOTABLE_TOOL )
      {
         if (kLayerPanel.getOneSelectedLayer()>=0)
         {
         selectArea(e);
         }
         else
         {
         KShareObject.showErrorMessage("ERROR","กรุณาเลือก LAYER ก่อนใช้ TOOL นี้");
         }
      }

      if (tool == KSamplesToolBarPanel.ROOMRESERVINFO_TOOL)
      {
          if (getTheme()==KViewerPanel.ROOM_THEME)
          {
          showRoomReservation(e);
          }
          else
          {
          KShareObject.showErrorMessage("ERROR","ใช้ TOOL นี้กับห้องเท่านั้น");
          }
      }


      }
      else
      {
      //JOptionPane.showInternalMessageDialog(KShareObject.getDesktopPane(),"OP","YO",JOptionPane.NO_OPTION);
      KShareObject.showMessage("WARNING","กรุณาใช้อัตราขยาย 100 % ขึ้นไป");
      }
  }
/*
  void  setSelectedDisplayPolygon(TableModelEvent e){
            int layerIndex =kLayerPanel.getOneSelectedLayer();
            if (layerIndex>=0){
               JTable jT = kRoomDescription.getDescriptionAt(layerIndex);
               for (int i=0;i<jT.getRowCount();i++){
                  Boolean selectedView = (Boolean)jT.getValueAt(i,0);
                  if (selectedView.booleanValue()){
                     Integer tmpGid = (Integer)jT.getValueAt(i,2);
                     KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(kLayerPanel.getOneSelectedLayer());
                     ktest.setFenceSelectedGid(tmpGid.intValue());
                     kDisplayPanel.repaint();
                     TableSorter s = (TableSorter)jT.getModel();
                     s.reallocateIndexes();
                     s.sortSearchResult(jT);
                  }
               }
            }

  }
*/

  void kDisplayPanel_mouseExited(MouseEvent e) {
     kDisplayPanel.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));

  }


  int[] getSelectedLayer(){
      return kLayerPanel.getSelectedLayer();
  }
  int getOneSelectedLayer(){
      return kLayerPanel.getOneSelectedLayer();
  }
      private void setUpIntegerEditor(JTable table) {
        //Set up the editor for the integer cells.
        final WholeNumberField integerField = new WholeNumberField(0, 5);
        integerField.setHorizontalAlignment(WholeNumberField.RIGHT);

        DefaultCellEditor integerEditor =
            new DefaultCellEditor(integerField) {
                //Override DefaultCellEditor's getCellEditorValue method
                //to return an Integer, not a String:
                public Object getCellEditorValue() {
                    return new Integer(integerField.getValue());
                }
            };
        table.setDefaultEditor(Integer.class, integerEditor);
    }

  JTable getTableDescription(String tableName){
         KConnectionManager k = KConnectionManager.getConnectionManager();
            Vector d = k.getTableData(tableName);
            DefaultTableModel dT = new MyTableModel((Vector)d.elementAt(0),(Vector)d.elementAt(1));
            TableSorter sorter = new TableSorter(dT); //ADDED THIS
            JTable jTable = new JTable(sorter);
            setUpIntegerEditor(jTable);
            sorter.addMouseListenerToHeaderInTable(jTable); //ADDED THIS
/*          if (tableName.equalsIgnoreCase(KConnectionManager.BUILDING_TABLE))
          {
          TableColumn orgColumn = jTable.getColumnModel().getColumn(4);
          JComboBox comboBox = new JComboBox();
          Hashtable t = KConnectionManager.getOrgHash();
          Enumeration eN = t.elements();
          while(eN.hasMoreElements()){
          comboBox.addItem((String)eN.nextElement());
          }

          orgColumn.setCellEditor(new DefaultCellEditor(comboBox));
          }
*/
            jTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
            ListSelectionModel rowSM = jTable.getSelectionModel();
            rowSM.addListSelectionListener(new ListSelectionListener() {
            public void valueChanged(ListSelectionEvent e) {
            int layerIndex =kLayerPanel.getOneSelectedLayer();
            if (layerIndex>=0){
               JTable jT = kRoomDescription.getDescriptionAt(layerIndex);

                    ListSelectionModel lsm = (ListSelectionModel)e.getSource();
                    if (lsm.isSelectionEmpty()) {

                    } else {
                        for (int i=lsm.getMinSelectionIndex();i<=lsm.getMaxSelectionIndex();i++){
                        if (lsm.isSelectedIndex(i)){
                           int viewColumn = jT.getColumnModel().getColumnIndex("view");
                           int gidColumn = kRoomDescription.getGidColumnAt(layerIndex);

                           if (gidColumn>=0)
                           {
                           Boolean t = (Boolean)jT.getValueAt(i,viewColumn);
                           jT.setValueAt(new Boolean(!t.booleanValue()),i,viewColumn);
                           Integer tmpGid = (Integer)jT.getValueAt(i,gidColumn);
                           KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(kLayerPanel.getOneSelectedLayer());
                           ktest.setFenceSelectedGid(tmpGid.intValue());
                           }
                           else
                           {
                              KShareObject.showErrorMessage("ERROR","ไม่พบ GID COLUMN");
                              return;
                           }

                        }
                        }
                        kDisplayPanel.repaint();
                    }
                }
            }
            });


           return jTable;

  }

  JTable getRoomDescription(String tableName)
  {
            KConnectionManager k = KConnectionManager.getConnectionManager();
            Vector d = k.getRoomData(tableName);
            DefaultTableModel dT = new MyTableModel((Vector)d.elementAt(0),(Vector)d.elementAt(1));
            TableSorter sorter = new TableSorter(dT); //ADDED THIS
            JTable jTable = new JTable(sorter);
            setUpIntegerEditor(jTable);
            sorter.addMouseListenerToHeaderInTable(jTable); //ADDED THIS

          /* old -- mapping room type
          TableColumn roomTypeColumn = jTable.getColumnModel().getColumn(3);
          JComboBox comboBox = new JComboBox();
          Hashtable t = KConnectionManager.getRoomTypeHash();
          for(int i=0;i<t.size();i++){
          comboBox.addItem((String)t.get(new Integer(i+1)));
          }
          roomTypeColumn.setCellEditor(new DefaultCellEditor(comboBox));
          */

            jTable.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
            ListSelectionModel rowSM = jTable.getSelectionModel();
            rowSM.addListSelectionListener(new ListSelectionListener() {


            public void valueChanged(ListSelectionEvent e) {
            int layerIndex =kLayerPanel.getOneSelectedLayer();
            if (layerIndex>=0){
               JTable jT = kRoomDescription.getDescriptionAt(layerIndex);

                    ListSelectionModel lsm = (ListSelectionModel)e.getSource();
                    if (lsm.isSelectionEmpty()) {

                    } else {
                        for (int i=lsm.getMinSelectionIndex();i<=lsm.getMaxSelectionIndex();i++){
                        if (lsm.isSelectedIndex(i)){
                           int viewColumn = jT.getColumnModel().getColumnIndex("view");
                           //int gidColumn = jT.getColumnModel().getColumnIndex("ROOM_GID");
                           int gidColumn = kRoomDescription.getGidColumnAt(layerIndex);//jT.getColumnModel().getColumnIndex("ROOM_GID");
                           if (gidColumn ==-1)
                           {
                            KShareObject.showErrorMessage("ERROR","ไม่พบ GID COLUMN");
                            return;
                           }
                           Boolean t = (Boolean)jT.getValueAt(i,viewColumn);
                           jT.setValueAt(new Boolean(!t.booleanValue()),i,viewColumn);
                           Integer tmpGid = (Integer)jT.getValueAt(i,gidColumn);
                           KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(kLayerPanel.getOneSelectedLayer());
                           ktest.setFenceSelectedGid(tmpGid.intValue());


                        }
                        }
                        kDisplayPanel.repaint();
                    }
                }
            }
            });

            jTable.getModel().addTableModelListener(new TableModelListener(){
                public void tableChanged(TableModelEvent eT){
                     int layerIndex = getOneSelectedLayer();
                     if (layerIndex>=0)
                     {
                        if (eT.getColumn()!=0)
                        {
                        kRoomDescription.addCmdAt(layerIndex,KDbCommand.UPDATE,eT.getFirstRow(),eT.getColumn());
                        }
                     }

                }
            });


           return jTable;
  }


  void showRoomDescription(int layerIndex)
  {
           JTable jTable = kRoomDescription.getDescriptionAt(layerIndex);
           jTable.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
           kRoomDescriptionScrollPane = JTable.createScrollPaneForTable(jTable);
           jTable.setPreferredScrollableViewportSize(new Dimension(400,180));
           //001 this.add(tablePanel, BorderLayout.SOUTH);
           //001 tablePanel.add(kRoomDescriptionScrollPane, BorderLayout.CENTER);
           this.add(kRoomDescriptionScrollPane, BorderLayout.SOUTH);
           SwingUtilities.updateComponentTreeUI(this);

  }

  void removeRoomDescription()
  {
           //001 this.remove(tablePanel);
           //001 tablePanel.remove(kRoomDescriptionScrollPane);
           this.remove(kRoomDescriptionScrollPane);
           SwingUtilities.updateComponentTreeUI(this);
  }



  public void updateRoomDescription()
  { int layerIndex = getOneSelectedLayer();
    if (layerIndex>=0){
        JTable updateTable = kRoomDescription.getDescriptionAt(layerIndex);
        if (kRoomDescription.getCmdAt(layerIndex)!=null)
        {
          try
          {
          createUpdateInternalFrame(KConnectionManager.createUpdateRoomTableSQL(kRoomDescription.getTableName(layerIndex),updateTable,kRoomDescription.getCmdAt(layerIndex)));
          }
          catch(Exception ex)
          {
            KShareObject.showErrorMessage("ERROR","Can not update table");
          }
        }
    }
  }


//--------------------------------------------------------------

  void setEditRoomTable(boolean b)
  {
        int layerIndex =kLayerPanel.getOneSelectedLayer();
        if (layerIndex>=0)
        {
        JTable jT = kRoomDescription.getDescriptionAt(layerIndex);
        TableSorter jTS = (TableSorter)jT.getModel();
        jTS.setEdit(b);
        }
        else
        {
        KShareObject.showErrorMessage("ERROR","Please  select layer");
        }

  }
  void createUpdateInternalFrame(Vector cmd)
  {
   JInternalFrame uf = new JInternalFrame("UPDATE");
   uf.setSize(450,350);
   uf.setBounds(0,0,450,350);
   uf.getContentPane().setLayout(new BorderLayout());
   uf.getContentPane().add(new KUpdateTablePanel(cmd),BorderLayout.CENTER);
   uf.show(true);
   uf.setClosable(true);
   KShareObject.getDesktopPane().add(uf, JLayeredPane.MODAL_LAYER);
   uf.moveToFront();
  }
  void startEditBtn_mouseClicked(MouseEvent e) {
        String startTxt = "START EDIT";
        if (startTxt.equalsIgnoreCase(startEditBtn.getText()))
        {
          startEditBtn.setText("STOP EDIT");
          setEditRoomTable(true);
        }
        else
        {
          startEditBtn.setText("START EDIT");
          setEditRoomTable(false);
        }

  }

  void updateBtn_mouseClicked(MouseEvent e) {
        updateRoomDescription();
  }

  void delBtn_mouseClicked(MouseEvent e) {

  }

  void clearSelectedPolygon(){
    kDisplayPanel.setSelectedPolygon(false,null);
  }

  void createQueryInternalFrame(String tableName,Vector colNameV)
  {
   JInternalFrame uf = new JInternalFrame("Query");
   uf.setSize(410,350);
   uf.setBounds(0,0,410,350);
   uf.getContentPane().setLayout(new BorderLayout());
   uf.getContentPane().add(new KQueryBuilder(this,colNameV,KConnectionManager.getCommentFromColumn(tableName,colNameV),tableName),BorderLayout.CENTER);
   uf.show(true);
   uf.setClosable(true);
   uf.setIconifiable(true);
   KShareObject.getDesktopPane().add(uf, JLayeredPane.MODAL_LAYER);
   uf.moveToFront();
  }

  public void queryByAny()
  {
            int layerIndex =kLayerPanel.getOneSelectedLayer();
            if (layerIndex>=0)
            {
                String tableName =kRoomDescription.getTableName(layerIndex);
                Vector v = KConnectionManager.getColumnNames(tableName);
                Vector colNameV = (Vector)v.elementAt(0);
                JInternalFrame uf = new JInternalFrame("Query");
                uf.setSize(410,350);
                uf.setBounds(0,0,410,350);
                uf.getContentPane().setLayout(new BorderLayout());
                uf.getContentPane().add(new KQueryBuilder(this,colNameV,KConnectionManager.getCommentFromColumn(tableName,colNameV),tableName,layerIndex),BorderLayout.CENTER);
                uf.show(true);
                uf.setClosable(true);
                uf.setIconifiable(true);
                KShareObject.getDesktopPane().add(uf, JLayeredPane.MODAL_LAYER);
                uf.moveToFront();
            }
  }
  public void queryByBuilding()
  {
   Vector colNameV = (Vector)KConnectionManager.getRoomColumnNames().clone();
   //colNameV.removeElementAt(0);//remove layername col
   createQueryInternalFrame(KConnectionManager.ROOM_TABLE,colNameV);

  }
  public void queryByRoom()
  {
   Vector colNameV = (Vector)KConnectionManager.getRoomColumnNames().clone();
   //colNameV.removeElementAt(0);//remove layername col
   //colNameV.removeElementAt(0);//remove room_gid col
   createQueryInternalFrame(KConnectionManager.ROOM_TABLE,colNameV);
  }
  public String getLayerNameConditionStr()
  {
    String retStr="";
    for (int i=0;i<kRoomDescription.size();i++)
    {
      retStr=retStr+(i>0?" OR ":"")+"a.LAYERNAME ='"+kRoomDescription.getTableName(i)+"' ";
    }
    return retStr;

  }
  public int searchRowBy(JTable table,int intValue,int col)
  {
    int tmpI = intValue;
    if (intValue>0) tmpI=intValue-1; // minus by 1 because if gid0 doesn't exist..

    for (int i=tmpI;i<table.getRowCount();i++)
    {
      Integer valueC = (Integer)table.getValueAt(i,col);
      if (valueC.intValue()==intValue)
      {
        return i;
      }

    }
    for (int j=0;j<intValue;j++)
    {
      Integer valueC = (Integer)table.getValueAt(j,col);
      if (valueC.intValue()==intValue)
      {
        return j;
      }

    }
    return -1;

  }
  public void clearSelectedArea()
  {
    for (int j=0;j<kRoomDescription.size();j++)
    {
      JTable jT = kRoomDescription.getDescriptionAt(j);
      int viewColumn = jT.getColumnModel().getColumnIndex("view");
      //int gidColumn = jT.getColumnModel().getColumnIndex("ROOM_GID");
      int gidColumn = kRoomDescription.getGidColumnAt(j);//jT.getColumnModel().getColumnIndex("ROOM_GID");
      if (gidColumn ==-1)
      {
        KShareObject.showErrorMessage("ERROR","ไม่พบ GID COLUMN");
        return;
      }


      for (int i=0;i<jT.getRowCount();i++)
      {
      Boolean t = (Boolean)jT.getValueAt(i,viewColumn);
        if (t.booleanValue())
        {
          jT.setValueAt(new Boolean(false),i,viewColumn);
          Integer tmpGid = (Integer)jT.getValueAt(i,gidColumn);
          KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(j);
          ktest.setFenceSelectedGid(tmpGid.intValue(),false);
        }
      }
      TableSorter s = (TableSorter)jT.getModel();
      s.reallocateIndexes();

    }
    kDisplayPanel.repaint();
  }


  public void showQueryBuildingResult(String conditionString)
  {
      Vector resultV = KConnectionManager.queryBuildingGid(conditionString);
      if (resultV.size()>0){
           clearSelectedArea();

           JTable jT = kRoomDescription.getDescriptionAt(0);// First Layer....

           int viewColumn = jT.getColumnModel().getColumnIndex("view");
           //int gidColumn = jT.getColumnModel().getColumnIndex("ROOM_GID");
           int gidColumn = kRoomDescription.getGidColumnAt(0);// First Layer..

        for (int i=0;i<resultV.size();i++)
        {
           Integer rI = (Integer)resultV.elementAt(i);

           int selectedRow = searchRowBy(jT,rI.intValue(),gidColumn);
           if (selectedRow>=0)
           {
           jT.setValueAt(new Boolean(true),selectedRow,viewColumn);
           KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(0);// First Layer
           ktest.setFenceSelectedGid(rI.intValue());
           }
        }

           TableSorter s = (TableSorter)jT.getModel();
           s.reallocateIndexes();
           s.sortSearchResult(jT);
           kDisplayPanel.repaint();
           KShareObject.showMessage("RESULT","พบทั้งหมด ="+Integer.toString(resultV.size())+"อาคาร");
      }else{
           KShareObject.showErrorMessage("NOT FOUND","ไม่พบอาคารที่ตรงตามเงื่อนไข");
      }

  }
  public void showQueryAnyResult(String tableName,String conditionString,int layerIndex)
  {
     Vector resultV = KConnectionManager.queryAnyGid(tableName,conditionString);
     if (resultV.size()>0&&layerIndex!=-1)
     {
        clearSelectedArea();

        JTable jT = kRoomDescription.getDescriptionAt(layerIndex);
        int viewColumn = jT.getColumnModel().getColumnIndex("view");
        int gidColumn = kRoomDescription.getGidColumnAt(layerIndex);

        for (int i=0;i<resultV.size();i++)
        {
        Integer rI = (Integer)resultV.elementAt(i);
        int ri = rI.intValue();

           int selectedRow = searchRowBy(jT,ri,gidColumn);
           if (selectedRow>=0)
           {
           jT.setValueAt(new Boolean(true),selectedRow,viewColumn);
           KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(layerIndex);
           ktest.setFenceSelectedGid(ri);

           }
         }
           TableSorter s = (TableSorter)jT.getModel();
           s.reallocateIndexes();
           s.sortSearchResult(jT);
           kDisplayPanel.repaint();
           KShareObject.showMessage("RESULT","พบคำตอบ ="+resultV.size()+"คำตอบ");
     }
  }

  public void showQueryRoomResult(String conditionString)
  {
      Vector resultV = KConnectionManager.queryRoomGid(conditionString+" AND ("+getLayerNameConditionStr()+")");
      Vector floorV = new Vector();
      if (resultV.size()>0){
        String resultFloor="";
        clearSelectedArea();
        for (int i=0;i<resultV.size();i++)
        {
           KRoomGidQuery rI = (KRoomGidQuery)resultV.elementAt(i);
           if (!floorV.contains(new Integer(rI.floorNo)))
           {
              floorV.addElement(new Integer(rI.floorNo));
           }
           JTable jT = kRoomDescription.getDescriptionAt(rI.floorNo-1);// minus by 1 because layer begin at floor 0 not 1


           int viewColumn = jT.getColumnModel().getColumnIndex("view");
           //int gidColumn = jT.getColumnModel().getColumnIndex("ROOM_GID");
           int gidColumn = kRoomDescription.getGidColumnAt(rI.floorNo-1);

           int selectedRow = searchRowBy(jT,rI.roomGid,gidColumn);
           if (selectedRow>=0)
           {
           jT.setValueAt(new Boolean(true),selectedRow,viewColumn);
           KPolyDepot ktest = (KPolyDepot)kDisplayPanel.dataCollector.elementAt(rI.floorNo-1);
           ktest.setFenceSelectedGid(rI.roomGid);

           }

           TableSorter s = (TableSorter)jT.getModel();
           s.reallocateIndexes();
           s.sortSearchResult(jT);

        }

           kDisplayPanel.repaint();

           Enumeration floorE = floorV.elements();
           while (floorE.hasMoreElements())
           {
            Integer r = (Integer)floorE.nextElement();
            resultFloor = resultFloor+" "+r.toString();
           }

           KShareObject.showMessage("Query Result","พบคำตอบในชั้น =>"+resultFloor);


      }else{
           KShareObject.showErrorMessage("ERROR","ไม่พบ");
      }
  }

  public Vector getRoomColumnValues(String colName)
  {
      return KConnectionManager.getSingleColumnValues(KConnectionManager.ROOM_TABLE,colName,"");
  }
  public Vector getColumnValues(String tableName,String colName)
  {
      return KConnectionManager.getSingleColumnValues(tableName,colName,"");
  }
/*
  public Vector getColumnValues(String colName)
  {
     Vector colValues = new Vector();
     String newValue;
     for (int i=0;i<kRoomDescription.size();i++)
     {
        JTable table = kRoomDescription.getDescriptionAt(i);
        int coli = table.getColumnModel().getColumnIndex(colName);
        for (int rowi=0;rowi<table.getRowCount();rowi++)
        {
                  if (table.getColumnClass(coli).getName().equals("java.lang.Integer"))
                  {
                    Integer tmp = (Integer)table.getValueAt(rowi,coli);
                    newValue = tmp.toString();
                  }
                  else
                  {
                    newValue = "'"+(String)table.getValueAt(rowi,coli)+"'";
                  }
                  if (!colValues.contains(newValue))
                  colValues.addElement(newValue);

         }


     }
     return colValues;
  }
*/
}

class KDbCommandTracker
{
  private Vector insertV,deleteV;
  private Hashtable updateH;
  public KDbCommandTracker()
  {
    insertV = new Vector();
    deleteV = new Vector();
    updateH = new Hashtable();
  }
  public Hashtable getUpdateCommand()
  {
    return updateH;
  }
  public boolean hasInsertCommand()
  {
    return insertV.size()>0;
  }
  public boolean hasDeleteCommand()
  {
    return deleteV.size()>0;
  }
  public boolean hasUpdateCommand()
  {
    return updateH.size()>0;
  }
  public void addUpdate(int row,int column)
  {
    if (!updateH.containsKey(new Integer(row)))
    {
      updateH.put(new Integer(row),new Vector());
    }
    Vector tmpV = (Vector)updateH.get(new Integer(row));
    if (!tmpV.contains(new Integer(column)))
    {
      tmpV.addElement(new Integer(column));
    }
  }
  public void addInsert(int row)
  {
    if (!insertV.contains(new Integer(row)))
    {
      insertV.addElement(new Integer(row));
    }
  }
  public void addDelete(int row)
  {
    if (!deleteV.contains(new Integer(row)))
    {
      deleteV.addElement(new Integer(row));
    }
  }
}
class KDbCommand
{
final static int INSERT = 0;
final static int DELELTE = 1;
final static int UPDATE = 2;
}
class KRoomDescription extends Vector
{ Vector tableNameV = new Vector();
  Vector gidColumnV = new Vector();
  Hashtable cmdH = new Hashtable();
  int selectedIndex;
  int getSelectedIndex(){
    return selectedIndex;
  }

  int searchGidColumn(JTable jTable)
  {
     for (int i=0;i<jTable.getColumnCount();i++)
     {
        String colName = jTable.getColumnName(i);
        String gidStr = "_GID";
        if (colName.length()>gidStr.length())
        {
          if (colName.regionMatches(true,colName.length()-gidStr.length(),gidStr,0,gidStr.length()))
          {
             return i;
          }
        }

     }

     return -1;
  }


  void addCmdAt(int layer,int cmd,int row,int column)
  {
      if (!cmdH.containsKey(new Integer(layer)))
      {
        cmdH.put(new Integer(layer),new KDbCommandTracker());
      }
      KDbCommandTracker cmdT = (KDbCommandTracker)cmdH.get(new Integer(layer));

      if (cmd == KDbCommand.INSERT)
      {
        cmdT.addInsert(row);
      }
      if (cmd == KDbCommand.DELELTE)
      {
        cmdT.addDelete(row);
      }
      if (cmd == KDbCommand.UPDATE)
      {
        cmdT.addUpdate(row,column);
      }

  }
  KDbCommandTracker getCmdAt(int layer)
  {

      return (KDbCommandTracker)cmdH.get(new Integer(layer));
  }
  void addDescription(String tableName,JTable table)
  {
    tableNameV.addElement(tableName);
    this.addElement(table);
    gidColumnV.addElement(new Integer(searchGidColumn(table)));
  }
  int getGidColumnAt(int i)
  {
    Integer retI = (Integer)gidColumnV.elementAt(i);
    return retI.intValue();
  }
  String getTableName(int i){
    return (String)tableNameV.elementAt(i);
  }
  JTable getDescriptionAt(int i)
  {
    selectedIndex =i;
    return (JTable)this.elementAt(i);
  }
  int descriptionCount()
  {
    return this.elementCount;
  }

}

