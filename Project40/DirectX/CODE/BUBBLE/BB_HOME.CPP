#include "bb_home.h"
#include "rules.h"

/****************************************************************************
 *
 * dec_levellife() 
 *
 ****************************************************************************/
void CBubbleHome::dec_levellife()
{
	level_lifetime--;
	if( !level_lifetime )
	{
		switch (level)
		{
		case 1:
			level = 2;
			level_lifetime = TIME_LEVEL2_LIFE;
			break;

		case 2:
			level = 3;
			level_lifetime = TIME_LEVEL3_LIFE;
			break;

		case 3:
			level_lifetime = TIME_LEVEL3_LIFE;
			break;
		}
	}
}

/****************************************************************************
 *
 * act_usrdown() // return EA_USRDOWN?
 *
 ****************************************************************************/
ENUM_ACTION CBubbleHome::act_usrdown()
{
	switch (level)
	{
		case 1 : return EA_USRDOWN1;
		case 2 : return EA_USRDOWN2;
		case 3 : return EA_USRDOWN3;
		default : return EA_USRDOWN3;
	}

}

/****************************************************************************
 *
 * time_usrdown() // return cell down in tick
 *
 ****************************************************************************/
int CBubbleHome::time_usrdown()
{
	switch (level)
	{
		case 1 : return TIME_USRDOWN_1;
		case 2 : return TIME_USRDOWN_2;
		case 3 : return TIME_USRDOWN_3;
		default : return TIME_USRDOWN_3;
	}
}

/****************************************************************************
 *
 * set_act // set character with .action -> .tick
 * 			  this duplicat in set_char()
 *
 ****************************************************************************/
void CBubbleHome::set_act(CHAR_BASE & _char,ENUM_ACTION _act)
{
	_char.action = _act;

	switch (_act)
	{
		case EA_BLOCKED :
			_char.tick = TIME_BLOCKED;
			break;

		case EA_FALL :
			_char.tick = TIME_FALL;
			break;

		case EA_BOMB :
			_char.tick = TIME_BOMB;
			break;

		case EA_USRDOWN1 :
		case EA_USRDOWN2 :
		case EA_USRDOWN3 :
			_char.tick = time_usrdown();
			break;

		default :
			_char.tick = 0;
	}

}

/****************************************************************************
 *
 * set_char // set character with .species and .action -> .tick
 *
 ****************************************************************************/
void CBubbleHome::set_char(
			CHAR_BASE & _char,
			ENUM_COLOR _c,ENUM_ACTION _act )
{
	switch (_c)
	{
				 case EC_NONE	: _char.species = EC_NONE;  break;
				 case EC_BLACK  : _char.species = EC_BLACK; break;
				 case EC_CYAN   : _char.species = EC_CYAN;	break;
		case 1 : case EC_RED	: _char.species = EC_RED;	break;
		case 2 : case EC_GREEN	: _char.species = EC_GREEN;	break;
		case 3 : case EC_BLUE	: _char.species = EC_BLUE;	break;
		case 4 : case EC_YELLOW : _char.species = EC_YELLOW;break;
		case 5 : case EC_MAGENTA: _char.species = EC_MAGENTA; break;
		default			  		: _char.species = EC_NONE;
	}

	// from this duplicate set_act()

	_char.action = _act;

	switch (_act)
	{
		case EA_BLOCKED :
			_char.tick = TIME_BLOCKED;
			break;

		case EA_FALL :
			_char.tick = TIME_FALL;
			break;

		case EA_BOMB :
			_char.tick = TIME_BOMB;
			break;

		case EA_USRDOWN1 :
		case EA_USRDOWN2 :
		case EA_USRDOWN3 :
			_char.tick = time_usrdown();
			break;

		default :
			_char.tick = 0;
	}
}

/****************************************************************************
 *
 * clear_act() // clear act
 *
 ****************************************************************************/
void CBubbleHome::clear_act()
{
	int i;

	act.pending = FALSE;
	act.action = EA_NONE;
	act.pending_time = 0;
	act.obstruct = OBSTRUCT_PRESS;

	for( i = 0; i < MAX_ACT_CHAR; i++)
	{
		set_char(act.bubble[i],EC_NONE,EA_NONE);

		act.pos[i].i = 0;
		act.pos[i].j = 0;
	}
}

/****************************************************************************
 *
 * init_var() // initial all variable in object
 *
 ****************************************************************************/
void CBubbleHome::init_var()
{
	level = 1;
	level_lifetime = TIME_LEVEL1_LIFE;

	status = EH_NONE;
	pending = FALSE;
	obstruct_fall = FALSE;

	connect_delay = 0;

	int i,j;

	for( i = 0; i < HOME_TABLE_I; i++)
	{
		set_char(tbl[i][0],EC_BLACK,EA_NONE);	// left |
		set_char(tbl[i][7],EC_BLACK,EA_NONE);	// right |
	}

	for( i = 1; i < HOME_TABLE_I-1; i++)		// for game
		for( j = 1; j < HOME_TABLE_J-1; j++)
			set_char(tbl[i][j],EC_NONE,EA_NONE);

	for( j = 1; j < HOME_TABLE_J-1; j++)
	{
		set_char(tbl[0][j],EC_BLACK,EA_NONE);	// top --
		set_char(tbl[15][j],EC_BLACK,EA_NONE);	// bottom --
	}

	memset(char_bomb,FALSE,sizeof(TABLE_BOMB));
	memset(count_bomb,0,sizeof(CONT_BOMB));
	memset(&pos_bomb,0,sizeof(TABLE_POS));

	memset(&action,0,sizeof(STRUCT_ACTION));

	clear_act();
}

/****************************************************************************
 *
 * CBubbleHome(int _id) // constructor _id is identify of this object
 *
 ****************************************************************************/
CBubbleHome::CBubbleHome(int _id)
{
	id = _id;

	init_var();
}

/****************************************************************************
 *
 * ~CBubbleHome() // destructor
 *
 ****************************************************************************/
CBubbleHome::~CBubbleHome()
{
}

/****************************************************************************
 *
 * get_status() // get status of Home
 *
 ****************************************************************************/
ENUM_HOME_STATUS CBubbleHome::get_status()
{
	return status;
}

/****************************************************************************
 *
 * want_new_act() // want new actor
 *
 ****************************************************************************/
BOOL CBubbleHome::want_new_act()
{

	return (status==EH_RUNNING)&&(!pending)&&(!act.pending);
}

/****************************************************************************
 *
 * set_act_char()
 *
 ****************************************************************************/
BOOL CBubbleHome::set_act_char(const ENUM_COLOR _s1, const ENUM_COLOR _s2)
{
	if( want_new_act() )
	{
		if( tbl[3][3].species != EC_NONE )	// top of input
		{
			status = EH_LOSE;

			return FALSE;
		}

		pending = TRUE;

		act.pending = TRUE;
		act.action = act_usrdown();
		act.pending_time = time_usrdown()/2;
		act.obstruct = OBSTRUCT_PRESS;

		set_char(act.bubble[0],_s1,act_usrdown());
		act.pos[0].i = 2;
		act.pos[0].j = 3;

		set_char(act.bubble[1],_s2,act_usrdown());
		act.pos[1].i = 1;
		act.pos[1].j = 3;

		return TRUE;
	}

	return FALSE;
}

/****************************************************************************
 *
 * key_input(ENUM_INPUTKEY _key) // key input to Home
 *
 ****************************************************************************/
BOOL CBubbleHome::key_input(ENUM_INPUTKEY _key)
{
	int i,j,l;

	if( act.pending )
	{
		switch (_key)
		{
			case EK_LEFT :
				// find low-left
				if( act.pos[0].i >= act.pos[1].i )
					i = act.pos[0].i;
				else
					i = act.pos[1].i;
				if( act.pos[0].j < act.pos[1].j )
					j = act.pos[0].j;
				else
					j = act.pos[1].j;

				if( tbl[i][j-1].species == EC_NONE )
				{
					action.move_key = TRUE;
					for( l = 0; l < MAX_ACT_CHAR; l++ )
						act.pos[l].j--;
				}
				break;

			case EK_RIGHT :
				// find low-right
				if( act.pos[0].i >= act.pos[1].i )
					i = act.pos[0].i;
				else
					i = act.pos[1].i;
				if( act.pos[0].j > act.pos[1].j )
					j = act.pos[0].j;
				else
					j = act.pos[1].j;

				if( tbl[i][j+1].species == EC_NONE )
				{
					action.move_key = TRUE;
					for( l = 0; l < MAX_ACT_CHAR; l++ )
						act.pos[l].j++;
				}
				break;

			case EK_DOWN :
				act.pending_time = 1;
				break;

			case EK_CW :
				if( act.pos[0].i > act.pos[1].i )
				{
					if( tbl[act.pos[1].i+1][act.pos[1].j+1]
							.species == EC_NONE )
					{
						action.turn_key = TRUE;
						act.pos[1].i++;
						act.pos[1].j++;
					}
					else if( tbl[act.pos[0].i][act.pos[0].j-1]
								.species == EC_NONE )
					{
						action.turn_key = TRUE;
						act.pos[0].j--;
						act.pos[1].i++;
					}
					else if( !act.obstruct )
					{
						act.obstruct = OBSTRUCT_PRESS;

						if( tbl[act.pos[0].i+1][act.pos[0].j].
								species == EC_NONE )
						{
							action.turn_key = TRUE;
							act.pos[1].i += 2;
						}
						else
						{
							action.turn_key = TRUE;
							act.pos[0].i--;
							act.pos[1].i++;
						}
					}
					else
					{
						act.obstruct--;
					}
				}
				else if( act.pos[0].i < act.pos[1].i )
				{
					if( tbl[act.pos[1].i-1][act.pos[1].j-1]
							.species == EC_NONE )
					{
						action.turn_key = TRUE;
						act.pos[1].i--;
						act.pos[1].j--;
					}
					else if( tbl[act.pos[0].i][act.pos[0].j+1]
								.species == EC_NONE )
					{
						action.turn_key = TRUE;
						act.pos[0].j++;
						act.pos[1].i--;
					}
					else if( !act.obstruct )
					{
						act.obstruct = OBSTRUCT_PRESS;

						action.turn_key = TRUE;
						act.pos[1].i -= 2;
					}
					else
					{
						act.obstruct--;
					}
				}
				else // act.pos[0].i == act.pos[1].i
				{
					if( act.pos[0].j < act.pos[1].j )
					{
						if( tbl[act.pos[1].i+1][act.pos[1].j-1]
								.species == EC_NONE )
						{
							action.turn_key = TRUE;
							act.pos[1].i++;
							act.pos[1].j--;
						}
						else
						{
							action.turn_key = TRUE;
							act.pos[0].i--;
							act.pos[1].j--;
						}
					}
					else // act.pos[0].j > act.pos[1].j
					{
						action.turn_key = TRUE;
						act.pos[1].i--;
						act.pos[1].j++;
					}
				}
				break;

			case EK_CCW :
				action.turn_key = TRUE;

				if( act.pos[0].i > act.pos[1].i )
				{
					if( tbl[act.pos[1].i+1][act.pos[1].j-1]
							.species == EC_NONE )
					{
						action.turn_key = TRUE;
						act.pos[1].i++;
						act.pos[1].j--;
					}
					else if( tbl[act.pos[0].i][act.pos[0].j+1]
								.species == EC_NONE )
					{
						action.turn_key = TRUE;
						act.pos[0].j++;
						act.pos[1].i--;
					}
					else if( !act.obstruct )
					{
						act.obstruct = OBSTRUCT_PRESS;

						if( tbl[act.pos[0].i+1][act.pos[0].j].
								species == EC_NONE )
						{
							action.turn_key = TRUE;
							act.pos[1].i += 2;
						}
						else
						{
							action.turn_key = TRUE;
							act.pos[0].i--;
							act.pos[1].i++;
						}
					}
					else
					{
						act.obstruct--;
					}
				}
				else if( act.pos[0].i < act.pos[1].i )
				{
					if( tbl[act.pos[1].i-1][act.pos[1].j+1]
							.species == EC_NONE )
					{
						action.turn_key = TRUE;
						act.pos[1].i--;
						act.pos[1].j++;
					}
					else if( tbl[act.pos[0].i][act.pos[0].j-1]
								.species == EC_NONE )
					{
						action.turn_key = TRUE;
						act.pos[0].j--;
						act.pos[1].i--;
					}
					else if( !act.obstruct )
					{
						act.obstruct = OBSTRUCT_PRESS;

						action.turn_key = TRUE;
						act.pos[1].i -= 2;
					}
					else
					{
						act.obstruct--;
					}
				}
				else // act.pos[0].i == act.pos[1].i
				{
					if( act.pos[0].j > act.pos[1].j )
					{
						if( tbl[act.pos[1].i+1][act.pos[1].j+1]
								.species == EC_NONE )
						{
							action.turn_key = TRUE;
							act.pos[1].i++;
							act.pos[1].j++;
						}
						else
						{
							action.turn_key = TRUE;
							act.pos[0].i--;
							act.pos[1].j++;
						}
					}
					else // act.pos[0].j < act.pos[1].j
					{
						action.turn_key = TRUE;
						act.pos[1].i--;
						act.pos[1].j--;
					}
				}
				break;
		}

		return TRUE;
	}

	return FALSE;
}

/****************************************************************************
 *
 * get_update() // retrive table
 *
 ****************************************************************************/
void CBubbleHome::get_update(HOME_TABLE _tbl, STRUCT_ACT & _act)
{
	int i,j;

	for( i = 3; i < HOME_TABLE_I-1; i++ )
		for( j = 1; j < HOME_TABLE_J-1; j++ )
		{
			_tbl[i-3][j-1] = tbl[i][j];
		}

	memcpy(&_act,&act,sizeof(STRUCT_ACT));
	for( i = 0; i < MAX_ACT_CHAR; i++ )
	{
		_act.pos[i].i -= 3;
		_act.pos[i].j -= 1;
	}
}

/****************************************************************************
 *
 * get_bomb() // retrive bomb array
 *
 ****************************************************************************/
void CBubbleHome::get_bomb(TABLE_POS & _pos, CONT_BOMB _cb)
{
	if( !pending )
	{
		_pos = pos_bomb;
		memset(&pos_bomb,0,sizeof(TABLE_POS));

		_pos.j -= 1;
		_pos.i -= 3;

		memcpy(_cb,count_bomb,sizeof(CONT_BOMB));
		memset(count_bomb,0,sizeof(CONT_BOMB));
	}
}

/****************************************************************************
 *
 * get_action() // retrive an action
 *
 ****************************************************************************/
void CBubbleHome::get_action(STRUCT_ACTION *_action)
{
	memcpy(_action, &action, sizeof(STRUCT_ACTION));
	memset(&action, 0, sizeof(STRUCT_ACTION));
}

/****************************************************************************
 *
 * deliver_bomb(int _cb) // deliver bomb to user
 *						 // to row 2 in table but check row 3 must free
 *
 ****************************************************************************/
int CBubbleHome::deliver_bomb(int _cb)
{
	if( (!pending)||(obstruct_fall) )
	{
		int j;
		int blank_cell = 0;

		for( j = 1; j < HOME_TABLE_J-1; j++ )
			if( tbl[3][j].species == EC_NONE )
				blank_cell++;

		if( blank_cell )	// have blank cell
		{
			pending = TRUE;
			obstruct_fall = TRUE;

			if( _cb <= blank_cell ) // can send all in this tick
			{
				int startj;

				while( _cb ) // random pos to send bomb
				{
#if defined __TURBOC__
					startj = random(HOME_USE_J)+1;
#elif defined _WIN32
					startj = (int)((float)rand()/(float)RAND_MAX*(HOME_USE_J))+1;
#endif
					for( j = startj; j < HOME_TABLE_J-1; j++ )
						if( (_cb)&&(tbl[3][j].species == EC_NONE) )
						{
							set_char(tbl[3][j],EC_CYAN,EA_FALL);
							_cb--;
						}
				}

				obstruct_fall = FALSE;

				return 0;
			}
			else // this tick send all can send
			{
				for( j = 1; j < HOME_TABLE_J-1; j++ )
					if( tbl[3][j].species == EC_NONE )
						set_char(tbl[3][j],EC_CYAN,EA_FALL);

				return (_cb-blank_cell);
			}
		}
		else // not have blank cell
		{
			for( j = 1; j < HOME_TABLE_J-1; j++ )
				if( tbl[3][j].action == EA_FALL ) // previous bomb falling
					return _cb; // nothing do - return

			// this no have cell free
			status = EH_LOSE;

			return _cb;
		}
	}

	return _cb;
}

/****************************************************************************
 *
 * tick_act() // tick actor	- pengind = TRUE (always)
 * this function not alter pending
 *
 ****************************************************************************/
void CBubbleHome::tick_act()
{
	act.pending_time--;

	if( !act.pending_time )	// elaspe time
	{
		int i;

		switch (act.action)
		{
		case EA_USRDOWN1:
		case EA_USRDOWN2:
		case EA_USRDOWN3:
				for( i = 0; i < MAX_ACT_CHAR; i++ )
					if( tbl[act.pos[i].i+1][act.pos[i].j]
							.species != EC_NONE )
					{
						set_act(act.bubble[i],EA_BLOCKED);

						act.action = EA_BLOCKED;

						// temperary use for mask that cell is blocked
						tbl[act.pos[i].i][act.pos[i].j].action = EA_BLOCKED;
					}

				if( act.action == EA_BLOCKED )
				{
					act.pending_time = TIME_ACT_BLOCKED;

					for( i = 0; i < MAX_ACT_CHAR; i++ )
						if( tbl[act.pos[i].i+1][act.pos[i].j]
							.action == EA_BLOCKED )
						{
							set_act(act.bubble[i],EA_BLOCKED);
						}

					// clear temperary mask blocked
					for( i = 0; i < MAX_ACT_CHAR; i++ )
						tbl[act.pos[i].i][act.pos[i].j].action = EA_NONE;

				}
				else
				{
					// both don't blocked then move down
					act.pending_time = time_usrdown(); //reset time

					for( i = 0; i < MAX_ACT_CHAR; i++)
					{
						act.pos[i].i++;
					}

					int next_tick_block = FALSE;

					for( i = 0; i < MAX_ACT_CHAR; i++ )
						if( tbl[act.pos[i].i+1][act.pos[i].j]
								.species != EC_NONE )
						{
							next_tick_block = TRUE;
						}

					if( next_tick_block )	// decrease time half
					{
						act.pending_time /= 2;
					}
				}
				break;

		case EA_BLOCKED:
				action.blocked_act = TRUE;

				BOOL move = FALSE; // check for some act move to table
				BOOL reset = FALSE; // check act reset to EA_USRDOWN?

				for( i = 0; i < MAX_ACT_CHAR; i++ )
					if( act.bubble[i].action == EA_BLOCKED )
						if( tbl[act.pos[i].i+1][act.pos[i].j]
								.species != EC_NONE )
						{
							move = TRUE;
						}
						else
						{
							reset = TRUE;
						}

				if( move )	// if move then move all no more reset
				{
					// temerary update
					for( i = 0; i < MAX_ACT_CHAR; i++ )
						tbl[act.pos[i].i][act.pos[i].j].species = EC_BLACK;

					// real update
					for( i = 0; i < MAX_ACT_CHAR; i++ )
					{
						if( tbl[act.pos[i].i+1][act.pos[i].j]
								.species != EC_NONE )
							set_char(
								tbl[act.pos[i].i][act.pos[i].j],
								act.bubble[i].species,
								EA_BLOCKED
							);
						else
							set_char(
								tbl[act.pos[i].i][act.pos[i].j],
								act.bubble[i].species,
								EA_FALL
							);

						// override tick for find connect as fast as possible
						tbl[act.pos[i].i][act.pos[i].j].tick = 1;
					}

					clear_act();
				}
				else if( reset ) // reset only not move
				{
					for( i = 0; i < MAX_ACT_CHAR; i++ )
					{
						set_act(act.bubble[i],act_usrdown());
					}

					act.pending_time = time_usrdown(); //reset time
					act.action = act_usrdown();
				}
				break;
		}
	}
}

/****************************************************************************
 *
 * check_stay() // is it stay
 *
 ****************************************************************************/
BOOL CBubbleHome::check_stay(const CHAR_BASE _c)
{
	if( (_c.species != EC_NONE )&&
		(_c.action != EA_USRDOWN1)&&
		(_c.action != EA_USRDOWN2)&&
		(_c.action != EA_USRDOWN3)&&
		(_c.action != EA_BLOCKED)&&
		(_c.action != EA_FALL)&&
		(_c.action != EA_BOMB)
	)
		return TRUE;
	else
		return FALSE;

}

/****************************************************************************
 *
 * check_connect() // is it connected ?
 *
 ****************************************************************************/
BOOL CBubbleHome::check_connect(const CHAR_BASE _c1, const CHAR_BASE _c2)
{
	if( (_c1.species == _c2.species )&&(check_stay(_c2))
	)
		return TRUE;
	else
		return FALSE;
}

/****************************************************************************
 *
 * find_new_connect() // check for connect
 *
 ****************************************************************************/
void CBubbleHome::find_new_connect()
{
	int i,j;

	for( i = HOME_TABLE_I-2; i > 0; i-- )
		for( j = 1; j < HOME_TABLE_J-1; j++ )
			if(	(tbl[i][j].species == EC_RED)||
				(tbl[i][j].species == EC_GREEN)||
				(tbl[i][j].species == EC_BLUE)||
				(tbl[i][j].species == EC_YELLOW)||
				(tbl[i][j].species == EC_MAGENTA)
			)
			if( check_stay(tbl[i][j]) ) // not stay -> can't connect
			{
				// above
				if( check_connect(tbl[i][j],tbl[i-1][j]) )
				{
					// bottom
					if( check_connect(tbl[i][j],tbl[i+1][j]) )
					{
						// left
						if( check_connect(tbl[i][j],tbl[i][j-1]) )
						{
							// right
							if( check_connect(tbl[i][j],tbl[i][j+1]) )
							{
								set_act(tbl[i][j],EA_ABOVE_BOTTOM_LEFT_RIGHT);
							}
							else
							{
								set_act(tbl[i][j],EA_ABOVE_BOTTOM_LEFT);
							}
						}
						// right
						else if( check_connect(tbl[i][j],tbl[i][j+1]) )
						{
							set_act(tbl[i][j],EA_ABOVE_BOTTOM_RIGHT);
						}
						else
						{
							set_act(tbl[i][j],EA_ABOVE_BOTTOM);
						}
					}
					// left
					else if( check_connect(tbl[i][j],tbl[i][j-1]) )
					{
						//right
						if( check_connect(tbl[i][j],tbl[i][j+1]) )
						{
							set_act(tbl[i][j],EA_ABOVE_LEFT_RIGHT);
						}
						else
						{
							set_act(tbl[i][j],EA_ABOVE_LEFT);
						}
					}
					// right
					else if( check_connect(tbl[i][j],tbl[i][j+1]) )
					{
						set_act(tbl[i][j],EA_ABOVE_RIGHT);
					}
					else
					{
						set_act(tbl[i][j],EA_ABOVE);
					}
				}
				// bottom
				else if( check_connect(tbl[i][j],tbl[i+1][j]) )
				{
					// left
					if( check_connect(tbl[i][j],tbl[i][j-1]) )
					{
						// right
						if( check_connect(tbl[i][j],tbl[i][j+1]) )
						{
							set_act(tbl[i][j],EA_BOTTOM_LEFT_RIGHT);
						}
						else
						{
							set_act(tbl[i][j],EA_BOTTOM_LEFT);
						}
					}
					// right
					else if( check_connect(tbl[i][j],tbl[i][j+1]) )
					{
						set_act(tbl[i][j],EA_BOTTOM_RIGHT);
					}
					else
					{
						set_act(tbl[i][j],EA_BOTTOM);
					}
				}
				// left
				else if( check_connect(tbl[i][j],tbl[i][j-1]) )
				{
					// right
					if( check_connect(tbl[i][j],tbl[i][j+1]) )
					{
						set_act(tbl[i][j],EA_LEFT_RIGHT);
					}
					else
					{
						set_act(tbl[i][j],EA_LEFT);
					}

				}
				// right
				else if( check_connect(tbl[i][j],tbl[i][j+1]) )
				{
					set_act(tbl[i][j],EA_RIGHT);
				}
				else
				{
					set_act(tbl[i][j],EA_NONE);
				}
			}
}

/****************************************************************************
 *
 * find_new_fall() // check for connect
 *
 ****************************************************************************/
void CBubbleHome::find_new_fall()
{
	BOOL found = FALSE;
	BOOL found_vacuum;

	for( int j = 1; j < HOME_TABLE_J-1; j++ )
		for( int i = HOME_TABLE_I-2; i > 1; i-- )
		{
			found_vacuum = FALSE;

			if( (tbl[i][j].species == EC_NONE)&&
				(tbl[i-1][j].species != EC_NONE)
			)
			{
				for(int row = i-1; row > 0; row-- )
					if( tbl[row][j].species != EC_NONE )
					{
						set_act(tbl[row][j],EA_FALL);
					}

				found_vacuum = TRUE;
			}

			found |= found_vacuum;

			if( found_vacuum )
				break;
		}

	if( found )	// update connect for cut some cell that connect
	{
		action.fall_act = TRUE;
		find_new_connect();
	}
}

/****************************************************************************
 *
 * find_set_bomb() // find bombable block
 *
 ****************************************************************************/
BOOL CBubbleHome::find_set_bomb()
{
	BOOL found = rule_bomb(tbl,char_bomb);

	if( found )	// found bomb ?
	{
		action.bomb_act = TRUE;

		count_bomb[0]++;			// next level of bomb

		for( int i = 1; i < HOME_TABLE_I-1; i++ )
			for( int j = 1; j < HOME_TABLE_J-1; j++ )
				if( char_bomb[i][j] )
				{
					set_act(tbl[i][j],EA_BOMB);
					count_bomb[count_bomb[0]]++;

					if( tbl[i-1][j].species == EC_CYAN ) // above
						set_act(tbl[i-1][j],EA_BOMB);
					if( tbl[i+1][j].species == EC_CYAN ) // bottom
						set_act(tbl[i+1][j],EA_BOMB);
					if( tbl[i][j-1].species == EC_CYAN ) // left
						set_act(tbl[i][j-1],EA_BOMB);
					if( tbl[i][j+1].species == EC_CYAN ) // right
						set_act(tbl[i][j+1],EA_BOMB);

					pos_bomb.i = i;
					pos_bomb.j = j;
				}
	}

	return found;
}

/****************************************************************************
 *
 * tick_table() // tick table
 *
 * case that pending = FALSE but something force to TRUE
 *	- obstruct_fall = TRUE
 *  - connect_delay != 0
 *
 ****************************************************************************/
void CBubbleHome::tick_table()
{
	int i,j;
	BOOL finish_blocked = FALSE;
	BOOL finish_bomb = FALSE;

	pending = obstruct_fall ? TRUE : FALSE;

	for( i = HOME_TABLE_I-2; i > 0; i-- )		// go up
		for( j = 1; j < HOME_TABLE_J-1; j++ )	// left -> right
			if(	(tbl[i][j].species == EC_CYAN)||
				(tbl[i][j].species == EC_RED)||
				(tbl[i][j].species == EC_GREEN)||
				(tbl[i][j].species == EC_BLUE)||
				(tbl[i][j].species == EC_YELLOW)||
				(tbl[i][j].species == EC_MAGENTA)
			)
			switch (tbl[i][j].action)
			{
/* EA_BLOCK */
				case EA_BLOCKED :
					tbl[i][j].tick--;
					if( !tbl[i][j].tick )
					{
						set_act(tbl[i][j],EA_NONE);
						connect_delay = TIME_CONNECT_DELAY;
						finish_blocked = TRUE;
					}
					pending = TRUE;
					break;
/* EA_FALL */
				case EA_FALL :
					tbl[i][j].tick--;
					if( !tbl[i][j].tick )
					{
						if( tbl[i+1][j].species != EC_NONE )
						{
							set_act(tbl[i][j],EA_BLOCKED);
						}
						else
						{	// move down one cell
							set_act(tbl[i][j],EA_FALL);
							tbl[i+1][j] = tbl[i][j];

							set_char(tbl[i][j],EC_NONE,EA_NONE);
						}
					}
					pending = TRUE;
					break;
/* EA_BOMB */
				case EA_BOMB :
					tbl[i][j].tick--;
					if( !tbl[i][j].tick )
					{
						set_char(tbl[i][j],EC_NONE,EA_NONE);
						finish_bomb = TRUE;
					}
					pending = TRUE;
					break;
			}

	if( finish_blocked ) // find connect after finish blocked
	{
		find_new_connect();
	}
	else if( finish_bomb )	// find new fall block after bombed
	{
		find_new_fall();
	}

	// in this block pending = FALSE
	if( !pending )
	{
		if( connect_delay ) // are delay in connect ?
		{
			pending = TRUE;
			connect_delay--;
		}
		else // all is stay - can find bomb
		{
			if( find_set_bomb() )
			{
				pending = TRUE;
			}
		}
	}
}

/****************************************************************************
 *
 * tick() // tick Home - it's a heartbeat
 *
 ****************************************************************************/
void CBubbleHome::tick()
{
	dec_levellife();

	if( status == EH_RUNNING )	// must running
	{
		if( act.pending )
		{
			tick_act();

			// here - all other char in table is stay
			for( int i = 1; i < HOME_TABLE_I-1; i++ )
				for( int j = 1; j < HOME_TABLE_J-1; j++ )
					if( (tbl[i][j].species != EC_NONE)&&
						(tbl[i][j].action == EA_NONE) )
					{
						if( ++tbl[i][j].tick > LIMIT_TICK_COUNT )
							tbl[i][j].tick = 0;
					}
		}
		else
		{
			tick_table();
		}
	}
}

/****************************************************************************
 *
 * reset()
 *
 ****************************************************************************/
void CBubbleHome::reset()
{
	init_var();
}

/****************************************************************************
 *
 * start()
 *
 ****************************************************************************/
void CBubbleHome::start()
{
	status = EH_RUNNING;
}

/****************************************************************************
 *
 * pause()
 *
 ****************************************************************************/
void CBubbleHome::pause()
{
	status = EH_PAUSE;
}
