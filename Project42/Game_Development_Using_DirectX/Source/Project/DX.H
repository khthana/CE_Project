/////////////////////////////////////////////////////////////////////////////
// File Name:	DX.h
// Author:		Tiwakorn Komut
// Source File:	Main Header File
// Date:		15/03/2000
// Comment:		Concept from CDX Library 1.6
//				Microsoft DirectX SDK 6.0
/////////////////////////////////////////////////////////////////////////////
#ifndef DX_H
#define DX_H

#include <stdio.h>
#include <d3drm.h>

/////////////////////////////////////////////////////////////////////////////
// Defined Types
/////////////////////////////////////////////////////////////////////////////
// macros
#define SAFE_RELEASE(x)		if (x != NULL) { x->Release(); x = NULL; }
#define SAFE_DELETE(x)		if (x != NULL) { delete x; x = NULL; }
#define MSG(hwnd, msg)		MessageBox (hwnd, msg, "Application Message", MB_OK)

// Application constants
#define MAX_D3DDRIVERS		5			// max Direct3D drivers
#define MAX_DDDRIVERS		5			// max DirectDraw drivers
#define MAX_MODES			40			// max Display modes
#define MAX_MODEWIDTH		1600		// max display mode width that application allow
#define MAX_MODEHEIGHT		1200		// max display mode height that application allow
#define MIN_BPP				16			// min display mode bpp that application allow
#define DEFAULT_WIDTH		640			// display mode Width that choosed as default
#define DEFAULT_HEIGHT		480			// display mode Height that choosed as default
#define DEFAULT_BPP			16			// display mode BPP that choosed as default
#define VALUE_ERROR			-10			// error value
#define VALUE_YOUDECIDE		-20			// choosed automatically by application

// Defined types
typedef struct tagDDDRIVER
{
	char			Name[30];			// short name of the driver
	DDCAPS			HWCaps;				// Hardware capabilities
	GUID			Guid;				// it's GUID
	BOOL			bIsPrimary;			// is this the primary device (software emulation)
} DDDRIVER, * LPDDDRIVER;

typedef struct tagD3DDRIVER
{
	char			Name[30];			// short name of the driver
	char			About[50];			// short string about the driver
	D3DDEVICEDESC	Desc;				// D3DDEVICEDESC for complete information
	GUID			Guid;				// it's GUID
	BOOL			bIsHardware;		// does this driver represent a hardware device
	BOOL			bDoesTextures;		// does this driver do texture mapping ?
	BOOL			bDoesZBuffer;		// can this driver use a z-buffer ?
	BOOL			bCanDoWindow;		// can this driver render to Windows's display depth ?
} D3DDRIVER, * LPD3DDRIVER;

typedef struct tagMODE
{
	int				w;					// width
	int				h;					// height
	int				bpp;				// bits per pixel
	BOOL			bThisDriverCanDo;	// can current D3D driver render in this mode ?
} MODE, * LPMODE;

typedef struct tagDDDRIVERINFO
{
	int				NumDrivers;			// number of DirectDraw drivers
	int				CurrDriver;			// current DirectDraw driver that we currently use
	DDDRIVER		DDDriver[MAX_DDDRIVERS];
										// list of all DirectDraw drivers
} DDDRIVERINFO, * LPDDDRIVERINFO;

typedef struct tagD3DDRIVERINFO
{
	int				NumDrivers;			// number of Direct3D drivers
	int				CurrDriver;			// current Direct3D driver that we currently use
	D3DDRIVER		D3DDriver[MAX_D3DDRIVERS];
										// list of all Direct3D drivers
} D3DDRIVERINFO, * LPD3DDRIVERINFO;

typedef struct tagMODEINFO
{
	int				NumModes;			// number of Display modes
	int				CurrMode;			// current Display mode that we currently use
	MODE			Mode[MAX_MODES];	// list of all Display modes
} MODEINFO, * LPMODEINFO;

typedef struct tagD3DRENDERSTATE
{
	BOOL			bZBufferOn;			// z-buffer is on
	BOOL			bPerspCorrect;		// perspective correction is on
	D3DSHADEMODE	ShadeMode;			// flat, gouraud, phong
	
	D3DTEXTUREFILTER
					TextureFilter;		// linear or bi-linear texture filter
	D3DTEXTUREBLEND	
					TextureBlend;		// use shade mode of copy mode

	D3DFILLMODE		FillMode;			// solid, lines, points

	BOOL			bDithering;			// dithering is on
	BOOL			bSpecular;			// specular highlights are on
	BOOL			bAntialiasing;		// anti-aliasing is on

	BOOL			bFogEnabled;		// fog is on
	D3DCOLOR		FogColor;			// fog color
	D3DFOGMODE		FogMode;			// linear, exp, ect.
	D3DVALUE		FogStart;			// beginning depth
	D3DVALUE		FogEnd;				// ending depth
} D3DRENDERSTATE, * LPD3DRENDERSTATE;

class DX_Surface;						// declare surface class					
class DX_Clipper;						// declare clipper class

/////////////////////////////////////////////////////////////////////////////
// DX_Screen Class
/////////////////////////////////////////////////////////////////////////////
class DX_Screen
{
public:
// Methods
	DX_Screen (void);					// Constructor of DX_Screen class
	~DX_Screen (void);					// Destructor of DX_Screen class

	void Initialise (void);				// Initialise DX_Screen class
	void Finalise (void);				// Finalise DX_Screen class

	///////////////////////////////////////////////////////////////
	// Callback functions										 	
	///////////////////////////////////////////////////////////////
	//
	// static BOOL WINAPI DDEnumCallback	(GUID FAR* lpGUID,
	//										 LPSTR lpDriverDesc,
	//										 LPSTR lpDriverName,
	//										 LPVOID lpContext);
    //
	// static HRESULT WINAPI EnumDisplayModesCallback
	//										(LPDDSURFACEDESC pddsd,
	//										 LPVOID lpContext);
    //
	// static HRESULT WINAPI EnumDeviceFunc 
	//										(LPGUID lpGuid,
	//										 LPSTR lpDeviceDescription,
	//										 LPSTR lpDeviceName,
	//										 LPD3DDEVICEDESC lpHWDesc,
	//										 LPD3DDEVICEDESC lpHELDesc,
	//										 LPVOID lpContext);
	// 
	// static int CompareModes (const void* arg1, const void* arg2);
	//
	///////////////////////////////////////////////////////////////

	BOOL EnumerateDDDevices (LPDDDRIVERINFO lpinfo);
	HRESULT CreateD3DRM (void);			// create m_D3DRM
										// create m_scene
										// create m_camera

	HRESULT CreateDD (LPGUID lpGuid);	// create m_DD
										// records m_bIsPrimary

	HRESULT RememberWindowsMode (LPMODE lpmode);
										// record current Windows display

	BOOL EnumerateDisplayModes (LPMODEINFO lpinfo);
	HRESULT CreateD3D (void);			// create m_D3D

	BOOL EnumerateDevices (LPD3DDRIVERINFO lpinfo);

	BOOL VerifyDriverAndMode (int* lpdriver, int* lpmode);
										// return appropriate driver
										// and mode to *lpdriver and *lpmode
	BOOL PickDriver (int* driver, DWORD depths);
	BOOL PickDisplayMode (int* mode, DWORD depths);
	BOOL FilterDisplayModes (int driver);
	DWORD BPPToDDBD (int bpp);

	HRESULT SetCoopLevel (HWND hWnd);
	HRESULT SetDisplayMode (int w, int h, int bpp);

	HRESULT CreateBuffers (BOOL bIsHardware);
	HRESULT CreateZBuffer (int w, int h, int driver);
	HRESULT CreateClipper (DX_Surface* dest);
										// create and attach clipper to dest
	HRESULT CreateDevice (int driver);	// create m_D3DDevice
	HRESULT CreateDevAndView (void);	// create m_dev
										// and m_view

	HRESULT D3DSetRenderState (void);	// set render state of m_D3DDevice
	HRESULT SetRenderState (void);		// set render state of m_dev
	void DefaultD3DRenderState (LPD3DRENDERSTATE lpstate);

	BOOL ChangeDriver (int driver);		// change D3D driver
	BOOL ChangeMode (int mode);			// change Dislplay mode

	BOOL Create (HWND hWnd);			// create all in one
	HRESULT Render (void);				// render scene
	HRESULT Restore (void);				// restore all surface
	HRESULT Flip (void);				// flip front and backbuffer

	// Get contents
	LPDIRECT3DRM3				GetD3DRM (void)			{ return m_D3DRM; }
	LPDIRECT3DRMDEVICE3			GetDevice (void)		{ return m_dev; }
	LPDIRECT3DRMVIEWPORT2		GetViewport (void)		{ return m_view; }
	LPDIRECT3DRMFRAME3			GetScene (void)			{ return m_scene; }
	LPDIRECT3DRMFRAME3			GetCamera (void)		{ return m_camera; }

	LPDIRECT3D2					GetD3D (void)			{ return m_D3D; }
	LPDIRECT3DDEVICE2			GetD3DDevice (void)		{ return m_D3DDevice; }

	LPDIRECTDRAW				GetDD (void)			{ return m_DD; }
	DX_Surface*					GetFront (void)			{ return m_FrontBuffer; }
	DX_Surface*					GetBack (void)			{ return m_BackBuffer; }
	DX_Surface*					GetDepth (void)			{ return m_ZBuffer; }
	DX_Clipper*					GetClipper (void)		{ return m_Clipper; }
	
	MODE						GetThisMode (void)		{ return m_ThisMode; }
	int							GetWidth (void)			{ return m_ThisMode.w; }
	int							GetHeight (void)		{ return m_ThisMode.h; }
	int							GetBpp (void)			{ return m_ThisMode.bpp; }

public:
// Attributes
	// Main section
	HWND						m_hWnd;					// handle main window
	MODE						m_WindowsDisplay;		// current Windows display mode

	// Direct3DRM section
	LPDIRECT3DRM3				m_D3DRM;
	LPDIRECT3DRMDEVICE3			m_dev;
	LPDIRECT3DRMVIEWPORT2		m_view;
	LPDIRECT3DRMFRAME3			m_scene;
	LPDIRECT3DRMFRAME3			m_camera;

	D3DRMRENDERQUALITY			m_RenderQuality;
	D3DRMTEXTUREQUALITY			m_TextureQuality;

	BOOL						m_bDithering;
	BOOL						m_bAntialiasing;

	// Direct3D section
	LPDIRECT3D2					m_D3D;
	LPDIRECT3DDEVICE2			m_D3DDevice;
	
	D3DDRIVERINFO				m_D3DDriverInfo;		// all D3D drivers
	D3DDRIVER					m_ThisD3DDriver;		// D3DDriver[CurrDriver]

	D3DRENDERSTATE				m_D3DRenderState;

	// DirectDraw section
	LPDIRECTDRAW				m_DD;
	BOOL						m_bIsPrimary;			// is this primary DD device ?

	DX_Surface*					m_FrontBuffer;			// primary surface
	DX_Surface*					m_BackBuffer;			// secondary surface
	DX_Surface*					m_ZBuffer;				// z-buffer
	DX_Clipper*					m_Clipper;				// DirectDraw Clipper

	BOOL						m_bBackBufferInVideo;	// is back buffer in video mem ?
	BOOL						m_bZBufferInVideo;		// is z-buffer in video mem ?

	DDDRIVERINFO				m_DDDriverInfo;			// all DirectDraw drivers
	DDDRIVER					m_ThisDDDriver;			// DDDriver[CurrDriver]

	MODEINFO					m_ModeInfo;				// all available Modes
	MODE						m_ThisMode;				// Mode[CurrMode]
};

/////////////////////////////////////////////////////////////////////////////
// DX_Surface
/////////////////////////////////////////////////////////////////////////////
class DX_Surface
{
public:
// Methods
	DX_Surface (void);									// Constructor
	~DX_Surface (void);									// Destructor

	void Initialise (void);								// Init class
	void Finalise (void);								// Clean class

	HRESULT Create (DX_Screen*);						// Create primary surface by m_Desc
	HRESULT Create (DX_Screen*, int, int);				// Create pure Off-Screen
	HRESULT LoadBitmap (DX_Screen*, const char*);		// Create Off-Screen from bitmap
														// and copy content of bitmap onto it
	HRESULT CopyBitmap (HBITMAP, int, int, int, int);
	HRESULT Restore (void);
	HRESULT Lock (void);								// Lock surface and fill in m_Desc
	HRESULT UnLock (void);								// Un-lock surface
	HRESULT Fill (DWORD);								// Fill color into surface
	HRESULT SetColorKey (void);							// Set to black color key
	HRESULT SetFont (const char*, int, int, int Attributes = FW_NORMAL);	
														// Set font
	HRESULT TextXY (int X, int Y, COLORREF, const char*);	
														// Draw text
	virtual HRESULT Draw (DX_Surface* Dest, DWORD flags);	
														// Blit
	virtual HRESULT DrawFast (int X, int Y, DX_Surface* Dest, DWORD flags);
														// Blit fast
	void SetSrc (int x, int y, int width = 0, int height = 0);
	void SetDest (int x, int y, int width = 0, int height = 0);
	int GetWidth (void)		{ return m_Width; }
	int GetHeight (void)	{ return m_Height; }
	LPDIRECTDRAWSURFACE GetSurface (void)	{ return m_Surface; }

public:
// Attributes
	LPDIRECTDRAWSURFACE		m_Surface;
	DDSURFACEDESC			m_Desc;
	DDSCAPS					m_Caps;

	int						m_Width;					// Width of surface
	int						m_Height;					// Height of surface
	RECT					m_SrcRect;					// Rect that describe source surface
	RECT					m_DestRect;					// Rect that describe dest surface
	HFONT					m_Font;						// Font handle
	const char*				m_Filename;					// Name of BMP file that has been loaded
};

/////////////////////////////////////////////////////////////////////////////
// DX_Clipper
/////////////////////////////////////////////////////////////////////////////
class DX_Clipper
{
public:
// Methods
	DX_Clipper (void);									// Constructor
	~DX_Clipper (void);									// Destructor

	void Initialise (void);								// Init class
	void Finalise (void);								// Clean class

	HRESULT AttachClipper (DX_Screen*, DX_Surface*, int num_rects = 1, LPRECT clip_list = NULL);
														// If clip_list = NULL use fullscreen clipper
	LPDIRECTDRAWCLIPPER GetClipper (void)	{ return m_Clipper; }

public:
// Attributes
	LPDIRECTDRAWCLIPPER		m_Clipper;
};

#endif