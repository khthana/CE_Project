VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form frmCountry 
   Caption         =   "แบบฟอร์มสำหรับกรอกรายละเอียดประเทศที่ส่งออกพืช"
   ClientHeight    =   3225
   ClientLeft      =   2610
   ClientTop       =   2340
   ClientWidth     =   5580
   LinkTopic       =   "Form1"
   ScaleHeight     =   3225
   ScaleWidth      =   5580
   Begin MSRDC.MSRDC rdc 
      Height          =   330
      Left            =   2400
      Top             =   120
      Width           =   2505
      _ExtentX        =   4419
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
      RecordSource    =   "SELECT CountryNo,CountryName,A2,A3                    FROM Country ORDER BY 1"
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "ข้อมูลประเทศ"
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
   Begin VB.CommandButton cmdAdd 
      Caption         =   "เพิ่มข้อมูล"
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
      Left            =   2040
      TabIndex        =   12
      ToolTipText     =   "กดเมื่อต้องการเพิ่มข้อมูล"
      Top             =   2400
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Height          =   2655
      Left            =   120
      TabIndex        =   6
      Top             =   480
      Width           =   5295
      Begin VB.CommandButton cmdDel 
         Caption         =   "ลบข้อมูล"
         Height          =   495
         Left            =   3000
         TabIndex        =   13
         Top             =   1920
         Width           =   975
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
         Left            =   4080
         TabIndex        =   11
         ToolTipText     =   "กดเมื่อต้องการเลิกการทำงาน"
         Top             =   1920
         Width           =   975
      End
      Begin VB.CommandButton cmdSave 
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
         Left            =   840
         TabIndex        =   4
         ToolTipText     =   "กดเมื่อต้องการบันทึกข้อมูล"
         Top             =   1920
         Width           =   975
      End
      Begin VB.TextBox txtfields 
         DataField       =   "CountryNo"
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
         Left            =   2160
         TabIndex        =   0
         Top             =   360
         Width           =   2895
      End
      Begin VB.TextBox txtfields 
         DataField       =   "CountryName"
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
         Left            =   2160
         TabIndex        =   1
         Top             =   720
         Width           =   2895
      End
      Begin VB.TextBox txtfields 
         DataField       =   "A2"
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
         Left            =   2160
         TabIndex        =   2
         Top             =   1080
         Width           =   2895
      End
      Begin VB.TextBox txtfields 
         DataField       =   "A3"
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
         Left            =   2160
         TabIndex        =   3
         Top             =   1440
         Width           =   2895
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "รหัสประเทศ :"
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
         Left            =   1080
         TabIndex        =   10
         Top             =   360
         Width           =   960
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "ชื่อประเทศย่อลำดับที่ 2 :"
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
         Left            =   360
         TabIndex        =   9
         Top             =   1440
         Width           =   1665
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "ชื่อประเทศแบบเต็ม  :"
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
         Left            =   600
         TabIndex        =   8
         Top             =   720
         Width           =   1440
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "ชื่อประเทศย่อลำดับที่ 1 :"
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
         Left            =   360
         TabIndex        =   7
         Top             =   1080
         Width           =   1680
      End
   End
   Begin VB.Label Label1 
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
      TabIndex        =   5
      Top             =   120
      Width           =   2175
   End
End
Attribute VB_Name = "frmCountry"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub cmdAdd_Click()
On Error GoTo ProcError
    AddRecord
    txtfields(0).SetFocus
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
    ' add it
    rdc.Resultset.AddNew
    txtfields(0).SetFocus
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


Private Sub txtFields_KeyPress(Index As Integer, KeyAscii As Integer)
    If Index = 0 And KeyAscii = 13 Then txtfields(1).SetFocus
    If Index = 1 And KeyAscii = 13 Then txtfields(2).SetFocus
    If Index = 2 And KeyAscii = 13 Then txtfields(3).SetFocus
    If Index = 3 And KeyAscii = 13 Then cmdSave.SetFocus
End Sub

