VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   1980
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5145
   LinkTopic       =   "Form1"
   ScaleHeight     =   1980
   ScaleWidth      =   5145
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "send"
      Height          =   495
      Left            =   1560
      TabIndex        =   4
      Top             =   1320
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      Height          =   495
      Left            =   1560
      TabIndex        =   2
      Top             =   720
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   495
      Left            =   1560
      TabIndex        =   0
      Top             =   120
      Width           =   3375
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Pager Number"
      Height          =   195
      Left            =   480
      TabIndex        =   3
      Top             =   840
      Width           =   1020
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Text to sent"
      Height          =   195
      Left            =   480
      TabIndex        =   1
      Top             =   240
      Width           =   840
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim PagerObj As Object

Private Sub Command1_Click()
Dim complete As Boolean

On Error GoTo Command1Error
    Command1.Enabled = False
    Set PagerObj = CreateObject("PagerCom.Pager")
    PagerObj.Message = Text1.Text
    PagerObj.Number = Text2.Text
    PagerObj.TypeOfPager = "152"
    complete = PagerObj.SendMessage
    
    Command1.Enabled = True
    
Exit Sub
Command1Error:
    Me.Caption = Err.Number & " : " & Err.Description
End Sub
