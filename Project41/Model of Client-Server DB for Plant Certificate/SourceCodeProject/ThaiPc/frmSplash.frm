VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.1#0"; "COMCTL32.OCX"
Begin VB.Form frmSplash 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   5565
   ClientLeft      =   1320
   ClientTop       =   1050
   ClientWidth     =   9540
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5565
   ScaleWidth      =   9540
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin ComctlLib.ProgressBar ProgressBar1 
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   5280
      Width           =   9255
      _ExtentX        =   16325
      _ExtentY        =   450
      _Version        =   327680
      Appearance      =   1
      MouseIcon       =   "frmSplash.frx":0000
   End
   Begin VB.Frame fraMainFrame 
      BackColor       =   &H80000004&
      BorderStyle     =   0  'None
      Height          =   5655
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9465
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Department Of Agricalture"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   17.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Index           =   2
         Left            =   2490
         TabIndex        =   9
         Top             =   3840
         Width           =   4380
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Agricaltural Regulatory Division"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   17.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Index           =   1
         Left            =   1995
         TabIndex        =   8
         Top             =   3360
         Width           =   5370
      End
      Begin VB.Label lblVersion 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "กรมวิชาการเกษตร"
         BeginProperty Font 
            Name            =   "KodchiangUPC"
            Size            =   27.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   540
         Index           =   2
         Left            =   3360
         TabIndex        =   7
         Tag             =   "Version"
         Top             =   2880
         Width           =   2610
      End
      Begin VB.Label lblVersion 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "กองควบคุมพืชและวัสดุการเกษตร"
         BeginProperty Font 
            Name            =   "KodchiangUPC"
            Size            =   27.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   540
         Index           =   1
         Left            =   2280
         TabIndex        =   6
         Tag             =   "Version"
         Top             =   2400
         Width           =   4710
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Phytosanitary Certificate Information System"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Index           =   0
         Left            =   945
         TabIndex        =   5
         Top             =   1800
         Width           =   7680
      End
      Begin VB.Label lblProductName 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackColor       =   &H80000004&
         Caption         =   "THAIPC"
         BeginProperty Font 
            Name            =   "KodchiangUPC"
            Size            =   56.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00400000&
         Height          =   1080
         Left            =   3450
         TabIndex        =   3
         Tag             =   "Product"
         Top             =   120
         Width           =   2505
      End
      Begin VB.Label lblLoading 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Now Loading ......."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   15.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   3600
         TabIndex        =   1
         Tag             =   "LicenseTo"
         Top             =   4800
         Width           =   2670
      End
      Begin VB.Label lblVersion 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "ระบบการออกใบรับรองปลอดศัตรูพืช"
         BeginProperty Font 
            Name            =   "KodchiangUPC"
            Size            =   33
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   645
         Index           =   0
         Left            =   1800
         TabIndex        =   2
         Tag             =   "Version"
         Top             =   1200
         Width           =   6030
      End
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Activate()
    Dim Counter As Integer
    Dim PauseTime, Start
    Dim Workarea(2500) As String
    ProgressBar1.Min = LBound(Workarea)
    ProgressBar1.Max = UBound(Workarea)
    ProgressBar1.Visible = True

' Set the Progress's Value to Min.
    ProgressBar1.Value = ProgressBar1.Min

' Delay For Show SplashLogo
    PauseTime = 0.1 ' Set duration
    Start = Timer   ' Set StartTime
    Do While Timer < Start + PauseTime
        DoEvents
    Loop
' End Delay For Show SplashLogo

' Loop through the array.
    For Counter = LBound(Workarea) To UBound(Workarea)
        'Set initial values for each item in the array.
        ProgressBar1.Value = Counter
    Next Counter
    ProgressBar1.Visible = False 'True
    ProgressBar1.Value = ProgressBar1.Min
End Sub

