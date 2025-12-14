#include <dinput.h>
#define KEYDOWN(name,key) (name[key] & 0x80) 
extern    BYTE diks[256];	/* DirectInput keyboard state buffer */

extern HINSTANCE	g_hinst;


extern LPDIRECTINPUT           g_pdi;
extern LPDIRECTINPUTDEVICE     g_pKeyboard;
extern HWND					g_hwnd;

BOOL initDInputx(void)
{

    HRESULT	ddrval;
/*
/initial direct input
*/
	//create dinput object
	ddrval = DirectInputCreate(g_hinst,0x0300, &g_pdi, NULL);
	if( ddrval != DI_OK ){
	return FALSE;
    }

	//create device
	ddrval = g_pdi->CreateDevice(GUID_SysKeyboard, &g_pKeyboard, NULL);
	if( ddrval != DI_OK ){
	return FALSE;
    }

	//set date format 
	ddrval = g_pKeyboard->SetDataFormat(&c_dfDIKeyboard);
	if( ddrval != DI_OK ){
	return FALSE;
    }

	//set coperative level
	ddrval = g_pKeyboard->SetCooperativeLevel(g_hwnd,
                                DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
	if( ddrval != DI_OK ){
	return FALSE;
    }


	if (g_pKeyboard) {
		g_pKeyboard->Acquire(); 
	}
return TRUE;
}//initDInputx


BOOL updateKeyStatus(void)
{
	HRESULT hr;

	if (g_pKeyboard != NULL) {
    again:;
        hr = g_pKeyboard->GetDeviceState(sizeof(diks), &diks);
      if (hr == DIERR_INPUTLOST) {
 			hr = g_pKeyboard->Acquire();
            if (SUCCEEDED(hr)) {
                goto again;
            }//if (successd)
        }//if (hr)

	}//if (g_pKeyboard)
	
	//------------
		
	if (SUCCEEDED(hr)) {		//now I have data of key
/*
		if (KEYDOWN(diks, DIK_ESCAPE )){			//exit windows
		  PostMessage(g_hwnd, WM_CLOSE, 0, 0);
		}//if ..exit

		//up or down
		if(KEYDOWN(diks,DIK_UP )) {
		ypos=decreasex(ypos,0);
		
		}
			else
			{
		
				if(KEYDOWN(diks,DIK_DOWN )){
				ypos=increasex(ypos,410);
				}
			}
		
		//-----
		//left or right
		if(KEYDOWN(diks,DIK_LEFT )) {
		xpos=decreasex(xpos,0);
		}
			else
			{
				if(KEYDOWN(diks,DIK_RIGHT )){
				xpos=increasex(xpos,570);
				}
			}
*/
		return TRUE;		
	}//if (SCCCESSED(hr))
return FALSE;
}

BOOL keyStatus(BYTE scancode)
{
  return (KEYDOWN(diks,scancode )) ;
}