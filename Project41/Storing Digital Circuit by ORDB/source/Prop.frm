VERSION 5.00
Begin VB.Form Prop 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Properties"
   ClientHeight    =   3690
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4245
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3690
   ScaleWidth      =   4245
   Begin VB.ListBox List2 
      Height          =   2010
      ItemData        =   "Prop.frx":0000
      Left            =   2160
      List            =   "Prop.frx":0002
      TabIndex        =   8
      Top             =   1560
      Width           =   1815
   End
   Begin VB.ListBox List1 
      Height          =   2010
      ItemData        =   "Prop.frx":0004
      Left            =   240
      List            =   "Prop.frx":0006
      TabIndex        =   7
      Top             =   1560
      Width           =   1815
   End
   Begin VB.CommandButton Command1 
      Caption         =   "O.K."
      Height          =   315
      Left            =   2760
      TabIndex        =   5
      Top             =   600
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   1560
      TabIndex        =   4
      Top             =   600
      Width           =   1095
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "Prop.frx":0008
      Left            =   1560
      List            =   "Prop.frx":000A
      TabIndex        =   0
      Top             =   120
      Width           =   2415
   End
   Begin VB.Label Label3 
      Caption         =   "Gate"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label6 
      Caption         =   "Output to"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2160
      TabIndex        =   3
      Top             =   1200
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Input From"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   1200
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Gate Type"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   720
      Width           =   1095
   End
End
Attribute VB_Name = "Prop"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Prop.Left = 3500
    Prop.Top = 2000
End Sub

