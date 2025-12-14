package IsecQ;
import java.awt.*;
class Abouts extends Dialog
{  	Image ii1;
      public Abouts(Frame parent)
      {  	super(parent, "About SICQ", true);
	      Toolkit tk = getToolkit();
	      ii1 = tk.getImage("IsecQ/images/logo_java2.jpg");
	      Panel pb = new Panel();
	      pb.setFont(new Font("DialogInput",Font.PLAIN ,12));
	      pb.setLayout(new FlowLayout());
	      pb.add(new Button("   OK   "));
	      add("South", pb);
	      resize(370, 230);
	      move(100, 100); 
	      setResizable(false);
   	}
      public void paint(Graphics g) 
      {	g.setFont(new Font("DialogInput", Font.PLAIN, 14));
	      g.setColor(Color.lightGray);				g.fill3DRect(7, 25, 355, 160, true);
	      g.setColor(Color.black);
	      g.drawImage(ii1, 20, 40 , this);			g.draw3DRect(19, 39, 77, 130, true);
	      g.draw3DRect(16, 36, 83, 136, true);      g.draw3DRect(6, 24, 357, 162, true);
	      g.drawString("  Mr. Teerapong Hempruchayakul", 115, 43);
	      g.drawString("       Mr. Weera Wiangchaisree", 115, 58);
	      g.drawString("                        (Advisor)", 115, 80);
	      g.drawString("  Mr. Akkradach Watcharapupong", 115, 93);
	      g.drawString("            Mr. Thana Hongsuwan", 115, 106);
	      //g.setColor(Color.lightGray);
		//g.draw3DRect(115, 87, 190, 18, false);	//Line in
		//g.drawRect(140, 105, 140, 1);	//Line in
		//g.clearRect(135, 105, 150, 1);	//Line in
		g.setColor(Color.black);
		//g.drawString("----------------------------------------------", 115, 90);
	      g.drawString("               ¹ÒÂ¸ÕÃ¾§Èì àËÁ»ÃÑªÂ¡ØÅ", 115, 126);
	      g.drawString("                   ¹ÒÂÇÕÃÐ àÇÕÂ§ªÑÂÈÃÕ", 115, 141);
	      g.drawString("     Copyright 1999 ISAG-lab, Inc.", 115, 158);
	      g.drawString("                      IsagQ v1.00", 115, 172);
      }
      public boolean handleEvent(Event evt)
      {	if (evt.id == Event.WINDOW_DESTROY) { dispose(); return true; }
		if ("   OK   ".equals(evt.arg)) { dispose(); return true; }
      		else return super.handleEvent(evt);
      }
}