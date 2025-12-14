#include "c_music.h"

/*********************************************** 
 *
 * CMusic // constructor
 *
 ***********************************************/
CMusic::CMusic(HWND _hwnd)
{
	hwnd = _hwnd;
}

/*********************************************** 
 *
 * ~CMusic // destructor
 *
 ***********************************************/
CMusic::~CMusic()
{
	mciSendString("close all", NULL, 0, NULL);
}

/*********************************************** 
 *
 * Play // play music
 *
 ***********************************************/
BOOL CMusic::Play(const char *Filename)
{
	if(Filename == NULL) return FALSE;
	char buffer[256];

	sprintf(buffer, "open %s type sequencer alias MUSIC", Filename);

	if (mciSendString("close all", NULL, 0, NULL) != 0)
	{
		return(FALSE);
	}

	if (mciSendString(buffer, NULL, 0, NULL) != 0)
	{
		return(FALSE);
	}

	if (mciSendString("play MUSIC from 0 notify", NULL, 0, hwnd) != 0)
	{
		return(FALSE);
	}

	return TRUE;
}

/*********************************************** 
 *
 * Stop // stop playing music
 *
 ***********************************************/
CMusic::Stop()
{
	if (mciSendString("close all", NULL, 0, NULL) != 0)
	{
		return(FALSE);
	}   

	return TRUE;
}

/*********************************************** 
 *
 * Pause // pause playing music
 *
 ***********************************************/
BOOL CMusic::Pause()
{
	// Pause if we're not already paused
	if (mciSendString("stop MUSIC", NULL, 0, NULL) != 0)
	{
		return(FALSE);
	}

	return TRUE;
}

/*********************************************** 
 *
 * Resume // resume play music
 *
 ***********************************************/
BOOL CMusic::Resume()
{
	// resume 
	if (mciSendString("play MUSIC notify", NULL, 0, hwnd) != 0)
	{
		return(FALSE);
	}

	return TRUE;
}

/*********************************************** 
 *
 * Restart // restart play music
 *
 ***********************************************/
BOOL CMusic::Restart()
{
	// replay music
	if (mciSendString("play MUSIC from 0 notify", NULL, 0, hwnd) != 0)
	{
		return(FALSE);
	}

	return TRUE;
}
