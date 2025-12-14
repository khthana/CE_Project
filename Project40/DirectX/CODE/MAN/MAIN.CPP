/////////////////////////////////////////////////////////////////////////////////////////////
// CDX example 5 - Sprite lists, resources and timing
// You must link to cdx.lib, ddraw.lib, dinput, dxguid and winmm.lib
/////////////////////////////////////////////////////////////////////////////////////////////
#include <windows.h>
#include <windowsx.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <CDX.h>

#define STAND			0
#define STAND_WALK		8
#define STAND_PUNCH		16
#define STAND_KICK		20

#define SIT				1
#define SIT_PUNCH		24
#define SIT_KICK		26

#define JUMP			2
#define	JUMP_WALK		3
#define JUMP_PUNCH		29
#define JUMP_KICK		31

#define JUMP_WALK_PUNCH 4
#define JUMP_WALK_KICK  5

#define MAN_VELX		7
#define MAN_VELY		4
#define MAN_DELAY		5
#define	JUMP_DELAY		20
#define JUMP_VELX		3
#define JUMP_VELY		4
#define WALK_DELAY		7

#define WALK_FRAME_END			16
#define STAND_PUNCH_FRAME_END	19
#define STAND_KICK_FRAME_END	24
#define SIT_PUNCH_FRAME_END		26
#define SIT_KICK_FRAME_END		28


CDXScreen* Screen; // The screen object
CDXInput Input; // The input device object
CDXMusic* Music; //The midi object
CDXSound* Sound;   //The wave object
//CDXSoundBuffer* BallCreateSound; //sound buffer
// The sprite bitmaps
CDXSprite* Man;

BOOL bActive = TRUE; // Is the program running?

// Frame rate counters
DWORD LastTime = 0;
DWORD CurTime = 0;
DWORD FpsTime = 0;
DWORD DeltaTime = 0;
DWORD FramesRendered = 0;
DWORD Fps = 0;
DWORD ManAct = 0;
// Resource bitmap files
char MAN[] = "man.bmp";
char MUSIC[] = "music.mid";
char PUNCH[] = "punch.wav";

/////////////////////////////////////////////////////////////////////////////////////////////
// WinProc - Handle Windows messages
/////////////////////////////////////////////////////////////////////////////////////////////
long PASCAL WinProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch(message)
	{
		case WM_ACTIVATEAPP:
      bActive = wParam;
			break;

		case WM_KEYDOWN:
			switch(wParam)
			{
				case VK_ESCAPE:
					Music->Stop();
//					delete Music;
//					delete Sound;
//					delete Screen;
					Screen->GetBack()->ReleaseDC();
					PostMessage(hWnd, WM_CLOSE, 0, 0);
				break;
			}
		break;

		case WM_DESTROY:
			PostQuitMessage(0);
		break;
	}

	return DefWindowProc(hWnd, message, wParam, lParam);
}

/////////////////////////////////////////////////////////////////////////////////////////////
// InitApp - Create the window and the CDX objects
/////////////////////////////////////////////////////////////////////////////////////////////
BOOL InitApp(HINSTANCE hInst, int nCmdShow)
{
	HWND hWnd;
	WNDCLASS WndClass;

	WndClass.style = CS_DBLCLKS;
	WndClass.lpfnWndProc = WinProc;
	WndClass.cbClsExtra = 0;
	WndClass.cbWndExtra = 0;
	WndClass.hInstance = hInst;
	WndClass.hIcon = LoadIcon(0, IDI_APPLICATION);
	WndClass.hCursor = LoadCursor(0, IDC_ARROW);
	WndClass.hbrBackground = GetStockObject(BLACK_BRUSH);
	WndClass.lpszMenuName = 0;
	WndClass.lpszClassName = "Example 5";
	RegisterClass(&WndClass);

	hWnd = CreateWindowEx(
         WS_EX_APPWINDOW,
		//WS_EX_TOPMOST,
		"Example 5",
		"Example 5",
		WS_POPUP,
		0,0,
		GetSystemMetrics(SM_CXSCREEN),
		GetSystemMetrics(SM_CYSCREEN),
		NULL,
		NULL,
		hInst,
		NULL);

	if(!hWnd) return FALSE;

	ShowWindow(hWnd, nCmdShow);
	UpdateWindow(hWnd);

	// Create the CDXScreen object
	Screen = new CDXScreen();
	Screen->CreateFullScreen(hWnd, 640, 480, 8);
	Screen->LoadPalette(MAN);

	// Create the input devices
	Input.Create(hInst, hWnd);

	// Load the bitmaps
	Man     = new CDXSprite(Screen, MAN, 60, 90, 64);
	Man->SetPos(300,300);
	Man->SetVel(MAN_VELX,0);
	Man->SetDelay(MAN_DELAY);
	Man->SetState(STAND);
	Man->SetFrame(STAND);
	// Set the bitmap transparent color
	Man->ColorKey(0);
		
	// Seed the random-number generator with current time
	srand((unsigned)time(NULL));

	// Change the default font
	Screen->GetBack()->ChangeFont("Comic Sans MS", 0, 18);
	
	// init midi
	Music = new CDXMusic(hWnd);
	Music->Play(MUSIC);
	
	//init wave sound object
	Sound = new CDXSound;
	Sound->Create(hWnd);
	//load sound
//	BallCreateSound = new CDXSoundBuffer;
//	BallCreateSound->Load(Sound,SOUND,4);

	return TRUE;
}


/*------------------------------Design for UpdateManAct --------------------------------*/
void Continue_Jump_Walk(void)
{
	Man->m_Delay--;
	if(Man->m_Delay==0)//peek to peek
	{
		if(Man->m_VelY < 0)//up peek
		{
			Man->SetDelay(JUMP_DELAY);
			Man->m_VelY=MAN_VELY;
		}else			//down peek
		{
			Man->SetState(STAND);
			Man->SetFrame(STAND);
			Man->m_VelY=0;
		}
	}else
	{
		Man->m_PosY +=Man->m_VelY;

		Man->m_PosX +=Man->m_VelX;
	if( (Man->m_PosX+Man->m_Tile->m_BlockWidth) > Screen->GetWidth())
		Man->SetPos(Screen->GetWidth()-Man->m_Tile->m_BlockWidth,Man->m_PosY);
	if( Man->m_PosX <0)
		Man->SetPos(0,Man->m_PosY);
	}
}

void Continue_Jump(void)
{
	if(--Man->m_Delay==0)//peek to peek
	{
		if(Man->m_VelY < 0)//up peek
		{
			Man->SetDelay(JUMP_DELAY);
			Man->m_VelY=MAN_VELY;
		}else			//down peek
		{
			Man->SetState(STAND);
			Man->SetFrame(STAND);
			Man->m_VelY=0;
		}
	}else
	{
		Man->m_PosY +=Man->m_VelY;
	}
}
void Continue_Stand_Walk(void)
{
	if(--Man->m_Delay >0)
		return;
	Man->m_Delay= WALK_DELAY;
	
	Man->m_Frame++;
	if(Man->m_Frame >= WALK_FRAME_END)
		Man->SetFrame(STAND_WALK);
	
	Man->m_PosX +=Man->m_VelX;
	if( (Man->m_PosX+Man->m_Tile->m_BlockWidth) > Screen->GetWidth())
		Man->SetPos(Screen->GetWidth()-Man->m_Tile->m_BlockWidth,Man->m_PosY);
	if( Man->m_PosX <0)
		Man->SetPos(0,Man->m_PosY);
}
void Continue_Stand_Punch(void)
{
	if(--Man->m_Delay>0)
		return;
	Man->m_Delay= WALK_DELAY;
	Man->m_Frame++;
	if(Man->m_Frame >= STAND_PUNCH_FRAME_END)
	{
		Man->SetDelay(MAN_DELAY);
		Man->SetState(STAND);
		Man->SetFrame(STAND);
	}
		
}
void Continue_Stand_Kick(void)
{
	if(--Man->m_Delay >0)
		return;
	Man->m_Delay= WALK_DELAY;
	Man->m_Frame++;
	if(Man->m_Frame >= STAND_KICK_FRAME_END)
	{
		Man->SetDelay(MAN_DELAY);
		Man->SetState(STAND);
		Man->SetFrame(STAND);
	}
}
void Continue_Sit_Punch(void)
{
	if(--Man->m_Delay >0)
		return;
	Man->m_Delay= WALK_DELAY;
	Man->m_Frame++;
	if(Man->m_Frame >= SIT_PUNCH_FRAME_END)
	{
		Man->SetDelay(MAN_DELAY);
		Man->SetState(SIT);
		Man->SetFrame(SIT);
	}
}
void Continue_Sit_Kick(void)
{
	if(--Man->m_Delay >0)
		return;
	Man->m_Delay= WALK_DELAY;
	Man->m_Frame++;
	if(Man->m_Frame >= SIT_KICK_FRAME_END)
	{
		Man->SetDelay(MAN_DELAY);
		Man->SetState(SIT);
		Man->SetFrame(SIT);
	}
}
void Continue_Jump_Punch(void)
{
	if((--Man->m_Delay)==0)//peek to peek
	{
		Man->m_Delay=0;//solve delay bug by if
		if(Man->m_VelY < 0)//up peek
		{
			Man->SetDelay(JUMP_DELAY);
			Man->m_VelY=MAN_VELY;
		}else			//down peek
		{
			Man->SetState(STAND);
			Man->SetFrame(STAND);
			Man->m_VelY=0;
		}
	}else
	{
		Man->m_PosY +=Man->m_VelY;
	}
}
void Continue_Jump_Kick(void)
{
	if((--Man->m_Delay)==0)//peek to peek
	{
		if(Man->m_VelY < 0)//up peek
		{
			Man->SetDelay(JUMP_DELAY);
			Man->m_VelY=MAN_VELY;
		}else			//down peek
		{
			Man->SetState(STAND);
			Man->SetFrame(STAND);
			Man->m_VelY=0;
		}
	}else
	{
		Man->m_PosY +=Man->m_VelY;
	}
}

void Continue_Jump_Walk_Punch()
{
	Continue_Jump_Walk();
}
void Continue_Jump_Walk_Kick()
{
	Continue_Jump_Walk();
}
/////////////////////////////////////////////////////////////////////////////////////////////
// UpdateManAct() - up date action by read key
/////////////////////////////////////////////////////////////////////////////////////////////
void UpdateManAct(void)
{
	Input.Update();
	if(Input.Keys[DIK_LALT])				//right ALT
	{
		switch( Man->m_State)
		{
		case STAND:		//*stand
			Man->SetFrame(STAND_PUNCH);
			Man->SetState(STAND_PUNCH);
			Man->SetDelay(WALK_DELAY);
				break;
		case STAND_PUNCH:
			Continue_Stand_Punch();
				break;
		case STAND_KICK:
			Continue_Stand_Kick();
				break;
		case STAND_WALK:
			Continue_Stand_Walk();
				break;
		case SIT:		//*sit
			Man->SetFrame(SIT_PUNCH);
			Man->SetState(SIT_PUNCH);
			Man->SetDelay(WALK_DELAY);
				break;
		case SIT_PUNCH:
			Continue_Sit_Punch();
				break;
		case SIT_KICK:
			Continue_Sit_Kick();
				break;
		case JUMP:		//*jump
			Man->SetFrame(JUMP_PUNCH);
			Man->SetState(JUMP_PUNCH);
				break;
		case JUMP_PUNCH:
			Continue_Jump_Punch();
				break;
		case JUMP_KICK:
			Continue_Jump_Kick();
				break;
		case JUMP_WALK:
			Man->SetFrame(JUMP_WALK_PUNCH);
			Man->SetState(JUMP_WALK_PUNCH);
				break;
		case JUMP_WALK_PUNCH:
			Continue_Jump_Walk();
				break;
		case JUMP_WALK_KICK:
			Continue_Jump_Walk();
				break;		
		}return;
	}//else
	if(Input.Keys[DIK_LCONTROL])					//left Ctrl
	{
		switch( Man->m_State)
		{
		case STAND:		//*stand
			Man->SetFrame(STAND_KICK);
			Man->SetState(STAND_KICK);
			Man->SetDelay(WALK_DELAY);
				break;
		case STAND_PUNCH:
			Continue_Stand_Punch();
				break;
		case STAND_KICK:
			Continue_Stand_Kick();
				break;
		case STAND_WALK:
			Continue_Stand_Walk();
				break;
		case SIT:		//*sit
			Man->SetFrame(SIT_KICK);
			Man->SetState(SIT_KICK);
			Man->SetDelay(WALK_DELAY);
				break;
		case SIT_PUNCH:
			Continue_Sit_Punch();
				break;
		case SIT_KICK:
			Continue_Sit_Kick();
				break;
		case JUMP:		//*jump
			Man->SetFrame(JUMP_KICK);
			Man->SetState(JUMP_KICK);
				break;
		case JUMP_PUNCH:
			Continue_Jump_Punch();
				break;
		case JUMP_KICK:
			Continue_Jump_Kick();
				break;
		case JUMP_WALK:
			Man->SetFrame(JUMP_WALK_KICK);
			Man->SetState(JUMP_WALK_KICK);
				break;
		case JUMP_WALK_PUNCH:
			Continue_Jump_Walk();
				break;
		case JUMP_WALK_KICK:
			Continue_Jump_Walk();
				break;		
		}return;
	}//else	
	
	
	if(Input.Keys[DIK_SPACE])					//SPACE
	{
		switch( Man->m_State)
		{
		case STAND:		//*stand
			Man->SetFrame(JUMP);
			Man->SetState(JUMP);
			Man->SetVel(Man->m_VelX,-(MAN_VELY));
			Man->SetDelay(JUMP_DELAY);
				break;
		case STAND_PUNCH:
			Continue_Stand_Punch();
				break;
		case STAND_KICK:
			Continue_Stand_Kick();
				break;
		case STAND_WALK:
			Man->SetFrame(JUMP_WALK);
			Man->SetState(JUMP_WALK);
			Man->SetDelay(JUMP_DELAY);
			if(Man->m_VelX>0)
				Man->SetVel(JUMP_VELX,-(MAN_VELY));
			else Man->SetVel(-JUMP_VELX,-(MAN_VELY));
				break;
		case SIT:		//*sit
				break;
		case SIT_PUNCH:
				break;
		case SIT_KICK:
				break;
		case JUMP:		//*jump
				Continue_Jump();
				break;
		case JUMP_PUNCH:
				Continue_Jump();			
				break;
		case JUMP_KICK:
				Continue_Jump();
				break;
		case JUMP_WALK:
				Continue_Jump_Walk();
				break;
		case JUMP_WALK_PUNCH:
			Continue_Jump_Walk();
				break;
		case JUMP_WALK_KICK:
			Continue_Jump_Walk();
				break;		
		}return;
	}//else

	if(Input.Keys[DIK_RIGHT])					//Right
	{
		switch( Man->m_State)
		{
		case STAND:		//*stand
			Man->SetFrame(STAND_WALK);
			Man->SetState(STAND_WALK);
			Man->SetDelay(WALK_DELAY);
			Man->SetVel(MAN_VELX,0);
				break;
		case STAND_PUNCH:
			Continue_Stand_Punch();
				break;
		case STAND_KICK:
			Continue_Stand_Kick();
				break;
		case STAND_WALK:
				if(Man->m_VelX<0)//left before
				{
					Man->SetFrame(STAND_WALK);
					Man->SetState(STAND_WALK);
					Man->SetDelay(WALK_DELAY);
					Man->SetVel(MAN_VELX,0);
				}else
					Continue_Stand_Walk();
				break;
		case SIT:		//*sit
				break;
		case SIT_PUNCH:
			Continue_Sit_Punch();
				break;
		case SIT_KICK:
			Continue_Sit_Kick();
				break;
		case JUMP:		//*jump
			Continue_Jump();	
				break;
		case JUMP_PUNCH:
			Continue_Jump_Punch();
				break;
		case JUMP_KICK:
			Continue_Jump_Kick();
				break;
		case JUMP_WALK:
				Continue_Jump_Walk();
				break;
		case JUMP_WALK_PUNCH:
			Continue_Jump_Walk();
				break;
		case JUMP_WALK_KICK:
			Continue_Jump_Walk();
				break;		
		}return;
	} //else
	if(Input.Keys[DIK_LEFT])					//Left
	{
		switch( Man->m_State)
		{
		case STAND:		//*stand
			Man->SetFrame(STAND_WALK);
			Man->SetState(STAND_WALK);
			Man->SetDelay(WALK_DELAY);
			Man->SetVel(-MAN_VELX,0);
				break;
		case STAND_PUNCH:
			Continue_Stand_Punch();
				break;
		case STAND_KICK:
			Continue_Stand_Kick();
				break;
		case STAND_WALK:
				if(Man->m_VelX>0)//Right before
				{
					Man->SetFrame(STAND_WALK);
					Man->SetState(STAND_WALK);
					Man->SetDelay(WALK_DELAY);
					Man->SetVel(-MAN_VELX,0);
				}else
					Continue_Stand_Walk();
				break;
		case SIT:		//*sit
				break;
		case SIT_PUNCH:
			Continue_Sit_Punch();
				break;
		case SIT_KICK:
			Continue_Sit_Kick();
				break;
		case JUMP:		//*jump
			Continue_Jump();	
				break;
		case JUMP_PUNCH:
			Continue_Jump_Punch();
				break;
		case JUMP_KICK:
			Continue_Jump_Kick();
				break;
		case JUMP_WALK:
				Continue_Jump_Walk();
				break;
		case JUMP_WALK_PUNCH:
			Continue_Jump_Walk();
				break;
		case JUMP_WALK_KICK:
			Continue_Jump_Walk();
				break;		
		}return;
	} //else


	if(Input.Keys[DIK_DOWN])					//Down
	{
		switch( Man->m_State)
		{
		case STAND:		//*stand
			Man->SetFrame(SIT);
			Man->SetState(SIT);
			Man->SetDelay(0);
				break;
		case STAND_PUNCH:
			Continue_Stand_Punch();
				break;
		case STAND_KICK:
			Continue_Stand_Kick();
				break;
		case STAND_WALK:
					Continue_Stand_Walk();
				break;
		case SIT:		//*sit
				break;
		case SIT_PUNCH:
			Continue_Sit_Punch();
				break;
		case SIT_KICK:
			Continue_Sit_Kick();
				break;
		case JUMP:		//*jump
			Continue_Jump();	
				break;
		case JUMP_PUNCH:
			Continue_Jump_Punch();
				break;
		case JUMP_KICK:
			Continue_Jump_Kick();
				break;
		case JUMP_WALK:
			Continue_Jump_Walk();
				break;
		case JUMP_WALK_PUNCH:
			Continue_Jump_Walk();
				break;
		case JUMP_WALK_KICK:
			Continue_Jump_Walk();
				break;		
		}return;
	} //else								//no key detect 
	switch(Man->m_State)
	{
	case STAND:		//*stand
			break;
	case STAND_PUNCH:
		Continue_Stand_Punch();
			break;
	case STAND_KICK:
		Continue_Stand_Kick();
			break;
	case STAND_WALK:
		Man->SetFrame(STAND);
		Man->SetState(STAND);
			break;
	case SIT:		//*sit
			Man->SetState(STAND);
			Man->SetFrame(STAND);
			Man->SetDelay(MAN_DELAY);
			break;
	case SIT_PUNCH:
		Continue_Sit_Punch();
			break;
	case SIT_KICK:
		Continue_Sit_Kick();	
			break;
	case JUMP:		//*jump
		Continue_Jump();
			break;
	case JUMP_PUNCH:
		Man->SetFrame(JUMP);
		Man->SetState(JUMP);
		Continue_Jump();
		break;
	case JUMP_KICK:
		Man->SetFrame(JUMP);
		Man->SetState(JUMP);
		Continue_Jump();
			break;
	case JUMP_WALK:
		Continue_Jump_Walk();
			break;
	case JUMP_WALK_PUNCH:
		Man->SetFrame(JUMP);
		Man->SetState(JUMP);
		Continue_Jump_Walk();
			break;
	case JUMP_WALK_KICK:
		Man->SetFrame(JUMP);
		Man->SetState(JUMP);
		Continue_Jump_Walk();
			break;			
	}
	return;
}

/////////////////////////////////////////////////////////////////////////////////////////////
// WinMain - The main program loop
/////////////////////////////////////////////////////////////////////////////////////////////
int PASCAL WinMain(HINSTANCE hInst, HINSTANCE hPrevInst, LPSTR lpCmdLine, int nCmdShow)
{
	MSG msg;

	if(!InitApp(hInst, nCmdShow)) return FALSE;
	while(1)
	{
		BOOL X = PeekMessage(&msg, NULL, 0, 0, PM_NOREMOVE);
		if(X)
		{
			if(!GetMessage(&msg, NULL, 0, 0 )) return msg.wParam;
			TranslateMessage(&msg); 
			DispatchMessage(&msg);
		}
		else if(bActive)
		{
			//update man action
			UpdateManAct();
			// Clear the back buffer
			Screen->Fill(0);
			// Draw man action 
			if (Man->m_VelX >0) //right
			{
				Man->DrawTrans(Screen->GetBack());
		
			}
			else
			{
				Man->m_Frame +=32; 				
				Man->DrawTrans(Screen->GetBack());
				Man->m_Frame -=32;
			}

			// Frame rate calculations
			CurTime   = timeGetTime();
			DeltaTime = CurTime - LastTime;
			LastTime  = CurTime;
			FpsTime  += DeltaTime;

			FramesRendered++;

			if (FpsTime > 1000)
			{
				Fps = FramesRendered;
				FramesRendered  = 0;
				FpsTime = 0;
			}

			char str[12];
			sprintf(str, "FPS: %d", Fps);
			
			char state[12];
			sprintf(state,"State: %d", Man->m_State);
			
			char delay[12];
			sprintf(delay,"Delay: %d", Man->m_Delay);

			char frame[12];
			sprintf(frame,"Frame: %d", Man->m_Frame);

			char velx[12];
			sprintf(velx,"Velx: %d", Man->m_VelX);

			char vely[12];
			sprintf(vely,"Vely: %d", Man->m_VelY);

			char posx[12];
			sprintf(posx,"Posx: %d", Man->m_PosX);

			char posy[12];
			sprintf(posy,"Posy: %d", Man->m_PosY);

			// Print the frame rate to the screen
			Screen->GetBack()->GetDC();
			Screen->GetBack()->SetFont();
			Screen->GetBack()->TextXY(5, 5, 255, str);
			Screen->GetBack()->TextXY(5, 20, 255,state);
			Screen->GetBack()->TextXY(5, 35, 255,delay);
			Screen->GetBack()->TextXY(5, 50, 255,frame);
			Screen->GetBack()->TextXY(5, 65, 255,velx);
			Screen->GetBack()->TextXY(5, 80, 255,vely);
			Screen->GetBack()->TextXY(5, 95, 255,posx);
			Screen->GetBack()->TextXY(5, 110, 255,posy);
			Screen->GetBack()->ReleaseDC();

			// Display the back buffer
//			Sleep(600);
			Screen->Flip();
		}
		else WaitMessage();
	}
}
