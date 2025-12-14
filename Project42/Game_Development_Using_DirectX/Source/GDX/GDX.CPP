/////////////////////////////////////////////////////////////////////////////
// File Name:		GDX.cpp
// Author:			Tiwakorn Komut
// Source File:		GDX Implementation
// Date:			16/05/2000
// Comment:			This is the last revision
/////////////////////////////////////////////////////////////////////////////
#include "GDX.h"

#define CREATEFONT(h, w, f) CreateFont (h, w, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, NONANTIALIASED_QUALITY, VARIABLE_PITCH, f)

const D3DVECTOR GDX::m_Path1[NUMBER_ROBOT1][NUMBER_KEYFRAME_ROBOT1] = {
									-D3DVAL (50), D3DVAL (0), -D3DVAL (170),
									-D3DVAL (50), D3DVAL (0), -D3DVAL (265),
									D3DVAL (130), D3DVAL (0), -D3DVAL (265),
									D3DVAL (130), D3DVAL (0), -D3DVAL (255),
									-D3DVAL (20), D3DVAL (0), -D3DVAL (255),
									-D3DVAL (20), D3DVAL (0), -D3DVAL (170),
									-D3DVAL (50), D3DVAL (0), -D3DVAL (170),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),

									D3DVAL (95), D3DVAL (0), -D3DVAL (94),
									D3DVAL (144), D3DVAL (0), -D3DVAL (94),
									D3DVAL (144), D3DVAL (0), -D3DVAL (143),
									D3DVAL (95), D3DVAL (0), -D3DVAL (143),
									D3DVAL (95), D3DVAL (0), -D3DVAL (94),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),

									D3DVAL (190), D3DVAL (0), -D3DVAL (195),
									D3DVAL (190), D3DVAL (0), -D3DVAL (330),
									D3DVAL (370), D3DVAL (0), -D3DVAL (330),
									D3DVAL (370), D3DVAL (0), -D3DVAL (195),
									D3DVAL (190), D3DVAL (0), -D3DVAL (195),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),

									D3DVAL (170), D3DVAL (0), -D3DVAL (90),
									D3DVAL (295), D3DVAL (0), -D3DVAL (90),
									D3DVAL (295), D3DVAL (0), -D3DVAL (160),
									D3DVAL (290), D3DVAL (0), -D3DVAL (160),
									D3DVAL (290), D3DVAL (0), -D3DVAL (100),
									D3DVAL (170), D3DVAL (0), -D3DVAL (100),
									D3DVAL (170), D3DVAL (0), -D3DVAL (90),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),

									D3DVAL (220), D3DVAL (18), -D3DVAL (210),
									D3DVAL (200), D3DVAL (18), -D3DVAL (225),
									D3DVAL (300), D3DVAL (18), -D3DVAL (225),
									D3DVAL (300), D3DVAL (18), -D3DVAL (220),
									D3DVAL (280), D3DVAL (18), -D3DVAL (220),
									D3DVAL (280), D3DVAL (18), -D3DVAL (210),
									D3DVAL (220), D3DVAL (18), -D3DVAL (210),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0) };

const D3DVECTOR GDX::m_Path2[NUMBER_ROBOT2][NUMBER_KEYFRAME_ROBOT2] = {
									D3DVAL (570), D3DVAL (0), -D3DVAL (170),
									D3DVAL (770), D3DVAL (0), -D3DVAL (170),
									D3DVAL (670), D3DVAL (0), -D3DVAL (260),
									D3DVAL (570), D3DVAL (0), -D3DVAL (170),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),

									D3DVAL (500), D3DVAL (0), -D3DVAL (170),
									D3DVAL (600), D3DVAL (0), -D3DVAL (260),
									D3DVAL (400), D3DVAL (0), -D3DVAL (260),
									D3DVAL (500), D3DVAL (0), -D3DVAL (170),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),

									D3DVAL (255), D3DVAL (8), -D3DVAL (258),
									D3DVAL (320), D3DVAL (8), -D3DVAL (258),
									D3DVAL (320), D3DVAL (8), -D3DVAL (276),
									D3DVAL (330), D3DVAL (8), -D3DVAL (276),
									D3DVAL (330), D3DVAL (8), -D3DVAL (284),
									D3DVAL (290), D3DVAL (8), -D3DVAL (284),
									D3DVAL (290), D3DVAL (8), -D3DVAL (264),
									D3DVAL (255), D3DVAL (8), -D3DVAL (264),
									D3DVAL (255), D3DVAL (8), -D3DVAL (258),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),

									D3DVAL (210), D3DVAL (2), -D3DVAL (290),
									D3DVAL (260), D3DVAL (2), -D3DVAL (290),
									D3DVAL (260), D3DVAL (2), -D3DVAL (300),
									D3DVAL (210), D3DVAL (2), -D3DVAL (300),
									D3DVAL (210), D3DVAL (2), -D3DVAL (290),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),

									-D3DVAL (50), D3DVAL (1), -D3DVAL (284),
									D3DVAL (50), D3DVAL (1), -D3DVAL (284),
									D3DVAL (50), D3DVAL (1), -D3DVAL (295),
									-D3DVAL (50), D3DVAL (1), -D3DVAL (295),
									-D3DVAL (50), D3DVAL (1), -D3DVAL (284),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),

									D3DVAL (170), D3DVAL (0), D3DVAL (0),
									D3DVAL (180), D3DVAL (0), D3DVAL (0),
									D3DVAL (180), D3DVAL (0), -D3DVAL (30),
									D3DVAL (170), D3DVAL (0), -D3DVAL (30),
									D3DVAL (170), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0),
									D3DVAL (0), D3DVAL (0), D3DVAL (0) };

const D3DVALUE GDX::m_PathTime1[NUMBER_ROBOT1][NUMBER_KEYFRAME_ROBOT1] = {
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f,
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f,
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f,
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f,
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f };
const D3DVALUE GDX::m_PathTime2[NUMBER_ROBOT2][NUMBER_KEYFRAME_ROBOT2] = {
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f,
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f,
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f,
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f,
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f,
			0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f };

const int GDX::m_NumKey1[NUMBER_ROBOT1] = {
											NUMBEROFKEY_ROBOT1_PATH1,
											NUMBEROFKEY_ROBOT1_PATH2,
											NUMBEROFKEY_ROBOT1_PATH3,
											NUMBEROFKEY_ROBOT1_PATH4,
											NUMBEROFKEY_ROBOT1_PATH5 };
const int GDX::m_NumKey2[NUMBER_ROBOT2] = {
											NUMBEROFKEY_ROBOT2_PATH1,
											NUMBEROFKEY_ROBOT2_PATH2,
											NUMBEROFKEY_ROBOT2_PATH3,
											NUMBEROFKEY_ROBOT2_PATH4,
											NUMBEROFKEY_ROBOT2_PATH5,
											NUMBEROFKEY_ROBOT2_PATH6 };

const char GDX::m_szStringGameTitle[NUMBER_STRING_GAME_TITLE][50] = {
														STRING_NEWGAME,
														STRING_OPTION,
														STRING_QUIT };
const char GDX::m_szStringGameOption[NUMBER_STRING_GAME_OPTION][50] = {
														STRING_EASY,
														STRING_NORMAL,
														STRING_HARD,
														STRING_HELLONEARTH };
const char GDX::m_szStringGamePause[NUMBER_STRING_GAME_PAUSE][50] = {
														STRING_RESUMEGAME,
														STRING_RETURNTOTITLE };

const D3DRMBOX GDX::m_BoxPlayer = {
									-2.5f, -5.0f, -3.0f,
									2.5f, 2.5f, 3.0f };
const D3DRMBOX GDX::m_BoxRobot1 = {
									-2.5f, 0.0f, -3.0f,
									2.5f, 7.5f, 3.0f };
const D3DRMBOX GDX::m_BoxRobot2 = {
									-2.5f, 0.0f, -2.5f,
									2.5f, 12.0f, 2.5f };
const D3DRMBOX GDX::m_BoxAmmo1 = {
									-0.5f, -0.5f, -1.5f,
									0.5f, 0.5f, 1.5f };
const D3DRMBOX GDX::m_BoxAmmo2 = {
									-0.5f, -0.5f, -1.5f,
									0.5f, 0.5f, 1.5f };

const double GDX::m_ConstSin = sin (0.05);
const double GDX::m_ConstCos = cos (0.05);

/////////////////////////////////////////////////////////////////////////////
// GDX Constructor
/////////////////////////////////////////////////////////////////////////////
GDX::GDX (void)
{
	Initialise ();
}

/////////////////////////////////////////////////////////////////////////////
// GDX Destructor
/////////////////////////////////////////////////////////////////////////////
GDX::~GDX (void)
{
	Finalise ();
}

/////////////////////////////////////////////////////////////////////////////
// GDX Initialise
/////////////////////////////////////////////////////////////////////////////
void GDX::Initialise (void)
{
	int level;
	int i;
	int j;

	// Main Section
	m_hInstance				= NULL;
	m_GameState				= STATE_GAME_TITLE;
	m_GameLevel				= LEVEL_GAME_NORMAL;

	// DirectDraw Surfaces
	m_SurfaceLifeBmp1		= NULL;
	m_SurfaceLifeBmp2		= NULL;
	m_SurfaceLife			= NULL;
	m_SurfaceScore			= NULL;
	m_SurfaceGameName		= NULL;

	// DirectInput
	m_bJoystick				= FALSE;
	m_Input					= NULL;
	m_Keyboard				= NULL;
	m_Mouse					= NULL;
	m_Joystick				= NULL;

	// DirectSound
	m_Sound					= NULL;
	m_Buffer1				= NULL;
	m_Buffer2				= NULL;

	// Fonts
	m_FontGame1				= CREATEFONT (HEIGHT_GAME_FONT1, WIDTH_GAME_FONT1, FONT_GAME1);
	m_FontGame2				= CREATEFONT (HEIGHT_GAME_FONT2, WIDTH_GAME_FONT2, FONT_GAME2);

	// Indics
	m_IndexGameTitle		= 0;
	m_IndexGamePause		= 0;

	// Maps
	m_CurrMap				= 0;
	for (level = 0; level < MAP_LEVEL; level++)
	{
		for (i = 0; i < MAP_I; i++)
		{
			for (j = 0; j < MAP_J; j++)
			{
				m_Maps[level][i][j].type = TYPE_BLOCKED;
				m_Maps[level][i][j].level = 0;
				m_Maps[level][i][j].reserved = -1;
				m_Maps[level][i][j].pMap = NULL;
			}
		}
	}
	
	// Light
	m_bLight				= FALSE;
	m_CountLight			= 0;

	m_PointLight1			= NULL;
	m_PointLight2			= NULL;

	///////////////////////////////////
	// Robots
	///////////////////////////////////
	// Robot1
	for (i = 0; i < NUMBER_ROBOT1; i++)
	{
		m_Robot1[i].pChaseFrame = NULL;
		m_Robot1[i].pRobotFrame = NULL;
		m_Robot1[i].pRobotPath = NULL;

		for (j = 0; j < NUMBER_AMMO_ROBOT; j++)
		{
			m_Robot1[i].Ammo[j].pAmmoFrame = NULL;
		}
	}

	// Robot2
	for (i = 0; i < NUMBER_ROBOT2; i++)
	{
		m_Robot2[i].pChaseFrame = NULL;
		m_Robot2[i].pRobotFrame = NULL;
		m_Robot2[i].pRobotPath = NULL;

		for (j = 0; j < NUMBER_AMMO_ROBOT; j++)
			m_Robot2[i].Ammo[j].pAmmoFrame = NULL;
	}

	// Ammo of Player
	for (i = 0; i < NUMBER_AMMO_PLAYER; i++)
		m_PlayerAmmo[i].pAmmoFrame = NULL;
}

/////////////////////////////////////////////////////////////////////////////
// GDX Finalise
/////////////////////////////////////////////////////////////////////////////
void GDX::Finalise (void)
{
	int level;
	int i;
	int j;

	// Maps
	for (level = 0; level < MAP_LEVEL; level++)
	{
		for (i = 0; i < MAP_I; i++)
		{
			for (j = 0; j < MAP_J; j++)
				SAFE_DELETE (m_Maps[level][i][j].pMap);
		}
	}

	// Fonts
	DeleteObject (m_FontGame2);
	DeleteObject (m_FontGame1);

	// DirectSound
	SAFE_DELETE (m_Buffer2);
	SAFE_DELETE (m_Buffer1);
	SAFE_DELETE (m_Sound);

	// DirectInput
	SAFE_DELETE (m_Joystick);
	SAFE_DELETE (m_Mouse);
	SAFE_DELETE (m_Keyboard);
	SAFE_DELETE (m_Input);

	// DirectDraw Surfaces
	SAFE_DELETE (m_SurfaceGameName);
	SAFE_DELETE (m_SurfaceScore);
	SAFE_DELETE (m_SurfaceLife);
	SAFE_DELETE (m_SurfaceLifeBmp2);
	SAFE_DELETE (m_SurfaceLifeBmp1);
}

/////////////////////////////////////////////////////////////////////////////
// GDX KeyInApplication
/////////////////////////////////////////////////////////////////////////////
void GDX::KeyInApplication (WPARAM wParam)
{
	if (m_State == STATE_NORMAL)
	{
		switch (m_GameState)
		{
		case STATE_GAME_TITLE:
			KeyInGameTitle (wParam);
			break;

		case STATE_GAME_OPTION:
			KeyInGameOption (wParam);
			break;

		case STATE_GAME_NORMAL:
			KeyInGameNormal (wParam);
			break;

		case STATE_GAME_PAUSE:
			KeyInGamePause (wParam);
			break;
		}
	}

	if (wParam != KEY_EXIT || m_State != STATE_NORMAL)
		KDX::KeyInApplication (wParam);
}

/////////////////////////////////////////////////////////////////////////////
// GDX Create
/////////////////////////////////////////////////////////////////////////////
BOOL GDX::Create (HWND hWnd, HINSTANCE hInstance)
{
	// Record hInstance
	m_hInstance = hInstance;

	// Call KDX::Create
	if (!KDX::Create (hWnd))
		return FALSE;

	///////////////////////////////////
	// Create DirectInput
	///////////////////////////////////
	m_Input = new CInput;
	if (m_Input->CreateInput (m_hInstance) != DI_OK)
		return FALSE;

	// Keyboard
	m_Keyboard = new CKeyboard;
	if (m_Keyboard->CreateKeyboard (m_Input, m_hWnd) != DI_OK)
		return FALSE;

	// Mouse
	m_Mouse = new CMouse;
	if (m_Mouse->CreateMouse (m_Input, m_hWnd) != DI_OK)
		return FALSE;

	// Joystick
	m_Joystick = new CJoystick;
	if (m_Joystick->CreateJoystick (m_Input, m_hWnd) != DI_OK)
		m_bJoystick = FALSE;
	else
		m_bJoystick = TRUE;

	///////////////////////////////////
	// Create DirectSound
	///////////////////////////////////
	m_Sound = new CSound;
	if (FAILED (m_Sound->CreateSound (m_hWnd)))
		return FALSE;

	// Buffer1
	m_Buffer1 = new CBuffer;
	if (FAILED (m_Buffer1->Create (m_Sound, WAVFILE_INTRO, 1)))
		return FALSE;

	// Buffer2
	m_Buffer2 = new CBuffer;
	if (FAILED (m_Buffer2->Create (m_Sound, WAVFILE_THEME, 1)))
		return FALSE;

	///////////////////////////////////
	// Load Maps
	///////////////////////////////////
	if (!InitMaps ())
		return FALSE;

	///////////////////////////////////
	// Build Scene
	///////////////////////////////////
	if (!BuildScene (GetD3DRM (), GetDevice (), GetViewport (), GetScene (), GetCamera ()))
		return FALSE;

	///////////////////////////////////
	// Play Title Sound
	///////////////////////////////////
	m_Buffer1->Play (0);

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// GDX CreateOffscreens
/////////////////////////////////////////////////////////////////////////////
BOOL GDX::CreateOffscreens (void)
{
	///////////////////////////////////
	// Create KDX Offscreens
	///////////////////////////////////
	if (!KDX::CreateOffscreens ())
		return FALSE;

	///////////////////////////////////
	// Create GDX Offscreens
	///////////////////////////////////
	// Life1 BMP
	SAFE_DELETE (m_SurfaceLifeBmp1);
	m_SurfaceLifeBmp1 = new DX_Surface;
	if (FAILED (m_SurfaceLifeBmp1->LoadBitmap (this, BMPFILE_LIFE1)))
		return FALSE;

	// Life2 BMP
	SAFE_DELETE (m_SurfaceLifeBmp2);
	m_SurfaceLifeBmp2 = new DX_Surface;
	if (FAILED (m_SurfaceLifeBmp2->LoadBitmap (this, BMPFILE_LIFE2)))
		return FALSE;

	// Life Surface
	SAFE_DELETE (m_SurfaceLife);
	m_SurfaceLife = new DX_Surface;
	if (FAILED (m_SurfaceLife->Create (this, WIDTH_SURFACE_LIFE, HEIGHT_SURFACE_LIFE)))
		return FALSE;
	if (FAILED (m_SurfaceLife->SetColorKey ()))
		return FALSE;

	// Score Surface
	SAFE_DELETE (m_SurfaceScore);
	m_SurfaceScore = new DX_Surface;
	if (FAILED (m_SurfaceScore->Create (this, WIDTH_SURFACE_SCORE, HEIGHT_SURFACE_SCORE)))
		return FALSE;
	if (FAILED (m_SurfaceScore->SetColorKey ()))
		return FALSE;

	// GameName BMP
	SAFE_DELETE (m_SurfaceGameName);
	m_SurfaceGameName = new DX_Surface;
	if (FAILED (m_SurfaceGameName->LoadBitmap (this, BMPFILE_GAMENAME)))
		return FALSE;
	if (FAILED (m_SurfaceGameName->SetColorKey ()))
		return FALSE;

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// GDX Render
/////////////////////////////////////////////////////////////////////////////
BOOL GDX::Render (void)
{
	///////////////////////////////////
	// DX_Screen::Render
	///////////////////////////////////
	if (FAILED (DX_Screen::Render ()))
		return FALSE;

	///////////////////////////////////
	// Draw Offscreen && Others
	///////////////////////////////////
	switch (m_GameState)
	{
	case STATE_GAME_TITLE:
		if (FAILED (UpdateGameSurfaceTitle ()))
			return FALSE;
		break;

	case STATE_GAME_OPTION:
		if (FAILED (UpdateGameSurfaceOption ()))
			return FALSE;
		break;

	case STATE_GAME_NORMAL:
		// LIFE
		if (FAILED (UpdateGameSurfaceLife ()))
			return FALSE;
		m_SurfaceLife->SetDest (GetWidth () - m_SurfaceLife->GetWidth (), GetHeight () - 2*m_SurfaceLife->GetHeight ());
		if (FAILED (m_SurfaceLife->Draw (m_BackBuffer, DDBLT_WAIT | DDBLT_KEYSRC)))
			return FALSE;

		// SCORE
		if (FAILED (UpdateGameSurfaceScore ()))
			return FALSE;
		m_SurfaceScore->SetDest (GetWidth () - m_SurfaceScore->GetWidth (), GetHeight () - m_SurfaceScore->GetHeight ());
		if (FAILED (m_SurfaceScore->Draw (m_BackBuffer, DDBLT_WAIT | DDBLT_KEYSRC)))
			return FALSE;

		// WIN || LOSE
		if (FAILED (UpdateGameSurfaceWinLose ()))
			return FALSE;
		break;

	case STATE_GAME_PAUSE:
		// LIFE
		if (FAILED (UpdateGameSurfaceLife ()))
			return FALSE;
		m_SurfaceLife->SetDest (GetWidth () - m_SurfaceLife->GetWidth (), GetHeight () - 2*m_SurfaceLife->GetHeight ());
		if (FAILED (m_SurfaceLife->Draw (m_BackBuffer, DDBLT_WAIT | DDBLT_KEYSRC)))
			return FALSE;

		// SCORE
		if (FAILED (UpdateGameSurfaceScore ()))
			return FALSE;
		m_SurfaceScore->SetDest (GetWidth () - m_SurfaceScore->GetWidth (), GetHeight () - m_SurfaceScore->GetHeight ());
		if (FAILED (m_SurfaceScore->Draw (m_BackBuffer, DDBLT_WAIT | DDBLT_KEYSRC)))
			return FALSE;

		// PAUSE
		if (FAILED (UpdateGameSurfacePause ()))
			return FALSE;
		break;
	}

	// Draw FPS
	if (FAILED (UpdateFPSSurface (m_SurfaceFPS)))
		return FALSE;
	m_SurfaceFPS->SetDest (0, GetHeight () - m_SurfaceFPS->GetHeight ());
	if (FAILED (m_SurfaceFPS->Draw (m_BackBuffer, DDBLT_WAIT | DDBLT_KEYSRC)))
		return FALSE;

	///////////////////////////////////
	// Draw Dialog
	///////////////////////////////////
	switch (m_State)
	{
	case STATE_NORMAL:
		break;

	case STATE_DLG_HELP:
		if (FAILED (UpdateDlgSurfaceHelp (m_SurfaceDlgBmp, m_SurfaceDlg)))
			return FALSE;
		break;

	case STATE_DLG_RENDER:
		if (FAILED (UpdateDlgSurfaceRender (m_SurfaceDlgBmp, m_SurfaceDlg)))
			return FALSE;
		break;

	case STATE_DLG_SYSTEMINFO:
		if (FAILED (UpdateDlgSurfaceSystemInfo (m_SurfaceDlgBmp, m_SurfaceDlg)))
			return FALSE;
		break;
	}

	if (m_State != STATE_NORMAL)
	{
		m_SurfaceDlg->SetDest ((GetWidth () - m_SurfaceDlg->GetWidth ())/2, (GetHeight () - m_SurfaceDlg->GetHeight ())/2);
		if (FAILED (m_SurfaceDlg->Draw (m_BackBuffer, DDBLT_WAIT | DDBLT_KEYSRC)))
			return FALSE;
	}

	///////////////////////////////////
	// Flip BackBuffer
	///////////////////////////////////
	if (FAILED (Flip ()))
		return FALSE;

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// GDX KeyInGameTitle
/////////////////////////////////////////////////////////////////////////////
void GDX::KeyInGameTitle (WPARAM wParam)
{
	CBuffer* buffer;

	switch (wParam)
	{
	case KEY_MOVECHOICE_UP:
		if (--m_IndexGameTitle < 0)
			m_IndexGameTitle = NUMBER_CHOICE_GAME_TITLE - 1;

		///////////////////////////////////
		// Click Sound
		///////////////////////////////////
		buffer = new CBuffer;
		buffer->Create (m_Sound, WAVFILE_CLICK, 1);
		buffer->Play (0);
		SAFE_DELETE (buffer);
		break;

	case KEY_MOVECHOICE_DOWN:
		if (++m_IndexGameTitle >= NUMBER_CHOICE_GAME_TITLE)
			m_IndexGameTitle = 0;

		///////////////////////////////////
		// Click Sound
		///////////////////////////////////
		buffer = new CBuffer;
		buffer->Create (m_Sound, WAVFILE_CLICK, 1);
		buffer->Play (0);
		SAFE_DELETE (buffer);
		break;

	case KEY_OK:
		switch (m_IndexGameTitle)
		{
		// NEW GAME
		case 0:
			m_GameState = STATE_GAME_NORMAL;
			InitGame ();

			///////////////////////////////////
			// Stop Title Sound && Play Theme Sound
			///////////////////////////////////
			m_Buffer1->Stop ();
			m_Buffer2->Play (DSBPLAY_LOOPING);
			break;

		// OPTION
		case 1:
			m_GameState = STATE_GAME_OPTION;
			m_IndexGameOption = m_GameLevel;
			break;

		// QUIT
		case 2:
			PostQuitMessage (0);
			break;
		}
		break;
	}
}

/////////////////////////////////////////////////////////////////////////////
// GDX KeyInGameOption
/////////////////////////////////////////////////////////////////////////////
void GDX::KeyInGameOption (WPARAM wParam)
{
	CBuffer* buffer;

	switch (wParam)
	{
	case KEY_MOVECHOICE_UP:
	case KEY_MOVECHOICE_LEFT:
		if (--m_IndexGameOption < 0)
			m_IndexGameOption = NUMBER_CHOICE_GAME_OPTION - 1;

		///////////////////////////////////
		// Click Sound
		///////////////////////////////////
		buffer = new CBuffer;
		buffer->Create (m_Sound, WAVFILE_CLICK, 1);
		buffer->Play (0);
		SAFE_DELETE (buffer);
		break;

	case KEY_MOVECHOICE_DOWN:
	case KEY_MOVECHOICE_RIGHT:
		if (++m_IndexGameOption >= NUMBER_CHOICE_GAME_OPTION)
			m_IndexGameOption = 0;

		///////////////////////////////////
		// Click Sound
		///////////////////////////////////
		buffer = new CBuffer;
		buffer->Create (m_Sound, WAVFILE_CLICK, 1);
		buffer->Play (0);
		SAFE_DELETE (buffer);
		break;

	case KEY_OK:
		m_GameLevel = m_IndexGameOption;
		m_GameState = STATE_GAME_TITLE;
		break;

	case KEY_CANCEL:
		m_GameState = STATE_GAME_TITLE;
		break;
	}
}

/////////////////////////////////////////////////////////////////////////////
// GDX KeyInGameNormal
/////////////////////////////////////////////////////////////////////////////
void GDX::KeyInGameNormal (WPARAM wParam)
{
	switch (wParam)
	{
	case KEY_PAUSE:
		m_IndexGamePause = 0;
		m_GameState = STATE_GAME_PAUSE;
		break;
	}
}

/////////////////////////////////////////////////////////////////////////////
// GDX KeyInGamePause
/////////////////////////////////////////////////////////////////////////////
void GDX::KeyInGamePause (WPARAM wParam)
{
	CBuffer* buffer;

	switch (wParam)
	{
	case KEY_MOVECHOICE_UP:
		if (--m_IndexGamePause < 0)
			m_IndexGamePause = NUMBER_CHOICE_GAME_PAUSE -1;

		///////////////////////////////////
		// Click Sound
		///////////////////////////////////
		buffer = new CBuffer;
		buffer->Create (m_Sound, WAVFILE_CLICK, 1);
		buffer->Play (0);
		SAFE_DELETE (buffer);
		break;

	case KEY_MOVECHOICE_DOWN:
		if (++m_IndexGamePause >= NUMBER_CHOICE_GAME_PAUSE)
			m_IndexGamePause = 0;

		///////////////////////////////////
		// Click Sound
		///////////////////////////////////
		buffer = new CBuffer;
		buffer->Create (m_Sound, WAVFILE_CLICK, 1);
		buffer->Play (0);
		SAFE_DELETE (buffer);
		break;

	case KEY_OK:
		switch (m_IndexGamePause)
		{
		// RESUME GAME
		case 0:
			m_GameState = STATE_GAME_NORMAL;
			break;

		// RETURN TO TITLE
		case 1:
			m_IndexGameTitle = 0;
			m_GameState = STATE_GAME_TITLE;

			///////////////////////////////////
			// Stop Theme Sound && Play Title Sound
			///////////////////////////////////
			m_Buffer2->Stop ();
			m_Buffer1->Play (0);
			break;
		}
		break;
	}
}

/////////////////////////////////////////////////////////////////////////////
// GDX UpdateGameSurfaceTitle
/////////////////////////////////////////////////////////////////////////////
HRESULT GDX::UpdateGameSurfaceTitle (void)
{
	HRESULT rval;
	HDC hdc;
	HFONT pOldFont;
	int i;

	///////////////////////////////////
	// Draw GameName
	///////////////////////////////////
	m_SurfaceGameName->SetDest ((GetWidth () - m_SurfaceGameName->GetWidth ())/2, GetHeight () / 20);
	if (FAILED (m_SurfaceGameName->Draw (m_BackBuffer, DDBLT_WAIT | DDBLT_KEYSRC)))
		return E_FAIL;

	///////////////////////////////////
	// Draw Text
	///////////////////////////////////
	// Get DC
	if (FAILED (rval = m_BackBuffer->GetSurface ()->GetDC (&hdc)))
		return rval;

	// Select Font
	pOldFont = (HFONT) SelectObject (hdc, m_FontGame1);
	SetBkMode (hdc, TRANSPARENT);

	// Draw Choices
	for (i = 0; i < NUMBER_STRING_GAME_TITLE; i++)
	{
		SetTextColor (hdc, TEXTCOLOR_GAME_SHADOW);
		TextOut (hdc,
				 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (m_szStringGameTitle[i])) / 2 + 2,
				 3 * (GetHeight () / 4) + i * HEIGHT_GAME_FONT1 + 2,
				 m_szStringGameTitle[i],
				 strlen (m_szStringGameTitle[i]));

		if (i == m_IndexGameTitle)
			SetTextColor (hdc, TEXTCOLOR_GAME_SELECTED);
		else
			SetTextColor (hdc, TEXTCOLOR_GAME_UNSELECTED);

		TextOut (hdc,
				 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (m_szStringGameTitle[i])) / 2,
				 3 * (GetHeight () / 4) + i * HEIGHT_GAME_FONT1,
				 m_szStringGameTitle[i],
				 strlen (m_szStringGameTitle[i]));
	}

	// Select old Font
	SelectObject (hdc, pOldFont);

	// Release DC
	m_BackBuffer->GetSurface ()->ReleaseDC (hdc);

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// GDX UpdateGameSurfaceOption
/////////////////////////////////////////////////////////////////////////////
HRESULT GDX::UpdateGameSurfaceOption (void)
{
	HRESULT rval;
	HDC hdc;
	HFONT pOldFont;

	///////////////////////////////////
	// Draw GameName
	///////////////////////////////////
	m_SurfaceGameName->SetDest ((GetWidth () - m_SurfaceGameName->GetWidth ())/2, GetHeight () / 20);
	if (FAILED (m_SurfaceGameName->Draw (m_BackBuffer, DDBLT_WAIT | DDBLT_KEYSRC)))
		return E_FAIL;

	///////////////////////////////////
	// Draw Text
	///////////////////////////////////
	// Get DC
	if (FAILED (rval = m_BackBuffer->GetSurface ()->GetDC (&hdc)))
		return rval; 

	// Select Font
	pOldFont = (HFONT) SelectObject (hdc, m_FontGame1);
	SetBkMode (hdc, TRANSPARENT);

	// Draw LEVEL
	SetTextColor (hdc, TEXTCOLOR_GAME_SHADOW);
	TextOut (hdc,
			 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (STRING_LEVEL)) / 2 + 2,
			 3 * (GetHeight () / 4) + 2,
			 STRING_LEVEL,
			 strlen (STRING_LEVEL));

	SetTextColor (hdc, TEXTCOLOR_GAME_UNSELECTED);
	TextOut (hdc,
			 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (STRING_LEVEL)) / 2,
			 3 * (GetHeight () / 4),
			 STRING_LEVEL,
			 strlen (STRING_LEVEL));

	// Draw Level that have just been changed
	SetTextColor (hdc, TEXTCOLOR_GAME_SHADOW);
	TextOut (hdc,
			 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (m_szStringGameOption[m_IndexGameOption])) / 2 + 2,
			 3 * (GetHeight () / 4) + HEIGHT_GAME_FONT1 + 2,
			 m_szStringGameOption[m_IndexGameOption],
			 strlen (m_szStringGameOption[m_IndexGameOption]));

	SetTextColor (hdc, TEXTCOLOR_GAME_SELECTED);
	TextOut (hdc,
			 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (m_szStringGameOption[m_IndexGameOption])) / 2,
			 3 * (GetHeight () / 4) + HEIGHT_GAME_FONT1,
			 m_szStringGameOption[m_IndexGameOption],
			 strlen (m_szStringGameOption[m_IndexGameOption]));

	// Select old Font
	SelectObject (hdc, pOldFont);

	// Release DC
	m_BackBuffer->GetSurface ()->ReleaseDC (hdc);

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// GDX UpdateGameSurfacePause
/////////////////////////////////////////////////////////////////////////////
HRESULT GDX::UpdateGameSurfacePause (void)
{
	HRESULT rval;
	HDC hdc;
	HFONT pOldFont;
	int i;

	///////////////////////////////////
	// Draw Text
	///////////////////////////////////
	// Get DC
	if (FAILED (rval = m_BackBuffer->GetSurface ()->GetDC (&hdc)))
		return rval;

	// Select Font
	pOldFont = (HFONT) SelectObject (hdc, m_FontGame1);
	SetBkMode (hdc, TRANSPARENT);

	// Draw Pause
	for (i = 0; i < NUMBER_STRING_GAME_PAUSE; i++)
	{
		SetTextColor (hdc, TEXTCOLOR_GAME_SHADOW);
		TextOut (hdc,
				 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (m_szStringGamePause[0])) / 2 + 2,
				 (GetHeight () - HEIGHT_GAME_FONT1 * NUMBER_STRING_GAME_PAUSE) / 2 + i * HEIGHT_GAME_FONT1 + 2,
				 m_szStringGamePause[i],
				 strlen (m_szStringGamePause[i]));

		if (i == m_IndexGamePause)
			SetTextColor (hdc, TEXTCOLOR_GAME_SELECTED);
		else
			SetTextColor (hdc, TEXTCOLOR_GAME_UNSELECTED);
		TextOut (hdc,
				 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (m_szStringGamePause[0])) / 2,
				 (GetHeight () - HEIGHT_GAME_FONT1 * NUMBER_STRING_GAME_PAUSE) / 2 + i * HEIGHT_GAME_FONT1,
				 m_szStringGamePause[i],
				 strlen (m_szStringGamePause[i]));
	}

	// Select old Font
	SelectObject (hdc, pOldFont);

	// Release DC
	m_BackBuffer->GetSurface ()->ReleaseDC (hdc);

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// GDX UpdateGameSurfaceWinLose
/////////////////////////////////////////////////////////////////////////////
HRESULT GDX::UpdateGameSurfaceWinLose (void)
{
	HRESULT rval;
	HDC hdc;
	HFONT pOldFont;
	int i;
	BOOL bWin = TRUE;

	///////////////////////////////////
	// Text BLINK
	///////////////////////////////////
	static blink_color = 0;
	static blink_count = 0;
	blink_count++;

	///////////////////////////////////
	// Draw Text
	///////////////////////////////////
	// Get DC
	if (FAILED (rval = m_BackBuffer->GetSurface ()->GetDC (&hdc)))
		return rval;

	// Select Font
	pOldFont = (HFONT) SelectObject (hdc, m_FontGame1);
	SetBkMode (hdc, TRANSPARENT);

	///////////////////////////////////
	// Counting
	///////////////////////////////////
	if (blink_count > WAIT_BLINK_TEXT)
	{
		blink_count = 0;
		
		if (blink_color == 0)
			blink_color = 1;
		else
			blink_color = 0;
	}

	///////////////////////////////////
	// WIN || LOSE
	///////////////////////////////////
	if (m_GameLife <= 0)
	{
		// LOSE
		SetTextColor (hdc, TEXTCOLOR_GAME_SHADOW);
		TextOut (hdc,
				 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (STRING_YOULOSE)) / 2 + 2,
				 (GetHeight () - HEIGHT_GAME_FONT1) / 2 + 2,
				 STRING_YOULOSE,
				 strlen (STRING_YOULOSE));

		if (blink_color == 0)
			SetTextColor (hdc, TEXTCOLOR_GAME_BLINK1);
		else
			SetTextColor (hdc, TEXTCOLOR_GAME_BLINK2);
		TextOut (hdc,
				 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (STRING_YOULOSE)) / 2,
				 (GetHeight () - HEIGHT_GAME_FONT1) / 2,
				 STRING_YOULOSE,
				 strlen (STRING_YOULOSE));
	}
	else
	{
		// WIN
		for (i = 0; i < NUMBER_ROBOT1; i++)
			if (m_Robot1[i].life > 0)
				bWin = FALSE;

		for (i = 0; i < NUMBER_ROBOT2; i++)
			if (m_Robot2[i].life > 0)
				bWin = FALSE;
		
		if (bWin)
		{
			SetTextColor (hdc, TEXTCOLOR_GAME_SHADOW);
			TextOut (hdc,
					 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (STRING_YOUWIN)) / 2 + 2,
					 (GetHeight () - HEIGHT_GAME_FONT1) / 2 + 2,
					 STRING_YOUWIN,
					 strlen (STRING_YOUWIN));

			if (blink_color == 0)
				SetTextColor (hdc, TEXTCOLOR_GAME_BLINK1);
			else
				SetTextColor (hdc, TEXTCOLOR_GAME_BLINK2);
			TextOut (hdc,
					 (GetWidth () - WIDTH_CHAR_FONT_GAME1 * strlen (STRING_YOUWIN)) / 2,
					 (GetHeight () - HEIGHT_GAME_FONT1) / 2,
					 STRING_YOUWIN,
					 strlen (STRING_YOUWIN));
		}
	}

	// Select old Font
	SelectObject (hdc, pOldFont);

	// Release DC
	m_BackBuffer->GetSurface ()->ReleaseDC (hdc);

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// GDX UpdateGameSurfaceLife
/////////////////////////////////////////////////////////////////////////////
HRESULT GDX::UpdateGameSurfaceLife (void)
{
	HRESULT rval;
	HDC hdc;
	HFONT pOldFont;

	///////////////////////////////////
	// Draw BMPs
	///////////////////////////////////
	if (FAILED (rval = m_SurfaceLifeBmp1->Draw (m_SurfaceLife, DDBLT_WAIT)))
		return rval;

	if (m_GameLife > 0)
	{
		m_SurfaceLifeBmp2->SetSrc (X_START_LIFE,
								   Y_START_LIFE,
								   m_GameLife,
								   14);
		
		m_SurfaceLifeBmp2->SetDest (X_START_LIFE,
									Y_START_LIFE,
									m_GameLife,
									14);

		if (FAILED (rval = m_SurfaceLifeBmp2->Draw (m_SurfaceLife, DDBLT_WAIT)))
			return rval;
	}

	///////////////////////////////////
	// Draw Text
	///////////////////////////////////
	// Get DC
	if (FAILED (rval = m_SurfaceLife->GetSurface ()->GetDC (&hdc)))
		return rval;

	// Select Font
	pOldFont = (HFONT) SelectObject (hdc, m_FontGame2);
	SetBkMode (hdc, TRANSPARENT);

	// LIFE:
	SetTextColor (hdc, TEXTCOLOR_GAME_SHADOW);
	TextOut (hdc,
			 2,
			 2,
			 "LIFE:",
			 strlen ("LIFE:"));

	SetTextColor (hdc, TEXTCOLOR_GAME_LIFE);
	TextOut (hdc,
			 0,
			 0,
			 "LIFE:",
			 strlen ("LIFE:"));

	// Select old Font
	SelectObject (hdc, pOldFont);

	// Release DC
	m_SurfaceLife->GetSurface ()->ReleaseDC (hdc);

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// GDX UpdateGameSurfaceScore
/////////////////////////////////////////////////////////////////////////////
HRESULT GDX::UpdateGameSurfaceScore (void)
{
	HRESULT rval;
	HDC hdc;
	HFONT pOldFont;
	char buff[50];

	///////////////////////////////////
	// Clear Surface
	///////////////////////////////////
	if (FAILED (rval = m_SurfaceScore->Fill (0)))
		return rval;

	///////////////////////////////////
	// Draw Text
	///////////////////////////////////
	// Get DC
	if (FAILED (rval = m_SurfaceScore->GetSurface ()->GetDC (&hdc)))
		return rval;

	// Select Font
	pOldFont = (HFONT) SelectObject (hdc, m_FontGame2);
	SetBkMode (hdc, TRANSPARENT);

	// Create String
	wsprintf (buff, "SCORE: %d", m_GameScore);

	// SCORE: XXXX
	SetTextColor (hdc, TEXTCOLOR_GAME_SHADOW);
	TextOut (hdc,
			 2,
			 2,
			 buff,
			 strlen (buff));

	SetTextColor (hdc, TEXTCOLOR_GAME_SCORE);
	TextOut (hdc,
			 0,
			 0,
			 buff,
			 strlen (buff));

	// Select old Font
	SelectObject (hdc, pOldFont);

	// Release DC
	m_SurfaceScore->GetSurface ()->ReleaseDC (hdc);

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// GDX COLORREF_2_D3DCOLOR
/////////////////////////////////////////////////////////////////////////////
D3DCOLOR GDX::COLORREF_2_D3DCOLOR (COLORREF cref)
{
	D3DVALUE r = D3DVALUE (GetRValue (cref)/D3DVALUE (255));
	D3DVALUE g = D3DVALUE (GetGValue (cref)/D3DVALUE (255));
	D3DVALUE b = D3DVALUE (GetBValue (cref)/D3DVALUE (255));
	return D3DRMCreateColorRGB (r, g, b);
}

/////////////////////////////////////////////////////////////////////////////
// GDX D3DCOLOR_2_COLORREF
/////////////////////////////////////////////////////////////////////////////
COLORREF GDX::D3DCOLOR_2_COLORREF (D3DCOLOR d3dclr)
{
	D3DVALUE red = D3DVALUE (255) * D3DRMColorGetRed (d3dclr);
	D3DVALUE green = D3DVALUE (255) * D3DRMColorGetGreen (d3dclr);
	D3DVALUE blue = D3DVALUE (255) * D3DRMColorGetBlue (d3dclr);
	return RGB ((int)red, (int)green, (int)blue);
}

/////////////////////////////////////////////////////////////////////////////
// GDX CheckCollision
/////////////////////////////////////////////////////////////////////////////
BOOL GDX::CheckCollision (D3DVECTOR pos1, D3DRMBOX box1, D3DVECTOR pos2, D3DRMBOX box2)
{
	if (pos2.x + box2.min.x > pos1.x + box1.max.x ||
		pos1.x + box1.min.x > pos2.x + box2.max.x ||
		pos2.z + box2.max.z < pos1.z + box1.min.z ||
		pos1.z + box1.max.z < pos2.z + box2.min.z ||
		pos2.y + box2.max.y < pos1.y + box1.min.y ||
		pos1.y + box1.max.y < pos2.y + box2.min.y)
		return FALSE;
	else
		return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// GDX MoveTextureCallBack
/////////////////////////////////////////////////////////////////////////////
void GDX::MoveTextureCallback (LPDIRECT3DRMFRAME3 frame, void* p, D3DVALUE val)
{
	LPDIRECT3DRM3 pD3DRM = (LPDIRECT3DRM3) p;

	static D3DVALUE xtex;
	xtex += D3DVALUE (0.001);

	DWORD nvisuals;
	if (FAILED (frame->GetVisuals (&nvisuals, NULL)))
		return ;
	LPDIRECT3DRMVISUAL* pvisuals;
	pvisuals = (LPDIRECT3DRMVISUAL*) malloc (nvisuals*sizeof (LPDIRECT3DRMVISUAL));
	if (FAILED (frame->GetVisuals (&nvisuals, (LPUNKNOWN*) pvisuals)))
		return ;

	for (int i = 0; i < (int) nvisuals; i++)
	{
		LPDIRECT3DRMMESH mesh;
		if (pvisuals[i]->QueryInterface (IID_IDirect3DRMMesh, (void**)&mesh) == 0)
		{
			D3DRMBOX box;
			mesh->GetBox (&box);
			D3DVALUE w = box.max.x - box.min.x;
			D3DVALUE h = box.max.z - box.min.z;

			LPDIRECT3DRMWRAP wrap;
			pD3DRM->CreateWrap (D3DRMWRAP_FLAT, NULL,
							    D3DVAL (0), D3DVAL (0), D3DVAL (0),
							    D3DVAL (0), -D3DVAL (1), D3DVAL (0),
								D3DVAL (0), D3DVAL (0), D3DVAL (1),
								xtex, D3DVAL (0.5),
								D3DDivide (1, w), D3DDivide (1, h),
								&wrap);
			wrap->Apply (mesh);

			SAFE_RELEASE (wrap);
			SAFE_RELEASE (mesh);
			SAFE_RELEASE (pvisuals[i]);
		}
	}
	free (pvisuals);
}

/////////////////////////////////////////////////////////////////////////////
// GDX MoveCameraCallback
/////////////////////////////////////////////////////////////////////////////
void GDX::MoveCameraCallback (LPDIRECT3DRMFRAME3 frame, void* p, D3DVALUE val)
{
	D3DVECTOR front;
	D3DVECTOR top;
	D3DVECTOR pos;
	D3DVECTOR pos_ammo;
	D3DVECTOR pos_robot;
	int i;
	int j;
	CBuffer* buffer;

	GDX* pGDX = (GDX*) p;

	///////////////////////////////////
	// Check for Playing
	///////////////////////////////////
	if (pGDX->m_State != STATE_NORMAL || pGDX->m_GameState != STATE_GAME_NORMAL)
		return;

	///////////////////////////////////
	// Player Die
	///////////////////////////////////
	if (pGDX->m_GameLife <= 0)
		goto move_others;

	///////////////////////////////////
	// Get DirectInput State
	///////////////////////////////////
	pGDX->m_Keyboard->GetState ();

	pGDX->m_Mouse->GetState ();

	if (pGDX->m_bJoystick)
		pGDX->m_Joystick->GetState ();

	///////////////////////////////////////////////////////////////////////////
	// [LEFT]
	///////////////////////////////////////////////////////////////////////////
	if (pGDX->m_Keyboard->keyboard_state[DIK_LEFT])
		frame->SetOrientation (frame,
							   -D3DVAL (m_ConstSin), D3DVAL (0), D3DVAL (m_ConstCos),
							   D3DVAL (0), D3DVAL (1), D3DVAL (0));

	if (pGDX->m_Mouse->GetX () < -10)
		frame->SetOrientation (frame,
							   -D3DVAL (m_ConstSin), D3DVAL (0), D3DVAL (m_ConstCos),
							   D3DVAL (0), D3DVAL (1), D3DVAL (0));

	if (pGDX->m_bJoystick)
		if (pGDX->m_Joystick->GetX () < -100)
			frame->SetOrientation (frame,
								   -D3DVAL (m_ConstSin), D3DVAL (0), D3DVAL (m_ConstCos),
								   D3DVAL (0), D3DVAL (1), D3DVAL (0));

	///////////////////////////////////////////////////////////////////////////
	// [RIGHT]
	///////////////////////////////////////////////////////////////////////////
	if (pGDX->m_Keyboard->keyboard_state[DIK_RIGHT])
		frame->SetOrientation (frame,
							   D3DVAL (m_ConstSin), D3DVAL (0), D3DVAL (m_ConstCos),
							   D3DVAL (0), D3DVAL (1), D3DVAL (0));

	if (pGDX->m_Mouse->GetX () > 10)
		frame->SetOrientation (frame,
							   D3DVAL (m_ConstSin), D3DVAL (0), D3DVAL (m_ConstCos),
							   D3DVAL (0), D3DVAL (1), D3DVAL (0));

	if (pGDX->m_bJoystick)
		if (pGDX->m_Joystick->GetX () > 100)
			frame->SetOrientation (frame,
								   D3DVAL (m_ConstSin), D3DVAL (0), D3DVAL (m_ConstCos),
								   D3DVAL (0), D3DVAL (1), D3DVAL (0));

	///////////////////////////////////////////////////////////////////////////
	// [UP]
	///////////////////////////////////////////////////////////////////////////
	frame->GetPosition (pGDX->GetScene (), &pos);

	if (pGDX->m_Keyboard->keyboard_state[DIK_UP])
		frame->SetPosition (frame,
							D3DVAL (0),
							D3DVAL (0),
							D3DVAL (DELTA_PLAYER));
	CompareMaps (pGDX, pos);

	if (pGDX->m_bJoystick)
		if (pGDX->m_Joystick->GetY () < -100)
			frame->SetPosition (frame,
								D3DVAL (0),
								D3DVAL (0),
								D3DVAL (DELTA_PLAYER));
	CompareMaps (pGDX, pos);

	///////////////////////////////////////////////////////////////////////////
	// [DOWN]
	///////////////////////////////////////////////////////////////////////////
	frame->GetPosition (pGDX->GetScene (), &pos);

	if (pGDX->m_Keyboard->keyboard_state[DIK_DOWN])
		frame->SetPosition (frame,
							D3DVAL (0),
							D3DVAL (0),
							-D3DVAL (DELTA_PLAYER));
	CompareMaps (pGDX, pos);

	if (pGDX->m_bJoystick)
		if (pGDX->m_Joystick->GetY () > 100)
			frame->SetPosition (frame,
								D3DVAL (0),
								D3DVAL (0),
								-D3DVAL (DELTA_PLAYER));
	CompareMaps (pGDX, pos);

	///////////////////////////////////////////////////////////////////////////
	// [PGUP]
	///////////////////////////////////////////////////////////////////////////
	frame->GetOrientation (pGDX->GetScene (), &front, &top);

	if (pGDX->m_Keyboard->keyboard_state[DIK_PGUP])
		frame->SetOrientation (pGDX->GetScene (),
							   front.x, front.y + D3DVAL (m_ConstSin), front.z,
							   top.x, top.y, top.z);

	if (pGDX->m_Mouse->GetY () < -10)
		frame->SetOrientation (pGDX->GetScene (),
							   front.x, front.y + D3DVAL (m_ConstSin), front.z,
							   top.x, top.y, top.z);

	if (pGDX->m_bJoystick)
		if (pGDX->m_Joystick->GetB2 ())
			frame->SetOrientation (pGDX->GetScene (),
								   front.x, front.y + D3DVAL (m_ConstSin), front.z,
								   top.x, top.y, top.z);

	///////////////////////////////////////////////////////////////////////////
	// [PGDOWN]
	///////////////////////////////////////////////////////////////////////////
	frame->GetOrientation (pGDX->GetScene (), &front, &top);

	if (pGDX->m_Keyboard->keyboard_state[DIK_PGDN])
		frame->SetOrientation (pGDX->GetScene (),
							   front.x, front.y - D3DVAL (m_ConstSin), front.z,
							   top.x, top.y, top.z);

	if (pGDX->m_Mouse->GetY () > 10)
		frame->SetOrientation (pGDX->GetScene (),
							   front.x, front.y - D3DVAL (m_ConstSin), front.z,
							   top.x, top.y, top.z);

	if (pGDX->m_bJoystick)
		if (pGDX->m_Joystick->GetB1 ())
			frame->SetOrientation (pGDX->GetScene (),
								   front.x, front.y - D3DVAL (m_ConstSin), front.z,
								   top.x, top.y, top.z);

	///////////////////////////////////////////////////////////////////////////
	// [HOME]
	///////////////////////////////////////////////////////////////////////////
	frame->GetOrientation (pGDX->GetScene (), &front, &top);

	if (pGDX->m_Keyboard->keyboard_state[DIK_HOME])
		frame->SetOrientation (pGDX->GetScene (),
							   front.x, D3DVAL (0), front.z,
							   D3DVAL (0), D3DVAL (1), D3DVAL (0));

	if (pGDX->m_Mouse->GetRB ())
		frame->SetOrientation (pGDX->GetScene (),
							   front.x, D3DVAL (0), front.z,
							   D3DVAL (0), D3DVAL (1), D3DVAL (0));

	if (pGDX->m_bJoystick)
		if (pGDX->m_Joystick->GetB3 ())
			frame->SetOrientation (pGDX->GetScene (),
								   front.x, D3DVAL (0), front.z,
								   D3DVAL (0), D3DVAL (1), D3DVAL (0));

///////////////////////////////////
move_others:
///////////////////////////////////

	///////////////////////////////////
	// Move Robot1
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT1; i++)
	{
		if (pGDX->m_Robot1[i].life > 0)
		{
			pGDX->m_Robot1[i].fTime += pGDX->m_RobotSpeed;

			pGDX->m_Robot1[i].pRobotPath->SetFrame (pGDX->m_Robot1[i].pRobotFrame);
			pGDX->m_Robot1[i].pRobotPath->SetTime (pGDX->m_Robot1[i].fTime);

			pGDX->m_Robot1[i].pRobotPath->SetFrame (pGDX->m_Robot1[i].pChaseFrame);
			pGDX->m_Robot1[i].pRobotPath->SetTime (pGDX->m_Robot1[i].fTime + pGDX->m_RobotSpeed);

			pGDX->m_Robot1[i].pRobotFrame->LookAt (pGDX->m_Robot1[i].pChaseFrame,
												   pGDX->GetScene (),
												   (D3DRMFRAMECONSTRAINT) 0);
		}
	}

	///////////////////////////////////
	// Move Robot2
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT2; i++)
	{
		if (pGDX->m_Robot2[i].life > 0)
		{
			pGDX->m_Robot2[i].fTime += pGDX->m_RobotSpeed;

			pGDX->m_Robot2[i].pRobotPath->SetFrame (pGDX->m_Robot2[i].pRobotFrame);
			pGDX->m_Robot2[i].pRobotPath->SetTime (pGDX->m_Robot2[i].fTime);

			pGDX->m_Robot2[i].pRobotPath->SetFrame (pGDX->m_Robot2[i].pChaseFrame);
			pGDX->m_Robot2[i].pRobotPath->SetTime (pGDX->m_Robot2[i].fTime + pGDX->m_RobotSpeed);

			pGDX->m_Robot2[i].pRobotFrame->LookAt (pGDX->m_Robot2[i].pChaseFrame,
												   pGDX->GetScene (),
												   (D3DRMFRAMECONSTRAINT) 0);
		}
	}

	///////////////////////////////////
	// Ammo
	///////////////////////////////////
	BOOL bFound;
	int IndexAmmo;
	static int wait = 0;
	wait++;

	///////////////////////////////////
	// Init Ammo of Player
	///////////////////////////////////
	if ((pGDX->m_Keyboard->keyboard_state[DIK_SPACE] ||
		 pGDX->m_Mouse->GetLB () ||
		 (pGDX->m_bJoystick && pGDX->m_Joystick->GetB4 ())) &&
		 pGDX->m_GameLife > 0 &&
		 wait > WAITAMMO_PLAYER)
	{
		wait = 0;
		bFound = FALSE;

		for (i = 0; i < NUMBER_AMMO_PLAYER; i++)
		{
			if (!pGDX->m_PlayerAmmo[i].bShoot)
			{
				IndexAmmo = i;
				bFound = TRUE;
			}
		}

		if (bFound)
		{
			pGDX->m_PlayerAmmo[IndexAmmo].bShoot = TRUE;
			pGDX->m_PlayerAmmo[IndexAmmo].count = 0;

			// Set Position
			pGDX->GetCamera ()->GetPosition (pGDX->GetScene (), &pos);
			pGDX->m_PlayerAmmo[IndexAmmo].pAmmoFrame->SetPosition (pGDX->GetScene (),
																   pos.x,
																   pos.y - 1,
																   pos.z);
			// Set Orientation
			pGDX->GetCamera ()->GetOrientation (pGDX->GetScene (),
												&front,
												&top);
			pGDX->m_PlayerAmmo[IndexAmmo].pAmmoFrame->SetOrientation (pGDX->GetScene (),
																	  front.x, front.y, front.z,
																	  top.x, top.y, top.z);

			///////////////////////////////////
			// Ammo Sound
			///////////////////////////////////
			buffer = new CBuffer;
			buffer->Create (pGDX->m_Sound, WAVFILE_PLAYER_SHOOT, 1);
			buffer->Play (0);
			SAFE_DELETE (buffer);
		}
	}

	///////////////////////////////////
	// Init Ammo of Robot2
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT2; i++)
	{
		pGDX->m_Robot2[i].wait++;

		if (pGDX->m_Robot2[i].life > 0 &&
			pGDX->m_Robot2[i].wait > pGDX->m_RobotWaitAmmo)
		{
			pGDX->m_Robot2[i].wait = 0;
			bFound = FALSE;

			for (j = 0; j < NUMBER_AMMO_ROBOT; j++)
			{
				if (!pGDX->m_Robot2[i].Ammo[j].bShoot)
				{
					IndexAmmo = j;
					bFound = TRUE;
				}
			}

			if (bFound)
			{
				pGDX->m_Robot2[i].Ammo[IndexAmmo].bShoot = TRUE;
				pGDX->m_Robot2[i].Ammo[IndexAmmo].count = 0;
				pGDX->m_Robot2[i].pRobotFrame->GetPosition (pGDX->GetScene (), &pos_robot);
				
				if (!pGDX->m_Robot2[i].bRightArm)
				{
					pGDX->m_Robot2[i].Ammo[IndexAmmo].pAmmoFrame->SetPosition (pGDX->GetScene (),
																			   pos_robot.x,
																			   pos_robot.y,
																			   pos_robot.z);
					pGDX->m_Robot2[i].Ammo[IndexAmmo].pAmmoFrame->SetPosition (pGDX->m_Robot2[i].Ammo[IndexAmmo].pAmmoFrame,
																			   D3DVAL (STARTAMMOOFROBOT2_X),
																			   D3DVAL (STARTAMMOOFROBOT2_Y),
																			   D3DVAL (STARTAMMOOFROBOT2_Z));
					pGDX->m_Robot2[i].bRightArm = TRUE;
				}
				else
				{
					pGDX->m_Robot2[i].Ammo[IndexAmmo].pAmmoFrame->SetPosition (pGDX->GetScene (),
																			   pos_robot.x,
																			   pos_robot.y,
																			   pos_robot.z);
					pGDX->m_Robot2[i].Ammo[IndexAmmo].pAmmoFrame->SetPosition (pGDX->m_Robot2[i].Ammo[IndexAmmo].pAmmoFrame,
																			   -D3DVAL (STARTAMMOOFROBOT2_X),
																			   D3DVAL (STARTAMMOOFROBOT2_Y),
																			   D3DVAL (STARTAMMOOFROBOT2_Z));
					pGDX->m_Robot2[i].bRightArm = FALSE;
				}

				pGDX->m_Robot2[i].pRobotFrame->GetOrientation (pGDX->GetScene (), &front, &top);
				pGDX->m_Robot2[i].Ammo[IndexAmmo].pAmmoFrame->SetOrientation (pGDX->GetScene (),
																			  front.x, front.y, front.z,
																			  top.x, top.y, top.z);
			}
		}
	}

	///////////////////////////////////
	// Move Ammo of Player
	///////////////////////////////////
	for (i = 0; i < NUMBER_AMMO_PLAYER; i++)
	{
		if (pGDX->m_PlayerAmmo[i].bShoot)
		{
			pGDX->m_PlayerAmmo[i].count++;
			if (pGDX->m_PlayerAmmo[i].count < FAR_AMMO_PLAYER)
			{
				pGDX->m_PlayerAmmo[i].pAmmoFrame->SetPosition (pGDX->m_PlayerAmmo[i].pAmmoFrame,
															   D3DVAL (0),
															   D3DVAL (0),
															   D3DVAL (DELTA_AMMO));
			}
			else
			{
				pGDX->m_PlayerAmmo[i].bShoot = FALSE;
				pGDX->m_PlayerAmmo[i].pAmmoFrame->SetPosition (pGDX->GetCamera (),
															   D3DVAL (0),
															   D3DVAL (0),
															   -D3DVAL (5));
			}
		}
		else
		{
			pGDX->m_PlayerAmmo[i].pAmmoFrame->SetPosition (pGDX->GetCamera (),
														   D3DVAL (0),
														   D3DVAL (0),
														   -D3DVAL (5));
		}
	}

	///////////////////////////////////
	// Move Ammo of Robot2
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT2; i++)
	{
		for (j = 0; j < NUMBER_AMMO_ROBOT; j++)
		{
			if (pGDX->m_Robot2[i].Ammo[j].bShoot)
			{
				pGDX->m_Robot2[i].Ammo[j].count++;
				if (pGDX->m_Robot2[i].Ammo[j].count < FAR_AMMO_ROBOT)
				{
					pGDX->m_Robot2[i].Ammo[j].pAmmoFrame->SetPosition (pGDX->m_Robot2[i].Ammo[j].pAmmoFrame,
																	   D3DVAL (0),
																	   D3DVAL (0),
																	   D3DVAL (DELTA_AMMO));
				}
				else
				{
					pGDX->m_Robot2[i].Ammo[j].bShoot = FALSE;
					pGDX->m_Robot2[i].Ammo[j].pAmmoFrame->SetPosition (pGDX->GetCamera (),
																	   D3DVAL (0),
																	   D3DVAL (0),
																	   -D3DVAL (5));
				}
			}
			else
			{
				pGDX->m_Robot2[i].Ammo[j].pAmmoFrame->SetPosition (pGDX->GetCamera (),
																   D3DVAL (0),
																   D3DVAL (0),
																   -D3DVAL (5));
			}
		}
	}

	///////////////////////////////////
	// Check Collision Player's Ammo && Robot1
	///////////////////////////////////
	for (i = 0; i < NUMBER_AMMO_PLAYER; i++)
	{
		for (j = 0; j < NUMBER_ROBOT1; j++)
		{
			if (!pGDX->m_PlayerAmmo[i].bShoot)
				continue;

			pGDX->m_PlayerAmmo[i].pAmmoFrame->GetPosition (pGDX->GetScene (), &pos_ammo);
			pGDX->m_Robot1[j].pRobotFrame->GetPosition (pGDX->GetScene (), &pos_robot);

			if (CheckCollision (pos_ammo, m_BoxAmmo1, pos_robot, m_BoxRobot1))
			{
				pGDX->m_PlayerAmmo[i].bShoot = FALSE;
				
				if (pGDX->m_Robot1[j].life > 0)
				{
					pGDX->m_Robot1[j].life -= LIFE_AMMO;
					pGDX->m_GameScore += LIFE_ROBOT1;
					
					if (pGDX->m_Robot1[j].life <= 0)
					{
						///////////////////////////////////
						// Robot1 Die Sound
						///////////////////////////////////
						buffer = new CBuffer;
						buffer->Create (pGDX->m_Sound, WAVFILE_ROBOT1_DIE, 1);
						buffer->Play (0);
						SAFE_DELETE (buffer);
					}
					else
					{
						///////////////////////////////////
						// Robot1 Hurt Sound
						///////////////////////////////////
						buffer = new CBuffer;
						buffer->Create (pGDX->m_Sound, WAVFILE_ROBOT1_HURT, 1);
						buffer->Play (0);
						SAFE_DELETE (buffer);
					}
				}

				///////////////////////////////////
				// Boom Sound
				///////////////////////////////////
				buffer = new CBuffer;
				buffer->Create (pGDX->m_Sound, WAVFILE_BOOM, 1);
				buffer->Play (0);
				SAFE_DELETE (buffer);
			}
		}
	}

	///////////////////////////////////
	// Check Collision Player's Ammo && Robot2
	///////////////////////////////////
	for (i = 0; i < NUMBER_AMMO_PLAYER; i++)
	{
		for (j = 0; j < NUMBER_ROBOT2; j++)
		{
			if (!pGDX->m_PlayerAmmo[i].bShoot)
				continue;

			pGDX->m_PlayerAmmo[i].pAmmoFrame->GetPosition (pGDX->GetScene (), &pos_ammo);
			pGDX->m_Robot2[j].pRobotFrame->GetPosition (pGDX->GetScene (), &pos_robot);

			if (CheckCollision (pos_ammo, m_BoxAmmo1, pos_robot, m_BoxRobot2))
			{
				pGDX->m_PlayerAmmo[i].bShoot = FALSE;
				
				if (pGDX->m_Robot2[j].life > 0)
				{
					pGDX->m_Robot2[j].life -= LIFE_AMMO;
					pGDX->m_GameScore += LIFE_ROBOT2;
					
					if (pGDX->m_Robot2[j].life <= 0)
					{
						///////////////////////////////////
						// Robot2 Die Sound
						///////////////////////////////////
						buffer = new CBuffer;
						buffer->Create (pGDX->m_Sound, WAVFILE_ROBOT2_DIE, 1);
						buffer->Play (0);
						SAFE_DELETE (buffer);
					}
					else
					{
						///////////////////////////////////
						// Robot2 Hurt Sound
						///////////////////////////////////
						buffer = new CBuffer;
						buffer->Create (pGDX->m_Sound, WAVFILE_ROBOT2_HURT, 1);
						buffer->Play (0);
						SAFE_DELETE (buffer);
					}
				}

				///////////////////////////////////
				// Boom Sound
				///////////////////////////////////
				buffer = new CBuffer;
				buffer->Create (pGDX->m_Sound, WAVFILE_BOOM, 1);
				buffer->Play (0);
				SAFE_DELETE (buffer);
			}
		}
	}

	///////////////////////////////////
	// Check Collision Player && Robot1
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT1; i++)
	{
		if (pGDX->m_Robot1[i].life <= 0)
			continue;

		pGDX->GetCamera ()->GetPosition (pGDX->GetScene (), &pos);
		pGDX->m_Robot1[i].pRobotFrame->GetPosition (pGDX->GetScene (), &pos_robot);

		if (CheckCollision (pos, m_BoxPlayer, pos_robot, m_BoxRobot1))
		{
			if (!pGDX->m_Robot1[i].bHitPlayer)
			{
				pGDX->m_Robot1[i].bHitPlayer = TRUE;
				pGDX->m_GameLife -= LIFE_DAMAGE;
				pGDX->m_bLight = TRUE;

				///////////////////////////////////
				// Damage Sound
				///////////////////////////////////
				buffer = new CBuffer;
				buffer->Create (pGDX->m_Sound, WAVFILE_PLAYER_HURT, 1);
				buffer->Play (0);
				SAFE_DELETE (buffer);
			}
		}
		else
		{
			pGDX->m_Robot1[i].bHitPlayer = FALSE;
		}
	}

	///////////////////////////////////
	// Check Collision Player && Robot2
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT2; i++)
	{
		if (pGDX->m_Robot2[i].life <= 0)
			continue;

		pGDX->GetCamera ()->GetPosition (pGDX->GetScene (), &pos);
		pGDX->m_Robot2[i].pRobotFrame->GetPosition (pGDX->GetScene (), &pos_robot);

		if (CheckCollision (pos, m_BoxPlayer, pos_robot, m_BoxRobot2))
		{
			if (!pGDX->m_Robot2[i].bHitPlayer)
			{
				pGDX->m_Robot2[i].bHitPlayer = TRUE;
				pGDX->m_GameLife -= LIFE_DAMAGE;
				pGDX->m_bLight = TRUE;

				///////////////////////////////////
				// Damage Sound
				///////////////////////////////////
				buffer = new CBuffer;
				buffer->Create (pGDX->m_Sound, WAVFILE_PLAYER_HURT, 1);
				buffer->Play (0);
				SAFE_DELETE (buffer);
			}
		}
		else
		{
			pGDX->m_Robot2[i].bHitPlayer = FALSE;
		}
	}

	///////////////////////////////////
	// Check Collision Robot2's Ammo && Player
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT2; i++)
	{
		for (j = 0; j < NUMBER_AMMO_ROBOT; j++)
		{
			if (!pGDX->m_Robot2[i].Ammo[j].bShoot)
				continue;

			pGDX->m_Robot2[i].Ammo[j].pAmmoFrame->GetPosition (pGDX->GetScene (), &pos_ammo);
			pGDX->GetCamera ()->GetPosition (pGDX->GetScene (), &pos);

			if (CheckCollision (pos_ammo, m_BoxAmmo2, pos, m_BoxPlayer))
			{
				pGDX->m_Robot2[i].Ammo[j].bShoot = FALSE;

				pGDX->m_GameLife -= LIFE_DAMAGE;
				pGDX->m_bLight = TRUE;

				///////////////////////////////////
				// Damage Sound
				///////////////////////////////////
				buffer = new CBuffer;
				buffer->Create (pGDX->m_Sound, WAVFILE_PLAYER_HURT, 1);
				buffer->Play (0);
				SAFE_DELETE (buffer);
			}
		}
	}

	///////////////////////////////////
	// Lighting
	///////////////////////////////////
	pGDX->m_CountLight++;

	if (pGDX->m_bLight)
	{
		pGDX->m_bLight = FALSE;
		pGDX->m_CountLight = 0;

		pGDX->m_PointLight1->SetColorRGB (D3DVAL (LIGHTCOLOR_HURT_R),
										  D3DVAL (LIGHTCOLOR_HURT_G),
										  D3DVAL (LIGHTCOLOR_HURT_B));
		pGDX->m_PointLight2->SetColorRGB (D3DVAL (LIGHTCOLOR_HURT_R),
										  D3DVAL (LIGHTCOLOR_HURT_G),
										  D3DVAL (LIGHTCOLOR_HURT_B));
	}

	if (pGDX->m_CountLight > WAIT_BLINK_SCREEN)
	{
		pGDX->m_CountLight = 0;

		pGDX->m_PointLight1->SetColorRGB (D3DVAL (LIGHTCOLOR_NORMAL_R),
										  D3DVAL (LIGHTCOLOR_NORMAL_G),
										  D3DVAL (LIGHTCOLOR_NORMAL_B));
		pGDX->m_PointLight2->SetColorRGB (D3DVAL (LIGHTCOLOR_NORMAL_R),
										  D3DVAL (LIGHTCOLOR_NORMAL_G),
										  D3DVAL (LIGHTCOLOR_NORMAL_B));
	}
}

/////////////////////////////////////////////////////////////////////////////
// GDX CleanupObjectCallback
/////////////////////////////////////////////////////////////////////////////
void GDX::CleanupObjectsCallback (LPDIRECT3DRMOBJECT pObj, void* p)
{
	int i;
	int j;

	GDX* pGDX = (GDX*) p;

	///////////////////////////////////
	// Release Ammo of Player
	///////////////////////////////////
	for (i = 0; i < NUMBER_AMMO_PLAYER; i++)
		SAFE_RELEASE (pGDX->m_PlayerAmmo[i].pAmmoFrame);

	///////////////////////////////////
	// Release Robot2
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT2; i++)
	{
		SAFE_RELEASE (pGDX->m_Robot2[i].pChaseFrame);
		SAFE_RELEASE (pGDX->m_Robot2[i].pRobotFrame);
		SAFE_RELEASE (pGDX->m_Robot2[i].pRobotPath);

		for (j = 0; j <NUMBER_AMMO_ROBOT; j++)
			SAFE_RELEASE (pGDX->m_Robot2[i].Ammo[j].pAmmoFrame);
	}

	///////////////////////////////////
	// Release Robot1
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT1; i++)
	{
		SAFE_RELEASE (pGDX->m_Robot1[i].pChaseFrame);
		SAFE_RELEASE (pGDX->m_Robot1[i].pRobotFrame);
		SAFE_RELEASE (pGDX->m_Robot1[i].pRobotPath);
	}

	///////////////////////////////////
	// Release Lights
	///////////////////////////////////
	SAFE_RELEASE (pGDX->m_PointLight2);
	SAFE_RELEASE (pGDX->m_PointLight1);
}

/////////////////////////////////////////////////////////////////////////////
// GDX InitMaps
/////////////////////////////////////////////////////////////////////////////
BOOL GDX::InitMaps (void)
{
	int i;
	int j;

	///////////////////////////////////
	// Init m_Maps[0]
	///////////////////////////////////
	// Init BLOCKED areas
	for (j = 0; j < MAP_J; j++)
	{
		m_Maps[0][0][j].type = TYPE_BLOCKED;
		m_Maps[0][0][j].level = 0;
		m_Maps[0][0][j].reserved = -1;
		m_Maps[0][0][j].pMap = NULL;
	}

	// Init NORMAL areas
	for (i = 1; i < MAP_I; i++)
	{
		for (j = 0; j < MAP_J; j++)
		{
			m_Maps[0][i][j].type = TYPE_NORMAL;
			m_Maps[0][i][j].level = 0;
			m_Maps[0][i][j].reserved = -1;
			m_Maps[0][i][j].pMap = NULL;
		}
	}

	// Init BLOCKED areas
	m_Maps[0][1][0].type = TYPE_BLOCKED;
	m_Maps[0][1][0].level = 0;
	m_Maps[0][1][0].reserved = -1;
	m_Maps[0][1][0].pMap = NULL;

	///////////////////////////////////
	// Init m_Maps[1]
	///////////////////////////////////
	for (i = 0; i < MAP_I; i++)
	{
		for (j = 0; j < MAP_J; j++)
		{
			m_Maps[1][i][j].type = TYPE_BLOCKED;
			m_Maps[1][i][j].level = 0;
			m_Maps[1][i][j].reserved = -1;
			m_Maps[1][i][j].pMap = NULL;
		}
	}

	///////////////////////////////////
	// Load m_Maps[0]
	///////////////////////////////////
	m_Maps[0][0][2].pMap = new KDX_Map;
	if (!m_Maps[0][0][2].pMap->LoadMap (MAPFILE_0_0_2))
		return FALSE;

	m_Maps[0][1][1].pMap = new KDX_Map;
	if (!m_Maps[0][1][1].pMap->LoadMap (MAPFILE_0_1_1))
		return FALSE;

	m_Maps[0][1][2].pMap = new KDX_Map;
	if (!m_Maps[0][1][2].pMap->LoadMap (MAPFILE_0_1_2))
		return FALSE;

	m_Maps[0][1][3].pMap = new KDX_Map;
	if (!m_Maps[0][1][3].pMap->LoadMap (MAPFILE_0_1_3))
		return FALSE;

	m_Maps[0][1][4].pMap = new KDX_Map;
	if (!m_Maps[0][1][4].pMap->LoadMap (MAPFILE_0_1_4))
		return FALSE;

	m_Maps[0][2][0].pMap = new KDX_Map;
	if (!m_Maps[0][2][0].pMap->LoadMap (MAPFILE_0_2_0))
		return FALSE;

	m_Maps[0][2][1].pMap = new KDX_Map;
	if (!m_Maps[0][2][1].pMap->LoadMap (MAPFILE_0_2_1))
		return FALSE;

	m_Maps[0][2][2].pMap = new KDX_Map;
	if (!m_Maps[0][2][2].pMap->LoadMap (MAPFILE_0_2_2))
		return FALSE;

	m_Maps[0][2][3].pMap = new KDX_Map;
	if (!m_Maps[0][2][3].pMap->LoadMap (MAPFILE_0_2_3))
		return FALSE;

	m_Maps[0][3][0].pMap = new KDX_Map;
	if (!m_Maps[0][3][0].pMap->LoadMap (MAPFILE_0_3_0))
		return FALSE;

	m_Maps[0][3][1].pMap = new KDX_Map;
	if (!m_Maps[0][3][1].pMap->LoadMap (MAPFILE_0_3_1))
		return FALSE;

	m_Maps[0][3][2].pMap = new KDX_Map;
	if (!m_Maps[0][3][2].pMap->LoadMap (MAPFILE_0_3_2))
		return FALSE;

	m_Maps[0][3][3].pMap = new KDX_Map;
	if (!m_Maps[0][3][3].pMap->LoadMap (MAPFILE_0_3_3))
		return FALSE;

	m_Maps[0][3][4].pMap = new KDX_Map;
	if (!m_Maps[0][3][4].pMap->LoadMap (MAPFILE_0_3_4))
		return FALSE;

	///////////////////////////////////
	// Load m_Maps[1]
	///////////////////////////////////
	m_Maps[1][2][2].pMap = new KDX_Map;
	if (!m_Maps[1][2][2].pMap->LoadMap (MAPFILE_1_2_2))
		return FALSE;

	m_Maps[1][2][3].pMap = new KDX_Map;
	if (!m_Maps[1][2][3].pMap->LoadMap (MAPFILE_1_2_3))
		return FALSE;

	m_Maps[1][3][2].pMap = new KDX_Map;
	if (!m_Maps[1][3][2].pMap->LoadMap (MAPFILE_1_3_2))
		return FALSE;

	m_Maps[1][3][3].pMap = new KDX_Map;
	if (!m_Maps[1][3][3].pMap->LoadMap (MAPFILE_1_3_3))
		return FALSE;

	m_Maps[1][3][4].pMap = new KDX_Map;
	if (!m_Maps[1][3][4].pMap->LoadMap (MAPFILE_1_3_4))
		return FALSE;

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// GDX GetMapsType
/////////////////////////////////////////////////////////////////////////////
int GDX::GetMapsType (GDX* pGDX, int level, int i, int j)
{
	int map_i;
	int map_j;
	int real_i;
	int real_j;

	map_i = i / MAX_BLOCK;
	map_j = j / MAX_BLOCK;
	real_i = i % MAX_BLOCK;
	real_j = j % MAX_BLOCK;

	if (pGDX->m_Maps[level][map_i][map_j].pMap == NULL)
		return pGDX->m_Maps[level][map_i][map_j].type;
	else
		return pGDX->m_Maps[level][map_i][map_j].pMap->GetBlockType (real_i, real_j);
}

/////////////////////////////////////////////////////////////////////////////
// GDX GetMapsLevel
/////////////////////////////////////////////////////////////////////////////
int GDX::GetMapsLevel (GDX* pGDX, int level, int i, int j)
{
	int map_i;
	int map_j;
	int real_i;
	int real_j;

	map_i = i / MAX_BLOCK;
	map_j = j / MAX_BLOCK;
	real_i = i % MAX_BLOCK;
	real_j = j % MAX_BLOCK;

	if (pGDX->m_Maps[level][map_i][map_j].pMap == NULL)
		return pGDX->m_Maps[level][map_i][map_j].level;
	else
		return pGDX->m_Maps[level][map_i][map_j].pMap->GetBlockLevel (real_i, real_j);
}

/////////////////////////////////////////////////////////////////////////////
// GDX CompareMaps
/////////////////////////////////////////////////////////////////////////////
void GDX::CompareMaps (GDX* pGDX, D3DVECTOR OldPos)
{
	D3DVECTOR pos;
	int i;
	int j;

	pGDX->GetCamera ()->GetPosition (pGDX->GetScene (), &pos);
	i = -(int) (pos.z * 100) / 100;
	j = (int) (pos.x * 100) / 100;

	///////////////////////////////////
	// Check if cannot move
	///////////////////////////////////
	if (i < 0 || i >= MAP_I * MAX_BLOCK || j < 0 || j >= MAP_J * MAX_BLOCK ||
		!(GetMapsType (pGDX, pGDX->m_CurrMap, i, j) == TYPE_NORMAL ||
		  GetMapsType (pGDX, pGDX->m_CurrMap, i, j) == TYPE_GRASS ||
		  GetMapsType (pGDX, pGDX->m_CurrMap, i, j) == TYPE_SPECIAL))
		pGDX->GetCamera ()->SetPosition (pGDX->GetScene (), OldPos.x, OldPos.y, OldPos.z);

	///////////////////////////////////
	// Get current Position
	///////////////////////////////////
	pGDX->GetCamera ()->GetPosition (pGDX->GetScene (), &pos);
	i = -(int) (pos.z * 100) / 100;
	j = (int) (pos.x * 100) / 100;

	///////////////////////////////////
	// Change current Maps && Z of Player
	///////////////////////////////////
	if (i >= 0 && i < MAP_I * MAX_BLOCK &&
		j >= 0 && j < MAP_J * MAX_BLOCK)
	{
		if (GetMapsType (pGDX, pGDX->m_CurrMap, i, j) == TYPE_SPECIAL)
		{
			// Change current maps
			if (pGDX->m_CurrMap == 0)
				pGDX->m_CurrMap = 1;
			else
				pGDX->m_CurrMap = 0;
		}

		// Change Z of Player
		pGDX->GetCamera ()->SetPosition (pGDX->GetScene (),
										 pos.x, 
										 D3DVAL (GetMapsLevel (pGDX, pGDX->m_CurrMap, i, j) + HEIGHT_PLAYER_EYES),
										 pos.z);
	}
}

/////////////////////////////////////////////////////////////////////////////
// GDX BuildScene
/////////////////////////////////////////////////////////////////////////////
BOOL GDX::BuildScene (LPDIRECT3DRM3 pD3DRM, LPDIRECT3DRMDEVICE3 dev, LPDIRECT3DRMVIEWPORT2 view, LPDIRECT3DRMFRAME3 scene, LPDIRECT3DRMFRAME3 camera)
{
	LPDIRECT3DRMMESHBUILDER3 builder1 = NULL;
	LPDIRECT3DRMMESHBUILDER3 builder2 = NULL;
	LPDIRECT3DRMMESHBUILDER3 builder3 = NULL;
	LPDIRECT3DRMMESHBUILDER3 builder4 = NULL;
	LPDIRECT3DRMMESHBUILDER3 builder5 = NULL;
	LPDIRECT3DRMMESHBUILDER3 builder6 = NULL;
	LPDIRECT3DRMMESHBUILDER3 builder7 = NULL;
	LPDIRECT3DRMMESH mesh = NULL;
	LPDIRECT3DRMFRAME3 frame = NULL;
	LPDIRECT3DRMLIGHT l1 = NULL;
	LPDIRECT3DRMLIGHT l2 = NULL;
	LPDIRECT3DRMTEXTURE3 tex = NULL;
	int i;
	int j;

	///////////////////////////////////
	// Set Lights
	///////////////////////////////////
	// Ambient
	if (FAILED (pD3DRM->CreateLightRGB (D3DRMLIGHT_AMBIENT,
										D3DVAL (0.1),
										D3DVAL (0.1),
										D3DVAL (0.1),
										&l1)))
										goto generic_error;
	if (FAILED (scene->AddLight (l1)))
		goto generic_error;

	// Spot1
	if (FAILED (pD3DRM->CreateFrame (scene, &frame)))
		goto generic_error;
	if (FAILED (frame->SetPosition (scene,
									D3DVAL (118.5),
									D3DVAL (100),
									-D3DVAL (118.5))))
									goto generic_error;
	if (FAILED (frame->SetOrientation (scene,
									   D3DVAL (0), -D3DVAL (1), D3DVAL (0),
									   D3DVAL (0), D3DVAL (0), D3DVAL (1))))
									   goto generic_error;
	if (FAILED (pD3DRM->CreateLightRGB (D3DRMLIGHT_SPOT,
										D3DVAL (1),
										D3DVAL (0.5),
										D3DVAL (0.1),
										&l2)))
										goto generic_error;
	if (FAILED (l2->SetUmbra (D3DVAL (10))))
		goto generic_error;
	if (FAILED (l2->SetPenumbra (D3DVAL (45))))
		goto generic_error;
	if (FAILED (frame->AddLight (l2)))
		goto generic_error;
	SAFE_RELEASE (frame);

	// Point1
	if (FAILED (pD3DRM->CreateFrame (scene, &frame)))
		goto generic_error;
	if (FAILED (frame->SetPosition (scene,
									D3DVAL (3000),
									D3DVAL (700),
									D3DVAL (2000))))
									goto generic_error;
	if (FAILED (pD3DRM->CreateLightRGB (D3DRMLIGHT_POINT,
										D3DVAL (LIGHTCOLOR_NORMAL_R),
										D3DVAL (LIGHTCOLOR_NORMAL_G),
										D3DVAL (LIGHTCOLOR_NORMAL_B),
										&m_PointLight1)))
										goto generic_error;
	if (FAILED (frame->AddLight (m_PointLight1)))
		goto generic_error;
	SAFE_RELEASE (frame);

	// Point2
	if (FAILED (pD3DRM->CreateFrame (scene, &frame)))
		goto generic_error;
	if (FAILED (frame->SetPosition (scene,
									-D3DVAL (3000),
									D3DVAL (700),
									-D3DVAL (2000))))
									goto generic_error;
	if (FAILED (pD3DRM->CreateLightRGB (D3DRMLIGHT_POINT,
										D3DVAL (LIGHTCOLOR_NORMAL_R),
										D3DVAL (LIGHTCOLOR_NORMAL_G),
										D3DVAL (LIGHTCOLOR_NORMAL_B),
										&m_PointLight2)))
										goto generic_error;
	if (FAILED (frame->AddLight (m_PointLight2)))
		goto generic_error;
	SAFE_RELEASE (frame);

	///////////////////////////////////
	// Load Object
	///////////////////////////////////
	// Building
	if (FAILED (pD3DRM->CreateFrame (scene, &frame)))
		goto generic_error;
	if (FAILED (frame->SetPosition (scene,
									D3DVAL (0),
									D3DVAL (0),
									D3DVAL (0))))
									goto generic_error;
	if (FAILED (pD3DRM->CreateMeshBuilder (&builder1)))
		goto generic_error;
	if (FAILED (builder1->Load (XFILE_BUILDING,
								NULL,
								D3DRMLOAD_FROMFILE,
								NULL,
								NULL)))
								goto generic_error;
	if (FAILED (frame->AddVisual ((LPDIRECT3DRMVISUAL) builder1)))
		goto generic_error;
	SAFE_RELEASE (frame);

	// Floor
	if (FAILED (pD3DRM->CreateFrame (scene, &frame)))
		goto generic_error;
	if (FAILED (frame->SetPosition (scene,
									D3DVAL (0),
									D3DVAL (0),
									D3DVAL (0))))
									goto generic_error;
	if (FAILED (pD3DRM->CreateMeshBuilder (&builder2)))
		goto generic_error;
	if (FAILED (builder2->Load (XFILE_FLOOR,
								NULL,
								D3DRMLOAD_FROMFILE,
								NULL,
								NULL)))
								goto generic_error;
	if (FAILED (frame->AddVisual ((LPDIRECT3DRMVISUAL) builder2)))
		goto generic_error;
	SAFE_RELEASE (frame);

	// Water
	if (FAILED (pD3DRM->CreateFrame (scene, &frame)))
		goto generic_error;
	if (FAILED (frame->SetPosition (scene,
									D3DVAL (0),
									D3DVAL (0),
									D3DVAL (0))))
									goto generic_error;
	if (FAILED (pD3DRM->CreateMeshBuilder (&builder3)))
		goto generic_error;
	if (FAILED (builder3->Load (XFILE_WATER,
								NULL,
								D3DRMLOAD_FROMFILE,
								NULL,
								NULL)))
								goto generic_error;
	if (FAILED (pD3DRM->LoadTexture (BMPFILE_TEXTURE_WATER, &tex)))
		goto generic_error;
	if (FAILED (builder3->SetTexture (tex)))
		goto generic_error;
	if (FAILED (builder3->CreateMesh (&mesh)))
		goto generic_error;
	if (FAILED (frame->AddVisual ((LPDIRECT3DRMVISUAL) mesh)))
		goto generic_error;
	if (FAILED (frame->AddMoveCallback ((D3DRMFRAME3MOVECALLBACK) MoveTextureCallback, (void*) pD3DRM, 0)))
		goto generic_error;
	SAFE_RELEASE (frame);

	///////////////////////////////////
	// Set Camera
	///////////////////////////////////
	if (FAILED (camera->SetPosition (scene,
									 D3DVAL (CAMERA_POSITION_X),
									 D3DVAL (CAMERA_POSITION_Y),
									 D3DVAL (CAMERA_POSITION_Z))))
									 goto generic_error;

	if (FAILED (camera->SetOrientation (scene,
										D3DVAL (0), D3DVAL (0), D3DVAL (1),
										D3DVAL (0), D3DVAL (1), D3DVAL (0))))
										goto generic_error;

	// Move Callback
	if (FAILED (camera->AddMoveCallback ((D3DRMFRAME3MOVECALLBACK) MoveCameraCallback, (void*) this, 0)))
		goto generic_error;

	// Destroy Callback
	if (FAILED (camera->AddDestroyCallback ((D3DRMOBJECTCALLBACK) CleanupObjectsCallback, (void*) this)))
		goto generic_error;

	///////////////////////////////////
	// Set Environment
	///////////////////////////////////
	COLORREF cref;
	D3DCOLOR d3dclr;
	cref = RGB (FOGCOLOR_R, FOGCOLOR_G, FOGCOLOR_B);
	d3dclr = COLORREF_2_D3DCOLOR (cref);
	if (FAILED (scene->SetSceneBackgroundRGB (D3DRMColorGetRed (d3dclr),
											  D3DRMColorGetGreen (d3dclr),
											  D3DRMColorGetBlue (d3dclr))))
											  goto generic_error;
	if (FAILED (scene->SetSceneFogColor (d3dclr)))
		goto generic_error;
	if (FAILED (scene->SetSceneFogMethod (D3DRMFOGMETHOD_ANY)))
		goto generic_error;
	if (FAILED (scene->SetSceneFogParams (D3DVAL (0),
										  D3DVAL (1000),
										  D3DVAL (0.6))))
										  goto generic_error;
	if (FAILED (scene->SetSceneFogEnable (TRUE)))
		goto generic_error;

	///////////////////////////////////////////////////////////////////////////
	// All Objects in Game
	///////////////////////////////////////////////////////////////////////////
	// Ammo of Player
	///////////////////////////////////
	if (FAILED (pD3DRM->CreateMeshBuilder (&builder4)))
		goto generic_error;
	if (FAILED (builder4->Load (XFILE_AMMO1,
								NULL,
								D3DRMLOAD_FROMFILE,
								NULL,
								NULL)))
								goto generic_error;

	for (i = 0; i < NUMBER_AMMO_PLAYER; i++)
	{
		if (FAILED (pD3DRM->CreateFrame (scene, &m_PlayerAmmo[i].pAmmoFrame)))
			goto generic_error;
		if (FAILED (m_PlayerAmmo[i].pAmmoFrame->AddVisual ((LPDIRECT3DRMVISUAL) builder4)))
			goto generic_error;
	}

	///////////////////////////////////
	// Robot1
	///////////////////////////////////
	if (FAILED (pD3DRM->CreateMeshBuilder (&builder5)))
		goto generic_error;
	if (FAILED (builder5->Load (XFILE_ROBOT1,
								NULL,
								D3DRMLOAD_FROMFILE,
								NULL,
								NULL)))
								goto generic_error;
	
	for (i = 0; i < NUMBER_ROBOT1; i++)
	{
		// Robot Frame
		if (FAILED (pD3DRM->CreateFrame (scene, &m_Robot1[i].pRobotFrame)))
			goto generic_error;
		if (FAILED (m_Robot1[i].pRobotFrame->AddVisual ((LPDIRECT3DRMVISUAL) builder5)))
			goto generic_error;

		// Chase Frame
		if (FAILED (pD3DRM->CreateFrame (scene, &m_Robot1[i].pChaseFrame)))
			goto generic_error;

		// Animation
		if (FAILED (pD3DRM->CreateAnimation (&m_Robot1[i].pRobotPath)))
			goto generic_error;
		if (FAILED (m_Robot1[i].pRobotPath->SetOptions (D3DRMANIMATION_CLOSED |
														D3DRMANIMATION_SPLINEPOSITION |
														D3DRMANIMATION_POSITION)))
														goto generic_error;

		// Key Frames
		for (j = 0; j < m_NumKey1[i]; j++)
			m_Robot1[i].pRobotPath->AddPositionKey (m_PathTime1[i][j],
													m_Path1[i][j].x,
													m_Path1[i][j].y,
													m_Path1[i][j].z);
	}

	///////////////////////////////////
	// Robot2
	///////////////////////////////////
	if (FAILED (pD3DRM->CreateMeshBuilder (&builder6)))
		goto generic_error;
	if (FAILED (builder6->Load (XFILE_ROBOT2,
								NULL,
								D3DRMLOAD_FROMFILE,
								NULL,
								NULL)))
								goto generic_error;

	if (FAILED (pD3DRM->CreateMeshBuilder (&builder7)))
		goto generic_error;
	if (FAILED (builder7->Load (XFILE_AMMO2,
								NULL,
								D3DRMLOAD_FROMFILE,
								NULL,
								NULL)))
								goto generic_error;

	for (i = 0; i < NUMBER_ROBOT2; i++)
	{
		// Robot Frame
		if (FAILED (pD3DRM->CreateFrame (scene, &m_Robot2[i].pRobotFrame)))
			goto generic_error;
		if (FAILED (m_Robot2[i].pRobotFrame->AddVisual ((LPDIRECT3DRMVISUAL) builder6)))
			goto generic_error;

		// Chase Frame
		if (FAILED (pD3DRM->CreateFrame (scene, &m_Robot2[i].pChaseFrame)))
			goto generic_error;

		// Animation
		if (FAILED (pD3DRM->CreateAnimation (&m_Robot2[i].pRobotPath)))
			goto generic_error;
		if (FAILED (m_Robot2[i].pRobotPath->SetOptions (D3DRMANIMATION_CLOSED |
														D3DRMANIMATION_SPLINEPOSITION |
														D3DRMANIMATION_POSITION)))
														goto generic_error;

		// Key Frames
		for (j = 0; j < m_NumKey2[i]; j++)
			m_Robot2[i].pRobotPath->AddPositionKey (m_PathTime2[i][j],
													m_Path2[i][j].x,
													m_Path2[i][j].y,
													m_Path2[i][j].z);

		///////////////////////////////////
		// Ammo of Robot2
		///////////////////////////////////
		for (j = 0; j < NUMBER_AMMO_ROBOT; j++)
		{
			if (FAILED (pD3DRM->CreateFrame (scene, &m_Robot2[i].Ammo[j].pAmmoFrame)))
				goto generic_error;
			if (FAILED (m_Robot2[i].Ammo[j].pAmmoFrame->AddVisual ((LPDIRECT3DRMVISUAL) builder7)))
				goto generic_error;
		}
	}

	///////////////////////////////////
	// Release All
	///////////////////////////////////
	SAFE_RELEASE (tex);
	SAFE_RELEASE (l2);
	SAFE_RELEASE (l1);
	SAFE_RELEASE (frame);
	SAFE_RELEASE (mesh);
	SAFE_RELEASE (builder7);
	SAFE_RELEASE (builder6);
	SAFE_RELEASE (builder5);
	SAFE_RELEASE (builder4);
	SAFE_RELEASE (builder3);
	SAFE_RELEASE (builder2);
	SAFE_RELEASE (builder1);
	return TRUE;

generic_error:
	SAFE_RELEASE (tex);
	SAFE_RELEASE (l2);
	SAFE_RELEASE (l1);
	SAFE_RELEASE (frame);
	SAFE_RELEASE (mesh);
	SAFE_RELEASE (builder7);
	SAFE_RELEASE (builder6);
	SAFE_RELEASE (builder5);
	SAFE_RELEASE (builder4);
	SAFE_RELEASE (builder3);
	SAFE_RELEASE (builder2);
	SAFE_RELEASE (builder1);
	return FALSE;
}

/////////////////////////////////////////////////////////////////////////////
// GDX InitGame
/////////////////////////////////////////////////////////////////////////////
void GDX::InitGame (void)
{
	int i;
	int j;

	///////////////////////////////////
	// Init Game Contents
	///////////////////////////////////
	m_GameLife = LIFE_PLAYER;
	m_GameScore = 0;

	switch (m_GameLevel)
	{
	case LEVEL_GAME_EASY:
		m_RobotWaitAmmo = WAITAMMO_ROBOT_EASY;
		m_RobotSpeed = SPEED_ROBOT_EASY;
		break;

	case LEVEL_GAME_NORMAL:
		m_RobotWaitAmmo = WAITAMMO_ROBOT_NORMAL;
		m_RobotSpeed = SPEED_ROBOT_NORMAL;
		break;

	case LEVEL_GAME_HARD:
		m_RobotWaitAmmo = WAITAMMO_ROBOT_HARD;
		m_RobotSpeed = SPEED_ROBOT_HARD;
		break;

	case LEVEL_GAME_HELLONEARTH:
		m_RobotWaitAmmo = WAITAMMO_ROBOT_HELLONEARTH;
		m_RobotSpeed = SPEED_ROBOT_HELLONEARTH;
		break;
	}

	///////////////////////////////////
	// Lights
	///////////////////////////////////
	m_bLight = FALSE;
	m_CountLight = 0;

	///////////////////////////////////
	// Init Ammo of Player
	///////////////////////////////////
	for (i = 0; i < NUMBER_AMMO_PLAYER; i++)
	{
		m_PlayerAmmo[i].bShoot = FALSE;
		m_PlayerAmmo[i].count = 0;
	}

	///////////////////////////////////
	// Init Robot 1
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT1; i++)
	{
		m_Robot1[i].bHitPlayer = FALSE;
		m_Robot1[i].fTime = 0;
		m_Robot1[i].life = LIFE_ROBOT1 * (m_GameLevel + 1);
	}

	///////////////////////////////////
	// Init Robot 2
	///////////////////////////////////
	for (i = 0; i < NUMBER_ROBOT2; i++)
	{
		m_Robot2[i].bHitPlayer = FALSE;
		m_Robot2[i].bRightArm = FALSE;
		m_Robot2[i].fTime = 0;
		m_Robot2[i].life = LIFE_ROBOT2 * (m_GameLevel + 1);
		m_Robot2[i].wait = 0;

		for (j = 0; j < NUMBER_AMMO_ROBOT; j++)
		{
			m_Robot2[i].Ammo[j].bShoot = FALSE;
			m_Robot2[i].Ammo[j].count = 0;
		}
	}
}