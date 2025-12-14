import java.math.BigInteger;
class kRSAkDES 
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
	public byte[] getkDES()
	{	System.out.println("RETURN kDES = "+this.kDES); 
		return this.kDES;   
	}
}