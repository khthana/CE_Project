VERSION 5.00
Begin VB.Form relationProp 
   BackColor       =   &H80000001&
   Caption         =   "Relationship"
   ClientHeight    =   1395
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3015
   LinkTopic       =   "Form3"
   ScaleHeight     =   1395
   ScaleWidth      =   3015
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   1680
      TabIndex        =   4
      Text            =   "Entity2"
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   240
      TabIndex        =   2
      Text            =   "Entity1"
      Top             =   480
      Width           =   1095
   End
   Begin VB.CommandButton OKcmd 
      Caption         =   "O.K."
      Height          =   255
      Left            =   720
      TabIndex        =   1
      Top             =   960
      Width           =   735
   End
   Begin VB.CommandButton CancleCmd 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   1680
      TabIndex        =   0
      Top             =   960
      Width           =   735
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Left            =   1440
      TabIndex        =   5
      Top             =   315
      Width           =   135
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Relationship"
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
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   1350
   End
End
Attribute VB_Name = "relationProp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub CancleCmd_Click()
    Text1.Text = "Entity1"
    Text2.Text = "Entity2"
    choseItem.tag = "nothing"
    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Left = (Screen.Width / 2) - (Me.Width / 2)
    Me.Top = (Screen.Height / 2) - (Me.Height / 2)
End Sub

Private Sub OKcmd_Click()
    Dim rel1 As String
    Dim rel2 As String
    Dim data As String
    Dim i As Integer
    Dim updateRELtable As ddoTable
    
    If (Text1.Text = "") And (Text2.Text = "") Then
        rel1 = "entity1"
        rel2 = "entity2"
    Else:
        rel1 = Text1.Text
        rel2 = Text2.Text
    End If
    data = rel1 & " - " & rel2
    
    If isERformSaved = True Then
      If data <> relationGroupState(choseItem.index).relationship Then
        Set updateRELtable = oDatagroup.CreateVirtualTable()
        updateRELtable.UpdateCommand = "Update relationTable SET relationship=? where (projectID=?)and(id=?)"
        
        updateRELtable.SetParam UPDATE_CMD, 1, data
        updateRELtable.SetParam UPDATE_CMD, 2, projectId.id
        updateRELtable.SetParam UPDATE_CMD, 3, choseItem.index
        
        oDatagroup.BeginTransaction
        updateRELtable.ExecuteCommand UPDATE_CMD
        oDatagroup.CommitTransaction
        
        oDatagroup.DeleteVirtualTable ("updateRELtable")
      End If
    End If
    
    relationGroupState(choseItem.index).relationship = data
    ERform.tooltipLabel.Caption = relationGroupState(choseItem.index).relationship
    choseItem.tag = "nothing"
    Me.Hide
    
End Sub

