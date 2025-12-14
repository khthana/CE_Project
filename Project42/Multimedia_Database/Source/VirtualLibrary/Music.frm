VERSION 5.00
Object = "{00028C51-0000-0000-0000-000000000046}#1.0#0"; "TDBGS32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "Comctl32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Music 
   Caption         =   "For Administrator control Music"
   ClientHeight    =   7365
   ClientLeft      =   225
   ClientTop       =   1110
   ClientWidth     =   11445
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7365
   ScaleWidth      =   11445
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Close"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   5340
      Style           =   1  'Graphical
      TabIndex        =   77
      Top             =   6840
      Width           =   915
   End
   Begin VB.Frame Frame1 
      Caption         =   "UPDATE"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   6075
      Index           =   1
      Left            =   180
      TabIndex        =   2
      Top             =   480
      Width           =   10995
      Begin VB.Frame Frame4 
         Caption         =   "รายละเอียดของเพลง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   4155
         Left            =   240
         TabIndex        =   57
         Top             =   240
         Width           =   10575
         Begin VB.TextBox Text3 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   5
            Left            =   1740
            TabIndex        =   76
            Top             =   2820
            Width           =   3315
         End
         Begin VB.TextBox Text3 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   4
            Left            =   1740
            TabIndex        =   75
            Top             =   2220
            Width           =   3315
         End
         Begin VB.TextBox Text3 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   3
            Left            =   7140
            TabIndex        =   74
            Top             =   1620
            Width           =   2655
         End
         Begin VB.CheckBox Check1 
            Caption         =   "รหัสเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   0
            Left            =   5880
            TabIndex        =   73
            Top             =   1080
            Width           =   1155
         End
         Begin VB.TextBox Text3 
            BackColor       =   &H00C0FFFF&
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   315
            Index           =   0
            Left            =   1260
            TabIndex        =   72
            Top             =   480
            Width           =   915
         End
         Begin VB.CommandButton cmdUBrowser 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Browser..."
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   435
            Left            =   6240
            Style           =   1  'Graphical
            TabIndex        =   71
            Top             =   3360
            Width           =   1035
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ค่ายเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   4
            Left            =   600
            TabIndex        =   70
            Top             =   2880
            Width           =   1155
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ปีที่ออกอัลบั้ม"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   5
            Left            =   5880
            TabIndex        =   69
            Top             =   2880
            Width           =   1395
         End
         Begin VB.CheckBox Check1 
            Caption         =   "เนื้อเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   6
            Left            =   600
            TabIndex        =   68
            Top             =   3480
            Width           =   1095
         End
         Begin VB.CheckBox Check1 
            Caption         =   "แนวเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   7
            Left            =   5880
            TabIndex        =   67
            Top             =   2280
            Width           =   1155
         End
         Begin VB.CheckBox Check1 
            Caption         =   "อัลบั้ม"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   3
            Left            =   600
            TabIndex        =   66
            Top             =   2280
            Width           =   795
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ศิลปิน"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   2
            Left            =   5880
            TabIndex        =   65
            Top             =   1680
            Width           =   795
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ชื่อเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   1
            Left            =   600
            TabIndex        =   64
            Top             =   1680
            Width           =   1095
         End
         Begin VB.TextBox Text3 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   6
            Left            =   7500
            TabIndex        =   63
            Top             =   2820
            Width           =   555
         End
         Begin VB.TextBox Text3 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   2
            Left            =   1740
            TabIndex        =   62
            Top             =   1620
            Width           =   3315
         End
         Begin VB.TextBox Text3 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   1
            Left            =   7140
            TabIndex        =   61
            Top             =   1020
            Width           =   1875
         End
         Begin VB.CommandButton cmdUSearch 
            BackColor       =   &H0080C0FF&
            Caption         =   "&ค้นหา..."
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   1260
            Style           =   1  'Graphical
            TabIndex        =   60
            Top             =   960
            Width           =   915
         End
         Begin VB.ComboBox cmbUGenre 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            ItemData        =   "Music.frx":0000
            Left            =   7140
            List            =   "Music.frx":0034
            Sorted          =   -1  'True
            TabIndex        =   59
            Text            =   "Pop"
            Top             =   2220
            Width           =   1635
         End
         Begin VB.TextBox Text3 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   7
            Left            =   1740
            TabIndex        =   58
            Top             =   3420
            Width           =   4215
         End
         Begin MSComDlg.CommonDialog DialogUpdate 
            Left            =   7320
            Top             =   3300
            _ExtentX        =   847
            _ExtentY        =   847
            _Version        =   393216
            Filter          =   "All type of music"
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "ID"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   195
            Left            =   840
            TabIndex        =   85
            Top             =   540
            Width           =   195
         End
      End
      Begin VB.CommandButton cmdUUpdate 
         BackColor       =   &H0080C0FF&
         Caption         =   "&Update"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   9480
         Style           =   1  'Graphical
         TabIndex        =   54
         Top             =   5040
         Width           =   915
      End
      Begin VB.Frame Frame6 
         Caption         =   "รายละเอียดของตู้เก็บเพลง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   1455
         Left            =   240
         TabIndex        =   50
         Top             =   4440
         Width           =   8595
         Begin VB.CheckBox Check1 
            Caption         =   "ตู้เพลงที่"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   8
            Left            =   540
            TabIndex        =   84
            Top             =   720
            Width           =   975
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ส่วนของตู้"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   10
            Left            =   5400
            TabIndex        =   56
            Top             =   720
            Width           =   1155
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ชั้นที่"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   9
            Left            =   3060
            TabIndex        =   55
            Top             =   720
            Width           =   675
         End
         Begin VB.ComboBox cmbUShelf 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   1680
            TabIndex        =   53
            Top             =   660
            Width           =   855
         End
         Begin VB.ComboBox cmbULayer 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   3960
            TabIndex        =   52
            Top             =   660
            Width           =   855
         End
         Begin VB.ComboBox cmbUPart 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            ItemData        =   "Music.frx":00BA
            Left            =   6720
            List            =   "Music.frx":00C7
            TabIndex        =   51
            Text            =   "ซ้าย"
            Top             =   660
            Width           =   795
         End
      End
   End
   Begin ComctlLib.TabStrip TabMusic 
      Height          =   6675
      Left            =   60
      TabIndex        =   0
      Top             =   60
      Width           =   11295
      _ExtentX        =   19923
      _ExtentY        =   11774
      _Version        =   327682
      BeginProperty Tabs {0713E432-850A-101B-AFC0-4210102A8DA7} 
         NumTabs         =   3
         BeginProperty Tab1 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Insert"
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Update"
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Select"
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Frame Frame1 
      Caption         =   "SELECT"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   6135
      Index           =   2
      Left            =   180
      TabIndex        =   3
      Top             =   480
      Width           =   11055
      Begin VB.Frame Frame7 
         Caption         =   "รายละเอียดของหนังสือ"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   5835
         Left            =   120
         TabIndex        =   27
         Top             =   180
         Width           =   4755
         Begin VB.TextBox Text1 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   4
            Left            =   1440
            TabIndex        =   49
            Top             =   2370
            Visible         =   0   'False
            Width           =   3135
         End
         Begin VB.TextBox Text1 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   3
            Left            =   1440
            TabIndex        =   48
            Top             =   1740
            Visible         =   0   'False
            Width           =   3135
         End
         Begin VB.TextBox Text1 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   2
            Left            =   1440
            TabIndex        =   47
            Top             =   1110
            Visible         =   0   'False
            Width           =   3135
         End
         Begin VB.TextBox Text1 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   1
            Left            =   3060
            TabIndex        =   46
            Top             =   480
            Visible         =   0   'False
            Width           =   1515
         End
         Begin VB.ComboBox cmbSGenre 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            ItemData        =   "Music.frx":00DC
            Left            =   1440
            List            =   "Music.frx":00E9
            TabIndex        =   45
            Text            =   "POP"
            Top             =   3000
            Visible         =   0   'False
            Width           =   1335
         End
         Begin VB.TextBox Text1 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   0
            Left            =   780
            TabIndex        =   44
            Top             =   480
            Visible         =   0   'False
            Width           =   735
         End
         Begin VB.TextBox Text1 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   6
            Left            =   1440
            MaxLength       =   4
            TabIndex        =   43
            Top             =   4260
            Visible         =   0   'False
            Width           =   555
         End
         Begin VB.TextBox Text1 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Index           =   5
            Left            =   1440
            TabIndex        =   42
            Top             =   3630
            Visible         =   0   'False
            Width           =   3135
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ชื่อศิลปิน"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   3
            Left            =   180
            TabIndex        =   37
            Top             =   1800
            Width           =   1095
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ชื่อเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   2
            Left            =   180
            TabIndex        =   36
            Top             =   1170
            Width           =   1035
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ีรหัสเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   1
            Left            =   1860
            TabIndex        =   35
            Top             =   540
            Width           =   1155
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ID"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   0
            Left            =   180
            TabIndex        =   34
            Top             =   540
            Width           =   555
         End
         Begin VB.CheckBox Check2 
            Caption         =   "อัลบั้ม"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   4
            Left            =   180
            TabIndex        =   33
            Top             =   2430
            Width           =   855
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ค่ายเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   5
            Left            =   180
            TabIndex        =   32
            Top             =   3690
            Width           =   1095
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ปีออกอัลบั้ม"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   6
            Left            =   180
            TabIndex        =   31
            Top             =   4320
            Width           =   1215
         End
         Begin VB.CheckBox Check2 
            Caption         =   "แนวเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   255
            Index           =   7
            Left            =   180
            TabIndex        =   30
            Top             =   3060
            Width           =   1155
         End
         Begin VB.CommandButton cmdSClear 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Clear"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   435
            Left            =   960
            Style           =   1  'Graphical
            TabIndex        =   29
            Top             =   5100
            Width           =   915
         End
         Begin VB.CommandButton cmdSSearch 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Search"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   435
            Left            =   2880
            Style           =   1  'Graphical
            TabIndex        =   28
            Top             =   5100
            Width           =   915
         End
      End
      Begin VB.Frame Frame8 
         Caption         =   "รายงานผลของการค้นหา"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   5835
         Left            =   4980
         TabIndex        =   38
         Top             =   180
         Width           =   5955
         Begin VB.CommandButton cmdSDelete 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Delete"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   435
            Left            =   1320
            Style           =   1  'Graphical
            TabIndex        =   40
            Top             =   5100
            Width           =   915
         End
         Begin VB.CommandButton cmdSUpdate 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Update"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   435
            Left            =   3840
            Style           =   1  'Graphical
            TabIndex        =   39
            Top             =   5100
            Width           =   915
         End
         Begin TrueDBGridStd.TDBGridS TDBGridS1 
            Height          =   4155
            Left            =   180
            OleObjectBlob   =   "Music.frx":0109
            TabIndex        =   41
            Top             =   300
            Width           =   5595
         End
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "INSERT"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   6075
      Index           =   0
      Left            =   180
      TabIndex        =   1
      Top             =   480
      Width           =   11055
      Begin VB.CommandButton cmdInsert 
         BackColor       =   &H0080C0FF&
         Caption         =   "&Insert"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   9000
         Style           =   1  'Graphical
         TabIndex        =   83
         Top             =   5100
         Width           =   975
      End
      Begin VB.Frame Frame2 
         Caption         =   "รายละเอียดของเพลง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   4335
         Left            =   180
         TabIndex        =   11
         Top             =   240
         Width           =   10695
         Begin VB.TextBox txtICode 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   2160
            TabIndex        =   21
            Top             =   480
            Width           =   2295
         End
         Begin VB.TextBox txtIName 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   6240
            TabIndex        =   20
            Top             =   480
            Width           =   3075
         End
         Begin VB.TextBox txtIArthist 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   2160
            TabIndex        =   19
            Top             =   1155
            Width           =   2295
         End
         Begin VB.TextBox txtIAlbum 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   6240
            TabIndex        =   18
            Top             =   1155
            Width           =   3075
         End
         Begin VB.TextBox txtIPublishing 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   2160
            TabIndex        =   17
            Top             =   1830
            Width           =   2295
         End
         Begin VB.TextBox txtIYear 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   2160
            MaxLength       =   4
            TabIndex        =   16
            Top             =   2505
            Width           =   555
         End
         Begin VB.TextBox txtISong 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   2160
            TabIndex        =   15
            Top             =   3180
            Width           =   4695
         End
         Begin VB.ComboBox cmbIGenre 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   6240
            TabIndex        =   14
            Text            =   "POP"
            Top             =   1830
            Width           =   1335
         End
         Begin VB.TextBox txtICount 
            BackColor       =   &H00C0FFFF&
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   315
            Left            =   5580
            Locked          =   -1  'True
            TabIndex        =   13
            Top             =   3780
            Width           =   615
         End
         Begin VB.CommandButton cmdIBrower 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Browser..."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   435
            Left            =   7260
            Style           =   1  'Graphical
            TabIndex        =   12
            Top             =   3120
            Width           =   1095
         End
         Begin MSComDlg.CommonDialog DialogInsert 
            Left            =   8460
            Top             =   3120
            _ExtentX        =   847
            _ExtentY        =   847
            _Version        =   393216
            Filter          =   "All type of Music"
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "เนื้อเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   7
            Left            =   1125
            TabIndex        =   82
            Top             =   3240
            Width           =   705
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ปีที่ออกอัลบั้ม"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   6
            Left            =   825
            TabIndex        =   81
            Top             =   2565
            Width           =   1005
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ค่ายเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   4
            Left            =   1125
            TabIndex        =   80
            Top             =   1890
            Width           =   705
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ศิลปิน"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   2
            Left            =   1380
            TabIndex        =   79
            Top             =   1215
            Width           =   450
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "รหัสเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   0
            Left            =   1080
            TabIndex        =   78
            Top             =   540
            Width           =   750
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   1
            Left            =   5340
            TabIndex        =   26
            Top             =   540
            Width           =   645
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "อัลบั้ม"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   3
            Left            =   5535
            TabIndex        =   25
            Top             =   1215
            Width           =   450
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "แนวเพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   5
            Left            =   5235
            TabIndex        =   24
            Top             =   1890
            Width           =   750
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "เรคคอด"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00004000&
            Height          =   195
            Index           =   12
            Left            =   6360
            TabIndex        =   23
            Top             =   3840
            Width           =   600
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ปัจจุบันในฐานข้อมูลมีหนังสือทั้งสิ้น"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00004000&
            Height          =   195
            Index           =   11
            Left            =   2760
            TabIndex        =   22
            Top             =   3840
            Width           =   2670
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "รายละเอียดของตู้เก็บเพลง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   1275
         Left            =   180
         TabIndex        =   4
         Top             =   4620
         Width           =   7515
         Begin VB.ComboBox cmbIPart 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            ItemData        =   "Music.frx":1BA1
            Left            =   5760
            List            =   "Music.frx":1BAE
            TabIndex        =   7
            Text            =   "ซ้าย"
            Top             =   540
            Width           =   795
         End
         Begin VB.ComboBox cmbILayer 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            ItemData        =   "Music.frx":1BC3
            Left            =   3300
            List            =   "Music.frx":1BC5
            TabIndex        =   6
            Text            =   "1"
            Top             =   540
            Width           =   795
         End
         Begin VB.ComboBox cmbIShelf 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   1380
            TabIndex        =   5
            Top             =   540
            Width           =   795
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ตู้เพลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   8
            Left            =   600
            TabIndex        =   10
            Top             =   600
            Width           =   540
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชั้นที่"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   9
            Left            =   2640
            TabIndex        =   9
            Top             =   600
            Width           =   360
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ส่วนของตู้"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   15
            Left            =   4740
            TabIndex        =   8
            Top             =   600
            Width           =   765
         End
      End
   End
End
Attribute VB_Name = "Music"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim oVTableResult As ddoTable
Dim checkInsert As Boolean
Dim CountRowFirst As ddoTable

Private Sub Check1_Click(Index As Integer)
If Check1(Index).Value = 1 Then
     If Index < 6 Then
          Text3(Index + 1).Enabled = True
          Text3(Index + 1).SetFocus
     Else: Select Case Index
                 Case 6: cmdUBrowser.Enabled = True
                 Case 7: cmbUGenre.Enabled = True
                 Case 8: cmbUShelf.Enabled = True
                 Case 9: cmbULayer.Enabled = True
                 Case 10: cmbUPart.Enabled = True
              End Select
      End If
Else:
         If Index < 6 Then
                 Text3(Index + 1).Enabled = False
         Else: Select Case Index
                 Case 6: cmdUBrowser.Enabled = True
                 Case 7: cmbUGenre.Enabled = False
                 Case 8: cmbUShelf.Enabled = False
                 Case 9: cmbULayer.Enabled = False
                 Case 10: cmbUPart.Enabled = False
         End Select
         End If
End If
End Sub

Private Sub Check2_Click(Index As Integer)
If Check2(Index).Value = 1 Then
     If Index <> 7 Then
           With Text1(Index)
               .Text = ""
               .Visible = True
               .SetFocus
           End With
      Else: cmbSGenre.Visible = True
      End If
Else:
         If Index <> 7 Then
                 Text1(Index).Visible = False
                 Text1(Index).Text = ""
         Else: cmbSGenre.Visible = False
         End If
End If
End Sub

Private Sub cmbIShelf_Click()
Dim i As Integer
Dim CountLayer As ddoTable
MainScreen.oDataGroupMusic.BeginTransaction
Set CountLayer = MainScreen.oDataGroupMusic.ExecuteSQLCommand("Select layer from musicshelf where shelfid = " + cmbIShelf)
MainScreen.oDataGroupMusic.CommitTransaction
cmbILayer.Clear   'ล้างข้อมูลใน ComboBox
cmbILayer.Text = 1
For i = 1 To CountLayer.Columns(1).Value
     cmbILayer.AddItem (i)
Next i
End Sub

Private Sub cmbUShelf_Click()
Dim i As Integer
Dim CountLayer As ddoTable
MainScreen.oDataGroupMusic.BeginTransaction
Set CountLayer = MainScreen.oDataGroupMusic.ExecuteSQLCommand("Select layer from musicshelf where shelfid = " + cmbIShelf)
MainScreen.oDataGroupMusic.CommitTransaction
cmbULayer.Clear   'ล้างข้อมูลใน ComboBox
cmbULayer.Text = 1
For i = 1 To CountLayer.Columns(1).Value
     cmbULayer.AddItem (i)
Next i
End Sub

Private Sub cmdIBrower_Click()
DialogInsert.ShowOpen
DialogInsert.Filter = "All type of song"
txtISong.Text = DialogInsert.FileName
End Sub

Private Sub cmdInsert_Click()
Dim Parameter As String
Dim CountRow As ddoTable
Parameter = PrepareParameter 'Set String ของ Parameter ของคำสั่ง Insert Book
Parameter = "{CALL insertmusic(" + Parameter + ")}"
MainScreen.oDataGroupMusic.BeginTransaction
Set CountRow = MainScreen.oDataGroupMusic.ExecuteSQLCommand(Parameter)
MainScreen.oDataGroupMusic.CommitTransaction
If CountRow.Columns(2).Value = "N" Then
    MsgBox "รหัสเพลงที่คุณ Insert ซ้ำกับข้อมูลที่มีอยู่แล้ว", , "Insert"
Else: MsgBox (" Insert ข้อมูลเรียบร้อยแล้ว")
End If
txtICount.Text = CountRow.Columns(1).Value
MainScreen.oDataGroupBook.DeleteVirtualTable ("CountRow")
End Sub

Private Function PrepareParameter() As String
Dim P_SQL As String
Dim Part As String
If cmbIPart.ListIndex = 0 Then
    Part = "L"
ElseIf cmbIPart.ListIndex = 1 Then
    Part = "M"
ElseIf cmbIPart.ListIndex = 2 Then
    Part = "R"
Else: Part = "L"
End If
P_SQL = """" + UCase(txtICode.Text) + """,""" + UCase(txtIName.Text) + """,""" + UCase(txtIArthist.Text) + _
              """,""" + UCase(txtIAlbum.Text) + """,""" + UCase(cmbIGenre) + """,""" + UCase(txtIPublishing.Text) + _
              """," + (txtIYear.Text) + ",'""" + txtISong.Text + """'," + cmbIShelf.Text + "," + cmbILayer + ",""" + Part + """"
PrepareParameter = P_SQL
End Function

Private Sub cmdSClear_Click()
Dim i As Byte
For i = 0 To 6
   Check2(i).Value = 0
   Text1(i).Text = ""
   Text1(i).Visible = False
Next i
   Check2(7).Value = 0
   cmbSGenre.Visible = False
End Sub

Private Sub cmdSDelete_Click()
Dim DeleteSQL As String
oVTableResult.GotoRecord (TDBGridS1.Row + 1)
DeleteSQL = "delete from music WHERE musicid = " + oVTableResult.Columns(1).Value
MainScreen.oDataGroupMusic.BeginTransaction
MainScreen.oDataGroupMusic.ExecuteSQLCommand (DeleteSQL)
Set CountRowFirst = MainScreen.oDataGroupMusic.ExecuteSQLCommand("Select count(*) from music")
MainScreen.oDataGroupMusic.CommitTransaction
txtICount.Text = CountRowFirst.Columns(1).Value
TDBGridS1.Refresh
Call PassSQL
End Sub

Private Sub cmdSSearch_Click()
Dim check As Boolean
Dim i As Byte
check = True
For i = 0 To 6
    If (Check2(i) = 1) And (Text1(i).Text = "") Then
       check = False
    End If
Next i
If check Then
Call PassSQL
Else: MsgBox "โปรดใส่ข้อความที่คุณต้องการค้นหา ณ หัวข้อที่คุณเช็ค", , "ค้นหา"
End If
End Sub

Private Sub PassSQL()
Dim SQLString As String
SQLString = PrepareParameterSearch
SQLString = "{CALL searchdetailmusic(" + SQLString + ")}"
'For direct SQL (DML) include transaction
MainScreen.oDataGroupMusic.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupMusic.ExecuteSQLCommand(SQLString)
MainScreen.oDataGroupMusic.CommitTransaction
Call ClearGrid
End Sub

Private Function PrepareParameterSearch() As String
Dim i As Byte
Dim SQL As String
If Check2(0).Value = 0 Then
    Text1(0).Text = "0"
End If
If Check2(6).Value = 0 Then
    Text1(6).Text = "0"
End If
For i = 0 To 5
    SQL = SQL + UCase(Text1(i).Text)
    If i = 0 Then
        SQL = Text1(i).Text + ","""
    ElseIf i <> 5 Then
        SQL = SQL + ""","""
End If
Next i
SQL = SQL + """," + Text1(6).Text + ","
If Check2(7).Value = 0 Then
     SQL = SQL + """"""
Else: SQL = SQL + """" + cmbSGenre + """"
End If
PrepareParameterSearch = SQL
End Function

Private Sub ClearGrid()
    Dim i As Integer
    Dim rc As Integer
    rc = 0
   ' Remove all the columns from the grid
    For i = TDBGridS1.Columns.Count To 0 Step -1
        If i = 0 Then Exit For
        TDBGridS1.Columns.Remove (i - 1)
    Next i
If oVTableResult Is Nothing Then                   'No data return
      MsgBox ("No Data in this Multimedia database")
      MainScreen.oDataGroupMusic.DeleteVirtualTable ("oVTableResult")
      cmdSDelete.Enabled = False
      cmdSUpdate.Enabled = False
      cmdUUpdate.Enabled = False
Else: Call SetNameColumn
         cmdSDelete.Enabled = True
         cmdSUpdate.Enabled = True
         cmdUUpdate.Enabled = True
End If
End Sub

Private Sub SetNameColumn()
        Dim i As Integer
        Dim c As Object
        Dim ColumnName(10) As String
        ColumnName(0) = "MUSICID"
        ColumnName(1) = "MUSICCODE"
        ColumnName(2) = "MUSICNAME"
        ColumnName(3) = "ARTHIST"
        ColumnName(4) = "ALBUM"
        ColumnName(5) = "PUBLISHING"
        ColumnName(6) = "YEAR"
        ColumnName(7) = "GENRE"
        ColumnName(8) = "SHELFID"
        ColumnName(9) = "LAYER"
        ColumnName(10) = "PART"
        For i = 0 To oVTableResult.Columns.Count - 1
             Set c = TDBGridS1.Columns.Add(i)
                 With c
                     .Visible = True
                     .Caption = UCase(ColumnName(i))
                     ' Set column locking, which specifies if a column is
                     ' read-only (i.e., the user cannot edit that column)
                     .Locked = True
                 End With
        Next i
 End Sub

Private Sub cmdSUpdate_Click()
Dim Search_Update As String
TabMusic.Tabs(2).Selected = True
Frame1(1).ZOrder 0
oVTableResult.GotoRecord (TDBGridS1.Row + 1)
Search_Update = "{Call SearchUpdateMusic(" + oVTableResult.Columns(1).Value + ")}"
Text3(0).Text = oVTableResult.Columns(1).Value
MainScreen.oDataGroupMusic.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupMusic.ExecuteSQLCommand(Search_Update)
MainScreen.oDataGroupMusic.CommitTransaction
Call Input_to_txt
End Sub

Private Sub Input_to_txt()
Dim i As Integer
If Not (oVTableResult Is Nothing) Then
    For i = 1 To 6
         Text3(i).Text = oVTableResult.Columns(i).Value
    Next i
        cmbUGenre.Text = oVTableResult.Columns(7).Value
        cmbUShelf.Text = oVTableResult.Columns(8).Value
        cmbULayer.Clear 'ล้างข้อมูลใน ComboBox
        cmbULayer.Text = oVTableResult.Columns(9).Value
    If oVTableResult.Columns(10).Value = "L" Then
       cmbUPart.Text = "ซ้าย"
    ElseIf oVTableResult.Columns(10).Value = "M" Then
       cmbUPart.Text = "กลาง"
    ElseIf oVTableResult.Columns(10).Value = "R" Then
       cmbUPart.Text = "ขวา"
    End If
    For i = 1 To oVTableResult.Columns(11).Value
       cmbULayer.AddItem (i)
    Next i
cmdUUpdate.Enabled = True
Else:  MsgBox ("No Data in this Multimedia database")
         Text3(0).Text = ""
         cmdUUpdate.Enabled = False
End If
MainScreen.oDataGroupMusic.DeleteVirtualTable ("oVTableResult")
End Sub

Function PrepareparameterUpdate() As String
Dim U_SQL As String
Dim Part As String
Dim i As Byte
If cmbUPart.ListIndex = 0 Then
    Part = "L"
ElseIf cmbUPart.ListIndex = 1 Then
    Part = "M"
ElseIf cmbUPart.ListIndex = 2 Then
    Part = "R"
Else: Part = "L"
End If
    U_SQL = Text3(0).Text + ","""
For i = 1 To 5
    U_SQL = U_SQL + UCase(Text3(i).Text)
    If i <> 5 Then
    U_SQL = U_SQL + ""","""
    End If
Next i
If Text3(7).Text = "" Then
    Text3(7).Text = "NOT"
End If
U_SQL = U_SQL + """," + Text3(6).Text + ",'""" + Text3(7).Text + """',""" + _
               cmbUGenre + """," + cmbUShelf + "," + cmbULayer + ",""" + Part + """"
PrepareparameterUpdate = U_SQL
End Function

Private Sub cmdUBrowser_Click()
DialogUpdate.ShowOpen
DialogUpdate.Filter = "All type of music"
Text3(7).Text = DialogUpdate.FileName
End Sub

Private Sub cmdUSearch_Click()
Dim Search_Update As String
Text3(0).Text = Val(Text3(0).Text)
Search_Update = "{Call SearchUpdateMusic(" + Text3(0).Text + ")}"
MainScreen.oDataGroupMusic.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupMusic.ExecuteSQLCommand(Search_Update)
MainScreen.oDataGroupMusic.CommitTransaction
Call Input_to_txt
End Sub

Private Sub cmdUUpdate_Click()
Dim ParameterUpdate As String
Dim CheckUpdate  As ddoTable
ParameterUpdate = PrepareparameterUpdate
ParameterUpdate = "execute procedure UPDATEMUSIC(" + ParameterUpdate + ")"
MainScreen.oDataGroupMusic.BeginTransaction
Set CheckUpdate = MainScreen.oDataGroupMusic.ExecuteSQLCommand(ParameterUpdate)
MainScreen.oDataGroupMusic.CommitTransaction
MsgBox " Update ข้อมูลเรียบร้อยแล้ว", , "Update"
MainScreen.oDataGroupMusic.DeleteVirtualTable ("CheckUpdate")
End Sub

Private Sub Command1_Click()
Unload Me
MenuAdmin.Show
End Sub

Private Sub Form_Load()
Dim i As Byte
Dim CountShelf As ddoTable
Dim CountLayer As Byte
For i = 0 To Frame1.Count - 1
     With Frame1(i)
     .Move TabMusic.ClientLeft + 40, _
      TabMusic.ClientTop + 40, _
      TabMusic.ClientWidth - 100, _
      TabMusic.ClientHeight - 100
     End With
Next i
Frame1(0).ZOrder 0
MainScreen.oDataGroupMusic.BeginTransaction
Set CountRowFirst = MainScreen.oDataGroupMusic.ExecuteSQLCommand("Select count(*) from music")
Set CountShelf = MainScreen.oDataGroupMusic.ExecuteSQLCommand("Select shelfid,layer from musicshelf")
MainScreen.oDataGroupMusic.CommitTransaction
txtICount.Text = CountRowFirst.Columns(1).Value
cmbIShelf.Text = CountShelf.Columns(1).Value
cmbUShelf.Text = CountShelf.Columns(1).Value
CountLayer = CountShelf.Columns(2).Value
For i = 1 To CountLayer
     cmbILayer.AddItem (i)
     cmbULayer.AddItem (i)
Next i
Do While CountShelf.EOT = False 'เพิ่มข้อมูลเข้าไปใน cmbIShelf และ cmbILayer
     cmbIShelf.AddItem (CountShelf.Columns(1).Value)
     cmbUShelf.AddItem (CountShelf.Columns(1).Value)
     CountShelf.NextRecord
Loop
MainScreen.oDataGroupMusic.DeleteVirtualTable ("CountRowFirst")
MainScreen.oDataGroupMusic.DeleteVirtualTable ("CountShelf")
End Sub

Private Sub TabMusic_Click()
Frame1(TabMusic.SelectedItem.Index - 1).ZOrder 0
If TabMusic.Tabs(3).Selected Then
   cmdSDelete.Enabled = False
   cmdSUpdate.Enabled = False
   cmdUUpdate.Enabled = False
End If
End Sub

Private Sub TDBGridS1_UnboundReadData(ByVal RowBuf As TrueDBGridStd.RowBuffer, StartLocation As Variant, ByVal ReadPriorRows As Boolean)
' Display SearchBook.oVTableBook in grdResult
    Dim i, j, r As Integer
    Dim BOT As Boolean, EOT As Boolean
        'check if the oTable exist
    If oVTableResult Is Nothing Then
        RowBuf.RowCount = 0
        Exit Sub
    End If
    ' StartLocation - If NULL, then the grid is empty
    ' ReadPriorRows - If True, read in a reverse direction otherwise read in a forward direction.
     r = 0
    ' StartLocation is the row immediately before the current record when fetching
    ' in a forward direction, and immediately after when fetching in a reverse direction.
    If IsNull(StartLocation) Then
        ' StartLocation is NULL so fetching is either at end or beginning of record set. If
        ' have already fetched data (ReadPriorRows = True) then goto LastRecord. Otherwise
        ' goto FirstRecord.
        If ReadPriorRows Then
            oVTableResult.LastRecord
            BOT = False
            EOT = False
        Else
            oVTableResult.FirstRecord
            BOT = False
            EOT = False
        End If
    Else
            'Set the current record to the StartLocation
            oVTableResult.GotoRecord (StartLocation)
        ' StartLocation not NULL, update record pointer
        If ReadPriorRows Then
            If oVTableResult.PreviousRecord Then
                BOT = False
                EOT = False
            Else
                BOT = True
                EOT = False
            End If
        Else
            If oVTableResult.NextRecord Then
                EOT = False
                BOT = False
            Else
                EOT = True
                BOT = False
            End If
        End If
    End If
    ' Loop over the row buffer and add the desired rows to the grid
    For i = 0 To RowBuf.RowCount - 1
        ' Exit if at the end of the record list
       If BOT Or EOT Then
            Exit For
        End If
        ' Loop over the columns and add the column values to the grid
        For j = 0 To oVTableResult.Columns.Count - 1
            RowBuf.Value(i, j) = oVTableResult.Columns(j + 1).Value
        Next j
        ' Use the current record number as the bookmarks
        RowBuf.Bookmark(i) = oVTableResult.CurrentRecordNumber
        If ReadPriorRows Then
            If oVTableResult.PreviousRecord Then
                BOT = False
            Else
                BOT = True
            End If
        Else
            If oVTableResult.NextRecord Then
                EOT = False
            Else
                EOT = True
            End If
        End If
                r = r + 1
    Next i
    oVTableResult.FirstRecord
    RowBuf.RowCount = r
End Sub

Private Sub Text1_Change(Index As Integer)
Dim CheckInteger As String
If Index = 0 Then
      CheckInteger = Val(Text1(0).Text)
      If CheckInteger = Text1(0).Text Then
           cmdSSearch.Enabled = True
      Else: cmdSSearch.Enabled = False
      End If
End If
End Sub

Private Sub Text3_Change(Index As Integer)
Dim CheckInteger As String
If Index = 0 Then
      CheckInteger = Val(Text3(0).Text)
      If CheckInteger = Text3(0).Text Then
           cmdUSearch.Enabled = True
      Else: cmdUSearch.Enabled = False
      End If
ElseIf Index = 6 Then
      CheckInteger = Val(Text3(6).Text)
      If CheckInteger = Text3(6).Text Then
            cmdUUpdate.Enabled = True
      Else: cmdUUpdate.Enabled = False
      End If
End If
End Sub

Private Sub txtISong_Change()
If checkInsert Then
  cmdInsert.Enabled = True
End If
End Sub

Private Sub txtIYear_Change()
Dim CheckInteger As String
CheckInteger = Val(txtIYear.Text)
If CheckInteger = txtIYear.Text Then
      checkInsert = True
Else: checkInsert = False
End If
End Sub
