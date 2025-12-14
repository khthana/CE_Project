package Banking;

/**
 * This type was created in VisualAge.
 */
import com.sun.java.swing.*;
import com.sun.java.swing.table.*;
 
public class LateCustomerForm implements java.awt.event.ActionListener, java.awt.event.WindowListener {
	private JButton ivjJButton1 = null;
	private JButton ivjJButton2 = null;
	private JComboBox ivjJComboBox1 = null;
	private JFrame ivjJFrame1 = null;
	private JPanel ivjJFrameContentPane = null;
	private JLabel ivjJLabel1 = null;
	private JLabel ivjJLabel2 = null;
	private JLabel ivjJLabel3 = null;
	private JScrollPane ivjJScrollPane1 = null;
	private JTable ivjScrollPaneTable = null;
	private BankerOption aBankerOption = null;
	private	DefaultTableColumnModel lateColumnModel = new DefaultTableColumnModel();
	private String[][] lateTableValue = new String[10][10];
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public LateCustomerForm() {
	super();
	initialize();
}
/**
 * Constructor
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
public LateCustomerForm(BankerOption aaBankerOption) {
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
 * This method was created in VisualAge.
 */
public void addComboBoxItem() {
	ivjJComboBox1.removeAllItems();
	ivjJComboBox1.addItem("LATE ONLY");
	ivjJComboBox1.addItem("ACQUIRE ONLY");
	ivjJComboBox1.addItem("LATE OR ACQUIRE");
}
/**
 * connEtoC1:  (JButton2.action. --> LateCustomerForm.exitForm()V)
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
 * connEtoC2:  (JFrame1.window.windowClosed(java.awt.event.WindowEvent) --> LateCustomerForm.exitForm()V)
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
 * connEtoC3:  (JButton1.action. --> LateCustomerForm.detectCustomerLate()V)
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private void connEtoC3() {
	try {
		// user code begin {1}
		// user code end
		this.detectCustomerLate();
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
public void createColumnModel() {
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

	column1.setHeaderValue("Customer ID");
	column2.setHeaderValue("Name");
	column3.setHeaderValue("Address");
	column4.setHeaderValue("Status");
	column5.setHeaderValue("Amount Loan");
	column6.setHeaderValue("Period Type");
	column7.setHeaderValue("Loan Date");
	column8.setHeaderValue("Balance Due");
	column9.setHeaderValue("LastPaid Date");
	column10.setHeaderValue("Amount Date");

	lateColumnModel.addColumn(column1);
	lateColumnModel.addColumn(column2);
	lateColumnModel.addColumn(column3);
	lateColumnModel.addColumn(column4);
	lateColumnModel.addColumn(column5);
	lateColumnModel.addColumn(column6);
	lateColumnModel.addColumn(column7);
	lateColumnModel.addColumn(column8);
	lateColumnModel.addColumn(column9);
	lateColumnModel.addColumn(column10);
}
/**
 * Comment
 */
public void detectCustomerLate() {
	try
	{
		java.sql.Statement stmt = aBankerOption.conn.createStatement ();		
		java.sql.ResultSet rset = null;
		
//------------------- clear lateTableValue --------------------//
		int i,j,numLate;
		for (i=0;i<10;i++)
		{
			for (j=0;j<10;j++)
			{
				lateTableValue[i][j] = null;
			}
		}
//------------------- clear lateTableValue --------------------//

		int choice = ivjJComboBox1.getSelectedIndex();
		if (choice == 0)
		{
			rset = stmt.executeQuery ("select Customer_id from Customer where Payment_Status = 'LATE'");
		}
		else if (choice == 1)
		{
			rset = stmt.executeQuery ("select Customer_id from Customer where Payment_Status = 'ACQUIRE'");
		}
		else
		{
			rset = stmt.executeQuery ("select Customer_id from Customer where Payment_Status != 'NORMAL'");
		}

		i = 0;
		while (rset.next () && i<10)
		{ 
			lateTableValue[i][0] = Integer.toString(rset.getInt(1));
			i++;
		}
		numLate = i;
		
		for (i=0;i<numLate;i++)
		{
			int customer_id = 0;
			int account_id = 0;
			String balance_due = null;
			String last_date = null;
			
			rset = stmt.executeQuery ("select Name,Address,Payment_Status from Customer where Customer_id = "+Integer.parseInt(lateTableValue[i][0]));
			if (rset.next ())
			{
				lateTableValue[i][1] = rset.getString(1);
				lateTableValue[i][2] = rset.getString(2);
				lateTableValue[i][3] = rset.getString(3);
			}

			rset = stmt.executeQuery ("select Account_id,Amount,Ptype,to_char(Start_Date,'dd-Mon-yyyy') from Loanaccount where Account_id = (select min(Account_id) from Customer where Customer_id = "+Integer.parseInt(lateTableValue[i][0])+" group by customer_id)");
			if (rset.next ())
			{
				account_id = rset.getInt(1);
				lateTableValue[i][4] = Integer.toString(rset.getInt(2));
				balance_due = Integer.toString(rset.getInt(2));
				lateTableValue[i][5] = Integer.toString(rset.getInt(3));
				lateTableValue[i][6] = rset.getString(4);
				last_date = rset.getString(4);
			}

			rset = stmt.executeQuery ("select Balance_Due,to_char(Pay_Date,'dd-Mon-yyyy') from Cash_Per_Month where Customer_id = "
				                      +Integer.parseInt(lateTableValue[i][0])+" and Period_Num >= all(select Period_Num from Cash_Per_Month where Customer_id = " 
			                      	  +Integer.parseInt(lateTableValue[i][0])+")");
			boolean found = false;
			if (rset.next ())
			{
				lateTableValue[i][7] = Integer.toString(rset.getInt(1));
				lateTableValue[i][8] = rset.getString(2);
				found = true;
			}
			if (found == false)
			{
				lateTableValue[i][7] = balance_due;
				lateTableValue[i][8] = last_date;
			}

			customer_id = Integer.parseInt(lateTableValue[i][0]);
			java.sql.CallableStatement cstmt = aBankerOption.conn.prepareCall ("{? = call GET_NUM_LATE (?,?)}");
			cstmt.registerOutParameter (1, java.sql.Types.INTEGER);
			cstmt.setInt (2, customer_id);
			cstmt.setInt (3, account_id);
			cstmt.execute ();
			lateTableValue[i][9] = Integer.toString(cstmt.getInt(1));
		}
		
		showLateTable();
	}
	catch (java.lang.Throwable error) { handleException(error); }
		
	return;
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
private JButton getJButton1() {
	if (ivjJButton1 == null) {
		try {
			ivjJButton1 = new com.sun.java.swing.JButton();
			ivjJButton1.setName("JButton1");
			ivjJButton1.setText("Detect Customer");
			ivjJButton1.setBounds(21, 52, 130, 25);
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
			ivjJButton2.setText("Exit");
			ivjJButton2.setBounds(375, 281, 85, 25);
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
 * Return the JComboBox1 property value.
 * @return com.sun.java.swing.JComboBox
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JComboBox getJComboBox1() {
	if (ivjJComboBox1 == null) {
		try {
			ivjJComboBox1 = new com.sun.java.swing.JComboBox();
			ivjJComboBox1.setName("JComboBox1");
			ivjJComboBox1.setBounds(164, 18, 136, 23);
			// user code begin {1}
			// user code end
		} catch (java.lang.Throwable ivjExc) {
			// user code begin {2}
			// user code end
			handleException(ivjExc);
		}
	};
	return ivjJComboBox1;
}
/**
 * Return the JFrame1 property value.
 * @return com.sun.java.swing.JFrame
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JFrame getJFrame1() {
	if (ivjJFrame1 == null) {
		try {
			ivjJFrame1 = new com.sun.java.swing.JFrame();
			ivjJFrame1.setName("JFrame1");
			ivjJFrame1.setDefaultCloseOperation(com.sun.java.swing.WindowConstants.DISPOSE_ON_CLOSE);
			ivjJFrame1.setBounds(59, 45, 498, 352);
			ivjJFrame1.setTitle("Late Customer Form");
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
private JPanel getJFrameContentPane() {
	if (ivjJFrameContentPane == null) {
		try {
			ivjJFrameContentPane = new com.sun.java.swing.JPanel();
			ivjJFrameContentPane.setName("JFrameContentPane");
			ivjJFrameContentPane.setLayout(null);
			ivjJFrameContentPane.setBackground(java.awt.Color.orange);
			getJFrameContentPane().add(getJLabel1(), getJLabel1().getName());
			getJFrameContentPane().add(getJComboBox1(), getJComboBox1().getName());
			getJFrameContentPane().add(getJButton1(), getJButton1().getName());
			getJFrameContentPane().add(getJScrollPane1(), getJScrollPane1().getName());
			getJFrameContentPane().add(getJButton2(), getJButton2().getName());
			getJFrameContentPane().add(getJLabel2(), getJLabel2().getName());
			getJFrameContentPane().add(getJLabel3(), getJLabel3().getName());
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
			ivjJLabel1.setText("Select Type for Detect");
			ivjJLabel1.setBounds(21, 22, 130, 15);
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
private JLabel getJLabel2() {
	if (ivjJLabel2 == null) {
		try {
			ivjJLabel2 = new com.sun.java.swing.JLabel();
			ivjJLabel2.setName("JLabel2");
			ivjJLabel2.setText("Date");
			ivjJLabel2.setBounds(353, 20, 32, 15);
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
private JLabel getJLabel3() {
	if (ivjJLabel3 == null) {
		try {
			ivjJLabel3 = new com.sun.java.swing.JLabel();
			ivjJLabel3.setName("JLabel3");
			ivjJLabel3.setBorder(new com.sun.java.swing.plaf.basic.BasicFieldBorder());
			ivjJLabel3.setText("");
			ivjJLabel3.setBounds(385, 21, 86, 15);
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
 * Return the JScrollPane1 property value.
 * @return com.sun.java.swing.JScrollPane
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JScrollPane getJScrollPane1() {
	if (ivjJScrollPane1 == null) {
		try {
			ivjJScrollPane1 = new com.sun.java.swing.JScrollPane();
			ivjJScrollPane1.setName("JScrollPane1");
			ivjJScrollPane1.setAutoscrolls(true);
			ivjJScrollPane1.setVerticalScrollBarPolicy(com.sun.java.swing.JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
			ivjJScrollPane1.setHorizontalScrollBarPolicy(com.sun.java.swing.JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
			ivjJScrollPane1.setBounds(21, 95, 452, 171);
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
 * Return the ScrollPaneTable property value.
 * @return com.sun.java.swing.JTable
 */
/* WARNING: THIS METHOD WILL BE REGENERATED. */
private JTable getScrollPaneTable() {
	if (ivjScrollPaneTable == null) {
		try {
			ivjScrollPaneTable = new com.sun.java.swing.JTable();
			ivjScrollPaneTable.setName("ScrollPaneTable");
			getJScrollPane1().setColumnHeaderView(ivjScrollPaneTable.getTableHeader());
			getJScrollPane1().getViewport().setBackingStoreEnabled(true);
			ivjScrollPaneTable.setAutoResizeMode(com.sun.java.swing.JTable.AUTO_RESIZE_OFF);
			ivjScrollPaneTable.setBounds(0, 0, 200, 200);
			// user code begin {1}
			createColumnModel();
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
public void initialLateCustomerForm() {
	addComboBoxItem();
	ivjJLabel3.setText(aBankerOption.today);

	int i,j;
	for (i=0;i<10;i++)
	{
		for (j=0;j<10;j++)
		{
			lateTableValue[i][j] = null;
		}
	}
	showLateTable();

	return;
}
/**
 * main entrypoint - starts the part when it is run as an application
 * @param args java.lang.String[]
 */
public static void main(java.lang.String[] args) {
	try {
		LateCustomerForm aLateCustomerForm;
		aLateCustomerForm = new LateCustomerForm();
	} catch (Throwable exception) {
		System.err.println("Exception occurred in main() of java.lang.Object");
		exception.printStackTrace(System.out);
	}
}
/**
 * This method was created in VisualAge.
 */
public void showForm() {
	getJFrame1().show();
	try 
	{
	   initialLateCustomerForm();
	}
	catch (Throwable exception) { handleException(exception); }
}
/**
 * This method was created in VisualAge.
 */
public void showLateTable() {
	TableModel dataModel = new AbstractTableModel() {
		public String getColumnName(int column) { return lateColumnModel.getColumn(column).getHeaderValue().toString(); }
		public int getColumnCount() { return lateColumnModel.getColumnCount(); }
		public int getRowCount() { return 10;}
		public Object getValueAt(int row, int col) { return lateTableValue[row][col]; }
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