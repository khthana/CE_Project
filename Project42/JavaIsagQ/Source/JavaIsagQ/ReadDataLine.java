package IsecQ;
//ReadDataLine.java
import java.io.*;

class  ReadDataLine 
{
	public String ret(int index, String sf) throws IOException
	{ 		
		 FileReader fin = new FileReader(sf);
		 LineNumberReader lin = new LineNumberReader(fin);
		 String str =null;
    	 for ( int i=0; i < index; i++) str = lin.readLine();
		 fin.close();
		 return str;
	}
}
