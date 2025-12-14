VERSION 5.00
Begin VB.Form AboutForm 
   Caption         =   "About"
   ClientHeight    =   3945
   ClientLeft      =   3390
   ClientTop       =   3030
   ClientWidth     =   4710
   LinkTopic       =   "Form6"
   ScaleHeight     =   3945
   ScaleWidth      =   4710
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.CommandButton Command1 
      Caption         =   "&OK"
      Height          =   375
      Left            =   1800
      TabIndex        =   7
      Top             =   3480
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Caption         =   "By"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   240
      TabIndex        =   2
      Top             =   1440
      Width           =   4215
      Begin VB.Label Label6 
         Caption         =   "Email : s9014508@kmitl.ac.th"
         ForeColor       =   &H00FF0000&
         Height          =   375
         Left            =   960
         TabIndex        =   6
         Top             =   1440
         Width           =   2295
      End
      Begin VB.Label Label5 
         Caption         =   "Saran  Theingsakul  39014508  4D"
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
         Left            =   600
         TabIndex        =   5
         Top             =   1080
         Width           =   3375
      End
      Begin VB.Label Label4 
         Caption         =   "Email : s9014499@kmitl.ac.th"
         ForeColor       =   &H00FF0000&
         Height          =   375
         Left            =   960
         TabIndex        =   4
         Top             =   720
         Width           =   2655
      End
      Begin VB.Label Label3 
         Caption         =   "Wuttichai  Ratpathomwong  39014499  4D          "
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
         Left            =   240
         TabIndex        =   3
         Top             =   360
         Width           =   3615
      End
   End
   Begin VB.Label Label2 
      Caption         =   "Alpha Version 1.01"
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
      Left            =   1320
      TabIndex        =   1
      Top             =   1080
      Width           =   1695
   End
   Begin VB.Label Label1 
      Caption         =   "Registeration and Information System           Temporal Database Software "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   3975
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H00C00000&
      BorderWidth     =   2
      FillColor       =   &H0000FF00&
      Height          =   735
      Left            =   240
      Top             =   240
      Width           =   4215
   End
End
Attribute VB_Name = "AboutForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    AboutForm.Hide
End Sub

