VERSION 5.00
Begin VB.Form MenuAdmin 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "ระบบสืบค้นหาข้อมูลสารนิเทศ"
   ClientHeight    =   4485
   ClientLeft      =   2010
   ClientTop       =   2865
   ClientWidth     =   6390
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MouseIcon       =   "MenuAdmin.frx":0000
   MousePointer    =   99  'Custom
   ScaleHeight     =   4485
   ScaleWidth      =   6390
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   4395
      Left            =   60
      MouseIcon       =   "MenuAdmin.frx":08CA
      MousePointer    =   4  'Icon
      TabIndex        =   4
      Top             =   0
      Width           =   6255
      Begin VB.CommandButton Command1 
         BackColor       =   &H0080FF80&
         Caption         =   "Shelf&&Room"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Index           =   3
         Left            =   2470
         MouseIcon       =   "MenuAdmin.frx":1194
         MousePointer    =   99  'Custom
         Picture         =   "MenuAdmin.frx":1A5E
         Style           =   1  'Graphical
         TabIndex        =   8
         ToolTipText     =   "ภาพยนต์"
         Top             =   2520
         Width           =   1155
      End
      Begin VB.CommandButton cmdAbout 
         BackColor       =   &H0080C0FF&
         Caption         =   "&About"
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
         Left            =   1740
         Style           =   1  'Graphical
         TabIndex        =   7
         ToolTipText     =   "เกี่ยวกับโปรแกรม"
         Top             =   3720
         Width           =   915
      End
      Begin VB.CommandButton Command1 
         BackColor       =   &H0080FF80&
         Caption         =   "Movie"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Index           =   2
         Left            =   3840
         MouseIcon       =   "MenuAdmin.frx":1E7A
         MousePointer    =   99  'Custom
         Picture         =   "MenuAdmin.frx":2744
         Style           =   1  'Graphical
         TabIndex        =   2
         ToolTipText     =   "ภาพยนต์"
         Top             =   1740
         Width           =   855
      End
      Begin VB.CommandButton Command1 
         BackColor       =   &H0080FF80&
         Caption         =   "Song"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Index           =   1
         Left            =   2640
         MouseIcon       =   "MenuAdmin.frx":2BBF
         MousePointer    =   99  'Custom
         Picture         =   "MenuAdmin.frx":3489
         Style           =   1  'Graphical
         TabIndex        =   1
         ToolTipText     =   "เพลง"
         Top             =   1500
         Width           =   855
      End
      Begin VB.CommandButton Command2 
         BackColor       =   &H0080C0FF&
         Caption         =   "&Exit"
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
         Left            =   3660
         Style           =   1  'Graphical
         TabIndex        =   3
         ToolTipText     =   "ออกจากโปรแกรม"
         Top             =   3720
         Width           =   915
      End
      Begin VB.CommandButton Command1 
         BackColor       =   &H0080FF80&
         Caption         =   "Book"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Index           =   0
         Left            =   1440
         MouseIcon       =   "MenuAdmin.frx":3946
         MousePointer    =   99  'Custom
         Picture         =   "MenuAdmin.frx":4210
         Style           =   1  'Graphical
         TabIndex        =   0
         ToolTipText     =   "หนังสือ"
         Top             =   1740
         Width           =   855
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "เลือกประเภทของข้อมูลที่ต้องการ"
         BeginProperty Font 
            Name            =   "JasmineUPC"
            Size            =   15.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   375
         Left            =   1320
         TabIndex        =   6
         Top             =   960
         Width           =   3435
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "ระบบการป้อนข้อมูลลงสู่ฐานข้อมูล"
         BeginProperty Font 
            Name            =   "JasmineUPC"
            Size            =   24
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   555
         Left            =   480
         TabIndex        =   5
         Top             =   360
         Width           =   5355
      End
   End
End
Attribute VB_Name = "MenuAdmin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public TypeSearch As Byte   ' 0 = SearchBook  1 = SearchSong  2 = SearchMovie
                                                 
Private Sub cmdAbout_Click()
Load About
About.Show vbModal
End Sub

Private Sub Command1_Click(Index As Integer)
Command1(Index).BackColor = &H80FF80
Select Case Index
Case 0
     If Not (MainScreen.oDataGroupBook.LoggedOn) Then
         MainScreen.oDataGroupBook.Logon "informix", "informix"
     End If
     Book.Show
     Me.Hide
Case 1
     If Not (MainScreen.oDataGroupMusic.LoggedOn) Then
         MainScreen.oDataGroupMusic.Logon "informix", "informix"
     End If
     Music.Show
     Me.Hide
Case 2
     If Not (MainScreen.oDataGroupMovie.LoggedOn) Then
         MainScreen.oDataGroupMovie.Logon "informix", "informix"
     End If
     Movie.Show
     Me.Hide
Case 3
     If Not (MainScreen.oDataGroupBook.LoggedOn) Then
         MainScreen.oDataGroupBook.Logon "informix", "informix"
     End If
     Shelf_Room.Show
     Me.Hide
End Select
End Sub

Private Sub Command1_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
If Command1(Index).BackColor <> &HC000& Then
Command1(Index).BackColor = &HC000&
End If
End Sub

Private Sub Command2_Click()
If MsgBox("ท่านแน่ใจที่จะออกจากโปรแกรมหรือไม่ ?", 52, "โปรดยืนยัน") = vbYes Then
     If (MainScreen.oDataGroupBook.LoggedOn) Then
        MainScreen.oDataGroupBook.Logoff
    End If
     If (MainScreen.oDataGroupMusic.LoggedOn) Then
        MainScreen.oDataGroupMusic.Logoff
     End If
     If (MainScreen.oDataGroupMovie.LoggedOn) Then
        MainScreen.oDataGroupMovie.Logoff
     End If
   End
End If
End Sub

Private Sub Frame1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
For i% = 0 To 3
   If Command1(i%).BackColor <> &H80FF80 Then
      Command1(i%).BackColor = &H80FF80
      Exit Sub
   End If
Next i%
End Sub
