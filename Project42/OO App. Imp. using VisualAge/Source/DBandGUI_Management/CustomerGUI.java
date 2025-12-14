package DBandGUI_Management;

import DBandGUI_Management.*;
import Project_Information.*;
import java.io.*;
import java.sql.*;
import java.awt.*;
import com.sun.java.swing.*;
/**
 * This type was created in VisualAge.
 */
public class CustomerGUI implements java.awt.event.ActionListener, java.awt.event.WindowListener, java.beans.PropertyChangeListener {
	// insert by ofen
	public JFrame fEMPMenu=null;
	public Calculate c = new Calculate();
	public MainDB m = new MainDB();
	public Customer customer = new Customer();
	public Connection conS;
	public int EnterID = 0;
	public int IDEmployee = 0;
	private JFrame ivjCusMFrame = null;
	private JPanel ivjJFrameContentPane = null;
	private JMenuBar ivjCusMFrameJMenuBar = null;
	private JMenu ivjMFile = null;
	private JMenu ivjMHelp = null;
	private JMenuItem ivjMIExit = null;
	private JMenu ivjMTools = null;
	private JMenu ivjMWindow = null;
	private com.ibm.ivj.db.uibeans.DBNavigator ivjDBNavigator1 = null;
	private JTable ivjScrollPaneTable = null;
	private DBandGUI_Management.GetCustomerColName ivjCusSelectBean = null;
	private JButton ivjBAdd = null;
	private JButton ivjBClear = null;
	private JButton ivjBremove = null;
	private JButton ivjBUpdate = null;
	private JLabel ivjJLabel10 = null;
	private JLabel ivjJLabel11 = null;
	private JLabel ivjJLabel12 = null;
	private JLabel ivjJLabel13 = null;
	private JLabel ivjJLabel14 = null;
	private JLabel ivjJLabel15 = null;
	private JLabel ivjJLabel16 = null;
	private JLabel ivjJLabel17 = null;
	private JLabel ivjJLabel18 = null;
	private JLabel ivjJLabel19 = null;
	private JLabel ivjJLabel20 = null;
	private JLabel ivjJLabel21 = null;
	private JLabel ivjJLabel22 = null;
	private JLabel ivjJLabel23 = null;
	private JLabel ivjJLabel3 = null;
	private JLabel ivjJLabel4 = null;
	private JLabel ivjJLabel5 = null;
	private JLabel ivjJLabel6 = null;
	private JLabel ivjJLabel7 = null;
	private JLabel ivjJLabel8 = null;
	private JLabel ivjJLabel9 = null;
	private JTextField ivjTFAddress = null;
	private JTextField ivjTFCompany = null;
	private JTextField ivjTFCustomerID = null;
	private JTextField ivjTFDistrict = null;
	private JTextField ivjTFEnterID = null;
	private JTextField ivjTFExpiryDate = null;
	private JTextField ivjTFFirstname = null;
	private JTextField ivjTFIDCardNumber = null;
	private JTextField ivjTFIssuedAt = null;
	private JTextField ivjTFIssuedDate = null;
	private JTextField ivjTFLastname = null;
	private JTextField ivjTFNationality = null;
	private JTextField ivjTFOccupation = null;
	private JTextField ivjTFPager = null;
	private JTextField ivjTFProvince = null;
	private JTextField ivjTFRace = null;
	private JTextField ivjTFReligion = null;
	private JTextField ivjTFSalary = null;
	private JTextField ivjTFSex = null;
	private JTextField ivjTFStatus = null;
	private JTextField ivjTFStreet = null;
	private JTextField ivjTFTelephone = null;
	private JTextField ivjTFTotalContract = null;
	private com.ibm.ivj.db.uibeans.Select ivjControlIDBean = null;
	private JButton ivjBLoad = null;
	private JLabel ivjJLabel25 = null;
	private JPanel ivjJPanel1 = null;
	private JLabel ivjJLabel26 = null;
	private JScrollPane ivjJScrollPane1 = null;
	private JDialog ivjDProtect = null;
	private JButton ivjJButton1 = null;
	private JButton ivjJButton2 = null;
	private JPanel ivjJDialogContentPane = null;
	private JLabel ivjLQuestion = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public CustomerGUI() {
	super();
	initialize();
}
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public CustomerGUI(JFrame jf,int id) {
	super();
	fEMPMenu = jf;
	IDEmployee = id;
	fEMPMenu.setEnabled(false);
	initialize();
}
/**
 * Method to handle events for the ActionListener interface.
 * @param e java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void actionPerformed(java.awt.event.ActionEvent e) {
	// user code begin {1}
	// user code end
	if ((e.getSource() == getTFCustomerID()) ) {
		connEtoC1(e);
	}
	if ((e.getSource() == getBLoad()) ) {
		connEtoC2(e);
	}
	if ((e.getSource() == getBClear()) ) {
		connEtoC3(e);
	}
	if ((e.getSource() == getBAdd()) ) {
		connEtoC4(e);
	}
	if ((e.getSource() == getBUpdate()) ) {
		connEtoC6(e);
	}
	if ((e.getSource() == getJButton1()) ) {
		connEtoC8(e);
	}
	if ((e.getSource() == getJButton2()) ) {
		connEtoM1(e);
	}
	if ((e.getSource() == getJButton1()) ) {
		connEtoM2(e);
	}
	if ((e.getSource() == getBremove()) ) {
		connEtoM3(e);
	}
	if ((e.getSource() == getMIExit()) ) {
		connEtoM4(e);
	}
	// user code begin {2}
	// user code end
}
/**
 * Comment
 */
public void bAdd_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	System.out.println("Add Customer");
	try {
			System.out.println("check add 1");
			customer.setString("Firstname",ivjTFFirstname.getText());
			customer.setString("Lastname",ivjTFLastname.getText());
			customer.setString("Sex",ivjTFSex.getText());
			customer.setString("Nationality",ivjTFNationality.getText());
			customer.setString("Race",ivjTFRace.getText());
			customer.setString("Religion",ivjTFReligion.getText());
			customer.setString("Status",ivjTFStatus.getText());
			customer.setString("PresentAddress",ivjTFAddress.getText());
			customer.setString("Street",ivjTFStreet.getText());
			customer.setString("District",ivjTFDistrict.getText());
			customer.setString("Province",ivjTFProvince.getText());
			customer.setString("Telephone",ivjTFTelephone.getText());
			customer.setString("Pager",ivjTFPager.getText());
			customer.setString("IDcardNumber",ivjTFIDCardNumber.getText());
			customer.setString("IssuedAt",ivjTFIssuedAt.getText());
			System.out.println("check add 2");			

			customer.setDate2("IssuedDate",ivjTFIssuedDate.getText());
			customer.setDate2("ExpiryDate",ivjTFExpiryDate.getText());

			System.out.println("check add 3");			
			customer.setString("Occupation",ivjTFOccupation.getText());
			customer.setString("Company",ivjTFCompany.getText());
			customer.setNumber("Salary",c.toInt(ivjTFSalary.getText()));
			customer.setNumber("EnterID",IDEmployee);
			customer.setNumber("TotalContract",c.toInt(ivjTFTotalContract.getText()));
			System.out.println("check add 4");

//			customer.setDate("IssuedDate",1999,"Sep",12);

//			customer.setDate("ExpiryDate",2002,"Dec",17);
			
			customer.add2(conS);
			System.out.println("end add ");

		
	}
	catch(IOException ie) {;}
	catch(SQLException se) {;}
	System.out.println("add ok");

			try {
				getCusSelectBean().refresh();
				getControlIDBean().refresh();
			} catch (java.lang.Throwable ivjExc) { handleException(ivjExc);}

}
/**
 * Comment
 */
public void bClear_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	System.out.println("clear Customer");
	
			ivjTFCustomerID.setText("");
			ivjTFFirstname.setText("");
			ivjTFLastname.setText("");
			ivjTFSex.setText("");
			ivjTFNationality.setText("");
			ivjTFRace.setText("");
			ivjTFReligion.setText("");
			ivjTFStatus.setText("");
			ivjTFAddress.setText("");
			ivjTFStreet.setText("");
			ivjTFDistrict.setText("");
			ivjTFProvince.setText("");
			ivjTFTelephone.setText("");
			ivjTFPager.setText("");
			ivjTFIDCardNumber.setText("");
			ivjTFIssuedAt.setText("");
			ivjTFIssuedDate.setText("");
			ivjTFExpiryDate.setText("");
			ivjTFOccupation.setText("");
			ivjTFCompany.setText("");
			ivjTFSalary.setText("");
			ivjTFEnterID.setText("");
			ivjTFTotalContract.setText("");
		
	
	
}
/**
 * Comment
 */
public void bLoad_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	System.out.println("Load Customer");
	try {
		System.out.println("Customer Text "+c.toInt(ivjTFCustomerID.getText()));
		if (customer.load(conS,c.toInt(ivjTFCustomerID.getText()))) {
			ivjTFFirstname.setText(customer.getString("Firstname"));
			ivjTFLastname.setText(customer.getString("Lastname"));
			ivjTFSex.setText(customer.getString("Sex"));
			ivjTFNationality.setText(customer.getString("Nationality"));
			ivjTFRace.setText(customer.getString("Race"));
			ivjTFReligion.setText(customer.getString("Religion"));
			ivjTFStatus.setText(customer.getString("Status"));
			ivjTFAddress.setText(customer.getString("PresentAddress"));
			ivjTFStreet.setText(customer.getString("Street"));
			ivjTFDistrict.setText(customer.getString("District"));
			ivjTFProvince.setText(customer.getString("Province"));
			ivjTFTelephone.setText(customer.getString("Telephone"));
			ivjTFPager.setText(customer.getString("Pager"));
			ivjTFIDCardNumber.setText(customer.getString("IDcardNumber"));
			ivjTFIssuedAt.setText(customer.getString("IssuedAt"));
			ivjTFIssuedDate.setText(customer.getDateString("IssuedDate"));
			ivjTFExpiryDate.setText(customer.getDateString("ExpiryDate"));
			ivjTFOccupation.setText(customer.getString("Occupation"));
			ivjTFCompany.setText(customer.getString("Company"));
			ivjTFSalary.setText(""+customer.getNumber("Salary"));
			ivjTFEnterID.setText(""+customer.getNumber("EnterID"));
			ivjTFTotalContract.setText(""+customer.getNumber("TotalContract"));
		}
	}
	catch(IOException ie) {System.out.println(""+ie);}
	catch(SQLException se) {System.out.println(""+se);}
}
/**
 * Comment
 */
public void bremove_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	System.out.println("Remove Customer");
	try{
			if (c.toInt(ivjTFCustomerID.getText()) > 0) {
				customer.remove(conS,c.toInt(ivjTFCustomerID.getText()));
				
			}
	}
	catch(IOException ie) {;}
	catch(SQLException se) {;}
	try {
					getCusSelectBean().refresh();
				    getControlIDBean().refresh();
	} catch (java.lang.Throwable ivjExc) { handleException(ivjExc);}
	
}
/**
 * Comment
 */
public void bUpdate_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	System.out.println("Update Customer");
	if (c.toInt(ivjTFCustomerID.getText()) > 0   )
	try {
		
			customer.setString("Firstname",ivjTFFirstname.getText());
			customer.setString("Lastname",ivjTFLastname.getText());
			customer.setString("Sex",ivjTFSex.getText());
			customer.setString("Nationality",ivjTFNationality.getText());
			customer.setString("Race",ivjTFRace.getText());
			customer.setString("Religion",ivjTFReligion.getText());
			customer.setString("Status",ivjTFStatus.getText());
			customer.setString("PresentAddress",ivjTFAddress.getText());
			customer.setString("Street",ivjTFStreet.getText());
			customer.setString("District",ivjTFDistrict.getText());
			customer.setString("Province",ivjTFProvince.getText());
			customer.setString("Telephone",ivjTFTelephone.getText());
			customer.setString("Pager",ivjTFPager.getText());
			customer.setString("IDcardNumber",ivjTFIDCardNumber.getText());
			customer.setString("IssuedAt",ivjTFIssuedAt.getText());
			customer.setDate2("IssuedDate",ivjTFIssuedDate.getText());
			customer.setDate2("ExpiryDate",ivjTFExpiryDate.getText());
			customer.setString("Occupation",ivjTFOccupation.getText());
			customer.setString("Company",ivjTFCompany.getText());
			customer.setNumber("Salary",c.toInt(ivjTFSalary.getText()));
			customer.setNumber("EnterID",IDEmployee);
			customer.setNumber("TotalContract",c.toInt(ivjTFTotalContract.getText()));
			customer.upDate(conS,c.toInt(ivjTFCustomerID.getText()));

			
		
	}
	catch(IOException ie) {;}
	catch(SQLException se) {;}
	try {
				getCusSelectBean().refresh();
				getControlIDBean().refresh();
	} catch (java.lang.Throwable ivjExc) { handleException(ivjExc);}
	
}
/**
 * connEtoC1:  (TFCustomerID.action.actionPerformed(java.awt.event.ActionEvent) --> CustomerGUI.tFCustomerID_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC1(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.tFCustomerID_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC2:  (BLoad.action.actionPerformed(java.awt.event.ActionEvent) --> CustomerGUI.bLoad_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC2(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.bLoad_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC3:  (BClear.action.actionPerformed(java.awt.event.ActionEvent) --> CustomerGUI.bClear_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.bClear_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC4:  (BAdd.action.actionPerformed(java.awt.event.ActionEvent) --> CustomerGUI.bAdd_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC4(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.bAdd_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC5:  (CusMFrame.window.windowClosed(java.awt.event.WindowEvent) --> CustomerGUI.cusMFrame_WindowClosed(Ljava.awt.event.WindowEvent;)V)
 * @param arg1 java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC5(java.awt.event.WindowEvent arg1) {
	try {
		// user code begin {1}
		fEMPMenu.setEnabled(true);
		// user code end
		this.cusMFrame_WindowClosed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC6:  (BUpdate.action.actionPerformed(java.awt.event.ActionEvent) --> CustomerGUI.bUpdate_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC6(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.bUpdate_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC8:  (JButton1.action.actionPerformed(java.awt.event.ActionEvent) --> CustomerGUI.jButton1_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC8(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.jButton1_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM1:  (JButton2.action.actionPerformed(java.awt.event.ActionEvent) --> DProtect.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM1(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getDProtect().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM2:  (JButton1.action.actionPerformed(java.awt.event.ActionEvent) --> DProtect.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM2(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getDProtect().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM3:  (Bremove.action.actionPerformed(java.awt.event.ActionEvent) --> DProtect.show()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM3(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getDProtect().show();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM4:  (MIExit.action.actionPerformed(java.awt.event.ActionEvent) --> CusMFrame.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM4(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getCusMFrame().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connPtoP1SetTarget:  (CusSelectBean.this <--> ScrollPaneTable.model)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connPtoP1SetTarget() {
	/* Set the target from the source */
	try {
		getScrollPaneTable().setModel(getCusSelectBean());
		getScrollPaneTable().createDefaultColumnsFromModel();
		// user code begin {1}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connPtoP3SetTarget:  (ScrollPaneTable.selectedRow <--> CusTab.currentRow)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connPtoP3SetTarget() {
	/* Set the target from the source */
	try {
		getDBNavigator1().setModel(getControlIDBean());
		// user code begin {1}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connPtoP6SetTarget:  (ControlIDBean.CUSTOMER.CUSTOMERID_String <--> TFCustomerID.text)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connPtoP6SetTarget() {
	/* Set the target from the source */
	try {
		getTFCustomerID().setText(getControlIDBean().getColumnValueToString("CUSTOMER.CUSTOMERID"));
		// user code begin {1}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * Comment
 */
public void controlIDBean_CacheRowsChanged(com.ibm.db.DataEvent dataEvent) {
	System.out.println("Load Customer");
	try {
		System.out.println("Customer Text "+c.toInt(ivjTFCustomerID.getText()));
		if (customer.load(conS,c.toInt(ivjTFCustomerID.getText()))) {
			ivjTFFirstname.setText(customer.getString("Firstname"));
			ivjTFLastname.setText(customer.getString("Lastname"));
			ivjTFSex.setText(customer.getString("Sex"));
			ivjTFNationality.setText(customer.getString("Nationality"));
			ivjTFRace.setText(customer.getString("Race"));
			ivjTFReligion.setText(customer.getString("Religion"));
			ivjTFStatus.setText(customer.getString("Status"));
			ivjTFAddress.setText(customer.getString("PresentAddress"));
			ivjTFStreet.setText(customer.getString("Street"));
			ivjTFDistrict.setText(customer.getString("District"));
			ivjTFProvince.setText(customer.getString("Province"));
			ivjTFTelephone.setText(customer.getString("Telephone"));
			ivjTFPager.setText(customer.getString("Pager"));
			ivjTFIDCardNumber.setText(customer.getString("IDcardNumber"));
			ivjTFIssuedAt.setText(customer.getString("IssuedAt"));
			ivjTFIssuedDate.setText(customer.getDateString("IssuedDate"));
			ivjTFExpiryDate.setText(customer.getDateString("ExpiryDate"));
			ivjTFOccupation.setText(customer.getString("Occupation"));
			ivjTFCompany.setText(customer.getString("Company"));
			ivjTFSalary.setText(""+customer.getNumber("Salary"));
			ivjTFEnterID.setText(""+customer.getNumber("EnterID"));
			ivjTFTotalContract.setText(""+customer.getNumber("TotalContract"));
		}
	}
	catch(IOException ie) {System.out.println(""+ie);}
	catch(SQLException se) {System.out.println(""+se);}
	
}
/**
 * Comment
 */
public void cusMFrame_WindowClosed(java.awt.event.WindowEvent windowEvent) {
	return;
}
/**
 * Comment
 */
public void dBNavigator1_ExceptionEvents() {
	System.out.println("key press");

}
/**
 * Comment
 */
public void dBNavigator1_ExceptionOccurred(com.ibm.ivj.db.uibeans.ExceptionEvent exceptionEvent) {
	System.out.println("Load Customer");
	try {
		System.out.println("Customer Text "+c.toInt(ivjTFCustomerID.getText()));
		if (customer.load(conS,c.toInt(ivjTFCustomerID.getText()))) {
			ivjTFFirstname.setText(customer.getString("Firstname"));
			ivjTFLastname.setText(customer.getString("Lastname"));
			ivjTFSex.setText(customer.getString("Sex"));
			ivjTFNationality.setText(customer.getString("Nationality"));
			ivjTFRace.setText(customer.getString("Race"));
			ivjTFReligion.setText(customer.getString("Religion"));
			ivjTFStatus.setText(customer.getString("Status"));
			ivjTFAddress.setText(customer.getString("PresentAddress"));
			ivjTFStreet.setText(customer.getString("Street"));
			ivjTFDistrict.setText(customer.getString("District"));
			ivjTFProvince.setText(customer.getString("Province"));
			ivjTFTelephone.setText(customer.getString("Telephone"));
			ivjTFPager.setText(customer.getString("Pager"));
			ivjTFIDCardNumber.setText(customer.getString("IDcardNumber"));
			ivjTFIssuedAt.setText(customer.getString("IssuedAt"));
			ivjTFIssuedDate.setText(customer.getDateString("IssuedDate"));
			ivjTFExpiryDate.setText(customer.getDateString("ExpiryDate"));
			ivjTFOccupation.setText(customer.getString("Occupation"));
			ivjTFCompany.setText(customer.getString("Company"));
			ivjTFSalary.setText(""+customer.getNumber("Salary"));
			ivjTFEnterID.setText(""+customer.getNumber("EnterID"));
			ivjTFTotalContract.setText(""+customer.getNumber("TotalContract"));
		}
	}
	catch(IOException ie) {System.out.println(""+ie);}
	catch(SQLException se) {System.out.println(""+se);}
	return;
}
/**
 * Return the JButton2 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBAdd() {
	if (ivjBAdd == null) {
		try {
			ivjBAdd = new com.sun.java.swing.JButton();
			ivjBAdd.setName("BAdd");
			ivjBAdd.setText("ADD");
			ivjBAdd.setBounds(430, 474, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBAdd;
}
/**
 * Return the JButton1 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBClear() {
	if (ivjBClear == null) {
		try {
			ivjBClear = new com.sun.java.swing.JButton();
			ivjBClear.setName("BClear");
			ivjBClear.setText("CLEAR");
			ivjBClear.setBounds(700, 474, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBClear;
}
/**
 * Return the BExit property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBLoad() {
	if (ivjBLoad == null) {
		try {
			ivjBLoad = new com.sun.java.swing.JButton();
			ivjBLoad.setName("BLoad");
			ivjBLoad.setText("LOAD");
			ivjBLoad.setBounds(340, 474, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBLoad;
}
/**
 * Return the JButton3 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBremove() {
	if (ivjBremove == null) {
		try {
			ivjBremove = new com.sun.java.swing.JButton();
			ivjBremove.setName("Bremove");
			ivjBremove.setText("REMOVE");
			ivjBremove.setBounds(520, 474, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBremove;
}
/**
 * Return the JButton4 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBUpdate() {
	if (ivjBUpdate == null) {
		try {
			ivjBUpdate = new com.sun.java.swing.JButton();
			ivjBUpdate.setName("BUpdate");
			ivjBUpdate.setText("UPDATE");
			ivjBUpdate.setBounds(610, 474, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBUpdate;
}
/**
 * Return the ControlIDBean property value.
 * @return com.ibm.ivj.db.uibeans.Select
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.ibm.ivj.db.uibeans.Select getControlIDBean() {
	if (ivjControlIDBean == null) {
		try {
			ivjControlIDBean = new com.ibm.ivj.db.uibeans.Select();
			ivjControlIDBean.setPacketSize(0);
			ivjControlIDBean.setMaximumRows(0);
			ivjControlIDBean.setQuery(new com.ibm.ivj.db.uibeans.Query(DBandGUI_Management.Ofen121.Project_Ofen121(), DBandGUI_Management.Ofen121.CusID()));
			ivjControlIDBean.setMaximumPacketsInCache(0);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjControlIDBean;
}
/**
 * Return the CusMFrame property value.
 * @return com.sun.java.swing.JFrame
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JFrame getCusMFrame() {
	if (ivjCusMFrame == null) {
		try {
			ivjCusMFrame = new com.sun.java.swing.JFrame();
			ivjCusMFrame.setName("CusMFrame");
			ivjCusMFrame.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjCusMFrame.setJMenuBar(getCusMFrameJMenuBar());
			ivjCusMFrame.setBounds(0, 0, 800, 570);
			ivjCusMFrame.setTitle("Customer Management");
			getCusMFrame().setContentPane(getJFrameContentPane());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjCusMFrame;
}
/**
 * Return the CusMFrameJMenuBar property value.
 * @return com.sun.java.swing.JMenuBar
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JMenuBar getCusMFrameJMenuBar() {
	if (ivjCusMFrameJMenuBar == null) {
		try {
			ivjCusMFrameJMenuBar = new com.sun.java.swing.JMenuBar();
			ivjCusMFrameJMenuBar.setName("CusMFrameJMenuBar");
			ivjCusMFrameJMenuBar.add(getMFile());
			ivjCusMFrameJMenuBar.add(getMTools());
			ivjCusMFrameJMenuBar.add(getMWindow());
			ivjCusMFrameJMenuBar.add(getMHelp());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjCusMFrameJMenuBar;
}
/**
 * Return the CusSelectBean property value.
 * @return DBandGUI_Management.GetCustomerColName
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private DBandGUI_Management.GetCustomerColName getCusSelectBean() {
	if (ivjCusSelectBean == null) {
		try {
			ivjCusSelectBean = new DBandGUI_Management.GetCustomerColName();
			ivjCusSelectBean.setPacketSize(0);
			ivjCusSelectBean.setReadOnly(true);
			ivjCusSelectBean.setMaximumRows(0);
			ivjCusSelectBean.setQuery(new com.ibm.ivj.db.uibeans.Query(DBandGUI_Management.Ofen121.Project_Ofen121(), DBandGUI_Management.Ofen121.CusSQL()));
			ivjCusSelectBean.setMaximumPacketsInCache(0);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjCusSelectBean;
}
/**
 * Return the DBNavigator1 property value.
 * @return com.ibm.ivj.db.uibeans.DBNavigator
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.ibm.ivj.db.uibeans.DBNavigator getDBNavigator1() {
	if (ivjDBNavigator1 == null) {
		try {
			ivjDBNavigator1 = new com.ibm.ivj.db.uibeans.DBNavigator();
			ivjDBNavigator1.setName("DBNavigator1");
			ivjDBNavigator1.setShowDelete(false);
			ivjDBNavigator1.setShowRollback(false);
			ivjDBNavigator1.setShowInsert(false);
			ivjDBNavigator1.setToolTipsEnabled(false);
			ivjDBNavigator1.setShowCommit(false);
			ivjDBNavigator1.setShowRefresh(false);
			ivjDBNavigator1.setBounds(15, 474, 230, 25);
			ivjDBNavigator1.setShowExecute(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjDBNavigator1;
}
/**
 * Return the DProtect property value.
 * @return com.sun.java.swing.JDialog
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JDialog getDProtect() {
	if (ivjDProtect == null) {
		try {
			ivjDProtect = new com.sun.java.swing.JDialog();
			ivjDProtect.setName("DProtect");
			ivjDProtect.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjDProtect.setBounds(232, 230, 335, 140);
			ivjDProtect.setTitle("Remove Customer Information");
			getDProtect().setContentPane(getJDialogContentPane());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjDProtect;
}
/**
 * Return the JButton1 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getJButton1() {
	if (ivjJButton1 == null) {
		try {
			ivjJButton1 = new com.sun.java.swing.JButton();
			ivjJButton1.setName("JButton1");
			ivjJButton1.setText("Yes");
			ivjJButton1.setBounds(60, 60, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton1;
}
/**
 * Return the JButton2 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getJButton2() {
	if (ivjJButton2 == null) {
		try {
			ivjJButton2 = new com.sun.java.swing.JButton();
			ivjJButton2.setName("JButton2");
			ivjJButton2.setText("No");
			ivjJButton2.setBounds(200, 60, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton2;
}
/**
 * Return the JDialogContentPane property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JPanel getJDialogContentPane() {
	if (ivjJDialogContentPane == null) {
		try {
			ivjJDialogContentPane = new com.sun.java.swing.JPanel();
			ivjJDialogContentPane.setName("JDialogContentPane");
			ivjJDialogContentPane.setLayout(null);
			getJDialogContentPane().add(getJButton1(), getJButton1().getName());
			getJDialogContentPane().add(getJButton2(), getJButton2().getName());
			getJDialogContentPane().add(getLQuestion(), getLQuestion().getName());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJDialogContentPane;
}
/**
 * Return the JFrameContentPane property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JPanel getJFrameContentPane() {
	if (ivjJFrameContentPane == null) {
		try {
			ivjJFrameContentPane = new com.sun.java.swing.JPanel();
			ivjJFrameContentPane.setName("JFrameContentPane");
			ivjJFrameContentPane.setLayout(null);
			ivjJFrameContentPane.setBackground(java.awt.SystemColor.window);
			getJFrameContentPane().add(getDBNavigator1(), getDBNavigator1().getName());
			getJFrameContentPane().add(getBClear(), getBClear().getName());
			getJFrameContentPane().add(getBAdd(), getBAdd().getName());
			getJFrameContentPane().add(getBremove(), getBremove().getName());
			getJFrameContentPane().add(getBUpdate(), getBUpdate().getName());
			getJFrameContentPane().add(getTFCustomerID(), getTFCustomerID().getName());
			getJFrameContentPane().add(getBLoad(), getBLoad().getName());
			getJFrameContentPane().add(getJLabel3(), getJLabel3().getName());
			getJFrameContentPane().add(getJLabel4(), getJLabel4().getName());
			getJFrameContentPane().add(getJLabel5(), getJLabel5().getName());
			getJFrameContentPane().add(getJLabel6(), getJLabel6().getName());
			getJFrameContentPane().add(getJLabel7(), getJLabel7().getName());
			getJFrameContentPane().add(getJLabel8(), getJLabel8().getName());
			getJFrameContentPane().add(getJLabel9(), getJLabel9().getName());
			getJFrameContentPane().add(getJLabel10(), getJLabel10().getName());
			getJFrameContentPane().add(getJLabel11(), getJLabel11().getName());
			getJFrameContentPane().add(getJLabel12(), getJLabel12().getName());
			getJFrameContentPane().add(getJLabel13(), getJLabel13().getName());
			getJFrameContentPane().add(getJLabel14(), getJLabel14().getName());
			getJFrameContentPane().add(getJLabel15(), getJLabel15().getName());
			getJFrameContentPane().add(getJLabel16(), getJLabel16().getName());
			getJFrameContentPane().add(getJLabel17(), getJLabel17().getName());
			getJFrameContentPane().add(getJLabel18(), getJLabel18().getName());
			getJFrameContentPane().add(getJLabel19(), getJLabel19().getName());
			getJFrameContentPane().add(getJLabel20(), getJLabel20().getName());
			getJFrameContentPane().add(getJLabel21(), getJLabel21().getName());
			getJFrameContentPane().add(getJLabel22(), getJLabel22().getName());
			getJFrameContentPane().add(getJLabel23(), getJLabel23().getName());
			getJFrameContentPane().add(getTFFirstname(), getTFFirstname().getName());
			getJFrameContentPane().add(getTFLastname(), getTFLastname().getName());
			getJFrameContentPane().add(getTFSex(), getTFSex().getName());
			getJFrameContentPane().add(getTFNationality(), getTFNationality().getName());
			getJFrameContentPane().add(getTFRace(), getTFRace().getName());
			getJFrameContentPane().add(getTFReligion(), getTFReligion().getName());
			getJFrameContentPane().add(getTFStatus(), getTFStatus().getName());
			getJFrameContentPane().add(getTFAddress(), getTFAddress().getName());
			getJFrameContentPane().add(getTFStreet(), getTFStreet().getName());
			getJFrameContentPane().add(getTFDistrict(), getTFDistrict().getName());
			getJFrameContentPane().add(getTFProvince(), getTFProvince().getName());
			getJFrameContentPane().add(getTFTelephone(), getTFTelephone().getName());
			getJFrameContentPane().add(getTFPager(), getTFPager().getName());
			getJFrameContentPane().add(getTFIDCardNumber(), getTFIDCardNumber().getName());
			getJFrameContentPane().add(getTFIssuedAt(), getTFIssuedAt().getName());
			getJFrameContentPane().add(getTFIssuedDate(), getTFIssuedDate().getName());
			getJFrameContentPane().add(getTFExpiryDate(), getTFExpiryDate().getName());
			getJFrameContentPane().add(getTFOccupation(), getTFOccupation().getName());
			getJFrameContentPane().add(getTFCompany(), getTFCompany().getName());
			getJFrameContentPane().add(getTFSalary(), getTFSalary().getName());
			getJFrameContentPane().add(getTFTotalContract(), getTFTotalContract().getName());
			getJFrameContentPane().add(getTFEnterID(), getTFEnterID().getName());
			getJFrameContentPane().add(getJLabel25(), getJLabel25().getName());
			getJFrameContentPane().add(getJPanel1(), getJPanel1().getName());
			getJFrameContentPane().add(getJLabel26(), getJLabel26().getName());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJFrameContentPane;
}
/**
 * Return the JLabel10 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel10() {
	if (ivjJLabel10 == null) {
		try {
			ivjJLabel10 = new com.sun.java.swing.JLabel();
			ivjJLabel10.setName("JLabel10");
			ivjJLabel10.setText("Street");
			ivjJLabel10.setBounds(140, 150, 41, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel10;
}
/**
 * Return the JLabel11 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel11() {
	if (ivjJLabel11 == null) {
		try {
			ivjJLabel11 = new com.sun.java.swing.JLabel();
			ivjJLabel11.setName("JLabel11");
			ivjJLabel11.setText("District");
			ivjJLabel11.setBounds(250, 150, 52, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel11;
}
/**
 * Return the JLabel12 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel12() {
	if (ivjJLabel12 == null) {
		try {
			ivjJLabel12 = new com.sun.java.swing.JLabel();
			ivjJLabel12.setName("JLabel12");
			ivjJLabel12.setText("Province");
			ivjJLabel12.setBounds(430, 150, 52, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel12;
}
/**
 * Return the JLabel13 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel13() {
	if (ivjJLabel13 == null) {
		try {
			ivjJLabel13 = new com.sun.java.swing.JLabel();
			ivjJLabel13.setName("JLabel13");
			ivjJLabel13.setText("Tel.");
			ivjJLabel13.setBounds(580, 150, 28, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel13;
}
/**
 * Return the JLabel14 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel14() {
	if (ivjJLabel14 == null) {
		try {
			ivjJLabel14 = new com.sun.java.swing.JLabel();
			ivjJLabel14.setName("JLabel14");
			ivjJLabel14.setText("Pager");
			ivjJLabel14.setBounds(690, 150, 52, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel14;
}
/**
 * Return the JLabel15 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel15() {
	if (ivjJLabel15 == null) {
		try {
			ivjJLabel15 = new com.sun.java.swing.JLabel();
			ivjJLabel15.setName("JLabel15");
			ivjJLabel15.setText("IDCardNumber");
			ivjJLabel15.setBounds(20, 190, 85, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel15;
}
/**
 * Return the JLabel16 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel16() {
	if (ivjJLabel16 == null) {
		try {
			ivjJLabel16 = new com.sun.java.swing.JLabel();
			ivjJLabel16.setName("JLabel16");
			ivjJLabel16.setText("Issued At");
			ivjJLabel16.setBounds(250, 190, 59, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel16;
}
/**
 * Return the JLabel17 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel17() {
	if (ivjJLabel17 == null) {
		try {
			ivjJLabel17 = new com.sun.java.swing.JLabel();
			ivjJLabel17.setName("JLabel17");
			ivjJLabel17.setText("Issued Date");
			ivjJLabel17.setBounds(430, 190, 72, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel17;
}
/**
 * Return the JLabel18 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel18() {
	if (ivjJLabel18 == null) {
		try {
			ivjJLabel18 = new com.sun.java.swing.JLabel();
			ivjJLabel18.setName("JLabel18");
			ivjJLabel18.setText("Expiry Date");
			ivjJLabel18.setBounds(580, 190, 64, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel18;
}
/**
 * Return the JLabel19 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel19() {
	if (ivjJLabel19 == null) {
		try {
			ivjJLabel19 = new com.sun.java.swing.JLabel();
			ivjJLabel19.setName("JLabel19");
			ivjJLabel19.setText("Occupation");
			ivjJLabel19.setBounds(20, 230, 66, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel19;
}
/**
 * Return the JLabel20 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel20() {
	if (ivjJLabel20 == null) {
		try {
			ivjJLabel20 = new com.sun.java.swing.JLabel();
			ivjJLabel20.setName("JLabel20");
			ivjJLabel20.setText("Company");
			ivjJLabel20.setBounds(250, 230, 58, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel20;
}
/**
 * Return the JLabel21 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel21() {
	if (ivjJLabel21 == null) {
		try {
			ivjJLabel21 = new com.sun.java.swing.JLabel();
			ivjJLabel21.setName("JLabel21");
			ivjJLabel21.setText("Salary");
			ivjJLabel21.setBounds(430, 230, 43, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel21;
}
/**
 * Return the JLabel22 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel22() {
	if (ivjJLabel22 == null) {
		try {
			ivjJLabel22 = new com.sun.java.swing.JLabel();
			ivjJLabel22.setName("JLabel22");
			ivjJLabel22.setText("Total Contract");
			ivjJLabel22.setBounds(580, 230, 83, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel22;
}
/**
 * Return the JLabel23 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel23() {
	if (ivjJLabel23 == null) {
		try {
			ivjJLabel23 = new com.sun.java.swing.JLabel();
			ivjJLabel23.setName("JLabel23");
			ivjJLabel23.setText("Enter By");
			ivjJLabel23.setBounds(690, 230, 49, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel23;
}
/**
 * Return the JLabel25 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel25() {
	if (ivjJLabel25 == null) {
		try {
			ivjJLabel25 = new com.sun.java.swing.JLabel();
			ivjJLabel25.setName("JLabel25");
			ivjJLabel25.setFont(new java.awt.Font("dialog", 1, 24));
			ivjJLabel25.setText("ID");
			ivjJLabel25.setBounds(21, 24, 28, 30);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel25;
}
/**
 * Return the JLabel26 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel26() {
	if (ivjJLabel26 == null) {
		try {
			ivjJLabel26 = new com.sun.java.swing.JLabel();
			ivjJLabel26.setName("JLabel26");
			ivjJLabel26.setText("");
			ivjJLabel26.setForeground(new java.awt.Color(255,255,221));
			ivjJLabel26.setVerticalTextPosition(com.sun.java.swing.SwingConstants.TOP);
			ivjJLabel26.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\labelCustomer.jpg"));
			ivjJLabel26.setFont(new java.awt.Font("dialog", 1, 36));
			ivjJLabel26.setVerticalAlignment(com.sun.java.swing.SwingConstants.TOP);
			ivjJLabel26.setBounds(368, 4, 407, 99);
			ivjJLabel26.setHorizontalAlignment(com.sun.java.swing.SwingConstants.RIGHT);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel26;
}
/**
 * Return the JLabel3 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel3() {
	if (ivjJLabel3 == null) {
		try {
			ivjJLabel3 = new com.sun.java.swing.JLabel();
			ivjJLabel3.setName("JLabel3");
			ivjJLabel3.setText("Name");
			ivjJLabel3.setBounds(20, 70, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel3;
}
/**
 * Return the JLabel4 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel4() {
	if (ivjJLabel4 == null) {
		try {
			ivjJLabel4 = new com.sun.java.swing.JLabel();
			ivjJLabel4.setName("JLabel4");
			ivjJLabel4.setText("Sex");
			ivjJLabel4.setBounds(430, 70, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel4;
}
/**
 * Return the JLabel5 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel5() {
	if (ivjJLabel5 == null) {
		try {
			ivjJLabel5 = new com.sun.java.swing.JLabel();
			ivjJLabel5.setName("JLabel5");
			ivjJLabel5.setText("Nationality");
			ivjJLabel5.setBounds(20, 110, 64, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel5;
}
/**
 * Return the JLabel6 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel6() {
	if (ivjJLabel6 == null) {
		try {
			ivjJLabel6 = new com.sun.java.swing.JLabel();
			ivjJLabel6.setName("JLabel6");
			ivjJLabel6.setText("Race");
			ivjJLabel6.setBounds(250, 110, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel6;
}
/**
 * Return the JLabel7 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel7() {
	if (ivjJLabel7 == null) {
		try {
			ivjJLabel7 = new com.sun.java.swing.JLabel();
			ivjJLabel7.setName("JLabel7");
			ivjJLabel7.setText("Religion");
			ivjJLabel7.setBounds(430, 110, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel7;
}
/**
 * Return the JLabel8 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel8() {
	if (ivjJLabel8 == null) {
		try {
			ivjJLabel8 = new com.sun.java.swing.JLabel();
			ivjJLabel8.setName("JLabel8");
			ivjJLabel8.setText("Status");
			ivjJLabel8.setBounds(580, 110, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel8;
}
/**
 * Return the JLabel9 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel9() {
	if (ivjJLabel9 == null) {
		try {
			ivjJLabel9 = new com.sun.java.swing.JLabel();
			ivjJLabel9.setName("JLabel9");
			ivjJLabel9.setText("Address");
			ivjJLabel9.setBounds(20, 150, 63, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel9;
}
/**
 * Return the JPanel1 property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JPanel getJPanel1() {
	if (ivjJPanel1 == null) {
		try {
			ivjJPanel1 = new com.sun.java.swing.JPanel();
			ivjJPanel1.setName("JPanel1");
			ivjJPanel1.setLayout(new java.awt.GridLayout());
			ivjJPanel1.setBounds(10, 280, 780, 180);
			ivjJPanel1.add(getJScrollPane1());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJPanel1;
}
/**
 * Return the JScrollPane1 property value.
 * @return com.sun.java.swing.JScrollPane
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JScrollPane getJScrollPane1() {
	if (ivjJScrollPane1 == null) {
		try {
			ivjJScrollPane1 = new com.sun.java.swing.JScrollPane();
			ivjJScrollPane1.setName("JScrollPane1");
			ivjJScrollPane1.setVerticalScrollBarPolicy(com.sun.java.swing.JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
			ivjJScrollPane1.setHorizontalScrollBarPolicy(com.sun.java.swing.JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
			getJScrollPane1().setViewportView(getScrollPaneTable());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJScrollPane1;
}
/**
 * Return the LQuestion property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getLQuestion() {
	if (ivjLQuestion == null) {
		try {
			ivjLQuestion = new com.sun.java.swing.JLabel();
			ivjLQuestion.setName("LQuestion");
			ivjLQuestion.setText("REMOVE CUSTOMER ?");
			ivjLQuestion.setBounds(31, 26, 278, 15);
			ivjLQuestion.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjLQuestion;
}
/**
 * Return the MFile property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JMenu getMFile() {
	if (ivjMFile == null) {
		try {
			ivjMFile = new com.sun.java.swing.JMenu();
			ivjMFile.setName("MFile");
			ivjMFile.setDelay(200);
			ivjMFile.setText("File");
			ivjMFile.add(getMIExit());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMFile;
}
/**
 * Return the MHelp property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JMenu getMHelp() {
	if (ivjMHelp == null) {
		try {
			ivjMHelp = new com.sun.java.swing.JMenu();
			ivjMHelp.setName("MHelp");
			ivjMHelp.setDelay(200);
			ivjMHelp.setText("Help");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMHelp;
}
/**
 * Return the MIExit property value.
 * @return com.sun.java.swing.JMenuItem
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JMenuItem getMIExit() {
	if (ivjMIExit == null) {
		try {
			ivjMIExit = new com.sun.java.swing.JMenuItem();
			ivjMIExit.setName("MIExit");
			ivjMIExit.setText("Exit");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMIExit;
}
/**
 * Return the MTools property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JMenu getMTools() {
	if (ivjMTools == null) {
		try {
			ivjMTools = new com.sun.java.swing.JMenu();
			ivjMTools.setName("MTools");
			ivjMTools.setDelay(200);
			ivjMTools.setText("Tools");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMTools;
}
/**
 * Return the MWindow property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JMenu getMWindow() {
	if (ivjMWindow == null) {
		try {
			ivjMWindow = new com.sun.java.swing.JMenu();
			ivjMWindow.setName("MWindow");
			ivjMWindow.setDelay(200);
			ivjMWindow.setText("Window");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjMWindow;
}
/**
 * Return the ScrollPaneTable property value.
 * @return com.sun.java.swing.JTable
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTable getScrollPaneTable() {
	if (ivjScrollPaneTable == null) {
		try {
			ivjScrollPaneTable = new com.sun.java.swing.JTable();
			ivjScrollPaneTable.setName("ScrollPaneTable");
			getJScrollPane1().setColumnHeaderView(ivjScrollPaneTable.getTableHeader());
			getJScrollPane1().getViewport().setBackingStoreEnabled(true);
			ivjScrollPaneTable.setBackground(new java.awt.Color(255,255,235));
			ivjScrollPaneTable.setDoubleBuffered(true);
			ivjScrollPaneTable.setForeground(new java.awt.Color(0,0,172));
			ivjScrollPaneTable.setGridColor(new java.awt.Color(161,154,213));
			ivjScrollPaneTable.setFont(new java.awt.Font("dialog", 1, 12));
			ivjScrollPaneTable.setBounds(0, 0, 200, 200);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjScrollPaneTable;
}
/**
 * Return the JTextField9 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFAddress() {
	if (ivjTFAddress == null) {
		try {
			ivjTFAddress = new com.sun.java.swing.JTextField();
			ivjTFAddress.setName("TFAddress");
			ivjTFAddress.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFAddress.setBackground(new java.awt.Color(255,255,235));
			ivjTFAddress.setBounds(20, 165, 110, 19);
			ivjTFAddress.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFAddress;
}
/**
 * Return the JTextField20 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFCompany() {
	if (ivjTFCompany == null) {
		try {
			ivjTFCompany = new com.sun.java.swing.JTextField();
			ivjTFCompany.setName("TFCompany");
			ivjTFCompany.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFCompany.setBackground(new java.awt.Color(255,255,235));
			ivjTFCompany.setBounds(250, 245, 170, 19);
			ivjTFCompany.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFCompany;
}
/**
 * Return the JTextField1 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFCustomerID() {
	if (ivjTFCustomerID == null) {
		try {
			ivjTFCustomerID = new com.sun.java.swing.JTextField();
			ivjTFCustomerID.setName("TFCustomerID");
			ivjTFCustomerID.setText("0000");
			ivjTFCustomerID.setBackground(new java.awt.Color(255,255,235));
			ivjTFCustomerID.setForeground(new java.awt.Color(50,50,50));
			ivjTFCustomerID.setFont(new java.awt.Font("sansserif", 1, 24));
			ivjTFCustomerID.setBounds(60, 24, 134, 30);
			ivjTFCustomerID.setHorizontalAlignment(com.sun.java.swing.JTextField.LEFT);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFCustomerID;
}
/**
 * Return the JTextField11 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFDistrict() {
	if (ivjTFDistrict == null) {
		try {
			ivjTFDistrict = new com.sun.java.swing.JTextField();
			ivjTFDistrict.setName("TFDistrict");
			ivjTFDistrict.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFDistrict.setBackground(new java.awt.Color(255,255,235));
			ivjTFDistrict.setBounds(250, 165, 170, 19);
			ivjTFDistrict.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFDistrict;
}
/**
 * Return the JTextField23 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFEnterID() {
	if (ivjTFEnterID == null) {
		try {
			ivjTFEnterID = new com.sun.java.swing.JTextField();
			ivjTFEnterID.setName("TFEnterID");
			ivjTFEnterID.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFEnterID.setText("0000");
			ivjTFEnterID.setBounds(690, 245, 90, 19);
			ivjTFEnterID.setEditable(false);
			ivjTFEnterID.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFEnterID;
}
/**
 * Return the JTextField18 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFExpiryDate() {
	if (ivjTFExpiryDate == null) {
		try {
			ivjTFExpiryDate = new com.sun.java.swing.JTextField();
			ivjTFExpiryDate.setName("TFExpiryDate");
			ivjTFExpiryDate.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFExpiryDate.setBackground(new java.awt.Color(255,255,235));
			ivjTFExpiryDate.setBounds(580, 205, 140, 19);
			ivjTFExpiryDate.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFExpiryDate;
}
/**
 * Return the JTextField2 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFFirstname() {
	if (ivjTFFirstname == null) {
		try {
			ivjTFFirstname = new com.sun.java.swing.JTextField();
			ivjTFFirstname.setName("TFFirstname");
			ivjTFFirstname.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFFirstname.setBackground(new java.awt.Color(255,255,235));
			ivjTFFirstname.setBounds(20, 85, 110, 19);
			ivjTFFirstname.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFFirstname;
}
/**
 * Return the JTextField15 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFIDCardNumber() {
	if (ivjTFIDCardNumber == null) {
		try {
			ivjTFIDCardNumber = new com.sun.java.swing.JTextField();
			ivjTFIDCardNumber.setName("TFIDCardNumber");
			ivjTFIDCardNumber.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFIDCardNumber.setBackground(new java.awt.Color(255,255,235));
			ivjTFIDCardNumber.setBounds(20, 205, 220, 19);
			ivjTFIDCardNumber.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFIDCardNumber;
}
/**
 * Return the JTextField16 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFIssuedAt() {
	if (ivjTFIssuedAt == null) {
		try {
			ivjTFIssuedAt = new com.sun.java.swing.JTextField();
			ivjTFIssuedAt.setName("TFIssuedAt");
			ivjTFIssuedAt.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFIssuedAt.setBackground(new java.awt.Color(255,255,235));
			ivjTFIssuedAt.setBounds(250, 205, 170, 19);
			ivjTFIssuedAt.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFIssuedAt;
}
/**
 * Return the JTextField17 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFIssuedDate() {
	if (ivjTFIssuedDate == null) {
		try {
			ivjTFIssuedDate = new com.sun.java.swing.JTextField();
			ivjTFIssuedDate.setName("TFIssuedDate");
			ivjTFIssuedDate.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFIssuedDate.setBackground(new java.awt.Color(255,255,235));
			ivjTFIssuedDate.setBounds(430, 205, 140, 19);
			ivjTFIssuedDate.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFIssuedDate;
}
/**
 * Return the JTextField3 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFLastname() {
	if (ivjTFLastname == null) {
		try {
			ivjTFLastname = new com.sun.java.swing.JTextField();
			ivjTFLastname.setName("TFLastname");
			ivjTFLastname.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFLastname.setBackground(new java.awt.Color(255,255,235));
			ivjTFLastname.setBounds(140, 85, 280, 19);
			ivjTFLastname.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFLastname;
}
/**
 * Return the JTextField5 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFNationality() {
	if (ivjTFNationality == null) {
		try {
			ivjTFNationality = new com.sun.java.swing.JTextField();
			ivjTFNationality.setName("TFNationality");
			ivjTFNationality.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFNationality.setBackground(new java.awt.Color(255,255,235));
			ivjTFNationality.setBounds(20, 125, 220, 19);
			ivjTFNationality.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFNationality;
}
/**
 * Return the JTextField19 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFOccupation() {
	if (ivjTFOccupation == null) {
		try {
			ivjTFOccupation = new com.sun.java.swing.JTextField();
			ivjTFOccupation.setName("TFOccupation");
			ivjTFOccupation.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFOccupation.setBackground(new java.awt.Color(255,255,235));
			ivjTFOccupation.setBounds(20, 245, 220, 19);
			ivjTFOccupation.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFOccupation;
}
/**
 * Return the JTextField14 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFPager() {
	if (ivjTFPager == null) {
		try {
			ivjTFPager = new com.sun.java.swing.JTextField();
			ivjTFPager.setName("TFPager");
			ivjTFPager.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFPager.setBackground(new java.awt.Color(255,255,235));
			ivjTFPager.setBounds(690, 165, 90, 19);
			ivjTFPager.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFPager;
}
/**
 * Return the JTextField12 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFProvince() {
	if (ivjTFProvince == null) {
		try {
			ivjTFProvince = new com.sun.java.swing.JTextField();
			ivjTFProvince.setName("TFProvince");
			ivjTFProvince.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFProvince.setBackground(new java.awt.Color(255,255,235));
			ivjTFProvince.setBounds(430, 165, 140, 19);
			ivjTFProvince.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFProvince;
}
/**
 * Return the JTextField6 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFRace() {
	if (ivjTFRace == null) {
		try {
			ivjTFRace = new com.sun.java.swing.JTextField();
			ivjTFRace.setName("TFRace");
			ivjTFRace.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFRace.setBackground(new java.awt.Color(255,255,235));
			ivjTFRace.setBounds(250, 125, 170, 19);
			ivjTFRace.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFRace;
}
/**
 * Return the JTextField7 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFReligion() {
	if (ivjTFReligion == null) {
		try {
			ivjTFReligion = new com.sun.java.swing.JTextField();
			ivjTFReligion.setName("TFReligion");
			ivjTFReligion.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFReligion.setBackground(new java.awt.Color(255,255,235));
			ivjTFReligion.setBounds(430, 125, 140, 19);
			ivjTFReligion.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFReligion;
}
/**
 * Return the JTextField21 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFSalary() {
	if (ivjTFSalary == null) {
		try {
			ivjTFSalary = new com.sun.java.swing.JTextField();
			ivjTFSalary.setName("TFSalary");
			ivjTFSalary.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFSalary.setBackground(new java.awt.Color(255,255,235));
			ivjTFSalary.setBounds(430, 245, 140, 19);
			ivjTFSalary.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFSalary;
}
/**
 * Return the JTextField4 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFSex() {
	if (ivjTFSex == null) {
		try {
			ivjTFSex = new com.sun.java.swing.JTextField();
			ivjTFSex.setName("TFSex");
			ivjTFSex.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFSex.setBackground(new java.awt.Color(255,255,235));
			ivjTFSex.setBounds(430, 85, 70, 19);
			ivjTFSex.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFSex;
}
/**
 * Return the JTextField8 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFStatus() {
	if (ivjTFStatus == null) {
		try {
			ivjTFStatus = new com.sun.java.swing.JTextField();
			ivjTFStatus.setName("TFStatus");
			ivjTFStatus.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFStatus.setBackground(new java.awt.Color(255,255,235));
			ivjTFStatus.setBounds(580, 125, 140, 19);
			ivjTFStatus.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFStatus;
}
/**
 * Return the JTextField10 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFStreet() {
	if (ivjTFStreet == null) {
		try {
			ivjTFStreet = new com.sun.java.swing.JTextField();
			ivjTFStreet.setName("TFStreet");
			ivjTFStreet.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFStreet.setBackground(new java.awt.Color(255,255,235));
			ivjTFStreet.setBounds(140, 165, 100, 19);
			ivjTFStreet.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFStreet;
}
/**
 * Return the JTextField13 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFTelephone() {
	if (ivjTFTelephone == null) {
		try {
			ivjTFTelephone = new com.sun.java.swing.JTextField();
			ivjTFTelephone.setName("TFTelephone");
			ivjTFTelephone.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFTelephone.setBackground(new java.awt.Color(255,255,235));
			ivjTFTelephone.setBounds(580, 165, 100, 19);
			ivjTFTelephone.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFTelephone;
}
/**
 * Return the JTextField22 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFTotalContract() {
	if (ivjTFTotalContract == null) {
		try {
			ivjTFTotalContract = new com.sun.java.swing.JTextField();
			ivjTFTotalContract.setName("TFTotalContract");
			ivjTFTotalContract.setFont(new java.awt.Font("sansserif", 1, 12));
			ivjTFTotalContract.setBackground(new java.awt.Color(255,255,235));
			ivjTFTotalContract.setBounds(580, 245, 100, 19);
			ivjTFTotalContract.setForeground(new java.awt.Color(50,50,50));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFTotalContract;
}
/**
 * Called whenever the part throws an exception.
 * @param exception java.lang.Throwable
 */
private void handleException(Throwable exception) {

	/* Uncomment the following lines to print uncaught exceptions to stdout */
	// System.out.println("--------- UNCAUGHT EXCEPTION ---------");
	// exception.printStackTrace(System.out);
}
/**
 * Initializes connections
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initConnections() {
	// user code begin {1}
	// user code end
	getTFCustomerID().addActionListener(this);
	getControlIDBean().addPropertyChangeListener(this);
	getBLoad().addActionListener(this);
	getBClear().addActionListener(this);
	getBAdd().addActionListener(this);
	getBUpdate().addActionListener(this);
	getJButton1().addActionListener(this);
	getJButton2().addActionListener(this);
	getBremove().addActionListener(this);
	getMIExit().addActionListener(this);
	getCusMFrame().addWindowListener(this);
	connPtoP3SetTarget();
	connPtoP6SetTarget();
	connPtoP1SetTarget();
}
/**
 * Initialize the class.
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initialize() {
	// user code begin {1}
	try {
		conS = m.connectServer();
		try {
			getCusSelectBean().execute();
			getControlIDBean().execute();
		} catch (java.lang.Throwable ivjExc) { handleException(ivjExc);}
//		getCusSelectBean().execute();
//		getControlIDBean().execute();
	}
	catch (IOException ie) {System.out.println("IO Error = "+ie);}
	catch (SQLException se) {System.out.println("SQL Error = "+se);}

	
	getCusMFrame();
	getCusMFrame().setVisible(true);
	getCusMFrame().setContentPane(getJFrameContentPane());
	getCusMFrame().show();

	// user code end
	initConnections();
	// user code begin {2}
	// user code end
}
/**
 * Comment
 */
public void jButton1_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	System.out.println("Remove Customer");
	try{
			if (c.toInt(ivjTFCustomerID.getText()) > 0) {
				customer.remove(conS,c.toInt(ivjTFCustomerID.getText()));
				
			}
	}
	catch(IOException ie) {;}
	catch(SQLException se) {;}
	
			try {
					getCusSelectBean().refresh();
				    getControlIDBean().refresh();
				} catch (java.lang.Throwable ivjExc) { handleException(ivjExc);}
	
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		CustomerGUI aCustomerGUI;
		aCustomerGUI = new CustomerGUI();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
/**
 * Method to handle events for the PropertyChangeListener interface.
 * @param evt java.beans.PropertyChangeEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void propertyChange(java.beans.PropertyChangeEvent evt) {
	// user code begin {1}
	// user code end
	if ((evt.getSource() == getControlIDBean()) && (evt.getPropertyName().equals("CUSTOMER.CUSTOMERID_String"))) {
		connPtoP6SetTarget();
	}
	// user code begin {2}
	// user code end
}
/**
 * Comment
 */
public void tFCustomerID_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	
	System.out.println("Load Customer");
	try {
		getCusSelectBean().setCurrentRow(c.toInt(ivjTFCustomerID.getText()));
	} catch (java.lang.Throwable ivjExc) {	handleException(ivjExc); }
	
	try {
		System.out.println("Customer Text "+c.toInt(ivjTFCustomerID.getText()));
		if (customer.load(conS,c.toInt(ivjTFCustomerID.getText()))) {
			ivjTFFirstname.setText(customer.getString("Firstname"));
			ivjTFLastname.setText(customer.getString("Lastname"));
			ivjTFSex.setText(customer.getString("Sex"));
			ivjTFNationality.setText(customer.getString("Nationality"));
			ivjTFRace.setText(customer.getString("Race"));
			ivjTFReligion.setText(customer.getString("Religion"));
			ivjTFStatus.setText(customer.getString("Status"));
			ivjTFAddress.setText(customer.getString("PresentAddress"));
			ivjTFStreet.setText(customer.getString("Street"));
			ivjTFDistrict.setText(customer.getString("District"));
			ivjTFProvince.setText(customer.getString("Province"));
			ivjTFTelephone.setText(customer.getString("Telephone"));
			ivjTFPager.setText(customer.getString("Pager"));
			ivjTFIDCardNumber.setText(customer.getString("IDcardNumber"));
			ivjTFIssuedAt.setText(customer.getString("IssuedAt"));
			ivjTFIssuedDate.setText(customer.getDateString("IssuedDate"));
			ivjTFExpiryDate.setText(customer.getDateString("ExpiryDate"));
			ivjTFOccupation.setText(customer.getString("Occupation"));
			ivjTFCompany.setText(customer.getString("Company"));
			ivjTFSalary.setText(""+customer.getNumber("Salary"));
			ivjTFEnterID.setText(""+customer.getNumber("EnterID"));
			ivjTFTotalContract.setText(""+customer.getNumber("TotalContract"));
		}
	}
	catch(IOException ie) {;}
	catch(SQLException se) {;}
	
}
/**
 * Comment
 */
public void tFCustomerID_CaretUpdate(com.sun.java.swing.event.CaretEvent caretEvent) {
	System.out.println("ID change !!!");
	return;
}
/**
 * Comment
 */
public void tFCustomerID_MouseClicked(java.awt.event.MouseEvent mouseEvent) {
	return;
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowActivated(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowClosed(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	if ((e.getSource() == getCusMFrame()) ) {
		connEtoC5(e);
	}
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowClosing(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowDeactivated(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowDeiconified(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowIconified(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * Method to handle events for the WindowListener interface.
 * @param e java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void windowOpened(java.awt.event.WindowEvent e) {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
}