import java.awt.Point;

public class Fire extends Thread {
  private DataCenter dataCenter;
  private int robotID;
  private int fireID;
  private int sleepTime;
  private int speedX,speedY;

  private final static int SPEED = 40;

  public Fire(int rid,int fid,Point op,int fdir,DataCenter dc) {
    robotID = rid;
    fireID = fid;
	  dataCenter = dc;
    sleepTime = dataCenter.getFireSleepTime();
    dataCenter.setFireDirection(robotID,fireID,fdir);
    dataCenter.setFirePosition(robotID,fireID,new Point(op.x,op.y));
    dataCenter.resetFireDie(robotID,fireID);
	  speedX = (int)Math.round((double)SPEED * cosine(fdir));
	  speedY = (int)Math.round((double)SPEED * sine(fdir));
	  start();
  }

  private double cosine(int degree) {
    return Math.cos((double)degree * Math.PI / (double)180);
  }
  
  private double sine(int degree) {
    return -Math.sin((double)degree * Math.PI / (double)180);
  }

  private synchronized void update() {
    int dx,dy,dxp,dyp;
    Point p,minPoint,maxPoint;

    p = dataCenter.getFirePosition(robotID,fireID);
    minPoint = dataCenter.getMinP();
    maxPoint = dataCenter.getMaxP();
	  if ((p.x < minPoint.x) || (p.y < minPoint.y) ||
	      (p.x > maxPoint.x) || (p.y > maxPoint.y))
      dataCenter.setFireDie(robotID,fireID);
	  else
      dataCenter.setFirePosition(robotID,fireID,
                                 new Point(p.x + speedX,p.y + speedY));
  }

  private void checkHit() {
    Point fp = dataCenter.getFirePosition(robotID,fireID);
    for (int rid = 0; rid < dataCenter.NUMROBOT; rid++) {
      if (rid != robotID && !dataCenter.isRobotDie(rid)) {
        Point rp = dataCenter.getRobotPosition(rid);
        if (intersect(fp,rp)) {
          dataCenter.setHitRobot(rid);
          dataCenter.setFireDie(robotID,fireID);
          dataCenter.setBoom(robotID,fireID,fp);
        }
      }
    }
  }

  private synchronized boolean intersect(Point fp,Point rp) {
    Dimension fsize,rsize;
    
    fsize = dataCenter.getFireSize();
    rsize = dataCenter.getRobotSize();
    return ((fp.x + fsize.width/2 >= rp.x - rsize.width/2) &&
            (rp.x + rsize.width/2 >= fp.x - fsize.width/2) &&
            (fp.y + fsize.height/2 >= rp.y - rsize.height/2) &&
            (rp.y + rsize.height/2 >= fp.y - fsize.height/2));
  }

  public void run() {
  	while(true) {
      checkHit();
      if (!dataCenter.isFireDie(robotID,fireID)) update();
   	  try {
  		  Thread.sleep(sleepTime);
  	  } catch(InterruptedException e) {}
  	}
  }
}