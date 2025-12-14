//--------------------------------------------------------------------
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <windowsx.h>
#include <ddraw.h>

//--------------------------------------------------------------------
#define NAME	"DirectX"
#define TITLE	"DirectX"

//--------------------------------------------------------------------
#define DDrawHeight		1024
#define DDrawWidth		768
#define DDrawBpp		16

LPDIRECTDRAW			lpDD;			// DirectDraw object
LPDIRECTDRAWSURFACE		lpDDSPrimary;	// DirectDraw primary surface

//--------------------------------------------------------------------
/*
 * finishObjects - finished with all objects we use - release them
 */
static void finishObjects( void )
{
	if( lpDD != NULL )
	{
		if( lpDDSPrimary != NULL )
		{
			lpDDSPrimary->Release();
			lpDDSPrimary = NULL;
		}
		lpDD->Release();
		lpDD = NULL;
	}
} /* finishObjects */

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
		finishObjects();
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
	finishObjects();
	MessageBox( hwnd, "DirectDraw Init FAILED", TITLE, MB_OK );
	DestroyWindow( hwnd );
	return FALSE;
}

/*
 * doInit - create the window, initialize data
 */
static BOOL doInit( HINSTANCE hInstance, int nCmdShow )
{
	HWND			hwnd;
	WNDCLASS		wc;
	DDSURFACEDESC	ddsd;
	HRESULT			ddrval;
	
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

	/*
	 * create the main DirectDraw object
	 */
	ddrval = DirectDrawCreate( NULL, &lpDD, NULL );
	if( ddrval != DD_OK )
	{
		return initFail(hwnd);
	}

	// Get exclusive mode
	ddrval = lpDD->SetCooperativeLevel( hwnd, 
		DDSCL_EXCLUSIVE | DDSCL_FULLSCREEN );
	if( ddrval != DD_OK )
	{
		return initFail(hwnd);
	}

	// Set the video mode
	ddrval = lpDD->SetDisplayMode( DDrawHeight, DDrawWidth, DDrawBpp );
	if( ddrval != DD_OK )
	{
		return initFail(hwnd);
	}

	// Create the primary surface with 1 back buffer
	ddsd.dwSize = sizeof( ddsd );
	ddsd.dwFlags = DDSD_CAPS;
	ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;
	ddrval = lpDD->CreateSurface( &ddsd, &lpDDSPrimary, NULL );
	if( ddrval != DD_OK )
	{
		return initFail(hwnd);
	}

	return TRUE;
} /* doInit */

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
