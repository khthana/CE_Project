package DBandGUI_Management;

import DBandGUI_Management.*;
import Project_Information.*;
import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class MainControl implements java.awt.event.ActionListener {
	// variable use in all part of system
	public int PRO_ID = 0;
	public int EMP_ID = 0;
	public boolean PASS = false;
	public CustomerGUI customerGUI;
	public Project_Management project_Management;
	private com.sun.java.swing.JFrame ivjFMainControl = null;
	private com.sun.java.swing.JPanel ivjJFrameContentPane = null;
	private com.sun.java.swing.JMenuBar ivjFMainControlJMenuBar = null;
	private com.sun.java.swing.JLabel ivjJLabel1 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel3 = null;
	private com.sun.java.swing.JMenu ivjJMenu1 = null;
	private com.sun.java.swing.JMenu ivjJMenu2 = null;
	private com.sun.java.swing.JMenu ivjJMenu3 = null;
	private com.sun.java.swing.JMenu ivjJMenu4 = null;
	private com.sun.java.swing.JButton ivjBCustomer = null;
	private com.sun.java.swing.JButton ivjBExit = null;
	private com.sun.java.swing.JButton ivjBProject = null;
	private com.sun.java.swing.JButton ivjBService = null;
	private com.sun.java.swing.JButton ivjBSummary = null;
	private com.sun.java.swing.JDialog ivjJDialog1 = null;
	private com.sun.java.swing.JPanel ivjJDialogContentPane = null;
	private com.sun.java.swing.JButton ivjJButton1 = null;
	private com.sun.java.swing.JButton ivjJButton2 = null;
	private com.sun.java.swing.JLabel ivjJLabel4 = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public MainControl() {
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
	if ((e.getSource() == getBProject()) ) {
		connEtoC1(e);
	}
	if ((e.getSource() == getBCustomer()) ) {
		connEtoC2(e);
	}
	if ((e.getSource() == getBExit()) ) {
		connEtoM1(e);
	}
	if ((e.getSource() == getJButton1()) ) {
		connEtoM2(e);
	}
	if ((e.getSource() == getJButton2()) ) {
		connEtoM3(e);
	}
	if ((e.getSource() == getJButton1()) ) {
		connEtoM4(e);
	}
	// user code begin {2}
	// user code end
}
/**
 * Comment
 */
public void bCustomer_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	customerGUI = new CustomerGUI();
	return;
}
/**
 * Comment
 */
public void bProject_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	project_Management = new Project_Management();
	return;
}
/**
 * connEtoC1:  (BProjectManage.action.actionPerformed(java.awt.event.ActionEvent) --> MainControl.jButton3_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC1(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.bProject_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC2:  (BCustomer.action.actionPerformed(java.awt.event.ActionEvent) --> MainControl.bCustomer_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC2(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.bCustomer_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM1:  (JButton5.action.actionPerformed(java.awt.event.ActionEvent) --> FMainControl.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM1(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getJDialog1().show();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM2:  (JButton1.action.actionPerformed(java.awt.event.ActionEvent) --> FMainControl.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM2(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getFMainControl().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM3:  (JButton2.action.actionPerformed(java.awt.event.ActionEvent) --> JDialog1.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM3(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getJDialog1().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM4:  (JButton1.action.actionPerformed(java.awt.event.ActionEvent) --> JDialog1.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM4(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getJDialog1().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * Return the JButton2 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBCustomer() {
	if (ivjBCustomer == null) {
		try {
			ivjBCustomer = new com.sun.java.swing.JButton();
			ivjBCustomer.setName("BCustomer");
			ivjBCustomer.setFont(new java.awt.Font("dialog", 1, 14));
			ivjBCustomer.setText("<<< Customer Management  >>>");
			ivjBCustomer.setBounds(250, 200, 300, 30);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBCustomer;
}
/**
 * Return the JButton5 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBExit() {
	if (ivjBExit == null) {
		try {
			ivjBExit = new com.sun.java.swing.JButton();
			ivjBExit.setName("BExit");
			ivjBExit.setFont(new java.awt.Font("dialog", 1, 14));
			ivjBExit.setText("Exit");
			ivjBExit.setBounds(250, 350, 300, 30);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBExit;
}
/**
 * Return the JButton3 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBProject() {
	if (ivjBProject == null) {
		try {
			ivjBProject = new com.sun.java.swing.JButton();
			ivjBProject.setName("BProject");
			ivjBProject.setFont(new java.awt.Font("dialog", 1, 14));
			ivjBProject.setText("Project Management");
			ivjBProject.setBounds(250, 250, 300, 30);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBProject;
}
/**
 * Return the JButton1 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBService() {
	if (ivjBService == null) {
		try {
			ivjBService = new com.sun.java.swing.JButton();
			ivjBService.setName("BService");
			ivjBService.setFont(new java.awt.Font("dialog", 1, 14));
			ivjBService.setText("XXX Service Management XXX");
			ivjBService.setBounds(250, 150, 300, 35);
			ivjBService.setVisible(true);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBService;
}
/**
 * Return the JButton4 property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBSummary() {
	if (ivjBSummary == null) {
		try {
			ivjBSummary = new com.sun.java.swing.JButton();
			ivjBSummary.setName("BSummary");
			ivjBSummary.setFont(new java.awt.Font("dialog", 1, 14));
			ivjBSummary.setText("XXX Project Summary XXX");
			ivjBSummary.setBounds(250, 300, 300, 30);
			ivjBSummary.setForeground(java.awt.Color.gray);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBSummary;
}
/**
 * Return the FMainControl property value.
 * @return com.sun.java.swing.JFrame
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JFrame getFMainControl() {
	if (ivjFMainControl == null) {
		try {
			ivjFMainControl = new com.sun.java.swing.JFrame();
			ivjFMainControl.setName("FMainControl");
			ivjFMainControl.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjFMainControl.setJMenuBar(getFMainControlJMenuBar());
			ivjFMainControl.setBounds(0, 0, 800, 570);
			ivjFMainControl.setTitle("Main Management");
			getFMainControl().setContentPane(getJFrameContentPane());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjFMainControl;
}
/**
 * Return the FMainControlJMenuBar property value.
 * @return com.sun.java.swing.JMenuBar
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuBar getFMainControlJMenuBar() {
	if (ivjFMainControlJMenuBar == null) {
		try {
			ivjFMainControlJMenuBar = new com.sun.java.swing.JMenuBar();
			ivjFMainControlJMenuBar.setName("FMainControlJMenuBar");
			ivjFMainControlJMenuBar.add(getJMenu1());
			ivjFMainControlJMenuBar.add(getJMenu2());
			ivjFMainControlJMenuBar.add(getJMenu3());
			ivjFMainControlJMenuBar.add(getJMenu4());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjFMainControlJMenuBar;
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
			ivjJButton1.setText("Yes");
			ivjJButton1.setBounds(60, 63, 85, 25);
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
			ivjJButton2.setText("No");
			ivjJButton2.setBounds(190, 63, 85, 25);
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
 * Return the JDialog1 property value.
 * @return com.sun.java.swing.JDialog
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JDialog getJDialog1() {
	if (ivjJDialog1 == null) {
		try {
			ivjJDialog1 = new com.sun.java.swing.JDialog();
			ivjJDialog1.setName("JDialog1");
			ivjJDialog1.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjJDialog1.setBounds(232, 230, 335, 140);
			ivjJDialog1.setTitle("Exit System");
			getJDialog1().setContentPane(getJDialogContentPane());
			// user code begin {1}
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
			getJDialogContentPane().add(getJLabel4(), getJLabel4().getName());
			getJDialogContentPane().add(getJButton1(), getJButton1().getName());
			getJDialogContentPane().add(getJButton2(), getJButton2().getName());
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
private com.sun.java.swing.JPanel getJFrameContentPane() {
	if (ivjJFrameContentPane == null) {
		try {
			ivjJFrameContentPane = new com.sun.java.swing.JPanel();
			ivjJFrameContentPane.setName("JFrameContentPane");
			ivjJFrameContentPane.setLayout(null);
			getJFrameContentPane().add(getBService(), getBService().getName());
			getJFrameContentPane().add(getJLabel1(), getJLabel1().getName());
			getJFrameContentPane().add(getJLabel2(), getJLabel2().getName());
			getJFrameContentPane().add(getJLabel3(), getJLabel3().getName());
			getJFrameContentPane().add(getBCustomer(), getBCustomer().getName());
			getJFrameContentPane().add(getBProject(), getBProject().getName());
			getJFrameContentPane().add(getBSummary(), getBSummary().getName());
			getJFrameContentPane().add(getBExit(), getBExit().getName());
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
			ivjJLabel1.setFont(new java.awt.Font("dialog", 1, 36));
			ivjJLabel1.setBorder(new com.sun.java.swing.plaf.metal.Flush3DBorder());
			ivjJLabel1.setText("                       Main Management");
			ivjJLabel1.setBounds(217, 5, 558, 50);
			ivjJLabel1.setForeground(new java.awt.Color(181,197,255));
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
 * Return the JLabel2 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel2() {
	if (ivjJLabel2 == null) {
		try {
			ivjJLabel2 = new com.sun.java.swing.JLabel();
			ivjJLabel2.setName("JLabel2");
			ivjJLabel2.setFont(new java.awt.Font("dialog", 1, 36));
			ivjJLabel2.setText("                       Main Management");
			ivjJLabel2.setBounds(217, 4, 558, 50);
			ivjJLabel2.setForeground(new java.awt.Color(225,228,255));
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
			ivjJLabel3.setFont(new java.awt.Font("dialog", 1, 36));
			ivjJLabel3.setText("                       Main Management");
			ivjJLabel3.setBounds(220, 6, 558, 50);
			ivjJLabel3.setForeground(new java.awt.Color(62,71,97));
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
			ivjJLabel4.setText("Exit System ?");
			ivjJLabel4.setBounds(50, 25, 245, 15);
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
 * Return the JMenu1 property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenu getJMenu1() {
	if (ivjJMenu1 == null) {
		try {
			ivjJMenu1 = new com.sun.java.swing.JMenu();
			ivjJMenu1.setName("JMenu1");
			ivjJMenu1.setText("File");
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
			ivjJMenu2.setText("Tools");
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
 * Return the JMenu3 property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenu getJMenu3() {
	if (ivjJMenu3 == null) {
		try {
			ivjJMenu3 = new com.sun.java.swing.JMenu();
			ivjJMenu3.setName("JMenu3");
			ivjJMenu3.setText("Windows");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenu3;
}
/**
 * Return the JMenu4 property value.
 * @return com.sun.java.swing.JMenu
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenu getJMenu4() {
	if (ivjJMenu4 == null) {
		try {
			ivjJMenu4 = new com.sun.java.swing.JMenu();
			ivjJMenu4.setName("JMenu4");
			ivjJMenu4.setText("Help");
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJMenu4;
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
	getBProject().addActionListener(this);
	getBCustomer().addActionListener(this);
	getBExit().addActionListener(this);
	getJButton1().addActionListener(this);
	getJButton2().addActionListener(this);
}
/**
 * Initialize the class.
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initialize() {
	// user code begin {1}
	ivjFMainControl = getFMainControl();
	ivjFMainControl.setVisible(true);
	ivjFMainControl.show();

	
	// user code end
	initConnections();
	// user code begin {2}
	// user code end
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		MainControl aMainControl;
		aMainControl = new MainControl();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
}