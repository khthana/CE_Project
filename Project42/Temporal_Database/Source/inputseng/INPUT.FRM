VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Input Data To Tables"
   ClientHeight    =   4860
   ClientLeft      =   1080
   ClientTop       =   2280
   ClientWidth     =   7230
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4860
   ScaleWidth      =   7230
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   3855
      Index           =   2
      Left            =   120
      TabIndex        =   4
      Top             =   960
      Visible         =   0   'False
      Width           =   7095
      Begin VB.Frame Frame2 
         Caption         =   "วันที่"
         Height          =   735
         Left            =   1560
         TabIndex        =   70
         Top             =   3000
         Width           =   3375
         Begin VB.ComboBox Combo1 
            Height          =   315
            Index           =   2
            ItemData        =   "input.frx":0000
            Left            =   2520
            List            =   "input.frx":0061
            Style           =   2  'Dropdown List
            TabIndex        =   73
            Top             =   240
            Width           =   735
         End
         Begin VB.ComboBox Combo1 
            Height          =   315
            Index           =   1
            ItemData        =   "input.frx":011F
            Left            =   1560
            List            =   "input.frx":0144
            Style           =   2  'Dropdown List
            TabIndex        =   72
            Top             =   240
            Width           =   615
         End
         Begin VB.ComboBox Combo1 
            Height          =   315
            Index           =   0
            ItemData        =   "input.frx":016C
            Left            =   360
            List            =   "input.frx":01CD
            Style           =   2  'Dropdown List
            TabIndex        =   71
            Top             =   240
            Width           =   615
         End
         Begin VB.Label Label10 
            Caption         =   "ปี"
            Height          =   255
            Index           =   2
            Left            =   2280
            TabIndex        =   76
            Top             =   360
            Width           =   255
         End
         Begin VB.Label Label10 
            Caption         =   "เดือน"
            Height          =   255
            Index           =   1
            Left            =   1080
            TabIndex        =   75
            Top             =   360
            Width           =   375
         End
         Begin VB.Label Label10 
            Caption         =   "วัน"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   74
            Top             =   360
            Width           =   255
         End
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Index           =   7
         Left            =   360
         TabIndex        =   65
         Top             =   480
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.CommandButton Command5 
         Caption         =   "...."
         Height          =   375
         Left            =   6000
         TabIndex        =   54
         Top             =   2520
         Width           =   375
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Index           =   0
         Left            =   3240
         TabIndex        =   9
         Text            =   "Text3"
         Top             =   360
         Width           =   1455
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Index           =   1
         Left            =   1560
         TabIndex        =   10
         Text            =   "Text3"
         Top             =   1080
         Width           =   1455
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Index           =   2
         Left            =   4920
         TabIndex        =   11
         Text            =   "Text3"
         Top             =   1080
         Width           =   1455
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Index           =   3
         Left            =   1560
         TabIndex        =   12
         Text            =   "Text3"
         Top             =   1800
         Width           =   1455
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Index           =   4
         Left            =   4920
         TabIndex        =   13
         Text            =   "Text3"
         Top             =   1800
         Width           =   1455
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Index           =   5
         Left            =   1560
         TabIndex        =   14
         Text            =   "Text3"
         Top             =   2520
         Width           =   1455
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Index           =   6
         Left            =   4920
         Locked          =   -1  'True
         TabIndex        =   15
         Text            =   "Text3"
         Top             =   2520
         Width           =   975
      End
      Begin VB.Label Label3 
         Caption         =   "Valid  From"
         Height          =   375
         Index           =   7
         Left            =   360
         TabIndex        =   64
         Top             =   3360
         Width           =   1095
      End
      Begin VB.Label Label9 
         Caption         =   "0"
         Height          =   255
         Left            =   6480
         TabIndex        =   60
         Top             =   3600
         Width           =   375
      End
      Begin VB.Label Label8 
         Caption         =   "Record Count = "
         Height          =   255
         Left            =   5160
         TabIndex        =   59
         Top             =   3600
         Width           =   1215
      End
      Begin VB.Label Label3 
         Caption         =   "Type"
         Height          =   375
         Index           =   6
         Left            =   4200
         TabIndex        =   48
         Top             =   2640
         Width           =   1095
      End
      Begin VB.Label Label3 
         Caption         =   "Credit"
         Height          =   375
         Index           =   5
         Left            =   840
         TabIndex        =   47
         Top             =   2640
         Width           =   1095
      End
      Begin VB.Label Label3 
         Caption         =   "Pre subject2"
         Height          =   375
         Index           =   4
         Left            =   3720
         TabIndex        =   46
         Top             =   1920
         Width           =   1095
      End
      Begin VB.Label Label3 
         Caption         =   "Pre subject1"
         Height          =   375
         Index           =   3
         Left            =   480
         TabIndex        =   45
         Top             =   1920
         Width           =   1095
      End
      Begin VB.Label Label3 
         Caption         =   "Thai Name"
         Height          =   375
         Index           =   2
         Left            =   3840
         TabIndex        =   44
         Top             =   1200
         Width           =   1095
      End
      Begin VB.Label Label3 
         Caption         =   "English Name"
         Height          =   375
         Index           =   1
         Left            =   360
         TabIndex        =   43
         Top             =   1200
         Width           =   1095
      End
      Begin VB.Label Label3 
         Caption         =   "Subject ID"
         Height          =   375
         Index           =   0
         Left            =   2280
         TabIndex        =   42
         Top             =   480
         Width           =   1095
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   390
      Index           =   0
      Left            =   120
      TabIndex        =   51
      Top             =   360
      Width           =   6960
      _ExtentX        =   12277
      _ExtentY        =   688
      ButtonWidth     =   609
      ButtonHeight    =   582
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      HotImageList    =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   43
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "insert"
            Object.ToolTipText     =   "Insert Submit"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "save"
            Object.ToolTipText     =   "Save Update data"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "clear"
            Object.ToolTipText     =   "Clear"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "first"
            Object.ToolTipText     =   "Go to first record"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "previous"
            Object.ToolTipText     =   "Go to Previous record"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "next"
            Object.ToolTipText     =   "Go to Next Record"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "last"
            Object.ToolTipText     =   "Go to last record"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "delete"
            Object.ToolTipText     =   "Delete record"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            ImageIndex      =   9
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
         EndProperty
         BeginProperty Button16 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
         EndProperty
         BeginProperty Button17 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button18 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button19 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button20 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button21 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button22 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button23 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button24 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button25 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button26 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button27 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button28 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button29 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button30 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button31 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button32 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button33 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button34 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button35 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button36 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button37 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button38 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button39 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button40 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button41 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button42 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button43 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "exit"
            ImageIndex      =   10
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3480
      Top             =   1320
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   10
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":0244
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":0696
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":0AE8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":0F3A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":138C
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":17DE
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":1C30
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":2082
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":24D4
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "input.frx":2926
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   2415
      Index           =   6
      Left            =   3960
      TabIndex        =   8
      Top             =   2040
      Visible         =   0   'False
      Width           =   3135
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   2415
      Index           =   5
      Left            =   4080
      TabIndex        =   7
      Top             =   1680
      Visible         =   0   'False
      Width           =   3135
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   2415
      Index           =   4
      Left            =   4320
      TabIndex        =   6
      Top             =   1800
      Visible         =   0   'False
      Width           =   3135
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   375
      Left            =   4320
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   360
      Visible         =   0   'False
      Width           =   2655
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   5055
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7215
      _ExtentX        =   12726
      _ExtentY        =   8916
      _Version        =   393216
   End
   Begin RichTextLib.RichTextBox texts1 
      Height          =   615
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   1085
      _Version        =   393217
      TextRTF         =   $"input.frx":2D78
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   2415
      Index           =   3
      Left            =   3960
      TabIndex        =   5
      Top             =   2040
      Visible         =   0   'False
      Width           =   3135
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   3855
      Index           =   1
      Left            =   120
      TabIndex        =   3
      Top             =   960
      Visible         =   0   'False
      Width           =   6975
      Begin RichTextLib.RichTextBox TextBox1 
         Height          =   375
         Left            =   5160
         TabIndex        =   91
         Top             =   360
         Visible         =   0   'False
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   661
         _Version        =   393217
         TextRTF         =   $"input.frx":2EC3
      End
      Begin VB.Frame Frame3 
         Caption         =   "วันที่"
         Height          =   735
         Left            =   1680
         TabIndex        =   77
         Top             =   3000
         Width           =   3375
         Begin VB.ComboBox Combo2 
            Height          =   315
            Index           =   2
            ItemData        =   "input.frx":3002
            Left            =   2520
            List            =   "input.frx":3060
            Style           =   2  'Dropdown List
            TabIndex        =   80
            Top             =   240
            Width           =   735
         End
         Begin VB.ComboBox Combo2 
            Height          =   315
            Index           =   1
            ItemData        =   "input.frx":3118
            Left            =   1560
            List            =   "input.frx":3140
            Style           =   2  'Dropdown List
            TabIndex        =   79
            Top             =   240
            Width           =   615
         End
         Begin VB.ComboBox Combo2 
            Height          =   315
            Index           =   0
            ItemData        =   "input.frx":316B
            Left            =   360
            List            =   "input.frx":31CC
            Style           =   2  'Dropdown List
            TabIndex        =   78
            Top             =   240
            Width           =   615
         End
         Begin VB.Label Label11 
            Caption         =   "ปี"
            Height          =   255
            Index           =   2
            Left            =   2280
            TabIndex        =   83
            Top             =   360
            Width           =   375
         End
         Begin VB.Label Label11 
            Caption         =   "เดือน"
            Height          =   255
            Index           =   1
            Left            =   1080
            TabIndex        =   82
            Top             =   360
            Width           =   375
         End
         Begin VB.Label Label11 
            Caption         =   "วัน"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   81
            Top             =   360
            Width           =   375
         End
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Index           =   7
         Left            =   240
         TabIndex        =   67
         Top             =   360
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.CommandButton Command4 
         Caption         =   "...."
         Height          =   375
         Left            =   6120
         TabIndex        =   53
         Top             =   2520
         Width           =   375
      End
      Begin VB.CommandButton Command3 
         Caption         =   "...."
         Height          =   375
         Left            =   2880
         TabIndex        =   52
         Top             =   2520
         Width           =   375
      End
      Begin VB.CommandButton Command2 
         Caption         =   "...."
         Height          =   375
         Left            =   6120
         TabIndex        =   50
         Top             =   1080
         Width           =   375
      End
      Begin VB.CommandButton Command1 
         Caption         =   "...."
         Height          =   375
         Left            =   2880
         TabIndex        =   49
         Top             =   1080
         Width           =   375
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Index           =   6
         Left            =   5040
         Locked          =   -1  'True
         TabIndex        =   28
         Text            =   "Text1"
         Top             =   2520
         Width           =   975
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Index           =   5
         Left            =   1800
         Locked          =   -1  'True
         TabIndex        =   27
         Text            =   "Text1"
         Top             =   2520
         Width           =   975
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Index           =   4
         Left            =   5040
         TabIndex        =   26
         Text            =   "Text1"
         Top             =   1800
         Width           =   1455
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Index           =   3
         Left            =   1800
         TabIndex        =   25
         Text            =   "Text1"
         Top             =   1800
         Width           =   1455
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Index           =   2
         Left            =   5040
         TabIndex        =   24
         Text            =   "Text1"
         Top             =   1080
         Width           =   975
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Index           =   1
         Left            =   1800
         TabIndex        =   23
         Text            =   "Text1"
         Top             =   1080
         Width           =   975
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Index           =   0
         Left            =   3120
         TabIndex        =   22
         Text            =   "Text1"
         Top             =   360
         Width           =   1455
      End
      Begin VB.Label Label1 
         Caption         =   "Valid  Form"
         Height          =   375
         Index           =   7
         Left            =   600
         TabIndex        =   66
         Top             =   3360
         Width           =   1215
      End
      Begin VB.Label Label7 
         Caption         =   "0"
         Height          =   255
         Left            =   6480
         TabIndex        =   58
         Top             =   3600
         Width           =   375
      End
      Begin VB.Label Label6 
         Caption         =   "Record Count ="
         Height          =   255
         Left            =   5160
         TabIndex        =   57
         Top             =   3600
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Student  ID"
         Height          =   375
         Index           =   0
         Left            =   2040
         TabIndex        =   35
         Top             =   480
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Pre Name (Thai)"
         Height          =   375
         Index           =   1
         Left            =   480
         TabIndex        =   34
         Top             =   1200
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Name (Thai)"
         Height          =   375
         Index           =   2
         Left            =   720
         TabIndex        =   33
         Top             =   1920
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Pre  Name (English)"
         Height          =   375
         Index           =   3
         Left            =   3480
         TabIndex        =   32
         Top             =   1200
         Width           =   1575
      End
      Begin VB.Label Label1 
         Caption         =   "Name (English)"
         Height          =   375
         Index           =   4
         Left            =   3720
         TabIndex        =   31
         Top             =   1920
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Degree"
         Height          =   375
         Index           =   5
         Left            =   1080
         TabIndex        =   30
         Top             =   2640
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Study  Type"
         Height          =   375
         Index           =   6
         Left            =   3960
         TabIndex        =   29
         Top             =   2640
         Width           =   1215
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   5415
      Index           =   0
      Left            =   120
      TabIndex        =   2
      Top             =   960
      Visible         =   0   'False
      Width           =   6975
      Begin VB.Frame Frame4 
         Caption         =   "วันที่"
         Height          =   735
         Left            =   1560
         TabIndex        =   84
         Top             =   2880
         Width           =   3375
         Begin VB.ComboBox Combo3 
            Height          =   315
            Index           =   2
            ItemData        =   "input.frx":3243
            Left            =   2520
            List            =   "input.frx":32A4
            Style           =   2  'Dropdown List
            TabIndex        =   87
            Top             =   240
            Width           =   735
         End
         Begin VB.ComboBox Combo3 
            Height          =   315
            Index           =   1
            ItemData        =   "input.frx":3362
            Left            =   1560
            List            =   "input.frx":338A
            Style           =   2  'Dropdown List
            TabIndex        =   86
            Top             =   240
            Width           =   615
         End
         Begin VB.ComboBox Combo3 
            Height          =   315
            Index           =   0
            ItemData        =   "input.frx":33B5
            Left            =   360
            List            =   "input.frx":3416
            Style           =   2  'Dropdown List
            TabIndex        =   85
            Top             =   240
            Width           =   615
         End
         Begin VB.Label Label12 
            Caption         =   "ปี"
            Height          =   255
            Index           =   2
            Left            =   2280
            TabIndex        =   90
            Top             =   360
            Width           =   375
         End
         Begin VB.Label Label12 
            Caption         =   "เดือน"
            Height          =   255
            Index           =   1
            Left            =   1080
            TabIndex        =   89
            Top             =   360
            Width           =   375
         End
         Begin VB.Label Label12 
            Caption         =   "วัน"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   88
            Top             =   360
            Width           =   375
         End
      End
      Begin VB.TextBox Text2 
         Height          =   375
         Index           =   6
         Left            =   3000
         TabIndex        =   69
         Top             =   120
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.CommandButton Command8 
         Caption         =   "..."
         Height          =   375
         Left            =   5880
         TabIndex        =   63
         Top             =   600
         Width           =   375
      End
      Begin VB.CommandButton Command7 
         Caption         =   "..."
         Height          =   375
         Left            =   2640
         TabIndex        =   62
         Top             =   600
         Width           =   375
      End
      Begin VB.CommandButton Command6 
         Caption         =   "..."
         Height          =   375
         Left            =   2640
         TabIndex        =   61
         Top             =   2280
         Width           =   375
      End
      Begin VB.TextBox Text2 
         Height          =   375
         Index           =   5
         Left            =   4800
         TabIndex        =   21
         Text            =   "Text2"
         Top             =   2280
         Width           =   1455
      End
      Begin VB.TextBox Text2 
         Height          =   375
         Index           =   4
         Left            =   1560
         Locked          =   -1  'True
         TabIndex        =   20
         Text            =   "Text2"
         Top             =   2280
         Width           =   975
      End
      Begin VB.TextBox Text2 
         Height          =   375
         Index           =   3
         Left            =   4800
         TabIndex        =   19
         Text            =   "Text2"
         Top             =   1440
         Width           =   1455
      End
      Begin VB.TextBox Text2 
         Height          =   375
         Index           =   2
         Left            =   1560
         TabIndex        =   18
         Text            =   "Text2"
         Top             =   1440
         Width           =   1455
      End
      Begin VB.TextBox Text2 
         Height          =   375
         Index           =   1
         Left            =   4800
         Locked          =   -1  'True
         TabIndex        =   17
         Text            =   "Text2"
         Top             =   600
         Width           =   975
      End
      Begin VB.TextBox Text2 
         Height          =   375
         Index           =   0
         Left            =   1560
         Locked          =   -1  'True
         TabIndex        =   16
         Text            =   "Text2"
         Top             =   600
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "Valid  From"
         Height          =   375
         Index           =   6
         Left            =   480
         TabIndex        =   68
         Top             =   3240
         Width           =   1215
      End
      Begin VB.Label Label4 
         Caption         =   "Record Count = "
         Height          =   255
         Left            =   5160
         TabIndex        =   56
         Top             =   3600
         Width           =   1215
      End
      Begin VB.Label Label5 
         Caption         =   "0"
         Height          =   255
         Left            =   6480
         TabIndex        =   55
         Top             =   3600
         Width           =   495
      End
      Begin VB.Label Label2 
         Caption         =   "Section"
         Height          =   375
         Index           =   5
         Left            =   3960
         TabIndex        =   41
         Top             =   2400
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Grade"
         Height          =   375
         Index           =   4
         Left            =   840
         TabIndex        =   40
         Top             =   2400
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Term"
         Height          =   375
         Index           =   3
         Left            =   4080
         TabIndex        =   39
         Top             =   1560
         Width           =   1095
      End
      Begin VB.Label Label2 
         Caption         =   "Year"
         Height          =   375
         Index           =   2
         Left            =   960
         TabIndex        =   38
         Top             =   1560
         Width           =   855
      End
      Begin VB.Label Label2 
         Caption         =   "Subject ID"
         Height          =   375
         Index           =   1
         Left            =   3840
         TabIndex        =   37
         Top             =   720
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Student  ID"
         Height          =   375
         Index           =   0
         Left            =   600
         TabIndex        =   36
         Top             =   720
         Width           =   1215
      End
   End
   Begin VB.Menu mnufile 
      Caption         =   "&Flie"
      Index           =   1
      Begin VB.Menu mnuexit 
         Caption         =   "&Exit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu mnumove 
      Caption         =   "&Move"
      Begin VB.Menu mnufirst 
         Caption         =   "First Record..."
         Shortcut        =   {F6}
      End
      Begin VB.Menu mnuprevious 
         Caption         =   "Previous Record..."
         Shortcut        =   {F7}
      End
      Begin VB.Menu mnunext 
         Caption         =   "Next Record..."
         Shortcut        =   {F8}
      End
      Begin VB.Menu mnulast 
         Caption         =   " Last Record..."
         Shortcut        =   {F9}
      End
   End
   Begin VB.Menu mnudata 
      Caption         =   "&Data"
      Begin VB.Menu delregis 
         Caption         =   "Delete All in registeration "
      End
      Begin VB.Menu delstd 
         Caption         =   "Delete All in Student"
      End
      Begin VB.Menu delsub 
         Caption         =   "Delete All in Subject"
      End
   End
   Begin VB.Menu mnuhelp 
      Caption         =   "&Help"
      Begin VB.Menu mmuhelp 
         Caption         =   "Help..."
         Shortcut        =   {F1}
      End
      Begin VB.Menu mnusep 
         Caption         =   "-"
      End
      Begin VB.Menu mnuabout 
         Caption         =   "&About"
         Shortcut        =   ^A
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public ii As Integer
Public counts As Integer
Dim databas As Database
Dim work As Workspace
Public record_regis As Recordset
Public record_std As Recordset
Public record_sub As Recordset
Public record_regisTT As Recordset
Public record_stdTT As Recordset
Public record_subTT As Recordset
Dim sql1 As String
Dim str(3) As String
Public i1, j1, k1, con As Integer
Dim chksave As Boolean

Private Sub Command1_Click()
    Form2.Show
    Form2.Frame1.ZOrder 0
    Form2.Caption = "Pre name (Thai)"
    Form1.Enabled = False
End Sub

Private Sub Command2_Click()
    Form2.Frame2.ZOrder 0
    Form2.Show
    Form2.Caption = "Pre name (English)"
    Form1.Enabled = False
End Sub

Private Sub Command3_Click()
    Form2.Frame3.ZOrder 0
    Form2.Show
    Form2.Caption = "Select Degree"
    Form2.Frame3.Caption = "Degree"
    Form1.Enabled = False
End Sub

Private Sub Command4_Click()
    Form2.Frame4.ZOrder 0
    Form2.Option1.Value = True
    Form2.Show
    Form2.Caption = "Select Study type"
    Form2.Frame4.Caption = "Study type"
    Form1.Enabled = False
End Sub

Private Sub Command5_Click()
    Form2.Frame5.ZOrder 0
    Form2.Show
    Form2.Caption = "Select Subject type"
    Form2.Frame5.Caption = "Subject type"
    Form1.Enabled = False
End Sub

Private Sub Command6_Click()
    Form2.Frame6.ZOrder 0
    Form2.Show
    Form2.Caption = "Select Grade"
    Form2.Frame6.Caption = "Grade"
    Form1.Enabled = False
End Sub

Private Sub Command7_Click()
Dim aa, i, j As Integer
    If record_std.RecordCount <> 0 Then
    Form3.List1.Clear
    record_std.MoveLast
    aa = record_std.RecordCount
    record_std.MoveFirst
    
    For i = 0 To aa - 1
        If j = 0 Then
            record_std.MoveFirst
            j = 1
        Else: record_std.MoveNext
        End If
        Form3.List1.AddItem record_std.Fields("stdid").Value
    Next i
    Form3.List1.Selected(0) = True
    record_std.MoveFirst
    Form1.Enabled = False
    With Form3
        .Caption = "รหัสนักศึกษา"
        .Frame1.ZOrder 0
        .Text1.Text = record_std.Fields("tname").Value
        .Visible = True
        .Show
    End With
    Else
         MsgBox "Student has no data please insert student before", vbOKOnly + vbExclamation, "Data Empty"
    End If
End Sub


Private Sub Command8_Click()
Dim aa, i, j As Integer
    If record_sub.RecordCount <> 0 Then
    Form3.List2.Clear
    record_sub.MoveLast
    aa = record_sub.RecordCount
    record_sub.MoveFirst
    
    For i = 0 To aa - 1
        If j = 0 Then
            record_sub.MoveFirst
            j = 1
        Else: record_sub.MoveNext
        End If
        Form3.List2.AddItem record_sub.Fields("subid").Value
    Next i
    Form3.List2.Selected(0) = True
    record_sub.MoveFirst
    Form1.Enabled = False
    With Form3
        .Caption = "รหัสวิชา"
        .Frame2.ZOrder 0
        .Text2.Text = record_sub.Fields("tname").Value
        .Visible = True
        .Show
    End With
    Else
        MsgBox "Subject has no data please insert subject before", vbOKOnly + vbExclamation, "Data Empty"
    End If
End Sub
Public Sub regisTimeEn_true()
    Label2(6).Enabled = True
    Frame4.Enabled = True
    Combo3(0).Enabled = True
    Combo3(1).Enabled = True
    Combo3(2).Enabled = True
    Label12(0).Enabled = True
    Label12(1).Enabled = True
    Label12(2).Enabled = True
End Sub
Public Sub regisTimeEn_false()
    Label2(6).Enabled = False
    Frame4.Enabled = False
    Combo3(0).Enabled = False
    Combo3(1).Enabled = False
    Combo3(2).Enabled = False
    Label12(0).Enabled = False
    Label12(1).Enabled = False
    Label12(2).Enabled = False
End Sub
Public Sub stdTimeEn_true()
    Label1(7).Enabled = True
    Frame3.Enabled = True
    Combo2(0).Enabled = True
    Combo2(1).Enabled = True
    Combo2(2).Enabled = True
    Label11(0).Enabled = True
    Label11(1).Enabled = True
    Label11(2).Enabled = True
End Sub
Public Sub stdTimeEn_false()
    Label1(7).Enabled = False
    Frame3.Enabled = False
    Combo2(0).Enabled = False
    Combo2(1).Enabled = False
    Combo2(2).Enabled = False
    Label11(0).Enabled = False
    Label11(1).Enabled = False
    Label11(2).Enabled = False
End Sub
Public Sub subTimeEn_true()
    Label3(7).Enabled = True
    Frame2.Enabled = True
    Combo1(0).Enabled = True
    Combo1(1).Enabled = True
    Combo1(2).Enabled = True
    Label10(0).Enabled = True
    Label10(1).Enabled = True
    Label10(2).Enabled = True
End Sub
Public Sub subTimeEn_false()
    Label3(7).Enabled = False
    Frame2.Enabled = False
    Combo1(0).Enabled = False
    Combo1(1).Enabled = False
    Combo1(2).Enabled = False
    Label10(0).Enabled = False
    Label10(1).Enabled = False
    Label10(2).Enabled = False
End Sub

Private Sub delregis_Click()
Dim msg As String
Dim aa1, aa2, i As Integer
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        record_regis.MoveLast
        aa1 = record_regis.RecordCount
        record_regisTT.MoveLast
        aa2 = record_regisTT.RecordCount
        msg = MsgBox("Are you sure to delete all data in registeration", vbOKCancel + vbExclamation, "Confirm Delete All Data")
        If msg = vbOK Then
            For i = 1 To aa1
                record_regis.Delete
                If i <> aa1 Then
                    record_regis.MovePrevious
                End If
            Next i
            For i = 1 To aa2
                record_regisTT.Delete
                If i <> aa2 Then
                    record_regisTT.MovePrevious
                End If
            Next i
        
            Label5.Caption = 0
            clear_click
            i1 = 0
            MsgBox "Table registeration have no data insert it now", vbOKOnly + vbExclamation, "No data"
            insert_click
        Else:
        End If
    End If
End Sub

Private Sub delstd_Click()
Dim msg As String
Dim aa1, aa2, i As Integer
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        record_std.MoveLast
        aa1 = record_std.RecordCount
        record_stdTT.MoveLast
        aa2 = record_stdTT.RecordCount
        msg = MsgBox("Are you sure to delete all data in student", vbOKCancel + vbExclamation, "Confirm Delete All Data")
        If msg = vbOK Then
            For i = 1 To aa1
                record_std.Delete
                If i <> aa1 Then
                    record_std.MovePrevious
                End If
            Next i
            For i = 1 To aa2
                record_stdTT.Delete
                If i <> aa2 Then
                    record_stdTT.MovePrevious
                End If
            Next i
        
            Label7.Caption = 0
            clear_click
            j1 = 0
            MsgBox "Table student have no data insert it now", vbOKOnly + vbExclamation, "No data"
            insert_click
        Else:
        End If
    End If
End Sub

Private Sub delsub_Click()
Dim msg As String
Dim aa1, aa2, i As Integer
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        record_sub.MoveLast
        aa1 = record_sub.RecordCount
        record_subTT.MoveLast
        aa2 = record_subTT.RecordCount
        msg = MsgBox("Are you sure to delete all data in subject", vbOKCancel + vbExclamation, "Confirm Delete All Data")
        If msg = vbOK Then
            For i = 1 To aa1
                record_sub.Delete
                If i <> aa1 Then
                    record_sub.MovePrevious
                End If
            Next i
            For i = 1 To aa2
                record_subTT.Delete
                If i <> aa2 Then
                    record_subTT.MovePrevious
                End If
            Next i
        
            Label9.Caption = 0
            clear_click
            k1 = 0
            MsgBox "Table subject have no data insert it now", vbOKOnly + vbExclamation, "No data"
            insert_click
        Else:
        End If
    End If
End Sub

Private Sub Form_Activate()
Dim j As Integer
Dim k, l, m, kk, che As Integer
   If con = 0 Then
   For j = 0 To Data1.Database.TableDefs.Count - 1
    If (Data1.Database.TableDefs(j).Attributes And _
       (dbSystemObject + dbHiddenObject)) = 0 Then
        texts1.Text = Data1.Database.TableDefs(j).Name
        If che = 0 Then
            texts1.Text = texts1.Text + "*"
            k = texts1.Find(".")
            texts1.SelStart = k + 1
            texts1.SelLength = 30
            texts1.Text = texts1.SelText
            kk = texts1.Find("*")
            texts1.SelStart = 0
            texts1.SelLength = kk
            TabStrip1.Tabs.Add ii, , texts1.SelText
            str(m) = texts1.SelText
            m = m + 1
            l = ii - 1
            With Frame1(l)
                .Caption = "<Table> " + texts1.SelText
                .FontBold = True
                .Height = Form1.Height - 1450
                .Width = Form1.Width - 190
                .Left = 30
                .Top = 800
                .Visible = True
            End With
            ii = ii + 1
            che = 1
        Else: che = 0
        End If
        
    End If
        Next j
       con = 1
    If (record_regis.RecordCount <> 0) Then
        record_regis.MoveLast
        Label5.Caption = record_regis.RecordCount
        record_regis.MoveFirst
    End If
    If (record_std.RecordCount <> 0) Then
        record_std.MoveLast
        Label7.Caption = record_std.RecordCount
        record_std.MoveFirst
    End If
    If (record_sub.RecordCount <> 0) Then
        record_sub.MoveLast
        Label9.Caption = record_sub.RecordCount
        record_sub.MoveFirst
    End If
    If (TabStrip1.SelectedItem.Index - 1 = 0) And (record_regis.RecordCount = 0) Then
        MsgBox "Table registeration have no data insert it now", vbOKOnly + vbExclamation, "No data"
        insert_click
    End If
    Call fillvalue
    End If
    Unload frmSplash
    frmSplash.Hide
End Sub

Private Sub Form_Load()
Dim str As String
Dim year As Integer
    regisTimeEn_false
    stdTimeEn_false
    subTimeEn_false
    delregis.Enabled = True
    delstd.Enabled = False
    delsub.Enabled = False
    
    Combo1(2).Clear
    str = Format(Date, "yyyy")
    year = str
    For i = year - 15 To year + 15
        Combo1(2).AddItem i
        Combo2(2).AddItem i
        Combo3(2).AddItem i
    Next i

    Set work = DBEngine.Workspaces(0)
    Set databas = work.OpenDatabase("", False, False, _
    "ODBC;DSN=student_data;DATABASE=student_data;UID=informix;PWD=informix;")
    
    Set record_regis = databas.OpenRecordset("registeration", dbOpenDynaset)
    Set record_std = databas.OpenRecordset("student", dbOpenDynaset)
    Set record_sub = databas.OpenRecordset("subject", dbOpenDynaset)
 
    Set record_regisTT = databas.OpenRecordset("registeration_TT", dbOpenDynaset)
    Set record_stdTT = databas.OpenRecordset("student_TT", dbOpenDynaset)
    Set record_subTT = databas.OpenRecordset("subject_TT", dbOpenDynaset)
   
    Frame1(0).ZOrder 0
    Data1.Connect = "ODBC;DSN=student_data;"
   ii = 1
End Sub

Public Sub Save_link()
Dim chkcombo As Integer
    'format time in informix is month/date/year

    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        record_regis.Fields("stdid").Value = Text2(0).Text
        record_regis.Fields("subid").Value = Text2(1).Text
        record_regis.Fields("yr").Value = Text2(2).Text
        record_regis.Fields("term").Value = Text2(3).Text
        record_regis.Fields("grade").Value = Text2(4).Text
        record_regis.Fields("section").Value = Text2(5).Text
        record_regis.Update
        
        'input to regisTT
        record_std.MoveFirst
        record_std.Move Form3.a1                'a1 is index of student
        record_regisTT.Fields("std_int").Value = record_std.Fields("std_serial").Value
        
        record_sub.MoveFirst
        record_sub.Move Form3.a2                'a2 is index of subject
        record_regisTT.Fields("sub_int").Value = record_sub.Fields("sub_serial").Value
        
        record_regisTT.Fields("yr").Value = Text2(2).Text
        record_regisTT.Fields("term").Value = Text2(3).Text
        record_regisTT.Fields("grade").Value = Text2(4).Text
        record_regisTT.Fields("section").Value = Text2(5).Text
        
        '-----------------------------------------------------
        chkcombo = Combo3(1).ListIndex
        Text2(6).Text = Combo3(1).List(chkcombo)
        Text2(6).Text = Text2(6).Text + "/"
        chkcombo = Combo3(0).ListIndex
        Text2(6).Text = Text2(6).Text + Combo3(0).List(chkcombo)
        Text2(6).Text = Text2(6).Text + "/"
        chkcombo = Combo3(2).ListIndex
        Text2(6).Text = Text2(6).Text + Combo3(2).List(chkcombo)
        '-----------------------------------------------------
        record_regisTT.Fields("Valid_from").Value = Text2(6).Text
        record_regisTT.Fields("Valid_to").Value = "12/31/9999"
        record_regisTT.Fields("TxStart").Value = Format(Date, "mm/dd/yyyy")
        record_regisTT.Fields("TxStop").Value = "12/31/9999"
        
        record_regis.MoveLast
        record_regisTT.Fields("regis_int").Value = record_regis.Fields("regis_serial").Value
        
        record_regisTT.Update
        
    End If
            
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        record_std.Fields("stdid").Value = Text1(0).Text
        record_std.Fields("tpren").Value = Text1(1).Text
        record_std.Fields("epren").Value = Text1(2).Text
        record_std.Fields("tname").Value = Text1(3).Text
        record_std.Fields("ename").Value = Text1(4).Text
        record_std.Fields("degree").Value = Text1(5).Text
        If Form2.Option1.Value = True Then
        record_std.Fields("stdtype").Value = "A"
        ElseIf Form2.Option2.Value = True Then
            record_std.Fields("stdtype").Value = "B"
        End If
        
        record_stdTT.Fields("stdid").Value = Text1(0).Text
        record_stdTT.Fields("tpren").Value = Text1(1).Text
        record_stdTT.Fields("epren").Value = Text1(2).Text
        record_stdTT.Fields("tname").Value = Text1(3).Text
        record_stdTT.Fields("ename").Value = Text1(4).Text
        record_stdTT.Fields("degree").Value = Text1(5).Text
        If Form2.Option1.Value = True Then
        record_stdTT.Fields("stdtype").Value = "A"
        ElseIf Form2.Option2.Value = True Then
            record_stdTT.Fields("stdtype").Value = "B"
        End If
        
        '--------------------------------
        chkcombo = Combo2(1).ListIndex
        Text1(7).Text = Combo2(1).List(chkcombo)
        Text1(7).Text = Text1(7).Text + "/"
        chkcombo = Combo2(0).ListIndex
        Text1(7).Text = Text1(7).Text + Combo2(0).List(chkcombo)
        Text1(7).Text = Text1(7).Text + "/"
        chkcombo = Combo2(2).ListIndex
        Text1(7).Text = Text1(7).Text + Combo2(2).List(chkcombo)
        '--------------------------------
        record_stdTT.Fields("valid_from").Value = Text1(7).Text
        record_stdTT.Fields("valid_to").Value = "12/31/9999"
        record_stdTT.Fields("TxStart").Value = Format(Date, "mm/dd/yyyy")
        record_stdTT.Fields("TxStop").Value = "12/31/9999"
            
        record_std.Update
        record_std.MoveLast
        record_stdTT.Fields("std_int").Value = record_std.Fields("std_serial").Value
        record_stdTT.Update
    End If
        
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        record_sub.Fields("subid").Value = Text3(0).Text
        record_sub.Fields("ename").Value = Text3(1).Text
        record_sub.Fields("tname").Value = Text3(2).Text
        record_sub.Fields("presub1").Value = Text3(3).Text
        record_sub.Fields("presub2").Value = Text3(4).Text
        record_sub.Fields("credit").Value = Text3(5).Text
        record_sub.Fields("type").Value = Text3(6).Text
        
        record_subTT.Fields("subid").Value = Text3(0).Text
        record_subTT.Fields("ename").Value = Text3(1).Text
        record_subTT.Fields("tname").Value = Text3(2).Text
        record_subTT.Fields("presub1").Value = Text3(3).Text
        record_subTT.Fields("presub2").Value = Text3(4).Text
        record_subTT.Fields("credit").Value = Text3(5).Text
        record_subTT.Fields("type").Value = Text3(6).Text
        
        '----------------------------------------------------
        chkcombo = Combo1(1).ListIndex
        Text3(7).Text = Combo1(1).List(chkcombo)
        Text3(7).Text = Text3(7).Text + "/"
        chkcombo = Combo1(0).ListIndex
        Text3(7).Text = Text3(7).Text + Combo1(0).List(chkcombo)
        Text3(7).Text = Text3(7).Text + "/"
        chkcombo = Combo1(2).ListIndex
        Text3(7).Text = Text3(7).Text + Combo1(2).List(chkcombo)
        '-----------------------------------------------------
        
        record_subTT.Fields("valid_from").Value = Text3(7).Text
        record_subTT.Fields("valid_to").Value = "12/31/9999"
        record_subTT.Fields("TxStart").Value = Format(Date, "mm/dd/yyyy")
        record_subTT.Fields("TxStop").Value = "12/31/9999"
            
        record_sub.Update
        record_sub.MoveLast
        record_subTT.Fields("sub_int").Value = record_sub.Fields("sub_serial").Value
        record_subTT.Update
        
    End If
End Sub
Private Sub Save_change()
Dim i1, i2, aaa1, aaa2, aa1, aa2, i, j As Integer
Dim str As String
Dim stdtext, subtext As String
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        record_regis.Fields("stdid").Value = Text2(0).Text
        record_regis.Fields("subid").Value = Text2(1).Text
        record_regis.Fields("yr").Value = Text2(2).Text
        record_regis.Fields("term").Value = Text2(3).Text
        record_regis.Fields("grade").Value = Text2(4).Text
        record_regis.Fields("section").Value = Text2(5).Text
        record_regis.Update
        
        '----------------------------------------------------
        chkcombo = Combo3(1).ListIndex
        Text2(6).Text = Combo3(1).List(chkcombo)
        Text2(6).Text = Text2(6).Text + "/"
        chkcombo = Combo3(0).ListIndex
        Text2(6).Text = Text2(6).Text + Combo3(0).List(chkcombo)
        Text2(6).Text = Text2(6).Text + "/"
        chkcombo = Combo3(2).ListIndex
        Text2(6).Text = Text2(6).Text + Combo3(2).List(chkcombo)
        '----------------------------------------------------
        
        record_regisTT.FindLast "regis_int = " & record_regis.Fields("regis_serial").Value
        record_regisTT.Edit
        record_regisTT.Fields("Valid_to").Value = Text2(6).Text
        record_regisTT.Fields("TxStop").Value = Format(Date, "mm/dd/yyyy")
        record_regisTT.Update
        stdtext = record_regisTT.Fields("std_int").Value
        subtext = record_regisTT.Fields("sub_int").Value
        record_regisTT.AddNew
                
        If Form3.chk1 Then
            record_std.MoveFirst
            record_std.Move Form3.a1
            record_regisTT.Fields("std_int").Value = record_std.Fields("std_serial").Value
        Else
            record_regisTT.Fields("std_int").Value = stdtext
        End If
        
        If Form3.chk2 Then
            record_sub.MoveFirst
            record_sub.Move Form3.a2
            record_regisTT.Fields("sub_int").Value = record_sub.Fields("sub_serial").Value
        Else
            record_regisTT.Fields("sub_int").Value = subtext
        End If
        
        record_regisTT.Fields("yr").Value = Text2(2).Text
        record_regisTT.Fields("term").Value = Text2(3).Text
        record_regisTT.Fields("grade").Value = Text2(4).Text
        record_regisTT.Fields("section").Value = Text2(5).Text
        
        record_regisTT.Fields("regis_int").Value = record_regis.Fields("regis_serial").Value
        record_regisTT.Fields("Valid_from").Value = Text2(6).Text
        record_regisTT.Fields("Valid_to").Value = "12/31/9999"
        record_regisTT.Fields("TxStart").Value = Format(Date, "mm/dd/yyyy")
        record_regisTT.Fields("TxStop").Value = "12/31/9999"
        record_regisTT.Update
        
    End If
            
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        record_std.Fields("stdid").Value = Text1(0).Text
        record_std.Fields("tpren").Value = Text1(1).Text
        record_std.Fields("epren").Value = Text1(2).Text
        record_std.Fields("tname").Value = Text1(3).Text
        record_std.Fields("ename").Value = Text1(4).Text
        record_std.Fields("degree").Value = Text1(5).Text
        If Form2.Option1.Value = True Then
        record_std.Fields("stdtype").Value = "A"
        ElseIf Form2.Option2.Value = True Then
            record_std.Fields("stdtype").Value = "B"
        End If
        
        record_std.Update
        
        '--------------------------------
        chkcombo = Combo2(1).ListIndex
        Text1(7).Text = Combo2(1).List(chkcombo)
        Text1(7).Text = Text1(7).Text + "/"
        chkcombo = Combo2(0).ListIndex
        Text1(7).Text = Text1(7).Text + Combo2(0).List(chkcombo)
        Text1(7).Text = Text1(7).Text + "/"
        chkcombo = Combo2(2).ListIndex
        Text1(7).Text = Text1(7).Text + Combo2(2).List(chkcombo)
        '--------------------------------
        
        record_stdTT.FindLast "std_int = " & record_std.Fields("std_serial").Value
        record_stdTT.Edit
        record_stdTT.Fields("Valid_to").Value = Text1(7).Text
        record_stdTT.Fields("TxStop").Value = Format(Date, "mm/dd/yyyy")
        record_stdTT.Update
        
        record_stdTT.AddNew
        record_stdTT.Fields("stdid").Value = Text1(0).Text
        record_stdTT.Fields("tpren").Value = Text1(1).Text
        record_stdTT.Fields("epren").Value = Text1(2).Text
        record_stdTT.Fields("tname").Value = Text1(3).Text
        record_stdTT.Fields("ename").Value = Text1(4).Text
        record_stdTT.Fields("degree").Value = Text1(5).Text
        If Form2.Option1.Value = True Then
        record_stdTT.Fields("stdtype").Value = "A"
        ElseIf Form2.Option2.Value = True Then
            record_stdTT.Fields("stdtype").Value = "B"
        End If
        
        record_stdTT.Fields("valid_from").Value = Text1(7).Text
        record_stdTT.Fields("valid_to").Value = "12/31/9999"
        record_stdTT.Fields("TxStart").Value = Format(Date, "mm/dd/yyyy")
        record_stdTT.Fields("TxStop").Value = "12/31/9999"
            
        record_stdTT.Fields("std_int").Value = record_std.Fields("std_serial").Value
        record_stdTT.Update
    End If
        
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        record_sub.Fields("subid").Value = Text3(0).Text
        record_sub.Fields("ename").Value = Text3(1).Text
        record_sub.Fields("tname").Value = Text3(2).Text
        record_sub.Fields("presub1").Value = Text3(3).Text
        record_sub.Fields("presub2").Value = Text3(4).Text
        record_sub.Fields("credit").Value = Text3(5).Text
        record_sub.Fields("type").Value = Text3(6).Text
        record_sub.Update
        
        '----------------------------------------------------
        chkcombo = Combo1(1).ListIndex
        Text3(7).Text = Combo1(1).List(chkcombo)
        Text3(7).Text = Text3(7).Text + "/"
        chkcombo = Combo1(0).ListIndex
        Text3(7).Text = Text3(7).Text + Combo1(0).List(chkcombo)
        Text3(7).Text = Text3(7).Text + "/"
        chkcombo = Combo1(2).ListIndex
        Text3(7).Text = Text3(7).Text + Combo1(2).List(chkcombo)
        '-----------------------------------------------------
        
        record_subTT.FindLast "sub_int = " & record_sub.Fields("sub_serial").Value
        record_subTT.Edit
        record_subTT.Fields("Valid_to").Value = Text3(7).Text
        record_subTT.Fields("TxStop").Value = Format(Date, "mm/dd/yyyy")
        record_subTT.Update

        record_subTT.AddNew
        record_subTT.Fields("subid").Value = Text3(0).Text
        record_subTT.Fields("ename").Value = Text3(1).Text
        record_subTT.Fields("tname").Value = Text3(2).Text
        record_subTT.Fields("presub1").Value = Text3(3).Text
        record_subTT.Fields("presub2").Value = Text3(4).Text
        record_subTT.Fields("credit").Value = Text3(5).Text
        record_subTT.Fields("type").Value = Text3(6).Text
        record_subTT.Fields("valid_from").Value = Text3(7).Text
        record_subTT.Fields("valid_to").Value = "12/31/9999"
        record_subTT.Fields("TxStart").Value = Format(Date, "dd/mm/yyyy")
        record_subTT.Fields("TxStop").Value = "12/31/9999"
            
        record_subTT.Fields("sub_int").Value = record_sub.Fields("sub_serial").Value
        record_subTT.Update
        
    End If

End Sub

Private Sub Form_Terminate()
    record_regis.Close
    record_std.Close
    record_sub.Close
    record_regisTT.Close
    record_stdTT.Close
    record_subTT.Close
    databas.Close
End Sub

Private Sub Form_Unload(Cancel As Integer)
    End
End Sub

Private Sub mnuabout_Click()
    AboutForm.Visible = True
    AboutForm.Show
End Sub

Private Sub mnuexit_Click()
    End
End Sub

Private Sub mnufirst_Click()
    first_click
End Sub

Private Sub mnulast_Click()
    last_click
End Sub

Private Sub mnunext_Click()
    next_click
End Sub

Private Sub mnuprevious_Click()
    previous_click
End Sub

Private Sub TabStrip1_Click()
    Frame1(TabStrip1.SelectedItem.Index - 1).ZOrder 0
    If (TabStrip1.SelectedItem.Index - 1 = 0) Then
        delregis.Enabled = True
        delstd.Enabled = False
        delsub.Enabled = False
        chksave = False
        If (record_regis.RecordCount = 0) Then
        MsgBox "Table registeration have no data insert it now", vbOKOnly + vbExclamation, "No data"
        i1 = 0
        insert_click
        End If
    End If
    
    If (TabStrip1.SelectedItem.Index - 1 = 1) Then
        delstd.Enabled = True
        delregis.Enabled = False
        delsub.Enabled = False
        chksave = False
        If (record_std.RecordCount = 0) Then
        MsgBox "Table student have no data insert it now", vbOKOnly + vbExclamation, "No data"
        j1 = 0
        insert_click
        End If
    End If
    
    If (TabStrip1.SelectedItem.Index - 1 = 2) Then
        delsub.Enabled = True
        delregis.Enabled = False
        delstd.Enabled = False
        chksave = False
        If (record_sub.RecordCount = 0) Then
        MsgBox "Table subject have no data insert it now", vbOKOnly + vbExclamation, "No data"
        k1 = 0
        insert_click
        End If
    End If
    Call fillvalue
End Sub

Public Sub insert_click()
Dim msg1 As String
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
    If i1 = 0 Then
        regisTimeEn_true
        record_regis.AddNew
        record_regisTT.AddNew
        clear_click
        chksave = True
        i1 = 1
    Else
        If (Text2(0).Text = "") Or (Text2(1).Text = "") Or (Text2(2).Text = "") Or (Text2(3).Text = "") Or (Combo3(0).Text = "") Or (Combo3(1).Text = "") Or (Combo3(2).Text = "") Then
        MsgBox "Student_id, Subject_id, Year and Term is Primary Key can't have null value OR Not Enter Valid from Date", vbOKOnly + vbExclamation, "Input Error"
        Else
            Form1.Enabled = False
            Form5.Option1.Value = True
            Form5.Visible = True
            Form5.Show
            chksave = False
        End If
    End If
    End If
    
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
    If j1 = 0 Then
        stdTimeEn_true
        record_std.AddNew
        record_stdTT.AddNew
        clear_click
        j1 = 1
        chksave = True
    Else
        If (Text1(0).Text = "") Or (Combo2(0).Text = "") Or (Combo2(1).Text = "") Or (Combo2(2).Text = "") Then
        MsgBox "Student_id is Primary Key can't have null value OR Not Enter Valid from Date", vbOKOnly + vbExclamation, "Input Error"
        Else
            Form1.Enabled = False
            Form5.Option1.Value = True
            Form5.Visible = True
            Form5.Show
            chksave = False
        End If
    End If
    End If
    
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
    If k1 = 0 Then
        subTimeEn_true
        record_sub.AddNew
        record_subTT.AddNew
        clear_click
        chksave = True
        k1 = 1
    Else
        If (Text3(0) = "") Or (Combo1(0).Text = "") Or (Combo1(1).Text = "") Or (Combo1(2).Text = "") Then
        MsgBox "Subject_id is Primary Key can't have null value", vbOKOnly + vbExclamation, "Input Error"
        Else
            Form1.Enabled = False
            Form5.Option1.Value = True
            Form5.Visible = True
            Form5.Show
            chksave = False
        End If
    End If
    End If
    Toolbar1(0).Buttons.Item(3).Enabled = False
    'chksave = True
End Sub
Public Sub clear_click()
Dim i As Integer
    
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        For i = 0 To 6
            Text2(i).Text = ""
        Next i
    End If

    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        For i = 0 To 7
            Text1(i).Text = ""
        Next i
    End If

    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        For i = 0 To 7
            Text3(i).Text = ""
        Next i
    End If
End Sub
Private Sub first_click()
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        If record_regis.RecordCount <> 0 Then
        record_regis.MoveFirst
        Text2(6).Enabled = False
        i1 = 0
        Call fillvalue
        Else: MsgBox "No data in registeration Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        If record_std.RecordCount <> 0 Then
        Text1(7).Enabled = False
        record_std.MoveFirst
        j1 = 0
        Call fillvalue
        Else: MsgBox "No data in student Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        If record_sub.RecordCount <> 0 Then
        Text3(7).Enabled = False
        record_sub.MoveFirst
        k1 = 0
        Call fillvalue
        Else: MsgBox "No data in subject Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    chksave = False
End Sub
Private Sub previous_click()
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        If record_regis.RecordCount <> 0 Then
        record_regis.MovePrevious
        If record_regis.BOF Then
            MsgBox "This record is beginning of table", vbOKOnly + vbExclamation
            record_regis.MoveFirst
        End If
        i1 = 0
        Call fillvalue
        Else: MsgBox "No data in registeration Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        If record_std.RecordCount <> 0 Then
        record_std.MovePrevious
        If record_std.BOF Then
            MsgBox "This record is beginning of table", vbOKOnly + vbExclamation
            record_std.MoveFirst
        End If
        j1 = 0
        Call fillvalue
        Else: MsgBox "No data in student Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        If record_sub.RecordCount <> 0 Then
        record_sub.MovePrevious
        If record_sub.BOF Then
            MsgBox "This record is beginning of table", vbOKOnly + vbExclamation
            record_sub.MoveFirst
        End If
        k1 = 0
        Call fillvalue
        Else: MsgBox "No data in subject Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    chksave = False
End Sub
Private Sub next_click()
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        If record_regis.RecordCount <> 0 Then
        record_regis.MoveNext
        If record_regis.EOF Then
            MsgBox "This record is end of table", vbOKOnly + vbExclamation
            record_regis.MoveLast
        End If
        i1 = 0
        Call fillvalue
        Else: MsgBox "No data in registeration Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        If record_std.RecordCount <> 0 Then
        record_std.MoveNext
        If record_std.EOF Then
            MsgBox "This record is end of table", vbOKOnly + vbExclamation
            record_std.MoveLast
        End If
        j1 = 0
        Call fillvalue
        Else: MsgBox "No data in student Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        If record_sub.RecordCount <> 0 Then
        record_sub.MoveNext
        If record_sub.EOF Then
            MsgBox "This record is end of table", vbOKOnly + vbExclamation
            record_sub.MoveLast
        End If
        k1 = 0
        Call fillvalue
        Else: MsgBox "No data in subject Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    chksave = False
End Sub
Private Sub last_click()
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        If record_regis.RecordCount <> 0 Then
        record_regis.MoveLast
        i1 = 0
        Call fillvalue
        Else: MsgBox "No data in registeration Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        If record_std.RecordCount <> 0 Then
        record_std.MoveLast
        j1 = 0
        Call fillvalue
        Else: MsgBox "No data in student Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        If record_sub.RecordCount <> 0 Then
        record_sub.MoveLast
        k1 = 0
        Call fillvalue
        Else: MsgBox "No data in subject Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    chksave = False
End Sub
Private Sub save_click()
Dim msg2 As String
'On Error GoTo err_enter
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        If (Combo3(0).Text = "") Or (Combo3(1).Text = "") Or (Combo3(2).Text = "") Then
            MsgBox "Please enter valid form date", vbOKOnly + vbExclamation, "Please enter"
        Else
        msg2 = MsgBox("Are you sure to save change to data", vbOKCancel + vbQuestion, "Save data")
        If msg2 = vbOK Then
            record_regis.Edit
'            record_regisTT.Edit
            Save_change
            Combo3(0).ListIndex = 0
            Combo3(1).ListIndex = 0
            Combo3(2).ListIndex = 10
            regisTimeEn_false
        End If
        End If
    End If
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        If (Combo2(0).Text = "") Or (Combo2(1).Text = "") Or (Combo2(2).Text = "") Then
            MsgBox "Please enter valid form date", vbOKOnly + vbExclamation, "Please enter"
        Else
        msg2 = MsgBox("Are you sure to save change to data", vbOKCancel + vbQuestion, "Save data")
        If msg2 = vbOK Then
            record_std.Edit
'            record_stdTT.Edit
            Save_change
            Combo2(0).ListIndex = 0
            Combo2(1).ListIndex = 0
            Combo2(2).ListIndex = 10
            stdTimeEn_false
        End If
        End If
    End If
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        If (Combo1(0).Text = "") Or (Combo1(1).Text = "") Or (Combo1(2).Text = "") Then
            MsgBox "Please enter valid form date", vbOKOnly + vbExclamation, "Please enter"
        Else
        msg2 = MsgBox("Are you sure to save change to data", vbOKCancel + vbQuestion, "Save data")
        If msg2 = vbOK Then
            record_sub.Edit
'            record_subTT.Edit
            Save_change
            Combo1(0).ListIndex = 0
            Combo1(1).ListIndex = 0
            Combo1(2).ListIndex = 10
            subTimeEn_false
        End If
        End If
    End If
'err_enter:  MsgBox Err.Description, vbOKOnly + vbExclamation, "Input Error"
End Sub

Private Sub delete_click()
Dim msg2 As String
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        If record_regis.RecordCount <> 0 Then
        Form1.Enabled = False
        Form4.Visible = True
        Form4.Show
        Else: MsgBox "No data in registeration Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If

    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        If record_std.RecordCount <> 0 Then
        Form1.Enabled = False
        Form4.Visible = True
        Form4.Show
        Else: MsgBox "No data in student Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
    
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        If record_sub.RecordCount <> 0 Then
        Form1.Enabled = False
        Form4.Visible = True
        Form4.Show
        Else: MsgBox "No data in subject Please insert before", vbOKOnly + vbExclamation, "Data Empty"
        End If
    End If
End Sub

Private Sub fillvalue()
Dim temp As String
    If (TabStrip1.SelectedItem.Index - 1) = 0 Then
        Text2(0).Text = Format$(record_regis.Fields("stdid").Value)
        Text2(1).Text = Format$(record_regis.Fields("subid").Value)
        Text2(2).Text = Format$(record_regis.Fields("yr").Value)
        Text2(3).Text = Format$(record_regis.Fields("term").Value)
        Text2(4).Text = Format$(record_regis.Fields("grade").Value)
        Text2(5).Text = Format$(record_regis.Fields("section").Value)
        regisTimeEn_false
    End If
    
    If (TabStrip1.SelectedItem.Index - 1) = 1 Then
        Text1(0).Text = Format$(record_std.Fields("stdid").Value)
        Text1(1).Text = Format$(record_std.Fields("tpren").Value)
        Text1(2).Text = Format$(record_std.Fields("epren").Value)
        Text1(3).Text = Format$(record_std.Fields("tname").Value)
        Text1(4).Text = Format$(record_std.Fields("ename").Value)
        Text1(5).Text = Format$(record_std.Fields("degree").Value)
        TextBox1.Text = Format$(record_std.Fields("stdtype").Value)
        If TextBox1.Find("A") <> -1 Then
        Text1(6).Text = Form2.Option1.Caption
        ElseIf TextBox1.Find("B") <> -1 Then
            Text1(6).Text = Form2.Option2.Caption
        End If
        stdTimeEn_false
    End If
    
    If (TabStrip1.SelectedItem.Index - 1) = 2 Then
        Text3(0).Text = Format$(record_sub.Fields("subid").Value)
        Text3(1).Text = Format$(record_sub.Fields("ename").Value)
        Text3(2).Text = Format$(record_sub.Fields("tname").Value)
        Text3(3).Text = Format$(record_sub.Fields("presub1").Value)
        Text3(4).Text = Format$(record_sub.Fields("presub2").Value)
        Text3(5).Text = Format$(record_sub.Fields("credit").Value)
        Text3(6).Text = Format$(record_sub.Fields("type").Value)
        subTimeEn_false
    End If
    Toolbar1(0).Buttons.Item(3).Enabled = False
End Sub

Private Sub Text1_Change(Index As Integer)
    stdTimeEn_true
    If chksave = False Then
        Toolbar1(0).Buttons.Item(3).Enabled = True
    End If
End Sub
Private Sub Text2_Change(Index As Integer)
    regisTimeEn_true
    If chksave = False Then
        Toolbar1(0).Buttons.Item(3).Enabled = True
    End If
End Sub

Private Sub Text3_Change(Index As Integer)
    subTimeEn_true
    If chksave = False Then
        Toolbar1(0).Buttons.Item(3).Enabled = True
    End If
End Sub

Private Sub Toolbar1_ButtonClick(Index As Integer, ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
    Case "insert"
            insert_click
    Case "clear"
            clear_click
    Case "first"
            first_click
    Case "previous"
            previous_click
    Case "next"
            next_click
    Case "last"
            last_click
    Case "save"
            save_click
    Case "delete"
            delete_click
    Case "exit"
            Form_Terminate
            End
   End Select
End Sub
