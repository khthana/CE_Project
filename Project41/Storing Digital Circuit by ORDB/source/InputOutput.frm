VERSION 5.00
Begin VB.Form InputOutput 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Input-Output"
   ClientHeight    =   3255
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5550
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3255
   ScaleWidth      =   5550
   Visible         =   0   'False
   Begin VB.ListBox List2 
      Height          =   1815
      ItemData        =   "InputOutput.frx":0000
      Left            =   2880
      List            =   "InputOutput.frx":0002
      TabIndex        =   4
      Top             =   1080
      Width           =   2415
   End
   Begin VB.ListBox List1 
      Height          =   1815
      ItemData        =   "InputOutput.frx":0004
      Left            =   240
      List            =   "InputOutput.frx":0006
      TabIndex        =   3
      Top             =   1080
      Width           =   2295
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   1680
      TabIndex        =   1
      Top             =   120
      Width           =   2055
   End
   Begin VB.CommandButton okInput 
      Caption         =   "O.K."
      Height          =   375
      Left            =   4080
      TabIndex        =   0
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "Output"
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
      Left            =   2880
      TabIndex        =   6
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Input"
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
      TabIndex        =   5
      Top             =   840
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
      TabIndex        =   2
      Top             =   240
      Width           =   1575
   End
End
Attribute VB_Name = "InputOutput"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Combo1_Click()
    Dim i As Integer
    Dim oGetvalue As ddoTable

    List1.Clear
    List2.Clear
    Set oGetvalue = oDatagroup.CreateVirtualTable
    oGetvalue.QueryCommand = "{call getvalue(" + CStr(Combo1.ListIndex + 1) + "," + CStr(lid) + ")}"
    oGetvalue.ExecuteCommand QUERY_CMD
    For i = 1 To gates(Combo1.ListIndex + 1).nInput
        List1.AddItem ("input " + CStr(i) + " = " + CStr(oGetvalue.Columns(1).Value))
        oGetvalue.NextRecord
    Next i
    For i = 1 To gates(Combo1.ListIndex + 1).nOutput
        List2.AddItem ("output " + CStr(i) + " = " + CStr(oGetvalue.Columns(1).Value))
        oGetvalue.NextRecord
    Next i
    oDatagroup.DeleteVirtualTable (oGetvalue.name)
    Set oGetvalue = Nothing
End Sub

Private Sub Form_Load()
    Dim i As Integer

    InputOutput.Left = 3500
    InputOutput.Top = 2000
    For i = 1 To gateCount
        Combo1.AddItem (i)
    Next i
End Sub

Private Sub okInput_Click()
    Unload Me
End Sub
