#ifndef _CBubble_World_
#define _CBubble_World_

#include "bb_home.h"

enum ENUM_WORLD_STATUS {
	EW_NONE,
	EW_RUNNING,
	EW_PAUSE
};

#define KEY_ESC		0x01	// ESC

#define KEY1_LEFT	0x1E	// A
#define KEY1_RIGHT	0x20	// D
#define KEY1_DOWN	0x2D	// X
#define KEY1_CW		0x1F	// S
#define KEY1_CCW	0x11	// W
#define KEY2_LEFT	0x4B	// White Left Arrow
#define KEY2_RIGHT	0x4D	// White Right Arrow
#define KEY2_DOWN	0x50	// White Down Arrow
#define KEY2_CW		0x4C	// Center Key
#define KEY2_CCW	0x48	// Whhite Up Arrow

typedef struct {
	BOOL want_act; // indicate home want new act
	ENUM_COLOR next_color[MAX_ACT_CHAR]; // next color for home
	STRUCT_ACT act;	// actor in table
	HOME_TABLE table; // table
	TABLE_POS pos_bomb; // pos of low-right bomb
	CONT_BOMB count_bomb; // array cont. bomb
	int recv_bomb; // receive bomb from other

	STRUCT_ACTION action;
} HOME_DAT_TO_LOCAL; // struct to pass to local

typedef struct {
	CBubbleHome *home; // CBubbleHome object

	BOOL key[HOME_INPUTKEY]; // flag key press
	int key_mask[HOME_INPUTKEY]; // flage key mask

	HOME_DAT_TO_LOCAL *local; // point to local data

} HOME_DAT_IN_WORLD; // intermediate value in world

#define	MAX_HOME_IN_WORLD	2

class CBubbleWorld
{
private:
	ENUM_WORLD_STATUS status;
	ENUM_PLAYER player;

	HOME_DAT_IN_WORLD home[MAX_HOME_IN_WORLD];

public:
	CBubbleWorld();
	~CBubbleWorld();

	// set internal pointer to appropriate home data in local
	BOOL set_point_home(int _homeid, HOME_DAT_TO_LOCAL *_home);

	ENUM_WORLD_STATUS get_status();

	void tick();

	void start(ENUM_PLAYER _play = EP_ONE);
	void stop();

	void key_press(char _key);
	void key_release(char _key);
};

#endif
