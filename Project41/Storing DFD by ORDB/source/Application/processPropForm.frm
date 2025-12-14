VERSION 5.00
Begin VB.Form processPropForm 
   BackColor       =   &H80000001&
   Caption         =   "Process Properties"
   ClientHeight    =   1785
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3030
   LinkTopic       =   "Form2"
   ScaleHeight     =   1785
   ScaleWidth      =   3030
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CancleCmd 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   1800
      TabIndex        =   5
      Top             =   1320
      Width           =   735
   End
   Begin VB.CommandButton OKcmd 
      Caption         =   "O.K."
      Height          =   255
      Left            =   1800
      TabIndex        =   4
      Top             =   960
      Width           =   735
   End
   Begin VB.TextBox Text2 
      Height          =   765
      Left            =   360
      MaxLength       =   30
      MultiLine       =   -1  'True
      TabIndex        =   3
      Text            =   "processPropForm.frx":0000
      Top             =   840
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   960
      MaxLength       =   15
      TabIndex        =   2
      Text            =   "NAME"
      Top             =   120
      Width           =   1935
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Description"
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
      Top             =   480
      Width           =   1245
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
      TabIndex        =   0
      Top             =   120
      Width           =   630
   End
End
Attribute VB_Name = "processPropForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub CancleCmd_Click()
    Text1.Text = "NAME"
    Text2.Text = "description"
    choseItem.tag = "nothing"
    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Left = (Screen.Width / 2) - (Me.Width / 2)
    Me.Top = (Screen.Height / 2) - (Me.Height / 2)
End Sub

Private Sub OKcmd_Click()
    Dim name As String
    Dim desc As String
    Dim updatePCtable As ddoTable
    
    If Text1.Text <> "" Then
        name = UCase(Text1.Text)
    Else:
        Text1.Text = "NAME"
        name = "NAME"
    End If
    
    If Text2.Text <> "" Then
        desc = Text2.Text
    Else: desc = "description"
    End If
    
    If referencedByGate(choseItem.index, choseItem.tag) = True Then
        MsgBox "can't update properties :: object is referenced"
        GoTo refHandle
    End If
    
    If formState(CInt(choseItem.ofForm.tag)).saved = True Then
      If name <> processState(choseItem.index).name Then
        Set updatePCtable = oDatagroup.CreateVirtualTable()
        updatePCtable.UpdateCommand = "Update processTable SET name=? where (projectID=?)and(id=?)"
        
        updatePCtable.SetParam UPDATE_CMD, 1, name
        updatePCtable.SetParam UPDATE_CMD, 2, projectId.id
        updatePCtable.SetParam UPDATE_CMD, 3, choseItem.index
        
        oDatagroup.BeginTransaction
        updatePCtable.ExecuteCommand UPDATE_CMD
        oDatagroup.CommitTransaction
        oDatagroup.DeleteVirtualTable ("updatePCtable")
      End If
      If desc <> processState(choseItem.index).description Then
        Set updatePCtable = oDatagroup.CreateVirtualTable()
        updatePCtable.UpdateCommand = "Update processTable SET description=? where (projectID=?)and(id=?)"
        
        updatePCtable.SetParam UPDATE_CMD, 1, desc
        updatePCtable.SetParam UPDATE_CMD, 2, projectId.id
        updatePCtable.SetParam UPDATE_CMD, 3, choseItem.index
        
        oDatagroup.BeginTransaction
        updatePCtable.ExecuteCommand UPDATE_CMD
        oDatagroup.CommitTransaction
        oDatagroup.DeleteVirtualTable ("updatePCtable")
      End If
    End If
    choseItem.ofForm.PcNameBox(choseItem.index).Caption = name
    choseItem.ofForm.PcDescBox(choseItem.index).Text = desc
    processState(choseItem.index).name = name
    processState(choseItem.index).description = desc

refHandle:
    choseItem.tag = "nothing"
    Me.Hide
    
End Sub

Public Sub setupBeforeShow()
    Text1.Text = choseItem.ofForm.PcNameBox(choseItem.index).Caption
    Text2.Text = choseItem.ofForm.PcDescBox(choseItem.index).Text
End Sub

