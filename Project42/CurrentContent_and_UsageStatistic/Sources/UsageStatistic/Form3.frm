VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Form3 
   Caption         =   "Form3"
   ClientHeight    =   6165
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7845
   LinkTopic       =   "Form3"
   ScaleHeight     =   6165
   ScaleWidth      =   7845
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.Frame Frame2 
      Caption         =   "ยกเลิกวารสาร"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   8520
      TabIndex        =   29
      Top             =   720
      Width           =   2655
      Begin VB.CommandButton Command14 
         Caption         =   "ยกเลิกวารสาร"
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
         TabIndex        =   30
         Top             =   360
         Width           =   1095
      End
   End
   Begin VB.ComboBox Combo1 
      Height          =   330
      Left            =   4680
      TabIndex        =   20
      Top             =   2880
      Width           =   6735
   End
   Begin VB.CommandButton Command13 
      Caption         =   "Brown..."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2040
      TabIndex        =   19
      Top             =   2520
      Width           =   1095
   End
   Begin VB.CommandButton Command12 
      Caption         =   "แทรก"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4800
      TabIndex        =   18
      Top             =   1080
      Width           =   1095
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "Form3.frx":0000
      Height          =   4815
      Left            =   -120
      OleObjectBlob   =   "Form3.frx":0018
      TabIndex        =   17
      Top             =   3360
      Width           =   11775
   End
   Begin VB.Data DataDAILY 
      Connect         =   "Access"
      DatabaseName    =   "D:\Project_duck\Project\order1.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   600
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   0  'Table
      RecordSource    =   ""
      Top             =   3600
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text3 
      Height          =   495
      Left            =   960
      TabIndex        =   16
      Top             =   2520
      Width           =   735
   End
   Begin VB.TextBox Text2 
      Height          =   495
      Left            =   3840
      TabIndex        =   15
      Top             =   1920
      Width           =   735
   End
   Begin VB.TextBox Text1 
      Height          =   495
      Left            =   3840
      TabIndex        =   14
      Top             =   1200
      Width           =   735
   End
   Begin VB.CommandButton Command11 
      Caption         =   "ออกจากวารสารประจำวัน"
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
      Left            =   9120
      TabIndex        =   10
      Top             =   0
      Width           =   2415
   End
   Begin VB.CommandButton Command10 
      Caption         =   ">>"
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
      Left            =   8040
      TabIndex        =   9
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton Command9 
      Caption         =   ">"
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
      Left            =   7200
      TabIndex        =   8
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton Command8 
      Caption         =   "<"
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
      Left            =   6360
      TabIndex        =   7
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton Command7 
      Caption         =   "<<"
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
      Left            =   5520
      TabIndex        =   6
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton Command6 
      Caption         =   "ยกเลิก"
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
      Left            =   4440
      TabIndex        =   5
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton Command5 
      Caption         =   "บันทึก"
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
      Left            =   3600
      TabIndex        =   4
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton Command4 
      Caption         =   "ค้นหา"
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
      Left            =   2520
      TabIndex        =   3
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton Command3 
      Caption         =   "ลบ"
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
      Left            =   1680
      TabIndex        =   2
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton Command2 
      Caption         =   "แก้ไข"
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
      Left            =   840
      TabIndex        =   1
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      Caption         =   "เพิ่ม"
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
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   855
   End
   Begin VB.Frame Frame1 
      Caption         =   "แทรกวารสาร"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   4680
      TabIndex        =   21
      Top             =   720
      Width           =   3735
      Begin VB.TextBox Text6 
         Height          =   375
         Left            =   2880
         TabIndex        =   24
         Top             =   840
         Width           =   735
      End
      Begin VB.TextBox Text5 
         Height          =   375
         Left            =   2880
         TabIndex        =   23
         Top             =   240
         Width           =   735
      End
      Begin VB.TextBox Text4 
         Height          =   375
         Left            =   2880
         TabIndex        =   22
         Top             =   1560
         Width           =   735
      End
      Begin VB.Label Label6 
         Caption         =   "หมายเลขประจำวารสารใหม่"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   480
         TabIndex        =   27
         Top             =   960
         Width           =   2295
      End
      Begin VB.Label Label5 
         Caption         =   "หมายเลขตู้ใหม่"
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
         Left            =   1440
         TabIndex        =   26
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label Label4 
         Caption         =   "ID# ของวารสารใหม่ที่ต้องการแทรก"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   240
         TabIndex        =   25
         Top             =   1440
         Width           =   2775
      End
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      Caption         =   "เลือก ID# จากช่องนี้"
      BeginProperty Font 
         Name            =   "Angsana New"
         Size            =   14.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   3240
      TabIndex        =   28
      Top             =   2520
      Width           =   1455
   End
   Begin VB.Label Label3 
      Caption         =   "ID#"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   13
      Top             =   2520
      Width           =   855
   End
   Begin VB.Label Label2 
      Caption         =   "หมายเลขประจำตำแหน่งวารสาร"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   0
      TabIndex        =   12
      Top             =   2040
      Width           =   3975
   End
   Begin VB.Label Label1 
      Caption         =   "หมายเลขตู้"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   0
      TabIndex        =   11
      Top             =   1320
      Width           =   1575
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public ORDERWS As Workspace
Public ORDERDB As Database
Public DAILYSNAP As Recordset
Public LastSNAP As Recordset
Public DAILYDYN1 As Recordset
Public strnode As String
Public strbook As String
Public SQLCOMMAND As String
Public sqlcommand1 As String
Dim TEMPIDCHANGE0  As String
Dim TEMPIDCHANGE1 As String
Dim TEMPIDCHANGE2 As String
Dim flagedit As Boolean

Dim flag As Boolean
Private Sub Command1_Click()
Call enableoperationbutton(False)
Call ENABLESAVECANCELBOTTON(True)
Call cleardata
Text1.Enabled = True
Text2.Enabled = True
Text1.SetFocus
DAILYDYN1.AddNew
Combo1.Visible = True

End Sub

Private Sub Command13_Click()
Dim temp As String
Dim TEMP_ID As String
If Combo1.Text <> "" Then
temp = Mid(Combo1.Text, 5, 10)
i% = 1
Do While Not Mid(temp, i%, 1) = ","
    TEMP_ID = TEMP_ID & Mid(temp, i%, 1)
    i% = i% + 1
Loop
Text3.Text = TEMP_ID
End If
End Sub

Private Sub Command14_Click()

If DAILYDYN1.RecordCount > 0 Then
Call Command4_Click
If MsgBox("คุณต้องการที่จะยกเลิกวารสารตำแหน่นงนี้ใช่ไหม?", [vbYesNo]) = vbYes Then
   Call enableoperationbutton(True)
   Call ENABLESAVECANCELBOTTON(False)
   TEMPIDCHANGE0 = DAILYDYN1.Fields("ID#").Value
   DAILYDYN1.MoveNext
   Call cleardata
   TEMPIDCHANGE1 = DAILYDYN1.Fields("ID#").Value
   DAILYDYN1.MovePrevious
   DAILYDYN1.Edit
   DAILYDYN1.Fields("ID#") = TEMPIDCHANGE1
   DAILYDYN1.Update
   DAILYDYN1.MoveNext
   Do
   DAILYDYN1.MoveNext
   If DAILYDYN1.EOF Then Exit Do
   TEMPIDCHANGE1 = DAILYDYN1.Fields("ID#").Value
   DAILYDYN1.MovePrevious
   DAILYDYN1.Edit
   DAILYDYN1.Fields("ID#") = TEMPIDCHANGE1
   DAILYDYN1.Update
   DAILYDYN1.MoveNext
   Loop While Not DAILYDYN1.EOF
   DAILYDYN1.MovePrevious
   DAILYDYN1.Delete
   
   'TEMPNODE = Text5.Text
   'TEMPBOOK = Text6.Text
   'DAILYDYN1.AddNew
   'DAILYDYN1.Fields("NODE#").Value = TEMPNODE
   'DAILYDYN1.Fields("BOOK#").Value = TEMPBOOK
   'DAILYDYN1.Fields("ID#").Value = TEMPIDCHANGE0
   'DAILYDYN1.Update
   'DAILYDYN1.MoveFirst
End If
End If
End Sub

Private Sub Form_Load()
Dim brownsnap As Recordset
Dim sqlbrown As String
'Text7.Enabled = False
'Text8.Enabled = False
Set ORDERWS = DBEngine.Workspaces(0)
Set ORDERDB = ORDERWS.OpenDatabase("C:\PROJECT\ORDER1.MDB", False, False)
Call DISPLAY_TABLE
Call DISPLAYFIELDS
flag = False
Command7.Enabled = False
Command8.Enabled = False
Call ENABLESAVECANCELBOTTON(False)
sqlbrown = "SELECT detail2.[ID#],DETAIL2.[Tiltle],DETAIL2.[VOLUME],DETAIL2.[number] FROM [DETAIL2]order by detail2.[Tiltle] "
Set brownsnap = ORDERDB.OpenRecordset(sqlbrown, dbOpenSnapshot)
brownsnap.MoveFirst
Combo1.Clear
Do While Not brownsnap.EOF
Combo1.AddItem ("ID#:" & brownsnap.Fields("ID#") & " , Tiltle:" & brownsnap.Fields("Tiltle") & " , VOLUME:" & brownsnap.Fields("VOLUME") & " ,Number:" & brownsnap.Fields("Number"))
brownsnap.MoveNext
Loop
brownsnap.Close
End Sub
Private Sub ENABLESAVECANCELBOTTON(enableflag As Boolean)
Command5.Enabled = enableflag
Command6.Enabled = enableflag
Combo1.Visible = False
End Sub
Private Sub enableoperationbutton(enableflag As Boolean)
    Command1.Enabled = enableflag
    Command2.Enabled = enableflag
    Command3.Enabled = enableflag
    Command4.Enabled = enableflag
    Combo1.Visible = False
End Sub
Private Sub cleardata()
Text1.Text = ""
Text2.Text = ""
Text3.Text = ""
End Sub
Private Sub DISPLAYFIELDS()
If DAILYDYN1.RecordCount > 0 Then
Text1.Text = DAILYDYN1.Fields("NODE#")
Text2.Text = DAILYDYN1.Fields("BOOK#")
Text3.Text = DAILYDYN1.Fields("ID#")
End If
End Sub

Private Sub Command10_Click()
If DAILYDYN1.RecordCount > 0 Then
DAILYDYN1.MoveLast
Call DISPLAYFIELDS
Command7.Enabled = True
Command8.Enabled = True
Command9.Enabled = False
Command10.Enabled = False
End If
End Sub

Private Sub Command11_Click()
If flag = True Then
DAILYSNAP.Close
End If
DAILYDYN1.Close
ORDERDB.Close
Unload Me
Form1.Show
End Sub

Private Sub Command12_Click()
Dim TEMPIDCHANGE0 As String
Dim temp As String
Dim TEMP_ID As String
If DAILYDYN1.RecordCount > 0 Then
    
If Text4.Text = "" Or Text5.Text = "" Or Text6.Text = "" Then
MsgBox "กรุณาใส่ข้อมูลทั้งหมดในเฟรมนี้ "
Else
 strnode = Text5.Text
 strbook = Text6.Text
SQLCOMMAND = "SELECT * FROM [DAILY1] Where [NODE#] ='" & strnode & "'"
SQLCOMMAND = SQLCOMMAND & "AND [BOOK#] ='" & strbook & "'"
Call OPENQUERY
If DAILYSNAP.RecordCount <> 0 Then
   MsgBox "หมายเลขตู้(Node#) และ หมายเลขวารสาร (Book#) ซั้า"
Else
TEMP_ID = Text4.Text
SQLCOMMAND = "SELECT * FROM [DAILY1] Where [ID#] ='" & TEMP_ID & "'"
Call OPENQUERY
If DAILYSNAP.RecordCount <> 0 Then
   MsgBox "ID# ซำ้"
Else
Call Command4_Click
If MsgBox("ในการแทรกคุณแน่ใจแล้วหรือยัง?", [vbYesNo]) = vbYes Then
   
  Call enableoperationbutton(True)
  Call ENABLESAVECANCELBOTTON(False)
   TEMPIDCHANGE0 = DAILYDYN1.Fields("ID#").Value
   Call cleardata
   temp = Text4.Text
   Text3.Text = temp
   DAILYDYN1.Edit
   DAILYDYN1.Fields("ID#") = Text3.Text
   DAILYDYN1.Update
   Do
   DAILYDYN1.MoveNext
   If DAILYDYN1.EOF Then Exit Do
   TEMPIDCHANGE1 = DAILYDYN1.Fields("ID#").Value
   DAILYDYN1.Edit
   DAILYDYN1.Fields("ID#") = TEMPIDCHANGE0
   DAILYDYN1.Update
   TEMPIDCHANGE0 = TEMPIDCHANGE1
   Loop While Not DAILYDYN1.EOF
   TEMPNODE = Text5.Text
   TEMPBOOK = Text6.Text
   DAILYDYN1.AddNew
   DAILYDYN1.Fields("NODE#").Value = TEMPNODE
   DAILYDYN1.Fields("BOOK#").Value = TEMPBOOK
   DAILYDYN1.Fields("ID#").Value = TEMPIDCHANGE0
   DAILYDYN1.Update
   DAILYDYN1.MoveFirst
End If
End If
End If
End If
End If
End Sub

Private Sub Command2_Click()
If DAILYDYN1.RecordCount > 0 Then
If Not DAILYDYN1.EOF And Not DAILYDYN1.BOF Then
Text1.Enabled = False
Text2.Enabled = False
Call enableoperationbutton(False)
flagedit = True
Call ENABLESAVECANCELBOTTON(True)
Text3.Text = ""
Text3.SetFocus
Combo1.Visible = True
DAILYDYN1.Edit
End If
End If
End Sub

Private Sub Command3_Click()
If DAILYDYN1.RecordCount > 0 Then
If Not DAILYDYN1.EOF And Not DAILYDYN1.BOF Then
If MsgBox("ลบข้อมูลนี้ , คุณแน่ใจแล้วหรือยัง?", [vbYesNo]) = vbYes Then
    DAILYDYN1.Delete
    Call Command7_Click
 End If
 End If
 End If
End Sub

Private Sub Command4_Click()
Dim TEMPID As String
Dim STRSEARCHCRITERIA  As String
If DAILYDYN1.RecordCount > 0 Then
 strnode = InputBox("กรุณาใส่หมายเลขตู้ที่ต้องการค้นหา(Node#)")
 strbook = InputBox(" กรุณาใส่หมายเลขวารสารที่ต้องการค้นหา(Book#)")
If strnode = "" Or strbook = "" Then
MsgBox "กรุณาใส่หมายเลขตู้(Node#) และหมายเลขวารสาร (Book#)"
Else
SQLCOMMAND = "SELECT * FROM [DAILY1] Where [NODE#] ='" & strnode & "'"
SQLCOMMAND = SQLCOMMAND & "AND [BOOK#] ='" & strbook & "'"
Call OPENQUERY
On Error GoTo error1
Text1.Text = DAILYSNAP.Fields("NODE#")
Text2.Text = DAILYSNAP.Fields("BOOK#")
Text3.Text = DAILYSNAP.Fields("ID#")
TEMPID = Text3.Text
If TEMPID <> "" Then
 DAILYDYN1.MoveFirst
 STRSEARCHCRITERIA = "[ID#]= '" & TEMPID & "'"
 DAILYDYN1.FindFirst (STRSEARCHCRITERIA)
 End If
End If
 End If
 GoTo end1
error1:
 MsgBox "ไม่พบข้อมูลที่ต้องการค้นหา"
end1:
End Sub
Private Sub OPENQUERY()
Set DAILYSNAP = ORDERDB.OpenRecordset(SQLCOMMAND, dbOpenSnapshot)
flag = True
End Sub
Private Sub Command5_Click()
 Dim TEMP_ID As String
 Dim STRSEARCHCRITERIA  As String
If Text1.Text = "" Then
    MsgBox "Insert NODE# "
ElseIf Text2.Text = "" Then
    MsgBox "Insert BOOK#"
ElseIf Text3.Text = "" Then
    MsgBox "Insert ID#"
Else
    If Not flagedit Then
        
    strnode = Text1.Text
    strbook = Text2.Text
   
        If strnode = "" Or strbook = "" Then
        MsgBox "กรุณาใส่หมายเลขตู้(Node#) และ หมายเลขวารสาร(Book#)"
        Else
        SQLCOMMAND = "SELECT * FROM [DAILY1] Where [NODE#] ='" & strnode & "'"
        SQLCOMMAND = SQLCOMMAND & "AND [BOOK#] ='" & strbook & "'"
        Call OPENQUERY
            If DAILYSNAP.RecordCount = 0 Then
               TEMP_ID = Text3.Text
               SQLCOMMAND = "SELECT * FROM [DAILY1] Where [ID#] ='" & TEMP_ID & "'"
               Call OPENQUERY
                    If DAILYSNAP.RecordCount = 0 Then
                    DAILYDYN1("NODE#") = Text1.Text
                    DAILYDYN1("BOOK#") = Text2.Text
                    DAILYDYN1("ID#") = Text3.Text
                    DAILYDYN1.Update
                    DAILYDYN1.Requery
                    Call ENABLESAVECANCELBOTTON(False)
                    Call enableoperationbutton(True)
                    Call DISPLAY_TABLE
                   Else
                    MsgBox "ID# Same   "
                    Call enableoperationbutton(True) '
                    End If
            Else
            MsgBox "หมายเลขตู้(Node#) และ หมายเลวารสาร(Book#) ซำ้"
            Call enableoperationbutton(True)
            Call cleardata
            End If
       End If
   Else  'edit
    TEMP_ID = Text3.Text
        If TEMP_ID = "" Then
        MsgBox "กรุณาใส่หมายเลขตู้(NODE#) และ หมายเลขวารสาร(BOOK#)"
        Else
        SQLCOMMAND = "SELECT * FROM [DAILY1] Where [ID#] ='" & TEMP_ID & "'"
        Call OPENQUERY
          If DAILYSNAP.RecordCount = 0 Then
          DAILYDYN1("NODE#") = Text1.Text
          DAILYDYN1("BOOK#") = Text2.Text
          DAILYDYN1("ID#") = Text3.Text
          DAILYDYN1.Update
          DAILYDYN1.Requery
          Call ENABLESAVECANCELBOTTON(False)
          Call enableoperationbutton(True)
          Call DISPLAY_TABLE
          Else
          MsgBox "ID# Same "
          Call enableoperationbutton(True)
          End If
        End If
   End If
End If
    flagedit = False
    Text1.Enabled = True
    Text2.Enabled = True
    DAILYDYN1.MoveFirst
    Call DISPLAYFIELDS
    Combo1.Visible = False
End Sub

Private Sub DISPLAY_TABLE()
'Dim MAXNODE As Integer
'Dim MAXBOOK As Integer
 sqlcommand1 = "SELECT DAILY1.[NODE#] ,DAILY1.[BOOK#],Daily1.[ID#],"
 sqlcommand1 = sqlcommand1 & "DETAIL2.[Tiltle],DETAIL2.[VOLUME],DETAIL2.[Number]"
 'sqlcommand1 = sqlcommand1 & "DETAIL2.[PUBLISHER]"
 sqlcommand1 = sqlcommand1 & "FROM DAILY1 LEFT JOIN DETAIL2 ON DAILY1.[ID#] = DETAIL2.[ID#]"
 sqlcommand1 = sqlcommand1 & "ORDER BY DAILY1.[NODE#],DAILY1.[BOOK#]"
Set DAILYDYN1 = ORDERDB.OpenRecordset(sqlcommand1, dbOpenDynaset)
Set DataDAILY.Recordset = DAILYDYN1
'Set LastSNAP = ORDERDB.OpenRecordset("select max(int(DAILY1.[NODE#])) as maxNODE,max(int(DAILY1.[BOOK#])) as maxBOOK  from DAILY1 ", dbOpenSnapshot)
'On Error GoTo error2
'If LastSNAP.RecordCount <> 0 Then

'Text7.Text = "0" & LastSNAP.Fields("maxNODE")
'Text8.Text = LastSNAP.Fields("maxBOOK")
'End If
'error2:
'LastSNAP.Close

End Sub
Private Sub Command6_Click()
Call cleardata
Call ENABLESAVECANCELBOTTON(False)
Call enableoperationbutton(True)
End Sub

Private Sub Command7_Click()
If DAILYDYN1.RecordCount > 0 Then
DAILYDYN1.MoveFirst
Call DISPLAYFIELDS
Command9.Enabled = True
Command10.Enabled = True
Command7.Enabled = False
Command8.Enabled = False
End If
End Sub

Private Sub Command8_Click()
If DAILYDYN1.RecordCount > 0 Then
DAILYDYN1.MovePrevious
If DAILYDYN1.BOF = False Then
    Call DISPLAYFIELDS
    
    Command9.Enabled = True
    Command10.Enabled = True
 Else
    Command7.Enabled = False
    Command8.Enabled = False
    Command9.Enabled = True
    Command10.Enabled = True
End If
End If
End Sub

Private Sub Command9_Click()
If DAILYDYN1.RecordCount > 0 Then
DAILYDYN1.MoveNext
If DAILYDYN1.EOF = False Then
    Call DISPLAYFIELDS
    Command7.Enabled = True
    Command8.Enabled = True
Else
    Command9.Enabled = False
    Command10.Enabled = False
     Command7.Enabled = True
    Command8.Enabled = True
End If
End If
End Sub

