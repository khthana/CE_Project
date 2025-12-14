#include "string.h"
#include "bb_world.h"

#if defined __TURBOC__
	#define TIME_KEY_DELAY  1
	#define TIME_KEY_DOWN	0
#elif defined _WIN32
	#define	TIME_KEY_DELAY	1
	#define TIME_KEY_DOWN	0
#endif

/****************************************************************************
 *
 * CBubbleWorld() // constructor - initial all variable
 *
 ****************************************************************************/
CBubbleWorld::CBubbleWorld()
{
	int i;

	status = EW_NONE;
	player = EP_ONE;

	for( i = 0; i < MAX_HOME_IN_WORLD; i++ )
	{
		home[i].home = NULL;
		memset(home[i].key,0,sizeof home[0].key);
		memset(home[i].key_mask,0,sizeof home[0].key_mask);
		home[i].local = NULL;
	}
}

/****************************************************************************
 *
 * ~CBubbleWorld() // destructor - clean up variable
 *
 ****************************************************************************/
CBubbleWorld::~CBubbleWorld()
{
	int i;

	for( i = 0; i < MAX_HOME_IN_WORLD; i++ )
	{
		if( home[i].home != NULL )
		{
			delete home[i].home;
		}
	}
}

/****************************************************************************
 *
 * set_point_home() // set internal pointer to appropriate home data in local
 *
 ****************************************************************************/
BOOL CBubbleWorld::set_point_home(int _homeid, HOME_DAT_TO_LOCAL *_home)
{
	int playidmax = player == EP_ONE ? 0 : 1;

	if( _homeid > playidmax )
		return FALSE;

	home[_homeid].local = _home;

	return TRUE;
}

/****************************************************************************
 *
 * get_status() // get status of World
 *
 ****************************************************************************/
ENUM_WORLD_STATUS CBubbleWorld::get_status()
{
	return status;
}

/****************************************************************************
 *
 * tick() // heartbeat of World
 *
 ****************************************************************************/
void CBubbleWorld::tick()
{
	int p, k;
	int play = player == EP_ONE ? 1 : 2;

	for( p = 0; p < play; p++ )
	{
		if( home[p].home->get_status() == EH_RUNNING )
		{
			if( home[p].local->recv_bomb )
			{
				home[p].local->recv_bomb =
					home[p].home->deliver_bomb(home[p].local->recv_bomb);
			}
			else
			{
				if( home[p].home->want_new_act() )
				{
					home[p].home->set_act_char(
						home[p].local->next_color[0],
						home[p].local->next_color[1]
					);

					if( home[p].local != NULL )
						home[p].local->want_act = TRUE;
				}
			}

			for( k = EK_LEFT; k <= EK_DOWN; k++ )
				if( home[p].key[k] )
				{
					if( !home[p].key_mask[k] )
					{
						home[p].home->key_input(ENUM_INPUTKEY(k));

						if( k == EK_DOWN )
							home[p].key_mask[k] = TIME_KEY_DOWN;
						else
							home[p].key_mask[k] = TIME_KEY_DELAY;
					}
					else
					{
						home[p].key_mask[k]--;
					}
				}

			if( home[p].key[EK_CW] != home[p].key[EK_CCW] )
			{
				if( home[p].key[EK_CW] )
				{
					home[p].home->key_input(EK_CW);
					home[p].key[EK_CW] = FALSE;
				}
				else // home[p].key[EK_CCW]
				{
					home[p].home->key_input(EK_CCW);
					home[p].key[EK_CCW] = FALSE;
				}
			}

			home[p].home->tick();

			home[p].home->get_update(home[p].local->table, home[p].local->act);
			home[p].home->get_bomb(home[p].local->pos_bomb, home[p].local->count_bomb);
			home[p].home->get_action(&(home[p].local->action));
		}
		else
		{
			status = EW_PAUSE;
		}
	}
}

/****************************************************************************
 *
 * start(ENUM_PLAYER _play) // start with number of player
 *
 ****************************************************************************/
void CBubbleWorld::start(ENUM_PLAYER _play)
{
	int play, i;

	status = EW_RUNNING;
	if( (_play == EP_ONE)||(_play == EP_2ONE) )
		player = _play;
	else
		player = EP_ONE;

	play = player == EP_ONE ? 1 : 2;
	for( i = 0; i < play; i++ )
	{
		home[i].home = new CBubbleHome(i);
		home[i].home->start();
	}
}

/****************************************************************************
 *
 * stop()
 *
 ****************************************************************************/
void CBubbleWorld::stop()
{
}

/****************************************************************************
 *
 * key_press(char _key) // key press for World
 *
 ****************************************************************************/
void CBubbleWorld::key_press(char _key)
{
	switch (player)
	{
		case EP_ONE :
			switch (_key)
			{
				case KEY_ESC :
					home[0].home->pause();
					status = EW_NONE;
					break;

				case KEY2_LEFT :
					if( !home[0].key_mask[EK_LEFT] )
						home[0].key[EK_LEFT] = TRUE;
					break;

				case KEY2_RIGHT :
					if( !home[0].key_mask[EK_RIGHT] )
						home[0].key[EK_RIGHT] = TRUE;
					break;

				case KEY2_DOWN :
					if( !home[0].key_mask[EK_DOWN] )
						home[0].key[EK_DOWN] = TRUE;
					break;

				case KEY2_CW :
					if( !home[0].key_mask[EK_CW] )
					{
						home[0].key[EK_CW] = TRUE;
						home[0].key_mask[EK_CW] = 1;
					}
					break;

				case KEY2_CCW :
					if( !home[0].key_mask[EK_CCW] )
					{
						home[0].key[EK_CCW] = TRUE;
						home[0].key_mask[EK_CCW] = 1;
					}
					break;
			}
			break;

		case EP_2ONE :
			switch (_key)
			{
				case KEY_ESC :
					home[0].home->pause();
					home[1].home->pause();
					status = EW_NONE;
					break;

				case KEY1_LEFT :
					if( !home[0].key_mask[EK_LEFT] )
						home[0].key[EK_LEFT] = TRUE;
					break;

				case KEY1_RIGHT :
					if( !home[0].key_mask[EK_RIGHT] )
						home[0].key[EK_RIGHT] = TRUE;
					break;

				case KEY1_DOWN :
					if( !home[0].key_mask[EK_DOWN] )
						home[0].key[EK_DOWN] = TRUE;
					break;

				case KEY1_CW :
					if( !home[0].key_mask[EK_CW] )
					{
						home[0].key[EK_CW] = TRUE;
						home[0].key_mask[EK_CW] = 1;
					}
					break;

				case KEY1_CCW :
					if( !home[0].key_mask[EK_CCW] )
					{
						home[0].key[EK_CCW] = TRUE;
						home[0].key_mask[EK_CCW] = 1;
					}
					break;

				case KEY2_LEFT :
					if( !home[1].key_mask[EK_LEFT] )
						home[1].key[EK_LEFT] = TRUE;
					break;

				case KEY2_RIGHT :
					if( !home[1].key_mask[EK_RIGHT] )
						home[1].key[EK_RIGHT] = TRUE;
					break;

				case KEY2_DOWN :
					if( !home[1].key_mask[EK_DOWN] )
						home[1].key[EK_DOWN] = TRUE;
					break;

				case KEY2_CW :
					if( !home[1].key_mask[EK_CW] )
					{
						home[1].key[EK_CW] = TRUE;
						home[1].key_mask[EK_CW] = 1;
					}
					break;

				case KEY2_CCW :
					if( !home[1].key_mask[EK_CCW] )
					{
						home[1].key[EK_CCW] = TRUE;
						home[1].key_mask[EK_CCW] = 1;
					}
					break;
			}
			break;

	}
}

/****************************************************************************
 *
 * key_release(char _key) // key release for World
 *
 ****************************************************************************/
void CBubbleWorld::key_release(char _key)
{
	switch (player)
	{
		case EP_ONE :
			switch (_key)
			{
				case KEY2_LEFT :
					home[0].key[EK_LEFT] = FALSE;
					home[0].key_mask[EK_LEFT] = 0;
					break;

				case KEY2_RIGHT :
					home[0].key[EK_RIGHT] = FALSE;
					home[0].key_mask[EK_RIGHT] = 0;
					break;

				case KEY2_DOWN :
					home[0].key[EK_DOWN] = FALSE;
					home[0].key_mask[EK_DOWN] = 0;
					break;

				case KEY2_CW :
					home[0].key[EK_CW] = FALSE;
					home[0].key_mask[EK_CW] = 0;
					break;

				case KEY2_CCW :
					home[0].key[EK_CCW] = FALSE;
					home[0].key_mask[EK_CCW] = 0;
					break;
			}
			break;

		case EP_2ONE :
			switch (_key)
			{
				case KEY1_LEFT :
					home[0].key[EK_LEFT] = FALSE;
					home[0].key_mask[EK_LEFT] = 0;
					break;

				case KEY1_RIGHT :
					home[0].key[EK_RIGHT] = FALSE;
					home[0].key_mask[EK_RIGHT] = 0;
					break;

				case KEY1_DOWN :
					home[0].key[EK_DOWN] = FALSE;
					home[0].key_mask[EK_DOWN] = 0;
					break;

				case KEY1_CW :
					home[0].key[EK_CW] = FALSE;
					home[0].key_mask[EK_CW] = 0;
					break;

				case KEY1_CCW :
					home[0].key[EK_CCW] = FALSE;
					home[0].key_mask[EK_CCW] = 0;
					break;

				case KEY2_LEFT :
					home[1].key[EK_LEFT] = FALSE;
					home[1].key_mask[EK_LEFT] = 0;
					break;

				case KEY2_RIGHT :
					home[1].key[EK_RIGHT] = FALSE;
					home[1].key_mask[EK_RIGHT] = 0;
					break;

				case KEY2_DOWN :
					home[1].key[EK_DOWN] = FALSE;
					home[1].key_mask[EK_DOWN] = 0;
					break;

				case KEY2_CW :
					home[1].key[EK_CW] = FALSE;
					home[1].key_mask[EK_CW] = 0;
					break;

				case KEY2_CCW :
					home[1].key[EK_CCW] = FALSE;
					home[1].key_mask[EK_CCW] = 0;
					break;
			}
			break;

	}
}

