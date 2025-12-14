package JavaIDEX;
import java.awt.*;
import java.awt.event.*;
import java.util.Hashtable;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import javax.swing.*;
import javax.swing.event.*;
import javax.swing.filechooser.*;
import javax.swing.text.*;
import javax.swing.undo.*;
import javax.swing.plaf.basic.*;
public class EditWin extends JInternalFrame{
	static int openFrameCount = 0;
	static final int xOffset = 30, yOffset = 30;
	JSplitPane splitPane;
	JScrollPane scrollPane1,scrollPane2 ;
	JTextPane textPane;
	DefaultStyledDocument dsd;
	DebugPane debugPane;
	CompileDlg compileDlg;
	File file;
	boolean dirty = false;	
	JPanel contentPane;
	JMenuBar menuBar;
	JMenu fileMenu, envMenu, commandMenu;
	JMenuItem file_Save_menuItem, file_SaveAs_menuItem, file_Exit_menuItem,
              env_setEnv_menuItem, 
			  command_Compile_menuItem, command_Execute_menuItem, command_Debug_menuItem;
	String currPath = null, currFileName = null, currJavName= null,
         JDKLoc = "d:\\jdk\\bin";
	SimpleAttributeSet[] attrs;
	JViewport dbp_viewport;
	Point dbv_point;
	final int line2Pixel = 17;
	final JFileChooser fileChooser = new JFileChooser();
	int threshold;
	int char2Line[];
	public EditWin(String currPath, String currFileName, String currJavName, File file) {
		super(currFileName,
			  true, //resizable
              true, //closable
              true, //maximizable
              true);//iconifiable
		this.currPath = currPath;
		this.currFileName = currFileName;
		this.currJavName = currJavName;
		this.file = file;
		createWin();
		try {
			int size = (int)file.length();
			int chars_read = 0;
			FileReader in = new FileReader(file);
			char[] data = new char[size];
			char2Line = new int[200];
			while(in.ready()) {
				chars_read += in.read(data,chars_read,size-chars_read);
			}
			char[] realString = new char[size];
			int line = 1;
			int j = 0;
			for (int i=0; i <= size-1 ; i++) {
				if (data[i] == '\r') {
					char2Line[line] = j;
					line++;
				} else {
					data[j] = data[i];
					j++;
				}
			}
			try {
				String temp = new String(data,0,j);
				attrs = initAttributes(size);
				dsd.insertString(dsd.getLength(), temp, attrs[0]);
			} catch (BadLocationException ble) {}
			in.close();
		} catch(IOException e) {}
	}
	public EditWin() {
		super("Noname" + (++openFrameCount)+ ".java",
              true, //resizable
              true, //closable
              true, //maximizable
              true);//iconifiable
		createWin();
	}
	public void createWin(){
		setVisible(true);
		setSize(700, 500);
		setLocation(xOffset*openFrameCount, yOffset*openFrameCount);
		// 1. create content pane
		contentPane = new JPanel();
		contentPane.setLayout(new BorderLayout());
		setContentPane(contentPane);
		// 2. create menu bar
		menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		// 2.1 create menu file
		fileMenu = new JMenu("File");
		fileMenu.setMnemonic(KeyEvent.VK_F);
		menuBar.add(fileMenu);
		file_Save_menuItem = new JMenuItem("Save",KeyEvent.VK_S);
		file_Save_menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S,ActionEvent.CTRL_MASK)); // set shortcut key
		fileMenu.add(file_Save_menuItem);
		file_SaveAs_menuItem = new JMenuItem("Save As...",KeyEvent.VK_A);
		fileMenu.add(file_SaveAs_menuItem);
		file_Exit_menuItem = new JMenuItem("Exit");
		fileMenu.add(file_Exit_menuItem);
		// 2.3 create menu environment
		envMenu = new JMenu("Environment");
		envMenu.setMnemonic(KeyEvent.VK_E);
		menuBar.add(envMenu);
		env_setEnv_menuItem = new JMenuItem("Set Environment",KeyEvent.VK_S);
		envMenu.add(env_setEnv_menuItem);		
		// 2.3 create menu command
		commandMenu = new JMenu("Command");
		commandMenu.setMnemonic(KeyEvent.VK_C);
		menuBar.add(commandMenu);
		command_Compile_menuItem = new JMenuItem("Compile",KeyEvent.VK_C);
		command_Compile_menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C, 
			ActionEvent.CTRL_MASK)); // set shortcut key
		commandMenu.add(command_Compile_menuItem);
		command_Execute_menuItem = new JMenuItem("Execute",KeyEvent.VK_E);
		command_Execute_menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_E,
			ActionEvent.CTRL_MASK)); // set shortcut key
		commandMenu.add(command_Execute_menuItem);
		command_Debug_menuItem = new JMenuItem("Debug",KeyEvent.VK_D);
		command_Debug_menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_D,
			ActionEvent.CTRL_MASK)); // set shortcut key
		commandMenu.add(command_Debug_menuItem);
		// 4. create text editor and Debugger Pane
	    dsd = new DefaultStyledDocument();
		dsd.addDocumentListener(new MyDocumentListener());
		textPane = new JTextPane(dsd); // row, column size
		textPane.addCaretListener(new MyCaretListener());
		scrollPane2 = new JScrollPane(textPane);
		debugPane = new DebugPane(this);
		scrollPane2.setAutoscrolls(true);
		dbp_viewport = new JViewport();
		scrollPane2.setViewportView(textPane);
		dbp_viewport = scrollPane2.getViewport();
		dbv_point = new Point(0,0);
		dbp_viewport.setViewPosition(dbv_point);
		splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, debugPane , scrollPane2);
		splitPane.setOneTouchExpandable(true);
		splitPane.setDividerLocation(0);
    	contentPane.add(splitPane, BorderLayout.CENTER);
		// 5. create Event Listeners
		file_Save_menuItem.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
				SaveFile();
			}
		});
		file_Exit_menuItem.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
		        SaveChangeBeforeExit();
			}
		});
	    file_SaveAs_menuItem.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
				SaveAsFile();
			}
		});
		env_setEnv_menuItem.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
				setJDKLoc();
			}
		});
		command_Compile_menuItem.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
				if (currFileName == null) {
					JOptionPane.showMessageDialog(contentPane,"No Java source code to compile",
					"Error",JOptionPane.ERROR_MESSAGE);
				} else {
					SaveFile();
				    compileDlg = new CompileDlg(currFileName, JDKLoc);
					Dimension compileDlgSize = compileDlg.getSize();
					Dimension compileFrmSize = getSize();
					Point loc = getLocation();
					compileDlg.setLocation((compileFrmSize.width - compileDlgSize.width) / 2 + loc.x, (compileFrmSize.height - compileDlgSize.height) / 2 + loc.y);
					compileDlg.setModal(true);
					compileDlg.show();
				}
			}
		});
		command_Execute_menuItem.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
				if (currFileName == null) {
					JOptionPane.showMessageDialog(contentPane,"No Java class file to execute",
					"Error",JOptionPane.ERROR_MESSAGE);
			    } else {
					SaveFile();
					compileDlg = new CompileDlg(currFileName, JDKLoc);
					if (compileDlg.compileBeforeExec()) {
						JOptionPane.showMessageDialog(contentPane, "There are some errors in your source code; please edit and compile it again.");
						return;
					}
					ExecuteDlg executeDlg = new ExecuteDlg(currPath, currJavName, JDKLoc);
					Dimension executeDlgSize = executeDlg.getSize();
					Dimension executeFrmSize = getSize();
					Point loc = getLocation();
					executeDlg.setLocation((executeFrmSize.width - executeDlgSize.width) / 2 + loc.x, (executeFrmSize.height - executeDlgSize.height) / 2 + loc.y);
					executeDlg.setModal(true);
					executeDlg.show();
				}
			}
		});
		command_Debug_menuItem.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
				if (currFileName != null) {
					SaveFile();
					compileDlg = new CompileDlg(currFileName, JDKLoc);
					if (compileDlg.compileBeforeExec()) {
						JOptionPane.showMessageDialog(contentPane, "There are some errors in your source code; please edit and compile it again.");
						return;
					}
					int editHeight = scrollPane2.getHeight();
					editHeight = editHeight / 2;
					threshold = (int) editHeight / 2;
					debugPane.startIt();
					splitPane.setDividerLocation(270);
				} else {
					JOptionPane.showMessageDialog(contentPane,"No Java source code to debug",
						"Error",JOptionPane.ERROR_MESSAGE);
				}
			}
		});
	}
	void setJDKLoc() {
		// remove acceptAllFileFilter
		fileChooser.removeChoosableFileFilter(fileChooser.getAcceptAllFileFilter());
		// set file filter
		fileChooser.setFileFilter(new FileFilter() {
			public boolean accept(File f) {
				return f.getName().toLowerCase().equals("javac.exe") || f.isDirectory();
			}
			public String getDescription() {
				return "Java compiler (javac.exe)";
			}
		});
		int returnVal = fileChooser.showOpenDialog(this);
		//set file filter
		if (returnVal == JFileChooser.APPROVE_OPTION) {
			JDKLoc = fileChooser.getCurrentDirectory().toString();

		}
	}
	boolean SaveFile() {
		if (currFileName == null) {
			return SaveAsFile();
		}
		try {
			File file = new File(currFileName);
			FileWriter out = new FileWriter(file);
			String text = textPane.getText();
		    out.write(text);
			out.close();
			dirty = false;
			this.setTitle(currFileName);
			return true;
		}
		catch(IOException e) {}
		return false;
	}
	boolean SaveChangeBeforeExit() {
        if (dirty) {
			int optionPane = JOptionPane.showConfirmDialog(contentPane,"Save change before exit?",
				"Save change?" ,JOptionPane.YES_NO_CANCEL_OPTION);
			if (optionPane == JOptionPane.YES_OPTION) {
				SaveFile();
			} else if (optionPane == JOptionPane.NO_OPTION) {
				this.dispose();
			}
        }
        return true;
	}
	boolean SaveAsFile() {
		// remove acceptAllFileFilter
		fileChooser.removeChoosableFileFilter(fileChooser.getAcceptAllFileFilter());
		// set file filter
		fileChooser.setFileFilter(new FileFilter() {
			public boolean accept(File f) {
				return f.getName().toLowerCase().endsWith(".java") || f.isDirectory();
			}
			public String getDescription() {
				return "Java source code (*.java)";
			}
		});

		if (JFileChooser.APPROVE_OPTION == fileChooser.showSaveDialog(this)) {
			currFileName = fileChooser.getSelectedFile().getPath();
			if (!currFileName.endsWith(".java")) {
				currFileName = currFileName+".java";
			}
			return SaveFile();
		} else {
			this.repaint();
			return false;
		}
	}
	protected SimpleAttributeSet[] initAttributes(int length) {
        //Hard-code some attributes.
        SimpleAttributeSet[] attrs = new SimpleAttributeSet[length];
        // normal text
        attrs[0] = new SimpleAttributeSet();
        StyleConstants.setFontFamily(attrs[0], "SansSerif");
        StyleConstants.setFontSize(attrs[0], 12);
        // breakpoint setted text...
        attrs[1] = new SimpleAttributeSet(attrs[0]);
        StyleConstants.setBold(attrs[1], true);
        StyleConstants.setForeground(attrs[1], Color.red);
        StyleConstants.setBackground(attrs[1], Color.green);
        // step text
        attrs[2] = new SimpleAttributeSet(attrs[0]);
        StyleConstants.setBold(attrs[2], true);
        StyleConstants.setForeground(attrs[2], Color.blue);
        return attrs;
    }
	protected class MyDocumentListener
                    implements DocumentListener {
		public void insertUpdate(DocumentEvent e) {
			dirty =  true;
		}
		public void removeUpdate(DocumentEvent e) {
			dirty =  true;
		}
		public void changedUpdate(DocumentEvent e) {
			dirty =  true;
		}
    }
	public class MyCaretListener
                  implements CaretListener {
		public void caretUpdate(CaretEvent e) {
			debugPane.dot = e.getDot();
			try {
				debugPane.caretCoords = textPane.modelToView(debugPane.dot);
			} catch (BadLocationException ble) {}
		}
	}
}