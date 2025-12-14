
//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description

package KCOM;


import java.sql.*;
import java.io.*;
import java.util.*;
import java.util.Vector;
import java.awt.*;
import com.sun.java.swing.table.*;
import com.sun.java.swing.*;
import oracle.jdbc.dbaccess.*;
import oracle.jdbc.driver.OracleResultSetMetaData;

public class KConnectionManager {
/*002
   public static String ROOM_TABLE = "ROOM_VIEW";
   public static String ROOMTYPE_TABLE = "ROOMTYPE";
   public static String FLOOR_TABLE ="FLOOR";
   public static String BUILDING_TABLE = "KMITL_BUILDING";
   public static String ORGANIZATION_TABLE = "ORGANIZATION";
   public static String MAINMAP_TABLE ="MAINMAP";
   public static String ROOMRESERVATION_TABLE ="ROOM_RESERV";
*/
   public static String CONFIG_TABLE ="GISDESKTOP_CONFIG";

   public static String ROOM_TABLE = "";
   public static String ROOMTYPE_TABLE = "";
   public static String FLOOR_TABLE ="";
   public static String BUILDING_TABLE = "";
   public static String ORGANIZATION_TABLE = "";
   public static String MAINMAP_TABLE ="";
   public static String ROOMRESERVATION_TABLE ="";

   static  String colQuery = "SELECT CNAME,COLTYPE FROM COL ";
 	 static  String graphicsQuery = " SELECT SDO_GID,SDO_ESEQ,SDO_ETYPE,SDO_SEQ,SDO_X1,SDO_Y1,SDO_X2,SDO_Y2,SDO_X3,SDO_Y3,SDO_X4,SDO_Y4,SDO_X5,SDO_Y5,SDO_X6,SDO_Y6,SDO_X7,SDO_Y7,SDO_X8,SDO_Y8,SDO_X9,SDO_Y9,SDO_X10,SDO_Y10,SDO_X11,SDO_Y11,SDO_X12,SDO_Y12,SDO_X13,SDO_Y13,SDO_X14,SDO_Y14,SDO_X15,SDO_Y15,SDO_X16,SDO_Y16,SDO_X17,SDO_Y17,SDO_X18,SDO_Y18,SDO_X19,SDO_Y19,SDO_X20,SDO_Y20,SDO_X21,SDO_Y21,SDO_X22,SDO_Y22,SDO_X23,SDO_Y23,SDO_X24,SDO_Y24,SDO_X25,SDO_Y25,SDO_X26,SDO_Y26,SDO_X27,SDO_Y27,SDO_X28,SDO_Y28,SDO_X29,SDO_Y29,SDO_X30,SDO_Y30,SDO_X31,SDO_Y31,SDO_X32,SDO_Y32 from ";
   static  String columnNameQuery = "SELECT CNAME FROM COL WHERE TNAME =";
   static  String roomDataQuery ="SELECT LAYERNAME,ROOM_GID,ROOMTYPECO,ROOMNA,ROOMCO,STDTOTAL,AREA,COMPUTER,PRINTER,OVERHEAD,PROJECTOR,WHITEBOARD,BLACKBOARD,STEREO,AIRCDT,FAN FROM "+ROOM_TABLE;

   static String roomTypeQuery,orgQuery,buildingQuery,buildingMappingQuery;

   static  String driver_class = "oracle.jdbc.driver.OracleDriver";
	 static String connect_string ;
   //="jdbc:oracle:thin:gisman/i;'-hk;@127.0.0.1:1521:orcl";
   private static Connection conn;   // Holds the connection to the database
   private static KConnectionManager _kConMgr;
   private static Hashtable _org;
   private static Hashtable _building;
   private static Vector _buildingTable;
   private static Hashtable _roomType,_roomTypeR;
   static Vector _roomColumnNames;
   static Hashtable _roomColumnInfo;
   static String ownerName;
   static int colorCounter = 0;

  public  static void closeConnection() {
      if (conn != null)
      try {
        conn.close();
        System.out.println("Close Connection");
      } catch(Exception ex){
        KShareObject.showErrorMessage("ERROR",ex.getMessage());
      }
  }
  public static void setInitParam(String userName,String password,String ip)
  {
    ownerName = userName;
    connect_string ="jdbc:oracle:thin:"+userName+"/"+password+"@"+ip+":1521:orcl";
  }
  private static void loadDataDic()
  {
      String qStr ="";
    qStr = "SELECT TABLE_NAME  FROM "+CONFIG_TABLE+" WHERE TABLE_KEY ='ROOM_TABLE'";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            ROOM_TABLE = rset.getString(1);
            }

    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","CAN NOT LOAD DATADICTIONARY\n"+qStr+"\n"+s.getMessage());
    }

   //--------------------------------------------------------------------------
    qStr = "SELECT TABLE_NAME  FROM "+CONFIG_TABLE+" WHERE TABLE_KEY ='ROOMTYPE_TABLE'";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            ROOMTYPE_TABLE = rset.getString(1);
            }

    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","CAN NOT LOAD DATADICTIONARY\n"+qStr+"\n"+s.getMessage());
    }
   //--------------------------------------------------------------------------
    qStr = "SELECT TABLE_NAME  FROM "+CONFIG_TABLE+" WHERE TABLE_KEY ='FLOOR_TABLE'";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            FLOOR_TABLE = rset.getString(1);
            }

    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","CAN NOT LOAD DATADICTIONARY\n"+qStr+"\n"+s.getMessage());
    }
   //--------------------------------------------------------------------------
    qStr = "SELECT TABLE_NAME  FROM "+CONFIG_TABLE+" WHERE TABLE_KEY ='BUILDING_TABLE'";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            BUILDING_TABLE = rset.getString(1);
            }

    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","CAN NOT LOAD DATADICTIONARY\n"+qStr+"\n"+s.getMessage());
    }
   //--------------------------------------------------------------------------
    qStr = "SELECT TABLE_NAME  FROM "+CONFIG_TABLE+" WHERE TABLE_KEY ='ORGANIZATION_TABLE'";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            ORGANIZATION_TABLE = rset.getString(1);
            }

    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","CAN NOT LOAD DATADICTIONARY\n"+qStr+"\n"+s.getMessage());
    }

   //--------------------------------------------------------------------------
    qStr = "SELECT TABLE_NAME  FROM "+CONFIG_TABLE+" WHERE TABLE_KEY ='MAINMAP_TABLE'";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            MAINMAP_TABLE = rset.getString(1);
            }

    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","CAN NOT LOAD DATADICTIONARY\n"+qStr+"\n"+s.getMessage());
    }
   //--------------------------------------------------------------------------
    qStr = "SELECT TABLE_NAME  FROM "+CONFIG_TABLE+" WHERE TABLE_KEY ='ROOMRESERVATION_TABLE'";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            ROOMRESERVATION_TABLE = rset.getString(1);
            }

    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","CAN NOT LOAD DATADICTIONARY\n"+qStr+"\n"+s.getMessage());
    }
/*
    System.out.println("'"+ROOM_TABLE+"'");
    System.out.println("'"+ROOMTYPE_TABLE+"'");
    System.out.println("'"+FLOOR_TABLE+"'");
    System.out.println("'"+BUILDING_TABLE+"'");
    System.out.println("'"+ORGANIZATION_TABLE+"'");
    System.out.println("'"+MAINMAP_TABLE+"'");
    System.out.println("'"+ROOMRESERVATION_TABLE+"'");
*/
   roomTypeQuery ="SELECT ROOMTYPECODE,ROOMTYPENAME FROM "+ROOMTYPE_TABLE;
   orgQuery = "SELECT ORGID,ORGNAME FROM "+ORGANIZATION_TABLE;
   buildingQuery = "SELECT BUILDING_GID,BUILDINGNAME,BUILDINGID,ORGID FROM "+BUILDING_TABLE;
   buildingMappingQuery ="SELECT LAYERNAME FROM "+FLOOR_TABLE;

  }
  public static String getRoomTypeName(int roomCode ){
    return (String)_roomType.get(new Integer(roomCode));
  }
  public static int getRoomTypeCode(String roomTypeName){
    Integer code = (Integer)_roomTypeR.get(roomTypeName);
    return code.intValue();
  }
  public static boolean haveConnection(){
    return (conn != null);
  }
  public static void createConnection() {
  try {
	    if (conn == null){
          //setInitParam(userN,pass,db_ip);
          Class.forName (driver_class);
    	    conn = DriverManager.getConnection (connect_string);
          loadDataDic();
          System.out.println("Connection established");
    	}
      }catch (Exception ex){
        KShareObject.showErrorMessage("ERROR","Can't create connection =>"+ex.getMessage());

      }

  }
  public static KConnectionManager getConnectionManager(){
      if (_kConMgr == null){
         _kConMgr = new KConnectionManager();
         createConnection();
          _roomType = getRoomTypeNames();
          Vector tmpV = getColumnNames(ROOM_TABLE);
          _roomColumnNames = (Vector)tmpV.elementAt(0);
          _roomColumnInfo = (Hashtable)tmpV.elementAt(1);
          _org = getOrgTable();
          _building = getBuildingTable();

      }
      return _kConMgr;
  }
  public static Vector getLayerNameOfMainMap()
  {
    Vector retV = new Vector();
      String qStr = "SELECT LAYERNAME,TABLEINFONAME,TITLE FROM "+MAINMAP_TABLE+" ORDER BY LAYERNO";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            retV.addElement(new KMainMapInfo(rset.getString(1),rset.getString(2),rset.getString(3)));
            }

    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","ไม่สามารถเรียกข้อมูล MAINMAP\n"+qStr+"\n"+s.getMessage());
    }

   return retV;



  }

  public static Vector queryBuildingGid(String conditionStr)
  {
    Vector retGid = new Vector();
      String qStr = "SELECT DISTINCT BUILDING_GID FROM "+FLOOR_TABLE+" WHERE LAYERNAME IN (SELECT DISTINCT LAYERNAME FROM "+ROOM_TABLE+" WHERE "+conditionStr+")";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            retGid.addElement(new Integer(rset.getInt(1)));
            }

    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","ไม่สามารถหาตึกที่ต้องการได้\n"+qStr+"\n"+s.getMessage());
    }

   return retGid;


  }
  public static Vector queryAnyGid(String tableName,String conditionStr)
  {
    Vector retGid = new Vector();
      String qStr = "SELECT DISTINCT SDO_GID FROM "+tableName+" WHERE "+conditionStr;
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            retGid.addElement(new Integer(rset.getInt(1)));
            }
    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","เงื่อนไขที่สร้างมีความผิดพลาด\n"+qStr+"\n"+s.getMessage());
    }

   return retGid;

  }

  public static Vector queryRoomGid(String conditionStr)
  {
    Vector retGid = new Vector();
      String qStr = "SELECT FLOORNO,ROOM_GID FROM "+ROOM_TABLE+" a,"+FLOOR_TABLE+" b WHERE a.LAYERNAME=b.LAYERNAME AND "+conditionStr+" ORDER BY FLOORNO";
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
	    while (rset.next ()){
            retGid.addElement(new KRoomGidQuery(rset.getInt(1),rset.getInt(2)));
            }
    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","เงื่อนไขที่สร้างมีความผิดพลาด\n"+qStr+"\n"+s.getMessage());
    }

   return retGid;

  }
  public static Vector createUpdateRoomTableSQL(String tableName,JTable table,KDbCommandTracker cmdTracker)
  {
      Vector updateString = new Vector();
      String newValue ;

      if (cmdTracker.hasUpdateCommand())
      {
          int gidColumn = table.getColumnModel().getColumnIndex("ROOM_GID");
          int roomTypeColumn = table.getColumnModel().getColumnIndex("ROOMTYPECO");

          Hashtable updateH = cmdTracker.getUpdateCommand();
          Enumeration rowIndex = updateH.keys();
          while(rowIndex.hasMoreElements())
          {
            String queryString = "UPDATE SET  ";

            Integer rowI = (Integer)rowIndex.nextElement();
            int rowi = rowI.intValue();
            Vector columnIndex = (Vector)updateH.get(rowI);
            Enumeration colE = columnIndex.elements();
            int colSize = columnIndex.size();
            int colCount = 0;
            while(colE.hasMoreElements())
            {
              colCount++;
              Integer colI =(Integer)colE.nextElement();
              int coli = colI.intValue();

              if (coli!=roomTypeColumn)
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
              }
              else
              { // equal  room type column
                  if (_roomTypeR.containsKey((String)table.getValueAt(rowi,coli)))
                  {
                      Integer tmpI= (Integer)_roomTypeR.get((String)table.getValueAt(rowi,coli));
                      newValue = tmpI.toString();
                  }
                  else
                  {
                      newValue = "0";
                      KShareObject.showErrorMessage("Error"," Invalid roomtypecode while updating database");
                  }
              }


              queryString = queryString+(String)_roomColumnNames.elementAt(colI.intValue()-1)+"="+newValue+(colCount==colSize?" ":", ");

            }
            Integer room_gid = (Integer)table.getValueAt(rowi,gidColumn);
            updateString.addElement(new String(queryString+" FROM "+ROOM_TABLE+" WHERE LAYERNAME='"+tableName+"' and ROOM_GID='"+room_gid.toString()+"'"));

          }


      }
      return updateString;
  }
  public static Vector updateRoomTable(String tableName,JTable table,Hashtable updateRow){
      Vector updateString = new Vector();
      String newValue ;

      for (int i=0;i<table.getRowCount();i++){
        if (updateRow.containsKey(new Integer(i)))
        {

        String queryString = "UPDATE SET  ";
        for (int j=3;j<table.getColumnCount();j++){

        if (j!=3){
        if (table.getColumnClass(j).getName().equals("java.lang.Integer")){
            Integer tmp = (Integer)table.getValueAt(i,j);
            newValue = tmp.toString();
        }else {
            newValue = "'"+(String)table.getValueAt(i,j)+"'";
        }
        } else { // equal column 3 , room type column
            if (_roomTypeR.containsKey((String)table.getValueAt(i,j))){
             Integer tmpI= (Integer)_roomTypeR.get((String)table.getValueAt(i,j));
             newValue = tmpI.toString();
            } else {
             newValue = "0";
             KShareObject.showErrorMessage("Error"," Invalid roomtypecode while updating database");
            }
        }


        queryString = queryString+(j==3?" ":",")+(String)_roomColumnNames.elementAt(j-1)+"="+newValue;

        }
        Integer room_gid = (Integer)table.getValueAt(i,2);
        updateString.addElement(new String(queryString+" FROM "+ROOM_TABLE+" WHERE LAYERNAME='"+tableName+"' and ROOM_GID='"+room_gid.toString()+"'"));
        }
      }
      if (updateString.size()>0)
      {
      //updateRoomTableData(updateString);
        return updateString;
      }
      else
      {
        return null;
      }
  }

  public static Hashtable getOrgHash(){
    return _org;
  }
  public static String getOrgName(String orgId){
    return (String)_org.get(orgId);
  }
  public static String getBuildingTitle(int buildingGid){
    KBuildingInfo k = (KBuildingInfo)_building.get(new Integer(buildingGid));
    return getOrgName(k.getOrgId())+"-->"+k.getBuildingName();
  }
  public static String getBuildingName(int buildingGid){
    KBuildingInfo k = (KBuildingInfo)_building.get(new Integer(buildingGid));
    return k.getBuildingName();
  }
  public static void testInsert(String st){
    try {

      Statement stmt = conn.createStatement ();
	    stmt.executeQuery ("Insert into t1 values ('" + st + "')");
      conn.commit();
    }catch(SQLException s){System.out.println("Can't insert"+s.getMessage());}

  }
  public static Vector  getCommentFromColumn(String tableName,Vector colNameV)
  {
    Vector retV = new Vector();

    for (int i=0;i<colNameV.size();i++)
    {
    String colName = (String)colNameV.elementAt(i);
    if (!isGidColumn(colName)&& !colName.equalsIgnoreCase("VIEW"))
    {
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery ("SELECT COMMENTS FROM ALL_COL_COMMENTS WHERE COLUMN_NAME='"+colName.toUpperCase()+"' AND TABLE_NAME= '"+tableName.toUpperCase()+"' AND OWNER='"+ownerName.toUpperCase()+"'" );
      while (rset.next())
      {

        try
        {
        retV.addElement(new String(rset.getString(1)));
        }
        catch(Exception ex)
        {
        System.out.println("comment error"+tableName+" by"+ex.getMessage());
        //KShareObject.showErrorMessage("ERROR","ไม่สามารถแสดงคอลัมน์ภาษาไทยได้ \n TABLE="+tableName+"\n"+s.getMessage());
        Vector v = (Vector)colNameV.clone();
        return v;

        }

      //System.out.println(rset.getString(1));

      }
      rset.close();
      stmt.close();
    }
    catch(SQLException s)
    {
      KShareObject.showErrorMessage("ERROR","ไม่สามารถแสดงคอลัมน์ภาษาไทยได้ \n TABLE="+tableName+"\n"+s.getMessage());
      return (Vector)colNameV.clone();
    }
    }
    else
    {
      retV.addElement(colName);
    }

    }

    return  retV;

  }
  public  static Vector getSingleColumnValues(String tableName,String colName,String condition)
  {
    Vector retV = new Vector();
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery ("SELECT DISTINCT "+colName.toUpperCase()+" FROM "+tableName.toUpperCase()+" "+condition);
      OracleResultSetMetaData rM = (OracleResultSetMetaData)rset.getMetaData();
	    while (rset.next ()){
               if (rM.getColumnTypeName(1) == "VARCHAR2"||rM.getColumnTypeName(1) == "VARCHAR"||rM.getColumnTypeName(1) == "CHAR")
               {
                  retV.addElement(new String("'"+rset.getString(1)+"'"));
               }
               else if (rM.getColumnTypeName(1)=="NUMBER")
               {
                  retV.addElement(Integer.toString(rset.getInt(1)));
                  //System.out.println("LABEL "+rM.getColumnLabel(1));
               }
               else if (rM.getColumnTypeName(1)=="FLOAT")
               {
                  retV.addElement(Float.toString(rset.getFloat(1)));
               }

               else
               {
                KShareObject.showErrorMessage("UNSUPPORT COLUMN",rM.getColumnTypeName(1));
               }

            }

    rset.close();
    stmt.close();
    }
    catch(SQLException s)
    {
    KShareObject.showErrorMessage("ERROR","Can't get single column values from"+ tableName +"\n "+s.getMessage());
    }
    return  retV;


  }
  public  static Vector getColumnNames(String tableName){
    Vector retV = new Vector();
    Vector colNames = new Vector();
    Hashtable colInfo = new Hashtable();
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (colQuery+" WHERE TNAME='"+tableName.toUpperCase()+"'");
	    while (rset.next ()){
            colInfo.put(new String(rset.getString(1)),new String(rset.getString(2)));
            colNames.addElement(new String(rset.getString(1)));
            //System.out.print(" "+rset.getString(1));
            }
            //System.out.println("");

    rset.close();
    stmt.close();
    }
    catch(SQLException s)
    {
    KShareObject.showErrorMessage("ERROR","Can't get Table"+ tableName +"\n "+s.getMessage());
    }

    retV.addElement(colNames);
    retV.addElement(colInfo);   // hashtable

    return  retV;
  }
  static boolean isGidColumn(String colName)
  {
        String gidStr = "_GID";
        if (colName.length()>gidStr.length())
        {
          if (colName.regionMatches(true,colName.length()-gidStr.length(),gidStr,0,gidStr.length()))
          {
             return true;
          }
        }
    return false;
   }
  public static String getRoomCodeFromLayerNameAndRoomGid(String layerName,int roomGid)
  {
      String qStr = "SELECT DISTINCT ROOMCODE FROM "+ROOM_TABLE+" WHERE LAYERNAME='"+layerName+"' AND ROOM_GID="+roomGid;
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (qStr);
 	    while (rset.next ()){
             return (rset.getString(1));
            }
    rset.close();
    stmt.close();
    }catch(SQLException s)
    {
      KShareObject.showErrorMessage("SQL ERROR","เงื่อนไขที่สร้างมีความผิดพลาด\n"+qStr+"\n"+s.getMessage());
      return null;
    }
    return null;
  }

  public static Vector getRoomReservationData(String roomCode)
  {
    Vector kt = getColumnNames(ROOMRESERVATION_TABLE);
    Vector retV = getData(ROOMRESERVATION_TABLE+" WHERE ROOMCODE='"+roomCode+"' ",(Vector)kt.elementAt(0),(Hashtable)kt.elementAt(1));
    Vector columnData = (Vector)retV.elementAt(1);
    Vector thaiColumnV = getCommentFromColumn(ROOMRESERVATION_TABLE,columnData);
    retV.removeElementAt(1);
    retV.insertElementAt(thaiColumnV,1);
    return retV;
  }
  public static Vector getTableData(String tableName){
    Vector kt = getColumnNames(tableName);
    Vector retV = getData(tableName,(Vector)kt.elementAt(0),(Hashtable)kt.elementAt(1));
    Vector columnData = (Vector)retV.elementAt(1);
    Vector thaiColumnV = getCommentFromColumn(tableName,columnData);
    retV.removeElementAt(1);
    retV.insertElementAt(thaiColumnV,1);
    return retV;
    /*    if (tableName.equalsIgnoreCase(BUILDING_TABLE)){
    Vector retV =getData(tableName,(Vector)kt.elementAt(0),(Hashtable)kt.elementAt(1));
    Vector data = (Vector)retV.elementAt(0);
    for (int i=0;i<data.size();i++){
      Vector row = (Vector)data.elementAt(i);
      String r = (String)row.elementAt(4);
      row.removeElementAt(4);
      row.insertElementAt(getOrgName(r),4);
    }
    return retV;
    } else {
      return getData(tableName,(Vector)kt.elementAt(0),(Hashtable)kt.elementAt(1));
    }
*/

  }

  public static Vector getRoomData(String tableName){
    Vector retV = getData(ROOM_TABLE+" WHERE LAYERNAME ='"+tableName+"'",_roomColumnNames,_roomColumnInfo);
    Vector columnData = (Vector)retV.elementAt(1);
    Vector thaiColumnV = getCommentFromColumn(ROOM_TABLE,columnData);
    /* --REM-001 Now we don't want to map roomtype column
    Vector data = (Vector)retV.elementAt(0);

    for (int i=0;i<data.size();i++){
      Vector row = (Vector)data.elementAt(i);
      Integer r = (Integer)row.elementAt(3);
      row.removeElementAt(3);
      row.insertElementAt(getRoomTypeName(r.intValue()),3);
    }
*/
    retV.removeElementAt(1);
    retV.insertElementAt(thaiColumnV,1);
    return retV;
  }
  private  static Vector getData(String tableName,Vector columnNames,Hashtable colInfo){
    Vector retV = new Vector();
    Vector data = new Vector();
    Vector colNames = (Vector)columnNames.clone();
    if (colNames.size()>0){
        String queryString = "SELECT ";
        for (int i=0;i<colNames.size();i++){
             queryString = queryString+ (i==0?" ":",")+(String)colNames.elementAt(i);
        }
        queryString = queryString+" FROM "+tableName;

        try {
            Statement stmt = conn.createStatement ();
	          ResultSet rset = stmt.executeQuery (queryString);
            String colType;
	          while (rset.next ()){
                Vector tmp = new Vector();
                tmp.addElement(new Boolean("false")); // view column
                for (int i=0;i<colNames.size();i++){
                  colType = (String)colInfo.get((String)colNames.elementAt(i));
                  if (colType.equalsIgnoreCase("NUMBER")){
                  tmp.addElement(new Integer(rset.getInt(i+1)));
                  }else {
                  tmp.addElement(new String(rset.getString(i+1)));
                  }

                }
                data.addElement(tmp);
            }
            colNames.insertElementAt(new String("view"),0);
          rset.close();
          stmt.close();
        }catch(SQLException s){KShareObject.showErrorMessage("ERROR",queryString +" \n"+s.getMessage());}

    }
   retV.addElement(data);
   retV.addElement(colNames);
   retV.addElement(colInfo);


   return retV;

  }
  private  static Vector getData2(String tableName,Vector columnNames,Hashtable colInfo){
    Vector retV = new Vector();
    Vector data = new Vector();
    Vector colNames = (Vector)columnNames.clone();
    if (colNames.size()>0){
        String queryString = "SELECT ";
        for (int i=0;i<colNames.size();i++){
             queryString = queryString+ (i==0?" ":",")+(String)colNames.elementAt(i);
        }
        queryString = queryString+" FROM "+tableName;

        try {
            Statement stmt = conn.createStatement ();
	          ResultSet rset = stmt.executeQuery (queryString);
            String colType;
	          while (rset.next ()){
                Vector tmp = new Vector();
                tmp.addElement(new Boolean("false")); // view column
                for (int i=0;i<colNames.size();i++){
                  colType = (String)colInfo.get((String)colNames.elementAt(i));
                  if (colType.equalsIgnoreCase("NUMBER")){
                  tmp.addElement(new Integer(rset.getInt(i+1)));
                  }else {
                  tmp.addElement(new String(rset.getString(i+1)));
                  }

                }
                data.addElement(tmp);
            }
            colNames.insertElementAt(new String("view"),0);
          rset.close();
          stmt.close();
        }catch(SQLException s){KShareObject.showErrorMessage("ERROR",queryString +" \n"+s.getMessage());}

    }
   retV.addElement(data);
   retV.addElement(colNames);
   retV.addElement(colInfo);


   return retV;

  }


  private static Hashtable getBuildingTable(){
    Hashtable t = new Hashtable();

    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (buildingQuery);
      Vector data = new Vector();
	    while (rset.next ()){
            t.put(new Integer(rset.getInt(1)),new KBuildingInfo(rset.getString(2),rset.getString(3),rset.getString(4)));
            Vector tmp = new Vector();
            for (int i=1;i<=4;i++){
            tmp.addElement(rset.getString(1));
            }
            data.addElement(tmp);

      }
      _buildingTable = data;
      rset.close();
      stmt.close();
    }
    catch(SQLException s)
    {
    KShareObject.showErrorMessage("ERROR","Can't get Building Table"+s.getMessage());
    }


    return t;


  }
  private static Hashtable getOrgTable(){
    Hashtable t = new Hashtable();
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (orgQuery);

	    while (rset.next ()){
//            data.addElement(new String(rset.getString(1)));
            t.put(new String(rset.getString(1)),new String(rset.getString(2)));

      }
    rset.close();
    stmt.close();
    }catch(SQLException s){KShareObject.showErrorMessage("ERROR","Can't get Organization\n"+s.getMessage());}

    return t;
  }
  public static Vector getLayerNameOfBuilding(int buildingGid){
    Vector data= new Vector();
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (buildingMappingQuery+" WHERE building_GID="+buildingGid+" ORDER BY FLOORNO");

	    while (rset.next ()){
            data.addElement(new String(rset.getString(1)));
      }
    rset.close();
    stmt.close();
    }catch(SQLException s){KShareObject.showErrorMessage("ERROR","Can't get any layers of building"+s.getMessage());}

     return data;

  }


  public static Hashtable getRoomTypeNames(){
    Hashtable roomHash = new Hashtable();
    _roomTypeR = new Hashtable();
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (roomTypeQuery);

	    while (rset.next ()){
          roomHash.put(new Integer(rset.getInt(1)),rset.getString(2));
          _roomTypeR.put(rset.getString(2),new Integer(rset.getInt(1)));

      }
    rset.close();
    stmt.close();
    }
    catch(SQLException s)
    {
    KShareObject.showErrorMessage("ERROR","Can't get Room type name cause\n"+s.getMessage());
    }


    return roomHash;
  }

  public static Hashtable getRoomTypeHash(){
    return _roomType;
  }
  public static Vector getRoomColumnNames(){
    return _roomColumnNames;
  }
/*
  private  static Vector getColumnNames(String tableName){
    Vector columnNamesVector = new Vector();
    try {
      Statement stmt = conn.createStatement ();
	    ResultSet rset = stmt.executeQuery (columnNameQuery+"'"+tableName.toUpperCase()+"'");
      columnNamesVector.addElement(new String("view"));
	    while (rset.next ()){
       columnNamesVector.addElement(new String(rset.getString(1)));
      }
    }catch(SQLException s){System.out.println("Can't get columnnames cause"+s.getMessage());}

    return columnNamesVector;
  }
*/

  public static KPolyDepot getFenceQuery(String layerName){
  return(getGraphicsQuery(layerName+"_FENCE"));
  }

  public static KPolyDepot getQuery(String layerName){
      KPolyDepot kpd = getGraphicsQuery(layerName);
      KPolyDepot kpd2 = getFenceQuery(layerName);
      if (kpd2 != null) {kpd.setFence((KPolyDepot)kpd2.clone());}
      else { KShareObject.showErrorMessage("ERROR","Can't load fence "+layerName);};
      return kpd;
  }
  public static KPolyDepot getGraphicsQuery(String layerName){

  KPolyDepot kd = new KPolyDepot();
  Vector resultX= new Vector();
  Vector resultY= new Vector();
  Random rnd = new Random();
  int[] result = new int[4];
  int prevGID = 0;
  Color newColor = Color.blue;

  try {

  Statement stmt = conn.createStatement ();
	ResultSet rset = stmt.executeQuery (graphicsQuery+layerName+"_sdogeom");

	while (rset.next ()){
    result[0] = rset.getInt(1);
    result[1] = rset.getInt(2);
    result[2] = rset.getInt(3);
    result[3] = rset.getInt(4);

      resultX.removeAllElements();
      resultY.removeAllElements();

      int count = 0;
      boolean stop = false;
      for(int i=1;i<=64&&(!stop);i=i+2)
  	  {

       try {
       float tmpX = rset.getFloat(i+4);
       float tmpY = rset.getFloat(i+5);
       if (tmpX != 0 && tmpY !=0){
       resultX.addElement(new Float(tmpX));
	     resultY.addElement(new Float(tmpY));
       count++;} else {stop = true;}


       }catch (Exception ex)
       { stop = true;}
       }// end for
      float X[] = new float[resultX.size()];
      float Y[] = new float[resultY.size()];

      for (int i=0;i<resultX.size();i++){
        Float x = (Float)resultX.elementAt(i);
        X[i] =x.floatValue();
      }

      for (int i=0;i<resultY.size();i++){
        Float y = (Float)resultY.elementAt(i);
        Y[i] = y.floatValue();
      }

      if (prevGID != result[0]){
        newColor = getColor();
        prevGID = result[0];
      }
      kd.add(new KPoly(result[0],X,Y,count,newColor));
      //System.out.println(count);
   } // end while

    rset.close();
    stmt.close();
      }catch(SQLException s){return null;}

   return(kd);
  }
   public static Color getColor(){
   colorCounter = (colorCounter+1)%8;
  switch (colorCounter){
  case 0 : return(Color.blue);
  case 1 : return(Color.cyan);
  case 2 : return(Color.green);
  case 3 : return(Color.orange);
  case 4 : return(Color.pink);
  case 5 : return(Color.red);
  case 6 : return(Color.white);
  case 7 : return(Color.yellow);
  default: return(Color.blue);
  }

  }

}
class KRoomGidQuery{
  int floorNo;
  int roomGid;
  public KRoomGidQuery(int floorNo,int roomGid)
  {
    this.floorNo = floorNo;
    this.roomGid = roomGid;
  }

}
class KTableWrapper{
  Vector col;
  Vector data;
  Hashtable colInfo;
  public KTableWrapper(Vector c,Vector d,Hashtable info){
  col = c;
  data = d;
  colInfo = info;
  }
  public Vector getColNames(){
    return col;
  }
  public Vector getData(){
    return data;
  }
  public Hashtable getColInfo(){
    return colInfo;
  }

}
class KMainMapInfo{
String layerName;
String tableInfoName;
String title;
  public KMainMapInfo(String lname,String taname,String tiname)
  {
    layerName = lname;
    tableInfoName = taname;
    title = tiname;
  }
}
class KBuildingInfo{
  String bName;
  String    bId;
  String    orgId;
  public KBuildingInfo(String buildingName,String buildingId,String orgId){
    this.bName = buildingName;
    this.bId = buildingId;
    this.orgId = orgId;
  }
  public String getBuildingName(){
    return bName;
  }
  public String getBuildingId(){
    return bId;
  }
  public String getOrgId(){
    return orgId;
  }
}
