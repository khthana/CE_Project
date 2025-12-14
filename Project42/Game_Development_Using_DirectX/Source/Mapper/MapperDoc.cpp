// MapperDoc.cpp : implementation of the CMapperDoc class
//

#include "stdafx.h"
#include "Mapper.h"

#include "MapperDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMapperDoc

IMPLEMENT_DYNCREATE(CMapperDoc, CDocument)

BEGIN_MESSAGE_MAP(CMapperDoc, CDocument)
	//{{AFX_MSG_MAP(CMapperDoc)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMapperDoc construction/destruction

CMapperDoc::CMapperDoc()
{
	// TODO: add one-time construction code here

}

CMapperDoc::~CMapperDoc()
{
}

BOOL CMapperDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: add reinitialization code here
	// (SDI documents will reuse this document)
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	int i, j;
	for (i = 0; i < MAX_BLOCK; i++)
		for (j = 0; j < MAX_BLOCK; j++)
		{
			m_Map[i][j].type = TYPE_NONE;
			m_Map[i][j].level = 0;
			m_Map[i][j].reserved = -1;
		}
	return TRUE;
}



/////////////////////////////////////////////////////////////////////////////
// CMapperDoc serialization

void CMapperDoc::Serialize(CArchive& ar)
{
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	int i, j;

	if (ar.IsStoring())
	{
		// TODO: add storing code here
		///////////////////////////////////////////
		// My code goes here.
		///////////////////////////////////////////
		for (i = 0; i < MAX_BLOCK; i++)
			for (j = 0; j < MAX_BLOCK; j++)
			{
				ar << m_Map[i][j].type;
				ar << m_Map[i][j].level;
				ar << m_Map[i][j].reserved;
			}
	}
	else
	{
		// TODO: add loading code here
		///////////////////////////////////////////
		// My code goes here.
		///////////////////////////////////////////
		for (i = 0; i < MAX_BLOCK; i++)
			for (j = 0; j < MAX_BLOCK; j++)
			{
				ar >> m_Map[i][j].type;
				ar >> m_Map[i][j].level;
				ar >> m_Map[i][j].reserved;
			}
	}
}

/////////////////////////////////////////////////////////////////////////////
// CMapperDoc diagnostics

#ifdef _DEBUG
void CMapperDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CMapperDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMapperDoc commands
