package Banking;

/**
 * This type was created in VisualAge.
 */
import com.sun.java.swing.*;
import com.sun.java.swing.table.*;
 
public class PaymentHistoryForm implements java.awt.event.ActionListener, java.awt.event.WindowListener {
	private com.sun.java.swing.JButton ivjJButton1 = null;
	private com.sun.java.swing.JButton ivjJButton2 = null;
	private com.sun.java.swing.JFrame ivjJFrame1 = null;
	private com.sun.java.swing.JPanel ivjJFrameContentPane = null;
	private com.sun.java.swing.JLabel ivjJLabel1 = null;
	private com.sun.java.swing.JLabel ivjJLabel10 = null;
	private com.sun.java.swing.JLabel ivjJLabel11 = null;
	private com.sun.java.swing.JLabel ivjJLabel12 = null;
	private com.sun.java.swing.JLabel ivjJLabel13 = null;
	private com.sun.java.swing.JLabel ivjJLabel14 = null;
	private com.sun.java.swing.JLabel ivjJLabel15 = null;
	private com.sun.java.swing.JLabel ivjJLabel16 = null;
	private com.sun.java.swing.JLabel ivjJLabel17 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel3 = null;
	private com.sun.java.swing.JLabel ivjJLabel4 = null;
	private com.sun.java.swing.JLabel ivjJLabel5 = null;
	private com.sun.java.swing.JLabel ivjJLabel6 = null;
	private com.sun.java.swing.JLabel ivjJLabel7 = null;
	private com.sun.java.swing.JLabel ivjJLabel8 = null;
	private com.sun.java.swing.JLabel ivjJLabel9 = null;
	private com.sun.java.swing.JScrollPane ivjJScrollPane1 = null;
	private com.sun.java.swing.JTextField ivjJTextField1 = null;
	private com.sun.java.swing.JTable ivjScrollPaneTable = null;
	private BankerOption aBankerOption = null;
	private	DefaultTableColumnModel historyColumnModel = new DefaultTableColumnModel();
	private String[][] historyTableValue = new String[10][10];	
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public PaymentHistoryForm() {
	super();
	initialize();
}
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public PaymentHistoryForm(BankerOption aaBankerOption) {
	super();
	aBankerOption = aaBankerOption;	
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
	if ((e.getSource() == getJButton1()) ) {
		connEtoC3();
	}
	// user code begin {2}
	// user code end
}
/**
 * connEtoC1:  (JButton2.action. --> PaymentHistoryForm.exitForm()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC1() {
	try {
		// user code begin {1}
		// user code end
		this.exitForm();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC2:  (JFrame1.window.windowClosed(java.awt.event.WindowEvent) --> PaymentHistoryForm.exitForm()V)
 * @param arg1 java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC2(java.awt.event.WindowEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.exitForm();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC3:  (JButton1.action. --> PaymentHistoryForm.searchCustomerHistomer()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3() {
	try {
		// user code begin {1}
		// user code end
		this.searchCustomerHistomer();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * This method was created in VisualAge.
 */
public void createHistoryColumnModel() {
	TableColumn column1  = new TableColumn();
	TableColumn column2  = new TableColumn();
	TableColumn column3  = new TableColumn();
	TableColumn column4  = new TableColumn();
	TableColumn column5  = new TableColumn();
	TableColumn column6  = new TableColumn();
	TableColumn column7  = new TableColumn();
	TableColumn column8  = new TableColumn();
	TableColumn column9  = new TableColumn();
	TableColumn column10 = new TableColumn();

	column1.setHeaderValue("Cash ID");
	column2.setHeaderValue("Period Num");
	column3.setHeaderValue("Cash Money");
	column4.setHeaderValue("Principal Paid");
	column5.setHeaderValue("Interest Paid");
	column6.setHeaderValue("Late Interest Paid");
	column7.setHeaderValue("Balance Due");
	column8.setHeaderValue("Period Status");
	column9.setHeaderValue("Pay Date");
	column10.setHeaderValue("Banker ID");

	historyColumnModel.addColumn(column1);
	historyColumnModel.addColumn(column2);
	historyColumnModel.addColumn(column3);
	historyColumnModel.addColumn(column4);
	historyColumnModel.addColumn(column5);
	historyColumnModel.addColumn(column6);
	historyColumnModel.addColumn(column7);
	historyColumnModel.addColumn(column8);
	historyColumnModel.addColumn(column9);
	historyColumnModel.addColumn(column10);	
}
/**
 * Comment
 */
public void exitForm() {
	ivjJFrame1.setVisible(false);
	aBankerOption.showMainMenu();	
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
			ivjJButton1.setText("Search Customer");
			ivjJButton1.setBounds(19, 48, 138, 25);
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
private com.sun.java.swing.JButton getJButton2() {
	if (ivjJButton2 == null) {
		try {
			ivjJButton2 = new com.sun.java.swing.JButton();
			ivjJButton2.setName("JButton2");
			ivjJButton2.setText("Exit");
			ivjJButton2.setBounds(373, 365, 85, 25);
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
			ivjJFrame1.setBounds(67, 35, 501, 434);
			ivjJFrame1.setTitle("Payment History Form");
			getJFrame1().setContentPane(getJFrameContentPane());
			// user code begin {1}
			aBankerOption.showCenter(ivjJFrame1);			
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
 * Return the JFrameContentPane property value.
 * @return com.sun.java.swing.JPanel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JPanel getJFrameContentPane() {
	if (ivjJFrameContentPane == null) {
		try {
			ivjJFrameContentPane = new com.sun.java.swing.JPanel();
			ivjJFrameContentPane.setName("JFrameContentPane");
			ivjJFrameContentPane.setLayout(null);
			ivjJFrameContentPane.setBackground(java.awt.Color.orange);
			getJFrameContentPane().add(getJScrollPane1(), getJScrollPane1().getName());
			getJFrameContentPane().add(getJLabel1(), getJLabel1().getName());
			getJFrameContentPane().add(getJTextField1(), getJTextField1().getName());
			getJFrameContentPane().add(getJButton1(), getJButton1().getName());
			getJFrameContentPane().add(getJLabel2(), getJLabel2().getName());
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
			getJFrameContentPane().add(getJButton2(), getJButton2().getName());
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
			ivjJLabel1.setText("Customer ID");
			ivjJLabel1.setBounds(19, 20, 77, 15);
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
			ivjJLabel10.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel10.setText("");
			ivjJLabel10.setBounds(324, 116, 29, 15);
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
			ivjJLabel11.setText("Year");
			ivjJLabel11.setBounds(365, 116, 31, 15);
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
			ivjJLabel12.setText("Loan Interest Rate");
			ivjJLabel12.setBounds(20, 146, 107, 15);
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
			ivjJLabel13.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel13.setText("");
			ivjJLabel13.setBounds(136, 146, 30, 15);
			ivjJLabel13.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel14.setText("%");
			ivjJLabel14.setBounds(176, 145, 18, 15);
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
private com.sun.java.swing.JLabel getJLabel15() {
	if (ivjJLabel15 == null) {
		try {
			ivjJLabel15 = new com.sun.java.swing.JLabel();
			ivjJLabel15.setName("JLabel15");
			ivjJLabel15.setText("Constant Paid");
			ivjJLabel15.setBounds(245, 146, 82, 15);
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
private com.sun.java.swing.JLabel getJLabel16() {
	if (ivjJLabel16 == null) {
		try {
			ivjJLabel16 = new com.sun.java.swing.JLabel();
			ivjJLabel16.setName("JLabel16");
			ivjJLabel16.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel16.setText("");
			ivjJLabel16.setBounds(338, 145, 70, 15);
			ivjJLabel16.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
private com.sun.java.swing.JLabel getJLabel17() {
	if (ivjJLabel17 == null) {
		try {
			ivjJLabel17 = new com.sun.java.swing.JLabel();
			ivjJLabel17.setName("JLabel17");
			ivjJLabel17.setText("Baht");
			ivjJLabel17.setBounds(419, 145, 34, 15);
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
 * Return the JLabel2 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel2() {
	if (ivjJLabel2 == null) {
		try {
			ivjJLabel2 = new com.sun.java.swing.JLabel();
			ivjJLabel2.setName("JLabel2");
			ivjJLabel2.setText("Name");
			ivjJLabel2.setBounds(19, 87, 39, 15);
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
			ivjJLabel3.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel3.setText("");
			ivjJLabel3.setBounds(66, 87, 141, 15);
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
			ivjJLabel4.setText("Customer Status");
			ivjJLabel4.setBounds(243, 87, 103, 15);
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
			ivjJLabel5.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel5.setText("");
			ivjJLabel5.setBounds(351, 87, 67, 15);
			ivjJLabel5.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel6.setText("Amount Loan");
			ivjJLabel6.setBounds(20, 116, 82, 15);
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
			ivjJLabel7.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel7.setText("");
			ivjJLabel7.setBounds(110, 116, 78, 15);
			ivjJLabel7.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel8.setText("Baht");
			ivjJLabel8.setBounds(200, 116, 33, 15);
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
			ivjJLabel9.setText("Period Type");
			ivjJLabel9.setBounds(244, 116, 70, 15);
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
 * Return the JScrollPane1 property value.
 * @return com.sun.java.swing.JScrollPane
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JScrollPane getJScrollPane1() {
	if (ivjJScrollPane1 == null) {
		try {
			ivjJScrollPane1 = new com.sun.java.swing.JScrollPane();
			ivjJScrollPane1.setName("JScrollPane1");
			ivjJScrollPane1.setVerticalScrollBarPolicy(com.sun.java.swing.JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
			ivjJScrollPane1.setHorizontalScrollBarPolicy(com.sun.java.swing.JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
			ivjJScrollPane1.setBounds(20, 179, 454, 157);
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
 * Return the JTextField1 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField1() {
	if (ivjJTextField1 == null) {
		try {
			ivjJTextField1 = new com.sun.java.swing.JTextField();
			ivjJTextField1.setName("JTextField1");
			ivjJTextField1.setBounds(108, 19, 73, 19);
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
 * Return the ScrollPaneTable property value.
 * @return com.sun.java.swing.JTable
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTable getScrollPaneTable() {
	if (ivjScrollPaneTable == null) {
		try {
			ivjScrollPaneTable = new com.sun.java.swing.JTable();
			ivjScrollPaneTable.setName("ScrollPaneTable");
			getJScrollPane1().setColumnHeaderView(ivjScrollPaneTable.getTableHeader());
			getJScrollPane1().getViewport().setBackingStoreEnabled(true);
			ivjScrollPaneTable.setAutoResizeMode(com.sun.java.swing.JTable.AUTO_RESIZE_OFF);
			ivjScrollPaneTable.setBounds(0, 110, 200, 90);
			// user code begin {1}
			createHistoryColumnModel();			
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
	// user code begin {2}
	// user code end
}
/**
 * This method was created in VisualAge.
 */
public void initialPaymentHistoryForm() {
	ivjJTextField1.setText("");
	ivjJLabel3.setText("");
	ivjJLabel5.setText("");
	ivjJLabel7.setText("");
	ivjJLabel10.setText("");
	ivjJLabel13.setText("");
	ivjJLabel16.setText("");
	
	int i,j;
	for (i=0;i<10;i++)
	{
		for (j=0;j<10;j++)
		{
			historyTableValue[i][j] = null;
		}
	}
	showHistoryTable();
	
	return;
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		PaymentHistoryForm aPaymentHistoryForm;
		aPaymentHistoryForm = new PaymentHistoryForm();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
/**
 * Comment
 */
public void searchCustomerHistomer() {
	int customer_id = 0;
	try
	{
		customer_id = Integer.parseInt(ivjJTextField1.getText());
	}
	catch (java.lang.Throwable exception) { return; }

	try
	{
		int account_id = 0;
		java.sql.Statement stmt = aBankerOption.conn.createStatement ();
		java.sql.ResultSet rset = null;

		ivjJLabel3.setText("");
		ivjJLabel5.setText("");
		ivjJLabel7.setText("");
		ivjJLabel10.setText("");
		ivjJLabel13.setText("");
		ivjJLabel16.setText("");
	
		rset = stmt.executeQuery ("select Name,Payment_Status,Account_id from Customer where Customer_id = "+Integer.toString(customer_id));
		if (rset.next ())
		{
			ivjJLabel3.setText(rset.getString(1));
			ivjJLabel5.setText(rset.getString(2));
			account_id = rset.getInt(3);
		}

		rset = stmt.executeQuery ("select Amount,PType,Loan_Int_Rate,Const_Paid from Loanaccount where Account_id = "+account_id);
		if (rset.next ())
		{
			ivjJLabel7.setText(Integer.toString(rset.getInt(1)));
			ivjJLabel10.setText(Integer.toString(rset.getInt(2)));
			ivjJLabel13.setText(Double.toString(rset.getDouble(3)));
			ivjJLabel16.setText(Integer.toString(rset.getInt(4)));
		}

//------------------ clear historyTableValue --------------------//
		int i,j;
		for (i=0;i<10;i++)
		{
			for (j=0;j<10;j++)
			{
				historyTableValue[i][j] = null;
			}
		}
//------------------ clear historyTableValue --------------------//

		rset = stmt.executeQuery ("select Cash_id,Period_Num,Cash_Money,Principal_Paid,Int_Paid,Late_Int_Paid,Balance_Due,Period_Status,to_char(Pay_Date,'dd-Mon-yyyy'),Banker_id from Cash_Per_Month where Customer_id = "
			                      +Integer.toString(customer_id)+" order by Period_Num");
		i = 0;
		while (rset.next () && i<10)
		{ 
			historyTableValue[i][0] = Integer.toString(rset.getInt(1));
			historyTableValue[i][1] = Integer.toString(rset.getInt(2));
			historyTableValue[i][2] = Integer.toString(rset.getInt(3));
			historyTableValue[i][3] = Double.toString(rset.getDouble(4));
			historyTableValue[i][4] = Double.toString(rset.getDouble(5));
			historyTableValue[i][5] = Double.toString(rset.getDouble(6));
			historyTableValue[i][6] = Double.toString(rset.getDouble(7));
			historyTableValue[i][7] = rset.getString(8);
			historyTableValue[i][8] = rset.getString(9);
			historyTableValue[i][9] = Integer.toString(rset.getInt(10));
			i++;
		}
		showHistoryTable();
	}
	catch (java.lang.Throwable error) { handleException(error); }
		
	return;
}
/**
 * This method was created in VisualAge.
 */
public void showForm() {
	getJFrame1().show();
	try 
	{
	   initialPaymentHistoryForm();
	}
	catch (Throwable exception) { handleException(exception); }	
}
/**
 * This method was created in VisualAge.
 */
public void showHistoryTable() {
	TableModel dataModel = new AbstractTableModel() {
		public String getColumnName(int column) { return historyColumnModel.getColumn(column).getHeaderValue().toString(); }
		public int getColumnCount() { return historyColumnModel.getColumnCount(); }
		public int getRowCount() { return 10;}
		public Object getValueAt(int row, int col) { return historyTableValue[row][col]; }
	};

	ivjScrollPaneTable.setModel(dataModel);	
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