#ifndef _Bubble_DirectInput_
#define _Bubble_DirectInput_

#include <windows.h>
#include <windowsx.h>
#include <dinput.h>

class CBubbleDI
{
private:
	LPDIRECTINPUT		lpDI;		//DriectInput Object
	LPDIRECTINPUTDEVICE lpKeyboard;	//Keyborad Object

	HRESULT	init_value;	// initial DirectInput last result

	BYTE diks[256];  //keyboard state buffer

	void init_var();	// initial all variable before use

	void DestroyDI();	// Destroy all DirectInput relate

public:
	CBubbleDI(HINSTANCE _hInstance, HWND _hwnd);
	~CBubbleDI(void);

	BOOL InitSuccess(void);	// question is init DirectInput success

	BOOL UpdateKeyStatus(void);
	BOOL KeyStatus(BYTE _scancode);
};

#endif


