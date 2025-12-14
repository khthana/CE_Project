package IsecQ;
import java.net.*;
import java.io.*;
import java.util.*;

public class  KEEP_ALIVE_Thread extends Thread
{
	ServerConnect sconnect;

    public KEEP_ALIVE_Thread(ServerConnect sconnect)
	{	this.sconnect=sconnect;
	}

	public void run() 
	{	while(true)
		{	try
			{		Date date=new Date();
					System.out.println(date);
					Thread.sleep(240000); // 4 minute
					sconnect.sendKeepAlive();
			}
			catch(InterruptedException e){System.err.println("error");}
			catch(IOException i){System.err.println("error");}
		}
	}// end run
}