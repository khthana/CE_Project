//////////////////////////////////////////////////////////////////////////////////
// Project Name: [ CDX Class Library - CDX.lib ]
// Source File:  [ CDXSoundBuffer Implementation ]
// Author:       [ Danny Farley - danny@jags.co.uk ]
// Revision:     [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"

struct Waveheader
{
	BYTE        RIFF[4];          // "RIFF"
	DWORD       dwSize;           // Size of data to follow
	BYTE        WAVE[4];          // "WAVE"
	BYTE        fmt_[4];          // "fmt "
	DWORD       dw16;             // 16
	WORD        wOne_0;           // 1
	WORD        wChnls;           // Number of Channels
	DWORD       dwSRate;          // Sample Rate
	DWORD       BytesPerSec;      // Sample Rate
	WORD        wBlkAlign;        // 1
	WORD        BitsPerSample;    // Sample size
	BYTE        DATA[4];          // "DATA"
	DWORD       dwDSize;          // Number of Samples
};

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXSoundBuffer::CDXSoundBuffer()
{
	m_pDS = NULL;
	m_lpDSB[0] = NULL;
	m_Current = 0;
	m_nBuffers = 1;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer Destructor
//////////////////////////////////////////////////////////////////////////////////
CDXSoundBuffer::~CDXSoundBuffer()
{
	for(int i = 0; i < m_nBuffers; i++) RELEASE(m_lpDSB[i]);
	m_pDS = NULL;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer CreateSoundBuffer
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSoundBuffer::CreateSoundBuffer(DWORD dwBufSize, DWORD dwFreq, DWORD dwBitsPerSample, DWORD dwBlkAlign, BOOL bStereo)
{
	PCMWAVEFORMAT pcmwf;
	DSBUFFERDESC dsbdesc;

	// Set up wave format structure.
	memset(&pcmwf, 0, sizeof(PCMWAVEFORMAT));
	pcmwf.wf.wFormatTag         = WAVE_FORMAT_PCM;      
	pcmwf.wf.nChannels          = bStereo ? 2 : 1;
	pcmwf.wf.nSamplesPerSec     = dwFreq;
	pcmwf.wf.nBlockAlign        = (WORD)dwBlkAlign;
	pcmwf.wf.nAvgBytesPerSec    = pcmwf.wf.nSamplesPerSec * pcmwf.wf.nBlockAlign;
	pcmwf.wBitsPerSample        = (WORD)dwBitsPerSample;

	// Set up DSBUFFERDESC structure.
	memset(&dsbdesc, 0, sizeof(DSBUFFERDESC));
	dsbdesc.dwSize              = sizeof(DSBUFFERDESC);
	dsbdesc.dwFlags             = DSBCAPS_STATIC | DSBCAPS_CTRLDEFAULT | DSBCAPS_GETCURRENTPOSITION2;
	dsbdesc.dwBufferBytes       = dwBufSize; 
	dsbdesc.lpwfxFormat         = (LPWAVEFORMATEX)&pcmwf;

	m_pDS->m_lpDS->CreateSoundBuffer(&dsbdesc, &m_lpDSB[0], NULL);

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer ReadData
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSoundBuffer::ReadData(FILE* fp, DWORD dwSize, DWORD dwPos)
{
	// Seek to correct position in file (if necessary)
	if (dwPos != 0xffffffff) 
	{
		if (fseek(fp, dwPos, SEEK_SET) != 0) return FALSE;
	}

	// Lock data in buffer for writing
	LPVOID pData1;
	DWORD  dwData1Size;
	LPVOID pData2;
	DWORD  dwData2Size;
	HRESULT rval;

	rval = m_lpDSB[0]->Lock(0, dwSize, &pData1, &dwData1Size, &pData2, &dwData2Size, DSBLOCK_FROMWRITECURSOR);
	if (rval != DS_OK)
	{
		return FALSE;
	}

	// Read in first chunk of data
	if (dwData1Size > 0) 
	{
		if (fread(pData1, dwData1Size, 1, fp) != 1) 
		{          
			char holder[256];
			wsprintf(holder, "Data1 : %d, dwdata: %d, fp: %d", pData1, dwData1Size, fp);
			OutputDebugString(holder);
			return FALSE;
		}
	}

	// Read in second chunk if necessary
	if (dwData2Size > 0) 
	{
		if (fread(pData2, dwData2Size, 1, fp) != 1) 
		{
			return FALSE;
		}
	}

	// Unlock data in buffer
	rval = m_lpDSB[0]->Unlock(pData1, dwData1Size, pData2, dwData2Size);
	if (rval != DS_OK) return FALSE;

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer GetFreeBuffer
//////////////////////////////////////////////////////////////////////////////////
LPDIRECTSOUNDBUFFER CDXSoundBuffer::GetFreeBuffer(void)
{
	DWORD Status;
	HRESULT rval;
	LPDIRECTSOUNDBUFFER Buffer;

	if(m_lpDSB == NULL) return NULL;

	if(Buffer = m_lpDSB[m_Current])
	{
		rval = Buffer->GetStatus(&Status);
		if(rval < 0) Status = 0;

		if((Status & DSBSTATUS_PLAYING) == DSBSTATUS_PLAYING)
		{
			if(m_nBuffers > 1)
			{
				if (++m_Current >= m_nBuffers) m_Current = 0;
				
				Buffer = m_lpDSB[m_Current];
				rval = Buffer->GetStatus(&Status);

				if((rval >= 0) && (Status & DSBSTATUS_PLAYING) == DSBSTATUS_PLAYING)
				{
					Buffer->Stop();
					Buffer->SetCurrentPosition(0);
				}
			}
			else
			{
				Buffer = NULL;
			}
		}

		if(Buffer && (Status & DSBSTATUS_BUFFERLOST))
		{
			if((Buffer->Restore() < 0))
			{
				Buffer = NULL;
			}
		}
	}

	return Buffer;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer LoadFromFile
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSoundBuffer::LoadFromFile(void)
{
	// Open the wave file       
	FILE* fp = fopen(m_Filename, "rb");
	if (fp == NULL) return FALSE;

	// Read in the wave header          
	Waveheader Wavhdr;
	if (fread(&Wavhdr, sizeof(Wavhdr), 1, fp) != 1) 
	{
		fclose(fp);
		return NULL;
	}

	// Figure out the size of the data region
	DWORD dwSize = Wavhdr.dwDSize;

	// Is this a stereo or mono file?
	BOOL bStereo = Wavhdr.wChnls > 1 ? TRUE : FALSE;

	// Create the sound buffer for the wave file
	if (!CreateSoundBuffer(dwSize, Wavhdr.dwSRate, Wavhdr.BitsPerSample, Wavhdr.wBlkAlign, bStereo))
	{
		// Close the file
		fclose(fp);
        
		return FALSE;
	}

	// Read the data for the wave file into the sound buffer
	if (!ReadData(fp, dwSize, sizeof(Wavhdr))) 
	{
		fclose(fp);
		return FALSE;
	}

	// Close out the wave file
	fclose(fp);

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer Load
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSoundBuffer::Load(CDXSound* pDS, const char *Filename, int Num)
{
	if(Filename == NULL) return FALSE;

	m_pDS = pDS;
	m_nBuffers = Num;
	m_Filename = Filename;

	if(!LoadFromFile()) return FALSE;

	for(int i = 1; i < m_nBuffers; i++)
	{
		if(!m_pDS->m_lpDS->DuplicateSoundBuffer(m_lpDSB[0], &m_lpDSB[i]))
		{
			if(!LoadFromFile()) return FALSE;
		}
	}

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer Play
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSoundBuffer::Play(int Pan, DWORD dwFlags)
{
	HRESULT rval;
	LPDIRECTSOUNDBUFFER Buffer = NULL;

	if(m_pDS == NULL) return FALSE;

	Buffer = GetFreeBuffer();
	if(Buffer == NULL) return FALSE;

	rval = Buffer->SetPan(Pan);
	if(rval != DS_OK) return FALSE;

	rval = Buffer->Play(0, 0, dwFlags);
	if(rval != DS_OK) return FALSE;

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer Stop
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSoundBuffer::Stop()
{
	HRESULT rval;

	if(m_pDS == NULL) return FALSE;

	for(int i = 0; i < m_nBuffers; i++)
	{
		rval = m_lpDSB[i]->Stop();
		if(rval != DS_OK) return FALSE;

		rval = m_lpDSB[i]->SetCurrentPosition(0);
		if(rval != DS_OK) return FALSE;
	}

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSoundBuffer SetVolume
//////////////////////////////////////////////////////////////////////////////////
void CDXSoundBuffer::SetVolume(LONG Volume)
{
	for(int i = 0; i < m_nBuffers; i++)
		m_lpDSB[i]->SetVolume(Volume);
}
