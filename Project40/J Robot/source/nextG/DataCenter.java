import java.awt.Point;
import java.awt.Dimension;
import java.rmi.*;
import java.rmi.server.*;

public class DataCenter extends UnicastRemoteServer implements RemoteService {

// ============ Global =======================================
  private int numberRobot;
  private Point minPoint;
  private Point maxPoint;
  private int gameStatus;
  private int winner;
  private boolean hitRobot[];

// ============ Class model ===================================
  private Point robotPosition[];
  private int robotDirection[];
  private int robotHP[];
  private int robotScanDir[];
  private int robotScanArc[];
  private boolean robotDie[];

// ============ Class fire ====================================
  private Point firePosition[][];
  private Point boomPosition[][];
  private int fireDirection[][];
  private boolean fireDie[][];
  private boolean boom[][];

// ============ Class timer ===================================
  private int gameTime;

// ============ Constant ======================================
  public final static int DECHP = 1;
  public final static int MAXHP = 100;
  public final static int MAXTIME = 300;
  public final static int MAXX = 700;
  public final static int MAXY = 450;
  public final static int MINX = 142;
  public final static int MINY = 0;
  public final static int NUMFIRE = 2;
  public final static int NUMROBOT = 4;
  public final static int SLEEPTIME = 20;
  public final static int SCANLENGTH = 200;
  public final static int RUNNING = 0;
  public final static int GAMEOVER = 1;
  public final static int GAMEDRAW = 2;

// ============================================================

  public DataCenter() throws RemoteException {
	  robotPosition = new Point[NUMROBOT];
    robotDirection = new int[NUMROBOT];
    robotScanDir = new int[NUMROBOT];
    robotScanArc = new int[NUMROBOT];
    robotHP = new int[NUMROBOT];
    robotDie = new boolean[NUMROBOT];
    hitRobot = new boolean[NUMROBOT];
    firePosition = new Point[NUMROBOT][NUMFIRE];
    boomPosition = new Point[NUMROBOT][NUMFIRE];
    fireDirection = new int[NUMROBOT][NUMFIRE];
    fireDie = new boolean[NUMROBOT][NUMFIRE];
    boom = new boolean[NUMROBOT][NUMFIRE];
	  for (int i = 0; i < NUMROBOT; i++) {
	    robotPosition[i] = new Point(0,0);
      robotDirection[i] = 0;
      robotScanDir[i] = 0;
      robotScanArc[i] = 0;
      robotHP[i] = MAXHP;
      robotDie[i] = false;
      for (int j = 0; j < NUMFIRE; j++) {
        firePosition[i][j] = new Point(0,0);
        boomPosition[i][j] = new Point(-100,-100);
        fireDirection[i][j] = 0;
        fireDie[i][j] = true;
        boom[i][j] = false;
      }
    }
    gameStatus = RUNNING;
  }

// ============ Global =======================================
  public Point getMaxP() throws RemoteException {
	  return new Point(MAXX,MAXY);
  }

  public Point getMinP() throws RemoteException {
	  return new Point(MINX,MINY);
  }

  public synchronized void setGameStatus(int stat) throws RemoteException {
    gameStatus = stat;
  }

  public synchronized boolean isRunning() throws RemoteException {
    return gameStatus == RUNNING;
  }
  
  public synchronized boolean isGameOver() throws RemoteException {
    return gameStatus == GAMEOVER;
  }

  public synchronized boolean isGameDraw() throws RemoteException {
    return gameStatus == GAMEDRAW;
  }
  
  public synchronized void setWinner(int win) throws RemoteException {
    winner = win;
  }
  
  public synchronized int getWinner() throws RemoteException {
    return winner;
  }

// ============ Class model ===================================
  public int getRobotSleepTime() throws RemoteException {
    return SLEEPTIME * 2;
  }

  public synchronized void setRobotPosition(int rid,Point p) throws RemoteException {
	  robotPosition[rid] = p;
  }

  public synchronized Point getRobotPosition(int rid) throws RemoteException {
	  return robotPosition[rid];
  }

  public synchronized Point getTopLeftRobotPosition(int rid) throws RemoteException {
	  return new Point(robotPosition[rid].x - (robotSize.width / 2),
	                   robotPosition[rid].y - (robotSize.height / 2));
  }

  public synchronized void setRobotDirection(int rid,int dir) throws RemoteException {
    robotDirection[rid] = dir;
  }

  public synchronized int getRobotDirection(int rid) throws RemoteException {
    return robotDirection[rid];
  }

  public synchronized void setRobotScanDir(int rid,int sdir) throws RemoteException {
    robotScanDir[rid] = sdir % 360;
  }
  
  public synchronized int getRobotScanDir(int rid) throws RemoteException {
    return robotScanDir[rid];
  }

  public synchronized void setRobotScanArc(int rid,int sarc) throws RemoteException {
    robotScanArc[rid] = sarc;
  }
  
  public synchronized int getRobotScanArc(int rid) throws RemoteException {
    return robotScanArc[rid];
  }

  private synchronized void decRobotHP(int rid) throws RemoteException {
    robotHP[rid] -= DECHP;
    if (robotHP[rid] <= 0) {
      robotHP[rid] = 0;
      robotDie[rid] = true;
    }
  }

  public synchronized int getRobotHP(int rid) throws RemoteException {
    return robotHP[rid];
  }

  public synchronized boolean isRobotDie(int rid) throws RemoteException {
	  return robotDie[rid];
  }

  public synchronized void setHitRobot(int rid) throws RemoteException {
    hitRobot[rid] = true;
    decRobotHP(rid);
  }
  
  public synchronized void resetHitRobot(int rid) throws RemoteException {
    hitRobot[rid] = false;
  }
  
  public synchronized boolean isHitRobot(int rid) throws RemoteException {
    return hitRobot[rid];
  }

  public Dimension getRobotSize() throws RemoteException {
	  return new Dimension(29,29);
  }

// ============ Class fire ====================================
  public Dimension getFireSize() throws RemoteException {
    return new Dimension(10,10);
  }

  public Dimension getBoomSize() throws RemoteException {
    return new Dimension(40,40);
  }

  public int getFireSleepTime() throws RemoteException {
    return SLEEPTIME * 2;
  }

  public synchronized void setFirePosition(int rid,int fid,Point p) throws RemoteException {
    firePosition[rid][fid] = p;
  }

  public synchronized Point getFirePosition(int rid,int fid) throws RemoteException {
    return firePosition[rid][fid];
  }

  public void setBoomPosition(int rid,int fid,Point p) throws RemoteException {
    boomPosition[rid][fid] = p;
  }
  
  public Point getBoomPosition(int rid,int fid) throws RemoteException {
    return boomPosition[rid][fid];
  }

  public synchronized void setFireDirection(int rid,int fid,int fdir) throws RemoteException {
    fireDirection[rid][fid] = fdir % 360;
  }
  
  public synchronized int getFireDirection(int rid,int fid) throws RemoteException {
    return fireDirection[rid][fid];
  }

  public synchronized void resetFireDie(int rid,int fid) throws RemoteException {
    fireDie[rid][fid] = false;
  }

  public synchronized void setFireDie(int rid,int fid) throws RemoteException {
    fireDie[rid][fid] = true;
  }
  
  public synchronized boolean isFireDie(int rid,int fid) throws RemoteException {
    return fireDie[rid][fid];
  }

  public void setBoom(int rid,int fid,Point p) throws RemoteException {
    boom[rid][fid] = true;
    setBoomPosition(rid,fid,p);
  }

  public void resetBoom(int rid,int fid) throws RemoteException {
    boom[rid][fid] = false;
  }

  public boolean isBoom(int rid,int fid) throws RemoteException {
    return boom[rid][fid];
    resetBoom(rid,fid);
  }

// ============ Class timer ===================================
  public synchronized void iniTime() throws RemoteException {
    gameTime = MAXTIME;
  }

  public synchronized void setTime() throws RemoteException {
    if (gameTime > 0) gameTime -= 1;
  }

  public synchronized int getTime() throws RemoteException {
    return gameTime;
  }
}