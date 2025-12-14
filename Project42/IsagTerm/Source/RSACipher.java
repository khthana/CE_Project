package SSH;
import java.math.BigInteger;
import java.io.IOException;

public class RSACipher {

  public KeyPair keys;

  public RSACipher(KeyPair keys) {
    this.keys = keys;
  }
//@ role: calculate RSA (Example  ->  C = p^e mod n)
//parameter: data of PKCS#1
  public BigInteger doPublic(BigInteger input) {
    RSAPublicKey pubKey = (RSAPublicKey)keys.getPublic();
    BigInteger   result;
    result = input.modPow(pubKey.getE(), pubKey.getN());
    return result;
  }

//@ role: create format of PKCS#1 (Example ->  |0|2|padding|0|data|)
//parameter: sessionkey(32 byte),random padding not zero,length of padding
 
   public static BigInteger doPad(BigInteger input, int padLen, SecureRandom rand) throws IOException {
  
    BigInteger result;
    BigInteger rndInt;
    int inByteLen  = (input.bitLength() + 7) / 8;
    int padByteLen = (padLen + 7) / 8;

    if(inByteLen > padByteLen - 3)
      throw new IOException("rsaPad: Input too long to pad");

    // !!! byte[] ranBytes = new byte[(padByteLen - inByteLen - 3) + 1];
    byte[] ranBytes = new byte[(padByteLen - inByteLen - 3) + 1];
    rand.nextBytes(ranBytes);
    ranBytes[0] = 0;
    for(int i = 1; i < (padByteLen - inByteLen - 3 + 1); i++)
      if(ranBytes[i] == 0)
	ranBytes[i] = 0x17;
	//byte[] b = input.toByteArray();
	
    rndInt = new BigInteger(ranBytes);
    rndInt = rndInt.shiftLeft((inByteLen + 1) * 8);
    result = new BigInteger("2");
    result = result.shiftLeft((padByteLen - 2) * 8);
    result = result.or(rndInt);
    result = result.or(input);
	 return result;
	  }
}
