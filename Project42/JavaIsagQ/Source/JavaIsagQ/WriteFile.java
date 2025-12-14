import java.io.*;

class WriteFile 
{	public static void main(String[] args) throws IOException
	{
//		int[] uin={24376329 ,45455043 ,24431635 ,12906447 ,18266771 ,14211459 ,4896304 ,5344938 ,60710412};
		int[] uin={24376329 ,45455043 ,24431635 ,12906447 ,18266771 ,14211459 ,4896304 ,5344938 ,60710154};

		int num_uin=uin.length;
		FileOutputStream file_out=new FileOutputStream("60710412.lis");
//		FileOutputStream file_out=new FileOutputStream("60710154.lis");
		DataOutputStream data_out=new DataOutputStream(file_out);
		data_out.writeInt(num_uin);
		for(int i=0;i<num_uin;i++)
		{
			data_out.writeInt(uin[i]);
		}
		data_out.flush();
		data_out.close();
		System.out.println("write file complete");
	}
}