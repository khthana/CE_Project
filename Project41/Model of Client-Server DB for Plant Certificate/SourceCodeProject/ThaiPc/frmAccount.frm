VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form frmAccount 
   Caption         =   "แบบฟอร์มแสดงบัญชีรายชื่อพืชที่ส่งออก"
   ClientHeight    =   5265
   ClientLeft      =   645
   ClientTop       =   1275
   ClientWidth     =   10560
   LinkTopic       =   "Form1"
   ScaleHeight     =   5265
   ScaleWidth      =   10560
   Begin VB.CommandButton cmdExit 
      Caption         =   "เลิกบันทึก"
      Height          =   495
      Left            =   6000
      TabIndex        =   14
      Top             =   3120
      Width           =   975
   End
   Begin VB.TextBox Text3 
      DataField       =   "CountryName"
      DataSource      =   "rdcCountry"
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
      Left            =   3480
      TabIndex        =   10
      Top             =   4680
      Width           =   3975
   End
   Begin VB.TextBox Text3 
      DataField       =   "CountryNo"
      DataSource      =   "rdcCountry"
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
      Left            =   2280
      TabIndex        =   9
      Top             =   4680
      Width           =   1095
   End
   Begin VB.TextBox Text2 
      DataField       =   "CommonName"
      DataSource      =   "rdcPlant"
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
      Left            =   3480
      TabIndex        =   8
      Top             =   4320
      Width           =   3975
   End
   Begin VB.TextBox Text2 
      DataField       =   "PlantID"
      DataSource      =   "rdcPlant"
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
      Left            =   2280
      TabIndex        =   7
      Top             =   4320
      Width           =   1095
   End
   Begin VB.TextBox Text1 
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
      Index           =   1
      Left            =   3480
      TabIndex        =   6
      Top             =   3960
      Width           =   3975
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
      Index           =   0
      Left            =   2280
      TabIndex        =   5
      Top             =   3960
      Width           =   1095
   End
   Begin MSRDC.MSRDC rdcCountry 
      Height          =   330
      Left            =   4440
      Top             =   5040
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
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
      RecordSource    =   "Select *  From Country"
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "rdcCountry"
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
   Begin MSRDC.MSRDC rdcPlant 
      Height          =   330
      Left            =   2160
      Top             =   5040
      Visible         =   0   'False
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
      RecordSource    =   "Select * From PlantsDetail"
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "rdcPlant"
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
   Begin VB.CommandButton cmdUncheck 
      Caption         =   "เลิกตรวจ"
      Height          =   495
      Left            =   4920
      TabIndex        =   4
      Top             =   3120
      Width           =   975
   End
   Begin VB.CommandButton cmdCheck 
      Caption         =   "ตรวจข้อมูล"
      Height          =   495
      Left            =   3840
      TabIndex        =   3
      Top             =   3120
      Width           =   975
   End
   Begin MSRDC.MSRDC rdcEx 
      Height          =   330
      Left            =   120
      Top             =   5040
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
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
      RecordSource    =   "Select * From Exporter"
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
   Begin MSDBGrid.DBGrid dbg2 
      Bindings        =   "frmAccount.frx":0000
      Height          =   2535
      Left            =   240
      OleObjectBlob   =   "frmAccount.frx":0015
      TabIndex        =   0
      Top             =   480
      Width           =   10095
   End
   Begin MSRDC.MSRDC rdcExPlant 
      Height          =   330
      Left            =   240
      Top             =   3120
      Width           =   3375
      _ExtentX        =   5953
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
      RecordSource    =   "Select * From ExportPlants"
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "ข้อมูลบัญชีรายชื่อพืชที่ส่งออก"
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
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      Caption         =   "เดือน / วัน / ปี"
      Height          =   210
      Left            =   8880
      TabIndex        =   20
      Top             =   3240
      Width           =   1035
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      Caption         =   "วันที่ส่งออก : "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   7560
      TabIndex        =   19
      Top             =   3240
      Width           =   1155
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "03 หมายถึง ขนส่งทางรถไฟ"
      Height          =   210
      Index           =   3
      Left            =   7920
      TabIndex        =   18
      Top             =   4680
      Width           =   1875
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "02 หมายถึง ขนส่งทางอากาศ"
      Height          =   210
      Index           =   2
      Left            =   7920
      TabIndex        =   17
      Top             =   4320
      Width           =   1935
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "01 หมายถึง ขนส่งทางเรือ"
      Height          =   210
      Index           =   1
      Left            =   7920
      TabIndex        =   16
      Top             =   3960
      Width           =   1710
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "ช่องข้อมูลขนส่งทาง :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   0
      Left            =   7560
      TabIndex        =   15
      Top             =   3600
      Width           =   1770
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "รหัสประเทศ/ชื่อประเทศ :"
      Height          =   210
      Index           =   2
      Left            =   360
      TabIndex        =   13
      Top             =   4680
      Width           =   1785
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "รหัสพืช/ชื่อพืช :"
      Height          =   210
      Index           =   1
      Left            =   360
      TabIndex        =   12
      Top             =   4320
      Width           =   1095
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "รหัสผู้ส่งออก/ชื่อผู้ส่งออก :"
      Height          =   210
      Index           =   0
      Left            =   360
      TabIndex        =   11
      Top             =   3960
      Width           =   1755
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "ตรวจสอบความถูกต้อง :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   240
      TabIndex        =   2
      Top             =   3600
      Width           =   1920
   End
   Begin VB.Label Label1 
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
      TabIndex        =   1
      Top             =   120
      Width           =   2145
   End
End
Attribute VB_Name = "frmAccount"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim check As Boolean
Private Sub cmdCheck_Click()
    check = True
    dbg2.SetFocus
End Sub
Private Sub cmdExit_Click()
    Unload Me
End Sub
Private Sub cmdUncheck_Click()
    check = False
    dbg2.SetFocus
End Sub

Private Sub Form_Initialize()
    rdcExPlant.Resultset.MoveLast
    check = False
End Sub
Private Sub rdcExPlant_Reposition()
On Error GoTo ProcError

Dim strSQL1, strSQL2, strSQL3 As String
    If check = True Then
        ' retrive ExporterDetail
        strSQL1 = "Select * From Exporter Where ExporterNumber = '" & rdcExPlant.Resultset![ExporterNo] & "' "
        rdcEx.SQL = strSQL1
        rdcEx.Refresh
        ' retrive PlantDetail
        strSQL2 = "Select * From PlantsDetail Where PlantID = '" & rdcExPlant.Resultset![PlantCode] & "' "
        rdcPlant.SQL = strSQL2
        rdcPlant.Refresh
        ' retrive CountryDetail
        strSQL3 = "Select * From country Where countryNo = '" & rdcExPlant.Resultset![ToCountryNo] & "' "
        rdcCountry.SQL = strSQL3
        rdcCountry.Refresh
    End If

ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub

