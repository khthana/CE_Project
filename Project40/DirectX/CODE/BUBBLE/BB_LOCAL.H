#ifndef _CBubble_Local_
#define _CBubble_Local_

#include "control.h"
#include "bb_world.h"

#if defined _WIN32
	#include "c_music.h" // MIDI
#ifdef useDD			// DirectDraw
	#include "bb_dd.h"	
#endif					
#ifdef useDI			// DirectInput
	#include "bb_di.h"
#endif
#ifdef useDS			// DirectSound
	#include "bb_ds.h"
#endif
#endif

enum ENUM_LOCAL_STATUS {
	EL_NONE,
	EL_RUNNING,
	EL_PAUSE
};

typedef struct {
	HOME_DAT_TO_LOCAL home;
	HOME_TABLE prev_table;
	ENUM_COLOR prev_color[MAX_ACT_CHAR];
	int send_bomb, precv_bomb;
} HOME_DAT;

#define MAX_HOME_IN_GAME	4
             
class CBubbleLocal
{
private:/***** PRIVATE *****/
	ENUM_LOCAL_STATUS status;

	CBubbleWorld world;

	HOME_DAT *home[MAX_HOME_IN_GAME];
	ENUM_PLAYER player; // type of playing
	int play;	// number of player

	unsigned long last_time_tick, curr_time_tick;

	ENUM_COLOR gen_next_color();
	
	void calculate_send_bomb(int _p);
	void send_bomb_to_other(int _p);

	void tick_local();
	void update_home_frame(int _pos, HOME_DAT *_home);
	void frame_home_local();

//***** DOS MODE *****
#if defined __TURBOC__

	void draw_bar();

//***** WIN32 MODE *****
#elif defined _WIN32
	HINSTANCE		hinst;
	HWND			hwnd;

	CMusic			*lpMusic; // Music object
	
#ifdef useDD
	CBubbleDD		*lpDD;	// DirectDraw

	// draw some effect to back buffer
	void draw_back_actor(int _pos, HOME_DAT_TO_LOCAL & _home);
	void frame_actor_local();
	void animate_effect();
#endif
#ifdef useDI				// DirectInput
	CBubbleDI		*lpDI;	
	 // read key from DirectInput 
	void read_key();
#endif
#ifdef useDS				// DirectSound
	CBubbleDS		*lpDS;
	// play sound effect
	void sound_effect();
#endif

#endif


public:/***** PUBLIC *****/

#if defined __TURBOC__
	CBubbleLocal();
#elif defined _WIN32
	CBubbleLocal(HINSTANCE _hinst, HWND _hwnd);
#endif

	~CBubbleLocal();

	ENUM_LOCAL_STATUS get_status();

	void tick();

	void start(ENUM_PLAYER _play = EP_ONE);
	void stop();

	void key_press(char _key);
	void key_release(char _key);
};

#endif