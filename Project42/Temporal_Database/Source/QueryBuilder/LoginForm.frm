VERSION 5.00
Begin VB.Form LoginForm 
   BorderStyle     =   0  'None
   Caption         =   "Input Password"
   ClientHeight    =   3090
   ClientLeft      =   3510
   ClientTop       =   2595
   ClientWidth     =   3510
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   3510
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command2 
      Caption         =   "Exit"
      Height          =   495
      Left            =   1920
      TabIndex        =   2
      Top             =   2520
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Login"
      Height          =   495
      Left            =   240
      TabIndex        =   1
      Top             =   2520
      Width           =   1335
   End
   Begin VB.Frame Frame1 
      Caption         =   "Login"
      Height          =   2295
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3495
      Begin VB.TextBox Passwprd 
         Height          =   285
         Left            =   1320
         TabIndex        =   4
         Top             =   1320
         Width           =   1695
      End
      Begin VB.TextBox User 
         Height          =   285
         Left            =   1320
         TabIndex        =   3
         Top             =   480
         Width           =   1695
      End
      Begin VB.Label Label2 
         Caption         =   "Password"
         Height          =   255
         Left            =   240
         TabIndex        =   6
         Top             =   1440
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "User Name"
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   600
         Width           =   855
      End
   End
End
Attribute VB_Name = "LoginForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
'On Error Resume Next
'EditForm.Data1.Connect = "ODBC;DSN=student_dsn;DATABASE=database_student;UID=informix;PWD=informix;HOST=island;SERVER=ol_island;SERVICE=turbo;PROTOCOL=olsoctcp;"
EditForm.Data1.Connect = "ODBC;DSN=student_data;" & _
"UID=" & User.Text & ";PWD=" & Passwprd.Text & ";"

EditForm.Show
LoginForm.Hide
End Sub

Private Sub Command2_Click()
End
End Sub

