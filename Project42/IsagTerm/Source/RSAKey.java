package SSH;
import java.math.BigInteger;

public class RSAKey implements Key {

  private BigInteger e;
  private BigInteger n;
//@ role: keep data of exponent key and modulus key
//parameter: exponent key,modulus key
  public RSAKey(BigInteger e, BigInteger n) {
    this.e    = e;
    this.n    = n;
  }
//@ role: return stratigic encryption
//parameter: none
  public String getAlgorithm() {
    return "RSA";
  }
//@ role: get bit length of modulus key for create format PKCS#1
//parameter: none
  public int bitLength() {
    return n.bitLength();
  }
//@ role: get exponent key
//parameter: none
  public BigInteger getE() {
    return e;
  }
 public byte[] getEncoded() {
    return null;
  }

  public String getFormat() {
    return null;
  }

//@ role: get modulus key
//parameter: none
  public BigInteger getN() {
    return n;
  }

}
