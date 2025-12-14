VERSION 5.00
Begin VB.Form SaveDB 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Save"
   ClientHeight    =   1080
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5745
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1080
   ScaleWidth      =   5745
   Begin VB.CommandButton Command2 
      Caption         =   "Cancle"
      Height          =   375
      Left            =   4320
      TabIndex        =   2
      Top             =   480
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "O.K."
      Height          =   375
      Left            =   4320
      TabIndex        =   1
      Top             =   120
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   4095
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "ENTER YOUR PROJECT NAME"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   3375
   End
End
Attribute VB_Name = "SaveDB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()
    Dim oNewcomp As ddoTable

    If Text1.Text <> "" Then
        pid = Text1.Text
        saveModel
        If MDI.saveType = 1 Then
            checkModel
            If MDI.resultCheck = 0 Then
                MsgBox "PASS"
            End If
            If MDI.resultCheck = 1 Then
                MsgBox "NOT PASS (have loop)"
            End If
            If MDI.resultCheck = 2 Then
                MsgBox "NOT PASS (have input more than one)"
            End If
        End If
        If MDI.saveType = 2 Then
            checkModel
            If MDI.resultCheck = 0 Then
                Simulate.Show
                MDI.mnuSimulate.Enabled = False
            End If
            If MDI.resultCheck = 1 Then
                MsgBox "NOT PASS (have loop)"
            End If
            If MDI.resultCheck = 2 Then
                MsgBox "NOT PASS (have input more than one)"
            End If
        End If
        If MDI.saveType = 3 Then
            checkModel
            If MDI.resultCheck = 0 Then
                Set oNewcomp = oDatagroup.CreateVirtualTable
                oNewcomp.QueryCommand = "{call makenew(?)}"
                oNewcomp.SetParam QUERY_CMD, 1, lid
                oNewcomp.ExecuteCommand QUERY_CMD
                oDatagroup.DeleteVirtualTable (oNewcomp.name)
                Set oNewcomp = Nothing
            End If
            If MDI.resultCheck = 1 Then
                MsgBox "NOT PASS (have loop)"
            End If
            If MDI.resultCheck = 2 Then
                MsgBox "NOT PASS (have input more than one)"
            End If
        End If
        Unload Me
    End If
End Sub

Private Sub Command2_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    SaveDB.Left = 3000
    SaveDB.Top = 2500
End Sub
