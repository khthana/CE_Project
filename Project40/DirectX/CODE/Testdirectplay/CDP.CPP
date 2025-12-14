#include <windows.h>
#include <string.h>
#include <limits.h>

#include "cdp.h"

#define NUMDRIVERS	15
#define NUMSESSIONS 15
#define NUMPLAYERS	15
#define NUMMESSAGES 15

#define MAXBUFFERLEN 1024

typedef struct
{
	GUID guid;
	char *name;

} DPDRIVER;

typedef struct
{
	DPID dpid;
	char *friendly;
	char *formal;

} PLAYER;

// data use in callback function

static DPDRIVER dpdriver[NUMDRIVERS];
static DPSESSIONDESC dpsdesc[NUMSESSIONS];
static PLAYER player[NUMPLAYERS];

static int numdrivers;	// number of all drivers currently found
static int numsessions;	// number of session in current driver
static int numplayers;	// number of player in current session

/****************************************************************************
 *
 *	EnumDrivers() // callback function for enum directplay drivers
 *	-	can't in object so data in this function must store outside object
 *		but can use only in this file only by static keyword
 *
 ****************************************************************************/
static BOOL CALLBACK EnumDrivers(LPGUID lpguid, LPSTR name, DWORD majver, DWORD minver, LPVOID context)
{
	memcpy(&dpdriver[numdrivers].guid, lpguid, sizeof(dpdriver[0].guid));

	dpdriver[numdrivers].name = new char[strlen(name) + 1];
	strcpy(dpdriver[numdrivers].name, name);

	if (++numdrivers == NUMDRIVERS)
		return (FALSE);
	else
		return (TRUE);
}

/****************************************************************************
 *
 *	EnumSessions() // callback function for enum sessions
 *	-	can't in object so data in this function must store outside object
 *		but can use only in this file only by static keyword
 *
 ****************************************************************************/
static BOOL CALLBACK EnumSessions(LPDPSESSIONDESC lpDPSGameDesc,
    LPVOID lpContext, LPDWORD lpdwTimeOut,
    DWORD dwFlags)
{
	if( lpDPSGameDesc == NULL )	// timeout is 
		return (FALSE);

	memcpy(&dpsdesc[numsessions], lpDPSGameDesc, sizeof(dpsdesc[0]));

	if (++numsessions == NUMSESSIONS)
		return (FALSE);
	else
		return (TRUE);
}

/****************************************************************************
 *
 *	EnumPlayers() // callback function for enum sessions
 *	-	can't in object so data in this function must store outside object
 *		but can use only in this file only by static keyword
 *
 ****************************************************************************/
static BOOL CALLBACK EnumPlayers(DPID dpID,
    LPSTR lpFriendlyName, LPSTR lpFormalName,
    DWORD dwFlags, LPVOID lpContext)
{
	player[numplayers].dpid = dpID;

	player[numplayers].friendly = new char[strlen(lpFriendlyName) + 1];
	player[numplayers].formal	= new char[strlen(lpFormalName) + 1];

	strcpy(player[numplayers].friendly, lpFriendlyName);
	strcpy(player[numplayers].formal, lpFormalName);

	if (++numplayers == NUMPLAYERS)
		return (FALSE);
	else
		return (TRUE);
}

/****************************************************************************
 *
 *	InitVar // initial all variable
 *
 ****************************************************************************/
void CDP::InitVar()
{
	lpDP = NULL;

	driver_id	= INT_MAX;
	session_id  = INT_MAX;
	player_id	= (DPID)-1;

	messagecallback = NULL;

	numdrivers  = 0;
	numsessions = 0;
	numplayers  = 0;
}

/****************************************************************************
 *
 *	// Destroy all DirectPlay relate
 *
 ****************************************************************************/
void CDP::DestroyDP()
{
	int i;

	for( i = 0; i < numplayers; i++ )
	{
		delete [] player[i].friendly;
		delete [] player[i].formal;
	}

	for( i = 0; i < numdrivers; i++ )
	{
		delete [] dpdriver[i].name;
	}

	if( lpDP != NULL )
	{
		if( player_id != (DPID)-1 )
			lpDP->DestroyPlayer(player_id);	// destroy player

		lpDP->Close();	 // close session
		lpDP->Release(); // close driver
	}
}

/****************************************************************************
 *
 *	CDP // constructor of DirectPlay object
 *
 ****************************************************************************/
CDP::CDP()
{
	InitVar();

	dprval = DirectPlayEnumerate(EnumDrivers, NULL);
}

/****************************************************************************
 *
 *	~CDP // destructor of DirectPlay object
 *
 ****************************************************************************/
CDP::~CDP()
{
	DestroyDP();
}

/****************************************************************************
 *
 *	LastResult() // last result in object
 *
 ****************************************************************************/
HRESULT CDP::LastResult()
{
	return dprval;
}

/****************************************************************************
 *
 *	GetNumDrivers() // number of drivers found
 *
 ****************************************************************************/
int CDP::GetNumDrivers() 
{
	if ( lpDP != NULL )
		return (numdrivers);

	return 0;
}

/****************************************************************************
 *
 *	GetDriverName() // name of drivers (auto allocate string)
 *
 ****************************************************************************/
char * CDP::GetDriverName(int drivernum) 
{
	if( (lpDP != NULL)&&(numdrivers > 0)&&(drivernum >= 0)&&(drivernum < numdrivers) )
	{
		char *drv_name;

		drv_name = new char[strlen(dpdriver[drivernum].name) + 1];
		strcpy(drv_name,dpdriver[drivernum].name);

		return drv_name;
	}

	return NULL;
}

/****************************************************************************
 *
 *	OpenDriver() // connect driver and enum session
 *
 ****************************************************************************/
HRESULT CDP::OpenDriver(int drivernum) 
{
	dprval = DPERR_INVALIDPARAMS;

	if( (lpDP != NULL)&&(numdrivers > 0)&&(drivernum >= 0)&&(drivernum < numdrivers) )
	{
		dprval = DirectPlayCreate(&dpdriver[drivernum].guid, &lpDP, NULL);
		if( dprval == DP_OK )
		{
			driver_id = drivernum;
		}
	}

	return dprval;
}

/****************************************************************************
 *
 *	EnumSessions() // enumerate session on current directplay driver
 *
 ****************************************************************************/
HRESULT CDP::EnumSessions(DPSESSIONDESC *lpsdesc, DWORD dwFlags)
{
	dprval = DPERR_INVALIDPARAMS;

	if( lpDP != NULL )
	{
		dprval = lpDP->EnumSessions(lpsdesc, 0, ::EnumSessions, NULL, dwFlags);
	}

	return dprval;
}

/****************************************************************************
 *
 *	GetNumSessions() // number of sessions found
 *
 ****************************************************************************/
int CDP::GetNumSessions() 
{
	if( lpDP != NULL )
		return (numsessions);

	return 0;
}

/****************************************************************************
 *
 *	GetSessionName() // name of session (auto allocate string)
 *
 ****************************************************************************/
char * CDP::GetSessionName(int sessionnum) 
{
	if( (lpDP != NULL)&&(numsessions > 0)&&(sessionnum >= 0)&&(sessionnum < numsessions) )
	{
		char *sess_name;

		sess_name = new char[strlen(dpsdesc[sessionnum].szSessionName) + 1];
		strcpy(sess_name,dpsdesc[sessionnum].szSessionName);

		return sess_name;
	}

	return NULL;
}

/****************************************************************************
 *
 *	CreateSession() // Create new session at the end
 *
 ****************************************************************************/
HRESULT CDP::CreateSession(DPSESSIONDESC *lpsdesc)
{
	dprval = DPERR_GENERIC;

	if( lpDP != NULL )
	{
		dprval = DPERR_INVALIDPARAMS;

		lpsdesc->dwSize  = sizeof DPSESSIONDESC;
		lpsdesc->dwSession = ++numsessions;
		lpsdesc->dwFlags = DPOPEN_CREATESESSION;
		dprval = lpDP->Open(lpsdesc);
		if( dprval == DP_OK )
		{
			session_id = numsessions;
		}
		else
		{
			--numsessions;
		}
	}

	return dprval;
}

/****************************************************************************
 *
 *	OpenSession() // Open exist session
 *
 ****************************************************************************/
HRESULT CDP::OpenSession(int sessionnum)
{
	dprval = DPERR_GENERIC;

	if( (lpDP != NULL)&&(numsessions > 0)&&(sessionnum >= 0)&&(sessionnum < numsessions) )
	{
		dpsdesc[sessionnum].dwFlags = DPOPEN_OPENSESSION;
		dprval = lpDP->Open(&dpsdesc[sessionnum]);
		if( dprval == DP_OK )
		{
			session_id = sessionnum;
		}
	}

	return dprval;
}

/****************************************************************************
 *
 *	CreateSession() // Create new session at the end
 *
 ****************************************************************************/
HRESULT CDP::EnumPlayers()
{
	dprval = DPERR_GENERIC;

	if( (lpDP != NULL)&&(numsessions > 0) )
	{
		dprval = lpDP->EnumPlayers(session_id, ::EnumPlayers, NULL, 0);
	}

	return dprval;
}

/****************************************************************************
 *
 *	GetNumPlayers() // number of players found
 *
 ****************************************************************************/
int CDP::GetNumPlayers()	// number of players found
{
	if( lpDP != NULL )
		return (numplayers);

	return 0;
}

/****************************************************************************
 *
 *	GetPlayerName() // name of play (auto allocate string)
 *
 ****************************************************************************/
void CDP::GetPlayerName(int playernum, char **friendlyname, char **formalname)
{
	dprval = DPERR_GENERIC;

	if( (lpDP != NULL)&&(numplayers > 0)&&(playernum >= 0)&&(playernum < numplayers) )
	{
		if( (*friendlyname != NULL)||(*formalname != NULL) )
			return;

		*friendlyname = new char[strlen(player[playernum].friendly) + 1];
		*formalname	  = new char[strlen(player[playernum].formal) + 1];

		strcpy(*friendlyname, player[numplayers].friendly);
		strcpy(*formalname, player[numplayers].formal);

		dprval = DP_OK;
	}
}

/****************************************************************************
 *
 *	CreatePlayer() // Create player on current session
 *
 ****************************************************************************/
HRESULT CDP::CreatePlayer(char *friendlyname, char *formalname)
{
	dprval = DPERR_GENERIC;

	if( lpDP != NULL )
	{
		dprval = lpDP->CreatePlayer(&player_id, friendlyname, formalname, NULL);
	}

	return dprval;
}

/****************************************************************************
 *
 *	Send() // Send data to all palyer
 *
 ****************************************************************************/
HRESULT CDP::Send(void *data, DWORD len)
{
	dprval = DPERR_GENERIC;

	if( lpDP != NULL )
	{
		if( len > MAXBUFFERLEN )
		{
			dprval = DPERR_INVALIDPARAMS;
			return dprval;
		}

		dprval = lpDP->Send(player_id, DPID_ALLPLAYERS, DPSEND_GUARANTEE, data, len);
	}

	return dprval;
}

/****************************************************************************
 *
 *	Update() // receive message and dispatch
 *
 ****************************************************************************/
void CDP::Update()
{
	dprval = DPERR_GENERIC;

	if( lpDP != NULL )
	{
		static BYTE data[MAXBUFFERLEN];

		DPMSG_GENERIC *msg;
		DPMSG_ADDPLAYER *add;

		DPID dpidfrom, dpidto;
		DWORD len;

		len = MAXBUFFERLEN;

		dprval = lpDP->Receive(&dpidfrom, &dpidto, DPRECEIVE_ALL, data, &len);
		if( dprval == DPERR_NOMESSAGES)
			return;

		if( dprval != DP_OK )
			return;

		if( dpidfrom == 0 )
		{
			// system message 
			msg = (DPMSG_GENERIC *)data;

			switch (msg->dwType)
			{
			case DPSYS_SESSIONLOST:
				break;

			case DPSYS_ADDPLAYER:
				add = (DPMSG_ADDPLAYER *)msg;
				::EnumPlayers(add->dpId, add->szLongName, add->szShortName, 0, NULL);
				break;

			case DPSYS_DELETEPLAYER:
				break;
			}
		}
		else
		{
			if( messagecallback != NULL )
			{
				for( int i = 0; i < numplayers; i++ )
					if( player[i].dpid == dpidfrom )
					{
						(*messagecallback)(i, data, len);
						break;
					}
			}				
		} // if( dpidfrom == 0 ) else
	} // if( lpDP != NULL )
}