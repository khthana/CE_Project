
//Title:        Your Product Name
//Version:
//Copyright:    Copyright (c) 1998
//Author:       Your Name
//Company:      Your Company
//Description:  Your description


package KCOM;
import java.util.*;

public class KBuilding {
  int orgId;
  int buildingId;
  int sdo_gid;
  public KBuilding(int oId,int bId,int sId) {
    orgId = oId;
    buildingId = bId;
    sdo_gid = sId;
  }

}
class KOrganization {
  int sdo_gid;
  int orgId;
  String orgName;
  public KOrganization(int sId,int oId,String oName){
    sdo_gid = sId;
    orgId = oId;
    orgName = oName;
  }
}

class KInstitue extends Hashtable{
  public void addData(Object key,Object value){
    this.put(key,value);
  }
  public String getOrgName(int orgId){
    return (String)this.get(new Integer(orgId));
  }

}