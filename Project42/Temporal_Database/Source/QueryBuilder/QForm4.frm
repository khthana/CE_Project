VERSION 5.00
Begin VB.Form QForm4 
   Caption         =   "ข้อมูลปัจจุบันของการลงทะเบียนของ ... ในวิชา ..."
   ClientHeight    =   4395
   ClientLeft      =   2220
   ClientTop       =   1740
   ClientWidth     =   5670
   LinkTopic       =   "Form2"
   ScaleHeight     =   4395
   ScaleWidth      =   5670
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "การลงทะเบียนของ"
      Height          =   1860
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   5655
      Begin VB.ComboBox RowStudent 
         Height          =   315
         Left            =   3240
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   840
         Width           =   2055
      End
      Begin VB.ComboBox ColumnStudent 
         Height          =   315
         ItemData        =   "QForm4.frx":0000
         Left            =   840
         List            =   "QForm4.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   840
         Width           =   2055
      End
      Begin VB.Label Label1 
         Caption         =   "เลือกคอลัมน์"
         Height          =   255
         Left            =   840
         TabIndex        =   11
         Top             =   480
         Width           =   1455
      End
      Begin VB.Label Label2 
         Caption         =   "เลือกแถว"
         Height          =   375
         Left            =   3240
         TabIndex        =   10
         Top             =   480
         Width           =   1695
      End
   End
   Begin VB.Frame k 
      Caption         =   "วิชา"
      Height          =   1860
      Left            =   0
      TabIndex        =   2
      Top             =   1920
      Width           =   5655
      Begin VB.TextBox Text1 
         Height          =   375
         Left            =   1920
         TabIndex        =   12
         Text            =   "Text1"
         Top             =   1320
         Width           =   1575
      End
      Begin VB.ComboBox RowSub 
         Height          =   315
         Left            =   3240
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   840
         Width           =   2055
      End
      Begin VB.ComboBox ColumnSub 
         Height          =   315
         ItemData        =   "QForm4.frx":0004
         Left            =   840
         List            =   "QForm4.frx":0006
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   840
         Width           =   2055
      End
      Begin VB.Label Label3 
         Caption         =   "เลือกคอลัมน์"
         Height          =   255
         Left            =   840
         TabIndex        =   6
         Top             =   480
         Width           =   1455
      End
      Begin VB.Label Label4 
         Caption         =   "เลือกแถว"
         Height          =   375
         Left            =   3240
         TabIndex        =   5
         Top             =   480
         Width           =   1695
      End
   End
   Begin VB.CommandButton exitcmd 
      Caption         =   "&ยกเลิก"
      Height          =   375
      Left            =   3240
      TabIndex        =   1
      Top             =   3960
      Width           =   1215
   End
   Begin VB.CommandButton querycmd 
      Caption         =   "&ค้นหา"
      Height          =   375
      Left            =   840
      TabIndex        =   0
      Top             =   3960
      Width           =   1215
   End
End
Attribute VB_Name = "QForm4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private RstStudent As Recordset
Private RstSubject As Recordset
Dim FieldStd As String
Dim FieldSub As String

Private Sub AddStudent(Column As String)
Dim i As Integer
    Select Case Column
        Case "รหัสนักศึกษา"
            FieldStd = "stdid"
        Case "คำนำหน้าชื่อ(ภาษาไทย)"
             FieldStd = "tpren"
        Case "คำนำหน้าชื่อ(ภาษาอังกฤษ)"
            FieldStd = "epren"
        Case "ชื่อ(ภาษาไทย)"
            FieldStd = "tname"
        Case "ชื่อ(ภาษาอังกฤษ)"
            FieldStd = "ename"
        Case "หลักสูตร"
            FieldStd = "degree"
        Case "ชนิดของนักศึกษา"
            FieldStd = "stdtype"
    End Select
        Set RstStudent = Form1.cnnTemporal.OpenRecordset _
        ("select distinct(" & FieldStd & ") from student", _
        dbOpenSnapshot) ', dbRunAsync)
    
    RowStudent.Clear
    RstStudent.MoveFirst
    Do While Not RstStudent.EOF
                 RowStudent.AddItem RstStudent.Fields _
                 (FieldStd).Value
                 RstStudent.MoveNext
    Loop
    RstStudent.Close
    
End Sub

Private Sub AddSubject(Column As String)
Dim i As Integer
    Select Case Column
        Case "รหัสวิชา"
            FieldSub = "subid"
        Case "ชื่อวิชา(ภาษาไทย)"
            FieldSub = "tname"
        Case "ชื่อวิชา(ภาษอังกฤษ)"
            FieldSub = "ename"
        Case "หน่วยกิต"
            FieldSub = "credit"
        Case "ชนิดของวิชา"
            FieldSub = "type"
    End Select
        Set RstSubject = Form1.cnnTemporal.OpenRecordset _
        ("select distinct(" & FieldSub & ") from subject", _
        dbOpenSnapshot) ', dbRunAsync)
    
    RowSub.Clear
    RstSubject.MoveFirst
    Do While Not RstSubject.EOF
                 RowSub.AddItem RstSubject.Fields _
                 (FieldSub).Value
                 RstSubject.MoveNext
    Loop
    RstSubject.Close
    
End Sub

Private Sub ColumnStudent_Click()
    AddStudent (ColumnStudent.Text)
End Sub


Private Sub ColumnSub_Click()
    AddSubject (ColumnSub.Text)
End Sub

Private Sub exitcmd_Click()

        QForm1.Hide
        Form1.Show
End Sub

Private Sub Form_Load()
     
    ColumnStudent.AddItem "รหัสนักศึกษา"
    ColumnStudent.AddItem "คำนำหน้าชื่อ(ภาษาไทย)"
    ColumnStudent.AddItem "คำนำหน้าชื่อ(ภาษาอังกฤษ)"
    ColumnStudent.AddItem "ชื่อ(ภาษาไทย)"
    ColumnStudent.AddItem "ชื่อ(ภาษาอังกฤษ)"
    ColumnStudent.AddItem "หลักสูตร"
    ColumnStudent.AddItem "ชนิดของนักศึกษา"

    ColumnSub.AddItem "รหัสวิชา"
    ColumnSub.AddItem "ชื่อวิชา(ภาษาไทย)"
    ColumnSub.AddItem "ชื่อวิชา(ภาษอังกฤษ)"
    ColumnSub.AddItem "หน่วยกิต"
    ColumnSub.AddItem "ชนิดของวิชา"
    
    ColumnStudent.ListIndex = 0
    ColumnSub.ListIndex = 0
    AddStudent (ColumnStudent.Text)
    AddSubject (ColumnSub.Text)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Form1.Show
End Sub

Private Sub querycmd_Click()
Dim SelectSql, Temp_Rowsub As String
    Temp_Rowsub = Form1.cut(RowSub.Text)
    If FieldSub <> "credit" Then Temp_Rowsub = " """ + Temp_Rowsub + """ "
SelectSql = "select t1.stdid, t1.tpren, t1.tname, t1.epren, t1.ename, t1.degree, t1.stdtype, t2.subid, t2.tname, t2.ename, t2.presub1, t2.presub2, t2.credit, t2.type, "
SelectSql = SelectSql + "t3.yr, t3.term, t3.grade, t3.section from student as t1, subject as t2, registeration as t3"
SelectSql = SelectSql & " where ( t1.stdid = t3.stdid ) and ( t2.subid = t3.subid ) and "
SelectSql = SelectSql + "( t1." + FieldStd + " = """ + Form1.cut(RowStudent.Text) + """ )"
SelectSql = SelectSql + " and ( t2." + FieldSub + " = " + Temp_Rowsub + " )"
Text1 = SelectSql
            With Output.Data1
            .RecordSource = SelectSql
            .Refresh
            End With
 
 Output.Show
End Sub


