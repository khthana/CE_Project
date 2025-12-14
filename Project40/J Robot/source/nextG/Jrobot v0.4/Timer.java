public class Timer extends Thread {
  private int time;
  private DataCenter dataCenter;

  private final static int SLEEPTIME = 1000;

  public Timer(DataCenter dc) {
    dataCenter = dc;
    time = dataCenter.MAXTIME;
    dataCenter.setTime(time);
    start();
  }
  
  public void run() {
    while(time >= 0) {
      dataCenter.setTime(time);
      try {
        Thread.sleep(SLEEPTIME);
      } catch(InterruptedException e) {}
      time -= 1;
    }
  }
}