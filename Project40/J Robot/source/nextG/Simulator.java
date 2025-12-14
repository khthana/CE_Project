//
//                         J Robot Next Generation
//
// Player 1 => Red
// Player 2 => Blue
// Player 3 => Yellow
// Player 4 => Green

import java.awt.*;
import java.lang.Thread;
import java.rmi.*;
import java.rmi.server.*;
import sun.applet.*;

public class Simulator {
  DataCenter dataCenter
  Timer timer;
  Model robot[];
  int sleeptime;

  private static final int RUNNING = 0;
  private static final int GAMEOVER = 1;
  private static final int GAMEDRAW = 2;
  
  public static void main(String[] args[]) {
    System.setSecurityManager(new StupSecurityManager());
    try {
      dataCenter = new DataCenter();
      Naming.rebind("DATACENTER",dataCenter);
    } catch(Exception e) {}
    sleeptime = dataCenter.SLEEPTIME * 2;
    init();
    while (!dataCenter.isGameOver()) {
      if (dataCenter.isGameDraw())
        init();
      mainTask();
      checkGame();
      try {
        Thread.sleep(sleeptime);
      } catch(InterruptedException e) {}
    }
    try {
      Thread.sleep(10000);
    } catch(InterruptedException e) {}
    freeMemory();
  }

  public void init() {
	  robot = new Model[dataCenter.NUMROBOT];
    Dimension robotSize;
	  int rid = 0;
	  boolean b;

	  while (rid < dataCenter.NUMROBOT) {
	    robotSize = dataCenter.getRobotSize();
	    robot[rid] = new Model(rid,dataCenter);
	    b = false;
      if (rid != 0) {
		    for (int i = rid - 1; i >= 0; i--) {
		      Point p;
		      p = dataCenter.getTopLeftPosition(i);
		      b = b || robot[rid].isIntersect(p.x,p.y,p.x + robotSize.width,
                                                p.y + robotSize.height);
		    }
      }
	    if (!b) {
	      dataCenter.resetHitRobot(rid);
		    rid += 1;
	    }
	  } // End while loop...

    timer = new Timer(dataCenter);
  }

  public void checkGame() {
	  int count = 0;
    int tmphp = 0;

	  for (int rid = 0; rid < dataCenter.NUMROBOT; rid++)
	    if (!dataCenter.isRobotDie(rid)) {
		    winner = rid;
	      count += 1;
	    }
	  if (count == 1) {
      dataCenter.setGameStatus(GAMEOVER);
	  } else if (count == 0) {
      dataCenter.setGameStatus(GAMEDRAW);
	  }
    if (dataCenter.isRunning() && dataCenter.getTime() == 0) {
      dataCenter.setGameStatus(GAMEOVER);
      for (int j = 0; j < dataCenter.NUMROBOT; j++) {
        if (dataCenter.getRobotHP(j) > tmphp) {
          tmphp = dataCenter.getRobotHP();
          dataCenter.setWinner(j);
        } else if (tmphp != 0 && dataCenter.getRobotHP(j) == tmphp) {
          dataCenter.setGameStatus(GAMEDRAW);
        }
      }
    }
  }

  public void mainTask() {
    for (int i = 0; i < dataCenter.NUMROBOT; i++) {
      if (dataCenter.isRobotDie(i)) {
        if (robot[i] != null) {
          boolean noneFire = false;

          for (int fid = 0; fid < dataCenter.NUMFIRE; fid++) {
            if (!robot[i].fired(fid)) {
              robot[i].releaseFire(fid);
              if (fid == 0)
                noneFire = true;
              else
                noneFire = noneFire;
            } else {
              noneFire = false;
            }
          }
          if (noneFire)
            robot[i].stop();
        }
      }
    }
  }

  private void freeMemory() {
    for (int i = 0; i < numRobot; i++) {
      if (robot[i] != null) {
        robot[i].absReleaseFire();
        robot[i].stop();
        robot[i] = null;
      }
    }
    if (timer != null) {
      timer.stop();
      timer = null;
    }
  }
}