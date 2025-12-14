VERSION 4.00
Begin VB.Form Form2 
   BackColor       =   &H00C0C0C0&
   Caption         =   "About NetWork Voice Chat"
   ClientHeight    =   2745
   ClientLeft      =   3000
   ClientTop       =   3405
   ClientWidth     =   4365
   FillColor       =   &H00FFFFFF&
   Height          =   3150
   Left            =   2940
   LinkTopic       =   "Form2"
   Picture         =   "AbtVChat.frx":0000
   ScaleHeight     =   2745
   ScaleWidth      =   4365
   Top             =   3060
   Width           =   4485
   Begin VB.Frame Frame1 
      Height          =   2055
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   4095
      Begin VB.CommandButton Command1 
         Caption         =   "ตกลง"
         Height          =   375
         Left            =   840
         TabIndex        =   5
         Top             =   1560
         Width           =   2175
      End
      Begin VB.Label Label4 
         Caption         =   " สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง"
         ForeColor       =   &H000000C0&
         Height          =   375
         Left            =   120
         TabIndex        =   4
         Top             =   960
         Width           =   3855
      End
      Begin VB.Label Label3 
         Caption         =   "คณะวิศวกรรมศาสตร์"
         ForeColor       =   &H00FF0000&
         Height          =   375
         Left            =   240
         TabIndex        =   3
         Top             =   600
         Width           =   3735
      End
      Begin VB.Label Label2 
         Caption         =   "ภาควิชา วิศวกรรมคอมพิวเตอร์"
         BeginProperty Font 
            name            =   "MS Sans Serif"
            charset         =   222
            weight          =   700
            size            =   9.75
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   375
         Left            =   240
         TabIndex        =   2
         Top             =   240
         Width           =   3615
      End
   End
   Begin VB.Label Label1 
      Caption         =   "About Network Voice Chat"
      BeginProperty Font 
         name            =   "MS Sans Serif"
         charset         =   222
         weight          =   700
         size            =   9.75
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C000C0&
      Height          =   375
      Left            =   840
      TabIndex        =   0
      Top             =   240
      Width           =   3735
   End
End
Attribute VB_Name = "Form2"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Private Sub Command1_Click()
Unload Form2
End Sub

Private Sub Form_Load()
 Move (Screen.Width - Width) / 2, (Screen.Height - Height) / 2
End Sub


Private Sub Form_Unload(Cancel As Integer)
Unload Form2
End Sub


