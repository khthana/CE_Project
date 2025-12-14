VERSION 5.00
Begin VB.Form Wired 
   BorderStyle     =   0  'None
   Caption         =   "Wired"
   ClientHeight    =   1455
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3750
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1455
   ScaleWidth      =   3750
   ShowInTaskbar   =   0   'False
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   360
      TabIndex        =   2
      Top             =   600
      Width           =   1575
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancle"
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
      Left            =   2160
      TabIndex        =   1
      Top             =   600
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "O.K."
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
      Left            =   2160
      TabIndex        =   0
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Select The Line"
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
      Left            =   360
      TabIndex        =   3
      Top             =   240
      Width           =   1575
   End
End
Attribute VB_Name = "Wired"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Option Base 1

Private Sub Form_Load()

    Wired.Left = 4000
    Wired.Top = 3000
    If MDI.Wired = False Then
        display_combo1
    Else
        display_combo2
    End If
    Comp.Enabled = False
End Sub

Private Sub Command1_Click()
    Dim i As Integer
    Dim existGate As Boolean
    Dim nWired As Integer
    
    If Combo1.ListIndex = -1 Then
        MsgBox "You have to select one line or 'CANCLE'"
    Else
        If MDI.Wired = False Then
            MDI.chooseGate1 = MDI.checkType
            If Combo1.ListIndex + 1 > gates(MDI.chooseGate1).nInput Then
                MDI.wiredtype1 = 2
                MDI.nInOut1 = Combo1.ListIndex + 1 - gates(MDI.chooseGate1).nInput
                MDI.nWired1 = gates(MDI.chooseGate1).outputlist(MDI.nInOut1)
            Else
                MDI.wiredtype1 = 1
                MDI.nInOut1 = Combo1.ListIndex + 1
                MDI.nWired1 = gates(MDI.chooseGate1).inputlist(MDI.nInOut1)
            End If
            MDI.Wired = True
        Else
            MDI.chooseGate2 = MDI.checkType
            If Combo1.ListIndex + 1 > gates(MDI.chooseGate2).nInput Then
                MDI.wiredtype2 = 2
                MDI.nInOut2 = Combo1.ListIndex + 1 - gates(MDI.chooseGate2).nInput
                MDI.nWired2 = gates(MDI.chooseGate2).outputlist(MDI.nInOut2)
            Else
                MDI.wiredtype2 = 1
                MDI.nInOut2 = Combo1.ListIndex + 1
                MDI.nWired2 = gates(MDI.chooseGate2).inputlist(MDI.nInOut2)
            End If
            If (MDI.nWired1 <> MDI.nWired2) And (MDI.nWired1 <> 0) And (MDI.nWired2 <> 0) Then
                MsgBox "Can't connection between group wired"
            Else
                If (MDI.nWired1 = MDI.nWired2) And (MDI.nWired1 <> 0) And (MDI.nWired2 <> 0) Then
                    MsgBox "Have alrady wired"
                Else
                    If (MDI.nWired1 <> 0) Or (MDI.nWired2 <> 0) Then
                        If MDI.nWired1 <> 0 Then
                            If MDI.wiredtype2 = 1 Then
                                gates(MDI.chooseGate2).inputlist(MDI.nInOut2) = MDI.nWired1
                            Else
                                gates(MDI.chooseGate2).outputlist(MDI.nInOut2) = MDI.nWired1
                            End If
                            existGate = False
                            For i = 1 To wireds(MDI.nWired1).ngate
                                If wireds(MDI.nWired1).gatelist(i) = MDI.chooseGate2 Then
                                    existGate = True
                                End If
                            Next i
                            If existGate = False Then
                                wireds(MDI.nWired1).ngate = wireds(MDI.nWired1).ngate + 1
                                wireds(MDI.nWired1).gatelist(wireds(MDI.nWired1).ngate) = MDI.chooseGate2
                            End If
                            If MDI.wiredtype1 = MDI.wiredtype2 Then
                                MsgBox "is input system"
                                wireds(MDI.nWired1).wiredtype = "I"
                            End If
                            Call LayOut.createLine(MDI.chooseGate1, MDI.chooseGate2, MDI.nInOut1, MDI.nInOut2, MDI.wiredtype1, MDI.wiredtype2)
                        Else
                            If MDI.wiredtype1 = 1 Then
                                gates(MDI.chooseGate1).inputlist(MDI.nInOut1) = MDI.nWired2
                            Else
                                gates(MDI.chooseGate1).outputlist(MDI.nInOut1) = MDI.nWired2
                            End If
                            existGate = False
                            For i = 1 To wireds(MDI.nWired2).ngate
                                If wireds(MDI.nWired2).gatelist(i) = MDI.chooseGate1 Then
                                    existGate = True
                                End If
                            Next i
                            If existGate = False Then
                                wireds(MDI.nWired2).ngate = wireds(MDI.nWired2).ngate + 1
                                wireds(MDI.nWired2).gatelist(wireds(MDI.nWired2).ngate) = MDI.chooseGate1
                            End If
                            If MDI.wiredtype1 = MDI.wiredtype2 Then
                                MsgBox "is input system"
                                wireds(MDI.nWired2).wiredtype = "I"
                            End If
                            Call LayOut.createLine(MDI.chooseGate1, MDI.chooseGate2, MDI.nInOut1, MDI.nInOut2, MDI.wiredtype1, MDI.wiredtype2)
                        End If
                    Else
                        wiredCount = wiredCount + 1
                        If UBound(wireds) < wiredCount Then
                            ReDim Preserve wireds(wiredCount + 10)
                        End If
                        wireds(wiredCount).gatelist(1) = MDI.chooseGate1
                        If MDI.chooseGate1 = MDI.chooseGate2 Then
                            wireds(wiredCount).ngate = 1
                        Else
                            wireds(wiredCount).ngate = 2
                            wireds(wiredCount).gatelist(2) = MDI.chooseGate2
                        End If
                        If MDI.wiredtype1 = 1 Then
                            gates(MDI.chooseGate1).inputlist(MDI.nInOut1) = wiredCount
                        Else
                            gates(MDI.chooseGate1).outputlist(MDI.nInOut1) = wiredCount
                        End If
                        If MDI.wiredtype2 = 1 Then
                            gates(MDI.chooseGate2).inputlist(MDI.nInOut2) = wiredCount
                        Else
                            gates(MDI.chooseGate2).outputlist(MDI.nInOut2) = wiredCount
                        End If
                        If MDI.wiredtype1 = MDI.wiredtype2 Then
                            MsgBox "is input system"
                            wireds(wiredCount).wiredtype = "I"
                        End If
                        Call LayOut.createLine(MDI.chooseGate1, MDI.chooseGate2, MDI.nInOut1, MDI.nInOut2, MDI.wiredtype1, MDI.wiredtype2)
                    End If
                End If
            End If
            Comp.Enabled = True
            MDI.Wired = False
        End If
    End If
    Unload Me
End Sub

Private Sub Command2_Click()

    Wired.Hide
    Comp.Enabled = True
    Unload Me
End Sub

Private Sub display_combo1()
    Dim i As Integer

    For i = 1 To gates(MDI.checkType).nInput
        Combo1.AddItem ("input" + CStr(i))
    Next i
    For i = 1 To gates(MDI.checkType).nOutput
        Combo1.AddItem ("output" + CStr(i))
    Next i
End Sub
Private Sub display_combo2()
    Dim i As Integer
    
    For i = 1 To gates(MDI.checkType).nInput
        Combo1.AddItem ("input" + CStr(i))
    Next i
    If MDI.wiredtype1 = 1 Then
        For i = 1 To gates(MDI.checkType).nOutput
            Combo1.AddItem ("output" + CStr(i))
        Next i
    End If
End Sub
