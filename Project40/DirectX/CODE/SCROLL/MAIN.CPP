#define NAME "xoom"
#define TITLE "xoom Project return"
#include "main.h"
#include <windows.h>
#include <windowsx.h>

#include "ddrawx.h"
#include "dinputx.h"
static void finiObjects(void );

GDXStruct gApp;		//global varrable
long FAR PASCAL WindowProc( HWND hWnd, UINT message, 
			    WPARAM wParam, LPARAM lParam )
{
    switch( message )
    {
    case WM_ACTIVATEAPP:
    	gApp.bActive = wParam;
	break;

    case WM_SETCURSOR:
        SetCursor(NULL);
        return TRUE;

    case WM_CREATE:
	break;

    case WM_DESTROY:
    	finiObjects();
	PostQuitMessage( 0 );
	break;
    }

    return DefWindowProc(hWnd, message, wParam, lParam);

} /* WindowProc */

/*
 * doInit - do work required for every instance of the application:
 *		  create the window, initialize data
 */
static BOOL doInit( HINSTANCE hInstance, int nCmdShow )
{
    HWND		hwnd;
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
    wc.lpszMenuName = NAME;
    wc.lpszClassName = NAME;
    RegisterClass( &wc );
    
    /*
     * create a window
     */
    hwnd = CreateWindowEx(
        0,
	NAME,
	TITLE,
	WS_POPUP,
	0,
	0,
        GetSystemMetrics(SM_CXSCREEN),
        GetSystemMetrics(SM_CYSCREEN),
	NULL,
	NULL,
	hInstance,
	NULL );

    if( !hwnd )
    {
	return FALSE;
    }
	gApp.hwnd = hwnd;
    ShowWindow( hwnd, nCmdShow );
    UpdateWindow( hwnd );
	//initial DirectDraw and all object
	gApp.displayx = new	CBubbleDD(gApp.hwnd ,640,480,8);
	if (!gApp.displayx->init_success() ){
		delete gApp.displayx;
		return FALSE;
	}
	//initilal DirectInput for keyboard
	gApp.keyx = new	CBubbleDI(gApp.hwnd ,gApp.g_hinst);
	if (!gApp.keyx->init_success() ){
		delete gApp.keyx;
		return FALSE;
	}
	return TRUE;
} /* doInit */

static void finiObjects( void )
{
	//dextroyDInput;
	delete gApp.displayx;
	delete gApp.keyx;
} /* finiObjects */



/*
 * WinMain - initialization, message loop
 */
int PASCAL WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance,
			LPSTR lpCmdLine, int nCmdShow)
{
	gApp.g_hinst = hInstance;
    MSG         msg;

    lpCmdLine = lpCmdLine;
    hPrevInstance = hPrevInstance;

    if( !doInit( hInstance, nCmdShow ) )
    {
	return FALSE;
    }
	gApp.displayx->BltSource2Buffer();   //initial screen for see (it not necessary to do)
	gApp.displayx->BltBuffer2Back4Part();//
	gApp.displayx->Flip();               //


	while (1)
	{
		
		if(PeekMessage(&msg,NULL,0,0,PM_NOREMOVE))
		{
			if (!GetMessage(&msg,NULL,0,0))
				return msg.wParam;
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
		else 
			if (gApp.bActive)
			{
			static DWORD timex = 0;  
				if ((timeGetTime() - timex)> 15 )
				{
					timex = timeGetTime(); 
					gApp.keyx->updateKeyStatus();

					//LEFT AND RIGHT
					if(gApp.keyx->keyStatus(DIK_RIGHT))
					{
						gApp.displayx->Scrollingx(4);
					}else 
						if(gApp.keyx->keyStatus(DIK_LEFT))
						{
						gApp.displayx->Scrollingx(-4);
						}
					//UP AND DOWN
					if(gApp.keyx->keyStatus(DIK_DOWN))
					{
						gApp.displayx->Scrollingy(4);
					}else 
						if(gApp.keyx->keyStatus(DIK_UP))
						{
							gApp.displayx->Scrollingy(-4);
						}
					if(gApp.keyx->keyStatus(DIK_ESCAPE))
					{
					PostMessage(gApp.hwnd,WM_CLOSE,0,0);
					}
					gApp.displayx->Scrollingx(2);
					gApp.displayx->Scrollingy(2);
					timex= timeGetTime();
					gApp.displayx->BltSource2Back(0,200,0,480,640,480+100);
					gApp.displayx->Flip();
				}
			}else
			{
				WaitMessage();
			}
	}
   
} /* WinMain */
