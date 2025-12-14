class test 
{
	public static void main(String[] args) 
	{	byte[] msg =new byte[33];
		byte[] key = new byte[16];
		for (int i=0;i<msg.length ;i++ )
		{	msg[i]=(byte)i;
		}

		for (int i=0;i<msg.length ;i++ )
		{	System.out.print(msg[i]+" ");
		}
		System.out.println();
		System.out.println("msg len "	+msg.length);
		System.out.println("key size "+key.length);
		msg=paddingMessage(msg ,key.length);
		for (int i=0;i<msg.length ;i++ )
		{	System.out.print(msg[i]+" ");
		}
		System.out.println();
		System.out.println("new msg len "+msg.length);
		System.out.println(msg.length / key.length);
	}

	public static byte[] paddingMessage(byte[] msg ,int keysize)
	{	byte[] msg_tmp;
		int k=msg.length % keysize;
		if (k != 0)
		{	int j = keysize - k;
			int new_len = j+msg.length;
			msg_tmp = new byte[ new_len ];
			for (int i = 0 ;i < msg.length ;i++)
			{	msg_tmp[i]=msg[i];
			}
			for (int i = msg.length ;i < new_len ;i++)
			{	msg_tmp[i]=(byte)0;
			}
		}else msg_tmp=msg;
		return msg_tmp;
	}

}
