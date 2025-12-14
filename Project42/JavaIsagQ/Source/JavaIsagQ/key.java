package IsecQ;
import java.math.BigInteger;
import IsecQ.*;
class key 
{
	public static void main(String[] args) 
	{	//BigInteger t = new BigInteger("2");
		//System.out.println("t = "+t);
		byte[] b = new byte[16]; /*KEY*/
		byte[] mess = new byte[32]; /*MESSAGE*/
		System.out.print("Key = ");
//		for(i=0 ;i<b.length ;i++)		{	b[i] = (byte)i;					}
		
		DES edes = new DES();
		DES ddes = new DES();

		b=edes.genKey(16);

//		for(int i=0 ;i<b.length ;i++) 		{	System.out.print("|"+b[i]);	}
		for(int i=0 ;i<mess.length ;i++) 	{	mess[i] = (byte)i;				}
		
		mess=edes.paddingMessage(mess ,b.length);

		edes.setKey(b);
		ddes.setKey(b);

		//-----------------------------------------------------------
		System.out.println("\nmessage = ");
		byte[] result = edes.encrypt(mess);
		for(int k=0 ;k<result.length ;k++)
		{	System.out.print("|" + mess[k]);
		}
		//-----------------------------------------------------------
		System.out.println("\n\nmessage encrypt now = ");
		for(int k=0 ;k<result.length ;k++)
		{	System.out.print("|" + result[k]);
		}
		//-----------------------------------------------------------
		System.out.println("\n\nmessage decrypt now = ");
		result = ddes.decrypt(result);
		for(int k=0 ;k<result.length ;k++)
		{	System.out.print("|" + result[k]);
		}

	}
}