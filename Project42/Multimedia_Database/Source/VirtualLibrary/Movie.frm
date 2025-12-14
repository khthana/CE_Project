VERSION 5.00
Object = "{00028C51-0000-0000-0000-000000000046}#1.0#0"; "TDBGS32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "Comctl32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Movie 
   Caption         =   "For Administrator control movie"
   ClientHeight    =   7110
   ClientLeft      =   360
   ClientTop       =   1245
   ClientWidth     =   11475
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7110
   ScaleWidth      =   11475
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
      TabIndex        =   75
      Top             =   6600
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
      Height          =   5895
      Index           =   1
      Left            =   240
      TabIndex        =   2
      Top             =   480
      Width           =   11055
      Begin VB.Frame Frame4 
         Caption         =   "รายละเอียดของภาพยนตร์"
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
         Height          =   4275
         Left            =   230
         TabIndex        =   56
         Top             =   180
         Width           =   10695
         Begin VB.CheckBox Check1 
            Caption         =   "บริษัทผู้สร้าง"
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
            Left            =   300
            TabIndex        =   83
            Top             =   2340
            Width           =   1395
         End
         Begin VB.Frame Frame9 
            Caption         =   "ชื่อนักแสดง"
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
            Height          =   1755
            Left            =   6120
            TabIndex        =   71
            Top             =   420
            Width           =   4215
            Begin VB.CheckBox Check1 
               Caption         =   "นักแสดง 1"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   222
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000040C0&
               Height          =   255
               Index           =   2
               Left            =   240
               TabIndex        =   82
               Top             =   480
               Width           =   1215
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
               Left            =   1500
               TabIndex        =   74
               Top             =   1080
               Width           =   2475
            End
            Begin VB.CheckBox Check1 
               Caption         =   "นักแสดง 2"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   222
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000040C0&
               Height          =   255
               Index           =   3
               Left            =   240
               TabIndex        =   73
               Top             =   1140
               Width           =   1155
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
               Left            =   1500
               TabIndex        =   72
               Top             =   420
               Width           =   2475
            End
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
            Index           =   5
            Left            =   1800
            TabIndex        =   70
            Top             =   2280
            Width           =   3795
         End
         Begin VB.CheckBox Check1 
            Caption         =   "รหัสภาพยนตร์"
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
            Left            =   2580
            TabIndex        =   69
            Top             =   960
            Width           =   1455
         End
         Begin VB.TextBox Text3 
            Alignment       =   2  'Center
            BackColor       =   &H00C0FFC0&
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
            Left            =   1140
            TabIndex        =   68
            Top             =   480
            Width           =   795
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
            Left            =   6480
            Style           =   1  'Graphical
            TabIndex        =   67
            Top             =   3540
            Width           =   1035
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ปีที่สร้าง"
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
            Left            =   300
            TabIndex        =   66
            Top             =   3000
            Width           =   1035
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ไฟล์ภาพยนตร์"
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
            Left            =   300
            TabIndex        =   65
            Top             =   3660
            Width           =   1455
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ประเภทภาพยนตร์"
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
            Left            =   2400
            TabIndex        =   64
            Top             =   3000
            Width           =   1755
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ชื่อภาพยนตร์"
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
            Left            =   300
            TabIndex        =   63
            Top             =   1680
            Width           =   1395
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
            Left            =   1440
            MaxLength       =   4
            TabIndex        =   62
            Top             =   2940
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
            Left            =   1800
            TabIndex        =   61
            Top             =   1620
            Width           =   3795
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
            Left            =   4200
            TabIndex        =   60
            Top             =   900
            Width           =   1695
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
            Left            =   1140
            Style           =   1  'Graphical
            TabIndex        =   59
            Top             =   960
            Width           =   915
         End
         Begin VB.ComboBox cmbUClass 
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
            ItemData        =   "Movie.frx":0000
            Left            =   4200
            List            =   "Movie.frx":0010
            TabIndex        =   58
            Text            =   "Action"
            Top             =   2940
            Width           =   1695
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
            Left            =   1860
            TabIndex        =   57
            Top             =   3600
            Width           =   4335
         End
         Begin MSComDlg.CommonDialog DialogUpdate 
            Left            =   6480
            Top             =   2940
            _ExtentX        =   847
            _ExtentY        =   847
            _Version        =   393216
            Filter          =   "All type of music"
         End
         Begin VB.Label Label2 
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
            Height          =   255
            Left            =   600
            TabIndex        =   85
            Top             =   540
            Width           =   315
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
         Left            =   9060
         Style           =   1  'Graphical
         TabIndex        =   55
         Top             =   4980
         Width           =   915
      End
      Begin VB.Frame Frame6 
         Caption         =   "รายละเอียดของตู้เก็บภาพยนตร์"
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
         Height          =   1230
         Left            =   230
         TabIndex        =   22
         Top             =   4510
         Width           =   7935
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
            Left            =   420
            TabIndex        =   84
            Top             =   600
            Width           =   975
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
            ItemData        =   "Movie.frx":0036
            Left            =   6480
            List            =   "Movie.frx":0043
            TabIndex        =   27
            Text            =   "ซ้าย"
            Top             =   540
            Width           =   795
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
            Left            =   3840
            TabIndex        =   26
            Top             =   540
            Width           =   855
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
            Left            =   1620
            TabIndex        =   25
            Top             =   540
            Width           =   855
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
            Left            =   2880
            TabIndex        =   24
            Top             =   600
            Width           =   675
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
            Left            =   5160
            TabIndex        =   23
            Top             =   600
            Width           =   1155
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
      Height          =   5895
      Index           =   0
      Left            =   180
      TabIndex        =   1
      Top             =   480
      Width           =   11055
      Begin VB.Frame Frame2 
         Caption         =   "รายละเอียดของภาพยนตร์"
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
         TabIndex        =   4
         Top             =   180
         Width           =   10755
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
            Left            =   1860
            TabIndex        =   81
            Top             =   480
            Width           =   1455
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
            Left            =   1860
            TabIndex        =   80
            Top             =   1155
            Width           =   3675
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
            Left            =   1860
            TabIndex        =   79
            Top             =   1830
            Width           =   3675
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
            Left            =   1860
            MaxLength       =   4
            TabIndex        =   78
            Top             =   2520
            Width           =   555
         End
         Begin VB.TextBox txtIFilm 
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
            Left            =   1860
            TabIndex        =   77
            Top             =   3180
            Width           =   5295
         End
         Begin VB.ComboBox cmbIClass 
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
            Left            =   5880
            TabIndex        =   76
            Text            =   "ACTION"
            Top             =   2520
            Width           =   2055
         End
         Begin VB.Frame Frame5 
            Caption         =   "ชื่อนักแสดง"
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
            Height          =   1755
            Left            =   5940
            TabIndex        =   48
            Top             =   420
            Width           =   4395
            Begin VB.TextBox txtIActor2 
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   222
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00C00000&
               Height          =   315
               Left            =   1260
               TabIndex        =   51
               Top             =   1080
               Width           =   2775
            End
            Begin VB.TextBox txtIActor1 
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   222
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00C00000&
               Height          =   315
               Left            =   1260
               TabIndex        =   49
               Top             =   420
               Width           =   2775
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "นักแสดง 2"
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
               Index           =   10
               Left            =   240
               TabIndex        =   52
               Top             =   1140
               Width           =   825
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "นักแสดง 1"
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
               Index           =   2
               Left            =   240
               TabIndex        =   50
               Top             =   480
               Width           =   825
            End
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
            Left            =   7380
            Style           =   1  'Graphical
            TabIndex        =   6
            Top             =   3120
            Width           =   1035
         End
         Begin VB.TextBox txtICount 
            Alignment       =   2  'Center
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
            Left            =   5820
            Locked          =   -1  'True
            TabIndex        =   5
            Top             =   3780
            Width           =   735
         End
         Begin MSComDlg.CommonDialog DialogInsert 
            Left            =   8220
            Top             =   2520
            _ExtentX        =   847
            _ExtentY        =   847
            _Version        =   393216
            Filter          =   "All type of Music"
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ปัจจุบันในฐานข้อมูลมีภาพยนตร์ทั้งสิ้น"
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
            TabIndex        =   14
            Top             =   3840
            Width           =   2910
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
            Left            =   6720
            TabIndex        =   13
            Top             =   3840
            Width           =   600
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ไฟล์ภาพยนตร์"
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
            Left            =   540
            TabIndex        =   12
            Top             =   3240
            Width           =   1125
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ปีที่สร้าง"
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
            Left            =   540
            TabIndex        =   11
            Top             =   2580
            Width           =   630
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ประเภทของภาพยนตร์"
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
            Left            =   3840
            TabIndex        =   10
            Top             =   2580
            Width           =   1710
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "บริษัทผู้สร้าง"
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
            Left            =   540
            TabIndex        =   9
            Top             =   1890
            Width           =   990
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อภาพยนตร์"
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
            Left            =   540
            TabIndex        =   8
            Top             =   1215
            Width           =   1020
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "รหัสภาพยนตร์"
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
            Left            =   540
            TabIndex        =   7
            Top             =   540
            Width           =   1125
         End
      End
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
         Left            =   9180
         Style           =   1  'Graphical
         TabIndex        =   53
         Top             =   5040
         Width           =   975
      End
      Begin VB.Frame Frame3 
         Caption         =   "รายละเอียดของตู้เก็บภาพยนตร์"
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
         Height          =   1155
         Left            =   180
         TabIndex        =   15
         Top             =   4560
         Width           =   7875
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
            ForeColor       =   &H00C00000&
            Height          =   315
            Left            =   1860
            TabIndex        =   18
            Top             =   480
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
            ForeColor       =   &H00C00000&
            Height          =   315
            ItemData        =   "Movie.frx":0058
            Left            =   3660
            List            =   "Movie.frx":005A
            TabIndex        =   17
            Text            =   "1"
            Top             =   480
            Width           =   795
         End
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
            ForeColor       =   &H00C00000&
            Height          =   315
            ItemData        =   "Movie.frx":005C
            Left            =   6060
            List            =   "Movie.frx":0069
            TabIndex        =   16
            Text            =   "ซ้าย"
            Top             =   480
            Width           =   795
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
            Left            =   5100
            TabIndex        =   21
            Top             =   540
            Width           =   765
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
            Left            =   3000
            TabIndex        =   20
            Top             =   540
            Width           =   360
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ตู้ภาพยนตร์ที่"
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
            TabIndex        =   19
            Top             =   540
            Width           =   1035
         End
      End
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
      Height          =   5895
      Index           =   2
      Left            =   180
      TabIndex        =   3
      Top             =   480
      Width           =   11115
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
         Height          =   5595
         Left            =   5160
         TabIndex        =   28
         Top             =   180
         Width           =   5835
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
            TabIndex        =   30
            Top             =   4800
            Width           =   915
         End
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
            TabIndex        =   29
            Top             =   4800
            Width           =   915
         End
         Begin TrueDBGridStd.TDBGridS TDBGridS1 
            Height          =   3735
            Left            =   180
            OleObjectBlob   =   "Movie.frx":007E
            TabIndex        =   31
            Top             =   300
            Width           =   5475
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "รายละเอียดของภาพยนตร์"
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
         Height          =   5595
         Left            =   120
         TabIndex        =   32
         Top             =   180
         Width           =   4935
         Begin VB.CheckBox Check2 
            Caption         =   "ประเภทภาพยนตร์"
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
            TabIndex        =   54
            Top             =   3084
            Width           =   1755
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
            TabIndex        =   47
            Top             =   4800
            Width           =   915
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
            TabIndex        =   46
            Top             =   4800
            Width           =   915
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ปีที่สร้าง"
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
            TabIndex        =   45
            Top             =   3720
            Width           =   975
         End
         Begin VB.CheckBox Check2 
            Caption         =   "บริษัทผู้สร้าง"
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
            TabIndex        =   44
            Top             =   2448
            Width           =   1335
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
            TabIndex        =   43
            Top             =   540
            Width           =   495
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ีรหัสภาพยนตร์"
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
            Left            =   1620
            TabIndex        =   42
            Top             =   540
            Width           =   1455
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ชื่อภาพยนตร์"
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
            TabIndex        =   41
            Top             =   1176
            Width           =   1335
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ชื่อนักแสดง"
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
            TabIndex        =   40
            Top             =   1812
            Width           =   1215
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
            Left            =   1620
            MaxLength       =   4
            TabIndex        =   39
            Top             =   3660
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
            Index           =   0
            Left            =   780
            TabIndex        =   38
            Top             =   480
            Visible         =   0   'False
            Width           =   615
         End
         Begin VB.ComboBox cmbSClass 
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
            ItemData        =   "Movie.frx":1B1A
            Left            =   2040
            List            =   "Movie.frx":1B27
            TabIndex        =   37
            Text            =   "ACTION"
            Top             =   3060
            Visible         =   0   'False
            Width           =   1575
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
            Left            =   3240
            TabIndex        =   36
            Top             =   480
            Visible         =   0   'False
            Width           =   1455
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
            Left            =   1620
            TabIndex        =   35
            Top             =   1128
            Visible         =   0   'False
            Width           =   3075
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
            Left            =   1620
            TabIndex        =   34
            Top             =   1776
            Visible         =   0   'False
            Width           =   3075
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
            Index           =   4
            Left            =   1620
            TabIndex        =   33
            Top             =   2400
            Visible         =   0   'False
            Width           =   3075
         End
      End
   End
   Begin ComctlLib.TabStrip TabMovie 
      Height          =   6435
      Left            =   60
      TabIndex        =   0
      Top             =   60
      Width           =   11355
      _ExtentX        =   20029
      _ExtentY        =   11351
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
End
Attribute VB_Name = "Movie"
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
                 Case 7: cmbUClass.Enabled = True
                 Case 8: cmbUShelf.Enabled = True
                 Case 9: cmbULayer.Enabled = True
                 Case 10: cmbUPart.Enabled = True
              End Select
      End If
Else:
         If Index < 6 Then
                 Text3(Index + 1).Enabled = False
         Else: Select Case Index
                 Case 6: cmdUBrowser.Enabled = False
                 Case 7: cmbUClass.Enabled = False
                 Case 8: cmbUShelf.Enabled = False
                 Case 9: cmbULayer.Enabled = False
                 Case 10: cmbUPart.Enabled = False
         End Select
         End If
End If
End Sub

Private Sub Check2_Click(Index As Integer)
If Check2(Index).Value = 1 Then
     If Index <> 6 Then
           With Text1(Index)
               .Text = ""
               .Visible = True
               .SetFocus
           End With
      Else: cmbSClass.Visible = True
      End If
Else:
         If Index <> 6 Then
                 Text1(Index).Visible = False
                 Text1(Index).Text = ""
         Else: cmbSClass.Visible = False
         End If
End If
End Sub

Private Sub cmbIShelf_Click()
Dim i As Integer
Dim CountLayer As ddoTable
MainScreen.oDataGroupMovie.BeginTransaction
Set CountLayer = MainScreen.oDataGroupMovie.ExecuteSQLCommand("Select layer from movieshelf where shelfid = " + cmbIShelf)
MainScreen.oDataGroupMovie.CommitTransaction
cmbILayer.Clear   'ล้างข้อมูลใน ComboBox
cmbILayer.Text = 1
For i = 1 To CountLayer.Columns(1).Value
     cmbILayer.AddItem (i)
Next i
End Sub

Private Sub cmbUShelf_Click()
Dim i As Integer
Dim CountLayer As ddoTable
MainScreen.oDataGroupMovie.BeginTransaction
Set CountLayer = MainScreen.oDataGroupMovie.ExecuteSQLCommand("Select layer from movieshelf where shelfid = " + cmbIShelf)
MainScreen.oDataGroupMovie.CommitTransaction
cmbULayer.Clear   'ล้างข้อมูลใน ComboBox
cmbULayer.Text = 1
For i = 1 To CountLayer.Columns(1).Value
     cmbULayer.AddItem (i)
Next i
End Sub

Private Sub cmdIBrower_Click()
DialogInsert.ShowOpen
DialogInsert.Filter = "All type of movie"
txtIFilm.Text = DialogInsert.FileName
End Sub

Private Sub cmdInsert_Click()
Dim Parameter As String
Dim CountRow As ddoTable
Parameter = PrepareParameter 'Set String ของ Parameter ของคำสั่ง Insert Book
Parameter = "{CALL insertmovie(" + Parameter + ")}"
MainScreen.oDataGroupMovie.BeginTransaction
Set CountRow = MainScreen.oDataGroupMovie.ExecuteSQLCommand(Parameter)
MainScreen.oDataGroupMovie.CommitTransaction
If CountRow.Columns(2).Value = "N" Then
    MsgBox ("รหัสภาพยนตร์ที่คุณ Insert ซ้ำกับข้อมูลที่มีอยู่แล้ว")
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
P_SQL = """" + UCase(txtICode.Text) + """,""" + UCase(txtIName.Text) + """,""" + UCase(txtIActor1.Text) + _
              """,""" + UCase(txtIActor2.Text) + """,""" + UCase(cmbIClass) + """,""" + UCase(txtIPublishing.Text) + _
              """," + (txtIYear.Text) + ",'""" + txtIFilm.Text + """'," + cmbIShelf.Text + "," + cmbILayer + ",""" + Part + """"
PrepareParameter = P_SQL
End Function

Private Sub cmdSClear_Click()
Dim i As Byte
For i = 0 To 5
   Check2(i).Value = 0
   Text1(i).Text = ""
   Text1(i).Visible = False
Next i
   Check2(6).Value = 0
   cmbSClass.Visible = False
End Sub

Private Sub cmdSDelete_Click()
Dim DeleteSQL As String
oVTableResult.GotoRecord (TDBGridS1.Row + 1)
DeleteSQL = "delete from movie where movieid = " + oVTableResult.Columns(1).Value
MainScreen.oDataGroupMovie.BeginTransaction
MainScreen.oDataGroupMovie.ExecuteSQLCommand (DeleteSQL)
Set CountRowFirst = MainScreen.oDataGroupMovie.ExecuteSQLCommand("Select count(*) from movie")
MainScreen.oDataGroupMovie.CommitTransaction
txtICount.Text = CountRowFirst.Columns(1).Value
TDBGridS1.Refresh
Call PassSQL
End Sub

Private Sub cmdSSearch_Click()
Dim check As Boolean
Dim i As Byte
check = True
For i = 0 To 4
    If (Check2(i) = 1) And (Text1(i).Text = "") Then
       check = False
    End If
Next i
If check Then
Call PassSQL
Else: MsgBox ("โปรดใส่ข้อความที่คุณต้องการค้นหา ณ หัวข้อที่คุณเช็ค")
End If
End Sub

Private Sub PassSQL()
Dim SQLString As String
SQLString = PrepareParameterSearch
SQLString = "{CALL searchdetailmovie(" + SQLString + ")}"
'For direct SQL (DML) include transaction
MainScreen.oDataGroupMovie.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupMovie.ExecuteSQLCommand(SQLString)
MainScreen.oDataGroupMovie.CommitTransaction
Call ClearGrid
End Sub

Private Function PrepareParameterSearch() As String
Dim i As Byte
Dim SQL As String
If Check2(0).Value = 0 Then
    Text1(0).Text = "0"
End If
If Check2(5).Value = 0 Then
    Text1(5).Text = "0"
End If
For i = 0 To 4
    SQL = SQL + UCase(Text1(i).Text)
    If i = 0 Then
        SQL = Text1(i).Text + ","""
    ElseIf i <> 4 Then
        SQL = SQL + ""","""
End If
Next i
SQL = SQL + """," + Text1(5).Text + ","
If Check2(6).Value = 0 Then
     SQL = SQL + """"""           'ไม่ได้ทำการ Search ตามประเภทของภาพยนตร์
Else: SQL = SQL + """" + cmbSClass + """"
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
      MainScreen.oDataGroupMovie.DeleteVirtualTable ("oVTableResult")
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
        ColumnName(0) = "MOVIEID"
        ColumnName(1) = "MOVIECODE"
        ColumnName(2) = "MOVIENAME"
        ColumnName(3) = "ACTOR 1"
        ColumnName(4) = "ACTOR 2"
        ColumnName(5) = "PUBLISHING"
        ColumnName(6) = "YEAR"
        ColumnName(7) = "MOVIECLASS"
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
TabMovie.Tabs(2).Selected = True
Frame1(1).ZOrder 0
oVTableResult.GotoRecord (TDBGridS1.Row + 1)
Search_Update = "{Call SearchUpdateMovie(" + oVTableResult.Columns(1).Value + ")}"
Text3(0).Text = oVTableResult.Columns(1).Value
MainScreen.oDataGroupMovie.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupMovie.ExecuteSQLCommand(Search_Update)
MainScreen.oDataGroupMovie.CommitTransaction
Call Input_to_txt
End Sub

Private Sub cmdUBrowser_Click()
DialogUpdate.ShowOpen
DialogUpdate.Filter = "All type of movie"
Text3(7).Text = DialogUpdate.FileName
End Sub

Private Sub cmdUSearch_Click()
Dim Search_Update As String
Search_Update = "{Call SearchUpdateMovie(" + Text3(0).Text + ")}"
MainScreen.oDataGroupMovie.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupMovie.ExecuteSQLCommand(Search_Update)
MainScreen.oDataGroupMovie.CommitTransaction
Call Input_to_txt
End Sub

Private Sub Input_to_txt()
Dim i As Integer
If Not (oVTableResult Is Nothing) Then
    For i = 1 To 6
         Text3(i).Text = oVTableResult.Columns(i).Value
    Next i
        cmbUClass.Text = oVTableResult.Columns(7).Value
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
Else: MsgBox ("No Data in this Multimedia database")
        Text3(0).Text = ""
cmdUUpdate.Enabled = False
End If
MainScreen.oDataGroupMovie.DeleteVirtualTable ("oVTableResult")
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
               cmbUClass + """," + cmbUShelf + "," + cmbULayer + ",""" + Part + """"
PrepareparameterUpdate = U_SQL
End Function

Private Sub cmdUUpdate_Click()
Dim ParameterUpdate As String
Dim CheckUpdate  As ddoTable
ParameterUpdate = PrepareparameterUpdate
ParameterUpdate = "execute procedure UPDATEMOVIE(" + ParameterUpdate + ")"
MainScreen.oDataGroupMovie.BeginTransaction
Set CheckUpdate = MainScreen.oDataGroupMovie.ExecuteSQLCommand(ParameterUpdate)
MainScreen.oDataGroupMovie.CommitTransaction
MsgBox (" Update ข้อมูลเรียบร้อยแล้ว")
MainScreen.oDataGroupMovie.DeleteVirtualTable ("CheckUpdate")
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
     .Move TabMovie.ClientLeft + 40, _
      TabMovie.ClientTop + 40, _
      TabMovie.ClientWidth - 100, _
      TabMovie.ClientHeight - 100
     End With
Next i
Frame1(0).ZOrder 0
MainScreen.oDataGroupMovie.BeginTransaction
Set CountRowFirst = MainScreen.oDataGroupMovie.ExecuteSQLCommand("Select count(*) from movie")
Set CountShelf = MainScreen.oDataGroupMovie.ExecuteSQLCommand("Select shelfid,layer from movieshelf")
MainScreen.oDataGroupMovie.CommitTransaction
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
MainScreen.oDataGroupMovie.DeleteVirtualTable ("CountRowFirst")
MainScreen.oDataGroupMovie.DeleteVirtualTable ("CountShelf")
End Sub

Private Sub TabMovie_Click()
Frame1(TabMovie.SelectedItem.Index - 1).ZOrder 0
If TabMovie.Tabs(3).Selected Then
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

Private Sub txtIFilm_Change()
If checkInsert Then
  cmdInsert.Enabled = True
Else: cmdInsert.Enabled = False
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
