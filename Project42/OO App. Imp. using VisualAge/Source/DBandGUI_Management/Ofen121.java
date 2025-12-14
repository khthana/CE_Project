package DBandGUI_Management;

import com.ibm.db.*;
import com.ibm.db.base.*;
import com.ibm.ivj.db.uibeans.*;
public class Ofen121 extends DatabaseAccess {
public static StatementMetaData CusID() throws Throwable {
  String name = "DBandGUI_Management.Ofen121.CusID";
  String statement = "SELECT PROJECT.CUSTOMER.CUSTOMERID FROM PROJECT.CUSTOMER ORDER BY PROJECT.CUSTOMER.CUSTOMERID";

  StatementMetaData aSpec = null;
  try{
	aSpec = new StatementMetaData();
	aSpec.setName(name);
	aSpec.setSQL(statement);
	aSpec.addTable("PROJECT.CUSTOMER");
	aSpec.addColumn("CUSTOMER.CUSTOMERID", 3,3);
  }
  catch(java.lang.Throwable e){throw e;}
  return aSpec;
/*V2.0
**start of SQL Assist data**
504b030414g08g08gb7ae4b28gggggggggggg0cggg6275696c64657220646174615af39681b5b48841
243ada272bb12c512f27312f5d2fb8a428332fdddac897736d8bd193702606868a020606065ea042612cead65e0a7bfe52b6
da1da68ea98481d9c4c0b08481d1b0b490a18e810922c66a62601c6f50c2201d10e4efe5ea1ca2e71c1a1ce2efeb1a046778
baa0a83784a81740578fac88d9128b45960646a458c46806c4aa2822a6250c1c50ddd628d61963f517d83a46031495860646
182a8d412a410282684a0dd1b503fdgf63ca331408001g504b070869194093b6ggga201gg504b010214g14g08g
08gb7ae4b2869194093b6ggga201gg0cggggggggggggggggg6275696c6465722064617461504b
0506gggg01g01g3agggf0ggggg
**end of SQL Assist data**/
}
public static StatementMetaData CusSQL() throws Throwable {
  String name = "DBandGUI_Management.Ofen121.CusSQL";
  String statement = "SELECT PROJECT.CUSTOMER.CUSTOMERID, PROJECT.CUSTOMER.FIRSTNAME, PROJECT.CUSTOMER.LASTNAME, PROJECT.CUSTOMER.PRESENTADDRESS, PROJECT.CUSTOMER.STREET, PROJECT.CUSTOMER.DISTRICT, PROJECT.CUSTOMER.PROVINCE, PROJECT.CUSTOMER.TELEPHONE, PROJECT.CUSTOMER.OCCUPATION, PROJECT.CUSTOMER.COMPANY, PROJECT.CUSTOMER.SALARY FROM PROJECT.CUSTOMER ORDER BY PROJECT.CUSTOMER.CUSTOMERID";

  StatementMetaData aSpec = null;
  try{
	aSpec = new StatementMetaData();
	aSpec.setName(name);
	aSpec.setSQL(statement);
	aSpec.addTable("PROJECT.CUSTOMER");
	aSpec.addColumn("CUSTOMER.CUSTOMERID", 3,3);
	aSpec.addColumn("CUSTOMER.FIRSTNAME", 12,12);
	aSpec.addColumn("CUSTOMER.LASTNAME", 12,12);
	aSpec.addColumn("CUSTOMER.PRESENTADDRESS", 12,12);
	aSpec.addColumn("CUSTOMER.STREET", 12,12);
	aSpec.addColumn("CUSTOMER.DISTRICT", 12,12);
	aSpec.addColumn("CUSTOMER.PROVINCE", 12,12);
	aSpec.addColumn("CUSTOMER.TELEPHONE", 12,12);
	aSpec.addColumn("CUSTOMER.OCCUPATION", 12,12);
	aSpec.addColumn("CUSTOMER.COMPANY", 12,12);
	aSpec.addColumn("CUSTOMER.SALARY", 3,3);
  }
  catch(java.lang.Throwable e){throw e;}
  return aSpec;
/*V2.0
**start of SQL Assist data**
504b030414g08g08g1d824b28gggggggggggg0cggg6275696c64657220646174619494cd4ac3401446
6f5a2aba132c542b45411444a99924fd095d8574d4489a8424ad942e4a574591a2652a82e0cac7b12fe33308e2c27730b755
697ac785bbe170e6e6e3f24d5e3e21371943bed773af07f783f2cd60342c47627c351a36b4d6daf4597bbbccg3cdc02c051
226e48bce96be7fda3f478f6e36504640d950950d8e40e9e2033673943d5fbaa80ed20f42fb81d97ed7614fb2d1efe1e9ce6
a2bf62263e4b2e287a6a0c9b8f595f1eb328654dfc7e86a50398aad637056cd2g7e2bb0bc2e91ebb2b4be6db7032b767c8f
f8350145e2c7dce5c1b9ef71a257056c113d011dc7b3a95d91d94d278a43c78e896d0828103b7139a7ae2e6047928347dc8b
ad66333944e48e264be35a51ec592d9a9dc91673ea847fe8ff6889922c51d94f916451abdfb71ba952e8b252e8580a047982
eb080a04d710145355458c5595acdc72adb04b6654119496ea8e3390584bcf66b6104525432a0876093610ec11ac23382058
4370483043709c5a1f5335f2a6519d653e595219498ccfd9c4fd6b04d7e5b826c75539aec8b121c7ba1c6b72cce478f673fa
1260g504b0708c80e0dc49b01gg4305gg504b010214g14g08g08g1d824b28c80e0dc49b01gg4305gg0cgg
ggggggggggggggg6275696c6465722064617461504b0506gggg01g01g3agggd501gggg
**end of SQL Assist data**/
}
public static com.ibm.db.DatabaseConnection Project_Ofen121() throws Throwable, com.ibm.db.DataException {
  com.ibm.db.DatabaseConnection connection = null;
  try{ 
	connection = new com.ibm.db.DatabaseConnection();
	connection.setConnectionAlias("DBandGUI_Management.Ofen121.Project_Ofen121");
	connection.setDriverName("oracle.jdbc.driver.OracleDriver");
	connection.setDataSourceName("jdbc:oracle:thin:@161.246.6.121:1521:orcl");
	connection.setUserID("project");
	connection.setPromptUID(false);
	connection.setAutoCommit(true);
	connection.setPassword("acedg0574g066a756c793937", true);
  }
  catch(com.ibm.db.DataException e){throw e;}
  catch(java.lang.Throwable e){throw e;}
  return connection;
}
}