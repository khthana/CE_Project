VERSION 5.00
Begin VB.Form MenuClient 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "ระบบสืบค้นหาข้อมูลสารนิเทศ"
   ClientHeight    =   4575
   ClientLeft      =   0
   ClientTop       =   2235
   ClientWidth     =   6495
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MouseIcon       =   "MenuClient.frx":0000
   MousePointer    =   99  'Custom
   ScaleHeight     =   4575
   ScaleWidth      =   6495
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   4395
      Left            =   120
      MouseIcon       =   "MenuClient.frx":08CA
      MousePointer    =   4  'Icon
      TabIndex        =   4
      Top             =   60
      Width           =   6255
      Begin VB.CommandButton Command3 
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
         Top             =   3480
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
         Left            =   4560
         MouseIcon       =   "MenuClient.frx":1194
         MousePointer    =   99  'Custom
         Picture         =   "MenuClient.frx":1A5E
         Style           =   1  'Graphical
         TabIndex        =   2
         ToolTipText     =   "ภาพยนต์"
         Top             =   2160
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
         Left            =   2700
         MouseIcon       =   "MenuClient.frx":1ED9
         MousePointer    =   99  'Custom
         Picture         =   "MenuClient.frx":27A3
         Style           =   1  'Graphical
         TabIndex        =   1
         ToolTipText     =   "เพลง"
         Top             =   2160
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
         Top             =   3480
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
         Left            =   840
         MouseIcon       =   "MenuClient.frx":289B
         MousePointer    =   99  'Custom
         Picture         =   "MenuClient.frx":3165
         Style           =   1  'Graphical
         TabIndex        =   0
         ToolTipText     =   "หนังสือ"
         Top             =   2160
         Width           =   855
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "เลือกชนิดของการค้นหาข้อมูลสารนิเทศ"
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
         Left            =   1140
         TabIndex        =   6
         Top             =   1500
         Width           =   3975
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "ระบบสืบค้นหาข้อมูลสารนิเทศ"
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
         Left            =   840
         TabIndex        =   5
         Top             =   540
         Width           =   4695
      End
   End
End
Attribute VB_Name = "MenuClient"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public TypeSearch As Byte   ' 0 = SearchBook  1 = SearchSong  2 = SearchMovie
                                                 
Private Sub Command1_Click(Index As Integer)
Command1(Index).BackColor = &H80FF80
Select Case Index
Case 0
     TypeSearch = 0          'SearchBook
     If Not (MainScreen.oDataGroupBook.LoggedOn) Then
         MainScreen.oDataGroupBook.Logon "informix", "informix"
     End If
     SearchBook.Show
     Me.Hide
Case 1
    TypeSearch = 1          'SearchSong
     If Not (MainScreen.oDataGroupMusic.LoggedOn) Then
         MainScreen.oDataGroupMusic.Logon "informix", "informix"
     End If
     SearchSong.Show
     Me.Hide
Case 2
     TypeSearch = 2              'SearchMovie
     If Not (MainScreen.oDataGroupMovie.LoggedOn) Then
         MainScreen.oDataGroupMovie.Logon "informix", "informix"
     End If
     Searchmovie.Show
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

Private Sub Command3_Click()
    Load About
    About.Show
End Sub

Private Sub Frame1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
For i% = 0 To 2
   If Command1(i%).BackColor <> &H80FF80 Then
      Command1(i%).BackColor = &H80FF80
      Exit Sub
   End If
Next i%
End Sub
