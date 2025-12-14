import java.awt.Point;
import java.awt.Dimension;

public class Model extends Thread {

// ============================================================================

  private Point position;
  private int speed;
  private int direction;
  private Dimension imageSize;
  private int hitpoint;
  private int index;
  private int scanDir;
  private int scanArc;

  private Fire fire;

  private Point minPoint,maxPoint;
  private DataCenter dataCenter;
  private int times;

  private int scanInfo[];  // For testing...

// ============================================================================

  public final static int MAXHP = 100;
  public final static int SCANLENGTH = 200;
  public final static int NOTSCAN = -1;
  
  private final static int DECHP = 1;
  private final static int ERROR = -100;

// ============================================================================
  
  private int testDir;
  private int testScan;
  private int testDistance;
  
// ============================================================================
  public Model(Point min,Point max,int sx,int sy,int t,DataCenter dc,int idx) {
	  dataCenter = dc;
	  index = idx;
	  hitpoint = MAXHP;
	  minPoint = min;
	  maxPoint = max;
	  imageSize = new Dimension(sx,sy);
	  position = new Point(minPoint.x + (int)Math.round(Math.random() *
                           (double)(maxPoint.x - minPoint.x)),
                         minPoint.y + (int)Math.round(Math.random() * 
                           (double)(maxPoint.y - minPoint.y)));
	  dataCenter.setPosition(index,position);
	  direction = (int)Math.round(Math.random() * (double)360);
    scanArc = NOTSCAN;
    scanDir = NOTSCAN;
	  times = t;
    scanInfo = new int[2];  // For testing...
	  start();
  }

  //  For testing purpose....
  public int[] getInfo() {
    return scanInfo;
  }
  //  For testing purpose....

  private double cosine(int degree) {
    return Math.cos((double)degree * Math.PI / (double)180);
  }
  
  private double sine(int degree) {
    return -Math.sin((double)degree * Math.PI / (double)180);
  }

  public synchronized Point getPosition() {
	  return position;
  }

  public synchronized int getDirection() {
	  return direction;
  }

  public Dimension getImageSize() {
	  return imageSize;
  }

  public synchronized void decHP() {
    hitpoint -= DECHP;
    if (hitpoint < 0) hitpoint = 0;
    if (hitpoint == 0)
      dataCenter.setDieFlag(index);
  }

  public synchronized int getHP() {
	  return hitpoint;
  }

  public synchronized boolean fired() {
	  if ((fire != null) && (!fire.isDead())) {
	    return true;
	  } else {
	    return false;
	  }
  }
  
  public synchronized void killFire() {
    if (fire != null) {
      fire.dead();
      fire.stop();
    }
  }
  
  public synchronized void releaseFire() {
    if (fire != null && fire.isDead()) {
      fire = null;
    }
  }

  public synchronized Point getfPosition() {
	  if (fired())
	    return fire.getPosition();
    return new Point(ERROR,ERROR);
  }

  public synchronized void fire(int dir) {
	  Point p;
	  int fRadius;

	  dir = dir % 360;
    releaseFire();
	  if (fire == null && !fired()) {
	    fRadius = imageSize.width/2;
	    p = new Point(position.x +
                      (int)Math.round((double)fRadius * cosine(dir)),
	                  position.y +
                      (int)Math.round((double)fRadius * sine(dir)));
      fire = new Fire(p,dir,times,dataCenter);
	  }
  }

  // =======================================================================
  //   Move robot heading to the direction and with the speed specified
  // if speed is less than 0 it will automatically adjust to 0.
  //   Maximum speed value is 10 if specified greater than 10 it will
  // automatically adjust to 10.
  //   The increment or decrement of speed must don't greater than 3 for
  // example if the old speed is 5 and the new specified speed is 9 it will
  // automatically adjust to 8 since the maximum increasing speed value
  // is 3, similar to the case of decreaing speed.
  //   The possible value of direction is between 0 and 359 and the
  // maximum among of direction change is 15 degree.
  // =======================================================================

  public synchronized void move(int newDir,int sp) {
	  boolean rotate;
	  int tmpx,tmpy;
	  Point newPosition;

	  rotate = false;
	  if (sp < 0) sp = 0;
	  if (sp > speed) {
	    if (sp - speed > 3) {
	   	  speed += 3;
	    } else {
		    speed = sp;
	    }
	  } else {
	    if (speed - sp > 3) {
		    speed -= 3;
	    } else {
		    speed = sp;
	    }
	  }
	  if (speed > 10) speed = 10;
	  if (speed < 0) speed = 0;
	  newDir = newDir % 360;
	  if ((newDir <= 15) || (direction <= 15) || (newDir >= 345) ||
        (direction >= 345)) {
	    rotate = true;
	    newDir = (newDir + 180) % 360;
	    direction = (direction + 180) % 360;
	  }
	  if (newDir > direction) {
	    if (newDir - direction > 15)
		    direction += 15;
	    else
		    direction = newDir;
	  } else {
	    if (direction - newDir > 15)
		    direction -= 15;
	    else
		    direction = newDir;
	  }
	  if (rotate)
	    direction = (direction + 180) % 360;
    tmpx = (int)Math.round((double)speed * cosine(direction));
	  tmpy = (int)Math.round((double)speed * sine(direction));
    
    // Testing..
    //System.out.println("Direction = " + direction + " ,Speed = " + speed);
    //System.out.println("tmpx = " + tmpx + " ,tmpy = " + tmpy);
    
	  newPosition = new Point(position.x + tmpx,position.y + tmpy);
	  if (!((newPosition.x < minPoint.x) || (newPosition.x > maxPoint.x) ||
	        (newPosition.y < minPoint.y) || (newPosition.y > maxPoint.y))) {
      if (!collision(newPosition)) {
	      position = newPosition;
	    }
	  }
    dataCenter.setPosition(index,position);
  }

  private boolean collision(Point pos) {
	  boolean collis;
	  Point tmpp;

	  collis = false;
	  for (int i = 0; i < dataCenter.getNumberRobot(); i++) {
	    if (!collis && i != index && !dataCenter.getDieFlag(i)) {
		    tmpp = dataCenter.getPosition(i);
		    collis = isIntersect(pos,tmpp,imageSize);
	    }
	  }
	  return collis;
  }

  private synchronized boolean isIntersect(Point p1,Dimension d1,
                                           Point p2,Dimension d2) {
	  return ((p1.x + d1.width/2 >= p2.x - d2.width/2) &&
	          (p2.x + d2.width/2 >= p1.x - d1.width/2) &&
			      (p1.y + d1.height/2 >= p2.y - d2.height/2) &&
	          (p2.y + d2.height/2 >= p1.y - d1.height/2));
  }

  private synchronized boolean isIntersect(Point p1,Point p2,Dimension d) {
	  return ((p1.x + d.width/2 >= p2.x - d.width/2) &&
	          (p2.x + d.width/2 >= p1.x - d.width/2) &&
			      (p1.y + d.height/2 >= p2.y - d.height/2) &&
	          (p2.y + d.height/2 >= p1.y - d.height/2));
  }

  public synchronized boolean isIntersect(int x1,int y1,int x2,int y2) {
	  return ((x2 >= position.x - imageSize.width/2) &&
	          (position.x + imageSize.width/2 >= x1) &&
	          (y2 >= position.y - imageSize.height/2) &&
			      (position.y + imageSize.height/2 >= y1));
  }

  public synchronized boolean isIntersect(Point p1,Point p2) {
  	return ((p2.x >= position.x - imageSize.width/2) &&
	          (position.x + imageSize.width/2 >= p1.x) &&
  	        (p2.y >= position.y - imageSize.height/2) &&
			      (position.y + imageSize.height/2 >= p1.y));
  }

  public synchronized int getScanDir() {
    return scanDir;
  }

  public synchronized int getScanArc() {
    return scanArc;
  }
  
  public synchronized int scan(int dir,int arc) {
    Point target;
    int rotate;
    int shortest;
    int targetDir;
    int distance;
    int foundDir;  // For testing....
    
    shortest = 0;
    rotate = 0;
    foundDir = -1;  // For testing....
    scanInfo[0] = -1;  // For testing... >> Distance
    scanInfo[1] = -1;  // For testing... >> Diredtion
    if (arc > 10) arc = 10;
    scanDir = dir % 360;
    scanArc = arc;
    if (dir < 15 || dir > 345) {
      rotate = 180;
      dir = (dir + rotate) % 360;
    }
    for (int i = 0; i < dataCenter.getNumberRobot(); i ++) {
      if (i != index && !dataCenter.getDieFlag(i)) {
        target = dataCenter.getPosition(i);
        distance = distance(position,target);
        if (distance <= SCANLENGTH) {
          targetDir = (findDir(position,target) + rotate) % 360;
          //System.out.println(">> " + targetDir + " <<");
          //System.out.println("## " + dir + " ##");
          if (targetDir > (dir - arc) && targetDir < (dir + arc)) {
            if ((shortest == 0) || (shortest > distance))
              shortest = distance;
              foundDir = (targetDir + rotate) % 360;  // For testing...
              scanInfo[0] = shortest;  // For testing...
              scanInfo[1] = foundDir;  // For testing...
              //System.out.println("Yeah!!! Found...");
          }
        }
      }
    }
    // return shortest;
    return foundDir;  // For testing...
  }

  private int findDir(Point o,Point p) {
    int dx,dy;
    int retDir;
    
    dx = p.x - o.x;
    dy = o.y - p.y;
    if (dx == 0) {
      if (dy > 0)
        return 90;
      else
        return 270;
    }
    if (dy == 0) {
      if (dx > 0)
        return 0;
      else
        return 180;
    }
    
    // Problem here .................
    retDir = arctan(dy,dx);
    // Problem here .................

    return retDir;
  }

  private int distance(Point p1,Point p2) {
    return (int)Math.round(Math.sqrt((double)(((p1.x - p2.x) *
             (p1.x - p2.x)) + ((p1.y - p2.y) * (p1.y - p2.y)))));
  }
  
  private int arctan(int dy,int dx) {
    int retval;
    
    retval = (int)Math.round(Math.atan((double)dy / (double)dx) *
                             (double)180 / Math.PI);
    System.out.println("Dy = " + dy + ", Dx = " + dx + ", return >> " + retval);
    if (dx >= 0)
      return (retval + 360) % 360;
    else
      return (retval + 180) % 360;
  }

  public void run() {
    testDir = (int)Math.round((Math.random() * (double)360));
    while(true) {
	    //move(testDir,10);
      testDistance = scan(testDir,10);
      //if (testDistance > 0)
      // For testing...
      if (testDistance != -1) {
        fire(testDistance);
        testDir = testDistance;
      } else {
        testDir = (testDir + 5) % 360;
      }
      // For testing...
	    try {
		    Thread.sleep(times);
	    } catch(InterruptedException e) {}
	  }
  }
}