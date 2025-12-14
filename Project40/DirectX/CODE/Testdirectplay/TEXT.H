#ifndef _WIN_TEXT_MODE_
#define _WIN_TEXT_MODE_

#include <windows.h>

#define CHAR_HEIGHT			20
#define MAX_LINE			20
#define MAX_LINE_LENGTH		132

class CWinTextMode
{
private:
	HWND		hwnd;
	PAINTSTRUCT ps;
	HDC			hdc;

	char	szLine[MAX_LINE][MAX_LINE_LENGTH];
	int		line_limit;
	int		curr_line;

public:
	CWinTextMode(HWND _hwnd, int _linelimit = MAX_LINE);
	~CWinTextMode();

	void clrline();
	void lineup(int _line = 1);
	char * line(int _line = -1);
	void printscr();
};

#endif