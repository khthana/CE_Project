package SSH;
import java.io.*;
import Utility.*;
import java.math.BigInteger;
import SSH.Cipher;
import TERMINAL.SshIO;
public class SSHBufferInputStream extends SSHDataInputStream implements SSHBuf
 {
  public static int type;
  public static int length;
  public boolean DEBUG = false;
  byte[] bytes;
 
  Cipher cipher;	//class cipher in class security
 
   public SSHBufferInputStream(int type,Cipher cipher)
   {
    super(null);
    this.type   = type; // This is the expected type (checked in readFrom())
    this.cipher = cipher;
   }

//@ role: It,s buffer for keep data of Stream 
//parameter: bytes data
//comment: เป็นคลาสสำหรับนำเอา stream bytes ที่รับเข้ามามาเก็บไว้เพื่อใช้สำหรับประมวณผล
//               ภายในเครื่องเพื่อป้องกัน การล่าช้าถ้าใช้การติดต่อกับ IO โดยตรง  
  static class PduByteArrayInputStream extends ByteArrayInputStream {
    PduByteArrayInputStream(byte[] data) {
      super(data);
    }

//@ role: get  current index of Bytearray inputstream
//parameter: none
// comment: ดึงค่า index ของ byte array ขณะนั้นออกมา 
    public int getPos() {
      return pos;
    }

//@ role: set index go to determine position
//parameter: position 
// comment: เซ็ทค่า index ของ byte array ตามที่ต้องการ 
    public void setPos(int pos) {
      this.pos = pos;
    }

	//@ the byte array contains the bytes to be read
	//parameter: none
    public byte[] getBuf() {
      return buf;
    }

	//@ role: set number of array byte to be read
	//parameter: number bytes
    public void setBuf(byte[] buf) {
      this.buf = buf;
    }
  }
  //@ role: this is method used check CRC32
  //parameter: none
  private boolean Checksum() throws IOException {
    int padLen = ((length + 8) & ~7); //padding length
    int stored, calculated;

    skip(padLen - 4);
    stored = readInt();
    reset();

    calculated = (int)CRC32.getValue(bytes, 0, padLen - 4);

    if(calculated != stored)
      return false;

    return true;
  }	  
//@ role: this is method used for read data bytes from stream
//parameter: input Stream
//comment: method นี้ใช้ในการดึงเอาข้อมูลจาก stream เข้ามาและทำการคำนวณหาความยาวของ packet,data,type,padding อื่น  
  public void readFrom(InputStream input) throws IOException { //1
   
    SSHDataInputStream	dIn    = new SSHDataInputStream(input);
	// if(dIn != null){System.out.println("not null >>>>>>>");}
	
	int                len    = dIn.readInt(); //read length of packet
	int                padLen = ((len + 8) & ~7);  //length padding 8-(length mod 8)
	//System.out.println("length -------->"+len);
	//System.out.println("length total -------->"+padLen);
    int                type;
    byte[]             data;

    if(padLen > 256000)
	{
       System.out.println("Corrupt incoming packet, too large");
       throw new IOException("Corrupt incoming packet, too large");
	  }

    data = new byte[padLen];

    dIn.readFully(data);
    if(cipher != null)
	{
      //System.out.println("Mode Decryption...");
      data = cipher.decrypt(data);
    }
    //for(int i=0;i<data.length;i++)System.out.print(data[i]+"|");
    this.in     = new PduByteArrayInputStream(data);
	
    this.bytes  = data;
    this.length = len;

   if(!this.Checksum())
      throw new IOException("Invalid checksum in packet");
     in.skip(8 - (len % 8));  //script padding length
    
    type = (int)this.readByte(); //reading packet type 1 byte
    //System.out.println("packet type ==="+type);
	if(type == SshIO.SSH_MSG_DEBUG) { //2
      logDebug("MSG_DEBUG: " + this.readString());
      this.readFrom(in);    
	  } //(2)
	   else if(type == SshIO.SSH_MSG_IGNORE) {//2
      logIgnore(this);
      this.readFrom(in);   
	  }  //(2)
	   else { //2
      if((this.type != SshIO.SSH_MSG_ANY) && (this.type != type)) { //3
	if(type == SshIO.SSH_MSG_DISCONNECT)
	{  //4
		System.out.println("Server Disconnect(readfrom)");
	  throw new IOException("Server disconnected: " + this.readString());
	} //(4)
	else
	{ //4
	  System.out.println("Invalid type(readfrom)");
	  throw new IOException("Invalid type: " + type + " (expected: " +
				this.type + ")");
	} //(4)
      }	//(3)
      this.type = type;
	 } //(2)
  }	//(1)
//@ role: this is method will print message if server request debug
//parameter: string request
  private void logDebug(String msg) {
     System.out.println(msg);
  }

//@role: print message if server request ignore
//parameter: message
private void logIgnore(SSHBufferInputStream pdu) {
     System.out.println("MSG_IGNORE received...(len = " + pdu.length + ")");
  }
 public void writeTo(OutputStream Out) throws IOException {
      }	
}
