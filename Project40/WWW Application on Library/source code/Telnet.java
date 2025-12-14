import java.net.*;
import java.awt.*;
import java.io.*;
import java.lang.*;

public class Telnet extends java.applet.Applet
{
 String hoststr,portstr,emstr,authstr,titlestr; // parameters giving host & port
 String fieldson;
 Panel controls;
 TelnetClient tn;              // telnet component
 TextField hostfield;
 TextField portfield;
 TextField emfield;
 TextField actionfield;
 
 //*********************
 TextField authfield;
 TextField titlefield;
 //*********************
 
 Button connect, disconnect;
 boolean firsttime = true;
 String UserOs = System.getProperty("os.name");

 public void init()
   {
   // Set up interface
   hoststr = getParameter("host");
   portstr = getParameter("port");
   emstr   = getParameter("emulation");
   fieldson = getParameter("fields");

   //***************************
   authstr = getParameter("author");
   titlestr = getParameter("title");
   //***************************

   if (hoststr == null) hoststr = "161.246.37.11";
   if (portstr == null) portstr = "23";
   if (emstr == null) emstr = "ANSI";
   if (fieldson == null) fieldson = "ON";

   //***********************
   if (authstr == null) authstr = "john";
   if (titlestr == null) titlestr = "introduction";
   //***********************

   // Create interface
     setLayout(new BorderLayout());
     tn = new TelnetClient();
     add("Center",tn);
//     add("Center",tn = new TelnetClient());
     add("North",controls = new Panel());
     controls.setLayout(new FlowLayout());

   if (fieldson.compareTo("OFF") == 0)
     {
     controls.add(connect = new Button("Connect"));
     controls.add(disconnect = new Button("Disconnect"));
     return;
     }

   if (UserOs.compareTo("Windows NT") == 0)
     {
    // controls.add(new Label("Host "));
     hostfield = new TextField(10);
    // controls.add(hostfield = new TextField(10));
     hostfield.setText(hoststr);
    // controls.add(new Label("Port "));
     portfield = new TextField(3);
    // controls.add(portfield = new TextField(3));
     portfield.setText(portstr);
   //  controls.add(new Label("Emulation "));
     emfield = new TextField(7);
   //  controls.add(emfield = new TextField(7));
     emfield.setText(emstr);
  // ############
     controls.add(new Label("author "));
     controls.add(authfield = new TextField(10));
     authfield.setText(authstr);
     controls.add(new Label("Title "));
     controls.add(titlefield = new TextField(10));
     titlefield.setText(titlestr);
  // ############

     controls.add(connect = new Button("Connect"));
     controls.add(disconnect = new Button("Disconnect"));
     }
   else if (UserOs.compareTo("BSD/OS") == 0)
     {
     controls.add(new Label("Host"));
     controls.add(hostfield = new TextField(10));
     hostfield.setText(hoststr);
     controls.add(new Label("Port"));
     controls.add(portfield = new TextField(2));
     portfield.setText(portstr);
     controls.add(new Label("Emulation"));
     controls.add(emfield = new TextField(4));
     emfield.setText(emstr);
     controls.add(connect = new Button("Connect"));
     controls.add(disconnect = new Button("Disconnect"));

     }
   else
     {
    // controls.add(new Label("Host "));
     hostfield = new TextField(10);
    // controls.add(hostfield = new TextField(10));
     hostfield.setText(hoststr);
    // controls.add(new Label("Port "));
     portfield = new TextField(3);
    // controls.add(portfield = new TextField(3));
     portfield.setText(portstr);
   //  controls.add(new Label("Emulation "));
     emfield = new TextField(7);
   //  controls.add(emfield = new TextField(7));
     emfield.setText(emstr);
  // ############
     controls.add(new Label("author "));
     controls.add(authfield = new TextField(10));
     authfield.setText(authstr);
     controls.add(new Label("Title "));
     controls.add(titlefield = new TextField(10));
     titlefield.setText(titlestr);
  // ############

     controls.add(connect = new Button("Connect"));
     controls.add(disconnect = new Button("Disconnect"));
     }
		//{{INIT_CONTROLS
		//}}
}

 public void con()
   {
   int port;
   // Don't try if the telnet client doesn't exist.
   if (tn == null)
     return;

   tn.disconnect();

   if (fieldson.compareTo("OFF") == 0)
     {
     if (portstr.equals(""))
       port = 23;
     else
       port =  Integer.parseInt(portstr);

     tn.connect(hoststr,port,emstr,authstr,titlestr);
     return;
     }

   // Integer.parseInt blows up if the string is null, that's not right :-)
   if (portfield.getText().equals(""))
     port = 23;
   else {
     port =  Integer.parseInt(portfield.getText());
     }
   tn.connect(hostfield.getText(),port, emfield.getText(), authfield.getText(), titlefield.getText());  
   }

 public void start()
   {

   if (firsttime == true)
 //  con();

   firsttime = false;
   }

 public boolean action(Event e, Object arg)
   {
   if (e.target == connect)
     con();
   else if (e.target == disconnect)
     tn.disconnect();
   return true;
   }

 public String getaction()
 {
    String tstring = " ";
    tstring = actionfield.getText();
    tstring = tstring+"\n";
    return tstring;
 }
	//{{DECLARE_CONTROLS
	//}}
}

//############################################################################
class TelnetClient extends java.awt.Canvas implements Runnable
 {
//  test about;  
  boolean debug = false;
  String host;                  // remote host
  String action;                //
  int port;                     // remote port
  Socket s;                     // connection to remote host
  InputStream in;               // data from other end
  OutputStream out;             // data to other end
  Thread th;                    // thread for reading data
  Font fn;                      // current font
  Image back;                   // backing image
  int x, y;                     // cursor position (in chars)
  int chw,chh;                  // size of a char (in pixels)
  int chd;                      // offset of char from baseline
  int width,height;             // size of applet (in pixels)
  int w,h;                      // size of applet (in chars)
  int step;
  Graphics gr,bgr;              // front and back graphics
  Emulation emulator;

  String term = "ANSI";         // what this terminal claims to be
  String Cterm;                 // class emulator
  String keepresult = " ";      // keeping result bookname all
  boolean firstterm = true;
  //*******************
  String oldpage = " ";
  String newpage = " ";
  Telnet telnet;
  String data[] = new String[60];
  String output[] = new String[60];
  int indexdata = 0;
  String authordata = "john";
  
  String titledata = "introduction";
  String lastresult[] = new String[60];
  int long1 = 0;
  int long2 = 0;
  boolean loop = false;
  boolean keep = false;
  //*******************
  boolean echo;      // echo keys sent?
  boolean periodwork = false;
  String UserOs = System.getProperty("os.name");  // For platform specific bugs.
  

  public void reshape(int nx, int ny, int nw, int nh)
    {

    if (nw != width || nh != height) {
      width = nw;
      height = nh;

      // Open font
      gr = getGraphics();
      fn = new Font("Courier",Font.PLAIN,11);
      if (fn != null) gr.setFont(fn);
      FontMetrics fnm = gr.getFontMetrics();
      chw = fnm.getMaxAdvance();
      chh = fnm.getHeight();
      chd = fnm.getDescent();

      // kludge for Windows NT and others which have too big widths
      if (chw + 1 >= chh)
        {
        chw = (chw + 1) / 2;
        }


      // work out size of drawing area
      h = nh / chh;
      w = nw / chw;

      // setup backing image
      back = createImage(width, height);
      bgr = back.getGraphics();
      bgr.setFont(fn);

      Emulation.initClass(this);

      try {

        emulator = (Emulation)Class.forName("ANSI").newInstance();
        }

      catch(Exception e) {
        e.printStackTrace();
        }

      clearch();
      }

    super.reshape(nx,ny,nw,nh);
    }

  void connect(String givenhost, int givenport, String givenemul, String giveauth, String givetitle )
    {
    host = givenhost;
    port = givenport;
    authordata = giveauth;
    titledata = givetitle;

    if (givenemul != Cterm )
      {
      try {
        emulator = (Emulation)Class.forName(givenemul).newInstance();
        }
      catch(Exception e) {
        e.printStackTrace();
        }
      Cterm = givenemul;
      }

    if (debug) System.out.println("Height = "+String.valueOf(h));
    if (debug) System.out.println("Width  = "+String.valueOf(w));

    // reset display
    clearch();
    echo = false;
    requestFocus();
    firstterm = true;

    // Open connection
    try {
      try {
        try {
          if ((s = new Socket(host,port)) == null) {
            display("Failed to connect to host "+host+"\n");
            return;
            }
          }
        catch(UnknownHostException e) {
          display("Host " + host + " not found\n");
          return;
          }
        }
      catch(IOException e) {
        display("Failed to connect to host "+host+"\n");
        return;
        }
      }
    catch (Exception e) {
      display("Security violation on socket for host "+host+"\n");
      return;
      }

    try {
      in = s.getInputStream();
      out = s.getOutputStream();
      }
    catch(IOException e) {
      if (debug) System.out.println("Failed to get stream from socket");
      System.exit(5);
      }
    display("Connected to "+host+"\n");
    if (debug) System.out.println("Connected to host");
    step = 1;

    // Begin thread for reading data
    th = new Thread(this);
    th.start();
    }

  void disconnect()
  {
  if (th != null) {
    display("\nDisconnected from "+host+"\n");
    th.stop();
    th = null;
    s = null; in = null; out = null;
    }
  }

  void clearch()
  {
  emulator.clearscreen();
  repaint();
  return;
  }

  // keyDown
  // Called on keypress
  public boolean keyDown(Event e, int k)
    {
    if (out != null) {
      int kp = e.key;

      if (kp == '.')
        periodwork = true;

      // if ((kp == '`') && (periodwork == false)) kp = '.'; // bug in keyDown

      if (debug) System.out.println("Pressed key " + String.valueOf(kp));

      emulator.transmitch((char)kp);

      if (echo) {
        if (debug) System.out.println("Echo'd "+String.valueOf(kp));
        displaych((char)kp);
        }
      }
    return true;
    }


// this is a kludge in order to get the period key when there is a bug in keyDown
  public boolean keyUp(Event e, int k)
    {
    if (periodwork == true) return true;

    if (k != '.') return true;

    if (out != null) {

      if (debug) System.out.println("Pressed key " + String.valueOf(k));

      emulator.transmitch((char)k);

      if (echo) {
        if (debug) System.out.println("Echo'd "+String.valueOf(k));
        displaych((char)k);
        }
      }
    return true;

    }
  public boolean mouseDown(Event e, int x, int y)
    {
    requestFocus();
    //repaint();
    return true;
    }

  public void paint(Graphics g)
    {
    g.drawImage(back,0,0,this);
    }

   public void update(Graphics g)
     {
     g.drawImage(back,0,0,this);
     }

   public void run()
     {
     byte b[] = new byte[2000];
     int len;

     while(true)
       {
       len = readstream(b);
       displaystream(b,len);
//***********************************
	   autotransmit(b,len);
//***********************************

       }
     }

   char readch()
     {
     int c = 0;
     try
       { c = in.read(); }
     catch(IOException e)
       { shutdown(); }
     if (c == -1) shutdown();
     if (debug) System.out.println("Got char "+String.valueOf(c)+" = "+String.valueOf((char)c));
     return (char)c;
     }

   int readstream(byte[] b)
     {
     int len = 0;
     try
       { len = in.read(b);}
     catch(IOException e)
       {shutdown();}
     if (len == -1) shutdown();
     return len;
     }

   // shutdown
   // Terminate connection
   void shutdown()
     {
     display("\nConnection closed\n");
     s = null; in = null; out = null;
     Thread.currentThread().stop();
     }

   // Display a stream of data
   void displaystream( byte b[], int len)
     {
     for (int i = 0; i <len; i++)
       {
       if (b[i] == 255 - 256)
         telnetparse(b,i,len);
       }
     emulator.displaybytes(b, len);
     if (UserOs.compareTo("Windows NT") == 0)
       {
       System.out.println("");
	    }

     repaint();
     }

//*************
    void autotransmit (byte b[],int len)
    {
      int i = 0;
  //    int index = 0;
  //     String stemp = " ";

      switch (step) {
        case 1:
            if ( b[5] == 58 || b[7] == 58 ) {
                transmit("library\n");
               ++step;
            }
            break;

        case 2:
            if ((b[14] == 0x57)||(b[16] == 0x57) ) {
                if (authordata.equalsIgnoreCase("*")) {       
                    transmitch('t');}
                else {
                    transmitch('a');}
                ++step;
            }
            
            break;

        case 3:
                
            if (( b[523] == 0x41 )|| (b[524] == 0x41)){
                 transmit(authordata + "\n");
                 ++step;}
                    
            if ((b[0] == 0x74) || (b[464] == 0x49) || (b[463] == 0x54)){
//                if (authordata.equalsIgnoreCase("*")){
                transmit(titledata + "\n"); //}
                ++step;}
            break;

        case 6:
            if (!(authordata.equalsIgnoreCase("*"))){ 
                emulator.transmitch('d'); 
            }
            ++step;
            break;

        case 8:
            if (30 < keepresult.length()){
                oldpage = " ";
                oldpage = keepresult.substring(10,30);
            }
            else { oldpage = "aaa";}
            
            keepresult = " ";
//********************** detect title 
            if (authordata.equalsIgnoreCase("*")) {
                keepresult = keepresult + detectstr1(b,len);
            }
            else {
                keepresult = keepresult + detectstr(b,len);
            }
            
            
            
            if  ( (keepresult != " ")&&(30 < keepresult.length()) )
            {
                newpage = " ";
                newpage = keepresult.substring(10,30);
                data[indexdata] = "";
//*******************************************                
                if (Comparedata()) {
                    data[indexdata] = keepresult;
                    ++indexdata; }
//********************************************                
                
	        }
            if (oldpage.equals(newpage)){
                //******** select search by enter *
                if (titledata.equalsIgnoreCase("*")){
                    Authordata(data);
                }
                else if (authordata.equalsIgnoreCase("*")){
                    Titledata(data);
                }
                else {
                    displaydata(data); }
                //*********************************
                test about = new test(lastresult,indexdata);
	            about.show();
                step = 0;
                indexdata = 0;
                disconnect();}
            else {
                keep = true;
                transmitch('f');}
            break;

        default :
            ++step ;
            break ;
        }

    }
//*************
   void telnetparse(byte b[], int index, int len)
     {
     char cmd;
     char opt;

     if ( index+1 > len - 1)
       {
       cmd = readch();
       if (cmd == 240)
           {
           return;
           }
       opt = readch();
       }
     else
       {
       if (b[index+1] < 0)
         cmd = (char)((int)b[index+1] + 256);
       else
         cmd = (char)b[index+1];

       if (cmd == 240)
           {
           return;
           }

       if (index+2 > len - 1)
         {
         opt = readch();
         }
       else
         {
         if (b[index+2] < 0)
           opt = (char)((int)b[index+2] + 256);
         else
           opt = (char)b[index+2];
         }
       }

     if (debug) System.out.println("read opt " + (int)opt + " and cmd " + (int)cmd);

       switch(opt) {
         case 1:  // echo
            if (cmd == 251)
              {
              transmitch((char)255);
              transmitch((char)253);
              transmitch((char)1);
              echo = false;
              }
            else if (cmd == 252)
              {
              transmitch((char)255);
              transmitch((char)254);
              transmitch((char)1);
              echo = true;
              }
            else if (cmd == 253)
              {
              transmitch((char)255);
              transmitch((char)251);
              transmitch((char)1);
              }

            break;

         case 3: // supress go-ahead
            transmitch((char)255);
            transmitch((char)253);
            transmitch((char)opt);
            break;

         case 32: // Terminal speed
            transmitch((char)255);
            transmitch((char)251);
            transmitch((char)32);
            transmitch((char)255);
            transmitch((char)250);
            transmitch((char)32);
            transmitch((char)0);
            transmit("38400,38400");
            transmitch((char)255);
            transmitch((char)240);

            break;

         case 35: // X display location
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)35);
            break;

         case 33: // Remote Flow control
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)33);
            break;

         case 31: // Window size
            if (cmd == 253) {
              // IAC WILL terminal-type
              transmitch((char)255);
              transmitch((char)251);
              transmitch((char)31);

              transmitch((char)255);
              transmitch((char)250);
              transmitch((char)31);
              char stemp =(char)(w / 256);
              transmitch(stemp);
              stemp = (char)(w % 256);
              transmitch(stemp);
              stemp = (char)(h / 256);
              transmitch(stemp);
              stemp = (char)(h % 256);
              transmitch(stemp);
              transmitch((char)255);
              transmitch((char)240);
              }
            break;

         case 39:
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)39);
            break;

         case 36: // Environment option
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)36);
            break;

         case 24: // terminal type
            if (cmd == 253) {
              // IAC WILL terminal-type
              transmitch((char)255);
              transmitch((char)251);
              transmitch((char)24);
					}
            else if (cmd == 250) {
              // IAC SB terminal-type IS <term> IAC SE
              transmitch((char)255);
              transmitch((char)250);
              transmitch((char)24);
              transmitch((char)0);
              if (firstterm == true)
                {
                transmit(term);
                firstterm = false;
                }
              else
                {
                transmit(Cterm);
                }

              transmitch((char)255);
              transmitch((char)240);
              }
            break;

         case 37: // Authentication
            if (cmd == 253) {
              // IAC WILL terminal-type
              transmitch((char)255);
              transmitch((char)251);
              transmitch((char)37);

              // IAC SB 0000 IAC SE
              transmitch((char)255);
              transmitch((char)250);
              transmitch((char)37);
              transmitch((char)0);
              transmitch((char)0);
              transmitch((char)0);
              transmitch((char)0);
              transmitch((char)255);
              transmitch((char)240);
              }
            break;

         default: // Catch all
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)opt);
            break;

         }
     }


   // display
   // Display a string in the telnet window
   void display(String str)
   {
   int i;
   for(i=0; i<str.length(); i++)
     displaych(str.charAt(i));
   }

   // displaych
   // Display one character at the current cursor position
   void displaych(char c)
     {

     if ( c < 128) {
       // Some printable character
       emulator.displaych(c);
       repaint();
       }
     else if (c == 255) {
       // Telnet IAC
       char cmd = readch();
       if (cmd == 240)
           {
           return;
           }
       char opt = readch();
	    switch(opt) {
         case 1:  // echo
             if (cmd == 251) echo = false;
             else if (cmd == 252) echo = true;
             break;

         case 3:  // supress go-ahead
            break;

         case 32:
            transmitch((char)255);
            transmitch((char)251);
            transmitch((char)32);
            transmitch((char)255);
            transmitch((char)250);
            transmitch((char)32);
            transmitch((char)0);
            transmit("38400,38400");
            transmitch((char)255);
            transmitch((char)240);

            break;

         case 35:
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)35);
            break;

         case 33:
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)33);
            break;

         case 31:
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)31);
            break;

         case 39:
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)39);
            break;

         case 36:
            transmitch((char)255);
            transmitch((char)252);
            transmitch((char)36);
            break;

         case 24: // terminal type
            if (cmd == 253) {
              // IAC WILL terminal-type
              transmitch((char)255);
              transmitch((char)251);
              transmitch((char)24);

              // IAC SB terminal-type IS <term> IAC SE
              transmitch((char)255);
              transmitch((char)250);
              transmitch((char)24);
              transmitch((char)0);
              transmit(term);
              transmitch((char)255);
              transmitch((char)240);
              }
            else if (cmd == 250) {
              while(readch() != 240);
              }
            break;
         }
       }
     }

   void transmit(String str)
     {
     int i;
     for(i=0; i<str.length(); i++)
       { transmitch(str.charAt(i)); }
     }

   void transmitch(char c)
     {
     if (c == '\n') transmitch('\r');
     try {
       out.write((int)c);
       out.flush();
       }
     catch(IOException e){};
     if (debug) System.out.println("Sent char " + String.valueOf((int)c) + " = " + String.valueOf(c));
     }

     //*****************************************
     //procedure check string for bookname only
     String detectstr (byte[] b,int len)
     {
      int i = 124;
      String Tstring = "";

        while ( i < 1997 )
        {
            if ( (b[i] == 0x6d) && (b[i+2] >= 0x41) && (b[i+2] <= 0x5a)         //m.P
                 && (i < 1997) && (b[i+3] >= 0x61) && (b[i+3] <= 0x7a) )
                 {
                    i = i + 2;
                    while ( (b[i] != 0x5b) && ((b[i] != 0x20) || (b[i+1] != 0x20)) && (i < 1997) )
                    {
                        Tstring = Tstring+(char)b[i];
                        ++i;
                    }
                    Tstring = Tstring + "{";
                  }
            else if ( (b[i] == 0x6d) && (b[i+1] >= 0x41) && (b[i+1] <= 0x5a)
                       && (i < 1997) && (b[i+3] >= 0x61) && (b[i+3] <= 0x7a) ) //mP

                  {
                    ++i;
                    while ( (b[i] != 0x5b) && ((b[i] != 0x20) || (b[i+1] != 0x20)) && (i < 1997) )
                    {
                        Tstring = Tstring+(char)b[i];
                        ++i;
                    }
                    Tstring = Tstring + "{";
                  }
            ++i;
        }
        i++ ;
   		return Tstring;
     }
     
   //************** detect str for title *******************
     String detectstr1 (byte[] b,int len)
     {
      int i = 124;
      String Tstring = "";
        while ( i < 1997 )
        {
            if ( (b[i] == 0x20) && (b[i+1] == 0x20) && (b[i+2] == 0x20) && 
                 (b[i+3] >= 0x41) && (b[i+3] <= 0x5a)         //m.P
                 && (i < 1997) && (b[i+3] >= 0x61) && (b[i+3] <= 0x7a) )
            
                 {
                    i = i + 2;
                    while ( (b[i] != 0x5b) && ((b[i] != 0x20) || (b[i+1] != 0x20)) && (i < 1997) )
                    {
                        Tstring = Tstring+(char)b[i];
                        ++i;
                    }
                    Tstring = Tstring + "{";
                  }
            ++i;
        }
        i++ ;
   		return Tstring;
     }
   
   //***********************************
   void displaydata (String c[])
   {
        int i = 0;
        int i1 = 0;
        String Stemp1 = "";
        String Stemp2 = "";
        int i2 = 0;
        boolean check = false;
        
        while (i < indexdata) {
            lastresult[i] = " ";
            i1 = 0;
            i2 = 0;
            while ( ((i1 + titledata.length()) < (c[i].length()-1)) &&
                    ((i1 + authordata.length()) < (c[i].length()-1)) ){
                
              if (!(c[i].substring(i1,i1 + 1).equals(" "))){
                if (authordata.equalsIgnoreCase(c[i].substring(i1,i1+authordata.length()))) {            // if string = authordata
                    Stemp1 = c[i].substring(i1,c[i].indexOf('{',i1) ) + "\n";
                    i1 = 1 + c[i].indexOf('{',i1); 
                    i2 = i1;
                    check = false;
                    
                    while ( ((i2 + titledata.length()) < c[i].length()) &&
                            (!(authordata.equalsIgnoreCase(c[i].substring(i2,i2+authordata.length())))) ){

                          if (!(c[i].substring(i2,i2 + 1).equals(" "))) { 
                               if (titledata.equalsIgnoreCase(c[i].substring(i2,i2+titledata.length()))){
                                   Stemp2 = Stemp2 + "        " + c[i].substring(i1,c[i].indexOf('{',i1)) + "\n";
                                   i1 = 1 + c[i].indexOf('{',i1);
                                   i2 = i1 - 1;
                                   if (check == false){
                                       check = true;
                                       lastresult[i] = lastresult[i] + Stemp1 + Stemp2;
                                       Stemp2 = "";}
                                   else {    
                                       lastresult[i] = lastresult[i] + Stemp2;
                                       Stemp2 = "";}
                                   } }
                          if (c[i].substring(i2,i2 + 1).equals("{")) { i1 = i2 + 1; }       
                                
                          ++i2; 
                    }
                    i1 = i2 - 1;        
                    Stemp1 = "";
                } }
              ++i1; 
            }
        ++i; } 
   } 
           
   
   boolean Comparedata() 
   {
      String a = "";
      String b = "";
      int index = 0;
      boolean keepin = true;
      
      if (indexdata > 0){
        a = data[indexdata-1];
        b = keepresult.substring(1,30);
      }
      
      if (indexdata > 0){
         while ( (index + b.length()) < a.length() ){
            if (b.equalsIgnoreCase(a.substring(index,index+b.length()))){
                keepin = false;
                index = a.length();
            }
            ++index;
         }
      }
      return keepin;
   }
 
//********* search by Author only
   void Authordata (String c[])
   {
        int i = 0;
        int i1 = 0;
        
        while (i < indexdata) {
            lastresult[i] = " ";
            i1 = 0;
            while (i1 < c[i].length()){
              if (c[i].substring(i1,i1 + 1).equals(" ")){
                  ++i1;}
              else {
                if (authordata.equalsIgnoreCase(c[i].substring(i1,i1+authordata.length()))){ // if string = authordata
                    lastresult[i] = lastresult[i] + c[i].substring(i1,c[i].indexOf('{',i1) ) + "\n";
                    i1 = 1 + c[i].indexOf('{',i1);}
                    
                else {
                    lastresult[i] = lastresult[i] + "        " 
                                 + c[i].substring(i1,c[i].indexOf('{',i1)) + "\n";
                    i1 = 1 + c[i].indexOf('{',i1);}
              }
            }
        ++i;    
        }
   }
//******************************** */
 
//********* search by Title only
   void Titledata (String c[])
   {
        int i = 0;
        int i1 = 0;
        
        while (i < indexdata) {
            lastresult[i] = " ";
            i1 = 0;
            while (i1 < c[i].length()){
              if (c[i].substring(i1,i1 + 1).equals(" ")){
                  ++i1;}
              else {
                if (titledata.equalsIgnoreCase(c[i].substring(i1,i1+titledata.length()))){ // if string = authordata
                    lastresult[i] = lastresult[i] + c[i].substring(i1,c[i].indexOf('{',i1) ) + "\n";
                    i1 = 1 + c[i].indexOf('{',i1);}
                    
                else {
                    lastresult[i] = lastresult[i] + "        " 
                                 + c[i].substring(i1,c[i].indexOf('{',i1)) + "\n";
                    i1 = 1 + c[i].indexOf('{',i1);}
              }
            }
        ++i;    
        }
   }
//******************************** */
 
 
}

class test extends Frame  {

    protected static Applet1 owner = null;
	Button close;
	TextArea textArea1;

    public test(String Now[],int m)
    {
        super("Test telnet");
		setLayout(null);
		addNotify();
		resize(476,335);
		close = new Button("CLOSE");
		close.reshape(192,276,96,40);
		add(close);
		textArea1 = new TextArea();
		//textArea1.setText("BUILT");
		textArea1.reshape(12,24,456,240);
		add(textArea1);
		//*******
        //********
        int i = 0;
        //**********
		while (i < m) {
		    if (i == 0){
		        textArea1.setText(Now[i]);}
		    else {
		        textArea1.appendText(Now[i]);
		    }
		    ++i;
		}
        //********
    		//{{INIT_CONTROLS
		setLayout(null);
		addNotify();
		resize(insets().left + insets().right + 430,insets().top + insets().bottom + 270);
		setTitle("Untitled");
		//}}
		//{{INIT_MENUS
		//}}
}
    public boolean CommandAction(Event event,Object arg)
    {
        if("CLOSE".equals(arg))
        {
            dispose();
        }
        return true;
        
    }
        

	public synchronized boolean handleEvent(Event event)
	{
	    switch(event.id)
	    {
	        case Event.ACTION_EVENT:
	            return CommandAction(event,event.arg);
	        default:
	            return false;
	    }
	}
	//{{DECLARE_CONTROLS
	//}}
	//{{DECLARE_MENUS
	//}}
}

/* class test extends Frame  {

    protected static Applet1 owner = null;
	Button close;
	TextArea textArea1;

    public test(String Now)
    {
        super("Test telnet");
		setLayout(null);
		addNotify();
		resize(476,335);
		close = new Button("CLOSE");
		close.reshape(192,276,96,40);
		add(close);
		textArea1 = new TextArea();
		textArea1.setText("BUILT");
		textArea1.reshape(12,24,456,240);
		add(textArea1);
		textArea1.setText(Now);

    		//{{INIT_CONTROLS
		setLayout(null);
		addNotify();
		resize(insets().left + insets().right + 430,insets().top + insets().bottom + 270);
		setTitle("Untitled");
		//}}
		//{{INIT_MENUS
		//}}
}
    public boolean CommandAction(Event event,Object arg)
    {
        if("CLOSE".equals(arg))
        {
            dispose();
        }
        return true;
        
    }
        

	public synchronized boolean handleEvent(Event event)
	{
	    switch(event.id)
	    {
	        case Event.ACTION_EVENT:
	            return CommandAction(event,event.arg);
	        default:
	            return false;
	    }
	}
	//{{DECLARE_CONTROLS
	//}}
	//{{DECLARE_MENUS
	//}}
}*/
