#ifndef _Bubble_Control_
#define _Bubble_Control_

#if defined __TURBOC__
	#include <stdio.h>
	#include <conio.h>
	#include <stdlib.h>
	#include <time.h>
	#include <string.h>
	#include <dos.h>
	#include "usr_type.h"		// user define data type
#elif defined _WIN32
	#include <windows.h>
	#include <windowsx.h>
	#include <mmsystem.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <time.h>
	#include <string.h>
	#include "usr_type.h"		// user define data type

	#define useDD	5		// use DirectDraw
	#define useDI	5		// use DirectInput
	#define useDS	5		// use DirectSound
//	#define useDP	5		// use DirectPlay

#endif

#endif
