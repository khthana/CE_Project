//==============================================================================
//  File: rmfull.cpp
//=============================================================================

#define INITGUID
#include "rmfull.h"

#include <d3drmwin.h>
#include <math.h>
#include <stdlib.h>
#include <mmsystem.h>



#include "DInput.h"
#include "DSound.h"
#include "KDX_Map.h"
#include "DX.h"

inline D3DCOLOR COLORREF_2_D3DCOLOR (COLORREF cref)
{
	D3DVALUE r = D3DVALUE (GetRValue (cref))/D3DVALUE (255);
	D3DVALUE g = D3DVALUE (GetGValue (cref))/D3DVALUE (255);
	D3DVALUE b = D3DVALUE (GetBValue (cref))/D3DVALUE (255);
	return D3DRMCreateColorRGB (r, g, b);
}

inline COLORREF D3DCOLOR_2_COLORREF (D3DCOLOR d3dclr)
{
	D3DVALUE red = D3DVALUE (255)*D3DRMColorGetRed (d3dclr);
	D3DVALUE green = D3DVALUE (255)*D3DRMColorGetGreen (d3dclr);
	D3DVALUE blue = D3DVALUE (255)*D3DRMColorGetBlue (d3dclr);
	return RGB((int)red, (int)green, (int)blue);
}


//*******
BOOL g_bjoystick = FALSE;
BOOL STARTGAME	= TRUE;
BOOL ENTERGAME  = FALSE;
BOOL TITLESONG	= FALSE;
BOOL PAUSEGAME = FALSE;
int GAME_STATUS;
#define		GAME_TITLE		1
#define		GAME_PLAY		2
#define		GAME_PAUSE		3
#define		GAME_OVER		4
int PLAY_STATUS;
#define		NORMAL			0 
#define		HIT				1

//**********
int CK_HIT_SOUND = 0;
int ROUTE = 0;	
int checkpoint = 0; //
int counttime = 0;
DWORD Time_0;
DWORD Time_n;
DWORD Time_R1;
DWORD Time_R2;
DWORD Time_R3;
DWORD Time_Best;
double building_y;
int block_level;

//LPDIRECT3DRMFRAME3 apSmokeFrame[NUM_SMOKE_TRAILS];



//define class for Map
KDX_Map*	g_Map;				

//define class for DirectInput
CInput*		g_Input		= NULL;
CKeyboard*	g_Keyboard	= NULL;
CJoystick*	g_Joystick	= NULL;

//define class for DirectSound
CSound* sound_t;
CBuffer* buffer_t;
CBuffer* buffer_t2;
CBuffer* buffer_t0;

//***********
double const_sin = sin (0.05);
double const_cos = cos (0.05);
double const_up = 20;
double const_down = 20;

//================================
//		 GLOBAL VARIABLES
//================================
D3DAppInfo* d3dapp;         /* Pointer to read only collection of DD and D3D
                               objects maintained by D3DApp */
rmfullglobals myglobs;      /* collection of global variables */
LPDIRECT3DRM3 lpD3DRM;      /* Direct3DRM object */
LPDIRECT3DRMFRAME3 pWorldFrame; /*Frame reference to master scene*/

//------------------------
//  DirectDraw Surfaces
//------------------------
DX_Surface* TestBmp;
DX_Surface* TestBmp2;
DX_Surface* TestText;
DX_Surface* TestText2;
DX_Surface* TestText3;
DX_Surface* TestText4;
HFONT TestFont;

//===========================================
//		 INTERNAL FUNCTION PROTOTYPES
//===========================================
static BOOL AppInit(HINSTANCE hInstance, LPSTR lpCmdLine);
static BOOL CreateD3DApp(LPSTR lpCmdLine);
static BOOL BeforeDeviceDestroyed(LPVOID lpContext);
static BOOL AfterDeviceCreated(int w, int h, LPDIRECT3DVIEWPORT* lpViewport,
                               LPVOID lpContext);
void CleanUpAndPostQuit(void);
static void InitGlobals(void);
static BOOL AppPause(BOOL f);
void ReportD3DAppError(void);
static BOOL RenderLoop(D3DAppInfo* d3dapp);
static BOOL RestoreSurfaces();
long FAR PASCAL WindowProc(HWND hWnd, UINT message, WPARAM wParam,
                           LPARAM lParam );
void ReadMouse(int*, int*, int*);
char* D3DRMErrorToString(HRESULT error);
BOOL CreateD3DRM(HWND win);
BOOL SetRenderState(void);
//--------------------------------------------------------------------
BOOL BuildScene(LPDIRECT3DRM3 pD3DRM, LPDIRECT3DRMDEVICE3 dev,
				LPDIRECT3DRMVIEWPORT2 view, LPDIRECT3DRMFRAME3 scene,
				LPDIRECT3DRMFRAME3 camera);

void OverrideDefaults(BOOL* bNoTextures, BOOL* pbResizingDisabled,
                      BOOL* pbConstRenderQuality, CHAR** pstrName);
//--------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Name: WinMain()
// Desc: Initializes the application then enters a message loop which calls sample's
//		 RenderScene until a quit message is received.
//-----------------------------------------------------------------------------------
 
int PASCAL
WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine,
        int nCmdShow)
{
    int failcount = 0; /* number of times RenderLoop has failed */
    MSG msg;
    HACCEL hAccelApp;
    hPrevInstance;
    // Create the window and initialize all objects needed to begin rendering
    if(!AppInit(hInstance, lpCmdLine))
        return FALSE;
    hAccelApp = LoadAccelerators(hInstance, "AppAccel");

    while (!myglobs.bQuit) {
        // Monitor the message queue until there are no pressing messages
        if (PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)) {
            if (msg.message == WM_QUIT) {
                CleanUpAndPostQuit();
                break;
            }
            if (!myglobs.hWndMain || !TranslateAccelerator(myglobs.hWndMain,
                                                           hAccelApp, &msg)) {
                TranslateMessage(&msg);
                DispatchMessage(&msg);
            }
		/*
		 * If the app is not minimized, not about to quit, not paused, either the
         * active fullscreen app or in a window and D3D has been initialized,
         * we can render
		 */
        } else if (d3dapp->bRenderingIsOK && !d3dapp->bMinimized
                   && !d3dapp->bPaused && !myglobs.bQuit
                   && (d3dapp->bAppActive || !d3dapp->bFullscreen)) {
			/*	            
             * If were are not in single step mode or if we are and the
             * bDrawAFrame flag is set, render one frame
			 */
            if (!(myglobs.bSingleStepMode && !myglobs.bDrawAFrame)) {
				/*        
				 * Attempt to render a frame, if it fails, take a note. 
                 * If rendering fails more than twice, abort execution.
				 */
                if (!RenderLoop(d3dapp)) {
                    ++failcount;
                    if (failcount == 3) {
                        Msg("Rendering has failed too many times.  Aborting execution.\n");
                        CleanUpAndPostQuit();
                        break;
                    }
                }
            }
			// Reset the bDrawAFrame flag if we are in single step mode
            if (myglobs.bSingleStepMode)
                myglobs.bDrawAFrame = FALSE;
        } else {
            WaitMessage();
        }
    }
    DestroyWindow(myglobs.hWndMain);
    return msg.wParam;
}

//=============================================================
//        D3DApp Initialization and callback functions             
//=============================================================

//-----------------------------------------------------------------------------------
// Name: AppInit()
// Desc: Creates the window and initializes all objects necessary to begin rendering
//-----------------------------------------------------------------------------------

static BOOL
AppInit(HINSTANCE hInstance, LPSTR lpCmdLine)
{
    WNDCLASS wc;
    HMENU hmenu;
    DWORD flags;
    int i;
    // Register the window class
    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc = WindowProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = hInstance;
    wc.hIcon = LoadIcon( hInstance, "AppIcon");
    wc.hCursor = LoadCursor( NULL, IDC_ARROW );
    wc.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
    wc.lpszMenuName = "AppMenu";
    wc.lpszClassName = "Example";
    if (!RegisterClass(&wc))
        return FALSE;
	/*
     * Initialize the global variables and allow the sample code to override
     * some of these default settings.
	 */
    InitGlobals();
    myglobs.hInstApp = hInstance;
    BOOL bResizingDisabled = FALSE;
    CHAR *szName = "D3DRM Example";
	BOOL bConstRenderQuality = FALSE;
	BOOL bNoTextures = FALSE;
    OverrideDefaults(&bConstRenderQuality,
                     &bResizingDisabled,
                     &bNoTextures,
                     &szName);
    myglobs.lpCmdLine = lpCmdLine;
    // Enumerate the DD drivers
    if (!D3DAppEnumerateDDDevices(&myglobs.NumDDDrivers, &myglobs.DDDriver[0])) {
        ReportD3DAppError();
        return FALSE;
    }
    //Choose the last device enumerated which will probably be secondary 3d hardware.
    myglobs.CurrDDDriver = myglobs.NumDDDrivers - 1;
	// Create the window
    if (bResizingDisabled)
        flags =  WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU |
                 WS_MINIMIZEBOX | WS_MAXIMIZEBOX;
    else
        flags = WS_OVERLAPPEDWINDOW;
	// Create a window with some default settings that may change
    myglobs.hWndMain = CreateWindowEx(
          WS_EX_APPWINDOW,
         "Example",
         szName,
         flags,
         CW_USEDEFAULT, CW_USEDEFAULT,
         START_WIN_SIZE, START_WIN_SIZE,
         NULL,                              /* parent window */
         NULL,                              /* menu handle */
         hInstance,                         /* program handle */
         NULL);                             /* create parms */
    if (!myglobs.hWndMain){
        Msg("CreateWindowEx failed");
        return FALSE;
    }

	// Display the window
    ShowWindow(myglobs.hWndMain, SW_SHOWNORMAL);
    UpdateWindow(myglobs.hWndMain);
	// Add the list of DD drivers D3DApp found to the file menu
    hmenu = GetSubMenu(GetMenu(myglobs.hWndMain), 0);
    for (i = 0; i < myglobs.NumDDDrivers; i++) {
        InsertMenu(hmenu,  6 + i, MF_BYPOSITION | MF_STRING,
                   MENU_FIRST_DDDRIVER + i, myglobs.DDDriver[i].Name);
    }
    
	// Create the D3DRM object which are initialized only when the program starts
    if (!CreateD3DRM(myglobs.hWndMain))
        return FALSE;
    /*
	 * Call D3DApp to initialize all DD and D3D objects necessary to render.
     * D3DApp will call the device creation callback which will initialize the
     * viewport and the sample's render states.
	 */
    if (!CreateD3DApp(lpCmdLine))
        return FALSE;
	
	//load map
	g_Map = new KDX_Map;
	if (!g_Map->LoadMap ("all03.map"))
		return FALSE;

	// Create the scene to be rendered by calling this sample's BuildScene
    if (!BuildScene(lpD3DRM, myglobs.dev, myglobs.view, myglobs.scene, myglobs.camera))
        return FALSE;

	
	//Create DirectInput
	g_Input = new CInput;
	g_Input->CreateInput(myglobs.hInstApp);
	g_Keyboard = new CKeyboard;
	g_Keyboard->CreateKeyboard(g_Input, &myglobs.hWndMain);
	g_Joystick = new CJoystick;
	if (g_Joystick -> CreateJoystick(g_Input,&myglobs.hWndMain) == DI_OK)
			g_bjoystick = TRUE;
		
	else
		g_bjoystick = FALSE;
	

	// Create DirectSound
	sound_t = new CSound;
	if (FAILED (sound_t->CreateSound (myglobs.hWndMain)))
		return FALSE;

	buffer_t = new CBuffer;
	if (FAILED (buffer_t->Create (sound_t, "Intro.wav", 1)))
		return FALSE;

	buffer_t2 = new CBuffer;
	if (FAILED (buffer_t2->Create (sound_t, "Theme.wav", 1)))
		return FALSE;


	// TestFont
	TestFont = CreateFont (50, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, NONANTIALIASED_QUALITY, VARIABLE_PITCH, "Impact");

	
    return TRUE;
}

//-----------------------------------------------------------------------------
// Name: CreateD3DRM()
// Desc: Create main D3DRM objects which are only initialized once.
//-----------------------------------------------------------------------------

BOOL
CreateD3DRM(HWND win)
{
    HRESULT rval;
    // Create the D3DRM object
    LPDIRECT3DRM pD3DRM;
    rval = Direct3DRMCreate(&pD3DRM);
    if (rval != D3DRM_OK) {
        Msg("Failed to create Direct3DRM.\n%s", D3DAppErrorToString(rval));
        return FALSE;
    }
    rval = pD3DRM->QueryInterface(IID_IDirect3DRM3, (LPVOID *)&lpD3DRM);
    pD3DRM->Release();
    if (rval != D3DRM_OK) {
        Msg("Failed to QI for IID_IDirect3DRM3.\n%s", D3DAppErrorToString(rval));
        return FALSE;
    }
    // Create the master scene frame and camera frame
    rval = lpD3DRM->CreateFrame(NULL, &myglobs.scene);
    if (rval != D3DRM_OK) {
        Msg("Failed to create the master scene frame.\n%s", D3DAppErrorToString(rval));
        return FALSE;
    }
	
    rval = lpD3DRM->CreateFrame(myglobs.scene, &myglobs.camera);
    if (rval != D3DRM_OK) {
        Msg("Failed to create the camera's frame.\n%s", D3DAppErrorToString(rval));
        return FALSE;
    }

    rval = myglobs.camera->SetPosition(myglobs.scene, D3DVAL(0.0), D3DVAL(0.0), D3DVAL(0.0));
    if (rval != D3DRM_OK) {
        Msg("Failed to position the camera in the frame.\n%s", D3DAppErrorToString(rval));
        return FALSE;
    }
    return TRUE;
}

//-----------------------------------------------------------------------------
// Name: CreateD3DApp()
// Desc: Create all DirectDraw and Direct3D objects necessary to begin rendering.
//		 Add the list of D3D drivers to the file menu.
//-----------------------------------------------------------------------------

static BOOL
CreateD3DApp(LPSTR lpCmdLine)
{
    HMENU hmenu;
    int i;
    LPSTR option;
    BOOL bOnlySystemMemory, bOnlyEmulation;
    DWORD flags;

    /*
     * Parse the command line in seach of one of the following options:
     *     systemmemory  All surfaces should be created in system memory.
     *                   Hardware DD and D3D devices are disabled, but
     *                   debugging during the Win16 lock becomes possible.
     *     emulation     Do not use hardware DD or D3D devices.
     */
    bOnlySystemMemory = FALSE;
    bOnlyEmulation = FALSE;
    option = strtok(lpCmdLine, " -");
    while(option != NULL )   {
        if (!lstrcmp(option, "systemmemory")) {
            bOnlySystemMemory = TRUE;
        } else if (!lstrcmp(option, "emulation")) {
            bOnlyEmulation = TRUE;
        } else {
            Msg("Invalid command line options given.\nLegal options: -systemmemory, -emulation\n");
            return FALSE;
        }
        option = strtok(NULL, " -");
    }
    // Set the flags to pass to the D3DApp creation based on command line
    flags = ((bOnlySystemMemory) ? D3DAPP_ONLYSYSTEMMEMORY : 0) |
            ((bOnlyEmulation) ? (D3DAPP_ONLYD3DEMULATION |
                                 D3DAPP_ONLYDDEMULATION) : 0);
    /*
     * Create all the DirectDraw and D3D objects neccesary to render.  The
     * AfterDeviceCreated callback function is called by D3DApp to create the
     * viewport and the example's execute buffers.
     */
    if (!D3DAppCreateFromHWND(flags, myglobs.hWndMain,
                              myglobs.DDDriver[myglobs.CurrDDDriver].bIsPrimary ? NULL : &myglobs.DDDriver[myglobs.CurrDDDriver].Guid,
                              AfterDeviceCreated, NULL, BeforeDeviceDestroyed, NULL, &d3dapp)) {
        ReportD3DAppError();
        return FALSE;
    }
    // Add the the list of display modes D3DApp found to the mode menu
    hmenu = GetSubMenu(GetMenu(myglobs.hWndMain), 2);
    for (i = 0; i < d3dapp->NumModes; i++) {
        char ach[80];
        wsprintf(ach,"%dx%dx%d", d3dapp->Mode[i].w, d3dapp->Mode[i].h,
                 d3dapp->Mode[i].bpp);
        AppendMenu(hmenu, MF_STRING, MENU_FIRST_MODE+i, ach);
    }
	// Add the list of D3D drivers D3DApp foudn to the file menu
    hmenu = GetSubMenu(GetMenu(myglobs.hWndMain), 0);
    for (i = 0; i < d3dapp->NumDrivers; i++) {
        InsertMenu(hmenu, 7 + myglobs.NumDDDrivers + i, MF_BYPOSITION | MF_STRING,
                   MENU_FIRST_DRIVER + i, d3dapp->Driver[i].Name);
    }

    return TRUE;
}

//-----------------------------------------------------------------------------
// Name: DestroyD3DApp()
// Desc: Destroy D3DApp and changes to menu
//-----------------------------------------------------------------------------

static void
DestroyD3DApp(void)
{
    HMENU hmenu;
    int i;
    // Remove the list of display modes
    hmenu = GetSubMenu(GetMenu(myglobs.hWndMain), 4);
    for (i = 0; i < d3dapp->NumModes; i++) {
        DeleteMenu(hmenu, MENU_FIRST_MODE + i, MF_BYCOMMAND);
    }
	// Remove the list of D3D drivers
    hmenu = GetSubMenu(GetMenu(myglobs.hWndMain), 0);
    for (i = 0; i < d3dapp->NumDrivers; i++) {
        DeleteMenu(hmenu, MENU_FIRST_DRIVER + i, MF_BYCOMMAND);
    }
    RELEASE(myglobs.lpInfoBuffer);
    RELEASE(myglobs.lpFrameRateBuffer);
    D3DAppDestroy();
}

//--------------------------------------------------------------------------------
// Name: AfterDeviceCreated()
// Desc: D3DApp will call this function immediately after the D3D device has been
//		 created (or re-created).  D3DApp expects the D3D viewport to be created 
//		 and returned.  In this case, we will return NULL because we only have a 
//		 D3DRM viewport.  This is fine as long as we don't use any of the D3D 
//		 viewport functionality of D3DApp.
//--------------------------------------------------------------------------------

static BOOL
AfterDeviceCreated(int w, int h, LPDIRECT3DVIEWPORT* lplpViewport, LPVOID lpContext)
{
    HRESULT rval;

    rval = lpD3DRM->CreateDeviceFromD3D(d3dapp->lpD3D, d3dapp->lpD3DDevice,
                                        &myglobs.dev);
    if (rval != D3DRM_OK) {
        Msg("Creation of D3DRM device failed.\n%s", D3DAppErrorToString(rval));
        return FALSE;
    }
    /*
     * Create the D3DRM viewport using the camera frame.  Set the background
     * depth to a large number.  The width and height may be slightly
     * adjusted, so get them from the device to be sure.
     */
    w = myglobs.dev->GetWidth();
    h = myglobs.dev->GetHeight();
    rval = lpD3DRM->CreateViewport(myglobs.dev, myglobs.camera, 0, 0, w,
                                   h, &myglobs.view);
    if (rval != D3DRM_OK) {
        Msg("Failed to create the D3DRM viewport.\n%s",
            D3DAppErrorToString(rval));
        RELEASE(myglobs.dev);
        return FALSE;
    }
    rval = myglobs.view->SetBack(D3DVAL(5000.0));
    if (rval != D3DRM_OK) {
        Msg("Failed to set the background depth of the D3DRM viewport.\n%s",
            D3DAppErrorToString(rval));
        RELEASE(myglobs.dev);
        RELEASE(myglobs.view);
        return FALSE;
    }
	// Set the render quality, fill mode, lighting state and color shade info
    if (!SetRenderState())
        return FALSE;
    // Return NULL for the viewport
    *lplpViewport = NULL;
    
	/*
     * Create and initialize the surfaces containing the frame rate and
     * window information
     */
    InitFontAndTextBuffers();

    return TRUE;
}

//--------------------------------------------------------------------------------
// Name: BeforeDeviceDestroyed()
// Desc: D3DApp will call this function before the current D3D device is destroyed
//		 to give the app the opportunity to destroy objects it has created with the
//		 DD or D3D objects.
//--------------------------------------------------------------------------------

static BOOL
BeforeDeviceDestroyed(LPVOID lpContext)
{
    RELEASE(myglobs.view);
    RELEASE(myglobs.dev);
    return TRUE;
}

//--------------------------------------------------------------------------------
// Name: RenderLoop()
// Desc: Render the next frame and update the window
//--------------------------------------------------------------------------------

static BOOL
RenderLoop(D3DAppInfo* d3dapp)
{
	if (TestBmp == NULL)
		return TRUE;

    D3DRECT extents[D3DAPP_MAXCLEARRECTS];
    int count;
    HRESULT rval;
	// Clear the second buffer on also
    static BOOL b = FALSE; 
    // If all the DD and D3D objects have been initialized we can render
    if (d3dapp->bRenderingIsOK) {
        // Restore any lost surfaces
        if (!RestoreSurfaces()) {
            /*
             * Restoring surfaces sometimes fails because the surfaces cannot
             * yet be restored.  If this is the case, the error will show up
             * somewhere else and we should return success here to prevent
             * unnecessary error's being reported.
             */
            return TRUE;
        }
		// Force an update of the entire client window if the resized flag is set
        if (myglobs.bResized || b)
            myglobs.view->ForceUpdate(0, 0, d3dapp->szClient.cx, d3dapp->szClient.cy);
		// Use b to makesure the second buffer is cleared also
        if (b)
            b = FALSE;
        if (myglobs.bResized)
            b = TRUE;
        // Calculate the frame rate
        if (!CalculateFrameRate())
            return FALSE;
        // Tick the scene
        rval = myglobs.scene->Move(D3DVAL(1.0));
        if (rval != D3DRM_OK) {
            Msg("Moving scene failed.\n%s", D3DAppErrorToString(rval));
            return FALSE;
        }
        // Clear the viewport  //*******edit****
		if (myglobs.view != NULL)
			rval = myglobs.view->Clear(D3DRMCLEAR_ALL);
        if (rval != D3DRM_OK) {
            Msg("Clearing viewport failed.\n%s", D3DAppErrorToString(rval));
            return FALSE;
        }
        // Render the scene to the viewport //*********edit***
		if (myglobs.view != NULL)
			rval = myglobs.view->Render(myglobs.scene);
        if (rval != D3DRM_OK) {
            Msg("Rendering scene failed.\n%s", D3DAppErrorToString(rval));
            return FALSE;
        }
		//-------------------------------------------------------------
        // Blt the frame rate and window stat text to the back buffer
		//-------------------------------------------------------------
        count = 0;
        if (!DisplayFrameRate(&count, &extents[0]))
            return FALSE;
        for (;count;--count)
			myglobs.view->ForceUpdate(0, 0, extents[count-1].x2, extents[count-1].y2);
            


		//-------------------------------------------------------------
		// Draw Panel
		//-------------------------------------------------------------
		if (GAME_STATUS != GAME_TITLE)
		{
			TestBmp->SetDest (0, 0, d3dapp->Mode[d3dapp->CurrMode].w, d3dapp->Mode[d3dapp->CurrMode].h); 
			TestBmp->Draw (d3dapp->lpBackBuffer, DDBLT_WAIT | DDBLT_KEYSRC);
		}
	
		//------------------
		// Draw Game Title
		//------------------
		if (GAME_STATUS == GAME_TITLE)
		{
			TestBmp2->SetDest (0, 0, 500, 300); 
			TestBmp2->Draw (d3dapp->lpBackBuffer, DDBLT_WAIT | DDBLT_KEYSRC);
		}

		char buff[50];
		HDC hdc;
		HFONT pOldFont;

		if (GAME_STATUS == GAME_PLAY)
		{

		//-------------------------------------------------------------
		// Draw Time
		//-------------------------------------------------------------
		TestText->SetDest ((d3dapp->Mode[d3dapp->CurrMode].w - TestText->GetWidth ()) ,   // /2
						   (d3dapp->Mode[d3dapp->CurrMode].h - TestText->GetHeight ()) ); // /2
		TestText->Fill (0);
		
		wsprintf (buff, "Time: %d", Time_n);

		
		// Get HDC
		TestText->m_Surface->GetDC (&hdc);

		// Select Font
		pOldFont = (HFONT) SelectObject (hdc, TestFont);

		// Set Font
		SetBkMode (hdc, TRANSPARENT);

		// Draw Text Shadow
		SetTextColor (hdc, RGB (10,10, 10));
		TextOut (hdc, 2, 2, buff, strlen (buff));

		// Draw Text
		SetTextColor (hdc, RGB (255, 255, 0));
		TextOut (hdc, 0, 0, buff, strlen (buff));

		// Select Old Font
		SelectObject (hdc, pOldFont);

		// Release DC
		TestText->m_Surface->ReleaseDC (hdc);

		// Draw to Back Buffer
		TestText->Draw (d3dapp->lpBackBuffer, DDBLT_WAIT | DDBLT_KEYSRC);

		//-------------------------------------------------------------
		// Draw Lab
		//-------------------------------------------------------------
		TestText2->SetDest ( 0, (d3dapp->Mode[d3dapp->CurrMode].h - TestText2->GetHeight ()) ); 
		TestText2->Fill (0);
		
		//char buff[50];
		wsprintf (buff, "  Lab: %d/3", ROUTE);

		//HDC hdc;
		//HFONT pOldFont;

		// Get HDC
		TestText2->m_Surface->GetDC (&hdc);

		// Select Font
		pOldFont = (HFONT) SelectObject (hdc, TestFont);

		// Set Font
		SetBkMode (hdc, TRANSPARENT);

		// Draw Text Shadow
		SetTextColor (hdc, RGB (10,10, 10));
		TextOut (hdc, 2, 2, buff, strlen (buff));

		// Draw Text
		SetTextColor (hdc, RGB (255, 255, 0));
		TextOut (hdc, 0, 0, buff, strlen (buff));

		// Select Old Font
		SelectObject (hdc, pOldFont);

		// Release DC
		TestText2->m_Surface->ReleaseDC (hdc);

		// Draw to Back Buffer
		TestText2->Draw (d3dapp->lpBackBuffer, DDBLT_WAIT | DDBLT_KEYSRC);

		}

		if (GAME_STATUS != GAME_PLAY)
		{
		//-------------------------------------------------------------
		// Draw Start Game or Exit Game
		//-------------------------------------------------------------
				
		TestText3->SetDest ((d3dapp->Mode[d3dapp->CurrMode].w - TestText->GetWidth ())/2 ,  
									(d3dapp->Mode[d3dapp->CurrMode].h - TestText->GetHeight ()) *2 /3 ); 
		TestText3->Fill (0);
		
		
		if (STARTGAME == TRUE)
			wsprintf (buff, "NEW GAME");
		else wsprintf (buff, "    EXIT");


		// Get HDC
		TestText3->m_Surface->GetDC (&hdc);

		// Select Font
		pOldFont = (HFONT) SelectObject (hdc, TestFont);

		// Set Font
		SetBkMode (hdc, TRANSPARENT);

		// Draw Text Shadow
		SetTextColor (hdc, RGB (10,10, 10));
		TextOut (hdc, 2, 2, buff, strlen (buff));

		// Draw Text
		SetTextColor (hdc, RGB (255, 0, 0)); // color = red
		TextOut (hdc, 0, 0, buff, strlen (buff));

		// Select Old Font
		SelectObject (hdc, pOldFont);

		// Release DC
		TestText3->m_Surface->ReleaseDC (hdc);

		// Draw to Back Buffer
		TestText3->Draw (d3dapp->lpBackBuffer, DDBLT_WAIT | DDBLT_KEYSRC);
		}

		if (GAME_STATUS == GAME_OVER)
		{
		//-------------------------------------------------------------
		// Draw Best Time
		//-------------------------------------------------------------
				
		TestText4->SetDest ((d3dapp->Mode[d3dapp->CurrMode].w - TestText->GetWidth ())/2 ,  
									(d3dapp->Mode[d3dapp->CurrMode].h - TestText->GetHeight ())/3  ); 
		TestText4->Fill (0);
		
			
		wsprintf (buff, "Best Time: %d", Time_Best);


		// Get HDC
		TestText4->m_Surface->GetDC (&hdc);

		// Select Font
		pOldFont = (HFONT) SelectObject (hdc, TestFont);

		// Set Font
		SetBkMode (hdc, TRANSPARENT);

		// Draw Text Shadow
		SetTextColor (hdc, RGB (10,10, 10));
		TextOut (hdc, 2, 2, buff, strlen (buff));

		// Draw Text
		SetTextColor (hdc, RGB (255, 0, 0)); // color = red
		TextOut (hdc, 0, 0, buff, strlen (buff));

		// Select Old Font
		SelectObject (hdc, pOldFont);

		// Release DC
		TestText4->m_Surface->ReleaseDC (hdc);

		// Draw to Back Buffer
		TestText4->Draw (d3dapp->lpBackBuffer, DDBLT_WAIT | DDBLT_KEYSRC);
		}

        //--------------------
		// Update the window
		//--------------------
        rval = myglobs.dev->Update();
        if (rval != D3DRM_OK) {
            Msg("Updating device failed.\n%s", D3DAppErrorToString(rval));
            return FALSE;
        }
		/*
         * Blt or flip the back buffer to the front buffer.  
         * If this fails, don't report an error.
		 */
        D3DAppShowBackBuffer(myglobs.bResized ? D3DAPP_SHOWALL : NULL);
        // Reset the resize flag
        myglobs.bResized = FALSE;
    }
    return TRUE;
}

//--------------------------------------------------------------------------------
// Name: AppPause()
// Desc: Pause and unpause the application
//--------------------------------------------------------------------------------

static BOOL
AppPause(BOOL f)
{
    // Flip to the GDI surface and halt rendering
    if (!D3DAppPause(f))
        return FALSE;
    // When returning from a pause, reset the frame rate count
    if (!f) {
        ResetFrameRate();
        myglobs.bResized = TRUE;
    }
    return TRUE;
}

//--------------------------------------------------------------------------------
// Name: RestoreSurfaces()
// Desc: Restores any lost surfaces.  Returns TRUE if all surfaces are not lost and
//		 FALSE if one or more surfaces is lost and can not be restored at the moment.
//--------------------------------------------------------------------------------

static BOOL
RestoreSurfaces()
{
    HRESULT d3drval;
    // Have D3DApp check all the surfaces it's in charge of
    if (!D3DAppCheckForLostSurfaces()) {
            return FALSE;
    }
	// Check frame rate and info surfaces and re-write them if they were lost.
    if (myglobs.lpFrameRateBuffer->IsLost() == DDERR_SURFACELOST) {
        d3drval = myglobs.lpFrameRateBuffer->Restore();
        if (d3drval != DD_OK) {
            return FALSE;
        }
        if (!WriteFrameRateBuffer(0.0f, 0))
            return FALSE;
    }
    if (myglobs.lpInfoBuffer->IsLost() == DDERR_SURFACELOST) {
        d3drval = myglobs.lpInfoBuffer->Restore();
        if (d3drval != DD_OK) {
            return FALSE;
        }
        if (!WriteInfoBuffer())
            return FALSE;
    }
    return TRUE;
}


//================================
//  Windows message handlers
//================================

//--------------------------------------------------------------------------------
// Name: AppAbout()
// Desc: About box message handler
//--------------------------------------------------------------------------------

BOOL
FAR PASCAL AppAbout(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  switch (msg)
  {
    case WM_COMMAND:
      if (LOWORD(wParam) == IDOK)
        EndDialog(hwnd, TRUE);
      break;

    case WM_INITDIALOG:
      return TRUE;
  }
  return FALSE;
}

//--------------------------------------------------------------------------------
// Name: WindowProc()
// Desc: Main window message handler.
//--------------------------------------------------------------------------------

long
FAR PASCAL WindowProc(HWND hWnd, UINT message, WPARAM wParam,
                           LPARAM lParam )
{
    int i;
    BOOL bStop;
    LRESULT lresult;
    /*
     * Give D3DApp an opportunity to process any messages it MUST see in order
     * to perform it's function.
     */
    if (!D3DAppWindowProc(&bStop, &lresult, hWnd, message, wParam, lParam)) {
        ReportD3DAppError();
        CleanUpAndPostQuit();
        return 0;
    }
    /*
     * If bStop is set by D3DApp, the app should not process the message but
     * return lresult.
     */
    if (bStop)
        return lresult;

    if (!d3dapp || !d3dapp->bRenderingIsOK) {
        return DefWindowProc(hWnd, message, wParam, lParam);
    }

    switch( message ) {
        case WM_LBUTTONDOWN:
        case WM_LBUTTONUP:
        case WM_RBUTTONDOWN:
        case WM_RBUTTONUP:
        case WM_MOUSEMOVE:
            // Record the mouse state for ReadMouse
            myglobs.mouse_buttons = wParam;
            myglobs.mouse_x = LOWORD(lParam);
            myglobs.mouse_y = HIWORD(lParam);
            break;
		//-----------------------------------------------
		case WM_KEYUP:
			
			switch (wParam)
			{
			case VK_UP:
				if (GAME_STATUS != GAME_PLAY)
				{
					if (STARTGAME == TRUE)
						STARTGAME = FALSE;
					else STARTGAME = TRUE;
				}
				break;

			case VK_DOWN:
				if (GAME_STATUS != GAME_PLAY)
				{
					if (STARTGAME == TRUE)
						STARTGAME = FALSE;
					else STARTGAME = TRUE;
				}
				break;

			case VK_RETURN:
				ENTERGAME = TRUE;
				break;
			
			case VK_PAUSE:
				
					if (PAUSEGAME == FALSE) 
						PAUSEGAME = TRUE;
					else PAUSEGAME = FALSE;
			
				break;

			}
			break;
		//------------------------------------------------
        case WM_ENTERMENULOOP:
            AppPause(TRUE);
            break;
        case WM_EXITMENULOOP:
            AppPause(FALSE);
            break;
        case WM_DESTROY:
            myglobs.hWndMain = NULL;
            CleanUpAndPostQuit();
            break;
        case WM_INITMENUPOPUP:
            // Check and enable the appropriate menu items
            CheckMenuItem((HMENU)wParam, MENU_STEP, (myglobs.bSingleStepMode) ? MF_CHECKED : MF_UNCHECKED);
            EnableMenuItem((HMENU)wParam, MENU_GO, (myglobs.bSingleStepMode) ? MF_ENABLED : MF_GRAYED);
            EnableMenuItem((HMENU)wParam, MENU_PHONG, MF_GRAYED);
            if (!myglobs.bConstRenderQuality) {
                CheckMenuItem((HMENU)wParam, MENU_LIGHTING, (myglobs.RenderQuality & D3DRMLIGHT_MASK) == D3DRMLIGHT_ON ? MF_CHECKED : MF_GRAYED);
                CheckMenuItem((HMENU)wParam, MENU_FLAT, (myglobs.RenderQuality & D3DRMSHADE_MASK) == D3DRMSHADE_FLAT ? MF_CHECKED : MF_UNCHECKED);
                CheckMenuItem((HMENU)wParam, MENU_GOURAUD, (myglobs.RenderQuality & D3DRMSHADE_MASK) == D3DRMSHADE_GOURAUD ? MF_CHECKED : MF_UNCHECKED);
                CheckMenuItem((HMENU)wParam, MENU_PHONG, (myglobs.RenderQuality & D3DRMSHADE_MASK) == D3DRMSHADE_PHONG ? MF_CHECKED : MF_UNCHECKED);
                EnableMenuItem((HMENU)wParam, MENU_PHONG, MF_GRAYED);
                CheckMenuItem((HMENU)wParam, MENU_POINT, (myglobs.RenderQuality & D3DRMFILL_MASK) == D3DRMFILL_POINTS ? MF_CHECKED : MF_UNCHECKED);
                CheckMenuItem((HMENU)wParam, MENU_WIREFRAME, (myglobs.RenderQuality & D3DRMFILL_MASK) == D3DRMFILL_WIREFRAME ? MF_CHECKED : MF_UNCHECKED);
                CheckMenuItem((HMENU)wParam, MENU_SOLID, (myglobs.RenderQuality & D3DRMFILL_MASK) == D3DRMFILL_SOLID ? MF_CHECKED : MF_UNCHECKED);
            } else {
                EnableMenuItem((HMENU)wParam, MENU_LIGHTING, MF_GRAYED);
                EnableMenuItem((HMENU)wParam, MENU_FLAT, MF_GRAYED);
                EnableMenuItem((HMENU)wParam, MENU_GOURAUD, MF_GRAYED);
                EnableMenuItem((HMENU)wParam, MENU_PHONG, MF_GRAYED);
                EnableMenuItem((HMENU)wParam, MENU_POINT, MF_GRAYED);
                EnableMenuItem((HMENU)wParam, MENU_WIREFRAME, MF_GRAYED);
                EnableMenuItem((HMENU)wParam, MENU_SOLID, MF_GRAYED);
            }
            if (!myglobs.bNoTextures && d3dapp->ThisDriver.bDoesTextures) {
                CheckMenuItem((HMENU)wParam, MENU_POINT_FILTER, (myglobs.TextureQuality == D3DRMTEXTURE_NEAREST) ? MF_CHECKED : MF_UNCHECKED);
                CheckMenuItem((HMENU)wParam, MENU_LINEAR_FILTER, (myglobs.TextureQuality == D3DRMTEXTURE_LINEAR) ? MF_CHECKED : MF_UNCHECKED);
            } else {
                EnableMenuItem((HMENU)wParam, MENU_POINT_FILTER, MF_GRAYED);
                EnableMenuItem((HMENU)wParam, MENU_LINEAR_FILTER, MF_GRAYED);
            }
            CheckMenuItem((HMENU)wParam, MENU_DITHERING, (myglobs.bDithering) ? MF_CHECKED : MF_UNCHECKED);
            CheckMenuItem((HMENU)wParam, MENU_ANTIALIAS, (myglobs.bAntialiasing) ? MF_CHECKED : MF_UNCHECKED);
            EnableMenuItem((HMENU)wParam, MENU_ANTIALIAS, MF_GRAYED);
            if (d3dapp->bIsPrimary) {
                CheckMenuItem((HMENU)wParam, MENU_FULLSCREEN, d3dapp->bFullscreen ? MF_CHECKED : MF_UNCHECKED);
                EnableMenuItem((HMENU)wParam, MENU_FULLSCREEN, d3dapp->bFullscreen && !d3dapp->ThisDriver.bCanDoWindow ? MF_GRAYED : MF_ENABLED);
                EnableMenuItem((HMENU)wParam, MENU_NEXT_MODE, (!d3dapp->bFullscreen) ? MF_GRAYED : MF_ENABLED);
                EnableMenuItem((HMENU)wParam, MENU_PREVIOUS_MODE, (!d3dapp->bFullscreen) ? MF_GRAYED : MF_ENABLED);
            } else {
                EnableMenuItem((HMENU)wParam, MENU_FULLSCREEN, MF_GRAYED);
                EnableMenuItem((HMENU)wParam, MENU_NEXT_MODE, MF_GRAYED);
                EnableMenuItem((HMENU)wParam, MENU_PREVIOUS_MODE, MF_GRAYED);
            }
            for (i = 0; i < d3dapp->NumModes; i++) {
                CheckMenuItem((HMENU)wParam, MENU_FIRST_MODE + i, (i == d3dapp->CurrMode) ? MF_CHECKED : MF_UNCHECKED);
                EnableMenuItem((HMENU)wParam, MENU_FIRST_MODE + i, (d3dapp->Mode[i].bThisDriverCanDo) ? MF_ENABLED : MF_GRAYED);
            }
            for (i = 0; i < d3dapp->NumDrivers; i++) {
                CheckMenuItem((HMENU)wParam, MENU_FIRST_DRIVER + i, (i == d3dapp->CurrDriver) ? MF_CHECKED : MF_UNCHECKED);
            }
            break;
        case WM_COMMAND:
            switch(LOWORD(wParam)) {
                case MENU_ABOUT:
                    AppPause(TRUE);
                    DialogBox(myglobs.hInstApp, "AppAbout", myglobs.hWndMain, (DLGPROC)AppAbout);
                    AppPause(FALSE);
                    break;
                case MENU_EXIT:
                    CleanUpAndPostQuit();
                    break;
                case MENU_STEP:        
					// Begin single step more or draw a frame if in single step mode
                    if (!myglobs.bSingleStepMode) {
                        myglobs.bSingleStepMode = TRUE;
                        myglobs.bDrawAFrame = TRUE;
                    } else if (!myglobs.bDrawAFrame) {
                        myglobs.bDrawAFrame = TRUE;
                    }
                    break;
                case MENU_GO:
					// Exit single step mode
                    if (myglobs.bSingleStepMode) {
                        myglobs.bSingleStepMode = FALSE;
                        ResetFrameRate();
                    }
                    break;
                case MENU_STATS:
					// Toggle output of frame rate and window info
                    if ((myglobs.bShowFrameRate) && (myglobs.bShowInfo)) {
                        myglobs.bShowFrameRate = FALSE;
                        myglobs.bShowInfo = FALSE;
                        break;
                    }
                    if ((!myglobs.bShowFrameRate) && (!myglobs.bShowInfo)) {
                        myglobs.bShowFrameRate = TRUE;
                        break;
                    }
                    myglobs.bShowInfo = TRUE;
                    break;
                case MENU_FULLSCREEN:
                    if (d3dapp->bFullscreen) {
                        /*
                         * Return to a windowed mode.  Let D3DApp decide which D3D driver to
                         * use in case this one cannot render to the Windows display depth
                         */
                        if (!D3DAppWindow(D3DAPP_YOUDECIDE, D3DAPP_YOUDECIDE)) {
                            ReportD3DAppError();
                            CleanUpAndPostQuit();
                            break;
                        }
                    } else {
                        /*
                         * Enter the current fullscreen mode.  D3DApp may resort to another 
                         * mode if this driver cannot do the currently selected mode.
                         */
                        if (!D3DAppFullscreen(d3dapp->CurrMode)) {
                            ReportD3DAppError();
                            CleanUpAndPostQuit();
                            break;
                        }
                    }
                    break;
                
				// Lighting toggle
                case MENU_LIGHTING:
                    myglobs.RenderQuality ^= D3DRMLIGHT_ON;
                    SetRenderState();
                    break;
                
				// Fill mode selection
                case MENU_POINT:
                    myglobs.RenderQuality = (myglobs.RenderQuality & ~D3DRMFILL_MASK) | D3DRMFILL_POINTS;
                    SetRenderState();
                    break;
                case MENU_WIREFRAME:
                    myglobs.RenderQuality = (myglobs.RenderQuality & ~D3DRMFILL_MASK) | D3DRMFILL_WIREFRAME;
                    SetRenderState();
                    break;
                case MENU_SOLID:
                    myglobs.RenderQuality = (myglobs.RenderQuality & ~D3DRMFILL_MASK) | D3DRMFILL_SOLID;
                    SetRenderState();
                    break;
                
				// Shade mode selection
                case MENU_FLAT:
                    myglobs.RenderQuality = (myglobs.RenderQuality & ~D3DRMSHADE_MASK) | D3DRMSHADE_FLAT;
                    SetRenderState();
                    break;
                case MENU_GOURAUD:
                    myglobs.RenderQuality = (myglobs.RenderQuality & ~D3DRMSHADE_MASK) | D3DRMSHADE_GOURAUD;
                    SetRenderState();
                    break;
                case MENU_PHONG:
                    myglobs.RenderQuality = (myglobs.RenderQuality & ~D3DRMSHADE_MASK) | D3DRMSHADE_PHONG;
                    SetRenderState();
                    break;
                case MENU_DITHERING:
                    myglobs.bDithering = !myglobs.bDithering;
                    SetRenderState();
                    break;
                case MENU_ANTIALIAS:
                    myglobs.bAntialiasing = !myglobs.bAntialiasing;
                    SetRenderState();
                    break;
                
				// Texture filter selection
                case MENU_POINT_FILTER:
                    if (myglobs.TextureQuality == D3DRMTEXTURE_NEAREST)
                        break;
                    myglobs.TextureQuality = D3DRMTEXTURE_NEAREST;
                    SetRenderState();
                    break;
                case MENU_LINEAR_FILTER:
                    if (myglobs.TextureQuality == D3DRMTEXTURE_LINEAR)
                        break;
                    myglobs.TextureQuality = D3DRMTEXTURE_LINEAR;
                    SetRenderState();
                    break;
                case MENU_NEXT_MODE:
                    // Enter the next usable fullscreen mode
                    i = d3dapp->CurrMode;
                    do {
                        ++i;
                        if (i >= d3dapp->NumModes)
                            i = 0;
                        if (!d3dapp->Mode[i].bThisDriverCanDo)
                            continue;
                        else {
                            if (!D3DAppFullscreen(i)) {
                                ReportD3DAppError();
                                CleanUpAndPostQuit();
                            }
                            break;
                        }
                    } while(i != d3dapp->CurrMode);
                    break;
                case MENU_PREVIOUS_MODE:
                    // Enter the previous usable fullscreen mode
                    i = d3dapp->CurrMode;
                    do {
                        --i;
                        if (i < 0)
                            i = d3dapp->NumModes - 1;
                        if (!d3dapp->Mode[i].bThisDriverCanDo)
                            continue;
                        else {
                            if (!D3DAppFullscreen(i)) {
                                ReportD3DAppError();
                                CleanUpAndPostQuit();
                            }
                            break;
                        }
                    } while(i != d3dapp->CurrMode);
                    break;
            }
            if (   LOWORD(wParam) >= MENU_FIRST_DRIVER
                && LOWORD(wParam) < MENU_FIRST_DRIVER + D3DAPP_MAXD3DDRIVERS
                && d3dapp->CurrDriver != LOWORD(wParam) - MENU_FIRST_DRIVER) {
                // Change the D3D driver
                if (!D3DAppChangeDriver(LOWORD(wParam) - MENU_FIRST_DRIVER,
                                        NULL)) {
                    ReportD3DAppError();
                    CleanUpAndPostQuit();
                }
            }
            if (   LOWORD(wParam) >= MENU_FIRST_MODE
                && LOWORD(wParam) < MENU_FIRST_MODE+100) {
                // Switch to the selected fullscreen mode
                if (!D3DAppFullscreen(LOWORD(wParam) - MENU_FIRST_MODE)) {
                    ReportD3DAppError();
                    CleanUpAndPostQuit();
                }
            }
            if (   LOWORD(wParam) >= MENU_FIRST_DDDRIVER
                && LOWORD(wParam) < MENU_FIRST_DDDRIVER + D3DAPP_MAXDDDRIVERS
                && myglobs.CurrDDDriver != LOWORD(wParam) - MENU_FIRST_DDDRIVER) {
                // Change the DD driver
                DestroyD3DApp();
                myglobs.CurrDDDriver = LOWORD(wParam) - MENU_FIRST_DDDRIVER;
                SetWindowPos(myglobs.hWndMain, HWND_NOTOPMOST, 0, 0, START_WIN_SIZE, START_WIN_SIZE, SWP_NOMOVE | SWP_SHOWWINDOW);
                if (!CreateD3DApp(myglobs.lpCmdLine))
                    return FALSE;
            }
            // Whenever we receive a command in single step mode, draw a frame
            if (myglobs.bSingleStepMode)
                myglobs.bDrawAFrame = TRUE;
            return 0L;
    }
    return DefWindowProc(hWnd, message, wParam, lParam);
}

//==================================================
//            Additional Functions                  
//==================================================

//--------------------------------------------------------------------------------
// Name: ReadMouse()
// Desc: Returns the mouse status for interaction with sample code
//--------------------------------------------------------------------------------

void
ReadMouse(int* b, int* x, int* y)
{
    *b = myglobs.mouse_buttons;
    *x = myglobs.mouse_x;
    *y = myglobs.mouse_y;
}

//--------------------------------------------------------------------------------
// Name: SetRenderState()
// Desc: Set the render quality, dither toggle and shade info 
//		 if any of them has changed
//--------------------------------------------------------------------------------

BOOL
SetRenderState(void)
{
    HRESULT rval;
    // Set the number of buffers so D3DRM can keep track of extents properly
    rval = myglobs.dev->SetBufferCount(d3dapp->bFullscreen &&
                                       d3dapp->bBackBufferInVideo ? 2 : 1);
    if (rval != D3DRM_OK) {
        Msg("Setting the buffer count failed.\n%s", D3DAppErrorToString(rval));
        return FALSE;
    }
    // Set the render quality (light toggle, fill mode, shade mode)
    if (myglobs.dev->GetQuality() != myglobs.RenderQuality) {
        rval = myglobs.dev->SetQuality(myglobs.RenderQuality);
        if (rval != D3DRM_OK) {
            Msg("Setting the render quality failed.\n%s",
                D3DAppErrorToString(rval));
            return FALSE;
        }
    }
    // Set dithering toggle
    if (myglobs.dev->GetDither() != myglobs.bDithering) {
        rval = myglobs.dev->SetDither(myglobs.bDithering);
        if (rval != D3DRM_OK) {
            Msg("Setting dither mode failed.\n%s", D3DAppErrorToString(rval));
            return FALSE;
        }
    }
    // Set the texture quality (point or linear filtering)
    if (myglobs.dev->GetTextureQuality() != myglobs.TextureQuality) {
        rval = myglobs.dev->SetTextureQuality(myglobs.TextureQuality);
        if (rval != D3DRM_OK) {
            Msg("Setting texture quality failed.\n%s",
                D3DAppErrorToString(rval));
            return FALSE;
        }
    }
    // Set shade info based on current bits per pixel
    switch (d3dapp->ThisMode.bpp) {
        case 1:
            if (FAILED(myglobs.dev->SetShades(4)))
                goto shades_error;
            if (FAILED(lpD3DRM->SetDefaultTextureShades(4)))
                goto shades_error;
            break;
        case 16:
            if (FAILED(myglobs.dev->SetShades(32)))
                goto shades_error;
            if (FAILED(lpD3DRM->SetDefaultTextureColors(64)))
                goto shades_error;
            if (FAILED(lpD3DRM->SetDefaultTextureShades(32)))
                goto shades_error;
            break;
        case 24:
        case 32:
            if (FAILED(myglobs.dev->SetShades(256)))
                goto shades_error;
            if (FAILED(lpD3DRM->SetDefaultTextureColors(64)))
                goto shades_error;
            if (FAILED(lpD3DRM->SetDefaultTextureShades(256)))
                goto shades_error;
            break;
    }
    return TRUE;
shades_error:
    Msg("A failure occurred while setting color shade information.\n");
    return FALSE;
}

//===============================================================
//    Initialization, error reporting and release functions.          
//===============================================================

//--------------------------------------------------------------------------------
// Name: InitGlobals()
// Desc: Called once at program initialization to initialize global variables.
//--------------------------------------------------------------------------------

static void
InitGlobals(void)
{
    d3dapp = NULL;
    memset(&myglobs, 0, sizeof(myglobs));
    myglobs.bShowFrameRate = TRUE;
    myglobs.bShowInfo = TRUE;
    myglobs.RenderQuality = D3DRMLIGHT_ON | D3DRMFILL_SOLID |
                            D3DRMSHADE_GOURAUD;
    myglobs.TextureQuality = D3DRMTEXTURE_NEAREST;

}

//--------------------------------------------------------------------------------
// Name: CleanUpAndPostQuit()
// Desc: Release all D3D objects, post a quit message and set the bQuit flag
//--------------------------------------------------------------------------------

void
CleanUpAndPostQuit(void)
{
	//release surface
	SAFE_DELETE (TestText);
	SAFE_DELETE (TestText2);
	SAFE_DELETE (TestText3);
	SAFE_DELETE (TestText4);
	SAFE_DELETE (TestBmp);
	SAFE_DELETE (TestBmp2);

    if (myglobs.bQuit)
        return;
    if (!D3DAppDestroy())
        ReportD3DAppError();

	DeleteObject (TestFont);

	SAFE_DELETE (g_Joystick);
	SAFE_DELETE (g_Keyboard);
	SAFE_DELETE (g_Input);
	SAFE_DELETE (g_Map);

	//release buffer
delete buffer_t;
delete buffer_t2;
delete buffer_t0;

//release sound
delete sound_t;
    
	RELEASE(myglobs.scene);
	RELEASE(myglobs.plane);
    RELEASE(myglobs.camera);
    RELEASE(lpD3DRM);

    myglobs.bQuit = TRUE;
    PostQuitMessage( 0 );
}

//--------------------------------------------------------------------------------
// Name: ReportD3DAppError()
// Desc: Reports an error during a d3d app call.
//--------------------------------------------------------------------------------

void
ReportD3DAppError(void)
{
    Msg("%s", D3DAppLastErrorString());
}

//--------------------------------------------------------------------------------
// Name: Msg()
// Desc: Message output for error notification.
//--------------------------------------------------------------------------------

void __cdecl
Msg( LPSTR fmt, ... )
{
    char buff[256];
    va_list args;

    va_start(args, fmt);
    wvsprintf(buff, fmt, args);
    va_end(args);

    lstrcat(buff, "\r\n");
    AppPause(TRUE);
    if (d3dapp && d3dapp->bFullscreen)
        SetWindowPos(myglobs.hWndMain, HWND_NOTOPMOST, 0, 0, 0, 0,
                     SWP_NOSIZE | SWP_NOMOVE);
    MessageBox( NULL, buff, "D3D Example Message", MB_OK );
    if (d3dapp && d3dapp->bFullscreen)
        SetWindowPos(myglobs.hWndMain, HWND_TOPMOST, 0, 0, 0, 0,
                     SWP_NOSIZE | SWP_NOMOVE);
    AppPause(FALSE);
}

//--------------------------------------------------------------------------------
// Name: D3DRMErrorToString()
// Desc: Allows the samples to return error strings.
//--------------------------------------------------------------------------------

char*
D3DRMErrorToString(HRESULT error)
{
    return D3DAppErrorToString(error);
}

//-----------------------------------------------------------------------------
// Name: MoveCameraCallback()
// Desc:
//-----------------------------------------------------------------------------

VOID MoveCameraCallback(LPDIRECT3DRMFRAME3 camera, void*, D3DVALUE)
{	
	LPDIRECT3DRMFRAMEARRAY frame_array;
	LPDIRECT3DRMFRAME frame;
	LPDIRECT3DRMFRAME3 frame3;
	if (FAILED (camera->GetChildren (&frame_array)))
		goto generic_error;
	if (FAILED (frame_array->GetElement (0, &frame)))
		goto generic_error;
	if (FAILED (frame->QueryInterface (IID_IDirect3DRMFrame3, (void**)&frame3)))
		goto generic_error;
		
	//dinput***** 
	g_Keyboard->GetState();
    g_Joystick -> GetState(); //
	g_Joystick -> GetX(); 
	g_Joystick -> GetY(); 
	g_Joystick -> GetZ(); 
	g_Joystick -> GetB1();
	g_Joystick -> GetB2();
	g_Joystick -> GetB3();
	g_Joystick -> GetB4();
	//****
	
	if ( GAME_STATUS == GAME_TITLE )
	{
		
	
	//--------------------
	// Play title sound
	//--------------------
	if (TITLESONG == FALSE)
	{ 
		buffer_t->Play (DSBPLAY_LOOPING);
		TITLESONG = TRUE;
	}
	
		//*********choose Start Game(channge state to PLAY_NORMAL) OR Quit
		if (ENTERGAME == TRUE)
			switch (STARTGAME)
		{
			case TRUE:
				buffer_t->Stop ();
				buffer_t2->Play (DSBPLAY_LOOPING);
				camera->SetPosition (pWorldFrame, D3DVAL (0), D3DVAL (25), D3DVAL (0));
				camera->SetOrientation (pWorldFrame, 0, 0, 1, 0, 1, 0);
				ENTERGAME = FALSE;
				GAME_STATUS = GAME_PLAY;
				counttime = 0;
				checkpoint = 0;
				ROUTE = 1;
				break;
			
			case FALSE:
			
				//CleanUpAndPostQuit();
				PostQuitMessage( 0 );
				break;
		}
	}
		
	
	if ( GAME_STATUS == GAME_OVER )
	{	
		Time_Best = Time_R1;
		if (Time_Best >= Time_R2)
			Time_Best = Time_R2; 
		if (Time_Best >= Time_R3)
			Time_Best = Time_R3;
		
		if (ENTERGAME == TRUE)
			switch (STARTGAME)
		{
			case TRUE:
				
				camera->SetPosition (pWorldFrame, D3DVAL (0), D3DVAL (25), D3DVAL (0));
				camera->SetOrientation (pWorldFrame, 0, 0, 1, 0, 1, 0);
				ENTERGAME = FALSE;
				GAME_STATUS = GAME_PLAY;
				counttime = 0;
				checkpoint = 0;
				ROUTE = 1;
				break;
			
			case FALSE:
				//CleanUpAndPostQuit();
				PostQuitMessage (0);
				break;
		}
		
	}

	if ( GAME_STATUS == GAME_PAUSE )
	{	
	
		if (PAUSEGAME == FALSE)
			GAME_STATUS = GAME_PLAY;

		if (ENTERGAME == TRUE)
			switch (STARTGAME)
		{
			case TRUE:
				
				camera->SetPosition (pWorldFrame, D3DVAL (0), D3DVAL (25), D3DVAL (0));
				camera->SetOrientation (pWorldFrame, 0, 0, 1, 0, 1, 0);
				PAUSEGAME = FALSE;
				ENTERGAME = FALSE;
				GAME_STATUS = GAME_PLAY;
				counttime = 0;
				checkpoint = 0;
				ROUTE = 1;
				break;
			
			case FALSE:
				
				//CleanUpAndPostQuit();
				PostQuitMessage (0);
				break;
		}
		
	}



	if ( GAME_STATUS == GAME_PLAY )
	{	
	
		PLAY_STATUS = NORMAL;
		ENTERGAME = FALSE;
	
		
		//***************
		if (PAUSEGAME == TRUE)
			GAME_STATUS = GAME_PAUSE;
		
		// clock
		if (counttime == 0)
		{
			Time_0 = GetTickCount()/1000;
			counttime = 1;
		}
		if (counttime == 1)
			Time_n = GetTickCount()/1000 - Time_0;
		
	
		//move all the time
		camera->SetPosition (camera, D3DVAL (0), D3DVAL (0), D3DVAL (2));
		D3DVECTOR pos;
		D3DVECTOR pos2;
		camera->GetPosition (pWorldFrame, &pos);
		frame3->GetPosition (pWorldFrame, &pos2);
		int i; 
		int j; 
		int j2; 
		int i2;
		i = -(int)(( pos.z/50 * 100 ) / 100 -40)  ; //  - /50 
		j = (int)(( pos.x/50 * 100 ) / 100 +40);
		i2 = -(int)(( pos2.z/50 * 100 ) / 100 -40); // -
		j2 = (int)(( pos2.x/50 * 100 ) / 100 +40);
			
		//check level ***********
		building_y = 0;
		if (g_Map->GetBlockType (i, j) == TYPE_BUILDING)
		{
				switch (g_Map->GetBlockLevel (i, j))
				{
				case 1:
					building_y = 25;
					break;
				case 2:
					building_y = 34;
					break;
				case 3:
					building_y = 55;
					break;
				case 4:
					building_y = 84;
					break;
				case 5:
					building_y = 96;
					break;
				case 6:
					building_y = 112;
					break;
				case 7:
					building_y = 128;
					break;
				case 8:
					building_y = 144;
					break;
				case 9:
					building_y = 192;
					break;
				case 10:
					building_y = 416;
					break;
			
				}
		}
			
		
		
		if (i < 0 || i >= MAX_BLOCK ||
			j < 0 || j >= MAX_BLOCK ||
			i2 < 0 || i2 >= MAX_BLOCK ||
			j2 < 0 || j2 >= MAX_BLOCK ||
			pos2.y < 5 || pos2.y > 200 || //****
			pos.y <= building_y || //*******
			g_Map->GetBlockType (i2, j2) == TYPE_BUILDING) 
			{
				camera->SetPosition (camera,
									 D3DVAL (0),
									 D3DVAL (0),
									 -D3DVAL (2));
				PLAY_STATUS = HIT;
			}
			
		//checkpoint : complete route?? **********
			if ( i<= 12 ) checkpoint = 1;
			if ( j>= 49 && checkpoint == 1 ) checkpoint =2;
			if ( i>= 69 && checkpoint == 2 ) checkpoint =3;
			if ( j<= 27 && checkpoint == 3 ) checkpoint =4;
			if ( i<= 64 && checkpoint == 4 ) checkpoint =5;
			if ( j>= 37 && checkpoint == 5 ) checkpoint =6;
			if ( i<= 40 && checkpoint == 6 ) checkpoint =7;
		// complete lab ??			
			if (checkpoint >= 7 )
			{
				switch (ROUTE)
				{
				case 1:
					Time_R1 = Time_n;
					counttime = 0;
					ROUTE = 2;
					checkpoint = 0;
					break;

				case 2:
					Time_R2 = Time_n;
					counttime = 0;
					ROUTE = 3;
					checkpoint = 0;
					break;

				case 3:
					Time_R3 = Time_n;
					GAME_STATUS = GAME_OVER;
					checkpoint = 0;
					break;
				}
			}

		// move forward
	if (g_Keyboard->keyboard_state[DIK_NUMPAD0] || (g_Joystick -> m_Buttons[0] && g_bjoystick == TRUE))
		{
			camera->SetPosition (camera,
								 D3DVAL (0),
								 D3DVAL (0),
								 D3DVAL (const_up));
			D3DVECTOR pos;
			D3DVECTOR pos2;
			camera->GetPosition (pWorldFrame, &pos);	
			frame3->GetPosition (pWorldFrame, &pos2);	
			
			int i = -(int)(( pos.z/50 * 100 ) / 100 -40)  ;  
			int j = (int)(( pos.x/50 * 100 ) / 100 +40);
			int i2 = -(int)(( pos2.z/50 * 100 ) / 100 -40); 
			int j2 = (int)(( pos2.x/50 * 100 ) / 100 +40);

			
			//check level ***********
		building_y = 0;
		if (g_Map->GetBlockType (i, j) == TYPE_BUILDING)
		{
				switch (g_Map->GetBlockLevel (i, j))
				{
				case 1:
					building_y = 25;
					break;
				case 2:
					building_y = 34;
					break;
				case 3:
					building_y = 55;
					break;
				case 4:
					building_y = 84;
					break;
				case 5:
					building_y = 96;
					break;
				case 6:
					building_y = 112;
					break;
				case 7:
					building_y = 128;
					break;
				case 8:
					building_y = 144;
					break;
				case 9:
					building_y = 192;
					break;
				case 10:
					building_y = 416;
					break;
			
				}
		}

			if (i < 0 || i >= MAX_BLOCK ||
				j < 0 || j >= MAX_BLOCK ||
				i2 < 0 || i2 >= MAX_BLOCK ||
				j2 < 0 || j2 >= MAX_BLOCK ||
				pos2.y < 5 || pos2.y > 200 || 
				pos.y <= building_y || 
				g_Map->GetBlockType (i2, j2) == TYPE_BUILDING) 
			{
				camera->SetPosition (camera,
									 D3DVAL (0),
									 D3DVAL (0),
									 -D3DVAL (const_up));
				PLAY_STATUS = HIT;
			}
			
		
							
			
		
		}




	// move back
	if (g_Keyboard->keyboard_state[DIK_DECIMAL] || (g_Joystick -> m_Buttons[1] && g_bjoystick == TRUE))
		{
			camera->SetPosition (camera,
								 D3DVAL (0),
								 D3DVAL (0),
								 -D3DVAL (const_up));
			D3DVECTOR pos;
			D3DVECTOR pos2;
			camera->GetPosition (pWorldFrame, &pos);	//g_KDX->GetScene
			frame3->GetPosition (pWorldFrame, &pos2);	//g_KDX->GetScene
			
			int i = -(int)(( pos.z/50 * 100 ) / 100 -40)  ; //  - /50 
			int j = (int)(( pos.x/50 * 100 ) / 100 +40);
			int i2 = -(int)(( pos2.z/50 * 100 ) / 100 -40); // -
			int j2 = (int)(( pos2.x/50 * 100 ) / 100 +40);
			
					
			//check level ***********
		building_y = 0;
		if (g_Map->GetBlockType (i, j) == TYPE_BUILDING)
		{
				switch (g_Map->GetBlockLevel (i, j))
				{
				case 1:
					building_y = 25;
					break;
				case 2:
					building_y = 34;
					break;
				case 3:
					building_y = 55;
					break;
				case 4:
					building_y = 84;
					break;
				case 5:
					building_y = 96;
					break;
				case 6:
					building_y = 112;
					break;
				case 7:
					building_y = 128;
					break;
				case 8:
					building_y = 144;
					break;
				case 9:
					building_y = 192;
					break;
				case 10:
					building_y = 416;
					break;
				/*case 11:
					building_y = 416;
					break;*/
				}
		}

			if (i < 0 || i >= MAX_BLOCK ||
				j < 0 || j >= MAX_BLOCK ||
				i2 < 0 || i2 >= MAX_BLOCK ||
				j2 < 0 || j2 >= MAX_BLOCK ||
				pos2.y < 0 || pos2.y > 200 || //****
				g_Map->GetBlockType (i2, j2) == TYPE_BUILDING) //i2j2
			{
				camera->SetPosition (camera,
									 D3DVAL (0),
									 D3DVAL (0),
									 D3DVAL (const_up));
				PLAY_STATUS = HIT;
			}
		
		}


	// turn left
	if (g_Keyboard->keyboard_state[DIK_LEFT] || (g_Joystick -> m_X < -100 && g_bjoystick == TRUE))
		camera->SetOrientation (camera, -D3DVAL (const_sin), 0, D3DVAL (const_cos), 0, 1, 0);
	// turn right
	if (g_Keyboard->keyboard_state[DIK_RIGHT] || (g_Joystick -> m_X > 100 && g_bjoystick == TRUE))
		camera->SetOrientation (camera, D3DVAL (const_sin), 0, D3DVAL (const_cos), 0, 1, 0);

	D3DVECTOR orient_z, orient_y;
	//D3DVECTOR orient_z, orient_y;
	// face up
	camera->GetOrientation (pWorldFrame, &orient_z, &orient_y);  
	if (g_Keyboard->keyboard_state[DIK_DOWN] || (g_Joystick -> m_Y > 100&& g_bjoystick == TRUE))
		camera->SetOrientation (pWorldFrame, orient_z.x, 
								orient_z.y+D3DVAL(const_sin), orient_z.z,
								orient_y.x, orient_y.y, orient_y.z);
	// face down
	if (g_Keyboard->keyboard_state[DIK_UP] || (g_Joystick -> m_Y < -100 && g_bjoystick == TRUE))
		camera->SetOrientation (pWorldFrame, orient_z.x, 
								orient_z.y-D3DVAL(const_sin), orient_z.z,
								orient_y.x, orient_y.y, orient_y.z);
	
	if (PLAY_STATUS == HIT)
	{
		if (CK_HIT_SOUND == 10)
		{
		buffer_t0 = new CBuffer;
		buffer_t0->Create (sound_t, "ding.wav", 1);
		buffer_t0->Play (0);
		SAFE_DELETE (buffer_t0);
		CK_HIT_SOUND = 0;
		}
		else CK_HIT_SOUND++;
	
	}
	

	}

	SAFE_RELEASE (frame3);
	SAFE_RELEASE (frame);
	SAFE_RELEASE (frame_array);

generic_error:
	SAFE_RELEASE (frame3);
	SAFE_RELEASE (frame);
	SAFE_RELEASE (frame_array);

}

//-----------------------------------------------------------------------------
// Name: BuildScene()
// Desc:
//-----------------------------------------------------------------------------
BOOL BuildScene( LPDIRECT3DRM3 pD3DRM,
				 LPDIRECT3DRMDEVICE3 pDevice, LPDIRECT3DRMVIEWPORT2 pViewport,
	             LPDIRECT3DRMFRAME3 pScene,  LPDIRECT3DRMFRAME3 pCamera )
{
    LPDIRECT3DRMFRAME3 lights = NULL;
    D3DRMBOX box; //****
    LPDIRECT3DRMMESHBUILDER3 mesh_builder = NULL;
    LPDIRECT3DRMLIGHT ambient = NULL;
    LPDIRECT3DRMLIGHT point1 = NULL;
	LPDIRECT3DRMLIGHT point2 = NULL;
	LPDIRECT3DRMLIGHT point3 = NULL;
	LPDIRECT3DRMLIGHT point4 = NULL;
    LPDIRECT3DRMFRAME3 frame = NULL;


	pWorldFrame = pScene;


	//===================================================
	// Environment
	//===================================================
	COLORREF rgb_sky = RGB (200, 200, 255);
	D3DCOLOR d3d_sky = COLORREF_2_D3DCOLOR (rgb_sky);
	if (FAILED (pScene->SetSceneBackgroundRGB (D3DRMColorGetRed (d3d_sky),
											   D3DRMColorGetGreen (d3d_sky),
											   D3DRMColorGetBlue (d3d_sky))))
		goto generic_error;
	if (FAILED (pScene->SetSceneFogColor (d3d_sky)))
		goto generic_error;
	if (FAILED (pScene->SetSceneFogEnable (TRUE)))
		goto generic_error;
	if (FAILED (pScene->SetSceneFogMethod (D3DRMFOGMETHOD_ANY)))
		goto generic_error;
	if (FAILED (pScene->SetSceneFogParams (D3DVAL (0), D3DVAL (2000), D3DVAL (0.6))))
		goto generic_error;
	//===================================================
	
	// set camera position in title
	if (FAILED (pCamera->SetPosition (pScene, D3DVAL (0), D3DVAL (60), -D3DVAL (1200))))
		goto generic_error;
	
	LPDIRECT3DRMFRAME3 postcamera;
	if (FAILED (pD3DRM->CreateFrame (pCamera, &postcamera)))
		goto generic_error;
	if (FAILED (postcamera->SetPosition (pCamera, D3DVAL (0), D3DVAL (0), D3DVAL (2))))
		goto generic_error;

    if( FAILED( pViewport->SetField( 0.3f ) ) )
		goto generic_error;
    if( FAILED( pDevice->SetQuality( D3DRMRENDER_GOURAUD ) ) )
		goto generic_error;

	// initialize the lights in the scene
    if( FAILED( pD3DRM->CreateFrame( pScene, &lights ) ) )
		goto generic_error;
    if( FAILED( lights->SetPosition( pScene, 500.0f, 500.0f, -500.0f ) ) )
		goto generic_error;

	// point1
	LPDIRECT3DRMFRAME3 frame1;
	if (FAILED (pD3DRM->CreateFrame (pScene, &frame1)))
		goto generic_error;
	if (FAILED (frame1->SetPosition (pScene, -D3DVAL (2000), D3DVAL (2000), -D3DVAL (2000))))
		goto generic_error;
    if( FAILED( pD3DRM->CreateLightRGB( D3DRMLIGHT_POINT,
		                                  0.8f, 0.8f, 0.8f, &point1 ) ) )
		goto generic_error;
	if( FAILED( frame1->AddLight( point1 ) ) )
		goto generic_error;
	SAFE_RELEASE (frame1);
	SAFE_RELEASE (point1);

	// point2
	LPDIRECT3DRMFRAME3 frame2;
	if (FAILED (pD3DRM->CreateFrame (pScene, &frame2)))
		goto generic_error;
	if (FAILED (frame2->SetPosition (pScene, D3DVAL (2000), D3DVAL (2000), -D3DVAL (2000))))
		goto generic_error;
    if( FAILED( pD3DRM->CreateLightRGB( D3DRMLIGHT_POINT,
		                                  0.8f, 0.8f, 0.8f, &point2 ) ) )
		goto generic_error;
	if( FAILED( frame2->AddLight( point2 ) ) )
		goto generic_error;
	SAFE_RELEASE (frame2);
	SAFE_RELEASE (point2); 
	
	// point3
	LPDIRECT3DRMFRAME3 frame3;
	if (FAILED (pD3DRM->CreateFrame (pScene, &frame3)))
		goto generic_error;
	if (FAILED (frame3->SetPosition (pScene, -D3DVAL (2000), D3DVAL (2000), D3DVAL (2000))))
		goto generic_error;
    if( FAILED( pD3DRM->CreateLightRGB( D3DRMLIGHT_POINT,
		                                  0.6f, 0.6f, 0.6f, &point3 ) ) )
		goto generic_error;
	if( FAILED( frame3->AddLight( point3 ) ) )
		goto generic_error;
	SAFE_RELEASE (frame3);
	SAFE_RELEASE (point3);

	// point4
	LPDIRECT3DRMFRAME3 frame4;
	if (FAILED (pD3DRM->CreateFrame (pScene, &frame4)))
		goto generic_error;
	if (FAILED (frame4->SetPosition (pScene, D3DVAL (2000), D3DVAL (2000), D3DVAL (2000))))
		goto generic_error;
    if( FAILED( pD3DRM->CreateLightRGB( D3DRMLIGHT_POINT,
		                                  0.6f, 0.6f, 0.6f, &point4 ) ) )
		goto generic_error;
	if( FAILED( frame4->AddLight( point4 ) ) )
		goto generic_error;
	SAFE_RELEASE (frame4);
	SAFE_RELEASE (point4); 
    
	// ambient
    if( FAILED( pD3DRM->CreateLightRGB( D3DRMLIGHT_AMBIENT,
		                                  0.1f, 0.1f, 0.1f, &ambient ) ) )
		goto generic_error;
    if( FAILED( pScene->AddLight( ambient ) ) )
		goto generic_error;

    // load mesh file
    if( FAILED( pD3DRM->CreateFrame( pScene, &frame ) ) )
		goto generic_error;
    if( FAILED( pD3DRM->CreateMeshBuilder( &mesh_builder ) ) )
		goto generic_error;
    if( FAILED( mesh_builder->Load( "test.x", NULL, D3DRMLOAD_FROMFILE,
		                            NULL, NULL ) ) )
		goto generic_error;
    if( FAILED( mesh_builder->Scale( 1.0f, 1.0f, 1.0f ) ) ) //
		goto generic_error;
    //****
	if( FAILED( mesh_builder->GetBox( &box ) ) )
		goto generic_error;
    if( FAILED( frame->AddVisual( (LPDIRECT3DRMVISUAL)mesh_builder ) ) ) //mesh
		goto generic_error;

	//load environment
	LPDIRECT3DRMFRAME3 envirframe ;
	LPDIRECT3DRMMESHBUILDER3 envirbuilder ;
	if (FAILED(pD3DRM->CreateFrame(pScene, &envirframe)))
	goto generic_error;
    if (FAILED(pD3DRM->CreateMeshBuilder(&envirbuilder)))
	goto generic_error;
    if (FAILED(envirbuilder->Load("envrm.x", NULL, D3DRMLOAD_FROMFILE, NULL, NULL)))
	goto generic_error;
    if (FAILED(envirframe->AddVisual(envirbuilder)))
	goto generic_error;
    SAFE_RELEASE(envirbuilder);
    SAFE_RELEASE(envirframe);

	//load environment2
	LPDIRECT3DRMFRAME3 envir2frame ;
	LPDIRECT3DRMMESHBUILDER3 envir2builder ;
	if (FAILED(pD3DRM->CreateFrame(pScene, &envir2frame)))
	goto generic_error;
    if (FAILED(pD3DRM->CreateMeshBuilder(&envir2builder)))
	goto generic_error;
    if (FAILED(envir2builder->Load("envrm2.x", NULL, D3DRMLOAD_FROMFILE, NULL, NULL)))
	goto generic_error;
    if (FAILED(envir2frame->AddVisual(envir2builder)))
	goto generic_error;
    SAFE_RELEASE(envir2builder);
    SAFE_RELEASE(envir2frame);

	//load B
	LPDIRECT3DRMFRAME3 bframe ;
	LPDIRECT3DRMMESHBUILDER3 bbuilder ;
	if (FAILED(pD3DRM->CreateFrame(pScene, &bframe)))
	goto generic_error;
    if (FAILED(pD3DRM->CreateMeshBuilder(&bbuilder)))
	goto generic_error;
    if (FAILED(bbuilder->Load("b.x", NULL, D3DRMLOAD_FROMFILE, NULL, NULL)))
	goto generic_error;
    if (FAILED(bframe->AddVisual(bbuilder)))
	goto generic_error;
    SAFE_RELEASE(bbuilder);
    SAFE_RELEASE(bframe);

	
	//load civil
	LPDIRECT3DRMFRAME3 civilframe ;
	LPDIRECT3DRMMESHBUILDER3 civilbuilder ;
	if (FAILED(pD3DRM->CreateFrame(pScene, &civilframe)))
	goto generic_error;
    if (FAILED(pD3DRM->CreateMeshBuilder(&civilbuilder)))
	goto generic_error;
    if (FAILED(civilbuilder->Load("civil.x", NULL, D3DRMLOAD_FROMFILE, NULL, NULL)))
	goto generic_error;
    if (FAILED(civilframe->AddVisual(civilbuilder)))
	goto generic_error;
    SAFE_RELEASE(civilbuilder);
    SAFE_RELEASE(civilframe);

	//load e12
	LPDIRECT3DRMFRAME3 e12frame ;
	LPDIRECT3DRMMESHBUILDER3 e12builder ;
	if (FAILED(pD3DRM->CreateFrame(pScene, &e12frame)))
	goto generic_error;
    if (FAILED(pD3DRM->CreateMeshBuilder(&e12builder)))
	goto generic_error;
    if (FAILED(e12builder->Load("e12.x", NULL, D3DRMLOAD_FROMFILE, NULL, NULL)))
	goto generic_error;
    if (FAILED(e12frame->AddVisual(e12builder)))
	goto generic_error;
    SAFE_RELEASE(e12builder);
    SAFE_RELEASE(e12frame);

	//load food
	LPDIRECT3DRMFRAME3 foodframe ;
	LPDIRECT3DRMMESHBUILDER3 foodbuilder ;
	if (FAILED(pD3DRM->CreateFrame(pScene, &foodframe)))
	goto generic_error;
    if (FAILED(pD3DRM->CreateMeshBuilder(&foodbuilder)))
	goto generic_error;
    if (FAILED(foodbuilder->Load("food.x", NULL, D3DRMLOAD_FROMFILE, NULL, NULL)))
	goto generic_error;
    if (FAILED(foodframe->AddVisual(foodbuilder)))
	goto generic_error;
    SAFE_RELEASE(foodbuilder);
    SAFE_RELEASE(foodframe);
	
	//load hall
	LPDIRECT3DRMFRAME3 hallframe ;
	LPDIRECT3DRMMESHBUILDER3 hallbuilder ;
	if (FAILED(pD3DRM->CreateFrame(pScene, &hallframe)))
	goto generic_error;
    if (FAILED(pD3DRM->CreateMeshBuilder(&hallbuilder)))
	goto generic_error;
    if (FAILED(hallbuilder->Load("hall.x", NULL, D3DRMLOAD_FROMFILE, NULL, NULL)))
	goto generic_error;
    if (FAILED(hallframe->AddVisual(hallbuilder)))
	goto generic_error;
    SAFE_RELEASE(hallbuilder);
    SAFE_RELEASE(hallframe);

	//*********show game title**********
	GAME_STATUS = GAME_TITLE;
	
	if( FAILED( pCamera->AddMoveCallback( MoveCameraCallback, NULL, 0 ) ) )
		goto generic_error;

    SAFE_RELEASE( lights );
    SAFE_RELEASE( mesh_builder );
    SAFE_RELEASE( ambient );
    SAFE_RELEASE( frame );
	SAFE_RELEASE( postcamera );
    return TRUE;

generic_error:
    Msg("A failure has occurred while building the scene.\n");
    SAFE_RELEASE( lights );
    SAFE_RELEASE( mesh_builder );
    SAFE_RELEASE( ambient );
    SAFE_RELEASE( frame );
	SAFE_RELEASE( postcamera );
	return FALSE;
}


//-----------------------------------------------------------------------------
// Name: OverrideDefaults()
// Desc: 
//-----------------------------------------------------------------------------
VOID OverrideDefaults( BOOL* pbNoTextures, BOOL* pbResizingDisabled, 
					   BOOL* pbConstRenderQuality, CHAR** pstrName )
{
	(*pbNoTextures) = TRUE;
    (*pbConstRenderQuality) = TRUE;
    (*pstrName)     = "KMITL"; //Fly Full-Screen Direct3DRM Example
}

