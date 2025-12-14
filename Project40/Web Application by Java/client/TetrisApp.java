import java.awt.*;
import java.applet.Applet;
import java.applet.AudioClip;
import java.util.Vector;
import java.lang.Math;
import java.lang.Thread;
import java.lang.System;
import java.awt.image.*;
import java.net.*;
import java.io.*;
import java.util.*;

public class TetrisApp extends java.applet.Applet
{
    public static final String DEFAULT_HOST = "Sunshine09.ce.kmitl.ac.th";
    public static final int DEFAULT_PORT = 6764;
    public static final String about="Java Puyo network game";
    protected Listener listener = null;
    protected int port;
    protected String host;
    public static Random idGen = new Random();
    protected Socket s = null;
    protected String myAddressAndPort;
    protected int myId = idGen.nextInt();
    
    
    Panel Player1;
    TetrisThread Tetris1;
    Choice PlayerNumChoice;
    Choice LevelChoice;
    Choice RandomChoice;
    
    public String[][] getParameterInfo()
    {
        String[][] info = {{"host","string","sunshine09"},{"port","integer","port 6764"}};
        return info;
    }

    public String getAppletInfo()
    {
        return about;
    }

    public void init()
    {
    	setBackground(Color.white);
        try
        {
            port = Integer.parseInt(getParameter("port"));
        }
        catch (NumberFormatException e)
        {
            port = DEFAULT_PORT;
        }
        host = getParameter("host");
        if (host == null)
        {
            host = DEFAULT_HOST;
        }
        setLayout(new BorderLayout());
        Panel grid = new Panel();
        grid.setLayout(new GridLayout(1,2));
        add("Center",grid);

        Player1 = new Panel();
        Player1.setLayout(null);
        grid.add("center",Player1);

        Panel control = new Panel();
        control.setLayout(new FlowLayout());
        add("South",control);

        control.add(new Button("New Game"));
        control.add(new Button("Pause/Resume"));
        control.add(new Button("Key Pad"));

        LevelChoice = new Choice();
        for (int i=0;i<=6;i++)
            LevelChoice.addItem("Stage"+i);
        control.add(LevelChoice);

        RandomChoice = new Choice();
        for (int i=0;i<=6;i++)
            RandomChoice.addItem(i+" Row");
        control.add(RandomChoice);

        TetrisThread.BlockColor = new int [TetrisThread.BlockNum][2];
        TetrisThread.BlockColor[0][0] = 5;
        TetrisThread.BlockColor[0][1] = 4;
        TetrisThread.BlockColor[1][0] = 3;
        TetrisThread.BlockColor[1][1] = 2;
        TetrisThread.BlockColor[2][0] = 1;
        TetrisThread.BlockColor[2][1] = 5;
        TetrisThread.BlockColor[3][0] = 4;
        TetrisThread.BlockColor[3][1] = 2;
        TetrisThread.BlockColor[4][0] = 2;
        TetrisThread.BlockColor[4][1] = 2;
        TetrisThread.BlockColor[5][0] = 3;
        TetrisThread.BlockColor[5][1] = 4;
        TetrisThread.BlockColor[6][0] = 4;
        TetrisThread.BlockColor[6][1] = 1;
        TetrisThread.BlockColor[7][0] = 5;
        TetrisThread.BlockColor[7][1] = 2;
        TetrisThread.BlockColor[8][0] = 3;
        TetrisThread.BlockColor[8][1] = 1;
        TetrisThread.BlockColor[9][0] = 4;
        TetrisThread.BlockColor[9][1] = 3;

        TetrisThread.Sound = new AudioClip[6];
        TetrisThread.Sound[0] = getAudioClip(getCodeBase(),"audio/block.au");
        TetrisThread.Sound[1] = getAudioClip(getCodeBase(),"audio/bomb.au");
        TetrisThread.Sound[2] = getAudioClip(getCodeBase(),"audio/fall.au");
        TetrisThread.Sound[3] = getAudioClip(getCodeBase(),"audio/move.au");
        TetrisThread.Sound[4] = getAudioClip(getCodeBase(),"audio/turn.au");
        TetrisThread.Sound[5] = getAudioClip(getCodeBase(),"audio/block.au");
}

    public void destroy()
    {
    }

    public void finalize() throws Throwable
    {
    }

    public void start()
    {
        try
        {
            s = new Socket(host,port);
            myAddressAndPort = s.getInetAddress()+":"+s.getPort();
        }
        catch (IOException e)
        {
            this.cleanUp();
            return;
        }
        
        Tetris1 = new TetrisThread(s,this,Player1,'j','k','l','m');
        listener = new Listener(s,this);
    }

    public void AddSuffer(String massage)
    {
        int count;
        if(massage.startsWith("USER "))
        {
            Tetris1.Update_User(massage.substring(5));   
        }
        else
        {
        try
        {
            count = Integer.parseInt(massage);
        }
        catch (NumberFormatException e)
        {
            count = 0;
        }
        Tetris1.BlackBlock(count);
        }
    }
    
    
    public void stop() 
    {
        cleanUp();
        super.stop () ;

    }
    
    public void cleanUp()
    {
        if(Tetris1!=null && Tetris1.running)
        {
            Tetris1.stop();
        }
        Tetris1 = null;
        if (listener != null && listener.running)
        {
            listener.stop();
        }
        listener = null;
        removeAll();
        try
        {
            if (s!= null)
            {
                s.close();
            }
        }
        catch (IOException e)
        {
        }
        s = null;
        myAddressAndPort ="";
        repaint();
    }

 public void paint(Graphics g)
    {
        if (Tetris1 == null && listener == null && s == null)
        {
            g.setColor(Color.white);
            g.setFont(new Font("Dialog",Font.BOLD,25));
            g.drawString("Not connect to server.",60,180);
        }
     
    }


    public int StartLevel()
    {
        return LevelChoice.getSelectedIndex();
    }

    public int StartRow()
    {
        return RandomChoice.getSelectedIndex();
    }

    private boolean CommandAction(Event event,Object arg)
    {
        if(event.target == LevelChoice)
        {
            Tetris1.SetLevel(LevelChoice.getSelectedIndex());
        }
        if("New Game".equals(arg))
        {
            Tetris1.NewGame();
        }
        if ("Key Pad".equals(arg))
        {
            Tetris1.Pause(true);
            AboutFrame about = new AboutFrame();
            about.show();
        }
        if ("Pause/Resume".equals(arg))
        {
            Tetris1.Pause();
        }
        return true;
    }

    public synchronized boolean handleEvent(Event event)
    {
        switch(event.id)
        {
            case Event.ACTION_EVENT:
                 return CommandAction(event,event.arg);
            case Event.KEY_ACTION:
            case Event.KEY_PRESS:
                 Tetris1.KeyAction(event , event.key);
                 return true;
            default:
                 return false;
        }
    }
}
/* ================================================================================ */
class TetrisThread extends Thread
{
    protected PrintStream sout;
    protected boolean running = false;
    public static final int Cols = 6;
    public static final int Rows = 12;
    public static final int MaxElement = 1;
    public static final int BlockNum = 10;

    public static int BlockColor[][];
    public static AudioClip Sound[];
    public static final int SND_BLOCK = 0;
    public static final int SND_BOMB = 1;
    public static final int SND_FALL = 2;
    public static final int SND_MOVE = 3;
    public static final int SND_TURN = 4;
    public static final int SND_GAMEOVER = 5;    
    public static int ElementSize;
    boolean state=false;
    boolean Enablekey=true;
    char KeyLeft,KeyRight,KeyRotate,KeyDrop;
    TetrisApp Applet;
    ArenaCanvas Arena;
    ReportCanvas Report;
    Shape CurrentShape = null;
    Shape NextShape = null;
    int Report_Bricks=0;
    int Puyo_Bricks=0;
    int PlayMap[][];
    int PlayStatus[][];
    int PlayValue[][];
    int SufferCount;
    boolean GamePaused = false;
    boolean GameRestart = false;
    boolean GameSuspended = false;
    boolean GameOver = false;
    boolean image[];
    boolean drop=true;
    boolean next[];
    boolean BlackBlock = false;
    boolean DropBlock = false;

    int sleeptime;
    int            Max;
    int            Mapy[];
    int            Mapx[];
    int            MaxMap;
    int            statedrop=0;
    public TetrisThread(Socket s,TetrisApp app,Panel panel,char left,char rotate,char right,char drop)
    {
        Applet = app;
        try
        {
            sout = new PrintStream(s.getOutputStream());
        }
        catch (IOException e)
        {
            running = false;
            app.cleanUp();
            return;
        }        
        Arena = new ArenaCanvas(Applet);
        panel.add(Arena);
        Report = new ReportCanvas(Applet);
        panel.add(Report);
        Report.move(250,12);
        KeyLeft = left;
        KeyRight = right;
        KeyRotate = rotate;
        KeyDrop = drop;
        PlayMap = new int [Rows][Cols];
        PlayStatus = new int [Rows][Cols];
        PlayValue = new int [Rows][Cols];
        Arena.SetPlayMap(PlayMap,PlayStatus);
        ElementSize = Arena.GetElementSize();
        Mapy = new int[2];
        Mapx = new int[2];
        next = new boolean[4];
        image = new boolean[2];
        image[0] = false;
        image[1] = false;     
        this.start();
    }

    protected void finalize() throws Throwable
    {
        sout.close();
        sout = null;
    }
    
    public void Update_User(String mes)
    {
        Report.UpdateUser(mes);
    }
    
    public void sendLine(int Linecount)
    {
        int linetime = Linecount;        
        String line = String.valueOf(linetime);
        line = "LINE "+line.trim()+"\n";
        long timeSent = (new Date()).getTime();
        sout.print(line);
        sout.flush();
    }

    
    private void ClearGame()
    {
        int x,y;
        for(y=0;y<Rows;y++)
        for(x=0;x<Cols;x++)
        {
            PlayMap[y][x] = 0;
            PlayValue[y][x] =1;
            PlayStatus[y][x] =0;
        }
    }

    private void InitGame()
    {
        int x,y;
        for(y=0;y<Rows-Applet.StartRow();y++)
            for(x=0;x<Cols;x++)
            {
                PlayMap[y][x] = 0;
                PlayValue[y][x] = 1;
                PlayStatus[y][x] = 0;
            }
        for(;y<Rows;y++)
            RandomRow(PlayMap[y],PlayStatus[y],PlayValue[y]);
        CheckState();
        Arena.RepaintPlayMap();
        Report.InitGame(Applet.StartLevel());
        sleeptime = Report.GetGameSpeed();        
        BlackBlock = false;
        DropBlock=false;
        SufferCount = 0;
        Puyo_Bricks=0;
        Report_Bricks=0;
        
        
    }
    
    private int RandomShapeNum()
    {

        int num;
        do
        {
            num = (int)(Math.random()*BlockNum);
        }
        while(num>=BlockNum);
        return num;

    }
    private void GetNextRandomShape()
    {
        int num;
        if(CurrentShape == null)
        {
            num = RandomShapeNum();
            CurrentShape = new Shape(Applet,BlockColor[num]);
        }
        else
            CurrentShape = NextShape;
        CurrentShape.Init();
        if(!CurrentShape.CheckFit(PlayMap,0,0,false))
            GameOver();
        num = RandomShapeNum();
        NextShape = new Shape(Applet,BlockColor[num]);
        Report.DisplayNextShape(NextShape);


    }
    
    private void CreateGame()
    {
        Over(false);
        Pause(false);
        Arena.GameOver();
        Report.GameOver();        
        InitGame();
        GetNextRandomShape();
    }

    private void GameOver()
    {
        Over(true);
        Play(SND_GAMEOVER);
        Arena.GameOver();
        Report.GameOver();
        ClearGame();
    }

    public void NewGame()
    {
        Arena.BeginRepaint();
        GameRestart = true;
        Over(false);
        Pause(false);
    }
    
    public void Over(boolean needpause)
    {
        GameOver = needpause;
    }
    
    public void Suspend(boolean needsuspend)
    {
        GameSuspended = needsuspend;
    }

    public void Pause()
    {
        GamePaused =!GamePaused;
    }

    public void Pause(boolean needpause)
    {
        GamePaused = needpause;
    }

    public void run()
    {
        running = true;
        for(;;)
        {
            try
            {
                Thread.sleep(sleeptime);
            }
            catch (InterruptedException e) {}
            if (!GamePaused && !GameSuspended)
               UpdateMap(false,0,0,false);
        }

    }



private void CheckDelete()
{

    int y;
    int x;
    int MaxValue=0;
    int tempincx;
    int time=0;
    MaxMap=0;
    boolean again;
    for(y=0;y<=Rows-1;y++)
    {
        for (x=Cols-1;x>=0;x--)
        {
            MaxValue = PlayValue[y][x];
            time=0;
            if (PlayMap[y][x] != 0)
            {
                if(PlayMap[y][x] != 6)
                {
                    if (y>0)
                    {
                        if (PlayMap[y-1][x] == PlayMap[y][x])
                        {
                            PlayValue[y][x] = PlayValue[y-1][x];
                            MaxValue = PlayValue[y][x];
                         }
                    }
                    if (x>0)
                    {
                        tempincx=x-1;
                        for (again=false,tempincx=x-1;tempincx>=0;tempincx--)
                        {
                            if(PlayMap[y][tempincx] == PlayMap[y][x])
                            {
                                time++;
                                if(PlayValue[y][tempincx] > MaxValue)
                                {
                                    MaxValue = PlayValue[y][tempincx];
                                }                            
                            }
                            else if(!(PlayMap[y][tempincx] == PlayMap[y][x]))
                            {
                                again = true;
                                break;
                            }
                        }
                        PlayValue[y][x] = MaxValue;
                        int tempreplace;
                        for (tempincx=1;tempincx<=time;tempincx++)
                        {
                            tempreplace = x-tempincx;
                            PlayValue[y][tempreplace] = MaxValue;
                        }
                    }
                }   
            }
            if (MaxValue > MaxMap)
            {
                MaxMap = MaxValue;
            }
        }
    }  
    if(MaxMap >=4)
    {
       
       statedrop=9;
       drop=true;
    }

}
private void CheckState()
{

    int x,y,c;
    for (y=Rows-1;y>=0;y--)
    {
         for(x=0;x<Cols;x++)
         {
            PlayStatus[y][x] = 0;
            if((x>0) && (x<Cols-1))
            {
                if(y==0)
                {
                    if(PlayMap[y][x-1] == PlayMap[y][x])
                       PlayStatus[y][x] = 15;
                    if(PlayMap[y][x+1] == PlayMap[y][x])
                       {
                        if(PlayStatus[y][x] == 15)
                           PlayStatus[y][x] = 14;
                        else PlayStatus[y][x] = 13;
                       }
                    if(PlayMap[y+1][x] == PlayMap[y][x])
                    {
                        if(PlayStatus[y][x] == 15)
                           PlayStatus[y][x] = 10;
                        else if (PlayStatus[y][x] == 14)
                           PlayStatus[y][x] = 9;
                        else if (PlayStatus[y][x] == 13)
                           PlayStatus[y][x] = 4;
                        else  PlayStatus[y][x] = 1;
                    }
                     
                       
                }
                if(y==Rows-1)
                {
                    if(PlayMap[y][x-1] == PlayMap[y][x])
                        PlayStatus[y][x] = 15;
                    if(PlayMap[y][x+1] == PlayMap[y][x])
                    {
                        if(PlayStatus[y][x] == 15)
                           PlayStatus[y][x] = 14;
                        else PlayStatus[y][x] = 13;
                    }
                        
                    if(PlayMap[y-1][x] == PlayMap[y][x])
                    {
                        if(PlayStatus[y][x] == 15)
                           PlayStatus[y][x] =  12;
                        else if(PlayStatus[y][x] == 14)
                           PlayStatus[y][x] = 7;
                        else if(PlayStatus[y][x] == 13)
                           PlayStatus[y][x] = 6;
                        else PlayStatus[y][x] = 3;
                    }
                }
                if((y>0) && (y<Rows-1))
                {
                    if(PlayMap[y][x-1] == PlayMap[y][x])
                          PlayStatus[y][x] = 15;
                    if(PlayMap[y][x+1] == PlayMap[y][x])
                    {
                        if(PlayStatus[y][x] == 15)
                           PlayStatus[y][x] = 14;
                        else PlayStatus[y][x] = 13;
                    }
                    if(PlayMap[y+1][x] == PlayMap[y][x])
                    {
                        if(PlayStatus[y][x] == 15)
                           PlayStatus[y][x] = 10;
                        else if(PlayStatus[y][x] == 14)
                           PlayStatus[y][x] = 9;
                        else if(PlayStatus[y][x] == 13)
                           PlayStatus[y][x] = 4;
                        else PlayStatus[y][x] = 1;
                    }
                    if(PlayMap[y-1][x] == PlayMap[y][x])
                    {
                        if(PlayStatus[y][x] == 15)
                           PlayStatus[y][x] = 12;
                        else if(PlayStatus[y][x] == 14)
                           PlayStatus[y][x] = 7;
                        else if(PlayStatus[y][x] == 13)
                           PlayStatus[y][x] = 6;
                        else if(PlayStatus[y][x] == 10)
                           PlayStatus[y][x] = 11;
                        else if(PlayStatus[y][x] == 9)
                           PlayStatus[y][x] = 8;
                        else if(PlayStatus[y][x] == 4)
                           PlayStatus[y][x] = 5;
                        else if(PlayStatus[y][x] == 1)                        
                           PlayStatus[y][x] = 2;
                        else PlayStatus[y][x] = 3;
                    }
                }
            }
            if(x==0)
            {
                PlayStatus[y][x] = 0;
                if(y==0)
                {
                    if(PlayMap[y][x+1] == PlayMap[y][x])
                       PlayStatus[y][x] = 13;
                    if(PlayMap[y+1][x] == PlayMap[y][x])
                    {
                        if(PlayStatus[y][x] ==13)
                           PlayStatus[y][x] =4;
                        else PlayStatus[y][x]= 1;
                    }
                       
                }
                if(y==Rows-1)
                {
                    if(PlayMap[y][x+1] == PlayMap[y][x])
                       PlayStatus[y][x] =13;
                    if(PlayMap[y-1][x] == PlayMap[y][x])
                    {
                        if(PlayStatus[y][x] == 13)
                           PlayStatus[y][x] = 6;
                        else PlayStatus[y][x] = 3;
                    }
                }      
                if((y>0) && (y<Rows-1))
                {
                    if(PlayMap[y][x+1] == PlayMap[y][x])
                       PlayStatus[y][x] = 13;
                    if(PlayMap[y-1][x] == PlayMap[y][x])
                       {
                        if(PlayStatus[y][x] == 13)
                           PlayStatus[y][x] = 6;
                        else PlayStatus[y][x] = 3;
                       }
                     if(PlayMap[y+1][x] == PlayMap[y][x])
                       {
                        if(PlayStatus[y][x] == 6)
                           PlayStatus[y][x] = 5;
                        else if (PlayStatus[y][x] == 3)
                           PlayStatus[y][x] =2;
                        else if (PlayStatus[y][x] == 13)
                           PlayStatus[y][x]  = 4;
                        else PlayStatus[y][x] = 1;
                       }
                }
         
            }
            if(x==Cols-1)
            {
                if((y>0) && (y<Rows-1))                
                {
                    if(PlayMap[y][x-1] == PlayMap[y][x])
                       PlayStatus[y][x] = 15;
                    if(PlayMap[y+1][x] == PlayMap[y][x])
                       {
                        if(PlayStatus[y][x] == 15)
                           PlayStatus[y][x] = 10;
                        else
                           PlayStatus[y][x] = 1;                           
                       }
                    if(PlayMap[y-1][x] == PlayMap[y][x])
                       {
                        if(PlayStatus[y][x] == 10)
                           PlayStatus[y][x] = 11;
                        else if(PlayStatus[y][x] == 1)
                           PlayStatus[y][x] = 2;
                        else if(PlayStatus[y][x] == 15)
                           PlayStatus[y][x] = 12;
                        else PlayStatus[y][x] = 3;   
                       }
                }
                if(y==Rows-1)
                {
                    if(PlayMap[y-1][x] == PlayMap[y][x])
                       PlayStatus[y][x] = 3;
                    if(PlayMap[y][x-1] == PlayMap[y][x])
                    {
                        if(PlayStatus[y][x] ==3)
                           PlayStatus[y][x] = 12;
                        else PlayStatus[y][x] = 15;
                    }
                }
                if(y==0)
                {
                    if(PlayMap[y][x-1] == PlayMap[y][x])
                       PlayStatus[y][x] = 15;
                    if(PlayMap[y+1][x] == PlayMap[y][x])
                    {
                       if(PlayStatus[y][x] == 15)
                          PlayStatus[y][x] = 10;
                       else PlayStatus[y][x] = 1;
                    }
                }
            }
         }
    }
}

private void CheckLines()
{

    int x,y,yc;
    int temppx=0;
    Max=1;
    boolean next=true;
    for (y=Rows-1;y>=0;y--)
    {
        for (x=0;x<Cols;x++)
        {
        PlayValue[y][x] = 1;     /* new Value PlayValue*/        
        }
    }
    for (y=Rows-1;y>=0;y--)
    {
        for (x=0;x<Cols;x++)
        {
             if (PlayMap[y][x] != 0)
             {
                if (PlayMap[y][x] != 6)
                {
                    if ((y<=Rows-2)&& (PlayMap[y+1][x]== PlayMap[y][x]))           /* Check below before */
                    {           
                        PlayValue[y][x] = PlayValue[y+1][x]+1;
                        PlayValue[y+1][x] = PlayValue[y+1][x] + 1;                      /* up and down is same */
                        Max = PlayValue[y][x];
                    }
                    if ((x>=1) && (PlayMap[y][x-1] == PlayMap[y][x]))               /* Then check left brick */
                    {
                        PlayValue[y][x] = PlayValue[y][x] + PlayValue[y][x-1];                    
                        Max = PlayValue[y][x];
                        next = false;
                        int tempc;
                        for (next=false,tempc=x-1;tempc>=0;tempc--)
                        {
                            if(PlayMap[y][tempc] == PlayMap[y][x])
                            {
                                PlayValue[y][tempc] = PlayValue[y][x];
                            }
                            else if(!(PlayMap[y][tempc] == PlayMap[y][x]))
                            {
                                next = true;
                                break;
                            }
                        }
                    }
                }
             }
             else
             {
                /* nothing to do if Color.black and dark */
             }
        }
    }
}

private void ChangeShape(int incx,int incy,boolean rotate)
    {

        while(!CurrentShape.IsReady());
        if(CurrentShape.CheckFit(PlayMap,incx,incy,rotate))
        {
            CurrentShape.ChangePosition(incx,incy,rotate);
            Arena.repaint(CurrentShape);
        }
    }
    
private void CheckForDrop()
{
    for(int i=0;i<2;i++)
    {
        if (Mapy[i] < Rows-1)
        {
            if(PlayMap[(Mapy[i]+1)][Mapx[i]] == 0)
               PlayStatus[Mapy[i]][Mapx[i]] = 18;
            else PlayStatus[Mapy[i]][Mapx[i]] = 16;
        }
    }
}
private void SaveBlock()
{
    int x;
    int y;
    DropBlock = false;
    statedrop=7;
    for(x=0;x<=Cols-1;x++)
        for(y=Rows-1;y>=0;y--)
        {
            if(PlayMap[y][x] == 6)
            {
                int nexty=1;
                if (y<Rows-1)
                {
                    if(PlayMap[(y+nexty)][x] == 0)
                    {
                        DropBlock = true;
                        PlayMap[(y+nexty)][x] = PlayMap[y][x];
                        PlayStatus[(y+nexty)][x] = 18;
                        PlayValue[(y+nexty)][x] = 1;
                        PlayMap[y][x] = 0;
                        PlayStatus[y][x] = 0;
                        PlayValue[y][x] = 1;
                    }
                }
            }
        }                      
}

private void SaveNewMap()
{
    int x;
    int y;
    boolean blackagain=true;
    drop=true;
    statedrop=7;
    for(x=0;x<=Cols-1;x++)
    {
        for(y=Rows-1;y>=0;y--)
        {
            blackagain=true;
            if(PlayMap[y][x] == 0)            
            {
                int nexty=1;        /* first decretement */
                if (y>=1)           /* first y=1 */
                {
                    do
                    {
                        if (!(PlayMap[(y-nexty)][x] == 0))
                        {
                            blackagain = false;
                            drop=false;                  // have to drop again
                            statedrop=4;
                        }
                        if(PlayMap[(y-nexty)][x] == 0)
                        {
                            nexty++;
                        }
                    }
                    while(((y-nexty) >= 0) && (blackagain));    
                    if (!(blackagain))                  // if there some brick upper
                    {
                            PlayMap[y][x] = PlayMap[(y-1)][x];
                            PlayValue[y][x] = PlayValue[(y-1)][x];
                            PlayStatus[y][x] = 18;
                            PlayMap[(y-1)][x] = 0;
                            PlayValue[(y-1)][x] = 1;
                            PlayStatus[(y-1)][x] = 0;
                    }
                }
            }
        }
    }
}


private void NowDelete()
{
    int y;
    int x;
    for(y=Rows-1;y>=0;y--)
    {
        for (x=Cols-1;x>=0;x--)
        {
            if (!(PlayMap[y][x] == 0))
            {
                if(x>0)
                { 
                    if(PlayMap[y][x] != 6)
                    {
                        if (PlayMap[y][(x-1)] == PlayMap[y][x])
                        {
                            if (PlayValue[y][(x-1)] >= 4)
                            {
                                PlayMap[y][x] = 0;
                                PlayValue[y][x] = 1;
                                Puyo_Bricks++;
                            }
                        }
                    }
                }   
                if (PlayValue[y][x] >= 4)
                {
                    if(PlayMap[y][x] != 6)
                    Puyo_Bricks++;
                    PlayMap[y][x] = 0;
                    PlayValue[y][x] = 1;
                }
            }
        }
    }
}

private void ChangeImage()
{
    int y,x;
    for(x=0;x<=Cols-1;x++)
    {
        for(y=Rows-1;y>=0;y--)
        {
            if(PlayMap[y][x] !=0)
            {
                if(PlayMap[y][x] != 6)
                {
                    if(PlayValue[y][x] >= 4)
                    {
                       PlayStatus[y][x] = 17;
                        if(x>0)
                        {
                            if(PlayMap[y][x-1] == 6)
                            {
                                  PlayValue[y][x-1] = 4;
                                  PlayStatus[y][x-1] = 17;
                            }
                        }
                        if((x>0) && (x<Cols-1))
                        {
                            if(PlayMap[y][x+1] == 6)
                            {
                                PlayValue[y][x+1] = 4;
                                PlayStatus[y][x+1] = 17;
                            }
                        }
                    }
                }
                
            }
        }
    }
}
                           
private void CheckDropPlace()
{
    boolean black=false;
    statedrop=3;
    for (int i=0;i<2;i++)
    {
        if(image[i])
        {
            int tempy = (Mapy[i]+1);            /* get higher Rows */
            if ((tempy <= Rows-1) && (PlayMap[tempy][Mapx[i]] == 0))
            {
                PlayMap [tempy][Mapx[i]] = PlayMap[Mapy[i]][Mapx[i]];
                PlayValue[tempy][Mapx[i]] = PlayValue[Mapy[i]][Mapx[i]];
                PlayStatus[tempy][Mapx[i]] = 18;
                PlayMap [Mapy[i]][Mapx[i]] = 0;
                PlayValue[Mapy[i]][Mapx[i]] = 1;
                PlayStatus[Mapy[i]][Mapx[i]] = 0;
                Mapy[i] = tempy;
                black=true;
                image[i]=true;
                statedrop=2;
            }
            else        // not drop again
            {
                PlayStatus[Mapy[i]][Mapx[i]] =  16;
                image[i] = false;
            }
        }
    }
}

private void CheckMap()
{

    boolean black=false;
    statedrop=3;
    for (int i=0;i<2;i++)
    {
        int tempy = (Mapy[i]+1);            /* get higher Rows */
        if ((tempy <= Rows-1) && (PlayMap[tempy][Mapx[i]] == 0))
        {
            PlayMap [tempy][Mapx[i]] = PlayMap[Mapy[i]][Mapx[i]];
            PlayValue[tempy][Mapx[i]] = PlayValue[Mapy[i]][Mapx[i]];
            PlayStatus[tempy][Mapx[i]] = 18;
            PlayMap [Mapy[i]][Mapx[i]] = 0;
            PlayValue[Mapy[i]][Mapx[i]] = 1;
            PlayStatus[Mapy[i]][Mapx[i]] = 0;
            Mapy[i] = tempy;
            black=true;
            image[i] = true;
        }
        else        // not drop again
        PlayStatus[Mapy[i]][Mapx[i]] =  16;
    }
    if(black) 
        statedrop=2;
    else
    {}
}

    private synchronized void UpdateMap(boolean userrequest,int incx,int incy,boolean rotate)
    {
        if(GameOver)
        {
        }
        else if(userrequest)
        {
            if(incy==0)
            Play(SND_TURN);
            else Play(SND_MOVE);
            ChangeShape(incx,incy,rotate);
        }
        else 
        {
            if(GameRestart)
            {
                GameRestart = false;
                CreateGame();
            }    
            else 
            if(CurrentShape != null)
            {
                switch(statedrop)
                {
                case 0:                     // current display
                {
                    sleeptime = Report.GetGameSpeed();
                    if(CurrentShape.CheckFit(PlayMap,0,1,false))
                    {
                       ChangeShape(0,1,false);
                       break;               // break to display current shape
                    }
                    else
                    {
                       statedrop=1;       
                       Enablekey=false;
                    }
                }   
                case 1:                     // just touch ground after place
                {
                    sleeptime = Report.GetGameSpeed();
                    Play(SND_BLOCK);
                    CurrentShape.Place(PlayMap,Mapy,Mapx,PlayStatus,PlayValue);
                    Report.AddScore(5);
                    CheckMap();                     // to identifier what ball have black below
                    break;                  // break first wait for drop
                }
                case 2:                     // between drop after place
                {
                    sleeptime = 50;
                    Play(SND_FALL);                    
                    CheckDropPlace();                    
                    if (statedrop==2)
                    {
                        break;
                    }
                    // now state change to be 3                        
                }
                case 3:                     // touch after drop place
                {
                    sleeptime = 50;
                    image[0] = false;       // clear all flag of 2 images
                    image[1] = false;       // now speed = report
                    statedrop=7;            // Change state to all touch ground
                    break;
                }
                case 4:                     // before bomb
                { 
                    sleeptime = 50;
                    if(drop)
                    {               
                        NowDelete();
                    }
                    SaveNewMap();
                    Report.AddLines(Puyo_Bricks);
                    Report.AddScore(Puyo_Bricks*3);                    
                    Report_Bricks=Report_Bricks+Puyo_Bricks;
                    Puyo_Bricks=0;
                    break;
                }
                case 5:                     // between bomb and drop
                {
                    sleeptime = 50;
                    Play(SND_FALL);
                    if(statedrop==5)
                    break;
                        

                }
                case 6:                     // touch ground after bomb
                {
                    sleeptime = 50;
                    Play(SND_BLOCK);
                    statedrop=7;
                    break;
                }
                case 7:                     // state to check to delete
                {
                    sleeptime = Report.GetGameSpeed();
                    if(BlackBlock)
                    {
                        Suffer();
                        BlackBlock=false;
                        DropBlock=true;
                        break;
                    }
                    if(DropBlock)
                    {
                        sleeptime = 50;
                        SaveBlock();
                        break;
                    }
                    statedrop=8;
                    CheckLines();
                    CheckDelete();
                    CheckState();                    
                    if(statedrop != 8)
                    {
                       drop = true;
                       Play(SND_BOMB);
                       break;
                    }
                    if(statedrop == 8)
                    {
                        if(Report_Bricks >=5)
                        sendLine(Report_Bricks);
                        else
                        sendLine(0);
                        Report_Bricks=0;
                    }

                }
                case 8:
                {
                    Puyo_Bricks=0;
                    sleeptime = Report.GetGameSpeed();
                    statedrop=0;
                    Enablekey=true;
                    GetNextRandomShape();
                    break;
                }
                case 9:             // Change to afraid
                {
                    sleeptime = 50;                    
                    ChangeImage();
                    statedrop=4;
                    break;
                }
                }
            }
            Arena.RepaintPlayMap();
        }
    }
    
    public void BlackBlock(int count)
    {
        BlackBlock = true;
        SufferCount = count;

    }

    public synchronized void Suffer()
    {
        if(GameSuspended)
           return;
        if(GameOver)
           return;
        int x,y;
        if (SufferCount <= 0)
        SufferCount = 4;
        SufferCount = SufferCount-4;
        if(SufferCount>=5)
           SufferCount = 5;
        y=0;  
        switch(SufferCount)
        {
            case 2:
            {
                if(PlayMap[y][3] == 0)
                {
                    PlayMap[y][3] = 6;
                    PlayStatus[y][3] = 0;
                    PlayValue[y][3] = 1;
                }
                if(PlayMap[y][4] == 0)
                {
                    PlayMap[y][4] = 6;
                    PlayStatus[y][4] = 0;
                    PlayValue[y][4] = 1;
                }           
                break;
            }
            case 3:
            {
                if(PlayMap[y][2] ==0)
                {
                    PlayMap[y][2] = 6;
                    PlayStatus[y][2] = 0;
                    PlayValue[y][2] = 1;
                    
                }
                if(PlayMap[y][3] == 0)
                {
                    PlayMap[y][3] = 6;
                    PlayStatus[y][3] = 0;
                    PlayValue[y][3] = 1;
                }
                if(PlayMap[y][4] == 0)
                {
                    PlayMap[y][4] = 6;
                    PlayStatus[y][4] = 0;
                    PlayValue[y][4] = 1;
                }     
                break;

            }            
            case 4:
            {
                if(PlayMap[y][2] ==0)
                {
                    PlayMap[y][2] = 6;
                    PlayStatus[y][2] = 0;
                    PlayValue[y][2] = 1;
                    
                }
                if(PlayMap[y][3] == 0)
                {
                    PlayMap[y][3] = 6;
                    PlayStatus[y][3] = 0;
                    PlayValue[y][3] = 1;
                }
                if(PlayMap[y][4] == 0)
                {
                    PlayMap[y][4] = 6;
                    PlayStatus[y][4] = 0;
                    PlayValue[y][4] = 1;
                }                                               
                if(PlayMap[y][5] == 0)
                {
                    PlayMap[y][5] = 6;
                    PlayStatus[y][5] = 0;
                    PlayValue[y][5] = 1;
                }     
                break;
            }
            case 5:
            {
                if(PlayMap[y][1] ==0)
                {
                    PlayMap[y][1] =6;
                    PlayStatus[y][1] = 0;
                    PlayValue[y][1] = 1;
                }
                if(PlayMap[y][2] ==0)
                {
                    PlayMap[y][2] = 6;
                    PlayStatus[y][2] = 0;
                    PlayValue[y][2] = 1;
                    
                }
                if(PlayMap[y][3] == 0)
                {
                    PlayMap[y][3] = 6;
                    PlayStatus[y][3] = 0;
                    PlayValue[y][3] = 1;
                }
                if(PlayMap[y][4] == 0)
                {
                    PlayMap[y][4] = 6;
                    PlayStatus[y][4] = 0;
                    PlayValue[y][4] = 1;
                }                                               
                if(PlayMap[y][5] == 0)
                {
                    PlayMap[y][5] = 6;
                    PlayStatus[y][5] = 0;
                    PlayValue[y][5] = 1;
                }                               
                break;
            }
            case 0: break;
            default :
            {
                if(PlayMap[y][3] == 0)
                {
                    PlayMap[y][3] = 6;
                    PlayStatus[y][3] = 0;
                    PlayValue[y][3] = 1;
                }
                
            }
        }
        BlackBlock=false;
        SufferCount = 0;
    }

    public void SetLevel(int level)
    {
        if(!GameSuspended)
        Report.SetLevel(level);
        sleeptime = Report.GetGameSpeed();        
    }

    public boolean KeyAction(Event event, int key)
    {

        int incx = 0;
        int incy = 0;
        boolean rotate = false;
        if (GameSuspended)
            return true;
        if (!Enablekey)       
            return true;
        if (GameOver)
            return true;
        if (GamePaused)
            return true;
        switch(key) 
        {
            case Event.LEFT:
                incx--;
                break;
            case Event.RIGHT:
                incx++;
                break;
            case Event.UP:
                rotate = true;
                break;
            case Event.DOWN:
                incy++;
                break;
        }
        UpdateMap(true,incx,incy,rotate);        
        return true;
    }

    private void RandomRow(int rowmap[],int rowstatus[],int rowvalue[])
    {
        for (int col=0;col<Cols;col++)
        {
             rowmap[col] = 0;
             rowstatus[col] = 0;
             rowvalue[col] = 1;
        }
        for (int i=0;i<Cols;i++)
            {
                if((rowmap[i] == 0))
                {
                    for(;;)
                    {
                        int temp = (int)(Math.random()*(BlockNum));
                        if((temp >0) && (temp <=5))
                        {
                            rowmap[i] = temp;
                            break;
                        }
                    }
                }
            }

    }

    public static void Play(int n)
    {
        if (Sound[n] != null)
        Sound[n].play();
    }
}

/* ================================================================================ */
class ArenaCanvas extends Canvas implements ImageObserver
{
    public static final int BorderWidth=5;
    public static final Color BorderColor = Color.blue;
    protected Shape CurrentShape = null;
    boolean CurrentShapeNeedRepaint = false;
    boolean PlayMapNeedRepaint = false;
    boolean DiscardGame = false;
    boolean AllLoading = false;
    boolean First = true;
    int ElementSize;
    public static TetrisApp applet1;
    public static Image Rimages[] = new Image[19];
    public static Image Yimages[] = new Image[19];
    public static Image Bimages[] = new Image[19];
    public static Image Pimages[] = new Image[19];
    public static Image Gimages[] = new Image[19];
    public static Image Dimages[] = new Image[20];
    MediaTracker tracker;
    Dimension offscreenSize;
    Image offscreenImage;
    Graphics offscreenGC;
    int lastLoaded = 0;
    protected Font TetrisFont1,TetrisFont2;
    int PlayMap[][] = null;
    int PlayStatus[][] = null;
    
    public void BeginRepaint()
    {
        First=false;
    }
    
    public boolean GetLoading()
    {
        return AllLoading;
    }
    
    public int GetElementSize()
    {
        return ElementSize;
    }

    public void GameOver()
    {
        DiscardGame = true;
        repaint();
    }

    public void RepaintPlayMap()
    {
        PlayMapNeedRepaint = true;
        repaint();
    }

    public void SetPlayMap(int playmap[][],int playstatus[][])
    {

        PlayMap = playmap;
        PlayStatus = playstatus;
    }

    public ArenaCanvas(TetrisApp app)
    {

        applet1 = app;
        TetrisFont1 = new Font("TimesRoman",Font.BOLD,20);
        FontMetrics TetrisFontMetrics1 = getFontMetrics(TetrisFont1);
        TetrisFont2 = new Font("TimesRoman",Font.BOLD,20);
        FontMetrics TetrisFontMetrics2 = getFontMetrics(TetrisFont2);
        int y=TetrisThread.Cols;
        /* ------------------------------ */
        tracker = new MediaTracker(applet1);
        for(int m=0;m<19;m++)
        {
            Rimages[m] = applet1.getImage(applet1.getCodeBase(),"image/r"+m+".jpg");
            tracker.addImage(Rimages[m],0);
        }
        for(int m=0;m<19;m++)
        {
            Yimages[m] = applet1.getImage(applet1.getCodeBase(),"image/y"+m+".jpg");
            tracker.addImage(Yimages[m],0);
        }
        for(int m=0;m<19;m++)
        {
            Bimages[m] = applet1.getImage(applet1.getCodeBase(),"image/b"+m+".jpg");
            tracker.addImage(Bimages[m],0);
        }
        for(int m=0;m<19;m++)
        {
            Pimages[m] = applet1.getImage(applet1.getCodeBase(),"image/p"+m+".jpg");
            tracker.addImage(Pimages[m],0);
        }
        for(int m=0;m<19;m++)
        {
            Gimages[m] = applet1.getImage(applet1.getCodeBase(),"image/g"+m+".jpg");
            tracker.addImage(Gimages[m],0);
        }
        for(int m=0;m<19;m++)
        {
            Dimages[m] = applet1.getImage(applet1.getCodeBase(),"image/d"+m+".jpg");
            tracker.addImage(Dimages[m],0);
        }
        Dimages[19] = applet1.getImage(applet1.getCodeBase(),"image/Logo.gif");
        tracker.addImage(Dimages[19],0);
        try
        {
            tracker.waitForID(0);
            ElementSize = Rimages[1].getWidth(applet1);
            reshape(12,12,ElementSize*TetrisThread.Cols+BorderWidth*2,ElementSize*TetrisThread.Rows+BorderWidth*2);            
            makeDoubleBuffer(ElementSize*TetrisThread.Cols+BorderWidth*2,ElementSize*TetrisThread.Rows+BorderWidth*2);            
            AllLoading = true;
            repaint();
        }
        catch (InterruptedException e)
        {
            System.exit(0);
        }

/* --------------- end of track ------------- */

    }

    void makeDoubleBuffer(int width,int height)
    {
        offscreenSize = new Dimension(width,height);
        offscreenImage = applet1.createImage(width,height);
        offscreenGC = offscreenImage.getGraphics();
        
    }


    public void repaint(Shape shape)
    {

        CurrentShape = shape;
        CurrentShapeNeedRepaint = true;
        repaint();
    }

    private void DrawLines(Graphics graph,int ymin,int ymax)
    {

        int y;
        for (y=ymin*ElementSize+BorderWidth;
             y<ymax*ElementSize+BorderWidth;y++)
            graph.drawLine(BorderWidth,y,BorderWidth+TetrisThread.Cols*ElementSize,y);
    }

    private void GraphicsEffect(Graphics graph,int ymin,int ymax)
    {

        for (int line=0;line<10;line++)
        {
            graph.setColor(Color.red);
            DrawLines(graph,ymin,ymax);
            graph.setColor(Color.green);
            DrawLines(graph,ymin,ymax);
            graph.setColor(Color.blue);
            DrawLines(graph,ymin,ymax);
            graph.setColor(Color.black);
            DrawLines(graph,ymin,ymax);
        }
    }

    private void Discard(Graphics graph)
    {

        DiscardGame = false;
        GraphicsEffect(graph,0,TetrisThread.Rows);
    }

    public void update(Graphics graph)
    {

        if(DiscardGame)
           Discard(graph);
        if(PlayMapNeedRepaint)
           DrawPlayMap(graph);
        DrawCurrentShape(graph);
    }

    public void paint(Graphics graph)
    {

        DrawPlayMap(graph);
        CurrentShapeNeedRepaint = true;
        DrawCurrentShape(graph);
    }
    

    private void DrawCurrentShape(Graphics graph)
    {

        if(CurrentShapeNeedRepaint && CurrentShape != null)
        {
            CurrentShape.Hide(graph,BorderWidth);
            while(!CurrentShape.IsReady());
            CurrentShape.Display(graph,BorderWidth,applet1);
            CurrentShapeNeedRepaint = false;
        }
    }
    
    public Image GetPlayMap(int PlayMapPosition,int PlayMapStatus)
    {
        switch(PlayMapPosition)
        {
            case 1: return Rimages[PlayMapStatus];
            case 2: return Gimages[PlayMapStatus];
            case 3: return Yimages[PlayMapStatus];
            case 4: return Pimages[PlayMapStatus];
            case 5: return Bimages[PlayMapStatus];
            case 6: return Dimages[PlayMapStatus];
            default : return Dimages[0];
        }
    }
    
    private void DrawPlayMap(Graphics graph)
    {

        Image image=null;
        setBackground(Color.black);        
    	graph.setColor(BorderColor);
        graph.fillRect (0, 0, BorderWidth,ElementSize * TetrisThread.Rows+BorderWidth*2);
        graph.fillRect (ElementSize * TetrisThread.Cols + BorderWidth, 0, BorderWidth, TetrisThread.ElementSize * TetrisThread.Rows+BorderWidth);
        graph.fillRect (0,ElementSize * TetrisThread.Rows+BorderWidth, ElementSize * TetrisThread.Cols + BorderWidth * 2, BorderWidth);
        graph.fillRect (0,0,ElementSize*TetrisThread.Cols + BorderWidth*2,BorderWidth);
        if(First)
        {
            offscreenGC.drawImage(Dimages[19],BorderWidth,BorderWidth,applet1);
            graph.drawImage(Dimages[19],BorderWidth,BorderWidth,applet1);
        }
        else
        {
    	int x,y;
    	for(x=0;x<TetrisThread.Cols;x++)
    	    for(y=0;y<TetrisThread.Rows;y++)
    	       if(PlayMap[y][x] != 0)
    	       {
                	offscreenGC.drawImage(GetPlayMap(PlayMap[y][x],PlayStatus[y][x]),BorderWidth+x*ElementSize,BorderWidth+y*ElementSize,applet1);    	    	        
    	            graph.drawImage(GetPlayMap(PlayMap[y][x],PlayStatus[y][x]),BorderWidth+x*ElementSize,BorderWidth+y*ElementSize,applet1);
    	       }
    	       else 
    	       {
    	            graph.setColor(Color.black);
    	            graph.fillRect(BorderWidth+x*ElementSize,BorderWidth+y*ElementSize,ElementSize,ElementSize);
    	       }
    	}
    	PlayMapNeedRepaint = false;
    }
}

/* ================================================================================ */
class ReportCanvas extends Canvas implements ImageObserver
{
    public static final Color TextColor = Color.black;
    public static final int BorderReport = 5;
    public static final int MaxLevel = 6;
    public static final int FontHeight = 15;
    protected Font TetrisFont;
    protected FontMetrics TetrisFontMetrics;
    protected int Level,Bricks,Score;    
    protected Shape NextShape = null;
    TetrisApp appreport;
    String count_User;
    

    public void InitGame(int level)
    {
        Bricks = 0;
        Score = 0;
        Level = level;
    }

    public void GameOver()
    {
    }

    public int GetGameSpeed()
    {
        switch(Level)
        {
            case 0: return 350;
            case 1: return 300;
            case 2: return 250;
            case 3: return 200;
            case 4: return 150;
            case 5: return 100;
            case 6: return 50;
            default: return 200;
        }
    }

    public ReportCanvas(TetrisApp app)
    {
        appreport = app;
        reshape(0,0,120,300);
        TetrisFont = new Font("Dialog",Font.BOLD,12);
        setFont(TetrisFont);
        TetrisFontMetrics = getFontMetrics(TetrisFont);        
        count_User ="";
    }
    
    public void UpdateUser(String count_u)
    {
        count_User = count_u;
    }

    public void SetLevel(int level)
    {
        Level = level;
        repaint();
    }

    public void AddScore(int point)
    {
        Score+=point;
        repaint();
    }

    public void AddLines(int num)
    {
        Bricks+=num;
        if(Bricks>(100*(Level+1)))
           AddLevel();
           repaint();
    }

    public void AddLevel()
    {
        if(Level < MaxLevel)
           Level++;
           repaint();
    }

    public void DisplayNextShape(Shape shape)
    {

        NextShape = shape;
        repaint();
    }

    

    public void paint(Graphics graph)
    {

        graph.setColor(TextColor);
        graph.drawString("Connect : "+count_User + " Users",0,FontHeight);
        graph.drawString("Brick : "+Bricks,0,FontHeight*3);
        graph.drawString("Score : "+Score,0,FontHeight*5);
        graph.drawString("Stage : "+Level,0,FontHeight*7);
        graph.drawString("Next : ",0,FontHeight*9);
        if(NextShape != null)
        {
            graph.setColor(Color.black);
            graph.fillRect(5,FontHeight*9+10,100+BorderReport,100+BorderReport*2);
            graph.setColor(Color.blue);
            graph.fillRect(5,FontHeight*9+10,BorderReport,100+BorderReport);
            graph.fillRect(5,FontHeight*9+10,100+BorderReport,BorderReport);
            graph.fillRect(BorderReport+100,FontHeight*9+10,BorderReport,100+BorderReport*2);
            graph.fillRect(5,100+BorderReport+FontHeight*9+10,100+BorderReport,BorderReport);
            NextShape.DisplayAbs(graph,5,FontHeight*9+20,appreport);
        }
    }
}

/* ================================================================================ */

class Element {
    protected int     X, Y ;
    int               OldX, OldY;
    protected int     XinShape, YinShape;
    protected int     OrgX, OrgY;
    protected int     OrgXinShape, OrgYinShape;
    protected int     ElementColor;                 /* Color of each element */
    protected boolean ErasePossible;
    protected ReportCanvas report;
    protected ArenaCanvas Arena;
    boolean All = false;
    Image Reportimages[] = new Image[6];        
    MediaTracker tracker1;    
    Dimension offscreenSize;
    Image offscreenImage;
    Graphics offscreenGC;
    TetrisApp app2;
    
    public Element (int xpos, int ypos, int colorint,TetrisApp app) {
        app2 = app;
        if(!All)
        {
            tracker1 = new MediaTracker(app);
            Reportimages[0] = app.getImage(app.getCodeBase(),"image/d0.jpg");
            tracker1.addImage(Reportimages[0],0);
            Reportimages[1] = app.getImage(app.getCodeBase(),"image/r0.jpg");
            tracker1.addImage(Reportimages[1],0);
            Reportimages[2] = app.getImage(app.getCodeBase(),"image/g0.jpg");
            tracker1.addImage(Reportimages[1],0);
            Reportimages[3] = app.getImage(app.getCodeBase(),"image/y0.jpg");
            tracker1.addImage(Reportimages[1],0);
            Reportimages[4] = app.getImage(app.getCodeBase(),"image/p0.jpg");
            tracker1.addImage(Reportimages[1],0);
            Reportimages[5] = app.getImage(app.getCodeBase(),"image/b0.jpg");
            tracker1.addImage(Reportimages[1],0);
            try
            {
                tracker1.waitForID(0);
                makeDoubleBuffer(50,50);            
                All=true;
            }
            catch (InterruptedException e)
            {
                System.exit(0);
            }        
        }
        XinShape = OrgXinShape = xpos;
        YinShape = OrgYinShape = ypos;
        X = OrgX = xpos + TetrisThread.Cols/2 - (TetrisThread.MaxElement+1)/2;
        Y = OrgY = ypos;
        ElementColor  = colorint;
        ErasePossible = false;
    }

    void makeDoubleBuffer(int width,int height)
    {
        offscreenSize = new Dimension(width,height);
        offscreenImage = app2.createImage(width,height);
        offscreenGC = offscreenImage.getGraphics();
        
    }
    


    public void Init () {

        ErasePossible = false;
        X = OrgX;   Y = OrgY;
        XinShape = OrgXinShape;
        YinShape = OrgYinShape;
    }


    public void Hide  (Graphics graph, int xoff, int yoff) {

        if  (ErasePossible) {
            int size = TetrisThread.ElementSize;
            graph.setColor (Color.black);
            
            graph.fillRect (xoff + OldX * size, yoff + OldY * size, size, size);
            ErasePossible = false;
        }
    }

    public void Display  (Graphics graph, int xoff, int yoff,TetrisApp app) {

        Image ImageCurrent =Reportimages[ElementColor];
        int size=TetrisThread.ElementSize;
       	offscreenGC.drawImage(ImageCurrent,xoff+X*size,yoff+Y*size,app);    	    	        
        graph.drawImage(ImageCurrent,xoff+X*size,yoff+Y*size,app);
        OldX = X;
        OldY = Y;
        ErasePossible = true;
    }


    public void DisplayAbs  (Graphics graph, int xoff, int yoff,TetrisApp app) {

        int size = TetrisThread.ElementSize;

        Image image=Reportimages[ElementColor];
        graph.drawImage(image,xoff+OrgXinShape*size,yoff+OrgYinShape*size,app);        

        }


    public boolean CheckFit (int playmap [][],
                             int xoff, int yoff, boolean rotate) {

                                
        if  (rotate) {
            xoff += TetrisThread.MaxElement - YinShape - XinShape;
            yoff += XinShape - YinShape;
        }

        if  (X + xoff < 0 || X + xoff >= TetrisThread.Cols)
            return false;
        if  (Y + yoff >= TetrisThread.Rows )
            return false;
        if  (playmap[Y + yoff][X + xoff] != 0)
            return false;

        return true;
    }


    public void ChangePostion (int xoff, int yoff, boolean rotate) {

        if  (rotate) {
            xoff += TetrisThread.MaxElement - YinShape - XinShape;
            yoff += XinShape - YinShape;
            int tempXinShape = XinShape;
            XinShape = TetrisThread.MaxElement - YinShape;
            YinShape = tempXinShape;
        }

        X += xoff;
        Y += yoff;
    }


    public int   GetXPos  () { return X; }
    public int   GetYPos  () { return Y; }
    public int  GetColor () { return ElementColor; }

}


/* ================================================================================ */

class Shape {
    protected Vector  Elements;
    protected boolean DrawReady = true;
    protected int     y[];
    protected int     x[];
    TetrisApp applet3;    
    int BorderWidth=5;


    public Shape () {
        DrawReady = true;

    }


    public void Init () {

        DrawReady = true;
        for  (int ix=0; ix<Elements.size (); ix++)
            ((Element) Elements.elementAt (ix)).Init () ;
    }

    public Shape (TetrisApp app,int blockcolor []) {

        applet3 = app;
        Elements = new Vector ();
        for (int i=0; i<2; i++)
            AddElements (i, blockcolor[i]);
        Init ();
    }


    protected void AddElements  (int row, int mapcolor) {

         Elements.addElement (new Element (1, row, mapcolor,applet3));
        }


    public void Hide  (Graphics graph, int xoff) {

        for  (int ix=0; ix<Elements.size (); ix++)
            ((Element) Elements.elementAt (ix)).Hide (graph, xoff, BorderWidth);
    }


    public void Display  (Graphics graph, int xoff,TetrisApp app) {

        DrawReady = false;
        for  (int ix=0; ix<Elements.size (); ix++)
            ((Element) Elements.elementAt (ix)).Display (graph, xoff, BorderWidth,app);
        DrawReady = true;
    }


    public void DisplayAbs  (Graphics graph, int x, int y,TetrisApp app) {

        for  (int ix = 0; ix < Elements.size (); ix++)
            ((Element) Elements.elementAt (ix)).DisplayAbs (graph, x, y,app);
        }


    public boolean CheckFit (int playmap [][],
                             int xoff, int yoff,
                             boolean rotate) {

        for  (int ix=0; ix<Elements.size (); ix++)

            if (! ((Element) Elements.elementAt (ix)).CheckFit (
                playmap, xoff, yoff, rotate))
                return false;


        return true;
    }


    public void ChangePosition (int xoff, int yoff, boolean rotate) {

        for  (int ix=0; ix<Elements.size (); ix++)
            ((Element) Elements.elementAt (ix)).ChangePostion (
                xoff, yoff, rotate);
    }

    public void Place (int playmap [][],int mapy[],int mapx[],int playstatus[][],int playvalue[][]) {

        for  (int ix=0; ix<Elements.size (); ix++) {
            Element element = (Element) Elements.elementAt (ix) ;
            playmap [element.GetYPos()] [element.GetXPos()] = element.GetColor();
            playvalue [element.GetYPos()] [element.GetXPos()] = 1;
            playstatus [element.GetYPos()] [element.GetXPos()] = 16;            
            mapy[ix] = element.GetYPos();
            mapx[ix] = element.GetXPos();
        }
    }

    public boolean IsReady () { return DrawReady; }


}



/* ================================================================================ */
class AboutFrame extends Frame
{
    Button OK = new Button("OK");
    Label Sp1 = new Label("                ");
    Label Sp2 = new Label("                ");
    Label Sp3 = new Label("                ");
    Label Sp4 = new Label("                ");
    Label Sp5 = new Label("                ");    
    Label St1 = new Label("Puyo On-Line Game",Label.CENTER);
    Label St2 = new Label("Up : Rotate , Down : Drop",Label.CENTER);
    Label St3 = new Label("Right : Move Right",Label.CENTER);
    Label St4 = new Label("Left : Move Left",Label.CENTER);    
    public AboutFrame()
    {
        super ("Puyo Game");
        resize(200,230);
        setResizable(false);
        setLayout(new FlowLayout(FlowLayout.CENTER,1000,0));
        add(St1);
        add(Sp1);
        add(St2);
        add(Sp2);
        add(St3);
        add(Sp3);
        add(St4);
        add(Sp4);
        add(OK);
}

    public synchronized boolean handleEvent(Event event)
    {
        if(event.id != Event.ACTION_EVENT)
           return false;
        if("OK".equals(event.arg))
           dispose();
           return true;
    }
}

class Listener extends Thread
{
    protected DataInputStream sin;
    protected boolean running = false;
    protected TetrisApp applet;
    
    public Listener(Socket s,TetrisApp applet)
    {
        this.applet = applet;
        try
        {
            sin = new DataInputStream(s.getInputStream());
        }
        catch (IOException e)
        {
            running = false;
            applet.cleanUp();
            return;
        }
        this.start();
    }

    public void run()
    {
        running = true;
        String line;
        while (true)
        {
            try
            {
                line = sin.readLine();
            }
            catch(IOException e)
            {
                running = false;
                applet.cleanUp();
                return;
            }
            if (line==null)
            {
            }
            else
            applet.AddSuffer(line);
        }
    }
}












