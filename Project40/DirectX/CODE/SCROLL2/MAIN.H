#ifndef _MAIN_H_
#define _MAIN_H_



#include <windows.h>
#include <windowsx.h>
#include <ddraw.h>
#include <dinput.h>

#include "dinputx.h"
#include "ddrawx.h"
#define NAME "xoom"
#define TITLE "xoom Project return"
typedef struct _DDraw
{

BOOL			bActive;	// is application active?
CBubbleDI				*keyx;
CBubbleDD				*displayx;
HWND					hwnd;
HINSTANCE	g_hinst;


} GDXStruct,*LPGDX;

#endif