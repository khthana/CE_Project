VERSION 5.00
Object = "{00028C51-0000-0000-0000-000000000046}#1.0#0"; "TDBGS32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "Comctl32.OCX"
Begin VB.Form Shelf_Room 
   Caption         =   "Shelf&Room"
   ClientHeight    =   8190
   ClientLeft      =   1680
   ClientTop       =   285
   ClientWidth     =   8295
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8190
   ScaleWidth      =   8295
   StartUpPosition =   2  'CenterScreen
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
      ForeColor       =   &H000040C0&
      Height          =   6915
      Index           =   1
      Left            =   180
      TabIndex        =   2
      Top             =   420
      Width           =   7935
      Begin VB.Frame Frame2 
         Caption         =   "BookShelf"
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
         Height          =   3735
         Index           =   4
         Left            =   120
         TabIndex        =   47
         Top             =   180
         Width           =   3735
         Begin VB.CommandButton cmdUSearchBook 
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
            Height          =   435
            Left            =   1860
            Style           =   1  'Graphical
            TabIndex        =   92
            Top             =   240
            Width           =   795
         End
         Begin VB.TextBox txtUIDBook 
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
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   660
            TabIndex        =   91
            Top             =   360
            Width           =   675
         End
         Begin VB.TextBox txtUNBook 
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
            Left            =   1200
            TabIndex        =   53
            Top             =   900
            Width           =   1215
         End
         Begin VB.TextBox txtULBook 
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
            Left            =   1200
            TabIndex        =   52
            Top             =   1500
            Width           =   675
         End
         Begin VB.ComboBox cmbURBook 
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
            Left            =   1200
            TabIndex        =   51
            Top             =   2040
            Width           =   855
         End
         Begin VB.TextBox txtUPXBook 
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
            Left            =   660
            TabIndex        =   50
            Top             =   3060
            Width           =   915
         End
         Begin VB.TextBox txtUPYBook 
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
            Left            =   2220
            TabIndex        =   49
            Top             =   3060
            Width           =   915
         End
         Begin VB.CommandButton cmdUUpdateBook 
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
            Left            =   2460
            Style           =   1  'Graphical
            TabIndex        =   48
            Top             =   1980
            Width           =   855
         End
         Begin VB.Label Label1 
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
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   38
            Left            =   240
            TabIndex        =   90
            Top             =   480
            Width           =   195
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อของตู้"
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
            Index           =   24
            Left            =   240
            TabIndex        =   59
            Top             =   975
            Width           =   660
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "จำนวนชั้น"
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
            Index           =   23
            Left            =   240
            TabIndex        =   58
            Top             =   1530
            Width           =   780
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "เก็บในห้อง"
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
            Index           =   22
            Left            =   240
            TabIndex        =   57
            Top             =   2085
            Width           =   810
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ตำแหน่ง "
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
            Index           =   21
            Left            =   240
            TabIndex        =   56
            Top             =   2640
            Width           =   705
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Y :"
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
            Height          =   195
            Index           =   20
            Left            =   1860
            TabIndex        =   55
            Top             =   3120
            Width           =   240
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "X :"
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
            Height          =   195
            Index           =   19
            Left            =   240
            TabIndex        =   54
            Top             =   3120
            Width           =   240
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "MusicShelf"
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
         Height          =   3735
         Index           =   7
         Left            =   3960
         TabIndex        =   77
         Top             =   180
         Width           =   3855
         Begin VB.CommandButton cmdUSearchMusic 
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
            Height          =   435
            Left            =   2100
            Style           =   1  'Graphical
            TabIndex        =   95
            Top             =   240
            Width           =   795
         End
         Begin VB.TextBox txtUIDMusic 
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
            ForeColor       =   &H00008000&
            Height          =   315
            Left            =   780
            TabIndex        =   94
            Top             =   360
            Width           =   675
         End
         Begin VB.TextBox txtUNMusic 
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
            Left            =   1260
            TabIndex        =   83
            Top             =   900
            Width           =   1215
         End
         Begin VB.TextBox txtULMusic 
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
            Left            =   1260
            TabIndex        =   82
            Top             =   1500
            Width           =   675
         End
         Begin VB.ComboBox cmbURMusic 
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
            Left            =   1260
            TabIndex        =   81
            Top             =   2040
            Width           =   915
         End
         Begin VB.TextBox txtUPYMusic 
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
            Left            =   2280
            TabIndex        =   80
            Top             =   3060
            Width           =   975
         End
         Begin VB.CommandButton cmdUUpdateMusic 
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
            Left            =   2640
            Style           =   1  'Graphical
            TabIndex        =   79
            Top             =   1980
            Width           =   795
         End
         Begin VB.TextBox txtUPXMusic 
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
            Left            =   600
            TabIndex        =   78
            Top             =   3060
            Width           =   975
         End
         Begin VB.Label Label1 
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
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   39
            Left            =   300
            TabIndex        =   93
            Top             =   420
            Width           =   195
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อของตู้"
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
            Index           =   37
            Left            =   300
            TabIndex        =   89
            Top             =   975
            Width           =   660
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "จำนวนชั้น"
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
            Index           =   36
            Left            =   300
            TabIndex        =   88
            Top             =   1530
            Width           =   780
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "เก็บในห้อง"
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
            Index           =   35
            Left            =   300
            TabIndex        =   87
            Top             =   2085
            Width           =   810
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ตำแหน่ง "
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
            Index           =   34
            Left            =   300
            TabIndex        =   86
            Top             =   2640
            Width           =   705
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Y :"
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
            Height          =   195
            Index           =   33
            Left            =   1920
            TabIndex        =   85
            Top             =   3120
            Width           =   240
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "X :"
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
            Height          =   195
            Index           =   32
            Left            =   300
            TabIndex        =   84
            Top             =   3120
            Width           =   240
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "MovieShelf"
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
         Height          =   1635
         Index           =   6
         Left            =   120
         TabIndex        =   64
         Top             =   3960
         Width           =   7695
         Begin VB.CommandButton cmdUSearchMovie 
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
            Height          =   435
            Left            =   1860
            Style           =   1  'Graphical
            TabIndex        =   98
            Top             =   300
            Width           =   795
         End
         Begin VB.TextBox txtUIDMovie 
            BackColor       =   &H00C0E0FF&
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
            Left            =   660
            TabIndex        =   97
            Top             =   360
            Width           =   675
         End
         Begin VB.TextBox txtUNMovie 
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
            TabIndex        =   70
            Top             =   420
            Width           =   1215
         End
         Begin VB.TextBox txtULMovie 
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
            Left            =   6600
            TabIndex        =   69
            Top             =   420
            Width           =   675
         End
         Begin VB.ComboBox cmbURMovie 
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
            Left            =   1200
            TabIndex        =   68
            Top             =   960
            Width           =   855
         End
         Begin VB.TextBox txtUPXMovie 
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
            Left            =   3600
            TabIndex        =   67
            Top             =   960
            Width           =   975
         End
         Begin VB.TextBox txtUPYMovie 
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
            Left            =   5160
            TabIndex        =   66
            Top             =   960
            Width           =   975
         End
         Begin VB.CommandButton cmdUUpdateMovie 
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
            Left            =   6540
            Style           =   1  'Graphical
            TabIndex        =   65
            Top             =   900
            Width           =   795
         End
         Begin VB.Label Label1 
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
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   40
            Left            =   240
            TabIndex        =   96
            Top             =   420
            Width           =   195
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อของตู้"
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
            Index           =   31
            Left            =   3060
            TabIndex        =   76
            Top             =   480
            Width           =   660
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "จำนวนชั้น"
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
            Index           =   30
            Left            =   5520
            TabIndex        =   75
            Top             =   480
            Width           =   780
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "เก็บในห้อง"
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
            Index           =   29
            Left            =   240
            TabIndex        =   74
            Top             =   1020
            Width           =   810
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ตำแหน่ง "
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
            Index           =   28
            Left            =   2460
            TabIndex        =   73
            Top             =   1020
            Width           =   705
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Y :"
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
            Height          =   195
            Index           =   27
            Left            =   4860
            TabIndex        =   72
            Top             =   1020
            Width           =   240
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "X :"
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
            Height          =   195
            Index           =   26
            Left            =   3240
            TabIndex        =   71
            Top             =   1020
            Width           =   240
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Room"
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
         Index           =   5
         Left            =   120
         TabIndex        =   60
         Top             =   5640
         Width           =   7695
         Begin VB.CommandButton cmdUSearchRoom 
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
            Height          =   435
            Left            =   1980
            Style           =   1  'Graphical
            TabIndex        =   101
            Top             =   420
            Width           =   795
         End
         Begin VB.TextBox txtUIDRoom 
            BackColor       =   &H00FFFFC0&
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
            Left            =   900
            TabIndex        =   100
            Top             =   480
            Width           =   675
         End
         Begin VB.TextBox txtUNRoom 
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
            Left            =   4500
            TabIndex        =   62
            Top             =   480
            Width           =   1275
         End
         Begin VB.CommandButton cmdUUpdateRoom 
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
            Left            =   6540
            Style           =   1  'Graphical
            TabIndex        =   61
            Top             =   420
            Width           =   795
         End
         Begin VB.Label Label1 
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
            ForeColor       =   &H00FF0000&
            Height          =   195
            Index           =   41
            Left            =   480
            TabIndex        =   99
            Top             =   540
            Width           =   195
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อของห้อง"
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
            Index           =   25
            Left            =   3420
            TabIndex        =   63
            Top             =   540
            Width           =   870
         End
      End
   End
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
      Left            =   3720
      Style           =   1  'Graphical
      TabIndex        =   112
      Top             =   7620
      Width           =   915
   End
   Begin ComctlLib.TabStrip TabShelf_Room 
      Height          =   7395
      Left            =   60
      TabIndex        =   0
      Top             =   60
      Width           =   8175
      _ExtentX        =   14420
      _ExtentY        =   13044
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
         Size            =   8.25
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
      Height          =   6855
      Index           =   2
      Left            =   180
      TabIndex        =   3
      Top             =   420
      Width           =   7935
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
         Height          =   555
         Left            =   6000
         Style           =   1  'Graphical
         TabIndex        =   105
         ToolTipText     =   "Delete"
         Top             =   5940
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
         Height          =   555
         Left            =   3420
         Style           =   1  'Graphical
         TabIndex        =   104
         ToolTipText     =   "Update"
         Top             =   5940
         Width           =   915
      End
      Begin VB.CommandButton cmdSSearch 
         BackColor       =   &H0080C0FF&
         Caption         =   "&Select"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   555
         Left            =   840
         MaskColor       =   &H00E0E0E0&
         Style           =   1  'Graphical
         TabIndex        =   103
         ToolTipText     =   "Select"
         Top             =   5940
         Width           =   915
      End
      Begin VB.Frame Frame3 
         Caption         =   "ประเภทของการค้นหา"
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
         Height          =   1095
         Left            =   180
         TabIndex        =   102
         Top             =   4500
         Width           =   7575
         Begin VB.OptionButton Option1 
            Caption         =   "ห้องสมุด"
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
            Height          =   375
            Index           =   3
            Left            =   6000
            TabIndex        =   111
            Top             =   420
            Width           =   975
         End
         Begin VB.OptionButton Option1 
            Caption         =   "ตู้เก็บภาพยนตร์"
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
            Height          =   375
            Index           =   2
            Left            =   3960
            TabIndex        =   110
            Top             =   420
            Width           =   1575
         End
         Begin VB.OptionButton Option1 
            Caption         =   "ตู้เก็บเพลง"
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
            Height          =   375
            Index           =   1
            Left            =   2280
            TabIndex        =   109
            Top             =   420
            Width           =   1155
         End
         Begin VB.OptionButton Option1 
            Caption         =   "ตู้เก็บหนังสือ"
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
            Height          =   375
            Index           =   0
            Left            =   420
            TabIndex        =   108
            Top             =   420
            Width           =   1275
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "แสดงผลของการค้นหา"
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
         Left            =   120
         TabIndex        =   106
         Top             =   240
         Width           =   7695
         Begin TrueDBGridStd.TDBGridS TDBGridS1 
            Height          =   3675
            Left            =   180
            OleObjectBlob   =   "Shelf_Room.frx":0000
            TabIndex        =   107
            Top             =   300
            Width           =   7335
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
      Height          =   6915
      Index           =   0
      Left            =   180
      TabIndex        =   1
      Top             =   420
      Width           =   7935
      Begin VB.Frame Frame2 
         Caption         =   "BookShelf"
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
         Height          =   3255
         Index           =   0
         Left            =   120
         TabIndex        =   4
         Top             =   180
         Width           =   3795
         Begin VB.CommandButton cmdIBook 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Insert"
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
            Left            =   2580
            Style           =   1  'Graphical
            TabIndex        =   18
            Top             =   1380
            Width           =   795
         End
         Begin VB.TextBox txtIPYBook 
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
            Left            =   2220
            TabIndex        =   17
            Top             =   2460
            Width           =   1035
         End
         Begin VB.TextBox txtIPXBook 
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
            Left            =   600
            TabIndex        =   15
            Top             =   2460
            Width           =   1035
         End
         Begin VB.ComboBox cmbIRBook 
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
            Left            =   1140
            TabIndex        =   13
            Top             =   1440
            Width           =   855
         End
         Begin VB.TextBox txtILBook 
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
            Left            =   1140
            TabIndex        =   11
            Top             =   900
            Width           =   675
         End
         Begin VB.TextBox txtINBook 
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
            Left            =   1140
            TabIndex        =   10
            Top             =   360
            Width           =   1215
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "X :"
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
            Height          =   195
            Index           =   5
            Left            =   180
            TabIndex        =   19
            Top             =   2520
            Width           =   240
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Y :"
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
            Height          =   195
            Index           =   4
            Left            =   1800
            TabIndex        =   16
            Top             =   2520
            Width           =   240
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ตำแหน่ง "
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
            Left            =   180
            TabIndex        =   14
            Top             =   1980
            Width           =   705
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "เก็บในห้อง"
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
            Left            =   180
            TabIndex        =   12
            Top             =   1460
            Width           =   810
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "จำนวนชั้น"
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
            Left            =   180
            TabIndex        =   9
            Top             =   940
            Width           =   780
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อของตู้"
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
            Left            =   180
            TabIndex        =   8
            Top             =   420
            Width           =   660
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Room"
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
         Height          =   1395
         Index           =   3
         Left            =   120
         TabIndex        =   7
         Top             =   5400
         Width           =   7635
         Begin VB.CommandButton cmdIRoom 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Insert"
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
            Left            =   4860
            Style           =   1  'Graphical
            TabIndex        =   45
            Top             =   480
            Width           =   795
         End
         Begin VB.TextBox txtINRoom 
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
            Left            =   2580
            TabIndex        =   44
            Top             =   540
            Width           =   1575
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อของห้อง"
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
            Index           =   18
            Left            =   1500
            TabIndex        =   43
            Top             =   600
            Width           =   870
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "MovieShelf"
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
         Height          =   1875
         Index           =   2
         Left            =   120
         TabIndex        =   6
         Top             =   3480
         Width           =   7635
         Begin VB.CommandButton cmdIMovie 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Insert"
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
            Left            =   5880
            Style           =   1  'Graphical
            TabIndex        =   42
            Top             =   360
            Width           =   795
         End
         Begin VB.TextBox txtIPYMovie 
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
            Left            =   6060
            TabIndex        =   40
            Top             =   1140
            Width           =   915
         End
         Begin VB.TextBox txtIPXMovie 
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
            Left            =   4380
            TabIndex        =   38
            Top             =   1140
            Width           =   915
         End
         Begin VB.ComboBox cmbIRMovie 
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
            Left            =   1200
            TabIndex        =   36
            Top             =   1140
            Width           =   915
         End
         Begin VB.TextBox txtILMovie 
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
            Left            =   4020
            TabIndex        =   34
            Top             =   480
            Width           =   675
         End
         Begin VB.TextBox txtINMovie 
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
            Left            =   1200
            TabIndex        =   33
            Top             =   420
            Width           =   1215
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "X :"
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
            Height          =   195
            Index           =   17
            Left            =   3900
            TabIndex        =   41
            Top             =   1200
            Width           =   240
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Y :"
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
            Height          =   195
            Index           =   16
            Left            =   5640
            TabIndex        =   39
            Top             =   1200
            Width           =   240
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ตำแหน่ง "
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
            Left            =   2940
            TabIndex        =   37
            Top             =   1200
            Width           =   705
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "เก็บในห้อง"
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
            Index           =   14
            Left            =   180
            TabIndex        =   35
            Top             =   1200
            Width           =   810
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "จำนวนชั้น"
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
            Index           =   13
            Left            =   2940
            TabIndex        =   32
            Top             =   540
            Width           =   780
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อของตู้"
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
            Index           =   12
            Left            =   180
            TabIndex        =   31
            Top             =   480
            Width           =   660
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "MusicShelf"
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
         Height          =   3255
         Index           =   1
         Left            =   4020
         TabIndex        =   5
         Top             =   180
         Width           =   3735
         Begin VB.TextBox txtIPXMusic 
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
            Left            =   720
            TabIndex        =   46
            Top             =   2460
            Width           =   915
         End
         Begin VB.CommandButton cmdIMusic 
            BackColor       =   &H0080C0FF&
            Caption         =   "&Insert"
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
            Left            =   2640
            Style           =   1  'Graphical
            TabIndex        =   30
            Top             =   1320
            Width           =   795
         End
         Begin VB.TextBox txtIPYMusic 
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
            Left            =   2340
            TabIndex        =   29
            Top             =   2460
            Width           =   915
         End
         Begin VB.ComboBox cmbIRMusic 
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
            Left            =   1200
            TabIndex        =   28
            Top             =   1380
            Width           =   915
         End
         Begin VB.TextBox txtILMusic 
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
            Left            =   1200
            TabIndex        =   27
            Top             =   900
            Width           =   675
         End
         Begin VB.TextBox txtINMusic 
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
            Left            =   1200
            TabIndex        =   26
            Top             =   360
            Width           =   1275
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "X :"
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
            Height          =   195
            Index           =   11
            Left            =   300
            TabIndex        =   25
            Top             =   2520
            Width           =   240
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Y :"
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
            Height          =   195
            Index           =   10
            Left            =   1920
            TabIndex        =   24
            Top             =   2520
            Width           =   240
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ตำแหน่ง "
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
            Left            =   240
            TabIndex        =   23
            Top             =   1980
            Width           =   705
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "เก็บในห้อง"
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
            Left            =   240
            TabIndex        =   22
            Top             =   1460
            Width           =   810
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "จำนวนชั้น"
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
            Left            =   240
            TabIndex        =   21
            Top             =   940
            Width           =   780
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อของตู้"
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
            Left            =   240
            TabIndex        =   20
            Top             =   420
            Width           =   660
         End
      End
   End
End
Attribute VB_Name = "Shelf_Room"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim CountRoom As ddoTable
Dim oVTableResult As ddoTable
Dim ColumnName() As String
Dim SQLSearchAll As String

Private Sub cmdIBook_Click()
Dim SQLInsertShelf As String
SQLInsertShelf = "execute procedure insertbookshelf(" + """" + UCase(txtINBook) + """," + _
                            txtILBook + "," + cmbIRBook + "," + txtIPXBook + "," + txtIPYBook + ")"
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLInsertShelf)
MainScreen.oDataGroupBook.CommitTransaction
MsgBox "Insert  ตู้เก็บหนังสือเรียบร้อยแล้ว", , "Insert ตู้เก็บหนังสือ"
End Sub

Private Sub cmdIMovie_Click()
Dim SQLInsertShelf As String
SQLInsertShelf = "execute procedure insertmovieshelf(" + """" + UCase(txtINMovie) + """," + _
                         txtILMovie + "," + cmbIRMovie + "," + txtIPXMovie + "," + txtIPYMovie + ")"
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLInsertShelf)
MainScreen.oDataGroupBook.CommitTransaction
MsgBox "Insert  ตู้เก็บภาพยนตร์เรียบร้อยแล้ว", , "Insert ตู้เก็บภาพยนตร์"
End Sub

Private Sub cmdIMusic_Click()
Dim SQLInsertShelf As String
SQLInsertShelf = "execute procedure insertmusicshelf(" + """" + UCase(txtINMusic) + """," + _
                         txtILMusic + "," + cmbIRMusic + "," + txtIPXMusic + "," + txtIPYMusic + ")"
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLInsertShelf)
MainScreen.oDataGroupBook.CommitTransaction
MsgBox "Insert  ตู้เก็บเพลงเรียบร้อยแล้ว", , "Insert ตู้เก็บเพลง"
End Sub

Private Sub cmdIRoom_Click()
Dim SQLInsertRoom As String
SQLInsertRoom = "Insert Into room Values(0,""" + UCase(txtINRoom) + """)"
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLInsertRoom)
MainScreen.oDataGroupBook.CommitTransaction
MsgBox "Insert ห้องสมุดเรียบร้อยแล้ว", , "Insert Room"
Call SetcmbCountRoom
End Sub

Private Sub cmdSDelete_Click()
Dim DeleteSQL As String
Dim Typedelete As String
oVTableResult.GotoRecord (TDBGridS1.Row + 1)
If (Option1(0).Value) Then
    Typedelete = "0"        'ลบตู้เก็บหนังสือ
ElseIf (Option1(1).Value) Then
    Typedelete = "1"        'ลบตู้เก็บเพลง
ElseIf (Option1(2).Value) Then
    Typedelete = "2"        'ลบตู้เก็บภาพยนตร์
Else: Typedelete = "3"    'ลบห้องสมุด
End If
DeleteSQL = "execute procedure DELETESHELF_ROOM(" + oVTableResult.Columns(1).Value + "," + Typedelete + ")"
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (DeleteSQL)
Set oVTableResult = MainScreen.oDataGroupBook.ExecuteSQLCommand(SQLSearchAll)
MainScreen.oDataGroupBook.CommitTransaction
TDBGridS1.Refresh
Call SetcmbCountRoom
Call ClearGrid
End Sub

Private Sub cmdSSearch_Click()
MainScreen.oDataGroupBook.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupBook.ExecuteSQLCommand(SQLSearchAll)
MainScreen.oDataGroupBook.CommitTransaction
Call ClearGrid
End Sub
Private Sub ClearGrid()
    Dim i As Integer
    Dim rc As Integer
    rc = 0
   ' Remove all the columns from the grid
    For i = TDBGridS1.Columns.Count To 0 Step -1
        If i = 0 Then Exit For
        TDBGridS1.Columns.Remove (i - 1)
    Next i
If Not (oVTableResult Is Nothing) Then                  'Have data return
        Call SetColumnname
        cmdSDelete.Enabled = True
        cmdSUpdate.Enabled = True
Else: MsgBox "No Data in this Multimedia database", , "No Data"
         MainScreen.oDataGroupBook.DeleteVirtualTable ("oVTableResult")
        cmdSDelete.Enabled = False
        cmdSUpdate.Enabled = False
End If
End Sub
Private Sub SetColumnname()
   Dim c As Object
   Dim i As Byte
   If Option1(0) Or Option1(1) Or Option1(2) Then
        ReDim ColumnName(6)
        ColumnName(0) = "SHELFID"
        ColumnName(1) = "SHELFNAME"
        ColumnName(2) = "LAYER"
        ColumnName(3) = "ROOMID"
        ColumnName(4) = "POSITION_X"
        ColumnName(5) = "POSITION_Y"
   Else
        ReDim ColumnName(2)
        ColumnName(0) = "ROOMID"
        ColumnName(1) = "ROOMNAME"
   End If
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
TabShelf_Room.Tabs(2).Selected = True
Frame1(1).ZOrder 0
oVTableResult.GotoRecord (TDBGridS1.Row + 1)
If (Option1(0).Value) Then
       txtUIDBook.Text = oVTableResult.Columns(1).Value
       txtUNBook.Text = oVTableResult.Columns(2).Value
       txtULBook.Text = oVTableResult.Columns(3).Value
       cmbURBook.Text = oVTableResult.Columns(4).Value
       txtUPXBook = oVTableResult.Columns(5).Value
       txtUPYBook = oVTableResult.Columns(6).Value
       cmdUUpdateBook.Enabled = True
ElseIf (Option1(1).Value) Then
       txtUIDMusic.Text = oVTableResult.Columns(1).Value
       txtUNMusic.Text = oVTableResult.Columns(2).Value
       txtULMusic.Text = oVTableResult.Columns(3).Value
       cmbURMusic.Text = oVTableResult.Columns(4).Value
       txtUPXMusic = oVTableResult.Columns(5).Value
       txtUPYMusic = oVTableResult.Columns(6).Value
       cmdUUpdateMusic.Enabled = True
ElseIf (Option1(2).Value) Then
       txtUIDMovie.Text = oVTableResult.Columns(1).Value
       txtUNMovie.Text = oVTableResult.Columns(2).Value
       txtULMovie.Text = oVTableResult.Columns(3).Value
       cmbURMovie.Text = oVTableResult.Columns(4).Value
       txtUPXMovie.Text = oVTableResult.Columns(5).Value
       txtUPYMovie.Text = oVTableResult.Columns(6).Value
       cmdUUpdateMovie.Enabled = True
Else: txtUIDRoom.Text = oVTableResult.Columns(1).Value
        txtUNRoom.Text = oVTableResult.Columns(2).Value
        cmdUUpdateRoom.Enabled = True
End If
End Sub

Private Sub cmdUSearchBook_Click()
Dim SearchDetail As ddoTable
Dim SQLSearch As String
SQLSearch = "Select shelfname,layer,roomid,position.x,position.y from bookshelf t1,addressbookshelf t2 where t1.shelfid = " + txtUIDBook
MainScreen.oDataGroupBook.BeginTransaction
Set SearchDetail = MainScreen.oDataGroupBook.ExecuteSQLCommand(SQLSearch)
MainScreen.oDataGroupBook.CommitTransaction
If Not (SearchDetail Is Nothing) Then
    txtUNBook.Text = SearchDetail.Columns(1).Value
    txtULBook.Text = SearchDetail.Columns(2).Value
    cmbURBook.Text = SearchDetail.Columns(3).Value
    txtUPXBook.Text = SearchDetail.Columns(4).Value
    txtUPYBook.Text = SearchDetail.Columns(5).Value
    cmdUUpdateBook.Enabled = True
Else: MsgBox "No Data in this Multimedia database", , "No Data"
        txtUIDBook.Text = ""
        cmdUUpdateBook.Enabled = False
End If
End Sub

Private Sub cmdUSearchMovie_Click()
Dim SearchDetail As ddoTable
Dim SQLSearch As String
SQLSearch = "Select shelfname,layer,roomid,position.x,position.y from movieshelf t1,addressmovieshelf t2 where t1.shelfid = " + txtUIDMovie
MainScreen.oDataGroupBook.BeginTransaction
Set SearchDetail = MainScreen.oDataGroupBook.ExecuteSQLCommand(SQLSearch)
MainScreen.oDataGroupBook.CommitTransaction
If Not (SearchDetail Is Nothing) Then
    txtUNMovie.Text = SearchDetail.Columns(1).Value
    txtULMovie.Text = SearchDetail.Columns(2).Value
    cmbURMovie.Text = SearchDetail.Columns(3).Value
    txtUPXMovie.Text = SearchDetail.Columns(4).Value
    txtUPYMovie.Text = SearchDetail.Columns(5).Value
    cmdUUpdateMovie.Enabled = True
Else: MsgBox "No Data in this Multimedia database", , "No Data"
        txtUIDMovie.Text = ""
        cmdUUpdateMovie.Enabled = False
End If
End Sub

Private Sub cmdUSearchMusic_Click()
Dim SearchDetail As ddoTable
Dim SQLSearch As String
SQLSearch = "Select shelfname,layer,roomid,position.x,position.y from musicshelf t1,addressmusicshelf t2 where t1.shelfid = " + txtUIDMusic
MainScreen.oDataGroupBook.BeginTransaction
Set SearchDetail = MainScreen.oDataGroupBook.ExecuteSQLCommand(SQLSearch)
MainScreen.oDataGroupBook.CommitTransaction
If Not (SearchDetail Is Nothing) Then
    txtUNMusic.Text = SearchDetail.Columns(1).Value
    txtULMusic.Text = SearchDetail.Columns(2).Value
    cmbURMusic.Text = SearchDetail.Columns(3).Value
    txtUPXMusic.Text = SearchDetail.Columns(4).Value
    txtUPYMusic.Text = SearchDetail.Columns(5).Value
     cmdUUpdateMusic.Enabled = True
Else: MsgBox "No Data in this Multimedia database", , "No Data"
        txtUIDMusic.Text = ""
        cmdUUpdateMusic.Enabled = False
End If
End Sub

Private Sub cmdUSearchRoom_Click()
Dim SearchDetail As ddoTable
Dim SQLSearch As String
SQLSearch = "Select roomname from room where roomid = " + txtUIDRoom
MainScreen.oDataGroupBook.BeginTransaction
Set SearchDetail = MainScreen.oDataGroupBook.ExecuteSQLCommand(SQLSearch)
MainScreen.oDataGroupBook.CommitTransaction
If Not (SearchDetail Is Nothing) Then
    txtUNRoom.Text = SearchDetail.Columns(1).Value
    cmdUUpdateRoom.Enabled = True
Else: MsgBox "No Data in this Multimedia database", , "No Data"
        txtUIDRoom.Text = ""
        cmdUUpdateRoom.Enabled = False
End If
End Sub

Private Sub cmdUUpdateBook_Click()
Dim SQLUpdate1, SQLUpdate2 As String
SQLUpdate1 = "Update bookshelf Set shelfname = """ + UCase(txtUNBook) + """" + _
                         ",layer = " + txtULBook + " where shelfid = " + txtUIDBook
SQLUpdate2 = "Update addressbookshelf Set roomid = " + cmbURBook + _
                         ",position = Row(" + txtUPXBook + " ," + txtUPYBook + ")::position_t" + _
                         " where shelfid = " + txtUIDBook
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLUpdate1)
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLUpdate2)
MainScreen.oDataGroupBook.CommitTransaction
MsgBox "Update ข้อมูลของตู้เก็บหนังสือเรียบร้อยแล้ว", , "Update ตู้เก็บหนังสือ"
End Sub

Private Sub cmdUUpdateMovie_Click()
Dim SQLUpdate1, SQLUpdate2 As String
SQLUpdate1 = "Update movieshelf Set shelfname = """ + UCase(txtUNMovie) + """" + _
                         ",layer = " + txtULMovie + " where shelfid = " + txtUIDMovie
SQLUpdate2 = "Update addressmovieshelf Set roomid = " + cmbURMovie + _
                         ",position = Row(" + txtUPXMovie + " ," + txtUPYMovie + ")::position_t" + _
                         " where shelfid = " + txtUIDMovie
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLUpdate1)
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLUpdate2)
MainScreen.oDataGroupBook.CommitTransaction
MsgBox "Update ข้อมูลของตู้เก็บภาพยนตร์เรียบร้อยแล้ว", , "Update ตู้เก็บภาพยนตร์"
End Sub

Private Sub cmdUUpdateMusic_Click()
Dim SQLUpdate1, SQLUpdate2 As String
SQLUpdate1 = "Update musicshelf Set shelfname = """ + UCase(txtUNMusic) + """" + _
                         ",layer = " + txtULMusic + " where shelfid = " + txtUIDMusic
SQLUpdate2 = "Update addressmusicshelf Set roomid = " + cmbURMusic + _
                         ",position = Row(" + txtUPXMusic + " ," + txtUPYMusic + ")::position_t" + _
                         " where shelfid = " + txtUIDMusic
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLUpdate1)
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLUpdate2)
MainScreen.oDataGroupBook.CommitTransaction
MsgBox "Update ข้อมูลของตู้เก็บเพลงเรียบร้อยแล้ว", , "Update ตู้เก็บเพลง"
End Sub

Private Sub cmdUUpdateRoom_Click()
Dim SQLUpdate1, SQLUpdate2 As String
SQLUpdate1 = "Update room Set roomname = """ + UCase(txtUNRoom) + """" + _
                         " where roomid = " + txtUIDRoom
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (SQLUpdate1)
MainScreen.oDataGroupBook.CommitTransaction
MsgBox "Update ข้อมูลของห้องสมุดเรียบร้อยแล้ว", , "Update ห้องสมุด"
End Sub

Private Sub Command1_Click()
MenuAdmin.Show
Unload Me
End Sub

Private Sub Form_Load()
Dim i As Byte
For i = 0 To Frame1.Count - 1
     With Frame1(i)
     .Move TabShelf_Room.ClientLeft + 40, _
      TabShelf_Room.ClientTop + 40, _
      TabShelf_Room.ClientWidth - 100, _
      TabShelf_Room.ClientHeight - 100
     End With
Next i
Frame1(0).ZOrder 0
Call SetcmbCountRoom
End Sub

Private Sub SetcmbCountRoom()
MainScreen.oDataGroupBook.BeginTransaction
Set CountRoom = MainScreen.oDataGroupBook.ExecuteSQLCommand("Select roomid from room")
MainScreen.oDataGroupBook.CommitTransaction
If Not (CountRoom Is Nothing) Then
    cmbIRBook.Clear
    cmbIRMusic.Clear
    cmbIRMovie.Clear
    cmbIRBook.Text = CountRoom.Columns(1).Value
    cmbIRMusic.Text = CountRoom.Columns(1).Value
    cmbIRMovie.Text = CountRoom.Columns(1).Value
    cmbURBook.Clear
    cmbURMusic.Clear
    cmbURMovie.Clear
    cmbURBook.Text = CountRoom.Columns(1).Value
    cmbURMusic.Text = CountRoom.Columns(1).Value
    cmbURMovie.Text = CountRoom.Columns(1).Value
    Do While CountRoom.EOT = False 'เพิ่มข้อมูลเข้าไปใน cmbIShelf และ cmbILayer
        cmbIRBook.AddItem (CountRoom.Columns(1).Value)
        cmbIRMusic.AddItem (CountRoom.Columns(1).Value)
        cmbIRMovie.AddItem (CountRoom.Columns(1).Value)
        cmbURBook.AddItem (CountRoom.Columns(1).Value)
        cmbURMusic.AddItem (CountRoom.Columns(1).Value)
        cmbURMovie.AddItem (CountRoom.Columns(1).Value)
        CountRoom.NextRecord
    Loop
End If
End Sub

Private Sub Option1_Click(Index As Integer)
If Index = 0 Then
    SQLSearchAll = "select t1.shelfid,shelfname,layer,t2.roomid,position.x,position.y" + _
                          " from bookshelf t1,addressbookshelf t2,room t3" + _
                          " where t2.shelfid = t1.shelfid and t3.roomid = t2.roomid"
ElseIf Index = 1 Then
     SQLSearchAll = "select t1.shelfid,shelfname,layer,t2.roomid,position.x,position.y" + _
                          " from musicshelf t1,addressmusicshelf t2,room t3" + _
                          " where t2.shelfid = t1.shelfid and t3.roomid = t2.roomid"
ElseIf Index = 2 Then
      SQLSearchAll = "select t1.shelfid,shelfname,layer,t2.roomid,position.x,position.y" + _
                          " from movieshelf t1,addressmovieshelf t2,room t3" + _
                          " where t2.shelfid = t1.shelfid and t3.roomid = t2.roomid"
Else
      SQLSearchAll = "select roomid,roomname from room"
End If
End Sub

Private Sub TabShelf_Room_Click()
Frame1(TabShelf_Room.SelectedItem.Index - 1).ZOrder 0
If TabShelf_Room.Tabs(3).Selected Then
   cmdSDelete.Enabled = False
   cmdSUpdate.Enabled = False
   cmdUUpdateBook.Enabled = False
   cmdUUpdateMusic.Enabled = False
   cmdUUpdateMovie.Enabled = False
   cmdUUpdateRoom.Enabled = False
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

Private Sub txtUIDBook_Change()
Dim CheckInteger As String
CheckInteger = Val(txtUIDBook.Text)
If CheckInteger = txtUIDBook.Text Then
     cmdUSearchBook.Enabled = True
Else: cmdUSearchBook.Enabled = False
End If
End Sub

Private Sub txtUIDMovie_Change()
Dim CheckInteger As String
CheckInteger = Val(txtUIDMovie.Text)
If CheckInteger = txtUIDMovie.Text Then
     cmdUSearchMovie.Enabled = True
Else: cmdUSearchMovie.Enabled = False
End If
End Sub

Private Sub txtUIDMusic_Change()
Dim CheckInteger As String
CheckInteger = Val(txtUIDMusic.Text)
If CheckInteger = txtUIDMusic.Text Then
     cmdUSearchMusic.Enabled = True
Else: cmdUSearchMusic.Enabled = False
End If
End Sub

Private Sub txtUIDRoom_Change()
Dim CheckInteger As String
CheckInteger = Val(txtUIDRoom.Text)
If CheckInteger = txtUIDRoom.Text Then
     cmdUSearchRoom.Enabled = True
Else: cmdUSearchRoom.Enabled = False
End If
End Sub
