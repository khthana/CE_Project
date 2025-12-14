VERSION 5.00
Begin VB.Form ShowLibrary 
   AutoRedraw      =   -1  'True
   Caption         =   "แผนที่ห้องสมุด"
   ClientHeight    =   8775
   ClientLeft      =   -705
   ClientTop       =   750
   ClientWidth     =   12000
   Icon            =   "ShowLibrary.frx":0000
   LinkTopic       =   "Form1"
   MousePointer    =   1  'Arrow
   Moveable        =   0   'False
   ScaleHeight     =   8775
   ScaleWidth      =   12000
   StartUpPosition =   2  'CenterScreen
   WhatsThisButton =   -1  'True
   WhatsThisHelp   =   -1  'True
   WindowState     =   2  'Maximized
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   3180
      Top             =   1920
   End
   Begin VB.CommandButton Command3 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Back"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   10740
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "กลับไปหน้าที่แล้ว"
      Top             =   7440
      Width           =   855
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   10
      Left            =   2160
      Top             =   1200
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Map"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   9600
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "แสดงตำแหน่งบนห้องสมุด"
      Top             =   7440
      Width           =   915
   End
   Begin VB.Image Image2 
      Height          =   285
      Left            =   10860
      Top             =   780
      Width           =   165
   End
   Begin VB.Image Image1 
      Height          =   6480
      Left            =   0
      MousePointer    =   99  'Custom
      Stretch         =   -1  'True
      Top             =   0
      Width           =   11910
   End
End
Attribute VB_Name = "ShowLibrary"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim X1, Y1  As Integer
Dim Distancex, Distancey As Single
Private Sub Command2_Click()
X1 = CInt(Result.oVTableDetail.Columns(16).Value)           ' X1  คือ จุดหมายทางแกน X
Y1 = CInt(Result.oVTableDetail.Columns(17).Value)           ' Y1 คือ จุดหมายทางแกน Y
If (Image2.Left = X1) And (Image2.Top = Y1) Then
    Image2.Left = 11600
    Image2.Top = 1600
    If X1 - Image2.Left > 0 Then
    Distancex = 200         ' เคลื่อนย้าย pointer ไปทางแกน +X
    Else: Distancex = -200
    End If
    If Y1 - Image2.Top > 0 Then
    Distancey = 200          'เคลื่อนย้าย pointer ไปทางแกน -y
    Else: Distancey = -200
    End If
    Timer1.Enabled = True
Else:
    If X1 - Image2.Left > 0 Then
    Distancex = 200         ' เคลื่อนย้าย pointer ไปทางแกน +X
    Else: Distancex = -200
    End If
    If Y1 - Image2.Top > 0 Then
    Distancey = 200          'เคลื่อนย้าย pointer ไปทางแกน -y
    Else: Distancey = -200
    End If
    Timer1.Enabled = True
End If
End Sub
Private Sub Command3_Click()
    Unload Me
    DetailBook.Show
End Sub
Private Sub Form_Load()
    Load Me
    Image1.Picture = LoadPicture("e:\Project\ProjectVB\VirtualLibrary\picture\Librapic2_2.bmp")
     Image2.Picture = LoadPicture("e:\Project\ProjectVB\VirtualLibrary\picture\pointer3.gif")
     Image2.Left = 11600
     Image2.Top = 1600
  End Sub

Private Sub Timer1_Timer()
'---------------------เคลื่อนที่ทางแกน Y--------------------------
If Image2.Top <> Y1 Then
        If Distancey > 0 Then
                If Image2.Top + Distancey <= Y1 Then
                    Image2.Top = Image2.Top + Distancey
                Else: Image2.Top = Y1
                End If
        Else
                 If Image2.Top + Distancey >= Y1 Then
                    Image2.Top = Image2.Top + Distancey
                Else: Image2.Top = Y1
                End If
        End If
    '---------------------เคลื่อนที่ทางแกน X--------------------------
ElseIf Image2.Left <> X1 Then
        If Distancex > 0 Then
                If Image2.Left + Distancex <= X1 Then
                    Image2.Left = Image2.Left + Distancex
                Else: Image2.Left = X1
                End If
        Else
                 If Image2.Left + Distancex >= X1 Then
                    Image2.Left = Image2.Left + Distancex
                Else: Image2.Left = X1
                End If
        End If
 ElseIf (Image2.Left = X1) And (Image2.Top = Y1) Then
        Timer1.Enabled = False
        Timer2.Enabled = True
End If
        
End Sub
Private Sub Timer2_Timer()
        Load ShowShelf
        ShowShelf.Show vbModal
        Timer2.Enabled = False
End Sub
