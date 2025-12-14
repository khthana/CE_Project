import java.io.*;

class ReadFile 
{
	public static void main(String[] args) throws IOException
	{
		int num_uin=0;
		FileInputStream file_in=new FileInputStream("contact.lis");
		DataInputStream data_in=new DataInputStream(file_in);
		num_uin=data_in.readInt();
		int[] uin=new int[num_uin];
		for(int i=0;i<num_uin;i++)
		{
			uin[i]=data_in.readInt();
			System.out.println(uin[i]);
		}
		data_in.close();
	}
}