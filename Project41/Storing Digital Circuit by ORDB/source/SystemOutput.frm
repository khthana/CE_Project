VERSION 5.00
Begin VB.Form SystemOutput 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "System Output"
   ClientHeight    =   2865
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2865
   ScaleWidth      =   4680
   Begin VB.CommandButton Command4 
      Caption         =   "Cancle"
      Height          =   375
      Left            =   3480
      TabIndex        =   6
      Top             =   2280
      Width           =   975
   End
   Begin VB.CommandButton Command3 
      Caption         =   "O.K."
      Height          =   375
      Left            =   2520
      TabIndex        =   5
      Top             =   2280
      Width           =   975
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Remove"
      Height          =   375
      Left            =   1320
      TabIndex        =   4
      Top             =   2280
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Add"
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   2280
      Width           =   1095
   End
   Begin VB.ListBox List1 
      Height          =   2010
      ItemData        =   "SystemOutput.frx":0000
      Left            =   2520
      List            =   "SystemOutput.frx":0002
      TabIndex        =   1
      Top             =   120
      Width           =   1935
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   240
      TabIndex        =   0
      Top             =   1440
      Width           =   2175
   End
   Begin VB.Label Label1 
      Caption         =   "Select gate that you want to be system output."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   480
      Width           =   2295
   End
End
Attribute VB_Name = "SystemOutput"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private realoutput As Integer

Private Sub Command1_Click()
    If Combo1.ListIndex = -1 Then
        MsgBox "not have select"
    Else
        List1.AddItem (Combo1.Text)
        Combo1.RemoveItem (Combo1.ListIndex)
    End If
End Sub

Private Sub Command2_Click()
    If List1.ListIndex = -1 Then
        MsgBox "not have select"
    Else
        If List1.ListIndex < realoutput Then
            MsgBox "can't remove real output system"
        Else
            Combo1.AddItem (List1.Text)
            List1.RemoveItem (List1.ListIndex)
        End If
    End If
End Sub

Private Sub Command3_Click()
    Dim i As Integer
    Dim temp As String
    
    If List1.ListCount > realoutput Then
        For i = realoutput To List1.ListCount - 1
            List1.ListIndex = i
            temp1 = CInt(Trim(Mid(List1.Text, 5, 2)))
            temp2 = CInt(Trim(Mid(List1.Text, 21, 2)))
            wireds(gates(temp1).outputlist(temp2)).wiredtype = "O"
        Next i
    End If
    Unload Me
End Sub

Private Sub Command4_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Dim i, j As Integer
    Dim message As String

    SystemOutput.Left = 3500
    SystemOutput.Top = 2000
    realoutput = 0
    saveInOutSystem
    For i = 1 To gateCount
        If gates(i).nOutput > 0 Then
            For j = 1 To gates(i).nOutput
                If i > 9 Then
                    message = "Gate"
                Else
                    message = "Gate "
                End If
                message = message + CStr(i) + " Output number " + CStr(j)
                If wireds(gates(i).outputlist(j)).wiredtype <> "I" And wireds(gates(i).outputlist(j)).wiredtype <> "O" Then
                    Combo1.AddItem (message)
                End If
                If wireds(gates(i).outputlist(j)).wiredtype = "O" Then
                    List1.AddItem (message)
                    realoutput = realoutput + 1
                End If
            Next j
        End If
    Next i
End Sub
