package Banking;

/**
 * This type was created in VisualAge.
 */
public class SampleForm implements java.awt.event.ActionListener, java.awt.event.WindowListener {
	private com.sun.java.swing.JButton ivjJButton1 = null;
	private com.sun.java.swing.JButton ivjJButton2 = null;
	private com.sun.java.swing.JButton ivjJButton3 = null;
	private com.sun.java.swing.JButton ivjJButton4 = null;
	private com.sun.java.swing.JFrame ivjJFrame1 = null;
	private com.sun.java.swing.JPanel ivjJFrameContentPane = null;
	private com.sun.java.swing.JLabel ivjJLabel1 = null;
	private com.sun.java.swing.JLabel ivjJLabel10 = null;
	private com.sun.java.swing.JLabel ivjJLabel11 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel3 = null;
	private com.sun.java.swing.JLabel ivjJLabel4 = null;
	private com.sun.java.swing.JLabel ivjJLabel5 = null;
	private com.sun.java.swing.JLabel ivjJLabel6 = null;
	private com.sun.java.swing.JLabel ivjJLabel61 = null;
	private com.sun.java.swing.JLabel ivjJLabel611 = null;
	private com.sun.java.swing.JLabel ivjJLabel62 = null;
	private com.sun.java.swing.JLabel ivjJLabel7 = null;
	private com.sun.java.swing.JLabel ivjJLabel8 = null;
	private com.sun.java.swing.JLabel ivjJLabel9 = null;
	private com.sun.java.swing.JRadioButton ivjJRadioButton1 = null;
	private com.sun.java.swing.JRadioButton ivjJRadioButton10 = null;
	private com.sun.java.swing.JRadioButton ivjJRadioButton11 = null;
	private com.sun.java.swing.JRadioButton ivjJRadioButton12 = null;
	private com.sun.java.swing.JTextField ivjJTextField1 = null;
	private com.sun.java.swing.JTextField ivjJTextField2 = null;
	private com.sun.java.swing.JButton ivjJButton5 = null;
	private com.sun.java.swing.ButtonGroup buttonGroup = null;
	private BankerOption aBankerOption = null;
	private NewLoanForm aNewLoanForm = null;
	private double interestRate = 0;
	private int totalSalary = 0;
	private int maxLoan = 0;
	private int loanMoney = 0;
	private int periodType = 5;
	private int constantPaid = 0;
	private int multipleLoan = 0;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public SampleForm() {
	super();
	initialize();
}
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public SampleForm(BankerOption aaBankerOption) {
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
	if ((e.getSource() == getJButton4()) ) {
		connEtoC1();
	}
	if ((e.getSource() == getJButton1()) ) {
		connEtoC4();
	}
	if ((e.getSource() == getJButton2()) ) {
		connEtoC5();
	}
	if ((e.getSource() == getJRadioButton1()) ) {
		connEtoC6();
	}
	if ((e.getSource() == getJRadioButton10()) ) {
		connEtoC7();
	}
	if ((e.getSource() == getJRadioButton11()) ) {
		connEtoC8();
	}
	if ((e.getSource() == getJRadioButton12()) ) {
		connEtoC9();
	}
	if ((e.getSource() == getJButton3()) ) {
		connEtoC10();
	}
	if ((e.getSource() == getJButton5()) ) {
		connEtoC11();
	}
	// user code begin {2}
	// user code end
}
/**
 * Comment
 */
public void calConstPaid() throws java.sql.SQLException {
	double factor,temploan = 0;
	loanMoney = Integer.parseInt(ivjJTextField2.getText());

	java.sql.CallableStatement cstmt = aBankerOption.conn.prepareCall ("{? = call GET_FACTOR (?,?)}");
	cstmt.registerOutParameter (1, java.sql.Types.DOUBLE);
	cstmt.setDouble(2, interestRate);
	cstmt.setInt (3, periodType);

	cstmt.execute ();
	factor = cstmt.getDouble(1);

	temploan = factor * loanMoney;				// temploan is temp variable //
	temploan = temploan * (1 + 0.1);			// const = temp + (10% of temp) //
	constantPaid = (int) temploan;				// truncation of Double to Integer //	
	
	ivjJLabel11.setText(Integer.toString(constantPaid));
	return;
}
/**
 * Comment
 */
public void calMaxLoan() throws java.sql.SQLException {
	java.sql.CallableStatement cstmt = aBankerOption.conn.prepareCall ("{? = call GET_MAX_LOAN()}");
	cstmt.registerOutParameter (1, java.sql.Types.INTEGER);
	cstmt.execute ();
	
	multipleLoan = cstmt.getInt(1);
	totalSalary = Integer.parseInt(ivjJTextField1.getText());
	maxLoan = totalSalary * multipleLoan;
	
	ivjJLabel5.setText(Integer.toString(maxLoan));
	return;
}
/**
 * Comment
 */
public void clearSampleForm() {
	totalSalary = 0;
	maxLoan = 0;
	loanMoney = 0;
	periodType = 5;
	constantPaid = 0;
	multipleLoan = 0;

	ivjJTextField1.setText("");
	ivjJTextField2.setText("");
	ivjJLabel5.setText("");
	ivjJLabel11.setText("");
	
	ivjJRadioButton1.setSelected(true);
	ivjJRadioButton10.setSelected(false);
	ivjJRadioButton11.setSelected(false);
	ivjJRadioButton12.setSelected(false);
	return;
}
/**
 * connEtoC1:  (JButton4.action. --> SampleForm.exitForm()V)
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
 * connEtoC10:  (JButton3.action. --> SampleForm.clearSampleForm()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC10() {
	try {
		// user code begin {1}
		// user code end
		this.clearSampleForm();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC11:  (JButton5.action. --> SampleForm.gotoLoan()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC11() {
	try {
		// user code begin {1}
		// user code end
		this.gotoLoan();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC2:  (JFrame1.window.windowClosed(java.awt.event.WindowEvent) --> SampleForm.exitForm()V)
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
 * connEtoC3:  (SampleForm.initialize() --> SampleForm.showInterestRate()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3() {
	try {
		// user code begin {1}
		// user code end
		this.showInterestRate();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC4:  (JButton1.action. --> SampleForm.calMaxLoan()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC4() {
	try {
		// user code begin {1}
		// user code end
		this.calMaxLoan();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC5:  (JButton2.action. --> SampleForm.calConstPaid()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC5() {
	try {
		// user code begin {1}
		// user code end
		this.calConstPaid();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC6:  (JRadioButton1.action. --> SampleForm.setType5()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC6() {
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
 * connEtoC7:  (JRadioButton10.action. --> SampleForm.setType10()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC7() {
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
 * connEtoC8:  (JRadioButton11.action. --> SampleForm.setType15()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC8() {
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
 * connEtoC9:  (JRadioButton12.action. --> SampleForm.setType20()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC9() {
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
			ivjJButton1.setText("Maximum Loan");
			ivjJButton1.setBounds(21, 75, 127, 25);
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
			ivjJButton2.setText("Constant Paid");
			ivjJButton2.setBounds(20, 204, 128, 25);
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
			ivjJButton3.setText("Clear");
			ivjJButton3.setBounds(236, 282, 85, 25);
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
			ivjJButton4.setText("Exit");
			ivjJButton4.setBounds(338, 282, 85, 25);
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
			ivjJButton5.setText("Goto Loan");
			ivjJButton5.setBackground(java.awt.Color.red);
			ivjJButton5.setBounds(23, 279, 94, 25);
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
			ivjJFrame1.setBounds(62, 30, 449, 350);
			ivjJFrame1.setTitle("Sample Form");
			getJFrame1().setContentPane(getJFrameContentPane());
			// user code begin {1}
			aBankerOption.showCenter(ivjJFrame1);

 			buttonGroup = new com.sun.java.swing.ButtonGroup();
			buttonGroup.add(ivjJRadioButton1);
			buttonGroup.add(ivjJRadioButton10);
			buttonGroup.add(ivjJRadioButton11);
			buttonGroup.add(ivjJRadioButton12);
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
			getJFrameContentPane().add(getJTextField1(), getJTextField1().getName());
			getJFrameContentPane().add(getJButton1(), getJButton1().getName());
			getJFrameContentPane().add(getJLabel4(), getJLabel4().getName());
			getJFrameContentPane().add(getJLabel5(), getJLabel5().getName());
			getJFrameContentPane().add(getJLabel6(), getJLabel6().getName());
			getJFrameContentPane().add(getJLabel7(), getJLabel7().getName());
			getJFrameContentPane().add(getJLabel8(), getJLabel8().getName());
			getJFrameContentPane().add(getJTextField2(), getJTextField2().getName());
			getJFrameContentPane().add(getJLabel61(), getJLabel61().getName());
			getJFrameContentPane().add(getJLabel62(), getJLabel62().getName());
			getJFrameContentPane().add(getJLabel9(), getJLabel9().getName());
			getJFrameContentPane().add(getJRadioButton1(), getJRadioButton1().getName());
			getJFrameContentPane().add(getJRadioButton11(), getJRadioButton11().getName());
			getJFrameContentPane().add(getJRadioButton12(), getJRadioButton12().getName());
			getJFrameContentPane().add(getJRadioButton10(), getJRadioButton10().getName());
			getJFrameContentPane().add(getJButton2(), getJButton2().getName());
			getJFrameContentPane().add(getJLabel10(), getJLabel10().getName());
			getJFrameContentPane().add(getJLabel11(), getJLabel11().getName());
			getJFrameContentPane().add(getJLabel611(), getJLabel611().getName());
			getJFrameContentPane().add(getJButton3(), getJButton3().getName());
			getJFrameContentPane().add(getJButton4(), getJButton4().getName());
			getJFrameContentPane().add(getJButton5(), getJButton5().getName());
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
			ivjJLabel1.setText("Interest Rate");
			ivjJLabel1.setBounds(21, 16, 77, 15);
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
			ivjJLabel10.setText("Constant Paid Per Month = ");
			ivjJLabel10.setBounds(20, 245, 156, 15);
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
			ivjJLabel11.setBounds(180, 246, 71, 15);
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
 * Return the JLabel2 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel2() {
	if (ivjJLabel2 == null) {
		try {
			ivjJLabel2 = new com.sun.java.swing.JLabel();
			ivjJLabel2.setName("JLabel2");
			ivjJLabel2.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel2.setText("");
			ivjJLabel2.setBounds(104, 16, 45, 15);
			ivjJLabel2.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
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
			ivjJLabel3.setText("Total Salary");
			ivjJLabel3.setBounds(21, 45, 75, 15);
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
			ivjJLabel4.setText("Maximum Loan Money = ");
			ivjJLabel4.setBounds(20, 115, 142, 15);
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
			ivjJLabel5.setBounds(167, 116, 96, 15);
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
			ivjJLabel6.setText("Baht");
			ivjJLabel6.setBounds(273, 116, 45, 15);
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
 * Return the JLabel61 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel61() {
	if (ivjJLabel61 == null) {
		try {
			ivjJLabel61 = new com.sun.java.swing.JLabel();
			ivjJLabel61.setName("JLabel61");
			ivjJLabel61.setText("Baht");
			ivjJLabel61.setBounds(207, 145, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel61;
}
/**
 * Return the JLabel611 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel611() {
	if (ivjJLabel611 == null) {
		try {
			ivjJLabel611 = new com.sun.java.swing.JLabel();
			ivjJLabel611.setName("JLabel611");
			ivjJLabel611.setText("Baht");
			ivjJLabel611.setBounds(263, 246, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel611;
}
/**
 * Return the JLabel62 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel62() {
	if (ivjJLabel62 == null) {
		try {
			ivjJLabel62 = new com.sun.java.swing.JLabel();
			ivjJLabel62.setName("JLabel62");
			ivjJLabel62.setText("Baht");
			ivjJLabel62.setBounds(201, 46, 45, 15);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJLabel62;
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
			ivjJLabel7.setText("%");
			ivjJLabel7.setBounds(160, 17, 18, 15);
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
			ivjJLabel8.setText("Loan Money");
			ivjJLabel8.setBounds(20, 145, 73, 15);
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
			ivjJLabel9.setBounds(20, 177, 74, 15);
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
			ivjJRadioButton1.setText("5 years");
			ivjJRadioButton1.setBounds(113, 175, 64, 22);
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
 * Return the JRadioButton10 property value.
 * @return com.sun.java.swing.JRadioButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JRadioButton getJRadioButton10() {
	if (ivjJRadioButton10 == null) {
		try {
			ivjJRadioButton10 = new com.sun.java.swing.JRadioButton();
			ivjJRadioButton10.setName("JRadioButton10");
			ivjJRadioButton10.setText("10 years");
			ivjJRadioButton10.setBounds(185, 176, 73, 22);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJRadioButton10;
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
			ivjJRadioButton11.setText("15 years");
			ivjJRadioButton11.setBounds(267, 176, 73, 22);
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
			ivjJRadioButton12.setText("20 years");
			ivjJRadioButton12.setBounds(349, 176, 73, 22);
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
 * Return the JTextField1 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField1() {
	if (ivjJTextField1 == null) {
		try {
			ivjJTextField1 = new com.sun.java.swing.JTextField();
			ivjJTextField1.setName("JTextField1");
			ivjJTextField1.setBounds(101, 44, 87, 19);
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
 * Return the JTextField2 property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getJTextField2() {
	if (ivjJTextField2 == null) {
		try {
			ivjJTextField2 = new com.sun.java.swing.JTextField();
			ivjJTextField2.setName("JTextField2");
			ivjJTextField2.setBounds(103, 143, 92, 19);
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
 * Comment
 */
public void gotoLoan() {
	ivjJFrame1.setVisible(false);
	
	aBankerOption.showNewLoanForm();

	aNewLoanForm = aBankerOption.aNewLoanForm;
	aNewLoanForm.parameterOfNewLoan(totalSalary,loanMoney,periodType,constantPaid);
	return;
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
	getJButton4().addActionListener(this);
	getJFrame1().addWindowListener(this);
	getJButton1().addActionListener(this);
	getJButton2().addActionListener(this);
	getJRadioButton1().addActionListener(this);
	getJRadioButton10().addActionListener(this);
	getJRadioButton11().addActionListener(this);
	getJRadioButton12().addActionListener(this);
	getJButton3().addActionListener(this);
	getJButton5().addActionListener(this);
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
	// user code end
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		SampleForm aSampleForm;
		aSampleForm = new SampleForm();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
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
	clearSampleForm();
}
/**
 * Comment
 */
public void showInterestRate() throws java.sql.SQLException {
	java.sql.CallableStatement cstmt = aBankerOption.conn.prepareCall ("{? = call GET_CURRENT_INT()}");
	cstmt.registerOutParameter (1, java.sql.Types.DOUBLE);
	cstmt.execute ();
	
	interestRate = cstmt.getDouble(1);
	
	ivjJLabel2.setText(java.lang.Double.toString(interestRate));
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