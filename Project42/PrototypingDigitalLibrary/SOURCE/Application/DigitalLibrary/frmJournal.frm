VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form frmJournal 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Digital Library"
   ClientHeight    =   5610
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6720
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5610
   ScaleWidth      =   6720
   StartUpPosition =   1  'CenterOwner
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "frmJournal.frx":0000
      Height          =   1575
      Left            =   120
      OleObjectBlob   =   "frmJournal.frx":0014
      TabIndex        =   37
      Top             =   3960
      Width           =   6495
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
         TabIndex        =   27
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.Frame Frame1 
      Height          =   735
      Left            =   120
      TabIndex        =   21
      Top             =   0
      Width           =   4815
      Begin VB.CommandButton btnExit 
         Caption         =   "ออกจากโปรแกรม"
         Height          =   375
         Left            =   3240
         TabIndex        =   20
         Top             =   240
         Width           =   1455
      End
      Begin VB.CommandButton btnPaper 
         Caption         =   "บทความ"
         Height          =   375
         Left            =   1680
         TabIndex        =   19
         Top             =   240
         Width           =   1455
      End
      Begin VB.CommandButton btnIssn 
         Caption         =   "ISSN"
         Height          =   375
         Left            =   120
         TabIndex        =   18
         Top             =   240
         Width           =   1455
      End
   End
   Begin VB.Frame Frame3 
      Height          =   735
      Left            =   120
      TabIndex        =   23
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
      TabIndex        =   24
      Top             =   1440
      Width           =   2175
      Begin VB.CommandButton btnCancel 
         Caption         =   "ยกเลิก"
         Height          =   375
         Left            =   1080
         TabIndex        =   16
         Top             =   240
         Width           =   975
      End
      Begin VB.CommandButton btnSave 
         Caption         =   "บันทึก"
         Height          =   375
         Left            =   120
         TabIndex        =   15
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame Frame5 
      Height          =   735
      Left            =   4440
      TabIndex        =   25
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
      TabIndex        =   26
      Top             =   720
      Width           =   4335
      Begin VB.CommandButton btnMoveNextThaiJournal 
         Caption         =   ">"
         Height          =   375
         Left            =   3960
         TabIndex        =   1
         Top             =   240
         Width           =   255
      End
      Begin VB.CommandButton btnMovePreviousThaiJournal 
         Caption         =   "<"
         Height          =   375
         Left            =   840
         TabIndex        =   0
         Top             =   240
         Width           =   255
      End
      Begin VB.TextBox txtThaiJournal 
         Height          =   375
         Left            =   1080
         TabIndex        =   38
         Top             =   240
         Width           =   2895
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "วารสาร"
         Height          =   210
         Left            =   240
         TabIndex        =   29
         Top             =   240
         Width           =   510
      End
   End
   Begin VB.Frame Frame7 
      Height          =   735
      Left            =   4440
      TabIndex        =   28
      Top             =   720
      Width           =   2175
      Begin VB.CommandButton btnNewJournal 
         Caption         =   "วารสารฉบับใหม่"
         Height          =   375
         Left            =   120
         TabIndex        =   17
         Top             =   240
         Width           =   1935
      End
   End
   Begin VB.Frame Frame8 
      Height          =   1695
      Left            =   120
      TabIndex        =   30
      Top             =   2160
      Width           =   6495
      Begin VB.ComboBox cmbPeriodicity 
         Height          =   330
         Left            =   4320
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   1200
         Width           =   2055
      End
      Begin VB.TextBox txtYear 
         Height          =   375
         Left            =   5880
         MaxLength       =   4
         TabIndex        =   13
         Top             =   720
         Width           =   495
      End
      Begin VB.ComboBox cmbMonth 
         Height          =   330
         Left            =   3480
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   720
         Width           =   1335
      End
      Begin VB.TextBox txtNumber 
         Height          =   375
         Left            =   2040
         TabIndex        =   11
         Top             =   720
         Width           =   855
      End
      Begin VB.TextBox txtVolume 
         Height          =   375
         Left            =   480
         TabIndex        =   10
         Top             =   720
         Width           =   855
      End
      Begin VB.ComboBox cmbEditor 
         Height          =   330
         Left            =   3480
         TabIndex        =   9
         Top             =   240
         Width           =   2895
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "วาระที่ออก"
         Height          =   210
         Left            =   3480
         TabIndex        =   36
         Top             =   1200
         Width           =   720
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ปี พ.ศ."
         Height          =   210
         Left            =   5280
         TabIndex        =   35
         Top             =   720
         Width           =   480
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "เดือน"
         Height          =   210
         Left            =   3000
         TabIndex        =   34
         Top             =   720
         Width           =   390
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ฉบับที่"
         Height          =   210
         Left            =   1440
         TabIndex        =   33
         Top             =   720
         Width           =   435
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ปีที่"
         Height          =   210
         Left            =   120
         TabIndex        =   32
         Top             =   720
         Width           =   210
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "บรรณาธิการ"
         Height          =   210
         Left            =   2520
         TabIndex        =   31
         Top             =   240
         Width           =   855
      End
   End
   Begin VB.Data Data1 
      Caption         =   "วารสาร"
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
      Top             =   3720
      Visible         =   0   'False
      Width           =   2295
   End
End
Attribute VB_Name = "frmJournal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'ประกาศตัวแปร
Dim LibraryWs As Workspace
Dim LibraryDb As Database
Dim JournalDyn As Recordset
Dim ThaiJournalSnap As Recordset
Dim JournalSnap As Recordset
Dim IdJournalSnap As Recordset
Dim EditorSnap As Recordset
Dim Explorer As SHDocVw.InternetExplorer

Private Sub btnAdd_Click()

    On Error GoTo HandleError
    
    'Disable ปุ่ม btnNewJournal
    btnNewJournal.Enabled = False
    
    'Disable ปุ่ม btnAdd, btnEdit และ btnDelete ในขณะที่ทำการเพิ่มข้อมูล
    Call EnableOperationButton(False)
    
    'Disable ปุ่ม btnJournal, btnPaper และ btnExit ในขณะที่ทำการเพิ่มข้อมูล
    Call EnablebtnForm(False)
    
    'Enable ปุ่ม btnSave และ btnCancel
    Call EnableSaveCancelButton(True)
    
    'ไม่แสดงปุ่ม btnMove
    Call VisiblebtnMove(False)
    
    'ไม่แสดงปุ่ม btnMoveThaiJournal
    Call VisiblebtnMoveThaiJournal(False)
    
    'Clear หน้าจอเพื่อรอรับข้อมูลใหม่
    Call ClearData
    
    'Enable ช่องรับข้อมูล
    Call EnableTxt(True)
    
    'Disable ปุ่ม btnNewJournal
    btnNewJournal.Enabled = False
    
    'เลื่อนเคอร์เซอร์ ไปที่ cmbThaiJournal บนหน้าจอเพื่อรอรับข้อมูลใหม่
    cmbEditor.SetFocus
    
    'ใช้เมดทอด AddNew เพื่อเพิ่มข้อมูลเรคคอร์ดใหม่
    JournalDyn.AddNew
    
    'แสดงสถานะ
    Call CheckStatus
    
    'แสดงเดือนต่างๆ ใน cmbMonth
    Call AddMonth
    cmbMonth.Text = cmbMonth.List(0)
    
    'แสดงวาระที่ออกของวารสารใน cmbPeriodicity
    Call AddPeriodicity
    cmbPeriodicity.Text = cmbPeriodicity.List(0)
    
    Exit Sub

HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
End Sub

Private Sub btnCancel_Click()

     'ยกเลิกการเพิ่มหรือแก้ไขข้อมูลเมื่ออยู่ในสถานะ AddNew และ Edit
    If (JournalDyn.EditMode = dbEditAdd) Or (JournalDyn.EditMode = dbEditInProgress) Then
        JournalDyn.CancelUpdate
    End If
    
    'Clear ฟิล์ดต่างๆ บนหน้าจอ
    Call ClearData
    
    If JournalDyn.RecordCount <> 0 Then
        'แสดงข้อมูลจากตารางบนหน้าจอ
        Call DisplayFields
    
        'Enbale ปุ่ม btnAdd, btnEdit และ btnDelete หลังจากยกเลิกการบันทึกข้อมูล
        Call EnableOperationButton(True)
        
        'Enable ปุ่ม btnNewJournal
        btnNewJournal.Enabled = True
        
        'แสดงปุ่ม btnMove
        Call VisiblebtnMove(True)
        
        'แสดงปุ่ม btnMoveThaiJournal
        Call VisiblebtnMoveThaiJournal(True)
        
    Else
        Call RecordZero
    End If
    
    'แสดงสถานะ
    Call CheckStatus
    
    'Disable ช่องรับข้อมูล
    Call EnableTxt(False)
    
    'Enable ปุ่ม btnJournal, btnPaper และ btnExit หลังจากยกเลิกการบันทึกข้อมูล
    Call EnablebtnForm(True)
    
    'Disable เมนู btnSave และ btnCancel หลังจากบันทึกข้อมูลเรียบร้อยแล้ว
    Call EnableSaveCancelButton(False)
        
End Sub

Private Sub btnDelete_Click()

    On Error GoTo HandleError
    
    'ยืนยันการลบข้อมูล
    If MsgBox("ต้องการลบวารสารฉบับนี้ แน่ใจหรือไม่", vbYesNo) = vbYes Then
        'ลบข้อมูลเรคคอร์ดปัจจุบัน
        JournalDyn.Delete
        
        'เช็คเรคคอร์ด
        If JournalDyn.RecordCount <> 0 Then
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
    
    'Disable ปุ่ม btnNewJournal
    btnNewJournal.Enabled = False
    
    'Disable ปุ่ม btnAdd, btnEdit และ btnDelete ในขณะที่ทำการแก้ไขข้อมูล
    Call EnableOperationButton(False)
    
   'Disable ปุ่ม btnJournal, btnPaper และ btnExit ในขณะที่ทำการแก้ไขข้อมูล
    Call EnablebtnForm(False)
    
    'Enable ปุ่ม btnSave และ btnCancel
    Call EnableSaveCancelButton(True)
    
    'ไม่แสดงปุ่ม btnMove
    Call VisiblebtnMove(False)
    
    'ไม่แสดงปุ่ม btnMoveThaiJournal
    Call VisiblebtnMoveThaiJournal(False)
    
    'Enable ช่องรับข้อมูล
    Call EnableTxt(True)

    'เลื่อนเคอร์เซอร์ไปที่ cmbEditor บนหน้าจอเพื่อรอรับข้อมูล
    cmbEditor.SetFocus
    
     'ใช้เมดทอด Edit เพื่อแก้ไขข้อมูล
    JournalDyn.Edit
    
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

Private Sub btnMoveFirst_Click()

    'ไปที่เรคคอร์ดแรก
    JournalDyn.MoveFirst
    
    'แสดงข้อมูลบนหน้าจอ
    Call DisplayFields
    
    'Enable ปุ่ม btnMoveLast และ btnMoveNext
    Call EnableMoveLastMoveNextButton(True)
    
    'Disable ปุ่ม btnMoveFirst และ btnMovePrevious
    Call EnableMoveFirstMovePreviousButton(False)
    
End Sub

Private Sub btnMoveLast_Click()

     'ไปที่เรคคอร์ดสุดท้าย
    JournalDyn.MoveLast
    
    'แสดงข้อมูลบนหน้าจอ
    Call DisplayFields
    
    'Disable ปุ่ม btnMoveLast และ btnMoveNext
    Call EnableMoveLastMoveNextButton(False)
    
    'Enable ปุ่ม btnMoveFirst และ btnMovePrevious
    Call EnableMoveFirstMovePreviousButton(True)
    
End Sub

Private Sub btnMoveNext_Click()

    'ไปที่เรคคอร์ดถัดไป
    JournalDyn.MoveNext
    
    'ถ้าไม่ใช้เรคคอร์ดสุดท้าย
    If JournalDyn.EOF = True Then
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

Private Sub btnMoveNextThaiJournal_Click()

    'ไปเรคคอร์ดถัดไป
    ThaiJournalSnap.MoveNext
    
    'ถ้าเป็นเรคคอร์ดสุดท้าย
    If ThaiJournalSnap.EOF Then
        'ไปที่เรคคอร์ดสุดท้าย
        ThaiJournalSnap.MoveLast
        
        'Disable ปุ่ม btnMoveNextThaiJournal
        btnMoveNextThaiJournal.Enabled = False
    End If
        'Enable ปุ่ม btnMovePreviousThaiJournal
        btnMovePreviousThaiJournal.Enabled = True
        
        'แสดงข้อมูล ThaiJournal บนหน้าจอ
        Call DisplayThaiJournal
        
        'แสดงข้อมูล Journal
        Call OpenQueryJournal
        
        'แสดงข้อมูลบน DBGrid
        Call OpenQuery
    
        'เช็คเรคคอร์ด JournalDyn มีเรคคอร์ดเป็น 0 หรือไม่
        Call CheckRecordJournalDyn
        
End Sub

Private Sub btnMovePrevious_Click()

    'ไปเรคคอร์ดก่อนหน้านี้
    JournalDyn.MovePrevious
    
    'ถ้าใช่เรคคอร์ดแรก
    If JournalDyn.BOF = True Then
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

Private Sub btnMovePreviousThaiJournal_Click()

    'ไปเรคคอร์ดก่อนหน้านี้
    ThaiJournalSnap.MovePrevious
    
    'ถ้าเป็นเรคคอร์ดแรก
    If ThaiJournalSnap.BOF Then
        'ไปที่เรคคอร์ดแรก
        ThaiJournalSnap.MoveFirst
        
        'Disable ปุ่ม btnMovePreviousThaiJournal
        btnMovePreviousThaiJournal.Enabled = False
    End If
        'Enable ปุ่ม btnMoveNextThaiJournal
        btnMoveNextThaiJournal.Enabled = True
        
        'แสดงข้อมูล ThaiJournal บนหน้าจอ
        Call DisplayThaiJournal
        
        'แสดงข้อมูล Journal
        Call OpenQueryJournal
        
        'แสดงข้อมูลบน DBGrid
        Call OpenQuery
    
        'เช็คเรคคอร์ด JournalDyn มีเรคคอร์ดเป็น 0 หรือไม่
        Call CheckRecordJournalDyn
        
End Sub

Private Sub btnNewJournal_Click()
    Dim objFSO As New FileSystemObject
    Dim objFile As File
    Dim objTs As TextStream
    Dim Text As String
    
    If objFSO.FileExists(App.Path & "\Host.txt") = False Then
        objFSO.CreateTextFile (App.Path & "\Host.txt")
        Set objFile = objFSO.GetFile(App.Path & "\Host.txt")
        Set objTs = objFile.OpenAsTextStream(ForWriting)
        Text = InputBox("กรุณาใส่ IP เครื่อง Server ", "IP เครื่อง Server")
        objTs.Write (Trim(Text))
        objTs.Close
    End If
    
    Set objTs = objFSO.OpenTextFile(App.Path & "\Host.txt", ForReading, False)
    Set Explorer = New SHDocVw.InternetExplorer
    Explorer.Visible = True
    Explorer.Navigate ("http://" & objTs.ReadLine & "/DigitalLibrary" & "/maillist.asp?ISSN=" & ThaiJournalSnap.Fields("Issn") & "&" & "ThaiJournal=" & ThaiJournalSnap.Fields("ThaiJournal"))
    
End Sub

Private Sub btnPaper_Click()

    'ปิดฟอร์ม
    Unload Me
    
    'เปิดฟอร์ม Paper
    frmPaper.Show vbModal, frmMain
    
End Sub

Private Sub btnSave_Click()
Dim IdJournal As Integer

    'On Error GoTo HandleError
    
    'ตรวจสอบความถูกต้องของข้อมูลก่อนการบันทึกข้อมูล
    If cmbEditor.Text = "" Then
        MsgBox "กรุณาเลือกหรือใส่ชื่อบรรณาธิการ ก่อนการบันทึกข้อมูล"
        cmbEditor.SetFocus
   ElseIf txtNumber.Text = "" Then
        MsgBox "กรุณาใส่ฉบับที่พิมพ์ ก่อนการบันทึกข้อมูล"
        txtNumber.SetFocus
    ElseIf txtYear.Text = "" Then
        MsgBox "กรุณาใส่ปี พ.ศ. ก่อนการบันทึกข้อมูล"
        txtYear.SetFocus
    ElseIf Not IsNumeric(txtYear.Text) Then
        MsgBox "กรุณาใส่ปี พ.ศ. เป็นตัวเลข"
        txtYear.Text = ""
        txtYear.SetFocus
    'ถ้าไม่มีข้อมูลใดๆ ผิดพลาด ให้ทำการบันทึกข้อมูล
    Else
        'กำหนดค่าให้กับฟิล์ดต่างๆ ตามข้อมูลบนหน้าจอ
        With JournalDyn
             If .EditMode = dbEditAdd Then
                'ดึงข้อมูลฟิล์ด IdJournal จากตาราง TblJournal
                Set IdJournalSnap = LibraryDb.OpenRecordset("SELECT IdJournal FROM TblJournal ORDER BY IdJournal", dbOpenSnapshot)
                With IdJournalSnap
                    If .RecordCount <> 0 Then
                        .Requery
                        .MoveLast
                        IdJournal = .Fields("IdJournal") + 1
                    Else
                        IdJournal = 1
                    End If
                End With
                .Fields("IdJournal") = IdJournal
            End If
            .Fields("Editor") = Trim(cmbEditor.Text)
            .Fields("Volume") = Trim(txtVolume.Text)
            .Fields("Number") = Trim(txtNumber.Text)
            .Fields("Month") = cmbMonth.Text
            .Fields("Year") = Val(txtYear.Text)
            .Fields("Periodicity") = cmbPeriodicity.Text
            .Fields("Issn") = ThaiJournalSnap.Fields("Issn")
        End With
        
        'ใช้เมดทอด Update เพื่อบันทึกข้อมูลลงในเรคคอร์ดเซท
        JournalDyn.Update
        
        'เลื่อนเรคคอร์ดเซทไปยังเรคคอร์ดสุดท้ายที่มีการเปลี่ยนแปลงข้อมูล
        JournalDyn.Bookmark = JournalDyn.LastModified
        
        'แสดงข้อมูลบนหน้าจอ
        EditorSnap.Requery
        Call ReadEditor
        Call DisplayFields
        Call OpenQuery
        
        'แสดงสถานะ
        Call CheckStatus
    
        'แสดงการบันทึกข้อมูล
        MsgBox "บันทึกข้อมูลเรียบร้อยแล้ว"
        
        'Enable ปุ่ม btnNewJournal
        btnNewJournal.Enabled = True
        
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
        
        'แสดงปุ่ม btnMoveThaiJournal
        Call VisiblebtnMoveThaiJournal(True)
        
        'ปิดเรคคอร์ดเซท
        IdJournalSnap.Close
    End If
    Exit Sub
    
'HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
'    MsgBox Error(Err.Number)
End Sub

Private Sub Form_Load()

    'ถ้าเกิด Error ขึ้นให้ข้ามไปทำงานที่ HandleError
    On Error GoTo HandleError
    
    frmJournal.Icon = LoadPicture(App.Path & "\Icon.ico")
    txtStatus.Enabled = False
    txtThaiJournal.Enabled = False
    
     'เลือกใช้ Workspace(0)
    Set LibraryWs = DBEngine.Workspaces(0)
    
    'เปิดฐานข้อมูล Digital Library.Mdb
    Set LibraryDb = LibraryWs.OpenDatabase(App.Path & "\Digital Library.Mdb", False, False)
    
    'เปิดตาราง TblIssn โดยใช้เรคคอร์ดเซท ThaiJournalSnap
    Set ThaiJournalSnap = LibraryDb.OpenRecordset("SELECT Issn, ThaiJournal FROM TblIssn ORDER BY Issn", dbOpenSnapshot)
    
    'เช็คตาราง TblIssn มีเรคคอร์ดเป็น 0 หรือไม่
    If ThaiJournalSnap.RecordCount <> 0 Then
        'ไปที่เรคคอร์ดแรกของ ThaiJournalSnap
        ThaiJournalSnap.MoveFirst
        
        'Disable ปุ่ม btnMovePreviousThaiJournal เมื่ออยู่ที่เรคคอร์ดแรก
        btnMovePreviousThaiJournal.Enabled = False
        
        'แสดงข้อมูลฟิล์ด ThaiJournal บนหน้าจอ
        Call DisplayThaiJournal
        
        'ดึงข้อมูลฟิล์ด Editor จากตาราง TblJournal ไว้ในเรคคอร์ดเซท EditorSnap
        Set EditorSnap = LibraryDb.OpenRecordset("SELECT DISTINCT Editor FROM TblJournal ORDER BY Editor", dbOpenSnapshot)
            
        'เปิดตาราง TbllJournal โดยใช้เรคคอร์ดเซท JournalDyn
        Call OpenQueryJournal
        
        'แสดงข้อมูลบน DBGrid
        Call OpenQuery
        
        'เช็คเรคคอร์ด JournalDyn มีเรคคอร์ดเป็น 0 หรือไม่
        Call CheckRecordJournalDyn
        
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
    With JournalDyn
        'txtStatus.Text = .Fields("IdJournal")
        cmbEditor.Text = .Fields("Editor")
        txtVolume.Text = .Fields("Volume")
        txtNumber.Text = .Fields("Number")
        cmbMonth.Text = .Fields("Month")
        txtYear.Text = .Fields("Year")
        cmbPeriodicity.Text = .Fields("Periodicity")
    End With
    
End Sub

Private Sub DisplayThaiJournal()

    'แสดงข้อมูลฟิล์ด ThaiJournal
    With ThaiJournalSnap
        txtThaiJournal.Text = .Fields("ThaiJournal")
    End With
    
End Sub

Private Sub ClearData()
    
    'Clear ค่าของฟิล์ดต่างๆ บนหน้าจอ
    cmbEditor.Text = ""
    txtVolume.Text = ""
    txtNumber.Text = ""
    txtYear.Text = ""
    
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

Private Sub VisiblebtnMoveThaiJournal(VisibleFlag As Boolean)

    'แสดงหรือไม่แสดงปุ่ม btnMovePreviousThaiJournal และ btnMoveNextThaiJournal
    btnMovePreviousThaiJournal.Visible = VisibleFlag
    btnMoveNextThaiJournal.Visible = VisibleFlag
    
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
    cmbEditor.Enabled = EnableFlag
    txtVolume.Enabled = EnableFlag
    txtNumber.Enabled = EnableFlag
    cmbMonth.Enabled = EnableFlag
    txtYear.Enabled = EnableFlag
    cmbPeriodicity.Enabled = EnableFlag
    
End Sub

Private Sub CheckRecordJournalDyn()

    If JournalDyn.RecordCount <> 0 Then
            'active RecordCount property
            JournalDyn.MoveLast
            
            'ดึงข้อมูลฟิล์ด Editor จากตาราง TblJournal ไปใส่ใน ComboBox cmbEditor
            Call ReadEditor
            
            'แสดงเดือนต่างๆ ใน cmbMonth
            cmbMonth.Clear
            Call AddMonth
    
            'แสดงวาระที่ออกของวารสารใน cmbPeriodicity
            cmbPeriodicity.Clear
            Call AddPeriodicity
            
            'ไปที่เรคอร์ดแรกของเรคคอร์ดเซท JournalDyn
            Call btnMoveFirst_Click
            
            'แสดงข้อมูลเรคคอร์ดแรกบนหน้าจอ
            Call DisplayFields
            
            'แสดงปุ่ม btnMove
            Call VisiblebtnMove(True)
            
            'Enable ปุ่ม btnNewJournal
            btnNewJournal.Enabled = True
            
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
    
    'Disable ปุ่ม btnNewJournal
    btnNewJournal.Enabled = False
    
    'Clear ข้อมูลบนหน้าจอ
    Call ClearData
    
    cmbEditor.Clear
    cmbMonth.Clear
    cmbPeriodicity.Clear
    
End Sub

Private Sub OpenQueryJournal()
Dim SqlCommand As String

     'เปิดตาราง TbllJournal โดยใช้เรคคอร์ดเซท JournalDyn
     SqlCommand = "SELECT * FROM TblJournal "
     SqlCommand = SqlCommand & "WHERE Issn = " & "'" & ThaiJournalSnap.Fields("Issn") & "'"
     SqlCommand = SqlCommand & "ORDER BY IdJournal DESC"
     Set JournalDyn = LibraryDb.OpenRecordset(SqlCommand, dbOpenDynaset)
        
End Sub

Private Sub OpenQuery()
Dim SqlCommand As String

    SqlCommand = "SELECT Editor, Volume, Number, Month, Year, Periodicity "
    SqlCommand = SqlCommand & "FROM TblJournal "
    SqlCommand = SqlCommand & "WHERE Issn = " & "'" & ThaiJournalSnap.Fields("Issn") & "'"
    SqlCommand = SqlCommand & "ORDER BY IdJournal DESC"
    Set JournalSnap = LibraryDb.OpenRecordset(SqlCommand, dbOpenSnapshot)
    Set Data1.Recordset = JournalSnap
    
End Sub

Private Sub CloseRecordDb()

    'ปิดเรคคอร์ดเซทและฐานข้อมูล
    If ThaiJournalSnap.RecordCount <> 0 Then
        If JournalDyn.RecordCount <> 0 Then
            JournalDyn.Close
            JournalSnap.Close
            EditorSnap.Close
        End If
    End If
    
    ThaiJournalSnap.Close
    LibraryDb.Close
    
End Sub

Private Sub ReadEditor()
    On Error GoTo HandleError
    
    'ไปที่เรคคอร์ดแรกของ EditorSnap
    EditorSnap.MoveFirst
    
    'Clear ข้อมูลใน ComboBox cmbEditor
    cmbEditor.Clear
    
    'วนลูปจะกว่าจะ End-Of-File ของ EditorSnap
    Do While Not EditorSnap.EOF
        'เพิ่ม Editor ใน cmbEditor
        cmbEditor.AddItem (EditorSnap.Fields("Editor"))
        
        'ไปยังเรคคอร์ดถัดไป
        EditorSnap.MoveNext
    Loop
    
    Exit Sub
    
HandleError:
    'แสดง Error Message เมื่อเกิดข้อผิดพลาดขึ้น
    MsgBox Error(Err.Number)
    
End Sub

Private Sub AddPeriodicity()
        
    cmbPeriodicity.AddItem ("รายเดือน")
    cmbPeriodicity.AddItem ("ราย 2 เดือน")
    cmbPeriodicity.AddItem ("ราย 3 เดือน")
    cmbPeriodicity.AddItem ("ราย 4 เดือน")
    cmbPeriodicity.AddItem ("ราย 6 เดือน")
    cmbPeriodicity.AddItem ("รายปี")

End Sub

Private Sub AddMonth()
    
    cmbMonth.AddItem ("มกราคม")
    cmbMonth.AddItem ("กุมภาพันธ์")
    cmbMonth.AddItem ("มีนาคม")
    cmbMonth.AddItem ("เมษายน")
    cmbMonth.AddItem ("พฤษภาคม")
    cmbMonth.AddItem ("มิถุนายน")
    cmbMonth.AddItem ("กรกฎาคม")
    cmbMonth.AddItem ("สิงหาคม")
    cmbMonth.AddItem ("กันยายน")
    cmbMonth.AddItem ("ตุลาคม")
    cmbMonth.AddItem ("พฤศจิกายน")
    cmbMonth.AddItem ("ธันวาคม")
    
End Sub

Private Sub CheckStatus()

    With JournalDyn
        If .EditMode = dbEditAdd Then
            txtStatus.Text = "เพิ่มวารสาร"
        ElseIf .EditMode = dbEditInProgress Then
            txtStatus.Text = "แก้ไขวารสาร"
        Else
            txtStatus.Text = "วารสาร"
        End If
    End With
    
End Sub

Private Sub txtYear_Change()

    'เช็คตัวอักษร
    If (Len(txtYear.Text) = 4) And ((JournalDyn.EditMode = dbEditAdd) Or (JournalDyn.EditMode = dbEditInProgress)) Then
        cmbPeriodicity.SetFocus
    End If
    
End Sub
