package Banking;

/**
 * This type was created in VisualAge.
 */
public class PaymentForm implements java.awt.event.ActionListener, java.awt.event.WindowListener {
	private com.sun.java.swing.JButton ivjJButton1 = null;
	private com.sun.java.swing.JButton ivjJButton2 = null;
	private com.sun.java.swing.JButton ivjJButton3 = null;
	private com.sun.java.swing.JCheckBox ivjJCheckBox1 = null;
	private com.sun.java.swing.JFrame ivjJFrame1 = null;
	private com.sun.java.swing.JPanel ivjJFrameContentPane = null;
	private com.sun.java.swing.JLabel ivjJLabel1 = null;
	private com.sun.java.swing.JLabel ivjJLabel10 = null;
	private com.sun.java.swing.JLabel ivjJLabel11 = null;
	private com.sun.java.swing.JLabel ivjJLabel12 = null;
	private com.sun.java.swing.JLabel ivjJLabel121 = null;
	private com.sun.java.swing.JLabel ivjJLabel122 = null;
	private com.sun.java.swing.JLabel ivjJLabel13 = null;
	private com.sun.java.swing.JLabel ivjJLabel14 = null;
	private com.sun.java.swing.JLabel ivjJLabel15 = null;
	private com.sun.java.swing.JLabel ivjJLabel16 = null;
	private com.sun.java.swing.JLabel ivjJLabel17 = null;
	private com.sun.java.swing.JLabel ivjJLabel18 = null;
	private com.sun.java.swing.JLabel ivjJLabel181 = null;
	private com.sun.java.swing.JLabel ivjJLabel19 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel20 = null;
	private com.sun.java.swing.JLabel ivjJLabel201 = null;
	private com.sun.java.swing.JLabel ivjJLabel21 = null;
	private com.sun.java.swing.JLabel ivjJLabel22 = null;
	private com.sun.java.swing.JLabel ivjJLabel23 = null;
	private com.sun.java.swing.JLabel ivjJLabel24 = null;
	private com.sun.java.swing.JLabel ivjJLabel25 = null;
	private com.sun.java.swing.JLabel ivjJLabel26 = null;
	private com.sun.java.swing.JLabel ivjJLabel3 = null;
	private com.sun.java.swing.JLabel ivjJLabel4 = null;
	private com.sun.java.swing.JLabel ivjJLabel5 = null;
	private com.sun.java.swing.JLabel ivjJLabel6 = null;
	private com.sun.java.swing.JLabel ivjJLabel7 = null;
	private com.sun.java.swing.JLabel ivjJLabel71 = null;
	private com.sun.java.swing.JLabel ivjJLabel8 = null;
	private com.sun.java.swing.JLabel ivjJLabel9 = null;
	private com.sun.java.swing.JLabel ivjJLabel91 = null;
	private com.sun.java.swing.JTextField ivjJTextField1 = null;
	private BankerOption aBankerOption = null;
	private int customerID = 0;
	private boolean late = false;
	private String customerName = null;
	private String customerStatus = null;
	private String lastPaidDate = null;
	private int amountDay = 0;
	private double interestRate = 0;
	private double lateIntRate = 0;
	private int lastPeriodNum = 0;
	private double balanceDue = 0;
	private int lowPayment = 0;
	private int periodNum = 0;
	private int cashMoney = 0;
	private double principalPaid = 0;
	private double intPaid = 0;
	private double lateIntPaid = 0;
	private String periodStatus = null;
	private int constPaid = 0;
	private com.sun.java.swing.JButton ivjJButton4 = null;
	private com.sun.java.swing.JButton ivjJButton5 = null;
	private com.sun.java.swing.JDialog ivjJDialog1 = null;
	private com.sun.java.swing.JPanel ivjJDialogContentPane = null;
	private com.sun.java.swing.JLabel ivjJLabel27 = null;
	private com.sun.java.swing.JLabel ivjJLabel28 = null;
	private com.sun.java.swing.JLabel ivjJLabel29 = null;
	private com.sun.java.swing.JLabel ivjJLabel30 = null;
	private com.sun.java.swing.JLabel ivjJLabel31 = null;
	private com.sun.java.swing.JLabel ivjJLabel32 = null;
	private com.sun.java.swing.JLabel ivjJLabel33 = null;
	private com.sun.java.swing.JLabel ivjJLabel34 = null;
	private com.sun.java.swing.JLabel ivjJLabel35 = null;
	private com.sun.java.swing.JLabel ivjJLabel36 = null;
	private com.sun.java.swing.JLabel ivjJLabel37 = null;
	private com.sun.java.swing.JLabel ivjJLabel371 = null;
	private com.sun.java.swing.JLabel ivjJLabel372 = null;
	private com.sun.java.swing.JLabel ivjJLabel373 = null;
	private com.sun.java.swing.JLabel ivjJLabel3731 = null;
	private com.sun.java.swing.JLabel ivjJLabel38 = null;
	private com.sun.java.swing.JLabel ivjJLabel39 = null;
	private com.sun.java.swing.JLabel ivjJLabel40 = null;
	private com.sun.java.swing.JLabel ivjJLabel41 = null;
	private com.sun.java.swing.JLabel ivjJLabel42 = null;
	private com.sun.java.swing.JLabel ivjJLabel421 = null;
	private com.sun.java.swing.JLabel ivjJLabel422 = null;
	private com.sun.java.swing.JLabel ivjJLabel43 = null;
	private com.sun.java.swing.JLabel ivjJLabel44 = null;
	private com.sun.java.swing.JLabel ivjJLabel45 = null;
	private com.sun.java.swing.JLabel ivjJLabel46 = null;
	private com.sun.java.swing.JLabel ivjJLabel47 = null;
	private com.sun.java.swing.JLabel ivjJLabel48 = null;
	private com.sun.java.swing.JLabel ivjJLabel49 = null;
	private com.sun.java.swing.JLabel ivjJLabel50 = null;
	private com.sun.java.swing.JTextField ivjCashEdit = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public PaymentForm() {
	super();
	initialize();
}
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public PaymentForm(BankerOption aaBankerOption) {
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
	if ((e.getSource() == getJButton5()) ) {
		connEtoC5();
	}
	if ((e.getSource() == getJButton2()) ) {
		connEtoC4();
	}
	if ((e.getSource() == getJButton4()) ) {
		connEtoC6();
	}
	// user code begin {2}
	// user code end
}
/**
 * connEtoC1:  (JButton3.action. --> PaymentForm.exitForm()V)
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
 * connEtoC2:  (JFrame1.window.windowClosed(java.awt.event.WindowEvent) --> PaymentForm.exitForm()V)
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
 * connEtoC3:  (JButton1.action. --> PaymentForm.searchCustomer()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3() {
	try {
		// user code begin {1}
		// user code end
		this.searchCustomer();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC4:  (JButton2.action. --> PaymentForm.recordCashPerMonth()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC4() {
	try {
		// user code begin {1}
		// user code end
		this.payCash();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC5:  (JButton5.action. --> PaymentForm.exitRecordPaymentForm()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC5() {
	try {
		// user code begin {1}
		// user code end
		this.exitRecordPaymentForm();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC6:  (JButton4.action. --> PaymentForm.recordCashPerMonth()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC6() {
	try {
		// user code begin {1}
		// user code end
		this.recordCashPerMonth();
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
 * Comment
 */
public void exitRecordPaymentForm() {
	ivjJFrame1.setVisible(true);
	ivjJDialog1.dispose();
	ivjJDialog1 = null;
	return;
}
/**
 * Return the JTextField2 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getCashEdit() {
	if (ivjCashEdit == null) {
		try {
			ivjCashEdit = new com.sun.java.swing.JTextField();
			ivjCashEdit.setName("CashEdit");
			ivjCashEdit.setBounds(259, 239, 77, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjCashEdit;
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
			ivjJButton1.setBounds(21, 49, 134, 25);
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
			ivjJButton2.setText("Ok");
			ivjJButton2.setBounds(247, 302, 85, 25);
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
			ivjJButton3.setBounds(347, 302, 85, 25);
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
			ivjJButton4.setText("Record");
			ivjJButton4.setBounds(187, 316, 85, 25);
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
			ivjJButton5.setText("Cancel");
			ivjJButton5.setBounds(291, 316, 85, 25);
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
 * Return the JCheckBox1 property value.
 * @return com.sun.java.swing.JCheckBox
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JCheckBox getJCheckBox1() {
	if (ivjJCheckBox1 == null) {
		try {
			ivjJCheckBox1 = new com.sun.java.swing.JCheckBox();
			ivjJCheckBox1.setName("JCheckBox1");
			ivjJCheckBox1.setBorder(new com.sun.java.swing.plaf.metal.Flush3DBorder());
			ivjJCheckBox1.setText("  Late");
			ivjJCheckBox1.setBackground(java.awt.Color.lightGray);
			ivjJCheckBox1.setForeground(java.awt.Color.red);
			ivjJCheckBox1.setBorderPainted(true);
			ivjJCheckBox1.setSelected(false);
			ivjJCheckBox1.setBounds(369, 41, 83, 18);
			ivjJCheckBox1.setEnabled(true);
			ivjJCheckBox1.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJDialog1.setBounds(87, 486, 412, 392);
			ivjJDialog1.setTitle("Record Payment Form");
			getJDialog1().setContentPane(getJDialogContentPane());
			// user code begin {1}
			aBankerOption.showCenter(ivjJDialog1);			
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
			getJDialogContentPane().add(getJButton4(), getJButton4().getName());
			getJDialogContentPane().add(getJButton5(), getJButton5().getName());
			getJDialogContentPane().add(getJLabel27(), getJLabel27().getName());
			getJDialogContentPane().add(getJLabel28(), getJLabel28().getName());
			getJDialogContentPane().add(getJLabel29(), getJLabel29().getName());
			getJDialogContentPane().add(getJLabel30(), getJLabel30().getName());
			getJDialogContentPane().add(getJLabel31(), getJLabel31().getName());
			getJDialogContentPane().add(getJLabel32(), getJLabel32().getName());
			getJDialogContentPane().add(getJLabel33(), getJLabel33().getName());
			getJDialogContentPane().add(getJLabel34(), getJLabel34().getName());
			getJDialogContentPane().add(getJLabel35(), getJLabel35().getName());
			getJDialogContentPane().add(getJLabel36(), getJLabel36().getName());
			getJDialogContentPane().add(getJLabel37(), getJLabel37().getName());
			getJDialogContentPane().add(getJLabel38(), getJLabel38().getName());
			getJDialogContentPane().add(getJLabel39(), getJLabel39().getName());
			getJDialogContentPane().add(getJLabel40(), getJLabel40().getName());
			getJDialogContentPane().add(getJLabel41(), getJLabel41().getName());
			getJDialogContentPane().add(getJLabel42(), getJLabel42().getName());
			getJDialogContentPane().add(getJLabel421(), getJLabel421().getName());
			getJDialogContentPane().add(getJLabel422(), getJLabel422().getName());
			getJDialogContentPane().add(getJLabel371(), getJLabel371().getName());
			getJDialogContentPane().add(getJLabel372(), getJLabel372().getName());
			getJDialogContentPane().add(getJLabel373(), getJLabel373().getName());
			getJDialogContentPane().add(getJLabel43(), getJLabel43().getName());
			getJDialogContentPane().add(getJLabel44(), getJLabel44().getName());
			getJDialogContentPane().add(getJLabel3731(), getJLabel3731().getName());
			getJDialogContentPane().add(getJLabel45(), getJLabel45().getName());
			getJDialogContentPane().add(getJLabel46(), getJLabel46().getName());
			getJDialogContentPane().add(getJLabel47(), getJLabel47().getName());
			getJDialogContentPane().add(getJLabel48(), getJLabel48().getName());
			getJDialogContentPane().add(getJLabel49(), getJLabel49().getName());
			getJDialogContentPane().add(getJLabel50(), getJLabel50().getName());
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
			ivjJFrame1.setBounds(36, 34, 469, 374);
			ivjJFrame1.setTitle("Payment Form");
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
			getJFrameContentPane().add(getJLabel91(), getJLabel91().getName());
			getJFrameContentPane().add(getJCheckBox1(), getJCheckBox1().getName());
			getJFrameContentPane().add(getJLabel14(), getJLabel14().getName());
			getJFrameContentPane().add(getJLabel15(), getJLabel15().getName());
			getJFrameContentPane().add(getJLabel16(), getJLabel16().getName());
			getJFrameContentPane().add(getJLabel17(), getJLabel17().getName());
			getJFrameContentPane().add(getJLabel18(), getJLabel18().getName());
			getJFrameContentPane().add(getJLabel19(), getJLabel19().getName());
			getJFrameContentPane().add(getJLabel181(), getJLabel181().getName());
			getJFrameContentPane().add(getJLabel20(), getJLabel20().getName());
			getJFrameContentPane().add(getJLabel201(), getJLabel201().getName());
			getJFrameContentPane().add(getJLabel21(), getJLabel21().getName());
			getJFrameContentPane().add(getJLabel71(), getJLabel71().getName());
			getJFrameContentPane().add(getJLabel22(), getJLabel22().getName());
			getJFrameContentPane().add(getJLabel23(), getJLabel23().getName());
			getJFrameContentPane().add(getJLabel121(), getJLabel121().getName());
			getJFrameContentPane().add(getJLabel24(), getJLabel24().getName());
			getJFrameContentPane().add(getCashEdit(), getCashEdit().getName());
			getJFrameContentPane().add(getJLabel122(), getJLabel122().getName());
			getJFrameContentPane().add(getJLabel25(), getJLabel25().getName());
			getJFrameContentPane().add(getJLabel26(), getJLabel26().getName());
			getJFrameContentPane().add(getJButton2(), getJButton2().getName());
			getJFrameContentPane().add(getJButton3(), getJButton3().getName());
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
			ivjJLabel1.setBounds(22, 20, 76, 15);
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
			ivjJLabel10.setText("Low Payment");
			ivjJLabel10.setBounds(19, 192, 81, 15);
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
			ivjJLabel11.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel11.setText("");
			ivjJLabel11.setBounds(107, 193, 82, 15);
			ivjJLabel11.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel12.setText("Baht");
			ivjJLabel12.setBounds(199, 193, 33, 15);
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
 * Return the JLabel121 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel121() {
	if (ivjJLabel121 == null) {
		try {
			ivjJLabel121 = new com.sun.java.swing.JLabel();
			ivjJLabel121.setName("JLabel121");
			ivjJLabel121.setText("Baht");
			ivjJLabel121.setBounds(408, 165, 33, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel121;
}
/**
 * Return the JLabel122 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel122() {
	if (ivjJLabel122 == null) {
		try {
			ivjJLabel122 = new com.sun.java.swing.JLabel();
			ivjJLabel122.setName("JLabel122");
			ivjJLabel122.setText("Baht");
			ivjJLabel122.setBounds(345, 241, 33, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel122;
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
			ivjJLabel13.setText("Last Paid Date");
			ivjJLabel13.setBounds(20, 112, 88, 15);
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
			ivjJLabel14.setText("Amount");
			ivjJLabel14.setBounds(208, 111, 52, 15);
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
			ivjJLabel15.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel15.setText("");
			ivjJLabel15.setBounds(263, 111, 35, 15);
			ivjJLabel15.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel16.setText("Days");
			ivjJLabel16.setBounds(312, 111, 35, 15);
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
			ivjJLabel17.setText("Interest Rate");
			ivjJLabel17.setBounds(19, 139, 80, 15);
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
			ivjJLabel18.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel18.setText("");
			ivjJLabel18.setBounds(103, 139, 34, 15);
			ivjJLabel18.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
 * Return the JLabel181 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel181() {
	if (ivjJLabel181 == null) {
		try {
			ivjJLabel181 = new com.sun.java.swing.JLabel();
			ivjJLabel181.setName("JLabel181");
			ivjJLabel181.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel181.setText("");
			ivjJLabel181.setBounds(316, 138, 34, 15);
			ivjJLabel181.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel181;
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
			ivjJLabel19.setText("Late Interest Rate");
			ivjJLabel19.setBounds(208, 138, 105, 15);
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
			ivjJLabel2.setBounds(21, 86, 45, 15);
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
			ivjJLabel20.setText("%");
			ivjJLabel20.setBounds(146, 139, 19, 15);
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
 * Return the JLabel201 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel201() {
	if (ivjJLabel201 == null) {
		try {
			ivjJLabel201 = new com.sun.java.swing.JLabel();
			ivjJLabel201.setName("JLabel201");
			ivjJLabel201.setText("%");
			ivjJLabel201.setBounds(360, 138, 19, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel201;
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
			ivjJLabel21.setText("Last Period Num");
			ivjJLabel21.setBounds(19, 166, 98, 15);
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
			ivjJLabel22.setText("Balance Due");
			ivjJLabel22.setBounds(208, 164, 76, 15);
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
			ivjJLabel23.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel23.setText("");
			ivjJLabel23.setBounds(290, 165, 109, 15);
			ivjJLabel23.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel24.setText("Cash Money");
			ivjJLabel24.setBounds(175, 241, 72, 15);
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
			ivjJLabel25.setText("Banker Name");
			ivjJLabel25.setBounds(19, 267, 77, 15);
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
			ivjJLabel26.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel26.setText("");
			ivjJLabel26.setBounds(108, 268, 193, 15);
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
			ivjJLabel27.setText("Cash ID");
			ivjJLabel27.setBounds(15, 16, 48, 15);
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
			ivjJLabel28.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel28.setText("");
			ivjJLabel28.setBounds(67, 15, 69, 15);
			ivjJLabel28.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel29.setText("Customer ID");
			ivjJLabel29.setBounds(15, 45, 76, 15);
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
			ivjJLabel3.setBounds(65, 86, 157, 15);
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
 * Return the JLabel30 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel30() {
	if (ivjJLabel30 == null) {
		try {
			ivjJLabel30 = new com.sun.java.swing.JLabel();
			ivjJLabel30.setName("JLabel30");
			ivjJLabel30.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel30.setText("");
			ivjJLabel30.setBounds(96, 45, 58, 15);
			ivjJLabel30.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
 * Return the JLabel31 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel31() {
	if (ivjJLabel31 == null) {
		try {
			ivjJLabel31 = new com.sun.java.swing.JLabel();
			ivjJLabel31.setName("JLabel31");
			ivjJLabel31.setText("Name");
			ivjJLabel31.setBounds(172, 44, 38, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel31;
}
/**
 * Return the JLabel32 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel32() {
	if (ivjJLabel32 == null) {
		try {
			ivjJLabel32 = new com.sun.java.swing.JLabel();
			ivjJLabel32.setName("JLabel32");
			ivjJLabel32.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel32.setText("");
			ivjJLabel32.setBounds(218, 44, 164, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel32;
}
/**
 * Return the JLabel33 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel33() {
	if (ivjJLabel33 == null) {
		try {
			ivjJLabel33 = new com.sun.java.swing.JLabel();
			ivjJLabel33.setName("JLabel33");
			ivjJLabel33.setText("Period Num");
			ivjJLabel33.setBounds(16, 73, 73, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel33;
}
/**
 * Return the JLabel34 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel34() {
	if (ivjJLabel34 == null) {
		try {
			ivjJLabel34 = new com.sun.java.swing.JLabel();
			ivjJLabel34.setName("JLabel34");
			ivjJLabel34.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel34.setText("");
			ivjJLabel34.setBounds(96, 73, 33, 15);
			ivjJLabel34.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.RIGHT);
			ivjJLabel34.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel34;
}
/**
 * Return the JLabel35 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel35() {
	if (ivjJLabel35 == null) {
		try {
			ivjJLabel35 = new com.sun.java.swing.JLabel();
			ivjJLabel35.setName("JLabel35");
			ivjJLabel35.setText("Cash Amount");
			ivjJLabel35.setBounds(171, 72, 80, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel35;
}
/**
 * Return the JLabel36 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel36() {
	if (ivjJLabel36 == null) {
		try {
			ivjJLabel36 = new com.sun.java.swing.JLabel();
			ivjJLabel36.setName("JLabel36");
			ivjJLabel36.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel36.setText("");
			ivjJLabel36.setBounds(259, 71, 84, 15);
			ivjJLabel36.setHorizontalTextPosition(com.sun.java.swing.SwingConstants.RIGHT);
			ivjJLabel36.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel36;
}
/**
 * Return the JLabel37 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel37() {
	if (ivjJLabel37 == null) {
		try {
			ivjJLabel37 = new com.sun.java.swing.JLabel();
			ivjJLabel37.setName("JLabel37");
			ivjJLabel37.setText("Baht");
			ivjJLabel37.setBounds(353, 72, 29, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel37;
}
/**
 * Return the JLabel371 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel371() {
	if (ivjJLabel371 == null) {
		try {
			ivjJLabel371 = new com.sun.java.swing.JLabel();
			ivjJLabel371.setName("JLabel371");
			ivjJLabel371.setText("Baht");
			ivjJLabel371.setBounds(266, 131, 29, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel371;
}
/**
 * Return the JLabel372 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel372() {
	if (ivjJLabel372 == null) {
		try {
			ivjJLabel372 = new com.sun.java.swing.JLabel();
			ivjJLabel372.setName("JLabel372");
			ivjJLabel372.setText("Baht");
			ivjJLabel372.setBounds(265, 160, 29, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel372;
}
/**
 * Return the JLabel373 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel373() {
	if (ivjJLabel373 == null) {
		try {
			ivjJLabel373 = new com.sun.java.swing.JLabel();
			ivjJLabel373.setName("JLabel373");
			ivjJLabel373.setText("Baht");
			ivjJLabel373.setBounds(265, 189, 29, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel373;
}
/**
 * Return the JLabel3731 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel3731() {
	if (ivjJLabel3731 == null) {
		try {
			ivjJLabel3731 = new com.sun.java.swing.JLabel();
			ivjJLabel3731.setName("JLabel3731");
			ivjJLabel3731.setText("Baht");
			ivjJLabel3731.setBounds(243, 219, 29, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel3731;
}
/**
 * Return the JLabel38 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel38() {
	if (ivjJLabel38 == null) {
		try {
			ivjJLabel38 = new com.sun.java.swing.JLabel();
			ivjJLabel38.setName("JLabel38");
			ivjJLabel38.setText("Divide by");
			ivjJLabel38.setBounds(16, 101, 56, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel38;
}
/**
 * Return the JLabel39 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel39() {
	if (ivjJLabel39 == null) {
		try {
			ivjJLabel39 = new com.sun.java.swing.JLabel();
			ivjJLabel39.setName("JLabel39");
			ivjJLabel39.setText("Principal Paid");
			ivjJLabel39.setBounds(38, 131, 82, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel39;
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
			ivjJLabel4.setBounds(247, 85, 100, 15);
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
 * Return the JLabel40 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel40() {
	if (ivjJLabel40 == null) {
		try {
			ivjJLabel40 = new com.sun.java.swing.JLabel();
			ivjJLabel40.setName("JLabel40");
			ivjJLabel40.setText("Interest Paid");
			ivjJLabel40.setBounds(39, 159, 79, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel40;
}
/**
 * Return the JLabel41 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel41() {
	if (ivjJLabel41 == null) {
		try {
			ivjJLabel41 = new com.sun.java.swing.JLabel();
			ivjJLabel41.setName("JLabel41");
			ivjJLabel41.setText("Late Interest Paid");
			ivjJLabel41.setBounds(39, 188, 107, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel41;
}
/**
 * Return the JLabel42 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel42() {
	if (ivjJLabel42 == null) {
		try {
			ivjJLabel42 = new com.sun.java.swing.JLabel();
			ivjJLabel42.setName("JLabel42");
			ivjJLabel42.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel42.setText("");
			ivjJLabel42.setBounds(154, 132, 98, 15);
			ivjJLabel42.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel42;
}
/**
 * Return the JLabel421 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel421() {
	if (ivjJLabel421 == null) {
		try {
			ivjJLabel421 = new com.sun.java.swing.JLabel();
			ivjJLabel421.setName("JLabel421");
			ivjJLabel421.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel421.setText("");
			ivjJLabel421.setBounds(153, 160, 98, 15);
			ivjJLabel421.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel421;
}
/**
 * Return the JLabel422 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel422() {
	if (ivjJLabel422 == null) {
		try {
			ivjJLabel422 = new com.sun.java.swing.JLabel();
			ivjJLabel422.setName("JLabel422");
			ivjJLabel422.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel422.setText("");
			ivjJLabel422.setBounds(153, 189, 98, 15);
			ivjJLabel422.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel422;
}
/**
 * Return the JLabel43 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel43() {
	if (ivjJLabel43 == null) {
		try {
			ivjJLabel43 = new com.sun.java.swing.JLabel();
			ivjJLabel43.setName("JLabel43");
			ivjJLabel43.setText("Balance Due");
			ivjJLabel43.setBounds(16, 220, 80, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel43;
}
/**
 * Return the JLabel44 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel44() {
	if (ivjJLabel44 == null) {
		try {
			ivjJLabel44 = new com.sun.java.swing.JLabel();
			ivjJLabel44.setName("JLabel44");
			ivjJLabel44.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel44.setText("");
			ivjJLabel44.setBounds(107, 220, 120, 15);
			ivjJLabel44.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel44;
}
/**
 * Return the JLabel45 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel45() {
	if (ivjJLabel45 == null) {
		try {
			ivjJLabel45 = new com.sun.java.swing.JLabel();
			ivjJLabel45.setName("JLabel45");
			ivjJLabel45.setText("Period Status");
			ivjJLabel45.setBounds(15, 250, 86, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel45;
}
/**
 * Return the JLabel46 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel46() {
	if (ivjJLabel46 == null) {
		try {
			ivjJLabel46 = new com.sun.java.swing.JLabel();
			ivjJLabel46.setName("JLabel46");
			ivjJLabel46.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel46.setText("");
			ivjJLabel46.setBounds(107, 249, 68, 15);
			ivjJLabel46.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel46;
}
/**
 * Return the JLabel47 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel47() {
	if (ivjJLabel47 == null) {
		try {
			ivjJLabel47 = new com.sun.java.swing.JLabel();
			ivjJLabel47.setName("JLabel47");
			ivjJLabel47.setText("Pay Date");
			ivjJLabel47.setBounds(208, 250, 58, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel47;
}
/**
 * Return the JLabel48 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel48() {
	if (ivjJLabel48 == null) {
		try {
			ivjJLabel48 = new com.sun.java.swing.JLabel();
			ivjJLabel48.setName("JLabel48");
			ivjJLabel48.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel48.setText("");
			ivjJLabel48.setBounds(277, 249, 93, 15);
			ivjJLabel48.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel48;
}
/**
 * Return the JLabel49 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel49() {
	if (ivjJLabel49 == null) {
		try {
			ivjJLabel49 = new com.sun.java.swing.JLabel();
			ivjJLabel49.setName("JLabel49");
			ivjJLabel49.setText("Banker Name");
			ivjJLabel49.setBounds(16, 281, 85, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel49;
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
			ivjJLabel5.setBounds(355, 84, 66, 15);
			ivjJLabel5.setForeground(new java.awt.Color(102,102,153));
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
 * Return the JLabel50 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel50() {
	if (ivjJLabel50 == null) {
		try {
			ivjJLabel50 = new com.sun.java.swing.JLabel();
			ivjJLabel50.setName("JLabel50");
			ivjJLabel50.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel50.setText("");
			ivjJLabel50.setBounds(107, 281, 188, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel50;
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
			ivjJLabel6.setText("Period Number");
			ivjJLabel6.setBounds(19, 239, 90, 15);
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
			ivjJLabel7.setBounds(112, 240, 32, 15);
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
 * Return the JLabel71 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel71() {
	if (ivjJLabel71 == null) {
		try {
			ivjJLabel71 = new com.sun.java.swing.JLabel();
			ivjJLabel71.setName("JLabel71");
			ivjJLabel71.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel71.setText("");
			ivjJLabel71.setBounds(124, 166, 32, 15);
			ivjJLabel71.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel71;
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
			ivjJLabel8.setText("Date");
			ivjJLabel8.setBounds(334, 20, 31, 15);
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
			ivjJLabel9.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel9.setText("");
			ivjJLabel9.setBounds(368, 19, 83, 15);
			ivjJLabel9.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
 * Return the JLabel91 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel91() {
	if (ivjJLabel91 == null) {
		try {
			ivjJLabel91 = new com.sun.java.swing.JLabel();
			ivjJLabel91.setName("JLabel91");
			ivjJLabel91.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel91.setText("");
			ivjJLabel91.setBounds(111, 112, 88, 15);
			ivjJLabel91.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel91;
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
			ivjJTextField1.setBounds(106, 19, 61, 19);
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
	getJButton3().addActionListener(this);
	getJButton1().addActionListener(this);
	getJButton5().addActionListener(this);
	getJFrame1().addWindowListener(this);
	getJButton2().addActionListener(this);
	getJButton4().addActionListener(this);
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
 * Comment
 */
public void initialPaymentForm() throws java.sql.SQLException {
	customerID = 0;
	late = false;
	customerName = null;
	customerStatus = null;
	lastPaidDate = null;
	amountDay = 0;
	interestRate = 0;
	lateIntRate = 0;
	lastPeriodNum = 0;
	balanceDue = 0;
	lowPayment = 0;
	periodNum = 0;
	cashMoney = 0;
	principalPaid = 0;
	intPaid = 0;
	lateIntPaid = 0;
	periodStatus = null;
	constPaid = 0;
		
	ivjJLabel9.setText(aBankerOption.today);
	ivjJLabel26.setText(aBankerOption.bankerName);
	
	ivjJCheckBox1.setSelected(false);
	ivjJTextField1.setText("");
	ivjCashEdit.setText("");
	ivjJLabel3.setText("");
	ivjJLabel5.setForeground(new java.awt.Color(102,102,153));
	ivjJLabel5.setText("");
	ivjJLabel91.setText("");
	ivjJLabel15.setText("");
	ivjJLabel18.setText("");
	ivjJLabel181.setText("");
	ivjJLabel71.setText("");
	ivjJLabel23.setText("");
	ivjJLabel11.setText("");
	ivjJLabel7.setText("");
	
	java.sql.CallableStatement cstmt = aBankerOption.conn.prepareCall ("{? = call GET_CURRENT_INT()}");
	cstmt.registerOutParameter (1, java.sql.Types.DOUBLE);
	cstmt.execute ();
	interestRate = cstmt.getDouble(1);
	ivjJLabel18.setText(java.lang.Double.toString(interestRate));

	cstmt = aBankerOption.conn.prepareCall ("{? = call GET_LATE_INT()}");
	cstmt.registerOutParameter (1, java.sql.Types.DOUBLE);
	cstmt.execute ();
	lateIntRate = cstmt.getDouble(1);
	ivjJLabel181.setText(java.lang.Double.toString(lateIntRate));
	return;
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		PaymentForm aPaymentForm;
		aPaymentForm = new PaymentForm();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
/**
 * Comment
 */
public void payCash() {
	try
	{
		cashMoney = Integer.parseInt(ivjCashEdit.getText());
	}
	catch (Throwable exception) { cashMoney = 0; }
		
	if ((cashMoney >= lowPayment) && (lowPayment > 0))
	{
		String a = new String();
		principalPaid = cashMoney - intPaid - lateIntPaid;
		balanceDue = balanceDue - principalPaid;
		
		a = Double.toString(principalPaid);
		try
		{ a = a.substring(0,a.indexOf('.')+4); }
		catch (Throwable exception) { }
		principalPaid = Double.valueOf(a).doubleValue();
		
		a = Double.toString(balanceDue);
		try
		{ a = a.substring(0,a.indexOf('.')+4); }
		catch (Throwable exception) { }
		balanceDue = Double.valueOf(a).doubleValue();
		
		ivjJFrame1.setVisible(false);
		showRecordPaymentForm();
	}
	
	return;
}
/**
 * Comment
 */
public void recordCashPerMonth() {
	try
	{
		java.sql.Statement stmt = aBankerOption.conn.createStatement ();
	
		java.sql.ResultSet rset = stmt.executeQuery ("select Period_Num,to_char(Pay_Date,'dd-Mon-yyyy') from Cash_Per_Month where Customer_id = "
			 				+customerID+" and Period_Num >= all(select Period_Num from Cash_Per_Month where Customer_id = "
			 				+customerID+")");
		if (rset.next ())
		{ 
			if (periodNum == rset.getInt(1) || aBankerOption.today.equals(rset.getString(2).trim()) 
				|| customerStatus.equals("ACQUIRE"))
			{
				return;		// exit when same periodNum or payDate or status == ACQUIRE
			}
		}
		

		aBankerOption.conn.commit();
		
		stmt.executeUpdate ("insert into Cash_Per_Month values(Cash_ID.nextval,"+customerID
							+","+periodNum+","+cashMoney+","+principalPaid+","+intPaid+","
							+lateIntPaid+","+balanceDue+",'"+periodStatus+"',sysdate,"
							+aBankerOption.bankerID+")");
	   
		stmt.executeUpdate ("update Customer set Payment_Status = '"+periodStatus+"' where Customer_id = "+customerID);
		
		rset = stmt.executeQuery ("select Cash_ID from Cash_Per_Month where Cash_ID >= ALL (select Cash_ID from Cash_Per_Month)");

		if (rset.next ())
		{ 
		 	ivjJLabel28.setText(Integer.toString(rset.getInt(1)));
		}

		aBankerOption.conn.commit();
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
public void searchCustomer() throws java.sql.SQLException {
	int accountID = 0;
	customerID = Integer.parseInt(ivjJTextField1.getText());

	aBankerOption.conn.close();
	aBankerOption.connectDatabase();
	java.sql.Statement stmt = aBankerOption.conn.createStatement ();
	java.sql.ResultSet rset = stmt.executeQuery ("select Name,Payment_Status,Account_id from Customer where Customer_id = " + customerID);
	if (rset.next ())
	{ 
		customerName = rset.getString(1); 
		customerStatus = rset.getString(2);
		accountID = rset.getInt(3);
		ivjJLabel3.setText(customerName);
		ivjJLabel5.setForeground(new java.awt.Color(102,102,153));
		ivjJLabel5.setText(customerStatus);
	    if (customerStatus.equals("ACQUIRE")) 
	    {
			ivjJCheckBox1.setSelected(false);
			ivjJLabel91.setText("");
			ivjJLabel15.setText("");
			ivjJLabel71.setText("");
			ivjJLabel23.setText("");
			ivjJLabel11.setText("");
			ivjJLabel7.setText("");
			lowPayment = 0;
		    return; 
		}
	}
	else
	{
		ivjJCheckBox1.setSelected(false);
		ivjJLabel3.setText("");
		ivjJLabel5.setText("");
		ivjJLabel91.setText("");
		ivjJLabel15.setText("");
		ivjJLabel71.setText("");
		ivjJLabel23.setText("");
		ivjJLabel11.setText("");
		ivjJLabel7.setText("");
		lowPayment = 0;
		return;
	}

	java.sql.CallableStatement cstmt = aBankerOption.conn.prepareCall ("{? = call LAST_PAY_DATE (?,?)}");
	cstmt.registerOutParameter (1, java.sql.Types.CHAR);
	cstmt.setInt (2, customerID);
	cstmt.setInt (3, accountID);
	cstmt.execute ();
	lastPaidDate = cstmt.getString(1).trim();
	ivjJLabel91.setText(lastPaidDate);
	
	cstmt = aBankerOption.conn.prepareCall ("{? = call CHECK_LATE (?,?)}");
	cstmt.registerOutParameter (1, java.sql.Types.CHAR);
	cstmt.setInt (2, customerID);
	cstmt.setInt (3, accountID);
	cstmt.execute ();
	if (cstmt.getString(1).trim().equals("true")) { late = true; periodStatus = "LATE"; }
	else { late = false; periodStatus = "NORMAL"; }

	if (late) { ivjJCheckBox1.setSelected(true); }
	else { ivjJCheckBox1.setSelected(false); }

	cstmt = aBankerOption.conn.prepareCall ("{? = call GET_NUM_LATE (?,?)}");
	cstmt.registerOutParameter (1, java.sql.Types.INTEGER);
	cstmt.setInt (2, customerID);
	cstmt.setInt (3, accountID);
	cstmt.execute ();
	amountDay = cstmt.getInt(1);
	if (amountDay == 0) { ivjJLabel15.setText(""); }
	else { ivjJLabel15.setText(Integer.toString(amountDay)); }
	
	rset = stmt.executeQuery ("select Period_Num,Balance_Due from Cash_Per_Month where customer_id = " 
		                      + customerID + " and pay_date >= all(select pay_date from cash_per_month where customer_id = "
		                      + customerID + ")");
	if (rset.next ())
	{ 
		lastPeriodNum = rset.getInt(1); 
		balanceDue = Double.valueOf(rset.getString(2)).doubleValue();
	}
	else
	{
		lastPeriodNum = 0;
		balanceDue = 0;
	}
	if (lastPeriodNum == 0) { ivjJLabel71.setText(""); }
	else { ivjJLabel71.setText(Integer.toString(lastPeriodNum)); }
	if (balanceDue == 0) { ivjJLabel23.setText(""); }
	else { ivjJLabel23.setText(Double.toString(balanceDue)); }

	rset = stmt.executeQuery ("select Const_Paid,Amount from Loanaccount where account_id = "+accountID);
	if (rset.next ())
	{ 
		constPaid = rset.getInt(1); 
		if (balanceDue == 0) 
		{ 
			balanceDue = rset.getDouble(2);
			ivjJLabel23.setText(Double.toString(balanceDue));
		}
	}
	else { return; }
		
	cstmt = aBankerOption.conn.prepareCall ("{? = call GET_LOW_PAYMENT (?,?,?,?,?,?,?)}");
	cstmt.registerOutParameter (1, java.sql.Types.INTEGER);
	cstmt.setInt (2, customerID);
	cstmt.setInt (3, accountID);
	cstmt.setDouble (4, balanceDue);
	cstmt.setDouble (5, interestRate);
	cstmt.setDouble (6, lateIntRate);
	cstmt.setString (7, lastPaidDate);
	cstmt.setInt (8, constPaid);
	cstmt.execute ();
	lowPayment = cstmt.getInt(1);
	if (lowPayment == 0) { ivjJLabel11.setText(""); }
	else { ivjJLabel11.setText(Integer.toString(lowPayment)); }
	
	periodNum = lastPeriodNum + 1;
	ivjJLabel7.setText(Integer.toString(periodNum));

	cstmt = aBankerOption.conn.prepareCall ("{? = call GET_INT_PAID (?,?,?,?,?)}");
	cstmt.registerOutParameter (1, java.sql.Types.CHAR);
	cstmt.setDouble (2, balanceDue);
	cstmt.setDouble (3, interestRate);
	cstmt.setDouble (4, lateIntRate);
	cstmt.setString (5, lastPaidDate);
	if (late) { cstmt.setString (6, "true"); }
	else { cstmt.setString (6, "false"); }
	cstmt.execute ();
	intPaid = Double.valueOf(cstmt.getString(1)).doubleValue();
		
	cstmt = aBankerOption.conn.prepareCall ("{? = call GET_LATE_INT_PAID (?,?,?,?,?)}");
	cstmt.registerOutParameter (1, java.sql.Types.CHAR);
	cstmt.setDouble (2, balanceDue);
	cstmt.setDouble (3, interestRate);
	cstmt.setDouble (4, lateIntRate);
	cstmt.setString (5, lastPaidDate);
	if (late) { cstmt.setString (6, "true"); }
	else { cstmt.setString (6, "false"); }
	cstmt.execute ();
	lateIntPaid = Double.valueOf(cstmt.getString(1)).doubleValue();

	if (amountDay > 90)
	{
		customerStatus = "ACQUIRE";
		updateCustomerStatus();
	}
	return;
}
/**
 * This method was created in VisualAge.
 */
public void showForm() {
	getJFrame1().show();
	try 
	{
	   initialPaymentForm();
	}
	catch (Throwable exception) { handleException(exception); }
}
/**
 * This method was created in VisualAge.
 */
public void showRecordPaymentForm() {
	getJDialog1().show();

	ivjJLabel28.setText("");
	ivjJLabel30.setText(Integer.toString(customerID));
	ivjJLabel32.setText(customerName);
	ivjJLabel34.setText(Integer.toString(periodNum));
	ivjJLabel36.setText(Integer.toString(cashMoney));
	ivjJLabel42.setText(Double.toString(principalPaid).trim());
	ivjJLabel421.setText(Double.toString(intPaid).trim());
	ivjJLabel422.setText(Double.toString(lateIntPaid).trim());
	ivjJLabel44.setText(Double.toString(balanceDue).trim());
	ivjJLabel46.setText(periodStatus);
	ivjJLabel48.setText(aBankerOption.today);
	ivjJLabel50.setText(aBankerOption.bankerName);
	
	return;
}
/**
 * This method was created in VisualAge.
 */
public void updateCustomerStatus() {
	try
	{
		aBankerOption.conn.commit();
		java.sql.Statement stmt = aBankerOption.conn.createStatement ();

		stmt.executeUpdate ("update Customer set Payment_Status = 'ACQUIRE' where Customer_id = "+customerID);

		aBankerOption.conn.commit();

		ivjJLabel5.setForeground(java.awt.Color.red);
		ivjJLabel5.setText(customerStatus);
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