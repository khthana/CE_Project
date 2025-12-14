package IsecQ;
import java.math.BigInteger;
import java.util.Random;
import IsecQ.Util;
class t 
{
	static BigInteger E,D,N;
	static Util u=new Util();
	static DES edes = new DES();
	static DES ddes = new DES();

	public static void main(String[] args) 
	{
		byte[] m =new byte[40];
//		byte[] key=new byte [16];
		byte[] key=edes.genKey(16);
		for (int i = 0 ;i < m.length; i++)
		{	m[i]=(byte) i;
		}
//		for (int i = 0 ;i < key.length; i++)
//		{	key[i]=(byte) i;
//		}
		System.out.println(" message = ");
		for (int i = 0 ;i < m.length; i++)
		{	System.out.print(m[i]+" ");
		}
		System.out.println("\n message length = "+m.length);
		System.out.println("\n key = ");
		for (int i = 0 ;i < key.length; i++)
		{	System.out.print(key[i]+" ");
		}
		System.out.println("\n key length = "+key.length);
		byte[] p=edes.paddingMessage(m,key.length);
		System.out.println("\npadding =\n");
		for (int i = 0;i<p.length ; i++)
		{	System.out.print(p[i]+" ");
		}
		System.out.println("\npadding length = "+p.length);
		System.out.println(p.length / key.length);

		edes.setKey(key);
		byte[] encrypt_msg = edes.encrypt(p);
		System.out.println("\n encrypt msg =\n");
		for (int i = 0;i<encrypt_msg.length ; i++)
		{	System.out.print(encrypt_msg[i]+" ");
		}
		System.out.println("\n encrypt length = "+encrypt_msg.length);

		ddes.setKey(key);
		byte[] decrypt_msg =	ddes.decrypt(encrypt_msg);
		System.out.println("\n decrypt msg =\n");
		for (int i = 0;i<decrypt_msg.length ; i++)
		{	System.out.print(decrypt_msg[i]+" ");
		}
		System.out.println("\n decrypt length = "+decrypt_msg.length);
	
		System.out.println("\ndepadding =");
		byte[] result =edes.dePaddingMessage(decrypt_msg);
		for (int i = 0;i<result.length ; i++)
		{	System.out.print(result[i]+" ");
		}
		System.out.println("\npadding length = "+result.length);

/*		System.out.println("des=\n");
		byte[] des =new byte[16];
		for (int i=0;i<des.length ;i++ )
		{	des[i]=(byte)i;
		}
		for (int i=0;i<des.length ;i++ )
		{	System.out.print(des[i]+" ");
		}
		System.out.println();


		BigInteger d = new BigInteger(des);
		System.out.println("d=\n"+d);

		byte[] des2=d.toByteArray();
		System.out.println("des2=\n");

		for (int i=0;i<des2.length ;i++ )
		{	System.out.print(des2[i]+" ");
		}
		System.out.println();


/*		BigInteger e = new BigInteger(256,16, new Random());
		BigInteger n = new BigInteger(256,16, new Random());
		BigInteger d = new BigInteger(256,16, new Random());

		System.out.println("E = \n"+e.toString(16));
		System.out.println("E = \n"+e);
		System.out.println("bit length = \n"+e.bitLength());
		System.out.println("bit count = \n"+e.bitCount());
		System.out.println("N = \n"+n.toString(16));
		System.out.println("N = \n"+n);
		System.out.println("bit length = \n"+n.bitLength());
		System.out.println("bit count = \n"+n.bitCount());
		String jk = e.toString() + n.toString();
		System.out.println("join key e and n=\n"+jk);

		extractPublicKeyFromMessage	(jk);

		System.out.println("E = \n"+E.toString(16));
		System.out.println("bit length = \n"+E.bitLength());
		System.out.println("bit count = \n"+E.bitCount());
		System.out.println("N = \n"+N.toString(16));
		System.out.println("bit length = \n"+N.bitLength());
		System.out.println("bit count = \n"+N.bitCount());

/*		byte[] m={1,2,3,4,5,6};
		byte[] n={02,3};
		for (int i=0;i<m.length ;i++ )
		{	System.out.print(m[i]+" ");
		}
		System.out.println();
		for (int i=0;i<n.length ;i++ )
		{	System.out.print(n[i]+" ");
		}
		System.out.println();
		m=n;
		for (int i=0;i<m.length ;i++ )
		{	System.out.print(m[i]+" ");
		}
*/
	}
/*
	public static byte[] paddingMessage(byte[] msg ,int keysize)
	{	byte[] msg_tmp;
		byte[] oo = u.joinBytes(u.short2Bytes((short)msg.length) ,msg );
		System.out.println("oo = \n");
		for (int i = 0 ;i < oo.length ;i++ )
		{	System.out.print(oo[i] + " ");
		}
		System.out.println("\noo length = "+oo.length+"\n");
		int k = oo.length % keysize;
		if (k != 0)
		{	int j = keysize - k;
			int new_len = j + oo.length;
			msg_tmp = new byte[ new_len ];
			for (int i = 0 ;i < oo.length ;i++)
			{	msg_tmp[i] = oo[i];
			}
			for (int i = oo.length ;i < new_len ;i++)
			{	msg_tmp[i] = (byte)0;
			}
		}else msg_tmp = oo;
		return msg_tmp;
	}

	public static byte[] dePaddingMessage(byte[] msg_padded)
	{	byte [] len =new byte [2];
		len[0] = msg_padded [0];
		len[1] = msg_padded [1];
		short m_len = u.bytes2Short(len);
		byte[] msg = new byte[(int)m_len & 0x0ffff];
		for (int i = 0 ;i < msg.length ;i++ )
		{	msg[i] = msg_padded[i+2];
		}
		return msg;
	}

	
	public static void extractPublicKeyFromMessage	(String message)
	{	byte[] msgByte = message.getBytes();
		byte[] e=new byte[32];
		byte[] n=new byte[32];
		for (int i=0 ;i<32;i++ )
		{	e[i]=msgByte[i];
		}
		E=new BigInteger(e);
		int j=0;
		for (int i=32 ;i<64 ;i++ )
		{	n[j]=msgByte[i];
			j++;
		}
		N=new BigInteger(n);
	}
*/
}