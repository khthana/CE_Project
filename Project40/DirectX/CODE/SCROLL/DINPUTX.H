#ifndef _Bubble_DirectInput_
#define _Bubble_DirectInput_

//#include <windows.h>
//#include <windowsx.h>
#include <dinput.h>

class CBubbleDI
{
private:
HRESULT					init_value;	// initial DirectInput last result
LPDIRECTINPUT           lpDI;		//DriectInput Object
LPDIRECTINPUTDEVICE     lpKeyboard;//Keyborad Object
BYTE					diks[256];  //keyboard state buffer
public:
  CBubbleDI(HWND _hwnd ,HINSTANCE _hInstance );
 ~CBubbleDI(void);
	BOOL init_success(void);	// question is init DirectInput success
	BOOL updateKeyStatus(void);
	BOOL keyStatus(BYTE scancode);
};

#endif


