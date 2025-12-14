import java.awt.*;
import java.awt.image.*;


public abstract class Emulation {


  protected static TelnetClient owner = null;
  protected static int width = 0;
  protected static int height = 0;
  protected static int char_w = 0;
  protected static int char_h = 0;



  static public void initClass (TelnetClient parent) {

    owner = parent;
    width = owner.width;
    height = owner.height;
    char_w = owner.w;
    char_h = owner.h;
    }


  public int column;
  public int row;
  public Color foreground;
  public Color background;

  public Emulation() {

    foreground = Color.white;
    background = Color.black;
    row = 0;
    column = 0;
    }

  public void clearcoord(int row1, int col1, int row2, int col2) {

    owner.bgr.setColor(background);

    if ( row1 == row2) {

      owner.bgr.fillRect(col1 * owner.chw, ( row1 )*owner.chh, (col2 - col1 + 1)*owner.chw, owner.chh);
      return;
      }

    owner.bgr.fillRect(col1 * owner.chw, ( row1 )*owner.chh, (char_w - col1)*owner.chw, owner.chh);

    if ( (row2-row1) > 1) {
      for (int i = row1+1; i < row2; i++){

        owner.bgr.fillRect(0, ( i )*owner.chh, char_w*owner.chw, owner.chh);
        }
      }

    owner.bgr.fillRect(0, ( row2 )*owner.chh, ( col2 + 1 )*owner.chw, owner.chh);
    }



  public void scrolldown(int ScrollTop, int ScrollBottom) {

    owner.bgr.copyArea(0, (ScrollTop) * owner.chh, char_w*owner.chw,
                          (ScrollBottom - ScrollTop)*owner.chh, 0, owner.chh);

    owner.bgr.setColor(background);

    owner.bgr.fillRect(0, (ScrollTop) * owner.chh, char_w*owner.chw, owner.chh);
    }

  public void scrollup(int ScrollTop, int ScrollBottom ) {

    owner.bgr.copyArea(0, (ScrollTop+1) * owner.chh,
                 char_w*owner.chw, (ScrollBottom - ScrollTop)*owner.chh, 0, -owner.chh);
    owner.bgr.setColor(background);

    owner.bgr.fillRect(0, (ScrollBottom)*owner.chh, char_w*owner.chw, owner.chh);

    }

  public void clearscreen() {

    owner.bgr.setColor(background);
    owner.bgr.fillRect(0,0,width,height);
    }

  public void displaych(char c) {

    owner.bgr.setColor(background);
    owner.bgr.fillRect(column*owner.chw, row*owner.chh, owner.chw, owner.chh);
    owner.bgr.setColor(foreground);
    owner.bgr.drawString(String.valueOf(c), column*owner.chw, (row+1)*owner.chh-owner.chd);

    }

  public void displaybytes(byte b[], int len) {
    }

  public void transmitch(char ch)
    {
    owner.transmitch(ch);
    }


  }