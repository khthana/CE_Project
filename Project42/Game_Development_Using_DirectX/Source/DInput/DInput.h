///////////////////////////////////////////////////////////
//Project Name:	Game developent using DirectX(DirectInput)
//Author:		Tawin Tusnajareon azzuri_man@hotmail.com
//Source File:	Header file 
//version 1.0
///////////////////////////////////////////////////////////
#ifndef DInput
#define DInput


#include <dinput.h>

//for release obj. //
#define RELEASE(x) if (x != NULL) {x->Release(); x = NULL;}

///////////////////////////////////////////////////////////
//CInput class
///////////////////////////////////////////////////////////
class CInput
{
public:
	CInput(void);
	~CInput(void);

	HRESULT CreateInput(void *hinst);
	//pass lpdi to other
	LPDIRECTINPUT GetDI(void) {return lpdi;}


public:
	LPDIRECTINPUT lpdi;
};

///////////////////////////////////////////////////////////
//CDevice class
///////////////////////////////////////////////////////////
class CDevice
{
public:
	CDevice(void);
	~CDevice(void);

	HRESULT Create(CInput*, REFGUID);
	HRESULT SetDataFormat(LPCDIDATAFORMAT);
	HRESULT SetCooperativeLevel(void*, DWORD);
	HRESULT RunControlPanel(void*);
	HRESULT Acquire(void);
	HRESULT Unacquire(void);
	HRESULT SetRelative(void);
	HRESULT SetAbsolute(void);

public:
	LPDIRECTINPUTDEVICE2 lpdi2;
	BOOL m_bActive;
};

///////////////////////////////////////////////////////////
//CKeyboard class
///////////////////////////////////////////////////////////
class CKeyboard : public CDevice
{
public:
	CKeyboard(void);
	~CKeyboard(void);

	HRESULT CreateKeyboard(CInput*, void*);
	void GetState(void);

public:
	BYTE keyboard_state[256];
};

///////////////////////////////////////////////////////////
//CMouse class
///////////////////////////////////////////////////////////
class CMouse : public CDevice
{
public:
	CMouse(void);
	~CMouse(void);

	HRESULT CreateMouse(CInput*, void*);
	void GetState(void);
	LONG GetX(void) {return m_X;}//return x-position mouse
	LONG GetY(void) {return m_Y;}//return y-positon mouse
	LONG GetZ(void) {return m_Z;}//returnn z-position mouse(wheel)
	BYTE GetLB(void) {return m_Buttons[0];}//return left button
	BYTE GetRB(void) {return m_Buttons[1];}//retrun right button
	BYTE GetMB(void) {return m_Buttons[2];}//return middle button

public:
	LONG m_X,m_Y,m_Z;
	BYTE m_Buttons[4];
};


///////////////////////////////////////////////////////////
//CJoystick class
///////////////////////////////////////////////////////////
class CJoystick : public CDevice
{
public:
	CJoystick(void);
	~CJoystick(void);

	HRESULT CreateJoystick(CInput*, void*);
	void GetState(void);

	LONG GetX(void) {return m_X;}//return x-position joy
	LONG GetY(void) {return m_Y;}//reyurn y-position joy
	LONG GetZ(void) {return m_Z;}//return z-position joy
	BYTE GetB1(void) {return m_Buttons[0];}//return button1
	BYTE GetB2(void) {return m_Buttons[1];}//return button2
	BYTE GetB3(void) {return m_Buttons[2];}//return button3
	BYTE GetB4(void) {return m_Buttons[3];}//return button4

public:
	LONG m_X,m_Y,m_Z;
	BYTE m_Buttons[32];
};

#endif