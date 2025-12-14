package Banking;

/**
 * This type was created in VisualAge.
 */
public class NewLoanForm implements java.awt.event.ActionListener, java.awt.event.WindowListener {
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
	private com.sun.java.swing.JLabel ivjJLabel18 = null;
	private com.sun.java.swing.JLabel ivjJLabel19 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel20 = null;
	private com.sun.java.swing.JLabel ivjJLabel21 = null;
	private com.sun.java.swing.JLabel ivjJLabel22 = null;
	private com.sun.java.swing.JLabel ivjJLabel23 = null;
	private com.sun.java.swing.JLabel ivjJLabel24 = null;
	private com.sun.java.swing.JLabel ivjJLabel3 = null;
	private com.sun.java.swing.JLabel ivjJLabel4 = null;
	private com.sun.java.swing.JLabel ivjJLabel5 = null;
	private com.sun.java.swing.JLabel ivjJLabel6 = null;
	private com.sun.java.swing.JLabel ivjJLabel7 = null;
	private com.sun.java.swing.JLabel ivjJLabel8 = null;
	private com.sun.java.swing.JLabel ivjJLabel9 = null;
	private com.sun.java.swing.JLabel ivjJLabel91 = null;
	private com.sun.java.swing.JLabel ivjJLabel911 = null;
	private com.sun.java.swing.JLabel ivjJLabel9111 = null;
	private com.sun.java.swing.JRadioButton ivjJRadioButton1 = null;
	private com.sun.java.swing.JRadioButton ivjJRadioButton11 = null;
	private com.sun.java.swing.JRadioButton ivjJRadioButton12 = null;
	private com.sun.java.swing.JRadioButton ivjJRadioButton13 = null;
	private com.sun.java.swing.JTextField ivjJTextField1 = null;
	private com.sun.java.swing.JTextField ivjJTextField10 = null;
	private com.sun.java.swing.JTextField ivjJTextField11 = null;
	private com.sun.java.swing.JTextField ivjJTextField12 = null;
	private com.sun.java.swing.JTextField ivjJTextField2 = null;
	private com.sun.java.swing.JTextField ivjJTextField3 = null;
	private com.sun.java.swing.JTextField ivjJTextField4 = null;
	private com.sun.java.swing.JTextField ivjJTextField5 = null;
	private com.sun.java.swing.JTextField ivjJTextField6 = null;
	private com.sun.java.swing.JTextField ivjJTextField7 = null;
	private com.sun.java.swing.JTextField ivjJTextField8 = null;
	private com.sun.java.swing.JTextField ivjJTextField9 = null;
	private com.sun.java.swing.ButtonGroup buttonGroup = null;
	private BankerOption aBankerOption = null;
	private int customerID = 0;
	private String customerName = null;
	private String address = null;
	private int salary = 0;
	private int amountLoan = 0;
	private int periodType = 5;
	private double interestRate = 0;
	private int constantPaid = 0;
	private String houseName = null;
	private String province = null;
	private int area = 0;
	private int price = 0;
	private int landID = 0;
	private String owner = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public NewLoanForm() {
	super();
	initialize();
}
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public NewLoanForm(BankerOption aaBankerOption) {
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
		connEtoC4();
	}
	if ((e.getSource() == getJRadioButton1()) ) {
		connEtoC3();
	}
	if ((e.getSource() == getJRadioButton11()) ) {
		connEtoC5();
	}
	if ((e.getSource() == getJRadioButton12()) ) {
		connEtoC6();
	}
	if ((e.getSource() == getJRadioButton13()) ) {
		connEtoC7();
	}
	// user code begin {2}
	// user code end
}
/**
 * connEtoC1:  (JButton2.action. --> CustomerForm.exitForm()V)
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
 * connEtoC2:  (JFrame1.window.windowClosed(java.awt.event.WindowEvent) --> CustomerForm.exitForm()V)
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
 * connEtoC3:  (JRadioButton1.action. --> NewLoanForm.setType5()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3() {
	try {
		// user code begin {1}
		// user code end
		this.setType5();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC4:  (JButton1.action. --> NewLoanForm.recordNewLoan()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC4() {
	try {
		// user code begin {1}
		// user code end
		this.recordNewLoan();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC5:  (JRadioButton11.action. --> NewLoanForm.setType10()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC5() {
	try {
		// user code begin {1}
		// user code end
		this.setType10();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC6:  (JRadioButton12.action. --> NewLoanForm.setType15()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC6() {
	try {
		// user code begin {1}
		// user code end
		this.setType15();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC7:  (JRadioButton13.action. --> NewLoanForm.setType20()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC7() {
	try {
		// user code begin {1}
		// user code end
		this.setType20();
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
			ivjJButton1.setText("Record");
			ivjJButton1.setBounds(307, 351, 85, 25);
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
			ivjJButton2.setBounds(403, 351, 85, 25);
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
			ivjJFrame1.setBounds(65, 35, 518, 428);
			ivjJFrame1.setTitle("New Loan Form");
			getJFrame1().setContentPane(getJFrameContentPane());
			// user code begin {1}
			aBankerOption.showCenter(ivjJFrame1);

 			buttonGroup = new com.sun.java.swing.ButtonGroup();
			buttonGroup.add(ivjJRadioButton1);
			buttonGroup.add(ivjJRadioButton11);
			buttonGroup.add(ivjJRadioButton12);
			buttonGroup.add(ivjJRadioButton13);
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
			getJFrameContentPane().add(getJLabel2(), getJLabel2().getName());
			getJFrameContentPane().add(getJLabel3(), getJLabel3().getName());
			getJFrameContentPane().add(getJLabel4(), getJLabel4().getName());
			getJFrameContentPane().add(getJLabel5(), getJLabel5().getName());
			getJFrameContentPane().add(getJLabel6(), getJLabel6().getName());
			getJFrameContentPane().add(getJTextField1(), getJTextField1().getName());
			getJFrameContentPane().add(getJTextField2(), getJTextField2().getName());
			getJFrameContentPane().add(getJLabel7(), getJLabel7().getName());
			getJFrameContentPane().add(getJTextField3(), getJTextField3().getName());
			getJFrameContentPane().add(getJLabel8(), getJLabel8().getName());
			getJFrameContentPane().add(getJTextField4(), getJTextField4().getName());
			getJFrameContentPane().add(getJLabel9(), getJLabel9().getName());
			getJFrameContentPane().add(getJLabel10(), getJLabel10().getName());
			getJFrameContentPane().add(getJTextField5(), getJTextField5().getName());
			getJFrameContentPane().add(getJLabel91(), getJLabel91().getName());
			getJFrameContentPane().add(getJLabel11(), getJLabel11().getName());
			getJFrameContentPane().add(getJRadioButton1(), getJRadioButton1().getName());
			getJFrameContentPane().add(getJRadioButton11(), getJRadioButton11().getName());
			getJFrameContentPane().add(getJRadioButton12(), getJRadioButton12().getName());
			getJFrameContentPane().add(getJRadioButton13(), getJRadioButton13().getName());
			getJFrameContentPane().add(getJLabel12(), getJLabel12().getName());
			getJFrameContentPane().add(getJLabel13(), getJLabel13().getName());
			getJFrameContentPane().add(getJLabel14(), getJLabel14().getName());
			getJFrameContentPane().add(getJLabel15(), getJLabel15().getName());
			getJFrameContentPane().add(getJTextField6(), getJTextField6().getName());
			getJFrameContentPane().add(getJLabel911(), getJLabel911().getName());
			getJFrameContentPane().add(getJLabel16(), getJLabel16().getName());
			getJFrameContentPane().add(getJLabel17(), getJLabel17().getName());
			getJFrameContentPane().add(getJLabel18(), getJLabel18().getName());
			getJFrameContentPane().add(getJTextField7(), getJTextField7().getName());
			getJFrameContentPane().add(getJLabel19(), getJLabel19().getName());
			getJFrameContentPane().add(getJTextField8(), getJTextField8().getName());
			getJFrameContentPane().add(getJLabel20(), getJLabel20().getName());
			getJFrameContentPane().add(getJTextField9(), getJTextField9().getName());
			getJFrameContentPane().add(getJLabel21(), getJLabel21().getName());
			getJFrameContentPane().add(getJLabel22(), getJLabel22().getName());
			getJFrameContentPane().add(getJTextField10(), getJTextField10().getName());
			getJFrameContentPane().add(getJLabel23(), getJLabel23().getName());
			getJFrameContentPane().add(getJLabel9111(), getJLabel9111().getName());
			getJFrameContentPane().add(getJTextField11(), getJTextField11().getName());
			getJFrameContentPane().add(getJLabel24(), getJLabel24().getName());
			getJFrameContentPane().add(getJTextField12(), getJTextField12().getName());
			getJFrameContentPane().add(getJButton1(), getJButton1().getName());
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
			ivjJLabel1.setBounds(19, 19, 76, 15);
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
			ivjJLabel10.setText("Amount Loan");
			ivjJLabel10.setBounds(201, 103, 83, 15);
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
			ivjJLabel11.setText("Period Type");
			ivjJLabel11.setBounds(19, 132, 74, 15);
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
			ivjJLabel12.setBounds(19, 161, 109, 15);
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
			ivjJLabel13.setBounds(135, 160, 52, 15);
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
			ivjJLabel14.setBounds(196, 160, 19, 15);
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
			ivjJLabel15.setBounds(19, 188, 87, 15);
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
			ivjJLabel16.setText("Banker Name");
			ivjJLabel16.setBounds(21, 356, 83, 15);
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
			ivjJLabel17.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel17.setText("");
			ivjJLabel17.setBounds(110, 356, 177, 15);
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
			ivjJLabel18.setText("House Project Name");
			ivjJLabel18.setBounds(19, 218, 121, 15);
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
			ivjJLabel19.setText("Province");
			ivjJLabel19.setBounds(19, 248, 56, 15);
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
			ivjJLabel2.setText("Date");
			ivjJLabel2.setBounds(354, 18, 34, 15);
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
			ivjJLabel20.setText("Area");
			ivjJLabel20.setBounds(233, 247, 34, 15);
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
			ivjJLabel21.setText("m x m");
			ivjJLabel21.setBounds(337, 248, 38, 15);
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
			ivjJLabel22.setText("Price");
			ivjJLabel22.setBounds(20, 276, 38, 15);
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
			ivjJLabel23.setText("Land ID");
			ivjJLabel23.setBounds(233, 276, 52, 15);
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
			ivjJLabel24.setText("Owner");
			ivjJLabel24.setBounds(20, 305, 44, 15);
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
			ivjJLabel3.setBounds(388, 19, 92, 15);
			ivjJLabel3.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel4.setBounds(101, 18, 56, 15);
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
			ivjJLabel5.setText("Name");
			ivjJLabel5.setBounds(19, 47, 40, 15);
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
			ivjJLabel6.setText("Surname");
			ivjJLabel6.setBounds(176, 47, 56, 15);
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
			ivjJLabel7.setText("Address");
			ivjJLabel7.setBounds(18, 76, 55, 15);
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
			ivjJLabel8.setText("Salary");
			ivjJLabel8.setBounds(19, 104, 45, 15);
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
			ivjJLabel9.setText("Baht");
			ivjJLabel9.setBounds(149, 103, 45, 15);
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
			ivjJLabel91.setText("Baht");
			ivjJLabel91.setBounds(387, 102, 45, 15);
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
 * Return the JLabel911 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel911() {
	if (ivjJLabel911 == null) {
		try {
			ivjJLabel911 = new com.sun.java.swing.JLabel();
			ivjJLabel911.setName("JLabel911");
			ivjJLabel911.setText("Baht");
			ivjJLabel911.setBounds(198, 186, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel911;
}
/**
 * Return the JLabel9111 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel9111() {
	if (ivjJLabel9111 == null) {
		try {
			ivjJLabel9111 = new com.sun.java.swing.JLabel();
			ivjJLabel9111.setName("JLabel9111");
			ivjJLabel9111.setText("Baht");
			ivjJLabel9111.setBounds(175, 275, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel9111;
}
/**
 * Return the JRadioButton1 property value.
 * @return com.sun.java.swing.JRadioButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JRadioButton getJRadioButton1() {
	if (ivjJRadioButton1 == null) {
		try {
			ivjJRadioButton1 = new com.sun.java.swing.JRadioButton();
			ivjJRadioButton1.setName("JRadioButton1");
			ivjJRadioButton1.setSelected(true);
			ivjJRadioButton1.setText("5 year");
			ivjJRadioButton1.setBounds(97, 130, 66, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJRadioButton1;
}
/**
 * Return the JRadioButton11 property value.
 * @return com.sun.java.swing.JRadioButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JRadioButton getJRadioButton11() {
	if (ivjJRadioButton11 == null) {
		try {
			ivjJRadioButton11 = new com.sun.java.swing.JRadioButton();
			ivjJRadioButton11.setName("JRadioButton11");
			ivjJRadioButton11.setText("10 year");
			ivjJRadioButton11.setBounds(167, 130, 66, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJRadioButton11;
}
/**
 * Return the JRadioButton12 property value.
 * @return com.sun.java.swing.JRadioButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JRadioButton getJRadioButton12() {
	if (ivjJRadioButton12 == null) {
		try {
			ivjJRadioButton12 = new com.sun.java.swing.JRadioButton();
			ivjJRadioButton12.setName("JRadioButton12");
			ivjJRadioButton12.setText("15 year");
			ivjJRadioButton12.setBounds(240, 130, 66, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJRadioButton12;
}
/**
 * Return the JRadioButton13 property value.
 * @return com.sun.java.swing.JRadioButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JRadioButton getJRadioButton13() {
	if (ivjJRadioButton13 == null) {
		try {
			ivjJRadioButton13 = new com.sun.java.swing.JRadioButton();
			ivjJRadioButton13.setName("JRadioButton13");
			ivjJRadioButton13.setText("20 year");
			ivjJRadioButton13.setBounds(309, 130, 66, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJRadioButton13;
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
			ivjJTextField1.setBounds(64, 46, 93, 19);
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
			ivjJTextField10.setBounds(63, 273, 100, 19);
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
 * Return the JTextField11 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField11() {
	if (ivjJTextField11 == null) {
		try {
			ivjJTextField11 = new com.sun.java.swing.JTextField();
			ivjJTextField11.setName("JTextField11");
			ivjJTextField11.setBounds(286, 274, 91, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField11;
}
/**
 * Return the JTextField12 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField12() {
	if (ivjJTextField12 == null) {
		try {
			ivjJTextField12 = new com.sun.java.swing.JTextField();
			ivjJTextField12.setName("JTextField12");
			ivjJTextField12.setBounds(69, 303, 143, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJTextField12;
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
			ivjJTextField2.setBounds(240, 45, 101, 19);
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
			ivjJTextField3.setBounds(80, 72, 310, 19);
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
			ivjJTextField4.setBounds(68, 102, 72, 19);
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
			ivjJTextField5.setBounds(288, 100, 89, 19);
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
			ivjJTextField6.setBounds(109, 185, 78, 19);
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
			ivjJTextField7.setBounds(147, 215, 167, 19);
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
			ivjJTextField8.setBounds(82, 246, 112, 19);
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
			ivjJTextField9.setBounds(272, 245, 52, 19);
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
	getJButton2().addActionListener(this);
	getJFrame1().addWindowListener(this);
	getJButton1().addActionListener(this);
	getJRadioButton1().addActionListener(this);
	getJRadioButton11().addActionListener(this);
	getJRadioButton12().addActionListener(this);
	getJRadioButton13().addActionListener(this);
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
public void initialNewLoanForm() throws java.sql.SQLException {
	customerID = 0;
	customerName = null;
	address = null;
	salary = 0;
	amountLoan = 0;
	periodType = 5;
	constantPaid = 0;
	houseName = null;
	province = null;
	area = 0;
	price = 0;
	landID = 0;
	owner = null;
	
	ivjJLabel3.setText(aBankerOption.today);
	ivjJLabel17.setText(aBankerOption.bankerName);

	ivjJLabel4.setText("");
	ivjJTextField1.setText("");
	ivjJTextField2.setText("");
	ivjJTextField3.setText("");
	ivjJTextField4.setText("");
	ivjJTextField5.setText("");
	ivjJTextField6.setText("");
	ivjJTextField7.setText("");
	ivjJTextField8.setText("");
	ivjJTextField9.setText("");
	ivjJTextField10.setText("");
	ivjJTextField11.setText("");
	ivjJTextField12.setText("");

	ivjJRadioButton1.setSelected(true);
	ivjJRadioButton11.setSelected(false);
	ivjJRadioButton12.setSelected(false);
	ivjJRadioButton13.setSelected(false);
	
	java.sql.CallableStatement cstmt = aBankerOption.conn.prepareCall ("{? = call GET_CURRENT_INT()}");
	cstmt.registerOutParameter (1, java.sql.Types.DOUBLE);
	cstmt.execute ();
	
	interestRate = cstmt.getDouble(1);
	ivjJLabel13.setText(java.lang.Double.toString(interestRate));
	return;
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		NewLoanForm aNewLoanForm;
		aNewLoanForm = new NewLoanForm();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
/**
 * This method was created in VisualAge.
 */
public void parameterOfNewLoan(int totalSalary,int loanMoney,int period,int constant) {
	salary = totalSalary;
	amountLoan = loanMoney;
	periodType = period;
	constantPaid = constant;

	ivjJTextField4.setText(Integer.toString(salary));
	ivjJTextField5.setText(Integer.toString(amountLoan));
	switch (periodType)
	{
		case  5 : ivjJRadioButton1.setSelected(true);  periodType = 5;  break;
		case 10 : ivjJRadioButton11.setSelected(true); periodType = 10; break;
		case 15 : ivjJRadioButton12.setSelected(true); periodType = 15; break;
		case 20 : ivjJRadioButton13.setSelected(true); periodType = 20; break;
	}
	ivjJTextField6.setText(Integer.toString(constantPaid));
	return;	                           
}
/**
 * Comment
 */
public void recordNewLoan() {
	customerName = ivjJTextField1.getText() + " " + ivjJTextField2.getText();
	customerName = customerName.toUpperCase();

	address = ivjJTextField3.getText().toUpperCase();
	salary = Integer.parseInt(ivjJTextField4.getText());
	amountLoan = Integer.parseInt(ivjJTextField5.getText());

	constantPaid = Integer.parseInt(ivjJTextField6.getText());
	houseName = ivjJTextField7.getText().toUpperCase();
	province = ivjJTextField8.getText().toUpperCase();
	area = Integer.parseInt(ivjJTextField9.getText());
	price = Integer.parseInt(ivjJTextField10.getText());
	landID = Integer.parseInt(ivjJTextField11.getText());
	owner = ivjJTextField12.getText().toUpperCase();
	
	try
	{
		aBankerOption.conn.commit();
		
		java.sql.CallableStatement cstmt = aBankerOption.conn.prepareCall ("{call ADD_NEW_ACCOUNT(?,?,?,?,?)}");
		cstmt.setString(1, aBankerOption.branchName);
		cstmt.setInt (2, amountLoan);
		cstmt.setInt (3, periodType);
		cstmt.setInt (4, constantPaid);
		cstmt.setInt (5, aBankerOption.bankerID);
		cstmt.execute ();

		java.sql.Statement stmt = aBankerOption.conn.createStatement ();
		stmt.executeUpdate ("insert into HouseProject values(Project_ID.nextval,'"+houseName
							+"','"+province+"',"+area+","+price+","+landID+",'"+owner+"')");
	   
		stmt.executeUpdate ("insert into Customer values(Customer_ID.nextval,'"+customerName
	   						+"','"+address+"',"+salary+",'NORMAL',Account_ID.currval,Project_ID.currval)");
	
		java.sql.ResultSet rset = stmt.executeQuery ("select Customer_ID from Customer where Customer_ID >= ALL (select Customer_ID from Customer)");

		if (rset.next ())
		{ 
			customerID = rset.getInt(1); 
		 	ivjJLabel4.setText(Integer.toString(customerID));
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
public void setType10() {
	periodType = 10;
	return;
}
/**
 * Comment
 */
public void setType15() {
	periodType = 15;
	return;
}
/**
 * Comment
 */
public void setType20() {
	periodType = 20;
	return;
}
/**
 * Comment
 */
public void setType5() {
	periodType = 5;
	return;
}
/**
 * This method was created in VisualAge.
 */
public void showForm() {
	getJFrame1().show();
	try 
	{
	   initialNewLoanForm();
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