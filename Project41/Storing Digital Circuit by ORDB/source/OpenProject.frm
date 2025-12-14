VERSION 5.00
Begin VB.Form OpenProject 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Open Project"
   ClientHeight    =   1530
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6645
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1530
   ScaleLeft       =   1000
   ScaleMode       =   0  'User
   ScaleTop        =   2000
   ScaleWidth      =   6645
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "OpenProject.frx":0000
      Left            =   360
      List            =   "OpenProject.frx":0002
      Sorted          =   -1  'True
      TabIndex        =   3
      Top             =   720
      Width           =   4455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancle"
      Height          =   495
      Left            =   5160
      TabIndex        =   2
      Top             =   720
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "O.K."
      Height          =   495
      Left            =   5160
      TabIndex        =   1
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "ENTER PROJECT NAME THAT YOU WANT TO OPEN"
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
      TabIndex        =   0
      Top             =   360
      Width           =   4695
   End
End
Attribute VB_Name = "OpenProject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()
    Dim oLoadname As ddoTable
    
    If Combo1.ListIndex = -1 Then
        MsgBox "not select yet"
    Else
        LayOut.Visible = True
        LayOut.Top = 1700
        LayOut.Left = 0
        LayOut.Show
        Comp.Enabled = True
        Comp.Visible = True
        Comp.Top = 0
        Comp.Left = 800
        MDI.mnuNewComp.Enabled = True
        pid = Trim(Combo1.Text)
        Set oLoadname = oDatagroup.CreateVirtualTable
        oLoadname.QueryCommand = "select lid from proj_layout where pid = '" + pid + "'"
        oLoadname.ExecuteCommand QUERY_CMD
        lid = oLoadname.Columns(1)
        oDatagroup.DeleteVirtualTable (oLoadname.name)
        Set oLoadname = Nothing
        loadModel
        LayOut.loadProject
        Unload Me
    End If
End Sub

Private Sub Command2_Click()
    MDI.mnuNew.Enabled = True
    Unload Me
End Sub

Private Sub Form_Load()
    Dim oLoadname As ddoTable
    Dim i As Integer
    Dim temp As String

    OpenProject.Left = 2500
    OpenProject.Top = 2500
    Set oLoadname = oDatagroup.CreateVirtualTable
    oLoadname.QueryCommand = "select pid from proj_layout"
    oLoadname.ExecuteCommand QUERY_CMD
    If oLoadname.TotalRecordCount = 0 Then
        MsgBox "not project"
    Else
        temp = ""
        Do While oLoadname.Columns(1).Value <> temp
            Combo1.AddItem (oLoadname.Columns(1).Value)
            temp = oLoadname.Columns(1).Value
            oLoadname.NextRecord
        Loop
    End If
    oDatagroup.DeleteVirtualTable (oLoadname.name)
    Set oLoadname = Nothing
End Sub
