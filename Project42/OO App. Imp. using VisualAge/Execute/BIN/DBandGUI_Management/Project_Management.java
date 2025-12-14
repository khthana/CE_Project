package DBandGUI_Management;

import DBandGUI_Management.*;
import Project_Information.*;
import java.io.*;
import java.sql.*;
/**
 * This type was created in VisualAge.
 */
public class Project_Management implements java.awt.event.ActionListener {
	
	private com.sun.java.swing.JButton ivjJButton1 = null;
	private com.sun.java.swing.JPanel ivjJFrameContentPane = null;
	private com.sun.java.swing.JButton ivjJButton2 = null;
	private com.sun.java.swing.JButton ivjJButton3 = null;
	private com.sun.java.swing.JButton ivjJButton4 = null;
	private com.sun.java.swing.JButton ivjJButton5 = null;
	private com.sun.java.swing.JLabel ivjJLabel1 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel3 = null;
	private com.sun.java.swing.JMenu ivjJMenu1 = null;
	private com.sun.java.swing.JMenu ivjJMenu2 = null;
	private com.sun.java.swing.JMenu ivjJMenu3 = null;
	private com.sun.java.swing.JMenu ivjJMenu4 = null;
	private com.sun.java.swing.JFrame ivjFProjectManagement = null;
	private com.sun.java.swing.JMenuBar ivjFProjectManagementJMenuBar = null;
	private com.sun.java.swing.JButton ivjJButton10 = null;
	private com.sun.java.swing.JButton ivjJButton6 = null;
	private com.sun.java.swing.JButton ivjJButton7 = null;
	private com.sun.java.swing.JButton ivjJButton8 = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public Project_Management() {
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
	if ((e.getSource() == getJButton10()) ) {
		connEtoM1(e);
	}
	// user code begin {2}
	// user code end
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
		getFProjectManagement().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * Return the FMainControl property value.
 * @return com.sun.java.swing.JFrame
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JFrame getFProjectManagement() {
	if (ivjFProjectManagement == null) {
		try {
			ivjFProjectManagement = new com.sun.java.swing.JFrame();
			ivjFProjectManagement.setName("FProjectManagement");
			ivjFProjectManagement.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjFProjectManagement.setJMenuBar(getFProjectManagementJMenuBar());
			ivjFProjectManagement.setBounds(0, 0, 800, 570);
			ivjFProjectManagement.setTitle("Project Management");
			getFProjectManagement().setContentPane(getJFrameContentPane());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjFProjectManagement;
}
/**
 * Return the FProjectManagementJMenuBar property value.
 * @return com.sun.java.swing.JMenuBar
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JMenuBar getFProjectManagementJMenuBar() {
	if (ivjFProjectManagementJMenuBar == null) {
		try {
			ivjFProjectManagementJMenuBar = new com.sun.java.swing.JMenuBar();
			ivjFProjectManagementJMenuBar.setName("FProjectManagementJMenuBar");
			ivjFProjectManagementJMenuBar.add(getJMenu1());
			ivjFProjectManagementJMenuBar.add(getJMenu2());
			ivjFProjectManagementJMenuBar.add(getJMenu3());
			ivjFProjectManagementJMenuBar.add(getJMenu4());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjFProjectManagementJMenuBar;
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
			ivjJButton1.setFont(new java.awt.Font("dialog", 1, 14));
			ivjJButton1.setText("XXX Project Information XXX");
			ivjJButton1.setBounds(50, 150, 300, 35);
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
			ivjJButton10.setFont(new java.awt.Font("dialog", 1, 14));
			ivjJButton10.setText("Exit");
			ivjJButton10.setBounds(450, 350, 300, 30);
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
			ivjJButton2.setFont(new java.awt.Font("dialog", 1, 14));
			ivjJButton2.setText("XXX Employee Information XXX");
			ivjJButton2.setBounds(50, 200, 300, 30);
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
			ivjJButton3.setFont(new java.awt.Font("dialog", 1, 14));
			ivjJButton3.setText("XXX Home Information XXX");
			ivjJButton3.setBounds(50, 250, 300, 30);
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
			ivjJButton4.setFont(new java.awt.Font("dialog", 1, 14));
			ivjJButton4.setText("XXX Company Information XXX");
			ivjJButton4.setBounds(50, 300, 300, 30);
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
			ivjJButton5.setFont(new java.awt.Font("dialog", 1, 14));
			ivjJButton5.setText("XXX Contract Type Information XXX");
			ivjJButton5.setBounds(50, 350, 300, 30);
			ivjJButton5.setForeground(java.awt.Color.gray);
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
			ivjJButton6.setFont(new java.awt.Font("dialog", 1, 14));
			ivjJButton6.setText("XXX Home Status Information XXX");
			ivjJButton6.setBounds(450, 150, 300, 30);
			ivjJButton6.setForeground(java.awt.Color.gray);
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
			ivjJButton7.setFont(new java.awt.Font("dialog", 1, 14));
			ivjJButton7.setText("XXX Position Information XXX");
			ivjJButton7.setBounds(450, 200, 300, 30);
			ivjJButton7.setForeground(java.awt.Color.gray);
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
			ivjJButton8.setFont(new java.awt.Font("dialog", 1, 14));
			ivjJButton8.setText("XXX Project Type Information XXX");
			ivjJButton8.setBounds(450, 250, 300, 30);
			ivjJButton8.setForeground(java.awt.Color.gray);
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
			getJFrameContentPane().add(getJButton1(), getJButton1().getName());
			getJFrameContentPane().add(getJLabel1(), getJLabel1().getName());
			getJFrameContentPane().add(getJLabel2(), getJLabel2().getName());
			getJFrameContentPane().add(getJLabel3(), getJLabel3().getName());
			getJFrameContentPane().add(getJButton2(), getJButton2().getName());
			getJFrameContentPane().add(getJButton3(), getJButton3().getName());
			getJFrameContentPane().add(getJButton4(), getJButton4().getName());
			getJFrameContentPane().add(getJButton5(), getJButton5().getName());
			getJFrameContentPane().add(getJButton6(), getJButton6().getName());
			getJFrameContentPane().add(getJButton7(), getJButton7().getName());
			getJFrameContentPane().add(getJButton8(), getJButton8().getName());
			getJFrameContentPane().add(getJButton10(), getJButton10().getName());
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
			ivjJLabel1.setText("                   Project Management");
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
			ivjJLabel2.setText("                   Project Management");
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
			ivjJLabel3.setText("                   Project Management");
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
	getJButton10().addActionListener(this);
}
/**
 * Initialize the class.
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initialize() {
	// user code begin {1}
	getFProjectManagement();
	getFProjectManagement().setVisible(true);
	getFProjectManagement().show();

	
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
		Project_Management aProject_Management;
		aProject_Management = new Project_Management();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
}