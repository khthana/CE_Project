import java.awt.*;
import java.awt.image.*;

public class LoadImage extends Canvas  {

  private Image theImage;
  private int width=100;
  private int height=100;
  private boolean loadComplete=false;

  public LoadImage()  {
  }


  public LoadImage(String fileImage)    {
      theImage=getToolkit().getImage(fileImage);
      width=getWidth();
      height=getHeight();
      //loadComplete=true;
      this.setSize(width,height);
  }

  public void load(String fileImage)    {
      theImage=getToolkit().getImage(fileImage);
      width=getWidth();
      height=getHeight();
      //loadComplete=true;
      this.setSize(width,height);
      repaint();
  }

  public boolean loadComplete()    {
      return theImage.getHeight(this) != -1;
  }

  public int getHeight()    {
      while(theImage.getHeight(this)==-1) {}
      return  theImage.getHeight(this);
  }

  public int getWidth()    {
      while(theImage.getWidth(this)==-1) {}
      return  theImage.getWidth(this);
  }

  public Image getImage()    {
      return theImage;
  }

  public void paint(Graphics g)    {
       g.drawImage(theImage,0,0,this);
  }

  public int[][] convertToArray()    {
           int Width=getWidth();
           int Height=getHeight();
           int pixelArray[]=new int[Width*Height];
           PixelGrabber pg=new
               PixelGrabber(theImage,0,0,Width,Height,pixelArray,0,Width);

           try {
               pg.grabPixels();
           }   catch(InterruptedException e){};

           Color middle_color=new Color(125,125,125);
           int middle_color_int=middle_color.hashCode();

           int temp[][]=new  int[Height][Width];
           int count=-1;

           for(int i=0;i<Height;i++)
              for(int j=0;j<Width;j++) {
                 count++;
                 temp[i][j]=pixelArray[count];
//CONVERT COLOR HASHCODE TO BINARY IF COLOR > MIDDLE =1 ELSE =0
                 if(temp[i][j]<middle_color_int)
                     temp[i][j]=1;
                 else temp[i][j]=0;
              }
      return temp;
  }

}


