/////////////////////////////////////////////////////////////////////////////
// File Name:		KDX.h
// Author:			Tiwakorn Komut
// Source File:		KDX Header File
// Date:			23/03/2000
// Comment:
/////////////////////////////////////////////////////////////////////////////
#ifndef KDX_H
#define KDX_H

#include "DX.h"

/////////////////////////////////////////////////////////////////////////////
// Defined types
/////////////////////////////////////////////////////////////////////////////
// State of application
#define STATE_NORMAL							0	// Application doesn't display any dialog
#define STATE_DLG_HELP							1	// display Help dialog
#define STATE_DLG_RENDER						2	// display Render dialog
#define STATE_DLG_SYSTEMINFO					3	// display System Info dialog

// Number of choice in dialog
#define NUMBER_CHOICE_SHADEMODE					3
#define NUMBER_CHOICE_LIGHTING					2
#define NUMBER_CHOICE_FILLMODE					3
#define NUMBER_CHOICE_DITHERING					2
#define NUMBER_CHOICE_ANTIALIASING				2
#define NUMBER_CHOICE_TEXTUREFILTERING			2
#define NUMBER_CHOICE_TEXTUREMAPPING			2
#define NUMBER_CHOICE_ZBUFFER					2
#define NUMBER_CHOICE_BACKBUFFERIN				2
#define NUMBER_CHOICE_ZBUFFERIN					3

// Number of strings in dialog
#define NUMBER_STRING_DLG_HELP					4
#define NUMBER_STRING_DLG_RENDER				6
#define NUMBER_STRING_DLG_SYSTEMINFO_PART1		2
#define NUMBER_STRING_DLG_SYSTEMINFO_PART2		5

// Dialog bitmap file
#define BMPFILE_DLG								"Dialog.bmp"

// Key Controls
#define KEY_DLG_HELP							VK_F1
#define KEY_DLG_RENDER							VK_F2
#define KEY_DLG_SYSTEMINFO						VK_F3
#define KEY_MOVECHOICE_LEFT						VK_LEFT
#define KEY_MOVECHOICE_RIGHT					VK_RIGHT
#define KEY_MOVECHOICE_UP						VK_UP
#define KEY_MOVECHOICE_DOWN						VK_DOWN
#define KEY_OK									VK_RETURN
#define KEY_CANCEL								VK_ESCAPE
#define KEY_EXIT								VK_ESCAPE

// Strings
#define STRING_HEADER_HELP						"Help"
#define STRING_HEADER_RENDER					"Render"
#define STRING_HEADER_SYSTEMINFO				"System Info"
#define STRING_OKCANCEL							"[Enter] OK/ [ESC] Cancel"

#define STRING_HELP_LINE1						"F1:    Help Dialog"
#define STRING_HELP_LINE2						"F2:    Render Dialog"		
#define STRING_HELP_LINE3						"F3:    System Info Dialog"
#define STRING_HELP_LINE4						"ESC:   Exit"

#define STRING_SHADEMODE						"Shade Mode:"
#define STRING_LIGHTING							"Lighting:"
#define STRING_FILLMODE							"Fill Mode:"
#define STRING_DITHERING						"Dithering:"
#define STRING_ANTIALIASING						"Anti-aliasing:"
#define STRING_TEXTUREFILTERING					"Texture Filtering:"

#define STRING_FLAT								"Flat"
#define STRING_GOURAUD							"Gouraud"
#define STRING_PHONG							"Phong"
#define STRING_POINT							"Point"
#define STRING_WIREFRAME						"Wireframe"
#define STRING_DISABLED							"Disabled"
#define STRING_POINTFILTERING					"Point Filtering"
#define STRING_BILINEARFILTERING				"Bi-Linear Filtering"
#define STRING_SOLID							"Solid"
#define STRING_ENABLED							"Enabled"

#define STRING_DIRECT3DDRIVER					"Direct3D Driver:"
#define STRING_DISPLAYMODE						"Display Mode:"
#define STRING_DIRECTDRAWDRIVER					"DirectDraw Driver:"
#define STRING_TEXTUREMAPPING					"Texture Mapping:"
#define STRING_ZBUFFER							"Z-Buffer:"
#define STRING_BACKBUFFERIN						"Back Buffer in:"
#define STRING_ZBUFFERIN						"Z-Buffer in:"

#define STRING_YES								"Yes"
#define STRING_NO								"No"
#define STRING_VIDEOMEMORY						"Video Memory"
#define STRING_SYSTEMMEMORY						"System Memory"
#define STRING_NONE								"-"

// Text Color
#define TEXTCOLOR_DLG_HEADER					RGB (255, 255, 0)
#define TEXTCOLOR_DLG_NORMAL					RGB (255, 255, 255)
#define TEXTCOLOR_DLG_SELECTED					RGB (255, 255, 0)
#define TEXTCOLOR_DLG_GRAYED					RGB (192, 192, 192)
#define TEXTCOLOR_DLG_SHADOW					RGB (10, 10, 10)
#define TEXTCOLOR_DLG_OKCANCEL					RGB (255, 0, 0)
#define TEXTCOLOR_FPS_NORMAL					RGB (255, 255, 255)


// Fonts	
#define FONT_DLG_HEADER							"Impact"
#define FONT_DLG_NORMAL							"Arial"
#define FONT_DLG_OKCANCEL						"Arial"
#define FONT_FPS_NORMAL							"Arial"

// Widths
#define WIDTH_DLG_FONT_HEADER					0
#define WIDTH_DLG_FONT_NORMAL					0
#define WIDTH_DLG_FONT_OKCANCEL					0
#define WIDTH_FPS_FONT_NORMAL					0
#define WIDTH_DLG_COLUMN						100
#define WIDTH_FPS_SURFACE						100

// Heights
#define HEIGHT_DLG_FONT_HEADER					20
#define HEIGHT_DLG_FONT_NORMAL					14
#define HEIGHT_DLG_FONT_OKCANCEL				14
#define HEIGHT_FPS_FONT_NORMAL					14
#define HEIGHT_DLG_ROW							4
#define HEIGHT_FPS_SURFACE						14

// Positions X
#define X_DLG_START_CONTENTS					60
#define X_DLG_START_HEADER						70
#define X_DLG_START_OKCANCEL					130

// Positions Y
#define Y_DLG_START_CONTENTS					37
#define Y_DLG_START_HEADER						12
#define Y_DLG_START_OKCANCEL					175

/////////////////////////////////////////////////////////////////////////////
// KDX Class
/////////////////////////////////////////////////////////////////////////////
class KDX : public DX_Screen
{
public:
// Methods
	KDX (void);
	~KDX (void);
	void Initialise (void);
	void Finalise (void);

	void KeyInApplication (WPARAM wParam);
	HRESULT UpdateDlgSurfaceHelp (DX_Surface* Bmp, DX_Surface* Dest);
	HRESULT UpdateDlgSurfaceRender (DX_Surface* Bmp, DX_Surface* Dest);
	HRESULT UpdateDlgSurfaceSystemInfo (DX_Surface* Bmp, DX_Surface* Dest);
	HRESULT UpdateFPSSurface (DX_Surface* Dest);
	BOOL Create (HWND hWnd);
	BOOL CreateOffscreens (void);
	BOOL Render (void);

protected:
//Methods
	void KeyInDlgHelp (WPARAM wParam);
	void KeyInDlgRender (WPARAM wParam);
	void KeyInDlgSystemInfo (WPARAM wParam);
	void InitDlgHelp (void);
	void InitDlgRender (void);
	void InitDlgSystemInfo (void);
	BOOL ChangeRenderState (void);
	BOOL ChangeDirect3DDriverAndMode (int driver, int mode);

public:
// Attributes:
	// Main section
	int 			m_State;		// state of application
	
	DX_Surface*		m_SurfaceDlgBmp;
	DX_Surface*		m_SurfaceDlg;
	DX_Surface*		m_SurfaceFPS;

	HFONT			m_FontDlgHeader;
	HFONT			m_FontDlgNormal;
	HFONT			m_FontDlgOKCancel;
	HFONT			m_FontFPSNormal;

	// Indexes
	int 			m_IndexDlgRender;
	int 			m_IndexDlgSystemInfo;
	int 			m_IndexShadeMode;
	int 			m_IndexLighting;
	int 			m_IndexFillMode;
	int 			m_IndexDithering;
	int 			m_IndexAntialiasing;
	int 			m_IndexTextureFiltering;
	int 			m_IndexDirect3DDriver;
	int 			m_IndexDisplayMode;

	static const char m_szStringDlgHelp[NUMBER_STRING_DLG_HELP][50];
	static const char m_szStringDlgRender[NUMBER_STRING_DLG_RENDER][50];
	static const char m_szChoiceShadeMode[NUMBER_CHOICE_SHADEMODE][50];
	static const char m_szChoiceLighting[NUMBER_CHOICE_LIGHTING][50];
	static const char m_szChoiceFillMode[NUMBER_CHOICE_FILLMODE][50];
	static const char m_szChoiceDithering[NUMBER_CHOICE_DITHERING][50];
	static const char m_szChoiceAntialiasing[NUMBER_CHOICE_ANTIALIASING][50];
	static const char m_szChoiceTextureFiltering[NUMBER_CHOICE_TEXTUREFILTERING][50];
	static const char m_szStringDlgSystemInfoPart1[NUMBER_STRING_DLG_SYSTEMINFO_PART1][50];
	static const char m_szStringDlgSystemInfoPart2[NUMBER_STRING_DLG_SYSTEMINFO_PART2][50];
	static const char m_szChoiceTextureMapping[NUMBER_CHOICE_TEXTUREMAPPING][50];
	static const char m_szChoiceZBuffer[NUMBER_CHOICE_ZBUFFER][50];
	static const char m_szChoiceBackBufferin[NUMBER_CHOICE_BACKBUFFERIN][50];
	static const char m_szChoiceZBufferin[NUMBER_CHOICE_ZBUFFERIN][50];
};

#endif