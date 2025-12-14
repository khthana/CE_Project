VERSION 5.00
Begin VB.Form LoadComp 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Load New Component"
   ClientHeight    =   1830
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4515
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1830
   ScaleWidth      =   4515
   Begin VB.CommandButton Command1 
      Caption         =   "O.K."
      Height          =   495
      Left            =   3000
      TabIndex        =   2
      Top             =   360
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancle"
      Height          =   495
      Left            =   3000
      TabIndex        =   1
      Top             =   840
      Width           =   1215
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   240
      TabIndex        =   0
      Top             =   840
      Width           =   2415
   End
   Begin VB.Label Label1 
      Caption         =   "LOAD NEW COMPONENT"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   480
      Width           =   2655
   End
End
Attribute VB_Name = "LoadComp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    Dim oLoadname As ddoTable
    
    If Combo1.ListIndex = -1 Then
        MsgBox "not select yet"
    Else
        MDI.tempname = Trim(Combo1.Text)
        Set oLoadname = oDatagroup.CreateVirtualTable
        oLoadname.QueryCommand = "select lid from proj_layout where pid = '" + MDI.tempname + "'"
        oLoadname.ExecuteCommand QUERY_CMD
        MDI.templayout = oLoadname.Columns(1)
        oDatagroup.DeleteVirtualTable (oLoadname.name)
        Set oLoadname = Nothing
        Set oLoadname = oDatagroup.CreateVirtualTable
        oLoadname.QueryCommand = "{call getwidnumberinput(?)}"
        oLoadname.SetParam QUERY_CMD, 1, MDI.templayout
        oLoadname.ExecuteCommand QUERY_CMD
        MDI.tempninput = oLoadname.Columns(1)
        oDatagroup.DeleteVirtualTable (oLoadname.name)
        Set oLoadname = Nothing
        Set oLoadname = oDatagroup.CreateVirtualTable
        oLoadname.QueryCommand = "{call getwidnumberoutput(?)}"
        oLoadname.SetParam QUERY_CMD, 1, MDI.templayout
        oLoadname.ExecuteCommand QUERY_CMD
        MDI.tempnoutput = oLoadname.Columns(1)
        oDatagroup.DeleteVirtualTable (oLoadname.name)
        Set oLoadname = Nothing
        Unload Me
        LayOut.createpicture (8)
    End If
End Sub

Private Sub Command2_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Dim oLoadname As ddoTable
    Dim i As Integer
    LoadComp.Left = 4000
    LoadComp.Top = 2000
    
    Set oLoadname = oDatagroup.CreateVirtualTable
    oLoadname.QueryCommand = "select pid from proj_layout where newcomp = 'Y'"
    oLoadname.ExecuteCommand QUERY_CMD
    If oLoadname.TotalRecordCount = 0 Then
        MsgBox "not project"
    Else
        For i = 1 To oLoadname.TotalRecordCount
            Combo1.AddItem (oLoadname.Columns(1).Value)
            oLoadname.NextRecord
        Next i
    End If
    oDatagroup.DeleteVirtualTable (oLoadname.name)
    Set oLoadname = Nothing
End Sub
