/////////////////////////////////////////////////////////////////////////////
// File Name:		DX_Screen.cpp
// Author:			Tiwakorn Komut
// Source File:		DX_Screen Implementation
// Date:			16/03/2000
// Comment:		
/////////////////////////////////////////////////////////////////////////////
#include "DX.h"

/////////////////////////////////////////////////////////////////////////////
// DX_Screen Constructor
/////////////////////////////////////////////////////////////////////////////
DX_Screen::DX_Screen (void)
{
	Initialise ();
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen Destructor
/////////////////////////////////////////////////////////////////////////////
DX_Screen::~DX_Screen (void)
{
	Finalise ();
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen Initialise
/////////////////////////////////////////////////////////////////////////////
void DX_Screen::Initialise (void)
{
	// Main section
	m_hWnd = NULL;
	memset (&m_WindowsDisplay, 0, sizeof (MODE));

	// Direct3DRM section
	m_D3DRM					= NULL;
	m_dev					= NULL;
	m_view					= NULL;
	m_scene					= NULL;
	m_camera				= NULL;
	m_RenderQuality			= D3DRMLIGHT_ON | D3DRMFILL_SOLID | D3DRMSHADE_GOURAUD;
	m_TextureQuality		= D3DRMTEXTURE_NEAREST;
	m_bDithering			= FALSE;
	m_bAntialiasing			= FALSE;

	// Direct3D section
	m_D3D					= NULL;
	m_D3DDevice				= NULL;	
	memset (&m_D3DDriverInfo, 0, sizeof (D3DDRIVERINFO));
	memset (&m_ThisD3DDriver, 0, sizeof (D3DDRIVER));
	DefaultD3DRenderState (&m_D3DRenderState);

	// DirectDraw section
	m_DD					= NULL;
	m_bIsPrimary			= FALSE;
	m_FrontBuffer			= NULL;
	m_BackBuffer			= NULL;
	m_ZBuffer				= NULL;
	m_Clipper				= NULL;
	m_bBackBufferInVideo	= FALSE;
	m_bZBufferInVideo		= FALSE;
	memset (&m_DDDriverInfo, 0, sizeof (DDDRIVERINFO));
	memset (&m_ThisDDDriver, 0, sizeof (DDDRIVER));
	memset (&m_ModeInfo, 0, sizeof (MODEINFO));
	memset (&m_ThisMode, 0, sizeof (MODE));
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen Finalise
/////////////////////////////////////////////////////////////////////////////
void DX_Screen::Finalise (void)
{
	SAFE_DELETE (m_Clipper);
	SAFE_RELEASE (m_view);
	SAFE_RELEASE (m_dev);
	SAFE_RELEASE (m_D3DDevice);
	SAFE_DELETE (m_ZBuffer);
	SAFE_DELETE (m_BackBuffer);
	SAFE_DELETE (m_FrontBuffer);
	SAFE_RELEASE (m_D3D);
	SAFE_RELEASE (m_DD);
	SAFE_RELEASE (m_scene);
	SAFE_RELEASE (m_camera);
	SAFE_RELEASE (m_D3DRM);
}


/////////////////////////////////////////////////////////////////////////////
// Callback functions
/////////////////////////////////////////////////////////////////////////////
// DDEnumCallback
static BOOL WINAPI DDEnumCallback (GUID FAR* lpGUID, LPSTR lpDriverDesc, LPSTR lpDriverName, LPVOID lpContext)
{
	LPDIRECTDRAW lpDD;
	DDCAPS DriverCaps, HELCaps;
	DDDRIVERINFO* context = (DDDRIVERINFO*)lpContext;

	// Create the DirectDraw device using this driver. If it fails, just move on to the next driver.
	if (FAILED (DirectDrawCreate (lpGUID, &lpDD, NULL)))
		return DDENUMRET_OK;

	// Get the capabilities of this DirectDraw driver. If it fails, just move on to the next driver.
	memset (&DriverCaps, 0, sizeof (DDCAPS));
	DriverCaps.dwSize = sizeof (DDCAPS);
	memset (&HELCaps, 0, sizeof (DDCAPS));
	HELCaps.dwSize = sizeof (DDCAPS);
	if (FAILED (lpDD->GetCaps (&DriverCaps, &HELCaps)))
		return DDENUMRET_OK;

	if (lpGUID && (DriverCaps.dwCaps & DDCAPS_3D))
	{
		// We have found a secondary 3D hardware device. Return the DD object and stop enumeration
		memcpy (&context->DDDriver[context->NumDrivers].Guid, lpGUID, sizeof (GUID));
		memcpy (&context->DDDriver[context->NumDrivers].HWCaps, &DriverCaps, sizeof (DDCAPS));
		lstrcpy (context->DDDriver[context->NumDrivers].Name, lpDriverName);
		context->DDDriver[context->NumDrivers].bIsPrimary = FALSE;
		context->NumDrivers++;
	}
	else
	{
		// It's the primary, fill some fields.
		memset (&context->DDDriver[context->NumDrivers].Guid, 0, sizeof (GUID));
		memcpy (&context->DDDriver[context->NumDrivers].HWCaps, &DriverCaps, sizeof (DDCAPS));
		lstrcpy (context->DDDriver[context->NumDrivers].Name, "Primary Device");
		context->DDDriver[context->NumDrivers].bIsPrimary = TRUE;
		context->NumDrivers++;
	}
	SAFE_RELEASE (lpDD);
	if (context->NumDrivers >= MAX_DDDRIVERS)
		return DDENUMRET_CANCEL;
	return DDENUMRET_OK;
}

// EnumDisplayModesCallback
static HRESULT WINAPI EnumDisplayModesCallback (LPDDSURFACEDESC pddsd, LPVOID lpContext)
{
	MODEINFO* context = (MODEINFO*)lpContext;

	// Very large resolution cause problems on some hardware.
	if (pddsd->dwWidth > MAX_MODEWIDTH || pddsd->dwHeight > MAX_MODEHEIGHT || pddsd->ddpfPixelFormat.dwRGBBitCount < MIN_BPP)
		return DDENUMRET_OK;

	// Save this mode at the end of the mode array and increment mode count
	context->Mode[context->NumModes].w = pddsd->dwWidth;
	context->Mode[context->NumModes].h = pddsd->dwHeight;
	context->Mode[context->NumModes].bpp = pddsd->ddpfPixelFormat.dwRGBBitCount;
	context->Mode[context->NumModes].bThisDriverCanDo = FALSE;
	context->NumModes++;
	if (context->NumModes >= MAX_MODES)
		return DDENUMRET_CANCEL;
	return DDENUMRET_OK;
}

// EnumDeviceFunc
static HRESULT WINAPI EnumDeviceFunc (LPGUID lpGuid, LPSTR lpDeviceDescription, LPSTR lpDeviceName, LPD3DDEVICEDESC lpHWDesc, LPD3DDEVICEDESC lpHELDesc, LPVOID lpContext)
{
	D3DDRIVERINFO* context = (D3DDRIVERINFO*)lpContext;

	// Record the driver's information
	memcpy (&context->D3DDriver[context->NumDrivers].Guid, lpGuid, sizeof (GUID));
	lstrcpy (context->D3DDriver[context->NumDrivers].About, lpDeviceDescription);
	lstrcpy (context->D3DDriver[context->NumDrivers].Name, lpDeviceName);

	// Is this a hardware device or software emulation? Checking the color model for valid model works
	if (lpHWDesc->dcmColorModel)
	{
		// this is hardware device
		context->D3DDriver[context->NumDrivers].bIsHardware = TRUE;
		memcpy (&context->D3DDriver[context->NumDrivers].Desc, lpHWDesc, sizeof (D3DDEVICEDESC));
	}
	else
	{
		// this is software emulation
		context->D3DDriver[context->NumDrivers].bIsHardware = FALSE;
		memcpy (&context->D3DDriver[context->NumDrivers].Desc, lpHELDesc, sizeof (D3DDEVICEDESC));
	}

	// Does this driver do texture mapping?
	context->D3DDriver[context->NumDrivers].bDoesTextures = (context->D3DDriver[context->NumDrivers].Desc.dpcTriCaps.dwTextureCaps & D3DPTEXTURECAPS_PERSPECTIVE) ? TRUE : FALSE;

	// Can this driver use a z-buffer?
	context->D3DDriver[context->NumDrivers].bDoesZBuffer = context->D3DDriver[context->NumDrivers].Desc.dwDeviceZBufferBitDepth ? TRUE : FALSE;

	context->NumDrivers++;
	if (context->NumDrivers >= MAX_D3DDRIVERS)
		return D3DENUMRET_CANCEL;
	return D3DENUMRET_OK;
}

// CompareModes
static int CompareModes (const void* arg1, const void* arg2)
{
	MODE* mode1 = (MODE*)arg1;
	MODE* mode2 = (MODE*)arg2;

	DWORD volume1 = mode1->w*mode1->h;
	DWORD volume2 = mode2->w*mode2->h;

	if (volume1 < volume2)
		return -1;
	else if (volume1 > volume2)
		return 1;
	else if (mode1->bpp < mode2->bpp)
		return -1;
	else if (mode1->bpp > mode2->bpp)
		return 1;
	return 0;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen EnumerateDDDevices
// Desc: enumerate all available DirectDraw devices
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::EnumerateDDDevices (LPDDDRIVERINFO lpinfo)
{
	lpinfo->NumDrivers = 0;
	if (FAILED (DirectDrawEnumerate (DDEnumCallback, (LPVOID)lpinfo)))
	{
		MSG (m_hWnd, "DirectDrawEnumerate failed.\n");
		return FALSE;
	}
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen CreateD3DRM
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::CreateD3DRM (void)
{
	HRESULT rval;

	// Create D3DRM object
	LPDIRECT3DRM pD3DRM;

	if (FAILED (rval = Direct3DRMCreate (&pD3DRM)))
	{
		MSG (m_hWnd, "Failed to create Direct3DRM.\n");
		return rval;
	}

	if (FAILED (rval = pD3DRM->QueryInterface (IID_IDirect3DRM3, (LPVOID*)&m_D3DRM)))
	{
		SAFE_RELEASE (pD3DRM);
		MSG (m_hWnd, "Failed to QueryInterface for IID_IDirect3DRM3.\n");
		return rval;
	}
	SAFE_RELEASE (pD3DRM);

	// Create the master scene frame and camera frame
	if (FAILED (rval = m_D3DRM->CreateFrame (NULL, &m_scene)))
	{
		MSG (m_hWnd, "Failed to create the master scene frame.\n");
		return rval;
	}
	if (FAILED (rval = m_D3DRM->CreateFrame (m_scene, &m_camera)))
	{
		MSG (m_hWnd, "Failed to create the camera's frame.\n");
		return rval;
	}
	if (FAILED (rval = m_camera->SetPosition (m_scene, D3DVAL (0.0), D3DVAL (0.0), D3DVAL (0.0))))
	{
		MSG (m_hWnd, "Failed to position the camera in the frame.\n");
		return rval;
	}
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen CreateDD
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::CreateDD (LPGUID lpGuid)
{
	HRESULT rval;

	if (!lpGuid)
		m_bIsPrimary = TRUE;
	else 
		m_bIsPrimary = FALSE;

	if (FAILED (rval = DirectDrawCreate (lpGuid, &m_DD, NULL)))
	{
		MSG (m_hWnd, "DirectDrawCreate failed.\n");
		return rval;
	}
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen RememberWindowsMode
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::RememberWindowsMode (LPMODE lpmode)
{
	HRESULT rval;
	DDSURFACEDESC ddsd;

	memset (&ddsd, 0, sizeof (DDSURFACEDESC));
	ddsd.dwSize = sizeof (DDSURFACEDESC);
	if (FAILED (rval = m_DD->GetDisplayMode (&ddsd)))
	{
		MSG (m_hWnd, "Getting the current display mode failed.\n");
		return rval;
	}
	lpmode->w = ddsd.dwWidth;
	lpmode->h = ddsd.dwHeight;
	lpmode->bpp = ddsd.ddpfPixelFormat.dwRGBBitCount;
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen EnumerateDisplayModes
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::EnumerateDisplayModes (LPMODEINFO lpinfo)
{
	// Get list of available display mode from DirectDraw
	lpinfo->NumModes = 0;
	if (FAILED (m_DD->EnumDisplayModes (0, NULL, (LPVOID)lpinfo, EnumDisplayModesCallback)))
	{
		MSG (m_hWnd, "EnumDisplayModes failed.\n");
		lpinfo->NumModes = 0;
		return FALSE;
	}

	// Sort the list of display modes
	qsort (lpinfo->Mode, lpinfo->NumModes, sizeof (MODE), CompareModes);
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen CreateD3D
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::CreateD3D (void)
{
	HRESULT rval;
	if (FAILED (rval = m_DD->QueryInterface (IID_IDirect3D2, (LPVOID*)&m_D3D)))
		MSG (m_hWnd, "Creation of IDirect3D failed.\n");
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen EnumerateDevices
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::EnumerateDevices (LPD3DDRIVERINFO lpinfo)
{
	HRESULT rval;

	lpinfo->NumDrivers = 0;
	if (FAILED (rval = m_D3D->EnumDevices (EnumDeviceFunc, (LPVOID)lpinfo)))
	{
		MSG (m_hWnd, "Enumeration of drivers failed.\n");
		return FALSE;
	}
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen VerifyDriverAndMode
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::VerifyDriverAndMode (int* lpdriver, int* lpmode)
{
	DWORD depths;
	int driver, mode, i;
	driver = *lpdriver; mode = *lpmode;

	// If I've been ask choose a driver, choose one which is compatible
	// with the specific mode
	if (driver == VALUE_YOUDECIDE)
	{
		if (mode == VALUE_YOUDECIDE)
		{
			// I'm free to choose any driver which can use even one supported mode
			depths = 0;
			for (i = 0; i < m_ModeInfo.NumModes; i++)
				depths |= BPPToDDBD (m_ModeInfo.Mode[i].bpp);
			PickDriver (&driver, depths);
			if (driver == VALUE_ERROR)
			{
				MSG (m_hWnd, "Cannot find D3D device driver which is the current display depth of any supported fullscreen mode.\n");
				return FALSE;
			}
			// The mode will be chosen in the next section
		}
		else
		{
			// must pick a driver which use the given mode depth
			PickDriver (&driver, BPPToDDBD (m_ModeInfo.Mode[mode].bpp));
			if (driver == VALUE_ERROR)
			{
				MSG (m_hWnd, "Cannot find a D3D device driver which is compatible with the specific fullscreen mode.\n");
				return FALSE;
			}
			// I don't need to go through the mode selection since I've verified it here
			goto ret_ok;
		}
	}
	
	// At this stage, I have a driver I want to match the mode to
	if (mode == VALUE_YOUDECIDE)
	{
		PickDisplayMode (&mode, m_D3DDriverInfo.D3DDriver[driver].Desc.dwDeviceRenderBitDepth);
		if (mode == VALUE_ERROR)
		{
			MSG (m_hWnd, "The selected D3D device driver is not compatible with the current display depth or any supported fullscreen modes.\n");
			return FALSE;
		}
		goto ret_ok;
	}
	else
	{
		// Check to see if this driver can use the specified fullscreen mode
		if (BPPToDDBD (m_ModeInfo.Mode[mode].bpp) & m_D3DDriverInfo.D3DDriver[driver].Desc.dwDeviceRenderBitDepth)
			goto ret_ok;
		else
		{
			// Since it cannot, call this function again to choose any display mode which is compatible
			mode = VALUE_YOUDECIDE;
			VerifyDriverAndMode (&driver, &mode);
			if (mode == VALUE_ERROR)
				return FALSE;
			goto ret_ok;
		}
	}
	
ret_ok:
	*lpdriver = driver; *lpmode = mode;
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen PickDriver
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::PickDriver (int* driver, DWORD depths)
{
	int i, j;
	j = 0;
	for (i = 0; i < m_D3DDriverInfo.NumDrivers; i++)
		if (m_D3DDriverInfo.D3DDriver[i].Desc.dwDeviceRenderBitDepth & depths)
			break;
	if (i >= m_D3DDriverInfo.NumDrivers)
	{
		*driver = VALUE_ERROR;
		return TRUE;
	}
	j = i;
	for (i = 0; i < m_D3DDriverInfo.NumDrivers; i++)
		if (m_D3DDriverInfo.D3DDriver[i].Desc.dwDeviceRenderBitDepth & depths)
			if (m_D3DDriverInfo.D3DDriver[i].bIsHardware && !m_D3DDriverInfo.D3DDriver[j].bIsHardware)
				j = i;
			else 
				if (m_D3DDriverInfo.D3DDriver[i].bIsHardware == m_D3DDriverInfo.D3DDriver[j].bIsHardware)
					if (m_D3DDriverInfo.D3DDriver[i].Desc.dcmColorModel & D3DCOLOR_MONO && !(m_D3DDriverInfo.D3DDriver[j].Desc.dcmColorModel & D3DCOLOR_MONO))
						j = i;
	if (j >= m_D3DDriverInfo.NumDrivers)
		*driver = VALUE_ERROR;
	else
		*driver = j;
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen PickDisplayMode
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::PickDisplayMode (int* mode, DWORD depths)
{
	int i, j;
	for (i = 0; i < m_ModeInfo.NumModes; i++)
		if (BPPToDDBD (m_ModeInfo.Mode[i].bpp) & depths)
			break;
	j = i;
	for (; i < m_ModeInfo.NumModes; i ++)
	{
		if (!(BPPToDDBD (m_ModeInfo.Mode[i].bpp) & depths))
			continue;
		if (m_ModeInfo.Mode[i].w == DEFAULT_WIDTH && m_ModeInfo.Mode[i].h == DEFAULT_HEIGHT && m_ModeInfo.Mode[i].bpp == DEFAULT_BPP)
		{
			j = i;
			break;
		}
	}
	if (j >= m_ModeInfo.NumModes)
		*mode = VALUE_ERROR;
	else 
		*mode = j;
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen FilterDisplayModes
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::FilterDisplayModes (int driver)
{
	int i;
	DWORD depths = m_D3DDriverInfo.D3DDriver[driver].Desc.dwDeviceRenderBitDepth;

	for (i = 0; i < m_ModeInfo.NumModes; i++)
	{
		m_ModeInfo.Mode[i].bThisDriverCanDo = FALSE;
		if (!(BPPToDDBD (m_ModeInfo.Mode[i].bpp) & depths))
			continue;
		m_ModeInfo.Mode[i].bThisDriverCanDo = TRUE;
	}
	m_ThisMode.bThisDriverCanDo = m_ModeInfo.Mode[m_ModeInfo.CurrMode].bThisDriverCanDo;
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen BPPToDDBD
/////////////////////////////////////////////////////////////////////////////
DWORD DX_Screen::BPPToDDBD (int bpp)
{
	switch(bpp) {
        case 1:
            return DDBD_1;
        case 2:
            return DDBD_2;
        case 4:
            return DDBD_4;
        case 8:
            return DDBD_8;
        case 16:
            return DDBD_16;
        case 24:
            return DDBD_24;
        case 32:
            return DDBD_32;
        default:
            return (DWORD)VALUE_ERROR;
    }
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen SetCoopLevel
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::SetCoopLevel (HWND hWnd)
{
	HRESULT rval;

	if (FAILED (rval = m_DD->SetCooperativeLevel (hWnd, DDSCL_EXCLUSIVE | DDSCL_FULLSCREEN)))
		MSG (m_hWnd, "SetCooperativeLevel to fullscreen failed.\n");
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen SetDisplayMode
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::SetDisplayMode (int w, int h, int bpp)
{
	HRESULT rval;

	m_ThisMode.w = w;
	m_ThisMode.h = h;
	m_ThisMode.bpp = bpp;

	if (FAILED (rval = m_DD->SetDisplayMode (w, h, bpp)))
	{
		char buff[256];
		wsprintf (buff, "SetDisplayMode to %dx%dx%d failed.\n", w, h, bpp);
		MSG (m_hWnd, buff);
	}
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen CreateBuffers
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::CreateBuffers (BOOL bIsHardware)
{
	HRESULT rval;
	
	// Release any old objects
	SAFE_DELETE (m_BackBuffer);
	SAFE_DELETE (m_FrontBuffer);

	// Create a complex flipping surface for fullscreen mode with one back buffer
	m_FrontBuffer = new DX_Surface;
	memset (&m_FrontBuffer->m_Desc, 0, sizeof (DDSURFACEDESC));
	m_FrontBuffer->m_Desc.dwSize = sizeof (DDSURFACEDESC);
	m_FrontBuffer->m_Desc.dwFlags = DDSD_CAPS | DDSD_BACKBUFFERCOUNT;
	m_FrontBuffer->m_Desc.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE | DDSCAPS_FLIP | DDSCAPS_3DDEVICE | DDSCAPS_COMPLEX;
	m_FrontBuffer->m_Desc.dwBackBufferCount = 1;
	if (bIsHardware)
		m_FrontBuffer->m_Desc.ddsCaps.dwCaps |= DDSCAPS_VIDEOMEMORY;
	if (FAILED (rval = m_FrontBuffer->Create (this)))
	{
		if (rval == DDERR_OUTOFMEMORY || rval == DDERR_OUTOFVIDEOMEMORY)
			MSG (m_hWnd, "There was not enough video memory to create the rendering surface.\n");
		else
			MSG (m_hWnd, "CreateSurface for fullscreen flipping surface failed.\n");
		goto exit_with_error;
	}

	// Obtain a pointer to the back buffer surface created above so we can use it later.
	// For now, just check to see if it ended up in video memory (FYI)
	m_BackBuffer = new DX_Surface;
	m_BackBuffer->m_Caps.dwCaps = DDSCAPS_BACKBUFFER;
	if (FAILED (rval = m_FrontBuffer->GetSurface ()->GetAttachedSurface (&m_BackBuffer->m_Caps, &m_BackBuffer->m_Surface)))
	{
		MSG (m_hWnd, "GetAttachedSurface failed to get back buffer.\n");
		goto exit_with_error;
	}
	if (FAILED (rval = m_BackBuffer->GetSurface ()->GetSurfaceDesc (&m_BackBuffer->m_Desc)))
	{
		MSG (m_hWnd, "Failed to get surface description of back buffer.\n");
		goto exit_with_error;
	}
	m_bBackBufferInVideo = (m_BackBuffer->m_Desc.ddsCaps.dwCaps & DDSCAPS_VIDEOMEMORY) ? TRUE : FALSE;
	m_BackBuffer->m_Width = m_BackBuffer->m_Desc.dwWidth;
	m_BackBuffer->m_Height = m_BackBuffer->m_Desc.dwHeight;

	// Clear buffers with black
	m_FrontBuffer->Fill (0);
	m_BackBuffer->Fill (0);
	return rval;

exit_with_error:
	SAFE_DELETE (m_BackBuffer);
	SAFE_DELETE (m_FrontBuffer);
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen CreateZBuffer
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::CreateZBuffer (int w, int h, int driver)
{
	HRESULT rval;
	DWORD devDepth;

	// Relese any z-Buffer that might be around just in case
	SAFE_DELETE (m_ZBuffer);

	// If this driver does not do z-bufferig, don't create a z-buffer
	if (!m_D3DDriverInfo.D3DDriver[driver].bDoesZBuffer)
		return DD_OK;

	// Prepare to create z-buffer
	m_ZBuffer = new DX_Surface;
	memset (&m_ZBuffer->m_Desc, 0, sizeof (DDSURFACEDESC));
	m_ZBuffer->m_Desc.dwSize = sizeof (DDSURFACEDESC);
	m_ZBuffer->m_Desc.dwFlags = DDSD_WIDTH | DDSD_HEIGHT | DDSD_CAPS | DDSD_ZBUFFERBITDEPTH;
	m_ZBuffer->m_Desc.ddsCaps.dwCaps = DDSCAPS_ZBUFFER;
	m_ZBuffer->m_Desc.dwWidth = w;
	m_ZBuffer->m_Desc.dwHeight = h;

	// If this is a hardware D3D driver, the z-Buffer MUST end up in video memory,
	// Otherwise, it MUST end up in system memory
	if (m_D3DDriverInfo.D3DDriver[driver].bIsHardware)
		m_ZBuffer->m_Desc.ddsCaps.dwCaps |= DDSCAPS_VIDEOMEMORY;
	else
		m_ZBuffer->m_Desc.ddsCaps.dwCaps |= DDSCAPS_SYSTEMMEMORY;

	// Get the z buffer depth from this driver's D3D device description
	devDepth = m_D3DDriverInfo.D3DDriver[driver].Desc.dwDeviceZBufferBitDepth;
	if (devDepth & DDBD_32)
		m_ZBuffer->m_Desc.dwZBufferBitDepth = 32;
	else if (devDepth & DDBD_24)
		m_ZBuffer->m_Desc.dwZBufferBitDepth = 24;
	else if (devDepth & DDBD_16)
		m_ZBuffer->m_Desc.dwZBufferBitDepth = 16;
	else if (devDepth & DDBD_8)
		m_ZBuffer->m_Desc.dwZBufferBitDepth = 8;
	else 
	{
		MSG (m_hWnd, "Unsupported Z-buffer depth requested by device.\n");
		return E_FAIL;
	}

	// Create z-buffer
	if (FAILED (rval = m_ZBuffer->Create (this)))
	{
		if (rval == DDERR_OUTOFMEMORY || rval == DDERR_OUTOFVIDEOMEMORY)
			MSG (m_hWnd, "There was not enough video memory to create the z-buffer surface.\n");
		else
			MSG (m_hWnd, "CreateSurface for z-buffer failed.\n");
		goto exit_with_error;
	}

	// Attached the z-buffer to the back buffer so D3D will find it
	if (FAILED (rval = m_BackBuffer->GetSurface ()->AddAttachedSurface (m_ZBuffer->GetSurface ())))
	{
		MSG (m_hWnd, "AddAttachedSurface failed for z-buffer.\n");
		goto exit_with_error;
	}

	// Find out if it ended up in video memory
	if (FAILED (rval = m_ZBuffer->GetSurface ()->GetSurfaceDesc (&m_ZBuffer->m_Desc)))
	{
		MSG (m_hWnd, "Failed to get surface description of Z buffer.\n");
		goto exit_with_error;
	}
	m_bZBufferInVideo = (m_ZBuffer->m_Desc.ddsCaps.dwCaps & DDSCAPS_VIDEOMEMORY) ? TRUE : FALSE;
	if (m_D3DDriverInfo.D3DDriver[driver].bIsHardware && !m_bZBufferInVideo)
	{
		MSG (m_hWnd, "Could not fit the z-buffer in video memory for this hardware device.\n");
		goto exit_with_error;
	}
	return rval;

exit_with_error:
	SAFE_DELETE (m_ZBuffer);
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen CreateClipper
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::CreateClipper (DX_Surface* dest)
{
	SAFE_DELETE (m_Clipper);

	m_Clipper = new DX_Clipper;
	return m_Clipper->AttachClipper (this, dest);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen CreateDevice
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::CreateDevice (int driver)
{
	HRESULT rval;

	SAFE_RELEASE (m_D3DDevice);

	if (m_D3DDriverInfo.D3DDriver[driver].bIsHardware && !m_bBackBufferInVideo)
	{
		MSG (m_hWnd, "Could not fit the rendering surfaces in video memory for this hardware device.\n");
		goto exit_with_error;
	}
	m_D3DDriverInfo.CurrDriver = driver;
	memcpy (&m_ThisD3DDriver, &m_D3DDriverInfo.D3DDriver[driver], sizeof (D3DDRIVER));

	if (FAILED (rval = m_D3D->CreateDevice (m_D3DDriverInfo.D3DDriver[driver].Guid, m_BackBuffer->m_Surface, &m_D3DDevice)))
	{
		MSG (m_hWnd, "Create D3D device failed.\n");
		goto exit_with_error;
	}
	return rval;

exit_with_error:
	SAFE_RELEASE (m_D3DDevice);
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen CreateDevAndView
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::CreateDevAndView (void)
{
	HRESULT rval;

	if (FAILED (rval = m_D3DRM->CreateDeviceFromD3D (m_D3D, m_D3DDevice, &m_dev)))
	{
		MSG (m_hWnd, "Creation of D3DRM device failed.\n");
		return rval;
	}

	// Create the D3DRM Viewport using the camera frame. 
	// Set the background depth to large number. The width and height may be slightly
	// adjust, so get them from the device to be sure.
	if (FAILED (rval = m_D3DRM->CreateViewport (m_dev, m_camera, 0, 0, m_dev->GetWidth (), m_dev->GetHeight (), &m_view)))
	{
		MSG (m_hWnd, "Failed to create the D3DRM viewport.\n");
		SAFE_RELEASE (m_dev);
		return rval;
	}
	if (FAILED (rval = m_view->SetBack (D3DVAL (5000.0))))
	{
		MSG (m_hWnd, "Failed to set the background depth of the D3DRM viewport.\n");
		SAFE_RELEASE (m_view);
		SAFE_RELEASE (m_dev);
		return rval;
	}
	// Set the render quality, fill mode , lighting state and color shade info
	if (FAILED (SetRenderState ()))
	{
		MSG (m_hWnd, "Failed to SetRenderState.\n");
		return rval;
	}
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen D3DSetRenderState
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::D3DSetRenderState (void)
{
	// Set render state
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_SHADEMODE, m_D3DRenderState.ShadeMode);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_TEXTUREPERSPECTIVE, m_D3DRenderState.bPerspCorrect);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_ZENABLE, m_D3DRenderState.bZBufferOn && m_ThisD3DDriver.bDoesZBuffer);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_ZWRITEENABLE, m_D3DRenderState.bZBufferOn);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_ZFUNC, D3DCMP_LESSEQUAL);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_TEXTUREMAG, m_D3DRenderState.TextureFilter);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_TEXTUREMIN, m_D3DRenderState.TextureFilter);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_TEXTUREMAPBLEND, m_D3DRenderState.TextureBlend);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_FILLMODE, m_D3DRenderState.FillMode);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_DITHERENABLE, m_D3DRenderState.bDithering);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_SPECULARENABLE, m_D3DRenderState.bSpecular);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_ANTIALIAS, m_D3DRenderState.bAntialiasing);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_FOGENABLE, m_D3DRenderState.bFogEnabled);
	m_D3DDevice->SetRenderState (D3DRENDERSTATE_FOGCOLOR, m_D3DRenderState.FogColor);
	// Set the light state
	m_D3DDevice->SetLightState (D3DLIGHTSTATE_FOGMODE, m_D3DRenderState.bFogEnabled ? m_D3DRenderState.FogMode : D3DFOG_NONE);
	m_D3DDevice->SetLightState (D3DLIGHTSTATE_FOGSTART, *(unsigned long*)&m_D3DRenderState.FogStart);
	m_D3DDevice->SetLightState (D3DLIGHTSTATE_FOGEND, *(unsigned long*)&m_D3DRenderState.FogEnd);
	return D3D_OK;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen SetRenderState
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::SetRenderState (void)
{
	HRESULT rval;

	// Set the number of buffers so D3DRM can keep track of extents properly
	if (FAILED (rval = m_dev->SetBufferCount (m_bBackBufferInVideo ? 2 : 1)))
	{
		MSG (m_hWnd, "Setting the buffer count failed.\n");
		return rval;
	}
	// Set the render quality (light toggle, fill mode, shade mode)
	if (m_dev->GetQuality () != m_RenderQuality)
	{
		if (FAILED (rval = m_dev->SetQuality (m_RenderQuality)))
		{
			MSG (m_hWnd, "Setting the render quality failed.\n");
			return rval;
		}
	}
	// Set dithering toggle
	if (m_dev->GetDither () != m_bDithering)
	{
		if (FAILED (rval = m_dev->SetDither (m_bDithering)))
		{
			MSG (m_hWnd, "Setting dithering mode failed.\n");
			return rval;
		}
	}
	// Set the texture quality (point or linear filtering)
	if (m_dev->GetTextureQuality () != m_TextureQuality)
	{
		if (FAILED (rval = m_dev->SetTextureQuality (m_TextureQuality)))
		{
			MSG (m_hWnd, "Setting texture quality failed.\n");
			return rval;
		}
	}
	// Set shade based on current bits per pixel
	switch (m_ThisMode.bpp)
	{
	case 1:
		if (FAILED (m_dev->SetShades (4)))
			goto exit_with_error;
		if (FAILED (m_D3DRM->SetDefaultTextureShades (4)))
			goto exit_with_error;
		break;
	case 16:
		if (FAILED (m_dev->SetShades (32)))
			goto exit_with_error;
		if (FAILED (m_D3DRM->SetDefaultTextureColors (64)))
			goto exit_with_error;
		if (FAILED (m_D3DRM->SetDefaultTextureShades (32)))
			goto exit_with_error;
		break;
	case 24:
	case 32:
		if (FAILED (m_dev->SetShades (256)))
			goto exit_with_error;
		if (FAILED (m_D3DRM->SetDefaultTextureColors (64)))
			goto exit_with_error;
		if (FAILED (m_D3DRM->SetDefaultTextureShades (256)))
			goto exit_with_error;
		break;
	}
	return rval;

exit_with_error:
	MSG (m_hWnd, "A failure occurred while setting color shade information.\n");
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen DefaultD3DRenderState
/////////////////////////////////////////////////////////////////////////////
void DX_Screen::DefaultD3DRenderState (LPD3DRENDERSTATE lpstate)
{
	lpstate->bZBufferOn = TRUE;
	lpstate->bPerspCorrect = FALSE;
	lpstate->ShadeMode = D3DSHADE_GOURAUD;
	lpstate->TextureFilter = D3DFILTER_NEAREST;
	lpstate->TextureBlend = D3DTBLEND_MODULATE;
	lpstate->FillMode = D3DFILL_SOLID;
	lpstate->bDithering = FALSE;
	lpstate->bSpecular = TRUE;
	lpstate->bAntialiasing = FALSE;
	lpstate->bFogEnabled = FALSE;
	lpstate->FogColor = RGB_MAKE (0, 0, 0);
	lpstate->FogMode = D3DFOG_LINEAR;
	lpstate->FogStart = D3DVAL (6.0);
	lpstate->FogEnd = D3DVAL (11.0);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen ChangeDriver
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::ChangeDriver (int driver)
{
	// Verify the compatibility of this mode with the specified driver.
	if (!(m_D3DDriverInfo.D3DDriver[driver].Desc.dwDeviceRenderBitDepth & BPPToDDBD (m_ModeInfo.Mode[m_ModeInfo.CurrMode].bpp)))
	{
		MSG (m_hWnd, "The specified D3D device driver doesn't compatible with the current display depth.\n");
		return FALSE;
	}
	// Update the current driver
	int tmp = m_D3DDriverInfo.CurrDriver;
	m_D3DDriverInfo.CurrDriver = driver;
	if (!(ChangeMode (m_ModeInfo.CurrMode)))
	{
		m_D3DDriverInfo.CurrDriver = tmp;
		return FALSE;
	}
	// Update current driver info
	memcpy (&m_ThisD3DDriver, &m_D3DDriverInfo.D3DDriver[m_D3DDriverInfo.CurrDriver], sizeof (D3DDRIVER));
	FilterDisplayModes (m_D3DDriverInfo.CurrDriver);
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen ChangeMode
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::ChangeMode (int mode)
{
	// Make sure this is a valid request.
	if (!(m_D3DDriverInfo.D3DDriver[m_D3DDriverInfo.CurrDriver].Desc.dwDeviceRenderBitDepth & BPPToDDBD (m_ModeInfo.Mode[mode].bpp)))
	{
		MSG (m_hWnd, "The current D3D device driver doesn't compatible with the specified display mode.\n");
		goto exit_with_error;
	}
	// Release everything
	SAFE_DELETE (m_Clipper);
	SAFE_RELEASE (m_view);
	SAFE_RELEASE (m_dev);
	
	// Clear buffers
	if (m_FrontBuffer)	m_FrontBuffer->Fill (0);
	if (m_BackBuffer)	m_BackBuffer->Fill (0);

	SAFE_RELEASE (m_D3DDevice);
	SAFE_DELETE (m_ZBuffer);
	SAFE_DELETE (m_BackBuffer);
	SAFE_DELETE (m_FrontBuffer);

	// Setting up
	if (FAILED (SetDisplayMode (m_ModeInfo.Mode[mode].w, m_ModeInfo.Mode[mode].h, m_ModeInfo.Mode[mode].bpp)))
		goto exit_with_error;
	if (FAILED (CreateBuffers (m_D3DDriverInfo.D3DDriver[m_D3DDriverInfo.CurrDriver].bIsHardware)))
		goto exit_with_error;
	if (FAILED (CreateZBuffer (m_ModeInfo.Mode[mode].w, m_ModeInfo.Mode[mode].h, m_D3DDriverInfo.CurrDriver)))
		goto exit_with_error;
	if (FAILED (CreateDevice (m_D3DDriverInfo.CurrDriver)))
		goto exit_with_error;
	if (FAILED (CreateDevAndView ()))
		goto exit_with_error;
	if (FAILED (D3DSetRenderState ()))
		goto exit_with_error;
	if (FAILED (CreateClipper (m_BackBuffer)))
		goto exit_with_error;
	// Record current display mode
	m_ModeInfo.CurrMode = mode;
	memcpy (&m_ThisMode, &m_ModeInfo.Mode[m_ModeInfo.CurrMode], sizeof (MODE));
	return TRUE;

exit_with_error:
	// Release everything
	SAFE_DELETE (m_Clipper);
	SAFE_RELEASE (m_view);
	SAFE_RELEASE (m_dev);
	
	// Clear buffers
	if (m_FrontBuffer)	m_FrontBuffer->Fill (0);
	if (m_BackBuffer)	m_BackBuffer->Fill (0);

	SAFE_RELEASE (m_D3DDevice);
	SAFE_DELETE (m_ZBuffer);
	SAFE_DELETE (m_BackBuffer);
	SAFE_DELETE (m_FrontBuffer);
	return FALSE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen Create
/////////////////////////////////////////////////////////////////////////////
BOOL DX_Screen::Create (HWND hWnd)
{
	// Restore the main window handle
	m_hWnd = hWnd;

	// Enumerate the DirectDraw drivers
	if (!EnumerateDDDevices (&m_DDDriverInfo))
		return FALSE;
	// Choose the last device enumerated which will probably be secondary 3D hardware
	m_DDDriverInfo.CurrDriver = m_DDDriverInfo.NumDrivers - 1;

	// Create the D3DRM object which are initialized only when the program starts
	if (FAILED (CreateD3DRM ()))
		return FALSE;

	// Initialise DD and D3D objects necessary to render.
	// Create DirectDraw, remember the Windows display mode and enumerate the display modes
	if (FAILED (CreateDD (m_DDDriverInfo.DDDriver[m_DDDriverInfo.CurrDriver].bIsPrimary ? NULL : &m_DDDriverInfo.DDDriver[m_DDDriverInfo.CurrDriver].Guid)))
		return FALSE;
	if (FAILED (RememberWindowsMode (&m_WindowsDisplay)))
		return FALSE;
	if (!EnumerateDisplayModes (&m_ModeInfo))
		return FALSE;

	// Create Direct3D and enumerate the D3D drivers
	if (FAILED (CreateD3D ()))
		return FALSE;
	if (!EnumerateDevices (&m_D3DDriverInfo))
		return FALSE;

	// Choose a driver and display mode. Set the cooperative level and create the front and back buffers for this mode
	m_D3DDriverInfo.CurrDriver = VALUE_YOUDECIDE;
	m_ModeInfo.CurrMode = VALUE_YOUDECIDE;
	if (!VerifyDriverAndMode (&m_D3DDriverInfo.CurrDriver, &m_ModeInfo.CurrMode))
		return FALSE;
	// Restore the current driver and mode informations
	memcpy (&m_ThisD3DDriver, &m_D3DDriverInfo.D3DDriver[m_D3DDriverInfo.CurrDriver], sizeof (D3DDRIVER));
	memcpy (&m_ThisMode, &m_ModeInfo.Mode[m_ModeInfo.CurrMode], sizeof (MODE));
	if (FAILED (SetCoopLevel (m_hWnd)))
		return FALSE;
	if (FAILED (SetDisplayMode (m_ThisMode.w, m_ThisMode.h, m_ThisMode.bpp)))
		return FALSE;
	if (FAILED (CreateBuffers (m_D3DDriverInfo.D3DDriver[m_D3DDriverInfo.CurrDriver].bIsHardware)))
		return FALSE;

	// Create Z-buffer
	if (FAILED (CreateZBuffer (m_ThisMode.w, m_ThisMode.h, m_D3DDriverInfo.CurrDriver)))
		return FALSE;

	// Create the D3D device, create D3DRM dev and view, Filter display modes, and set D3D render state
	if (FAILED (CreateDevice (m_D3DDriverInfo.CurrDriver)))
		return FALSE;
	if (!FilterDisplayModes (m_D3DDriverInfo.CurrDriver))
		return FALSE;
	if (FAILED (CreateDevAndView ()))	// CreateDevAndView will call SetRenderState automatically
		return FALSE;
	if (FAILED (D3DSetRenderState ()))
		return FALSE;

	// Create DirectDraw clipper and attach to the back buffer
	if (FAILED (CreateClipper (m_BackBuffer)))
		return FALSE;
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen Render
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::Render (void)
{
	HRESULT rval;

	// Restore any lost surfaces
	if (FAILED (rval = Restore ()))
		return rval;
	// Force update
	if (FAILED (rval = m_view->ForceUpdate (0, 0, m_ThisMode.w, m_ThisMode.h)))
	{
		MSG (m_hWnd, "Force update failed.\n");
		return rval;
	}
	// Tick the scene
	if (FAILED (rval = m_scene->Move (D3DVAL (1.0))))
	{
		MSG (m_hWnd, "Moving scene failed.\n");
		return rval;
	}
	// Clear the viewport
	if (FAILED (rval = m_view->Clear (D3DRMCLEAR_ALL)))
	{
		MSG (m_hWnd, "Clearing viewport failed.\n");
		return rval;
	}
	// Render the scene to the viewport
	if (FAILED (rval = m_view->Render (m_scene)))
	{
		MSG (m_hWnd, "Rendering scene failed.\n");
		return rval;
	}
	// Update the window
	if (FAILED (rval = m_dev->Update ()))
	{
		MSG (m_hWnd, "Updating device failed.\n");
		return rval;
	}
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen Restore
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::Restore (void)
{
	HRESULT rval;

	// If front buffer is lost, restore it.
	if (m_FrontBuffer)
	{
		rval = m_FrontBuffer->GetSurface ()->IsLost ();
		if (rval == DDERR_SURFACELOST)
			if (FAILED (rval = m_FrontBuffer->Restore ()))
			{
				MSG (m_hWnd, "Failed to restore front buffer.\n");
				return rval;
			}
	}
	// If back buffer is lost, restore it.
	if (m_BackBuffer)
	{
		rval = m_BackBuffer->GetSurface ()->IsLost ();
		if (rval == DDERR_SURFACELOST)
			if (FAILED (rval = m_BackBuffer->Restore ()))
			{
				MSG (m_hWnd, "Failed to restore back buffer.\n");
				return rval;
			}
	}
	// If z-buffer is lost, restore it
	if (m_ZBuffer)
	{
		rval = m_ZBuffer->GetSurface ()->IsLost ();
		if (rval == DDERR_SURFACELOST)
			if (FAILED (rval = m_ZBuffer->Restore ()))
			{
				MSG (m_hWnd, "Failed to restore z-buffer.\n");
				return rval;
			}
	}
	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen Flip
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Screen::Flip (void)
{
	HRESULT rval;

	rval = m_FrontBuffer->GetSurface ()->Flip (m_BackBuffer->GetSurface (), DDFLIP_WAIT);
	if (rval == DDERR_SURFACELOST)
	{
		if (FAILED (rval = Restore ()))
			return rval;
		m_FrontBuffer->Fill (0);
		m_BackBuffer->Fill (0);
	}
	else if (rval != DD_OK)
		MSG (m_hWnd, "Flipping complex display surface failed.\n");
	return rval;
}