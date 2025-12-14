//package IsecQ;
import IsecQ.IsagQ;
import java.io.*;
import java.awt.*;
import java.awt.image.*;
import java.awt.event.*;
import java.net.*;
class  Main
{
	public static void main(String[] args) 
	{	IsagQ f= new IsagQ();
		try
		{	f.Begin();
		}
		catch (UnknownHostException uh)
		{	System.out.println("Main "+uh);
		}
		catch (IOException io)
		{	System.out.println("Main "+io);
		}
	}
} 