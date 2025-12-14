#ifndef _Class_Music_
#define _Class_Music_

#include <windows.h>
#include <mmsystem.h>
#include <stdio.h>

class CMusic
{
private:
	HWND hwnd;

public:
	CMusic(void *hWnd);
	~CMusic();

	BOOL Play(const char *Filename);
	BOOL Stop();
	BOOL Pause();
	BOOL Resume();
	BOOL Restart();
};

#endif