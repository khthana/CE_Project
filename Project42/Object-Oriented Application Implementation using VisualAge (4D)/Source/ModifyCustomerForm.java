package Banking;

/**
 * This type was created in VisualAge.
 */
public class ModifyCustomerForm implements java.awt.event.ActionListener, java.awt.event.WindowListener {
	private com.sun.java.swing.JFrame ivjJFrame1 = null;
	private com.sun.java.swing.JPanel ivjJFrameContentPane = null;
	private com.sun.java.swing.JButton ivjJButton1 = null;
	private com.sun.java.swing.JButton ivjJButton2 = null;
	private com.sun.java.swing.JButton ivjJButton3 = null;
	private com.sun.java.swing.JLabel ivjJLabel1 = null;
	private com.sun.java.swing.JLabel ivjJLabel10 = null;
	private com.sun.java.swing.JLabel ivjJLabel11 = null;
	private com.sun.java.swing.JLabel ivjJLabel12 = null;
	private com.sun.java.swing.JLabel ivjJLabel13 = null;
	private com.sun.java.swing.JLabel ivjJLabel14 = null;
	private com.sun.java.swing.JLabel ivjJLabel15 = null;
	private com.sun.java.swing.JLabel ivjJLabel16 = null;
	private com.sun.java.swing.JLabel ivjJLabel17 = null;
	private com.sun.java.swing.JLabel ivjJLabel18 = null;
	private com.sun.java.swing.JLabel ivjJLabel19 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel20 = null;
	private com.sun.java.swing.JLabel ivjJLabel21 = null;
	private com.sun.java.swing.JLabel ivjJLabel22 = null;
	private com.sun.java.swing.JLabel ivjJLabel23 = null;
	private com.sun.java.swing.JLabel ivjJLabel24 = null;
	private com.sun.java.swing.JLabel ivjJLabel25 = null;
	private com.sun.java.swing.JLabel ivjJLabel26 = null;
	private com.sun.java.swing.JLabel ivjJLabel27 = null;
	private com.sun.java.swing.JLabel ivjJLabel28 = null;
	private com.sun.java.swing.JLabel ivjJLabel29 = null;
	private com.sun.java.swing.JLabel ivjJLabel30 = null;
	private com.sun.java.swing.JLabel ivjJLabel4 = null;
	private com.sun.java.swing.JLabel ivjJLabel5 = null;
	private com.sun.java.swing.JLabel ivjJLabel6 = null;
	private com.sun.java.swing.JLabel ivjJLabel7 = null;
	private com.sun.java.swing.JLabel ivjJLabel8 = null;
	private com.sun.java.swing.JLabel ivjJLabel9 = null;
	private com.sun.java.swing.JTextField ivjJTextField1 = null;
	private com.sun.java.swing.JTextField ivjJTextField2 = null;
	private com.sun.java.swing.JTextField ivjJTextField3 = null;
	private com.sun.java.swing.JTextField ivjJTextField4 = null;
	private com.sun.java.swing.JTextField ivjJTextField5 = null;
	private com.sun.java.swing.JTextField ivjJTextField6 = null;
	private com.sun.java.swing.JTextField ivjJTextField7 = null;
	private com.sun.java.swing.JTextField ivjJTextField8 = null;
	private com.sun.java.swing.JTextField ivjJTextField9 = null;
	private BankerOption aBankerOption = null;
	private int customerID = 0;
	private int houseID = 0;
	private String customerName = null;
	private String address = null;
	private int salary = 0;
	private String houseName = null;
	private String province = null;
	private int area = 0;
	private int price = 0;
	private int landID = 0;
	private String owner = null;
	private com.sun.java.swing.JTextField ivjJTextField10 = null;
	private com.sun.java.swing.JCheckBox ivjJCheckBox1 = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public ModifyCustomerForm() {
	super();
	initialize();
}
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public ModifyCustomerForm(BankerOption aaBankerOption) {
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
	if ((e.getSource() == getJButton3()) ) {
		connEtoC1();
	}
	if ((e.getSource() == getJButton1()) ) {
		connEtoC3();
	}
	if ((e.getSource() == getJButton2()) ) {
		connEtoC4();
	}
	// user code begin {2}
	// user code end
}
/**
 * connEtoC1:  (JButton3.action. --> ModifyCustomerForm.exitForm()V)
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
 * connEtoC2:  (JFrame1.window.windowClosed(java.awt.event.WindowEvent) --> ModifyCustomerForm.exitForm()V)
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
 * connEtoC3:  (JButton1.action. --> ModifyCustomerForm.searchCustomerToModify()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3() {
	try {
		// user code begin {1}
		// user code end
		this.searchCustomerToModify();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC4:  (JButton2.action. --> ModifyCustomerForm.recordModifyCustomer()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC4() {
	try {
		// user code begin {1}
		// user code end
		this.recordModifyCustomer();
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
			ivjJButton1.setBounds(20, 48, 136, 25);
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
			ivjJButton2.setText("Record");
			ivjJButton2.setBounds(271, 382, 85, 25);
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
			ivjJButton3.setText("Cancel");
			ivjJButton3.setBounds(376, 382, 85, 25);
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
 * Return the JCheckBox1 property value.
 * @return com.sun.java.swing.JCheckBox
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JCheckBox getJCheckBox1() {
	if (ivjJCheckBox1 == null) {
		try {
			ivjJCheckBox1 = new com.sun.java.swing.JCheckBox();
			ivjJCheckBox1.setName("JCheckBox1");
			ivjJCheckBox1.setText("Update Complete");
			ivjJCheckBox1.setBounds(21, 386, 124, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJCheckBox1;
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
			ivjJFrame1.setBounds(71, 42, 485, 453);
			ivjJFrame1.setTitle("Modify Customer Form");
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
			getJFrameContentPane().add(getJLabel1(), getJLabel1().getName());
			getJFrameContentPane().add(getJTextField1(), getJTextField1().getName());
			getJFrameContentPane().add(getJButton1(), getJButton1().getName());
			getJFrameContentPane().add(getJLabel2(), getJLabel2().getName());
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
			getJFrameContentPane().add(getJTextField2(), getJTextField2().getName());
			getJFrameContentPane().add(getJLabel21(), getJLabel21().getName());
			getJFrameContentPane().add(getJTextField3(), getJTextField3().getName());
			getJFrameContentPane().add(getJLabel22(), getJLabel22().getName());
			getJFrameContentPane().add(getJLabel23(), getJLabel23().getName());
			getJFrameContentPane().add(getJTextField4(), getJTextField4().getName());
			getJFrameContentPane().add(getJLabel24(), getJLabel24().getName());
			getJFrameContentPane().add(getJTextField5(), getJTextField5().getName());
			getJFrameContentPane().add(getJLabel25(), getJLabel25().getName());
			getJFrameContentPane().add(getJTextField6(), getJTextField6().getName());
			getJFrameContentPane().add(getJLabel26(), getJLabel26().getName());
			getJFrameContentPane().add(getJLabel27(), getJLabel27().getName());
			getJFrameContentPane().add(getJTextField7(), getJTextField7().getName());
			getJFrameContentPane().add(getJLabel28(), getJLabel28().getName());
			getJFrameContentPane().add(getJLabel29(), getJLabel29().getName());
			getJFrameContentPane().add(getJTextField8(), getJTextField8().getName());
			getJFrameContentPane().add(getJLabel30(), getJLabel30().getName());
			getJFrameContentPane().add(getJTextField9(), getJTextField9().getName());
			getJFrameContentPane().add(getJButton2(), getJButton2().getName());
			getJFrameContentPane().add(getJButton3(), getJButton3().getName());
			getJFrameContentPane().add(getJTextField10(), getJTextField10().getName());
			getJFrameContentPane().add(getJCheckBox1(), getJCheckBox1().getName());
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
			ivjJLabel1.setBounds(20, 21, 75, 15);
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
			ivjJLabel10.setBounds(324, 114, 32, 15);
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
			ivjJLabel11.setBounds(367, 113, 33, 15);
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
			ivjJLabel12.setBounds(20, 143, 108, 15);
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
			ivjJLabel13.setBounds(133, 142, 30, 15);
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
			ivjJLabel14.setBounds(171, 142, 18, 15);
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
			ivjJLabel15.setBounds(196, 143, 89, 15);
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
			ivjJLabel16.setBounds(289, 144, 67, 15);
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
			ivjJLabel17.setBounds(368, 143, 29, 15);
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
private com.sun.java.swing.JLabel getJLabel18() {
	if (ivjJLabel18 == null) {
		try {
			ivjJLabel18 = new com.sun.java.swing.JLabel();
			ivjJLabel18.setName("JLabel18");
			ivjJLabel18.setText("Loan Date");
			ivjJLabel18.setBounds(20, 172, 58, 15);
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
private com.sun.java.swing.JLabel getJLabel19() {
	if (ivjJLabel19 == null) {
		try {
			ivjJLabel19 = new com.sun.java.swing.JLabel();
			ivjJLabel19.setName("JLabel19");
			ivjJLabel19.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel19.setText("");
			ivjJLabel19.setBounds(90, 172, 97, 15);
			ivjJLabel19.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel2.setBounds(20, 87, 39, 15);
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
 * Return the JLabel20 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel20() {
	if (ivjJLabel20 == null) {
		try {
			ivjJLabel20 = new com.sun.java.swing.JLabel();
			ivjJLabel20.setName("JLabel20");
			ivjJLabel20.setText("Address");
			ivjJLabel20.setBounds(20, 210, 52, 15);
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
private com.sun.java.swing.JLabel getJLabel21() {
	if (ivjJLabel21 == null) {
		try {
			ivjJLabel21 = new com.sun.java.swing.JLabel();
			ivjJLabel21.setName("JLabel21");
			ivjJLabel21.setText("Salary");
			ivjJLabel21.setBounds(21, 239, 43, 15);
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
private com.sun.java.swing.JLabel getJLabel22() {
	if (ivjJLabel22 == null) {
		try {
			ivjJLabel22 = new com.sun.java.swing.JLabel();
			ivjJLabel22.setName("JLabel22");
			ivjJLabel22.setText("Baht");
			ivjJLabel22.setBounds(159, 240, 32, 15);
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
private com.sun.java.swing.JLabel getJLabel23() {
	if (ivjJLabel23 == null) {
		try {
			ivjJLabel23 = new com.sun.java.swing.JLabel();
			ivjJLabel23.setName("JLabel23");
			ivjJLabel23.setText("House Project Name");
			ivjJLabel23.setBounds(22, 268, 120, 15);
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
 * Return the JLabel24 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel24() {
	if (ivjJLabel24 == null) {
		try {
			ivjJLabel24 = new com.sun.java.swing.JLabel();
			ivjJLabel24.setName("JLabel24");
			ivjJLabel24.setText("Province");
			ivjJLabel24.setBounds(22, 297, 52, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel24;
}
/**
 * Return the JLabel25 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel25() {
	if (ivjJLabel25 == null) {
		try {
			ivjJLabel25 = new com.sun.java.swing.JLabel();
			ivjJLabel25.setName("JLabel25");
			ivjJLabel25.setText("Area");
			ivjJLabel25.setBounds(216, 297, 32, 15);
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
private com.sun.java.swing.JLabel getJLabel26() {
	if (ivjJLabel26 == null) {
		try {
			ivjJLabel26 = new com.sun.java.swing.JLabel();
			ivjJLabel26.setName("JLabel26");
			ivjJLabel26.setText("m x m");
			ivjJLabel26.setBounds(316, 298, 52, 15);
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
 * Return the JLabel27 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel27() {
	if (ivjJLabel27 == null) {
		try {
			ivjJLabel27 = new com.sun.java.swing.JLabel();
			ivjJLabel27.setName("JLabel27");
			ivjJLabel27.setText("Price");
			ivjJLabel27.setBounds(22, 326, 37, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel27;
}
/**
 * Return the JLabel28 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel28() {
	if (ivjJLabel28 == null) {
		try {
			ivjJLabel28 = new com.sun.java.swing.JLabel();
			ivjJLabel28.setName("JLabel28");
			ivjJLabel28.setText("Baht");
			ivjJLabel28.setBounds(171, 326, 32, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel28;
}
/**
 * Return the JLabel29 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel29() {
	if (ivjJLabel29 == null) {
		try {
			ivjJLabel29 = new com.sun.java.swing.JLabel();
			ivjJLabel29.setName("JLabel29");
			ivjJLabel29.setText("Land ID");
			ivjJLabel29.setBounds(217, 326, 46, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel29;
}
/**
 * Return the JLabel30 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel30() {
	if (ivjJLabel30 == null) {
		try {
			ivjJLabel30 = new com.sun.java.swing.JLabel();
			ivjJLabel30.setName("JLabel30");
			ivjJLabel30.setText("Owner");
			ivjJLabel30.setBounds(21, 356, 41, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel30;
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
			ivjJLabel4.setBounds(243, 86, 101, 15);
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
			ivjJLabel5.setBounds(350, 86, 73, 15);
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
			ivjJLabel6.setBounds(20, 114, 79, 15);
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
			ivjJLabel7.setBounds(104, 114, 82, 15);
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
			ivjJLabel8.setBounds(197, 114, 32, 15);
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
			ivjJLabel9.setBounds(244, 113, 72, 15);
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
 * Return the JTextField1 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField1() {
	if (ivjJTextField1 == null) {
		try {
			ivjJTextField1 = new com.sun.java.swing.JTextField();
			ivjJTextField1.setName("JTextField1");
			ivjJTextField1.setBounds(104, 20, 64, 19);
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
 * Return the JTextField10 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField10() {
	if (ivjJTextField10 == null) {
		try {
			ivjJTextField10 = new com.sun.java.swing.JTextField();
			ivjJTextField10.setName("JTextField10");
			ivjJTextField10.setBounds(64, 85, 161, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField10;
}
/**
 * Return the JTextField2 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField2() {
	if (ivjJTextField2 == null) {
		try {
			ivjJTextField2 = new com.sun.java.swing.JTextField();
			ivjJTextField2.setName("JTextField2");
			ivjJTextField2.setBounds(77, 209, 291, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField2;
}
/**
 * Return the JTextField3 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField3() {
	if (ivjJTextField3 == null) {
		try {
			ivjJTextField3 = new com.sun.java.swing.JTextField();
			ivjJTextField3.setName("JTextField3");
			ivjJTextField3.setBounds(70, 238, 77, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField3;
}
/**
 * Return the JTextField4 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField4() {
	if (ivjJTextField4 == null) {
		try {
			ivjJTextField4 = new com.sun.java.swing.JTextField();
			ivjJTextField4.setName("JTextField4");
			ivjJTextField4.setBounds(147, 267, 134, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField4;
}
/**
 * Return the JTextField5 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField5() {
	if (ivjJTextField5 == null) {
		try {
			ivjJTextField5 = new com.sun.java.swing.JTextField();
			ivjJTextField5.setName("JTextField5");
			ivjJTextField5.setBounds(82, 296, 100, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField5;
}
/**
 * Return the JTextField6 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField6() {
	if (ivjJTextField6 == null) {
		try {
			ivjJTextField6 = new com.sun.java.swing.JTextField();
			ivjJTextField6.setName("JTextField6");
			ivjJTextField6.setBounds(254, 296, 52, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField6;
}
/**
 * Return the JTextField7 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField7() {
	if (ivjJTextField7 == null) {
		try {
			ivjJTextField7 = new com.sun.java.swing.JTextField();
			ivjJTextField7.setName("JTextField7");
			ivjJTextField7.setBounds(68, 325, 91, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField7;
}
/**
 * Return the JTextField8 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField8() {
	if (ivjJTextField8 == null) {
		try {
			ivjJTextField8 = new com.sun.java.swing.JTextField();
			ivjJTextField8.setName("JTextField8");
			ivjJTextField8.setBounds(272, 325, 84, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField8;
}
/**
 * Return the JTextField9 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField9() {
	if (ivjJTextField9 == null) {
		try {
			ivjJTextField9 = new com.sun.java.swing.JTextField();
			ivjJTextField9.setName("JTextField9");
			ivjJTextField9.setBounds(74, 354, 167, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField9;
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
	getJButton3().addActionListener(this);
	getJFrame1().addWindowListener(this);
	getJButton1().addActionListener(this);
	getJButton2().addActionListener(this);
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
public void initialModifyCustomerForm() {
	customerID = 0;
	houseID = 0;
	customerName = null;
	address = null;
	salary = 0;
	houseName = null;
	province = null;
	area = 0;
	price = 0;
	landID = 0;
	owner = null;
	
	ivjJTextField10.setText("");
	ivjJTextField1.setText("");
	ivjJTextField2.setText("");
	ivjJTextField3.setText("");
	ivjJTextField4.setText("");
	ivjJTextField5.setText("");
	ivjJTextField6.setText("");
	ivjJTextField7.setText("");
	ivjJTextField8.setText("");
	ivjJTextField9.setText("");
	
	ivjJLabel5.setText("");
	ivjJLabel7.setText("");
	ivjJLabel10.setText("");
	ivjJLabel13.setText("");
	ivjJLabel16.setText("");
	ivjJLabel19.setText("");
	
	ivjJCheckBox1.setSelected(false);
	return;
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		ModifyCustomerForm aModifyCustomerForm;
		aModifyCustomerForm = new ModifyCustomerForm();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
/**
 * Comment
 */
public void recordModifyCustomer() {
	try
	{
		if (customerID == 0 || houseID == 0) { return; }
		
		java.sql.Statement stmt = aBankerOption.conn.createStatement ();
	
		customerName = ivjJTextField10.getText().toUpperCase();
		address = ivjJTextField2.getText().toUpperCase();
		salary = Integer.parseInt(ivjJTextField3.getText());
		houseName =	ivjJTextField4.getText().toUpperCase();
		province = ivjJTextField5.getText().toUpperCase();
		area = Integer.parseInt(ivjJTextField6.getText());
		price = Integer.parseInt(ivjJTextField7.getText());
		landID = Integer.parseInt(ivjJTextField8.getText());
		owner = ivjJTextField9.getText().toUpperCase();
				
		aBankerOption.conn.commit();

		stmt.executeUpdate ("update Customer set Name = '"+customerName+"' , Address = '"+address
			                +"' , Salary = "+salary+" where customer_id = "+customerID);
	   
		stmt.executeUpdate ("update HouseProject set ProjectName = '"+houseName+"' , Province = '"+province+"' , Area = "
			                +area+" , Price = "+price+" , Land_id = "+landID+" , Owner = '"+owner+"' where Project_id = "+houseID);
		
		aBankerOption.conn.commit();

		ivjJCheckBox1.setSelected(true);
	}
	catch (Throwable exception) 
	{
		handleException(exception);
		try
		{
			aBankerOption.conn.rollback();
		}
		catch (Throwable except) { handleException(except); }
	}

	return;
}
/**
 * Comment
 */
public void searchCustomerToModify() {
	try
	{
		customerID = Integer.parseInt(ivjJTextField1.getText());
	}
	catch (java.lang.Throwable exception) { return; }

	try
	{
		int account_id = 0;
		int project_id = 0;
		java.sql.Statement stmt = aBankerOption.conn.createStatement ();
		java.sql.ResultSet rset = null;
		
//------------------------ clear form -------------------------//
		houseID = 0;
		customerName = null;
		address = null;
		salary = 0;
		houseName = null;
		province = null;
		area = 0;
		price = 0;
		landID = 0;
		owner = null;

		ivjJTextField10.setText("");
		ivjJTextField2.setText("");
		ivjJTextField3.setText("");
		ivjJTextField4.setText("");
		ivjJTextField5.setText("");
		ivjJTextField6.setText("");
		ivjJTextField7.setText("");
		ivjJTextField8.setText("");
		ivjJTextField9.setText("");
	
		ivjJLabel5.setText("");
		ivjJLabel7.setText("");
		ivjJLabel10.setText("");
		ivjJLabel13.setText("");
		ivjJLabel16.setText("");
		ivjJLabel19.setText("");
		
		ivjJCheckBox1.setSelected(false);
//------------------------ clear form -------------------------//
		
		rset = stmt.executeQuery ("select Name,Address,Salary,Payment_Status,Account_id,Project_id from Customer where Customer_id = "+customerID);
		if (rset.next ())
		{
			customerName = rset.getString(1);	ivjJTextField10.setText(customerName);
			address = rset.getString(2);		ivjJTextField2.setText(address);
			salary = rset.getInt(3);			ivjJTextField3.setText(Integer.toString(salary));
												ivjJLabel5.setText(rset.getString(4));
			account_id = rset.getInt(5);		
			project_id = rset.getInt(6);
			houseID = project_id;				// for update houseProject //
		}

		rset = stmt.executeQuery ("select Amount,PType,Loan_Int_Rate,Const_Paid,to_char(Start_Date,'dd-Mon-yyyy') from Loanaccount where Account_id = "+account_id);
		if (rset.next ())
		{
			ivjJLabel7.setText(Integer.toString(rset.getInt(1)));
			ivjJLabel10.setText(Integer.toString(rset.getInt(2)));
			ivjJLabel13.setText(Double.toString(rset.getDouble(3)));
			ivjJLabel16.setText(Integer.toString(rset.getInt(4)));
			ivjJLabel19.setText(rset.getString(5));
		}

		rset = stmt.executeQuery ("select ProjectName,Province,Area,Price,Land_id,Owner from HouseProject where Project_id = "+project_id);
		if (rset.next ())
		{
			houseName = rset.getString(1);		ivjJTextField4.setText(houseName);
			province = rset.getString(2); 		ivjJTextField5.setText(province);
			area = rset.getInt(3);				ivjJTextField6.setText(Integer.toString(area));
			price = rset.getInt(4);				ivjJTextField7.setText(Integer.toString(price));
			landID = rset.getInt(5);			ivjJTextField8.setText(Integer.toString(landID));
			owner = rset.getString(6);			ivjJTextField9.setText(owner);
		}
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
	   initialModifyCustomerForm();
	}
	catch (Throwable exception) { handleException(exception); }
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