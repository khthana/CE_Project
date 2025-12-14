//
//        J Robot Next Generation
//
// Player 1 => Red
// Player 2 => Blue
// Player 3 => Yellow
// Player 4 => Green

import java.applet.Applet;
import java.awt.*;
import java.rmi.*;
import java.rmi.server.*;

public class BattleViewer extends Applet implements Runnable {
  RemoteService dataCenter;
  String url = "rmi://161.246.6.93/jrobot/demo/rmi/";

  Image images[][];
  MediaTracker tracker;
  int screenWidth,screenHeight;

  Color rColor[];
  Color titleColor;
  int rgb,cStep,currentColor;
  Image digit[];
  Image colon;
  Image bgImage;

  Image bufferImage;
  Graphics bufferGraphics;
  Thread mainThread;

  Point minP,maxP;
  int numRobot;
  int numFire;
  int sleeptime;

  final static int MINX = 142;
  final static int MINY = 0;
  final static int GUNLENGTH = 10;
  final static int BASEY = 55;
  final static int BASEX = 15;
  final static int RUNNING = 0;
  final static int GAMEOVER = 1;
  final static int GAMEDRAW = 2;
  final static int NOTSCAN = -1;

  // Color for each Robot...
  final static int RED = 0;
  final static int BLUE = 1;
  final static int YELLOW = 2;
  final static int GREEN = 3;

  // Use for indexing to images array...
  final static int NUMPIC = 4;  
  final static int NORM = 0;
  final static int INVT = 1;
  final static int FIRE = 2;
  final static int BOOM = 3;

  // ---------------------------------------------------------------------
  // Initialized all main(global) variable used in this program(class)...
  // ---------------------------------------------------------------------
  public void init() {
    System.setSecurityManager(new StubSecurityManager());
    try {
      dataCenter = (RemoteService)Naming.lookup(url,"DATACENTER");
    } catch(Exception e) {}
    numRobot = dataCenter.NUMROBOT;
    numfire = dataCenter.NUMFIRE;
    sleeptime = dataCenter.SLEEPTIME;
    minP = dataCenter.getMinP();
    maxP = dataCenter.getMaxP();
	  tracker = new MediaTracker(this);
    bgImage = getImage(getCodeBase(),"images/lunar-space.jpg");
    tracker.addImage(bgImage,0);
	  images = new Image[numRobot][NUMPIC];
	  for (int i = 0; i < numRobot; i++) {
	    images[i][0] = getImage(getCodeBase(),"images/ship-nor" + i + ".gif");
	    images[i][1] = getImage(getCodeBase(),"images/ship-inv" + i + ".gif");
	    images[i][2] = getImage(getCodeBase(),"images/fire.gif");
      images[i][3] = getImage(getCodeBase(),"images/boom.gif");
	  }
    colon = getImage(getCodeBase(),"images/colon.gif");
    digit = new Image[10];
    for (int i = 0; i < 10; i++) {
      digit[i] = getImage(getCodeBase(),"images/digit" + i + ".gif");
      tracker.addImage(digit[i],0);
    }
	  for (int m = 0; m < numRobot; m++) {
	    for (int n = 0; n < NUMPIC; n++) {
	      tracker.addImage(images[m][n],0);
	    }
	  }
	  try {
	    tracker.waitForID(0);
	  } catch(InterruptedException e) {}

	  screenWidth = size().width;
	  screenHeight = size().height;
	  cStep = 5;
	  rgb = 0;
	  currentColor = RED;
	  rColor = new Color[8];
	  rColor[0] = Color.red;
	  rColor[1] = Color.blue;
	  rColor[2] = Color.yellow;
	  rColor[3] = Color.green;
	  rColor[4] = new Color(100,0,0);
	  rColor[5] = new Color(0,0,100);
	  rColor[6] = new Color(100,100,0);
	  rColor[7] = new Color(0,100,0);

    timer = new Timer(dataCenter);
	  bufferImage = createImage(screenWidth,screenHeight);
	  bufferGraphics = bufferImage.getGraphics();
  }

  // ---------------------------------------------------------------------
  // After the applet initialized, this method will execute...
  // ---------------------------------------------------------------------
  public void start() {
	  mainThread = new Thread(this);
	  if (mainThread != null) {
	    mainThread.start();
	  }
  }

  // ---------------------------------------------------------------------
  // Run once before the program terminated...
  // ---------------------------------------------------------------------
  public void stop() {
	  if (mainThread != null) {
	    mainThread.stop();
	    mainThread = null;
	  }
  }

  // ---------------------------------------------------------------------
  // The main loop of this class, it will loop forever until user close
  // the program...
  // ---------------------------------------------------------------------
  public void run() {
	  while(!dataCenter.isGameOver()) {
	    repaint();
	    try {
		  mainThread.sleep(sleeptime);
	    } catch(InterruptedException e) {}
	  }
    repaint();
    System.gc();
  }

  // -------------------------------------------------------------------
  // Display the blinking title "J Robot Project I"...
  // -------------------------------------------------------------------
  public void displayTitle(Graphics gg) {
    Font font = new Font("Dialog",Font.BOLD,12);
	  gg.setFont(font);
	  if (((rgb + cStep) <= 0) || ((rgb + cStep) >= 255)){
	    if ((rgb + cStep) <= 0)
		    currentColor = (currentColor + 1) % 5;
	    cStep = -cStep;
	  }
	  rgb = (rgb + cStep);
    
	  switch(currentColor) {
	  case RED:
	    titleColor = new Color(rgb,0,0);
	    break;
	  case BLUE:
	    titleColor = new Color(0,0,rgb);
	    break;
	  case YELLOW:
	    titleColor = new Color(rgb,rgb,0);
	    break;
	  case GREEN:
	    titleColor = new Color(0,rgb,0);
	    break;
	  default:
	    titleColor = new Color(rgb,rgb,rgb);
	  }
      
    gg.setColor(titleColor);
	  gg.drawString("J Robot Project I",22,30);
  }

  public void displayTime(Graphics gt) {
    int ntime;
    int min,fsec,ssec;

    ntime = dataCenter.getTime();
    min = ntime / 60;
    ntime = ntime % 60;
    fsec = ntime / 10;
    ssec = ntime % 10;

    gt.drawImage(colon,44,400,this);    
    gt.drawImage(digit[min],26,400,this);
    gt.drawImage(digit[fsec],62,400,this);
    gt.drawImage(digit[ssec],86,400,this);
  }

  public void paint(Graphics g) {
	  if (dataCenter.isGameOver()) {
	    Font font = new Font("TimesRoman",Font.BOLD,36);
	    bufferGraphics.setFont(font);
	    FontMetrics fontMetrics = getFontMetrics(font);
	    String gamedraw,gameover,playerwin;
      int winner;
	    int strWidth,fontHeight;

      winner = dataCenter.getWinner();
	    gamedraw = "GAME DRAW";
	    gameover = "GAME OVER";
	    playerwin = "PLAYER " + (winner + 1) + " WIN";
	    fontHeight = fontMetrics.getHeight();
	    bufferGraphics.setColor(rColor[winner]);
	    if (dataCenter.isGameDraw()) {
		    strWidth = fontMetrics.stringWidth(gamedraw);
        bufferGraphics.setColor(Color.white);
		    bufferGraphics.drawString(gamedraw,(screenWidth + MINX - strWidth)/2,
		                              (screenHeight + MINY - fontHeight)/2);
	    } else {
		    strWidth = fontMetrics.stringWidth(gameover);
		    bufferGraphics.drawString(gameover,(screenWidth + MINX - strWidth)/2,
		                              (screenHeight + MINY - fontHeight)/2);
		    strWidth = fontMetrics.stringWidth(playerwin);
		    bufferGraphics.drawString(playerwin,(screenWidth + MINX - strWidth)/2,
		                              (screenHeight+MINY+fontHeight)/2);
	    }
	  } else {
      Font font = new Font("Dialog",Font.BOLD,12);
      bufferGraphics.setFont(font);
      // -------------------------------------------------------------------
	    // If not GameOver continue the game...
	    // -------------------------------------------------------------------
	    // Clear the right panel (fill in with black color)...
	    // -------------------------------------------------------------------
      bufferGraphics.drawImage(bgImage,MINX,MINY,this);

	    // -------------------------------------------------------------------
	    // Drawing the fire for each robot at right panel, if fired...
	    // -------------------------------------------------------------------
	    for (int rid = 0; rid < numRobot; rid++) {
        Point fPoint;
        int pic;
        
        for (int fid = 0; fid < numFire; fid++) {
          if (!dataCenter.isFireDie(rid,fid)) {
            fPoint = dataCenter.getFirePosition(rid,fid);
            if (dataCenter.isBoom(rid,fid))
              pic = BOOM;
            else
              pic = FIRE;
            bufferGraphics.drawImage(images[i][pic],
                    fPoint.x - images[0][pic].getWidth(this) / 2,
                    fPoint.y - images[0][pic].getHeight(this) / 2,this);
          }
        }
	    }

	    // -------------------------------------------------------------------
	    // Drawing the picture of each robot on the right panel...
	    // -------------------------------------------------------------------
	    for (int rid = 0; rid < numRobot; rid++) {
		    if (!dataCenter.isRobotDie(rid)) {
		      Point p;
		      int rDir;

		      p = dataCenter.getTopLeftPosition(rid);
		      if (dataCenter.isHitRobot(rid)) {
		        bufferGraphics.drawImage(images[rid][INVT],p.x,p.y,this);
            dataCenter.resetHitRobot(rid);
		      } else {
			      bufferGraphics.drawImage(images[rid][NORM],p.x,p.y,this);
		      }
		      p = dataCenter.getRobotPosition(rid);
		      rDir = dataCenter.getRobotDirection(rid);
		      bufferGraphics.setColor(Color.black);
		      bufferGraphics.drawLine(p.x,p.y,
                           p.x + (int)((double)GUNLENGTH * cosine(rDir)),
			                     p.y + (int)((double)GUNLENGTH * sine(rDir)));
		    }
	    }

	    // -------------------------------------------------------------------
	    // Drawing the scan line for each robot at the right panel...
	    // -------------------------------------------------------------------
      for (int rid = 0; rid < numRobot; rid++) {
 		    if (!dataCenter.isRobotDie(rid) &&
            dataCenter.getRobotScanArc(rid) != NOTSCAN) {
		      Point robotP;
          Point scanP1,scanP2;
		      int length;
    		  int scanDir,scanArc;

		      robotP = dataCenter.getRobotPosition(rid);
		      length = dataCenter.SCANLENGTH;
		      scanDir = dataCenter.getRobotScanDir(rid);
          scanArc = dataCenter.getRobotScanArc(rid);
          scanP1 = new Point(robotP.x + (int)((double)length *
                                 cosine((scanDir + scanArc) % 360)),
                             robotP.y + (int)((double)length *
                                 sine((scanDir + scanArc) % 360)));
          scanP2 = new Point(robotP.x + (int)((double)length *
                                 cosine((scanDir - scanArc + 360) % 360)),
                             robotP.y + (int)((double)length *
                                 sine((scanDir - scanArc + 360) % 360)));
		      bufferGraphics.setColor(Color.cyan);
          bufferGraphics.drawLine(robotP.x,robotP.y,scanP1.x,scanP1.y);
          bufferGraphics.drawLine(robotP.x,robotP.y,scanP2.x,scanP2.y);
        }
	    }

	    // -------------------------------------------------------------------
	    // Clear the left panel and then drawing the border of both panel...
	    // -------------------------------------------------------------------
	    bufferGraphics.setColor(Color.black);
	    bufferGraphics.fillRect(0,0,MINX-1,screenHeight);
	    bufferGraphics.setColor(Color.orange);
	    bufferGraphics.drawRect(MINX,MINY,screenWidth - MINX - 1,
                                                 screenHeight - MINY - 1);
	    bufferGraphics.drawRect(MINX + 1,MINY + 1,screenWidth - MINX - 3,
	                                               screenHeight - MINY - 3);
	    bufferGraphics.drawRect(0,0,MINX - 1,screenHeight - 1);
	    bufferGraphics.drawRect(1,1,MINX - 3,screenHeight - 3);

	    // -------------------------------------------------------------------
	    // Drawing the project title and the content of the left panel...
	    // -------------------------------------------------------------------
	    int space = (screenHeight - BASEY - 36) / numRobot;
	    for (int k = 0; k < numRobot; k++) {
		    bufferGraphics.setColor(rColor[k]);
		    bufferGraphics.drawString("Player " + (k + 1),10,BASEY + (k * space));
		    bufferGraphics.setColor(rColor[k + 4]);
		    bufferGraphics.fillRect(20,BASEY + 5 + (k * space),100,11);
		    if (dataCenter.getDieFlag(k)) {
		      bufferGraphics.setColor(rColor[k]);
		      bufferGraphics.drawString("---== Dead ==---",25,
                                                BASEY + 15 + (k*space));
		    } else {
		      bufferGraphics.setColor(rColor[k]);
		      bufferGraphics.fillRect(20,BASEY + 5 + (k * space),
                                             dataCenter.getRobotHP(k),11);
		    }
		    Point tmpCrp;

        tmpCrp = dataCenter.getRobotPosition(k);
	      tmpCrp = new Point(tmpCrp.x - MINX,tmpCrp.y);
		    bufferGraphics.setColor(rColor[k]);
		    bufferGraphics.drawString("X >> " + tmpCrp.x,BASEX,
                                     BASEY + 28 + (k * space));
		    bufferGraphics.drawString("Y >> " + tmpCrp.y,75,
                                     BASEY + 28 + (k * space));
        bufferGraphics.drawString("Direction >> " + dataCenter.getRobotDirection(k),
                                     BASEX,BASEY + 40 + (k * space));
		    bufferGraphics.drawString("Scan >> " + dataCenter.getRobotScanDir(k),
                                     BASEX,BASEY + 52 + (k * space));
	    }
	  } // End if ... else ...

	  // ---------------------------------------------------------------------
	  // Display the title and then flush the buffer(image) to the screen...
	  // ---------------------------------------------------------------------
	  displayTitle(bufferGraphics);
    displayTime(bufferGraphics);
	  g.drawImage(bufferImage,0,0,this);
  }

  private double cosine(int degree) {
    return Math.cos((double)degree * Math.PI / (double)180);
  }
  
  private double sine(int degree) {
    return -Math.sin((double)degree * Math.PI / (double)180);
  }

  // -----------------------------------------------------------------------
  // For smooth display, no clipping effect, overide the update method...
  // -----------------------------------------------------------------------
  public void update(Graphics g) {
	  paint(g);
  }
}