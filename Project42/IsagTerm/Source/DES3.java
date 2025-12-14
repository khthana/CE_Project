package SSH;

import java.math.BigInteger;

public final class DES3 extends Cipher {
  DES des1 = new DES();
  DES des2 = new DES();
  DES des3 = new DES();

  public synchronized byte[] encrypt(byte[] in) {
    in = des1.encrypt(in);
    in = des2.decrypt(in);
    in = des3.encrypt(in);
    return in;
  }

  public synchronized byte[] decrypt(byte[] in) {
    in = des3.decrypt(in);
    in = des2.encrypt(in);
    in = des1.decrypt(in);
    return in;
  }

  public void setKey(byte[] key) {
    byte[] subKey = new byte[8];
    des1.setKey(key);
    System.arraycopy(key, 8, subKey, 0, 8);
    des2.setKey(subKey);
    System.arraycopy(key, 16, subKey, 0, 8);
    des3.setKey(subKey);
  }

  

}
