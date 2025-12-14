#include "Bb_di.h"

#include <string.h>

#define KEYDOWN(name,key) (name[key] & 0x80) 

/*********************************************** 
 *
 * init_var() // initial all variable before use
 *
 ***********************************************/
void CBubbleDI::init_var()
{
	lpDI = NULL;
	lpKeyboard = NULL;

	init_value = FALSE;

	memset(diks,0,sizeof(diks));
}

/*********************************************** 
 *
 * DestroyDI() // Destroy all DirectInput relate
 *
 ***********************************************/
void CBubbleDI::DestroyDI()
{
    if( lpDI != NULL )
    {
		if( lpKeyboard != NULL )	
		{
	        /*
		     *  Cleanliness is next to godliness.  Unacquire the device
			 *  one last time just in case we got really confused and tried
			 *  to exit while the device is still acquired.
			 */
			lpKeyboard->Unacquire();

		
			lpKeyboard->Release(); 
			lpKeyboard = NULL;
		}

		/*
 		 *  Destroy any lingering IDirectInput object.
		 */
		lpDI->Release();
		lpDI = NULL;
    }
}

/**********************************************
*
* Constructor Initial DirectInput and use Keyboard
*
***********************************************/
CBubbleDI::CBubbleDI(HINSTANCE _hInstance, HWND _hwnd)
{
	init_var();

	//create dinput object
	init_value  = DirectInputCreate(_hInstance, 0x0300, &lpDI, NULL);
	if( init_value != DI_OK )
	{
		lpDI = NULL;
		return;
    }

	//create device
	init_value  = lpDI->CreateDevice(GUID_SysKeyboard, &lpKeyboard, NULL);
	if(init_value!= DI_OK )
	{
		DestroyDI();
		return;
    }

	//set date format 
	init_value = lpKeyboard->SetDataFormat(&c_dfDIKeyboard);
	if(init_value!= DI_OK )
	{
		DestroyDI();
		return;
	}

	//set coperative level
	init_value = lpKeyboard->SetCooperativeLevel(_hwnd,
                                DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
	if( init_value != DI_OK )
	{
		DestroyDI();
		return;
    }

	if( lpKeyboard ) 
	{
		lpKeyboard->Acquire(); 
	}
	//in this line successful for create directinput
}
/**************************************************
*
*	Destructor Destroy DirectInput
*
****************************************************/
CBubbleDI::~CBubbleDI(void)
{
	DestroyDI();
}

/*******************************************************
*
*	init_success told me that Dinput success  ?
*
*******************************************************/
BOOL CBubbleDI::InitSuccess(void)
{
	return init_value == DI_OK ? TRUE : FALSE;
}

/******************************************************
*
*	UpdateKeyStatus  for update key in diks keyboard array
*
*****************************************************/
BOOL CBubbleDI::UpdateKeyStatus(void)
{
	HRESULT dirval;

	if (lpKeyboard != NULL) 
	{
    again:;
		dirval = lpKeyboard->GetDeviceState(sizeof(diks), &diks);
		if( dirval == DIERR_INPUTLOST ) 
		{
 			dirval = lpKeyboard->Acquire();
            if( SUCCEEDED(dirval) ) 
			{
                goto again;
            }
        }
	} 

	if( SUCCEEDED(dirval) ) //now I have data of key
	{
		return TRUE;		
	} 

	return FALSE;
}

/*******************************************************
*
*	KeyStatus told me that this key was press ?
*
*******************************************************/
BOOL CBubbleDI::KeyStatus(BYTE _scancode)
{
  return (KEYDOWN(diks,_scancode )) ;
}

