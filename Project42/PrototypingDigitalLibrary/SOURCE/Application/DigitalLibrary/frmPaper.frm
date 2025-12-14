VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form frmPaper 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Digital Library"
   ClientHeight    =   7635
   ClientLeft      =   2490
   ClientTop       =   795
   ClientWidth     =   6705
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7635
   ScaleWidth      =   6705
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame Frame1 
      Height          =   735
      Left            =   120
      TabIndex        =   24
      Top             =   0
      Width           =   4815
      Begin VB.CommandButton btnIssn 
         Caption         =   "ISSN"
         Height          =   375
         Left            =   120
         TabIndex        =   12
         Top             =   240
         Width           =   1455
      End
      Begin VB.CommandButton btnJournal 
         Caption         =   "วารสาร"
         Height          =   375
         Left            =   1680
         TabIndex        =   13
         Top             =   240
         Width           =   1455
      End
      Begin VB.CommandButton btnExit 
         Caption         =   "ออกจากโปรแกรม"
         Height          =   375
         Left            =   3240
         TabIndex        =   14
         Top             =   240
         Width           =   1455
      End
   End
   Begin VB.Frame Frame2 
      Height          =   735
      Left            =   5040
      TabIndex        =   22
      Top             =   0
      Width           =   1575
      Begin VB.TextBox txtStatus 
         Alignment       =   1  'Right Justify
         Height          =   375
         Left            =   120
         TabIndex        =   23
         Top             =   240
         Width           =   1335
      End
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "frmPaper.frx":0000
      Height          =   1455
      Left            =   120
      OleObjectBlob   =   "frmPaper.frx":0014
      TabIndex        =   21
      Top             =   6120
      Width           =   6495
   End
   Begin VB.Frame Frame3 
      Height          =   735
      Left            =   120
      TabIndex        =   25
      Top             =   1440
      Width           =   2175
      Begin VB.CommandButton btnDelete 
         Caption         =   "ลบ"
         Height          =   375
         Left            =   1440
         TabIndex        =   4
         Top             =   240
         Width           =   615
      End
      Begin VB.CommandButton btnEdit 
         Caption         =   "แก้ไข"
         Height          =   375
         Left            =   720
         TabIndex        =   3
         Top             =   240
         Width           =   735
      End
      Begin VB.CommandButton btnAdd 
         Caption         =   "เพิ่ม"
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   615
      End
   End
   Begin VB.Frame Frame4 
      Height          =   735
      Left            =   2280
      TabIndex        =   27
      Top             =   1440
      Width           =   2175
      Begin VB.CommandButton btnCancel 
         Caption         =   "ยกเลิก"
         Height          =   375
         Left            =   1080
         TabIndex        =   28
         Top             =   240
         Width           =   975
      End
      Begin VB.CommandButton btnSave 
         Caption         =   "บันทึก"
         Height          =   375
         Left            =   120
         TabIndex        =   29
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame Frame5 
      Height          =   735
      Left            =   4440
      TabIndex        =   26
      Top             =   1440
      Width           =   2175
      Begin VB.CommandButton btnMoveLast 
         Caption         =   ">>"
         Height          =   375
         Left            =   1560
         TabIndex        =   8
         Top             =   240
         Width           =   495
      End
      Begin VB.CommandButton btnMoveNext 
         Caption         =   ">"
         Height          =   375
         Left            =   1080
         TabIndex        =   7
         Top             =   240
         Width           =   495
      End
      Begin VB.CommandButton btnMovePrevious 
         Caption         =   "<"
         Height          =   375
         Left            =   600
         TabIndex        =   6
         Top             =   240
         Width           =   495
      End
      Begin VB.CommandButton btnMoveFirst 
         Caption         =   "<<"
         Height          =   375
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Frame Frame6 
      Height          =   735
      Left            =   120
      TabIndex        =   30
      Top             =   720
      Width           =   6495
      Begin VB.CommandButton btnMoveNextJournal 
         Caption         =   ">"
         Height          =   375
         Left            =   6120
         TabIndex        =   1
         Top             =   240
         Width           =   255
      End
      Begin VB.CommandButton btnMovePreviousJournal 
         Caption         =   "<"
         Height          =   375
         Left            =   2040
         TabIndex        =   0
         Top             =   240
         Width           =   255
      End
      Begin VB.TextBox txtJournal 
         Height          =   375
         Left            =   2280
         TabIndex        =   31
         Top             =   240
         Width           =   3855
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "วารสาร"
         Height          =   210
         Left            =   1320
         TabIndex        =   37
         Top             =   240
         Width           =   510
      End
   End
   Begin VB.Frame Frame7 
      Height          =   1215
      Left            =   120
      TabIndex        =   32
      Top             =   2160
      Width           =   6495
      Begin VB.TextBox txtEngTitle 
         Height          =   375
         Left            =   2040
         TabIndex        =   16
         Top             =   720
         Width           =   4335
      End
      Begin VB.TextBox txtThaiTitle 
         Height          =   375
         Left            =   2040
         TabIndex        =   15
         Top             =   240
         Width           =   4335
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ชื่อบทความภาษาอังกฤษ"
         Height          =   210
         Left            =   240
         TabIndex        =   39
         Top             =   720
         Width           =   1650
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ชื่อบทความภาษาไทย"
         Height          =   210
         Left            =   240
         TabIndex        =   38
         Top             =   240
         Width           =   1455
      End
   End
   Begin VB.Frame Frame8 
      Height          =   735
      Left            =   120
      TabIndex        =   33
      Top             =   3360
      Width           =   3255
      Begin VB.ComboBox cmbTypePaper 
         Height          =   330
         Left            =   1320
         TabIndex        =   17
         Top             =   240
         Width           =   1815
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ประเภทบทความ"
         Height          =   210
         Left            =   120
         TabIndex        =   40
         Top             =   240
         Width           =   1140
      End
   End
   Begin VB.Frame Frame9 
      Height          =   735
      Left            =   3360
      TabIndex        =   34
      Top             =   3360
      Width           =   3255
      Begin VB.TextBox txtFinalPage 
         Height          =   375
         Left            =   2640
         TabIndex        =   19
         Top             =   240
         Width           =   495
      End
      Begin VB.TextBox txtStartPage 
         Height          =   375
         Left            =   1080
         TabIndex        =   18
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "จบที่หน้า"
         Height          =   210
         Left            =   1920
         TabIndex        =   42
         Top             =   240
         Width           =   600
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "เริ่มต้นที่หน้า"
         Height          =   210
         Left            =   120
         TabIndex        =   41
         Top             =   240
         Width           =   900
      End
   End
   Begin VB.Frame Frame10 
      Height          =   735
      Left            =   120
      TabIndex        =   35
      Top             =   4080
      Width           =   6495
      Begin VB.CommandButton btnSearchFile 
         Caption         =   "ค้นหาไฟล์"
         Height          =   375
         Left            =   5400
         TabIndex        =   20
         Top             =   240
         Width           =   975
      End
      Begin VB.TextBox txtFilePaper 
         Height          =   375
         Left            =   1320
         TabIndex        =   36
         Top             =   240
         Width           =   3975
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ชื่อไฟล์บทความ"
         Height          =   210
         Left            =   120
         TabIndex        =   43
         Top             =   240
         Width           =   1080
      End
   End
   Begin VB.Frame Frame11 
      Height          =   1215
      Left            =   120
      TabIndex        =   44
      Top             =   4800
      Width           =   2175
      Begin VB.TextBox txtAuthor 
         Height          =   375
         Left            =   120
         TabIndex        =   45
         Top             =   240
         Width           =   1935
      End
      Begin VB.CommandButton btnAuthor 
         Caption         =   "แสดงชื่อผู้แต่ง"
         Height          =   375
         Left            =   480
         TabIndex        =   9
         Top             =   720
         Width           =   1215
      End
   End
   Begin VB.Data Data1 
      Caption         =   "บทความ"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   375
      Left            =   0
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   2  'Snapshot
      RecordSource    =   ""
      Top             =   5880
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.Frame Frame12 
      Height          =   1215
      Left            =   2280
      TabIndex        =   46
      Top             =   4800
      Width           =   2175
      Begin VB.CommandButton btnKeyword 
         Caption         =   "แสดงคำค้น"
         Height          =   375
         Left            =   480
         TabIndex        =   10
         Top             =   720
         Width           =   1335
      End
      Begin VB.TextBox txtKeyword 
         Height          =   375
         Left            =   120
         TabIndex        =   48
         Top             =   240
         Width           =   1935
      End
   End
   Begin VB.Frame Frame13 
      Height          =   1215
      Left            =   4440
      TabIndex        =   47
      Top             =   4800
      Width           =   2175
      Begin VB.CommandButton btnAbstract 
         Caption         =   "แสดงบทคัดย่อ"
         Height          =   375
         Left            =   480
         TabIndex        =   11
         Top             =   720
         Width           =   1215
      End
      Begin VB.TextBox txtAbstract 
         Height          =   375
         Left            =   120
         TabIndex        =   49
         Top             =   240
         Width           =   1935
      End
   End
End
Attribute VB_Name = "frmPaper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'ประกาศตัวแปร
Dim LibraryWs As Workspace
Dim LibraryDb As Database
Public PaperDyn As Recordset
Dim IssnSnap As Recordset
Dim JournalSnap As Recordset
Dim PaperSnap As Recordset
Dim TypePaperSnap As Recordset
Dim IdPaperSnap As Recordset
Public FileName As String
Public PathName As String
Public ClickbtnSearchFile As Boolean

Private Sub btnAbstract_Click()

    frmAbstract.Show vbModal, frmPaper
    
End Sub

Private Sub btnAdd_Click()

    On Error GoTo HandleError
    
    'Disable ปุ่ม btnAdd, btnEdit และ btnDelete ในขณะที่ทำการเพิ่มข้อมูล
    Call EnableOperationButton(False)
    
    'Disable ปุ่ม btnIssn, btnJournal และ btnExit ในขณะที่ทำการเพิ่มข้อมูล
    Call EnablebtnForm(False)
    
    'Enable ปุ่ม btnSave และ btnCancel
    Call EnableSaveCancelButton(True)
    
    'ไม่แสดงปุ่ม btnMove
    Call VisiblebtnMove(False)
    
    'ไม่แสดงปุ่ม btnMoveJournal
    Call VisiblebtnMoveJournal(False)
    
    'Clear หน้าจอเพื่อรอรับข้อมูลใหม่
    Call ClearData
    
    'Enable ช่องรับข้อมูล
    Call EnableTxt(True)
    
    'เลื่อนเคอร์เซอร์ ไปที่ txtThaiTitle บนหน้าจอเพื่อรอรับข้อมูลใหม่
    txtThaiTitle.SetFocus
    
    'ใช้เมดทอด AddNew เพื่อเพิ่มข้อมูลเรคคอร์ดใหม่
    PaperDyn.AddNew
    
    'แสดงจำนวนผู้แต่ง
    Call CheckAuthor
            
    'แสดงจำนวนคำค้น
    Call CheckKeyword
    
    'แสดงบทคัดย่อ
    Call CheckAbstract
    
    'แสดงสถานะ
    Call CheckStatus
    
    Exit Sub

HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
End Sub

Private Sub btnAuthor_Click()

    frmAuthor.Show vbModal, frmPaper
    
End Sub

Private Sub btnCancel_Click()

    'ยกเลิกการเพิ่มหรือแก้ไขข้อมูลเมื่ออยู่ในสถานะ AddNew และ Edit
    If (PaperDyn.EditMode = dbEditAdd) Or (PaperDyn.EditMode = dbEditInProgress) Then
        PaperDyn.CancelUpdate
    End If
    
    'Clear ฟิล์ดต่างๆ บนหน้าจอ
    Call ClearData
    
    If PaperDyn.RecordCount <> 0 Then
        'แสดงข้อมูลจากตารางบนหน้าจอ
        Call DisplayFields
    
        'Enbale ปุ่ม btnAdd, btnEdit และ btnDelete หลังจากยกเลิกการบันทึกข้อมูล
        Call EnableOperationButton(True)
        
        'แสดงปุ่ม btnMove
        Call VisiblebtnMove(True)
        
        'แสดงจำนวนผู้แต่ง
        Call CheckAuthor
            
        'แสดงจำนวนคำค้น
        Call CheckKeyword
            
        'แสดงบทคัดย่อ
        Call CheckAbstract
        
    Else
        Call RecordZero
    End If
    
    ClickbtnSearchFile = False
    
     'แสดงสถานะ
    Call CheckStatus
    
    'Disable ช่องรับข้อมูล
    Call EnableTxt(False)
    
    'แสดงปุ่ม btnMoveJournal
    Call VisiblebtnMoveJournal(True)
        
    'Enable ปุ่ม btnIssn, btnJournal และ btnExit หลังจากยกเลิกการบันทึกข้อมูล
    Call EnablebtnForm(True)
    
    'Disable ปุ่ม btnSave และ btnCancel หลังจากบันทึกข้อมูลเรียบร้อยแล้ว
    Call EnableSaveCancelButton(False)
        
End Sub

Private Sub btnDelete_Click()

    On Error GoTo HandleError
    
    'ยืนยันการลบข้อมูล
    If MsgBox("ต้องการลบบทความนี้ แน่ใจหรือไม่", vbYesNo) = vbYes Then
        'ลบข้อมูลเรคคอร์ดปัจจุบัน
        PaperDyn.Delete
        
        'เช็คเรคคอร์ด
        If PaperDyn.RecordCount <> 0 Then
            'ไปที่เรคคอร์ดแรกและแสดงข้อมูลในตารางบนหน้าจอ
            Call btnMoveNext_Click
        Else
            Call ClearData
            Call RecordZero
        End If
    End If
    
     'แสดงข้อมูลบน DBGrid
     Call OpenQuery
    
    Exit Sub
    
HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
End Sub

Private Sub btnEdit_Click()

    On Error GoTo HandleError
    
    'Disable ปุ่ม btnAdd, btnEdit และ btnDelete ในขณะที่ทำการแก้ไขข้อมูล
    Call EnableOperationButton(False)
    
   'Disable ปุ่ม btnJournal, btnPaper และ btnExit ในขณะที่ทำการแก้ไขข้อมูล
    Call EnablebtnForm(False)
    
    'Enable ปุ่ม btnSave และ btnCancel
    Call EnableSaveCancelButton(True)
    
    'ไม่แสดงปุ่ม btnMove
    Call VisiblebtnMove(False)
    
    'ไม่แสดงปุ่ม btnMoveJournal
    Call VisiblebtnMoveJournal(False)
    
    'Enable ช่องรับข้อมูล
    Call EnableTxt(True)

    'เลื่อนเคอร์เซอร์ไปที่ cmbEditor บนหน้าจอเพื่อรอรับข้อมูล
    txtThaiTitle.SetFocus
    
     'ใช้เมดทอด Edit เพื่อแก้ไขข้อมูล
    PaperDyn.Edit
    
     'แสดงสถานะ
    Call CheckStatus
    
    Exit Sub
    
HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
End Sub

Private Sub btnExit_Click()

    'จบโปรแกรม
    End
    
End Sub

Private Sub btnIssn_Click()

    'ปิดฟอร์ม
    Unload Me
    
    'เปิดฟอร์ม Issn
    frmIssn.Show vbModal, frmMain
    
End Sub

Private Sub btnJournal_Click()

    'ปิดฟอร์ม
    Unload Me
    
    'เปิดฟอร์ม Journal
    frmJournal.Show vbModal, frmMain
    
End Sub

Private Sub btnKeyword_Click()

    frmKeyword.Show vbModal, frmPaper
    
End Sub

Private Sub btnMoveFirst_Click()

    'ไปที่เรคคอร์ดแรก
    PaperDyn.MoveFirst
    
    'แสดงข้อมูลบนหน้าจอ
    Call DisplayFields
    
     'แสดงจำนวนผู้แต่ง
    Call CheckAuthor
            
    'แสดงจำนวนคำค้น
    Call CheckKeyword
    
    'แสดงบทคัดย่อ
    Call CheckAbstract
            
    'Enable ปุ่ม btnMoveLast และ btnMoveNext
    Call EnableMoveLastMoveNextButton(True)
    
    'Disable ปุ่ม btnMoveFirst และ btnMovePrevious
    Call EnableMoveFirstMovePreviousButton(False)

End Sub

Private Sub btnMoveLast_Click()

    'ไปที่เรคคอร์ดสุดท้าย
    PaperDyn.MoveLast
    
    'แสดงข้อมูลบนหน้าจอ
    Call DisplayFields
    
     'แสดงจำนวนผู้แต่ง
    Call CheckAuthor
            
    'แสดงจำนวนคำค้น
    Call CheckKeyword
    
    'แสดงบทคัดย่อ
    Call CheckAbstract
            
    'Disable ปุ่ม btnMoveLast และ btnMoveNext
    Call EnableMoveLastMoveNextButton(False)
    
    'Enable ปุ่ม btnMoveFirst และ btnMovePrevious
    Call EnableMoveFirstMovePreviousButton(True)
    
End Sub

Private Sub btnMoveNext_Click()

    'ไปที่เรคคอร์ดถัดไป
    PaperDyn.MoveNext
    
    'ถ้าไม่ใช้เรคคอร์ดสุดท้าย
    If PaperDyn.EOF = True Then
        'Disable ปุ่ม btnMoveLast และ btnMoveNext
        Call EnableMoveLastMoveNextButton(False)
        
        'ไปที่เรคคอร์ดสุดท้าย
        Call btnMoveLast_Click
    Else
        'Enable ปุ่ม btnMoveFirst และ btnMovePrevious
        Call EnableMoveFirstMovePreviousButton(True)
    End If
    
    'แสดงข้อมูลบนหน้าจอ
    Call DisplayFields
    
     'แสดงจำนวนผู้แต่ง
    Call CheckAuthor
            
    'แสดงจำนวนคำค้น
    Call CheckKeyword
    
    'แสดงบทคัดย่อ
    Call CheckAbstract
    
End Sub

Private Sub btnMoveNextJournal_Click()

    'ไปเรคคอร์ดถัดไป
    JournalSnap.MoveNext
    
    'ถ้าเป็นเรคคอร์ดสุดท้าย
    If JournalSnap.EOF Then
        'ไปที่เรคคอร์ดสุดท้าย
        JournalSnap.MoveLast
        
        'Disable ปุ่ม btnMoveNextJournal
        btnMoveNextJournal.Enabled = False
    End If
        'Enable ปุ่ม btnMovePreviousJournal
        btnMovePreviousJournal.Enabled = True
        
        'แสดงข้อมูล Journal บนหน้าจอ
        Call DisplayJournal
        
        'แสดงข้อมูล Paper
        Call OpenQueryPaper
        
        'แสดงข้อมูลบน DBGrid
        Call OpenQuery
    
        'เช็คเรคคอร์ด PaperDyn มีเรคคอร์ดเป็น 0 หรือไม่
        Call CheckRecordPaperDyn
        
End Sub

Private Sub btnMovePrevious_Click()

    'ไปเรคคอร์ดก่อนหน้านี้
    PaperDyn.MovePrevious
    
    'ถ้าใช่เรคคอร์ดแรก
    If PaperDyn.BOF = True Then
        'Disable ปุ่ม btnMoveFirst และ btnMovePrevious
        Call EnableMoveFirstMovePreviousButton(False)
        
        'ไปที่เรคคอร์ดแรก
        Call btnMoveFirst_Click
    Else
        'Enable ปุ่ม btnMoveLast และ btnMoveNext
        Call EnableMoveLastMoveNextButton(True)
    End If
    
    'แสดงข้อมูลบนหน้าจอ
    Call DisplayFields
    
     'แสดงจำนวนผู้แต่ง
    Call CheckAuthor
            
    'แสดงจำนวนคำค้น
    Call CheckKeyword
    
    'แสดงบทคัดย่อ
    Call CheckAbstract
    
End Sub

Private Sub btnMovePreviousJournal_Click()

    'ไปเรคคอร์ดก่อนหน้านี้
    JournalSnap.MovePrevious
    
    'ถ้าเป็นเรคคอร์ดแรก
    If JournalSnap.BOF Then
        'ไปที่เรคคอร์ดแรก
        JournalSnap.MoveFirst
        
        'Disable ปุ่ม btnMovePreviousJournal
        btnMovePreviousJournal.Enabled = False
    End If
        'Enable ปุ่ม btnMoveNextJournal
        btnMoveNextJournal.Enabled = True
        
        'แสดงข้อมูล Journal บนหน้าจอ
        Call DisplayJournal
        
        'แสดงข้อมูล Paper
        Call OpenQueryPaper
        
        'แสดงข้อมูลบน DBGrid
        Call OpenQuery
    
        'เช็คเรคคอร์ด PaperDyn มีเรคคอร์ดเป็น 0 หรือไม่
        Call CheckRecordPaperDyn
        
End Sub

Private Sub btnSave_Click()
Dim IdPaper As Integer

    On Error GoTo HandleError
    
    'ตรวจสอบความถูกต้องของข้อมูลก่อนการบันทึกข้อมูล
    If (txtThaiTitle.Text = "") And (txtEngTitle.Text = "") Then
        MsgBox "กรุณาใส่ชื่อบทความ  ก่อนการบันทึกข้อมูล"
        txtThaiTitle.SetFocus
     ElseIf txtStartPage.Text = "" Then
        MsgBox "กรุณาใส่หน้าเริ่มต้นของบทความ ก่อนการบันทึกข้อมูล"
        txtStartPage.SetFocus
    ElseIf Not IsNumeric(txtStartPage.Text) Then
        MsgBox "กรุณาใส่หน้าเริ่มต้นของบทความเป็นตัวเลข"
        txtStartPage.SetFocus
    ElseIf txtFinalPage.Text = "" Then
        MsgBox "กรุณาใส่หน้าสุดท้ายของบทความ ก่อนการบันทึกข้อมูล"
        txtFinalPage.SetFocus
    ElseIf Not IsNumeric(txtFinalPage.Text) Then
        MsgBox "กรุณาใส่หน้าสุดท้ายของบทความเป็นตัวเลข"
        txtFinalPage.SetFocus
    ElseIf PaperDyn.Fields("Author1") = "" And PaperDyn.Fields("Author1") = "" And PaperDyn.Fields("Author1") = "" And PaperDyn.Fields("Author1") = "" And PaperDyn.Fields("Author1") = "" Then
        MsgBox "กรุณาใส่ชื่อผู้แต่งบทความ ก่อนการบันทึกข้อมูล"
        Call btnAuthor_Click
    'ถ้าไม่มีข้อมูลใดๆ ผิดพลาด ให้ทำการบันทึกข้อมูล
    Else
        'กำหนดค่าให้กับฟิล์ดต่างๆ ตามข้อมูลบนหน้าจอ
        With PaperDyn
            If .EditMode = dbEditAdd Then
                'ดึงข้อมูลฟิล์ด IdPaper จากตาราง TblPaper
                Set IdPaperSnap = LibraryDb.OpenRecordset("SELECT IdPaper FROM TblPaper ORDER BY IdPaper", dbOpenSnapshot)
                With IdPaperSnap
                    If .RecordCount <> 0 Then
                        .Requery
                        .MoveLast
                        IdPaper = .Fields("IdPaper") + 1
                    Else
                        IdPaper = 1
                    End If
                End With
                .Fields("IdPaper") = IdPaper
            End If
            .Fields("ThaiTitle") = Trim(txtThaiTitle.Text)
            .Fields("EngTitle") = Trim(txtEngTitle.Text)
            .Fields("TypePaper") = Trim(cmbTypePaper.Text)
            .Fields("StartPage") = Trim(txtStartPage.Text)
            .Fields("FinalPage") = Trim(txtFinalPage.Text)
            .Fields("FilePaper") = Trim(txtFilePaper.Text)
            .Fields("IdJournal") = JournalSnap.Fields("IdJournal")
        End With
        
        'ใช้เมดทอด Update เพื่อบันทึกข้อมูลลงในเรคคอร์ดเซท
        PaperDyn.Update
        
        'เลื่อนเรคคอร์ดเซทไปยังเรคคอร์ดสุดท้ายที่มีการเปลี่ยนแปลงข้อมูล
        PaperDyn.Bookmark = PaperDyn.LastModified
        
        'แสดงข้อมูลบนหน้าจอ
        TypePaperSnap.Requery
        Call ReadTypePaper
        Call DisplayFields
        Call OpenQuery
        
        If ClickbtnSearchFile = True Then
            'เช็ค Folder Paper
            Call CheckFolder
        
            'เช็คไฟล์บทความ
            Call CheckFile
            
            ClickbtnSearchFile = False
        End If
         
         'แสดงสถานะ
        Call CheckStatus
    
        'แสดงการบันทึกข้อมูล
        MsgBox "บันทึกข้อมูลเรียบร้อยแล้ว"
        
        'Disable ช่องรับข้อมูล
        Call EnableTxt(False)
        
        'Disable ปุ่ม btnSave และ btnCancel หลังจากบันทึกข้อมูลเรียบร้อยแล้ว
        Call EnableSaveCancelButton(False)
        
        'Enable ปุ่ม btnAdd, btnEdit และ btnDelete หลังจากบันทึกข้อมูลเรียบร้อยแล้ว
        Call EnableOperationButton(True)
        
        'Enable ปุ่ม btnJournal, btnPaper และ btnExit หลังจากบันทึกข้อมูลเรียบร้อยแล้ว
        Call EnablebtnForm(True)
        
        'แสดงปุ่ม btnMove
        Call VisiblebtnMove(True)
        
        'แสดงปุ่ม btnMoveJournal
        Call VisiblebtnMoveJournal(True)
        
    End If
    Exit Sub
    
HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
End Sub

Private Sub btnSearchFile_Click()

    frmSearchFile.Show vbModal, frmPaper
    
End Sub

Private Sub Form_Load()
Dim SqlCommand As String

    'ถ้าเกิด Error ขึ้นให้ข้ามไปทำงานที่ HandleError
    On Error GoTo HandleError
    
    frmPaper.Icon = LoadPicture(App.Path & "\Icon.ico")
    txtStatus.Enabled = False
    txtJournal.Enabled = False
    txtFilePaper.Enabled = False
    txtAuthor.Enabled = False
    txtKeyword.Enabled = False
    txtAbstract.Enabled = False
    ClickbtnSearchFile = False
    
     'เลือกใช้ Workspace(0)
    Set LibraryWs = DBEngine.Workspaces(0)
    
    'เปิดฐานข้อมูล Digital Library.Mdb
    Set LibraryDb = LibraryWs.OpenDatabase(App.Path & "\Digital Library.Mdb", False, False)
    
    'เปิดตาราง TblIssn โดยใช้เรคคอร์ดเซท ThaiJournalSnap
    Set IssnSnap = LibraryDb.OpenRecordset("SELECT Issn FROM TblIssn ORDER BY Issn", dbOpenSnapshot)
    
    'เช็คตาราง TblIssn มีเรคคอร์ดเป็น 0 หรือไม่
    If IssnSnap.RecordCount <> 0 Then
        'เปิดตาราง TblJournal โดยใช้เรคคอร์ดเซท JournalSnap
        SqlCommand = "SELECT IdJournal, Volume, Number, Month, Year, TblIssn.ThaiJournal"
        SqlCommand = SqlCommand & " " & "FROM TblJournal INNER JOIN TblIssn"
        SqlCommand = SqlCommand & " " & "ON TblJournal.Issn = TblIssn.Issn"
        SqlCommand = SqlCommand & " " & "ORDER BY IdJournal"
        Set JournalSnap = LibraryDb.OpenRecordset(SqlCommand, dbOpenSnapshot)
        
        'เช็คตาราง TblJournal มีเรคคอร์ดเป็น 0 หรือไม่
        If JournalSnap.RecordCount <> 0 Then
            'ไปที่เรคคอร์ดแรกของ JournalSnap
            JournalSnap.MoveFirst
            
            'Disable ปุ่ม btnMovePreviousJournal เมื่ออยู่ที่เรคคอร์ดแรก
            btnMovePreviousJournal.Enabled = False
            
            'แสดงข้อมูลฟิล์ด Journal บนหน้าจอ
            Call DisplayJournal
            
            'ดึงข้อมูลฟิล์ด TypePaper จากตาราง TblPaper ไว้ในเรคคอร์ดเซท TypePaperSnap
            Set TypePaperSnap = LibraryDb.OpenRecordset("SELECT DISTINCT TypePaper FROM TblPaper ORDER BY TypePaper", dbOpenSnapshot)
            
            'เปิดตาราง TblPaper โดยใช้เรคคอร์ดเซท PaperDyn
            Call OpenQueryPaper
            
            'แสดงข้อมูลบน DBGrid
            Call OpenQuery
            
            'เช็คเรคคอร์ด PaperDyn มีเรคคอร์ดเป็น 0 หรือไม่
            Call CheckRecordPaperDyn
            
        Else
            MsgBox ("ไม่มีวารสารอยู่ในฐานข้อมูล กรุณาใส่วารสารก่อน")
            Call btnJournal_Click
        
        End If
    Else
        MsgBox ("ไม่มีชื่อวารสารอยู่ในฐานข้อมูล กรุณาใส่ชื่อวารสารก่อน")
        Call btnIssn_Click
        
    End If
    
    'Disable ช่องรับข้อมูล
    Call EnableTxt(False)
    
    'Disable ปุ่ม btnSave และ btnCancel
    Call EnableSaveCancelButton(False)
    
    'แสดงสถานะ
    Call CheckStatus
    
    Exit Sub
    
HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
End Sub

Private Sub Form_Unload(Cancel As Integer)

    Call CloseRecordDb
    
End Sub

Private Sub DisplayFields()

    'แสดงข้อมูลบนฟิล์ดต่างๆ บนหน้าจอ
    With PaperDyn
        txtThaiTitle.Text = .Fields("ThaiTitle")
        txtEngTitle.Text = .Fields("EngTitle")
        cmbTypePaper.Text = .Fields("TypePaper")
        txtStartPage.Text = .Fields("StartPage")
        txtFinalPage.Text = .Fields("FinalPage")
        txtFilePaper.Text = .Fields("FilePaper")
        'txtAbstract.Text = .Fields("ThaiAbstract")
    End With
    
End Sub

Private Sub DisplayJournal()
    Dim TextJournal As String
    
    'แสดงข้อมูลฟิล์ด Journal
    With JournalSnap
        TextJournal = .Fields("ThaiJournal")
        TextJournal = TextJournal & " " & .Fields("Volume")
        TextJournal = TextJournal & "," & .Fields("Number")
        TextJournal = TextJournal & "(" & .Fields("Month")
        TextJournal = TextJournal & "," & .Fields("Year") & ")"
    End With
    
    txtJournal.Text = TextJournal
    
End Sub

Private Sub ClearData()
    
    'Clear ค่าของฟิล์ดต่างๆ บนหน้าจอ
     txtThaiTitle.Text = ""
    txtEngTitle.Text = ""
    cmbTypePaper.Text = ""
    txtStartPage.Text = ""
    txtFinalPage.Text = ""
    txtFilePaper.Text = ""
    
End Sub

Private Sub EnableMoveFirstMovePreviousButton(EnableFlag As Boolean)
    
    'Enable หรือ Disable ปุ่ม btnMoveFirst และ btnMovePrevious
    btnMoveFirst.Enabled = EnableFlag
    btnMovePrevious.Enabled = EnableFlag
    
End Sub

Private Sub EnableMoveLastMoveNextButton(EnableFlag As Boolean)
    
    'Enable หรือ Disable ปุ่ม btnMoveLast และ btnMoveNext
    btnMoveLast.Enabled = EnableFlag
    btnMoveNext.Enabled = EnableFlag
    
End Sub

Private Sub VisiblebtnMoveJournal(VisibleFlag As Boolean)

    'แสดงหรือไม่แสดงปุ่ม btnMovePreviousJournal และ btnMoveNextJournal
    btnMovePreviousJournal.Visible = VisibleFlag
    btnMoveNextJournal.Visible = VisibleFlag
    
End Sub

Private Sub EnableOperationButton(EnableFlag As Boolean)
    
    'Enable หรือ Disable ปุ่ม btnAdd, btnEdit และ btnDelete
    btnAdd.Enabled = EnableFlag
    btnEdit.Enabled = EnableFlag
    btnDelete.Enabled = EnableFlag
    
End Sub

Private Sub EnableSaveCancelButton(EnableFlag As Boolean)
    
    'Enable หรือ Disable ปุ่ม btnSave และ btnCancel
    btnSave.Enabled = EnableFlag
    btnCancel.Enabled = EnableFlag
    
End Sub

Private Sub EnablebtnForm(EnableFlag As Boolean)

    'Enable หรือ Disable ปุ่ม btnJournal, btnPaper และ btnExit
    btnIssn.Enabled = EnableFlag
    btnJournal.Enabled = EnableFlag
    btnExit.Enabled = EnableFlag
    
End Sub

Private Sub VisiblebtnMove(VisibleFlag As Boolean)
    
    'แสดงหรือไม่แสดงปุ่ม  btnMoveFirst, btnMovePrevious, btnMoveNext และ btnMoveLast
    btnMoveFirst.Visible = VisibleFlag
    btnMovePrevious.Visible = VisibleFlag
    btnMoveNext.Visible = VisibleFlag
    btnMoveLast.Visible = VisibleFlag
    
End Sub

Private Sub EnableTxt(EnableFlag As Boolean)

    'Enable หรือ Disable ช่องรับข้อมูล
     txtThaiTitle.Enabled = EnableFlag
    txtEngTitle.Enabled = EnableFlag
    cmbTypePaper.Enabled = EnableFlag
    txtStartPage.Enabled = EnableFlag
    txtFinalPage.Enabled = EnableFlag
    btnSearchFile.Enabled = EnableFlag
    
End Sub

Private Sub CheckRecordPaperDyn()

    If PaperDyn.RecordCount <> 0 Then
            'active RecordCount property
            PaperDyn.MoveLast
            
            'ดึงข้อมูลฟิล์ด TypePaper จากตาราง TblPaper ไปใส่ใน ComboBox cmbTypePaper
            TypePaperSnap.Requery
            Call ReadTypePaper
            
            'ไปที่เรคอร์ดแรกของเรคคอร์ดเซท PaperDyn
            Call btnMoveFirst_Click
            
            'แสดงข้อมูลเรคคอร์ดแรกบนหน้าจอ
            Call DisplayFields
            
            'แสดงจำนวนผู้แต่ง
            Call CheckAuthor
            
            'แสดงจำนวนคำค้น
            Call CheckKeyword
            
            'แสดงบทคัดย่อ
            Call CheckAbstract
            
            'แสดงปุ่ม btnMove
            Call VisiblebtnMove(True)
            
             'Enable เมนู btnAdd, btnEdit และ btnDelete หลังจากบันทึกข้อมูลเรียบร้อยแล้ว
            Call EnableOperationButton(True)
    
        Else
            Call RecordZero
        End If
        
End Sub

Private Sub RecordZero()

    'ไม่แสดง btnMove
    Call VisiblebtnMove(False)
        
    'Disable ปุ่ม btnEdit และ btnDelete
    btnEdit.Enabled = False
    btnDelete.Enabled = False
    
    'Enable ปุ่ม btnAdd
    btnAdd.Enabled = True
    
    'Clear ข้อมูลบนหน้าจอ
    Call ClearData
    txtAuthor.Text = ""
    txtKeyword.Text = ""
    txtAbstract.Text = ""
    
    cmbTypePaper.Clear
    
End Sub

Private Sub OpenQueryPaper()
Dim AbstactSnap As Recordset
Dim SqlCommand As String

     'เปิดตาราง TblPaper โดยใช้เรคคอร์ดเซท PaperDyn
     SqlCommand = "SELECT * FROM TblPaper "
     SqlCommand = SqlCommand & "WHERE IdJournal = " & JournalSnap.Fields("IdJournal") & " "
     SqlCommand = SqlCommand & "ORDER BY IdPaper DESC"
     Set PaperDyn = LibraryDb.OpenRecordset(SqlCommand, dbOpenDynaset)
     
End Sub

Private Sub OpenQuery()
Dim SqlCommand As String

    SqlCommand = "SELECT ThaiTitle, EngTitle, TypePaper, Author1, Author2, Author3, Author4, Author5, StartPage, FinalPage, FilePaper "
    SqlCommand = SqlCommand & "FROM TblPaper "
    SqlCommand = SqlCommand & "WHERE IdJournal = " & JournalSnap.Fields("IdJournal") & " "
    SqlCommand = SqlCommand & "ORDER BY IdPaper DESC"
    Set PaperSnap = LibraryDb.OpenRecordset(SqlCommand, dbOpenSnapshot)
    Set Data1.Recordset = PaperSnap
    
End Sub

Private Sub CloseRecordDb()

    'ปิดเรคคอร์ดเซทและฐานข้อมูล
    If IssnSnap.RecordCount <> 0 Then
        If JournalSnap.RecordCount <> 0 Then
            If PaperDyn.RecordCount <> 0 Then
                PaperDyn.Close
                TypePaperSnap.Close
                PaperSnap.Close
            End If
            JournalSnap.Close
        End If
    End If
    
    IssnSnap.Close
    LibraryDb.Close
    
End Sub

Private Sub ReadTypePaper()
    
    On Error GoTo HandleError
    
    'ไปที่เรคคอร์ดแรกของ TypePaperSnap
    TypePaperSnap.MoveFirst
    
    'Clear ข้อมูลใน ComboBox cmbTypePaper
    cmbTypePaper.Clear
    
    'วนลูปจะกว่าจะ End-Of-File ของ TypePaperSnap
    Do While Not TypePaperSnap.EOF
        'เพิ่ม TypePaper ใน cmbTypePaper
        cmbTypePaper.AddItem (TypePaperSnap.Fields("TypePaper"))
        
        'ไปยังเรคคอร์ดถัดไป
        TypePaperSnap.MoveNext
    Loop
    
    Exit Sub
    
HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
    
End Sub

Private Sub CheckStatus()

    With PaperDyn
        If .EditMode = dbEditAdd Then
            txtStatus.Text = "เพิ่มบทความ"
        ElseIf .EditMode = dbEditInProgress Then
            txtStatus.Text = "แก้ไขบทความ"
        Else
            txtStatus.Text = "บทความ"
        End If
    End With
    
End Sub

Public Sub CheckAuthor()
Dim CountAuthor As Integer

    CountAuthor = 0
    
    With PaperDyn
        If .Fields("Author1") <> "" Then
            CountAuthor = CountAuthor + 1
        End If
        
        If .Fields("Author2") <> "" Then
            CountAuthor = CountAuthor + 1
        End If
        
        If .Fields("Author3") <> "" Then
            CountAuthor = CountAuthor + 1
        End If
        
        If .Fields("Author4") <> "" Then
            CountAuthor = CountAuthor + 1
        End If
        
        If .Fields("Author5") <> "" Then
            CountAuthor = CountAuthor + 1
        End If
    End With
    
    If CountAuthor = 0 Then
        txtAuthor.Text = "ไม่มีชื่อผู้แต่ง"
    Else
        txtAuthor.Text = "มีชื่อผู้แต่ง " & CountAuthor & " คน"
    End If
    
End Sub

Public Sub CheckKeyword()
Dim CountKeyword As Integer

    CountKeyword = 0
    
    With PaperDyn
        If .Fields("Keyword1") <> "" Then
            CountKeyword = CountKeyword + 1
        End If
        
        If .Fields("Keyword2") <> "" Then
            CountKeyword = CountKeyword + 1
        End If
        
        If .Fields("Keyword3") <> "" Then
            CountKeyword = CountKeyword + 1
        End If
        
        If .Fields("Keyword4") <> "" Then
            CountKeyword = CountKeyword + 1
        End If
        
        If .Fields("Keyword5") <> "" Then
            CountKeyword = CountKeyword + 1
        End If
    End With
    
    If CountKeyword = 0 Then
        txtKeyword.Text = "ไม่มีคำค้น"
    Else
        txtKeyword.Text = "มีคำค้น " & CountKeyword & " คำ"
    End If
    
End Sub

Public Sub CheckAbstract()
    
    With PaperDyn
        If .Fields("ThaiAbstract") <> "" And .Fields("EngAbstract") <> "" Then
            txtAbstract.Text = "มีบทคัดย่อ และ Abstract"
        ElseIf .Fields("ThaiAbstract") <> "" Then
            txtAbstract.Text = "มีบทคัดย่อ"
        ElseIf .Fields("EngAbstract") <> "" Then
            txtAbstract.Text = "มี Abstract"
        Else
            txtAbstract.Text = "ไม่มีบทคัดย่อ และ Abstract"
        End If
    End With
    
End Sub

Private Sub CheckFolder()
Dim objFSO As New FileSystemObject
    
    If objFSO.FolderExists(App.Path & "\Paper") = False Then
        objFSO.CreateFolder (App.Path & "\Paper")
    End If
    
End Sub

Private Sub CheckFile()
Dim objFSO As New FileSystemObject
    
    'มีชื่อไฟล์บทความหรือไม่
    If Trim(txtFilePaper.Text) <> "" Then
        'มีชื่อไฟล์บทความที่ต้นทางหรือไม่
        If objFSO.FileExists(PathName & "\" & FileName) = True Then
            'มีชื่อไฟล์นี้ที่ ไดเรกเทอรี Paper หรือไม่
            If objFSO.FileExists(App.Path & "\Paper\" & FileName) = False Then
                'Copy ไฟล์
                objFSO.CopyFile (PathName & "\" & FileName), (App.Path & "\Paper\")
            Else
                If MsgBox("มีไฟล์นี้อยู่แล้ว ต้องการจะ Copy ทับหรือไม่", vbYesNo) = vbYes Then
                    objFSO.CopyFile (PathName & "\" & FileName), (App.Path & "\Paper\"), True
                End If
            End If
        Else
            MsgBox "ไม่เจอไฟล์บทความ"
        End If
    End If
    
End Sub

