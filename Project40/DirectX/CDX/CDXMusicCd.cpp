//////////////////////////////////////////////////////////////////////////////////
// Project Name: [ CDX Class Library - CDX.lib ]
// Source File:  [ CDXMusicCd Implementation ]
// Author:       [ Patrick Feuser - pat@das-netz.de ]
// Revision:     [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"
#define MAX_TRACKS 100

//////////////////////////////////////////////////////////////////////////////////
// CDXMusicCd Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXMusicCd::CDXMusicCd(void)
{
	m_MCIOpen.wDeviceID = 0;
	m_nNumberOfTracks = 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMusicCd Destructor
//////////////////////////////////////////////////////////////////////////////////
CDXMusicCd::~CDXMusicCd(void)
{
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMusicCd Read
//////////////////////////////////////////////////////////////////////////////////
short	CDXMusicCd::Read(void)
{
	int i;
	short nTrackLength;

	m_nNumberOfTracks = 0;
	m_MCIOpen.lpstrDeviceType = (LPCTSTR)MCI_DEVTYPE_CD_AUDIO;

	if(mciSendCommand(NULL, MCI_OPEN, MCI_OPEN_TYPE|MCI_OPEN_TYPE_ID, (DWORD)(LPVOID)&m_MCIOpen))
	{
		return 0;
	}	
		
	m_MCIStatus.dwItem = MCI_STATUS_NUMBER_OF_TRACKS;
	if(mciSendCommand(m_MCIOpen.wDeviceID, MCI_STATUS, MCI_STATUS_ITEM|MCI_WAIT, (DWORD)(LPVOID)&m_MCIStatus))
	{
		mciSendCommand(m_MCIOpen.wDeviceID, MCI_CLOSE, NULL, NULL);
		return 0;
	}

	m_nNumberOfTracks = (short)m_MCIStatus.dwReturn;
	if(m_nNumberOfTracks > MAX_TRACKS) m_nNumberOfTracks = MAX_TRACKS;
	m_MCIStatus.dwItem = MCI_STATUS_LENGTH;

	for(i = 0; i < m_nNumberOfTracks; i++)
	{
		m_MCIStatus.dwTrack = i + 1;
		mciSendCommand(m_MCIOpen.wDeviceID, MCI_STATUS, MCI_TRACK|MCI_STATUS_ITEM|MCI_WAIT,	(DWORD)(LPVOID)&m_MCIStatus);
		nTrackLength = (short)(MCI_MSF_MINUTE(m_MCIStatus.dwReturn)*60 + MCI_MSF_SECOND(m_MCIStatus.dwReturn));
		m_nTrackLength[i] = nTrackLength;
	}

	mciSendCommand(m_MCIOpen.wDeviceID, MCI_CLOSE, NULL, NULL);

	return m_nNumberOfTracks;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMusicCd GetTrackLength
//////////////////////////////////////////////////////////////////////////////////
short	CDXMusicCd::GetTrackLength(short nTrack)
{
	if(nTrack > 0 && nTrack <= m_nNumberOfTracks) return m_nTrackLength[nTrack-1];
	else return 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMusicCd SetTrackLength
//////////////////////////////////////////////////////////////////////////////////
void CDXMusicCd::SetTrackLength(short nTrack, short nNewLength)
{
	if(nTrack > 0 && nTrack <= m_nNumberOfTracks)
		m_nTrackLength[nTrack-1] = nNewLength;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMusicCd GetTotalLength
//////////////////////////////////////////////////////////////////////////////////
short	CDXMusicCd::GetTotalLength(void)
{
	short nTotalLength = 0;
	short nTrack;

	for(nTrack = 0; nTrack < m_nNumberOfTracks; nTrack++)
		nTotalLength = (short)(nTotalLength + m_nTrackLength[nTrack]);

	return nTotalLength;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMusicCd Play
//////////////////////////////////////////////////////////////////////////////////
void CDXMusicCd::Play(short nTrack)
{
	MCI_SET_PARMS	mciSet;
	MCI_PLAY_PARMS mciPlay;

	m_MCIOpen.lpstrDeviceType = (LPCTSTR)MCI_DEVTYPE_CD_AUDIO;
	if(mciSendCommand(NULL, MCI_OPEN, MCI_OPEN_TYPE|MCI_OPEN_TYPE_ID, (DWORD)&m_MCIOpen))
	{
		return;
	}

	// Set the time format to track/minute/second/frame (TMSF)
	mciSet.dwTimeFormat = MCI_FORMAT_TMSF;
	if(mciSendCommand(m_MCIOpen.wDeviceID, MCI_SET, MCI_SET_TIME_FORMAT, (DWORD)&mciSet))
	{
		mciSendCommand(m_MCIOpen.wDeviceID, MCI_CLOSE, 0, NULL);
		return;
	}

	mciPlay.dwCallback = 0;
	mciPlay.dwFrom = MCI_MAKE_TMSF(nTrack, 0, 0, 0);
	if(mciSendCommand(m_MCIOpen.wDeviceID, MCI_PLAY, MCI_FROM, (DWORD)&mciPlay))
	{
		return;
	}

	mciSendCommand(m_MCIOpen.wDeviceID, MCI_CLOSE, 0, NULL);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMusicCd Stop
//////////////////////////////////////////////////////////////////////////////////
void CDXMusicCd::Stop(void)
{
	if (m_MCIOpen.wDeviceID != -1)
	{
		mciSendCommand(m_MCIOpen.wDeviceID, MCI_CLOSE, NULL, NULL);
	}
}
