/////////////////////////////////////////////////////////////////////////////
// File Name:	???
// Author:		Tiwakorn Komut
// Source File:	???
// Date:		??/??/??
/////////////////////////////////////////////////////////////////////////////
#include <windows.h>
#include "DX.h"

/////////////////////////////////////////////////////////////////////////////
// Prototypes
/////////////////////////////////////////////////////////////////////////////
LRESULT CALLBACK WndProc (HWND, UINT, WPARAM, LPARAM);
BOOL AppInit (void);
BOOL AppProcess (void);
BOOL AppEnd (void);

/////////////////////////////////////////////////////////////////////////////
// Variables
/////////////////////////////////////////////////////////////////////////////
HWND g_Hwnd;

/////////////////////////////////////////////////////////////////////////////
// WINMAIN
/////////////////////////////////////////////////////////////////////////////
int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPreInstance, PSTR szCmdLine, int iCmdShow)
{
	static char szAppName[] = "Shell";
	HWND		hwnd;
	MSG			msg;
	WNDCLASSEX	wndclass;

	wndclass.cbSize			= sizeof (wndclass);
	wndclass.style			= CS_HREDRAW | CS_VREDRAW;
	wndclass.lpfnWndProc	= WndProc;
	wndclass.cbClsExtra		= 0;
	wndclass.cbWndExtra		= 0;
	wndclass.hInstance		= hInstance;
	wndclass.hIcon			= LoadIcon (NULL, IDI_APPLICATION);
	wndclass.hCursor		= LoadCursor (NULL, IDC_ARROW);
	wndclass.hbrBackground	= (HBRUSH) GetStockObject (WHITE_BRUSH);
	wndclass.lpszMenuName	= NULL;
	wndclass.lpszClassName	= szAppName;
	wndclass.hIconSm		= LoadIcon (NULL, IDI_APPLICATION);

	RegisterClassEx (&wndclass);

	hwnd = CreateWindow (szAppName,				// window class name
						 "Shell",				// window caption
						 //WS_OVERLAPPEDWINDOW,	// window style
						 WS_POPUP,
						 //CW_USEDEFAULT,			// initial x position
						 //CW_USEDEFAULT,			// initial y position
						 //CW_USEDEFAULT,			// initial x size
						 //CW_USEDEFAULT,			// initial y size
						 0,
						 0,
						 GetSystemMetrics (SM_CXSCREEN),
						 GetSystemMetrics (SM_CYSCREEN),
						 NULL,					// parent window handle
						 NULL,					// window menu handle
						 hInstance,				// program instance handle
						 NULL);					// creation parameters

	ShowWindow (hwnd, iCmdShow);
	UpdateWindow (hwnd);

	///////////////////////
	// Initialise App
	///////////////////////
	g_Hwnd = hwnd;

	if (!AppInit ())
		PostQuitMessage (0);

	while (1)
	{
		if (PeekMessage (&msg, NULL, 0, 0, PM_REMOVE))
		{
			if (msg.message == WM_QUIT)
				break;
			TranslateMessage (&msg);
			DispatchMessage (&msg);
		}

		///////////////////////
		// App dose its task
		///////////////////////
		if (!AppProcess ())
			PostQuitMessage (0);
	}

	///////////////////////
	// Clean App before EXIT
	///////////////////////
	AppEnd ();

	return (msg.wParam);
}

/////////////////////////////////////////////////////////////////////////////
// MESSAGE HANDLER
/////////////////////////////////////////////////////////////////////////////
LRESULT CALLBACK WndProc (HWND hwnd, UINT iMsg, WPARAM wParam, LPARAM lParam)
{
	HDC hdc;
	PAINTSTRUCT ps;

	switch (iMsg)
	{
	case WM_CREATE:
		return 0;

	case WM_PAINT:
		hdc = BeginPaint (hwnd, &ps);

		EndPaint (hwnd, &ps);
		return 0;

	case WM_DESTROY:
		PostQuitMessage (0);
		return 0;
	}

	return DefWindowProc (hwnd, iMsg, wParam, lParam);
}

/////////////////////////////////////////////////////////////////////////////
// AppInit
/////////////////////////////////////////////////////////////////////////////
BOOL AppInit (void)
{

}

/////////////////////////////////////////////////////////////////////////////
// AppEnd
/////////////////////////////////////////////////////////////////////////////
BOOL AppEnd (void)
{

}

/////////////////////////////////////////////////////////////////////////////
// AppProcess
/////////////////////////////////////////////////////////////////////////////
BOOL AppProcess (void)
{

}