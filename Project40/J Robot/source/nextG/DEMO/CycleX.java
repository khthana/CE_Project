import java.awt.Point;

public class CycleX extends Model {
  int testDir;
  
  public CycleX(int idx,DataCenter dc,int t) {
    super(idx,dc,t);
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