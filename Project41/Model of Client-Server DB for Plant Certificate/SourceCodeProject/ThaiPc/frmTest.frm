VERSION 5.00
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   5895
   ClientLeft      =   3525
   ClientTop       =   1770
   ClientWidth     =   7800
   LinkTopic       =   "Form1"
   ScaleHeight     =   5895
   ScaleWidth      =   7800
   Begin VB.TextBox Text8 
      DataField       =   "ConsigneeNumber"
      DataSource      =   "rdcCon"
      Height          =   375
      Left            =   3360
      TabIndex        =   8
      Text            =   "Text8"
      Top             =   3480
      Width           =   975
   End
   Begin VB.TextBox Text7 
      DataField       =   "ExporterNumber"
      DataSource      =   "rdcEx"
      Height          =   375
      Left            =   3360
      TabIndex        =   7
      Text            =   "Text7"
      Top             =   2520
      Width           =   975
   End
   Begin MSRDC.MSRDC rdcCon 
      Height          =   330
      Left            =   5280
      Top             =   2280
      Width           =   2055
      _ExtentX        =   3625
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
      RecordSource    =   "Select * From Consignee"
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "rdcCon"
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
   Begin MSRDC.MSRDC rdcEx 
      Height          =   330
      Left            =   5280
      Top             =   1800
      Width           =   2055
      _ExtentX        =   3625
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
      RecordSource    =   "Select * From Exporter "
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "rdcEx"
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
   Begin VB.TextBox Text6 
      DataField       =   "ConsigneeName"
      DataSource      =   "rdcCon"
      Height          =   375
      Left            =   720
      TabIndex        =   6
      Text            =   "Text6"
      Top             =   3960
      Width           =   4335
   End
   Begin VB.TextBox Text5 
      DataField       =   "ExporterName"
      DataSource      =   "rdcEx"
      Height          =   375
      Left            =   720
      TabIndex        =   5
      Text            =   "Text5"
      Top             =   3000
      Width           =   4335
   End
   Begin VB.TextBox Text4 
      DataField       =   "ConsigneeNumber"
      DataSource      =   "rdc1"
      Height          =   375
      Left            =   720
      TabIndex        =   4
      Text            =   "Text4"
      Top             =   3480
      Width           =   1215
   End
   Begin VB.TextBox Text3 
      DataField       =   "ExporterNumber"
      DataSource      =   "rdc1"
      Height          =   375
      Left            =   720
      TabIndex        =   3
      Text            =   "Text3"
      Top             =   2520
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      DataField       =   "RefNo"
      DataSource      =   "rdc1"
      Height          =   375
      Left            =   720
      TabIndex        =   2
      Text            =   "Text2"
      Top             =   2040
      Width           =   1215
   End
   Begin MSRDC.MSRDC rdc1 
      Height          =   330
      Left            =   4080
      Top             =   120
      Width           =   2055
      _ExtentX        =   3625
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
      RecordSource    =   "Select * From Applications "
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "rdc1"
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
   Begin Crystal.CrystalReport crptTest 
      Left            =   2880
      Top             =   600
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "test.rpt"
      WindowTitle     =   "Test Print"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   1080
      TabIndex        =   1
      Top             =   1320
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   495
      Left            =   840
      TabIndex        =   0
      Top             =   480
      Width           =   1455
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim str1, str2 As String
Private Sub Command1_Click()
On Error GoTo ProcError
   
   '--------------------------------
        crptTest.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str1 = "{Applications.RefNo} = '" & Text1.Text & "' "
        crptTest.SelectionFormula = str1
        crptTest.Action = 1
   '--------------------------------


ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
Private Sub rdc1_Reposition()
On Error GoTo ProcError
    Dim strSQL1, strSQL2, strSQL3 As String
    Dim rsPara As rdoResultset
        
    'Text1.Text = txtFields(0).Text
    
    
    ' set Exporter
    strSQL1 = "Select * From Exporter Where ExporterNumber ='" & rdc1.Resultset![ExporterNumber] & "' "
    rdcEx.SQL = strSQL1
    rdcEx.Refresh
    
    ' set Consignee
    strSQL2 = "Select * From Consignee Where ConsigneeNumber = '" & rdc1.Resultset![ConsigneeNumber] & "' "
    rdcCon.SQL = strSQL2
    rdcCon.Refresh
    

ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
Private Sub Text1_KeyPress(KeyAscii As Integer)
On Error GoTo ProcError
    Dim Test, strSQL1, strSQL2 As String
    If KeyAscii = 13 Then
        Test = Text1.Text
        str2 = "Select * From Applications Where Applications.RefNo = '" & Test & "' "
        rdc1.SQL = str2
        rdc1.Refresh
    
    '----------------------
    ' set Exporter
    strSQL1 = "Select * From Exporter Where ExporterNumber ='" & rdc1.Resultset![ExporterNumber] & "' "
    rdcEx.SQL = strSQL1
    rdcEx.Refresh
    
    ' set Consignee
    strSQL2 = "Select * From Consignee Where ConsigneeNumber = '" & rdc1.Resultset![ConsigneeNumber] & "' "
    rdcCon.SQL = strSQL2
    rdcCon.Refresh


ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit

    
    End If
End Sub
