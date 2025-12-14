VERSION 5.00
Begin VB.Form Query 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Query"
   ClientHeight    =   3195
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4725
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3195
   ScaleWidth      =   4725
   Begin VB.TextBox sqlText 
      Height          =   2415
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   2
      Top             =   600
      Width           =   4455
   End
   Begin VB.CommandButton Execute 
      Caption         =   "Execute"
      Height          =   375
      Left            =   3240
      TabIndex        =   1
      Top             =   120
      Width           =   1335
   End
   Begin VB.Label Label1 
      Caption         =   "SQL Statement :"
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1455
   End
End
Attribute VB_Name = "Query"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Execute_Click()
    Query.Hide
    MDI.mnuQuery.Enabled = True
    Result.Show
End Sub

