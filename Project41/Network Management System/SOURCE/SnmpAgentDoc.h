// SnmpAgentDoc.h : interface of the CSnmpAgentDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_SNMPAGENTDOC_H__F4E51E4B_8162_11D2_AA9B_008048FBB1F4__INCLUDED_)
#define AFX_SNMPAGENTDOC_H__F4E51E4B_8162_11D2_AA9B_008048FBB1F4__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000


class CSnmpAgentDoc : public CDocument
{
protected: // create from serialization only
	CSnmpAgentDoc();
	DECLARE_DYNCREATE(CSnmpAgentDoc)

// Attributes
public:

// Operations
public:
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSnmpAgentDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CSnmpAgentDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CSnmpAgentDoc)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SNMPAGENTDOC_H__F4E51E4B_8162_11D2_AA9B_008048FBB1F4__INCLUDED_)
