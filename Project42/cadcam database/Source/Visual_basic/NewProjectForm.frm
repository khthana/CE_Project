VERSION 5.00
Begin VB.Form NewProjForm 
   AutoRedraw      =   -1  'True
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Enter About New Project  "
   ClientHeight    =   2970
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   2970
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2970
   ScaleWidth      =   2970
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CancelButton 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   495
      Left            =   1440
      TabIndex        =   5
      Top             =   2280
      Width           =   1335
   End
   Begin VB.CommandButton OkButton 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   495
      Left            =   120
      TabIndex        =   4
      Top             =   2280
      Width           =   1215
   End
   Begin VB.TextBox NewDescProject 
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   1560
      Width           =   2655
   End
   Begin VB.TextBox NewNameProject 
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   2655
   End
   Begin VB.Label Label2 
      Caption         =   "Enter Project Description:"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   1200
      Width           =   1935
   End
   Begin VB.Label Label1 
      Caption         =   "Enter Project Name:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1695
   End
End
Attribute VB_Name = "NewProjForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub CancelButton_Click()
    Unload NewProjForm
End Sub

Private Sub Form_Load()
     NewProjForm.Left = (Screen.Width - NewProjForm.Width) / 2
    NewProjForm.Top = (Screen.Height - NewProjForm.Height) / 2
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Unload NewProjForm
End Sub

Private Sub OkButton_Click()
    If Trim(NewNameProject.Text) = "" Then
        MsgBox "Don't Enter Project Name", vbOKOnly, ""
        NewNameProject.Text = ""
    Else
        If Main.ExistsProject(NewNameProject.Text) Then
                MsgBox "Project Name is already", vbOKOnly, ""
                NewNameProject.Text = ""
        Else
            Main.Caption = NewNameProject.Text
            Main.ProjectName = NewNameProject.Text
            Main.ProjectDesc = NewDescProject.Text
            NewProjForm.MousePointer = 11
            Call Main.SaveProject
            NewProjForm.MousePointer = 0
            Unload NewProjForm
        End If
    End If
End Sub
