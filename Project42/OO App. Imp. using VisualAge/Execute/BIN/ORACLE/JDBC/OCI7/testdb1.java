package oracle.jdbc.oci7;

import com.ibm.db.*;
import com.ibm.db.base.*;
import com.ibm.ivj.db.uibeans.*;
public class testdb1 extends DatabaseAccess {
public static StatementMetaData a() throws Throwable {
  String name = "oracle.jdbc.oci7.testdb1.a";
  String statement = "select * from a";

  StatementMetaData aSpec = null;
  try{
	aSpec = new StatementMetaData();
	aSpec.setName(name);
	aSpec.setSQL(statement);
  }
  catch(java.lang.Throwable e){throw e;}
  return aSpec;
}
}