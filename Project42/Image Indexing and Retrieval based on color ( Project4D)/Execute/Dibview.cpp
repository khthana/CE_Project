// dibview.cpp : implementation of the CDibView class
//
// This is a part of the Microsoft Foundation Classes C++ library.
// Copyright (C) 1992-1998 Microsoft Corporation
// All rights reserved.
//
// This source code is only intended as a supplement to the
// Microsoft Foundation Classes Reference and related
// electronic documentation provided with the library.
// See these sources for detailed information regarding the
// Microsoft Foundation Classes product.

#include "stdafx.h"
#include "diblook.h"

#include "dibdoc.h"
#include "dibview.h"
#include "dibapi.h"
#include "diboper.h"
#include "ResultDlg.h"
#include "Threshold.h"
#include "DataDialog.h"
#include "mainfrm.h"

#include <stdio.h>
#include <stdlib.h>
#include <io.h>
#include <math.h>

#define max(a, b)  (((a) > (b)) ? (a) : (b))  
#define min(a, b)  (((a) < (b)) ? (a) : (b))

#ifdef _DEBUG
#undef THIS_FILE
static char BASED_CODE THIS_FILE[] = __FILE__;
#endif

struct Result
{
	CString filename;
	float H;
	double ModelSize;
	CString DATA;
	float avg;
	Result *next_up;
	Result *next_down;
};

/////////////////////////////////////////////////////////////////////////////
// CDibView

IMPLEMENT_DYNCREATE(CDibView, CScrollView)

BEGIN_MESSAGE_MAP(CDibView, CScrollView)
	//{{AFX_MSG_MAP(CDibView)
	ON_COMMAND(ID_EDIT_COPY, OnEditCopy)
	ON_UPDATE_COMMAND_UI(ID_EDIT_COPY, OnUpdateEditCopy)
	ON_COMMAND(ID_EDIT_PASTE, OnEditPaste)
	ON_UPDATE_COMMAND_UI(ID_EDIT_PASTE, OnUpdateEditPaste)
	ON_MESSAGE(WM_DOREALIZE, OnDoRealize)
//	ON_COMMAND(ID_TOOL_RGBVALUE, OnToolRgbvalue)
	ON_WM_LBUTTONDOWN()
	ON_WM_MOUSEMOVE()
	ON_COMMAND(ID_TOOL_MATCHING, OnToolMatching)
	ON_UPDATE_COMMAND_UI(ID_TOOL_DATABASE, OnUpdateToolDatabase)
	ON_COMMAND(ID_TOOL_DATABASE, OnToolDatabase)
	ON_COMMAND(ID_OPTION_SETBOXCOLOR, OnOptionSetboxcolor)
	ON_COMMAND(ID_OPTION_ROTATEFRAMEBOX, OnOptionRotatebox)
    //}}AFX_MSG_MAP

	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CScrollView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CScrollView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDibView construction/destruction

CDibView::CDibView()
{
	m_database = FALSE;
	boxColor = 0,0,0;
	// default value of threshold
	detail = "no data";
	origin = "80";
	
}

CDibView::~CDibView()
{
}

/////////////////////////////////////////////////////////////////////////////
// CDibView drawing

void CDibView::OnDraw(CDC* pDC)
{
	CDibDoc* pDoc = GetDocument();

	HDIB hDIB = pDoc->GetHDIB();
	if (hDIB != NULL)
	{
		LPSTR lpDIB = (LPSTR) ::GlobalLock((HGLOBAL) hDIB);
		int cxDIB = (int) ::DIBWidth(lpDIB);         // Size of DIB - x
		int cyDIB = (int) ::DIBHeight(lpDIB);        // Size of DIB - y
		::GlobalUnlock((HGLOBAL) hDIB);
		CRect rcDIB;
		rcDIB.top = rcDIB.left = 0;
		rcDIB.right = cxDIB;
		rcDIB.bottom = cyDIB;
		CRect rcDest;

		if (pDC->IsPrinting())   // printer DC
		{
			// get size of printer page (in pixels)
			int cxPage = pDC->GetDeviceCaps(HORZRES);
			int cyPage = pDC->GetDeviceCaps(VERTRES);
			// get printer pixels per inch
			int cxInch = pDC->GetDeviceCaps(LOGPIXELSX);
			int cyInch = pDC->GetDeviceCaps(LOGPIXELSY);

			//
			// Best Fit case -- create a rectangle which preserves
			// the DIB's aspect ratio, and fills the page horizontally.
			//
			// The formula in the "->bottom" field below calculates the Y
			// position of the printed bitmap, based on the size of the
			// bitmap, the width of the page, and the relative size of
			// a printed pixel (cyInch / cxInch).
			//
			rcDest.top = rcDest.left = 0;
			rcDest.bottom = (int)(((double)cyDIB * cxPage * cyInch)
					/ ((double)cxDIB * cxInch));
			rcDest.right = cxPage;

		}
		else   // not printer DC
		{
			rcDest = rcDIB;
		}

		::PaintDIB(pDC->m_hDC, &rcDest, hDIB,
			&rcDIB, pDoc->GetDocPalette());
	
		// for show first point of box boundary

			TEXTMETRIC textMetric;
			// Get the current font's height.
			pDC->GetTextMetrics(&textMetric);
			int fontHeight = textMetric.tmHeight;
			// Get the height of the picture.
			int textPos = cyDIB + 10;    
			char str[81];
		
			// Show start point that send to calculate histogram
			wsprintf(str,"starting point = %d,%d",pDoc->start_point.x,pDoc->start_point.y);
			pDC->TextOut(70, textPos, str);
			textPos += fontHeight + 10;

		if (!target.IsEmpty())
		
		{    
	
			int tmp = (int)Model_Size;
			wsprintf(str,"Total size of Model : %d",tmp);
			pDC->TextOut(70, textPos, str);
			textPos += fontHeight;

			tmp = (int)Target_Size;
			wsprintf(str,"Total size of Target : %d",tmp);
			pDC->TextOut(70, textPos, str);
			textPos += fontHeight;
			SetScrollSizes(MM_TEXT, CSize(cxDIB,textPos));

		}
	
		// Draw box boundary
		UINT x1 = pDoc->start_point.x;
		UINT y1 = pDoc->start_point.y;
		UINT x2 = pDoc->end_point.x;
		UINT y2 = pDoc->end_point.y;

		boxWidth  = x2 - x1;
		boxHeight = y2 - y1;
		
		CBrush brush(boxColor);

		pDC->FrameRect(CRect(x1,y1,x2,y2),&brush);
	}
}

/////////////////////////////////////////////////////////////////////////////
// CDibView printing

BOOL CDibView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

/////////////////////////////////////////////////////////////////////////////
// CDibView commands


LRESULT CDibView::OnDoRealize(WPARAM wParam, LPARAM)
{
	ASSERT(wParam != NULL);
	CDibDoc* pDoc = GetDocument();
	if (pDoc->GetHDIB() == NULL)
		return 0L;  // must be a new document

	CPalette* pPal = pDoc->GetDocPalette();
	if (pPal != NULL)
	{
		CMainFrame* pAppFrame = (CMainFrame*) AfxGetApp()->m_pMainWnd;
		ASSERT_KINDOF(CMainFrame, pAppFrame);

		CClientDC appDC(pAppFrame);
		// All views but one should be a background palette.
		// wParam contains a handle to the active view, so the SelectPalette
		// bForceBackground flag is FALSE only if wParam == m_hWnd (this view)
		CPalette* oldPalette = appDC.SelectPalette(pPal, ((HWND)wParam) != m_hWnd);

		if (oldPalette != NULL)
		{
			UINT nColorsChanged = appDC.RealizePalette();
			if (nColorsChanged > 0)
				pDoc->UpdateAllViews(NULL);
			appDC.SelectPalette(oldPalette, TRUE);
		}
		else
		{
			TRACE0("\tSelectPalette failed in CDibView::OnPaletteChanged\n");
		}
	}

	return 0L;
}

void CDibView::OnInitialUpdate()
{
	CScrollView::OnInitialUpdate();
	ASSERT(GetDocument() != NULL);
	SetScrollSizes(MM_TEXT, GetDocument()->GetDocSize());	}


void CDibView::OnActivateView(BOOL bActivate, CView* pActivateView,
					CView* pDeactiveView)
{
	CScrollView::OnActivateView(bActivate, pActivateView, pDeactiveView);

	if (bActivate)
	{
		ASSERT(pActivateView == this);
		OnDoRealize((WPARAM)m_hWnd, 0);   // same as SendMessage(WM_DOREALIZE);
	}
}

void CDibView::OnEditCopy()
{
	CDibDoc* pDoc = GetDocument();
	// Clean clipboard of contents, and copy the DIB.

	if (OpenClipboard())
	{
		BeginWaitCursor();
		EmptyClipboard();
		SetClipboardData (CF_DIB, CopyHandle((HANDLE) pDoc->GetHDIB()) );
		CloseClipboard();
		EndWaitCursor();
	}
}



void CDibView::OnUpdateEditCopy(CCmdUI* pCmdUI)
{
	pCmdUI->Enable(GetDocument()->GetHDIB() != NULL);
}


void CDibView::OnEditPaste()
{
	HDIB hNewDIB = NULL;

	if (OpenClipboard())
	{
		BeginWaitCursor();

		hNewDIB = (HDIB) CopyHandle(::GetClipboardData(CF_DIB));

		CloseClipboard();

		if (hNewDIB != NULL)
		{
			CDibDoc* pDoc = GetDocument();
			pDoc->ReplaceHDIB(hNewDIB); // and free the old DIB
			pDoc->InitDIBData();    // set up new size & palette
			pDoc->SetModifiedFlag(TRUE);

			SetScrollSizes(MM_TEXT, pDoc->GetDocSize());
			OnDoRealize((WPARAM)m_hWnd,0);  // realize the new palette
			pDoc->UpdateAllViews(NULL);
		}
		EndWaitCursor();
	}
}


void CDibView::OnUpdateEditPaste(CCmdUI* pCmdUI)
{
	pCmdUI->Enable(::IsClipboardFormatAvailable(CF_DIB));
}

void CDibView::Rgbvalue() 
{
	CDibDoc* pDoc = GetDocument();

	int x1 = pDoc->start_point.x;
	int y1 = pDoc->start_point.y;
	int x2 = pDoc->end_point.x;
	int y2 = pDoc->end_point.y;
	
	boxWidth = x2 - x1;
	boxHeight = y2- y1;

	HDIB hDIB = pDoc->GetHDIB();
	LPSTR lpDIB = (LPSTR) ::GlobalLock((HGLOBAL) hDIB);
	int width = (int) ::DIBWidth(lpDIB);         // Size of DIB - x
	int height = (int) ::DIBHeight(lpDIB);        // Size of DIB - y
	::GlobalUnlock((HGLOBAL) hDIB);
		
		// if not choose boundary set boudary to over all image
/*		if (boxWidth <= 0 || boxHeight <= 0)
		{
			//x1 = 5; y1 = 5;
			x2 = width; y2 = height;
			boxWidth = width;
			boxHeight = height;
			pDoc->start_point.x = x1;
			pDoc->start_point.y = y1;
			pDoc->end_point.x = x2;
			pDoc->end_point.y = y2;
		}
*/		
	// check that already defined boundary yet
	if (boxHeight > 0 && boxWidth > 0)
	{	
		// check box boundary if outside picture not store histogram & file
		if (x2 > width || y2 > height)
		{
			AfxMessageBox("Outside boundary! Choose new area");
			if (!target.IsEmpty())
				target.Empty();
		}
/*			// clear points & target 
			target.Empty();
			pDoc->start_point = 0;
			pDoc->end_point = 0;
			Invalidate();
		
*/		else
		{
			CPalette* cPal = pDoc->GetDocPalette();

/////////////// save value in temp buff for show /////////////////////

			BeginWaitCursor();

			ToScreen hisbuff = InitHistogram(hisbuff);

			for (int v=0; v<boxHeight; ++v)//150
			{	
				for (int h=0; h<boxWidth; ++h)//190
				{
					HSVQUAD	value = ::findHSV(hDIB,cPal,x1,y1);

					hisbuff = :: StoreHistogram(hisbuff,value);
					x1 += 1;
				}
				x1 -= boxWidth;	y1 += 1;
			}
	
			EndWaitCursor();
// END TRANSFORM AND QUANTIZE
////////////////////////////////////////////////////////////////////
			
			target = CountHistogram(hisbuff);

			if (m_database == TRUE)
			{
				CDataDialog data;
				data.DoModal();
				if (data.m_data != "")
					detail = data.m_data;
				//AfxMessageBox(detail);

				// get save path from application
				extern	CString path;
				CString name = path;
				name.Replace("\\","/");
				name += "/hisDB/";

				// get picture name for save
				name += pDoc->GetTitle();
			//	target += "*";
				target += detail; 
			
				// save picture and histogram and return file's buffer
				::SaveFile(hDIB,name,target);
			}

			// for show Array's Size of target & model		
			Invalidate();
				
		}// end of else in picture boundary
	
	}//end of if open image
	else
	{
		AfxMessageBox("Please select area to compute histogram");
		if (!target.IsEmpty())
			target.Empty();
	}
}


void CDibView::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CDibDoc* pDoc = GetDocument();

	HDIB hDIB = pDoc->GetHDIB();
	if (hDIB != NULL)
	{	
		pDoc -> start_point = point;
		Invalidate();
	}
	else
		AfxMessageBox("no image");

	CScrollView::OnLButtonDown(nFlags, point);

}

void CDibView::OnMouseMove(UINT nFlags, CPoint point) 
{
	CDibDoc* pDoc = GetDocument();
	HDIB hDIB = pDoc->GetHDIB();

	if (hDIB != NULL)
	
	{
		while (nFlags)
		{
			pDoc -> end_point = point;
			nFlags = 0;			
			Invalidate();
		}
	}
	
	else
		AfxMessageBox("no image");

  CScrollView::OnMouseMove(nFlags, point);
}

void CDibView::OnToolMatching() 
{ 
	Rgbvalue();
	GetThreshold();

	if (show == FALSE)
		target.Empty();

	if (!target.IsEmpty())
	{
		struct _finddata_t his_file;
		long hFile;
	
		extern	CString path;

		// to find in path /*.his
		CString dir = path;
		dir.Replace("\\","/");
	
		dir += "/hisDB/";		
				
		// Find first .his file in specified directory 	
		CString model;

		if( (hFile = _findfirst( dir + "*.his", &his_file )) == -1L )
			AfxMessageBox("Can't find .his file");
	
		else
		{    
			//AfxMessageBox("Found .his file");
				
			// for first file that has .his
			CStdioFile fileRead( dir + his_file.name, CFile::modeRead );
			fileRead.ReadString(model);
			fileRead.Close();
	
			// CONVERT MODEL 1//			 
			int c = 0;
			int order = 0;
			int expo ;
			int count = 0;
			double num = 0 ;
		//	char  *temp,*stop;
		    expo = model.Find('|');
			model.SetAt(expo,'x');
			--expo;
			int total = 0;
			char cnum;
	//		char runji;
	
	//	while (c < (model.GetLength()-1) )
		while (model.GetAt(c) != '*')
		{
			if(model.GetAt(++c) != '*')
			{ c--;

		//	runji = model.GetAt(c);	
			if (model.GetAt(c) == 'x' )
			{ 
				if (model.GetAt(++c) != ' ')
				{
				//	runji = model.GetAt(c);
					c--;
					expo = model.Find('|');
					model.SetAt(expo,'x');
					expo = expo - (c + 2) ;
					++c; 
					num = 0;
				}else
				{
					expo = model.Find('|');
					model.SetAt(expo,'x');
					expo = expo -( c + 2);
					num = 0 ; 
					++c;
				}
			}
			else
			{
				cnum = model.GetAt(c++);
				count = asctoint(cnum);
				num = pow(10,expo)*count+num;				
				--expo;
			  if (expo == -1)
				{model_buff[order++] = num;}
			}
			} // end if up
		}
		// END CONVET MODEL 1 // 
			// CATCH DATA
		CString DATAtemp;

		DATAtemp = "";
		c++;
		while (c != model.GetLength())
		{DATAtemp += model.GetAt(c++) ;}
			// END CATCH DATA
		//CONVERT TARGET //
			
			   c = 0;
			   order = 0;
			   count = 0;
			   num = 0 ;
			   expo = target.Find('|'); 
		if (expo != -1 )
		{

			 target.SetAt(expo,'x');
			--expo;

		while (target.GetAt(c) != '*')
		{
			if(target.GetAt(++c) != '*') // if up
			{ c--;
	
			if (target.GetAt(c) == 'x' )
			{ 
				if (target.GetAt(++c) != ' ')
				{
				//	runji = model.GetAt(c);
					c--;
					expo = target.Find('|');
					target.SetAt(expo,'x');
					expo = expo - (c + 2) ;
					++c; 
					num = 0;
				}else
				{
					expo = target.Find('|');
					target.SetAt(expo,'x');
					expo = expo -( c + 2);
					num = 0 ; 
					++c;
				}
			}
			else
			{
				cnum = target.GetAt(c++);
				count = asctoint(cnum);
				num = pow(10,expo)*count+num;				
				--expo;
			  if (expo == -1)
				{target_buff[order++] = num;}
			}
			} // end if up
		}
		} // end if
		// END CONVERT TARGET
		// CATCH DATA

		// END CATCH DATA


			// NORMALIZATION //
			Model_Size = 0;
			double Top,Down;
			double old_target[32];
			Target_Size = boxWidth * boxHeight;
			Old_Target = Target_Size;
			for (int k=0;k<=32;++k)
			{old_target[k] = target_buff[k];}
			for (int i=1;i<=5;++i)
			{Model_Size = model_buff[i+26]+ Model_Size;}

			double Normalize;
			 Top = max(Target_Size,Model_Size);
			 Down = min(Target_Size,Model_Size);
			   Normalize = Top/Down;// always more than or equal 1 
			   Normalize = floor(Normalize);
			   if (Normalize == 0.0)
				{Normalize = 1;}
			   if (Top == Model_Size) // Model is bigger than target
			   {  for (int i = 0;i <=32;++i)
					{target_buff[i] = target_buff[i]*Normalize;}
				  Target_Size = Target_Size*Normalize;
			   }
			   else 
				{
				   for (int j = 0;j <=32;++j)
				   { model_buff[j] = model_buff[j]*Normalize;}
				   Model_Size = Model_Size*Normalize;
				}	

			// for show model size
		//	   Invalidate();

			// END NORMALIZATION //
			float Ma = HisIntersectAVG(target_buff,model_buff);
			float Mh = HisIntersectH(target_buff,model_buff);	

///////////////////////////////////////////////////////////
////////////// histogram intersection
				
			// initial value of list
			Result *node = NULL, *list_h = NULL, *list_t = NULL , *insert = NULL;

			// create new node
			node = new Result;				
			node->filename = his_file.name;
			node->avg = Ma;
			node->H = Mh;
			node->ModelSize = Model_Size;
			node->DATA = DATAtemp;
			list_h = node;
			list_t = node;
			list_t->next_down = NULL;
			list_t->next_up = NULL;
		
			// find similarity
				
			// for all other file that has .his in that directory
			while ( _findnext( hFile, &his_file ) == 0 )
			{
				CStdioFile fileRead( dir + his_file.name, CFile::modeRead );
				fileRead.ReadString(model);
				fileRead.Close();

				// call histogram intersection
			//CONVET MODEL 2//
			c = 0;
			order = 0;
			expo = 0 ;
			count = 0;
			num = 0 ;
		    expo = model.Find('|');
			model.SetAt(expo,'x');
			--expo;
	//		int runji = 0;
			
	//	while (c < (model.GetLength()-1) )
		while (model.GetAt(c) != '*')
		{
			if(model.GetAt(++c) != '*')
			{ c--;

			if (model.GetAt(c) == 'x' )
			{ 
				if (model.GetAt(++c) != ' ')
				{
			//		runji = model.GetAt(c);
					c--;
					expo = model.Find('|');
					model.SetAt(expo,'x');
					expo = expo - (c + 2) ;
					++c; 
					num = 0;
				}else
				{
					expo = model.Find('|');
					model.SetAt(expo,'x');
					expo = expo -( c + 2);
					num = 0 ; 
					++c;
				}
			}
			else
			{
				cnum = model.GetAt(c++);
				count = asctoint(cnum);
				num = pow(10,expo)*count+num;				
				--expo;
			  if (expo == -1)
				{model_buff[order++] = num;}
			}
			} //end if up
		}
		// END CONVERT MODEL 2 //
		// CATCH DATA
		DATAtemp = "";
		c++;
		while (c != model.GetLength())
		{DATAtemp += model.GetAt(c++) ;}
		// END CATCH DATA
	//		++murf;
			// NORMALIZATION //
			
		     Model_Size = 0;
			 Target_Size = Old_Target;
			 for(int k=0;k>=32;++k)
			 {target_buff[k] = old_target[k];}
			for (int i=1;i<=5;++i)
				{Model_Size = model_buff[i+26]+ Model_Size;}
			 Top = max(Target_Size,Model_Size);
			 Down = min(Target_Size,Model_Size);
			   Normalize = Top/Down;// always more than or equal 1 
			   Normalize = floor(Normalize);
			   if (Normalize == 0.0) 
				{Normalize = 1;}
			   if (Top == Model_Size) // target is bigger than model
			   {  for (int i = 0;i <=32;++i)
					{target_buff[i] = target_buff[i]*Normalize;}
				  Target_Size = Target_Size*Normalize;
			   }
			   else 
				{
				   for (int j = 0;j <=32;++j)
					{ model_buff[j] = model_buff[j]*Normalize;}
				   Model_Size = Model_Size*Normalize;
				}	
			// END NORMALIZATION //


			float Ma =  HisIntersectAVG(target_buff,model_buff);
			float Mh =  HisIntersectH(target_buff,model_buff);
		
		

			// SORT OF LIST //  	
			float pot;
			

			insert = list_h;
			list_t = list_h;
			node = new Result;
		while(insert)
		{
			pot = insert->H ;
		//	pot = insert->avg;
	
			list_t = insert;
			if (Mh/*Ma*/ > pot) // top  
			{
				if (insert->next_up == NULL) // one child
				{
					list_h = node;
					node->next_down = insert;
					node->next_up = NULL;
					insert->next_up = node;
			
					insert = NULL;
				}
				else  // there is node up and down child
				{
					list_t = insert->next_up;
					list_t->next_down = node;
					node->next_up = list_t;
					insert->next_up = node;
					node->next_down = insert;
			
				}
				insert = NULL;
			}
			else if (insert->next_down == NULL)  //end of list   // rear  
			{
				node->next_up = insert;
				insert->next_down = node;
				node->next_down = NULL;
			
				insert = NULL;
			}  // end else if
			else { insert = insert->next_down ;}
			
		} // end while
				node->filename = his_file.name;
				node->avg = Ma;
				node->H = Mh;
				node->ModelSize = Model_Size;
				node->DATA = DATAtemp;

			// END SORT OF LIST//
				
			}// end while
			

	//		char buff_str[10];
	//		int list_length = 0;

			// for pass avg value
			float match;
			CString info;
			float Tthres;
			bool  firsttime = false ;
			Tthres = (float)threshold/100;
						
			int times = 0;
			BOOL reset;
			//	insert = list_h;
			CResultDlg Dlg;
			reset = FALSE;
			while (list_h)
			{		
				node = list_h;
				list_h = list_h->next_down;
				CString n = node->filename + " ";
				match = node->H;
				info = node->DATA;

				if ( match < Tthres)
				{	list_h = NULL;	}
				else
				{
				// For show result dialog
				n.Replace(".his",".bmp");
				n.Replace(".HIS",".bmp");

				CString fileResult = dir+n;
			 	times += 1;
				Dlg.InitPath(fileResult,n,match,info,reset);
				if (reset == TRUE)
					reset = FALSE;
				firsttime = true ;
				if (times % 5 == 0)
				{
				reset = TRUE;						
					//Dlg.DoModal();
					// IDOK = NEXT, IDCANCEL = BACK
						if (Dlg.DoModal() == IDCANCEL)  
					{
						if (times == 5)
						{ list_h = NULL;}
						else
						{
							if(list_h == NULL)
							{
								list_h = node;
								times--;
								for (int k=1;k<10;k++)
								{	
									list_h = list_h->next_up;
									times--;
								}
							}
							else
							{
								for (int i=1;i<11;i++)
								{
									list_h = list_h->next_up;
									times--;
								}
							}
						}
					}
				}
					// list BACK 5 image
				}
		
			
			if (firsttime == false)
				{ 
					AfxMessageBox("NO picture found");
					list_h = NULL;
				}
			else 
			{	
				if (list_h == NULL) // not divide by 5
				{   

					if (times < 5) //picture found less than 5
					{
						Dlg.DoModal(); 
						reset = TRUE;						
					}
					if (times > 5 && times % 5 != 0)
					{

					reset = TRUE;
						if (Dlg.DoModal() == IDCANCEL) 
					{
							// it's next node that not show
							list_h = node; 

						int m = times % 5;
						for (int j=0;j < m;j++)
						{
							list_h = list_h->next_up;
							times--;
						}
						for (int i=0;i<5;i++)
						{
							list_h = list_h->next_up;
							times--;
						}
						//list_h = list_h->next_up;
						//times--;
					}
			
					}
				}			
			//Dlg.DoModal();
			}
				
			} // end while
			delete node;			
	//		delete insert;
			delete list_h;

//			Dlg.DoModal();
				
		} // end of can found .his file
	
		_findclose( hFile );

	} // end of check for target histogram
//	else 
//		AfxMessageBox("You must calculate histogram first");
}

ToScreen CDibView::InitHistogram(ToScreen bu)
{
// INITIAL BUFFER OF HISTOGRAM TO 0
	for (int ih = 0;ih < 19;++ih)
		bu.hue[ih]=0;
	for (int is = 0;is < 5;++is)
		bu.sat[is]=0;
	for (int iv = 0;iv < 5;++iv)
		bu.val[iv]=0;
	for (int ig =0;ig <6;++ig)
		bu.gra[ig] = 0;
// END INITIAL BUFFER OF HISTOGRAM OT 0
	return bu;
}

CString CDibView::CountHistogram(ToScreen hisbuff)
{
	CString histogram;
	char temp[10];
	
	for (int hcount = 0;hcount<19;++hcount)
	{ 
		histogram += _itoa(hisbuff.hue[hcount],temp,10);
		histogram += "|";
	}		
		histogram += " ";
	for (int scount = 0;scount<4;++scount)
	{
		histogram += _itoa(hisbuff.sat[scount],temp,10);
		histogram += "|";
	}
		histogram += " ";
	for (int vcount = 0;vcount<4;++vcount)
	{
		histogram += _itoa(hisbuff.val[vcount],temp,10);
		histogram += "|";
	}
		histogram += " ";
	for (int gcount = 0;gcount<5;++gcount)
	{
		histogram += _itoa(hisbuff.gra[gcount],temp,10);
		histogram += "|";
	}
	//	histogram += " ";
		histogram += "*";
	return histogram;
}

void CDibView::OnUpdateToolDatabase(CCmdUI* pCmdUI) 
{
	//if (m_database)
	pCmdUI->SetCheck(m_database);
}

void CDibView::OnToolDatabase() 
{
	m_database = !m_database;
}

void CDibView::OnOptionSetboxcolor() 
{
	CColorDialog dlgColor(boxColor);
	if (dlgColor.DoModal() == IDOK)
	{
		boxColor = dlgColor.GetColor();
		Invalidate();
	}	
}

void CDibView::OnOptionRotatebox() 
{
/*	int height = boxHeight;
	boxHeight = boxWidth;
	boxWidth = height;
	Invalidate();
*/
}

float CDibView::HisIntersectAVG(double target_buff[32],double model_buff[32])
{
		// HISTOGRAM INTERSECTION AVG 1
			int order = 0 ;
			double mini_val;
			double total_min = 0;
			double total_model = 0;
			while (order < 32)  //real is 31 count from 0
			{
				if((order != 18)||(order != 22)||(order != 26)||(order != 31))
				{
					total_model = total_model + model_buff[++order]; // min of model
					mini_val = min(target_buff[order],model_buff[order]); // min of model and target
					total_min = total_min + mini_val;   // total of model and target compare
				}
			}
			float Ma ;
			Ma =  (float)total_min/(float)total_model;
			return Ma;
		// END HISTOGRAM INTERSECTION AVG 1	

}

float CDibView::HisIntersectH(double target_buff[19],double model_buff[19])
{
			int order = 0 ;
			double mini_val = 0;
			double total_min = 0;
			double total_model = 0;
			while (order < 19) // real is 18  
			{
				total_model = total_model + model_buff[++order]; // min of model
				mini_val = min(target_buff[order],model_buff[order]); // min of model and target
				total_min = total_min + mini_val;   // total of model and target compare
			}
			float Mh ;
			Mh =  (float)total_min/(float)total_model;
			return Mh;
}

int CDibView::asctoint(char cnum)
{
	int total = 0;
	total = 10*total+(cnum-'0');
	return total;
}

void CDibView::GetThreshold()
{
	CThreshold tdlg;
	tdlg.m_threshold = origin;

	if	(tdlg.DoModal() == IDOK)
	{	
		threshold = atoi(tdlg.m_threshold);
		show = TRUE;
		if (threshold > 100)
		{
			CString msg;
			msg = "Threshold can't more than 100!\n Threshold set to default ";
			msg += origin;		msg += "%.";
			AfxMessageBox(msg);
			threshold = atoi(origin);
				//tdlg.m_threshold = origin;
				//Invalidate();
				//threshold = atoi(tdlg.m_threshold);
		}			
	}
	else
		show = FALSE;
}
