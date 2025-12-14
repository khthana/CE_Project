package TERMINAL;
public interface DATA_TERMINAL
{
  //********************************************************************
  //							   part of TERMINAL
  //********************************************************************
  public final static int    Xterminal		  = 650;    //size of width Frame 
  public final static int    Yterminal		  = 450;    //size of heigth Frame
  //********************************************************************
  //							   part of SshTerminal
  //********************************************************************
  public final static char ESC            = 27;              // escape character = 0x1b
  public final static char BACKET		  = '[';           
  public final static char COMMA		  = ';';
  public final static char DEL			  = 8;
  public final static char BELL			  = 7;
  public final static int  STATUS_DATA    = 0;   //data
  public final static int  STATUS_ESC     = 1;   //ESC
  public final static int  STATUS_CSI     = 2;   //ESC [
  public final static int  ModeBackGround = 40;
  public final static int  ModeForeGround = 30;
  public final static String termType	  = "vt100";

  //********************************************************************
  //							   part of Display
  //********************************************************************
  public final static int NORMAL        = 0x00;  
  public final static int BOLD             = 0x01;
  public final static int UNDERLINE    = 0x02;
  public final static int INVERT          = 0x04;
  public final static int MaxColor        = 16;
  public final static int ColorBrighter   = 8;
  public final static int LINE             = 25;
  public final static int COLUMN       = 80;
  }//DATA