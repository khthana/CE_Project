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
public class DBAMenu implements java.awt.event.ActionListener, java.awt.event.WindowListener {
	int IDProject=0;
	int IDEmployee=0;
	JFrame FLogin=null;
	private JButton ivjBEmployee = null;
	private JButton ivjBHomeType = null;
	private JButton ivjBLogout = null;
	private JButton ivjBProject = null;
	private JPanel ivjJFrameContentPane = null;
	private JLabel ivjJLabel8 = null;
	private JFrame ivjFDBAMenu = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public DBAMenu() {
	super();
	initialize();
}
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public DBAMenu(JFrame jf,int idP,int idE) {
	super();
	FLogin = jf;
	IDProject = idP;
	IDEmployee = idE;
	FLogin.setEnabled(false);
	initialize();
}
/**
 * Method to handle events for the ActionListener interface.
 * @param e java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public void actionPerformed(java.awt.event.ActionEvent e) {
	// user code begin {1}
	if ((e.getSource() == getBHomeType()) ) {
		
	}
	if ((e.getSource() == getBEmployee()) ) {
		
	}
	if ((e.getSource() == getBProject()) ) {
		
	}
	// user code end
	if ((e.getSource() == getBLogout()) ) {
		connEtoM1(e);
	}
	// user code begin {2}
	// user code end
}
/**
 * connEtoC1:  (FDBAMenu.window.windowClosed(java.awt.event.WindowEvent) --> DBAMenu.fDBAMenu_WindowClosed(Ljava.awt.event.WindowEvent;)V)
 * @param arg1 java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC1(java.awt.event.WindowEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.fDBAMenu_WindowClosed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM1:  (BLogout.action.actionPerformed(java.awt.event.ActionEvent) --> FDBAMenu.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM1(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getFDBAMenu().dispose();
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
public void fDBAMenu_WindowClosed(java.awt.event.WindowEvent windowEvent) {
	return;
}
/**
 * Return the BEmployee property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBEmployee() {
	if (ivjBEmployee == null) {
		try {
			ivjBEmployee = new com.sun.java.swing.JButton();
			ivjBEmployee.setName("BEmployee");
			ivjBEmployee.setText("Employee Editor");
			ivjBEmployee.setBackground(java.awt.SystemColor.text);
			ivjBEmployee.setBounds(150, 95, 150, 25);
			ivjBEmployee.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBEmployee;
}
/**
 * Return the BHomeType property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBHomeType() {
	if (ivjBHomeType == null) {
		try {
			ivjBHomeType = new com.sun.java.swing.JButton();
			ivjBHomeType.setName("BHomeType");
			ivjBHomeType.setText("HomeType Editor");
			ivjBHomeType.setBackground(java.awt.SystemColor.text);
			ivjBHomeType.setBounds(150, 25, 150, 25);
			ivjBHomeType.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBHomeType;
}
/**
 * Return the BLogout property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBLogout() {
	if (ivjBLogout == null) {
		try {
			ivjBLogout = new com.sun.java.swing.JButton();
			ivjBLogout.setName("BLogout");
			ivjBLogout.setText("Logout");
			ivjBLogout.setBackground(java.awt.SystemColor.text);
			ivjBLogout.setBounds(15, 95, 120, 25);
			ivjBLogout.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBLogout;
}
/**
 * Return the BProject property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBProject() {
	if (ivjBProject == null) {
		try {
			ivjBProject = new com.sun.java.swing.JButton();
			ivjBProject.setName("BProject");
			ivjBProject.setText("Project Editor");
			ivjBProject.setBackground(java.awt.SystemColor.text);
			ivjBProject.setBounds(150, 60, 150, 25);
			ivjBProject.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
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
 * Return the FLogin property value.
 * @return com.sun.java.swing.JFrame
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JFrame getFDBAMenu() {
	if (ivjFDBAMenu == null) {
		try {
			ivjFDBAMenu = new com.sun.java.swing.JFrame();
			ivjFDBAMenu.setName("FDBAMenu");
			ivjFDBAMenu.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjFDBAMenu.setBounds(405, 100, 320, 183);
			ivjFDBAMenu.setTitle("DBA Menu");
			getFDBAMenu().setContentPane(getJFrameContentPane());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjFDBAMenu;
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
			getJFrameContentPane().add(getJLabel8(), getJLabel8().getName());
			getJFrameContentPane().add(getBHomeType(), getBHomeType().getName());
			getJFrameContentPane().add(getBProject(), getBProject().getName());
			getJFrameContentPane().add(getBEmployee(), getBEmployee().getName());
			getJFrameContentPane().add(getBLogout(), getBLogout().getName());
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
 * Return the JLabel8 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel8() {
	if (ivjJLabel8 == null) {
		try {
			ivjJLabel8 = new com.sun.java.swing.JLabel();
			ivjJLabel8.setName("JLabel8");
			ivjJLabel8.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\microsoft.jpg"));
			ivjJLabel8.setText("");
			ivjJLabel8.setBounds(15, 12, 124, 74);
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
	getBHomeType().addActionListener(this);
	getBEmployee().addActionListener(this);
	getBProject().addActionListener(this);
	// user code end
	getBLogout().addActionListener(this);
	getFDBAMenu().addWindowListener(this);
}
/**
 * Initialize the class.
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initialize() {
	// user code begin {1}
	getFDBAMenu().show();
	getFDBAMenu().setVisible(true);
	getFDBAMenu().setEnabled(true);
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
		DBAMenu aDBAMenu;
		aDBAMenu = new DBAMenu();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
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
		FLogin.setEnabled(true);
	// user code end
	if ((e.getSource() == getFDBAMenu()) ) {
		connEtoC1(e);
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