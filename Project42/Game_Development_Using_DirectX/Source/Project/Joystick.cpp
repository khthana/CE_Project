///////////////////////////////////////////////////////////
//Project Name:	Game developent using DirectX(DirectInput)
//Author:		Tawin Tusnajareon azzuri_man@hotmail.com
//Source File:	Mouse Implementation
//version 1.0
///////////////////////////////////////////////////////////
#include "DInput.h"

///////////////////////////////////////////////////////////
//Cjoystick Constructor
///////////////////////////////////////////////////////////
CJoystick::CJoystick(void)
{
	lpdi2 = NULL;
	m_bActive = FALSE;
	m_X = m_Y = m_Z =0;
}

///////////////////////////////////////////////////////////
//Cjoystick Destructor
///////////////////////////////////////////////////////////
CJoystick::~CJoystick(void)
{
	lpdi2->Unacquire();
	RELEASE(lpdi2);
}

static LPDIRECTINPUTDEVICE lpDID = NULL;

///////////////////////////////////////////////////////////
//Enumerate Joystick
///////////////////////////////////////////////////////////
static BOOL FAR PASCAL EnumJoystick(LPCDIDEVICEINSTANCE pdinst, LPVOID pvRef)
{
//this function is enumerate joystick
	LPDIRECTINPUT pDI = (LPDIRECTINPUT)pvRef;

	if(pDI->CreateDevice(pdinst->guidInstance, &lpDID, NULL) != DI_OK)
		return DIENUM_CONTINUE;

	return DIENUM_STOP;
}

//////////////////////////////////////////////////////////////////////////////////
// CJoystick Create
//////////////////////////////////////////////////////////////////////////////////
HRESULT CJoystick::CreateJoystick(CInput* input, void* hwnd)
{
	HRESULT rval;

	// Enumerate the joystick device
	rval = input->GetDI()->EnumDevices(DIDEVTYPE_JOYSTICK, EnumJoystick, input->GetDI(), DIEDFL_ATTACHEDONLY);
	
	// Check for available device
	if (lpDID == NULL)
		return E_FAIL;

	if(lpDID != NULL && rval == DI_OK)
	{
		rval = lpDID->QueryInterface(IID_IDirectInputDevice2, (LPVOID*)&lpdi2);
		if(rval != DI_OK) return rval;

		RELEASE(lpDID);

		lpdi2->SetDataFormat(&c_dfDIJoystick);
		if(rval != DI_OK) return rval;

		lpdi2->SetCooperativeLevel((HWND) hwnd, DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
		if(rval != DI_OK) return rval;

		// Set the X-axis range (-1000 to +1000)
		DIPROPRANGE diprg;
		diprg.diph.dwSize = sizeof(diprg);
		diprg.diph.dwHeaderSize = sizeof(diprg.diph);
		diprg.diph.dwObj = DIJOFS_X;
		diprg.diph.dwHow = DIPH_BYOFFSET;
		diprg.lMin = -1000;
		diprg.lMax = +1000;

		if(lpdi2->SetProperty(DIPROP_RANGE, &diprg.diph) != DI_OK)
			return rval;

		// And again for Y-axis range
		diprg.diph.dwObj = DIJOFS_Y;

		if(lpdi2->SetProperty(DIPROP_RANGE, &diprg.diph) != DI_OK)
			return rval;

		// Set X axis dead zone to 10%
		DIPROPDWORD dipdw;
		dipdw.diph.dwSize = sizeof(dipdw);
		dipdw.diph.dwHeaderSize = sizeof(dipdw.diph);
		dipdw.diph.dwObj = DIJOFS_X;
		dipdw.diph.dwHow = DIPH_BYOFFSET;
		dipdw.dwData = 1000;

		if(lpdi2->SetProperty(DIPROP_DEADZONE, &dipdw.diph) != DI_OK)
			return rval;

		dipdw.diph.dwObj = DIJOFS_Y;

		// Set Y axis dead zone to 10%
		if(lpdi2->SetProperty(DIPROP_DEADZONE, &dipdw.diph) != DI_OK)
			return rval;

		rval = lpdi2->Acquire();
		if(rval != DI_OK) return rval;

		m_bActive = TRUE;
	}

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CJoystick Update
//////////////////////////////////////////////////////////////////////////////////
void CJoystick::GetState(void)
{
	if(m_bActive)
	{
		DIJOYSTATE joy_state;

		lpdi2->Poll();

		if(lpdi2->GetDeviceState(sizeof(joy_state), &joy_state) == (DIERR_INPUTLOST | DIERR_NOTACQUIRED))
			lpdi2->Acquire();

		m_X = joy_state.lX;
		m_Y = joy_state.lY;
		m_Z = joy_state.lZ;

		for(int i = 0; i < 32; i++)
			m_Buttons[i] = joy_state.rgbButtons[i];
	}
}

