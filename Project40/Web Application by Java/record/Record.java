
import java.awt.*;
import java.applet.AudioClip;
import java.applet.Applet;
import java.util.Vector;
import java.lang.Math;
import java.lang.Thread;
import java.lang.System;
import java.awt.image.*;
import java.awt.MediaTracker;
import java.awt.Graphics;
import java.awt.Image;

public class Record extends java.applet.Applet
{
    Panel Player1;
    RecordThread Karaoker;
    public static AudioClip Sound;
    symantec.itools.awt.ImageButton imageButton1;
    symantec.itools.awt.ImageButton imageButton3;
    symantec.itools.awt.ImageButton imageButton2;
    public void init()
    {
        Sound = getAudioClip(getCodeBase(),getParameter("Song"));
        setBackground(new Color(160));
        setLayout(new BorderLayout());
        Panel grid = new Panel();
        grid.setLayout(new GridLayout(1,1));
        add("Center",grid);
        Player1 = new Panel();
        Player1.setLayout(null);
        grid.add("Left",Player1);
        Panel control = new Panel();
        control.setLayout(new FlowLayout());
        add("South",control);

        imageButton1 = new symantec.itools.awt.ImageButton();
        imageButton1.reshape(60,60,48,24);
        control.add(imageButton1);
        try
        {
//            imageButton1.setImageURL(new java.net.URL("file:/c:/winnt/profiles/administrator/desktop/kara/play.gif"));
            imageButton1.setImageURL(new java.net.URL("http://sunshine09.ce.kmitl.ac.th/java/Karaok1/kara/play.gif"));
        }
        catch (java.net.MalformedURLException error)
        {
        }
        imageButton3 = new symantec.itools.awt.ImageButton();
        imageButton3.reshape(120,60,48,24);
        control.add(imageButton3);
        try
        {
            imageButton3.setImageURL(new java.net.URL("http://sunshine09.ce.kmitl.ac.th/java/Karaok1/kara/stop.gif"));
//            imageButton3.setImageURL(new java.net.URL("file:/c:/winnt/profiles/administrator/desktop/kara/stop.gif"));
        }
        catch (java.net.MalformedURLException error)
        {}
        imageButton2 = new symantec.itools.awt.ImageButton();
        imageButton2.reshape(180,60,48,24);
        control.add(imageButton2);
        try
        {
            imageButton2.setImageURL(new java.net.URL("file:/c:/winnt/profiles/administrator/desktop/kara/pause.gif"));
        }
        catch(java.net.MalformedURLException error)
        {}
    }

        public void start()
        {
            Karaoker = new RecordThread(this,Player1);
            Karaoker.start();
        }

        public void stop()
        {
            Karaoker.stop();
        }

        public boolean CommandAction(Event event,Object arg)
        {
            if(event.target == imageButton1)
            {
                if(Sound != null)
                Sound.play();
                Karaoker.Play();
            }

            if(event.target == imageButton3)
            {
                Sound.stop();
                Karaoker.Stop();
            }
            if(event.target == imageButton2)
            {
                Karaoker.DisplayLyrics();
            }
            return true;
        }

        public synchronized boolean handleEvent(Event event)
        {
            switch(event.id)
            {
                case Event.ACTION_EVENT:
                     return CommandAction(event,event.arg);
                case Event.KEY_PRESS:
                     Karaoker.KeyAction(event.key);
                     return true;
                default:
                      return false;
            }
        }
}


class RecordThread extends Thread
{
    Record Applet;
    RecordCanvas Arena;
    RecordReport Report;
    public int Click_time = 0;
    boolean SongPlay = false;
    boolean SongStop = true;
    boolean SongPaused = false;

    public RecordThread(Record app,Panel panel)
    {
        Applet = app;
        Arena = new RecordCanvas(Applet);
        panel.add(Arena);
        Report = new RecordReport(Applet);
        panel.add(Report);
        Arena.SetSong();
    }

    public void DisplayLyrics()
    {
        Arena.Display_Lyrics();
    }

    public void Play()
    {
        SongPaused = false;
      	SongPlay = true;
      	SongStop = false;
        Arena.SetSong();
       	Arena.Play();
       	Report.Play();
    }
    public void Pause()
    {
        SongPaused = !SongPaused;
    }

    public void Record()
    {
    	SongPlay = false;
        SongStop = false;
    	Arena.Record();
    	Report.Record();
    }

    public void Stop()
    {
        Arena.SetSong();
        SongStop = true;
    	Arena.Stop();
    	Report.Stop();
    }

    public void Stop(boolean needstop)
    {
        SongStop = needstop;
    }

    public void run()
    {
        for(;;)
        {
            try
            {
                Thread.sleep(100);
            }
            catch(InterruptedException e) {}
            if(!SongPaused && !SongStop)
            UpdateLyrics(false,0,0,false);
        }
    }

    public synchronized void UpdateLyrics(boolean user,int x,int y,boolean test)
    {
        Report.RepaintClock();
    	Arena.RepaintPlayLyrics();

    }
    public boolean KeyAction(int key)
    {
        if(SongStop)
        return true;
        else
       {
        Click_time = Report.Display();
        Arena.Display(Click_time);
        return true;
       }
    }
}

    class RecordCanvas extends Canvas implements ImageObserver
    {
        Record applet1;
        public static final int FontHeight = 30;
        protected Font LyricsFont;
        protected FontMetrics LyricsFontMetrics;
        MediaTracker trackerr;
        public String Lyrics;
        public int time_send=0;
        public String Total_String1,Total_String2,Current_Lyrics,Next_Lyrics;
        public int index_Next,index_Now,index_time,now_x,next_x;
        boolean Playing = false;
        boolean Stoping = true;
        boolean Recording = false;
        boolean PlayLyricsNeedRepaint = false;
        boolean change = false;
        int ball_Drop = 0;
        int next_ball_Drop=0;
        int Old_Stop_Time = 0;
        int FontWidth = 0;
        int Receive_Time=0;
        int canvas_width,canvas_height ;
        int Stop_Time=0;
        int count=0;
        int count_Lyrics=0;
        int Current,Next,end_Current;
        Graphics gcc;
        AboutFrame about;
        Image framee_image,ball_image;
        boolean St1 = true;
        boolean first = true;
        int ball_width = 0;
        Image buf_image = null;
        int distance=0;
        int init_Stop_Time = 0;
        int count_div = 0;
        int dis_x = 0;
        int dis_y = 0;
        int ball_Drop_y=0;


        public RecordCanvas(Record app)
        {
             applet1 = app;
             setForeground(new Color(16777215));
             setBackground(new Color(255));
             LyricsFont = new Font("TimesRoman",Font.BOLD,30);
             setFont(LyricsFont);
             LyricsFontMetrics = getFontMetrics(LyricsFont);
             FontWidth = LyricsFont.getSize();
             count_Lyrics = Integer.parseInt(applet1.getParameter("Count"));
             framee_image = applet1.getImage(applet1.getCodeBase(),"kara/b1.gif");
             trackerr = new MediaTracker(applet1);
             trackerr.addImage(framee_image,0);
             try
             {
        		trackerr.waitForAll(0);
        		trackerr.waitForAll(1);
             }
             catch(InterruptedException e)
             {}
             ball_image = applet1.getImage(applet1.getCodeBase(),"kara/ball2.gif");
             trackerr.addImage(ball_image,0);
             try
             {
        		trackerr.waitForAll(0);
        		trackerr.waitForAll(1);
             }
             catch(InterruptedException e)
             {}
             canvas_width = framee_image.getWidth(applet1);
             canvas_height = framee_image.getHeight(applet1);
             try
             {
                 reshape(8,8,canvas_width,canvas_height);
                 buf_image = applet1.createImage(canvas_width,canvas_height);
                 gcc = buf_image.getGraphics();
             }
             catch(Exception e)
             {
                gcc=null;
             }
             ball_width = ball_image.getWidth(applet1)/2;
             about = new AboutFrame();
        }

        public void Display_Lyrics()
        {
            about.show();
        }

        public void RepaintPlayLyrics()
        {
            repaint();
        }
        public void GetNextLyrics()
        {
            if(Current <= count_Lyrics)
            {
                if(change)
                {
                    change = false;
                    now_x = next_x;
                    St1 = !St1;                 //set to first Lyrics
                    Current = Next;
                    Next = Next+1;
                    Current_Lyrics = Next_Lyrics;
                    end_Current = Current_Lyrics.length();
                    int w = Current_Lyrics.indexOf(" ",now_x);
                    next_x = w+1;
                    String temp2 = Current_Lyrics.substring(now_x,w);
                    ball_Drop= LyricsFontMetrics.stringWidth(temp2)/2+30;
                    ball_Drop = ball_Drop - ball_width;
                    int t = Current_Lyrics.indexOf(" ",next_x);
                    String temp4 = Current_Lyrics.substring(next_x,t);
                    next_ball_Drop = (LyricsFontMetrics.stringWidth(temp4)/2);
                    String temp5 = Current_Lyrics.substring(0,next_x);
                    int Temp_ball = LyricsFontMetrics.stringWidth(temp5)+30;
                    next_ball_Drop = next_ball_Drop + Temp_ball - ball_width;
                    if(Next <= count_Lyrics)
                    {
                        Next_Lyrics = applet1.getParameter("Lyrics"+Next);
                        Next_Lyrics = Next_Lyrics.toUpperCase();
                    }
                }
                else
                {
                    now_x = next_x;
                    int x = Current_Lyrics.indexOf(" ",now_x);
                    next_x = x+1;
                    String temp1 = Current_Lyrics.substring(0,now_x);
                    ball_Drop = LyricsFontMetrics.stringWidth(temp1)+30;
                    String temp2 = Current_Lyrics.substring(now_x,x);
                    int X_temp = LyricsFontMetrics.stringWidth(temp2)/2;
                    ball_Drop = ball_Drop + X_temp-ball_width;
                    if(next_x < end_Current)
                    {
                        try
                        {
                            int t = Current_Lyrics.indexOf(" ",next_x);
                            String temp4 = Current_Lyrics.substring(next_x,t);
                            next_ball_Drop = (LyricsFontMetrics.stringWidth(temp4)/2);
                            String temp5 = Current_Lyrics.substring(0,next_x);
                            int Temp_ball = LyricsFontMetrics.stringWidth(temp5)+30;
                            next_ball_Drop = next_ball_Drop + Temp_ball - ball_width;

                        }
                        catch(NumberFormatException e)
                        {}
                    }
                    else
                    {
                        change = true;
                        next_x = 0;
                        int n1 = Next_Lyrics.indexOf(" ",0);
                        String n2 = Next_Lyrics.substring(0,n1);
                        next_ball_Drop = (LyricsFontMetrics.stringWidth(n2)/2)+30;
                        next_ball_Drop = next_ball_Drop -ball_width;
                    }
                }
            }
        }

        public void SetSong()
        {
            Old_Stop_Time = 0;
            St1 = true;                 //set to first Lyrics
            Current = 1;
            Next = 2;
            ball_Drop=10;
            Current_Lyrics = applet1.getParameter("Lyrics1");
            Current_Lyrics = Current_Lyrics.toUpperCase();
            end_Current = Current_Lyrics.length();
            now_x=0;
            next_x=0;
            Next_Lyrics = applet1.getParameter("Lyrics2");
            Next_Lyrics = Next_Lyrics.toUpperCase();
        }

        public void Record()
        {
        	Playing = false;
        	Stoping = false;
        	Recording = true;
        	time_send = 0;
        }

        public void Play()
        {
        	Playing = true;
        	Stoping = false;
        	Recording = false;
        	time_send = 0;
        	about.clear();

        }

        public void Stop()
        {
        	Playing = false;
        	Stoping = true;
        	Recording = false;
        	time_send = 0;
        	repaint();
        }

        public void Display(int Time)
        {
            time_send = Time;
            Old_Stop_Time = time_send - Old_Stop_Time;
            if(change)
            about.addText("/\n/"+Old_Stop_Time);
            else
            about.addText("/"+Old_Stop_Time);
            Old_Stop_Time = time_send;
            GetNextLyrics();
            repaint();

        }


        public void paint(Graphics graph)
        {
            gcc.drawImage(framee_image,0,0,applet1);
            if(!Stoping)
            {
                gcc.setFont(LyricsFont);
                if(Playing)
                {
                    if (St1)
                    {
                        gcc.setColor(Color.white);
                        gcc.drawString(Current_Lyrics,30,FontHeight*5);
                        gcc.setColor(Color.lightGray);
                        gcc.drawString(Next_Lyrics,30,FontHeight*10);
                        gcc.drawImage(ball_image,ball_Drop,(FontHeight*3)-ball_Drop_y,applet1);
                    }
                    else
                    {
                       gcc.setColor(Color.lightGray);
                       gcc.drawString(Next_Lyrics,30,FontHeight*5);
                       gcc.setColor(Color.white);
                       gcc.drawString(Current_Lyrics,30,FontHeight*10);
                       gcc.drawImage(ball_image,ball_Drop,(FontHeight*8)-ball_Drop_y,applet1);
                    }
                }
            }
            graph.drawImage(buf_image,0,0,applet1);
        }

        public void update(Graphics g)
        {
        	paint(g);
        }

    }

    //===================================================================================

    class RecordReport extends Canvas implements ImageObserver
    {
        Record applet2;
        MediaTracker tracker;
        Image[] digit_image = new Image[10];
        Image buffer_image,colon_image,frame_image;
        Graphics gc;
        int digit_height = 21;
        int digit_width = 16;
        int colon_width = 9;
        int offset = 4;
        int back_width = 200;
        int back_height=33;
        int[] image_start_x = new int[8];
        boolean Played = false;
        boolean Stoped = true;
        boolean Recorded = false;
        boolean PlayClock = false;
        int time_display=0;


        public int Display()
        {
            return time_display;
        }

        public void Play()
        {
            Played = true;
            Stoped = false;
            Recorded = false;
            time_display=0;
        }

        public void Record()
        {
        	Played = false;
        	Stoped = false;
        	Recorded = true;
        	time_display=0;
        }

        public void Stop()
        {
        	Played = false;
        	Stoped = true;
        	Recorded = false;
        	time_display=0;
        }


        public RecordReport(Record app)
        {
            applet2 = app;
            reshape(8,380,100,20);
            setForeground(new Color(16777215));
            setBackground(new Color(0));
            tracker = new MediaTracker(applet2);
            for(int i=0;i<10;i++)
            {
		            digit_image[i] = applet2.getImage(applet2.getCodeBase(),"kara/"+i+".gif");
                    tracker.addImage(digit_image[i],1);
            }
            colon_image = applet2.getImage(applet2.getCodeBase(),"kara/colon.gif");
            tracker.addImage(colon_image,1);
            frame_image = applet2.getImage(applet2.getCodeBase(),"kara/back.gif");
        	tracker.addImage(frame_image,1);
            try
            {
        		tracker.waitForAll(0);
                tracker.waitForAll(1);
            }
            catch(InterruptedException e)  {}
        	digit_height = digit_image[0].getHeight(applet2);
     	    digit_width = digit_image[0].getWidth(applet2);
        	colon_width = colon_image.getWidth(applet2);
        	image_start_x[0] = offset;
            for(int i=1;i<8;i++)
        	{
        		if((i==3)||(i==6))
  		        	image_start_x[i] = image_start_x[i-1]+colon_width;
        		else
		        	image_start_x[i] = image_start_x[i-1] + digit_width;
        	}
        	back_width=frame_image.getWidth(applet2);
        	back_height=frame_image.getHeight(applet2);
        	reshape(8,380,back_width,back_height);
        	try
        	{
        		buffer_image = applet2.createImage(back_width,back_height);
        		gc = buffer_image.getGraphics();
        	}
        	catch(Exception e)
        	{
        	    gc=null;
        	}


        }

        public void RepaintClock()
        {
            time_display=time_display+100;
            repaint();
        }

        public void paint(Graphics g)
        {
            int hour = (time_display/3600000);
            int minute = (time_display/60000);
            int second = ((time_display-(minute*60000))/1000)            ;
        	int i=0;
        	gc.drawImage(frame_image,0,0,applet2);
        	gc.drawImage(digit_image[hour/10],image_start_x[i++],offset,applet2);
        	gc.drawImage(digit_image[hour%10],image_start_x[i++],offset,applet2);
        	gc.drawImage(colon_image,image_start_x[i++],offset,applet2);
        	gc.drawImage(digit_image[minute/10],image_start_x[i++],offset,applet2);
        	gc.drawImage(digit_image[minute%10],image_start_x[i++],offset,applet2);
        	gc.drawImage(colon_image,image_start_x[i++],offset,applet2);
        	gc.drawImage(digit_image[second/10],image_start_x[i++],offset,applet2);
        	gc.drawImage(digit_image[second%10],image_start_x[i++],offset,applet2);
        	g.drawImage(buffer_image,0,0,applet2);
        }

        public void update(Graphics g)
        {
            paint(g);
        }
    }

class AboutFrame extends Frame
{
    Button OK = new Button("OK");
    TextArea Lyricc = new TextArea();

    public AboutFrame()
    {
        super ("Ohyo Game");
        resize(500,200);
        setResizable(true);
        setLayout(new FlowLayout(FlowLayout.CENTER,1000,0));
        add(Lyricc);
        add(OK);

    }

    public void clear()
    {
        Lyricc.setText("");
    }
    public void addText(String message)
    {
        Lyricc.appendText(message);
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


