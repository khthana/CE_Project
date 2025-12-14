VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form frmPlantsGroup 
   Caption         =   "แบบฟอร์มข้อมูลแสดงรายละเอียดกลุ่มพืช"
   ClientHeight    =   2475
   ClientLeft      =   3180
   ClientTop       =   2700
   ClientWidth     =   5145
   LinkTopic       =   "Form2"
   ScaleHeight     =   2475
   ScaleWidth      =   5145
   Begin VB.CommandButton cmdDel 
      Caption         =   "ลบข้อมูล"
      Height          =   495
      Left            =   2640
      TabIndex        =   8
      Top             =   1680
      Width           =   1095
   End
   Begin VB.CommandButton cmdQuit 
      Caption         =   "เลิกบันทึก"
      Height          =   495
      Left            =   3840
      TabIndex        =   7
      Top             =   1680
      Width           =   1095
   End
   Begin VB.CommandButton cmdAdd 
      Caption         =   "เพิ่มข้อมูล"
      Height          =   495
      Left            =   1440
      TabIndex        =   6
      Top             =   1680
      Width           =   1095
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "บันทึกข้อมูล"
      Height          =   495
      Left            =   240
      TabIndex        =   5
      Top             =   1680
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      DataField       =   "GroupName"
      DataSource      =   "rdc"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   1
      Left            =   1200
      TabIndex        =   1
      Top             =   1200
      Width           =   2535
   End
   Begin VB.TextBox Text1 
      DataField       =   "GroupID"
      DataSource      =   "rdc"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   0
      Left            =   1200
      TabIndex        =   0
      Top             =   720
      Width           =   1095
   End
   Begin MSRDC.MSRDC rdc 
      Height          =   330
      Left            =   2400
      Top             =   120
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   582
      _Version        =   327680
      Options         =   0
      CursorDriver    =   0
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   1
      LockType        =   4
      QueryType       =   0
      Prompt          =   3
      Appearance      =   1
      QueryTimeout    =   30
      RowsetSize      =   100
      LoginTimeout    =   15
      KeysetSize      =   0
      MaxRows         =   0
      ErrorThreshold  =   -1
      BatchSize       =   15
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Enabled         =   -1  'True
      ReadOnly        =   0   'False
      Appearance      =   -1  'True
      DataSourceName  =   "DBProject"
      RecordSource    =   "Select * From PlantsGroup;"
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "ข้อมูลกลุ่มพืช"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "ชื่อกลุ่ม :"
      Height          =   210
      Index           =   1
      Left            =   360
      TabIndex        =   4
      Top             =   1200
      Width           =   585
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "รหัสกลุ่ม :"
      Height          =   210
      Index           =   0
      Left            =   360
      TabIndex        =   3
      Top             =   720
      Width           =   675
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "กรุณากรอกข้อความให้สมบูรณ์ :"
      Height          =   210
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   2160
   End
End
Attribute VB_Name = "frmPlantsGroup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub SaveRecord()
    Select Case rdc.Resultset.EditMode
        Case rdEditNone
            'clean record,do nothing
        Case rdEditInProgress
            ' the control handles regular edits
            rdc.UpdateRow
        Case rdEditAdd
            ' use the update method of the resultset
            rdc.Resultset.Update
    End Select
End Sub
Private Sub DeleteRecord()
    ' delete the row
    rdc.Resultset.Delete
    ' back up one row
    rdc.Resultset.MovePrevious
    ' check for beginning of set
    If rdc.Resultset.BOF Then
        rdc.Resultset.MoveFirst
    End If
End Sub
Private Sub AddRecord()
    ' add it
    rdc.Resultset.AddNew
    Text1(0).SetFocus
End Sub
Private Sub cmdAdd_Click()
On Error GoTo ProcError
    AddRecord
    Text1(0).SetFocus
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
Resume ProcExit
End Sub
Private Sub cmdDel_Click()
On Error GoTo ProcError
    DeleteRecord
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
Resume ProcExit
End Sub
Private Sub cmdQuit_Click()
    Unload Me
End Sub
Private Sub cmdSave_Click()
On Error GoTo ProcError
    SaveRecord
    cmdAdd.SetFocus
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
Private Sub Form_Initialize()
    rdc.Resultset.AddNew
End Sub
Private Sub Text1_KeyPress(Index As Integer, KeyAscii As Integer)
    If Index = 0 And KeyAscii = 13 Then Text1(1).SetFocus
    If Index = 1 And KeyAscii = 13 Then cmdSave.SetFocus
End Sub
