///////////////////////////////////////////////////////////
//Project Name:	Game developent using DirectX(DirectInput)
//Author:		Tawin Tusnajareon azzuri_man@hotmail.com
//Source File:	Keyboard Implementation
//version 1.0
///////////////////////////////////////////////////////////
#include "DInput.h"


///////////////////////////////////////////////////////////
//CKeyboard Constructor
///////////////////////////////////////////////////////////
CKeyboard::CKeyboard(void)
{
	lpdi2 = NULL;
	m_bActive = FALSE;
}

///////////////////////////////////////////////////////////
//CKeyboard Destructor
///////////////////////////////////////////////////////////
CKeyboard::~CKeyboard(void)
{
	lpdi2->Unacquire();
	RELEASE(lpdi2);
}

///////////////////////////////////////////////////////////
//CKeyboard create
///////////////////////////////////////////////////////////
HRESULT CKeyboard::CreateKeyboard(CInput* input, void* hwnd)
{
	HRESULT rval;
	LPDIRECTINPUTDEVICE lpDID = NULL;
	
	//create a keyboard device
	rval = input -> GetDI() -> CreateDevice(GUID_SysKeyboard, &lpDID, NULL);
	if (rval == DI_OK)
	{
		//returns a pointer to that interface
		rval = lpDID->QueryInterface(IID_IDirectInputDevice2, (LPVOID*)&lpdi2);
		if (rval != DI_OK) return rval;

		// release the version 1.0 interface since we have converted
		// it to 2.0
		RELEASE(lpDID);

		//set cooperation level
		lpdi2->SetCooperativeLevel((HWND) hwnd,DISCL_NONEXCLUSIVE | DISCL_BACKGROUND);
		//if (rval != DI_OK) return rval;
		
		//set data format
		lpdi2->SetDataFormat(&c_dfDIKeyboard);
		//if (rval != DI_OK) return rval;
		
		//acquire the keyboard
		rval= lpdi2->Acquire();
		if (rval != DI_OK) return rval;

		m_bActive = TRUE;
	}
	return rval;//end if(rval == DI_OK)
}

///////////////////////////////////////////////////////////
//CKeyboard GetState
///////////////////////////////////////////////////////////
void CKeyboard::GetState(void)
{
	if(m_bActive)
		//get the keyboard data
		if(lpdi2->GetDeviceState(256, &keyboard_state) ==(DIERR_INPUTLOST | DIERR_NOTACQUIRED))
			lpdi2->Acquire();
}





