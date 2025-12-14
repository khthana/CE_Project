VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Form5 
   Caption         =   "Form5"
   ClientHeight    =   4725
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   11880
   BeginProperty Font 
      Name            =   "AngsanaUPC"
      Size            =   14.25
      Charset         =   222
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form5"
   ScaleHeight     =   4725
   ScaleWidth      =   11880
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.TextBox Text7 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6120
      TabIndex        =   4
      Top             =   840
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "ออกจากตารางแสดงรายงาน"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   10200
      TabIndex        =   1
      Top             =   240
      Width           =   1335
   End
   Begin VB.Data Datareport 
      Connect         =   "Access"
      DatabaseName    =   "D:\Project_duck\Project\order1.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   120
      Options         =   0
      ReadOnly        =   -1  'True
      RecordsetType   =   2  'Snapshot
      RecordSource    =   ""
      Top             =   8040
      Visible         =   0   'False
      Width           =   1140
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "Form5_1.frx":0000
      Height          =   4815
      Left            =   480
      OleObjectBlob   =   "Form5_1.frx":0019
      TabIndex        =   0
      Top             =   3120
      Width           =   10815
   End
   Begin VB.Frame Frame2 
      Caption         =   "แสดงรายงานสถิติ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2415
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   9855
      Begin VB.CommandButton Command5 
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
         Height          =   615
         Left            =   120
         TabIndex        =   17
         Top             =   1080
         Width           =   1455
      End
      Begin VB.CommandButton Command1 
         Caption         =   "พิมพ์รายงาน"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   240
         TabIndex        =   14
         Top             =   4920
         Width           =   1215
      End
      Begin VB.TextBox Text9 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   8040
         TabIndex        =   9
         Top             =   1320
         Width           =   1335
      End
      Begin VB.TextBox Text8 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   5760
         TabIndex        =   8
         Top             =   1320
         Width           =   1215
      End
      Begin VB.OptionButton Option3 
         Caption         =   " สรุปทุก ID# ที่ให้บริการเป็นช่วง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   1680
         TabIndex        =   7
         Top             =   1320
         Width           =   3255
      End
      Begin VB.OptionButton Option2 
         Caption         =   "สรุปทุก ID# ที่ให้บริการใน 1 วัน "
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1680
         TabIndex        =   5
         Top             =   600
         Width           =   3495
      End
      Begin VB.CommandButton Command4 
         Caption         =   "แสดง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   360
         TabIndex        =   3
         Top             =   240
         Width           =   1095
      End
      Begin VB.Label Label1 
         Caption         =   "วันสิ้นสุด"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   7200
         TabIndex        =   16
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label Label10 
         Caption         =   "(ไม่ต้องใส่ ID#)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2160
         TabIndex        =   15
         Top             =   960
         Width           =   1455
      End
      Begin VB.Label Label14 
         Caption         =   "วัน/เดือน/ปี"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   8160
         TabIndex        =   13
         Top             =   1080
         Width           =   1215
      End
      Begin VB.Label Label13 
         Caption         =   "วัน/เดือน/ปี"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   5880
         TabIndex        =   12
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label Label12 
         Caption         =   "วันสิ้นสุด"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   7680
         TabIndex        =   11
         Top             =   3720
         Width           =   855
      End
      Begin VB.Label Label11 
         Caption         =   "วันเริ่มต้น"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   4920
         TabIndex        =   10
         Top             =   1440
         Width           =   975
      End
      Begin VB.Label Label9 
         Caption         =   "วัน/เดือน/ปี"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   6120
         TabIndex        =   6
         Top             =   240
         Width           =   975
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
Dim flag As Boolean
Private Sub Command2_Click()
ORDERDB.Close
Unload Me
Form1.Show
End Sub
Private Sub Command4_Click()
Dim SQLCOMMAND As String
Dim start As String
Dim TEMPID As Variant
Dim TEMPID1 As Variant
Dim final As Variant
Dim TEMPDATE As Variant
Dim RESULTSNAP As Recordset
Command1.Visible = True
If Option2.Value Then
 TEMPDATE = (Text7.Text)
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
   Else
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
    Set Datareport.Recordset = RESULTSNAP
  End If
  RESULTSNAP.Close
End If
 If Option3.Value Then
    start = (Text8.Text)
    final = (Text9.Text)
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
   Else
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
   Set Datareport.Recordset = RESULTSNAP
 End If
  
  RESULTSNAP.Close
 End If
 Exit Sub
error1: MsgBox (Error)
End Sub

Private Sub Command5_Click()
DataReport1.Show
End Sub

Private Sub Form_Load()
 Set ORDERWS = DBEngine.Workspaces(0)
 Set ORDERDB = ORDERWS.OpenDatabase("C:\PROJECT\ORDER1.MDB", False, False)
Text7.Visible = False
Label9.Visible = False
Label11.Visible = False
Label1.Visible = False
Label12.Visible = False
Label13.Visible = False
Label14.Visible = False
Text8.Visible = False
Text9.Visible = False
Command1.Visible = False
End Sub


Private Sub Option2_Click()
Option2.Value = True
Option3.Value = False
Text7.Visible = True
Label1.Visible = False
Label9.Visible = True
Label11.Visible = False
Label12.Visible = False
Label13.Visible = False
Label14.Visible = False
Text8.Visible = False
Text9.Visible = False
Command1.Visible = False
Text7.SetFocus
End Sub



Private Sub Option3_Click()

Option2.Value = False
Option3.Value = True
Label1.Visible = True
Text7.Visible = False
Label11.Visible = True
Label9.Visible = False
Label12.Visible = True
Label13.Visible = True
Label14.Visible = True
Text8.Visible = True
Text9.Visible = True
Command1.Visible = False
Text8.SetFocus
End Sub

