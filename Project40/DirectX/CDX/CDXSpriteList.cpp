//////////////////////////////////////////////////////////////////////////////////
// Project Name:   [ CDX Class Library - CDX.lib ]
// Source File:    [ CDXSpriteList Implementation ]
// Author:         [ Danny Farley - danny@jags.co.uk ]
// Revision:       [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXSpriteList::CDXSpriteList(void)
{
	m_List.m_Next = m_List.m_Prev = &m_List;
	m_List.SetPos(0,0);
	m_List.SetVel(0,0);

	m_nSprites = 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList Destructor
//////////////////////////////////////////////////////////////////////////////////
CDXSpriteList::~CDXSpriteList(void)
{
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList AddSprite
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::AddSprite(CDXTile* pTile, int Type,
		                                          int PosX, int PosY,
																              int VelX, int VelY,
																              int State, int Frame,
																              int Delay)
{
	CDXSprite* Node;

	// Create a new sprite
	Node = new CDXSprite(pTile);
	if(Node == NULL) return;

	// Setup sprite
	Node->SetType(Type);
	Node->SetPos(PosX, PosY);
	Node->SetVel(VelX, VelY);
	Node->SetState(State);
	Node->SetFrame(Frame);
	Node->SetDelay(Delay);

	// Add sprite too list
	Node->m_Next = m_List.m_Next;
	Node->m_Prev = &m_List;
	m_List.m_Next->m_Prev = Node;
	m_List.m_Next = Node;

	m_nSprites++;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList DelSprite
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::DelSprite(CDXSprite* pNode)
{
	if(m_List.m_Next == &m_List) return;

	m_nSprites--;

	pNode->m_Next->m_Prev = pNode->m_Prev;
	pNode->m_Prev->m_Next = pNode->m_Next;
	delete pNode;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList Draw
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::Draw(CDXSurface* lpDDS)
{
	CDXSprite* Node;

	// Loop the list and draw the objects
	for(Node = m_List.m_Next; Node != &m_List; Node = Node->m_Next)
	{
		Node->Draw(lpDDS);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList DrawFast
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::DrawFast(CDXSurface* lpDDS)
{
	CDXSprite* Node;

	// Loop the list and draw the objects
	for(Node = m_List.m_Next; Node != &m_List; Node = Node->m_Next)
	{
		Node->DrawFast(lpDDS);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList DrawTrans
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::DrawTrans(CDXSurface* lpDDS)
{
	CDXSprite* Node;

	// Loop the list and draw the objects
	for(Node = m_List.m_Next; Node != &m_List; Node = Node->m_Next)
	{
		Node->DrawTrans(lpDDS);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList DrawClipped
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::DrawClipped(CDXSurface* lpDDS, LPRECT ClipRect)
{
	CDXSprite* Node;

	// Loop the list and draw the objects
	for(Node = m_List.m_Next; Node != &m_List; Node = Node->m_Next)
	{
		Node->DrawClipped(lpDDS, ClipRect);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList DrawWindowed
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::DrawWindowed(CDXSurface* lpDDS)
{
	CDXSprite* Node;

	// Loop the list and draw the objects
	for(Node = m_List.m_Next; Node != &m_List; Node = Node->m_Next)
	{
		Node->DrawWindowed(lpDDS);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList DrawScaled
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::DrawScaled(float Factor, CDXSurface* lpDDS)
{
	CDXSprite* Node;

	// Loop the list and draw the objects
	for(Node = m_List.m_Next; Node != &m_List; Node = Node->m_Next)
	{
		Node->DrawScaled(Factor, lpDDS);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList DrawRotated
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::DrawRotated(float Angle, CDXSurface* lpDDS)
{
	CDXSprite* Node;

	// Loop the list and draw the objects
	for(Node = m_List.m_Next; Node != &m_List; Node = Node->m_Next)
	{
		Node->DrawRotated(Angle, lpDDS);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList DrawHFlip
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::DrawHFlip(CDXSurface* lpDDS)
{
	CDXSprite* Node;

	// Loop the list and draw the objects
	for(Node = m_List.m_Next; Node != &m_List; Node = Node->m_Next)
	{
		Node->DrawHFlip(lpDDS);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSpriteList DrawVFlip
//////////////////////////////////////////////////////////////////////////////////
void CDXSpriteList::DrawVFlip(CDXSurface* lpDDS)
{
	CDXSprite* Node;

	// Loop the list and draw the objects
	for(Node = m_List.m_Next; Node != &m_List; Node = Node->m_Next)
	{
		Node->DrawVFlip(lpDDS);
	}
}
