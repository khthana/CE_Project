// SnmpAgentDoc.cpp : implementation of the CSnmpAgentDoc class
//

#include "stdafx.h"
#include "SnmpAgent.h"

#include "SnmpAgentDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentDoc

IMPLEMENT_DYNCREATE(CSnmpAgentDoc, CDocument)

BEGIN_MESSAGE_MAP(CSnmpAgentDoc, CDocument)
	//{{AFX_MSG_MAP(CSnmpAgentDoc)
	//}}AFX_MSG_MAP
	ON_COMMAND(ID_FILE_SEND_MAIL, OnFileSendMail)
	ON_UPDATE_COMMAND_UI(ID_FILE_SEND_MAIL, OnUpdateFileSendMail)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentDoc construction/destruction

CSnmpAgentDoc::CSnmpAgentDoc()
{
}

CSnmpAgentDoc::~CSnmpAgentDoc()
{
}

BOOL CSnmpAgentDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	return TRUE;
}



/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentDoc serialization

void CSnmpAgentDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
	}
	else
	{
	}
}

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentDoc diagnostics

#ifdef _DEBUG
void CSnmpAgentDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CSnmpAgentDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentDoc commands
