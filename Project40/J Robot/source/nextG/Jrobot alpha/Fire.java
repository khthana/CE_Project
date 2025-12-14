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

  public Fire(Point p,int d,int t,DataCenter dc) {
	  dataCenter = dc;
	  direction = d % 360;
    position = p;
	  times = t;
	  dead = false;
	  speedX = (int)(SPEED * cosine(direction));
	  speedY = (int)(SPEED * sine(direction));
	  minPoint = dataCenter.getMinP();
	  maxPoint = dataCenter.getMaxP();
	  start();
  }

  private double cosine(int degree) {
    return (double)Math.cos(toRadian(degree));
  }
  
  private double sine(int degree) {
    return -(double)Math.sin(toRadian(degree));
  }

  private double toRadian(int degree) {
	  return (double)((degree * Math.PI) / 180);
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
	  if ((position.x < minPoint.x) || (position.y < minPoint.y) ||
	      (position.x > maxPoint.x) || (position.y > maxPoint.y)) {
	    dead();
      stop();
	  } else {
      position.translate(speedX,speedY);
	  }
  }

  public void run() {
  	while(true) {
  	  update();
  	  try {
  		Thread.sleep(times);
  	  } catch(InterruptedException e) {}
  	}
  }
}