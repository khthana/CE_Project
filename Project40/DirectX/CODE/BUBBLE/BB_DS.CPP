#include "bb_ds.h"

/*********************************************** 
 *
 * init_var() // initial all variable before use
 *
 ***********************************************/
void CBubbleDS::init_var()
{
	lpDS = NULL;

	init_value = NULL;

	for(int i = 0; i < MAX_CHANNEL; i++ )
		channel[i] = MAX_CHANNEL;
}

/*********************************************** 
 *
 * CBubbleDS() // constructor for DirectSound
 *
 ***********************************************/
CBubbleDS::CBubbleDS(HWND _hwnd)
{
	init_var();

	lpDS = new CDS(_hwnd);
	if( lpDS == NULL )
	{
		init_value = DSERR_GENERIC;
		return;
	}

	channel[TURNKEY_SOUND]	= lpDS->LoadWave(TURNKEY_SOUND_FILE);
	channel[MOVEKEY_SOUND]	= lpDS->LoadWave(MOVEKEY_SOUND_FILE);
	channel[BLOCKED_SOUND]	= lpDS->LoadWave(BLOCKED_SOUND_FILE);
	channel[FALL_SOUND]		= lpDS->LoadWave(FALL_SOUND_FILE);
	channel[BOMB_SOUND]		= lpDS->LoadWave(BOMB_SOUND_FILE);
}

/*********************************************** 
 *
 * ~CBubbleDS() // Destroy all DirectSound relate
 *
 ***********************************************/
CBubbleDS::~CBubbleDS()
{
	delete lpDS;
}

/*********************************************** 
 *
 * play() // play that sound 
 *
 ***********************************************/
void CBubbleDS::play(ENUM_SOUND _sound)
{
	if( (lpDS != NULL)&&(_sound >= 0)&&(_sound<MAX_CHANNEL) )
	{
		if( (channel[_sound] >= 0)&&(channel[_sound] < MAX_CHANNEL) )
		{
			lpDS->Stop(channel[_sound]);
			lpDS->Start(channel[_sound], FALSE);
		}
	}
}

