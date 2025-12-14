/******************************************************************************
File: 		 dp.h
Tab stops: every 2 columns
Project:	 Developer's Guide to DirectX 4
Written:	 96/05/12 by Keith Weiner
Purpose:	 Contains the definition for the DPLAY class
History:	 96/05/12 KW Started
******************************************************************************/
#ifndef dp_INCLUDE
  #define dp_INCLUDE
  #include "dplay.h"

	typedef void (dp_MESSAGECALLBACK)(DWORD playnum, void *data, DWORD len);

	void dp_Init(dp_MESSAGECALLBACK *mcb);
  void dp_Kill(void);

	DWORD dp_GetNumDrivers(void);
  char *dp_GetDriverName(DWORD drivernum);

	void dp_OpenDriver(DWORD drivernum);

	DWORD dp_GetNumSessions(void);
  char *dp_GetSessionName(DWORD sessionnum);

  void dp_CreateSession(void);
  void dp_OpenSession(DWORD sessionnum);

  DWORD dp_GetNumPlayers(void);
  void dp_GetPlayerName(DWORD playnum, char **friendlyname, char **formalname);

  void dp_CreatePlayer(char *friendlyname, char *formalname);

  void dp_Send(DWORD playnum, void *data, DWORD len);

	void dp_Update(void);

#endif
