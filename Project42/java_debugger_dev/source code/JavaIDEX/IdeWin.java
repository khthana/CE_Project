package JavaIDEX;
import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import javax.swing.*;
import javax.swing.filechooser.*;
public class IdeWin extends JFrame{
	//JPanel contentPane;
	JDesktopPane contentPane;
	JMenuBar menuBar;
	JMenu fileMenu, envMenu;
	JToolBar toolBar,taskBar;
	JButton new_button, open_button, save_button, file_button;
	EditWin editWin;  
	final JFileChooser fileChooser = new JFileChooser();
	static String currPath = null, currFileName = null, currJavName = null;
	public IdeWin() {
		toolBar = new JToolBar();
                new_button = new JButton(new ImageIcon("images/new.gif"));
		toolBar.add(new_button);
                open_button = new JButton(new ImageIcon("images/open.gif"));
		toolBar.add(open_button);
		contentPane = new JDesktopPane();
		//contentPane = new JPanel();
		//contentPane.setPreferredSize(new Dimension(400, 100));
		contentPane.setLayout(new BorderLayout());
		contentPane.add(toolBar, BorderLayout.NORTH);
		
		//contentPane.add(desktopPane, BorderLayout.CENTER);		
        setContentPane(contentPane); //
		addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
		new_button.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
				createEditWin();
			}
		});
		open_button.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
				openFile();
			}
		});
   		setTitle("KMITL Java Developer v1.0");
		setSize(800, 575);
		setVisible(true);
	}
	protected void createEditWin() {
		editWin = new EditWin();
		contentPane.add(editWin);//
			try {
				editWin.setSelected(true);
			} catch (java.beans.PropertyVetoException e) {}
	}
	protected void createEditWin(String currPath, String currFileName, String currJavName, File file) {
		editWin = new EditWin(currPath, currFileName, currJavName, file);
		contentPane.add(editWin);//
			try {
				editWin.setSelected(true);
			} catch (java.beans.PropertyVetoException e) {}
	}
	protected void openFile() {
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
		int returnVal = fileChooser.showOpenDialog(this);
		// set file filter
		if (returnVal == JFileChooser.APPROVE_OPTION) {
			File file = fileChooser.getSelectedFile();
			// current path + file name"
      currFileName = fileChooser.getSelectedFile().getPath().toString();
			// current path of chosen file
			currPath = fileChooser.getCurrentDirectory().toString();
			// current path + file name exclude ".java"
			String tempN = fileChooser.getName(file);
			int deletePos = tempN.indexOf(".java");
			currJavName = tempN.substring(0,deletePos);
			createEditWin(currPath,currFileName,currJavName,file);
		}
	}
}
