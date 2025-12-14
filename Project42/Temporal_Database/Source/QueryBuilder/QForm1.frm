VERSION 5.00
Begin VB.Form QForm1 
   Caption         =   "ประวัติการลงทะเบียนของ ... ในวิชา ..."
   ClientHeight    =   4395
   ClientLeft      =   1650
   ClientTop       =   1560
   ClientWidth     =   5685
   LinkTopic       =   "Form2"
   ScaleHeight     =   4395
   ScaleWidth      =   5685
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton querycmd 
      Caption         =   "&ค้นหา"
      Height          =   375
      Left            =   840
      TabIndex        =   5
      Top             =   3960
      Width           =   1215
   End
   Begin VB.CommandButton exitcmd 
      Caption         =   "&ยกเลิก"
      Height          =   375
      Left            =   3240
      TabIndex        =   4
      Top             =   3960
      Width           =   1215
   End
   Begin VB.Frame k 
      Caption         =   "วิชา"
      Height          =   1860
      Left            =   0
      TabIndex        =   2
      Top             =   1920
      Width           =   5655
      Begin VB.ComboBox ColumnSub 
         Height          =   315
         ItemData        =   "QForm1.frx":0000
         Left            =   840
         List            =   "QForm1.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   840
         Width           =   2055
      End
      Begin VB.ComboBox RowSub 
         Height          =   315
         Left            =   3240
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   840
         Width           =   2055
      End
      Begin VB.Label Label4 
         Caption         =   "เลือกแถว"
         Height          =   375
         Left            =   3240
         TabIndex        =   11
         Top             =   480
         Width           =   1695
      End
      Begin VB.Label Label3 
         Caption         =   "เลือกคอลัมน์"
         Height          =   255
         Left            =   840
         TabIndex        =   10
         Top             =   480
         Width           =   1455
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "ประวัติการลงทะเบียนของ"
      Height          =   1860
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5655
      Begin VB.ComboBox ColumnStudent 
         Height          =   315
         ItemData        =   "QForm1.frx":0004
         Left            =   840
         List            =   "QForm1.frx":0006
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   840
         Width           =   2055
      End
      Begin VB.ComboBox RowStudent 
         Height          =   315
         Left            =   3240
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   840
         Width           =   2055
      End
      Begin VB.Label Label2 
         Caption         =   "เลือกแถว"
         Height          =   375
         Left            =   3240
         TabIndex        =   9
         Top             =   480
         Width           =   1695
      End
      Begin VB.Label Label1 
         Caption         =   "เลือกคอลัมน์"
         Height          =   255
         Left            =   840
         TabIndex        =   8
         Top             =   480
         Width           =   1455
      End
   End
End
Attribute VB_Name = "QForm1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private RstStudent_tt As Recordset
Private RstSubject_tt As Recordset
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
        Set RstStudent_tt = Form1.cnnTemporal.OpenRecordset _
        ("select distinct(" & FieldStd & ") from student_tt", _
        dbOpenSnapshot) ', dbRunAsync)
    
    RowStudent.Clear
    RstStudent_tt.MoveFirst
    Do While Not RstStudent_tt.EOF
                 RowStudent.AddItem RstStudent_tt.Fields _
                 (FieldStd).Value
                 RstStudent_tt.MoveNext
    Loop
    RstStudent_tt.Close
    
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
        Set RstSubject_tt = Form1.cnnTemporal.OpenRecordset _
        ("select distinct(" & FieldSub & ") from subject_tt", _
        dbOpenSnapshot) ', dbRunAsync)
    
    RowSub.Clear
    RstSubject_tt.MoveFirst
    Do While Not RstSubject_tt.EOF
                 RowSub.AddItem RstSubject_tt.Fields _
                 (FieldSub).Value
                 RstSubject_tt.MoveNext
    Loop
    RstSubject_tt.Close
    
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
SelectSql = SelectSql + "t3.yr, t3.term, t3.grade, t3.section, t3.valid_from, t3.valid_to from student_tt as t1, subject_tt as t2, registeration_tt as t3"
SelectSql = SelectSql & " where t3.std_int in (select distinct(std_int) From student_tt  where "
SelectSql = SelectSql + FieldStd + " = """ + Form1.cut(RowStudent.Text) + """ )"
'SelectSql = SelectSql & " tpren = ""นาย"" )"
SelectSql = SelectSql & " and t3.sub_int in (select    distinct(sub_int) From subject_tt where "
SelectSql = SelectSql + FieldSub + " = " + Temp_Rowsub + " )"
'SelectSql = SelectSql & " credit = 3 )"
SelectSql = SelectSql & " and (t1.std_int = t3.std_int) and (t2.sub_int = t3.sub_int) and (t3.valid_from >= t1.valid_from) and (t3.valid_from < t1.valid_to) and (t3.valid_from >= t2.valid_from) and (t3.valid_from < t2.valid_to)"

            With Output.Data1
            .RecordSource = SelectSql
            .Refresh
            End With
 
 Output.Show
End Sub

