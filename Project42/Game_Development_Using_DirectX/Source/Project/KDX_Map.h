/////////////////////////////////////////////////////////////////////////////
// File Name:		KDX_Map.h
// Author:			Tiwakorn Komut
// Source File:		KDX_Map Header File
// Date:			31/03/2000
// Comment:
/////////////////////////////////////////////////////////////////////////////
#ifndef KDX_MAP_H
#define KDX_MAP_H

#include <ddraw.h>
#include "MapperConst.h"

/////////////////////////////////////////////////////////////////////////////
// Defined Type
/////////////////////////////////////////////////////////////////////////////
typedef struct tagFILEBLOCKSTATUS
{
	LONG	type;
	LONG	level;
	LONG	reserved;
}FILEBLOCKSTATUS, * LPFILEBLOCKSTATUS;

/////////////////////////////////////////////////////////////////////////////
// KDX_Map Class
/////////////////////////////////////////////////////////////////////////////
class KDX_Map
{
public:
// Methods
	KDX_Map (void);
	~KDX_Map (void);

	void Initialise (void);
	void Finalise (void);

	BOOL LoadMap (char* filename);
	void FillMap (int i1, int j1, int i2, int j2, int type, int level, int reserved);

	BLOCKSTATUS GetBlockStatus (int i, int j)	{ return m_Map[i][j]; }
	int GetBlockType (int i, int j)				{ return m_Map[i][j].type; }
	int GetBlockLevel (int i, int j)			{ return m_Map[i][j].level; }
	int GetBlockReserved (int i, int j)			{ return m_Map[i][j].reserved; }

public:
// Attribute
	BLOCKSTATUS		m_Map[MAX_BLOCK][MAX_BLOCK];
};

#endif