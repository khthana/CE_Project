import java.io.*;
import java.net.*;

public class InetExample
{

/*===============================================================================
================================= main(String) ==================================
===============================================================================*/

	public static void main(String[] args)
	{
		printLocalAddress();
		
		Reader kbd = new FileReader(FileDescriptor.in);
		BufferedReader bufferedKbd = new BufferedReader(kbd);
		try
		{
			String name;
			do
			{
				System.out.print("Enter a hostname or IP address: ");
				System.out.flush();
				name = bufferedKbd.readLine();
				if(name != null)
					printRemoteAddress(name);
			}while(name != null);
			System.out.println("exit");
		}
		catch (IOException ex)
		{
			System.out.println("Input error:");
			ex.printStackTrace();
		}
	}

/*===============================================================================
============================= printLocalAddress() ===============================
===============================================================================*/

	static void printLocalAddress()
	{
		try
		{
			InetAddress myself = InetAddress.getLocalHost();
			System.out.println("My name: " + myself.getHostName());
			System.out.println("My IP: " + myself.getHostAddress());
			System.out.println("My class: " + ipClass(myself.getAddress()));
		}
		catch(UnknownHostException ex)
		{
			System.out.println("Failed to find myself: ");
			ex.printStackTrace();
		}
	}

/*===============================================================================
============================= ipClass(byte[]) ===================================
===============================================================================*/

	static char ipClass(byte[] ip)
	{
		int highByte = 0xff & ip[0];
		return(highByte < 128) ? 'A' : (highByte < 192) ? 'B' :
			(highByte < 224) ? 'C' : (highByte < 240) ? 'D' : 'E';
	}

/*===============================================================================
=========================== printRemoteAddress(String) ==========================
===============================================================================*/
	
	static void printRemoteAddress(String name)
	{
		try
		{
			System.out.println("Look up " + name + "...");
			InetAddress machine = InetAddress.getByName(name);
			System.out.println("Host name : " + machine.getHostName());
			System.out.println("Host IP : " + machine.getHostAddress());
			System.out.println("Host class : " + 
								ipClass(machine.getAddress()));
			
		}
		catch (UnknownHostException ex)
		{
			System.out.println("Failed to lookup " + name);
		}
	}
	
}

