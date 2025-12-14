//
//                         J Robot Next Generation
//
// images[x][0] >> ship-nor.gif >> size 29 x 29 pixel (normal)
// images[x][1] >> ship-inv.gif >> size 29 x 29 pixel (invert)
// images[x][2] >> fire.gif     >> size 10 x 10 pixel
//
// Player 1 => Red
// Player 2 => Blue
// Player 3 => Yellow
// Player 4 => Green

import java.awt.*;

public class Simulator extends java.applet.Applet implements Runnable {
  Image images[][];
  MediaTracker tracker;
  int screenWidth,screenHeight;

  Model robot[];
  Color rColor[];
  boolean hit[];
  int rgb,cStep,currentColor;
  Color titleColor;
  boolean GameOver,GameDraw;
  int winner;
  DataCenter dataCenter;
  Timer timer;
  Image digit[];
  Image colon;

  Image bufferImage;
  Graphics bufferGraphics;
  Thread mainThread;
  Image bgImage;

  final static int MINX = 142;
  final static int MINY = 0;
  final static int NUMROBOT = 4;
  final static int GUNLENGTH = 10;
  final static int BASEY = 55;
  final static int BASEX = 15;
  final static int SLEEPING = 20;

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
	  System.out.println("\n  Starting initialize routine...");
	  System.out.print("   - Loading necessary images...");
	  tracker = new MediaTracker(this);
    bgImage = getImage(getCodeBase(),"images/lunar-space.jpg");
    tracker.addImage(bgImage,0);
	  images = new Image[NUMROBOT][NUMPIC];
	  for (int i = 0; i < NUMROBOT; i++) {
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
	  for (int m = 0; m < NUMROBOT; m++) {
	    for (int n = 0; n < NUMPIC; n++) {
	      tracker.addImage(images[m][n],0);
	    }
	  }
	  try {
	    tracker.waitForID(0);
	  } catch(InterruptedException e) {}
	  System.out.println("done");
	  System.out.print("   - Set up environment variable's value...");
	  screenWidth = size().width;
	  screenHeight = size().height;
    dataCenter = new DataCenter(new Point(MINX,MINY),
	                              new Point(screenWidth,screenHeight),
                                NUMROBOT);
	  dataCenter.setImageSize(images[0][NORM].getWidth(this),
	                          images[0][NORM].getHeight(this));
	  GameOver = false;
	  GameDraw = false;
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
	  robot = new Model[NUMROBOT];
	  hit = new boolean[NUMROBOT];
	  int i = 0;
	  boolean b;
    
    //
    // Random Position for each robot...
    //
	  while (i < NUMROBOT) {
  	  int imageWidth,imageHeight;
      
	    imageWidth = images[i][0].getWidth(this);
	    imageHeight = images[i][0].getHeight(this);
	    robot[i] = new Model(new Point(MINX + imageWidth/2,MINY + imageHeight/2),
	                         new Point(screenWidth - imageWidth/2,
                                     screenHeight - imageHeight/2),
		                       imageWidth,imageHeight,SLEEPING * 2,dataCenter,i);
	    b = false;
      if (i != 0) {
		    Dimension d = dataCenter.getImageSize();
		    for (int j = i - 1; j >= 0; j--) {
		      Point p;
		      p = dataCenter.getTopLeftPosition(j);
		      b = b || robot[i].isIntersect(p.x,p.y,p.x + d.width,p.y + d.height);
		    }
      }
	    if (!b) {
	      hit[i] = false;
		    i += 1;
	    }
	  } // End while loop...

    timer = new Timer(dataCenter);
	  bufferImage = createImage(screenWidth,screenHeight);
	  bufferGraphics = bufferImage.getGraphics();
	  System.out.println("done\n  Initialized done...");
  }

  public void checkGame() {
	  int count = 0;
    int tmphp = 0;

	  for (int i = 0; i < NUMROBOT; i++)
	    if (!dataCenter.getDieFlag(i)) {
		    winner = i;
	      count += 1;
	    }
	  if (count == 1) {
	    GameOver = true;
	    GameDraw = false;
	  } else if (count == 0) {
	    GameOver = true;
	    GameDraw = true;
	  }
    if (!GameOver && dataCenter.getTime() == 0) {
      GameOver = true;
      for (int j = 0; j < NUMROBOT; j++) {
        if (robot[j].getHP() > tmphp) {
          tmphp = robot[j].getHP();
          winner = j;
        } else if (tmphp != 0 && robot[j].getHP() == tmphp) {
          GameDraw = true;
        }
      }
    }
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
	  while(!GameOver) {
	    repaint();
	    checkGame();
	    try {
		  mainThread.sleep(SLEEPING);
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
	  if (GameOver) {

      for (int i = 0; i < NUMROBOT; i++) {
        if (robot[i] != null) {
          robot[i].absReleaseFire();
          robot[i].stop();
          robot[i] = null;
        }
      }
      if (timer != null) {
        timer.stop();
        timer = null;
      }

	    Font font = new Font("TimesRoman",Font.BOLD,36);
	    bufferGraphics.setFont(font);
	    FontMetrics fontMetrics = getFontMetrics(font);
	    String gamedraw,gameover,playerwin;
	    int strWidth,fontHeight;

	    gamedraw = "GAME DRAW";
	    gameover = "GAME OVER";
	    playerwin = "PLAYER " + (winner + 1) + " WIN";
	    fontHeight = fontMetrics.getHeight();
	    bufferGraphics.setColor(rColor[winner]);
	    if (GameDraw) {
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
      // bufferGraphics.setColor(Color.black);
      // bufferGraphics.fillRect(MINX,MINY,screenWidth,screenHeight);
      bufferGraphics.drawImage(bgImage,MINX,MINY,this);

	    // -------------------------------------------------------------------
	    // Drawing the fire for each robot at right panel, if fired...
	    // -------------------------------------------------------------------
	    for (int i = 0; i < NUMROBOT; i++) {
        Point fPoint;
        
		    if (robot[i] != null) {
          for (int fid = 0; fid < robot[i].NUMFIRE; fid++) {
            if (robot[i].fired(fid)) {
		          fPoint = robot[i].getfPosition(fid);
              bufferGraphics.drawImage(images[i][FIRE],
                      fPoint.x - images[0][FIRE].getWidth(this) / 2,
                      fPoint.y - images[0][FIRE].getHeight(this) / 2,this);
            }
          }
        }
	    }

	    // -------------------------------------------------------------------
	    // Checking for fired hitting and if hit decrement HP of hit robot...
	    // -------------------------------------------------------------------
	    for (int i = 0; i < NUMROBOT; i++) {
	  	  if (robot[i] != null) {
          for (int fid = 0; fid < robot[i].NUMFIRE; fid++) {
            if (robot[i].fired(fid)) {
		          Point fp1,fp2,tmpfp;
              
	  	        fp1 = robot[i].getfPosition(fid);
              tmpfp = fp1;
              fp1 = new Point(fp1.x - images[0][FIRE].getWidth(this) / 2,
                              fp1.y - images[0][FIRE].getHeight(this) / 2);
  		        fp2 = new Point(fp1.x + images[0][FIRE].getWidth(this),
                              fp1.y + images[0][FIRE].getHeight(this));
		          for (int j = 0; j < NUMROBOT; j++) {
			          if ((j != i) && (!dataCenter.getDieFlag(j)) &&
			              (robot[j].isIntersect(fp1,fp2))) {
			            robot[j].decHP();
                  bufferGraphics.drawImage(images[i][BOOM],
                      tmpfp.x - (images[i][BOOM].getWidth(this) / 2),
                      tmpfp.y - (images[i][BOOM].getHeight(this) / 2),this);
                  robot[i].killFire(fid);
	  	            hit[j] = true;
                }
              }
			      }
		      }
	  	  }
  	  }

	    // -------------------------------------------------------------------
	    // Drawing the picture of each robot on the right panel...
	    // -------------------------------------------------------------------
	    for (int i = 0; i < NUMROBOT; i++) {
		    if (!dataCenter.getDieFlag(i)) {
		      Point p;
		      int rDir;
		      p = dataCenter.getTopLeftPosition(i);
		      if (hit[i]) {
		        bufferGraphics.drawImage(images[i][INVT],p.x,p.y,this);
            hit[i] = false;
		      } else {
			      bufferGraphics.drawImage(images[i][NORM],p.x,p.y,this);
		      }
		      p = robot[i].getPosition();
		      rDir = robot[i].getDirection();
		      bufferGraphics.setColor(Color.black);
		      bufferGraphics.drawLine(p.x,p.y,
                           p.x + (int)((double)GUNLENGTH * cosine(rDir)),
			                     p.y + (int)((double)GUNLENGTH * sine(rDir)));
		    }
	    }

	    // -------------------------------------------------------------------
	    // Drawing the scan line for each robot at the right panel...
	    // -------------------------------------------------------------------
      for (int i = 0; i < NUMROBOT; i++) {
 		    if (!dataCenter.getDieFlag(i) &&
            robot[i].getScanArc() != robot[i].NOTSCAN) {
		      Point robotP;
          Point scanP1,scanP2;
		      int length;
    		  int scanDir,scanArc;

		      robotP = robot[i].getPosition();
		      length = robot[i].MAXLENGTH;
		      scanDir = robot[i].getScanDir();
          scanArc = robot[i].getScanArc();
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
	    int space = (screenHeight - BASEY - 36) / NUMROBOT;
	    for (int k = 0; k < NUMROBOT; k++) {
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
                                  robot[k].getHP() * 100/robot[k].MAXHP,11);
		    }
		    Point tmpCrp;

        tmpCrp = dataCenter.getPosition(k);
	      tmpCrp = new Point(tmpCrp.x - MINX,tmpCrp.y);
		    bufferGraphics.setColor(rColor[k]);
		    bufferGraphics.drawString("X >> " + tmpCrp.x,BASEX,
                                     BASEY + 28 + (k * space));
		    bufferGraphics.drawString("Y >> " + tmpCrp.y,75,
                                     BASEY + 28 + (k * space));
        bufferGraphics.drawString("Direction >> " + robot[k].getDirection(),
                                     BASEX,BASEY + 40 + (k * space));
		    bufferGraphics.drawString("Scan >> " + robot[k].getScanDir(),
                                     BASEX,BASEY + 52 + (k * space));
	    }
	  } // End if ... else ...
    
    // Releasing the dead robot...
    for (int i = 0; i < NUMROBOT; i++) {
      if (dataCenter.getDieFlag(i)) {
        if (robot[i] != null) {
          boolean noneFire = false;

          for (int fid = 0; fid < robot[i].NUMFIRE; fid++) {
            if (!robot[i].fired(fid)) {
              robot[i].releaseFire(fid);
              if (fid == 0)
                noneFire = true;
              else
                noneFire = noneFire;
            } else {
              noneFire = false;
            }
          }
          if (noneFire)
            robot[i].stop();
        }
      }
    }

	  // ---------------------------------------------------------------------
	  // Display the title and then flush the buffer(image) to the screen...
	  // ---------------------------------------------------------------------
	  displayTitle(bufferGraphics);
    displayTime(bufferGraphics);
	  g.drawImage(bufferImage,0,0,this);
  }

  private double cosine(int degree) {
    return Math.cos(toRadian(degree));
  }
  
  private double sine(int degree) {
    return -Math.sin(toRadian(degree));
  }

  private double toRadian(int degree) {
	  return (double)degree * Math.PI / (double)180;
  }

  // -----------------------------------------------------------------------
  // For smooth display, no clipping effect, overide the update method...
  // -----------------------------------------------------------------------
  public void update(Graphics g) {
	  paint(g);
  }
}