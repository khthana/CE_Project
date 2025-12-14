import java.awt.*;
public class LoadCharacter extends Canvas  {
  private int width=100;
  private int height=100;
  private int blockWidth;
  private int blockHeight;

  private int[][] characterImage;


  public LoadCharacter()  {
     setSize(width,height);
  }


  public void load(int[][] imageData)  {
     int i,j;
     characterImage=imageData;
     blockWidth=width/imageData[0].length;
     blockHeight=height/imageData.length;
     repaint();
  }

  public void paint(Graphics g)  {
     g.setColor(Color.white);
     g.fillRect(0,0,width,height);
     if(characterImage!=null) {
          g.setColor(Color.black);
          for(int i=0;i<blockHeight;i++)
            for(int j=0;j<blockWidth;j++)
               if(characterImage[j][i]==1)
                 g.fillRect(i*blockWidth,j*blockHeight,blockWidth,blockHeight);
     }
  }

}
