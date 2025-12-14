import java.awt.*;
import java.awt.image.*;
public class PictureArea extends ScrollPane {

  Image characterImage;
  LoadImage image=new LoadImage();
  Block myBlock ;

  public PictureArea()  {
    super(ScrollPane.SCROLLBARS_AS_NEEDED);
    this.setSize(400,400);
    setBackground(Color.black);
  }

  public void loadImage(String fileImage)    {
    image.load(fileImage);
    add(image);
  }

  public void segmentation()  {
    makeBlock();
  }

  public int[][] getCharacter() {
    int imageData[][]=myBlock.getDisplayData();
    return imageData;
  }

  public double[] getData()  {
    return myBlock.getTokenData();
  }

  public boolean haveAnyCharacter()  {
    return myBlock.haveAnyDisplayData();
  }

  public Image getCharacterImage()  {
    return characterImage;
  }

  private void makeBlock()  {
    int[][] block=image.convertToArray();
    myBlock=new Block(block);
  }

}

