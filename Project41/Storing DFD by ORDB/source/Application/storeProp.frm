VERSION 5.00
Begin VB.Form storeProp 
   BackColor       =   &H80000001&
   Caption         =   "Store Properties"
   ClientHeight    =   1095
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3225
   BeginProperty Font 
      Name            =   "Arial Narrow"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form2"
   ScaleHeight     =   1095
   ScaleWidth      =   3225
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CancleCmd 
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1800
      TabIndex        =   3
      Top             =   600
      Width           =   735
   End
   Begin VB.CommandButton OKcmd 
      Caption         =   "O.K."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   840
      TabIndex        =   2
      Top             =   600
      Width           =   735
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1080
      MaxLength       =   15
      TabIndex        =   1
      Text            =   "NAME"
      Top             =   120
      Width           =   1935
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
      Left            =   360
      TabIndex        =   0
      Top             =   120
      Width           =   630
   End
End
Attribute VB_Name = "storeProp"
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
    Dim updateDStable As ddoTable
    Dim updateEXtable As ddoTable
    
    If Text1.Text <> "" Then
        name = Text1.Text
    Else:
        name = "NAME"
    End If
    
    If choseItem.tag = "D" Then
        name = UCase(Text1.Text)
        If name = datastoreState(choseItem.index).name Then
            Exit Sub
        Else
            If referencedByGate(choseItem.index, choseItem.tag) = True Then
                MsgBox "can't update properties :: object is referenced"
                GoTo exitSub
            End If
            If formState(CInt(choseItem.ofForm.tag)).saved = True Then
                GoTo updateDS
            Else: GoTo setNewValue
            End If
        End If
    End If
    
    If choseItem.tag = "E" Then
        If name = externalState(choseItem.index).name Then
            Exit Sub
        
        Else
            If referencedByGate(choseItem.index, choseItem.tag) = True Then
                MsgBox "can't update properties :: object is referenced"
                GoTo exitSub
            End If
            If formState(CInt(choseItem.ofForm.tag)).saved = True Then
                GoTo updateEX
            Else: GoTo setNewValue
            End If
        End If
    End If
        
    

updateDS:
        Set updateDStable = oDatagroup.CreateVirtualTable()
        updateDStable.UpdateCommand = "Update datastoreTable SET name=? where (projectID=?)and(id=?)"
        
        updateDStable.SetParam UPDATE_CMD, 1, name
        updateDStable.SetParam UPDATE_CMD, 2, projectId.id
        updateDStable.SetParam UPDATE_CMD, 3, choseItem.index
        
        oDatagroup.BeginTransaction
        updateDStable.ExecuteCommand UPDATE_CMD
        oDatagroup.CommitTransaction
        oDatagroup.DeleteVirtualTable ("updateDStable")
        GoTo setNewValue
        
updateEX:
        Set updateEXtable = oDatagroup.CreateVirtualTable()
        updateEXtable.UpdateCommand = "Update externalTable SET name=? where (projectID=?)and(id=?)"
        
        updateEXtable.SetParam UPDATE_CMD, 1, name
        updateEXtable.SetParam UPDATE_CMD, 2, projectId.id
        updateEXtable.SetParam UPDATE_CMD, 3, choseItem.index
        
        oDatagroup.BeginTransaction
        updateEXtable.ExecuteCommand UPDATE_CMD
        oDatagroup.CommitTransaction
        oDatagroup.DeleteVirtualTable ("updateEXtable")
        GoTo setNewValue

setNewValue:
    Select Case choseItem.tag
      Case "E"
        choseItem.ofForm.EsNameBox(choseItem.index).Caption = name
        externalState(choseItem.index).name = name
      Case "D"
        choseItem.ofForm.DsNameBox(choseItem.index).Caption = name
        datastoreState(choseItem.index).name = name
    End Select

exitSub:
    choseItem.tag = "nothing"
    Me.Hide
    
End Sub

Public Sub setupBeforeShow()
    Select Case choseItem.tag
      Case "E"
        Text1.Text = choseItem.ofForm.EsNameBox(choseItem.index).Caption
      Case "D"
        Text1.Text = choseItem.ofForm.DsNameBox(choseItem.index).Caption
    End Select
End Sub


