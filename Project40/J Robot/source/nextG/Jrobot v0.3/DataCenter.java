import java.awt.Point;
import java.awt.Dimension;

public class DataCenter {
  private int numberRobot;
  private Point position[];
  private boolean die[];
  private Dimension imageSize;
  private Point minPoint;
  private Point maxPoint;
  private int time;

  public final static int MAXTIME = 3000;

  public DataCenter(Point minp,Point maxp,int number) {
	  minPoint = minp;
	  maxPoint = maxp;
	  numberRobot = number;
	  position = new Point[numberRobot];
    die = new boolean[numberRobot];
	  for (int i = 0; i < numberRobot; i++) {
	    position[i] = new Point(0,0);
      die[i] = false;
    }
	  imageSize = new Dimension();
  }

  public Point getMaxP() {
	  return maxPoint;
  }

  public Point getMinP() {
	  return minPoint;
  }

  public int getNumberRobot() {
	  return numberRobot;
  }

  public void setPosition(int index,Point p) {
	  position[index] = p;
  }

  public Point getPosition(int index) {
	  return position[index];
  }

  public Point getTopLeftPosition(int index) {
	  return new Point(position[index].x - (imageSize.width / 2),
	                   position[index].y - (imageSize.height / 2));
  }

  public void setDieFlag(int index) {
    die[index] = true;
  }

  public boolean getDieFlag(int index) {
	  return die[index];
  }

  public void setImageSize(int width,int height) {
	  imageSize = new Dimension(width,height);
  }

  public Dimension getImageSize() {
	  return imageSize;
  }
  
  public synchronized void setTime(int t) {
    time = t;
  }
  
  public synchronized int getTime() {
    return time;
  }
}