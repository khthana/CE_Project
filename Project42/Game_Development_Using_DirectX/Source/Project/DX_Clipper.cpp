/////////////////////////////////////////////////////////////////////////////
// File Name:	DX_Clipper.cpp
// Author:		Tiwakorn Komut
// Source File:	DX_Clipper Implementation
// Date:		14/02/2000
/////////////////////////////////////////////////////////////////////////////
#include "DX.h"

/////////////////////////////////////////////////////////////////////////////
// DX_Clipper Constructor
/////////////////////////////////////////////////////////////////////////////
DX_Clipper::DX_Clipper (void)
{
	Initialise ();
}

/////////////////////////////////////////////////////////////////////////////
// DX_Clipper Destructor
/////////////////////////////////////////////////////////////////////////////
DX_Clipper::~DX_Clipper (void)
{
	Finalise ();
}

/////////////////////////////////////////////////////////////////////////////
// DX_Clipper Initialise
/////////////////////////////////////////////////////////////////////////////
void DX_Clipper::Initialise (void)
{
	m_Clipper = NULL;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Clipper Finalise
/////////////////////////////////////////////////////////////////////////////
void DX_Clipper::Finalise (void)
{
	SAFE_RELEASE (m_Clipper);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Clipper AttachClipper
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Clipper::AttachClipper (DX_Screen* engine, DX_Surface* Dest, int num_rects, LPRECT clip_list)
{
	HRESULT rval;
	LPRGNDATA region_data;

	// Create DirectDrawClipper object
	if (FAILED (rval = engine->GetDD ()->CreateClipper (0, &m_Clipper, NULL)))
		return rval;

	if (num_rects == 1 && clip_list == NULL)
	{
		// Create full screen clipper
		RECT clip = {0, 0, Dest->GetWidth (), Dest->GetHeight ()};
		clip_list = &clip;
	}
		
	// Allocate memory for the region data
	region_data = (LPRGNDATA)malloc (sizeof (RGNDATAHEADER) + num_rects*sizeof (RECT));

	// Copy the rects into region data
	memcpy (region_data->Buffer, clip_list, num_rects*sizeof (RECT));

	// Setup fielda of header
	region_data->rdh.dwSize = sizeof (RGNDATAHEADER);
	region_data->rdh.iType = RDH_RECTANGLES;
	region_data->rdh.nCount = num_rects;
	region_data->rdh.nRgnSize = num_rects*sizeof (RECT);
	region_data->rdh.rcBound.left = 64000;
	region_data->rdh.rcBound.top = 64000;
	region_data->rdh.rcBound.right = -64000;
	region_data->rdh.rcBound.bottom = -64000;

	// Find bound of all regions
	for (int i = 0; i < num_rects; i++)
	{
		// Test whether next rectangle unioned the current bound is larger
		if (clip_list[i].left < region_data->rdh.rcBound.left)
			region_data->rdh.rcBound.left = clip_list[i].left;

		if (clip_list[i].right > region_data->rdh.rcBound.right)
			region_data->rdh.rcBound.right = clip_list[i].right;

		if (clip_list[i].top < region_data->rdh.rcBound.top)
			region_data->rdh.rcBound.top = clip_list[i].top;

		if (clip_list[i].bottom > region_data->rdh.rcBound.bottom)
			region_data->rdh.rcBound.bottom = clip_list[i].bottom;
	}

	// Set the clipping list
	if (FAILED (rval = m_Clipper->SetClipList (region_data, 0)))
	{
		// Release memory and return ERROR!
		free (region_data);
		return rval;
	}

	// Attach the clipper to the surface
	rval = Dest->GetSurface ()->SetClipper (m_Clipper);

	// Release memory
	free (region_data);

	// Return result
	return rval;
}