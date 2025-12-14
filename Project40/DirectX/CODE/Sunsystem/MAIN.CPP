#define INITGUID           // Must precede other defines and includes
#include <windows.h>
#include <malloc.h>        // Required by memset call
#include <mmsystem.h>
#include <d3drmwin.h>
#include <math.h>
#define MAX_DRIVERS 5           // Maximum D3D drivers expected  

// Global variables

LPDIRECT3DRM lpD3DRM;           // Direct3DRM object 
LPDIRECTDRAWCLIPPER lpDDClipper;// DirectDrawClipper object 

struct _myglobs {
    LPDIRECT3DRMDEVICE dev;     // Direct3DRM device 
    LPDIRECT3DRMVIEWPORT view;  // Direct3DRM viewport through which 
                                // the scene is viewed
    LPDIRECT3DRMFRAME scene;    // Master frame in which others are 

                                // placed 
    LPDIRECT3DRMFRAME camera;   // Frame describing the user's POV 

    GUID DriverGUID[MAX_DRIVERS];     // GUIDs of available D3D drivers 
    char DriverName[MAX_DRIVERS][50]; // Names of available D3D drivers 
    int  NumDrivers;                  // Number of available D3D drivers 
    int  CurrDriver;                  // Number of D3D driver currently
                                      // being used 

    BOOL bQuit;                 // Program is about to terminate 

    BOOL bInitialized;          // All D3DRM objects are initialized 
    BOOL bMinimized;            // Window is minimized 

    int BPP;                    // Bit depth of the current display mode

} myglobs;


static BOOL InitApp(HINSTANCE, int);
long FAR PASCAL WindowProc(HWND, UINT, WPARAM, LPARAM);
static BOOL EnumDrivers(HWND win);
static HRESULT WINAPI enumDeviceFunc(LPGUID lpGuid, 
    LPSTR lpDeviceDescription, LPSTR lpDeviceName, 

    LPD3DDEVICEDESC lpHWDesc, LPD3DDEVICEDESC lpHELDesc, 
    LPVOID lpContext);
static DWORD BPPToDDBD(int bpp);
static BOOL CreateDevAndView(LPDIRECTDRAWCLIPPER lpDDClipper, 
    int driver, int width, int height);
static BOOL SetRenderState(void);
static BOOL RenderLoop(void);
static void CleanUp(void);
void MakeMyOrbit(LPDIRECT3DRMFRAME lpScene,LPDIRECT3DRMFRAME * lplpOrbit,
				 D3DVALUE rotate);
void CreateMyStar(LPDIRECT3DRMFRAME lpOrbit,LPDIRECT3DRMFRAME * lplpStarFrame,
		D3DVALUE size, char* texture_path,D3DVALUE distance,D3DVALUE rotate);
void CreateMyLight(LPDIRECT3DRMFRAME lpScene);
void MyScene(LPDIRECT3DRMFRAME lpScene);

/////////////////////////////////////////////////////////////////////
//
// MakeMyOrbit()
//		create star and add it to own frame
//
/////////////////////////////////////////////////////////////////////
void MakeMyOrbit(LPDIRECT3DRMFRAME lpScene,LPDIRECT3DRMFRAME * lplpOrbit,
				 D3DVALUE rotate)
{
    lpD3DRM->CreateFrame(lpScene, lplpOrbit);
    (*lplpOrbit)->SetPosition( lpScene, 
        D3DVAL(0), D3DVAL(0.0), D3DVAL(0.0));
    (*lplpOrbit)->SetOrientation( lpScene, 
        D3DVAL(0.0), D3DVAL(0.0), D3DVAL(1),
        D3DVAL(0.0), D3DVAL(1), D3DVAL(0.0));
    (*lplpOrbit)->SetRotation( lpScene, 
        D3DVAL(0.0), D3DVAL(0.1), D3DVAL(0.0), D3DVAL(rotate)); //rotate around y axis
}

/////////////////////////////////////////////////////////////////////
//
// CreateMyStar()
//		create star and add it to own frame
//
/////////////////////////////////////////////////////////////////////
void CreateMyStar(LPDIRECT3DRMFRAME lpOrbit,LPDIRECT3DRMFRAME * lplpStarFrame,
		D3DVALUE size, char* texture_path,D3DVALUE distance,D3DVALUE rotate)
{
    LPDIRECT3DRMTEXTURE lpTex       = NULL;
    LPDIRECT3DRMWRAP lpWrap         = NULL;
    LPDIRECT3DRMMESHBUILDER lpSphere3_builder = NULL;

	lpD3DRM->CreateFrame(lpOrbit, lplpStarFrame);
    (*lplpStarFrame)->SetPosition( lpOrbit, 
        D3DVAL(0), D3DVAL(0.0), D3DVAL(distance));
    (*lplpStarFrame)->SetOrientation( lpOrbit, 
        D3DVAL(0.0), D3DVAL(0.0), D3DVAL(1),
        D3DVAL(0.0), D3DVAL(1), D3DVAL(0.0));
    (*lplpStarFrame)->SetRotation( lpOrbit, 
        D3DVAL(0.0), D3DVAL(0.1), D3DVAL(0.0), rotate); //rotate around y axis
    
	
	
	lpD3DRM->CreateMeshBuilder( &lpSphere3_builder);
    lpSphere3_builder->Load(
        "sphere3.x", NULL, D3DRMLOAD_FROMFILE, NULL, NULL);

    lpSphere3_builder->Scale(
        size, size, size); //scale to box wide hide deep size unit
      
    // Set sphere to white to avoid unexpected texture-blending results.
    lpSphere3_builder->SetColorRGB(
        D3DVAL(1), D3DVAL(1), D3DVAL(1));

	D3DVALUE miny, maxy, height;
    D3DRMBOX box;
    lpSphere3_builder->GetBox( &box);
    maxy = box.max.y;
    miny = box.min.y;
    height = maxy - miny;
    lpD3DRM->CreateWrap
        (D3DRMWRAP_CYLINDER  , NULL,
        D3DVAL(0.0), D3DVAL(0.0), D3DVAL(0.0),		//origin of wrap
        D3DVAL(0.0), D3DVAL(1.0), D3DVAL(0.0),		//z axis
        D3DVAL(0.0), D3DVAL(0.0), D3DVAL(1.0),		//y axis
        D3DVAL(0.0), D3DDivide(miny, height),		//origin in texture
        D3DVAL(1.0), D3DDivide(D3DVAL(1.0), height),//scale factor in texture
        &lpWrap);							
	lpWrap->Apply( (LPDIRECT3DRMOBJECT)
        lpSphere3_builder);

    lpD3DRM->LoadTexture( texture_path, &lpTex);
    lpSphere3_builder->SetTexture( lpTex);
    (*lplpStarFrame)->AddVisual(
        (LPDIRECT3DRMVISUAL) lpSphere3_builder);

	
	lpSphere3_builder->Release();
    lpTex->Release();
    lpWrap->Release();

}

/////////////////////////////////////////////////////////////////////
//
// CreateMyLight()
//	create light in scene
//
/////////////////////////////////////////////////////////////////////
void CreateMyLight(LPDIRECT3DRMFRAME lpScene)
{
    LPDIRECT3DRMLIGHT lpLightD      = NULL;
    LPDIRECT3DRMLIGHT lpLightA      = NULL;
	LPDIRECT3DRMFRAME lpLightFrame = NULL;

	lpD3DRM->CreateFrame(lpScene, &lpLightFrame);
	lpD3DRM->CreateLightRGB( D3DRMLIGHT_DIRECTIONAL, 
        D3DVAL(0.9), D3DVAL(0.9), D3DVAL(0.9), &lpLightD);
    lpLightFrame->AddLight( lpLightD);
    lpD3DRM->CreateLightRGB( D3DRMLIGHT_AMBIENT, 
        D3DVAL(0.1), D3DVAL(0.1), D3DVAL(0.1), &lpLightA);
    lpScene->AddLight( lpLightA);
	
	lpLightD->Release();
	lpLightFrame->Release();
	lpLightA->Release();

}






/////////////////////////////////////////////////////////////////////
//
// MyScene()
// Clear the viewport, render the next frame, and update the window.
//
/////////////////////////////////////////////////////////////////////
void MyScene(LPDIRECT3DRMFRAME lpScene)
{
	LPDIRECT3DRMFRAME lpOrbit = NULL;
	LPDIRECT3DRMFRAME lpStarFrame = NULL;
	CreateMyLight(lpScene)	;
	
	//make sun
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(0.1));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(5),
		"sun.bmp",D3DVAL(0) ,D3DVAL(0.2));
	lpOrbit->Release();
	lpStarFrame->Release();

	//make put
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(-0.2));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(0.5),
		"put.bmp",D3DVAL(15) ,D3DVAL(0.1));
	lpOrbit->Release();
	lpStarFrame->Release();


		//make suck
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(-0.1));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(1),
		"suck.bmp",D3DVAL(20) ,D3DVAL(0.1));
	lpOrbit->Release();
	lpStarFrame->Release();

	//make earth
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(0.15));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(1),
		"earth.bmp",D3DVAL(25) ,D3DVAL(0.1));
	lpOrbit->Release();
	lpStarFrame->Release();

	//make mar
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(-0.05));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(1),
		"mar.bmp",D3DVAL(30) ,D3DVAL(0.1));
	lpOrbit->Release();
	lpStarFrame->Release();

	//make phuruhus
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(0.08));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(2.7),
		"phuruhus.bmp",D3DVAL(40) ,D3DVAL(0.01));
	lpOrbit->Release();
	lpStarFrame->Release();

	//make sao
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(0.07));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(1.1),
		"sao.bmp",D3DVAL(49) ,D3DVAL(0.01));
	lpOrbit->Release();
	lpStarFrame->Release();

	//make uranus
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(0.05));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(1),
		"uranus.bmp",D3DVAL(52) ,D3DVAL(-0.01));
	lpOrbit->Release();
	lpStarFrame->Release();

	//make nep
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(-0.08));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(1),
		"nep.bmp",D3DVAL(57) ,D3DVAL(0.01));
	lpOrbit->Release();
	lpStarFrame->Release();

	//make pluto
	MakeMyOrbit(lpScene,&lpOrbit,D3DVAL(-0.04));
	CreateMyStar(lpOrbit,&lpStarFrame,D3DVAL(0.5),
		"pluto.bmp",D3DVAL(65) ,D3DVAL(0.01));
	lpOrbit->Release();
	lpStarFrame->Release();

}


/////////////////////////////////////////////////////////////////////
//
// RenderLoop
// Clear the viewport, render the next frame, and update the window.
//
/////////////////////////////////////////////////////////////////////
static BOOL
RenderLoop()
{
    HRESULT rval;
   
    // Tick the scene.
     
    rval = myglobs.scene->Move( D3DVAL(1.0));
    if (rval != D3DRM_OK) {
        return FALSE;
    }
    
    // Clear the viewport.
     
    rval = myglobs.view->Clear();
    if (rval != D3DRM_OK) {
        return FALSE;
    }
   
    // Render the scene to the viewport.
     
    rval = myglobs.view->Render( myglobs.scene);
    if (rval != D3DRM_OK) {
        return FALSE;
    }
    
    // Update the window.
     
    rval = myglobs.dev->Update();
    if (rval != D3DRM_OK) {
        return FALSE;
    }
    return TRUE;
}

/////////////////////////////////////////////////////////////////////
//
// EnumDrivers
// Enumerate the available D3D drivers and choose one.
//
/////////////////////////////////////////////////////////////////////
 
static BOOL
EnumDrivers(HWND win)
{
    LPDIRECTDRAW lpDD;
    LPDIRECT3D lpD3D;
    HRESULT rval;

    // Create a DirectDraw object and query for the Direct3D interface 
    // to use to enumerate the drivers.
     
    DirectDrawCreate(NULL, &lpDD, NULL);

    rval = lpDD->QueryInterface( IID_IDirect3D, 
        (void**) &lpD3D);
    if (rval != DD_OK) {
        lpDD->Release();
        return FALSE;
    }
    
    // Enumerate the drivers, setting CurrDriver to -1 to initialize the
    // driver selection code in enumDeviceFunc.
     
    myglobs.CurrDriver = -1;
    lpD3D->EnumDevices( enumDeviceFunc, 
        &myglobs.CurrDriver);
    
    // Ensure at least one valid driver was found.

     
    if (myglobs.NumDrivers == 0) {
        return FALSE;
    }
    lpD3D->Release();
    lpDD->Release();
    
    return TRUE;
}

/////////////////////////////////////////////////////////////////////
//
// enumDeviceFunc
// Callback function that records each usable D3D driver's name 
// and GUID. Chooses a driver and sets *lpContext to this driver.
//
/////////////////////////////////////////////////////////////////////
 
static HRESULT
WINAPI enumDeviceFunc(LPGUID lpGuid, LPSTR lpDeviceDescription, 
    LPSTR lpDeviceName, LPD3DDEVICEDESC lpHWDesc, 
    LPD3DDEVICEDESC lpHELDesc, LPVOID lpContext)

{
    static BOOL hardware = FALSE; // Current start driver is hardware 
    static BOOL mono = FALSE;     // Current start driver is mono light 
    LPD3DDEVICEDESC lpDesc;
    int *lpStartDriver = (int *)lpContext;
   
    // Decide which device description should be consulted.
     
    lpDesc = lpHWDesc->dcmColorModel ? lpHWDesc : lpHELDesc;
    
    // If this driver cannot render in the current display bit-depth, 
    // skip it and continue with the enumeration.

     
    if (!(lpDesc->dwDeviceRenderBitDepth & BPPToDDBD(myglobs.BPP)))
        return D3DENUMRET_OK;
    
    // Record this driver's name and GUID.
     
    memcpy(&myglobs.DriverGUID[myglobs.NumDrivers], lpGuid, 
        sizeof(GUID));
    lstrcpy(&myglobs.DriverName[myglobs.NumDrivers][0], lpDeviceName);
   
    // Choose hardware over software, RGB lights over mono lights.
     
    if (*lpStartDriver == -1) {
        
        // This is the first valid driver.

         
        *lpStartDriver = myglobs.NumDrivers;
        hardware = lpDesc == lpHWDesc ? TRUE : FALSE;
        mono = lpDesc->dcmColorModel & D3DCOLOR_MONO ? TRUE : FALSE;
    } else if (lpDesc == lpHWDesc && !hardware) {
        
        // This driver is hardware and the start driver is not.
         
        *lpStartDriver = myglobs.NumDrivers;
        hardware = lpDesc == lpHWDesc ? TRUE : FALSE;
        mono = lpDesc->dcmColorModel & D3DCOLOR_MONO ? TRUE : FALSE;

    } else if ((lpDesc == lpHWDesc && hardware ) || 
               (lpDesc == lpHELDesc && !hardware)) {
        if (lpDesc->dcmColorModel == D3DCOLOR_MONO && !mono) {
            
            // This driver and the start driver are the same type, and 
            // this driver is mono whereas the start driver is not.
             
            *lpStartDriver = myglobs.NumDrivers;
            hardware = lpDesc == lpHWDesc ? TRUE : FALSE;
            mono = lpDesc->dcmColorModel & D3DCOLOR_MONO ? TRUE : FALSE;

        }
    }
    myglobs.NumDrivers++;
    if (myglobs.NumDrivers == MAX_DRIVERS)
        return (D3DENUMRET_CANCEL);
    return (D3DENUMRET_OK);
}

/////////////////////////////////////////////////////////////////////
//
// BPPToDDBD
// Converts bits-per-pixel to a DirectDraw bit-depth flag.
//
/////////////////////////////////////////////////////////////////////

static DWORD
BPPToDDBD(int bpp)
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
            return 0;
    }
}

/////////////////////////////////////////////////////////////////////
//
// CreateDevAndView
// Create the D3DRM device and viewport with the given D3D driver and 
// with the specified size.
// 
/////////////////////////////////////////////////////////////////////
 
static BOOL
CreateDevAndView(LPDIRECTDRAWCLIPPER lpDDClipper, int driver, 
    int width, int height)
{
    HRESULT rval;

    // Create the D3DRM device from this window by using the specified 

    // D3D driver.
     
    lpD3DRM->CreateDeviceFromClipper( lpDDClipper, 
        &myglobs.DriverGUID[driver], width, height, &myglobs.dev);
    
    // Create the D3DRM viewport by using the camera frame.  Set the 
    // background depth to a large number. The width and height
    // might have been slightly adjusted, so get them from the device.
     
    width = myglobs.dev->GetWidth();
    height = myglobs.dev->GetHeight();

    rval = lpD3DRM->CreateViewport( myglobs.dev, 
        myglobs.camera, 0, 0, width, height, &myglobs.view);
    if (rval != D3DRM_OK) {
        myglobs.dev->Release();
        return FALSE;
    }
    rval = myglobs.view->SetBack( D3DVAL(5000));
    if (rval != D3DRM_OK) {
        myglobs.dev->Release();
        myglobs.view->Release();
        return FALSE;
    }

    
    // Set the render quality, fill mode, lighting state,
    // and color shade info.
     
    if (!SetRenderState())
        return FALSE;
    return TRUE;
}


/////////////////////////////////////////////////////////////////////
//
// SetRenderState
// Set the render quality and shade information.
//
/////////////////////////////////////////////////////////////////////
 
BOOL
SetRenderState(void)
{
    HRESULT rval;
    
    // Set the render quality (light toggle, fill mode, shade mode).
     
    rval = myglobs.dev->SetQuality( 
        D3DRMLIGHT_ON | D3DRMFILL_SOLID | D3DRMSHADE_GOURAUD);

    if (rval != D3DRM_OK) {
        return FALSE;
    }
    
    // If you want to change the dithering mode, call SetDither here.

    // If you want a texture quality other than D3DRMTEXTURE_NEAREST
    // (the default value), call SetTextureQuality here.
        
   return TRUE;
}


/////////////////////////////////////////////////////////////////////
//
// CleanUp
// Release all D3DRM objects and set the bQuit flag.
//
/////////////////////////////////////////////////////////////////////

void
CleanUp(void)
{
    myglobs.bInitialized = FALSE;
    myglobs.scene->Release();
    myglobs.camera->Release();
    myglobs.view->Release();
    myglobs.dev->Release();

    lpD3DRM->Release();
    lpDDClipper->Release();

    myglobs.bQuit = TRUE;
}


/////////////////////////////////////////////////////////////////////
//
// WindowProc
// Main window message handler.
//
/////////////////////////////////////////////////////////////////////
 
LONG FAR PASCAL WindowProc(HWND win, UINT msg, 
    WPARAM wparam, LPARAM lparam)
{
    RECT r;
    PAINTSTRUCT ps;
    LPDIRECT3DRMWINDEVICE lpD3DRMWinDev;

	D3DVECTOR c_p; //position of camera

	D3DVECTOR z_v; //z axis
	D3DVECTOR y_v; //y axix
	D3DVECTOR x_v; //y axix
#define SPEED 0.3
#define ANGLE 0.05
    switch (msg)    {
        
    case WM_DESTROY:
        CleanUp();
        break;

    case WM_ACTIVATE:

        {
       
        // Create a Windows-specific D3DRM window device to handle this
        // message.
         
        LPDIRECT3DRMWINDEVICE lpD3DRMWinDev;
        if (!myglobs.dev)
            break;
        myglobs.dev->QueryInterface( 
            IID_IDirect3DRMWinDevice, (void **) &lpD3DRMWinDev);
        lpD3DRMWinDev->HandleActivate(
            (WORD) wparam);
        lpD3DRMWinDev->Release();

        }
        break;

    case WM_PAINT:
        if (!myglobs.bInitialized || !myglobs.dev)
            return DefWindowProc(win, msg, wparam, lparam);
       
        // Create a Windows-specific D3DRM window device to handle this
        // message.
         
        if (GetUpdateRect(win, &r, FALSE)) {
            BeginPaint(win, &ps);
            myglobs.dev->QueryInterface( 
                IID_IDirect3DRMWinDevice, (void **) &lpD3DRMWinDev);

            if (FAILED(lpD3DRMWinDev->HandlePaint(
                ps.hdc)))
            lpD3DRMWinDev->Release();
            EndPaint(win, &ps);
        }
        break;

	case WM_KEYDOWN:
		switch(wparam)
		{
		case VK_UP:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			myglobs.camera->GetPosition(myglobs.scene,&c_p);
			D3DRMVectorAdd(&c_p,&c_p,&z_v);	//add position with z axis 
			myglobs.camera->SetPosition(myglobs.scene,c_p.dvX,c_p.dvY,c_p.dvZ);
			break;
		case VK_DOWN:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			myglobs.camera->GetPosition(myglobs.scene,&c_p);
			D3DRMVectorSubtract(&c_p,&c_p,&z_v);//subtract position with z axis 
			myglobs.camera->SetPosition(myglobs.scene,c_p.dvX,c_p.dvY,c_p.dvZ);
			break;
		case VK_RIGHT:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			D3DRMVectorRotate(&z_v,&z_v,&y_v,float(ANGLE));//rotate around y axis
			myglobs.camera->SetOrientation(myglobs.scene,
				z_v.dvX,z_v.dvY,z_v.dvZ,   y_v.dvX,y_v.dvY,y_v.dvZ);
			break;
		case VK_LEFT:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			D3DRMVectorRotate(&z_v,&z_v,&y_v,float(-ANGLE));//rotate around y axis
			myglobs.camera->SetOrientation(myglobs.scene,
				z_v.dvX,z_v.dvY,z_v.dvZ,   y_v.dvX,y_v.dvY,y_v.dvZ);
			break;
		case VK_NEXT:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			D3DRMVectorCrossProduct(&x_v,&y_v,&z_v);//rotate around x axis
			D3DRMVectorRotate(&z_v,&z_v,&x_v,float(ANGLE));
			myglobs.camera->SetOrientation(myglobs.scene,
				z_v.dvX,z_v.dvY,z_v.dvZ,   y_v.dvX,y_v.dvY,y_v.dvZ);
			break;
		case VK_PRIOR :
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			D3DRMVectorCrossProduct(&x_v,&y_v,&z_v);//rotate around x axis
			D3DRMVectorRotate(&z_v,&z_v,&x_v,float(-ANGLE));
			myglobs.camera->SetOrientation(myglobs.scene,
				z_v.dvX,z_v.dvY,z_v.dvZ,   y_v.dvX,y_v.dvY,y_v.dvZ);
			break;
		case VK_NUMPAD8:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			myglobs.camera->GetPosition(myglobs.scene,&c_p);
			D3DRMVectorAdd(&c_p,&c_p,&y_v);//add position with y axis
			myglobs.camera->SetPosition(myglobs.scene,c_p.dvX,c_p.dvY,c_p.dvZ);
			break;
		case VK_NUMPAD2:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			myglobs.camera->GetPosition(myglobs.scene,&c_p);
			D3DRMVectorSubtract(&c_p,&c_p,&y_v);//subtract position with y axis
			myglobs.camera->SetPosition(myglobs.scene,c_p.dvX,c_p.dvY,c_p.dvZ);
			break;
		case VK_NUMPAD4:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			D3DRMVectorCrossProduct(&x_v,&y_v,&z_v);
			myglobs.camera->GetPosition(myglobs.scene,&c_p);
			D3DRMVectorSubtract(&c_p,&c_p,&x_v);//subtract positon with x axis
			myglobs.camera->SetPosition(myglobs.scene,c_p.dvX,c_p.dvY,c_p.dvZ);
			break;
		case VK_NUMPAD6:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			D3DRMVectorCrossProduct(&x_v,&y_v,&z_v);
			myglobs.camera->GetPosition(myglobs.scene,&c_p);
			D3DRMVectorAdd(&c_p,&c_p,&x_v);//add position with y axis
			myglobs.camera->SetPosition(myglobs.scene,c_p.dvX,c_p.dvY,c_p.dvZ);
			break;
		case VK_ADD:
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			D3DRMVectorRotate(&y_v,&y_v,&z_v,float(ANGLE));//rotate around z axis
			myglobs.camera->SetOrientation(myglobs.scene,
				z_v.dvX,z_v.dvY,z_v.dvZ,   y_v.dvX,y_v.dvY,y_v.dvZ);
			break;
		case VK_SUBTRACT :
			myglobs.camera->GetOrientation(myglobs.scene,&z_v,&y_v);
			D3DRMVectorRotate(&y_v,&y_v,&z_v,float(-ANGLE));//rotate around z axis
			myglobs.camera->SetOrientation(myglobs.scene,
				z_v.dvX,z_v.dvY,z_v.dvZ,   y_v.dvX,y_v.dvY,y_v.dvZ);
			break;
		case VK_ESCAPE:
		myglobs.camera->SetOrientation(myglobs.scene,//back to the origin view
        D3DVAL(0.0), D3DVAL(0.0), D3DVAL(1), 
        D3DVAL(0.0), D3DVAL(1), D3DVAL(0.0));
		myglobs.camera->SetPosition(myglobs.scene,0,5,-70);
			break;
		}
	default:
        return DefWindowProc(win, msg, wparam, lparam);
    }
    return 0L;
}

/////////////////////////////////////////////////////////////////////
// 
// InitApp
// Creates window and initializes all objects necessary to begin 
// rendering.
//
/////////////////////////////////////////////////////////////////////
 
static BOOL
InitApp(HINSTANCE this_inst, int cmdshow)
{
    HWND win;
    HDC hdc;
    WNDCLASS wc;
    RECT rc;

    // Set up and register the window class.
     
    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc = WindowProc;

    wc.cbClsExtra = 0;
    wc.cbWndExtra = sizeof(DWORD);
    wc.hInstance = this_inst;
    wc.hIcon = LoadIcon(this_inst, "AppIcon");
    wc.hCursor = LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
    wc.lpszMenuName = NULL;        
    wc.lpszClassName = "D3DRM Example";
    if (!RegisterClass(&wc))
        return FALSE;
    
    // Initialize the global variables.
     
    memset(&myglobs, 0, sizeof(myglobs));


    // Create the window.
     
    win =
        CreateWindow
        (   "D3DRM Example",            // Class 
            "Hello World (Direct3DRM)", // Title bar 
            WS_VISIBLE | WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU |
                 WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
            CW_USEDEFAULT,              // Init. x pos 
            CW_USEDEFAULT,              // Init. y pos 
            300,                        // Init. x size 
            300,                        // Init. y size 

            NULL,                       // Parent window 
            NULL,                       // Menu handle 
            this_inst,                  // Program handle 
            NULL                        // Create parms 
        );
    if (!win)
        return FALSE;
   
    // Record the current display bits-per-pixel.
     
    hdc = GetDC(win);
    myglobs.BPP = GetDeviceCaps(hdc, BITSPIXEL);
    ReleaseDC(win, hdc);
   
    // Enumerate the D3D drivers and select one.

     
    if (!EnumDrivers(win))
        return FALSE;
   
    // Create the D3DRM object and the D3DRM window object.
     
    lpD3DRM = NULL;
    Direct3DRMCreate(&lpD3DRM);
    
    // Create the master scene frame and camera frame.
     
    lpD3DRM->CreateFrame( NULL, &myglobs.scene);
    lpD3DRM->CreateFrame( myglobs.scene, 
        &myglobs.camera);
    myglobs.camera->SetPosition( myglobs.scene, 

        D3DVAL(0.0), D3DVAL(0.0), D3DVAL(0.0));

    // Create a DirectDrawClipper object and associate the 
    // window with it.
     
    DirectDrawCreateClipper(0, &lpDDClipper, NULL);
    lpDDClipper->SetHWnd( 0, win);
    
    // Create the D3DRM device by using the selected D3D driver.
     
    GetClientRect(win, &rc);
    if (!CreateDevAndView(lpDDClipper, myglobs.CurrDriver, rc.right, 
            rc.bottom)) {
        return FALSE;

    }

MyScene( myglobs.scene);
/*
if (!MyScene( myglobs.scene)
        return FALSE;
*/


    myglobs.bInitialized = TRUE;  // Initialization completed
    
    // Display the window.
     
    ShowWindow(win, cmdshow);
    UpdateWindow(win);

    return TRUE;
}



/////////////////////////////////////////////////////////////////////
// 
// WinMain
// Initializes the application and enters a message loop.
// The message loop renders the scene until a quit message is received.
//
/////////////////////////////////////////////////////////////////////
 
int PASCAL
WinMain (HINSTANCE this_inst, HINSTANCE prev_inst, LPSTR cmdline, 
    int cmdshow)
{
    MSG     msg;
    HACCEL  accel = NULL;
    int     failcount = 0;  // Number of times RenderLoop has failed 

    prev_inst;
    cmdline;

    // Create the window and initialize all objects needed to begin 
    // rendering.
     
    if (!InitApp(this_inst, cmdshow))
        return 1;

    while (!myglobs.bQuit) {
        
        // Monitor the message queue until there are no pressing
        // messages.
         
        while (PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)) {
            if (!TranslateAccelerator(msg.hwnd, accel, &msg)) {
                TranslateMessage(&msg);

                DispatchMessage(&msg);
            }
        }
        
        // If the app is not minimized, not about to quit, and D3DRM has
        // been initialized, begin rendering.
         
        if (!myglobs.bMinimized && !myglobs.bQuit && 
             myglobs.bInitialized) {

		static DWORD timex = 0;
	        if ((timeGetTime() - timex)> 30 )
			{
				timex = timeGetTime(); 
				// Attempt to render a frame. If rendering fails more than 
				// twice, abort execution.
                 
	            if (!RenderLoop())
		            ++failcount;

			    if (failcount > 2) {
				    CleanUp();
					break;
				}
			}
		}
    }
    return msg.wParam;
}
