import java.io.*;
public class FileManager {
  public static final String LOAD="r";
  public static final String SAVE="rw";
  public RandomAccessFile raf;

  public FileManager(String name,String mode) {
        try {
            raf=new RandomAccessFile(name,mode);
        } catch(IOException e)  {}
  }

  public void appendData()  {
      try  {
          raf.seek(raf.length());
      } catch(IOException e) {}
  }

  public void setPosition(long position)  {
      try  {
          raf.seek(position);
      } catch(IOException e) {}
  }

  public void write(double data)  {
      try  {
          raf.writeDouble(data);
      } catch(IOException e) {}
  }           

  public void writeCode(String data)  {
      try  {
          raf.writeUTF(data);
      } catch(IOException e) {}
  }

  public void writeInt(int data)  {
      try  {
          raf.writeInt(data);
      } catch(IOException e) {}
  }

  public void writeString(String data)  {
      try  {
          raf.writeBytes(data);
      } catch(IOException e) {}
  }

  public double read() {
      double temp=0.0;
      try  {
          temp=raf.readDouble();
      } catch(IOException e) {}
      return temp;
  }

  public int readInt() {
      int temp=0;
      try  {
          temp=raf.readInt();
      } catch(IOException e) {}
      return temp;
  }

  public String readUTF()  {
      String temp="";
      try  {
          temp=raf.readUTF();
      } catch(IOException e) {}
      return temp;
  }

  public long getSize()  {
      long temp=0;
      try  {
          temp=raf.length();
      } catch(IOException e) {}
      return temp;
  }

}
