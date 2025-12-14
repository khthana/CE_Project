///////////////////////////////////////////////////////////
//Project Name:	Game developent using DirectX(DirectInput)
//Author:		Tawin Tusnajareon azzuri_man@hotmail.com
//Source File:	Mouse Implementation
//version 1.0
///////////////////////////////////////////////////////////
#include "DInput.h"

///////////////////////////////////////////////////////////
//CMouse Constructor
///////////////////////////////////////////////////////////
CMouse::CMouse(void)
{
	lpdi2 = NULL;
	m_bActive = FALSE;
	m_X = m_Y = m_Z =0;
}

///////////////////////////////////////////////////////////
//CMouse Destructor
///////////////////////////////////////////////////////////
CMouse::~CMouse(void)
{
	lpdi2->Unacquire();
	RELEASE(lpdi2);
}

///////////////////////////////////////////////////////////
//CMouse create
///////////////////////////////////////////////////////////
HRESULT CMouse::CreateMouse(CInput* input, void* hwnd)
{
	HRESULT rval;
	LPDIRECTINPUTDEVICE lpDID = NULL;

	//create a Mouse device
	rval = input->GetDI()->CreateDevice(GUID_SysMouse, &lpDID, NULL);
	if (rval == DI_OK)
	{
		//returns a pointer to that interface
		rval = lpDID->QueryInterface(IID_IDirectInputDevice2, (LPVOID*)&lpdi2);
		if (rval != DI_OK) return rval;

		// release the version 1.0 interface since we have converted
		// it to 2.0
		RELEASE(lpDID);

		//set cooperation level
		rval = lpdi2->SetCooperativeLevel((HWND) hwnd,DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
		if (rval != DI_OK) return rval;
		
		//set data format
		rval= lpdi2->SetDataFormat(&c_dfDIMouse);
		if (rval != DI_OK) return rval;
		
		//acquire the Mouse
		rval= lpdi2->Acquire();
		if (rval != DI_OK) return rval;

		m_bActive = TRUE;
	}
	return rval;//end if(rval == DI_OK)
}

///////////////////////////////////////////////////////////
//CMouse GetState
///////////////////////////////////////////////////////////
void CMouse::GetState(void)
{
	if(m_bActive)
	{
		DIMOUSESTATE mouse_state;

		//get the Mouse data
		if(lpdi2->GetDeviceState(sizeof(mouse_state), &mouse_state) == (DIERR_INPUTLOST | DIERR_NOTACQUIRED))
			lpdi2->Acquire();
		
		m_X = mouse_state.lX;
		m_Y = mouse_state.lY;
		m_Z = mouse_state.lZ;//keep position state mouse to m_X,m_Y,m_Z

		for(int i =0; i<4; i++)
			m_Buttons[i] = mouse_state.rgbButtons[i];//keep press state to m_Buttons
	}
}





