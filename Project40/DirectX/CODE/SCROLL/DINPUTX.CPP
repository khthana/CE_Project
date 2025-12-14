#include "dinputx.h"
#define KEYDOWN(name,key) (name[key] & 0x80) 
/**********************************************
*
* Constructor Initial DirectInput and use Keyboard
*
***********************************************/
CBubbleDI::CBubbleDI(HWND _hwnd ,HINSTANCE _hInstance )
{
	
	//create dinput object
	init_value  = DirectInputCreate(_hInstance,0x0300, &lpDI, NULL);
	if( init_value != DI_OK ){
	return;
    }

	//create device
	init_value  = lpDI->CreateDevice(GUID_SysKeyboard, &lpKeyboard, NULL);
	if(init_value!= DI_OK ){
	return ;
    }

	//set date format 
	init_value = lpKeyboard->SetDataFormat(&c_dfDIKeyboard);
	if(init_value!= DI_OK ){
	return;
    }

	//set coperative level
	init_value = lpKeyboard->SetCooperativeLevel(_hwnd,
                                DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
	if( init_value  != DI_OK ){
	return ;
    }

	if (lpKeyboard) {
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
    if (lpKeyboard) {
        /*
         *  Cleanliness is next to godliness.  Unacquire the device
         *  one last time just in case we got really confused and tried
         *  to exit while the device is still acquired.
         */
        lpKeyboard->Unacquire();

        lpKeyboard->Release();
        lpKeyboard = NULL;
    }//(g_pKeyboard)
    /*
     *  Destroy any lingering IDirectInput object.
     */
    if (lpDI) {
        lpDI->Release();
        lpDI = NULL;
    }
}
/******************************************************
*
*	updateKeyStatus  for update key in diks keyboard array
*
*****************************************************/
CBubbleDI::updateKeyStatus(void)
{
	if (lpKeyboard != NULL) {
    again:;
        init_value = lpKeyboard->GetDeviceState(sizeof(diks), &diks);
      if (init_value == DIERR_INPUTLOST) {
 			init_value = lpKeyboard->Acquire();
            if (SUCCEEDED(init_value )) {
                goto again;
            }//if (successd)
        }//if (hr)

	}//if (g_pKeyboard)
	if (SUCCEEDED(init_value)) {		//now I have data of key
		return TRUE;		
	}//if (SCCCESSED(hr))
return FALSE;
}
/*******************************************************
*
*	init_success told me that Dinput success  ?
*
*******************************************************/
BOOL CBubbleDI::init_success(void)
{
	return init_value == DI_OK ? TRUE : FALSE;
}
/*******************************************************
*
*	keyStatus told me that this key was press ?
*
*******************************************************/

BOOL CBubbleDI::keyStatus(BYTE scancode)
{
  return (KEYDOWN(diks,scancode )) ;
}

