package DBandGUI_Management;

import DBandGUI_Management.*;
import Project_Information.*;
import java.io.*;
import java.sql.*;
import com.sun.java.swing.*;
import java.awt.*;
/**
 * This type was created in VisualAge.
 */
public class LoginGUI implements java.awt.event.ActionListener, java.awt.event.WindowListener {
	public DBAMenu dBAMenu=null;
	public EMPMenu eMPMenu=null;
	public Calculate c = new Calculate();
	public Employee employee = new Employee();
	public Account account = new Account();
	public Privilege privilege = new Privilege();
	public Project project = new Project();
	public MainDB mainDB = new MainDB();
	public Connection conS;
	private JPanel ivjJFrameContentPane = null;
	private JLabel ivjJLabel1 = null;
	private JFrame ivjFLogin = null;
	private JButton ivjBCancel = null;
	private JButton ivjBOk = null;
	private JLabel ivjJLabel5 = null;
	private JLabel ivjJLabel6 = null;
	private JLabel ivjJLabel7 = null;
	private JTextField ivjTFProID = null;
	private JTextField ivjTFProName = null;
	private JTextField ivjTFUser = null;
	private JDialog ivjDLoginError = null;
	private JButton ivjJButton1 = null;
	private JPanel ivjJDialogContentPane = null;
	private JDialog ivjDCannotConnect = null;
	private JPanel ivjJDialogContentPane1 = null;
	private JLabel ivjJLabel9 = null;
	private JButton ivjJButton2 = null;
	private JPasswordField ivjTFPassword = null;
	private JLabel ivjLError = null;
	private JLabel ivjJLabel8 = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public LoginGUI() {
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
	if ((e.getSource() == getBOk()) ) {
		connEtoC1(e);
	}
	if ((e.getSource() == getBCancel()) ) {
		connEtoM1(e);
	}
	if ((e.getSource() == getTFProID()) ) {
		connEtoC2(e);
	}
	if ((e.getSource() == getJButton1()) ) {
		connEtoM2(e);
	}
	if ((e.getSource() == getJButton2()) ) {
		connEtoM3(e);
	}
	// user code begin {2}
	// user code end
}
/**
 * Comment
 */
public void bOk_ActionPerformed(java.awt.event.ActionEvent actionEvent) throws IOException {
	boolean connectok = false;
	try {
			System.out.println("Start Connect");
			conS = mainDB.connectServer();
			System.out.println("Connect ok !!!");
			getDCannotConnect().dispose();
			connectok = true;
		}
		catch (IOException ie) { getDCannotConnect().show(); }
		catch (SQLException se) { getDCannotConnect().show(); }

	boolean loginok = false;
	try {
			if (connectok) {
				if (account.search(conS,getTFUser().getText(),getTFPassword().getText())) {
					System.out.println("Account ID ="+account.getNumber("AccountID"));
					if (employee.checkAcc(conS,account.getNumber("AccountID")) ){
						System.out.println("Employee Name = "+employee.getString("Firstname"));
						if (employee.pos.getID() != 1) {
						if (employee.pri.checkPri(conS,c.toInt(getTFProID().getText()))) {
							loginok = true;
							getDLoginError().dispose();
							System.out.println("Privilege OK");
						} else { 
						System.out.println("You have not privilege");
						getDLoginError().show();
						}}
						else { loginok = true; }
					} else { 
					System.out.println("Employee not found");
					getDLoginError().show();
					}
				} else { 
				System.out.println("UserName or Password Error");
				getDLoginError().show();
				}
				
		
			}
		}
		catch (IOException ie) { getDCannotConnect().show(); }
		catch (SQLException se) { getDCannotConnect().show(); }

	if (loginok) {
		if (employee.pos.getID() == 1) {
			dBAMenu = new DBAMenu(getFLogin(),c.toInt(getTFProID().getText()),employee.getNumber("EmployeeID"));
		}
		else {
			eMPMenu = new EMPMenu(getFLogin(),c.toInt(getTFProID().getText()),employee.getNumber("EmployeeID"));
		}
	}
}
/**
 * connEtoC1:  (BOk.action.actionPerformed(java.awt.event.ActionEvent) --> LoginGUI.bOk_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC1(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.bOk_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC2:  (TFProID.action.actionPerformed(java.awt.event.ActionEvent) --> LoginGUI.tFProID_ActionPerformed(Ljava.awt.event.ActionEvent;)V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC2(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.tFProID_ActionPerformed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoC3:  (FLogin.window.windowClosed(java.awt.event.WindowEvent) --> LoginGUI.fLogin_WindowClosed(Ljava.awt.event.WindowEvent;)V)
 * @param arg1 java.awt.event.WindowEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3(java.awt.event.WindowEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		this.fLogin_WindowClosed(arg1);
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM1:  (BCancel.action.actionPerformed(java.awt.event.ActionEvent) --> FLogin.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM1(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getFLogin().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM2:  (JButton1.action.actionPerformed(java.awt.event.ActionEvent) --> DLoginError.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM2(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getDLoginError().dispose();
		// user code begin {2}
		// user code end
	} catch (java.lang.Throwable ivjExc) {
		// user code begin {3}
		// user code end
		handleException(ivjExc);
	}
}
/**
 * connEtoM3:  (JButton2.action.actionPerformed(java.awt.event.ActionEvent) --> DCannotConnect.dispose()V)
 * @param arg1 java.awt.event.ActionEvent
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoM3(java.awt.event.ActionEvent arg1) {
	try {
		// user code begin {1}
		// user code end
		getDCannotConnect().dispose();
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
public void fLogin_WindowClosed(java.awt.event.WindowEvent windowEvent) {
	return;
}
/**
 * Return the BCancel property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBCancel() {
	if (ivjBCancel == null) {
		try {
			ivjBCancel = new com.sun.java.swing.JButton();
			ivjBCancel.setName("BCancel");
			ivjBCancel.setText("Cancel");
			ivjBCancel.setBackground(java.awt.SystemColor.text);
			ivjBCancel.setBounds(215, 150, 85, 25);
			ivjBCancel.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBCancel;
}
/**
 * Return the BOk property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JButton getBOk() {
	if (ivjBOk == null) {
		try {
			ivjBOk = new com.sun.java.swing.JButton();
			ivjBOk.setName("BOk");
			ivjBOk.setText("OK");
			ivjBOk.setBackground(java.awt.SystemColor.text);
			ivjBOk.setBounds(120, 150, 85, 25);
			ivjBOk.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBOk;
}
/**
 * Return the DCannotConnect property value.
 * @return com.sun.java.swing.JDialog
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JDialog getDCannotConnect() {
	if (ivjDCannotConnect == null) {
		try {
			ivjDCannotConnect = new com.sun.java.swing.JDialog();
			ivjDCannotConnect.setName("DCannotConnect");
			ivjDCannotConnect.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjDCannotConnect.setBounds(405, 100, 250, 140);
			ivjDCannotConnect.setVisible(false);
			ivjDCannotConnect.setTitle("Connection Fail");
			getDCannotConnect().setContentPane(getJDialogContentPane1());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjDCannotConnect;
}
/**
 * Return the DLoginError property value.
 * @return com.sun.java.swing.JDialog
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JDialog getDLoginError() {
	if (ivjDLoginError == null) {
		try {
			ivjDLoginError = new com.sun.java.swing.JDialog();
			ivjDLoginError.setName("DLoginError");
			ivjDLoginError.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjDLoginError.setBounds(405, 100, 250, 140);
			ivjDLoginError.setTitle("Login Error");
			getDLoginError().setContentPane(getJDialogContentPane());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjDLoginError;
}
/**
 * Return the FMainControl property value.
 * @return com.sun.java.swing.JFrame
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JFrame getFLogin() {
	if (ivjFLogin == null) {
		try {
			ivjFLogin = new com.sun.java.swing.JFrame();
			ivjFLogin.setName("FLogin");
			ivjFLogin.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjFLogin.setBounds(75, 100, 320, 220);
			ivjFLogin.setTitle("Login Information");
			getFLogin().setContentPane(getJFrameContentPane());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjFLogin;
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
			ivjJButton1.setText("New Login");
			ivjJButton1.setBounds(60, 63, 125, 25);
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
			ivjJButton2.setText("OK");
			ivjJButton2.setBounds(85, 63, 85, 25);
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
			ivjJDialogContentPane.setBackground(java.awt.SystemColor.window);
			getJDialogContentPane().add(getLError(), getLError().getName());
			getJDialogContentPane().add(getJButton1(), getJButton1().getName());
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
private JPanel getJDialogContentPane1() {
	if (ivjJDialogContentPane1 == null) {
		try {
			ivjJDialogContentPane1 = new com.sun.java.swing.JPanel();
			ivjJDialogContentPane1.setName("JDialogContentPane1");
			ivjJDialogContentPane1.setLayout(null);
			ivjJDialogContentPane1.setBackground(java.awt.SystemColor.window);
			getJDialogContentPane1().add(getJLabel9(), getJLabel9().getName());
			getJDialogContentPane1().add(getJButton2(), getJButton2().getName());
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
			getJFrameContentPane().add(getJLabel5(), getJLabel5().getName());
			getJFrameContentPane().add(getJLabel6(), getJLabel6().getName());
			getJFrameContentPane().add(getJLabel7(), getJLabel7().getName());
			getJFrameContentPane().add(getTFUser(), getTFUser().getName());
			getJFrameContentPane().add(getTFPassword(), getTFPassword().getName());
			getJFrameContentPane().add(getTFProID(), getTFProID().getName());
			getJFrameContentPane().add(getTFProName(), getTFProName().getName());
			getJFrameContentPane().add(getBOk(), getBOk().getName());
			getJFrameContentPane().add(getBCancel(), getBCancel().getName());
			getJFrameContentPane().add(getJLabel8(), getJLabel8().getName());
			getJFrameContentPane().add(getJLabel1(), getJLabel1().getName());
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
private JLabel getJLabel1() {
	if (ivjJLabel1 == null) {
		try {
			ivjJLabel1 = new com.sun.java.swing.JLabel();
			ivjJLabel1.setName("JLabel1");
			ivjJLabel1.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\comp1.jpg"));
			ivjJLabel1.setText("");
			ivjJLabel1.setBounds(233, 38, 70, 64);
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
 * Return the JLabel5 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getJLabel5() {
	if (ivjJLabel5 == null) {
		try {
			ivjJLabel5 = new com.sun.java.swing.JLabel();
			ivjJLabel5.setName("JLabel5");
			ivjJLabel5.setText("User Name");
			ivjJLabel5.setBounds(20, 45, 65, 23);
			ivjJLabel5.setForeground(java.awt.SystemColor.controlText);
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
			ivjJLabel6.setText("Password");
			ivjJLabel6.setBounds(20, 80, 62, 15);
			ivjJLabel6.setForeground(java.awt.SystemColor.controlText);
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
			ivjJLabel7.setText("Project ID");
			ivjJLabel7.setBounds(20, 115, 68, 15);
			ivjJLabel7.setForeground(java.awt.SystemColor.controlText);
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
			ivjJLabel8.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\labellogin.jpg"));
			ivjJLabel8.setText("");
			ivjJLabel8.setBounds(20, 3, 140, 40);
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
			ivjJLabel9.setText("Press check server and network !!!");
			ivjJLabel9.setBounds(1, 25, 248, 15);
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
 * Return the JLabel8 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JLabel getLError() {
	if (ivjLError == null) {
		try {
			ivjLError = new com.sun.java.swing.JLabel();
			ivjLError.setName("LError");
			ivjLError.setText("Login Error !!!");
			ivjLError.setBounds(5, 25, 241, 15);
			ivjLError.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjLError;
}
/**
 * Return the JPasswordField1 property value.
 * @return com.sun.java.swing.JPasswordField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JPasswordField getTFPassword() {
	if (ivjTFPassword == null) {
		try {
			ivjTFPassword = new com.sun.java.swing.JPasswordField();
			ivjTFPassword.setName("TFPassword");
			ivjTFPassword.setBackground(new java.awt.Color(255,255,235));
			ivjTFPassword.setBounds(100, 80, 120, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFPassword;
}
/**
 * Return the TFProID property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFProID() {
	if (ivjTFProID == null) {
		try {
			ivjTFProID = new com.sun.java.swing.JTextField();
			ivjTFProID.setName("TFProID");
			ivjTFProID.setBackground(new java.awt.Color(255,255,235));
			ivjTFProID.setBounds(100, 115, 50, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFProID;
}
/**
 * Return the TFProName property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFProName() {
	if (ivjTFProName == null) {
		try {
			ivjTFProName = new com.sun.java.swing.JTextField();
			ivjTFProName.setName("TFProName");
			ivjTFProName.setText("Project Name");
			ivjTFProName.setBackground(new java.awt.Color(193,223,255));
			ivjTFProName.setBounds(160, 115, 140, 19);
			ivjTFProName.setEditable(false);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFProName;
}
/**
 * Return the TFUser property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTextField getTFUser() {
	if (ivjTFUser == null) {
		try {
			ivjTFUser = new com.sun.java.swing.JTextField();
			ivjTFUser.setName("TFUser");
			ivjTFUser.setBackground(new java.awt.Color(255,255,235));
			ivjTFUser.setBounds(100, 45, 120, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFUser;
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
	getBOk().addActionListener(this);
	getBCancel().addActionListener(this);
	getTFProID().addActionListener(this);
	getJButton1().addActionListener(this);
	getJButton2().addActionListener(this);
	getFLogin().addWindowListener(this);
}
/**
 * Initialize the class.
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initialize() {
	// user code begin {1}
	
	getFLogin();
	getFLogin().setVisible(true);
	getFLogin().show();
		
	
	// user code end
	initConnections();
	// user code begin {2}

	// user code end
}
/**
 * Comment
 */
public void jButton1_ActionPerformed(java.awt.event.ActionEvent actionEvent) {

}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		LoginGUI aLoginGUI;
		aLoginGUI = new LoginGUI();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
/**
 * Comment
 */
public void tFProID_ActionPerformed(java.awt.event.ActionEvent actionEvent) {
	boolean connectok = false;
	try {
			System.out.println("Start Connect");
			conS = mainDB.connectServer();
			System.out.println("Connect ok !!!");
			getDCannotConnect().dispose();
			connectok = true;
		}
		catch (IOException ie) { getDCannotConnect().show(); }
		catch (SQLException se) { getDCannotConnect().show(); }

	if (connectok) {
	 try {
		  if (project.load(conS,c.toInt(getTFProID().getText()))) {
	      	getTFProName().setText(""+project.getString("ProjectName"));
		  } else { getTFProName().setText("Not Found !!!"); }
	 }
	 catch (IOException ie){}
	 catch (SQLException se){}
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
	// user code end
	if ((e.getSource() == getFLogin()) ) {
		connEtoC3(e);
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