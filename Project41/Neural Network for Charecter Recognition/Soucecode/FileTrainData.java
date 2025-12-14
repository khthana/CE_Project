import java.awt.*;
import java.io.*;
public class FileTrainData extends FileManager  {
    String fileName;
    int fileMode;
    int count=0;
    int numberData=0;
    int numberPerData=0;
    int numberCode=6;
    double typeData[];
    public FileTrainData(String path,String name,String mode) {
        super(name,mode);
        if(getSize()>0) 
          readFormat();
        else
          setFormat();
    }

    public void setFormat()  {
        setPosition(0);
        writeInt(numberData);
        writeInt(numberPerData);
        writeInt(numberCode);
        writeCode("\n");
    }

    public void readFormat() {
        setPosition(0);
        numberData=readInt();
        numberPerData=readInt();
        numberCode=readInt();
        String s=readCode();
    }  

    public void setNumberPerData(int data) {
        numberPerData=data;
    }

    public int getNumberOfData()  {
        return  numberData;
    }
    public int getNumberCode()  {
        return  numberCode;
    }
    public int getNumberPerData()  {
        return  numberPerData;
    }
    public void save(double[] data,String s)  {
        int i;
        appendData();
        for(i=0;i<data.length;i++) 
           write(data[i]);

        typeData=Code.encode(s);

        for(i=0;i<typeData.length;i++)
           write(typeData[i]);

        writeCode("\n");
        setPosition(0);
        numberData++;
        writeInt(numberData);
    }

    public void append(double[] data,String s)  {
        appendData();
        save(data,s);
    }

    public double readData()  {
        return read();
    }
    public String readCode()  {
        return readUTF();
    }

   
}
                             
