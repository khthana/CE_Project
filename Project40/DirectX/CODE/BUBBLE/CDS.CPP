#include "cds.h"

WORD CDS::AllocChannel(void)
{
	WORD i;

	for( i = 0; i < ds_NUMCHANNELS; i++ )
		if( lpdsb[i] == NULL )
			break;

	return i;
}

HRESULT CDS::CreateBuffer(WORD channel, WAVEFORMATEX & wfmtx)
{
	DSBUFFERDESC dsbdesc;
	PCMWAVEFORMAT pcmwf;
	HRESULT hr;

	memset(&pcmwf, 0, sizeof(PCMWAVEFORMAT));
	pcmwf.wf.wFormatTag			= wfmtx.wFormatTag;
	pcmwf.wf.nChannels			= wfmtx.nChannels;
	pcmwf.wf.nSamplesPerSec		= wfmtx.nSamplesPerSec;
	pcmwf.wf.nBlockAlign		= wfmtx.nBlockAlign;
	pcmwf.wf.nAvgBytesPerSec	= wfmtx.nAvgBytesPerSec;
	pcmwf.wBitsPerSample		= wfmtx.wBitsPerSample;

	memset(&dsbdesc, 0, sizeof(DSBUFFERDESC));
	dsbdesc.dwSize			= sizeof(DSBUFFERDESC);
	dsbdesc.dwFlags			= DSBCAPS_CTRLDEFAULT;
	dsbdesc.dwBufferBytes	= len[channel];
	dsbdesc.lpwfxFormat		= (LPWAVEFORMATEX)&pcmwf;

	hr = lpds->CreateSoundBuffer(&dsbdesc, &lpdsb[channel], NULL);

	return hr;
}

HRESULT CDS::FillBuffer(WORD channel)
{
	LPVOID write1;
	DWORD length1;
	LPVOID write2;
	DWORD length2;
	HRESULT hr;

	hr = lpdsb[channel]->Lock(0, len[channel], &write1, &length1, &write2, &length2, 0);

	if (hr == DSERR_BUFFERLOST)
	{
		lpdsb[channel]->Restore();

		hr = lpdsb[channel]->Lock(0, len[channel], &write1, &length1, &write2, &length2, 0);
	}

	if (hr != DS_OK)
	{
		return hr;
	}

	CopyMemory(write1, sound[channel], length1);

	if (write2 != NULL)
	{
		CopyMemory(write2, sound[channel] + length1, length2);
	}

	hr = lpdsb[channel]->Unlock(write1, length1, write2, length2);

	return DD_OK;
}

CDS::CDS(HWND _hwnd)
{
	DWORD ret;
	WORD i;

	for( i = 0; i < ds_NUMCHANNELS; i++)
	{
		lpdsb[i] = NULL;
		sound[i] = NULL;
	}

	ret = DirectSoundCreate(NULL, &lpds, NULL);
	if( ret != DS_OK )
	{
		lpds = NULL;
	}

	ret = lpds->SetCooperativeLevel(_hwnd, DSSCL_NORMAL);
	if( ret != DS_OK )
	{
		lpds->Release();
		lpds = NULL;
	}
}

CDS::~CDS()
{
	WORD i;

	for( i = 0; i < ds_NUMCHANNELS; i++ )
		UnLoadWave(i);

	lpds->Release();		//nothing to do if this causes an error...
}

WORD CDS::LoadWave(char *filename)
{
	HMMIO			hmfr;
	MMCKINFO		parent, child;
	WAVEFORMATEX	wfmtx;
	WORD			channel;

	channel = AllocChannel();
	if( channel == ds_NUMCHANNELS )	// channel nonavailable
		return ds_NUMCHANNELS;

	parent.ckid = (FOURCC)0;
	parent.cksize = 0;
	parent.fccType = (FOURCC)0;
	parent.dwDataOffset = 0;
	parent.dwFlags = 0;

	child = parent;

	hmfr = mmioOpen(filename, NULL, MMIO_READ | MMIO_ALLOCBUF);

	if( hmfr == NULL )
	{
		return ds_NUMCHANNELS;		// can't open file
	}

	/* descend into the RIFF */
	parent.fccType = mmioFOURCC('W','A','V','E');

	if( mmioDescend(hmfr, &parent, NULL, MMIO_FINDRIFF))
	{
		mmioClose(hmfr, 0);

		return ds_NUMCHANNELS;		// not a WAVE file
	}

	/* descend to the WAVEfmt */
	child.ckid = mmioFOURCC('f','m','t',' ');

	if( mmioDescend(hmfr, &child, &parent, 0))
	{
		mmioClose(hmfr, 0);

		return ds_NUMCHANNELS;		// WAVE file has no fmt chunk
	}

	/* read the WAVEFMT from the wave file */
	if( mmioRead(hmfr, (char*)&wfmtx, sizeof(wfmtx)) != sizeof(wfmtx))
	{
		mmioClose(hmfr, 0);

		return ds_NUMCHANNELS;
	}

	/* handle only PCM format WAVEs */
	if( wfmtx.wFormatTag != WAVE_FORMAT_PCM )
	{
		mmioClose(hmfr, 0);

		return ds_NUMCHANNELS;		// WAVE file is not PCM format
	}

	if( mmioAscend(hmfr, &child, 0))
	{
		mmioClose(hmfr, 0);

		return ds_NUMCHANNELS;		// unable to ascend
	}

	/* descend to the data chunk */
	child.ckid = mmioFOURCC('d','a','t','a');

	if( mmioDescend(hmfr, &child, &parent, MMIO_FINDCHUNK))
	{
		mmioClose(hmfr, 0);

		return ds_NUMCHANNELS;		// WAVE file has no data chunk
	}

	sound[channel] = new BYTE[child.cksize];
	len[channel] = child.cksize;

	if( sound[channel] == NULL )
	{
		return ds_NUMCHANNELS;
	}

	/* read the wave data */
	if( (DWORD)mmioRead(hmfr, (char *)sound[channel], child.cksize) != child.cksize)
	{
		mmioClose(hmfr, 0);

		return ds_NUMCHANNELS;		// unable to read data chunk
	}

	mmioClose(hmfr, 0);

	CreateBuffer(channel,wfmtx);
	FillBuffer(channel);

	return (channel);
}

void CDS::UnLoadWave(WORD channel)
{
	if( (channel < 0)||(channel >= ds_NUMCHANNELS ) )
		return;

	if( lpdsb[channel] != NULL )
	{
		lpdsb[channel]->Release();
		lpdsb[channel] = NULL;
	}

	if( sound[channel] != NULL )
	{
		delete sound[channel];
		sound[channel] = NULL;
	}
}

HRESULT CDS::Start(WORD channel, BOOL looping)
{
	if( (channel < 0)||(channel >= ds_NUMCHANNELS )||(lpdsb[channel] == NULL) )
		return DSERR_GENERIC;

	HRESULT hr;

	hr = lpdsb[channel]->Play(0, 0, looping == TRUE ? DSBPLAY_LOOPING : 0);
	if( hr == DSERR_BUFFERLOST )
	{
		hr = lpdsb[channel]->Restore();
		if( hr != DS_OK )
			return hr;

		FillBuffer(channel);
		hr = lpdsb[channel]->Play(0, 0, looping == TRUE ? DSBPLAY_LOOPING : 0);
	}

	return hr;
}

void CDS::Stop(WORD channel)
{
	if( (channel < 0)||(channel >= ds_NUMCHANNELS )||(lpdsb[channel] == NULL) )
		lpdsb[channel]->Stop();
}
