VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form frmExMas 
   Caption         =   "แบบฟอร์มข้อมูลผู้ส่งออกและผู้นำเข้า"
   ClientHeight    =   6630
   ClientLeft      =   570
   ClientTop       =   765
   ClientWidth     =   10980
   LinkTopic       =   "Form2"
   ScaleHeight     =   6630
   ScaleWidth      =   10980
   Begin VB.Frame Frame2 
      Caption         =   "ข้อมูลผู้นำเข้า"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2295
      Left            =   120
      TabIndex        =   12
      Top             =   4200
      Width           =   10695
      Begin VB.CommandButton cmdExit1 
         Caption         =   "เลิกบันทึก"
         Height          =   495
         Left            =   6720
         TabIndex        =   23
         Top             =   1560
         Width           =   1095
      End
      Begin VB.CommandButton cmdDel1 
         Caption         =   "ลบข้อมูล"
         Height          =   495
         Left            =   5520
         TabIndex        =   22
         Top             =   1560
         Width           =   1095
      End
      Begin VB.CommandButton cmdAdd1 
         Caption         =   "เพิ่มข้อมูล"
         Height          =   495
         Left            =   4320
         TabIndex        =   21
         Top             =   1560
         Width           =   1095
      End
      Begin VB.CommandButton cmdSave1 
         Caption         =   "บันทึกข้อมูล"
         Height          =   495
         Left            =   3120
         TabIndex        =   20
         Top             =   1560
         Width           =   1095
      End
      Begin VB.TextBox Text6 
         DataField       =   "Address"
         DataSource      =   "rdcCon"
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
         Left            =   1320
         TabIndex        =   15
         Text            =   "ConAddress"
         Top             =   1080
         Width           =   9135
      End
      Begin VB.TextBox Text5 
         DataField       =   "ConsigneeName"
         DataSource      =   "rdcCon"
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
         Left            =   1320
         TabIndex        =   14
         Text            =   "ConName"
         Top             =   720
         Width           =   9135
      End
      Begin VB.TextBox Text4 
         DataField       =   "ConsigneeNumber"
         DataSource      =   "rdcCon"
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
         Left            =   1320
         TabIndex        =   13
         Text            =   "ConNo"
         Top             =   360
         Width           =   2175
      End
      Begin MSRDC.MSRDC rdcCon 
         Height          =   330
         Left            =   120
         Top             =   1680
         Width           =   2775
         _ExtentX        =   4895
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
         RecordSource    =   "Select * From Consignee Order By 1"
         UserName        =   "sa"
         Password        =   "thaipc"
         Connect         =   ""
         LogMessages     =   ""
         Caption         =   "ข้อมูลผู้นำเข้า"
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
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "ชื่อผู้นำเข้า :"
         Height          =   210
         Index           =   2
         Left            =   360
         TabIndex        =   19
         Top             =   720
         Width           =   825
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "ที่อยู่ผู้นำเข้า :"
         Height          =   210
         Index           =   1
         Left            =   240
         TabIndex        =   18
         Top             =   1080
         Width           =   930
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "รหัสผู้นำเข้า :"
         Height          =   210
         Index           =   0
         Left            =   240
         TabIndex        =   17
         Top             =   360
         Width           =   915
      End
      Begin VB.Label Label3 
         Caption         =   "Label3"
         Height          =   15
         Left            =   3720
         TabIndex        =   16
         Top             =   840
         Width           =   735
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "ข้อมูลผู้ส่งออก"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3375
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   10695
      Begin VB.TextBox Text8 
         DataField       =   "AddressT2"
         DataSource      =   "rdcEx"
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
         Left            =   1320
         TabIndex        =   25
         Text            =   "AddressThai2"
         Top             =   2160
         Width           =   4575
      End
      Begin VB.TextBox Text7 
         DataField       =   "AddressT1"
         DataSource      =   "rdcEx"
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
         Left            =   1320
         TabIndex        =   24
         Text            =   "AddressThai1"
         Top             =   1800
         Width           =   4575
      End
      Begin VB.CommandButton cmdDel 
         Caption         =   "ลบข้อมูล"
         Height          =   495
         Left            =   5400
         TabIndex        =   10
         Top             =   2640
         Width           =   1095
      End
      Begin VB.CommandButton cmdExit 
         Caption         =   "เลิกบันทึก"
         Height          =   495
         Left            =   6600
         TabIndex        =   9
         Top             =   2640
         Width           =   1095
      End
      Begin VB.CommandButton cmdAdd 
         Caption         =   "เพิ่มข้อมูล"
         Height          =   495
         Left            =   4200
         TabIndex        =   8
         Top             =   2640
         Width           =   1095
      End
      Begin VB.CommandButton cmdSave 
         Caption         =   "บันทึกข้อมูล"
         Height          =   495
         Left            =   3000
         TabIndex        =   7
         Top             =   2640
         Width           =   1095
      End
      Begin VB.TextBox Text1 
         DataField       =   "ExporterNumber"
         DataSource      =   "rdcEx"
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
         Left            =   1320
         TabIndex        =   1
         Text            =   "ExNo"
         Top             =   360
         Width           =   2175
      End
      Begin VB.TextBox Text2 
         DataField       =   "ExporterName"
         DataSource      =   "rdcEx"
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
         Left            =   1320
         TabIndex        =   2
         Text            =   "ExName"
         Top             =   720
         Width           =   9135
      End
      Begin VB.TextBox Text3 
         DataField       =   "Address"
         DataSource      =   "rdcEx"
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
         Left            =   1320
         TabIndex        =   3
         Text            =   "ExAddress"
         Top             =   1080
         Width           =   9135
      End
      Begin MSRDC.MSRDC rdcEx 
         Height          =   330
         Left            =   120
         Top             =   2760
         Width           =   2655
         _ExtentX        =   4683
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
         RecordSource    =   "Select * From Exporter Order by 1"
         UserName        =   "sa"
         Password        =   "thaipc"
         Connect         =   ""
         LogMessages     =   ""
         Caption         =   "ข้อมูลผู้ส่งออก"
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
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "ที่อยู่ผู้ส่งออก :"
         Height          =   210
         Index           =   3
         Left            =   240
         TabIndex        =   27
         Top             =   1800
         Width           =   945
      End
      Begin VB.Label Label5 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "( ภาษาไทย )"
         Height          =   210
         Left            =   240
         TabIndex        =   26
         Top             =   2040
         Width           =   885
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "ที่อยู่ผู้ส่งออก :"
         Height          =   210
         Index           =   2
         Left            =   240
         TabIndex        =   6
         Top             =   1080
         Width           =   945
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "ชื่อผู้ส่งออก :"
         Height          =   210
         Index           =   1
         Left            =   360
         TabIndex        =   5
         Top             =   720
         Width           =   840
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "รหัสผู้ส่งออก :"
         Height          =   210
         Index           =   0
         Left            =   240
         TabIndex        =   4
         Top             =   360
         Width           =   930
      End
   End
   Begin VB.Label Label2 
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
      Left            =   240
      TabIndex        =   11
      Top             =   120
      Width           =   2145
   End
End
Attribute VB_Name = "frmExMas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub cmdAdd_Click()
On Error GoTo ProcError
    AddRecord
    Text1.SetFocus
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
Resume ProcExit
End Sub
Private Sub cmdAdd1_Click()
On Error GoTo ProcError
    AddRecord1
    Text4.SetFocus
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
Private Sub cmdDel1_Click()
On Error GoTo ProcError
    DeleteRecord1
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
Resume ProcExit
End Sub
Private Sub cmdExit_Click()
    Unload Me
End Sub
Private Sub cmdExit1_Click()
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
Private Sub cmdSave1_Click()
On Error GoTo ProcError
    SaveRecord1
    cmdAdd1.SetFocus
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
Private Sub Form_Initialize()
    rdcCon.Resultset.AddNew
    rdcEx.Resultset.AddNew
End Sub
Private Sub SaveRecord()
    Select Case rdcEx.Resultset.EditMode
        Case rdEditNone
            'clean record,do nothing
        Case rdEditInProgress
            ' the control handles regular edits
            rdcEx.UpdateRow
        Case rdEditAdd
            ' use the update method of the resultset
            rdcEx.Resultset.Update
    End Select
End Sub
Private Sub SaveRecord1()
    Select Case rdcCon.Resultset.EditMode
        Case rdEditNone
            'clean record,do nothing
        Case rdEditInProgress
            ' the control handles regular edits
            rdcCon.UpdateRow
        Case rdEditAdd
            ' use the update method of the resultset
            rdcCon.Resultset.Update
    End Select
End Sub
Private Sub AddRecord()
    ' add it
    rdcEx.Resultset.AddNew
    'Text1.SetFocus
End Sub
Private Sub AddRecord1()
    ' add it
    rdcCon.Resultset.AddNew
End Sub
Private Sub DeleteRecord()
    ' delete the row
    rdcEx.Resultset.Delete
    ' back up one row
    rdcEx.Resultset.MovePrevious
    ' check for beginning of set
    If rdcEx.Resultset.BOF Then
        rdcEx.Resultset.MoveFirst
    End If
End Sub
Private Sub DeleteRecord1()
    ' delete the row
    rdcCon.Resultset.Delete
    ' back up one row
    rdcCon.Resultset.MovePrevious
    ' check for beginning of set
    If rdcCon.Resultset.BOF Then
        rdcCon.Resultset.MoveFirst
    End If
End Sub
Private Sub Text1_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Text2.SetFocus
End Sub
Private Sub Text2_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Text3.SetFocus
End Sub
Private Sub Text3_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmdSave.SetFocus
End Sub
Private Sub Text4_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Text5.SetFocus
End Sub
Private Sub Text5_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Text6.SetFocus
End Sub
Private Sub Text6_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmdSave1.SetFocus
End Sub



