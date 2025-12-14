#ifndef _CBubble_Home_
#define _CBubble_Home_

#include <stdlib.h>
#include <string.h>
#include "usr_type.h"		// user define data type

enum ENUM_HOME_STATUS {
	EH_NONE,
	EH_RUNNING,
	EH_PAUSE,
	EH_LOSE
};

#define HOME_INPUTKEY	5

enum ENUM_INPUTKEY {
	EK_LEFT,
	EK_RIGHT,
	EK_DOWN,
	EK_CW,			// clockwise
	EK_CCW,			// counterclockwise
	EK_ESC,
	EK_PAUSE
};

#if defined __TURBOC__
	#define LIMIT_TICK_COUNT	100

	#define TIME_USRDOWN_1		10
	#define TIME_USRDOWN_2		7
	#define TIME_USRDOWN_3		5

	#define TIME_LEVEL1_LIFE	900
	#define TIME_LEVEL2_LIFE	900
	#define TIME_LEVEL3_LIFE	900

	#define TIME_FALL	  		2

	#define TIME_BLOCKED        2
	#define TIME_BOMB			3
	#define TIME_CONNECT_DELAY	2

	#define TIME_ACT_BLOCKED	7
#elif defined _WIN32
	#define LIMIT_TICK_COUNT	100

	#define TIME_USRDOWN_1		12
	#define TIME_USRDOWN_2		9
	#define TIME_USRDOWN_3		7

	#define TIME_LEVEL1_LIFE	900
	#define TIME_LEVEL2_LIFE	900
	#define TIME_LEVEL3_LIFE	900

	#define TIME_FALL	  		2

	#define TIME_BLOCKED        3
	#define TIME_BOMB			4
	#define TIME_CONNECT_DELAY	3

	#define TIME_HALFDOWN1	(TIME_USRDOWN_1/2)
	#define	TIME_HALFDOWN2	(TIME_USRDOWN_2/2)
	#define TIME_HALFDOWN3	(TIME_USRDOWN_3/2)

	#define TIME_ACT_BLOCKED	5
#endif

typedef struct {
	BOOL pending;	// actor is pending
	ENUM_ACTION action; // actor action
	int pending_time;	// multiply of tick
	int	obstruct;	// count press when can't turn
	CHAR_BASE bubble[MAX_ACT_CHAR];
	TABLE_POS pos[MAX_ACT_CHAR]; // pos in table (i,j)
} STRUCT_ACT;

typedef struct {
	BOOL turn_key;
	BOOL move_key;
	BOOL blocked_act;
	BOOL fall_act;
	BOOL bomb_act;
} STRUCT_ACTION;

class CBubbleHome
{
private:
	int id;		// identifier for itself

	int level;	// level for select speed
	int level_lifetime; // time remain in this level
	ENUM_HOME_STATUS status;	// status of home

	BOOL pending;	// home in action can't input key
	BOOL obstruct_fall;	// obstruct is falling

	int connect_delay; // delay for connect before bomb or next actor

	STRUCT_ACT	act; // actor

	IN_HOME_TABLE tbl; // table in game

	TABLE_BOMB char_bomb; // boolean check cell bomb
	CONT_BOMB count_bomb; // array of continue bomb
	TABLE_POS pos_bomb;	  // low-left of bomb

	STRUCT_ACTION action; // action send to local

	void dec_levellife();	// decrease life time
	ENUM_ACTION act_usrdown(); 	// action depend on level
	int time_usrdown();		   	// tick depend on level

	void set_act(CHAR_BASE & _char,ENUM_ACTION _act);
	void set_char(CHAR_BASE & _char,ENUM_COLOR _c,ENUM_ACTION _act);
	void clear_act();
	void init_var(); // initial all variable

	void tick_act();

	BOOL check_stay(const CHAR_BASE _c);
	BOOL check_connect(const CHAR_BASE _c1, const CHAR_BASE _c2);
	void find_new_connect();

	void find_new_fall();
	BOOL find_set_bomb();
	void tick_table();

public:
	CBubbleHome(int _id = 1);
	~CBubbleHome();

	ENUM_HOME_STATUS get_status();

	BOOL want_new_act();
	BOOL set_act_char(const ENUM_COLOR _s1, const ENUM_COLOR _s2);

	BOOL key_input(ENUM_INPUTKEY _key);

	void get_update(HOME_TABLE _tbl, STRUCT_ACT & _act);
	void get_bomb(TABLE_POS & _pos, CONT_BOMB _cb);
	void get_action(STRUCT_ACTION *_action);

	int deliver_bomb(int _cb);

	void tick();

	void reset();
	void start();
	void pause();
};

#endif

