VERSION 5.00
Begin VB.Form Form3 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "รหัสนักศึกษา"
   ClientHeight    =   3225
   ClientLeft      =   3840
   ClientTop       =   3330
   ClientWidth     =   3900
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3225
   ScaleWidth      =   3900
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.Frame Frame2 
      Caption         =   "รหัสวิชาที่อยู่ในทะเบียน"
      Height          =   3135
      Left            =   120
      TabIndex        =   5
      Top             =   0
      Width           =   2415
      Begin VB.TextBox Text2 
         Height          =   375
         Left            =   120
         TabIndex        =   7
         Top             =   2640
         Width           =   2175
      End
      Begin VB.ListBox List2 
         Height          =   2205
         ItemData        =   "Form3.frx":0000
         Left            =   120
         List            =   "Form3.frx":0002
         TabIndex        =   6
         Top             =   240
         Width           =   2175
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   2760
      TabIndex        =   1
      Top             =   1800
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&OK"
      Height          =   375
      Left            =   2760
      TabIndex        =   0
      Top             =   1080
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Caption         =   "รหัสนักศึกษาที่อยู่ในทะเบียน"
      Height          =   3135
      Left            =   120
      TabIndex        =   2
      Top             =   0
      Width           =   2415
      Begin VB.TextBox Text1 
         Height          =   375
         Left            =   120
         TabIndex        =   4
         Top             =   2640
         Width           =   2175
      End
      Begin VB.ListBox List1 
         Height          =   2205
         ItemData        =   "Form3.frx":0004
         Left            =   120
         List            =   "Form3.frx":0006
         TabIndex        =   3
         Top             =   240
         Width           =   2175
      End
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public a1 As Integer
Public a2 As Integer
Public chk1, chk2 As Boolean
Private Sub Command1_Click()
    If Form3.Caption = "รหัสนักศึกษา" Then
        Form1.Text2(0).Text = List1.Text
        Form1.Enabled = True
        Form1.Text2(0).SetFocus
        chk1 = True
    End If
    If Form3.Caption = "รหัสวิชา" Then
        Form1.Text2(1).Text = List2.Text
        Form1.Enabled = True
        Form1.Text2(1).SetFocus
        chk2 = True
    End If
End Sub

Private Sub Command2_Click()
    Form3.Hide
    Form1.Enabled = True
    Form1.Show
End Sub

Private Sub Form_Terminate()
    Form1.Enabled = True
    Form1.Show
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Form1.Enabled = True
    Form1.Show
End Sub

Private Sub List1_Click()
Dim ii As Integer
    ii = List1.ListIndex
    a1 = ii
    Form1.record_std.MoveFirst
    Form1.record_std.Move ii
    Text1.Text = ii
    Text1.Text = Form1.record_std.Fields("tname").Value
End Sub

Private Sub List2_Click()
Dim ii As Integer
    ii = List2.ListIndex
    a2 = ii
    Form1.record_sub.MoveFirst
    Form1.record_sub.Move ii
    Text2.Text = ii
    Text2.Text = Form1.record_sub.Fields("tname").Value
End Sub
