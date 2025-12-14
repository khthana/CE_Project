package IsecQ;
import java.io.*;
import IsecQ.Util;

class WriteAllData 
{
	public WriteAllData(String filename ,UserAllInfo[] uallinfo ,int num_user) 
	{
		try
		{	FileOutputStream file_out=new FileOutputStream(filename);
			DataOutputStream data_out=new DataOutputStream(file_out);
			data_out.writeInt(num_user);
			for(int i=0;i<num_user;i++)
			{	data_out.writeInt		(uallinfo[i].getUIN());
				data_out.writeInt		(uallinfo[i].getPWD().length());
				data_out.write			(uallinfo[i].getPWD().getBytes());
				data_out.writeInt		(uallinfo[i].getNick().length());
				data_out.write			(uallinfo[i].getNick().getBytes());
				data_out.writeInt		(uallinfo[i].getFirst().length());
				data_out.write			(uallinfo[i].getFirst().getBytes());
				data_out.writeInt		(uallinfo[i].getLast().length());
				data_out.write			(uallinfo[i].getLast().getBytes());
				data_out.writeInt		(uallinfo[i].getEmail().length());
				data_out.write			(uallinfo[i].getEmail().getBytes());
				data_out.writeByte	(uallinfo[i].getAuth());
				
				data_out.writeInt		(uallinfo[i].getCity().length());
				data_out.write			(uallinfo[i].getCity().getBytes());
				data_out.writeShort(uallinfo[i].getCountryCode());
				data_out.writeByte	(uallinfo[i].getCountryStatus());
				data_out.writeInt		(uallinfo[i].getState().length());
				data_out.write			(uallinfo[i].getState().getBytes());
				data_out.writeShort(uallinfo[i].getAge());
				data_out.writeByte	(uallinfo[i].getSex());
				data_out.writeInt		(uallinfo[i].getPhone().length());
				data_out.write			(uallinfo[i].getPhone().getBytes());
				data_out.writeInt		(uallinfo[i].getHomepage().length());
				data_out.write			(uallinfo[i].getHomepage().getBytes());
				data_out.writeInt		(uallinfo[i].getAbout().length());
				data_out.write			(uallinfo[i].getAbout().getBytes());
	
//				data_out.writeInt		(uallinfo[i].getIP());
//				data_out.writeInt		(uallinfo[i].getReal_IP());
//				data_out.writeInt		(uallinfo[i].getPort());
//				data_out.writeInt		(uallinfo[i].getStatus());
			}
			data_out.flush();
			data_out.close();
			System.out.println("write file "+filename+" complete");
		}
		catch (IOException io)
		{	System.out.println("IOException "+io);
		}
	}
}