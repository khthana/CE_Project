package SSH;
import java.math.BigInteger;

public class RSAPublicKey extends RSAKey implements PublicKey {
  public RSAPublicKey(BigInteger e, BigInteger n) {
    super(e, n);
  }
}
