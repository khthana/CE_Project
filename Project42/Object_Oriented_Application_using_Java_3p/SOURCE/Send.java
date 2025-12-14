import java.io.*;
import java.net.*;
import java.util.*;


class Send
{

Socket connector;
DataInputStream inputStream;
DataOutputStream outputStream;
String EOL = "\r\n",message = "Hello";
String host;
int port;

  Send(String host,int port)
  {
		this.host = host;
		this.port = port;
  }

//===========================connect()=======================================  

  private void connect() throws IOException{
    connector = new Socket(host,port);
    inputStream = new DataInputStream(connector.getInputStream());
    outputStream = new DataOutputStream(connector.getOutputStream());
  }

//===========================close()=========================================

  public void close() throws IOException
  {
    connector.close();
    connector = null;
  }

//===========================run(String,String)=======================================

	public void run(String sub, String fileDirectory,String fileName)
	{
		try
		{
			connect();
			outputStream.writeBytes(sub + "\r\n");
			outputStream.writeBytes(fileName + "\r\n");
			FileInputStream fin = new FileInputStream(fileDirectory + fileName);
			int filelength = fin.available();
			System.out.println(filelength);
			byte[] streamByte = new byte[filelength];
			fin.read(streamByte);
			outputStream.writeBytes(filelength + "\r\n");
			outputStream.write(streamByte,0,filelength);
			fin.close();
			
			
			Thread.sleep(3000);
			close();
		}
		catch (Exception e)
		{
			System.out.println(e);
		}
		
	}

//===========================main(String)=======================================

	
	/*public static void main(String[] args)
	{
		Send send = new Send("database10.ce.kmitl.ac.th",8888);
		send.run("c:/javaEditPlus/web/Hi/","picture.gif");
	}*/
}
