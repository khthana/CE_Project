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
		lpKeyboard->Release();
		return;
    }

	//set coperative level
	init_value = lpKeyboard->SetCooperativeLevel(_hwnd,
                                DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
	if( init_value  != DI_OK ){
		lpKeyboard->Release();
		return ;
    }

	if (lpKeyboard) {
		lpKeyboard->Acquire(); 
	}
		//in this line you success for create keyboard
	lpDI->Release(); //FREE IT FOR USE JOY
        lpDI = NULL;
	
///now we try to use joystick
LPDIRECTINPUTDEVICE lpJoyStick;
	init_value  = DirectInputCreate(_hInstance,DIRECTINPUT_VERSION, &lpDI, NULL);
	if( init_value != DI_OK ){
	return;
    }
	//create device
	init_value  =  lpDI->CreateDevice(GUID_Joystick, &lpJoyStick, NULL);
	if(init_value!= DI_OK ){
	return ;
    }

	//set date format 
	init_value = lpJoyStick->SetDataFormat(&c_dfDIJoystick);
	if(init_value!= DI_OK ){
	lpJoyStick->Release();
		return;
    }

	//set coperative level
	init_value = lpJoyStick->SetCooperativeLevel(_hwnd,
                                DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
	if( init_value  != DI_OK ){
	lpJoyStick->Release();
		return ;
    }
   // set X-axis range to (-1000 ... +1000)
   // This lets us test against 0 to see which way the stick is pointed.
 DIPROPRANGE diprg;
   diprg.diph.dwSize       = sizeof(diprg);
   diprg.diph.dwHeaderSize = sizeof(diprg.diph);
   diprg.diph.dwObj        = DIJOFS_X;
   diprg.diph.dwHow        = DIPH_BYOFFSET;
   diprg.lMin              = -1000;
   diprg.lMax              = +1000;

   init_value=lpJoyStick->SetProperty(DIPROP_RANGE, &diprg.diph);
   if(init_value != DI_OK)
   {
      OutputDebugString("IDirectInputDevice::SetProperty(DIPH_RANGE) FAILED\n");
      lpJoyStick->Release();
      return ;
   }
 // Y Axis
   diprg.diph.dwObj        = DIJOFS_Y;
   
   init_value = lpJoyStick->SetProperty(DIPROP_RANGE, &diprg.diph);
   if( init_value != DI_OK)
   {
      OutputDebugString("IDirectInputDevice::SetProperty(DIPH_RANGE) FAILED\n");
      lpJoyStick->Release();
      return ;
   }


   // set X axis dead zone to 50% (to avoid accidental turning)
   // Units are ten thousandths, so 50% = 5000/10000.
   DIPROPDWORD dipdw;
   dipdw.diph.dwSize       = sizeof(dipdw);
   dipdw.diph.dwHeaderSize = sizeof(dipdw.diph);
   dipdw.diph.dwObj        = DIJOFS_X;
   dipdw.diph.dwHow        = DIPH_BYOFFSET;
   dipdw.dwData            = 5000;
   init_value=lpJoyStick->SetProperty(DIPROP_DEADZONE, &dipdw.diph) ;
   if(init_value!= DI_OK)
   {
      OutputDebugString("IDirectInputDevice::SetProperty(DIPH_DEADZONE) FAILED\n");
      lpJoyStick->Release();
      return ;
   }
	// Y Axis
	dipdw.diph.dwObj        = DIJOFS_Y;
   
	init_value = lpJoyStick->SetProperty(DIPROP_DEADZONE, &dipdw.diph) ;
	if(init_value!= DI_OK)
   {
      OutputDebugString("IDirectInputDevice::SetProperty(DIPH_DEADZONE) FAILED\n");
      lpJoyStick->Release();
      return ;
   }

      /*
         *  Convert it to a Device2 so we can Poll() it.
         */



   init_value = lpJoyStick->QueryInterface(IID_IDirectInputDevice2,(LPVOID *)&lpJoyStickX);
	if (!SUCCEEDED(init_value)) 
	{
      OutputDebugString("IDirectInputDevice::QueryInterface FAILED\n");
      lpJoyStick->Release();
      return;
	}
	lpJoyStick->Release();
	lpDI->Release(); //Finish Joy
    lpDI = NULL;	
	//finish joy use object lpJoyStickX

	if (lpJoyStickX) {
		lpJoyStick->Acquire(); 
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
CBubbleDI::updateJoyStatus(void)
{
	DIJOYSTATE			js	;
	init_value = lpJoyStickX->Poll();
	init_value = lpJoyStickX->GetDeviceState(sizeof(DIJOYSTATE),&js);
	if (init_value != DI_OK) 
	{ 
		  // did the read fail because we lost input for some reason? 

		  // if so, then attempt to reacquire. If the second acquire 
		  // fails, then the error from GetDeviceData will be 
		  // DIERR_NOTACQUIRED, so we won't get stuck an infinite loop. 
		if(init_value == DIERR_INPUTLOST) 
		{     //ReacquireInput(); 
			if (lpJoyStickX) 
			{ 
			// acquire the device 
			init_value = lpJoyStickX->Acquire();
       
				if (SUCCEEDED(init_value)) 
				{ 
				// acquisition successful 
					return FALSE; 
				} 
					else 
					{ 
					  // acquisition failed 

					  return FALSE; 
					} 
			} else 
				{ 
				// we don't have a current device 
					return FALSE; 
				} 
		  // return the fact that we did not read any data 
		  return FALSE; 
		} 
		return FALSE;
	}
	
	dijs=0;//clear joy state
		if(js.lX < 0)
			dijs|=KEY_LEFT;
		else 
		{
			if (js.lX > 0)
				dijs|=KEY_RIGHT;
		}
		
		if (js.lY >0 )
			dijs|=KEY_UP;
		else
		{	
			if (js.lY <0 )
				dijs|=KEY_DOWN;
		}
		
		if (js.rgbButtons[0] & 0x80)
			dijs|=KEY_A;
		if (js.rgbButtons[1] & 0x80)
			dijs|=KEY_B;
		if (js.rgbButtons[2] & 0x80)
			dijs|=KEY_C;
		if (js.rgbButtons[3] & 0x80)
			dijs|=KEY_D;
	
	return TRUE;
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

BOOL CBubbleDI::joyStatus(BYTE press)
{
	return (press & dijs);
}