/****************************************************************************
 *		
 *		WBUBBLE.CPP - Bubble on Windows
 *
 ***************************************************************************/
#include "control.h"
#include "bb_local.h"

/***************************************************************************
 *
 *     Global variables
 *
 ***************************************************************************/
#define c_szClassName	"wBubble"	// windows class name
#define c_szTitle		"Bubble"	// window's title

HINSTANCE	hinst;
HWND		hwnd;
BOOL		bActive = FALSE;

CBubbleLocal	*local = NULL;

/****************************************************************************
 *
 *		CleanUp all resource
 *
 ****************************************************************************/
void CleanUp()
{
	if( local != NULL )
		delete local;
}

 /****************************************************************************
 *
 *      Windows CallBack function
 *
 ****************************************************************************/
long FAR PASCAL WindowProc( HWND hWnd, UINT message,
						    WPARAM wParam, LPARAM lParam )
{
#ifndef useDD
	PAINTSTRUCT ps;
	HDC hdc;
#endif

	switch( message )
	{
	case WM_ACTIVATEAPP:
		bActive = wParam;
		break;

	case WM_PAINT:
#ifndef useDD
		hdc = BeginPaint(hwnd, &ps);
		if( hdc )
		{
	        ExtTextOut(hdc, 0, 0, ETO_OPAQUE, &ps.rcPaint, "", 0, NULL);
			EndPaint(hwnd, &ps);
		}
#endif
		break;

	case WM_CREATE:
		break;

	case WM_KEYUP:
#ifndef useDI
		if( wParam == VK_NUMPAD2 )
		{
			local->key_release(0x50);
			return 0;
		}
		if( wParam == VK_NUMPAD4 )
		{
			local->key_release(0x4B);
			return 0;
		}
		else if( wParam == VK_NUMPAD5 )
		{
			local->key_release(0x4C);
			return 0;
		}
		else if( wParam == VK_NUMPAD6 )
		{
			local->key_release(0x4D);
			return 0;
		}
		else if( wParam == 0x41 ) // A
		{
			local->key_release(0x1E);
			return 0;
		}
		else if( wParam == 0x53 ) // S
		{
				local->key_release(0x1F);
				return 0;
		}
		else if( wParam == 0x44 ) // D
		{
			local->key_release(0x20);
			return 0;
		}
		else if( wParam == 0x58 ) // X
		{
			local->key_release(0x2D);
			return 0;
		}
#endif
		break;

	case WM_KEYDOWN:
		switch( wParam )
		{
		case VK_ESCAPE:
		case VK_F12:
			PostMessage(hWnd, WM_CLOSE, 0, 0);
			return 0;
#ifndef useDI
		case VK_NUMPAD2:
			local->key_press(0x50);
			return 0;
		case VK_NUMPAD4:
			local->key_press(0x4B);
			return 0;
		case VK_NUMPAD5:
			local->key_press(0x4C);
			return 0;
		case VK_NUMPAD6:
			local->key_press(0x4D);
			return 0;
		case 0x41: // A
			local->key_press(0x1E);
			return 0;
		case 0x53: // S
			local->key_press(0x1F);
			return 0;
		case 0x44: // D
			local->key_press(0x20);
			return 0;
		case 0x58: // X
			local->key_press(0x2d);
			return 0;
#endif
		}
		break;

	case WM_DESTROY:
		CleanUp();
		PostQuitMessage(0);
		break;
	}

	return DefWindowProc(hWnd, message, wParam, lParam);
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
     *  Save instance handle for future reference.
     */
	hinst = hInstance;

	/*
	 * set up and register window class
	 */
	WNDCLASS	wc;

	wc.style = CS_HREDRAW | CS_VREDRAW;
	wc.lpfnWndProc = WindowProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	wc.hInstance = hinst;
	wc.hIcon = LoadIcon(hInstance, IDI_APPLICATION);
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground = 0;
	wc.lpszMenuName = NULL;
	wc.lpszClassName = c_szClassName;
	RegisterClass(&wc);

	/*
	 * create a window
	 */
#ifdef useDD
	hwnd = CreateWindowEx(
		WS_EX_APPWINDOW,
		c_szClassName,
		c_szTitle,
		WS_POPUP,
		0, 0,
		GetSystemMetrics(SM_CXSCREEN),
		GetSystemMetrics(SM_CYSCREEN),
		NULL,
		NULL,
		hinst,
		NULL );
#else
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
#endif

	if( !hwnd )
	{
		return FALSE;
	}

	ShowCursor(FALSE);

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

	if( !AppInit(hInstance, nCmdShow) )
	{
		return FALSE;
	}

	local = new CBubbleLocal(hinst, hwnd);

	if( !strcmp(lpCmdLine, "/2") )
	{
		local->start(EP_2ONE);
	}
	else
	{
		local->start(EP_ONE);
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
			// Application is in focus
			local->tick();
			if( local->get_status() != EL_RUNNING )
				local->stop();
		}
		else
		{
			// make sure we go to sleep if we have nothing else to do
			WaitMessage();
		}
	}
} /* WinMain */
