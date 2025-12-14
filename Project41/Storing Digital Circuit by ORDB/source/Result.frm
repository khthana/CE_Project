VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Result 
   Caption         =   "Result"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   Begin MSDBGrid.DBGrid DBGrid1 
      Height          =   2415
      Left            =   120
      OleObjectBlob   =   "Result.frx":0000
      TabIndex        =   1
      Top             =   120
      Width           =   4455
   End
   Begin VB.CommandButton okResult 
      Caption         =   "O.K."
      Height          =   495
      Left            =   3360
      TabIndex        =   0
      Top             =   2640
      Width           =   1215
   End
End
Attribute VB_Name = "Result"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub okResult_Click()
    Result.Hide
End Sub
