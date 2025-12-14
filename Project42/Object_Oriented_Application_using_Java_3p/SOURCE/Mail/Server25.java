import java.io.*;
import java.net.*;
import java.awt.*;
import java.util.*;

public class Server25 extends Frame
{
    TextArea display;
    public static ServerSocket server;
    String mail="";

    public Server25()
    {
        super("Server");
        display = new TextArea(20,5);
        add("Center",display);
        resize(300,150);
        show();
    }

    public Socket waitConnect(Socket connect)
    {
        display.appendText("server25.waitConnect...\n");

        try
        {
          connect = server.accept();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }

        display.appendText("server25.Connect.accept...\n");

        return connect;
    }

    public boolean handleEvent(Event e)
    {
        if(e.id == Event.WINDOW_DESTROY)
        {
            hide();
            dispose();
            System.exit(0);
        }
        return super.handleEvent(e);
    }

    public static void main(String args[])
    {
        Server25 s = new Server25();
        try
        {
            server = new ServerSocket(25);
            s.display.appendText("New Socket \n");
            Socket25 socket = new Socket25(s);
            socket.start();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
    }


}
