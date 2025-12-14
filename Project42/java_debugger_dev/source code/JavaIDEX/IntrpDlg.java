package JavaIDEX;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.swing.*;

public class IntrpDlg extends JDialog {
	final Box contentPane = Box.createVerticalBox();
	JPanel subPane1,subPane2;
	JTextField options_TF;
	JButton start_button;
	JProgressBar progressBar;
	JTextArea result_TA;
	String currFileName = null;
  String JDKLoc;

	public IntrpDlg(String s1, String s2) {
		currFileName = s1;
    JDKLoc = s2;
		setTitle("Interpret...");
		// create content pane
		//Box contentPane = Box.createVerticalBox();
		contentPane.add(Box.createGlue());
		// create sub pane 1
		subPane1 = new JPanel();
		subPane1.setLayout(new FlowLayout());
		subPane1.add(new JLabel("options"));
		options_TF = new JTextField(15);
		subPane1.add(options_TF);
		contentPane.add(subPane1);

		start_button = new JButton("start");
		contentPane.add(start_button);
		 // create sub pane 2

		subPane2 = new JPanel();
 		subPane2.setLayout(new FlowLayout());
	 	subPane2.add(new JLabel("progress"));
		progressBar = new JProgressBar();
		subPane2.add(progressBar);
		contentPane.add(subPane2);

		contentPane.add(new JLabel("result"));
		result_TA = new JTextArea();
		contentPane.add(result_TA);

		getContentPane().add(contentPane,"Center");
		setSize(250,150);

  // create event listener
    start_button.addActionListener(new ActionListener()  {
      public void actionPerformed(ActionEvent e) {
		    if (currFileName == null) {
			    JOptionPane.showMessageDialog(contentPane,"No Java source code to compile",
			    "Error",JOptionPane.ERROR_MESSAGE);
		    }
		    else {
			    interpret();
		    }
	    }
    });
  }

  private void interpret() {
	  Runtime rt;
    //Properties property;
    rt = Runtime.getRuntime();
	  try {
		  Process p = rt.exec(JDKLoc + "\\javac.exe" + " "+"-g" +" "+ options_TF.getText() +" " +currFileName);
		  try {
			  p.waitFor();
      }
      catch (InterruptedException e){
			  InputStream in = p.getInputStream();
			  InputStreamReader rin = new InputStreamReader(in);
			  BufferedReader bin = new BufferedReader(rin);
			  System.out.println(bin.readLine());
			  result_TA.setText(bin.readLine());
			  rt.freeMemory();

        InputStream out = p.getErrorStream();
        InputStreamReader rout = new InputStreamReader(out);
        BufferedReader bout = new BufferedReader(rout);
			  JOptionPane.showMessageDialog(this,"complete compilation without error",
			  "Completely compiled",JOptionPane.INFORMATION_MESSAGE );
		  }
    } catch (IOException e) {

    }
  }
}
