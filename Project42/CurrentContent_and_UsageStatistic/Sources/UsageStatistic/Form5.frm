VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Form5 
   Caption         =   "Form5"
   ClientHeight    =   3225
   ClientLeft      =   60
   ClientTop       =   315
   ClientWidth     =   4680
   LinkTopic       =   "Form5"
   ScaleHeight     =   3225
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "Form5.frx":0000
      Height          =   5535
      Left            =   240
      OleObjectBlob   =   "Form5.frx":0014
      TabIndex        =   14
      Top             =   2760
      Width           =   8775
   End
   Begin VB.CommandButton Command3 
      Caption         =   "ออกจากแสดงรายงานสถิติ"
      Height          =   855
      Left            =   9600
      TabIndex        =   13
      Top             =   360
      Width           =   1815
   End
   Begin VB.Frame Frame1 
      Height          =   2535
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   8775
      Begin VB.CommandButton Command4 
         Caption         =   "ยกเลิกการออกรายงาน"
         Height          =   735
         Left            =   2040
         TabIndex        =   15
         Top             =   1680
         Width           =   975
      End
      Begin VB.Data Data1 
         Caption         =   "Data1"
         Connect         =   "Access"
         DatabaseName    =   "C:\PROJECT\order1.mdb"
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   375
         Left            =   360
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   1  'Dynaset
         RecordSource    =   ""
         Top             =   240
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Left            =   6840
         TabIndex        =   9
         Top             =   1800
         Width           =   1695
      End
      Begin VB.TextBox Text2 
         Height          =   375
         Left            =   4200
         TabIndex        =   6
         Top             =   1800
         Width           =   1695
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Left            =   4800
         TabIndex        =   5
         Top             =   600
         Width           =   1695
      End
      Begin VB.OptionButton Option2 
         Caption         =   "สถิติในช่วงที่กำหนด"
         Height          =   495
         Left            =   2160
         TabIndex        =   4
         Top             =   1200
         Width           =   1935
      End
      Begin VB.OptionButton Option1 
         Caption         =   "สถิติในวันที่กำหนด"
         Height          =   375
         Left            =   2160
         TabIndex        =   3
         Top             =   720
         Width           =   2295
      End
      Begin VB.CommandButton Command2 
         Caption         =   "เตรียมพิมพ์"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   240
         TabIndex        =   2
         Top             =   1680
         Width           =   1455
      End
      Begin VB.CommandButton Command1 
         Caption         =   "แสดง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   360
         TabIndex        =   1
         Top             =   720
         Width           =   1215
      End
      Begin VB.Label Label5 
         Caption         =   "วันสิ้นสุด"
         Height          =   375
         Left            =   6000
         TabIndex        =   12
         Top             =   1800
         Width           =   855
      End
      Begin VB.Label Label4 
         Caption         =   "วันเริ่มต้น"
         Height          =   375
         Left            =   3360
         TabIndex        =   11
         Top             =   1800
         Width           =   735
      End
      Begin VB.Label Label3 
         Caption         =   "วัน/เดือน/ปี"
         Height          =   375
         Left            =   6840
         TabIndex        =   10
         Top             =   1440
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "วัน/เดือน/ปี"
         Height          =   255
         Left            =   4200
         TabIndex        =   8
         Top             =   1440
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "วัน/เดือน/ปี"
         Height          =   375
         Left            =   4800
         TabIndex        =   7
         Top             =   240
         Width           =   1575
      End
   End
End
Attribute VB_Name = "Form5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public REPORTdyn As Recordset
Public RESULTSNAP As Recordset
Public ORDERWS As Workspace
Public ORDERDB As Database
Public temp_label1 As String
Public temp_label2 As String
Public FLAG_LABEL As Boolean
Dim flag As Boolean

Private Sub Command1_Click()
Dim SQLCOMMAND As String
Dim start As String
Dim TEMPID As Variant
Dim TEMPID1 As Variant
Dim final As Variant
Dim TEMPDATE As Variant
Dim RESULTSNAP As Recordset
Command2.Visible = True
If Option1.Value Then
 FLAG_LABEL = False
 TEMPDATE = (Text1.Text)
 temp_label1 = TEMPDATE
 SQLCOMMAND = "SELECT  STATISTIC.[ID#] ,MIN(DETAIL2.[Tiltle]) AS Tiltle ,"
 SQLCOMMAND = SQLCOMMAND & " MIN(DETAIL2.[VOLUME])as Volumes  ,MIN(DETAIL2.[NUMBER]) as Numbers ,COUNT(STATISTIC.[TIME]) AS Count "
 SQLCOMMAND = SQLCOMMAND & " FROM [STATISTIC] LEFT JOIN DETAIL2 ON STATISTIC.[ID#] = DETAIL2.[ID#] "
 SQLCOMMAND = SQLCOMMAND & " WHERE [DATE] = #" & TEMPDATE & "#"
 SQLCOMMAND = SQLCOMMAND & " GROUP BY STATISTIC.[ID#]"
 SQLCOMMAND = SQLCOMMAND & " ORDER BY 2"
 Set RESULTSNAP = ORDERDB.OpenRecordset(SQLCOMMAND, dbOpenSnapshot)
 On Error GoTo error1
  If RESULTSNAP.RecordCount = 0 Then
   MsgBox " NO FOUND STATISTIC"
   DBGrid1.Visible = False
   Else
   DBGrid1.Visible = True
   RESULTSNAP.MoveFirst
    Set REPORTdyn = ORDERDB.OpenRecordset("select * from ReportTbl ", dbOpenDynaset)
    On Error GoTo error1
    If REPORTdyn.RecordCount <> 0 Then
    REPORTdyn.MoveFirst
    Do
    REPORTdyn.Delete
    REPORTdyn.MoveNext
    Loop Until REPORTdyn.EOF
    End If
    RESULTSNAP.MoveFirst
    Do
    REPORTdyn.AddNew
    REPORTdyn("ID#") = RESULTSNAP.Fields("ID#")
    REPORTdyn("Tiltle") = RESULTSNAP.Fields("Tiltle")
    'REPORTdyn("PUBLIC") = RESULTSNAP.Fields("Publics")
    REPORTdyn("VOLUME") = RESULTSNAP.Fields("Volumes")
    REPORTdyn("Number") = RESULTSNAP.Fields("Numbers")
    REPORTdyn("Count") = RESULTSNAP.Fields("Count")
   ' REPORTdyn("ISSN#") = RESULTSNAP.Fields("ISSN_NUM#")
    REPORTdyn.Update
    REPORTdyn.Requery
    RESULTSNAP.MoveNext
    Loop Until RESULTSNAP.EOF
    REPORTdyn.Close
    Set Data1.Recordset = RESULTSNAP
    DBGrid1.Visible = True
    
  End If
  RESULTSNAP.Close
End If
 If Option2.Value Then
 FLAG_LABEL = True

    start = (Text2.Text)
    final = (Text3.Text)
     temp_label1 = start
     temp_label2 = final
   SQLCOMMAND = "SELECT  STATISTIC.[ID#],MIN(DETAIL2.[Tiltle]) AS Tiltle,MIN(DETAIL2.[VOLUME]) AS VOLUMEs,MIN(DETAIL2.[NUMBER])AS NUMBERs ,COUNT(STATISTIC.[TIME])AS COUNT  "
   SQLCOMMAND = SQLCOMMAND & " FROM [STATISTIC]LEFT JOIN DETAIL2 ON STATISTIC.[ID#] = DETAIL2.[ID#] "
   SQLCOMMAND = SQLCOMMAND & "  WHERE [DATE] >= #" & start & "#"
   SQLCOMMAND = SQLCOMMAND & " AND [DATE] <=#" & final & "#"
   SQLCOMMAND = SQLCOMMAND & " GROUP BY STATISTIC.[ID#]"
   SQLCOMMAND = SQLCOMMAND & " ORDER BY 2"
   Set RESULTSNAP = ORDERDB.OpenRecordset(SQLCOMMAND, dbOpenSnapshot)
   On Error GoTo error1
 If RESULTSNAP.RecordCount = 0 Then
   MsgBox " NO FOUND STATISTIC"
   DBGrid1.Visible = False
   Else
   DBGrid1.Visible = True
    RESULTSNAP.MoveFirst
    Set REPORTdyn = ORDERDB.OpenRecordset("select * from ReportTbl ", dbOpenDynaset)
    On Error GoTo error1
    If REPORTdyn.RecordCount <> 0 Then
    REPORTdyn.MoveFirst
    Do
    REPORTdyn.Delete
    REPORTdyn.MoveNext
    Loop Until REPORTdyn.EOF
    End If
    RESULTSNAP.MoveFirst
    Do
    REPORTdyn.AddNew
    REPORTdyn("ID#") = RESULTSNAP.Fields("ID#")
    REPORTdyn("Tiltle") = RESULTSNAP.Fields("Tiltle")
    REPORTdyn("VOLUME") = RESULTSNAP.Fields("Volumes")
    REPORTdyn("Number") = RESULTSNAP.Fields("Numbers")
    REPORTdyn("Count") = RESULTSNAP.Fields("Count")
    REPORTdyn.Update
    REPORTdyn.Requery
    RESULTSNAP.MoveNext
    Loop Until RESULTSNAP.EOF
    REPORTdyn.Close
    Set Data1.Recordset = RESULTSNAP
    DBGrid1.Visible = True
  End If
  RESULTSNAP.Close
    'REPORTdyn.Update
    'REPORTdyn.Requery
    'RESULTSNAP.MoveNext
    'Loop Until RESULTSNAP.EOF
    'REPORTdyn.Close
   'Set Data1.Recordset = RESULTSNAP
   'DBGrid1.Visible = True
 'End If
  
  'RESULTSNAP.Close
 End If
 
 Exit Sub
error1: MsgBox (Error)
End Sub


Private Sub Command2_Click()
Command4.Visible = True
DataReport1.Show


End Sub
Private Sub Command3_Click()
ORDERDB.Close
Unload Me
Form1.Show
End Sub

Private Sub Command4_Click()
DataReport1.Hide
Unload DataReport1
End Sub

Private Sub Form_Load()
 Set ORDERWS = DBEngine.Workspaces(0)
 Set ORDERDB = ORDERWS.OpenDatabase("C:\PROJECT\ORDER1.MDB", False, False)
 Command4.Visible = False
Text1.Visible = False
Text2.Visible = False
Text3.Visible = False
Command2.Visible = False
Label1.Visible = False
Label2.Visible = False
Label3.Visible = False
Label4.Visible = False
Label5.Visible = False
DBGrid1.Visible = False
Data1.Visible = False
End Sub




Private Sub Option1_Click()
Option1.Value = True
Option2.Value = False
Text1.Visible = True
Label1.Visible = True
Label2.Visible = False
Label3.Visible = False
Label4.Visible = False
Label5.Visible = False
Text2.Visible = False
Text3.Visible = False
Text1.SetFocus

End Sub

Private Sub Option2_Click()
Option1.Value = False
Option2.Value = True
Text1.Visible = False
Label1.Visible = False
Label2.Visible = True
Label3.Visible = True
Label4.Visible = True
Label5.Visible = True
Text2.Visible = True
Text3.Visible = True
Text2.SetFocus
End Sub





