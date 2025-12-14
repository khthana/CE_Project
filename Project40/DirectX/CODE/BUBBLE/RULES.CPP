#include "string.h"
#include "rules.h"

/****************************************************************************
 *
 * BOOL rule_bomb(
 *	IN_HOME_TABLE _tbl,		// table for check HOME_TABLE_IxHOME_TABLE_J
 *	TABLE_BOME _tb			// boolean that cell bomb
 * )
 *
 ****************************************************************************/
BOOL rule_bomb(const IN_HOME_TABLE _tbl, TABLE_BOMB _tb )
{
	int i,j;
	BOOL bomb = FALSE;

	static int count_connect[HOME_TABLE_I][HOME_TABLE_J];	// for speed

	memset(count_connect,0,sizeof(count_connect));
	memset(_tb,FALSE,sizeof(TABLE_BOMB));

	for( i = HOME_TABLE_I-2; i > 0; i-- )		// go up
		for( j = 1; j < HOME_TABLE_J-1; j++ )	// left to right
		{
			if( (_tbl[i][j].species == EC_RED)||
				(_tbl[i][j].species == EC_GREEN)||
				(_tbl[i][j].species == EC_BLUE)||
				(_tbl[i][j].species == EC_YELLOW)||
				(_tbl[i][j].species == EC_MAGENTA)
			)
				count_connect[i][j] = 1;
		}

	for( i = HOME_TABLE_I-2; i > 0; i-- )		// go up
		for( j = 1; j < HOME_TABLE_J-1; j++ )	// left to right
		{
			if( _tbl[i][j].species == _tbl[i+1][j].species ) // bottom
			{
				count_connect[i][j] += count_connect[i+1][j];
			}

			if( _tbl[i][j].species == _tbl[i][j-1].species ) // left
			{
				count_connect[i][j] += count_connect[i][j-1];
				count_connect[i][j-1] = count_connect[i][j];

				int relative = 2;
				while( _tbl[i][j].species == _tbl[i][j-relative].species )
				{
					count_connect[i][j-relative] = count_connect[i][j];
					relative++;
				}
/*
				if( _tbl[i][j-1].species == _tbl[i][j-2].species )
					count_connect[i][j-2] = count_connect[i][j];
*/
			}
		}

	BOOL change = TRUE;

	while (change)
	{
		change = FALSE;

		for( i = HOME_TABLE_I-2; i > 0; i-- )		// go up
			for( j = 1; j < HOME_TABLE_J-1; j++ )	// left to right
				if( !_tb[i][j] )
				{
					if( count_connect[i][j] >= CONNECT_BOMB )
					{
						_tb[i][j] = TRUE;
						change = TRUE;
					}
					else
					{
						if( (_tb[i-1][j])&&
							(_tbl[i][j].species == _tbl[i-1][j].species))
						{
							_tb[i][j] = TRUE;
							change = TRUE;
						}
						else if( (_tb[i][j+1])&&
							(_tbl[i][j].species == _tbl[i][j+1].species))
						{
							_tb[i][j] = TRUE;
							change = TRUE;
						}
						else if( (_tb[i+1][j])&&
							(_tbl[i][j].species == _tbl[i+1][j].species))
						{
							_tb[i][j] = TRUE;
							change = TRUE;
						}
						else if( (_tb[i][j-1])&&
							(_tbl[i][j].species == _tbl[i][j-1].species))
						{
							_tb[i][j] = TRUE;
							change = TRUE;
						}
					}
				}

		if( change )
		{
			bomb = TRUE;	// that bomb;
		}
	}

	return bomb;
}

/****************************************************************************
 *
 * calculate_cont_bomb(const CONT_BOMB _cb)
 *
 ****************************************************************************/
int calculate_cont_bomb(const CONT_BOMB _cb)
{
	int cal = 0;
	int mul = 1;

	for(int i = 1; i <= _cb[0]; i++ )
	{
		cal += _cb[i] * mul/4;

		mul++;
	}

	return cal;
}

