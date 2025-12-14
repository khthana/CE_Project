package IsecQ;
import java.io.*;

import IsecQ.*;

class ReadAllMyDataFile 
{
	ReadAllMyDataFile(){}

	public static void main(String[] args) 
	{	
		ReadFile(60710412);
	}

	public static UserAllInfo ReadFile(int ownerUIN)
	{	int num_uin=0 ,len = 0;
		byte[] data;
		UserAllInfo myallinfo = new UserAllInfo();
		File							c_file		= null;
		FileInputStream		file_in		= null;
		FileOutputStream	file_out	 	= null;
		DataInputStream		data_in	 	= null;
		DataOutputStream	data_out	= null;
		
		try
		{	c_file	= new File(ownerUIN+".ifo");
			if (c_file.exists())
			{	file_in		= new FileInputStream(c_file);
				data_in		= new DataInputStream(file_in);
				System.out.println(c_file.canRead() ? "r" : "-");
				System.out.println(c_file.canWrite() ? "w" : "-");
				System.out.println("file length "+c_file.length());

				myallinfo.setUIN(ownerUIN);
				System.out.println(myallinfo.getUIN());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setPWD 	(new String(data));
				System.out.println(myallinfo.getPWD());
//				System.in.read();
		
				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setNick (new String(data));
				System.out.println(myallinfo.getNick());
//				System.in.read();

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setFirst (new String(data));
				System.out.println(myallinfo.getFirst());
//				System.in.read();

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setLast		(new String(data));
				System.out.println(myallinfo.getLast());
//				System.in.read();
				
				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setEmail	(new String(data));
				System.out.println(myallinfo.getEmail());
//				System.in.read();
				myallinfo.setAuth		(data_in.readByte());
				System.out.println(myallinfo.getAuth());
	
				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setCity		(new String(data));
				System.out.println(myallinfo.getCity());

				myallinfo.setCountryCode		(data_in.readShort());
				System.out.println(myallinfo.getCountryCode());
				myallinfo.setCountryStatus		(data_in.readByte());
				System.out.println(myallinfo.getCountryStatus());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setState	(new String(data));
				System.out.println(myallinfo.getState());

				myallinfo.setAge		(data_in.readShort());
				System.out.println(myallinfo.getAge());

				myallinfo.setSex		(data_in.readByte());
				System.out.println(myallinfo.getSex());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setPhone	(new String(data));
				System.out.println(myallinfo.getPhone());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setHomepage (new String(data));
				System.out.println(myallinfo.getHomepage());

				len = data_in.readInt();
				data = new byte[len];
				data_in.read(data);
				myallinfo.setAbout	(new String(data));
				System.out.println(myallinfo.getAbout());
/*
				myallinfo.setIP			(data_in.readInt());
				System.out.println(Integer.toHexString(myallinfo.getIP()));
//				System.in.read();

				myallinfo.setReal_IP				(data_in.readInt());
				System.out.println(myallinfo.getReal_IP());
				myallinfo.setPort		((short)data_in.readInt());
				System.out.println(myallinfo.getPort());
//				System.in.read();
*/
				myallinfo.setStatus	(data_in.readInt());
				System.out.println(myallinfo.getStatus());
//				System.in.read();
				file_in.close();
			}	// end if file exists
			else // if file doesn't exists
			{	file_out = new FileOutputStream(c_file);
				file_out.flush();	
				file_out.close();
			}
		}
		catch (FileNotFoundException f)
		{	System.err.println("FileNotFoundException " +f);
		}
		catch (IOException ioe)
		{	System.err.println("IOException " +ioe);
		}
		return myallinfo;
	}// end readDataFile
}