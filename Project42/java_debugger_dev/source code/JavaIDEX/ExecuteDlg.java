package JavaIDEX;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.swing.*;

public class ExecuteDlg extends JDialog {
	final Box contentPane = Box.createVerticalBox();
	JPanel subPane1,subPane2;
	JTextField options_TF, args_TF;
	JButton start_button;
  JTextArea result_TA;
  JScrollPane resultPane;
	String currPath = null;
  String currJavName = null;
  String JDKLoc;
  JViewport viewport;
  Point viewportPos;

	public ExecuteDlg(String s1, String s2, String s3) {
		currPath = s1;
    currJavName = s2;
    JDKLoc = s3;

		setTitle("Executing");
		// create content pane
		Box contentPane = Box.createVerticalBox();
		contentPane.add(Box.createGlue());
		// create sub pane 1
		subPane1 = new JPanel();
		subPane1.setLayout(new FlowLayout());
		subPane1.add(new JLabel("options     "));
		options_TF = new JTextField(15);
		subPane1.add(options_TF);
    contentPane.add(subPane1);

    subPane2 = new JPanel();
    subPane2.add(new JLabel("arguments"));
		args_TF = new JTextField(15);
		subPane2.add(args_TF);
		contentPane.add(subPane2);

		start_button = new JButton("start");
		contentPane.add(start_button);

    result_TA = new JTextArea(5,10);
    resultPane = new JScrollPane(result_TA);
		contentPane.add(new JLabel("result"));
		contentPane.add(resultPane);
    resultPane.setAutoscrolls(true);
    viewport = new JViewport();
    resultPane.setViewportView(result_TA);
    viewportPos = new Point(0,0);
    viewport.setViewPosition(viewportPos);



		getContentPane().add(contentPane,"Center");
		setSize(250,250);

  // create event listener
    start_button.addActionListener(new ActionListener()  {
      public void actionPerformed(ActionEvent e) {
        execute();

	    }
    });
  }

  private void execute() {
	  Runtime rt;
    //Properties property;
    rt = Runtime.getRuntime();
	  try {
		  Process p = rt.exec(JDKLoc + "\\java.exe" +" -classpath "+ currPath + " " + options_TF.getText() +" " +currJavName + " " + args_TF.getText());
		  try {
			  p.waitFor();

        InputStream in = p.getErrorStream();
			  InputStreamReader rin = new InputStreamReader(in);
			  BufferedReader bin = new BufferedReader(rin);
        String temp;
        result_TA.setText("");
        temp = bin.readLine();
        while (temp != null){
			    result_TA.append(temp+"\n");
          temp = bin.readLine();
        }

        in = p.getInputStream();
			  rin = new InputStreamReader(in);
			  bin = new BufferedReader(rin);
        temp = bin.readLine();
        while (temp != null){
			    result_TA.append(temp+"\n");
          temp = bin.readLine();
        }
        viewport.setViewPosition(viewportPos);
        result_TA.repaint();
			  rt.freeMemory();

      }catch (InterruptedException e){


		  }
    } catch (IOException e) {

    }
  }
}
