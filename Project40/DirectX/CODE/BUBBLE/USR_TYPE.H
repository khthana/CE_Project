#ifndef _User_DataType_
#define _User_DataType_

#ifndef BOOL
	typedef int BOOL;
	#define FALSE	0
	#define TRUE	1
#endif

typedef struct {
	int i,j;
} TABLE_POS;

enum ENUM_PLAYER {
	EP_ONE,
	EP_2ONE
};

#define MAX_CHAR_COLOR	5

enum ENUM_COLOR {
	EC_NONE		= 8,
	EC_BLACK	= 0,
	EC_CYAN		= 11,
	EC_RED		= 12,
	EC_GREEN	= 10,
	EC_BLUE		= 9,
	EC_YELLOW	= 14,
	EC_MAGENTA	= 13
};

#define MAX_ACTION_CHAR	22

enum ENUM_ACTION {
	EA_NONE,
	EA_USRDOWN1,
	EA_USRDOWN2,
	EA_USRDOWN3,
	EA_FALL,
	EA_BLOCKED,
	EA_BOMB,

	EA_ABOVE,
	EA_BOTTOM,
	EA_LEFT,
	EA_RIGHT,

	EA_ABOVE_BOTTOM,
	EA_ABOVE_LEFT,
	EA_ABOVE_RIGHT,

	EA_BOTTOM_LEFT,
	EA_BOTTOM_RIGHT,

	EA_LEFT_RIGHT,

	EA_ABOVE_BOTTOM_LEFT,
	EA_ABOVE_BOTTOM_RIGHT,
	EA_ABOVE_LEFT_RIGHT,

	EA_BOTTOM_LEFT_RIGHT,
	EA_ABOVE_BOTTOM_LEFT_RIGHT
};

typedef struct {
	ENUM_COLOR species;		// identifier of char
	ENUM_ACTION action;		// action for animation
	int tick;				// clock to change frame
} CHAR_BASE;

#define HOME_TABLE_I	16
#define HOME_TABLE_J	8

#define HOME_USE_I		12
#define HOME_USE_J		6

#define MAX_ACT_CHAR	2	// Two actor
#define CONNECT_BOMB	4	// connect for bomb
#define OBSTRUCT_PRESS 	1	// obstruct before turn CW or CCW
#define MAX_CONT_BOMB	10	// max continue bomb level

enum ENUM_CHECK_BOMB {
	ECB_ONLYCHECK,
	ECB_CHECKUPDATE
};

typedef CHAR_BASE 		IN_HOME_TABLE[HOME_TABLE_I][HOME_TABLE_J];
typedef CHAR_BASE 		HOME_TABLE[HOME_USE_I][HOME_USE_J];
typedef unsigned char 	CONT_BOMB[MAX_CONT_BOMB];
typedef BOOL 			TABLE_BOMB[HOME_TABLE_I][HOME_TABLE_J];

#endif
