// VT100.cpp: implementation of the CVT100 class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SecureShell.h"
#include "VT100.h"
#include "SecureShellView.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
CVT100::CVT100() : CEmulation()
{
    foreground = WHITE;
    background = BLACK;
    row = 0;
    column = 0;

	color[0] = BLACK;
	color[1] = RED;
	color[2] = GREEN;
	color[3] = YELLOW;
	color[4] = BLUE;
	color[5] = MAGENTA;
	color[6] = CYAN;
	color[7] = LIGHTGRAY;
	color[8] = BLACK;
	color[9] = RED;
	color[10] = GREEN;
	color[11] = YELLOW;
	color[12] = BLUE;
	color[13] = MAGENTA;
	color[14] = CYAN;
	/*for (int i = 8; i < 15; i++)
	{
		color[i] = color[i-8].brighter();
	}*/
	color[15] = WHITE;
	currentForeground = 1;
	currentBackground = 15;
	
/*	CharArray = new char[char_w][char_h];
	Foregnd = new Color[char_w][char_h];
	Backgnd = new Color[char_w][char_h];
	cleararray();
*/


	escapeon = false;
	firstchar = false;
	bracket = false;
	ScrollTop = 0;
	ScrollBottom = 24;
	brighthold = false;
	inversehold = false;
	firstchar = false;
	bracket = false;
	bright = false;
	inverse = false;

}

CVT100::~CVT100()
{

}

void CVT100::clearArray()
{
	CSecureShellView *pView = CSecureShellView::GetView();
	for (int i=0;i<char_w;i++)
		for (int j=0;j<char_h;i++)
		{
			pView->CharArray[i][j] = ' ';
			Foregnd[i][j] = foreground;
			Backgnd[i][j] = background;
		}
}

void CVT100::displaybytes(CByteArray* b, int len)
{

	CSecureShellView *pView = CSecureShellView::GetView();
	
	HoldFore = foreground;
	HoldBack = background;
	foreground = Foregnd[column][row];
	background = Backgnd[column][row];
	CEmulation::displaych(pView->CharArray[column][row]);
	foreground = HoldFore;
	background = HoldBack;
// if (true) System.out.println("i got " + String.valueOf(len)+ " chars to show you.");
	int i = 0;
	while( i < len)
	{
       // System.out.println("i got " + String.valueOf(b[i])+" "+ i);
		if (b->GetAt(i) == 255-256)
        {
			i++;
			if (b->GetAt(i) == 250-256)
            {
				while ((i < len) && (b->GetAt(i) != 240-256))
					i++;
				i++;
            }
			else
			{
				i+=2;
            }

		}
        else
		{
			if (b->GetAt(i) < 0)
				displaych((char)(((char)b->GetAt(i)) + 256));
			else
				displaych((char)b->GetAt(i));
			i++;
		}
	}
//	pView->drawForeground('_',column*7,row+1*18,(row+1)*10,20, foreground);

	//CSecureShellView *pView = CSecureShellView::GetView();
//	pView->drawForeground('_',column*7,row+1*18,(row+1)*10,20, foreground);

//	pView->drawForegnd("_",column*
//	owner.bgr.setColor(Foregnd[column][row].brighter());
//	owner.bgr.drawString("_", column*owner.chw, (row+1)*owner.chh-owner.chd);

}

void CVT100::displaych(char c)
{
     // System.out.println("char = "+String.valueOf((int)c) + " " + String.valueOf((char)c));
	if (escapeon)
	{
        translate(c);
        return;
	}
	if (c == 27)
	{
		escapeon = true;
        Parameter = 0;
        Value[0] = 0;
        Value[1] = 0;  // cases of [H with no parameters
        Value[2] = 0;
        bracket = false;
        firstchar = true;
        return;
	}
	else if (c == 0x0a) {
        // Linefeed
        if (row == char_h-1) {
			scrollup(0,char_h-1);
		}
        else
			if (row == ScrollBottom)
			{
				scrollup(ScrollTop, ScrollBottom);
			}
			else
				row++;
			}
			else if (c == 0x0d) {
	        // Carriage Return
				column = 0;
			}
			else if (c == '\t') {
				// Tab
				int coltemp = column;
				for ( int i = 8 ; i > coltemp%8; i--)
				{
					displaych(' ');
				}
			}
			else if (c == (char)8 ) {
				// Backspace
				if (column != 0) column--;
			}
			else if (c >= 32 && c < 255) {
				// Some printable character
				CEmulation::displaych(c);
				CharArray[column][row] = c;
				Foregnd[column][row] = foreground;
				Backgnd[column][row] = background;
				if (column == char_w - 1)
				{
					displaych((char)0x0a);
					displaych((char)0x0d);
				}
				else
					column++;
			}
}


void CVT100::translate(char c)
{
	if (c == '[') 
	{
		bracket = true;
        return;
	}
	if ((c >='0') && (c <= '9')) 
	{
		if (bracket)
		{
			Value[Parameter] *= 10;
			Value[Parameter] += c - 0x30;
			firstchar = false;
			return;
		}
	escapeon = false;
	switch (c) 
	{
		case '7' : // store cursor position
			columnhold = column;
			rowhold = row;
			brighthold = bright;
			inversehold = inverse;
			Foresave = foreground;
			Backsave = background;
			break;

		case '8': // restore cursor position
			column = columnhold;
			row = rowhold;
			bright     = brighthold;
			inverse    = inversehold;
			foreground = Foresave;
			background = Backsave;
			break;
	}
	return;
	}

	switch (c) {
        case '?':  break; // Ignore VT100 '?1l' and '?1h'

		case ';':
			Parameter++;
			Value[Parameter] = 0;
			break;

		case 'A':
			escapeon = false;
			if (Value[0] == 0)
				Value[0] = 1;
			if (row - Value[0] < 0)
				row = 0;
			else
				row -= Value[0];
			break;

		case 'B':
			escapeon = false;
			if (Value[0] == 0)
				Value[0] = 1;
			if (row + Value[0] > char_h - 1)
				row = char_h - 1;
			else
				row += Value[0];
			break;

        case 'C':
			escapeon = false;
			if (Value[0] == 0)
				Value[0] = 1;
			if (column + Value[0] > char_w - 1)
				column = char_w - 1;
			else
				column += Value[0];
			break;

		case 'D':
			escapeon = false;
			if (Value[0] == 0)
				Value[0] = 1;
			if (column - Value[0] < 0)
				column = 0;
			else
				column -= Value[0];
			break;

		case 'f':

        case 'H':
           escapeon = false;
		   if (Value[0] == 0)
			   Value[0] = 1;
		   if (Value[1] == 0)
			   Value[1] = 1;
		   if (Value[0] > char_h)
			   row = char_h - 1;
		   else
			   row = Value[0] - 1;
		   if (Value[1] > char_w)
			   column = char_w - 1;
		   else
			   column = Value[1] - 1;
		   break;

		case 'J':
			escapeon = false;
			if (Value[0] == 2)
			{
				column = 0;
				row = 0;
			}
			if ((column == 0) && (row == 0))
			{
				clearscreen();
				break;
			}
			if (Value[0] == 0)
			{
				clearcoord(row,column,char_h-1,char_w - 1);
				break;
			}
			if (Value[0] == 1)
			{
				clearcoord(0,0,row,column);
				break;
			}
			break;

		case 'K':
			escapeon = false;
			if (Value[0] == 0)
			{
				clearcoord(row,column,row,char_w - 1);
				break;
			}
			if (Value[0] == 1)
			{
				clearcoord(row,0,row,column);
				break;
			}
			if (Value[0] == 2)
			{
				clearcoord(row,0,row,char_w - 1);
				break;
			}

		case 'm':
			escapeon = false;
			changecolor();
			break;

        case 'r':
			escapeon = false;
			if (Value[0] == 0)
				Value[0] = 1;
			if (Value[1] == 0)
				Value[1] = 1;

			ScrollTop = Value[0] - 1;
			ScrollBottom = Value[1] - 1;
			break;
		default :
			// System.out.println("Unhandled ESC char = "+String.valueOf((int)c) + " " + String.valueOf((char)c));
			escapeon = false;
			break;

}
firstchar = false;

}

void CVT100::scrollup(int top, int bottom)
{
	CSecureShellView *pView = CSecureShellView::GetView();
/*	for (int i = 0; i < char_w; i++)
	{
		CharArray[i][bottom] = ' ';
		Foregnd[i][bottom] = foreground;
		Backgnd[i][bottom] = background;
	}
*/
	for (int j=1;j<char_h;j++)
		for (int i = 0;i<char_w;i++)	
		{
			pView->CharArray[i][j-1] = pView->CharArray[i][j];
//			Foregnd[i][bottom] = foreground;
//			Backgnd[i][bottom] = background;
		}	
	for (int i=0;i<char_w;i++)
		pView->CharArray[i][char_h-1] = ' ';

	CEmulation::scrollup(top, bottom);
}

void CVT100::clearscreen()
{
	row = 0;
	column = 0;
	cleararray();
	CEmulation::clearscreen();
}

void CVT100::clearcoord(int row1, int col1, int row2, int col2)
{
	int i,j;
	CSecureShellView *pView = CSecureShellView::GetView();

	CEmulation::clearcoord(row1,col1,row2,col2);

	if ( row1 == row2) {
		for (i = col1;i <= col2;i++)
		{

			pView->CharArray[i][row1] = ' ';
			Foregnd[i][row1] = foreground;
			Backgnd[i][row1] = background;
		}
		return;
	}
	for (i = col1; i < char_w; i++)
	{
		pView->CharArray[i][row1] = ' ';
		Foregnd[i][row1] = foreground;
		Backgnd[i][row1] = background;
	}
	for (j = row1+1; i < row2; i++)
	{  
		for (i = 0; i < char_w - 1; i++)
		{
			pView->CharArray[i][j] = ' ';
			Foregnd[i][j] = foreground;
			Backgnd[i][j] = background;
		}

	}


	for (i = 0; i <= col2; i++)
	{
		pView->CharArray[i][row2] = ' ';
        Foregnd[i][row2] = foreground;
        Backgnd[i][row2] = background;
	}
}

void CVT100::cleararray()
{
	CSecureShellView *pView = CSecureShellView::GetView();
	for (int i = 0; i < char_w; i++)
		for (int j = 0; j < char_h; j++)
		{
			pView->CharArray[i][j] = ' ';
			Foregnd[i][j] = foreground;
			Backgnd[i][j] = background;
		}
}

void CVT100::changecolor()
{
	for (int i = 0; i <= Parameter; i++)
	{
		if (Value[i] >= 40)
		{
			currentBackground = Value[i] - 40;
			background = color[currentBackground];
		}
		else if (Value[i] >= 30)
		{
			currentForeground = Value[i] - 30;
			if ( bright )
				foreground = color[currentForeground + 8];
			else
				foreground = color[currentForeground];
		}
		else
			switch (Value[i])
		{
			case 0:
				currentForeground = 7;
				currentBackground = 0;
				foreground = color[currentForeground];
				background = color[currentBackground];
				bright = false;
				inverse = false;
				break;

			case 1:
				bright = true;
				foreground = color[currentForeground + 8 ];
				break;

			case 7:
				inverse = true; 
				foreground = color[currentBackground];
				background = color[currentForeground];
				break;

			case 22:
				bright = false;
				foreground = color[currentForeground];
				break;

			case 27:
				background = color[currentBackground];
				inverse = false;
				if (bright)
					foreground = color[currentForeground+8];
				else   
					foreground = color[currentForeground];

				break;

		}

	}

}
