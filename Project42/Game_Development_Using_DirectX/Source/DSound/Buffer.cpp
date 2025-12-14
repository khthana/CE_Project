//////////////////////////////////////////////////////////////////////////////////
// CBuffer Implementation
//////////////////////////////////////////////////////////////////////////////////
#include "DSound.h"

//////////////////////////////////////////////////////////////////////////////////
// CBuffer Constructor
//////////////////////////////////////////////////////////////////////////////////
CBuffer::CBuffer()
{
	m_WaveFile = NULL;
	m_Buffer = NULL;
	m_BufferCount = 1;
}

//////////////////////////////////////////////////////////////////////////////////
// CBuffer Destructor
//////////////////////////////////////////////////////////////////////////////////
CBuffer::~CBuffer()
{
	if(m_WaveFile)
	{
		delete m_WaveFile;
		m_WaveFile = NULL;
	}

	for(int i = 0; i < m_BufferCount; i++)
	{
		m_Buffer[i] -> Release;
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CBuffer Create
//////////////////////////////////////////////////////////////////////////////////
HRESULT CBuffer::Create(CSound* sound, char* filename, int count)
{
	HRESULT rval;
	LPVOID Audio;
	DWORD Bytes;
	UINT BytesRead;
	DSBUFFERDESC desc;
	int i;

	// Create enough space for the buffers
	m_BufferCount = count;
	m_Buffer = new LPDIRECTSOUNDBUFFER[((m_BufferCount-1) * sizeof(LPDIRECTSOUNDBUFFER))];
	if(m_Buffer == NULL) return -1;

	// Open the file and get ready to read
	m_WaveFile = new CWaveFile;
	m_WaveFile->Open(filename);

	memset(&desc, 0, sizeof(DSBUFFERDESC));
	desc.dwSize = sizeof(DSBUFFERDESC);
	desc.dwFlags = DSBCAPS_STATIC;
	desc.dwBufferBytes = m_WaveFile->m_nDataSize;
	desc.lpwfxFormat = m_WaveFile->m_pFormat;

	rval = sound->GetDS()->CreateSoundBuffer(&desc, &m_Buffer[0], NULL);
	if(rval != DS_OK) goto CREATE_ERROR;

	rval = m_Buffer[0]->Lock(0, 0, &Audio, &Bytes, NULL, NULL, DSBLOCK_ENTIREBUFFER);
	if(rval != DS_OK) goto CREATE_ERROR;

	// Read the data from the file into the buffer
	BytesRead = m_WaveFile->Read((BYTE*)Audio, Bytes);

	rval = m_Buffer[0]->Unlock(Audio, Bytes, NULL, 0);
	if(rval != DS_OK) goto CREATE_ERROR;

	for(i = 0; i < m_BufferCount; i++)
		rval = sound->lpds->DuplicateSoundBuffer(m_Buffer[0], &m_Buffer[i]);

CREATE_ERROR:
	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CBuffer GetFreeBuffer
//////////////////////////////////////////////////////////////////////////////////
LPDIRECTSOUNDBUFFER CBuffer::GetFreeBuffer(void)
{
	LPDIRECTSOUNDBUFFER Buffer;
	DWORD Status;
	int Current = 0;

	while(Current < m_BufferCount)
	{
		Buffer = m_Buffer[Current];
		if(Buffer->GetStatus(&Status) < 0) Status = 0;

		if((Status & DSBSTATUS_PLAYING) == DSBSTATUS_PLAYING)
		{
			Buffer = NULL;
			Current++;
		}
		else break;
	}

	if(Buffer && (Status & DSBSTATUS_BUFFERLOST))
	{
		if((Buffer->Restore() < 0)) Buffer = NULL;
	}

	return Buffer;
}

//////////////////////////////////////////////////////////////////////////////////
// CBuffer Play
//////////////////////////////////////////////////////////////////////////////////
HRESULT CBuffer::Play(DWORD flags)
{
	HRESULT rval;
	LPDIRECTSOUNDBUFFER Buffer = NULL;

	Buffer = GetFreeBuffer();
	if(Buffer == NULL) return -1;

	rval = Buffer->Play(0, 0, flags);
	if(rval != DS_OK) return rval;

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CBuffer Stop
//////////////////////////////////////////////////////////////////////////////////
HRESULT CBuffer::Stop()
{
	HRESULT rval;

	for(int i = 0; i < m_BufferCount; i++)
	{
		rval = m_Buffer[i]->Stop();
		if(rval != DS_OK) return rval;

		rval = m_Buffer[i]->SetCurrentPosition(0);
		if(rval != DS_OK) return rval;
	}

	return TRUE;
}
