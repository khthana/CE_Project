import java.awt.*;
import java.awt.event.*;
public class MyFrame extends Frame implements WindowListener {
  public MyFrame()  {
    this.addWindowListener(this);
  }
  public MyFrame(String st) {
    super(st);
    addWindowListener(this);
  }
  public void windowActivated(WindowEvent e) {}
  public void windowClosed(WindowEvent e) {
  }
  public void windowClosing(WindowEvent e) {
      this.dispose();
  }
  public void windowDeactivated(WindowEvent e) {} 
  public void windowDeiconified(WindowEvent e) {} 
  public void windowIconified(WindowEvent e) {} 
  public void windowOpened(WindowEvent e) {} 

}

