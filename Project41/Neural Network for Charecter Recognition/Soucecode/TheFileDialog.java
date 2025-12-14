import java.io.*;
import java.awt.*;
public class TheFileDialog extends FileDialog implements FilenameFilter    {

   public static final int LOAD=0;
   public static final int SAVE=1;
          File   theFile;
          String theFilterSuffix;

   public TheFileDialog(Frame parent,String title,int mode)    {
       super(parent,title,mode);
   }

   public void setFilterSuffix(String fileSuffix)    {
       theFilterSuffix=fileSuffix;
       setFilenameFilter(this);
   }

   public boolean accept(File dir,String filter)   {
       return filter.endsWith(theFilterSuffix);
   }

}
