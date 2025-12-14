//////////////////////////////////////////////////////////////////////////////////
// CWaveFile Implementation
//////////////////////////////////////////////////////////////////////////////////
#include "DSound.h"
#include <windows.h>
#include <windowsx.h>
#include <mmsystem.h>
#include <crtdbg.h>
//////////////////////////////////////////////////////////////////////////////////
// Constructor
//////////////////////////////////////////////////////////////////////////////////
CWaveFile::CWaveFile(void)
{
	// Initialise data members
	m_pFormat = NULL;
	m_hmmio = NULL;
	m_nBlockAlign= 0;
	m_nAvgDataRate = 0;
	m_nDataSize = 0;
	m_nBytesPlayed = 0;
	m_nDuration = 0;
	memset(&m_mmckiRiff, 0, sizeof (MMCKINFO));
	memset(&m_mmckiFmt, 0, sizeof (MMCKINFO));
	memset(&m_mmckiData, 0, sizeof (MMCKINFO));
}

//////////////////////////////////////////////////////////////////////////////////
// Destructor
//////////////////////////////////////////////////////////////////////////////////
CWaveFile::~CWaveFile(void)
{
	// Free memory
	if(m_pFormat) GlobalFree(m_pFormat);

	// Close file
	if(m_hmmio) mmioClose(m_hmmio, 0);
}

//////////////////////////////////////////////////////////////////////////////////
// Open
//////////////////////////////////////////////////////////////////////////////////
BOOL CWaveFile::Open(LPSTR pszFilename)
{
	WORD cbExtra = 0;
	BOOL fRtn = TRUE;

	// Open the requested file
	if((m_hmmio = mmioOpen(pszFilename, NULL, MMIO_ALLOCBUF | MMIO_READ)) == NULL)
	{
		m_mmr = MMIOERR_CANNOTOPEN;
		goto OPEN_ERROR;
	}

	// Descend into initial chunk ('RIFF')
	if(m_mmr = mmioDescend(m_hmmio, &m_mmckiRiff, NULL, 0))
	{
		goto OPEN_ERROR;
	}

	// Validate that it's a WAVE file
	if((m_mmckiRiff.ckid != FOURCC_RIFF) || (m_mmckiRiff.fccType != mmioFOURCC('W', 'A', 'V', 'E')))
	{
		m_mmr = MMIOERR_INVALIDFILE;
		goto OPEN_ERROR;
	}

	// Find format chunk ('fmt '), allocate and fill WAVEFORMATEX structure
	m_mmckiFmt.ckid = mmioFOURCC('f', 'm', 't', ' ');
	if(m_mmr = mmioDescend(m_hmmio, &m_mmckiFmt, &m_mmckiRiff, MMIO_FINDCHUNK))
	{
		goto OPEN_ERROR;
	}

	// Read the format chunk into temporary structure
	PCMWAVEFORMAT pcmwf;
	if(mmioRead (m_hmmio, (CHAR *) &pcmwf, sizeof(PCMWAVEFORMAT)) != sizeof(PCMWAVEFORMAT))
	{
		m_mmr = MMIOERR_CANNOTREAD;
		goto OPEN_ERROR;
	}

  // If format is not PCM then there are extra bytes appended to WAVEFORMATEX
	if(pcmwf.wf.wFormatTag != WAVE_FORMAT_PCM)
	{
		// Read WORD specifying number of extra bytes
		if(mmioRead(m_hmmio, (LPSTR) &cbExtra, sizeof (cbExtra)) != sizeof(cbExtra))
		{
			m_mmr = MMIOERR_CANNOTREAD;
			goto OPEN_ERROR;
		}
	}

	// Allocate memory for WAVEFORMATEX structure + extra bytes
	if(m_pFormat = (WAVEFORMATEX *) GlobalAlloc(GMEM_FIXED, sizeof(WAVEFORMATEX)+cbExtra))
	{
		// Copy bytes from temporary format structure
		memcpy(m_pFormat, &pcmwf, sizeof(pcmwf));
		m_pFormat->cbSize = cbExtra;

		// Read those extra bytes and append to WAVEFORMATEX structure
		if(cbExtra != 0)
		{
			if((m_mmr = mmioRead(m_hmmio, (LPSTR) ((BYTE *)(m_pFormat) + sizeof (WAVEFORMATEX)), cbExtra)) != cbExtra)
			{
				// Error reading extra bytes
				m_mmr = MMIOERR_CANNOTREAD;
				goto OPEN_ERROR;
			}
		}
	}
  else
	{
		// Error allocating memory
		m_mmr = MMIOERR_OUTOFMEMORY;
		goto OPEN_ERROR;
	}

	// Init some member data from format chunk
	m_nBlockAlign = m_pFormat->nBlockAlign;
	m_nAvgDataRate = m_pFormat->nAvgBytesPerSec;

	// Ascend out of format chunk
	if(m_mmr = mmioAscend(m_hmmio, &m_mmckiFmt, 0))
	{
		goto OPEN_ERROR;
	}

	// Cue for streaming
	Cue();

	// Init some member data from data chunk
	m_nDataSize = m_mmckiData.cksize;
	m_nDuration = (UINT)(((__int64) m_nDataSize * 1000) / m_nAvgDataRate);

	// Successful open!
	goto OPEN_DONE;
	
OPEN_ERROR:

	fRtn = FALSE;
	if(m_hmmio)
	{
		// Close file
		mmioClose(m_hmmio, 0);
		m_hmmio = NULL;
	}
	if(m_pFormat)
	{
		// Free memory
		GlobalFree (m_pFormat);
		m_pFormat = NULL;
	}

OPEN_DONE:

	return fRtn;
}

//////////////////////////////////////////////////////////////////////////////////
// Cue
//////////////////////////////////////////////////////////////////////////////////
BOOL CWaveFile::Cue(void)
{
	BOOL fRtn = TRUE;

	// Seek to 'data' chunk from beginning of file
	if(mmioSeek (m_hmmio, m_mmckiRiff.dwDataOffset + sizeof(FOURCC), SEEK_SET) != -1)
	{
		// Descend into 'data' chunk
		m_mmckiData.ckid = mmioFOURCC('d', 'a', 't', 'a');
		if((m_mmr = mmioDescend(m_hmmio, &m_mmckiData, &m_mmckiRiff, MMIO_FINDCHUNK)) == MMSYSERR_NOERROR)
		{
			// Reset byte counter
			m_nBytesPlayed = 0;
		}
		else
		{
			fRtn = FALSE;
		}
	}
	else
	{
		// mmioSeek error
		m_mmr = MMIOERR_CANNOTSEEK;
		fRtn = FALSE;
	}

	return fRtn;
}

//////////////////////////////////////////////////////////////////////////////////
// Read
//////////////////////////////////////////////////////////////////////////////////
UINT CWaveFile::Read(BYTE * pbDest, UINT cbSize)
{
	MMIOINFO mmioinfo;
	UINT cb;

	// Use direct buffer access for reads to maximize performance
	if(m_mmr = mmioGetInfo(m_hmmio, &mmioinfo, 0))
	{
		goto READ_ERROR;
	}

	// Limit read size to chunk size
	cbSize = (cbSize > m_mmckiData.cksize) ? m_mmckiData.cksize : cbSize;

	// Adjust chunk size
	m_mmckiData.cksize -= cbSize;

	// Copy bytes from MMIO buffer
	for(cb = 0; cb < cbSize; cb++)
	{
		// Advance buffer if necessary
		if(mmioinfo.pchNext == mmioinfo.pchEndRead)
		{
			if(m_mmr = mmioAdvance(m_hmmio, &mmioinfo, MMIO_READ))
			{
				goto READ_ERROR;
			}

			if(mmioinfo.pchNext == mmioinfo.pchEndRead)
			{
				m_mmr = MMIOERR_CANNOTREAD;
				goto READ_ERROR;
			}
		}

		// Actual copy
		*(pbDest+cb) = *(mmioinfo.pchNext)++;
	}

	// End direct buffer access
	if(m_mmr = mmioSetInfo(m_hmmio, &mmioinfo, 0))
	{
		goto READ_ERROR;
	}

	// Successful read keep running total of number of data bytes read
	m_nBytesPlayed += cbSize;
	goto READ_DONE;

READ_ERROR:
	cbSize = 0;

READ_DONE:
	return cbSize;
}

//////////////////////////////////////////////////////////////////////////////////
// GetSilenceData
//////////////////////////////////////////////////////////////////////////////////
BYTE CWaveFile::GetSilenceData(void)
{
	BYTE bSilenceData = 0;

	// Silence data depends on format of Wave file
	if(m_pFormat)
	{
		if(m_pFormat->wBitsPerSample == 8)
		{
			// For 8-bit formats (unsigned, 0 to 255)
			// Packed DWORD = 0x80808080;
			bSilenceData = 0x80;
		}
		else if(m_pFormat->wBitsPerSample == 16)
		{
			// For 16-bit formats (signed, -32768 to 32767)
			// Packed DWORD = 0x00000000;
			bSilenceData = 0x00;
		}
	}

	return bSilenceData;
}
