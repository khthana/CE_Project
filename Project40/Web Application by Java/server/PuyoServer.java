
import java.io.*;
import java.net.*;
import java.util.*;

public class PuyoServer extends Thread implements Trigger {
    public static final String rcsVersion = "$Revision: 1.00 $";
    public static final String rcsDate = "$Date: 1998/01/14 23:43:21 $";
    public static final String rcsProgram = "$RCSfile: Puyo.java,v $";
    public static final String version = rcsVersion.substring(11, rcsVersion.length()-2);
    public static final String date = rcsDate.substring(7, 17);
    public static final String program = rcsProgram.substring(10, rcsProgram.length()-9);
    public static final String about = "\n  " + program + " v. " + version;


    public final static int DEFAULT_PORT = 6764;
    public final static int WARNING_IF_INACTIVE_FOR = 5*60;
    public final static int TIME_TO_LIVE_AFTER_WARNING = 60;
    public final static int REAPER_PERIOD = 10*1000;
    protected int warningIfInactiveFor = WARNING_IF_INACTIVE_FOR;
    protected int timeToLiveAfterWarning = TIME_TO_LIVE_AFTER_WARNING;
    protected int port = DEFAULT_PORT;
    protected String logFileName = "Puyo." + Time.ymdhms(false) + ".log";

    protected int maxInactivity;
    protected PrintStream log;
    protected ServerSocket listen_socket;
    protected Hashtable participants;
    protected Ticker ticker;

    public static void main(String[] args) {
        System.out.println(about);
        new PuyoServer(args);
    }

    public static void usage() {
        System.out.println ("USAGE (all arguments optional and positional):\n"
                + "  java " + program
                + " warningIfInactiveFor timeToLiveAfterWarning port logFileName\n"
                + "    warningIfInactiveFor     After this many seconds of inactivity: warning\n"
                + "    timeToLiveAfterWarning   After this many extra seconds: kicked out\n"
                + "    port                     Port number on which to listen for connections\n"
                + "    logFileName              A transcript of the talk goes here\n"
        );
        System.exit(1);
    }


    public PuyoServer(String[] args) {
        switch (args.length) {
            case 4:
                logFileName = args[3];
            case 3:
                try {
                    port = Integer.parseInt(args[2]);
                }
                catch (NumberFormatException e) {
                    usage();
                }

            case 2:
                try {
                    timeToLiveAfterWarning = Integer.parseInt(args[1]);
                }
                catch (NumberFormatException e) {
                    usage();
                }
            case 1:
                try {
                    warningIfInactiveFor = Integer.parseInt(args[0]);
                }
                catch (NumberFormatException e) {
                    usage();
                }

            case 0:
                break;

            default:
                usage();
        }
        System.out.println (
                  "\nwarningIfInactiveFor     " + warningIfInactiveFor
                + "\ntimeToLiveAfterWarning   " + timeToLiveAfterWarning
                + "\nport                     " + port
                + "\nlogFileName              " + logFileName
                + "\n\nServer running and waiting for connections..."
        );

        warningIfInactiveFor *= 1000;
        timeToLiveAfterWarning *= 1000;

        maxInactivity = warningIfInactiveFor + timeToLiveAfterWarning;

        try {
            log = new PrintStream(new FileOutputStream(logFileName));
        }
        catch (IOException e) {
            fail(e, "Can't open log file '" + logFileName + "' for writing.");
        }
        log.println(about);
        Date d = new Date();
        log.println("Server started on " + d.toGMTString() + " ("
                + Time.ymdhms(d, true) + " server's local time)\n" );
        log.flush();

        try {
            listen_socket = new ServerSocket(port);
        }
        catch (IOException e) {
            fail(e, "Exception creating server socket");
        }

        participants = new Hashtable();

        ticker = new Ticker(REAPER_PERIOD, this);

        this.start();
    }

    public void run() {
        try {
            while(true) {
                Socket client_socket = listen_socket.accept();
                Connection c = new Connection(client_socket, this);
            }
        }
        catch (IOException e) {
            fail(e, "Exception while listening for connections");
        }
    }


    public static void fail(Exception e, String msg) {
        System.err.println(msg + ": " +  e);
        System.exit(1);
    }


    public void tick() {
        Vector toBeKilled = new Vector();
        Date d = new Date();
        long now = d.getTime();
        Enumeration e = participants.keys();
        while (e.hasMoreElements()) {
            String key = (String) e.nextElement();
            Connection thisClient = (Connection) participants.get(key);
            long inactivity = now - thisClient.timeOfLastActivity;
            if (inactivity > maxInactivity) {
                toBeKilled.addElement(thisClient);
            } else if (inactivity > warningIfInactiveFor) {
                thisClient.out.println("INACTIVITY WARNING: you'll be kicked off in "
                        + ((maxInactivity - inactivity)/1000) + " seconds");
                thisClient.out.flush();
            }
        }

        for (int i= 0; i < toBeKilled.size(); i++) {
            Connection thisClient = (Connection) toBeKilled.elementAt(i);
            try {
                thisClient.client.close();

            }
            catch (IOException e2) {
                fail (e2, "Couldn't kill client");
            }
        }
    }

}

class Connection extends Thread {
    protected Socket client;
    protected DataInputStream in;
    protected PrintStream out;
    protected InetAddress clientAddress;
    protected int clientPort;
    protected String clientName;
    protected long timeOfLastActivity;

    protected Hashtable participants;
    protected PrintStream log;

    public static void fail(Exception e, String msg) {
        System.err.println(msg + ": " +  e);
        System.exit(1);
    }
    public Connection(Socket client_socket, PuyoServer server) {
        logActivity("Accepted incoming connection, spawned thread.");
        client = client_socket;
        timeOfLastActivity = (new Date()).getTime();
        participants = server.participants;
        log = server.log;

        try {
            in = new DataInputStream(client.getInputStream());
            logActivity("Successfully created input stream for new socket");
            out = new PrintStream(client.getOutputStream());
            logActivity("Successfully created output stream for new socket");
        }
        catch (IOException e) {
            try {
                client.close();
                logActivity("Successfully closed client socket");
            }
            catch (IOException e2) {
            }
            logException(e, "Exception while getting socket streams");
            this.stop();
            return;
        }


        clientAddress = client.getInetAddress();
        clientPort = client.getPort();
        clientName = clientAddress + ":" + clientPort;
        participants.put(clientName, this);
        logActivity("Got a connection from " + clientName);
        broadcast_User();
//        out.prisntln("USER "+Count_User());
        System.out.println("User "+clientName +" joined the conference.");
//        broadcast ("User " + clientName + " joined the conference.");
        logPrint(whoString());
        this.start();
    }


    public String whoString() {
        String result ="\n  CURRENTLY CONNECTED:\n";
        Enumeration e = participants.keys();
        while (e.hasMoreElements()) {
            String key = (String) e.nextElement();
            Connection thisClient = (Connection) participants.get(key);
            result += "  " + thisClient.clientName
                    + " (from " + key + ")\n";
        }
        return result;
    }

    public void run() {
        String line;
        int len;
        try {
            for(;;) {
                line = in.readLine();
//                logActivity("Received line: " + line);
                timeOfLastActivity = (new Date()).getTime();
                if (line == null) {
//                    logActivity ("Received empty line: closing down");
                    break  ;
                }
                if (line.startsWith("LINE"))
                {
                    String msg;
                    msg = line.substring(5);
                    broadcast(msg);
                    logPrint(msg);
                    continue;
                }

                broadcast ("");
            }
        }
        catch (IOException e) {
            logException (e, "Exception in main loop talking to "
                + clientName + "(" + clientAddress
                + ":" + clientPort + ")");
        }
        finally {
            logActivity ("Connection to "
                + clientAddress + ":" + clientPort
                + " not working, I'll close it");
            try {
                client.close();
                logActivity ("Successfully closed broken socket for "
                    + clientAddress + ":" + clientPort);
            }
            catch (IOException e2) {
                logException (e2, "Exception while closing socket for "
                    + clientAddress + ":" + clientPort);
            }
            finally {
                client = null;
                logActivity("Broken socket forgotten");
                participants.remove(clientAddress + ":" + clientPort);
                broadcast_User();                                
                broadcast ("User " + clientName + " ("
                    + clientAddress + ":" + clientPort
                    + ") left the conference.");
                logPrint(whoString());
            }
        }
    }

    public void logException (Exception e, String message) {
        System.err.println(message + ": " +  e);
    }

    public void logActivity (String message) {
        System.out.println(message);
    }

    public void logPrint (String message) {
        Date d = new Date();
        log.print("["+  Time.ymdhms(true) + "] " + message);
        log.flush();
    }
    public int Count_User ()
    {
        int count_user = 0;
        Enumeration e = participants.keys();
        while(e.hasMoreElements())
        {
            String key = (String) e.nextElement();
            Connection thisClient = (Connection) participants.get(key);
            count_user++;
        }
        return count_user;
    }
    
    public void broadcast_User()
    {
        Enumeration e = participants.keys();
        int Current_USER = Count_User();
        while (e.hasMoreElements())
        {
            String key = (String) e.nextElement();
            Connection thisClient = (Connection) participants.get(key);
            thisClient.out.println("USER "+Current_USER);
            thisClient.out.flush();
        }
    }
    public void broadcast (String s) {
        Enumeration e = participants.keys();
        while (e.hasMoreElements()) {
            String key = (String) e.nextElement();
            Connection thisClient = (Connection) participants.get(key);
            if (thisClient.clientName.equals(clientName))
            {}
            else
            {
            thisClient.out.println(s);
            thisClient.out.flush();
            }
        }
        logPrint(s + "\n");
    }
}


class Ticker extends Thread {
    public int period; // period between ticks in milliseconds
    protected Trigger trigger;

    public Ticker (int period, Trigger trigger) {
        this.period = period;
        this.trigger = trigger;
        this.start();
    }

    public void run() {
        for (;;) {
            if (trigger != null) {
                trigger.tick();
            }
            try {
                sleep(period);
            } catch (InterruptedException e) {
              System.err.println("Ticker thread interrupted: " + e);
            }
        }
    }
}


interface Trigger {
    // Something that can be called by a ticker to make things happen.
    public abstract void tick();
}



class Time {
    public static String ymdhms(Date d, boolean separators) {
        int y = d.getYear();
        int month = d.getMonth()+1;
        int date = d.getDate();
        int h = d.getHours();
        int m = d.getMinutes();
        int s = d.getSeconds();
        String result = "";
        if (y < 10) {
            result += "0";
        }
        result += y;
        if (month < 10) {
            result += 0;
        }
        result += month;
        if (date < 10) {
            result += "0";
        }
        result += date + "-";
        if (h < 10) {
            result += "0";
        }
        result += h;
        if (separators) {
            result += ":";
        }
        if (m < 10) {
            result += 0;
        }
        result += m;
        if (separators) {
            result += ":";
        }
        if (s < 10) {
            result += "0";
        }
        result += s;
        return result;
    }


    /**
        Returns a string with a ymdhms representation of "now".
    */
    public static String ymdhms(boolean separators) {
        return ymdhms(new Date(), separators);
    }


    public static String hoursMins(Date d) {
        int h = d.getHours();
        int m = d.getMinutes();
        String result = "";
        if (h < 10) {
            result += "0";
        }
        result += h + ":";
        if (m < 10) {
            result += 0;
        }
        result += m;
        return result;
    }

    public static String hoursMins() {
        return hoursMins(new Date());
    }

}


