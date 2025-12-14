// SecureShellDoc.cpp : implementation of the CSecureShellDoc class
//

#include "stdafx.h"
#include "SecureShell.h"

#include "SecureShellDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSecureShellDoc

IMPLEMENT_DYNCREATE(CSecureShellDoc, CDocument)

BEGIN_MESSAGE_MAP(CSecureShellDoc, CDocument)
	//{{AFX_MSG_MAP(CSecureShellDoc)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSecureShellDoc construction/destruction

CSecureShellDoc::CSecureShellDoc()
{
	// TODO: add one-time construction code here

}

CSecureShellDoc::~CSecureShellDoc()
{
}

BOOL CSecureShellDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	((CEditView*)m_viewList.GetHead())->SetWindowText(NULL);

	// TODO: add reinitialization code here
	// (SDI documents will reuse this document)

	return TRUE;
}



/////////////////////////////////////////////////////////////////////////////
// CSecureShellDoc serialization

void CSecureShellDoc::Serialize(CArchive& ar)
{
	// CEditView contains an edit control which handles all serialization
	((CEditView*)m_viewList.GetHead())->SerializeRaw(ar);
}

/////////////////////////////////////////////////////////////////////////////
// CSecureShellDoc diagnostics

#ifdef _DEBUG
void CSecureShellDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CSecureShellDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CSecureShellDoc commands
