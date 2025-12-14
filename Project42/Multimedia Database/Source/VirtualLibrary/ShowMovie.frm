VERSION 5.00
Begin VB.Form ShowMovie 
   Caption         =   "แผนที่ห้องสมุด"
   ClientHeight    =   8040
   ClientLeft      =   120
   ClientTop       =   270
   ClientWidth     =   9360
   LinkTopic       =   "Form4"
   ScaleHeight     =   8040
   ScaleWidth      =   9360
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.Frame Frame1 
      Caption         =   " รายละเอียดเพลง "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00008000&
      Height          =   1395
      Left            =   420
      TabIndex        =   2
      Top             =   6720
      Width           =   8955
      Begin VB.Label Label1 
         Caption         =   "ชื่อเพลง :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   315
         Left            =   180
         TabIndex        =   12
         Top             =   420
         Width           =   915
      End
      Begin VB.Label Label2 
         Caption         =   "รหัสเพลง :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   180
         TabIndex        =   11
         Top             =   1020
         Width           =   975
      End
      Begin VB.Label Label3 
         Caption         =   "ชั้นของตู้ :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   315
         Left            =   4140
         TabIndex        =   10
         Top             =   420
         Width           =   795
      End
      Begin VB.Label Label4 
         Caption         =   "ส่วนของชั้น :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   315
         Left            =   4080
         TabIndex        =   9
         Top             =   1020
         Width           =   1155
      End
      Begin VB.Label Label5 
         Caption         =   "ห้อง :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   6900
         TabIndex        =   8
         Top             =   420
         Width           =   675
      End
      Begin VB.Label Label6 
         Caption         =   "Label6"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   555
         Left            =   1260
         TabIndex        =   7
         Top             =   420
         Width           =   2835
      End
      Begin VB.Label Label7 
         Caption         =   "Label7"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   1260
         TabIndex        =   6
         Top             =   1020
         Width           =   795
      End
      Begin VB.Label Label8 
         Caption         =   "Label8"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   315
         Left            =   5340
         TabIndex        =   5
         Top             =   420
         Width           =   675
      End
      Begin VB.Label Label9 
         Caption         =   "Label9"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   315
         Left            =   5340
         TabIndex        =   4
         Top             =   1020
         Width           =   615
      End
      Begin VB.Label Label10 
         Caption         =   "Label10"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   375
         Left            =   7620
         TabIndex        =   3
         Top             =   420
         Width           =   1095
      End
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   10
      Left            =   4080
      Top             =   3540
   End
   Begin VB.CommandButton Command2 
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
      Left            =   10860
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "กลับไปหน้าที่แล้ว"
      Top             =   7200
      Width           =   915
   End
   Begin VB.CommandButton Command1 
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
      Top             =   7200
      Width           =   975
   End
   Begin VB.Image Image2 
      Height          =   375
      Left            =   3960
      Top             =   660
      Width           =   195
   End
   Begin VB.Image Image1 
      Height          =   6435
      Left            =   0
      Stretch         =   -1  'True
      Top             =   60
      Width           =   11955
   End
End
Attribute VB_Name = "ShowMovie"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim X1, Y1 As Integer
Dim Distancex, Distancey As Single
Private Sub Command1_Click()
X1 = CInt(Result.oVTableDetail.Columns(14).Value)           ' X1  คือ จุดหมายทางแกน X
Y1 = CInt(Result.oVTableDetail.Columns(15).Value)           ' Y1 คือ จุดหมายทางแกน Y
    If X1 - Image2.Left > 0 Then
    Distancex = 200         ' เคลื่อนย้าย pointer ไปทางแกน +X
    Else: Distancex = -200
    End If
    If Y1 - Image2.Top > 0 Then
    Distancey = 200          'เคลื่อนย้าย pointer ไปทางแกน -y
    Else: Distancey = -200
    End If
    Timer1.Enabled = True
End Sub
Private Sub Command2_Click()
Unload Me
DetailMovie.Show
End Sub



Private Sub Form_Load()
Load Me
Image1.Picture = LoadPicture("e:\Project\ProjectVB\VirtualLibrary\picture\Librapic2_2.bmp")
Image2.Picture = LoadPicture("e:\Project\ProjectVB\VirtualLibrary\picture\Pointer3.gif")
Image2.Left = 11600
Image2.Top = 1600
Label6.Caption = Result.oVTableDetail.Columns(3).Value
Label7.Caption = Result.oVTableDetail.Columns(2).Value
Label8.Caption = Result.oVTableDetail.Columns(10).Value
Select Case Result.oVTableDetail.Columns(13).Value
        Case "L"
                Label9.Caption = "ซ้าย"
        Case "M"
                Label9.Caption = "กลาง"
        Case "R"
                Label9.Caption = "ขวา"
End Select
Label10.Caption = Result.oVTableDetail.Columns(11).Value
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
End If
End Sub

