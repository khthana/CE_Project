VERSION 5.00
Begin VB.Form SaveAsDB 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Save As"
   ClientHeight    =   1155
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5775
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1155
   ScaleWidth      =   5775
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   4095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "O.K."
      Height          =   375
      Left            =   4320
      TabIndex        =   1
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancle"
      Height          =   375
      Left            =   4320
      TabIndex        =   0
      Top             =   480
      Width           =   1215
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "ENTER YOUR PROJECT NAME"
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
      TabIndex        =   3
      Top             =   120
      Width           =   3375
   End
End
Attribute VB_Name = "SaveAsDB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()
    BeingSave.Show
    Unload Me
End Sub

Private Sub Command2_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    SaveAsDB.Left = 3000
    SaveAsDB.Top = 2500
End Sub
