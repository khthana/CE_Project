/////////////////////////////////////////////////////////////////////////////
// File Name:	Shell.cpp
// Author:		Tiwakorn Komut
// Source File:	Mechanical Hazard
// Date:		23/05/2000
// Comment:		This is the last build
/////////////////////////////////////////////////////////////////////////////
#define INITGUID

#include <windows.h>
#include "GDX.h"

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
HINSTANCE g_Hinstance;

GDX* g_pGDX;

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
	wndclass.hbrBackground	= (HBRUSH) GetStockObject (BLACK_BRUSH);
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
	g_Hinstance = hInstance;

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

	case WM_KEYUP:
		g_pGDX->KeyInApplication (wParam);
		return 0;
	}

	return DefWindowProc (hwnd, iMsg, wParam, lParam);
}

/////////////////////////////////////////////////////////////////////////////
// AppInit
/////////////////////////////////////////////////////////////////////////////
BOOL AppInit (void)
{
	/////////////////////////////////////////////
	// Init GDX Class
	/////////////////////////////////////////////
	g_pGDX = new GDX;
	if (!g_pGDX->Create (g_Hwnd, g_Hinstance))
		return FALSE;

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// AppEnd
/////////////////////////////////////////////////////////////////////////////
BOOL AppEnd (void)
{
	/////////////////////////////////////////////
	// Delete GDX Class
	/////////////////////////////////////////////
	SAFE_DELETE (g_pGDX);

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// AppProcess
/////////////////////////////////////////////////////////////////////////////
BOOL AppProcess (void)
{
	/////////////////////////////////////////////
	// Render
	/////////////////////////////////////////////
	if (!g_pGDX->Render ())
		return FALSE;

	return TRUE;
}