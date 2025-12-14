VERSION 5.00
Begin VB.Form LayOut 
   BackColor       =   &H80000009&
   BorderStyle     =   0  'None
   Caption         =   "Lay Out"
   ClientHeight    =   5625
   ClientLeft      =   0
   ClientTop       =   1695
   ClientWidth     =   11910
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5558.301
   ScaleMode       =   0  'User
   ScaleWidth      =   11910
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.CommandButton Command1 
      Caption         =   "Close"
      Height          =   495
      Left            =   10800
      TabIndex        =   0
      Top             =   0
      Width           =   1095
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   4.5
         Charset         =   255
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   90
      Index           =   0
      Left            =   2640
      TabIndex        =   1
      Top             =   2160
      Width           =   90
   End
   Begin VB.Line Line1 
      BorderWidth     =   3
      Index           =   0
      Visible         =   0   'False
      X1              =   1320
      X2              =   960
      Y1              =   355.731
      Y2              =   1897.233
   End
   Begin VB.Image Image1 
      Height          =   15
      Index           =   0
      Left            =   480
      Top             =   2760
      Width           =   15
   End
End
Attribute VB_Name = "LayOut"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Base 1

Private clickx As Integer
Private clicky As Integer
Private i As Integer
Private x, y As Integer
Private compMove As Integer

Public Sub createLine(gate1, gate2, ioNumber1, ioNumber2, ioType1, ioType2 As Integer)
    Dim yGate1, yGate2, xGate1, xGate2 As Integer

    lineCount = lineCount + 3
    Load Line1(lineCount)
    Load Line1(lineCount - 1)
    Load Line1(lineCount - 2)
    Line1(lineCount).Visible = True
    Line1(lineCount - 1).Visible = True
    Line1(lineCount - 2).Visible = True
    If ioType1 = 1 Then
        yGate1 = gates(gate1).posy + ((Image1(gate1 - 1).Height / (gates(gate1).nInput + 1)) * ioNumber1)
        xGate1 = gates(gate1).posx
    Else
        yGate1 = gates(gate1).posy + ((Image1(gate1 - 1).Height / (gates(gate1).nOutput + 1)) * ioNumber1)
        xGate1 = gates(gate1).posx + Image1(gate1 - 1).Width
    End If
    If ioType2 = 1 Then
        yGate2 = gates(gate2).posy + ((Image1(gate2 - 1).Height / (gates(gate2).nInput + 1)) * ioNumber2)
        xGate2 = gates(gate2).posx
    Else
        yGate2 = gates(gate2).posy + ((Image1(gate2 - 1).Height / (gates(gate2).nOutput + 1)) * ioNumber2)
        xGate2 = gates(gate2).posx + Image1(gate2 - 1).Width
    End If
    Line1(lineCount).X1 = xGate1
    Line1(lineCount).X2 = xGate1 + ((xGate2 - xGate1) / 2)
    Line1(lineCount).Y1 = yGate1
    Line1(lineCount).Y2 = yGate1
    
    Line1(lineCount - 1).X1 = Line1(lineCount).X2
    Line1(lineCount - 1).X2 = Line1(lineCount).X2
    Line1(lineCount - 1).Y1 = yGate1
    Line1(lineCount - 1).Y2 = yGate2
    
    Line1(lineCount - 2).X1 = Line1(lineCount).X2
    Line1(lineCount - 2).X2 = xGate2
    Line1(lineCount - 2).Y1 = yGate2
    Line1(lineCount - 2).Y2 = yGate2
    Image1(gate1 - 1).Tag = "0"
    Image1(gate2 - 1).Tag = "0"
End Sub

Public Sub createpicture(index As Integer)
    gateCount = gateCount + 1
    If gateCount - 1 > 0 Then
        Load Label1(gateCount - 1)
        Load Image1(gateCount - 1)
    End If
    If UBound(gates) < gateCount Then
        ReDim Preserve gates(gateCount + 10)
    End If
    If index = 1 Then
        Image1(gateCount - 1).Picture = LoadPicture("picture\and.gif")
        gates(gateCount).gateType = "and"
        gates(gateCount).nInput = 2
        gates(gateCount).nOutput = 1
    End If
    If index = 2 Then
        Image1(gateCount - 1).Picture = LoadPicture("picture\or.gif")
        gates(gateCount).gateType = "or"
        gates(gateCount).nInput = 2
        gates(gateCount).nOutput = 1
    End If
    If index = 3 Then
        Image1(gateCount - 1).Picture = LoadPicture("picture\not.gif")
        gates(gateCount).gateType = "not"
        gates(gateCount).nInput = 1
        gates(gateCount).nOutput = 1
    End If
    If index = 4 Then
        Image1(gateCount - 1).Picture = LoadPicture("picture\nand.gif")
        gates(gateCount).gateType = "nand"
        gates(gateCount).nInput = 2
        gates(gateCount).nOutput = 1
    End If
    If index = 5 Then
        Image1(gateCount - 1).Picture = LoadPicture("picture\nor.gif")
        gates(gateCount).gateType = "nor"
        gates(gateCount).nInput = 2
        gates(gateCount).nOutput = 1
    End If
    If index = 6 Then
        Image1(gateCount - 1).Picture = LoadPicture("picture\xor.gif")
        gates(gateCount).gateType = "xor"
        gates(gateCount).nInput = 2
        gates(gateCount).nOutput = 1
    End If
    If index = 7 Then
        Image1(gateCount - 1).Picture = LoadPicture("picture\xnor.gif")
        gates(gateCount).gateType = "xnor"
        gates(gateCount).nInput = 2
        gates(gateCount).nOutput = 1
    End If
    If index = 8 Then
        Image1(gateCount - 1).Picture = LoadPicture("picture\new.gif")
        gates(gateCount).gateType = "new"
        gates(gateCount).linkLayout = MDI.templayout
        gates(gateCount).nInput = MDI.tempninput
        gates(gateCount).nOutput = MDI.tempnoutput
    End If
    Image1(gateCount - 1).Left = 100
    Image1(gateCount - 1).Top = 100
    Label1(gateCount - 1).Caption = gateCount
    If gates(gateCount).gateType = "new" Then
        Label1(gateCount - 1).Caption = CStr(gateCount) + " " + MDI.tempname
    End If
    Label1(gateCount - 1).Top = Image1(gateCount - 1).Top + 100
    Label1(gateCount - 1).Left = Image1(gateCount - 1).Left + 200
    gates(gateCount).posx = 100
    gates(gateCount).posy = 100
    Label1(gateCount - 1).Visible = True
    Image1(gateCount - 1).Visible = True
    Image1(gateCount - 1).Tag = "1"
End Sub

Public Sub loadProject()
    Dim i, j, k, cinputGate, coutputGate As Integer
    Dim inputGate() As group
    Dim outputGate() As group
    Dim oGetname As ddoTable
    
    For i = 1 To gateCount
        If i - 1 > 0 Then
            Load Label1(i - 1)
            Load Image1(i - 1)
        End If
        If gates(i).gateType = "and" Then
            Image1(i - 1).Picture = LoadPicture("project\and.gif")
        End If
        If gates(i).gateType = "or" Then
            Image1(i - 1).Picture = LoadPicture("project\or.gif")
        End If
        If gates(i).gateType = "not" Then
            Image1(i - 1).Picture = LoadPicture("project\not.gif")
        End If
        If gates(i).gateType = "nand" Then
            Image1(i - 1).Picture = LoadPicture("project\nand.gif")
        End If
        If gates(i).gateType = "nor" Then
            Image1(i - 1).Picture = LoadPicture("project\nor.gif")
        End If
        If gates(i).gateType = "xor" Then
            Image1(i - 1).Picture = LoadPicture("project\xor.gif")
        End If
        If gates(i).gateType = "xnor" Then
            Image1(i - 1).Picture = LoadPicture("project\xnor.gif")
        End If
        If gates(i).gateType = "new" Then
            Image1(i - 1).Picture = LoadPicture("project\new.gif")
        End If
        Image1(i - 1).Left = gates(i).posx
        Image1(i - 1).Top = gates(i).posy
        Label1(i - 1).Caption = i
        If gates(i).gateType = "new" Then
            Set oGetname = oDatagroup.CreateVirtualTable
            oGetname.QueryCommand = "select pid from proj_layout where lid = ?"
            oGetname.SetParam QUERY_CMD, 1, gates(i).linkLayout
            oGetname.ExecuteCommand QUERY_CMD
            Label1(i - 1).Caption = CStr(i) + " " + Trim(oGetname.Columns(1).Value)
        End If
        Label1(i - 1).Top = Image1(i - 1).Top + 100
        Label1(i - 1).Left = Image1(i - 1).Left + 200
        Label1(i - 1).Visible = True
        Image1(i - 1).Visible = True
        Image1(i - 1).Tag = "0"
    Next i
    For i = 1 To wiredCount
        cinputGate = 0
        coutputGate = 0
        ReDim inputGate(10) As group
        ReDim outputGate(10) As group
        For j = 1 To wireds(i).ngate
            For k = 1 To gates(wireds(i).gatelist(j)).nInput
                If gates(wireds(i).gatelist(j)).inputlist(k) = i Then
                    cinputGate = cinputGate + 1
                    inputGate(cinputGate).name = wireds(i).gatelist(j)
                    inputGate(cinputGate).number = k
                End If
            Next k
        Next j
        For j = 1 To wireds(i).ngate
            For k = 1 To gates(wireds(i).gatelist(j)).nOutput
                If gates(wireds(i).gatelist(j)).outputlist(k) = i Then
                    coutputGate = coutputGate + 1
                    outputGate(coutputGate).name = wireds(i).gatelist(j)
                    outputGate(coutputGate).number = k
                End If
            Next k
        Next j
        If cinputGate + coutputGate > 1 Then
            If cinputGate > 0 And coutputGate > 0 Then
                For j = 1 To cinputGate
                    Call createLine(outputGate(1).name, inputGate(j).name, outputGate(1).number, inputGate(j).number, 2, 1)
                Next j
                If coutputGate > 1 Then
                    For j = 2 To coutputGate
                        Call createLine(outputGate(j).name, inputGate(1).name, outputGate(j).number, inputGate(1).number, 2, 1)
                    Next j
                End If
            Else
                For j = 2 To cinputGate
                    Call createLine(inputGate(1).name, inputGate(j).name, inputGate(1).number, inputGate(j).number, 1, 1)
                Next j
            End If
        End If
    Next i
End Sub

Private Sub Command1_Click()
    LayOut.Visible = False
    LayOut.Hide
    Comp.Hide
    MDI.mnuProject.Enabled = False
    MDI.mnuNew.Enabled = True
    MDI.mnuOpen.Enabled = True
    MDI.mnuSave.Enabled = False
    MDI.layoutClose = True
    Unload Me
End Sub

Private Sub Form_DragDrop(Source As Control, x As Single, y As Single)
    Source.Left = x - clickx
    Source.Top = y - clicky
    gates(compMove).posx = Source.Left
    gates(compMove).posy = Source.Top
    Label1(compMove - 1).Top = Source.Top + 100
    Label1(compMove - 1).Left = Source.Left + 200
End Sub

Private Sub Form_Load()
    gateCount = 0
    wiredCount = 0
    lineCount = 0
    clickx = 0
    clicky = 0
    i = 1
    x = 50
    y = 50
    pid = ""
    ReDim gates(10)
    ReDim wireds(10)
    MDI.Wired = False
    Comp.Show
    Comp.Enabled = True
    MDI.mnuProject.Enabled = True
    MDI.mnuSave.Enabled = True
    MDI.layoutClose = False
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    If Button = 2 Then PopupMenu MDI.mnuProject
    End Sub

Private Sub Image1_DragDrop(index As Integer, Source As Control, x As Single, y As Single)
   
        Source.Left = Source.Left + x - clickx
        Source.Top = Source.Top + y - clicky
        gates(compMove).posx = Source.Left
        gates(compMove).posy = Source.Top
        Label1(index).Top = Source.Top + 100
        Label1(index).Left = Source.Left + 200
End Sub

Private Sub Image1_MouseDown(index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
    If Button = 1 Then
        If MDI.Wired = True Then
            MsgBox "You have to select gate line for Wiring."
        Else
            If Image1(index).Tag <> "0" Then
                clickx = x
                clicky = y
                compMove = index + 1
                Image1(index).Drag
            End If
        End If
    ElseIf Button = 2 Then
        MDI.checkType = index + 1
        Wired.Show
    End If
End Sub
