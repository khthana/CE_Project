#ifndef _Bubble_DirectSound_
#define _Bubble_DirectSound_

#include <windows.h>
#include "cds.h"

#define MAX_CHANNEL		ds_NUMCHANNELS

enum ENUM_SOUND {
	TURNKEY_SOUND,
	MOVEKEY_SOUND,	
	BLOCKED_SOUND,
	FALL_SOUND,
	BOMB_SOUND
};

#define TURNKEY_SOUND_FILE	"turn.wav"
#define MOVEKEY_SOUND_FILE	"move.wav"
#define BLOCKED_SOUND_FILE	"block.wav"
#define FALL_SOUND_FILE		"fall.wav"
#define BOMB_SOUND_FILE		"bomb.wav"

class CBubbleDS
{
private:
	CDS		*lpDS;

	HRESULT init_value; // initial DirectSound last result
	
	WORD	channel[MAX_CHANNEL];

	void init_var();

public:
	CBubbleDS(HWND _hwnd);
	~CBubbleDS();

	void play(ENUM_SOUND _sound);
};

#endif