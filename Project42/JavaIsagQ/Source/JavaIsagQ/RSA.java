package IsecQ;
import java.math.BigInteger;
import java.util.Random;

class RSA
{	public int Private_index = 0;
	public int IP;
	public BigInteger E, N, D;
	public byte[] kDES;

/*	public void setEN(int ip,BigInteger e, BigInteger n) 
	{	System.out.println("In class RSA : "+ip+":"+e+":"+n);
		this.IP = ip;
		this.E = e;
		this.N = n;
	} //method นี้ยังไม่ได้ใช้..*/
	public int getIP()
	{    //System.out.println("RETURN IP = "+this.IP); 
		return this.IP;
	}
	public BigInteger getD()
	{	//System.out.println("RETURN D = "+this.D); 
		return this.D;   
	}
	public BigInteger getE()
	{    //System.out.println("RETURN E = "+this.E); 
		return this.E;
	}
	public BigInteger getN()
	{	//System.out.println("RETURN N = "+this.N); 
		return this.N;   
	}

/*	public byte[] getkDES()
	{	System.out.println("RETURN kDES = "+this.kDES); 
		return this.kDES;   
	}
*/	
	public void genKey()
	{	BigInteger one = new BigInteger("1");
		BigInteger p1 = new BigInteger(256,16, new Random());	
		BigInteger q1 = new BigInteger(256,16, new Random());	
		N = p1.multiply(q1);
		BigInteger phi1 = p1.subtract(one).multiply(q1.subtract(one));		
		E = new BigInteger(256,1, new Random());
		BigInteger gcd1 = phi1.gcd(E);
		while (!gcd1.equals(one))
			{
				E = new BigInteger(256,1, new Random());		gcd1 = phi1.gcd(E);
			}
		D = E.modInverse(phi1);
	}

	//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	//	n = p x q ,		phi = (p-1)(q-1) ,		e = ? ,		Message = m
	//	Enc	 	: mchipher = m.modPow(e1,n1);		// e1, n1 publicKey receive from Send User#
	//  Dec	: mplantex = mc.modPow(d1,n1);	// d1 : privateKey User#
	//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*	public BigInteger Encrypt(BigInteger eb, BigInteger nb, String ss)		
	{	byte[] bytestr = ss.getBytes();
		BigInteger m = new BigInteger(bytestr); 
		BigInteger mc = m.modPow(eb,nb);
		return mc;
	}

/*	public BigInteger Encrypt(BigInteger eb, BigInteger nb, BigInteger ss)		
	{	BigInteger mc = ss.modPow(eb,nb);
		return mc;
	}
*/
/*	public BigInteger Decrypt(BigInteger db, BigInteger nb, BigInteger mc)
	{	System.out.println(" key D= \n"+db);
		System.out.println(" key N= \n"+nb);
		System.out.println(" messagge \n"+mc);

		BigInteger mx = mc.modPow(db ,nb);
		return mx;
	}
*/
		public BigInteger Encrypt(BigInteger key_E, BigInteger key_N, BigInteger msg)		
		{	return msg.modPow(key_E ,key_N);
		}

		public BigInteger Decrypt(BigInteger key_D, BigInteger key_N, BigInteger msg_en)
		{	return  msg_en.modPow(key_D ,key_N);
		}

}