import java.awt.Point;
import java.awt.Dimension;

public class Model extends Thread {

  private DataCenter dataCenter;
  private int speed;
  private int robotID;
  private int sleepTime;
  private Fire fire[];
  private int fireWait[];
  private Point minPoint,maxPoint;
// =======================================================================
  public final static int NOTSCAN = -1;
  private final static int ERROR = -1000;
// =======================================================================
  private int testDir;
  private int testScan;
  private int testDistance;
// =======================================================================

  public Model(int rid,DataCenter dc) {
	  dataCenter = dc;
	  robotID = rid;
    sleepTime = dataCenter.getRobotSleepTime();
    speed = 0;
    minPoint = new Point(dataCenter.getMinP().x +
                                    dataCenter.getRobotSize().width,
                         dataCenter.getMinP().y +
                                    dataCenter.getRobotSize().height);
    maxPoint = new Point(dataCenter.getMaxP().x -
                                    dataCenter.getRobotSize().width,
                         dataCenter.getMaxP().y -
                                    dataCenter.getRobotSize().height);
	  dataCenter.setRobotPosition(robotID,
                 new Point(minPoint.x + (int)Math.round(Math.random() *
                                       (double)(maxPoint.x - minPoint.x)),
                           minPoint.y + (int)Math.round(Math.random() * 
                                       (double)(maxPoint.y - minPoint.y))));
	  dataCenter.setRobotDirection(robotID,
                            (int)Math.round(Math.random() * (double)360));
    dataCenter.setScanDirection(robotID,NOTSCAN);
    dataCenter.setScanArc(robotID,NOTSCAN);
    fire = new Fire[dataCenter.NUMFIRE];
    fireWait = new int[dataCenter.NUMFIRE];
    for (int i = 0; i < dataCenter.NUMFIRE; i++)
      fireWait[i] = WAITTIME;
	  start();
  }

  private double cosine(int degree) {
    return Math.cos((double)degree * Math.PI / (double)180);
  }
  
  private double sine(int degree) {
    return -Math.sin((double)degree * Math.PI / (double)180);
  }

  public synchronized Point getPosition() {
	  return dataCenter.getRobotPosition(robotID);
  }

  public synchronized int getDirection() {
	  return dataCenter.getRobotDirection(robotID);
  }

  public synchronized void decHP() {
    dataCenter.decRobotHP(robotID);
  }

  public synchronized int getHP() {
	  return dataCenter.getRobotHP(robotID);
  }

  public synchronized boolean fireNull(int fid) {
    return fire[fid] == null;
  }

  public synchronized boolean fired(int fid) {
    return fire[fid] != null && !dataCenter.isFireDie(robotID,fid);
  }
  
  public synchronized void killFire(int fid) {
    if (fire[fid] != null) {
      dataCenter.setFireDie(robotID,fid);
      fire[fid].stop();
    }
  }

  public synchronized void releaseFire(int fid) {
    if (fire[fid] != null && dataCenter.isFireDie(robotID,fid)) {
      fireWait[fid] = WAITTIME;
      fire[fid] = null;
    }
  }

  public void absReleaseFire() {
    for (int i = 0; i < dataCenter.NUMFIRE; i++) {
      if (fire[i] != null) {
        dataCenter.setFireDie(robotID,i);
        fire[i].stop();
        fire[i] = null;
      }
    }
  }

  public synchronized void fire(int dir) {
	  Point p,position;
	  double fRadius;
    int fid;
    boolean done;

	  dir = dir % 360;
    for (int i = 0; i < dataCenter.NUMFIRE; i++)
      releaseFire(i);
    position = dataCenter.getRobotPosition(robotID);
    done = false;
    fid = 0;
    while (fid < dataCenter.NUMFIRE && !done) {
	    if (fire[fid] == null && fireWait[fid] == 0) {
	      fRadius = (double)dataCenter.getRobotSize().width / (double)4;
	      p = new Point(position.x +
                        (int)Math.round(fRadius * cosine(dir)),
	                    position.y +
                        (int)Math.round(fRadius * sine(dir)));
        fire[fid] = new Fire(robotID,fid,p,dir,dataCenter);
        done = true;
      }
      fid += 1;
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
    Point position,newPosition;
    int direction;

    rotate = false;
    position = dataCenter.getRobotPosition(robotID);
    direction = dataCenter.getRobotDirection(robotID);
    if (sp < 0) sp = 0;
    if (Math.abs(speed - sp) > 3) {
      if (sp > speed)
        speed += 3;
      else
        speed -= 3;
    } else {
      speed = sp;
    }
    if (speed > 10) speed = 10;
    if (speed < 0) speed = 0;
    newDir = newDir % 360;
    if ((newDir != direction) && (speed > 5)) {
      speed = 5;
    }
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
    dataCenter.setRobotDirection(robotID,direction);
    tmpx = (int)Math.round((double)speed * cosine(direction));
    tmpy = (int)Math.round((double)speed * sine(direction));
    newPosition = new Point(position.x + tmpx,position.y + tmpy);
    if (!((newPosition.x < minPoint.x) || (newPosition.x > maxPoint.x) ||
          (newPosition.y < minPoint.y) || (newPosition.y > maxPoint.y))) {
      if (!collision(newPosition)) {
        dataCenter.setRobotPosition(robotID,newPosition);
      }
    }
  }

  private boolean collision(Point pos) {
	  boolean collide;
	  Point tmpp;

	  collide = false;
	  for (int i = 0; i < dataCenter.NUMROBOT; i++) {
	    if (!collide && i != index && !dataCenter.getDieFlag(i)) {
		    tmpp = dataCenter.getRobotPosition(i);
		    collide = isIntersect(pos,tmpp,imageSize);
	    }
	  }
	  return collide;
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
    return dataCenter.getRobotScanDir(robotID);
  }

  public synchronized int getScanArc() {
    return dataCenter.getRobotScanArc(robotID);
  }
  
  public synchronized boolean scan(int dir,int arc) {
    Point position,target;
    int rotate;
    int shortest;
    int scanArc;
    int distance;
    boolean found;

    position = dataCenter.getRobotPosition(robotID);
    shortest = 0;
    rotate = 0;
    found = false;
    if (arc > 10) arc = 10;
    dataCenter.setRobotScanDir(robotID,dir);
    dataCenter.setRobotScanArc(robotID,arc);
    if (dir < 15 || dir > 345) {
      rotate = 180;
      dir = (dir + rotate) % 360;
    }
    for (int i = 0; i < dataCenter.getNumberRobot(); i ++) {
      if (i != index && !dataCenter.isRobotDie(i)) {
        target = dataCenter.getRobotPosition(i);
        distance = distance(position,target);
        if (distance <= dataCenter.SCANLENGTH) {
          targetDir = (findDir(position,target) + rotate) % 360;
          if (targetDir > (dir - arc) && targetDir < (dir + arc)) {
            if ((shortest == 0) || (shortest > distance))
              shortest = distance;
              found = true;
          }
        }
      }
    }
    return found;
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
    retDir = arctan(dy,dx);
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
    if (dx >= 0)
      return (retval + 360) % 360;
    else
      return (retval + 180) % 360;
  }

  public void run() {
    boolean foundBefore = false;
    boolean scanFound;

    testDir = (int)Math.round((Math.random() * (double)360));
    while(true) {
      if (foundBefore) {
        scanFound = scan(testDir + 10,10);
        if (scanFound) {
          testDir += 10;
        } else {
          testDir -= 10;
        }
        foundBefore = false;
      }
      scanFound = scan(testDir,10);
      if (scanFound) {
        fire(testDir + 5);
        fire(testDir - 5);
        foundBefore = true;
      } else {
        move(testDir,10);
        testDir = (testDir + 3) % 360;
      }
      for (int i = 0; i < NUMFIRE; i++) {
        if (fireWait[i] > 0)
          fireWait[i] -= 1;
      }
	    try {
		    Thread.sleep(times);
	    } catch(InterruptedException e) {}
	  }
  }
}