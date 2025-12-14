package TERMINAL;
import java.awt.*;

public class SshTerminal extends Display 
{
	private static boolean DEBUG = false;
	private int ParameterAfterBacket;    
	private int Value[] = new int[10];   //keep value after backet [
	public  static int TempBackGround;
	public  static int TempForeGround;
	public  static Color HoldFore;
	public  static Color HoldBack;
	public  static int TempLine;
	public  static int TempColumn;
	public  static boolean Bright; 
	public  static boolean Inverse;
	public  static boolean TempBright;
	public  static boolean TempInverse;
	 
	public SshTerminal()
	{
		ParameterAfterBacket =0;
		TempForeGround = 7;
		TempBackGround = 0;
		Bright  = false;
		Inverse = false;
	}//constructor SshTerminal()

	//@role: this is method will display entry string on screen
	//input : string message
	//output : display on screen
	public void DisplayString(String str)
	{
		if(str == null) return;
		super.Line   = super.CheckBound(super.Line,0,super.Char_Canvas_Height-1);
		super.Column = super.CheckBound(super.Column,0,super.Char_Canvas_Width-1);
		int length = str.length();
		super.State = super.CheckCodeFirstFormString(str.charAt(0));
		for(int i = 0; i <length; i++)
		{
			DisplayChar(str.charAt(i));
	   		super.Paint();
		}//for()
	}//method PutString()

	//@role : this is method used change attribute of background,foreground
	//input : none
	//output : change attribute
	public void ChangeAttribute()
	{
  		for(int i=0; i <= ParameterAfterBacket;i++)
		{
			if(Value[i] >= ModeBackGround)
			{
	  			TempBackGround = Value[i] - ModeBackGround;
				super.BackGround = super.color[TempBackGround];
			}	//if(value[i] >= ModebackGround)
			else if(Value[i] >= ModeForeGround)
			{
	  			TempForeGround = Value[i] - ModeForeGround;
				if(Bright)
					super.ForeGround = super.color[TempForeGround + 8];
				else 
					super.ForeGround = super.color[TempForeGround];
			}	//if(Value[i] >= ModeForeGround)
			else
				switch(Value[i])
				{
					case 0:
						TempForeGround = 7;
						TempBackGround = 0;
						super.ForeGround = color[TempForeGround];
						super.BackGround = color[TempBackGround];
						Bright = false;
						Inverse= false;
						break;
					case 1:
						Bright = true;
						super.ForeGround = color[TempForeGround+8];
						break;
					case 7:
						Inverse = true;
						super.ForeGround = color[TempBackGround];
						super.BackGround = color[TempForeGround];
						break;
					case 22:
						Bright = false;
						super.ForeGround = color[TempForeGround];
						break;
					case 27:
						super.BackGround = color[TempBackGround];
						Inverse = false;
						if(Bright)
						{
							super.ForeGround = color[TempForeGround+8];
						}//if(bright = true)
						else
							super.ForeGround = color[TempForeGround];
						break;
				}//switch(value[i])
		}//for()
	}//method changeAttribute()

	//@role : this is method used display one character on screen
	//input : one char
	//output : display one char
	public void DisplayChar(char Char)
	{
  		switch(super.State)
		{
			case STATUS_DATA:
			{
				switch(Char)
				{
					case ESC:
						if(DEBUG)System.out.println("Load Char : ESC "+Char);
						super.State = STATUS_ESC;
						break;
					case DEL:
						if(DEBUG)System.out.println("Load Char : Back Space "+Char);
						if(Column != 0)
						Column--;
						break;
					case BELL:
						if(DEBUG)System.out.println(" Bip Bip : BELL "+Char);
						break;
					case '\t':
						if(DEBUG)System.out.println(" tap : \t "+Char);
						int Tem = super.Column;
						for(int i =8;i>Tem%8;i--)
						DisplayChar(' ');
						break;
					case 0x0d:
						if(DEBUG)System.out.println("Load Carriage :\r "+Char);
						Column = 0;
						break;
					case 0x0a:
						if(DEBUG)System.out.println("Load Line Feed : \n "+Char);
						if(Line == Char_Canvas_Height-1)
						{
							super.LineFeed(0,Char_Canvas_Height-1);
						}//if(line == Char_Canvas_Height)
						else if(super.Line == ScrollBottom)
						{
							super.LineFeed(ScrollTop,ScrollBottom);
						}//if(line == ScrollBottom)
						else super.Line++;
						break;
					default:
						if(Char >= 32 && Char < 255)
						{
							super.DisplayCharOnScreen(Char);
							super.PutChar(super.Line,super.Column,Char);
							if(super.Column == (super.Char_Canvas_Width-1))
							{
								this.DisplayChar((char)0x0a);
								this.DisplayChar((char)0x0d);
							}//if()
							else super.Column++;
							break;
						}//if(32 && 255)
				}//case STATUS_DATA && switch(Char) 
				break;//break of STATUS_DATA
			}//case STATUS_DATA

			case STATUS_ESC: 
			{
				switch(Char)
				{	   
					case ESC:
						if(DEBUG)System.out.println(" Load Char : ESC "+Char);
						super.State = STATUS_ESC;
						break;
					case BACKET:
						if(DEBUG)System.out.println(" Load Char : "+Char);
						super.State = STATUS_CSI;
						ParameterAfterBacket = 0;
						for(int i =0; i< 10; i++)
						Value[i] = 0;
						break;
					case '7':
						if(DEBUG)System.out.println(" Load Char :store Cursor "+Char);
						TempLine   = super.Line;
						TempColumn = super.Column;
						TempBright = Bright;
						TempInverse= Inverse;
						HoldFore = super.ForeGround;
						HoldBack = super.BackGround;
						super.State = STATUS_DATA;
						break;
					case '8':
						if(DEBUG)System.out.println(" Load Char :restore Cursor "+Char);
						super.Line   = TempLine;
						super.Column = TempColumn; 
						Bright       = TempBright; 
						Inverse      = TempInverse;
						super.ForeGround = HoldFore;
						super.BackGround = HoldBack;
						super.State = STATUS_DATA;
						break;
					case 'M':
						if(DEBUG)System.out.println(" Load Char : M "+Char);
						if(Value[0] == 0)
							Value[0]= 1;
						if((super.Line + Value[0]) > (super.Char_Canvas_Height-1))
							super.Line = super.Char_Canvas_Height-1;
						else
							super.Line += Value[0];
							super.State = STATUS_DATA;
							ParameterAfterBacket = 0;
							for(int i=0;i<3;i++)
								Value[i] = 0;
							ScrollDown(ScrollTop,ScrollBottom);
							break;
					case '(':
					case	')':
						if(DEBUG)System.out.println(" Load Char : (,) "+Char);
						super.State = STATUS_DATA;
						break;
					default:
						if(DEBUG)System.out.println(" VT100_DATA : <ESC> + unknow: "+Char);
						super.State = STATUS_DATA;
						break;
				}//case STATUS_ESC && switch(Char)
				break;//break of STATUS_ESC   
			}//case STATUS_ESC

			case STATUS_CSI: 	
			{
				switch(Char)
				{
					case '0':
					case '1':
					case '2':
					case '3':
					case '4':
					case '5':
					case '6':
					case '7':
					case '8':
					case '9':
						Value[ParameterAfterBacket] *= 10;
						Value[ParameterAfterBacket] += Char - '0';
						if(DEBUG)System.out.println(" Load Char :Char - '0' "+Value[ParameterAfterBacket]);
						break;
					case ';':
						if(DEBUG)System.out.println(" Load Char : ; "+Char);
						if(ParameterAfterBacket >= Value.length)
							ParameterAfterBacket = Value.length - 1;
						ParameterAfterBacket++;
						Value[ParameterAfterBacket] = 0;
						break;
					case 'f':
					case 'H':
						if(DEBUG)System.out.println(" Load Char : f,H "+Char);
						if(Value[0] == 0)
							Value[0] = 1;
						if(Value[1] == 0)
							Value[1]	= 1;
						if(Value[0] > super.Char_Canvas_Height)
							super.Line = super.Char_Canvas_Height-1;
						else 
							super.Line = Value[0]-1;
						if(Value[1] > super.Char_Canvas_Width)
							super.Column = super.Char_Canvas_Width-1;
						else
							super.Column = Value[1]-1; 
						super.State = STATUS_DATA;
						ParameterAfterBacket = 0;
						for(int i=0;i<3;i++)
							Value[i] = 0;
						break;
					case 'A':
						if(DEBUG)System.out.println(" Load Char : A "+Char);
						if(Value[0] == 0)
							Value[0] = 1;
						if((super.Line - Value[0]) < 0)
							super.Line = 0;
						else 
							super.Line -= Value[0];
						super.State = STATUS_DATA;
						ParameterAfterBacket = 0;
						for(int i=0;i<3;i++)
							Value[i] = 0;
						break;
					case 'B':
						if(DEBUG)System.out.println(" Load Char : B "+Char);
						if(Value[0] == 0)
							Value[0]= 1;
						if((super.Line + Value[0]) > (super.Char_Canvas_Height-1))
							super.Line = super.Char_Canvas_Height-1;
						else
							super.Line += Value[0];
						super.State = STATUS_DATA;
						ParameterAfterBacket = 0;
						for(int i=0;i<3;i++)
							Value[i] = 0;
						break;
					case 'C':
						if(DEBUG)System.out.println(" Load Char : C "+Char);
						if(Value[0] == 0)
							Value[0]= 1;
						if((super.Column + Value[0]) > (super.Char_Canvas_Width-1))
							super.Column = super.Char_Canvas_Width-1;
						else
							super.Column += Value[0];
						super.State = STATUS_DATA;
						ParameterAfterBacket = 0;
						for(int i=0;i<3;i++)
							Value[i] = 0;
						break;
					case 'D':
						if(DEBUG)System.out.println(" Load Char : D "+Char);
						if(Value[0] == 0)
							Value[0]= 1;
						if((super.Column - Value[0]) < 0)
							super.Column = 0;
						else
							super.Column -= Value[0];
						super.State = STATUS_DATA;
						ParameterAfterBacket = 0;
						for(int i=0;i<3;i++)
							Value[i] = 0;
						break;
					case 'J':
						if(DEBUG)System.out.println(" Load Char : J* "+Char);
						if(Value[0] == 2)
						{
							super.Line   = 0;
							super.Column = 0;
							super.ClearAll();
						}//if(value[0] = 2)
						else if(Value[0] == 1)
						{
							super.ClearCoordinateAll(0,0,super.Line,super.Column);
						}//if(Value[0] =1)
						else if(Value[0] == 0)
						{
							super.ClearCoordinateAll(super.Line,super.Column,Char_Canvas_Height-1,Char_Canvas_Width-1);
						}//if(Value[0] = 0)
						super.State = STATUS_DATA;
						ParameterAfterBacket = 0;
						for(int i=0;i<3;i++)
							Value[i] = 0;
						break;
					case 'K':
						if(DEBUG)System.out.println(" Load Char : K* "+Char);
						if(Value[0] == 2)
						{
							super.ClearCoordinateAll(super.Line,super.Column,super.Line,Char_Canvas_Width-1);
						}//if(value[0] = 2)
						else if(Value[0] == 1)
						{
							super.ClearCoordinateAll(super.Line,0,super.Line,super.Column);
						}//if(Value[0] =1)
						else if(Value[0] == 0)
						{
							super.ClearCoordinateAll(super.Line,super.Column,super.Line,Char_Canvas_Width-1);
						}//if(Value[0] = 0)
						super.State = STATUS_DATA;
						ParameterAfterBacket = 0;
						for(int i=0;i<3;i++)
						Value[i] = 0;
						break;
					case 'm':
						ChangeAttribute();
						super.State = STATUS_DATA;
						ParameterAfterBacket = 0;
						for(int i=0;i<5;i++)
							Value[i] = 0;
						break;
					case 'r':
						if(DEBUG)System.out.println(" Load Char : r "+Char);
						if(Value[0]  == 0)
							Value[0]  = 1;
						if(Value[1] == 0)
							Value[1]	 = 1;
						ScrollTop    = Value[0] - 1;
						ScrollBottom = Value[1] - 1;
						super.State = STATUS_DATA;
						ParameterAfterBacket = 0;
						for(int i=0;i<3;i++)
							Value[i] = 0;
						break;
					case '?':
						break;
					default:
						if(DEBUG)System.out.println(" VT100_CSI : <ESC> + unknow: "+Char);
						super.State = STATUS_DATA;
						break;
				}//switch(Char) 
				break; //break of STATUS_CSI
			}//case STATUS_CSI
			default:
				if(DEBUG)System.out.println(" VT100 : <ESC> + unknow: "+Char);
				super.State = STATUS_DATA;
				break;//break of State
                       
		}//switch(super.state)
	}//method DisplayChar()
}//public SshTerminal class