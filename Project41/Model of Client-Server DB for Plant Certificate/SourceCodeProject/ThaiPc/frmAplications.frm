VERSION 5.00
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form frmApplications 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "คำขอใบรับรองปลอดศัตรูพืช ( แบบ พ.ก. 9 )"
   ClientHeight    =   8625
   ClientLeft      =   210
   ClientTop       =   330
   ClientWidth     =   11880
   ForeColor       =   &H8000000C&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   8625
   ScaleWidth      =   11880
   WindowState     =   2  'Maximized
   Begin MSRDC.MSRDC rdcCon 
      Height          =   330
      Left            =   7800
      Top             =   6840
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
      Enabled         =   0   'False
      ReadOnly        =   0   'False
      Appearance      =   -1  'True
      DataSourceName  =   "DBProject"
      RecordSource    =   "SELECT * FROM Consignee ORDER BY 1"
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
   Begin VB.TextBox txtConNum 
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
      Index           =   1
      Left            =   480
      TabIndex        =   59
      Top             =   6840
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.TextBox txtExNum 
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
      Index           =   1
      Left            =   4080
      TabIndex        =   58
      Top             =   6720
      Visible         =   0   'False
      Width           =   2055
   End
   Begin MSRDC.MSRDC rdcEx 
      Height          =   330
      Left            =   1080
      Top             =   6720
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
      Enabled         =   0   'False
      ReadOnly        =   0   'False
      Appearance      =   -1  'True
      DataSourceName  =   "DBProject"
      RecordSource    =   "SELECT * FROM Exporter ORDER BY 1"
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
   Begin Crystal.CrystalReport crptForm1 
      Left            =   9480
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "certi.rpt"
      WindowWidth     =   500
      WindowTitle     =   "รายงานใบรับรองปลอดศัตรูพืช"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
      UserName        =   "sa"
   End
   Begin VB.CommandButton cmdPrint 
      Caption         =   "พิมพ์"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Left            =   8280
      TabIndex        =   13
      Top             =   240
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Caption         =   "ชื่อและที่อยู่ผู้ส่งออก , ชื่อและที่อยู่ผู้รับ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   2295
      Left            =   360
      TabIndex        =   34
      Top             =   720
      Width           =   11415
      Begin VB.TextBox txtFields 
         DataField       =   "ShipAgent"
         DataSource      =   "rdcApp"
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
         Index           =   13
         Left            =   7920
         MaxLength       =   50
         TabIndex        =   70
         Top             =   360
         Width           =   615
      End
      Begin VB.TextBox txtFields 
         DataField       =   "ChInspector"
         DataSource      =   "rdcApp"
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
         Index           =   23
         Left            =   9360
         MaxLength       =   50
         TabIndex        =   69
         Top             =   360
         Width           =   615
      End
      Begin VB.TextBox txtFields 
         DataField       =   "Inspector"
         DataSource      =   "rdcApp"
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
         Index           =   24
         Left            =   10560
         MaxLength       =   50
         TabIndex        =   68
         Top             =   360
         Width           =   615
      End
      Begin VB.TextBox txtConNum 
         DataField       =   "ConsigneeNumber"
         DataSource      =   "rdcApp"
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
         Left            =   5280
         TabIndex        =   57
         Top             =   360
         Width           =   1815
      End
      Begin VB.TextBox txtExNum 
         DataField       =   "ExporterNumber"
         DataSource      =   "rdcApp"
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
         Left            =   1680
         TabIndex        =   55
         Top             =   360
         Width           =   1815
      End
      Begin VB.TextBox txtFields 
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
         Index           =   2
         Left            =   1680
         MaxLength       =   255
         TabIndex        =   46
         Top             =   1440
         Width           =   9495
      End
      Begin VB.TextBox txtFields 
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
         Left            =   1680
         MaxLength       =   255
         TabIndex        =   45
         Top             =   720
         Width           =   9495
      End
      Begin VB.TextBox txtFields 
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
         Index           =   27
         Left            =   1680
         MaxLength       =   255
         TabIndex        =   2
         Top             =   1800
         Width           =   9495
      End
      Begin VB.TextBox txtFields 
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
         Index           =   30
         Left            =   1680
         MaxLength       =   255
         TabIndex        =   1
         Top             =   1080
         Width           =   9495
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "ShAgt:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   7320
         TabIndex        =   73
         Top             =   360
         Width           =   570
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "ChInsp:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   2
         Left            =   8640
         TabIndex        =   72
         Top             =   360
         Width           =   645
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "Insp:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   10080
         TabIndex        =   71
         Top             =   360
         Width           =   420
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "ConsigneeNumber :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   3600
         TabIndex        =   56
         Top             =   360
         Width           =   1650
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "ExporterNumber :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   54
         Top             =   360
         Width           =   1470
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "Address:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   27
         Left            =   120
         TabIndex        =   44
         Top             =   1800
         Width           =   735
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "ConsigneeName:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   28
         Left            =   120
         TabIndex        =   43
         Top             =   1440
         Width           =   1425
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "Address:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   33
         Left            =   120
         TabIndex        =   36
         Top             =   1080
         Width           =   735
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "ExporterName:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   34
         Left            =   120
         TabIndex        =   35
         Top             =   720
         Width           =   1245
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Disinfestation And/Or Disinfection Treatment"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   1935
      Left            =   360
      TabIndex        =   27
      Top             =   6600
      Width           =   11415
      Begin VB.ComboBox Combo7 
         DataField       =   "AddDeclaration2"
         DataSource      =   "rdcApp"
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
         ItemData        =   "frmAplications.frx":0000
         Left            =   1680
         List            =   "frmAplications.frx":000D
         TabIndex        =   67
         Top             =   1440
         Width           =   9615
      End
      Begin VB.ComboBox Combo7 
         DataField       =   "AddDeclaration1"
         DataSource      =   "rdcApp"
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
         ItemData        =   "frmAplications.frx":00BA
         Left            =   1680
         List            =   "frmAplications.frx":00E5
         TabIndex        =   53
         Top             =   1080
         Width           =   9615
      End
      Begin VB.ComboBox Combo6 
         DataField       =   "AddInformation"
         DataSource      =   "rdcApp"
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
         ItemData        =   "frmAplications.frx":03E0
         Left            =   8640
         List            =   "frmAplications.frx":03E7
         TabIndex        =   52
         Top             =   720
         Width           =   2655
      End
      Begin VB.ComboBox Combo5 
         DataField       =   "Concentration"
         DataSource      =   "rdcApp"
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
         ItemData        =   "frmAplications.frx":0400
         Left            =   5520
         List            =   "frmAplications.frx":0416
         TabIndex        =   51
         Top             =   720
         Width           =   2055
      End
      Begin VB.ComboBox Combo4 
         DataField       =   "Temperature"
         DataSource      =   "rdcApp"
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
         ItemData        =   "frmAplications.frx":0477
         Left            =   1680
         List            =   "frmAplications.frx":048D
         TabIndex        =   50
         Top             =   720
         Width           =   2415
      End
      Begin VB.ComboBox Combo3 
         DataField       =   "Chemical"
         DataSource      =   "rdcApp"
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
         ItemData        =   "frmAplications.frx":04DE
         Left            =   8640
         List            =   "frmAplications.frx":04F7
         TabIndex        =   49
         Top             =   360
         Width           =   2655
      End
      Begin VB.ComboBox Combo2 
         DataField       =   "Treatment"
         DataSource      =   "rdcApp"
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
         ItemData        =   "frmAplications.frx":055C
         Left            =   5520
         List            =   "frmAplications.frx":056C
         Sorted          =   -1  'True
         TabIndex        =   48
         Top             =   360
         Width           =   2055
      End
      Begin VB.TextBox txtFields 
         DataField       =   "TreatmentDate"
         DataSource      =   "rdcApp"
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
         Index           =   17
         Left            =   1680
         TabIndex        =   11
         Top             =   360
         Width           =   2415
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "AddDeclaration:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   42
         Top             =   1080
         Width           =   1365
      End
      Begin VB.Label lblLabels 
         Caption         =   "TreatmentDate:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   17
         Left            =   120
         TabIndex        =   33
         Top             =   360
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "Treatment:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   18
         Left            =   4200
         TabIndex        =   32
         Top             =   360
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "Chemical:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   19
         Left            =   7680
         TabIndex        =   31
         Top             =   360
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "Duration/Temp:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   20
         Left            =   120
         TabIndex        =   30
         Top             =   720
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "Concentration:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   21
         Left            =   4200
         TabIndex        =   29
         Top             =   720
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "AddInform:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   22
         Left            =   7680
         TabIndex        =   28
         Top             =   720
         Width           =   1815
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Description Of Consignment"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   3615
      Left            =   360
      TabIndex        =   21
      Top             =   3000
      Width           =   11415
      Begin VB.TextBox txtFields 
         DataField       =   "ProduceQuantity4"
         DataSource      =   "rdcApp"
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
         Index           =   19
         Left            =   6480
         MaxLength       =   255
         TabIndex        =   66
         Top             =   2520
         Width           =   4695
      End
      Begin VB.TextBox txtFields 
         DataField       =   "ProduceQuantity3"
         DataSource      =   "rdcApp"
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
         Index           =   18
         Left            =   1680
         MaxLength       =   255
         TabIndex        =   65
         Top             =   2520
         Width           =   4695
      End
      Begin VB.TextBox txtFields 
         DataField       =   "ProduceQuantity2"
         DataSource      =   "rdcApp"
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
         Index           =   11
         Left            =   6480
         MaxLength       =   255
         TabIndex        =   64
         Top             =   2160
         Width           =   4695
      End
      Begin VB.TextBox txtFields 
         DataField       =   "BotanicalName4"
         DataSource      =   "rdcApp"
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
         Index           =   9
         Left            =   6480
         MaxLength       =   255
         TabIndex        =   63
         Top             =   3240
         Width           =   4695
      End
      Begin VB.TextBox txtFields 
         DataField       =   "BotanicalName3"
         DataSource      =   "rdcApp"
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
         Index           =   7
         Left            =   1680
         MaxLength       =   255
         TabIndex        =   62
         Top             =   3240
         Width           =   4695
      End
      Begin VB.TextBox txtFields 
         DataField       =   "BotanicalName2"
         DataSource      =   "rdcApp"
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
         Index           =   5
         Left            =   6480
         MaxLength       =   255
         TabIndex        =   61
         Top             =   2880
         Width           =   4695
      End
      Begin VB.ComboBox Combo8 
         DataField       =   "OriginOfPlant"
         DataSource      =   "rdcApp"
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
         ItemData        =   "frmAplications.frx":059E
         Left            =   1680
         List            =   "frmAplications.frx":05A5
         TabIndex        =   60
         Top             =   1080
         Width           =   3855
      End
      Begin VB.ComboBox Combo1 
         DataField       =   "Means"
         DataSource      =   "rdcApp"
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
         ItemData        =   "frmAplications.frx":05B3
         Left            =   1680
         List            =   "frmAplications.frx":05C0
         Sorted          =   -1  'True
         TabIndex        =   47
         Top             =   1440
         Width           =   3855
      End
      Begin VB.TextBox txtFields 
         DataField       =   "BotanicalName1"
         DataSource      =   "rdcApp"
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
         Index           =   16
         Left            =   1680
         MaxLength       =   255
         TabIndex        =   10
         Top             =   2880
         Width           =   4695
      End
      Begin VB.TextBox txtFields 
         DataField       =   "ShipName"
         DataSource      =   "rdcApp"
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
         Index           =   8
         Left            =   1680
         MaxLength       =   50
         TabIndex        =   8
         Top             =   1800
         Width           =   3855
      End
      Begin VB.TextBox txtFields 
         DataField       =   "ToPort"
         DataSource      =   "rdcApp"
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
         Index           =   6
         Left            =   7200
         MaxLength       =   50
         TabIndex        =   5
         Top             =   1080
         Width           =   3975
      End
      Begin VB.TextBox txtFields 
         DataField       =   "ToCountry"
         DataSource      =   "rdcApp"
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
         Index           =   4
         Left            =   7200
         MaxLength       =   50
         TabIndex        =   6
         Top             =   1440
         Width           =   3975
      End
      Begin VB.TextBox txtFields 
         DataField       =   "Marks"
         DataSource      =   "rdcApp"
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
         Index           =   10
         Left            =   1680
         MaxLength       =   50
         TabIndex        =   7
         Top             =   720
         Width           =   9495
      End
      Begin VB.TextBox txtFields 
         DataField       =   "PermitNo"
         DataSource      =   "rdcApp"
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
         Index           =   12
         Left            =   7200
         MaxLength       =   50
         TabIndex        =   9
         Top             =   1800
         Width           =   3975
      End
      Begin VB.TextBox txtFields 
         DataField       =   "DescriptionOfPackage"
         DataSource      =   "rdcApp"
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
         Index           =   14
         Left            =   1680
         MaxLength       =   255
         TabIndex        =   3
         Top             =   360
         Width           =   9495
      End
      Begin VB.TextBox txtFields 
         DataField       =   "ProduceQuantity1"
         DataSource      =   "rdcApp"
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
         Index           =   15
         Left            =   1680
         MaxLength       =   255
         TabIndex        =   4
         Top             =   2160
         Width           =   4695
      End
      Begin VB.Label lblLabels 
         Caption         =   "BotanicalName:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   16
         Left            =   120
         TabIndex        =   41
         Top             =   2880
         Width           =   1815
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "ShipName:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   40
         Top             =   1800
         Width           =   915
      End
      Begin VB.Label lblLabels 
         Caption         =   "ToPort:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   6
         Left            =   5760
         TabIndex        =   39
         Top             =   1080
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "ToCountry:"
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
         Index           =   4
         Left            =   5760
         TabIndex        =   38
         Top             =   1440
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "Means:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   7
         Left            =   120
         TabIndex        =   37
         Top             =   1440
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "Mark:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   10
         Left            =   120
         TabIndex        =   26
         Top             =   720
         Width           =   480
      End
      Begin VB.Label lblLabels 
         Caption         =   "OriginOfPlant:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   11
         Left            =   120
         TabIndex        =   25
         Top             =   1080
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "ImportPermitNo:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   12
         Left            =   5760
         TabIndex        =   24
         Top             =   1800
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "DescOfPackage:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   14
         Left            =   120
         TabIndex        =   23
         Top             =   360
         Width           =   1815
      End
      Begin VB.Label lblLabels 
         Caption         =   "ProduceQuantity:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   15
         Left            =   120
         TabIndex        =   22
         Top             =   2160
         Width           =   1815
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "ReferenceNumber"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   735
      Left            =   360
      TabIndex        =   19
      Top             =   0
      Width           =   4095
      Begin VB.TextBox txtFields 
         DataField       =   "RefNo"
         DataSource      =   "rdcApp"
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
         Left            =   1560
         MaxLength       =   20
         TabIndex        =   0
         Top             =   240
         Width           =   2175
      End
      Begin VB.Label lblLabels 
         AutoSize        =   -1  'True
         Caption         =   "ReferenceNo:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   20
         Top             =   240
         Width           =   1185
      End
   End
   Begin VB.PictureBox picButtons 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   420
      Left            =   4800
      ScaleHeight     =   420
      ScaleWidth      =   3885
      TabIndex        =   16
      Top             =   240
      Width           =   3885
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
         Height          =   420
         Left            =   2400
         TabIndex        =   15
         Top             =   0
         Width           =   975
      End
      Begin VB.CommandButton cmdUpdate 
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
         Height          =   420
         Left            =   0
         TabIndex        =   12
         Top             =   0
         Width           =   1095
      End
      Begin VB.CommandButton cmdRefresh 
         Caption         =   "&Refresh"
         Height          =   300
         Left            =   4200
         TabIndex        =   18
         Top             =   0
         Visible         =   0   'False
         Width           =   975
      End
      Begin VB.CommandButton cmdDelete 
         Caption         =   "&Delete"
         Height          =   300
         Left            =   4200
         TabIndex        =   17
         Top             =   120
         Visible         =   0   'False
         Width           =   975
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
         Height          =   420
         Left            =   1200
         TabIndex        =   14
         Top             =   0
         Width           =   1095
      End
   End
   Begin MSRDC.MSRDC rdcApp 
      Height          =   330
      Left            =   9360
      Top             =   240
      Width           =   2535
      _ExtentX        =   4471
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
      RecordSource    =   "SELECT * FROM  Applications "
      UserName        =   "sa"
      Password        =   "thaipc"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "ข้อมูลใบรับรอง"
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
End
Attribute VB_Name = "frmApplications"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim mcon As rdoConnection
Dim NewConsignee As Boolean
Dim NewExporter As Boolean
Dim NewRefNo As Boolean
Private Sub cmdAdd_Click()
On Error GoTo ProcError
    AddRecord
    txtfields(0).SetFocus
    
ProcExit:
    Exit Sub
ProcError:
    MsgBox "ตรวจพบข้อผิดพลาด ! " & vbCrLf & "  - อาจมีการกดที่ปุ่ม เพิ่มข้อมูล มากกว่า 1 ครั้ง" & vbCrLf & _
    "    หรือกรุณาติดต่อผู้ควบคุมระบบ"
    Resume ProcExit
End Sub
Private Sub cmdClose_Click()
   Unload Me
End Sub
Private Sub cmdPrint_Click()
    Dim str As String
On Error GoTo ProcError
    ' set value to print_RefNo
 '   rdcPara.Resultset.Edit
 '   rdcPara.Resultset![Print_RefNo] = Text1.Text
 '   rdcPara.Resultset.Update
 '   rdcPara.Refresh
    
    ' set crystal report
    crptForm1.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
    str = " {Applications.RefNo} = '" & txtfields(0).Text & "' "
    'str = "{Parameter.Print_RefNo} = '" & Text1.Text & "' "
    crptForm1.SelectionFormula = str
    crptForm1.Action = 1
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
Private Sub cmdUpdate_Click()
On Error GoTo ProcError
    UpdateRecordApp
    rdcApp.Resultset.MoveLast
  
    If NewExporter Then
        UpdateRecordEx
        NewExporter = False
    End If
    If NewConsignee Then
        UpdateRecordCon
        NewConsignee = False
    End If
    ' set focus to AddNew Button
    cmdPrint.SetFocus
    
ProcExit:
    Exit Sub
ProcError:
    MsgBox "ตรวจพบข้อผิดพลาด ! " & vbCrLf & "  - หมายเลข RefNo อาจซ้ำกับหมายเลขเดิมที่มีอยู่" & vbCrLf & _
    "    โปรดตรวจสอบหมายเลข RefNo ว่าซ้ำหรือไม่" & vbCrLf & "    หรือกรุณาติดต่อผู้ควบคุมระบบ"
    Resume ProcExit
End Sub
Private Sub UpdateRecordApp()
    Select Case rdcApp.Resultset.EditMode
        Case rdEditNone
            ' clean record ,do nothing
        Case rdEditInProgress
            ' the control handles regular edits
            rdcApp.UpdateRow
        Case rdEditAdd
            ' use the update method of the resultset
            rdcApp.Resultset.Update
    End Select
        rdcApp.Refresh
End Sub
Private Sub UpdateRecordEx()
    Select Case rdcEx.Resultset.EditMode
        Case rdEditNone
            ' clean record ,do nothing
        Case rdEditInProgress
            ' the control handles regular edits
            rdcEx.UpdateRow
        Case rdEditAdd
            ' use the update method of the resultset
            rdcEx.Resultset.Update
    End Select
        rdcEx.Refresh
End Sub
Private Sub UpdateRecordCon()
    Select Case rdcCon.Resultset.EditMode
        Case rdEditNone
            ' clean record ,do nothing
        Case rdEditInProgress
            ' the control handles regular edits
            rdcCon.UpdateRow
        Case rdEditAdd
            ' use the update method of the resultset
            rdcCon.Resultset.Update
    End Select
        rdcCon.Refresh
End Sub
Private Sub AddRecord()
    ' add it
    rdcApp.Resultset.AddNew
End Sub
Private Sub Combo1_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtfields(8).SetFocus
End Sub
Private Sub Combo2_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Combo3.SetFocus
End Sub
Private Sub Combo3_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Combo4.SetFocus
End Sub
Private Sub Combo4_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Combo5.SetFocus
End Sub
Private Sub Combo5_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Combo6.SetFocus
End Sub
Private Sub Combo6_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Combo7(0).SetFocus
End Sub
Private Sub Combo7_KeyPress(Index As Integer, KeyAscii As Integer)
    If Index = 0 And KeyAscii = 13 Then Combo7(1).SetFocus
    If Index = 1 And KeyAscii = 13 Then txtfields(13).SetFocus
End Sub
Private Sub Combo8_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Combo1.SetFocus
End Sub

Private Sub rdcApp_Reposition()
On Error GoTo ProcError
    Dim strSQL1, strSQL2, strSQL3 As String
    Dim rsPara As rdoResultset
        
    ' set Exporter
    strSQL1 = "Select * From Exporter Where ExporterNumber ='" & rdcApp.Resultset![ExporterNumber] & "' "
    rdcEx.SQL = strSQL1
    rdcEx.Refresh
    
    ' set Consignee
    strSQL2 = "Select * From Consignee Where ConsigneeNumber = '" & rdcApp.Resultset![ConsigneeNumber] & "' "
    rdcCon.SQL = strSQL2
    rdcCon.Refresh
    
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
Private Sub Form_Initialize()
    rdcApp.Resultset.AddNew
    NewExporter = False
    NewConsignee = False
End Sub
Private Sub Form_Load()
On Error GoTo ProcError
    OpenConnection

ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
Private Sub OpenConnection()
    Dim sConnect, strSQL As String
    ' default using a configured DSN
    Set mcon = rdoEnvironments(0).OpenConnection("DBProject")
End Sub
Private Sub txtConNum_KeyPress(Index As Integer, KeyAscii As Integer)
On Error GoTo ProcError
    If Index = 0 And KeyAscii = 13 Then
    Dim strCon, ConNum As String
        ConNum = txtConNum(0).Text
        If NewConsignee = False Then
            strCon = "Select * From Consignee Where ConsigneeNumber ='" & ConNum & "' "
            rdcCon.SQL = strCon
            rdcCon.Refresh
            If rdcCon.Resultset.RowCount = 0 And txtConNum(0).Text <> "" Then
                rdcCon.Resultset.AddNew
                txtConNum(0).Text = ConNum 'txtConNum(0)=AppNum,txtConNum(1)=ConNum
                txtConNum(1).Text = ConNum
                NewConsignee = True
            End If
        Else: txtConNum(0).Text = ConNum
        End If
        txtfields(2).SetFocus
    End If
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
Private Sub txtExNum_KeyPress(Index As Integer, KeyAscii As Integer)
On Error GoTo ProcError
    If Index = 0 And KeyAscii = 13 Then
        Dim strEx, ExNum As String
        ExNum = txtExNum(0).Text
        If NewExporter = False Then
            strEx = "Select * From Exporter Where ExporterNumber = '" & ExNum & "' "
            rdcEx.SQL = strEx
            rdcEx.Refresh
            If rdcEx.Resultset.RowCount = 0 And txtExNum(0).Text <> " " Then
                rdcEx.Resultset.AddNew
                txtExNum(0).Text = ExNum ' txtExNum(0)=AppNum,txtExNum(1)=ExNum
                txtExNum(1).Text = ExNum
                NewExporter = True
            End If
        Else: txtExNum(0).Text = ExNum
        End If
        txtfields(1).SetFocus
    End If
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
Private Sub txtFields_KeyPress(Index As Integer, KeyAscii As Integer)
On Error GoTo ProcError
    Dim Refno As String
    Dim strApp, strSQL1, strSQL2  As String
    Dim rsApp As rdoResultset
    '--------------------------------- index(0)=RefNo
    If Index = 0 And KeyAscii = 13 Then
        txtExNum(0).SetFocus
    End If
    '----------------------------------
    If Index = 1 And KeyAscii = 13 Then txtfields(30).SetFocus
    If Index = 30 And KeyAscii = 13 Then txtConNum(0).SetFocus
    If Index = 2 And KeyAscii = 13 Then txtfields(27).SetFocus
    
    If Index = 27 And KeyAscii = 13 Then txtfields(14).SetFocus
    If Index = 14 And KeyAscii = 13 Then txtfields(10).SetFocus
    If Index = 10 And KeyAscii = 13 Then Combo8.SetFocus  'txtFields(11).SetFocus
    If Index = 8 And KeyAscii = 13 Then txtfields(6).SetFocus
    If Index = 6 And KeyAscii = 13 Then txtfields(4).SetFocus
    If Index = 4 And KeyAscii = 13 Then txtfields(12).SetFocus
    If Index = 12 And KeyAscii = 13 Then txtfields(15).SetFocus
    If Index = 15 And KeyAscii = 13 Then txtfields(11).SetFocus
    If Index = 11 And KeyAscii = 13 Then txtfields(18).SetFocus
    If Index = 18 And KeyAscii = 13 Then txtfields(19).SetFocus
    If Index = 19 And KeyAscii = 13 Then txtfields(16).SetFocus
    If Index = 16 And KeyAscii = 13 Then txtfields(5).SetFocus
    If Index = 5 And KeyAscii = 13 Then txtfields(7).SetFocus
    If Index = 7 And KeyAscii = 13 Then txtfields(9).SetFocus
    If Index = 9 And KeyAscii = 13 Then txtfields(17).SetFocus
    '----------------------------------
    If Index = 17 And KeyAscii = 13 Then Combo2.SetFocus  'txtFields(18).SetFocus
    If Index = 13 And KeyAscii = 13 Then txtfields(23).SetFocus
    If Index = 23 And KeyAscii = 13 Then txtfields(24).SetFocus
    If Index = 24 And KeyAscii = 13 Then cmdUpdate.SetFocus
    '----------------------------------
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub
