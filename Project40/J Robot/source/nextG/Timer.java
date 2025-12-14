public class Timer extends Thread {
  private DataCenter dataCenter;

  private final static int ONESEC = 1000;

  public Timer(DataCenter dc) {
    dataCenter = dc;
    dataCenter.iniTime();
    start();
  }

  public void run() {
    while(dataCenter.getTime() >= 0) {
      try {
        Thread.sleep(ONESEC);
      } catch(InterruptedException e) {}
      dataCenter.setTime();
    }
  }
}