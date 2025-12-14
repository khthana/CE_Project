VERSION 5.00
Begin VB.Form QForm5 
   Caption         =   "Form2"
   ClientHeight    =   2820
   ClientLeft      =   4320
   ClientTop       =   3405
   ClientWidth     =   4320
   LinkTopic       =   "Form2"
   ScaleHeight     =   2820
   ScaleWidth      =   4320
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "นักศึกษา"
      Height          =   2055
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   4335
      Begin VB.ComboBox ColumnStudent 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1080
         Width           =   1815
      End
      Begin VB.ComboBox RowStudent 
         Height          =   315
         Left            =   2520
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1080
         Width           =   1695
      End
      Begin VB.Label Label2 
         Caption         =   "เลือกแถว"
         Height          =   375
         Left            =   2520
         TabIndex        =   6
         Top             =   720
         Width           =   1695
      End
      Begin VB.Label Label1 
         Caption         =   "เลือกคอลัมน์"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   720
         Width           =   1455
      End
   End
   Begin VB.CommandButton querycmd 
      Caption         =   "ค้นหา"
      Height          =   375
      Left            =   720
      TabIndex        =   1
      Top             =   2295
      Width           =   1095
   End
   Begin VB.CommandButton exitcmd 
      Caption         =   "ยกเลิก"
      Height          =   375
      Left            =   2400
      TabIndex        =   0
      Top             =   2295
      Width           =   1095
   End
End
Attribute VB_Name = "QForm5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private RstStudent As Recordset
Dim FieldStd As String

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


Private Sub ColumnStudent_Click()
        AddStudent (ColumnStudent.Text)
End Sub

Private Sub exitcmd_Click()
        QForm2.Hide
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
    
    ColumnStudent.ListIndex = 0
    AddStudent (ColumnStudent.Text)
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Form1.Show
End Sub

Private Sub querycmd_Click()
Dim SelectSql As String
SelectSql = "select * from student where "
SelectSql = SelectSql + FieldStd + " = """ + Form1.cut(RowStudent.Text) + """ "

            With Output.Data1
            .RecordSource = SelectSql
            .Refresh
            End With
 Output.Show
End Sub


