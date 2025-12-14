VERSION 5.00
Begin VB.Form entityProp 
   BackColor       =   &H80000001&
   Caption         =   "Entity Properties"
   ClientHeight    =   1095
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3000
   ForeColor       =   &H80000008&
   LinkTopic       =   "Form3"
   ScaleHeight     =   1095
   ScaleWidth      =   3000
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   960
      MaxLength       =   15
      TabIndex        =   2
      Text            =   "NAMENAMENAMENAM"
      Top             =   120
      Width           =   1935
   End
   Begin VB.CommandButton OKcmd 
      Caption         =   "O.K."
      Height          =   255
      Left            =   720
      TabIndex        =   1
      Top             =   600
      Width           =   735
   End
   Begin VB.CommandButton CancleCmd 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   1680
      TabIndex        =   0
      Top             =   600
      Width           =   735
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Name"
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
      TabIndex        =   3
      Top             =   120
      Width           =   630
   End
End
Attribute VB_Name = "entityProp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub CancleCmd_Click()
    Text1.Text = "NAME"
    choseItem.tag = "nothing"
    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Left = (Screen.Width / 2) - (Me.Width / 2)
    Me.Top = (Screen.Height / 2) - (Me.Height / 2)
End Sub

Private Sub OKcmd_Click()
    Dim name As String
    Dim updateERtable As ddoTable
    
    If Text1.Text <> "" Then
        name = UCase(Text1.Text)
    Else:
        name = "NAME"
    End If
    
    If isERformSaved = True Then
      If name <> entityState(choseItem.Index).name Then
        Set updateERtable = oDatagroup.CreateVirtualTable()
        updateERtable.UpdateCommand = "Update entityTable SET name=? where (projectId=?)and(id=?)"
        updateERtable.SetParam UPDATE_CMD, 1, name
        updateERtable.SetParam UPDATE_CMD, 2, projectId.id
        updateERtable.SetParam UPDATE_CMD, 3, choseItem.Index
        
        oDatagroup.BeginTransaction
        updateERtable.ExecuteCommand UPDATE_CMD
        oDatagroup.CommitTransaction
        
        oDatagroup.DeleteVirtualTable ("updateERtable")
        GoTo setup
        
      End If
    End If
    
setup:
    
    ERform.EtNameBox(choseItem.Index).Caption = name
    entityState(choseItem.Index).name = name
    
    choseItem.tag = "nothing"
    Me.Hide
    Exit Sub


        
End Sub

Public Sub setupBeforeShow()
    Text1.Text = entityState(choseItem.Index).name
End Sub
