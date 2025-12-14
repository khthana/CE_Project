import java.rmi.*;

public interface RemoteService extends Remote {

  // ============ Global =======================================
  public Point getMaxP() throws RemoteException;
  public Point getMinP() throws RemoteException;
  public void setGameStatus(int stat) throws RemoteException;
  public boolean isRunning() throws RemoteException;
  public boolean isGameOver() throws RemoteException;
  public boolean isGameDraw() throws RemoteException;
  public void setWinner(int win) throws RemoteException;
  public int getWinner() throws RemoteException;

// ============ Class model ===================================
  public int getRobotSleepTime() throws RemoteException;
  public void setRobotPosition(int rid,Point p) throws RemoteException;
  public Point getRobotPosition(int rid) throws RemoteException;
  public Point getTopLeftRobotPosition(int rid) throws RemoteException;
  public void setRobotDirection(int rid,int dir) throws RemoteException;
  public int getRobotDirection(int rid) throws RemoteException;
  public void setRobotScanDir(int rid,int sdir) throws RemoteException;
  public int getRobotScanDir(int rid) throws RemoteException;
  public void setRobotScanArc(int rid,int sarc) throws RemoteException;
  public int getRobotScanArc(int rid) throws RemoteException;
  public void decRobotHP(int rid) throws RemoteException;
  public int getRobotHP(int rid) throws RemoteException;
  public boolean isRobotDie(int rid) throws RemoteException;
  public void setHitRobot(int rid) throws RemoteException;
  public void resetHitRobot(int rid) throws RemoteException;
  public boolean isHitRobot(int rid) throws RemoteException;
  public Dimension getRobotSize() throws RemoteException;

// ============ Class fire ====================================
  public Dimension getFireSize() throws RemoteException;
  public Dimension getBoomSize() throws RemoteException;
  public int getFireSleepTime() throws RemoteException;
  public void setFirePosition(int rid,int fid,Point p) throws RemoteException;
  public Point getFirePosition(int rid,int fid) throws RemoteException;
  public void setBoomPosition(int rid,int fid,Point p) throws RemoteException;
  public Point getBoomPosition(int rid,int fid) throws RemoteException;
  public void setFireDirection(int rid,int fid,int fdir) throws RemoteException;
  public int getFireDirection(int rid,int fid) throws RemoteException;
  public void resetFireDie(int rid,int fid) throws RemoteException;
  public void setFireDie(int rid,int fid) throws RemoteException;
  public boolean isFireDie(int rid,int fid) throws RemoteException;
  public void setBoom(int rid,int fid,Point p) throws RemoteException;
  public void resetBoom(int rid,int fid) throws RemoteException;
  public boolean isBoom(int rid,int fid) throws RemoteException;

// ============ Class timer ===================================
  public void iniTime() throws RemoteException;
  public void setTime() throws RemoteException;
  public int getTime() throws RemoteException;
}