#include <string.h>
#include "text.h"

/****************************************************************************
 * constructor
 ****************************************************************************/
CWinTextMode::CWinTextMode(HWND _hwnd, int _linelimit)
{
	hwnd = _hwnd;
	line_limit = _linelimit;

	clrline();
}

/****************************************************************************
 * destructor
 ****************************************************************************/
CWinTextMode::~CWinTextMode()
{
}

/****************************************************************************
 * clear screen 
 ****************************************************************************/
void CWinTextMode::clrline()
{
	for( int i = 0; i < MAX_LINE; i++ )
		szLine[i][0] = 0;
	curr_line = 0;
}

/****************************************************************************
 * lineup move line buffer up one line
 ****************************************************************************/
void CWinTextMode::lineup(int _line)
{
	for( int l = 0; l < _line; l++ )
		for( int i = 0; i < line_limit-1; i++ )
		{
			strcpy(szLine[i],szLine[i+1]);
		}
}

/****************************************************************************
 * check line not more than MAX_LINE
 ****************************************************************************/
char * CWinTextMode::line(int _line)
{
	if( (_line >= 0)&&(_line < MAX_LINE) )
	{
		return szLine[_line];
	}
	else 
	{
		if( curr_line == line_limit )
		{
			lineup();
			szLine[line_limit-1][0] = 0;

			return szLine[line_limit-1];	// last line
		}
		else
		{
			szLine[curr_line][0] = 0;
			return szLine[curr_line++];
		}
	}
}

/****************************************************************************
 * print screen with szLine
 ****************************************************************************/
void CWinTextMode::printscr()
{
	hdc = BeginPaint(hwnd, &ps);

	if( hdc ) 
	{
		// clear screen
		ExtTextOut(hdc, 0, 0, ETO_OPAQUE, &ps.rcPaint, "", 0, NULL);

		for( int i = 0; i < MAX_LINE; i++ )
		{
			TextOut(hdc, 0, i*CHAR_HEIGHT, szLine[i], strlen(szLine[i]));
		}

		EndPaint(hwnd, &ps);
	}
}

