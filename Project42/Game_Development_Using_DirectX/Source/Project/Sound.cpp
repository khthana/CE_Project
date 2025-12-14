///////////////////////////////////////////////////////////
//Project Name:	Game developent using DirectX(DirectSound)
//Author:		Tawin Tusnajareon azzuri_man@hotmail.com
//Source File:	Sound.cpp file Implementation
//version 1.0
///////////////////////////////////////////////////////////
#include "DSound.h"

///////////////////////////////////////////////////////////
//CSound Constructor
///////////////////////////////////////////////////////////
CSound::CSound()
{
	lpdsprimary = NULL;
	lpds = NULL;
}

///////////////////////////////////////////////////////////
//CSound Destructor
///////////////////////////////////////////////////////////
CSound::~CSound()
{
	DO_RELEASE(lpdsprimary);
	DO_RELEASE(lpds);
}

///////////////////////////////////////////////////////////
//CSound CreateSound
///////////////////////////////////////////////////////////
HRESULT CSound::CreateSound(void *hwnd)
{
	HRESULT rval;
	DSBUFFERDESC dsbd;//DirectSound buffer description

	rval = DirectSoundCreate(NULL, &lpds, NULL);//Create a DirectSound object
	if(rval != DS_OK) return rval;
	
	rval = lpds -> SetCooperativeLevel((HWND) hwnd, DSSCL_EXCLUSIVE);//Set CooperativeLevel
	if(rval != DS_OK) return rval;

	memset(&dsbd, 0, sizeof(DSBUFFERDESC));
	dsbd.dwSize = sizeof(DSBUFFERDESC);
	dsbd.dwFlags = DSBCAPS_PRIMARYBUFFER;

	//Create primary buffer
	rval = lpds -> CreateSoundBuffer(&dsbd, &lpdsprimary, NULL);
	if(rval != DS_OK) return rval;

	return rval;
}



