VERSION 5.00
Begin VB.Form frmBackground 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Digital Library"
   ClientHeight    =   6555
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8190
   Icon            =   "frmBackground.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6555
   ScaleWidth      =   8190
   StartUpPosition =   1  'CenterOwner
   WindowState     =   2  'Maximized
   Begin VB.Timer Timer1 
      Left            =   0
      Top             =   0
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "เจ้าคุณทหารลาดกระบัง"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   300
      Left            =   480
      TabIndex        =   3
      Top             =   4200
      Width           =   2385
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "สถาบันเทคโนโลยีพระจอมเกล้า"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   300
      Left            =   120
      TabIndex        =   2
      Top             =   3720
      Width           =   3195
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "สำนักหอสมุดกลาง"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   300
      Left            =   720
      TabIndex        =   1
      Top             =   3120
      Width           =   1860
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "โปรแกรมจัดการวารสาร"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   300
      Left            =   480
      TabIndex        =   0
      Top             =   2280
      Width           =   825
   End
   Begin VB.Image Image1 
      Height          =   1020
      Left            =   1320
      Top             =   840
      Width           =   750
   End
End
Attribute VB_Name = "frmBackground"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()

    frmBackground.Icon = LoadPicture(App.Path & "\Icon.ico")
    frmBackground.Picture = LoadPicture(App.Path & "\Background.jpg")
    Image1.Picture = LoadPicture(App.Path & "\Logo.jpg")
    Timer1.Interval = 1
    
End Sub

Private Sub Timer1_Timer()

    If Timer1.Interval = 1 Then
        frmTitle.Show vbModal, frmBackground
        Timer1.Interval = 2000
    End If
    
End Sub
