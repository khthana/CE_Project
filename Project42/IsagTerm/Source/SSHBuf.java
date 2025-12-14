//@ role: It's interface class for only extends 
//parameter: none
//comment: เป็นคลาสแม่สำหรับให้มีการขยายไปใช้งานโดยต้องมีการประกาศ method ทั้ง 2 ก่อนจึงจะใช้งานได้
// เพื่อต้องการให้มีหน้าที่การทำงานที่เหมือนคลาสแม่ทุกประการ
package SSH;
import java.io.*;

public interface SSHBuf {
  public void   writeTo(OutputStream out) throws IOException;
  public   void   readFrom(InputStream in) throws IOException;
 }
