//--------------------------------------------------------------------
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <windowsx.h>
#include <mmsystem.h>
#include <ddraw.h>
#include <dsound.h>
#include "..\include\cds.h"

//--------------------------------------------------------------------
#define NAME	"tstSound"
#define TITLE	"Testing Sound WAVE"
//--------------------------------------------------------------------
HWND					hwnd;			// windows handle

CDS						*dirsound;		// pointer of DirectSound Object;
WORD					channel[16];		// channel of WAV

static void finishSound( void )
{
	for(int i=0; i<5; i++ )
	{
		if( channel[i] != ds_NUMCHANNELS )
		{
			dirsound->Stop(channel[i]);
			dirsound->UnLoadWave(channel[i]);
		}
	}

	delete dirsound;
}

long FAR PASCAL WindowProc( HWND hWnd, UINT message,
						    WPARAM wParam, LPARAM lParam )
{
	switch( message )
	{
	case WM_CREATE:
		break;

	case WM_KEYDOWN:
		switch( wParam )
		{
		case VK_ESCAPE:
		case VK_F12:
			PostMessage( hWnd, WM_CLOSE, 0, 0 );
			return 0;
		}
		break;

	case WM_DESTROY:
		finishSound();
		PostQuitMessage( 0 );
		break;
	}

	return DefWindowProc( hWnd, message, wParam, lParam );
} /* WindowProc */

/*
 * This function is called if the initialization function fails
 */
BOOL initFail ( HWND hwnd )
{
	finishSound();
	MessageBox( hwnd, "DirectDraw Init FAILED", TITLE, MB_OK );
	DestroyWindow( hwnd );
	return FALSE;
}

/*
 * doInit - create the window, initialize data
 */
static BOOL doInit( HINSTANCE hInstance, int nCmdShow )
{
	WNDCLASS		wc;

	/*
	 * set up and register window class
	 */
	wc.style = CS_HREDRAW | CS_VREDRAW;
	wc.lpfnWndProc = WindowProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	wc.hInstance = hInstance;
	wc.hIcon = LoadIcon( hInstance, IDI_APPLICATION );
	wc.hCursor = LoadCursor( NULL, IDC_ARROW );
	wc.hbrBackground = GetStockBrush(BLACK_BRUSH);
	wc.lpszMenuName = NULL;
	wc.lpszClassName = NAME;
	RegisterClass( &wc );

	/*
	 * create a window
	 */
	hwnd = CreateWindowEx(
		WS_EX_APPWINDOW,
		NAME,
		TITLE,
		WS_POPUP,
		0, 0,
		GetSystemMetrics( SM_CXSCREEN ),
		GetSystemMetrics( SM_CYSCREEN ),
		NULL,
		NULL,
		hInstance,
		NULL );

	if( !hwnd )
	{
		return FALSE;
	}

	ShowWindow( hwnd, nCmdShow );
	UpdateWindow( hwnd );

	return TRUE;
} /* doInit */

BOOL InitialSound()
{
	int i;

	dirsound = new CDS(hwnd);

	for( i=0; i<5; i++ )
	{
		channel[i] = ds_NUMCHANNELS;
	}

	channel[0] = dirsound->LoadWave("Clap1.wav");
	channel[1] = dirsound->LoadWave("Cash2.wav");
	channel[2] = dirsound->LoadWave("cloop.wav");
	channel[3] = dirsound->LoadWave("Clap1.wav");
	channel[4] = dirsound->LoadWave("Cash2.wav");
	channel[5] = dirsound->LoadWave("cloop.wav");
	channel[6] = dirsound->LoadWave("Clap1.wav");
	channel[7] = dirsound->LoadWave("Cash2.wav");
	channel[8] = dirsound->LoadWave("cloop.wav");
	channel[9] = dirsound->LoadWave("Clap1.wav");
	channel[10] = dirsound->LoadWave("Cash2.wav");
	channel[11] = dirsound->LoadWave("cloop.wav");
	channel[12] = dirsound->LoadWave("Clap1.wav");
	channel[13] = dirsound->LoadWave("Cash2.wav");
	channel[14] = dirsound->LoadWave("cloop.wav");
	channel[15] = dirsound->LoadWave("cloop.wav");

	dirsound->Start(channel[0], FALSE);
	dirsound->Start(channel[1], FALSE);
	dirsound->Start(channel[2], FALSE);

	return TRUE;
}

int PASCAL WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance,
				    LPSTR lpCmdLine, int nCmdShow )
{
	MSG		msg;

	lpCmdLine = lpCmdLine;
	hPrevInstance = hPrevInstance;

	if( !doInit( hInstance, nCmdShow ) )
	{
		return FALSE;
	}

	if( !InitialSound() )
	{
		return FALSE;
	}

	while( 1 )
	{
		if( PeekMessage( &msg, NULL, 0, 0, PM_NOREMOVE ) )
		{
			if( !GetMessage( &msg, NULL, 0, 0 ) )
			{
				return msg.wParam;
			}
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		} else {
			WaitMessage();
		}
	}
} /* WinMain */
