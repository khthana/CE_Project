#ifndef _Bubble_DirectInput_
#define _Bubble_DirectInput_

#define	KEY_RIGHT	0X01
#define	KEY_LEFT	0X02
#define	KEY_DOWN	0X04
#define	KEY_UP		0X08
#define	KEY_A		0X10
#define	KEY_B		0X20
#define	KEY_C		0X40
#define	KEY_D		0X80

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
LPDIRECTINPUTDEVICE2    lpJoyStickX;//Joystick Object
BYTE					dijs;
//DIJOYSTATE				js	;		//Joystick state buffer
public:
  CBubbleDI(HWND _hwnd ,HINSTANCE _hInstance );
 ~CBubbleDI(void);
	BOOL init_success(void);	// question is init DirectInput success
	BOOL updateKeyStatus(void);
	BOOL updateJoyStatus(void);
	BOOL keyStatus(BYTE scancode);
	BOOL joyStatus(BYTE press);
};

#endif


