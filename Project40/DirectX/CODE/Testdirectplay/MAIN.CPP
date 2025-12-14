/****************************************************************************
 *		
 *		TEST WORKSPACE
 *
 ***************************************************************************/
#include <windows.h>
#include <windowsx.h>
#include <mmsystem.h>
#include <stdio.h>
#include <limits.h>

#include "text.h"
#include "dp.h"
#include "cdp.h"

/****************************************************************************
 *		
 *		Global Variable
 *
 ***************************************************************************/
#define c_szClassName	"testapp"			// windows class name
#define c_szTitle		"Test DirectPlay object"	// window's title

HWND	hwnd = NULL;

CWinTextMode	*scr = NULL;

#define REFRESH_DELAY	100		// millisecs
unsigned long tick = 0;
unsigned long last_tick = 0;

BOOL	bActive	= FALSE;

BOOL	repaint = FALSE;

BOOL	upstage = TRUE;
BOOL	readychat = FALSE;

#define MAX_CHAT_LENGTH		80
#define CHAT_LINE			20

char chat_buff[MAX_CHAT_LENGTH] = "> _";

#define IPX_NAME			"IPX Connection For DirectPlay"

#define MAX_SESSION_NAME	5

char *session_name[MAX_SESSION_NAME] = {
	"Hello World",
	"Happy New Year 1998",
	"Project DriectX",
	"Not entrance !",
	"Oh la la"
};

#define MAX_PLAYER_NAME		4
#define MAX_NAME_LENGTH		80

char *player_name[MAX_PLAYER_NAME][2] = {
	{ "pinball",	"Bhihien Anawachapun"},
	{ "oom",		"Sorawit ???"},
	{ "pook",		"Oom's Girlfriend"},
	{ "phu",		"Cute Girld"}
};

/****************************************************************************
 *		
 *	Update DirectPlay stage
 *
 ***************************************************************************/
void UpdateDPStatge()
{
	static stage = 0;

	static DWORD numdrivers = 0;
	static DWORD numsessions = 0;
	static DWORD numplayers = 0;

	static DWORD ipx_drv = ULONG_MAX;
	static DWORD session = ULONG_MAX;
	static DWORD player  = ULONG_MAX;

	char *friendlyname, *formalname;

	DWORD i;

	if( upstage )
	{
		switch (stage)
		{
		case 0:
			// find available directplay drivers
			
			numdrivers = dp_GetNumDrivers();

			wsprintf(scr->line(), "Number of DirectPlay Drivers = %d", numdrivers);

			for( i = 0; i < numdrivers; i++ )
			{
				wsprintf(scr->line(), "%d. %s", i+1, dp_GetDriverName(i));

				if( !strcmp(dp_GetDriverName(i),IPX_NAME) )
				{
					ipx_drv = i;
				}
			}

			wsprintf(scr->line(), "...Any key to - Conncet IPX. If found it will delay for enum Sessions");

			stage = 1;
			break;

		case 1:
			// connect with IPX and enum session
			scr->line();

			wsprintf(scr->line(), "Searching for IPX...");

			if( (numdrivers == 0)||(ipx_drv == ULONG_MAX) ) // check if IPX avail
			{
				 wsprintf(scr->line(), "IPX not avail.");
			}
			else	// connect IPX.
			{
				wsprintf(scr->line(), "Connectting IPX...");

				dp_OpenDriver(ipx_drv);

				numsessions = dp_GetNumSessions();

				if( numsessions )
				{
					for( i = 0; i < numsessions; i++ )
					{
						wsprintf(scr->line(), "%d. %s", i+1, dp_GetSessionName(i));

						wsprintf(scr->line(), "...Any key to - Open session and enum Players ");
					}
				}
				else	// no session avail
				{
					wsprintf(scr->line(), "No sessions avail.");

					wsprintf(scr->line(), "...Any key to - Create session.");

				}	// if ( numsessions ) else
			}	// if connect IPX avail else

			scr->line();

			if( numsessions )
			{
				wsprintf(scr->line(), "Open session \"%s\"",dp_GetSessionName(0));

				dp_OpenSession(0);

				// get player
				numplayers = dp_GetNumPlayers();

				wsprintf(scr->line(), "Number of player = %d", numplayers);

				for( i = 0; i < numplayers; i++ )
				{
					dp_GetPlayerName(i, &friendlyname, &formalname);

					 wsprintf(scr->line(), "%d. %s - %s", i+1, friendlyname, formalname);
				}
			}
			else	// no session avail
			{
				wsprintf(scr->line(), "Create session.");

				dp_CreateSession();
			}

			 wsprintf(scr->line(), "...Any key to - Create Player");

			scr->line();

			if( numplayers >= MAX_PLAYER_NAME )
			{
				wsprintf(scr->line(), "Can't create player - player limit = %d",MAX_PLAYER_NAME);
			}
			else
			{
				wsprintf(scr->line(), "Create player.");

				// attach to last player
				dp_CreatePlayer(player_name[numplayers][0],player_name[numplayers][1]);

				 wsprintf(scr->line(), "%d. %s - %s", numplayers+1, player_name[numplayers][0],player_name[numplayers][1]);
			}

			wsprintf(scr->line(), "...Any key to - Go");

			scr->line();

			wsprintf(scr->line(), "--- Enter chat mode ---");
			strcpy(scr->line(CHAT_LINE-1), chat_buff);

			readychat = TRUE;

			stage = 2;
			break;
		}

		upstage = FALSE;
		InvalidateRect(hwnd, NULL, TRUE);
	}
}

/****************************************************************************
 *		
 *	DirectPlay Message CALLBACK
 *
 ***************************************************************************/
void mcl(DWORD playnum, void *data, DWORD len)
{
	if( ((char *)data)[0] == '>' )
	{
		((char *)data)[0] = '*';
		((char *)data)[1] = '*';
		strcpy(scr->line(), (char *)data);

		repaint = TRUE;
	}
}

/****************************************************************************
 *		
 *	Init DirectPlay
 *
 ***************************************************************************/
BOOL DplayInit()
{
	dp_Init(mcl);

	return TRUE;
}

/****************************************************************************
 *		
 *	Destroy DirectPlay
 *
 ***************************************************************************/
void DestroyDP()
{
	dp_Kill();
}

/****************************************************************************
 *		
 *	ReaMessage // get string from keyboard and send when Enter
 *
 ***************************************************************************/
void ReadMessage(WPARAM key)
{
	if( key == VK_RETURN )
	{
		// send to all player
		chat_buff[strlen(chat_buff)-1] = 0x00;

		dp_Send(0, chat_buff, strlen(chat_buff)+1); // include NULL char
		strcpy(scr->line(), chat_buff);

		strcpy(chat_buff,"> _");
		strcpy(scr->line(CHAT_LINE-1), chat_buff);
	}
	else
	{
		if( ((key >= 0x30)&&(key <= 0x39))||
			((key >= 0x41)&&(key <= 0x5A))||
			(key == VK_SPACE)
		)
		{
			chat_buff[strlen(chat_buff)+1] = 0x00;	// terminate string
			chat_buff[strlen(chat_buff)-1] = LOBYTE(LOWORD(key));	
			chat_buff[strlen(chat_buff)] = '_';

			strcpy(scr->line(CHAT_LINE-1), chat_buff);
		}
		else if( key == VK_LEFT )
		{
			if( strlen(chat_buff) > 3 )
			{
				chat_buff[strlen(chat_buff)-2] = '_';
				chat_buff[strlen(chat_buff)-1] = 0x00;
			}

			strcpy(scr->line(CHAT_LINE-1), chat_buff);
		}
	}

	InvalidateRect(hwnd, NULL, TRUE);
}

/****************************************************************************
 *		
 *		OnPaint Function when WM_PAINT
 *
 ***************************************************************************/
LRESULT OnPaint()
{
	if( scr != NULL )
		scr->printscr();
	
	return 0;
}

/****************************************************************************
 *		
 * Clean clean and clean
 *
 ***************************************************************************/
void CleanUp()
{
	if( scr != NULL )
		delete scr;
}

/****************************************************************************
 *
 *      Windows CallBack function
 *
 ****************************************************************************/
long FAR PASCAL WindowProc( HWND _hwnd, UINT message,
						    WPARAM wParam, LPARAM lParam )
{
	switch( message )
	{
	case WM_ACTIVATEAPP:
		bActive = wParam;
		break;

	case WM_CREATE:
		break;

	case WM_PAINT:
		return OnPaint();

	case WM_KEYDOWN:
		switch( wParam )
		{
		case VK_ESCAPE:
		case VK_F12:
			PostMessage(_hwnd, WM_CLOSE, 0, 0);
			return 0;
		default:
			if( readychat )
			{
				ReadMessage(wParam);
			}
			else
			{
				upstage = TRUE;
			}
		}
		break;

	case WM_DESTROY:
		DestroyDP();
		CleanUp();
		PostQuitMessage(0);
		break;
	}

	return DefWindowProc(_hwnd, message, wParam, lParam);
} /* WindowProc */

/****************************************************************************
 *
 *      AppInit
 *
 *      Set up everything the application needs to get started.
 *
 ****************************************************************************/
static BOOL AppInit( HINSTANCE hInstance, int nCmdShow )
{
	/*
	 * set up and register window class
	 */
	WNDCLASS	wc;

	wc.style = CS_HREDRAW | CS_VREDRAW;
	wc.lpfnWndProc = WindowProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	wc.hInstance = hInstance;
	wc.hIcon = LoadIcon(hInstance, IDI_APPLICATION);
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground = 0;
	wc.lpszMenuName = NULL;
	wc.lpszClassName = c_szClassName;
	RegisterClass(&wc);

	/*
	 * create a window
	 */
    hwnd = CreateWindow(
		c_szClassName,                  // Class name
        c_szTitle,						// Caption
        WS_OVERLAPPEDWINDOW,            // Style
        CW_USEDEFAULT, CW_USEDEFAULT,   // Position
        CW_USEDEFAULT, CW_USEDEFAULT,   // Size
        NULL,                           // No parent
        NULL,                           // No menu
        hInstance,                      // inst handle
        0                               // no params
	);

	if( !hwnd )
	{
		return FALSE;
	}

	ShowWindow(hwnd, nCmdShow);
	UpdateWindow(hwnd);

	return TRUE;
} /* AppInit */

/****************************************************************************
 *
 *      WinMain
 *
 *      Application entry point.
 *
 ****************************************************************************/
int PASCAL WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance,
				    LPSTR lpCmdLine, int nCmdShow )
{
	MSG		msg;
    msg.wParam = 0;         /* In case something goes horribly wrong */

	if( !AppInit(hInstance, nCmdShow) )
	{
		return FALSE;
	}

	scr = new CWinTextMode(hwnd, 15);

	if( !DplayInit() )
	{
		return FALSE;
	} 

	while( 1 )
	{
		if( PeekMessage(&msg, NULL, 0, 0, PM_NOREMOVE) )
		{
			if( !GetMessage(&msg, NULL, 0, 0) )
			{
				return msg.wParam;
			}
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		} else if( bActive )
		{
			// active
			tick = timeGetTime();
			if( tick - last_tick > REFRESH_DELAY )
			{
				last_tick = tick;

				dp_Update();	// retrive message from directplay
				if( repaint )
				{
					repaint = FALSE;
					InvalidateRect(hwnd, NULL, TRUE);
				}


				UpdateDPStatge();
			}
		}
		else
		{
			// make sure we go to sleep if we have nothing else to do
			WaitMessage();
		}
	}
} /* WinMain */
