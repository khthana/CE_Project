VERSION 5.00
Begin VB.Form AboutFrm 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "About"
   ClientHeight    =   3135
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   2655
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3135
   ScaleWidth      =   2655
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer2 
      Interval        =   500
      Left            =   2160
      Top             =   0
   End
   Begin VB.Timer Timer1 
      Interval        =   1
      Left            =   1680
      Top             =   0
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   2760
      Width           =   2415
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "General Info"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   120
      Width           =   2415
   End
   Begin VB.Line Line8 
      BorderColor     =   &H00808080&
      X1              =   120
      X2              =   2520
      Y1              =   480
      Y2              =   480
   End
   Begin VB.Line Line7 
      BorderColor     =   &H00E0E0E0&
      X1              =   120
      X2              =   2520
      Y1              =   495
      Y2              =   495
   End
   Begin VB.Label InfraRed4 
      BackStyle       =   0  'Transparent
      Caption         =   "2.1.1"
      ForeColor       =   &H00FF00FF&
      Height          =   255
      Left            =   840
      TabIndex        =   9
      Top             =   960
      Width           =   1695
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Version:  "
      ForeColor       =   &H00FF00FF&
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   960
      Width           =   615
   End
   Begin VB.Line Line6 
      BorderColor     =   &H00808080&
      X1              =   120
      X2              =   2520
      Y1              =   2640
      Y2              =   2640
   End
   Begin VB.Line Line5 
      BorderColor     =   &H00E0E0E0&
      X1              =   120
      X2              =   2520
      Y1              =   2655
      Y2              =   2655
   End
   Begin VB.Line Line4 
      BorderColor     =   &H00E0E0E0&
      X1              =   120
      X2              =   2520
      Y1              =   1815
      Y2              =   1815
   End
   Begin VB.Line Line3 
      BorderColor     =   &H00808080&
      X1              =   120
      X2              =   2520
      Y1              =   1800
      Y2              =   1800
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00E0E0E0&
      X1              =   120
      X2              =   2520
      Y1              =   1335
      Y2              =   1335
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00808080&
      X1              =   120
      X2              =   2520
      Y1              =   1320
      Y2              =   1320
   End
   Begin VB.Label InfraRed3 
      BackStyle       =   0  'Transparent
      Caption         =   "17948286"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   840
      TabIndex        =   6
      Top             =   2280
      Width           =   735
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "ICQ #:"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   2280
      Width           =   495
   End
   Begin VB.Label InfraRed2 
      BackStyle       =   0  'Transparent
      Caption         =   "InfraRed@flashmail.com"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Left            =   840
      TabIndex        =   4
      Top             =   1920
      Width           =   1725
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "E-Mail:"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   1920
      Width           =   495
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Contact Info"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   1440
      Width           =   2415
   End
   Begin VB.Label InfraRed 
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "InfraRed"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   840
      TabIndex        =   1
      Top             =   600
      Width           =   615
   End
   Begin VB.Label Label1 
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "By:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   495
   End
End
Attribute VB_Name = "AboutFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Reverse As Boolean
Dim Extrude As Boolean

Private Sub Command1_Click()
TUFrm.Enabled = True
TUFrm.SetFocus
AboutFrm.Hide
End Sub

Private Sub Form_Load()
Dim xtra As Single
xtra = Line2.Y1
Line2.Y1 = Line1.Y1
Line2.Y2 = Line1.Y2
Line1.Y1 = xtra
Line1.Y2 = xtra
xtra = Line6.Y1
Line6.Y1 = Line5.Y1
Line6.Y2 = Line5.Y2
Line5.Y1 = xtra
Line5.Y2 = xtra
InfraRed4.Caption = App.Major & "." & App.Minor & "." & App.Revision
Ontop Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
Command1_Click
End Sub

Private Sub InfraRed_Click()
MsgBox "The intelligent person who made this program!", 48, "InfraRed"
End Sub

Private Sub InfraRed2_Click()
Ret = Shell("Start.exe " & "mailto:InfraRed@flashmail.com", 0)
End Sub

Private Sub InfraRed3_Click()
Ret = Shell("Start.exe " & "http://wwp.icq.com/17948286", 0)
End Sub

Private Sub Timer1_Timer()
If Reverse = False Then
If InfraRed.ForeColor = &H88& Then
InfraRed.ForeColor = &H99&
InfraRed2.ForeColor = &H9900&
InfraRed3.ForeColor = &H990000
InfraRed4.ForeColor = &H990099
ElseIf InfraRed.ForeColor = &H99& Then
InfraRed.ForeColor = &HAA&
InfraRed2.ForeColor = &HAA00&
InfraRed3.ForeColor = &HAA0000
InfraRed4.ForeColor = &HAA00AA
ElseIf InfraRed.ForeColor = &HAA& Then
InfraRed.ForeColor = &HBB&
InfraRed2.ForeColor = &HBB00&
InfraRed3.ForeColor = &HBB0000
InfraRed4.ForeColor = &HBB00BB
ElseIf InfraRed.ForeColor = &HBB& Then
InfraRed.ForeColor = &HCC&
InfraRed2.ForeColor = &HCC00&
InfraRed3.ForeColor = &HCC0000
InfraRed4.ForeColor = &HCC00CC
ElseIf InfraRed.ForeColor = &HCC& Then
InfraRed.ForeColor = &HDD&
InfraRed2.ForeColor = &HDD00&
InfraRed3.ForeColor = &HDD0000
InfraRed4.ForeColor = &HDD00DD
ElseIf InfraRed.ForeColor = &HDD& Then
InfraRed.ForeColor = &HEE&
InfraRed2.ForeColor = &HEE00&
InfraRed3.ForeColor = &HEE0000
InfraRed4.ForeColor = &HEE00EE
ElseIf InfraRed.ForeColor = &HEE& Then
InfraRed.ForeColor = &HFF&
InfraRed2.ForeColor = &HFF00&
InfraRed3.ForeColor = &HFF0000
InfraRed4.ForeColor = &HFF00FF
ElseIf InfraRed.ForeColor = &HFF& Then
InfraRed.ForeColor = &H1111FF
InfraRed2.ForeColor = &H11FF11
InfraRed3.ForeColor = &HFF1111
InfraRed4.ForeColor = &HFF11FF
ElseIf InfraRed.ForeColor = &H1111FF Then
InfraRed.ForeColor = &H2222FF
InfraRed2.ForeColor = &H22FF22
InfraRed3.ForeColor = &HFF2222
InfraRed4.ForeColor = &HFF22FF
ElseIf InfraRed.ForeColor = &H2222FF Then
InfraRed.ForeColor = &H3333FF
InfraRed2.ForeColor = &H33FF33
InfraRed3.ForeColor = &HFF3333
InfraRed4.ForeColor = &HFF33FF
ElseIf InfraRed.ForeColor = &H3333FF Then
InfraRed.ForeColor = &H4444FF
InfraRed2.ForeColor = &H44FF44
InfraRed3.ForeColor = &HFF4444
InfraRed4.ForeColor = &HFF44FF
ElseIf InfraRed.ForeColor = &H4444FF Then
InfraRed.ForeColor = &H5555FF
InfraRed2.ForeColor = &H55FF55
InfraRed3.ForeColor = &HFF5555
InfraRed4.ForeColor = &HFF55FF
ElseIf InfraRed.ForeColor = &H5555FF Then
InfraRed.ForeColor = &H6666FF
InfraRed2.ForeColor = &H66FF66
InfraRed3.ForeColor = &HFF6666
InfraRed4.ForeColor = &HFF66FF
ElseIf InfraRed.ForeColor = &H6666FF Then
InfraRed.ForeColor = &H7777FF
InfraRed2.ForeColor = &H77FF77
InfraRed3.ForeColor = &HFF7777
InfraRed4.ForeColor = &HFF77FF
Reverse = True
End If
Else
If InfraRed.ForeColor = &H7777FF Then
InfraRed.ForeColor = &H6666FF
InfraRed2.ForeColor = &H66FF66
InfraRed3.ForeColor = &HFF6666
InfraRed4.ForeColor = &HFF66FF
ElseIf InfraRed.ForeColor = &H6666FF Then
InfraRed.ForeColor = &H5555FF
InfraRed2.ForeColor = &H55FF55
InfraRed3.ForeColor = &HFF5555
InfraRed4.ForeColor = &HFF55FF
ElseIf InfraRed.ForeColor = &H5555FF Then
InfraRed.ForeColor = &H4444FF
InfraRed2.ForeColor = &H44FF44
InfraRed3.ForeColor = &HFF4444
InfraRed4.ForeColor = &HFF44FF
ElseIf InfraRed.ForeColor = &H4444FF Then
InfraRed.ForeColor = &H3333FF
InfraRed2.ForeColor = &H33FF33
InfraRed3.ForeColor = &HFF3333
InfraRed4.ForeColor = &HFF33FF
ElseIf InfraRed.ForeColor = &H3333FF Then
InfraRed.ForeColor = &H2222FF
InfraRed2.ForeColor = &H22FF22
InfraRed3.ForeColor = &HFF2222
InfraRed4.ForeColor = &HFF22FF
ElseIf InfraRed.ForeColor = &H2222FF Then
InfraRed.ForeColor = &H1111FF
InfraRed2.ForeColor = &H11FF11
InfraRed3.ForeColor = &HFF1111
InfraRed4.ForeColor = &HFF11FF
ElseIf InfraRed.ForeColor = &H1111FF Then
InfraRed.ForeColor = &HFF&
InfraRed2.ForeColor = &HFF00&
InfraRed3.ForeColor = &HFF0000
InfraRed4.ForeColor = &HFF00FF
ElseIf InfraRed.ForeColor = &HFF& Then
InfraRed.ForeColor = &HEE&
InfraRed2.ForeColor = &HEE00&
InfraRed3.ForeColor = &HEE0000
InfraRed4.ForeColor = &HEE00EE
ElseIf InfraRed.ForeColor = &HEE& Then
InfraRed.ForeColor = &HDD&
InfraRed2.ForeColor = &HDD00&
InfraRed3.ForeColor = &HDD0000
InfraRed4.ForeColor = &HDD00DD
ElseIf InfraRed.ForeColor = &HDD& Then
InfraRed.ForeColor = &HCC&
InfraRed2.ForeColor = &HCC00&
InfraRed3.ForeColor = &HCC0000
InfraRed4.ForeColor = &HCC00CC
ElseIf InfraRed.ForeColor = &HCC& Then
InfraRed.ForeColor = &HBB&
InfraRed2.ForeColor = &HBB00&
InfraRed3.ForeColor = &HBB0000
InfraRed4.ForeColor = &HBB00BB
ElseIf InfraRed.ForeColor = &HBB& Then
InfraRed.ForeColor = &HAA&
InfraRed2.ForeColor = &HAA00&
InfraRed3.ForeColor = &HAA0000
InfraRed4.ForeColor = &HAA00AA
ElseIf InfraRed.ForeColor = &HAA& Then
InfraRed.ForeColor = &H99&
InfraRed2.ForeColor = &H9900&
InfraRed3.ForeColor = &H990000
InfraRed4.ForeColor = &H990099
ElseIf InfraRed.ForeColor = &H99& Then
InfraRed.ForeColor = &H88&
InfraRed2.ForeColor = &H8800&
InfraRed3.ForeColor = &H880000
InfraRed4.ForeColor = &H880088
Reverse = False
End If
End If
End Sub

Private Sub Timer2_Timer()
Dim xtra As Single
xtra = Line2.Y1
Line2.Y1 = Line1.Y1
Line2.Y2 = Line1.Y2
Line1.Y1 = xtra
Line1.Y2 = xtra
xtra = Line3.Y1
Line3.Y1 = Line4.Y1
Line3.Y2 = Line4.Y2
Line4.Y1 = xtra
Line4.Y2 = xtra
xtra = Line6.Y1
Line6.Y1 = Line5.Y1
Line6.Y2 = Line5.Y2
Line5.Y1 = xtra
Line5.Y2 = xtra
xtra = Line7.Y1
Line7.Y1 = Line8.Y1
Line7.Y2 = Line8.Y2
Line8.Y1 = xtra
Line8.Y2 = xtra
End Sub
