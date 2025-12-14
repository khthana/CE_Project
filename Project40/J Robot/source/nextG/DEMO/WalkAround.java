import java.awt.Point;

public class WalkAround extends Model {
  int scandir;
  int movedir;
  Point myMin;
  Point myMax;
  Point myp;
  
  public WalkAround(int idx,DataCenter dc,int t) {
    super(idx,dc,t);
  }
  
  public void run() {
    boolean scanFound;
    
    myMin = new Point(minPoint.x + (imageSize.width * 2),
                      minPoint.y + (imageSize.height * 2));
    myMax = new Point(maxPoint.x - (imageSize.width * 2),
                      maxPoint.y - (imageSize.height * 2));
    movedir = 0;
    scandir = movedir;
    while(true) {
      move(movedir,10);
      myp = super.getPosition();
      switch (movedir) {
        case 0:
          if (myp.x > myMax.x)
            movedir = 270;
          break;
        case 270:
          if (myp.y > myMax.y)
            movedir = 180;
          break;
        case 180:
          if (myp.x < myMin.x)
            movedir = 90;
          break;
        default:
          if (myp.y < myMin.y)
            movedir = 0;
      }
      scanFound = scan(scandir,10);
      if (scanFound) {
        fire(scandir);
      } else {
        scandir += 3;
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