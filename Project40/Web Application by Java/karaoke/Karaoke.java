
import java.awt.*;
import java.io.*;
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

public class Karaoke extends java.applet.Applet
{
    Panel Player1;
    KaraokeThread Karaoke1;
    public static AudioClip Sound;
    symantec.itools.awt.ImageButton imageButton1;
    symantec.itools.awt.ImageButton imageButton3;

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
            imageButton1.setImageURL(new java.net.URL("http://sunshine09.ce.kmitl.ac.th/java/Karaoke1/kara/play.gif"));
        }
        catch (java.net.MalformedURLException error)
        {
        }
        imageButton3 = new symantec.itools.awt.ImageButton();
        imageButton3.reshape(120,60,48,24);
        control.add(imageButton3);
        try
        {
            imageButton3.setImageURL(new java.net.URL("http://sunshine09.ce.kmitl.ac.th/java/Karaoke1/kara/stop.gif"));
        }
        catch (java.net.MalformedURLException error)
        {}
}

        public void start()
        {
            Karaoke1 = new KaraokeThread(this,Player1);
            Karaoke1.start();
        }

        public void stop()
        {
            Karaoke1.stop();
        }

        public boolean CommandAction(Event event,Object arg)
        {
            if(event.target == imageButton1)
            {
                if(Sound != null)
                Sound.play();
                Karaoke1.Play();
            }
            if(event.target == imageButton3)
            {
                Sound.stop();
                Karaoke1.Stop();
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
                     return true;
                default:
                      return false;
            }
        }
}

class KaraokeThread extends Thread
{
    Karaoke Applet;
    ArenaCanvas Arena;
    ReportCanvas Report;
    public int Click_time = 0;
    boolean SongPlay = false;
    boolean SongStop = true;

    public KaraokeThread(Karaoke app,Panel panel)
    {
        Applet = app;
        Arena = new ArenaCanvas(Applet);
        panel.add(Arena);
        Report = new ReportCanvas(Applet);
        panel.add(Report);
    }

    public void Play()
    {
      	SongPlay = true;
      	SongStop = false;
        Arena.SetSong();
       	Arena.Play();
       	Report.Play();
    }


    public void Stop()
    {
        SongStop = true;
    	Arena.Stop();
    	Report.Stop();
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
            if(!SongStop)
            UpdateLyrics(false,0,0,false);
        }
    }

    public synchronized void UpdateLyrics(boolean user,int x,int y,boolean test)
    {
        Report.RepaintClock();
        Click_time=Report.Display();
    	Arena.RepaintPlayLyrics(Click_time);

    }
}

    class ArenaCanvas extends Canvas implements ImageObserver
    {
        Karaoke applet1;
        public static final int FontHeight = 30;
        protected Font LyricsFont;
        protected FontMetrics LyricsFontMetrics;
        MediaTracker trackerr;
        public String Lyrics;
        public String Total_String1,Total_String2,Current_Lyrics,Next_Lyrics;
        public int index_Next,index_Now,index_time,now_x,next_x;
        boolean Playing = false;
        boolean Stoping = true;
        boolean change = false;
        int ball_Drop = 0;
        int next_ball_Drop=0;
        int FontWidth = 0;
        int Receive_Time=0;
        int canvas_width,canvas_height ;
        int Stop_Time=0;
        int count=0;
        int count_Lyrics=0;
        int Current,Next,end_Current;
        int Temp_Time;
        Graphics gcc;
        Image framee_image,ball_image;
        boolean St1 = true;
        boolean first = true;
        boolean End_Line = false;
        int ball_width = 0;
        Image buf_image = null;
        int distance=0;
        int init_Stop_Time = 0;
        int count_div = 0;
        int dis_x = 0;
        int dis_y = 0;
        int ball_Drop_y=0;
        boolean Mucher = true;


        public ArenaCanvas(Karaoke app)
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
        }

        public void State_run()
        {

            if(Receive_Time >= Temp_Time)
            {
                ball_Drop_y = ball_Drop_y + dis_y;
            }

        }
        public void Stable_Run()
        {
            if(init_Stop_Time>=1000)
            {
                Temp_Time = init_Stop_Time-1000;
                dis_y = (FontHeight*2)/10;
            }
            else
            {
            Temp_Time = 0;
            dis_y = (FontHeight*2)/(init_Stop_Time/100);
            }
        }
        public void RepaintPlayLyrics(int Time_Now)
        {
            Receive_Time = Time_Now;
            if(Receive_Time==Stop_Time)
            {
                End_Line = false;
             	GetNextLyrics();
                repaint();
            }
            else
            {
                if(first)
                {
                    State_run();
                }
                else if(End_Line)
                {
                    if(Mucher)
                    ball_Drop_y = ball_Drop_y + dis_y;
                    else
                    ball_Drop_y = ball_Drop_y - dis_y;
                    if(ball_Drop_y >= 50)
                    Mucher = false;
                    if(!Mucher && (ball_Drop_y <=0))
                    Mucher = true;

                }
                else
                Change_x();
                repaint();
            }
        }

        public void Change_x()
        {
            ball_Drop = ball_Drop + dis_x;
            count = count+1;
            if((count_div%2) == 0)
            {
                if(count <= (count_div/2))
                ball_Drop_y = ball_Drop_y + dis_y;
                else
                ball_Drop_y = ball_Drop_y - dis_y;
            }
            else
            {
                if(count <= (count_div/2))
                ball_Drop_y = ball_Drop_y + dis_y;
                else if (count == ((count_div/2)+1))
                ball_Drop_y = ball_Drop_y;
                else
                ball_Drop_y = ball_Drop_y - dis_y;
            }
        }

        public void Calculate()
        {
            count_div = init_Stop_Time/100;
            dis_x = distance/count_div;
            ball_Drop_y = 0;
            if((count_div%2) == 0)
            {
                dis_y = 100/count_div;
            }
            else
            {
                dis_y = 100/(count_div+1);
            }
            count = 0;
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
                    Total_String1 = Total_String2;
                    int x = Total_String1.indexOf("/",0)            ;
                    Current_Lyrics = Total_String1.substring(0,x);
                    end_Current = Current_Lyrics.length();
                    int z = Current_Lyrics.indexOf(" ",0);
                    index_time = x+1;
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
                    distance = next_ball_Drop - ball_Drop;
                    try
                    {
                        int y = Total_String1.indexOf("/",index_time);
                        int u = Total_String1.indexOf("/",y+1);
                        init_Stop_Time = Integer.parseInt(Total_String1.substring(y+1,u));
                        Stop_Time = Stop_Time + init_Stop_Time;
                        index_time = u+1;
                        Calculate();
                    }
                    catch(NumberFormatException e)
                    {}

                    if(Next <= count_Lyrics)
                    {
                        Total_String2 = applet1.getParameter("Lyrics"+Next);
                        Total_String2 = Total_String2.toUpperCase();
                        int s = Total_String2.indexOf("/",0);
                        Next_Lyrics = Total_String2.substring(0,s);
                    }
                    else
                    {
                        Next_Lyrics = "";
                        Total_String2 = "";
                    }
                }
                else
                {
                    first=false;
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
                            End_Line = false;
                            int y = Total_String1.indexOf("/",index_time);
                            int w =  Integer.parseInt(Total_String1.substring(index_time,y));
                            init_Stop_Time = Integer.parseInt(Total_String1.substring(index_time,y));
                            Stop_Time = Stop_Time+init_Stop_Time;
                            index_time = y+1;
                            int t = Current_Lyrics.indexOf(" ",next_x);
                            String temp4 = Current_Lyrics.substring(next_x,t);
                            next_ball_Drop = (LyricsFontMetrics.stringWidth(temp4)/2);
                            String temp5 = Current_Lyrics.substring(0,next_x);
                            int Temp_ball = LyricsFontMetrics.stringWidth(temp5)+30;
                            next_ball_Drop = next_ball_Drop + Temp_ball - ball_width;
                            distance = next_ball_Drop - ball_Drop;
                            count = 0;
                            Calculate();

                        }
                        catch(NumberFormatException e)
                        {}
                    }
                    else
                    {
                        End_Line = true;
                        Mucher = true;
                        Current_Line();
                        change = true;
                        next_x = 0;
                        int h = Total_String2.indexOf("/",0);
                        int m = Total_String2.indexOf("/",h+1);
                        init_Stop_Time = Integer.parseInt(Total_String2.substring(h+1,m));
                        Stop_Time = Stop_Time+init_Stop_Time;
                        int n1 = Next_Lyrics.indexOf(" ",0);
                        String n2 = Next_Lyrics.substring(0,n1);
                        next_ball_Drop = (LyricsFontMetrics.stringWidth(n2)/2)+30;
                        next_ball_Drop = next_ball_Drop -ball_width;
                        distance=0;
                        count_div = 0;
                        dis_x = 0;
                        ball_Drop_y = 0;
                    }
                }
            }
            else
            {
            dis_x = 0;
            dis_y =0;
            ball_Drop_y = 0;
            }
        }

        public void Current_Line()
        {
            dis_y = 5;
        }
        public void SetSong()
        {
            Mucher = true;
            count = 0;
            dis_y =  0;
            dis_x = 0;
            count_div = 0;
            End_Line = false;
            first = true;
            ball_Drop = 30;
            ball_Drop_y = 0;
            next_ball_Drop = 30;
            distance=0;
            St1 = true;                 //set to first Lyrics
            Current = 1;
            Next = 2;
            Total_String1 = applet1.getParameter("Lyrics1");
            Total_String1 = Total_String1.toUpperCase();
            int x = Total_String1.indexOf("/",0)            ;
            Current_Lyrics = Total_String1.substring(0,x);
            end_Current = Current_Lyrics.length();
            int z = Current_Lyrics.indexOf(" ",0);
            index_time = x+1;
            now_x=0;
            next_x=0;
            int m = Current_Lyrics.indexOf(" ",now_x);
            String temp1 = Current_Lyrics.substring(0,now_x);
            ball_Drop = LyricsFontMetrics.stringWidth(temp1)+30;
            String temp2 = Current_Lyrics.substring(now_x,m);
            int X_temp = LyricsFontMetrics.stringWidth(temp2)/2;
            ball_Drop = ball_Drop + X_temp-ball_width;
            try
            {
                int y = Total_String1.indexOf("/",index_time);
                init_Stop_Time = Integer.parseInt(Total_String1.substring(index_time,y));
                Stop_Time = init_Stop_Time;
                index_time = y+1;
            }
            catch(NumberFormatException e)
            {}
            Total_String2 = applet1.getParameter("Lyrics2");
            Total_String2 = Total_String2.toUpperCase();
            int s = Total_String2.indexOf("/",0);
            Next_Lyrics = Total_String2.substring(0,s);
            Stable_Run();
        }

        public void Play()
        {
        	Playing = true;
        	Stoping = false;

        }

        public void Stop()
        {
        	Playing = false;
        	Stoping = true;
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
                        if(first)
                        gcc.drawImage(ball_image,ball_Drop,(FontHeight) + ball_Drop_y,applet1);
                        else
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

    class ReportCanvas extends Canvas implements ImageObserver
    {
        Karaoke applet2;
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
            time_display=0;
        }

        public void Stop()
        {
        	Played = false;
        	Stoped = true;
        	time_display=0;
        }


        public ReportCanvas(Karaoke app)
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


