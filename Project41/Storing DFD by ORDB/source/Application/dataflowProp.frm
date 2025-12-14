VERSION 5.00
Begin VB.Form dataflowProp 
   BackColor       =   &H80000001&
   Caption         =   "Dataflow Properties"
   ClientHeight    =   1095
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3135
   LinkTopic       =   "Form2"
   ScaleHeight     =   1095
   ScaleWidth      =   3135
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CancleCmd 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   1800
      TabIndex        =   3
      Top             =   600
      Width           =   735
   End
   Begin VB.CommandButton OKcmd 
      Caption         =   "O.K."
      Height          =   255
      Left            =   720
      TabIndex        =   2
      Top             =   600
      Width           =   735
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1560
      TabIndex        =   0
      Text            =   "data"
      Top             =   120
      Width           =   1455
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Flow data"
      BeginProperty Font 
         Name            =   "Arial Black"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   270
      Left            =   240
      TabIndex        =   1
      Top             =   120
      Width           =   1065
   End
End
Attribute VB_Name = "dataflowProp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub CancleCmd_Click()
    Text1.Text = "name"
    choseItem.tag = "nothing"
    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Left = (Screen.Width / 2) - (Me.Width / 2)
    Me.Top = (Screen.Height / 2) - (Me.Height / 2)
End Sub

Private Sub OKcmd_Click()
    Dim data As String
    Dim updateDFtable As ddoTable
    
    If Text1.Text <> "" Then
        data = LCase(Text1.Text)
    Else:
        data = "data"
    End If
    
    If formState(CInt(choseItem.ofForm.tag)).saved = True Then
      If data <> lineGroupState(choseItem.index).data Then
        Set updateDFtable = oDatagroup.CreateVirtualTable
        updateDFtable.UpdateCommand = "Update dataflowTable SET formatdata=? where (projectId=?)and(id=?)"
        
        updateDFtable.SetParam UPDATE_CMD, 1, data
        updateDFtable.SetParam UPDATE_CMD, 2, projectId.id
        updateDFtable.SetParam UPDATE_CMD, 3, choseItem.index
        
        oDatagroup.BeginTransaction
        updateDFtable.ExecuteCommand UPDATE_CMD
        oDatagroup.CommitTransaction
        
        oDatagroup.DeleteVirtualTable ("updateDFtable")
        GoTo setup
    
      End If
    End If

setup:
    lineGroupState(choseItem.index).data = data
    
    formArray(CInt(choseItem.ofForm.tag)).tooltipLabel.Caption = data
    
    choseItem.tag = "nothing"
    Me.Hide
    
End Sub

Public Sub setupBeforeShow()

    MDIForm1.menuCreateSubprocess.Visible = False
    MDIForm1.menuViewDetail.Visible = False
    MDIForm1.menuDeleteSubprocess.Visible = False
    Text1.Text = lineGroupState(choseItem.index).data
End Sub
