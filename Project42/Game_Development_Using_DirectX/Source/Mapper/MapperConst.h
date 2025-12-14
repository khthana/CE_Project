/////////////////////////////////////////////////////////////////////////////
// File Name:		MapperConst.h
// Author:			Tiwakorn Komut
// Source File:		Mapper Header File
// Date:			30/03/2000
// Comment:
/////////////////////////////////////////////////////////////////////////////
#ifndef MAPPERCONST_H
#define MAPPERCONST_H

/////////////////////////////////////////////////////////////////////////////
// Defined type
/////////////////////////////////////////////////////////////////////////////
typedef struct tagBLOCKSTATUS
{
	int		type;					// type of block
	int		level;					// level of block
	int		reserved;				// special field
} BLOCKSTATUS, * LPBLOCKSTATUS;

/////////////////////////////////////////////////////////////////////////////
// Defined constants
/////////////////////////////////////////////////////////////////////////////
// types
#define TYPE_NONE			0
#define TYPE_NORMAL			1
#define TYPE_BLOCKED		2
#define TYPE_GRASS			3
#define TYPE_WATER			4
#define TYPE_BUILDING		5
#define TYPE_SPECIAL		6

// Colors
#define COLOR_CONST1		25
#define COLOR_CONST2		50
#define COLOR_FACTOR		10

// Update
#define UPDATE_NORMAL		0
#define UPDATE_CONVERT		1

// Map
#define BLOCK				10		// block Width and Height
#define MAX_BLOCK			80		// number of blocks in X and Y
#define OFFSET				50		// offset of map

#endif