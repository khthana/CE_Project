package IsecQ;
import java.io.*;

import IsecQ.*;

class ReadAllDataFile2 
{
	ReadAllDataFile2()
	{}
	public static void main(String[] args) 
	{	
		ReadFile(60710154);
	}

	public static UserAllInfo[] ReadFile(int ownerUIN)
	{	int num_uin=0 ,len = 0;
		byte[] data;
		UserAllInfo[] usrArr = new UserAllInfo[0];
		FileInputStream		file_in	= null;
		DataInputStream		data_in	= null;
		
		try
		{	file_in		= new FileInputStream(ownerUIN+".ctl");
			data_in		= new DataInputStream(file_in);
		}
		catch (FileNotFoundException f)
		{	System.err.println("FileNotFoundException " +f);
		}

		try
		{	num_uin = data_in.readInt();
			usrArr	=	new UserAllInfo[num_uin];
			System.out.println("num uin "+num_uin);
			for (int i = 0 ;i<num_uin ; i++)
			{	usrArr[i] = new UserAllInfo();
				usrArr[i].setUIN(data_in.readInt());
				System.out.println(usrArr[i].getUIN());
				len = data_in.readInt();
				data = new byte[len];

				data_in.read(data);
				usrArr[i].setPWD 	(new String(data));
				System.out.println(usrArr[i].getPWD());
//				System.in.read();
			
				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				usrArr[i].setNick (new String(data));
				System.out.println(usrArr[i].getNick());
//				System.in.read();

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				usrArr[i].setFirst (new String(data));
				System.out.println(usrArr[i].getFirst());
//				System.in.read();

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				usrArr[i].setLast		(new String(data));
				System.out.println(usrArr[i].getLast());
//				System.in.read();
				
				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				usrArr[i].setEmail	(new String(data));
				System.out.println(usrArr[i].getEmail());
//				System.in.read();
				usrArr[i].setAuth		(data_in.readByte());
				System.out.println(usrArr[i].getAuth());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				usrArr[i].setCity		(new String(data));
				System.out.println(usrArr[i].getCity());

				usrArr[i].setCountryCode		(data_in.readShort());
				System.out.println(usrArr[i].getCountryCode());
				usrArr[i].setCountryStatus		(data_in.readByte());
				System.out.println(usrArr[i].getCountryStatus());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				usrArr[i].setState	(new String(data));
				System.out.println(usrArr[i].getState());

				usrArr[i].setAge		(data_in.readShort());
				System.out.println(usrArr[i].getAge());

				usrArr[i].setSex		(data_in.readByte());
				System.out.println(usrArr[i].getSex());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				usrArr[i].setPhone	(new String(data));
				System.out.println(usrArr[i].getPhone());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				usrArr[i].setHomepage			(new String(data));
				System.out.println(usrArr[i].getHomepage());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				usrArr[i].setAbout	(new String(data));
				System.out.println(usrArr[i].getAbout());
/*
				usrArr[i].setIP			(data_in.readInt());
				System.out.println(Integer.toHexString(usrArr[i].getIP()));
//				System.in.read();

				usrArr[i].setReal_IP				(data_in.readInt());
				System.out.println(usrArr[i].getReal_IP());
				usrArr[i].setPort		((short)data_in.readInt());
				System.out.println(usrArr[i].getPort());
//				System.in.read();

*/				usrArr[i].setStatus	(data_in.readInt());
				System.out.println(usrArr[i].getStatus());
//				System.in.read();

			}	// end for
			file_in.close();
		} // end try
		catch (IOException e)
		{	System.err.println("IOException Error "+e);
		}
		return usrArr;
	}// end readDataFile
}