#include "string.h"
#include "bb_local.h"
#include "rules.h"

#if defined __TURBOC__
	#include "action_c.h"
#endif

#if defined _WIN32
	#define	MusicMIDI	"music.mid"

#ifndef useDD
	#include "action_c.h"

	#define CHAR_WIDTH	20
	#define CHAR_HEIGHT	20

	#define	CHAR_SHIFT_LEFT	1
	#define CHAR_SHIFT_TOP	5

	#define HALF_BLOCKWIDE	(CHAR_WIDTH/2)
	#define HALF_BLOCKHIGH	(CHAR_HEIGHT/2)

	#define	DISP_CHAR	"O"
#else
	#define HALF_BLOCKWIDE	(BLOCK_WIDE/2)
	#define HALF_BLOCKHIGH	(BLOCK_HIGH/2)
#endif

	#define TIME_WIN32_TICK_ELASPE	50	// millisec per frame

	#define DDWidth		640
	#define DDHeight	480
	#define DDBpp		8

	#define	BLOCK_SPLIT2		320

	#define	BLOCK_SHIFT_LEFT	15
	#define	BLOCK_SHIFT_TOP		55

	#define	BLOCK_NEXT			(2*BLOCK_SHIFT_LEFT+BLOCK_WIDE*HOME_USE_J)
#endif

#if defined __TURBOC__
/****************************************************************************
 *
 * draw_bar() // draw boader
 *
 ****************************************************************************/
void CBubbleLocal::draw_bar()
{
	int p, i,j;

	for( p = 0; p < play; p++ )
	{
		textattr(LIGHTGRAY);

		gotoxy(p*40+4,25);
		putch('À');

		for( j = 1; j <= HOME_USE_J*3; j++ )
			putch('Ä');

		putch('Ù');

		for( i = 1; i < 25; i++ )
		{
			gotoxy(p*40+4,i);
			putch('³');
			gotoxy(p*40+5+HOME_USE_J*3,i);
			putch('³');
		}
	}
}
#endif // no _WIN32

/****************************************************************************
 *
 * gen_next_color() // generate next color for home
 *
 ****************************************************************************/
ENUM_COLOR CBubbleLocal::gen_next_color()
{
#if defined __TURBOC__
	switch (random(MAX_CHAR_COLOR)+1)
#elif defined _WIN32
	switch ( (int)((float)rand()/(float)RAND_MAX*MAX_CHAR_COLOR)+1 )
#endif
	{
		case 1 : return EC_RED;
		case 2 : return EC_GREEN;
		case 3 : return EC_BLUE;
		case 4 : return EC_YELLOW;
		case 5 : return EC_MAGENTA;
		default: return EC_NONE;	// imposible to happen
	}
}

/****************************************************************************
 *
 * calculate_send_bomb(int _p) // calculate from bomb array
 *
 ****************************************************************************/
void CBubbleLocal::calculate_send_bomb(int _p)
{
	home[_p]->send_bomb += calculate_cont_bomb((home[_p]->home).count_bomb);

	memset((home[_p]->home).count_bomb,0,sizeof(CONT_BOMB));
}

/****************************************************************************
 *
 * send_bomb_to_other(int _p) // send bonus to other
 *
 ****************************************************************************/
void CBubbleLocal::send_bomb_to_other(int _p)
{
	if( player == EP_2ONE )
	{
		int op;

		op = _p == 0 ? 1 : 0;
		if( (home[_p]->home).recv_bomb )
		{
			if( (home[_p]->home).recv_bomb >= home[_p]->send_bomb )
			{
				(home[_p]->home).recv_bomb -= home[_p]->send_bomb;
			}
			else
			{
				home[_p]->send_bomb -= (home[_p]->home).recv_bomb;
				(home[_p]->home).recv_bomb = 0;
				(home[op]->home).recv_bomb += home[_p]->send_bomb;
			}

			home[_p]->send_bomb = 0;
		}
		else
		{
			(home[op]->home).recv_bomb += home[_p]->send_bomb;
			home[_p]->send_bomb = 0;
		}
	}
}

/****************************************************************************
 *
 * tick_local() // tick to only in local ( to world )
 *
 ****************************************************************************/
void CBubbleLocal::tick_local()
{
	if( world.get_status() != EW_RUNNING )
	{
		status = EL_PAUSE;

		return;
	}

	world.tick();

	for( int i = 0; i < play; i++ )
	{
		calculate_send_bomb(i);

		if( home[i]->send_bomb )
		{
			send_bomb_to_other(i);
		}

		if( (home[i]->home).want_act )
		{
			(home[i]->home).next_color[0] = gen_next_color();
			(home[i]->home).next_color[1] = gen_next_color();

			(home[i]->home).want_act = FALSE;
		}
	}
}

/****************************************************************************
 *
 * update_home_frame() // repaint frame of home - big screen
 *
 ****************************************************************************/
void CBubbleLocal::update_home_frame(int _pos, HOME_DAT *_home)
{
	if( _pos > 1 )	// allow only 2 homes
		return;

	int i,j;

#if defined __TURBOC__
	int c;
#elif defined _WIN32
#ifndef useDD
	char szBuff[10];
	char *psz;

	PAINTSTRUCT ps;
	HDC hdc = BeginPaint(hwnd, &ps);
	EndPaint(hwnd, &ps);
#else // useDD
	CHAR_BASE tmp_char;
#endif
#endif

	HOME_TABLE diff;

	// update receive bomb
	if( (_home->home).recv_bomb != _home->precv_bomb )
	{
		_home->precv_bomb = (_home->home).recv_bomb;
#if defined __TURBOC__
		textattr(WHITE);
		gotoxy(_pos*40+27,12);
		printf("R = %d ",(_home->home).recv_bomb);
#elif defined _WIN32
#ifndef useDD
		psz = szBuff;
		psz += wsprintf(psz,"R=%d_",(_home->home).recv_bomb);

		SetTextColor(hdc, 0);
		TextOut(hdc,
			_pos*BLOCK_SPLIT2+(HOME_TABLE_J)*CHAR_WIDTH,
			(5+CHAR_SHIFT_TOP)*CHAR_HEIGHT,
			szBuff, strlen(szBuff));
#else // useDD
		lpDD->BoomNum(
			_pos*BLOCK_SPLIT2+3*BLOCK_WIDE+BLOCK_SHIFT_LEFT, 
			(-1)*BLOCK_HIGH+BLOCK_SHIFT_TOP, 
			(_home->home).recv_bomb
		);
#endif
#endif
	}

	// sprite for next color
	if( memcmp(
			_home->prev_color,
			(_home->home).next_color,
			sizeof(_home->prev_color))
	)
	{
		memcpy(
			_home->prev_color,
			(_home->home).next_color,
			sizeof(_home->prev_color));

		for( i = 0; i < MAX_ACT_CHAR; i++ )
		{
#if defined __TURBOC__
			textattr((_home->home).next_color[i]);
			gotoxy(_pos*40+27,(1-i)*2+3);
			for( c = 0; c < 3; c++ )
				putch(disp_char[EA_NONE][c]);
			gotoxy(_pos*40+27,(1-i)*2+4);
			for( c = 3; c < 6; c++ )
				putch(disp_char[EA_NONE][c]);
#elif defined _WIN32
#ifndef useDD
			SetTextColor(hdc, RGB(
					text_color[(_home->home).next_color[i]][0],
					text_color[(_home->home).next_color[i]][1],
					text_color[(_home->home).next_color[i]][2])
			);
			TextOut(hdc,
				_pos*BLOCK_SPLIT2+(HOME_TABLE_J)*CHAR_WIDTH,
				(CHAR_SHIFT_TOP+(1-i))*CHAR_HEIGHT,
				DISP_CHAR, 1 );
#else // useDD
			tmp_char.species = (_home->home).next_color[i];
			tmp_char.action = EA_NONE;
			tmp_char.tick = 0;

			lpDD->Char2Buffer(
				_pos*BLOCK_SPLIT2+BLOCK_NEXT,
				BLOCK_SHIFT_TOP+BLOCK_HIGH*(1-i), 
				tmp_char
			);
#endif
#endif
		}
	}

#ifndef useDD
	// add actor to table
	if( (_home->home).act.pending )
	{
		for( i = 0; i < MAX_ACT_CHAR; i++ )
			if( (_home->home).act.pos[i].i >= 0 )
			{
				(_home->home).table
					[(_home->home).act.pos[i].i]
					[(_home->home).act.pos[i].j]
					= (_home->home).act.bubble[i];
			}
	}
#endif

	// sprite for table
	if( memcmp(
			_home->prev_table,
			(_home->home).table,
			sizeof(HOME_TABLE))
	)
	{
		memset(diff,0,sizeof(HOME_TABLE));
		for( i = 0; i < HOME_USE_I; i++ )
			for( j = 0; j < HOME_USE_J; j++ )
				if( ((_home->home).table[i][j].species !=
					_home->prev_table[i][j].species)||
					((_home->home).table[i][j].action !=
					_home->prev_table[i][j].action)
				)
				{
					diff[i][j] = (_home->home).table[i][j];
				}

		memcpy(
			_home->prev_table,
			(_home->home).table,
			sizeof(HOME_TABLE));

		for( i = 0; i < HOME_USE_I; i++ )
			for( j = 0; j < HOME_USE_J; j++ )
				if( diff[i][j].species != 0 )
				{
					if( diff[i][j].species == EC_NONE )
					{
#if defined __TURBOC__
						gotoxy(_pos*40+j*3+5,i*2+1);
						putch(' ');	putch(' '); putch(' ');
						gotoxy(_pos*40+j*3+5,i*2+2);
						putch(' ');	putch(' '); putch(' ');
#elif defined _WIN32
#ifndef useDD
						SetTextColor(hdc, RGB(255,255,255));
						TextOut(hdc,
							_pos*BLOCK_SPLIT2+(j+CHAR_SHIFT_LEFT)*CHAR_WIDTH,
							(i+CHAR_SHIFT_TOP)*CHAR_HEIGHT,
							DISP_CHAR, 1 );
#else // useDD
						lpDD->Char2Buffer(
							_pos*BLOCK_SPLIT2+j*BLOCK_WIDE+BLOCK_SHIFT_LEFT, 
							i*BLOCK_HIGH+BLOCK_SHIFT_TOP, 
							diff[i][j]
						);
#endif
#endif
					}
					else
					{
#if defined __TURBOC__
						textattr(diff[i][j].species);
						gotoxy(_pos*40+j*3+5,i*2+1);
						for( c = 0; c < 3; c++ )
							putch(disp_char
								[diff[i][j].action][c]
							);
						gotoxy(_pos*40+j*3+5,i*2+2);
						for( c = 3; c < 6; c++ )
							putch(disp_char
								[diff[i][j].action][c]
							);
#elif defined _WIN32
#ifndef useDD
						SetTextColor(hdc, RGB(
								text_color[diff[i][j].species][0],
								text_color[diff[i][j].species][1],
								text_color[diff[i][j].species][2])
						);
						TextOut(hdc,
							_pos*BLOCK_SPLIT2+(j+CHAR_SHIFT_LEFT)*CHAR_WIDTH,
							(i+CHAR_SHIFT_TOP)*CHAR_HEIGHT,
							DISP_CHAR, 1 );
#else // useDD
						lpDD->Char2Buffer(
							_pos*BLOCK_SPLIT2+j*BLOCK_WIDE+BLOCK_SHIFT_LEFT, 
							i*BLOCK_HIGH+BLOCK_SHIFT_TOP, 
							diff[i][j]
						);
#endif
#endif
					}
				}
	}
}

/****************************************************************************
 *
 * read_key() // read keyboard input from DirectInput
 *
 ****************************************************************************/
void CBubbleLocal::frame_home_local()
{
	if( world.get_status() != EW_RUNNING )
	{
		status = EL_PAUSE;

		return;
	}

	for( int i = 0; i < play; i++ )
	{
		update_home_frame(i, home[i]);
	}
}

#if defined _WIN32
#ifdef useDD
/****************************************************************************
 *
 * draw_back_actor() // draw actor to back buffer
 *
 ****************************************************************************/
void CBubbleLocal::draw_back_actor(int _pos, HOME_DAT_TO_LOCAL & _home)
{
	// draw actor
	if( _home.act.pending )
	{
		int i;
		BOOL can_half = TRUE;

		for( i = 0; i < MAX_ACT_CHAR; i++ )
			if( 
				(_home.act.pos[i].i >= 0)&&
				(
					(
						(_home.act.pos[i].i < HOME_USE_I-1)&&
						(_home.table[_home.act.pos[i].i+1][_home.act.pos[i].j]
							.species != EC_NONE)
					)
					||
					(
						(_home.act.pos[i].i == HOME_USE_I-1)
					)
				)
			)
			{
				can_half = FALSE;
			}


		for( i = 0; i < MAX_ACT_CHAR; i++ )
			if( _home.act.pos[i].i >= -1 ) // -1 show bottom half
			{
				int half = 0;

				switch (_home.act.action)
				{
				case EA_USRDOWN1:
					half = TIME_HALFDOWN1;
					break;

				case EA_USRDOWN2:
					half = TIME_HALFDOWN2;
					break;

				case EA_USRDOWN3:
					half = TIME_HALFDOWN3;
					break;
				}

				int addy = 0;

				if( can_half )
				{
					if( 
						(_home.act.pos[i].i < HOME_USE_I-1)&&
						(_home.table
							[_home.act.pos[i].i+1]
							[_home.act.pos[i].j]
							.species == EC_NONE)&&
						(_home.act.pending_time <= half)
					)
					{
						addy = HALF_BLOCKHIGH;
					}
				}

				lpDD->OnlyChar2Back(
					_pos*BLOCK_SPLIT2+_home.act.pos[i].j*BLOCK_WIDE+BLOCK_SHIFT_LEFT,
					_home.act.pos[i].i*BLOCK_HIGH+BLOCK_SHIFT_TOP + addy, 
					BLOCK_SHIFT_TOP,
					_home.act.bubble[i]
				);
			}
	}
}

/****************************************************************************
 *
 * draw_on_backbuffer() // draw some effect to back buffer
 *
 ****************************************************************************/
void CBubbleLocal::frame_actor_local()
{
	for( int i = 0; i < play; i++ )
	{
		draw_back_actor(i, home[i]->home);
	}
}

/****************************************************************************
 *
 * draw_on_backbuffer() // draw some effect to back buffer
 *
 ****************************************************************************/
void CBubbleLocal::animate_effect()
{
	if( world.get_status() != EW_RUNNING )
	{
		status = EL_PAUSE;

		return;
	}

	frame_actor_local();	// draw actor to back buffer
}
#endif
#endif

#if defined _WIN32
#ifdef useDI
/****************************************************************************
 *
 * read_key() // read keyboard input from DirectInput
 *
 ****************************************************************************/
void CBubbleLocal::read_key()
{
	lpDI->UpdateKeyStatus();

	// System key
	if( lpDI->KeyStatus(DIK_ESCAPE) )
		world.key_press(KEY_ESC);
	else
		world.key_release(KEY_ESC);

	// Key group 0
	if( lpDI->KeyStatus(DIK_A) )
		world.key_press(KEY1_LEFT);
	else
		world.key_release(KEY1_LEFT);
	if( lpDI->KeyStatus(DIK_D) )
		world.key_press(KEY1_RIGHT);
	else
		world.key_release(KEY1_RIGHT);
	if( lpDI->KeyStatus(DIK_X) )
		world.key_press(KEY1_DOWN);
	else
		world.key_release(KEY1_DOWN);
	if( lpDI->KeyStatus(DIK_S) )
		world.key_press(KEY1_CW);
	else
		world.key_release(KEY1_CW);
	if( lpDI->KeyStatus(DIK_W) )
		world.key_press(KEY1_CCW);
	else
		world.key_release(KEY1_CCW);

	// Key group 1
	if( lpDI->KeyStatus(DIK_NUMPAD4) )
		world.key_press(KEY2_LEFT);
	else
		world.key_release(KEY2_LEFT);

	if( lpDI->KeyStatus(DIK_NUMPAD6) )
		world.key_press(KEY2_RIGHT);
	else
		world.key_release(KEY2_RIGHT);

	if( lpDI->KeyStatus(DIK_NUMPAD2) )
		world.key_press(KEY2_DOWN);
	else
		world.key_release(KEY2_DOWN);

	if( lpDI->KeyStatus(DIK_NUMPAD5) )
		world.key_press(KEY2_CW);
	else
		world.key_release(KEY2_CW);

	if( lpDI->KeyStatus(DIK_NUMPAD8) )
		world.key_press(KEY2_CCW);
	else
		world.key_release(KEY2_CCW);
}
#endif
#endif

#if defined _WIN32
#ifdef useDS
/****************************************************************************
 *
 * sound_effect() // play sound effect
 *
 ****************************************************************************/
void CBubbleLocal::sound_effect()
{
	for( int i = 0; i < play; i++ )
	{
		// play sound effect
		if( (home[i]->home).action.turn_key )
		{
			lpDS->play(TURNKEY_SOUND);
			(home[i]->home).action.turn_key = FALSE;
		}

		if( (home[i]->home).action.move_key )
		{
			lpDS->play(MOVEKEY_SOUND);
			(home[i]->home).action.move_key = FALSE;
		}

		if( (home[i]->home).action.blocked_act )
		{
			lpDS->play(BLOCKED_SOUND);
			(home[i]->home).action.blocked_act = FALSE;
		}

		if( (home[i]->home).action.fall_act )
		{
			lpDS->play(FALL_SOUND);
			(home[i]->home).action.fall_act = FALSE;
		}

		if( (home[i]->home).action.bomb_act )
		{
			lpDS->play(BOMB_SOUND);
			(home[i]->home).action.bomb_act = FALSE;
		}
	}
}
#endif
#endif

/****************************************************************************
 *
 * CBubbleLocal() // constructor - initial all variable
 *
 ****************************************************************************/
#if defined __TURBOC__
CBubbleLocal::CBubbleLocal()
#elif defined _WIN32
CBubbleLocal::CBubbleLocal(HINSTANCE _hinst, HWND _hwnd)
#endif
{
	status = EL_NONE;

	for( int i = 0; i < MAX_HOME_IN_GAME; i++ )
	{
		home[i] = NULL;
	}

	play = 0;
	last_time_tick = curr_time_tick = 0;

#if defined __TURBOC__
	randomize();
#elif defined _WIN32
	hinst = _hinst;
	hwnd = _hwnd;

	lpMusic = new CMusic(hwnd);

#ifdef useDD
	lpDD = new CBubbleDD(hwnd, DDWidth, DDHeight, DDBpp);
#endif
#ifdef useDI
	lpDI = new CBubbleDI(hinst, hwnd);
#endif
#ifdef useDS
	lpDS = new CBubbleDS(hwnd);
#endif

	srand((unsigned)time(NULL));
#endif

}

/****************************************************************************
 *
 * ~CBubbleLocal() // destructor
 *
 ****************************************************************************/
CBubbleLocal::~CBubbleLocal()
{
	for( int i = 0; i < MAX_HOME_IN_GAME; i++ )
		if( home[i] != NULL )
		{
			delete home[i];
		}

#if defined _WIN32
		delete lpMusic;

#ifdef useDD
		delete lpDD;
#endif
#ifdef useDI
		delete lpDI;
#endif
#ifdef useDS
		delete lpDS;
#endif
#endif
}

/****************************************************************************
 *
 * get_status() // get status of local
 *
 ****************************************************************************/
ENUM_LOCAL_STATUS CBubbleLocal::get_status()
{
	return status;
}

/****************************************************************************
 *
 * tick() // heartbeat of Local
 *
 ****************************************************************************/
void CBubbleLocal::tick()
{
	BOOL time_tick = FALSE;

#if defined __TURBOC__
	struct time t;
	
	gettime(&t);
	curr_time_tick = t.ti_sec*100+t.ti_hund;

	if( curr_time_tick - last_time_tick > 0)
	{
		last_time_tick = curr_time_tick;
		time_tick = TRUE;
	}
#elif defined _WIN32
	curr_time_tick = timeGetTime();

	if( curr_time_tick - last_time_tick >= TIME_WIN32_TICK_ELASPE )
	{
		last_time_tick = curr_time_tick;
		time_tick = TRUE;
	}
#endif

	// send tick to all home if time to tick
	if( !time_tick )
		return;

#if defined _WIN32
#ifdef useDI
	read_key();
#endif
#endif

	// send tick to all world
	tick_local();

	// update screen
	frame_home_local();

#if defined _WIN32
#if defined useDD
	lpDD->BltBuffer2Back();

	// draw some effect to back buffer
	animate_effect();

	lpDD->Flip();
#endif
#if defined useDS
	sound_effect();
#endif
#endif
}

/****************************************************************************
 *
 * start(ENUM_PLAYER _play) // start with number of player
 *
 ****************************************************************************/
void CBubbleLocal::start(ENUM_PLAYER _play)
{
	status = EL_RUNNING;

	if( (_play == EP_ONE)||(_play == EP_2ONE) )
	{
		player = _play;

		if( _play == EP_ONE )
		{
			play = 1;
		}
		else
		{
			play = 2;
		}

		world.start(player);

		for( int i = 0; i < play; i++ )
		{
			home[i] = new HOME_DAT;
			memset(home[i], 0, sizeof(HOME_DAT));
			home[i]->precv_bomb = 1;

			world.set_point_home(i, &(home[i]->home));

			(home[i]->home).next_color[0] = gen_next_color();
			(home[i]->home).next_color[1] = gen_next_color();
		}

#if defined __TURBOC__
		draw_bar();
#elif defined _WIN32
		lpMusic->Play(MusicMIDI);
#endif
	}
}

/****************************************************************************
 *
 * stop()
 *
 ****************************************************************************/
void CBubbleLocal::stop()
{
#if defined _WIN32
	lpMusic->Stop();
#endif
}

/****************************************************************************
 *
 * key_press() // key press 
 *
 ****************************************************************************/
void CBubbleLocal::key_press(char _key)
{
	world.key_press(_key);
}

/****************************************************************************
 *
 * key_release() // key release
 *
 ****************************************************************************/
void CBubbleLocal::key_release(char _key)
{
	world.key_release(_key);
}
