//
// CDP.H
// Class DirectPlay
//

#ifndef _CDP_H_
#define _CDP_H_

#include <dplay.h>

typedef void (MESSAGECALLBACK)(int formpnum, void *data, DWORD len);

class CDP
{
private:
	/*----- Data -----*/
	LPDIRECTPLAY lpDP;		// DirectPlay object

	int driver_id;		// connect driver number
	int session_id;		// open or create session number
	DPID player_id;		// player id

	// msessage callback function to user
	MESSAGECALLBACK *messagecallback;

	HRESULT dprval;		// last return result

	/*----- Method -----*/
	void InitVar();		// initial all variable
	void DestroyDP();	// Destroy all DirectPlay relate

public:
	CDP();	// auto enum DirectPlay driver
	~CDP();

	HRESULT LastResult();

	int GetNumDrivers();	// number of drivers found
	char * GetDriverName(int drivernum); // name of driver (auto allocate string)
	HRESULT OpenDriver(int drvivernum); // connect that driver

	// enum session on current directplay driver
	HRESULT EnumSessions(DPSESSIONDESC *lpsdesc, DWORD dwFlags); 
	int GetNumSessions();	// number of sessions found
	char * GetSessionName(int sessionnum); // name of session (auto allocate string)
	HRESULT CreateSession(DPSESSIONDESC *lpsdesc);
	HRESULT OpenSession(int sessionnum);

	HRESULT EnumPlayers(); // enum player on current session
	int GetNumPlayers();	// number of players found
	// name of play (auto allocate string) pointer must NULL
	void GetPlayerName(int playernum, char **friendlyname, char **formalname); 
	HRESULT CreatePlayer(char *friendlyname, char *formalname);

	// send data to all player
	HRESULT Send(void *data, DWORD len);

	void Update(); // receive message and dispatch
};

#endif