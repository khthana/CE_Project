VERSION 5.00
Begin VB.Form Comp 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   0  'None
   Caption         =   "Component"
   ClientHeight    =   1080
   ClientLeft      =   495
   ClientTop       =   2415
   ClientWidth     =   10170
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1080
   ScaleWidth      =   10170
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command2 
      Caption         =   "Load Component"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   8280
      TabIndex        =   9
      Top             =   480
      Width           =   1695
   End
   Begin VB.PictureBox Picture7 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
      Height          =   435
      Left            =   6000
      Picture         =   "Comp.frx":0000
      ScaleHeight     =   375
      ScaleWidth      =   720
      TabIndex        =   7
      ToolTipText     =   "XNOR"
      Top             =   480
      Width           =   780
   End
   Begin VB.PictureBox Picture6 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
      Height          =   435
      Left            =   5040
      Picture         =   "Comp.frx":00B4
      ScaleHeight     =   375
      ScaleWidth      =   720
      TabIndex        =   6
      ToolTipText     =   "XOR"
      Top             =   480
      Width           =   780
   End
   Begin VB.PictureBox Picture5 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
      Height          =   435
      Left            =   4080
      Picture         =   "Comp.frx":0165
      ScaleHeight     =   375
      ScaleWidth      =   720
      TabIndex        =   5
      ToolTipText     =   "NOR"
      Top             =   480
      Width           =   780
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Select"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   450
      Left            =   6960
      Picture         =   "Comp.frx":0205
      TabIndex        =   4
      Top             =   480
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
      Height          =   435
      Left            =   240
      Picture         =   "Comp.frx":050F
      ScaleHeight     =   375
      ScaleWidth      =   720
      TabIndex        =   3
      ToolTipText     =   "AND"
      Top             =   480
      Width           =   780
   End
   Begin VB.PictureBox Picture4 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
      Height          =   435
      Left            =   3120
      Picture         =   "Comp.frx":05AB
      ScaleHeight     =   375
      ScaleWidth      =   720
      TabIndex        =   2
      ToolTipText     =   "NAND"
      Top             =   480
      Width           =   780
   End
   Begin VB.PictureBox Picture3 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
      Height          =   435
      Left            =   2160
      Picture         =   "Comp.frx":064D
      ScaleHeight     =   375
      ScaleWidth      =   720
      TabIndex        =   1
      ToolTipText     =   "NOT"
      Top             =   480
      Width           =   780
   End
   Begin VB.PictureBox Picture2 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
      Height          =   435
      Left            =   1200
      Picture         =   "Comp.frx":06EA
      ScaleHeight     =   375
      ScaleWidth      =   720
      TabIndex        =   0
      ToolTipText     =   "OR"
      Top             =   480
      Width           =   780
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "Component"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   375
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   10215
   End
End
Attribute VB_Name = "Comp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public selectPicture As Integer

Private Sub Command1_Click()
    Picture1.BackColor = QBColor(15)
    Picture2.BackColor = QBColor(15)
    Picture3.BackColor = QBColor(15)
    Picture4.BackColor = QBColor(15)
    Picture5.BackColor = QBColor(15)
    Picture6.BackColor = QBColor(15)
    Picture7.BackColor = QBColor(15)
    If selectPicture <> 0 Then
        Call LayOut.createpicture(selectPicture)
    End If
End Sub

Private Sub Command2_Click()
    LoadComp.Show
End Sub

Private Sub Form_Load()
    selectPicture = 0
End Sub

Private Sub Picture1_Click()
    Picture1.BackColor = QBColor(7)
    Picture2.BackColor = QBColor(15)
    Picture3.BackColor = QBColor(15)
    Picture4.BackColor = QBColor(15)
    Picture5.BackColor = QBColor(15)
    Picture6.BackColor = QBColor(15)
    Picture7.BackColor = QBColor(15)
    selectPicture = 1
End Sub

Private Sub Picture2_Click()
    Picture1.BackColor = QBColor(15)
    Picture2.BackColor = QBColor(7)
    Picture3.BackColor = QBColor(15)
    Picture4.BackColor = QBColor(15)
    Picture5.BackColor = QBColor(15)
    Picture6.BackColor = QBColor(15)
    Picture7.BackColor = QBColor(15)
    selectPicture = 2
End Sub

Private Sub Picture3_Click()
    Picture1.BackColor = QBColor(15)
    Picture2.BackColor = QBColor(15)
    Picture3.BackColor = QBColor(7)
    Picture4.BackColor = QBColor(15)
    Picture5.BackColor = QBColor(15)
    Picture6.BackColor = QBColor(15)
    Picture7.BackColor = QBColor(15)
    selectPicture = 3
End Sub

Private Sub Picture4_Click()
    Picture1.BackColor = QBColor(15)
    Picture2.BackColor = QBColor(15)
    Picture3.BackColor = QBColor(15)
    Picture4.BackColor = QBColor(7)
    Picture5.BackColor = QBColor(15)
    Picture6.BackColor = QBColor(15)
    Picture7.BackColor = QBColor(15)
    selectPicture = 4
End Sub

Private Sub Picture5_Click()
    Picture1.BackColor = QBColor(15)
    Picture2.BackColor = QBColor(15)
    Picture3.BackColor = QBColor(15)
    Picture4.BackColor = QBColor(15)
    Picture5.BackColor = QBColor(7)
    Picture6.BackColor = QBColor(15)
    Picture7.BackColor = QBColor(15)
    selectPicture = 5
End Sub

Private Sub Picture6_Click()
    Picture1.BackColor = QBColor(15)
    Picture2.BackColor = QBColor(15)
    Picture3.BackColor = QBColor(15)
    Picture4.BackColor = QBColor(15)
    Picture5.BackColor = QBColor(15)
    Picture6.BackColor = QBColor(7)
    Picture7.BackColor = QBColor(15)
    selectPicture = 6
End Sub

Private Sub Picture7_Click()
    Picture1.BackColor = QBColor(15)
    Picture2.BackColor = QBColor(15)
    Picture3.BackColor = QBColor(15)
    Picture4.BackColor = QBColor(15)
    Picture5.BackColor = QBColor(15)
    Picture6.BackColor = QBColor(15)
    Picture7.BackColor = QBColor(7)
    selectPicture = 7
End Sub
