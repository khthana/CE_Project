VERSION 5.00
Begin VB.Form Simulate 
   BackColor       =   &H8000000A&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Simulate"
   ClientHeight    =   3885
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4200
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3885
   ScaleWidth      =   4200
   Begin VB.Frame Frame1 
      Caption         =   "Select Input Value"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Left            =   120
      TabIndex        =   3
      Top             =   1920
      Width           =   2295
      Begin VB.CommandButton setSim 
         Caption         =   "Set"
         Height          =   495
         Left            =   600
         TabIndex        =   6
         Top             =   840
         Width           =   1095
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         Left            =   240
         TabIndex        =   4
         Top             =   360
         Width           =   1815
      End
   End
   Begin VB.ListBox List1 
      Height          =   1035
      ItemData        =   "Simulate.frx":0000
      Left            =   240
      List            =   "Simulate.frx":0002
      Sorted          =   -1  'True
      TabIndex        =   2
      Top             =   600
      Width           =   3615
   End
   Begin VB.CommandButton cancleSim 
      Caption         =   "Cancle"
      Height          =   495
      Left            =   2640
      TabIndex        =   1
      Top             =   2760
      Width           =   1215
   End
   Begin VB.CommandButton okSim 
      Caption         =   "O.K."
      Height          =   495
      Left            =   2640
      TabIndex        =   0
      Top             =   2280
      Width           =   1215
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Select Gate"
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
      TabIndex        =   5
      Top             =   240
      Width           =   1815
   End
End
Attribute VB_Name = "Simulate"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cancleSim_Click()
    MDI.mnuSimulate = True
    Unload Me
End Sub

Private Sub Form_Load()
    Dim i, j, temp As Integer
    Dim oClearValue As ddoTable
    Dim message As String
    
    Simulate.Left = 4000
    Simulate.Top = 2000
    Set oClearValue = oDatagroup.CreateVirtualTable
    oClearValue.QueryCommand = "{call initvalue()}"
    oClearValue.ExecuteCommand QUERY_CMD
    oDatagroup.DeleteVirtualTable (oClearValue.name)
    Set oClearValue = Nothing
    For i = 1 To wiredCount
        If wireds(i).wiredtype = "I" Then
            If wireds(i).gatelist(1) > 9 Then
                message = "Gate"
            Else
                message = "Gate "
            End If
            For j = 1 To gates(wireds(i).gatelist(1)).nInput
                If gates(wireds(i).gatelist(1)).inputlist(j) = i Then
                    message = message + CStr(wireds(i).gatelist(1)) + " Input number "
                    If j > 9 Then
                        message = message + " "
                    End If
                    List1.AddItem (message + CStr(j) + " = ")
                    Exit For
                End If
            Next j
        End If
    Next i
    Combo1.AddItem ("H")
    Combo1.AddItem ("L")
End Sub

Private Sub okSim_Click()
    Dim i As Integer
    Dim wiredn As Integer
    Dim oInsertValue As ddoTable
    Dim oSimulate As ddoTable
    Dim complete As Boolean

    complete = True
    Set oInsertValue = oDatagroup.CreateVirtualTable
    For i = 0 To List1.ListCount - 1
        List1.ListIndex = i
        If Len(List1.Text) < 25 Then
            MsgBox "not set value complete"
            complete = False
            Exit For
        Else
            wiredn = gates(CInt(Trim(Mid(List1.Text, 5, 2)))).inputlist(CInt(Trim(Mid(List1.Text, 20, 2))))
            oInsertValue.QueryCommand = "{call insertvalue(?,'" + Mid(List1.Text, 25, 1) + "',?)}"
            oInsertValue.SetParam QUERY_CMD, 1, wiredn
            oInsertValue.SetParam QUERY_CMD, 2, lid
            oInsertValue.ExecuteCommand QUERY_CMD
        End If
    Next i
    oDatagroup.DeleteVirtualTable (oInsertValue.name)
    Set oInsertValue = Nothing
    If complete Then
        Set oSimulate = oDatagroup.CreateVirtualTable
        oSimulate.QueryCommand = "{call genaratefinal(?)}"
        oSimulate.SetParam QUERY_CMD, 1, lid
        oSimulate.ExecuteCommand QUERY_CMD
        MsgBox "finish"
        oDatagroup.DeleteVirtualTable (oSimulate.name)
        Set oSimulate = Nothing
        InputOutput.Show
    End If
    MDI.mnuSimulate = True
    Unload Me
End Sub

Private Sub setSim_Click()
    Dim temp As String
    
    If List1.ListIndex = -1 Or Combo1.ListIndex = -1 Then
        MsgBox "must choose GATE and VALUE before"
    Else
        temp = Mid(List1.Text, 1, 24) + Combo1.Text
        List1.RemoveItem (List1.ListIndex)
        List1.AddItem (temp)
    End If
End Sub
