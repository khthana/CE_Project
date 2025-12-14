import java.awt.Point;

public class RandoZ extends Model {
  int movedir;
  int scandir;
  
  public RandoZ(int idx,DataCenter dc,int t) {
    super(idx,dc,t);
  }
  
  public void run() {
    boolean foundBefore = false;
    boolean scanFound;

    movedir = (int)Math.round((Math.random() * (double)360));
    while(true) {
      if (Math.random() < 0.5)
        movedir += 3;
      scandir = (int)Math.round((Math.random() * (double)360));        
      scanFound = scan(scandir,10);
      if (scanFound) {
        fire(scandir + 3);
        fire(scandir - 3);
      }
      move(movedir,10);
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