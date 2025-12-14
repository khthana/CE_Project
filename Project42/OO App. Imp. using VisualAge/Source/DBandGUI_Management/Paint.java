package DBandGUI_Management;

/**
 * This type was created in VisualAge.
 */
public class Paint {
	private com.sun.java.swing.JButton ivjBBack = null;
	private com.sun.java.swing.JButton ivjBEnd = null;
	private com.sun.java.swing.JButton ivjBNext = null;
	private com.sun.java.swing.JButton ivjBOKset = null;
	private com.sun.java.swing.JDialog ivjDHomeInformation = null;
	private com.sun.java.swing.JPanel ivjJDialogContentPane = null;
	private com.sun.java.swing.JLabel ivjJLabel1 = null;
	private com.sun.java.swing.JLabel ivjJLabel10 = null;
	private com.sun.java.swing.JLabel ivjJLabel2 = null;
	private com.sun.java.swing.JLabel ivjJLabel3 = null;
	private com.sun.java.swing.JLabel ivjJLabel4 = null;
	private com.sun.java.swing.JLabel ivjJLabel5 = null;
	private com.sun.java.swing.JLabel ivjJLabel6 = null;
	private com.sun.java.swing.JLabel ivjJLabel7 = null;
	private com.sun.java.swing.JLabel ivjJLabel8 = null;
	private com.sun.java.swing.JLabel ivjJLabel9 = null;
	private com.sun.java.swing.JLabel ivjLImage = null;
	private com.sun.java.swing.JTextField ivjTFAddress = null;
	private com.sun.java.swing.JTextField ivjTFBathRoom = null;
	private com.sun.java.swing.JTextField ivjTFBedRoom = null;
	private com.sun.java.swing.JTextField ivjTFFloor = null;
	private com.sun.java.swing.JTextField ivjTFPrice = null;
	private com.sun.java.swing.JTextField ivjTFSpace = null;
	private com.sun.java.swing.JTextField ivjTFStatusID = null;
	private com.sun.java.swing.JTextField ivjTFStatusName = null;
	private com.sun.java.swing.JTextField ivjTFTypeID = null;
	private com.sun.java.swing.JTextField ivjTFTypeName = null;
	private com.sun.java.swing.JTextField ivjTFWidth = null;
	private com.sun.java.swing.JTextField ivjTFXY = null;
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public Paint() {
	super();
	initialize();
}
/**
 * Return the BBack property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBBack() {
	if (ivjBBack == null) {
		try {
			ivjBBack = new com.sun.java.swing.JButton();
			ivjBBack.setName("BBack");
			ivjBBack.setText("Back");
			ivjBBack.setBounds(145, 190, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBBack;
}
/**
 * Return the BEnd property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBEnd() {
	if (ivjBEnd == null) {
		try {
			ivjBEnd = new com.sun.java.swing.JButton();
			ivjBEnd.setName("BEnd");
			ivjBEnd.setText("End");
			ivjBEnd.setBounds(325, 190, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBEnd;
}
/**
 * Return the BNext property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBNext() {
	if (ivjBNext == null) {
		try {
			ivjBNext = new com.sun.java.swing.JButton();
			ivjBNext.setName("BNext");
			ivjBNext.setText("Next");
			ivjBNext.setBounds(235, 190, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBNext;
}
/**
 * Return the BOKset property value.
 * @return com.sun.java.swing.JButton
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JButton getBOKset() {
	if (ivjBOKset == null) {
		try {
			ivjBOKset = new com.sun.java.swing.JButton();
			ivjBOKset.setName("BOKset");
			ivjBOKset.setText("OK");
			ivjBOKset.setBounds(55, 190, 85, 25);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjBOKset;
}
/**
 * Return the DHomeInformation property value.
 * @return com.sun.java.swing.JDialog
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JDialog getDHomeInformation() {
	if (ivjDHomeInformation == null) {
		try {
			ivjDHomeInformation = new com.sun.java.swing.JDialog();
			ivjDHomeInformation.setName("DHomeInformation");
			ivjDHomeInformation.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjDHomeInformation.setBounds(21, 122, 460, 255);
			ivjDHomeInformation.setTitle("Home Information");
			getDHomeInformation().setContentPane(getJDialogContentPane());
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjDHomeInformation;
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
			getJDialogContentPane().add(getJLabel1(), getJLabel1().getName());
			getJDialogContentPane().add(getTFXY(), getTFXY().getName());
			getJDialogContentPane().add(getBOKset(), getBOKset().getName());
			getJDialogContentPane().add(getBBack(), getBBack().getName());
			getJDialogContentPane().add(getBNext(), getBNext().getName());
			getJDialogContentPane().add(getBEnd(), getBEnd().getName());
			getJDialogContentPane().add(getJLabel2(), getJLabel2().getName());
			getJDialogContentPane().add(getTFAddress(), getTFAddress().getName());
			getJDialogContentPane().add(getJLabel3(), getJLabel3().getName());
			getJDialogContentPane().add(getTFStatusID(), getTFStatusID().getName());
			getJDialogContentPane().add(getTFStatusName(), getTFStatusName().getName());
			getJDialogContentPane().add(getJLabel4(), getJLabel4().getName());
			getJDialogContentPane().add(getTFTypeID(), getTFTypeID().getName());
			getJDialogContentPane().add(getTFTypeName(), getTFTypeName().getName());
			getJDialogContentPane().add(getJLabel5(), getJLabel5().getName());
			getJDialogContentPane().add(getTFSpace(), getTFSpace().getName());
			getJDialogContentPane().add(getJLabel6(), getJLabel6().getName());
			getJDialogContentPane().add(getTFBedRoom(), getTFBedRoom().getName());
			getJDialogContentPane().add(getJLabel7(), getJLabel7().getName());
			getJDialogContentPane().add(getTFWidth(), getTFWidth().getName());
			getJDialogContentPane().add(getJLabel8(), getJLabel8().getName());
			getJDialogContentPane().add(getTFBathRoom(), getTFBathRoom().getName());
			getJDialogContentPane().add(getJLabel9(), getJLabel9().getName());
			getJDialogContentPane().add(getTFFloor(), getTFFloor().getName());
			getJDialogContentPane().add(getJLabel10(), getJLabel10().getName());
			getJDialogContentPane().add(getTFPrice(), getTFPrice().getName());
			getJDialogContentPane().add(getLImage(), getLImage().getName());
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
 * Return the JLabel1 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel1() {
	if (ivjJLabel1 == null) {
		try {
			ivjJLabel1 = new com.sun.java.swing.JLabel();
			ivjJLabel1.setName("JLabel1");
			ivjJLabel1.setText("Home");
			ivjJLabel1.setBounds(20, 20, 45, 15);
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
			ivjJLabel10.setText("Price");
			ivjJLabel10.setBounds(320, 140, 42, 15);
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
 * Return the JLabel2 property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getJLabel2() {
	if (ivjJLabel2 == null) {
		try {
			ivjJLabel2 = new com.sun.java.swing.JLabel();
			ivjJLabel2.setName("JLabel2");
			ivjJLabel2.setText("Address");
			ivjJLabel2.setBounds(120, 20, 51, 15);
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
			ivjJLabel3.setText("Status");
			ivjJLabel3.setBounds(20, 50, 45, 15);
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
			ivjJLabel4.setText("Type");
			ivjJLabel4.setBounds(200, 50, 34, 15);
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
			ivjJLabel5.setText("Width");
			ivjJLabel5.setBounds(200, 80, 37, 15);
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
			ivjJLabel6.setText("Space");
			ivjJLabel6.setBounds(200, 110, 45, 15);
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
			ivjJLabel7.setText("BedRoom");
			ivjJLabel7.setBounds(320, 81, 65, 15);
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
			ivjJLabel8.setText("BathRoom");
			ivjJLabel8.setBounds(320, 110, 64, 15);
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
			ivjJLabel9.setText("Floor");
			ivjJLabel9.setBounds(200, 140, 37, 15);
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
 * Return the LImage property value.
 * @return com.sun.java.swing.JLabel
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JLabel getLImage() {
	if (ivjLImage == null) {
		try {
			ivjLImage = new com.sun.java.swing.JLabel();
			ivjLImage.setName("LImage");
			ivjLImage.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjLImage.setText("");
			ivjLImage.setIcon(new com.sun.java.swing.ImageIcon("..\\test\\PictureAndIcon\\home.jpg"));
			ivjLImage.setBounds(76, 95, 60, 60);
			ivjLImage.setHorizontalAlignment(com.sun.java.swing.SwingConstants.CENTER);
			ivjLImage.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjLImage;
}
/**
 * Return the TFAddress property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFAddress() {
	if (ivjTFAddress == null) {
		try {
			ivjTFAddress = new com.sun.java.swing.JTextField();
			ivjTFAddress.setName("TFAddress");
			ivjTFAddress.setBounds(175, 20, 97, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFAddress;
}
/**
 * Return the TFBathRoom property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFBathRoom() {
	if (ivjTFBathRoom == null) {
		try {
			ivjTFBathRoom = new com.sun.java.swing.JTextField();
			ivjTFBathRoom.setName("TFBathRoom");
			ivjTFBathRoom.setBounds(385, 110, 50, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFBathRoom;
}
/**
 * Return the TFBedRoom property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFBedRoom() {
	if (ivjTFBedRoom == null) {
		try {
			ivjTFBedRoom = new com.sun.java.swing.JTextField();
			ivjTFBedRoom.setName("TFBedRoom");
			ivjTFBedRoom.setBounds(385, 80, 50, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFBedRoom;
}
/**
 * Return the TFFloor property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFFloor() {
	if (ivjTFFloor == null) {
		try {
			ivjTFFloor = new com.sun.java.swing.JTextField();
			ivjTFFloor.setName("TFFloor");
			ivjTFFloor.setBounds(240, 140, 50, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFFloor;
}
/**
 * Return the TFPrice property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFPrice() {
	if (ivjTFPrice == null) {
		try {
			ivjTFPrice = new com.sun.java.swing.JTextField();
			ivjTFPrice.setName("TFPrice");
			ivjTFPrice.setBounds(355, 140, 80, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFPrice;
}
/**
 * Return the TFSpace property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFSpace() {
	if (ivjTFSpace == null) {
		try {
			ivjTFSpace = new com.sun.java.swing.JTextField();
			ivjTFSpace.setName("TFSpace");
			ivjTFSpace.setBounds(240, 110, 50, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFSpace;
}
/**
 * Return the TFStatusID property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFStatusID() {
	if (ivjTFStatusID == null) {
		try {
			ivjTFStatusID = new com.sun.java.swing.JTextField();
			ivjTFStatusID.setName("TFStatusID");
			ivjTFStatusID.setBounds(65, 50, 20, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFStatusID;
}
/**
 * Return the TFStatusName property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFStatusName() {
	if (ivjTFStatusName == null) {
		try {
			ivjTFStatusName = new com.sun.java.swing.JTextField();
			ivjTFStatusName.setName("TFStatusName");
			ivjTFStatusName.setBounds(90, 50, 100, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFStatusName;
}
/**
 * Return the TFTypeID property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFTypeID() {
	if (ivjTFTypeID == null) {
		try {
			ivjTFTypeID = new com.sun.java.swing.JTextField();
			ivjTFTypeID.setName("TFTypeID");
			ivjTFTypeID.setBounds(240, 50, 20, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFTypeID;
}
/**
 * Return the TFTypeName property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFTypeName() {
	if (ivjTFTypeName == null) {
		try {
			ivjTFTypeName = new com.sun.java.swing.JTextField();
			ivjTFTypeName.setName("TFTypeName");
			ivjTFTypeName.setBounds(265, 50, 170, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFTypeName;
}
/**
 * Return the TFWidth property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFWidth() {
	if (ivjTFWidth == null) {
		try {
			ivjTFWidth = new com.sun.java.swing.JTextField();
			ivjTFWidth.setName("TFWidth");
			ivjTFWidth.setBounds(240, 80, 50, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFWidth;
}
/**
 * Return the TFXY property value.
 * @return com.sun.java.swing.JTextField
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private com.sun.java.swing.JTextField getTFXY() {
	if (ivjTFXY == null) {
		try {
			ivjTFXY = new com.sun.java.swing.JTextField();
			ivjTFXY.setName("TFXY");
			ivjTFXY.setBounds(65, 20, 40, 19);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjTFXY;
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
 * Initialize the class.
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void initialize() {
	// user code begin {1}
	// user code end
	// user code begin {2}
	// user code end
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		Paint aPaint;
		aPaint = new Paint();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
}