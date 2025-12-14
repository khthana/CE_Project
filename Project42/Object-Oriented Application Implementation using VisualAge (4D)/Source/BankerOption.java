package Banking;

/**
 * This type was created in VisualAge.
 */
import java.sql.*;

public class BankerOption implements java.awt.event.ActionListener, java.awt.event.WindowListener {
	private com.sun.java.swing.JFrame ivjJFrame1 = null;
	private com.sun.java.swing.JPanel ivjJFrameContentPane = null;
	private com.sun.java.swing.JButton ivjJButton2 = null;
	private com.sun.java.swing.JDialog ivjJDialog1 = null;
	private com.sun.java.swing.JPanel ivjJDialogContentPane = null;
	private com.sun.java.swing.JMenuBar ivjJFrame1JMenuBar = null;
	private com.sun.java.swing.JMenu ivjJMenu1 = null;
	private com.sun.java.swing.JMenu ivjJMenu2 = null;
	private com.sun.java.swing.JMenuItem ivjJMenuItem1 = null;
	private com.sun.java.swing.JMenuItem ivjJMenuItem2 = null;
	private com.sun.java.swing.JMenuItem ivjJMenuItem3 = null;
	private com.sun.java.swing.JButton ivjJButton3 = null;
	private com.sun.java.swing.JButton ivjJButton4 = null;
	private com.sun.java.swing.JButton ivjJButton5 = null;
	private com.sun.java.swing.JButton ivjJButton6 = null;
	private com.sun.java.swing.JButton ivjJButton7 = null;
	private com.sun.java.swing.JButton ivjJButton8 = null;
	private com.sun.java.swing.JButton ivjJButton9 = null;
	private com.sun.java.swing.JLabel ivjJLabel1 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JPanel ivjJPanel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel3 = null;
	private com.sun.java.swing.JLabel ivjJLabel4 = null;
	private com.sun.java.swing.JLabel ivjJLabel5 = null;
	private com.sun.java.swing.JLabel ivjJLabel6 = null;
	private com.sun.java.swing.JLabel ivjJLabel7 = null;
	private com.sun.java.swing.JPasswordField ivjJPasswordField1 = null;
	private com.sun.java.swing.JTextField ivjJTextField1 = null;
	private com.sun.java.swing.JButton ivjJButton10 = null;
	private com.sun.java.swing.JComboBox ivjJComboBox1 = null;
	public  Connection conn = null;
	public  int bankerID = 0;
	public  String bankerName = null;
	private String password = null;
	private String bankerStatus = null;
	public  String branchName = null;
	public  String today = null;
	private com.sun.java.swing.JLabel ivjJLabel8 = null;
	public  NewLoanForm aNewLoanForm = null;
	private LateCustomerForm aLateCustomerForm = null;
	private ModifyCustomerForm aModifyCustomerForm = null;
	private PaymentForm aPaymentForm = null;
	private PaymentHistoryForm aPaymentHistoryForm = null;
	private SampleForm aSampleForm = null;
	private com.sun.java.swing.JLabel ivjJLabel9 = null;
	private com.sun.java.swing.JButton ivjJButton1 = null;
	private com.sun.java.swing.JDialog ivjJDialog2 = null;
	private com.sun.java.swing.JPanel ivjJDialogContentPane1 = null;
	private com.sun.java.swing.JLabel ivjJLabel10 = null;
	private com.sun.java.swing.JLabel ivjJLabel11 = null;
	private com.sun.java.swing.JLabel ivjJLabel12 = null;
	private com.sun.java.swing.JLabel ivjJLabel13 = null;
	private com.sun.java.swing.JLabel ivjJLabel14 = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public BankerOption() {
	super();
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
	if ((e.getSource() == getJButton2()) ) {
		connEtoC1();
	}
	if ((e.getSource() == getJMenuItem1()) ) {
		connEtoC4();
	}
	if ((e.getSource() == getJButton3()) ) {
		connEtoC5();
	}
	if ((e.getSource() == getJButton10()) ) {
		connEtoC6();
	}
	if ((e.getSource() == getJButton4()) ) {
		connEtoC7();
	}
	if ((e.getSource() == getJButton5()) ) {
		connEtoC8();
	}
	if ((e.getSource() == getJButton6()) ) {
		connEtoC9();
	}
	if ((e.getSource() == getJButton7()) ) {
		connEtoC10();
	}
	if ((e.getSource() == getJButton8()) ) {
		connEtoC11();
	}
	if ((e.getSource() == getJButton9()) ) {
		connEtoC12();
	}
	if ((e.getSource() == getJMenuItem2()) ) {
		connEtoC13();
	}
	if ((e.getSource() == getJMenuItem3()) ) {
		connEtoC14();
	}
	if ((e.getSource() == getJButton1()) ) {
		connEtoC15();
	}
	// user code begin {2}
	// user code end
}
/**
 * Comment
 */
public void adminLogon(java.awt.event.MouseEvent mouseEvent) {
	bankerStatus = "ADMIN";
	showLogonForm();
	return;
}
/**
 * Comment
 */
public void bankerOption_Initialize() {
	getJFrame1().show();

	try
	{
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
	
		connectDatabase();
		CallableStatement cstmt = conn.prepareCall ("{? = call GET_SYSDATE ()}");
		cstmt.registerOutParameter (1, Types.CHAR);
		cstmt.execute ();
		today = cstmt.getString(1).trim();
		ivjJLabel4.setText(today);
		ivjJLabel9.setText("Status : Connected");
	}
	catch (Throwable exception) 
	{ 
		ivjJLabel9.setText("Status : Disconnected");
		handleException(exception);
	}
	return;
}
/**
 * Comment
 */
public void checkUserPassword() throws SQLException {
	String passwordOk = "false";
	
	try { bankerID = Integer.parseInt(ivjJTextField1.getText()); }
	catch (java.lang.Throwable ivjExc) 
	{ bankerID = 0; handleException(ivjExc); }

	password = ivjJPasswordField1.getText();
	branchName = ivjJComboBox1.getSelectedItem().toString().toUpperCase();
	
	CallableStatement cstmt = conn.prepareCall ("{? = call CHECK_USER (?,?,?,?)}");
	cstmt.registerOutParameter (1, Types.CHAR);
	cstmt.setInt (2, bankerID);
	cstmt.setString (3, password);			// not upper font //
	cstmt.setString (4, bankerStatus);
	cstmt.setString (5, branchName);
	
	try
	{
		cstmt.execute ();
		passwordOk = cstmt.getString(1).trim();
	}
	catch (java.lang.Throwable ivjExc) { handleException(ivjExc); }

	if (passwordOk.equals("true"))
	{
		ivjJDialog1.dispose();
		ivjJDialog1 = null;

	    Statement stmt = conn.createStatement ();
		ResultSet rset = stmt.executeQuery ("select Banker_Name from Banker where Banker_id = " + bankerID);
		if (rset.next ())
		{ bankerName = rset.getString(1); }

		ivjJLabel2.setText(bankerName);
		ivjJFrame1.setEnabled(true);
	}
	else { ivjJLabel8.setText("Invalid Username/Password"); }
	return;
}
/**
 * Comment
 */
public void closeAbout() {
	ivjJFrame1.setEnabled(true);

	ivjJDialog2.dispose();
	ivjJDialog2 = null;
	return;
}
/**
 * Comment
 */
public void closeUserPassword() {
	ivjJFrame1.setEnabled(true);
	ivjJDialog1.dispose();
	ivjJDialog1 = null;
	return;
}
/**
 * This method was created in VisualAge.
 */
public void connectDatabase() throws SQLException {
//	DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
//	use register_driver in bankerOption_Initialize only //

	conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.117:1521:bk",
				   						"dear", "dear");
	conn.setAutoCommit(false);
}
/**
 * connEtoC1:  (JButton2.action. --> BankerOption.ExitApplication()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC1() {
	try {
		// user code begin {1}
		// user code end
		this.ExitApplication();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC10:  (JButton7.action. --> BankerOption.showLateCustomerForm()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC10() {
	try {
		// user code begin {1}
		// user code end
		this.showLateCustomerForm();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC11:  (JButton8.action. --> BankerOption.showPaymentHistoryForm()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC11() {
	try {
		// user code begin {1}
		// user code end
		this.showPaymentHistoryForm();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC12:  (JButton9.action. --> BankerOption.showModifyCustomerForm()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC12() {
	try {
		// user code begin {1}
		// user code end
		this.showModifyCustomerForm();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC13:  (JMenuItem2.action. --> BankerOption.adminLogon(Ljava.awt.event.MouseEvent;)V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC13() {
	try {
		// user code begin {1}
		// user code end
		this.adminLogon(null);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC14:  (JMenuItem3.action. --> BankerOption.openAbount()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC14() {
	try {
		// user code begin {1}
		// user code end
		this.openAbount();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC15:  (JButton1.action. --> BankerOption.closeAbout()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC15() {
	try {
		// user code begin {1}
		// user code end
		this.closeAbout();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC2:  (JFrame1.window.windowClosed(java.awt.event.WindowEvent) --> BankerOption.ExitApplication()V)
 * @param arg1 java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC2(java.awt.event.WindowEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.ExitApplication();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC3:  (BankerOption.initialize() --> BankerOption.bankerOption_Initialize()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3() {
	try {
		// user code begin {1}
		// user code end
		this.bankerOption_Initialize();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC4:  (JMenuItem1.action. --> BankerOption.BankerLogon(Ljava.awt.event.MouseEvent;)V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC4() {
	try {
		// user code begin {1}
		// user code end
		this.userLogon(null);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC5:  (JButton3.action. --> BankerOption.checkUserPassword()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC5() {
	try {
		// user code begin {1}
		// user code end
		this.checkUserPassword();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC6:  (JButton10.action. --> BankerOption.closeUserPassword()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC6() {
	try {
		// user code begin {1}
		// user code end
		this.closeUserPassword();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC7:  (JButton4.action. --> BankerOption.showSampleForm()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC7() {
	try {
		// user code begin {1}
		// user code end
		this.showSampleForm();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC8:  (JButton5.action. --> BankerOption.showCustomerForm()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC8() {
	try {
		// user code begin {1}
		// user code end
		this.showNewLoanForm();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC9:  (JButton6.action. --> BankerOption.showPaymentForm()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC9() {
	try {
		// user code begin {1}
		// user code end
		this.showPaymentForm();
		// user code begin {2}
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
public void ExitApplication() {
	System.exit(1);
	return;
}
/**
 * Return the JButton1 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton1() {
	if (ivjJButton1 == null) {
		try {
			ivjJButton1 = new com.sun.java.swing.JButton();
			ivjJButton1.setName("JButton1");
			ivjJButton1.setText("Ok");
			ivjJButton1.setBounds(266, 160, 85, 25);
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
 * Return the JButton10 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton10() {
	if (ivjJButton10 == null) {
		try {
			ivjJButton10 = new com.sun.java.swing.JButton();
			ivjJButton10.setName("JButton10");
			ivjJButton10.setText("Cancel");
			ivjJButton10.setBounds(155, 153, 93, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton10;
}
/**
 * Return the JButton2 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton2() {
	if (ivjJButton2 == null) {
		try {
			ivjJButton2 = new com.sun.java.swing.JButton();
			ivjJButton2.setName("JButton2");
			ivjJButton2.setText("Exit Program");
			ivjJButton2.setBounds(371, 355, 110, 25);
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
 * Return the JButton3 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton3() {
	if (ivjJButton3 == null) {
		try {
			ivjJButton3 = new com.sun.java.swing.JButton();
			ivjJButton3.setName("JButton3");
			ivjJButton3.setText("Ok");
			ivjJButton3.setBounds(43, 153, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton3;
}
/**
 * Return the JButton4 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton4() {
	if (ivjJButton4 == null) {
		try {
			ivjJButton4 = new com.sun.java.swing.JButton();
			ivjJButton4.setName("JButton4");
			ivjJButton4.setText("Show Sample Form");
			ivjJButton4.setBounds(20, 76, 205, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton4;
}
/**
 * Return the JButton5 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton5() {
	if (ivjJButton5 == null) {
		try {
			ivjJButton5 = new com.sun.java.swing.JButton();
			ivjJButton5.setName("JButton5");
			ivjJButton5.setText("Record Customer");
			ivjJButton5.setBounds(19, 152, 205, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton5;
}
/**
 * Return the JButton6 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton6() {
	if (ivjJButton6 == null) {
		try {
			ivjJButton6 = new com.sun.java.swing.JButton();
			ivjJButton6.setName("JButton6");
			ivjJButton6.setText("Get Payment Per Month");
			ivjJButton6.setBounds(18, 230, 205, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton6;
}
/**
 * Return the JButton7 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton7() {
	if (ivjJButton7 == null) {
		try {
			ivjJButton7 = new com.sun.java.swing.JButton();
			ivjJButton7.setName("JButton7");
			ivjJButton7.setText("Detect Late Payment");
			ivjJButton7.setBounds(258, 76, 202, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton7;
}
/**
 * Return the JButton8 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton8() {
	if (ivjJButton8 == null) {
		try {
			ivjJButton8 = new com.sun.java.swing.JButton();
			ivjJButton8.setName("JButton8");
			ivjJButton8.setText("Show Payment History");
			ivjJButton8.setBounds(258, 152, 202, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton8;
}
/**
 * Return the JButton9 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getJButton9() {
	if (ivjJButton9 == null) {
		try {
			ivjJButton9 = new com.sun.java.swing.JButton();
			ivjJButton9.setName("JButton9");
			ivjJButton9.setText("Edit Customer Detail");
			ivjJButton9.setBounds(259, 230, 202, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJButton9;
}
/**
 * Return the JComboBox1 property value.
 * @return com.sun.java.swing.JComboBox
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JComboBox getJComboBox1() {
	if (ivjJComboBox1 == null) {
		try {
			ivjJComboBox1 = new com.sun.java.swing.JComboBox();
			ivjJComboBox1.setName("JComboBox1");
			ivjJComboBox1.setAutoscrolls(true);
			ivjJComboBox1.setBounds(123, 83, 138, 27);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJComboBox1;
}
/**
 * Return the JDialog1 property value.
 * @return com.sun.java.swing.JDialog
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JDialog getJDialog1() {
	if (ivjJDialog1 == null) {
		try {
			ivjJDialog1 = new com.sun.java.swing.JDialog();
			ivjJDialog1.setName("JDialog1");
			ivjJDialog1.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DO_NOTHING_ON_CLOSE);
			ivjJDialog1.setResizable(true);
			ivjJDialog1.setBounds(176, 536, 294, 220);
			ivjJDialog1.setTitle("User Logon");
			getJDialog1().setContentPane(getJDialogContentPane());
			// user code begin {1}
			showCenter(ivjJDialog1);
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJDialog1;
}
/**
 * Return the JDialog2 property value.
 * @return com.sun.java.swing.JDialog
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JDialog getJDialog2() {
	if (ivjJDialog2 == null) {
		try {
			ivjJDialog2 = new com.sun.java.swing.JDialog();
			ivjJDialog2.setName("JDialog2");
			ivjJDialog2.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DO_NOTHING_ON_CLOSE);
			ivjJDialog2.setBounds(156, 811, 375, 224);
			ivjJDialog2.setTitle("about Housing Loan Systems");
			getJDialog2().setContentPane(getJDialogContentPane1());
			// user code begin {1}
			showCenter(ivjJDialog2);			
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJDialog2;
}
/**
 * Return the JDialogContentPane property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPanel getJDialogContentPane() {
	if (ivjJDialogContentPane == null) {
		try {
			ivjJDialogContentPane = new com.sun.java.swing.JPanel();
			ivjJDialogContentPane.setName("JDialogContentPane");
			ivjJDialogContentPane.setLayout(null);
			ivjJDialogContentPane.setBackground(java.awt.Color.orange);
			getJDialogContentPane().add(getJButton3(), getJButton3().getName());
			getJDialogContentPane().add(getJLabel5(), getJLabel5().getName());
			getJDialogContentPane().add(getJLabel6(), getJLabel6().getName());
			getJDialogContentPane().add(getJLabel7(), getJLabel7().getName());
			getJDialogContentPane().add(getJTextField1(), getJTextField1().getName());
			getJDialogContentPane().add(getJPasswordField1(), getJPasswordField1().getName());
			getJDialogContentPane().add(getJButton10(), getJButton10().getName());
			getJDialogContentPane().add(getJComboBox1(), getJComboBox1().getName());
			getJDialogContentPane().add(getJLabel8(), getJLabel8().getName());
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
 * Return the JDialogContentPane1 property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPanel getJDialogContentPane1() {
	if (ivjJDialogContentPane1 == null) {
		try {
			ivjJDialogContentPane1 = new com.sun.java.swing.JPanel();
			ivjJDialogContentPane1.setName("JDialogContentPane1");
			ivjJDialogContentPane1.setLayout(null);
			ivjJDialogContentPane1.setBackground(java.awt.Color.orange);
			getJDialogContentPane1().add(getJButton1(), getJButton1().getName());
			getJDialogContentPane1().add(getJLabel10(), getJLabel10().getName());
			getJDialogContentPane1().add(getJLabel11(), getJLabel11().getName());
			getJDialogContentPane1().add(getJLabel12(), getJLabel12().getName());
			getJDialogContentPane1().add(getJLabel13(), getJLabel13().getName());
			getJDialogContentPane1().add(getJLabel14(), getJLabel14().getName());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJDialogContentPane1;
}
/**
 * Return the JFrame1 property value.
 * @return com.sun.java.swing.JFrame
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JFrame getJFrame1() {
	if (ivjJFrame1 == null) {
		try {
			ivjJFrame1 = new com.sun.java.swing.JFrame();
			ivjJFrame1.setName("JFrame1");
			ivjJFrame1.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjJFrame1.setTitle("Main Menu of Banker Options");
			ivjJFrame1.setVisible(false);
			ivjJFrame1.setJMenuBar(getJFrame1JMenuBar());
			ivjJFrame1.setBounds(59, 35, 514, 442);
			ivjJFrame1.setResizable(true);
			getJFrame1().setContentPane(getJFrameContentPane());
			// user code begin {1}
			showCenter(ivjJFrame1);
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJFrame1;
}
/**
 * Return the JFrame1JMenuBar property value.
 * @return com.sun.java.swing.JMenuBar
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuBar getJFrame1JMenuBar() {
	if (ivjJFrame1JMenuBar == null) {
		try {
			ivjJFrame1JMenuBar = new com.sun.java.swing.JMenuBar();
			ivjJFrame1JMenuBar.setName("JFrame1JMenuBar");
			ivjJFrame1JMenuBar.setBackground(java.awt.Color.lightGray);
			ivjJFrame1JMenuBar.setVisible(true);
			ivjJFrame1JMenuBar.setEnabled(true);
			ivjJFrame1JMenuBar.add(getJMenu1());
			ivjJFrame1JMenuBar.add(getJMenu2());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJFrame1JMenuBar;
}
/**
 * Return the JFrameContentPane property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPanel getJFrameContentPane() {
	if (ivjJFrameContentPane == null) {
		try {
			ivjJFrameContentPane = new com.sun.java.swing.JPanel();
			ivjJFrameContentPane.setName("JFrameContentPane");
			ivjJFrameContentPane.setBorder(new com.sun.java.swing.border.CompoundBorder());
			ivjJFrameContentPane.setLayout(null);
			ivjJFrameContentPane.setBackground(java.awt.Color.orange);
			ivjJFrameContentPane.setVisible(true);
			getJFrameContentPane().add(getJButton2(), getJButton2().getName());
			getJFrameContentPane().add(getJLabel1(), getJLabel1().getName());
			getJFrameContentPane().add(getJLabel2(), getJLabel2().getName());
			getJFrameContentPane().add(getJPanel2(), getJPanel2().getName());
			getJFrameContentPane().add(getJLabel3(), getJLabel3().getName());
			getJFrameContentPane().add(getJLabel4(), getJLabel4().getName());
			getJFrameContentPane().add(getJLabel9(), getJLabel9().getName());
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
 * Return the JLabel1 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel1() {
	if (ivjJLabel1 == null) {
		try {
			ivjJLabel1 = new com.sun.java.swing.JLabel();
			ivjJLabel1.setName("JLabel1");
			ivjJLabel1.setFont(new java.awt.Font("dialog", 1, 12));
			ivjJLabel1.setText("Banker Name");
			ivjJLabel1.setBounds(16, 20, 82, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel1;
}
/**
 * Return the JLabel10 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel10() {
	if (ivjJLabel10 == null) {
		try {
			ivjJLabel10 = new com.sun.java.swing.JLabel();
			ivjJLabel10.setName("JLabel10");
			ivjJLabel10.setBorder(new com.sun.java.swing.plaf.basic.BasicMarginBorder());
			ivjJLabel10.setText("");
			ivjJLabel10.setDoubleBuffered(true);
			ivjJLabel10.setIcon(new com.sun.java.swing.ImageIcon("C:\\HousingLoanSystems\\Banking\\logo visualage.jpg"));
			ivjJLabel10.setBounds(17, 18, 88, 89);
			ivjJLabel10.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
private com.sun.java.swing.JLabel getJLabel11() {
	if (ivjJLabel11 == null) {
		try {
			ivjJLabel11 = new com.sun.java.swing.JLabel();
			ivjJLabel11.setName("JLabel11");
			ivjJLabel11.setText("Housing Loan Systems");
			ivjJLabel11.setBounds(132, 16, 139, 15);
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
private com.sun.java.swing.JLabel getJLabel12() {
	if (ivjJLabel12 == null) {
		try {
			ivjJLabel12 = new com.sun.java.swing.JLabel();
			ivjJLabel12.setName("JLabel12");
			ivjJLabel12.setText("Version 1.0");
			ivjJLabel12.setBounds(131, 46, 79, 15);
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
private com.sun.java.swing.JLabel getJLabel13() {
	if (ivjJLabel13 == null) {
		try {
			ivjJLabel13 = new com.sun.java.swing.JLabel();
			ivjJLabel13.setName("JLabel13");
			ivjJLabel13.setText("Create by VisualAge for Java 2.0");
			ivjJLabel13.setBounds(131, 79, 193, 15);
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
private com.sun.java.swing.JLabel getJLabel14() {
	if (ivjJLabel14 == null) {
		try {
			ivjJLabel14 = new com.sun.java.swing.JLabel();
			ivjJLabel14.setName("JLabel14");
			ivjJLabel14.setText("Copyright @ 2000 Computer Engineering of KMIT\'L");
			ivjJLabel14.setBounds(20, 126, 294, 15);
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
 * Return the JLabel2 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel2() {
	if (ivjJLabel2 == null) {
		try {
			ivjJLabel2 = new com.sun.java.swing.JLabel();
			ivjJLabel2.setName("JLabel2");
			ivjJLabel2.setToolTipText("");
			ivjJLabel2.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel2.setText("");
			ivjJLabel2.setBounds(112, 18, 178, 18);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel2;
}
/**
 * Return the JLabel3 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel3() {
	if (ivjJLabel3 == null) {
		try {
			ivjJLabel3 = new com.sun.java.swing.JLabel();
			ivjJLabel3.setName("JLabel3");
			ivjJLabel3.setText("Date");
			ivjJLabel3.setBounds(365, 18, 32, 15);
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
private com.sun.java.swing.JLabel getJLabel4() {
	if (ivjJLabel4 == null) {
		try {
			ivjJLabel4 = new com.sun.java.swing.JLabel();
			ivjJLabel4.setName("JLabel4");
			ivjJLabel4.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel4.setText("");
			ivjJLabel4.setBounds(398, 17, 95, 18);
			ivjJLabel4.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
private com.sun.java.swing.JLabel getJLabel5() {
	if (ivjJLabel5 == null) {
		try {
			ivjJLabel5 = new com.sun.java.swing.JLabel();
			ivjJLabel5.setName("JLabel5");
			ivjJLabel5.setText("Banker ID");
			ivjJLabel5.setBounds(19, 18, 61, 15);
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
private com.sun.java.swing.JLabel getJLabel6() {
	if (ivjJLabel6 == null) {
		try {
			ivjJLabel6 = new com.sun.java.swing.JLabel();
			ivjJLabel6.setName("JLabel6");
			ivjJLabel6.setText("Password");
			ivjJLabel6.setBounds(19, 53, 66, 15);
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
private com.sun.java.swing.JLabel getJLabel7() {
	if (ivjJLabel7 == null) {
		try {
			ivjJLabel7 = new com.sun.java.swing.JLabel();
			ivjJLabel7.setName("JLabel7");
			ivjJLabel7.setText("Branch of Bank");
			ivjJLabel7.setBounds(19, 88, 93, 15);
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
private com.sun.java.swing.JLabel getJLabel8() {
	if (ivjJLabel8 == null) {
		try {
			ivjJLabel8 = new com.sun.java.swing.JLabel();
			ivjJLabel8.setName("JLabel8");
			ivjJLabel8.setBorder(new com.sun.java.swing.plaf.metal.Flush3DBorder());
			ivjJLabel8.setText("Status");
			ivjJLabel8.setBounds(34, 123, 221, 19);
			ivjJLabel8.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
private com.sun.java.swing.JLabel getJLabel9() {
	if (ivjJLabel9 == null) {
		try {
			ivjJLabel9 = new com.sun.java.swing.JLabel();
			ivjJLabel9.setName("JLabel9");
			ivjJLabel9.setText("Status : ");
			ivjJLabel9.setBounds(26, 359, 177, 15);
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
 * Return the JMenu1 property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenu getJMenu1() {
	if (ivjJMenu1 == null) {
		try {
			ivjJMenu1 = new com.sun.java.swing.JMenu();
			ivjJMenu1.setName("JMenu1");
			ivjJMenu1.setText("Log On");
			ivjJMenu1.add(getJMenuItem2());
			ivjJMenu1.add(getJMenuItem1());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenu1;
}
/**
 * Return the JMenu2 property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenu getJMenu2() {
	if (ivjJMenu2 == null) {
		try {
			ivjJMenu2 = new com.sun.java.swing.JMenu();
			ivjJMenu2.setName("JMenu2");
			ivjJMenu2.setText("About");
			ivjJMenu2.add(getJMenuItem3());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenu2;
}
/**
 * Return the JMenuItem1 property value.
 * @return com.sun.java.swing.JMenuItem
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuItem getJMenuItem1() {
	if (ivjJMenuItem1 == null) {
		try {
			ivjJMenuItem1 = new com.sun.java.swing.JMenuItem();
			ivjJMenuItem1.setName("JMenuItem1");
			ivjJMenuItem1.setText("User Logon");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenuItem1;
}
/**
 * Return the JMenuItem2 property value.
 * @return com.sun.java.swing.JMenuItem
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuItem getJMenuItem2() {
	if (ivjJMenuItem2 == null) {
		try {
			ivjJMenuItem2 = new com.sun.java.swing.JMenuItem();
			ivjJMenuItem2.setName("JMenuItem2");
			ivjJMenuItem2.setText("Admin Logon");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenuItem2;
}
/**
 * Return the JMenuItem3 property value.
 * @return com.sun.java.swing.JMenuItem
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuItem getJMenuItem3() {
	if (ivjJMenuItem3 == null) {
		try {
			ivjJMenuItem3 = new com.sun.java.swing.JMenuItem();
			ivjJMenuItem3.setName("JMenuItem3");
			ivjJMenuItem3.setText("Housing Loan System");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenuItem3;
}
/**
 * Return the JPanel2 property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPanel getJPanel2() {
	if (ivjJPanel2 == null) {
		try {
			ivjJPanel2 = new com.sun.java.swing.JPanel();
			ivjJPanel2.setName("JPanel2");
			ivjJPanel2.setToolTipText("main menu");
			ivjJPanel2.setBorder(new com.sun.java.swing.plaf.metal.Flush3DBorder());
			ivjJPanel2.setLayout(null);
			ivjJPanel2.setBackground(java.awt.Color.orange);
			ivjJPanel2.setBounds(14, 59, 480, 284);
			getJPanel2().add(getJButton4(), getJButton4().getName());
			getJPanel2().add(getJButton5(), getJButton5().getName());
			getJPanel2().add(getJButton6(), getJButton6().getName());
			getJPanel2().add(getJButton7(), getJButton7().getName());
			getJPanel2().add(getJButton8(), getJButton8().getName());
			getJPanel2().add(getJButton9(), getJButton9().getName());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJPanel2;
}
/**
 * Return the JPasswordField1 property value.
 * @return com.sun.java.swing.JPasswordField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPasswordField getJPasswordField1() {
	if (ivjJPasswordField1 == null) {
		try {
			ivjJPasswordField1 = new com.sun.java.swing.JPasswordField();
			ivjJPasswordField1.setName("JPasswordField1");
			ivjJPasswordField1.setBounds(102, 51, 91, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJPasswordField1;
}
/**
 * Return the JTextField1 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField1() {
	if (ivjJTextField1 == null) {
		try {
			ivjJTextField1 = new com.sun.java.swing.JTextField();
			ivjJTextField1.setName("JTextField1");
			ivjJTextField1.setBounds(101, 17, 91, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField1;
}
/**
 * Called whenever the part throws an exception.
 * @param exception java.lang.Throwable
 */
private void handleException(Throwable exception) {

	/* Uncomment the following lines to print uncaught exceptions to stdout */
	System.out.println("--------- UNCAUGHT EXCEPTION ---------");
	exception.printStackTrace(System.out);
}
/**
 * Initializes connections
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initConnections() {
	// user code begin {1}
	// user code end
	getJButton2().addActionListener(this);
	getJFrame1().addWindowListener(this);
	getJMenuItem1().addActionListener(this);
	getJButton3().addActionListener(this);
	getJButton10().addActionListener(this);
	getJButton4().addActionListener(this);
	getJButton5().addActionListener(this);
	getJButton6().addActionListener(this);
	getJButton7().addActionListener(this);
	getJButton8().addActionListener(this);
	getJButton9().addActionListener(this);
	getJMenuItem2().addActionListener(this);
	getJMenuItem3().addActionListener(this);
	getJButton1().addActionListener(this);
}
/**
 * Initialize the class.
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initialize() {
	// user code begin {1}
	// user code end
	initConnections();
	connEtoC3();
	// user code begin {2}
	try {
		aNewLoanForm = new NewLoanForm(this);
		aLateCustomerForm = new LateCustomerForm(this);
		aModifyCustomerForm = new ModifyCustomerForm(this);
		aPaymentForm = new PaymentForm(this);
		aPaymentHistoryForm = new PaymentHistoryForm(this);
		aSampleForm = new SampleForm(this);
	} catch (Throwable exception) {
		exception.printStackTrace(System.out);
	}
	// user code end
}
/**
 * This method was created in VisualAge.
 * @param myChoices com.sun.java.swing.JComboBox
 */
public void initializeChoiecs(com.sun.java.swing.JComboBox myChoices) throws SQLException {
	connectDatabase();
	
	Statement stmt = conn.createStatement ();

	ResultSet rset = stmt.executeQuery ("select Branch_Name from Bank order by 1");

	while (rset.next ())
	{
		myChoices.addItem(rset.getString(1));
	}
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		BankerOption aBankerOption;
		aBankerOption = new BankerOption();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
/**
 * Comment
 */
public void openAbount() {
	ivjJFrame1.setEnabled(false);

	getJDialog2().show();
	return;
}
/**
 * This method was created in VisualAge.
 * @param component java.swing.component
 */
public void showCenter(java.awt.Component component) {
	int x,y;
	java.awt.Rectangle bound = component.getBounds();
	x = (800 - bound.width) / 2;
	y = (600 - bound.height) / 2;
	component.setBounds(x,y,bound.width,bound.height);
}
/**
 * Comment
 */
public void showLateCustomerForm() {
	if (bankerName == null) { }
	else
	{
		ivjJFrame1.setVisible(false);
		aLateCustomerForm.showForm();
	}
	return;
}
/**
 * This method was created in VisualAge.
 */
public void showLogonForm() {
	ivjJFrame1.setEnabled(false);

	getJDialog1();
	ivjJTextField1.setText("");
	ivjJPasswordField1.setText("");

	ivjJComboBox1.removeAllItems();
	try { initializeChoiecs(ivjJComboBox1); }
	catch (java.lang.Throwable ivjExc) { handleException(ivjExc); }
	
	ivjJLabel8.setText("Status");
	ivjJDialog1.show();
	return;
}
/**
 * This method was created in VisualAge.
 */
public void showMainMenu() {
	ivjJFrame1.setVisible(true);
}
/**
 * Comment
 */
public void showModifyCustomerForm() {
	if (bankerName == null) { }
	else
	{
		ivjJFrame1.setVisible(false);
		aModifyCustomerForm.showForm();
	}	
	return;
}
/**
 * Comment
 */
public void showNewLoanForm() {
	if (bankerName == null) { }
	else
	{
		ivjJFrame1.setVisible(false);
		aNewLoanForm.showForm();
	}
	return;
}
/**
 * Comment
 */
public void showPaymentForm() {
	if (bankerName == null) { }
	else
	{
		ivjJFrame1.setVisible(false);
		aPaymentForm.showForm();
	}	
	return;
}
/**
 * Comment
 */
public void showPaymentHistoryForm() {
	if (bankerName == null) { }
	else
	{
		ivjJFrame1.setVisible(false);
		aPaymentHistoryForm.showForm();
	}	
	return;
}
/**
 * Comment
 */
public void showSampleForm() {
	if (bankerName == null) { }
	else
	{
		ivjJFrame1.setVisible(false);
		aSampleForm.showForm();
	}
	return;
}
/**
 * Comment
 */
public void userLogon(java.awt.event.MouseEvent mouseEvent) {
	bankerStatus = "USER";
	showLogonForm();
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
	if ((e.getSource() == getJFrame1()) ) {
		connEtoC2(e);
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