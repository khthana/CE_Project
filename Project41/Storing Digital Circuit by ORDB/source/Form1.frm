VERSION 5.00
Begin VB.Form Form1 
   BackColor       =   &H8000000A&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   3975
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6150
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   3975
   ScaleWidth      =   6150
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command2 
      Caption         =   "Cancle"
      Height          =   495
      Left            =   4440
      TabIndex        =   4
      Top             =   3240
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "O.K."
      Height          =   495
      Left            =   3240
      TabIndex        =   3
      Top             =   3240
      Width           =   1215
   End
   Begin VB.OptionButton Option2 
      Caption         =   " Open Project"
      Height          =   495
      Left            =   2520
      TabIndex        =   2
      Top             =   1680
      Width           =   1455
   End
   Begin VB.OptionButton Option1 
      Caption         =   " New Project"
      Height          =   495
      Left            =   2520
      TabIndex        =   1
      Top             =   1080
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      Height          =   2415
      Left            =   480
      TabIndex        =   0
      Top             =   600
      Width           =   5175
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    MDI.mnuProject.Enabled = True
    MDI.mnuNew.Enabled = True
    MDI.mnuOpen.Enabled = True
    MDI.mnuSave.Enabled = True
    MDI.mnuNewComp.Enabled = True
    If Option1 = True Then
        LayOut.Visible = True
        LayOut.Top = 1700
        LayOut.Left = 0
        LayOut.Show
        Comp.Top = 0
        Comp.Left = 800
    ElseIf Option2 = True Then
        OpenProject.Show
        MDI.mnuNew.Enabled = False
    End If
    Unload Me
End Sub

Private Sub Command2_Click()
    MDI.mnuNew.Enabled = True
    MDI.mnuOpen.Enabled = True
    pid = ""
    Unload Me
End Sub

Private Sub Form_Load()
    Form1.Left = 2500
    Form1.Top = 2000
    initConnect
End Sub


