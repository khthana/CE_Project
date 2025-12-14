import java.awt.Point;

public class Fire extends Thread {
  private DataCenter dataCenter;
  private Point position;
  private int direction;
  private int times;
  private boolean dead;
  private int speedX,speedY;
  private Point minPoint,maxPoint;

  private final static int SPEED = 40;

  public Fire(Point op,int dir,int time,DataCenter dc) {
	  dataCenter = dc;
	  direction = dir % 360;
    position = new Point(op.x,op.y);
    times = time;
	  dead = false;
	  speedX = (int)Math.round((double)SPEED * cosine(direction));
	  speedY = (int)Math.round((double)SPEED * sine(direction));
	  minPoint = dataCenter.getMinP();
	  maxPoint = dataCenter.getMaxP();
	  start();
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

  public synchronized Point getPosition() {
	  return position;
  }

  public synchronized boolean isDead() {
	  return dead;
  }

  public synchronized void dead() {
	  dead = true;
  }

  private synchronized void update() {
    int dx,dy,dxp,dyp;

	  if ((position.x < minPoint.x) || (position.y < minPoint.y) ||
	      (position.x > maxPoint.x) || (position.y > maxPoint.y)) {
      dead();
	  } else {
      position.translate(speedX,speedY);
	  }
  }

  public void run() {
  	while(true) {
      if (!dead) update();
   	  try {
  		  Thread.sleep(times);
  	  } catch(InterruptedException e) {}
  	}
  }
}