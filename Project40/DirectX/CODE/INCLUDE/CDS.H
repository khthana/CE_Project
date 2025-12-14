//
// CDS.H
// Class DirectSound
//

#ifndef _CDS_H_
#define _CDS_H_

#include <windows.h>
#include <mmsystem.h>
#include <dsound.h>

#define ds_NUMCHANNELS		16

class CDS
{
private:
	/*----- Data -----*/
	LPDIRECTSOUND			lpds;

	BYTE					*sound[ds_NUMCHANNELS];
	DWORD					len[ds_NUMCHANNELS];
	LPDIRECTSOUNDBUFFER		lpdsb[ds_NUMCHANNELS];

	/*----- Methode -----*/
	WORD AllocChannel(void);
	HRESULT CreateBuffer(WORD channel, WAVEFORMATEX & wfmtx);
	HRESULT FillBuffer(WORD channel);

public:
	CDS(HWND _hwnd);
	~CDS();

	WORD LoadWave(char *filename);	// return channel number
	void UnLoadWave(WORD channel);

	HRESULT Start(WORD channel, BOOL looping);
	void Stop(WORD channel);
};

#endif
