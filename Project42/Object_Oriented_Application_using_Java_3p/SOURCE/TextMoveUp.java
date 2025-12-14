import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import java.awt.image.*;

public class TextMoveUp extends Applet implements Runnable {

 int  x = 10,j=100;
Image gif=null;
String data1 = " Welcome To ";
String data2 = " WebServer & MailServer";
String data3 = " Version 1.0";
String data4 = " Product by";
String data5 = " Mr. Adisak Pongtipakorn";
String data6 = " Mr. Bunchoy Chuenchom";
Thread t = new Thread(this);
Graphics backBufferG;
Image    backBuffer;

  public void init() {
   setFont(new Font("TimesRoman",Font.PLAIN,13));
//   setBackground(Color.yellow);
   setForeground(Color.blue);

   gif = getImage(getCodeBase(),"gravel.jpg");
   backBuffer  = createImage(145,100);
   backBufferG = backBuffer.getGraphics();

   t.start();

  }


     public void update(Graphics g) 

      {
     backBufferG.clearRect(0,0,145,100);	      
     backBufferG.drawImage(gif,0,0,this);
     putString(backBufferG,j--);
     if (j==-100) j=100;
     g.drawImage(backBuffer,0,0	,this);

     }

  public void paint(Graphics g) 
 {
	update(g);
 }

  public void putString(Graphics g,int y)
  {
  g.drawString(data1,31,y);
  g.drawString(data2,1,y+18);
  g.drawString(data3,36,y+36);
  g.drawString(data4,36,y+54);
  g.drawString(data5,4,y+72);
  g.drawString(data6,4,y+90);
  }

  public void run() 
{
   while(true) 
     {
      try { Thread.sleep(50); }  catch (Exception e) {}
      repaint();
     }
}
 }

 // <applet code="TextMoveUp" width=250 height=100> </applet>
