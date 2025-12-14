VERSION 5.00
Begin VB.Form createProjectForm 
   BackColor       =   &H80000001&
   Caption         =   "Dataflow Designer"
   ClientHeight    =   1590
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3735
   LinkTopic       =   "Form4"
   ScaleHeight     =   1590
   ScaleWidth      =   3735
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CancleCmd 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   2640
      TabIndex        =   2
      Top             =   1080
      Width           =   735
   End
   Begin VB.CommandButton OKcmd 
      Caption         =   "O.K."
      Height          =   255
      Left            =   2640
      TabIndex        =   1
      Top             =   720
      Width           =   735
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   480
      TabIndex        =   0
      Text            =   "PROJECT_NAME"
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "ENTER THE PROJECT NAME"
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
      Width           =   3135
   End
End
Attribute VB_Name = "createProjectForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub CancleCmd_Click()

    projectId.name = ""
    Text1.Text = "PROJECT_NAME"
    createProjectForm.Hide
    
End Sub
Private Sub Form_Load()
    Me.Left = (Screen.Width / 2) - (Me.Width / 2)
    Me.Top = (Screen.Height / 2) - (Me.Height / 2)
End Sub

Private Sub OKcmd_Click()
    Dim ovTempTable As ddoTable
    If Text1.Text = "" Then
        MsgBox "please enter ProjectName"
    Else
        oDatagroup.BeginTransaction
        Set ovTempTable = oDatagroup.ExecuteSQLCommand("execute function genprojectid()")
        oDatagroup.CommitTransaction
    
        projectId.id = ovTempTable.Columns(1).Value
        
        projectId.name = UCase(Text1.Text)
        MsgBox "The ID of this project is NO." & projectId.id
                
        Call saveToPjTable
        createProjectForm.Hide
        
        If createDiagramType = "DF" Then
            Call createDF
        ElseIf createDiagramType = "ER" Then
            Call createER
        End If
        
    End If
    
End Sub

