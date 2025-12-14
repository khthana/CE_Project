package SSH;
import java.io.*;
import java.math.BigInteger;
import TERMINAL.*;
import Utility.*;

public class SSHBufferOutputStream extends SSHDataOutputStream implements SSHBuf {
//@ role: this is class used for is buffer for keep data before writing data on stream
//parameter: none
  static class PduByteArrayOutputStream extends ByteArrayOutputStream {
    PduByteArrayOutputStream() {
      super();
    }
//@ role: set size of bytes array
//parameter: size
    PduByteArrayOutputStream(int size) {
      super(size);
    }
//@ role: get number of store bytes in bytes array
//input: none
//output: number of created buffers 
	public byte[] getBuf() {
      return buf;
    }
//@ role: get the ending index of the byte array to be read
//input : none
//output: index count
    public int getCount() {
      return count;
    }
//@ role: set number of bytes array
//input : bytes 
//output: none
    public void setBuf(byte[] buf) {
      this.buf = buf;
    }
//@ role: set index of the byte array to be read
//input : number count
//output : none 
    public void setCount(int count) {
      this.count = count;
    }
  }

  public static final int SSH_DEFAULT_PKT_LEN = 8192;  //default packet length
  public static int mtu = SSH_DEFAULT_PKT_LEN;

  public static synchronized void setMTU(int newMtu) {
    mtu = newMtu;
  }

  public static synchronized int getMTU() {
    return mtu;
  }

  byte[]  readFromRawData;
  int     readFromOff;
  int     readFromSize;

  public int    type;
  public Cipher cipher;

  SSHBufferOutputStream(Cipher cipher) {
    super(null);
    this.cipher = cipher;
  }

  public SSHBufferOutputStream(int type, Cipher cipher) throws IOException {
    super(new PduByteArrayOutputStream(getMTU()));
    this.type   = type;
    this.cipher = cipher;
    if(cipher != null) {
      SecureRandom rand = SshIO.secureRandom();
      byte[] randBytes  = new byte[8];
      rand.nextBytes(randBytes);
      for(int i = 0; i < 8; i++)
	write(randBytes[i]);
    } else {
      for(int i = 0; i < 8; i++)
	write(0);
    }
    write(type);
  }
  public void readFrom(InputStream in) throws IOException {
     }
//@role: this is method will do write data from bytes array on to out put stream 
//input : out put stream
//output : data in bytes array to out out put stream 
  public void writeTo(OutputStream sshOut) throws IOException {
    PduByteArrayOutputStream bytes   = (PduByteArrayOutputStream) out;
    int                      pad     = (bytes.size() + 4) % 8;
    byte[]                 padData = new byte[bytes.size() + 4 - pad];
    int                      crc32   = (int)CRC32.getValue(bytes.getBuf(), pad, bytes.size() - pad);

    writeInt(crc32);
    System.arraycopy(bytes.getBuf(), pad, padData, 0, padData.length);

    if(cipher != null) {
	  //System.out.println(" Mode ENCRYPTION  !");
      padData = cipher.encrypt(padData);
    }

    bytes = new PduByteArrayOutputStream();
    bytes.setBuf(padData);
    bytes.setCount(padData.length);
    out = bytes;
    sshOut = new SSHDataOutputStream(sshOut);

    ((SSHDataOutputStream)sshOut).writeInt(bytes.getCount() - (8 - pad));
    bytes.writeTo(sshOut);//byte array inputstream
    
    sshOut.flush();
  }
}

