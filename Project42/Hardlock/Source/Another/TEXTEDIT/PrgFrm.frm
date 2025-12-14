VERSION 5.00
Begin VB.Form PrgFrm 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Progress"
   ClientHeight    =   1215
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   4695
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1215
   ScaleWidth      =   4695
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Cancel 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   840
      Width           =   4455
   End
   Begin VB.Shape GraphB2 
      Height          =   255
      Left            =   120
      Top             =   480
      Width           =   4455
   End
   Begin VB.Shape GraphB 
      Height          =   255
      Left            =   120
      Top             =   120
      Width           =   4455
   End
   Begin VB.Shape GraphF2 
      BackColor       =   &H00FF0000&
      BackStyle       =   1  'Opaque
      Height          =   255
      Left            =   120
      Top             =   480
      Width           =   15
   End
   Begin VB.Shape GraphF 
      BackColor       =   &H00FF0000&
      BackStyle       =   1  'Opaque
      Height          =   255
      Left            =   120
      Top             =   120
      Width           =   15
   End
End
Attribute VB_Name = "PrgFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Cancel_Click()
TUMod.DoCancel = True
End Sub

Private Sub Form_Load()
Ontop Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
Cancel = 1
End Sub
