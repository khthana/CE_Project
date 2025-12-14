VERSION 5.00
Begin VB.Form OpenProjectForm 
   BackColor       =   &H80000001&
   Caption         =   "Dataflow Designer"
   ClientHeight    =   1500
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3990
   LinkTopic       =   "Form3"
   ScaleHeight     =   1500
   ScaleWidth      =   3990
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   480
      TabIndex        =   2
      Text            =   "{select project}"
      Top             =   720
      Width           =   1935
   End
   Begin VB.CommandButton OKcmd 
      Caption         =   "O.K."
      Height          =   255
      Left            =   2880
      TabIndex        =   1
      Top             =   720
      Width           =   735
   End
   Begin VB.CommandButton CancleCmd 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   2880
      TabIndex        =   0
      Top             =   1080
      Width           =   735
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "PLEASE SELECT THE PROJECT"
      BeginProperty Font 
         Name            =   "Arial Black"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000005&
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   240
      Width           =   3495
   End
End
Attribute VB_Name = "OpenProjectForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim ovProjectName As ddoTable
Dim comboClick As Boolean
Dim viewCount As Integer

Private Sub CancleCmd_Click()
    OpenProjectForm.Hide
    If viewCount > 0 Then
        oDatagroup.DeleteVirtualTable ("ovProjectName")
        viewCount = 0
    End If
    projectId.id = 0
    comboClick = False
    
End Sub

Private Sub Combo1_Click()
   
    comboClick = True
    
    If Combo1.ListIndex >= 0 Then
        ovProjectName.GotoRecord (Combo1.ListIndex + 1)
        projectId.id = ovProjectName.Columns(1).Value
    ElseIf Combo1.ListIndex < 0 Then
            projectId.id = -1
    End If
    
End Sub

Private Sub Combo1_DropDown()
    
    Combo1.Clear
    Combo1.Text = "{select project}"
    
If viewCount = 0 Then
    Set ovProjectName = oDatagroup.CreateVirtualTable()
    ovProjectName.QueryCommand = "select * from projecttable order by projectId"
    ovProjectName.ExecuteCommand QUERY_CMD
    
    If ovProjectName.TotalRecordCount > 0 Then
        While Not ovProjectName.EOT
            Combo1.AddItem "PJ" & ovProjectName.Columns(1).Value & " -- " & ovProjectName.Columns(2).Value
            ovProjectName.NextRecord
        Wend
    End If
    
End If
If viewCount > 0 Then
    ovProjectName.FirstRecord
    While Not ovProjectName.EOT
            Combo1.AddItem "PJ" & ovProjectName.Columns(1).Value & " -- " & ovProjectName.Columns(2).Value
            ovProjectName.NextRecord
    Wend
End If

    viewCount = viewCount + 1

End Sub

Private Sub Form_Load()
    Me.Left = (Screen.Width / 2) - (Me.Width / 2)
    Me.Top = (Screen.Height / 2) - (Me.Height / 2)
    comboClick = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
    OpenProjectForm.Hide
    
    
End Sub

Private Sub OKcmd_Click()

    If (projectId.id <= 0) Or (comboClick = False) Then
        MsgBox "please select the project"
        Exit Sub
    End If
    
    If viewCount > 0 Then
        oDatagroup.DeleteVirtualTable ("ovProjectName")
        viewCount = 0
    End If
    
    OpenProjectForm.Hide
    Call show_ERdiagram(projectId.id)
    Call show_DFdiagram(projectId.id)
    comboClick = False
    
End Sub

