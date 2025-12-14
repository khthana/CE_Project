//////////////////////////////////////////////////////////////////////////////////
// Project Name:   [ CDX Class Library - CDX.lib ]
// Source File:    [ CDXAvi Implementation ]
// Author:         [ Gert Wollny ]
// Contributions:  [ Danny Farley, Patrick Feuser ]
// Revision:       [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXAvi::CDXAvi(void)
{
	m_lpDDS = NULL;
	m_AviStream = NULL;
	ZeroMemory(&m_StreamInfo, sizeof(m_StreamInfo));
	m_Index = 0;
	m_nFrames = 0;
	m_Decompressor = 0;
	m_Input = m_Output = 0;

	m_AviSound = NULL;
	ZeroMemory(&m_SoundInfo, sizeof(m_SoundInfo));
	m_SoundFormat = 0;
	m_SoundBuffer = NULL;
	m_LoadPos = 0;
	m_LoadSize = 0;
	m_SoundFramesAhead = 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi Destructor
//////////////////////////////////////////////////////////////////////////////////
CDXAvi::~CDXAvi(void)
{
	DeleteCriticalSection(&m_AccessBuffer);

	if(m_Decompressor)
	{
		ICDecompressEnd(m_Decompressor);
		ICClose(m_Decompressor);
	}
	
	if(m_InputFormat) free(m_InputFormat);
	if(m_TargetFormat) free(m_TargetFormat);
	if(m_Input) free(m_Input);
	if(m_Output) free(m_Output);

	AVIStreamRelease(m_AviStream);
	AVIFileExit();

  if(m_SoundFormat) free(m_SoundFormat);
	if(m_SoundBuffer) m_SoundBuffer->Release();
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi Create
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXAvi::Create(CDXScreen* pScreen, CDXSound* pSound, const char* Filename, BOOL bLoop)
{
	if(Filename == NULL) return FALSE;
	AVIFileInit();
	m_bLoop = bLoop;

	if(AVIStreamOpenFromFile(&m_AviStream, Filename, streamtypeVIDEO , 0, OF_READ,NULL) != 0)
	{
		AVIFileExit();
		return FALSE;
	}

	LONG FmtLenght;

	AVIStreamFormatSize(m_AviStream, 0, &FmtLenght);
	m_InputFormat = (LPBITMAPINFOHEADER)malloc(FmtLenght);
	m_TargetFormat = (LPBITMAPV4HEADER)malloc(max(FmtLenght, sizeof(BITMAPV4HEADER)));
	ZeroMemory(m_TargetFormat, sizeof(BITMAPV4HEADER));
	AVIStreamReadFormat(m_AviStream, 0, m_InputFormat, &FmtLenght);
	m_nFrames = AVIStreamLength(m_AviStream);
	AVIStreamInfo(m_AviStream, &m_StreamInfo, sizeof(AVISTREAMINFO));

	HRESULT rval;

	ZeroMemory(&m_DDSD, sizeof(m_DDSD));
	m_DDSD.dwSize = sizeof(m_DDSD);
	m_DDSD.dwFlags = DDSD_CAPS | DDSD_HEIGHT |DDSD_WIDTH;
	m_DDSD.ddsCaps.dwCaps = DDSCAPS_TEXTURE | DDSCAPS_SYSTEMMEMORY;
	m_DDSD.dwWidth = m_InputFormat->biWidth;
	m_DDSD.dwHeight = m_InputFormat->biHeight;

	rval = pScreen->m_lpDD->CreateSurface(&m_DDSD, &m_lpDDS, NULL);
	if(rval != DD_OK)
	{
		AVIFileExit();
		DDError(rval, pScreen->m_hWnd);
		return FALSE;
	}

	m_lpDDS->GetSurfaceDesc(&m_DDSD);

	memcpy(m_TargetFormat, m_InputFormat, FmtLenght);

	m_TargetFormat->bV4Size = max(FmtLenght, sizeof(BITMAPV4HEADER));
	m_TargetFormat->bV4BitCount = m_DDSD.ddpfPixelFormat.dwRGBBitCount;
	m_TargetFormat->bV4V4Compression = BI_BITFIELDS;
	
	if(m_TargetFormat->bV4BitCount==24) m_TargetFormat->bV4V4Compression = BI_RGB;

	m_TargetFormat->bV4ClrUsed = 0;
	m_TargetFormat->bV4RedMask = m_DDSD.ddpfPixelFormat.dwRBitMask;
	m_TargetFormat->bV4GreenMask = m_DDSD.ddpfPixelFormat.dwGBitMask;
	m_TargetFormat->bV4BlueMask  = m_DDSD.ddpfPixelFormat.dwBBitMask;
	m_TargetFormat->bV4AlphaMask = m_DDSD.ddpfPixelFormat.dwRGBAlphaBitMask;
	m_TargetFormat->bV4SizeImage = ((m_TargetFormat->bV4Width +3)&0xFFFFFFFC) *
																	 m_TargetFormat->bV4Height * (m_TargetFormat->bV4BitCount>>3);

	m_Length = m_InputFormat->biWidth * m_InputFormat->biHeight *	(m_InputFormat->biBitCount >> 3);

	if(m_StreamInfo.dwSuggestedBufferSize) m_Length = (LONG)m_StreamInfo.dwSuggestedBufferSize;

	m_Decompressor = ICDecompressOpen(ICTYPE_VIDEO,	m_StreamInfo.fccHandler, m_InputFormat,
																	 (LPBITMAPINFOHEADER)m_TargetFormat);

	m_Input = (BYTE *)calloc(m_Length, 1);
	ZeroMemory(m_Input, m_Length);
	m_Output = (BYTE *)calloc(m_TargetFormat->bV4SizeImage, 1);
	ZeroMemory(m_Output, m_TargetFormat->bV4SizeImage);

	if(!m_Decompressor) return FALSE;

	m_LinePitch = m_TargetFormat->bV4Width *
								(m_TargetFormat->bV4BitCount >> 3);
	
	ICDecompressBegin(m_Decompressor, m_InputFormat,
									 (LPBITMAPINFOHEADER)m_TargetFormat);
	
	m_Fps = m_StreamInfo.dwRate / m_StreamInfo.dwScale;
	
	m_TimeTick = (1000 * m_StreamInfo.dwScale +
							 (m_StreamInfo.dwRate >> 1)) / m_StreamInfo.dwRate;

	SrcRect.top = 0;
	SrcRect.left = 0;
	SrcRect.bottom = m_TargetFormat->bV4Height;
	SrcRect.right = m_TargetFormat->bV4Width;

	InitializeCriticalSection(&m_AccessBuffer);

	if(AVIStreamOpenFromFile(&m_AviSound, Filename, streamtypeAUDIO , 0, OF_READ, NULL) != 0)
	{
		AVIFileExit();
		return FALSE;
	}

	DSBUFFERDESC dsbd;

	AVIStreamFormatSize(m_AviSound, 0, &FmtLenght);
	m_SoundFormat = (WAVEFORMATEX *)malloc(FmtLenght);

	AVIStreamReadFormat(m_AviSound, 0, m_SoundFormat, &FmtLenght);
	AVIStreamInfo(m_AviSound, &m_SoundInfo, sizeof(AVISTREAMINFO));

	m_LoadSize = (m_SoundFormat->nAvgBytesPerSec + m_Fps - 1 ) / m_Fps;

	dsbd.dwSize = sizeof(dsbd);
	dsbd.dwFlags = 0;
	dsbd.dwBufferBytes = m_LoadSize * m_Fps;
	dsbd.dwReserved = 0;
	dsbd.lpwfxFormat = m_SoundFormat;

	if(pSound->m_lpDS->CreateSoundBuffer(&dsbd, &m_SoundBuffer, NULL) != DS_OK)
	{
		AVIFileExit();
		return FALSE;
	}

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi GetFrameTimer
//////////////////////////////////////////////////////////////////////////////////
void CALLBACK GetFrameTimer(UINT, UINT, DWORD AviSurface, DWORD, DWORD)
{
	((CDXAvi*)AviSurface)->NextFrame();
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi Start
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXAvi::Start(void)
{
	if(!GetSound()) return FALSE;

	m_TimerID = timeSetEvent(m_TimeTick, 5, GetFrameTimer,
													(ULONG)this, TIME_PERIODIC);
	m_bPlaying = (m_TimerID != NULL);
	CDXAvi::ReadFrame(0);

	m_SoundFramesAhead = m_SoundInfo.dwInitialFrames / m_SoundInfo.dwScale;
	if(m_SoundBuffer->Play(0, 0, DSBPLAY_LOOPING) != DS_OK) return FALSE;

	return m_bPlaying;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi Stop
//////////////////////////////////////////////////////////////////////////////////
void CDXAvi::Stop(void)
{
	Sleep(30);
	m_SoundBuffer->Stop();
	m_bPlaying = FALSE;
	timeKillEvent(m_TimerID);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi NextFrame
//////////////////////////////////////////////////////////////////////////////////
void CDXAvi::NextFrame(void)
{
	GetSound();
	m_Index++;

	if(m_Index == m_nFrames)
	{
		timeKillEvent(m_TimerID);
		Sleep(m_TimeTick);
		m_SoundBuffer->Stop();

		if(m_bLoop)
		{
			m_TimerID = timeSetEvent(m_TimeTick, 5, GetFrameTimer,
															(ULONG)this, TIME_PERIODIC);
			m_Index = 0;
			m_LoadPos = 0;
			m_SoundBuffer->SetCurrentPosition(0);
			GetSound();
			m_SoundBuffer->Play(0, 0, DSBPLAY_LOOPING);
		}
	}

	ReadFrame(m_Index);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi ReadFrame
//////////////////////////////////////////////////////////////////////////////////
void CDXAvi::ReadFrame(LONG Frame)
{
	Frame -= m_SoundFramesAhead;

	if(Frame < 0) return;
	if(Frame < m_nFrames)
	{
		AVIStreamRead(m_AviStream, Frame, 1, m_Input, m_Length, NULL, NULL);
		EnterCriticalSection(&m_AccessBuffer);
		ICDecompress(m_Decompressor, 0, m_InputFormat, m_Input,
								(LPBITMAPINFOHEADER)m_TargetFormat, m_Output);
		LeaveCriticalSection(&m_AccessBuffer);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi GetSound
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXAvi::GetSound(void)
{
	HRESULT rval;
	DWORD dwSize1, dwSize2;
	LPVOID Data1, Data2;

	rval = m_SoundBuffer->Lock(m_LoadPos * m_LoadSize, m_LoadSize,
														 &Data1, &dwSize1, &Data2, &dwSize2, 0);
	if(rval != DS_OK)	return FALSE;

	AVIStreamRead(m_AviSound, m_Index * m_LoadSize >> 1,
								m_LoadSize >> 1, Data1, m_LoadSize, NULL, NULL);

	rval = m_SoundBuffer->Unlock(Data1, dwSize1, Data2, dwSize2);

	m_LoadPos++;
	m_LoadPos %= m_Fps;

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi DrawBuffer
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXAvi::DrawBuffer(void)
{
	HRESULT rval;

	rval = CDXSurface::Lock();
	if(rval != DD_OK) return rval;

	LPBYTE lpSource = m_Output + m_LinePitch * (m_TargetFormat->bV4Height - 1);
	LPBYTE lpDest = (LPBYTE)m_DDSD.lpSurface;

	if(rval == DD_OK)
	{
		EnterCriticalSection(&m_AccessBuffer);
		for(int i = 0; i < (int)m_TargetFormat->bV4Height; i++)
		{
			memcpy(lpDest, lpSource, m_LinePitch);
			lpDest += m_DDSD.lPitch;
			lpSource -= m_LinePitch;
		}
		LeaveCriticalSection(&m_AccessBuffer);
		rval = CDXSurface::UnLock();
		if(rval != DD_OK) return rval;
	}

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi DrawBuffer
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXAvi::Draw(CDXSurface* Dest)
{
	HRESULT rval;

	rval = CDXAvi::DrawBuffer();
	if(rval != DD_OK) return rval;

  rval = Dest->m_lpDDS->Blt(&DestRect, m_lpDDS, &SrcRect, DDBLT_WAIT, NULL);
	if(rval == DDERR_SURFACELOST) Restore();

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXAvi DrawBuffer
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXAvi::DrawFast(int X, int Y, CDXSurface* Dest)
{
	HRESULT rval;

	rval = CDXAvi::DrawBuffer();
	if(rval != DD_OK) return rval;

	rval = Dest->m_lpDDS->BltFast(X, Y, m_lpDDS, &SrcRect, DDBLTFAST_WAIT);
	if(rval == DDERR_SURFACELOST) Restore();

	return rval;
}
