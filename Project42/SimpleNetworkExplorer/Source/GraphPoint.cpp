// GraphPoint.cpp: implementation of the CGraphPoint class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "GraphPoint.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CGraphPoint::CGraphPoint()
{

}

CGraphPoint::~CGraphPoint()
{

}

void CGraphPoint::SetValue(int X,int Y)
{
	thePoint.x = X;
	thePoint.y = Y;
}

