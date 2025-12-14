/////////////////////////////////////////////////////////////////////////////
// File Name:		GDX.h
// Author:			Tiwakorn Komut
// Source File:		GDX Header File
// Date:			16/05/2000
// Comment:			This is the last revision
/////////////////////////////////////////////////////////////////////////////
#ifndef GDX_H
#define GDX_H

#include <windows.h>
#include <math.h>
#include <mmsystem.h>
#include <time.h>

#include "KDX.h"
#include "DInput.h"
#include "DSound.h"
#include "KDX_Map.h"

/////////////////////////////////////////////////////////////////////////////
// Constants
/////////////////////////////////////////////////////////////////////////////
// Game States
#define STATE_GAME_TITLE				0
#define STATE_GAME_OPTION				1
#define STATE_GAME_NORMAL				2
#define STATE_GAME_PAUSE				3

// Number of Choices
#define NUMBER_CHOICE_GAME_TITLE		3
#define NUMBER_CHOICE_GAME_OPTION		4
#define NUMBER_CHOICE_GAME_PAUSE		2

// Number of Strings
#define NUMBER_STRING_GAME_TITLE		3
#define NUMBER_STRING_GAME_OPTION		4
#define NUMBER_STRING_GAME_PAUSE		2

// BMP Files
#define BMPFILE_LIFE1					"Life1.bmp"
#define BMPFILE_LIFE2					"Life2.bmp"
#define BMPFILE_GAMENAME				"GameName.bmp"
#define BMPFILE_TEXTURE_WATER			"TextureW_i.bmp"

// Models
#define XFILE_BUILDING					"Building.x"
#define XFILE_FLOOR						"Floor.x"
#define XFILE_WATER						"Water.x"
#define XFILE_ROBOT1					"Robot01.x"
#define XFILE_ROBOT2					"Robot02.x"
#define XFILE_AMMO1						"Ammo01.x"
#define XFILE_AMMO2						"Ammo02.x"

// Wav Files
#define WAVFILE_BOOM					"Boom.wav"
#define WAVFILE_CLICK					"Click.wav"
#define WAVFILE_INTRO					"Intro.wav"
#define WAVFILE_THEME					"Theme.wav"
#define WAVFILE_PLAYER_HURT				"PlayerHurt.wav"
#define WAVFILE_PLAYER_SHOOT			"PlayerShoot.wav"
#define WAVFILE_ROBOT1_HURT				"RobotHurt01.wav"
#define WAVFILE_ROBOT1_DIE				"RobotDie01.wav"
#define WAVFILE_ROBOT2_HURT				"RobotHurt02.wav"
#define WAVFILE_ROBOT2_DIE				"RobotDie02.wav"

// Map Files
#define MAPFILE_0_0_2					"Map0_0_2.map"
#define MAPFILE_0_1_1					"Map0_1_1.map"
#define MAPFILE_0_1_2					"Map0_1_2.map"
#define MAPFILE_0_1_3					"Map0_1_3.map"
#define MAPFILE_0_1_4					"Map0_1_4.map"
#define MAPFILE_0_2_0					"Map0_2_0.map"
#define MAPFILE_0_2_1					"Map0_2_1.map"
#define MAPFILE_0_2_2					"Map0_2_2.map"
#define MAPFILE_0_2_3					"Map0_2_3.map"
#define MAPFILE_0_3_0					"Map0_3_0.map"
#define MAPFILE_0_3_1					"Map0_3_1.map"
#define MAPFILE_0_3_2					"Map0_3_2.map"
#define MAPFILE_0_3_3					"Map0_3_3.map"
#define MAPFILE_0_3_4					"Map0_3_4.map"
#define MAPFILE_1_2_2					"Map1_2_2.map"
#define MAPFILE_1_2_3					"Map1_2_3.map"
#define MAPFILE_1_3_2					"Map1_3_2.map"
#define MAPFILE_1_3_3					"Map1_3_3.map"
#define MAPFILE_1_3_4					"Map1_3_4.map"

// Key
#define KEY_PAUSE						VK_ESCAPE

// Strings
#define STRING_NEWGAME					"New Game"
#define STRING_OPTION					"Option"
#define STRING_QUIT						"Quit"
#define STRING_LEVEL					"Level"
#define STRING_EASY						"EASY"
#define STRING_NORMAL					"NORMAL"
#define STRING_HARD						"HARD"
#define STRING_HELLONEARTH				"HELL ON EARTH"
#define STRING_RESUMEGAME				"Resume Game"
#define STRING_RETURNTOTITLE			"Return to Title"
#define STRING_YOUWIN					"You Win!"
#define STRING_YOULOSE					"You Lose!"

// Text Colors
#define TEXTCOLOR_GAME_SELECTED			RGB (255, 255, 255)
#define TEXTCOLOR_GAME_UNSELECTED		RGB (100, 100, 100)
#define TEXTCOLOR_GAME_SHADOW			RGB (10, 10, 10)
#define TEXTCOLOR_GAME_LIFE				RGB (255, 255, 0)
#define TEXTCOLOR_GAME_SCORE			RGB (255, 255, 0)
#define TEXTCOLOR_GAME_BLINK1			RGB (255, 255, 0)
#define TEXTCOLOR_GAME_BLINK2			RGB (255, 0, 0)

// Fonts
#define FONT_GAME1						"Impact"
#define FONT_GAME2						"Impact"

// Widths
#define WIDTH_GAME_FONT1				0
#define WIDTH_GAME_FONT2				0
#define WIDTH_SURFACE_LIFE				100
#define WIDTH_SURFACE_SCORE				100
#define WIDTH_CHAR_FONT_GAME1			15

// Heights
#define HEIGHT_GAME_FONT1				40
#define HEIGHT_GAME_FONT2				20
#define HEIGHT_SURFACE_LIFE				20
#define HEIGHT_SURFACE_SCORE			20
#define HEIGHT_PLAYER_EYES				5

// Positions X
#define X_START_LIFE					37

// Positions Y
#define Y_START_LIFE					3

// Map
#define MAP_LEVEL						2
#define MAP_I							5
#define MAP_J							10

// Game Levels
#define LEVEL_GAME_EASY					0
#define LEVEL_GAME_NORMAL				1
#define LEVEL_GAME_HARD					2
#define LEVEL_GAME_HELLONEARTH			3

// Point Lights
#define LIGHTCOLOR_NORMAL_R				0.8
#define LIGHTCOLOR_NORMAL_G				0.8
#define LIGHTCOLOR_NORMAL_B				0.8
#define LIGHTCOLOR_HURT_R				0.8
#define LIGHTCOLOR_HURT_G				0
#define LIGHTCOLOR_HURT_B				0

// Fog
#define FOGCOLOR_R						180
#define FOGCOLOR_G						180
#define FOGCOLOR_B						250

// Animations
#define NUMBEROFKEY_ROBOT1_PATH1		7
#define NUMBEROFKEY_ROBOT1_PATH2		5
#define NUMBEROFKEY_ROBOT1_PATH3		5
#define NUMBEROFKEY_ROBOT1_PATH4		7
#define NUMBEROFKEY_ROBOT1_PATH5		7

#define NUMBEROFKEY_ROBOT2_PATH1		4
#define NUMBEROFKEY_ROBOT2_PATH2		4
#define NUMBEROFKEY_ROBOT2_PATH3		9
#define NUMBEROFKEY_ROBOT2_PATH4		5
#define NUMBEROFKEY_ROBOT2_PATH5		5
#define NUMBEROFKEY_ROBOT2_PATH6		5

#define SPEED_ROBOT_EASY				0.0025f
#define SPEED_ROBOT_NORMAL				0.005f
#define SPEED_ROBOT_HARD				0.01f	
#define SPEED_ROBOT_HELLONEARTH			0.02f

// Life
#define LIFE_PLAYER						60
#define LIFE_ROBOT1						40
#define LIFE_ROBOT2						80
#define LIFE_AMMO						10
#define LIFE_DAMAGE						5

// Numbers
#define NUMBER_ROBOT1					5
#define NUMBER_ROBOT2					6
#define NUMBER_KEYFRAME_ROBOT1			10
#define NUMBER_KEYFRAME_ROBOT2			10
#define NUMBER_AMMO_ROBOT				20
#define NUMBER_AMMO_PLAYER				10

// Far
#define FAR_AMMO_PLAYER					200
#define FAR_AMMO_ROBOT					200

// Wait
#define WAITAMMO_ROBOT_EASY				60	
#define WAITAMMO_ROBOT_NORMAL			30
#define WAITAMMO_ROBOT_HARD				15
#define WAITAMMO_ROBOT_HELLONEARTH		7
#define WAITAMMO_PLAYER					10

#define WAIT_BLINK_TEXT					4
#define WAIT_BLINK_SCREEN				10

// Deltas
#define DELTA_AMMO						2
#define DELTA_PLAYER					1

// Ammo of Robot2
#define STARTAMMOOFROBOT2_X				3.25
#define STARTAMMOOFROBOT2_Y				5.843
#define STARTAMMOOFROBOT2_Z				3.697

// Camera
#define CAMERA_POSITION_X				108
#define CAMERA_POSITION_Y				5
#define CAMERA_POSITION_Z				-300

/////////////////////////////////////////////////////////////////////////////
// Defined Types
/////////////////////////////////////////////////////////////////////////////
typedef struct tagAmmoInfo
{
	LPDIRECT3DRMFRAME3		pAmmoFrame;
	BOOL					bShoot;
	int						count;
} AMMOINFO, * LPAMMOINFO;

typedef struct tagRobotInfo
{
	int						life;
	int						wait;
	BOOL					bRightArm;
	BOOL					bHitPlayer;
	FLOAT					fTime;
	LPDIRECT3DRMFRAME3		pChaseFrame;
	LPDIRECT3DRMFRAME3		pRobotFrame;
	LPDIRECT3DRMANIMATION2	pRobotPath;
	AMMOINFO				Ammo[NUMBER_AMMO_ROBOT];
} ROBOTINFO, * LPROBOTINFO;

typedef struct tagMap
{
	int						type;
	int						level;
	int						reserved;
	KDX_Map*				pMap;
} MAP, * LPMAP;

/////////////////////////////////////////////////////////////////////////////
// GDX Class
/////////////////////////////////////////////////////////////////////////////
class GDX : public KDX
{
public:
// Methods
	GDX (void);						// Constructor
	~GDX (void);					// Destructor
	void Initialise (void);			// Initialise GDX Class
	void Finalise (void);			// Finalise GDX Class

	void KeyInApplication (WPARAM wParam);
	BOOL Create (HWND hWnd, HINSTANCE hInstance);
	BOOL CreateOffscreens (void);
	BOOL Render (void);

protected:
// Methods
	void KeyInGameTitle (WPARAM wParam);
	void KeyInGameOption (WPARAM wParam);
	void KeyInGameNormal (WPARAM wParam);
	void KeyInGamePause (WPARAM wParam);

	HRESULT UpdateGameSurfaceTitle (void);
	HRESULT UpdateGameSurfaceOption (void);
	HRESULT UpdateGameSurfacePause (void);
	HRESULT UpdateGameSurfaceWinLose (void);
	HRESULT UpdateGameSurfaceLife (void);
	HRESULT UpdateGameSurfaceScore (void);
	
public:
// Methods
	inline D3DCOLOR COLORREF_2_D3DCOLOR (COLORREF cref);
	inline COLORREF D3DCOLOR_2_COLORREF (D3DCOLOR d3dclr);
	static BOOL CheckCollision (D3DVECTOR pos1, D3DRMBOX box1, D3DVECTOR pos2, D3DRMBOX box2);

	static void MoveTextureCallback (LPDIRECT3DRMFRAME3 frame, void* p, D3DVALUE val);
	static void MoveCameraCallback (LPDIRECT3DRMFRAME3 frame, void* p, D3DVALUE val);
	static void CleanupObjectsCallback (LPDIRECT3DRMOBJECT pObj, void* p);
	
	BOOL InitMaps (void);
	static int GetMapsType (GDX* pGDX, int level, int i, int j);
	static int GetMapsLevel (GDX* pGDX, int level, int i, int j);
	static void CompareMaps (GDX* pGDX, D3DVECTOR OldPos);

	BOOL BuildScene (LPDIRECT3DRM3 pD3DRM, LPDIRECT3DRMDEVICE3 dev, LPDIRECT3DRMVIEWPORT2 view, LPDIRECT3DRMFRAME3 scene, LPDIRECT3DRMFRAME3 camera);
	void InitGame (void);

public:
// Attributes
	// Main Section
	HINSTANCE				m_hInstance;
	int						m_GameState;

	// DirectDraw Surfaces
	DX_Surface*				m_SurfaceLifeBmp1;
	DX_Surface*				m_SurfaceLifeBmp2;
	DX_Surface*				m_SurfaceLife;
	DX_Surface*				m_SurfaceScore;
	DX_Surface*				m_SurfaceGameName;

	// DirectInput
	BOOL					m_bJoystick;
	CInput*					m_Input;
	CKeyboard*				m_Keyboard;
	CMouse*					m_Mouse;
	CJoystick*				m_Joystick;

	// DirectSound
	CSound*					m_Sound;
	CBuffer*				m_Buffer1;
	CBuffer*				m_Buffer2;

	// Fonts
	HFONT					m_FontGame1;
	HFONT					m_FontGame2;

	// Indices
	int						m_IndexGameTitle;
	int						m_IndexGameOption;
	int						m_IndexGamePause;

	// Game Contents
	int						m_GameLife;
	int						m_GameScore;
	int						m_GameLevel;
	int						m_RobotWaitAmmo;
	float					m_RobotSpeed;
	
	// Maps
	int						m_CurrMap;
	MAP						m_Maps[MAP_LEVEL][MAP_I][MAP_J];

	// Light
	BOOL					m_bLight;
	int						m_CountLight;
	
	LPDIRECT3DRMLIGHT		m_PointLight1;
	LPDIRECT3DRMLIGHT		m_PointLight2;

	// Robots
	ROBOTINFO				m_Robot1[NUMBER_ROBOT1];
	ROBOTINFO				m_Robot2[NUMBER_ROBOT2];
	AMMOINFO				m_PlayerAmmo[NUMBER_AMMO_PLAYER];




	// Animations
	static const D3DVECTOR	m_Path1[NUMBER_ROBOT1][NUMBER_KEYFRAME_ROBOT1];
	static const D3DVECTOR	m_Path2[NUMBER_ROBOT2][NUMBER_KEYFRAME_ROBOT2];

	static const D3DVALUE	m_PathTime1[NUMBER_ROBOT1] [NUMBER_KEYFRAME_ROBOT1];
	static const D3DVALUE	m_PathTime2[NUMBER_ROBOT2] [NUMBER_KEYFRAME_ROBOT2];
	
	static const int	m_NumKey1[NUMBER_ROBOT1];
	static const int	m_NumKey2[NUMBER_ROBOT2];

	// Strings
	static const char m_szStringGameTitle[NUMBER_STRING_GAME_TITLE][50];
	static const char m_szStringGameOption[NUMBER_STRING_GAME_OPTION][50];
	static const char m_szStringGamePause[NUMBER_STRING_GAME_PAUSE][50];

	// Boxes
	static const D3DRMBOX m_BoxPlayer;
	static const D3DRMBOX m_BoxRobot1;
	static const D3DRMBOX m_BoxRobot2;
	static const D3DRMBOX m_BoxAmmo1;
	static const D3DRMBOX m_BoxAmmo2;

	// Rotates
	static const double m_ConstSin;
	static const double m_ConstCos;
};

#endif