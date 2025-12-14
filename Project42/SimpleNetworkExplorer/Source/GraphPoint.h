// GraphPoint.h: interface for the CGraphPoint class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GRAPHPOINT_H__6CAAA567_0D3D_11D4_9343_00E02947F59E__INCLUDED_)
#define AFX_GRAPHPOINT_H__6CAAA567_0D3D_11D4_9343_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CGraphPoint : public CObject  
{
public:
	CGraphPoint();
	virtual ~CGraphPoint();
// Attribute
public:
	CPoint thePoint;

	// Method
public:
	void SetValue(int X,int Y);

};

#endif // !defined(AFX_GRAPHPOINT_H__6CAAA567_0D3D_11D4_9343_00E02947F59E__INCLUDED_)
