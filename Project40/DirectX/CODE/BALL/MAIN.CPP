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

CDXScreen* Screen; // The screen object
CDXInput Input; // The input device object
CDXMusic* Music; //The midi object
CDXSound* Sound;   //The wave object
CDXSoundBuffer* BallCreateSound; //sound buffer
// The sprite bitmaps
CDXTile* Ball;

CDXSpriteList Sprites; // The sprite list object

BOOL bActive = TRUE; // Is the program running?

// Frame rate counters
DWORD LastTime = 0;
DWORD CurTime = 0;
DWORD FpsTime = 0;
DWORD DeltaTime = 0;
DWORD FramesRendered = 0;
DWORD Fps = 0;
DWORD BallCount = 0;
// Resource bitmap files
char BALL[] = "ball.bmp";
char MUSIC[] = "music.mid";
char SOUND[] = "sound.wav";
/////////////////////////////////////////////////////////////////////////////////////////////
// UpdateSprites
/////////////////////////////////////////////////////////////////////////////////////////////
void UpdateSprites(void)
{
	CDXSprite* Node;
	CDXSprite* Save;

	// Loop the list and update the sprites
	for(Node = Sprites.Next(); Node != Sprites.List(); Node = Save)
	{
		Save = Node->m_Next;

		Node->m_PosX += Node->m_VelX;
		Node->m_PosY += Node->m_VelY;

		if(Node->m_PosX < 0)
		{
			Node->m_VelX -= (2 * Node->m_VelX);
			Node->m_PosX = 1;
			Node->SetFrame(rand()%11);
		}
		if(Node->m_PosX > (640 - Node->m_Tile->m_BlockWidth))
		{
			Node->m_VelX -= (2 * Node->m_VelX);
			Node->m_PosX = (639 - Node->m_Tile->m_BlockWidth);
			Node->SetFrame(rand()%11);
		}
		if(Node->m_PosY < 0)
		{
			Node->m_VelY -= (2 * Node->m_VelY);
			Node->m_PosY = 1;
			Node->SetFrame(rand()%11);
		}
		if(Node->m_PosY > (480 - Node->m_Tile->m_BlockHeight))
		{
			Node->m_VelY -= (2 * Node->m_VelY);
			Node->m_PosY = (479 - Node->m_Tile->m_BlockHeight);
			Node->SetFrame(rand()%11);
		}
	}
}

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
		WS_EX_TOPMOST,
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
	Screen->LoadPalette(BALL);

	// Create the input devices
	Input.Create(hInst, hWnd);

	// Load the bitmaps
	Ball     = new CDXTile(Screen, BALL, 25, 25, 12);
	;

	// Set the bitmap transparent color
	Ball->ColorKey(0);
		
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
	BallCreateSound = new CDXSoundBuffer;
	BallCreateSound->Load(Sound,SOUND,4);

	return TRUE;
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
		if(PeekMessage(&msg, NULL, 0, 0, PM_NOREMOVE))
		{
			if(!GetMessage(&msg, NULL, 0, 0 )) return msg.wParam;
			TranslateMessage(&msg); 
			DispatchMessage(&msg);
		}
		else if(bActive)
		{
			// Update the input device states
			Input.Update();

			// Check for keyboard input
			if(Input.Keys[DIK_INSERT])
			{
				BallCreateSound->Play();
				BallCount++;
				int PosX = rand()%556;
				int PosY = rand()%400;
				int VelX = rand()%3 +1;
				int VelY = rand()%3 +1;
			Sprites.AddSprite(Ball,0,PosX,PosY,VelX,VelY,0,0,0);
			}
			if(Input.Keys[DIK_DELETE]) 
			{
				if(BallCount > 0)
				{
					BallCount--;
					Sprites.DelSprite(Sprites.Next());
				}
			}
			
			// Loop the sprite list and update the sprites
			UpdateSprites();

			// Clear the back buffer
			Screen->Fill(0);

			// Draw all the sprites in the list
			Sprites.DrawTrans(Screen->GetBack());

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
			
			char str2[14];
			sprintf(str2,"BALLS: %d", BallCount);

			// Print the frame rate to the screen
			Screen->GetBack()->GetDC();
			Screen->GetBack()->SetFont();
			Screen->GetBack()->TextXY(5, 5, 255, str);
			Screen->GetBack()->TextXY(5, 20, 255, "INSERT - ADD SPRITE");
			Screen->GetBack()->TextXY(5, 35, 255, "DELETE - DEL SPRITE");
			Screen->GetBack()->TextXY(5, 50, 255, str2);
			Screen->GetBack()->ReleaseDC();

			// Display the back buffer
			Screen->Flip();
		}
		else WaitMessage();
	}
}
