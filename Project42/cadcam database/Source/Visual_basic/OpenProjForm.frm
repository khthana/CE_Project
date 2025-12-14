VERSION 5.00
Begin VB.Form OpenProjForm 
   AutoRedraw      =   -1  'True
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Form1"
   ClientHeight    =   2745
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2745
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox ProjDescList 
      Height          =   1035
      Left            =   3480
      TabIndex        =   4
      Top             =   1440
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton CancelButton 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   495
      Left            =   3480
      TabIndex        =   3
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton OKButton 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   495
      Left            =   3480
      TabIndex        =   2
      Top             =   120
      Width           =   1095
   End
   Begin VB.TextBox ProjDesc 
      Height          =   615
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   1
      Top             =   2040
      Width           =   3255
   End
   Begin VB.ListBox ProjName 
      Height          =   1815
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3255
   End
End
Attribute VB_Name = "OpenProjForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public OpenName As String
Public OpenDesc As String
Private Sub CancelButton_Click()
    Unload OpenProjForm
End Sub
Private Sub Form_Load()
    OpenProjForm.Left = (Screen.Width - OpenProjForm.Width) / 2
    OpenProjForm.Top = (Screen.Height - OpenProjForm.Height) / 2
    If Main.OpenRem Then
        OpenProjForm.Caption = "Open Project Form"
    Else
        OpenProjForm.Caption = "Remove Project Form"
    End If
    Call Main.LoadProjectNameAndDesc
    OpenName = ProjName.List(0)
    OpenDesc = ProjDescList.List(0)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Unload OpenProjForm
End Sub

Public Sub GoOpenActivate()
    Dim Msg As String
    If Main.OpenRem Then
        If Main.SaveStatus Then
            Msg = MsgBox("Do you want to save this project?", vbYesNoCancel, "")
            OpenProjForm.MousePointer = 11
            If Msg = vbYes Then
                Call Main.SaveProjectForm
                Call Main.ClearMainForm
                Main.ProjectName = OpenName
                Main.ProjectDesc = OpenDesc
                Main.StatusBar.SimpleText = "Opening Project......."
                Call Main.OpenProjectForm
            Else
                If Msg = vbNo Then
                    Call Main.ClearMainForm
                    Main.ProjectName = OpenName
                    Main.ProjectDesc = OpenDesc
                    Main.StatusBar.SimpleText = "Opening Project......."
                    Call Main.OpenProjectForm
                End If
            End If
        Else
            OpenProjForm.MousePointer = 11
            Call Main.ClearMainForm
            Main.ProjectName = OpenName
            Main.ProjectDesc = OpenDesc
            Main.StatusBar.SimpleText = "Opening Project......."
            Call Main.OpenProjectForm
        End If
        OpenProjForm.MousePointer = 0
        Unload OpenProjForm
    Else
        Msg = MsgBox("Confirm to Remove project?", vbYesNoCancel, "")
        If Msg = vbYes Then
            OpenProjForm.MousePointer = 11
            Main.ProjectName = OpenName
            Main.ProjectDesc = OpenDesc
            Main.StatusBar.SimpleText = "Removing Project......."
            Call Main.RemoveProject
            OpenProjForm.MousePointer = 0
            Unload OpenProjForm
        Else
            If Msg = vbNo Then
                Unload OpenProjForm
            End If
        End If
    End If
End Sub
Private Sub OkButton_Click()
    Call GoOpenActivate
End Sub

Private Sub ProjName_Click()
    OpenName = ProjName.Text
    OpenDesc = ProjDescList.List(ProjName.ListIndex)
    ProjDesc.Text = ProjDescList.List(ProjName.ListIndex)
End Sub

Private Sub ProjName_DblClick()
    Call GoOpenActivate
End Sub
