VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form frmIssn 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Digital Library"
   ClientHeight    =   4650
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6705
   Icon            =   "frmIssn.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4650
   ScaleWidth      =   6705
   StartUpPosition =   1  'CenterOwner
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "frmIssn.frx":000C
      Height          =   1335
      Left            =   120
      OleObjectBlob   =   "frmIssn.frx":0020
      TabIndex        =   25
      Top             =   3240
      Width           =   6495
   End
   Begin VB.Frame Frame2 
      Height          =   735
      Left            =   120
      TabIndex        =   17
      Top             =   0
      Width           =   4815
      Begin VB.CommandButton btnExit 
         Caption         =   "ออกจากโปรแกรม"
         Height          =   375
         Left            =   3240
         TabIndex        =   15
         Top             =   240
         Width           =   1455
      End
      Begin VB.CommandButton btnPaper 
         Caption         =   "บทความ"
         Height          =   375
         Left            =   1680
         TabIndex        =   14
         Top             =   240
         Width           =   1455
      End
      Begin VB.CommandButton btnJournal 
         Caption         =   "วารสาร"
         Height          =   375
         Left            =   120
         TabIndex        =   13
         Top             =   240
         Width           =   1455
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1695
      Left            =   120
      TabIndex        =   16
      Top             =   1440
      Width           =   6495
      Begin VB.TextBox txtIssnRight 
         Height          =   375
         Left            =   5880
         MaxLength       =   4
         TabIndex        =   10
         Top             =   240
         Width           =   495
      End
      Begin VB.TextBox txtIssnLeft 
         Height          =   375
         Left            =   5160
         MaxLength       =   4
         TabIndex        =   9
         Top             =   240
         Width           =   495
      End
      Begin VB.TextBox txtThaiJournal 
         Height          =   375
         Left            =   1800
         TabIndex        =   11
         Top             =   720
         Width           =   4575
      End
      Begin VB.TextBox txtEngJournal 
         Height          =   375
         Left            =   1800
         TabIndex        =   12
         Top             =   1200
         Width           =   4575
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "-"
         Height          =   210
         Left            =   5760
         TabIndex        =   27
         Top             =   240
         Width           =   45
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "ชื่อวารสารภาษาอังกฤษ"
         Height          =   210
         Left            =   120
         TabIndex        =   21
         Top             =   1320
         Width           =   1575
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "ชื่อวารสารภาษาไทย"
         Height          =   210
         Left            =   120
         TabIndex        =   20
         Top             =   720
         Width           =   1380
      End
      Begin VB.Label Label1 
         Caption         =   "ISSN"
         Height          =   255
         Left            =   4680
         TabIndex        =   19
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Frame Frame5 
      Height          =   735
      Left            =   4440
      TabIndex        =   23
      Top             =   720
      Width           =   2175
      Begin VB.CommandButton btnMoveLast 
         Caption         =   ">>"
         Height          =   375
         Left            =   1560
         TabIndex        =   6
         Top             =   240
         Width           =   495
      End
      Begin VB.CommandButton btnMoveNext 
         Caption         =   ">"
         Height          =   375
         Left            =   1080
         TabIndex        =   5
         Top             =   240
         Width           =   495
      End
      Begin VB.CommandButton btnMovePrevious 
         Caption         =   "<"
         Height          =   375
         Left            =   600
         TabIndex        =   4
         Top             =   240
         Width           =   495
      End
      Begin VB.CommandButton btnMoveFirst 
         Caption         =   "<<"
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Frame Frame4 
      Height          =   735
      Left            =   2280
      TabIndex        =   22
      Top             =   720
      Width           =   2175
      Begin VB.CommandButton btnCancel 
         Caption         =   "ยกเลิก"
         Height          =   375
         Left            =   1080
         TabIndex        =   8
         Top             =   240
         Width           =   975
      End
      Begin VB.CommandButton btnSave 
         Caption         =   "บันทึก"
         Height          =   375
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame Frame6 
      Height          =   735
      Left            =   5040
      TabIndex        =   24
      Top             =   0
      Width           =   1575
      Begin VB.TextBox txtStatus 
         Alignment       =   1  'Right Justify
         Height          =   375
         Left            =   120
         TabIndex        =   26
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   375
      Left            =   0
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   3000
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Frame Frame3 
      Height          =   735
      Left            =   120
      TabIndex        =   18
      Top             =   720
      Width           =   2175
      Begin VB.CommandButton btnDelete 
         Caption         =   "ลบ"
         Height          =   375
         Left            =   1440
         TabIndex        =   2
         Top             =   240
         Width           =   615
      End
      Begin VB.CommandButton btnEdit 
         Caption         =   "แก้ไข"
         Height          =   375
         Left            =   720
         TabIndex        =   1
         Top             =   240
         Width           =   735
      End
      Begin VB.CommandButton btnAdd 
         Caption         =   "เพิ่ม"
         Height          =   375
         Left            =   120
         TabIndex        =   0
         Top             =   240
         Width           =   615
      End
   End
End
Attribute VB_Name = "frmIssn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'ประกาศตัวแปร
Dim LibraryWs As Workspace
Dim LibraryDb As Database
Dim IssnDyn As Recordset
Dim IssnSnap As Recordset

Private Sub btnAdd_Click()

    On Error GoTo HandleError
    
    'Disable ปุ่ม btnAdd, btnEdit และ btnDelete ในขณะที่ทำการเพิ่มข้อมูล
    Call EnableOperationButton(False)
    
    'Disable ปุ่ม btnJournal, btnPaper และ btnExit ในขณะที่ทำการเพิ่มข้อมูล
    Call EnablebtnForm(False)
    
    'Enable เมนู btnSave และ btnCancel
    Call EnableSaveCancelButton(True)
    
    'ไม่แสดงปุ่ม btnMove
    Call VisiblebtnMove(False)
    
    'Clear หน้าจอเพื่อรอรับข้อมูลใหม่
    Call ClearData
    
    'Enable ช่องรับข้อมูล
    Call EnableTxt(True)

     'เลื่อนเคอร์เซอร์ ไปที่ txtIssnLeft บนหน้าจอเพื่อรอรับข้อมูลใหม่
    txtIssnLeft.SetFocus
    
    'ใช้เมดทอด AddNew เพื่อเพิ่มข้อมูลเรคคอร์ดใหม่
    IssnDyn.AddNew
    
    'แสดงสถานะ
    Call CheckStatus
    
    Exit Sub

HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
    
End Sub

Private Sub btnCancel_Click()

     'ยกเลิกการเพิ่มหรือแก้ไขข้อมูลเมื่ออยู่ในสถานะ AddNew และ Edit
    If (IssnDyn.EditMode = dbEditAdd) Or (IssnDyn.EditMode = dbEditInProgress) Then
        IssnDyn.CancelUpdate
    End If
    
    'Clear ฟิล์ดต่างๆ บนหน้าจอ
    Call ClearData
    
     If IssnDyn.RecordCount <> 0 Then
        'แสดงข้อมูลจากตารางบนหน้าจอ
        Call DisplayFields
    
        'Enbale เมนู btnAdd, btnEdit และ btnDelete หลังจากยกเลิกการบันทึกข้อมูล
        Call EnableOperationButton(True)
    
        'แสดงปุ่ม btnMove
        Call VisiblebtnMove(True)
    Else
        Call RecordZero
    End If
    
    'แสดงสถานะ
    Call CheckStatus
    
    'Disable ช่องรับข้อมูล
    Call EnableTxt(False)
    
     'Disable ปุ่ม btnSave และ btnCancel หลังจากยกเลิกการบันทึกข้อมูล
    Call EnableSaveCancelButton(False)
    
    'Enable ปุ่ม btnJournal, btnPaper และ btnExit หลังจากยกเลิกการบันทึกข้อมูล
    Call EnablebtnForm(True)
    
End Sub

Private Sub btnDelete_Click()

    On Error GoTo HandleError
    
    'ยืนยันการลบข้อมูล
    If MsgBox("ต้องการลบวารสารนี้ แน่ใจหรือไม่", vbYesNo) = vbYes Then
        'ลบข้อมูลเรคคอร์ดปัจจุบัน
        IssnDyn.Delete
        
        'เช็คเรคคอร์ด
        If IssnDyn.RecordCount <> 0 Then
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
    
    'Enable ช่องรับข้อมูล
    Call EnableTxt(True)

    'เลื่อนเคอร์เซอร์ไปที่ txtIssnLeft บนหน้าจอเพื่อรอรับข้อมูล
    txtIssnLeft.SetFocus
    
     'ใช้เมดทอด Edit เพื่อแก้ไขข้อมูล
    IssnDyn.Edit
    
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

Private Sub btnJournal_Click()

    'ปิดฟอร์ม
    Unload Me
    
    'เปิดฟอร์ม Journal
    frmJournal.Show vbModal, frmMain
    
End Sub

Private Sub btnMoveFirst_Click()

    'ไปที่เรคคอร์ดแรก
    IssnDyn.MoveFirst
    
    'แสดงข้อมูลบนหน้าจอ
    Call DisplayFields
    
    'Enable ปุ่ม btnMoveLast และ btnMoveNext
    Call EnableMoveLastMoveNextButton(True)
    
    'Disable ปุ่ม btnMoveFirst และ btnMovePrevious
    Call EnableMoveFirstMovePreviousButton(False)
    
End Sub

Private Sub btnMoveLast_Click()

    'ไปที่เรคคอร์ดสุดท้าย
    IssnDyn.MoveLast
    
    'แสดงข้อมูลบนหน้าจอ
    Call DisplayFields
    
    'Disable ปุ่ม btnMoveLast และ btnMoveNext
    Call EnableMoveLastMoveNextButton(False)
    
    'Enable ปุ่ม btnMoveFirst และ btnMovePrevious
    Call EnableMoveFirstMovePreviousButton(True)
    
End Sub

Private Sub btnMoveNext_Click()

    'ไปที่เรคคอร์ดถัดไป
    IssnDyn.MoveNext
    
    'ถ้าไม่ใช้เรคคอร์ดสุดท้าย
    If IssnDyn.EOF = True Then
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
    
End Sub

Private Sub btnMovePrevious_Click()

    'ไปเรคคอร์ดก่อนหน้านี้
    IssnDyn.MovePrevious
    
    'ถ้าไม่ใช่เรคคอร์ดแรก
    If IssnDyn.BOF = True Then
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
    
End Sub

Private Sub btnPaper_Click()

    'ปิดฟอร์ม
    Unload Me
    
    'เปิดฟอร์ม Paper
    frmPaper.Show vbModal, frmMain
    
End Sub

Private Sub btnSave_Click()

    On Error GoTo HandleError
    
    'ตรวจสอบความถูกต้องของข้อมูลก่อนการบันทึกข้อมูล
    If txtIssnLeft.Text = "" Then
        MsgBox "กรุณาใส่ ISSN ก่อนการบันทึกข้อมูล"
        txtIssnLeft.SetFocus
    ElseIf Not IsNumeric(txtIssnLeft.Text) Then
        MsgBox "กรุณาใส่ ISSN เป็นตัวเลข"
        txtIssnLeft.Text = ""
        txtIssnLeft.SetFocus
    ElseIf txtIssnRight.Text = "" Then
        MsgBox "กรุณาใส่ ISSN ก่อนการบันทึกข้อมูล"
        txtIssnRight.SetFocus
    ElseIf Not IsNumeric(txtIssnRight.Text) Then
        MsgBox "กรุณาใส่ ISSN เป็นตัวเลข"
        txtIssnRight.Text = ""
        txtIssnRight.SetFocus
    ElseIf txtThaiJournal.Text = "" Then
        MsgBox "กรุณาใส่ชื่อวารสารภาษาไทย ก่อนการบันทึกข้อมูล"
        txtThaiJournal.SetFocus
    ElseIf txtEngJournal.Text = "" Then
        MsgBox "กรุณาใส่ชื่อวารสารภาษาอังกฤษ ก่อนการบันทึกข้อมูล"
        txtEngJournal.SetFocus
    'ถ้าไม่มีข้อมูลใดๆ ผิดพลาด ให้ทำการบันทึกข้อมูล
    Else
    'กำหนดค่าให้กับฟิล์ดต่างๆ ตามข้อมูลบนหน้าจอ
        With IssnDyn
            .Fields("Issn") = txtIssnLeft.Text & "-" & txtIssnRight.Text
            .Fields("ThaiJournal") = Trim(txtThaiJournal.Text)
            .Fields("EngJournal") = Trim(txtEngJournal.Text)
        End With
        
        'ใช้เมดทอด Update เพื่อบันทึกข้อมูลลงในเรคคอร์ดเซท
        IssnDyn.Update
        
        'เลื่อนเรคคอร์ดเซทไปยังเรคคอร์ดสุดท้ายที่มีการเปลี่ยนแปลงข้อมูล
        IssnDyn.Bookmark = IssnDyn.LastModified
        
        'แสดงข้อมูลบนหน้าจอ
        Call DisplayFields
        Call OpenQuery
        
        'แสดงสถานะ
        Call CheckStatus
    
        MsgBox "บันทึกข้อมูลเรียบร้อยแล้ว"
        
        'Disable ช่องรับข้อมูล
        Call EnableTxt(False)
        
        'Disable เมนู btnSave และ btnCancel หลังจากบันทึกข้อมูลเรียบร้อยแล้ว
        Call EnableSaveCancelButton(False)
        
        'Enable เมนู btnAdd, btnEdit และ btnDelete หลังจากบันทึกข้อมูลเรียบร้อยแล้ว
        Call EnableOperationButton(True)
        
        'Enable ปุ่ม btnJournal, btnPaper และ btnExit หลังจากบันทึกข้อมูลเรียบร้อยแล้ว
        Call EnablebtnForm(True)
        
        'แสดงปุ่ม btnMove
        Call VisiblebtnMove(True)
        End If
    
    Exit Sub
    
HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
End Sub

Private Sub Form_Load()

    'ถ้าเกิด Error ขึ้นให้ข้ามไปทำงานที่ HandleError
    On Error GoTo HandleError
    
    frmIssn.Icon = LoadPicture(App.Path & "\Icon.ico")
    txtStatus.Enabled = False
    
    'เลือกใช้ Workspace(0)
    Set LibraryWs = DBEngine.Workspaces(0)
    
    'เปิดฐานข้อมูล Digital Library.Mdb
    Set LibraryDb = LibraryWs.OpenDatabase(App.Path & "\Digital Library.Mdb", False, False)
    
    'เปิดตาราง TblIssn โดยใช้เรคคอร์ดเซท IssnDyn
    Set IssnDyn = LibraryDb.OpenRecordset("SELECT * FROM TblIssn ORDER BY Issn", dbOpenDynaset)
    
    'เช็คเรคคอร์ดในเรคคอร์ดเซท
    If IssnDyn.RecordCount <> 0 Then
        'active RecordCount preperties
        IssnDyn.MoveLast
        
        'ไปที่เรคอร์ดแรกของเรคคอร์ดเซท IssnDyn
        IssnDyn.MoveFirst
        
        'แสดงข้อมูลบนหน้าจอ
        Call DisplayFields
        
        'Disable ปุ่ม btnMoveFirst และ btnMovePrevious เมื่ออยู่ที่เรคอร์ดแรก
        Call EnableMoveFirstMovePreviousButton(False)
    Else
        Call RecordZero
    
    End If
    
    'แสดงข้อมูลบน DBGrid
    Call OpenQuery
    
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

Private Sub txtIssnLeft_Change()

    'เช็คตัวอักษร
    If (Len(txtIssnLeft.Text) = 4) And ((IssnDyn.EditMode = dbEditAdd) Or (IssnDyn.EditMode = dbEditInProgress)) Then
        txtIssnRight.SetFocus
    End If
    
End Sub

Private Sub txtIssnRight_Change()
    
    'เช็คตัวอักษร
    If (Len(txtIssnRight.Text) = 4) And ((IssnDyn.EditMode = dbEditAdd) Or (IssnDyn.EditMode = dbEditInProgress)) Then
        txtThaiJournal.SetFocus
    End If
    
End Sub

Private Sub DisplayFields()

    'แสดงข้อมูลบนฟิล์ดต่างๆ บนหน้าจอ
    With IssnDyn
        txtIssnLeft.Text = Left(.Fields("Issn"), 4)
        txtIssnRight.Text = Right(.Fields("Issn"), 4)
        txtThaiJournal.Text = .Fields("ThaiJournal")
        txtEngJournal.Text = .Fields("EngJournal")
    End With
    
End Sub

Private Sub ClearData()
    
    'Clear ค่าของฟิล์ดต่างๆ บนหน้าจอ
    txtIssnLeft.Text = ""
    txtIssnRight.Text = ""
    txtThaiJournal.Text = ""
    txtEngJournal.Text = ""
    
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
    btnJournal.Enabled = EnableFlag
    btnPaper.Enabled = EnableFlag
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
    txtIssnLeft.Enabled = EnableFlag
    txtIssnRight.Enabled = EnableFlag
    txtThaiJournal.Enabled = EnableFlag
    txtEngJournal.Enabled = EnableFlag
    
End Sub

Private Sub RecordZero()

    'ไม่แสดง btnMove
    Call VisiblebtnMove(False)
        
    'Disable ปุ่ม btnEdit และ btnDelete
    btnEdit.Enabled = False
    btnDelete.Enabled = False
    
    'Enable ปุ่ม btnAdd
    btnAdd.Enabled = True
    
End Sub

Private Sub OpenQuery()
Dim SqlCommand As String

    SqlCommand = "SELECT * FROM TblIssn ORDER BY Issn"
    Set IssnSnap = LibraryDb.OpenRecordset(SqlCommand, dbOpenSnapshot)
    Set Data1.Recordset = IssnSnap
    
End Sub

Private Sub CloseRecordDb()

    'ปิดเรคคอร์ดเซทและฐานข้อมูล
    IssnDyn.Close
    IssnSnap.Close
    LibraryDb.Close
    
End Sub

Private Sub CheckStatus()

    With IssnDyn
        If .EditMode = dbEditAdd Then
            txtStatus.Text = "เพิ่ม ISSN"
        ElseIf .EditMode = dbEditInProgress Then
            txtStatus.Text = "แก้ไข ISSN"
        Else
            txtStatus.Text = "ISSN"
        End If
    End With
    
End Sub

