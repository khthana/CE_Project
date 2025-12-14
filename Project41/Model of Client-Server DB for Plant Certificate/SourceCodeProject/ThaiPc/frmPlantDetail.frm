VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form frmPlantDetail 
   Caption         =   "แบบฟอร์มข้อมูลแสดงรายละเอียดเกี่ยวกับพืช"
   ClientHeight    =   3120
   ClientLeft      =   2595
   ClientTop       =   1950
   ClientWidth     =   6270
   LinkTopic       =   "Form1"
   ScaleHeight     =   3120
   ScaleWidth      =   6270
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
      Height          =   315
      Left            =   1680
      TabIndex        =   0
      Top             =   840
      Width           =   1695
   End
   Begin VB.CommandButton cmdAdd 
      Caption         =   "เพิ่มข้อมูล"
      Height          =   495
      Left            =   2400
      TabIndex        =   13
      Top             =   2400
      Width           =   1095
   End
   Begin MSRDC.MSRDC rdc 
      Height          =   330
      Left            =   2400
      Top             =   120
      Width           =   2415
      _ExtentX        =   4260
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
      RecordSource    =   "SELECT * FROM PlantsDetail  ORDER BY 2"
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "ข้อมูลพืช"
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
   Begin VB.Frame Frame1 
      Height          =   2535
      Left            =   120
      TabIndex        =   7
      Top             =   480
      Width           =   6015
      Begin VB.CommandButton cmdDel 
         Caption         =   "ลบข้อมูล"
         Height          =   495
         Left            =   3480
         TabIndex        =   15
         Top             =   1920
         Width           =   1095
      End
      Begin VB.CommandButton cmdClose 
         Caption         =   "เลิกบันทึก"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   4680
         TabIndex        =   12
         ToolTipText     =   "กดเมื่อเลิกการทำงาน"
         Top             =   1920
         Width           =   1095
      End
      Begin VB.CommandButton cmdSave 
         BackColor       =   &H00808080&
         Caption         =   "บันทึกข้อมูล"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   1080
         MaskColor       =   &H00808080&
         TabIndex        =   5
         ToolTipText     =   "กดเมื่อต้องการบันทึกข้อมูล"
         Top             =   1920
         Width           =   1095
      End
      Begin VB.TextBox txtFields 
         DataField       =   "PlantID"
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
         Height          =   315
         Index           =   0
         Left            =   3960
         TabIndex        =   1
         Top             =   360
         Width           =   1815
      End
      Begin VB.TextBox txtFields 
         DataField       =   "ThaiName"
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
         Height          =   315
         Index           =   1
         Left            =   1560
         TabIndex        =   2
         Top             =   720
         Width           =   4215
      End
      Begin VB.TextBox txtFields 
         DataField       =   "CommonName"
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
         Height          =   315
         Index           =   2
         Left            =   1560
         TabIndex        =   3
         Top             =   1080
         Width           =   4215
      End
      Begin VB.TextBox txtFields 
         DataField       =   "ScnName"
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
         Height          =   315
         Index           =   3
         Left            =   1560
         TabIndex        =   4
         Top             =   1440
         Width           =   4215
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "รหัสกลุ่ม :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   4
         Left            =   720
         TabIndex        =   14
         Top             =   360
         Width           =   690
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "ชื่อวิทยาศาสตร์  :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   0
         Left            =   240
         TabIndex        =   11
         Top             =   1440
         Width           =   1200
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "รหัส :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   1
         Left            =   3360
         TabIndex        =   10
         Top             =   360
         Width           =   420
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "ชื่อไทย :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   2
         Left            =   840
         TabIndex        =   9
         Top             =   720
         Width           =   570
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "ชื่อสามัญ :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   3
         Left            =   720
         TabIndex        =   8
         Top             =   1080
         Width           =   720
      End
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      Caption         =   "กรุณากรอกข้อความให้สมบูรณ์ :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   6
      Top             =   120
      Width           =   2160
   End
End
Attribute VB_Name = "frmPlantDetail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub cmdAdd_Click()
On Error GoTo ProcError
    AddRecord
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
Resume ProcExit
End Sub
Private Sub cmdClose_Click()
    Unload Me
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

Private Sub Text1_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtFields(0).SetFocus
End Sub

Private Sub txtFields_KeyPress(Index As Integer, KeyAscii As Integer)
    If Index = 0 And KeyAscii = 13 Then txtFields(1).SetFocus
    If Index = 1 And KeyAscii = 13 Then txtFields(2).SetFocus
    If Index = 2 And KeyAscii = 13 Then txtFields(3).SetFocus
    If Index = 3 And KeyAscii = 13 Then cmdSave.SetFocus
End Sub
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
Private Sub AddRecord()
    rdc.Resultset.AddNew
    Text1.SetFocus
    'txtFields(0).SetFocus
End Sub
Private Sub DeleteRecord()
    rdc.Resultset.Delete
    rdc.Resultset.MovePrevious
    If rdc.Resultset.BOF Then
        rdc.Resultset.MoveFirst
    End If
End Sub
