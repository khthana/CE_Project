VERSION 5.00
Begin VB.Form QForm3 
   Caption         =   "ประวัติของวิชา ...."
   ClientHeight    =   2850
   ClientLeft      =   1680
   ClientTop       =   1560
   ClientWidth     =   4335
   LinkTopic       =   "Form2"
   ScaleHeight     =   2850
   ScaleWidth      =   4335
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton querycmd 
      Caption         =   "ค้นหา"
      Height          =   375
      Left            =   840
      TabIndex        =   6
      Top             =   2280
      Width           =   1095
   End
   Begin VB.CommandButton exitcmd 
      Caption         =   "ยกเลิก"
      Height          =   375
      Left            =   2520
      TabIndex        =   5
      Top             =   2280
      Width           =   1095
   End
   Begin VB.Frame k 
      Caption         =   "วิชา"
      Height          =   1980
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4335
      Begin VB.ComboBox RowSub 
         Height          =   315
         Left            =   2280
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   840
         Width           =   1815
      End
      Begin VB.ComboBox ColumnSub 
         Height          =   315
         ItemData        =   "QForm3.frx":0000
         Left            =   240
         List            =   "QForm3.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   840
         Width           =   1695
      End
      Begin VB.Label Label3 
         Caption         =   "เลือกคอลัมน์"
         Height          =   255
         Left            =   240
         TabIndex        =   4
         Top             =   480
         Width           =   1455
      End
      Begin VB.Label Label4 
         Caption         =   "เลือกแถว"
         Height          =   375
         Left            =   2280
         TabIndex        =   3
         Top             =   480
         Width           =   1695
      End
   End
End
Attribute VB_Name = "QForm3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private RstSubject_tt As Recordset
Dim FieldSub As String

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

Private Sub ColumnSub_Click()
    AddSubject (ColumnSub.Text)
End Sub

Private Sub exitcmd_Click()
        QForm3.Hide
        Form1.Show
End Sub

Private Sub Form_Load()
    ColumnSub.AddItem "รหัสวิชา"
    ColumnSub.AddItem "ชื่อวิชา(ภาษาไทย)"
    ColumnSub.AddItem "ชื่อวิชา(ภาษอังกฤษ)"
    ColumnSub.AddItem "หน่วยกิต"
    ColumnSub.AddItem "ชนิดของวิชา"
    
    ColumnSub.ListIndex = 0
    AddSubject (ColumnSub.Text)
End Sub

Private Sub Form_Unload(Cancel As Integer)
     Form1.Show
End Sub

Private Sub querycmd_Click()
Dim SelectSql, Temp_Rowsub As String
    Temp_Rowsub = Form1.cut(RowSub.Text)
    If FieldSub <> "credit" Then Temp_Rowsub = " """ + Temp_Rowsub + """ "

SelectSql = "select * from subject_tt where sub_int in (select distinct(sub_int) from subject_tt where "
SelectSql = SelectSql + FieldSub + " = " + Temp_Rowsub + " )"

            With Output.Data1
            .RecordSource = SelectSql
            .Refresh
            End With
 Output.Show
End Sub
