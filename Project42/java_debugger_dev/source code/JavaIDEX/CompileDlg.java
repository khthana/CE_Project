package JavaIDEX;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.swing.*;

public class CompileDlg extends JDialog {
	final Box contentPane = Box.createVerticalBox();
	JPanel subPane1,subPane2;
	JTextField options_TF;
	JButton start_button;
  JTextArea result_TA;
	String currFileName = null;
  String JDKLoc;
  JScrollPane resultPane;
  Thread outThread = null;
  Thread errThread = null;
  JViewport viewport;
  Point viewportPos;
  Dimension viewportSize;

	public CompileDlg(String s1, String s2) {
		currFileName = s1;
    JDKLoc = s2;
		setTitle("Compiling");
		// create content pane
		Box contentPane = Box.createVerticalBox();
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

    result_TA = new JTextArea(5,5);
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
        compile();

	    }
    });
  }

  private void compile() {
	  Runtime rt;
    //Properties property;
    rt = Runtime.getRuntime();	  
	  try {

		  Process p = rt.exec(JDKLoc + "\\javac.exe" + " "+"-g" +" "+ options_TF.getText() +" " +currFileName);
		  
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
        viewport.setViewPosition(viewportPos);
        result_TA.repaint();
        JOptionPane.showMessageDialog(this, "Compile complete.");
			  rt.freeMemory();
      }
      catch (InterruptedException e){


		  }
    } catch (IOException e) {

    }
  }

  protected boolean compileBeforeExec() {
	  Runtime rt;
    String temp="xx";
    rt = Runtime.getRuntime();
	  try {
		  Process p = rt.exec(JDKLoc + "\\javac.exe" + " "+"-g" +" "+ options_TF.getText() +" " +currFileName);
		  try {
			  p.waitFor();
        InputStream in = p.getErrorStream();
			  InputStreamReader rin = new InputStreamReader(in);
			  BufferedReader bin = new BufferedReader(rin);
        temp = bin.readLine();
        temp = bin.readLine();
        rt.freeMemory();
      }
      catch (InterruptedException e){}
    } catch (IOException e) {}
    if (temp != null)
      return true; //error, didn't complete compilation
    else return false;

  }


}
