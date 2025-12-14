/////////////////////////////////////////////////////////////////////////////
// File Name:		KDX.cpp
// Author:			Tiwakorn Komut
// Source File:		KDX Implementation
// Date:			23/03/2000
// Comment:
/////////////////////////////////////////////////////////////////////////////
#include "KDX.h"
#define CREATEFONT(h, w, f) CreateFont (h, w, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, NONANTIALIASED_QUALITY, VARIABLE_PITCH, f)

const char KDX::m_szStringDlgHelp[NUMBER_STRING_DLG_HELP][50] = {STRING_HELP_LINE1, STRING_HELP_LINE2, STRING_HELP_LINE3, STRING_HELP_LINE4};
const char KDX::m_szStringDlgRender[NUMBER_STRING_DLG_RENDER][50] = {STRING_SHADEMODE, STRING_LIGHTING, STRING_FILLMODE, STRING_DITHERING, STRING_ANTIALIASING, STRING_TEXTUREFILTERING};
const char KDX::m_szChoiceShadeMode[NUMBER_CHOICE_SHADEMODE][50] = {STRING_FLAT, STRING_GOURAUD, STRING_PHONG};
const char KDX::m_szChoiceLighting[NUMBER_CHOICE_LIGHTING][50] = {STRING_DISABLED, STRING_ENABLED};
const char KDX::m_szChoiceFillMode[NUMBER_CHOICE_FILLMODE][50] = {STRING_POINT, STRING_WIREFRAME, STRING_SOLID};
const char KDX::m_szChoiceDithering[NUMBER_CHOICE_DITHERING][50] = {STRING_DISABLED, STRING_ENABLED};
const char KDX::m_szChoiceAntialiasing[NUMBER_CHOICE_ANTIALIASING][50] = {STRING_DISABLED, STRING_ENABLED};
const char KDX::m_szChoiceTextureFiltering[NUMBER_CHOICE_TEXTUREFILTERING][50] = {STRING_POINTFILTERING, STRING_BILINEARFILTERING};
const char KDX::m_szStringDlgSystemInfoPart1[NUMBER_STRING_DLG_SYSTEMINFO_PART1][50] = {STRING_DIRECT3DDRIVER, STRING_DISPLAYMODE};
const char KDX::m_szStringDlgSystemInfoPart2[NUMBER_STRING_DLG_SYSTEMINFO_PART2][50] = {STRING_DIRECTDRAWDRIVER, STRING_TEXTUREMAPPING, STRING_ZBUFFER, STRING_BACKBUFFERIN, STRING_ZBUFFERIN};
const char KDX::m_szChoiceTextureMapping[NUMBER_CHOICE_TEXTUREMAPPING][50] = {STRING_NO, STRING_YES};
const char KDX::m_szChoiceZBuffer[NUMBER_CHOICE_ZBUFFER][50] = {STRING_NO, STRING_YES};
const char KDX::m_szChoiceBackBufferin[NUMBER_CHOICE_BACKBUFFERIN][50] = {STRING_SYSTEMMEMORY, STRING_VIDEOMEMORY};
const char KDX::m_szChoiceZBufferin[NUMBER_CHOICE_ZBUFFERIN][50] = {STRING_SYSTEMMEMORY, STRING_VIDEOMEMORY, STRING_NONE};

/////////////////////////////////////////////////////////////////////////////
// KDX Constructor
/////////////////////////////////////////////////////////////////////////////
KDX::KDX (void)
{
	Initialise ();
}

/////////////////////////////////////////////////////////////////////////////
// KDX Destructor
/////////////////////////////////////////////////////////////////////////////
KDX::~KDX (void)
{
	Finalise ();
}

/////////////////////////////////////////////////////////////////////////////
// KDX Initialise
/////////////////////////////////////////////////////////////////////////////
void KDX::Initialise (void)
{
	// state of application
	m_State						= STATE_NORMAL;
	
	m_SurfaceDlgBmp				= NULL;
	m_SurfaceDlg				= NULL;
	m_SurfaceFPS				= NULL;

	m_FontDlgHeader				= NULL;
	m_FontDlgNormal				= NULL;
	m_FontDlgOKCancel			= NULL;
	m_FontFPSNormal				= NULL;

	// Indexes
	m_IndexDlgRender			= 0;
	m_IndexDlgSystemInfo		= 0;
	m_IndexShadeMode			= 0;
	m_IndexLighting				= 0;
	m_IndexFillMode				= 0;
	m_IndexDithering			= 0;
	m_IndexAntialiasing			= 0;
	m_IndexTextureFiltering		= 0;
	m_IndexDirect3DDriver		= 0;
	m_IndexDisplayMode			= 0;

	// Create fonts
	m_FontDlgHeader				= CREATEFONT (HEIGHT_DLG_FONT_HEADER, WIDTH_DLG_FONT_HEADER, FONT_DLG_HEADER);
	m_FontDlgNormal				= CREATEFONT (HEIGHT_DLG_FONT_NORMAL, WIDTH_DLG_FONT_NORMAL, FONT_DLG_NORMAL);
	m_FontDlgOKCancel			= CREATEFONT (HEIGHT_DLG_FONT_OKCANCEL, WIDTH_DLG_FONT_OKCANCEL, FONT_DLG_OKCANCEL);
	m_FontFPSNormal				= CREATEFONT (HEIGHT_FPS_FONT_NORMAL, WIDTH_FPS_FONT_NORMAL, FONT_FPS_NORMAL);
}

/////////////////////////////////////////////////////////////////////////////
// KDX Finalise
/////////////////////////////////////////////////////////////////////////////
void KDX::Finalise (void)
{
	// Delete fonts
	DeleteObject (m_FontFPSNormal);
	DeleteObject (m_FontDlgOKCancel);
	DeleteObject (m_FontDlgNormal);
	DeleteObject (m_FontDlgHeader);

	// Delete surface
	SAFE_DELETE (m_SurfaceFPS);
	SAFE_DELETE (m_SurfaceDlg);
	SAFE_DELETE (m_SurfaceDlgBmp);
}

/////////////////////////////////////////////////////////////////////////////
// KDX  KeyInApplication
/////////////////////////////////////////////////////////////////////////////
void KDX::KeyInApplication (WPARAM wParam)
{
	switch (m_State)
	{
	case STATE_NORMAL:
		switch (wParam)
		{
		case KEY_DLG_HELP:
			InitDlgHelp ();
			m_State = STATE_DLG_HELP;
			break;

		case KEY_DLG_RENDER:
			InitDlgRender ();
			m_IndexDlgRender = 0;
			m_State = STATE_DLG_RENDER;
			break;

		case KEY_DLG_SYSTEMINFO:
			InitDlgSystemInfo ();
			m_IndexDlgSystemInfo = 0;
			m_State = STATE_DLG_SYSTEMINFO;
			break;

		case KEY_EXIT:
			PostQuitMessage (0);
			break;
		}
		break;

	case STATE_DLG_HELP:
		KeyInDlgHelp (wParam);
		break;

	case STATE_DLG_RENDER:
		KeyInDlgRender (wParam);
		break;

	case STATE_DLG_SYSTEMINFO:
		KeyInDlgSystemInfo (wParam);
		break;
	}
}

/////////////////////////////////////////////////////////////////////////////
// KDX UpdateDlgSurfaceHelp
/////////////////////////////////////////////////////////////////////////////
HRESULT KDX::UpdateDlgSurfaceHelp (DX_Surface* Bmp, DX_Surface* Dest)
{
	HRESULT rval;
	HDC hdc;
	HFONT OldFont;
	int i;

	// Draw Dialog bitmap
	if (FAILED (rval = Bmp->Draw (Dest, DDBLT_WAIT)))
		return rval;

	// Get DC
	if (FAILED (rval = Dest->GetSurface ()->GetDC (&hdc)))
		return rval;

	// Draw dialog's contents
	OldFont = (HFONT)SelectObject (hdc, m_FontDlgNormal);
	SetBkMode (hdc, TRANSPARENT);
	SetTextColor (hdc, TEXTCOLOR_DLG_GRAYED);
	for (i = 0; i < NUMBER_STRING_DLG_HELP; i++)
		TextOut (hdc, 
				 X_DLG_START_CONTENTS + 3*HEIGHT_DLG_ROW,
				 Y_DLG_START_CONTENTS + i*HEIGHT_DLG_FONT_NORMAL + (i + 1)*HEIGHT_DLG_ROW,
				 &m_szStringDlgHelp[i][0],
				 strlen (&m_szStringDlgHelp[i][0]));
	SelectObject (hdc, OldFont);
	
	// Draw dialog's OK, Cancel
	OldFont = (HFONT)SelectObject (hdc, m_FontDlgOKCancel);
	SetBkMode (hdc, TRANSPARENT);
	SetTextColor (hdc, TEXTCOLOR_DLG_OKCANCEL);
	TextOut (hdc,
			 X_DLG_START_OKCANCEL,
			 Y_DLG_START_OKCANCEL,
			 STRING_OKCANCEL,
			 strlen (STRING_OKCANCEL));
	SelectObject (hdc, OldFont);

	// Draw dialog's Header
	OldFont = (HFONT)SelectObject (hdc, m_FontDlgHeader);
	SetBkMode (hdc, TRANSPARENT);
	SetTextColor (hdc, TEXTCOLOR_DLG_SHADOW);
	TextOut (hdc,
			 X_DLG_START_HEADER + 2,
			 Y_DLG_START_HEADER + 2,
			 STRING_HEADER_HELP,
			 strlen (STRING_HEADER_HELP));
	SetTextColor (hdc, TEXTCOLOR_DLG_HEADER);
	TextOut (hdc,
			 X_DLG_START_HEADER,
			 Y_DLG_START_HEADER,
			 STRING_HEADER_HELP,
			 strlen (STRING_HEADER_HELP));
	SelectObject (hdc, OldFont);

	// Delete DC
	Dest->GetSurface ()->ReleaseDC (hdc);
	return rval;	
}

/////////////////////////////////////////////////////////////////////////////
// KDX UpdateDlgSurfaceRender
/////////////////////////////////////////////////////////////////////////////
HRESULT KDX::UpdateDlgSurfaceRender (DX_Surface* Bmp, DX_Surface* Dest)
{
	HRESULT rval;
	HDC hdc;
	HFONT OldFont;
	int i;

	// Draw Dialog bitmap
	if (FAILED (rval = Bmp->Draw (Dest, DDBLT_WAIT)))
		return rval;

	// Get DC
	if (FAILED (rval = Dest->GetSurface ()->GetDC (&hdc)))
		return rval;

	// Draw dialog's contents
	OldFont = (HFONT)SelectObject (hdc, m_FontDlgNormal);
	SetBkMode (hdc, TRANSPARENT);
	for (i = 0; i < NUMBER_STRING_DLG_RENDER; i++)
	{
		if (i == m_IndexDlgRender)
			SetTextColor (hdc, TEXTCOLOR_DLG_SELECTED);
		else
			SetTextColor (hdc, TEXTCOLOR_DLG_NORMAL);
		TextOut (hdc,
				 X_DLG_START_CONTENTS + 3*HEIGHT_DLG_ROW,
				 Y_DLG_START_CONTENTS + i*HEIGHT_DLG_FONT_NORMAL + (i + 1)*HEIGHT_DLG_ROW,
				 &m_szStringDlgRender[i][0],
				 strlen (&m_szStringDlgRender[i][0]));

		int x = X_DLG_START_CONTENTS + 3*HEIGHT_DLG_ROW + WIDTH_DLG_COLUMN;
		int y = Y_DLG_START_CONTENTS + i*HEIGHT_DLG_FONT_NORMAL + (i + 1)*HEIGHT_DLG_ROW;
		switch (i)
		{
		case 0:
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceShadeMode[m_IndexShadeMode][0],
					 strlen (&m_szChoiceShadeMode[m_IndexShadeMode][0]));
			break;

		case 1:
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceLighting[m_IndexLighting][0],
					 strlen (&m_szChoiceLighting[m_IndexLighting][0]));
			break;

		case 2:
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceFillMode[m_IndexFillMode][0],
					 strlen (&m_szChoiceFillMode[m_IndexFillMode][0]));
			break;

		case 3:
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceDithering[m_IndexDithering][0],
					 strlen (&m_szChoiceDithering[m_IndexDithering][0]));
			break;

		case 4:
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceAntialiasing[m_IndexAntialiasing][0],
					 strlen (&m_szChoiceAntialiasing[m_IndexAntialiasing][0]));
			break;

		case 5:
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceTextureFiltering[m_IndexTextureFiltering][0],
					 strlen (&m_szChoiceTextureFiltering[m_IndexTextureFiltering][0]));
			break;
		}
	}
	SelectObject (hdc, OldFont);

	// Draw dialog's OK, Cancel
	OldFont = (HFONT)SelectObject (hdc, m_FontDlgOKCancel);
	SetBkMode (hdc, TRANSPARENT);
	SetTextColor (hdc, TEXTCOLOR_DLG_OKCANCEL);
	TextOut (hdc,
			 X_DLG_START_OKCANCEL,
			 Y_DLG_START_OKCANCEL,
			 STRING_OKCANCEL,
			 strlen (STRING_OKCANCEL));
	SelectObject (hdc, OldFont);

	// Draw dialog's Header
	OldFont = (HFONT)SelectObject (hdc, m_FontDlgHeader);
	SetBkMode (hdc, TRANSPARENT);
	SetTextColor (hdc, TEXTCOLOR_DLG_SHADOW);
	TextOut (hdc,
			 X_DLG_START_HEADER + 2,
			 Y_DLG_START_HEADER + 2,
			 STRING_HEADER_RENDER,
			 strlen (STRING_HEADER_RENDER));
	SetTextColor (hdc, TEXTCOLOR_DLG_HEADER);
	TextOut (hdc,
			 X_DLG_START_HEADER,
			 Y_DLG_START_HEADER,
			 STRING_HEADER_RENDER,
			 strlen (STRING_HEADER_RENDER));
	SelectObject (hdc, OldFont);

	// Delete DC
	Dest->GetSurface ()->ReleaseDC (hdc);
	return rval;	
}

/////////////////////////////////////////////////////////////////////////////
// KDX UpdateDlgSurfaceSystemInfo
/////////////////////////////////////////////////////////////////////////////
HRESULT KDX::UpdateDlgSurfaceSystemInfo (DX_Surface* Bmp, DX_Surface* Dest)
{
	HRESULT rval;
	HDC hdc;
	HFONT OldFont;
	int i;

	// Draw Dialog bitmap
	if (FAILED (rval = Bmp->Draw (Dest, DDBLT_WAIT)))
		return rval;

	// Get DC
	if (FAILED (rval = Dest->GetSurface ()->GetDC (&hdc)))
		return rval;

	// Draw dialog's contents
	OldFont = (HFONT)SelectObject (hdc, m_FontDlgNormal);
	SetBkMode (hdc, TRANSPARENT);
	for (i = 0; i < NUMBER_STRING_DLG_SYSTEMINFO_PART1; i++)
	{
		if (i == m_IndexDlgSystemInfo)
			SetTextColor (hdc, TEXTCOLOR_DLG_SELECTED);
		else
			SetTextColor (hdc, TEXTCOLOR_DLG_NORMAL);
		TextOut (hdc,
				 X_DLG_START_CONTENTS + 3*HEIGHT_DLG_ROW,
				 Y_DLG_START_CONTENTS + i*HEIGHT_DLG_FONT_NORMAL + (i + 1)*HEIGHT_DLG_ROW,
				 &m_szStringDlgSystemInfoPart1[i][0],
				 strlen (&m_szStringDlgSystemInfoPart1[i][0]));

		int x = X_DLG_START_CONTENTS + 3*HEIGHT_DLG_ROW + WIDTH_DLG_COLUMN;
		int y = Y_DLG_START_CONTENTS + i*HEIGHT_DLG_FONT_NORMAL + (i + 1)*HEIGHT_DLG_ROW;
		switch (i)
		{
		case 0:
			TextOut (hdc,
					 x,
					 y,
					 m_D3DDriverInfo.D3DDriver[m_IndexDirect3DDriver].Name,
					 strlen (m_D3DDriverInfo.D3DDriver[m_IndexDirect3DDriver].Name));
			break;

		case 1:
			char buff[50];
			wsprintf (buff, "%dx%dx%d", m_ModeInfo.Mode[m_IndexDisplayMode].w, m_ModeInfo.Mode[m_IndexDisplayMode].h, m_ModeInfo.Mode[m_IndexDisplayMode].bpp);
			TextOut (hdc,
					 x,
					 y,
					 buff,
					 strlen (buff));
			break;
		}
	}
	
	SetTextColor (hdc, TEXTCOLOR_DLG_GRAYED);
	for (i = 0; i < NUMBER_STRING_DLG_SYSTEMINFO_PART2; i++)
	{
		TextOut (hdc,
				 X_DLG_START_CONTENTS + 3*HEIGHT_DLG_ROW,
				 Y_DLG_START_CONTENTS + (i + NUMBER_STRING_DLG_SYSTEMINFO_PART1)*HEIGHT_DLG_FONT_NORMAL + (i + NUMBER_STRING_DLG_SYSTEMINFO_PART1 + 1)*HEIGHT_DLG_ROW,
				 &m_szStringDlgSystemInfoPart2[i][0],
				 strlen (&m_szStringDlgSystemInfoPart2[i][0]));

		int x = X_DLG_START_CONTENTS + 3*HEIGHT_DLG_ROW + WIDTH_DLG_COLUMN;
		int y = Y_DLG_START_CONTENTS + (i + NUMBER_STRING_DLG_SYSTEMINFO_PART1)*HEIGHT_DLG_FONT_NORMAL + (i + NUMBER_STRING_DLG_SYSTEMINFO_PART1 + 1)*HEIGHT_DLG_ROW;
		switch (i)
		{
		case 0:
			TextOut (hdc,
					 x,
					 y,
					 m_DDDriverInfo.DDDriver[m_DDDriverInfo.CurrDriver].Name,
					 strlen (m_DDDriverInfo.DDDriver[m_DDDriverInfo.CurrDriver].Name));
			break;

		case 1:
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceTextureMapping[m_ThisD3DDriver.bDoesTextures][0],
					 strlen (&m_szChoiceTextureMapping[m_ThisD3DDriver.bDoesTextures][0]));
			break;

		case 2:
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceZBuffer[m_ThisD3DDriver.bDoesZBuffer][0],
					 strlen (&m_szChoiceZBuffer[m_ThisD3DDriver.bDoesZBuffer][0]));
			break;

		case 3:
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceBackBufferin[m_bBackBufferInVideo][0],
					 strlen (&m_szChoiceBackBufferin[m_bBackBufferInVideo][0]));
			break;

		case 4:
			int z = m_ThisD3DDriver.bDoesZBuffer ? m_bZBufferInVideo : 2;
			TextOut (hdc,
					 x,
					 y,
					 &m_szChoiceZBufferin[z][0],
					 strlen (&m_szChoiceZBufferin[z][0]));
			break;
		}
	}
	SelectObject (hdc, OldFont);

	// Draw dialog's OK, Cancel
	OldFont = (HFONT)SelectObject (hdc, m_FontDlgOKCancel);
	SetBkMode (hdc, TRANSPARENT);
	SetTextColor (hdc, TEXTCOLOR_DLG_OKCANCEL);
	TextOut (hdc,
			 X_DLG_START_OKCANCEL,
			 Y_DLG_START_OKCANCEL,
			 STRING_OKCANCEL,
			 strlen (STRING_OKCANCEL));
	SelectObject (hdc, OldFont);

	// Draw dialog's Header
	OldFont = (HFONT)SelectObject (hdc, m_FontDlgHeader);
	SetBkMode (hdc, TRANSPARENT);
	SetTextColor (hdc, TEXTCOLOR_DLG_SHADOW);
	TextOut (hdc,
			 X_DLG_START_HEADER + 2,
			 Y_DLG_START_HEADER + 2,
			 STRING_HEADER_SYSTEMINFO,
			 strlen (STRING_HEADER_SYSTEMINFO));
	SetTextColor (hdc, TEXTCOLOR_DLG_HEADER);
	TextOut (hdc,
			 X_DLG_START_HEADER,
			 Y_DLG_START_HEADER,
			 STRING_HEADER_SYSTEMINFO,
			 strlen (STRING_HEADER_SYSTEMINFO));
	SelectObject (hdc, OldFont);

	// Delete DC
	Dest->GetSurface ()->ReleaseDC (hdc);
	return rval;	
}

/////////////////////////////////////////////////////////////////////////////
// KDX UpdateFPSSurface
/////////////////////////////////////////////////////////////////////////////
HRESULT KDX::UpdateFPSSurface (DX_Surface* Dest)
{
	HRESULT rval = DD_OK;
	static const long interval = 100;
	static long framecount;

	framecount++;
	if (framecount == interval)
	{
		static DWORD timenow;
		static DWORD timethen;
		HDC hdc;
		HFONT OldFont;

		timethen = timenow;
		timenow = GetTickCount ();

		double seconds = double(timenow - timethen)/(double)1000;
		int fps = (int)((double)framecount/seconds);

		static char buff[10];
		wsprintf (buff, "[F1] Help /FPS: %d", fps);

		Dest->Fill (0);

		if (FAILED (rval = Dest->GetSurface ()->GetDC (&hdc)))
			return rval;
		OldFont = (HFONT)SelectObject (hdc, m_FontFPSNormal);
		SetBkMode (hdc, TRANSPARENT);
		SetTextColor (hdc, TEXTCOLOR_FPS_NORMAL);
		TextOut (hdc, 0, 0, buff, strlen (buff));
		SelectObject (hdc, OldFont);
		Dest->GetSurface ()->ReleaseDC (hdc);
		framecount = 0;
	}
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// KDX Create
/////////////////////////////////////////////////////////////////////////////
BOOL KDX::Create (HWND hWnd)
{
	if (!DX_Screen::Create (hWnd))
		return FALSE;
	if (!CreateOffscreens ())
		return FALSE;
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// KDX CreateOffscreens
/////////////////////////////////////////////////////////////////////////////
BOOL KDX::CreateOffscreens (void)
{
	SAFE_DELETE (m_SurfaceDlgBmp);
	m_SurfaceDlgBmp = new DX_Surface;
	if (FAILED (m_SurfaceDlgBmp->LoadBitmap (this, BMPFILE_DLG)))
		return FALSE;

	SAFE_DELETE (m_SurfaceDlg);
	m_SurfaceDlg = new DX_Surface;
	if (FAILED (m_SurfaceDlg->Create (this, m_SurfaceDlgBmp->GetWidth (), m_SurfaceDlgBmp->GetHeight ())))
		return FALSE;
	m_SurfaceDlg->Fill (0);
	m_SurfaceDlg->SetColorKey ();

	SAFE_DELETE (m_SurfaceFPS);
	m_SurfaceFPS = new DX_Surface;
	if (FAILED (m_SurfaceFPS->Create (this, WIDTH_FPS_SURFACE, HEIGHT_FPS_SURFACE)))
		return FALSE;
	m_SurfaceFPS->Fill (0);
	m_SurfaceFPS->SetColorKey ();
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// KDX Render
/////////////////////////////////////////////////////////////////////////////
BOOL KDX::Render (void)
{
	if (FAILED (DX_Screen::Render ()))
		return FALSE;

	if (FAILED (UpdateFPSSurface (m_SurfaceFPS)))
		return FALSE;
	m_SurfaceFPS->SetDest (0, GetHeight () - HEIGHT_FPS_SURFACE);
	if (FAILED (m_SurfaceFPS->Draw (m_BackBuffer, DDBLT_WAIT | DDBLT_KEYSRC)))
		return FALSE;
	
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

	if (FAILED (Flip ()))
		return FALSE;
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// KDX KeyInDlgHelp
/////////////////////////////////////////////////////////////////////////////
void KDX::KeyInDlgHelp (WPARAM wParam)
{
	switch (wParam)
	{
	case KEY_OK:
	case KEY_CANCEL:
		m_State = STATE_NORMAL;
		break;
	}
}

/////////////////////////////////////////////////////////////////////////////
// KDX KeyInDlgRender
/////////////////////////////////////////////////////////////////////////////
void KDX::KeyInDlgRender (WPARAM wParam)
{
	switch (wParam)
	{
	case KEY_MOVECHOICE_UP:
		if (--m_IndexDlgRender < 0)
			m_IndexDlgRender = NUMBER_STRING_DLG_RENDER - 1;
		break;

	case KEY_MOVECHOICE_DOWN:
		if (++m_IndexDlgRender >= NUMBER_STRING_DLG_RENDER)
			m_IndexDlgRender = 0;
		break;

	case KEY_MOVECHOICE_LEFT:
		switch (m_IndexDlgRender)
		{
		case 0:
			if (--m_IndexShadeMode < 0)
				m_IndexShadeMode = NUMBER_CHOICE_SHADEMODE - 1;
			break;

		case 1:
			if (--m_IndexLighting < 0)
				m_IndexLighting = NUMBER_CHOICE_LIGHTING - 1;
			break;

		case 2:
			if (--m_IndexFillMode < 0)
				m_IndexFillMode = NUMBER_CHOICE_FILLMODE - 1;
			break;

		case 3:
			if (--m_IndexDithering < 0)
				m_IndexDithering = NUMBER_CHOICE_DITHERING - 1;
			break;

		case 4:
			if (--m_IndexAntialiasing < 0)
				m_IndexAntialiasing = NUMBER_CHOICE_ANTIALIASING - 1;
			break;

		case 5:
			if (--m_IndexTextureFiltering < 0)
				m_IndexTextureFiltering = NUMBER_CHOICE_TEXTUREFILTERING - 1;
			break;
		}
		break;

	case KEY_MOVECHOICE_RIGHT:
		switch (m_IndexDlgRender)
		{
		case 0:
			if (++m_IndexShadeMode >= NUMBER_CHOICE_SHADEMODE)
				m_IndexShadeMode = 0;
			break;

		case 1:
			if (++m_IndexLighting >= NUMBER_CHOICE_LIGHTING)
				m_IndexLighting = 0;
			break;

		case 2:
			if (++m_IndexFillMode >= NUMBER_CHOICE_FILLMODE)
				m_IndexFillMode = 0;
			break;

		case 3:
			if (++m_IndexDithering >= NUMBER_CHOICE_DITHERING)
				m_IndexDithering = 0;
			break;

		case 4:
			if (++m_IndexAntialiasing >= NUMBER_CHOICE_ANTIALIASING)
				m_IndexAntialiasing = 0;
			break;

		case 5:
			if (++m_IndexTextureFiltering >= NUMBER_CHOICE_TEXTUREFILTERING)
				m_IndexTextureFiltering = 0;
			break;
		}
		break;

	case KEY_OK:
		ChangeRenderState ();
		InitDlgRender ();
		break;

	case KEY_CANCEL:
		m_State = STATE_NORMAL;
		break;
	}
}

/////////////////////////////////////////////////////////////////////////////
// KDX KeyInDlgSystemInfo
/////////////////////////////////////////////////////////////////////////////
void KDX::KeyInDlgSystemInfo (WPARAM wParam)
{
	switch (wParam)
	{
	case KEY_MOVECHOICE_UP:
		if (--m_IndexDlgSystemInfo < 0)
			m_IndexDlgSystemInfo = NUMBER_STRING_DLG_SYSTEMINFO_PART1 - 1;
		break;

	case KEY_MOVECHOICE_DOWN:
		if (++m_IndexDlgSystemInfo >= NUMBER_STRING_DLG_SYSTEMINFO_PART1)
			m_IndexDlgSystemInfo = 0;
		break;

	case KEY_MOVECHOICE_LEFT:
		switch (m_IndexDlgSystemInfo)
		{
		case 0:
			if (--m_IndexDirect3DDriver < 0)
				m_IndexDirect3DDriver = m_D3DDriverInfo.NumDrivers - 1;
			break;

		case 1:
			if (--m_IndexDisplayMode < 0)
				m_IndexDisplayMode = m_ModeInfo.NumModes - 1;
			break;
		}
		break;

	case KEY_MOVECHOICE_RIGHT:
		switch (m_IndexDlgSystemInfo)
		{
		case 0:
			if (++m_IndexDirect3DDriver >= m_D3DDriverInfo.NumDrivers)
				m_IndexDirect3DDriver = 0;
			break;

		case 1:
			if (++m_IndexDisplayMode >= m_ModeInfo.NumModes)
				m_IndexDisplayMode = 0;
			break;
		}
		break;

	case KEY_OK:
		if(!ChangeDirect3DDriverAndMode (m_IndexDirect3DDriver, m_IndexDisplayMode))
			ChangeDirect3DDriverAndMode (m_D3DDriverInfo.CurrDriver, m_ModeInfo.CurrMode);
		break;

	case KEY_CANCEL:
		m_State = STATE_NORMAL;
		break;
	}
}

/////////////////////////////////////////////////////////////////////////////
// KDX InitDlgHelp
/////////////////////////////////////////////////////////////////////////////
void KDX::InitDlgHelp (void)
{

}

/////////////////////////////////////////////////////////////////////////////
// KDX InitDlgRender
/////////////////////////////////////////////////////////////////////////////
void KDX::InitDlgRender (void)
{
	m_RenderQuality = m_dev->GetQuality ();	
	if ((m_RenderQuality & D3DRMSHADE_MASK) == D3DRMSHADE_FLAT)
		m_IndexShadeMode = 0;
	if ((m_RenderQuality & D3DRMSHADE_MASK) == D3DRMSHADE_GOURAUD)
		m_IndexShadeMode = 1;
	if ((m_RenderQuality & D3DRMSHADE_MASK) == D3DRMSHADE_PHONG)
		m_IndexShadeMode = 2;
	m_IndexLighting = (m_RenderQuality & D3DRMLIGHT_MASK) == D3DRMLIGHT_ON ? 1 : 0;
	if ((m_RenderQuality & D3DRMFILL_MASK) == D3DRMFILL_POINTS)
		m_IndexFillMode = 0;
	if ((m_RenderQuality & D3DRMFILL_MASK) == D3DRMFILL_WIREFRAME)
		m_IndexFillMode = 1;
	if ((m_RenderQuality & D3DRMFILL_MASK) == D3DRMFILL_SOLID)
		m_IndexFillMode = 2;
	
	m_bDithering = m_dev->GetDither ();
	m_IndexDithering = m_bDithering;

	m_bAntialiasing = FALSE;
	m_IndexAntialiasing = m_bAntialiasing;

	m_TextureQuality = m_dev->GetTextureQuality ();
	if (m_TextureQuality == D3DRMTEXTURE_NEAREST)
		m_IndexTextureFiltering = 0;
	if (m_TextureQuality == D3DRMTEXTURE_LINEAR)
		m_IndexTextureFiltering = 1;
}

/////////////////////////////////////////////////////////////////////////////
// KDX InitDlgSystemInfo
/////////////////////////////////////////////////////////////////////////////
void KDX::InitDlgSystemInfo (void)
{
	m_IndexDirect3DDriver = m_D3DDriverInfo.CurrDriver;
	m_IndexDisplayMode = m_ModeInfo.CurrMode;
}

/////////////////////////////////////////////////////////////////////////////
// KDX ChangeRenderState
/////////////////////////////////////////////////////////////////////////////
BOOL KDX::ChangeRenderState (void)
{
	switch (m_IndexShadeMode)
	{
	case 0:
		m_RenderQuality = (m_RenderQuality & ~D3DRMSHADE_MASK) | D3DRMSHADE_FLAT;
		break;

	case 1:
		m_RenderQuality = (m_RenderQuality & ~D3DRMSHADE_MASK) | D3DRMSHADE_GOURAUD;
		break;

	case 2:
		m_RenderQuality = (m_RenderQuality & ~D3DRMSHADE_MASK) | D3DRMSHADE_PHONG;
		break;
	}

	switch (m_IndexLighting)
	{
	case 0:
		m_RenderQuality = (m_RenderQuality & ~D3DRMLIGHT_MASK) | D3DRMLIGHT_OFF;
		break;

	case 1:
		m_RenderQuality = (m_RenderQuality & ~D3DRMLIGHT_MASK) | D3DRMLIGHT_ON;
		break;
	}

	switch (m_IndexFillMode)
	{
	case 0:
		m_RenderQuality = (m_RenderQuality & ~D3DRMFILL_MASK) | D3DRMFILL_POINTS;
		break;

	case 1:
		m_RenderQuality = (m_RenderQuality & ~D3DRMFILL_MASK) | D3DRMFILL_WIREFRAME;
		break;

	case 2:
		m_RenderQuality = (m_RenderQuality & ~D3DRMFILL_MASK) | D3DRMFILL_SOLID;
		break;
	}

	switch (m_IndexDithering)
	{
	case 0:
		m_bDithering = FALSE;
		break;

	case 1:
		m_bDithering = TRUE;
		break;
	}

	switch (m_IndexAntialiasing)
	{
	case 0:
		m_bAntialiasing = FALSE;
		break;

	case 1:
		m_bAntialiasing = TRUE;
		break;
	}

	switch (m_IndexTextureFiltering)
	{
	case 0:
		m_TextureQuality = D3DRMTEXTURE_NEAREST;
		break;

	case 1:
		m_TextureQuality = D3DRMTEXTURE_LINEAR;
		break;
	}
	
	if (FAILED (SetRenderState ()))
		return FALSE;
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// KDX ChangeDirect3DDriverAndMode
/////////////////////////////////////////////////////////////////////////////
BOOL KDX::ChangeDirect3DDriverAndMode (int driver, int mode)
{
	// Change driver only
	if (driver != m_D3DDriverInfo.CurrDriver && mode == m_ModeInfo.CurrMode)
		if (!ChangeDriver (driver))
			return FALSE;

	// Change mode only
	if (driver == m_D3DDriverInfo.CurrDriver && mode != m_ModeInfo.CurrMode)
		if (!ChangeMode (mode))
			return FALSE;

	// Change driver and mode
	if (driver != m_D3DDriverInfo.CurrDriver && mode != m_ModeInfo.CurrMode)
	{
		// Verify the compatibility of this mode with the specified driver.
		if (!(m_D3DDriverInfo.D3DDriver[driver].Desc.dwDeviceRenderBitDepth & BPPToDDBD (m_ModeInfo.Mode[mode].bpp)))
		{
			MSG (m_hWnd, "The specified D3D device driver doesn't compatible with the specified display depth.\n");
			return FALSE;
		}
		// Update the current driver
		int tmp = m_D3DDriverInfo.CurrDriver;
		m_D3DDriverInfo.CurrDriver = driver;
		if (!ChangeMode (mode))
		{
			m_D3DDriverInfo.CurrDriver = tmp;
			return FALSE;
		}
		// Update the current driver info.
		memcpy (&m_ThisD3DDriver, &m_D3DDriverInfo.D3DDriver[m_D3DDriverInfo.CurrDriver], sizeof (D3DDRIVER));
		FilterDisplayModes (m_D3DDriverInfo.CurrDriver);
	}

	// Delete offscreen surfaces
	SAFE_DELETE (m_SurfaceFPS);
	SAFE_DELETE (m_SurfaceDlg);
	SAFE_DELETE (m_SurfaceDlgBmp);
	// Recreate offscreen surfaces
	if (FAILED (CreateOffscreens ()))
		return FALSE;
	return TRUE;
}