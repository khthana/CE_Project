///////////////////////////////////////////////////////////
//Project Name:	Game developent using DirectX(DirectSound)
//Author:		Tawin Tusnajareon azzuri_man@hotmail.com
//Source File:	Header file 
//version 1.0
///////////////////////////////////////////////////////////
#ifndef DSound
#define DSound

#include <windows.h>
#include <mmsystem.h>
#include <dsound.h>

///////////////////////////////////////////////////////////
//Define types
///////////////////////////////////////////////////////////
#define DO_RELEASE(x) if(x != NULL) {x->Release(); x= NULL;}
#define DO_DELETE(x) if(x != NULL) {delete x; x= NULL;}

///////////////////////////////////////////////////////////
//CSound Class
///////////////////////////////////////////////////////////
class CSound
{
public:
	CSound(void);
	~CSound(void);

	HRESULT CreateSound(void *hwnd);

	LPDIRECTSOUND GetDS(void) {return lpds;}
	LPDIRECTSOUNDBUFFER GetPrimary(void) {return lpdsprimary;}

public:
	LPDIRECTSOUND lpds;//DirectSound interface pointer
	LPDIRECTSOUNDBUFFER lpdsprimary;
};

///////////////////////////////////////////////////////////
//CWaveFile Class
///////////////////////////////////////////////////////////
class CWaveFile
{
public:
	CWaveFile(void);
	~CWaveFile(void);

	BOOL Open(LPSTR pszFilename);
	BOOL Cue(void);
	UINT Read(BYTE* pbDest, UINT cbSize);

	UINT GetNumBytesRemaining(void) { return (m_nDataSize - m_nBytesPlayed); }
	UINT GetAvgDataRate(void)       { return (m_nAvgDataRate); }
	UINT GetDataSize(void)          { return (m_nDataSize); }
	UINT GetNumBytesPlayed(void)    { return (m_nBytesPlayed); }
	UINT GetDuration(void)          { return (m_nDuration); }
	BYTE GetSilenceData(void);

public:
	WAVEFORMATEX* m_pFormat;
	HMMIO m_hmmio;
	MMRESULT m_mmr;
	MMCKINFO m_mmckiRiff;
	MMCKINFO m_mmckiFmt;
	MMCKINFO m_mmckiData;
	UINT m_nDuration;
	UINT m_nBlockAlign;
	UINT m_nAvgDataRate;
	UINT m_nDataSize;
	UINT m_nBytesPlayed;
};

///////////////////////////////////////////////////////////
//CBuffer Class
///////////////////////////////////////////////////////////
class CBuffer
{
public:
	CBuffer(void);
	~CBuffer(void);

	virtual HRESULT Create(CSound* sound, char* filename, int count);

	HRESULT Play(DWORD flags);
	HRESULT Stop(void);
	LPDIRECTSOUNDBUFFER GetFreeBuffer(void);

public:
	int m_BufferCount;
	CWaveFile* m_WaveFile;
	LPDIRECTSOUNDBUFFER *m_Buffer;
};

#endif