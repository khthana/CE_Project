VERSION 5.00
Begin VB.Form Form2 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Form2"
   ClientHeight    =   1950
   ClientLeft      =   4440
   ClientTop       =   3525
   ClientWidth     =   3015
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1950
   ScaleWidth      =   3015
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame4 
      Caption         =   "Frame4"
      Height          =   1815
      Left            =   120
      TabIndex        =   10
      Top             =   0
      Width           =   1935
      Begin VB.OptionButton Option2 
         Caption         =   "สามัญ"
         Height          =   255
         Left            =   360
         TabIndex        =   18
         Top             =   1080
         Width           =   1215
      End
      Begin VB.OptionButton Option1 
         Caption         =   "ทดลองเรียน"
         Height          =   375
         Left            =   360
         TabIndex        =   17
         Top             =   480
         Width           =   1335
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   2160
      TabIndex        =   2
      Top             =   1080
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&OK"
      Height          =   375
      Left            =   2160
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   480
      Width           =   735
   End
   Begin VB.Frame Frame5 
      Caption         =   "Frame5"
      Height          =   1815
      Left            =   120
      TabIndex        =   11
      Top             =   0
      Width           =   1935
      Begin VB.ListBox List5 
         Height          =   645
         ItemData        =   "Form2.frx":0000
         Left            =   120
         List            =   "Form2.frx":000A
         TabIndex        =   12
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label Label5 
         Caption         =   "A - บรรยาย"
         Height          =   255
         Left            =   480
         TabIndex        =   14
         Top             =   1080
         Width           =   975
      End
      Begin VB.Label Label6 
         Caption         =   "B - ปฏิบัติ"
         Height          =   255
         Left            =   480
         TabIndex        =   13
         Top             =   1440
         Width           =   1215
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Frame3"
      Height          =   1815
      Left            =   120
      TabIndex        =   6
      Top             =   0
      Width           =   1935
      Begin VB.ListBox List3 
         Height          =   645
         ItemData        =   "Form2.frx":0014
         Left            =   120
         List            =   "Form2.frx":001E
         TabIndex        =   7
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label Label1 
         Caption         =   "B - Bachelor  Degree"
         Height          =   255
         Left            =   240
         TabIndex        =   9
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Label Label2 
         Caption         =   "M - Master  Degree"
         Height          =   255
         Left            =   240
         TabIndex        =   8
         Top             =   1440
         Width           =   1575
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Frame6"
      Height          =   1815
      Left            =   120
      TabIndex        =   15
      Top             =   0
      Width           =   1935
      Begin VB.ListBox List6 
         Height          =   1425
         ItemData        =   "Form2.frx":0029
         Left            =   120
         List            =   "Form2.frx":004E
         TabIndex        =   16
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "รายการ"
      Height          =   1815
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   1935
      Begin VB.ListBox List1 
         Height          =   1425
         ItemData        =   "Form2.frx":0077
         Left            =   120
         List            =   "Form2.frx":0093
         TabIndex        =   3
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "List"
      Height          =   1815
      Left            =   120
      TabIndex        =   4
      Top             =   0
      Width           =   1935
      Begin VB.ListBox List2 
         Height          =   1425
         ItemData        =   "Form2.frx":00C5
         Left            =   120
         List            =   "Form2.frx":00D5
         TabIndex        =   5
         Top             =   240
         Width           =   1695
      End
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    If Form2.Caption = "Pre name (Thai)" Then
        Form1.Enabled = True
        Form1.Text1(1) = List1.Text
        Form1.Text1(1).SetFocus
    End If
    If Form2.Caption = "Pre name (English)" Then
        Form1.Enabled = True
        Form1.Text1(2) = List2.Text
        Form1.Text1(2).SetFocus
    End If
    If Form2.Caption = "Select Degree" Then
        Form1.Enabled = True
        Form1.Text1(5) = List3.Text
        Form1.Text1(5).SetFocus
    End If
    If Form2.Caption = "Select Study type" Then
        Form1.Enabled = True
        If Option1.Value = True Then
        Form1.Text1(6) = Option1.Caption
        End If
        If Option2.Value = True Then
        Form1.Text1(6) = Option2.Caption
        End If
        Form1.Text1(6).SetFocus
    End If
    If Form2.Caption = "Select Subject type" Then
        Form1.Enabled = True
        Form1.Text3(6) = List5.Text
        Form1.Text3(6).SetFocus
    End If
    If Form2.Caption = "Select Grade" Then
        Form1.Enabled = True
        Form1.Text2(4) = List6.Text
        Form1.Text2(4).SetFocus
    End If
    Form2.Hide
    Form1.Enabled = True
    Form1.Show
End Sub

Private Sub Command2_Click()
    Form2.Hide
    Form1.Enabled = True
    Form1.Show
End Sub

Private Sub Form_Load()
    List1.Selected(0) = True
    List2.Selected(0) = True
    List3.Selected(0) = True
    List5.Selected(0) = True
End Sub

Private Sub Form_Terminate()
    Form1.Show
    Form1.Enabled = True
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Form1.Show
    Form1.Enabled = True
End Sub

