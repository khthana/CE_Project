#if !defined(AFX_DIAGRAM_H__90CB7C06_E5C4_11D3_92E1_00E02947F59E__INCLUDED_)
#define AFX_DIAGRAM_H__90CB7C06_E5C4_11D3_92E1_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Diagram.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDiagram window

class CDiagram : public CStatic
{
// Construction
public:
	CDiagram();

// Attributes
public:
	BOOLEAN Exist;			// if Exist = TRUE ->this Diagram is be displayed (Must delete from Popup Menu)
	CWnd* ParentWnd;  // use to be the pointer for "CNetworkDiagramDlg"	Class

protected:
	CBitmap m_Bitmap;		// m_Bitmap = CBitmap of this Diagram(be Resource Bitmap ID)
	CPoint Pos;				// Pos = CPoint that point to TOP-Left of Bitmap
	CRect m_BoundingRect;   // = the boundary of Dragging Diagram
	CRect BitmapRect;		// = the rectangular of Diagram bitmap(m_Bitmap) 

// Operations
public:
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDiagram)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CDiagram();
    void Show(CWnd* pParentWnd,CRect & rect, UINT nBitmapID);
	// method to display this Diagram at rect in pParentWnd(Window) by nBitmapID(Bitmap)
    void SetBoundRect(CRect &boundRect);
	//method to set the boundary of Dragging Diagram
	CRect MoveDiagram(CPoint point);
	//method to move Diagram follow to point
	void SetExist(BOOLEAN BeExisted);
	//method to set value of Exist 
	CPoint GetPosition();
	//method to return the Point of Bitmap

// Generated message map functions
protected:
	//{{AFX_MSG(CDiagram)
		// NOTE - the ClassWizard will add and remove member functions here.
		afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
		afx_msg CRect OnMouseMove(UINT nFlags, CPoint point);
		afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DIAGRAM_H__90CB7C06_E5C4_11D3_92E1_00E02947F59E__INCLUDED_)
