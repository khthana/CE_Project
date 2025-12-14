VERSION 5.00
Object = "{00028C51-0000-0000-0000-000000000046}#1.0#0"; "TDBGS32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "Comctl32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Book 
   Caption         =   "For Administrator control Book"
   ClientHeight    =   7305
   ClientLeft      =   225
   ClientTop       =   1365
   ClientWidth     =   11595
   Icon            =   "Book.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7305
   ScaleWidth      =   11595
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdUClose 
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
      Left            =   5400
      Style           =   1  'Graphical
      TabIndex        =   63
      Top             =   6780
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
      Height          =   5955
      Index           =   1
      Left            =   240
      TabIndex        =   2
      Top             =   480
      Width           =   11175
      Begin VB.Frame Frame4 
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
         Height          =   4155
         Left            =   180
         TabIndex        =   69
         Top             =   180
         Width           =   10815
         Begin VB.CommandButton cmdUBrowserPreface 
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
            Left            =   7440
            Style           =   1  'Graphical
            TabIndex        =   101
            Top             =   3480
            Width           =   975
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ประเภทของหนังสือ"
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
            Height          =   255
            Index           =   10
            Left            =   300
            TabIndex        =   99
            Top             =   2520
            Width           =   1875
         End
         Begin VB.TextBox Text3 
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
            Index           =   10
            Left            =   1620
            TabIndex        =   97
            Top             =   3540
            Width           =   5655
         End
         Begin VB.TextBox Text3 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00C0FFFF&
            BeginProperty DataFormat 
               Type            =   1
               Format          =   "0"
               HaveTrueFalseNull=   0
               FirstDayOfWeek  =   0
               FirstWeekOfYear =   0
               LCID            =   1054
               SubFormatType   =   1
            EndProperty
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
            TabIndex        =   92
            Top             =   420
            Width           =   915
         End
         Begin VB.CommandButton cmdUBrowserTitle 
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
            Left            =   7440
            Style           =   1  'Graphical
            TabIndex        =   91
            Top             =   2940
            Width           =   975
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ISBN"
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
            Height          =   255
            Index           =   5
            Left            =   4320
            TabIndex        =   84
            Top             =   2520
            Width           =   735
         End
         Begin VB.CheckBox Check1 
            Caption         =   "สำนักพิมพ์"
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
            Height          =   255
            Index           =   6
            Left            =   300
            TabIndex        =   83
            Top             =   1980
            Width           =   1215
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ปีที่พิมพ์"
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
            Height          =   255
            Index           =   7
            Left            =   7140
            TabIndex        =   82
            Top             =   2460
            Width           =   1035
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ชื่อหนังสือ"
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
            Height          =   255
            Index           =   1
            Left            =   300
            TabIndex        =   81
            Top             =   1440
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
            Left            =   5220
            TabIndex        =   80
            Top             =   2460
            Width           =   1515
         End
         Begin VB.TextBox Text3 
            BackColor       =   &H00FFFFFF&
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
            Left            =   1620
            TabIndex        =   79
            Top             =   1380
            Width           =   5175
         End
         Begin VB.TextBox Text3 
            BackColor       =   &H00FFFFFF&
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
            Left            =   5160
            TabIndex        =   78
            Top             =   780
            Width           =   1575
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
            TabIndex        =   77
            Top             =   840
            Width           =   915
         End
         Begin VB.ComboBox cmbUClass 
            BackColor       =   &H00FFFFFF&
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
            ItemData        =   "Book.frx":0442
            Left            =   2340
            List            =   "Book.frx":0455
            Sorted          =   -1  'True
            TabIndex        =   76
            Text            =   "CARTOON"
            Top             =   2460
            Width           =   1455
         End
         Begin VB.TextBox Text3 
            BackColor       =   &H00FFFFFF&
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
            Left            =   1620
            TabIndex        =   75
            Top             =   1920
            Width           =   5175
         End
         Begin VB.TextBox Text3 
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
            Index           =   9
            Left            =   1620
            TabIndex        =   74
            Top             =   3000
            Width           =   5655
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
            Index           =   8
            Left            =   8340
            MaxLength       =   4
            TabIndex        =   73
            Top             =   2400
            Width           =   555
         End
         Begin VB.CheckBox Check1 
            Caption         =   "รหัสหนังสือ"
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
            Height          =   255
            Index           =   0
            Left            =   3840
            TabIndex        =   72
            Top             =   840
            Width           =   1215
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ภาพหน้าปก"
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
            Height          =   255
            Index           =   8
            Left            =   300
            TabIndex        =   71
            Top             =   3060
            Width           =   1215
         End
         Begin VB.CheckBox Check1 
            Caption         =   "หน้าPreface"
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
            Height          =   255
            Index           =   9
            Left            =   300
            TabIndex        =   70
            Top             =   3600
            Width           =   1275
         End
         Begin MSComDlg.CommonDialog DialogUpdate 
            Left            =   8640
            Top             =   2940
            _ExtentX        =   847
            _ExtentY        =   847
            _Version        =   393216
         End
         Begin VB.Frame Frame5 
            Caption         =   "ชื่อผู้แต่ง"
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
            Height          =   2115
            Left            =   7020
            TabIndex        =   85
            Top             =   180
            Width           =   3555
            Begin VB.CheckBox Check1 
               Caption         =   "ชื่อผู้แต่ง 2"
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
               Left            =   180
               TabIndex        =   98
               Top             =   960
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
               Left            =   1380
               TabIndex        =   90
               Top             =   360
               Width           =   1935
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
               Left            =   1380
               TabIndex        =   89
               Top             =   930
               Width           =   1935
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
               Left            =   1380
               TabIndex        =   88
               Top             =   1500
               Width           =   1935
            End
            Begin VB.CheckBox Check1 
               Caption         =   "ชื่อผู้แต่ง 1"
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
               Left            =   180
               TabIndex        =   87
               Top             =   420
               Width           =   1155
            End
            Begin VB.CheckBox Check1 
               Caption         =   "ชื่อผู้แต่ง 3"
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
               Index           =   4
               Left            =   180
               TabIndex        =   86
               Top             =   1560
               Width           =   1155
            End
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
            Left            =   780
            TabIndex        =   93
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
         Left            =   9540
         Style           =   1  'Graphical
         TabIndex        =   58
         Top             =   4920
         Width           =   915
      End
      Begin VB.Frame Frame6 
         Caption         =   "รายละเอียดของตู้เก็บหนังสือ"
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
         Left            =   180
         TabIndex        =   19
         Top             =   4380
         Width           =   8535
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
            ForeColor       =   &H00C00000&
            Height          =   255
            Index           =   13
            Left            =   5820
            TabIndex        =   100
            Top             =   660
            Width           =   1215
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
            ItemData        =   "Book.frx":048A
            Left            =   7140
            List            =   "Book.frx":0497
            TabIndex        =   61
            Text            =   "ซ้าย"
            Top             =   600
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
            Left            =   4260
            TabIndex        =   60
            Text            =   "1"
            Top             =   600
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
            Left            =   1920
            TabIndex        =   59
            Top             =   600
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
            ForeColor       =   &H00C00000&
            Height          =   255
            Index           =   12
            Left            =   3240
            TabIndex        =   21
            Top             =   660
            Width           =   675
         End
         Begin VB.CheckBox Check1 
            Caption         =   "ตู้หนังสือที่"
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
            Height          =   255
            Index           =   11
            Left            =   540
            TabIndex        =   20
            Top             =   660
            Width           =   1095
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
      Height          =   6075
      Index           =   2
      Left            =   180
      TabIndex        =   3
      Top             =   480
      Width           =   11235
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
         Height          =   5715
         Left            =   120
         TabIndex        =   22
         Top             =   180
         Width           =   4815
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
            Left            =   1380
            MaxLength       =   4
            TabIndex        =   55
            Top             =   2400
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
            Left            =   1380
            TabIndex        =   54
            Top             =   3680
            Visible         =   0   'False
            Width           =   3195
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
            Left            =   1380
            TabIndex        =   53
            Top             =   1760
            Visible         =   0   'False
            Width           =   3255
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
            Left            =   1380
            TabIndex        =   52
            Top             =   1120
            Visible         =   0   'False
            Width           =   3255
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
            Left            =   1380
            TabIndex        =   51
            Top             =   4320
            Visible         =   0   'False
            Width           =   1515
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
            Left            =   3120
            TabIndex        =   50
            Top             =   480
            Visible         =   0   'False
            Width           =   1515
         End
         Begin VB.TextBox Text1 
            BeginProperty DataFormat 
               Type            =   0
               Format          =   "9999"
               HaveTrueFalseNull=   0
               FirstDayOfWeek  =   0
               FirstWeekOfYear =   0
               LCID            =   1054
               SubFormatType   =   0
            EndProperty
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
            TabIndex        =   49
            Top             =   480
            Visible         =   0   'False
            Width           =   675
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
            TabIndex        =   34
            Top             =   5040
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
            TabIndex        =   33
            Top             =   5040
            Width           =   915
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
            ItemData        =   "Book.frx":04AC
            Left            =   2040
            List            =   "Book.frx":04B9
            TabIndex        =   32
            Text            =   "CARTOON"
            Top             =   3040
            Visible         =   0   'False
            Width           =   1575
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ประเภทของหนังสือ"
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
            Height          =   255
            Index           =   7
            Left            =   180
            TabIndex        =   31
            Top             =   3100
            Width           =   1815
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ปีที่พิมพ์"
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
            Height          =   255
            Index           =   6
            Left            =   180
            TabIndex        =   30
            Top             =   2460
            Width           =   975
         End
         Begin VB.CheckBox Check2 
            Caption         =   "สำนักพิมพ์"
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
            Height          =   255
            Index           =   5
            Left            =   180
            TabIndex        =   29
            Top             =   3740
            Width           =   1155
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ชื่อผู้แต่ง"
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
            Height          =   255
            Index           =   4
            Left            =   180
            TabIndex        =   28
            Top             =   1820
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
            ForeColor       =   &H00C00000&
            Height          =   255
            Index           =   0
            Left            =   180
            TabIndex        =   27
            Top             =   540
            Width           =   555
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ีรหัสหนังสือ"
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
            Height          =   255
            Index           =   1
            Left            =   1740
            TabIndex        =   26
            Top             =   540
            Width           =   1275
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ISBN"
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
            Height          =   255
            Index           =   2
            Left            =   180
            TabIndex        =   25
            Top             =   4380
            Width           =   855
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ชื่อหนังสือ"
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
            Height          =   255
            Index           =   3
            Left            =   180
            TabIndex        =   24
            Top             =   1180
            Width           =   1155
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
         Height          =   5715
         Left            =   5100
         TabIndex        =   23
         Top             =   180
         Width           =   6015
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
            TabIndex        =   57
            Top             =   5040
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
            TabIndex        =   56
            Top             =   5040
            Width           =   915
         End
         Begin TrueDBGridStd.TDBGridS TDBGridS1 
            Height          =   3675
            Left            =   180
            OleObjectBlob   =   "Book.frx":04D9
            TabIndex        =   48
            Top             =   300
            Width           =   5715
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
      Height          =   6135
      Index           =   0
      Left            =   180
      TabIndex        =   1
      Top             =   480
      Width           =   11175
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
         TabIndex        =   62
         Top             =   5340
         Width           =   975
      End
      Begin VB.Frame Frame3 
         Caption         =   "รายละเอียดของตู้เก็บหนังสือ"
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
         Height          =   1215
         Left            =   180
         TabIndex        =   14
         Top             =   4740
         Width           =   7635
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
            ItemData        =   "Book.frx":1F71
            Left            =   5880
            List            =   "Book.frx":1F7E
            TabIndex        =   47
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
            ItemData        =   "Book.frx":1F93
            Left            =   3600
            List            =   "Book.frx":1F95
            TabIndex        =   46
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
            Left            =   1680
            TabIndex        =   45
            Top             =   540
            Width           =   795
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ตู้หนังสือที่"
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
            Height          =   195
            Index           =   13
            Left            =   660
            TabIndex        =   17
            Top             =   600
            Width           =   795
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
            ForeColor       =   &H00C00000&
            Height          =   195
            Index           =   14
            Left            =   2940
            TabIndex        =   16
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
            ForeColor       =   &H00C00000&
            Height          =   195
            Index           =   15
            Left            =   4860
            TabIndex        =   15
            Top             =   600
            Width           =   765
         End
      End
      Begin VB.Frame Frame2 
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
         Height          =   4515
         Index           =   1
         Left            =   180
         TabIndex        =   4
         Top             =   180
         Width           =   10815
         Begin VB.CommandButton cmdIBrowerPreface 
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
            Left            =   6840
            Style           =   1  'Graphical
            TabIndex        =   96
            Top             =   3300
            Width           =   1095
         End
         Begin VB.TextBox txtIPreface 
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
            Left            =   1500
            TabIndex        =   95
            Top             =   3360
            Width           =   5115
         End
         Begin VB.CommandButton cmdIBrowerTitle 
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
            Left            =   6840
            Style           =   1  'Graphical
            TabIndex        =   64
            Top             =   2760
            Width           =   1095
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
            ItemData        =   "Book.frx":1F97
            Left            =   5040
            List            =   "Book.frx":1FA7
            TabIndex        =   44
            Text            =   "CARTOON"
            Top             =   2280
            Width           =   1575
         End
         Begin VB.TextBox txtITitle 
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
            Left            =   1500
            TabIndex        =   40
            Top             =   2820
            Width           =   5115
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
            Left            =   1500
            MaxLength       =   4
            TabIndex        =   39
            Top             =   2280
            Width           =   555
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
            Left            =   1500
            TabIndex        =   38
            Top             =   1260
            Width           =   5115
         End
         Begin VB.TextBox txtIISBN 
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
            Left            =   1500
            TabIndex        =   37
            Top             =   1800
            Width           =   1215
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
            Left            =   1500
            TabIndex        =   36
            Top             =   780
            Width           =   5115
         End
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
            Left            =   1500
            TabIndex        =   35
            Top             =   300
            Width           =   2055
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
            Left            =   5940
            Locked          =   -1  'True
            TabIndex        =   18
            Top             =   4020
            Width           =   615
         End
         Begin VB.Frame Frame2 
            Caption         =   "ชื่อผู้แต่ง"
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
            Height          =   1995
            Index           =   0
            Left            =   6960
            TabIndex        =   5
            Top             =   420
            Width           =   3495
            Begin VB.TextBox txtIAuthor3 
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
               TabIndex        =   43
               Top             =   1440
               Width           =   1935
            End
            Begin VB.TextBox txtIAuthor2 
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
               TabIndex        =   42
               Top             =   900
               Width           =   1935
            End
            Begin VB.TextBox txtIAuthor1 
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
               TabIndex        =   41
               Top             =   360
               Width           =   1935
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "ชื่อผู้แต่ง 1"
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
               Index           =   3
               Left            =   240
               TabIndex        =   8
               Top             =   420
               Width           =   855
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "ชื่อผู้แต่ง 2"
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
               Left            =   240
               TabIndex        =   7
               Top             =   960
               Width           =   855
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "ชื่อผู้แต่ง 3"
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
               Left            =   240
               TabIndex        =   6
               Top             =   1500
               Width           =   855
            End
         End
         Begin MSComDlg.CommonDialog DialogInsert 
            Left            =   8160
            Top             =   2760
            _ExtentX        =   847
            _ExtentY        =   847
            _Version        =   393216
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "หน้า Preface"
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
            Height          =   195
            Index           =   0
            Left            =   210
            TabIndex        =   94
            Top             =   3420
            Width           =   1035
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "รหัสหนังสือ"
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
            Height          =   195
            Index           =   1
            Left            =   360
            TabIndex        =   68
            Top             =   360
            Width           =   885
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ISBN"
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
            Height          =   195
            Index           =   8
            Left            =   780
            TabIndex        =   67
            Top             =   1860
            Width           =   435
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ภาพหน้าปก"
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
            Height          =   195
            Index           =   9
            Left            =   360
            TabIndex        =   66
            Top             =   2880
            Width           =   885
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ปีที่พิมพ์"
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
            Height          =   195
            Index           =   10
            Left            =   585
            TabIndex        =   65
            Top             =   2340
            Width           =   660
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ประเภทของหนังสือ"
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
            Height          =   195
            Index           =   6
            Left            =   3300
            TabIndex        =   13
            Top             =   2340
            Width           =   1470
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "สำนักพิมพ์"
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
            Height          =   195
            Index           =   7
            Left            =   420
            TabIndex        =   12
            Top             =   1320
            Width           =   825
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "ชื่อหนังสือ"
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
            Height          =   195
            Index           =   2
            Left            =   465
            TabIndex        =   11
            Top             =   840
            Width           =   780
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
            Left            =   6660
            TabIndex        =   10
            Top             =   4080
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
            Left            =   3120
            TabIndex        =   9
            Top             =   4080
            Width           =   2670
         End
      End
   End
   Begin ComctlLib.TabStrip TabBook 
      Height          =   6615
      Left            =   60
      TabIndex        =   0
      Top             =   60
      Width           =   11475
      _ExtentX        =   20241
      _ExtentY        =   11668
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
Attribute VB_Name = "Book"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim oVTableResult As ddoTable
Dim checkInsert As Boolean
Dim CountRowFirst As ddoTable

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
P_SQL = """" + UCase(txtICode.Text) + """,""" + UCase(txtIISBN.Text) + """,""" + UCase(txtIName.Text) + """,""" + _
               UCase(txtIAuthor1.Text) + """,""" + UCase(txtIAuthor2.Text) + """,""" + UCase(txtIAuthor3.Text) + """,""" + _
               UCase(cmbIClass.Text) + """,""" + UCase(txtIPublishing.Text) + """," + (txtIYear.Text) + "," + _
               "'""" + txtITitle.Text + """',"
If txtIPreface.Text = "" Then
    txtIPreface.Text = "NULL"
    P_SQL = P_SQL + txtIPreface + ","
Else: P_SQL = P_SQL + "'""" + txtIPreface.Text + """',"
End If
 P_SQL = P_SQL + cmbIShelf.Text + "," + cmbILayer + ",""" + Part + """"
PrepareParameter = P_SQL
End Function

Private Sub Check1_Click(Index As Integer)
If Check1(Index).Value = 1 Then
     If Index < 8 Then
          Text3(Index + 1).Enabled = True
          Text3(Index + 1).SetFocus
     Else: Select Case Index
                 Case 8: cmdUBrowserTitle.Enabled = True
                 Case 9: cmdUBrowserPreface.Enabled = True
                 Case 10: cmbUClass.Enabled = True
                 Case 11: cmbUShelf.Enabled = True
                 Case 12: cmbULayer.Enabled = True
                 Case 13: cmbUPart.Enabled = True
              End Select
      End If
Else:
         If Index < 8 Then
                 Text3(Index + 1).Enabled = False
         Else: Select Case Index
                 Case 8: cmdUBrowserTitle.Enabled = False
                 Case 9: cmdUBrowserPreface.Enabled = False
                 Case 10: cmbUClass.Enabled = False
                 Case 11: cmbUShelf.Enabled = False
                 Case 12: cmbULayer.Enabled = False
                 Case 13: cmbUPart.Enabled = False
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
      Else: cmbSClass.Visible = True
      End If
Else:
         If Index <> 7 Then
                 Text1(Index).Visible = False
                 Text1(Index).Text = ""
         Else: cmbSClass.Visible = False
         End If
End If
End Sub

Private Sub cmbIShelf_Click()
Dim i As Integer
Dim CountLayer As ddoTable
MainScreen.oDataGroupBook.BeginTransaction
Set CountLayer = MainScreen.oDataGroupBook.ExecuteSQLCommand("Select layer from bookshelf where shelfid = " + cmbIShelf)
MainScreen.oDataGroupBook.CommitTransaction
cmbILayer.Clear   'ล้างข้อมูลใน ComboBox
cmbILayer.Text = 1
For i = 1 To CountLayer.Columns(1).Value
     cmbILayer.AddItem (i)
Next i
End Sub

Private Sub cmbUShelf_Click()
Dim i As Integer
Dim CountLayer As ddoTable
MainScreen.oDataGroupBook.BeginTransaction
Set CountLayer = MainScreen.oDataGroupBook.ExecuteSQLCommand("Select layer from bookshelf where shelfid = " + cmbUShelf)
MainScreen.oDataGroupBook.CommitTransaction
cmbULayer.Clear   'ล้างข้อมูลใน ComboBox
cmbULayer.Text = 1
For i = 1 To CountLayer.Columns(1).Value
     cmbULayer.AddItem (i)
Next i
End Sub

Private Sub cmdIBrowerPreface_Click()
DialogInsert.ShowOpen
DialogInsert.Filter = "All Picture"
txtIPreface.Text = DialogInsert.FileName
If checkInsert Then
  cmdInsert.Enabled = True
End If
End Sub

Private Sub cmdIBrowerTitle_Click()
DialogInsert.ShowOpen
DialogInsert.Filter = "All Picture"
txtITitle.Text = DialogInsert.FileName
If checkInsert Then
  cmdInsert.Enabled = True
End If
End Sub

Private Sub cmdInsert_Click()
Dim Parameter As String
Dim CountRow As ddoTable
Parameter = PrepareParameter 'Set String ของ Parameter ของคำสั่ง Insert Book
Parameter = "{CALL insertbook(" + Parameter + ")}"
MainScreen.oDataGroupBook.BeginTransaction
Set CountRow = MainScreen.oDataGroupBook.ExecuteSQLCommand(Parameter)
MainScreen.oDataGroupBook.CommitTransaction
If CountRow.Columns(2).Value = "N" Then
    MsgBox "รหัสหนังสือที่คุณ Insert ซ้ำกับข้อมูลที่มีอยู่แล้ว", , "Insert"
Else: MsgBox " Insert ข้อมูลเรียบร้อยแล้ว", , "Insert"
End If
txtICount.Text = CountRow.Columns(1).Value
MainScreen.oDataGroupBook.DeleteVirtualTable ("CountRow")
End Sub

Private Sub cmdSClear_Click()
Dim i As Byte
For i = 0 To 6
   Check2(i).Value = 0
   Text1(i).Text = ""
   Text1(i).Visible = False
Next i
   Check2(7).Value = 0
   cmbSClass.Visible = False
End Sub

Private Sub cmdSDelete_Click()
Dim DeleteSQL As String
oVTableResult.GotoRecord (TDBGridS1.Row + 1)
DeleteSQL = "delete from book where bookid = " + oVTableResult.Columns(1).Value
MainScreen.oDataGroupBook.BeginTransaction
MainScreen.oDataGroupBook.ExecuteSQLCommand (DeleteSQL)
Set CountRowFirst = MainScreen.oDataGroupBook.ExecuteSQLCommand("Select count(*) from book")
MainScreen.oDataGroupBook.CommitTransaction
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
Else: MsgBox "โปรดใส่ข้อความที่คุณต้องการค้นหา ณ หัวข้อที่คุณเช็ค", , "Search"
End If
End Sub

Private Sub PassSQL()
Dim SQLString As String
SQLString = PrepareParameterSearch
SQLString = "{CALL searchdetailbook(" + SQLString + ")}"
'For direct SQL (DML) include transaction
MainScreen.oDataGroupBook.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupBook.ExecuteSQLCommand(SQLString)
MainScreen.oDataGroupBook.CommitTransaction
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
Else: SQL = SQL + """" + cmbSClass + """"
End If
PrepareParameterSearch = SQL
End Function

Private Sub cmdSUpdate_Click()
Dim Search_Update As String
TabBook.Tabs(2).Selected = True
Frame1(1).ZOrder 0
oVTableResult.GotoRecord (TDBGridS1.Row + 1)
Search_Update = "{Call SearchUpdateBook(" + oVTableResult.Columns(1).Value + ")}"
Text3(0).Text = oVTableResult.Columns(1).Value
MainScreen.oDataGroupBook.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupBook.ExecuteSQLCommand(Search_Update)
MainScreen.oDataGroupBook.CommitTransaction
Call Input_to_txt
End Sub

Private Sub cmdUBrowserPreface_Click()
DialogUpdate.ShowOpen
DialogUpdate.Filter = "All Picture"
Text3(10).Text = DialogUpdate.FileName
End Sub

Private Sub cmdUBrowserTitle_Click()
DialogUpdate.ShowOpen
DialogUpdate.Filter = "All Picture"
Text3(9).Text = DialogUpdate.FileName
End Sub

Private Sub cmdUClose_Click()
MenuAdmin.Show
Unload Me
End Sub

Private Sub cmdUSearch_Click()
Dim Search_Update As String
Search_Update = "{Call SearchUpdateBook(" + Text3(0).Text + ")}"
MainScreen.oDataGroupBook.BeginTransaction
Set oVTableResult = MainScreen.oDataGroupBook.ExecuteSQLCommand(Search_Update)
MainScreen.oDataGroupBook.CommitTransaction
Call Input_to_txt
End Sub

Private Sub Input_to_txt()
Dim i As Integer
If Not (oVTableResult Is Nothing) Then
   For i = 1 To 8
        Text3(i).Text = oVTableResult.Columns(i).Value
   Next i
        cmbUClass.Text = oVTableResult.Columns(9).Value
        cmbUShelf.Text = oVTableResult.Columns(10).Value
        cmbULayer.Clear 'ล้างข้อมูลใน ComboBox
        cmbULayer.Text = oVTableResult.Columns(11).Value
        If oVTableResult.Columns(12).Value = "L" Then
            cmbUPart.Text = "ซ้าย"
        ElseIf oVTableResult.Columns(12).Value = "M" Then
            cmbUPart.Text = "กลาง"
        ElseIf oVTableResult.Columns(12).Value = "R" Then
            cmbUPart.Text = "ขวา"
        End If
        For i = 1 To oVTableResult.Columns(13).Value
            cmbULayer.AddItem (i)
        Next i
cmdUUpdate.Enabled = True
Else: MsgBox "No Data in this Multimedia database", , "No Data"
       Text3(0).Text = ""
cmdUUpdate.Enabled = False
End If
MainScreen.oDataGroupBook.DeleteVirtualTable ("oVTableResult")
End Sub

Private Sub cmdUUpdate_Click()
Dim ParameterUpdate As String
Dim CheckUpdate  As ddoTable
ParameterUpdate = PrepareparameterUpdate
ParameterUpdate = "execute procedure UPDATEBOOK(" + ParameterUpdate + ")"
MsgBox ParameterUpdate
MainScreen.oDataGroupBook.BeginTransaction
Set CheckUpdate = MainScreen.oDataGroupBook.ExecuteSQLCommand(ParameterUpdate)
MainScreen.oDataGroupBook.CommitTransaction
MsgBox " Update ข้อมูลเรียบร้อยแล้ว", , "Update"
MainScreen.oDataGroupBook.DeleteVirtualTable ("CheckUpdate")
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
For i = 1 To 7
    U_SQL = U_SQL + UCase(Text3(i).Text)
    If i <> 7 Then
    U_SQL = U_SQL + ""","""
    End If
Next i
If Text3(9).Text = "" Then
    Text3(9).Text = "NOT"
End If
If Text3(10).Text = "" Then
    Text3(10).Text = "NOT"
End If
U_SQL = U_SQL + """," + Text3(8).Text + ",'""" + Text3(9).Text + """'" + ",'""" + Text3(10).Text + """',""" + _
               cmbUClass + """," + cmbUShelf + "," + cmbULayer + ",""" + Part + """"
PrepareparameterUpdate = U_SQL
End Function

Private Sub Form_Load()
Dim i As Byte
Dim CountShelf As ddoTable
Dim CountLayer As Byte
For i = 0 To Frame1.Count - 1
     With Frame1(i)
     .Move TabBook.ClientLeft + 40, _
      TabBook.ClientTop + 40, _
      TabBook.ClientWidth - 100, _
      TabBook.ClientHeight - 100
     End With
Next i
Frame1(0).ZOrder 0
MainScreen.oDataGroupBook.BeginTransaction
Set CountRowFirst = MainScreen.oDataGroupBook.ExecuteSQLCommand("Select count(*) from book")
Set CountShelf = MainScreen.oDataGroupBook.ExecuteSQLCommand("Select shelfid,layer from bookshelf")
MainScreen.oDataGroupBook.CommitTransaction
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
MainScreen.oDataGroupBook.DeleteVirtualTable ("CountRowFirst")
MainScreen.oDataGroupBook.DeleteVirtualTable ("CountShelf")
End Sub

Private Sub TabBook_Click()
Frame1(TabBook.SelectedItem.Index - 1).ZOrder 0
If TabBook.Tabs(3).Selected Then
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
      MsgBox "No Data in this Multimedia database", , "No Data"
      MainScreen.oDataGroupBook.DeleteVirtualTable ("oVTableResult")
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
        Dim ColumnName(12) As String
        ColumnName(0) = "BOOKID"
        ColumnName(1) = "BOOKCODE"
        ColumnName(2) = "BOOKNAME"
        ColumnName(3) = "AUTHOR1"
        ColumnName(4) = "AUTHOR2"
        ColumnName(5) = "AUTHOR3"
        ColumnName(6) = "ISBN"
        ColumnName(7) = "PUBLISHING"
        ColumnName(8) = "YEAR"
        ColumnName(9) = "BOOKCLASS"
        ColumnName(10) = "SHELFID"
        ColumnName(11) = "LAYER"
        ColumnName(12) = "PART"
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
ElseIf Index = 8 Then
      CheckInteger = Val(Text3(8).Text)
      If CheckInteger = Text3(8).Text Then
            cmdUUpdate.Enabled = True
      Else: cmdUUpdate.Enabled = False
      End If
End If
End Sub

Private Sub txtITitle_Change()
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
