package SSH;

public abstract class Cipher {

  public static Cipher getInstance(String algorithm) {
    Class c;
    try {
      c = Class.forName("SSH." + algorithm);
      return (Cipher)c.newInstance();
    } catch(Exception e) {
      return null;
    }
  }

  public abstract byte[] encrypt(byte[] msg);
  public abstract byte[] decrypt(byte[] msg);
  public abstract void   setKey(byte[] key);

  public void setKey(String key) {
    MessageDigest md5;
    byte[] mdKey = new byte[32];
    try {
      md5 = MessageDigest.getInstance("MD5");
      md5.update(key.getBytes());
      byte[] digest = md5.digest();
      System.arraycopy(digest, 0, mdKey, 0, 16);
      System.arraycopy(digest, 0, mdKey, 16, 16);
    } catch(Exception e) {
      // !!!
      System.out.println("MD5 not implemented, can't generate key out of string!");
      System.exit(1);
    }
    setKey(mdKey);
  }

}
