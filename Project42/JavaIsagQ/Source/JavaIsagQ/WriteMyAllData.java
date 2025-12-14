package IsecQ;
import java.io.*;
import IsecQ.Util;

class WriteMyAllData 
{
//	public static void main(String[] args) throws IOException
	public WriteMyAllData(UserAllInfo uallinfo) throws IOException
	{	FileOutputStream file_out=new FileOutputStream(Integer.toString(uallinfo.getUIN())+".ifo");
		DataOutputStream data_out=new DataOutputStream(file_out);

		data_out.writeInt		(uallinfo.getPWD().length());
		data_out.write			(uallinfo.getPWD().getBytes());
		data_out.writeInt		(uallinfo.getNick().length());
		data_out.write			(uallinfo.getNick().getBytes());
		data_out.writeInt		(uallinfo.getFirst().length());
		data_out.write			(uallinfo.getFirst().getBytes());
		data_out.writeInt		(uallinfo.getLast().length());
		data_out.write			(uallinfo.getLast().getBytes());
		data_out.writeInt		(uallinfo.getEmail().length());
		data_out.write			(uallinfo.getEmail().getBytes());
		data_out.writeByte	(uallinfo.getAuth());
			
		data_out.writeInt		(uallinfo.getCity().length());
		data_out.write			(uallinfo.getCity().getBytes());
		data_out.writeShort(uallinfo.getCountryCode());
		data_out.writeByte	(uallinfo.getCountryStatus());
		data_out.writeInt		(uallinfo.getState().length());
		data_out.write			(uallinfo.getState().getBytes());
		data_out.writeShort(uallinfo.getAge());
		data_out.writeByte	(uallinfo.getSex());
		data_out.writeInt		(uallinfo.getPhone().length());
		data_out.write			(uallinfo.getPhone().getBytes());
		data_out.writeInt		(uallinfo.getHomepage().length());
		data_out.write			(uallinfo.getHomepage().getBytes());
		data_out.writeInt		(uallinfo.getAbout().length());
		data_out.write			(uallinfo.getAbout().getBytes());
//		data_out.writeInt		(uallinfo.getIP());
//		data_out.writeInt		(uallinfo.getReal_IP());
//		data_out.writeInt		(uallinfo.getPort());
		data_out.writeInt		(uallinfo.getStatus());
		data_out.flush();
		data_out.close();
		System.out.println("write file complete");
	}
}