VERSION 5.00
Begin VB.Form SearchSong 
   Caption         =   "ระบบค้นหาเพลง"
   ClientHeight    =   6000
   ClientLeft      =   285
   ClientTop       =   1380
   ClientWidth     =   5490
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6000
   ScaleWidth      =   5490
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
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
      Left            =   420
      Style           =   1  'Graphical
      TabIndex        =   18
      ToolTipText     =   "ไปหน้าการค้นหาหลัก"
      Top             =   5340
      Width           =   960
   End
   Begin VB.CommandButton Command3 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Search"
      Enabled         =   0   'False
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
      Left            =   4140
      Style           =   1  'Graphical
      TabIndex        =   17
      ToolTipText     =   "เริ่มค้นหา"
      Top             =   5340
      Width           =   960
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Clear"
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
      Left            =   2280
      Style           =   1  'Graphical
      TabIndex        =   16
      ToolTipText     =   "ล้างข้อมูลการค้นหา"
      Top             =   5340
      Width           =   960
   End
   Begin VB.Frame Frame2 
      Caption         =   "รูปแบบการป้อน"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   735
      Left            =   120
      TabIndex        =   14
      Top             =   4380
      Width           =   5235
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
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
         Height          =   195
         Left            =   2640
         TabIndex        =   19
         Top             =   300
         Visible         =   0   'False
         Width           =   60
      End
      Begin VB.Label Label1 
         Caption         =   "ตัวอย่างรูปแบบการป้อน คือ"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000040C0&
         Height          =   255
         Left            =   420
         TabIndex        =   15
         Top             =   300
         Width           =   2175
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "ข้อมูลในการค้นหา"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000040C0&
      Height          =   4095
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5235
      Begin VB.ComboBox Combo1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "SearchSong.frx":0000
         Left            =   2040
         List            =   "SearchSong.frx":0034
         Sorted          =   -1  'True
         TabIndex        =   20
         Text            =   "Pop"
         Top             =   2940
         Visible         =   0   'False
         Width           =   2835
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Index           =   6
         Left            =   2040
         TabIndex        =   13
         Top             =   3360
         Visible         =   0   'False
         Width           =   2850
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Index           =   4
         Left            =   2040
         MaxLength       =   4
         TabIndex        =   12
         Top             =   2400
         Visible         =   0   'False
         Width           =   2850
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Index           =   3
         Left            =   2040
         TabIndex        =   11
         Top             =   1980
         Visible         =   0   'False
         Width           =   2850
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Index           =   2
         Left            =   2040
         TabIndex        =   10
         Top             =   1500
         Visible         =   0   'False
         Width           =   2850
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Index           =   1
         Left            =   2040
         TabIndex        =   9
         Top             =   1020
         Visible         =   0   'False
         Width           =   2850
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Index           =   0
         Left            =   2040
         TabIndex        =   8
         Top             =   540
         Visible         =   0   'False
         Width           =   2850
      End
      Begin VB.CheckBox Check1 
         Caption         =   " ค่ายเพลง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   6
         Left            =   240
         TabIndex        =   7
         Top             =   3420
         Width           =   1455
      End
      Begin VB.CheckBox Check1 
         Caption         =   " แนวเพลง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   5
         Left            =   240
         TabIndex        =   6
         Top             =   2940
         Width           =   1455
      End
      Begin VB.CheckBox Check1 
         Caption         =   " ปีที่ออกอัลบั้ม"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   4
         Left            =   240
         TabIndex        =   5
         Top             =   2520
         Width           =   1455
      End
      Begin VB.CheckBox Check1 
         Caption         =   " ชื่ออัลบั้ม"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   3
         Left            =   240
         TabIndex        =   4
         Top             =   2040
         Width           =   1755
      End
      Begin VB.CheckBox Check1 
         Caption         =   " ชื่อศิลปิน"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   2
         Left            =   240
         TabIndex        =   3
         Top             =   1560
         Width           =   1755
      End
      Begin VB.CheckBox Check1 
         Caption         =   " เลขหมู่เพลง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   2
         Top             =   540
         Width           =   1455
      End
      Begin VB.CheckBox Check1 
         Caption         =   " ชื่อเพลง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   1
         Top             =   1080
         Width           =   1755
      End
   End
End
Attribute VB_Name = "SearchSong"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public oVTableMusic As ddoTable
Dim SQLString As String    'SQL Current
Dim Countcheck As Byte  'Count All CheckBox is Checked
Private Sub Check1_Click(Index As Integer)
If Index = 5 Then
        If Check1(5).Value = 1 Then
        Combo1.Visible = True
        Countcheck = Countcheck + 1
        Combo1.SetFocus
        Else
        Combo1.Visible = False
        Combo1.Text = ""
        Countchec = Countcheck - 1
        End If
Else:
        If Check1(Index).Value = 1 Then
            With Text1(Index)
            .Text = ""
            .Visible = True
            .SetFocus
            End With
            Countcheck = Countcheck + 1
        Else: Text1(Index).Visible = False
            Text1(Index).Text = ""
            Label2.Visible = False
            Countcheck = Countcheck - 1
        End If
End If
If Countcheck > 0 Then
Command3.Enabled = True
Label1.Visible = True
Else: Command3.Enabled = False
         Label1.Visible = False
End If
End Sub
Private Sub Combo1_GotFocus()
Label2.Visible = True
Label2.Caption = "Pop"
End Sub

Private Sub Command1_Click()
Unload Me
MenuClient.Show
End Sub

Private Sub Command2_Click()
For c% = 0 To 6
Check1(c%).Value = 0
Next c%
End Sub

Private Sub Command3_Click()
Dim check As Boolean
check = True
For i% = 0 To 6
If i% = 5 Then
            If (Check1(5) = 1) And (Combo1.Text = "") Then
                    check = False
            End If
Else:
            If (Check1(i%) = 1) And (Text1(i%).Text = "") Then
                    check = False
            End If
End If
If (i%) = 4 And (Text1(4).Text = "") Then
     Text1(4).Text = 0
End If
Next i%
If check Then
PassSQL
Else: MsgBox ("โปรดใส่ข้อความที่คุณต้องการค้นหา ณ หัวข้อที่คุณเช็ค")
End If
End Sub

Private Function PrepareSQL() As String
SQL$ = ""
For i% = 0 To 6
    If i% = 5 Then
            SQL$ = SQL$ + UCase(Combo1.Text)
    Else:
            SQL$ = SQL$ + UCase(Text1(i%).Text)
    End If
If i% <> 6 Then
SQL$ = SQL$ + ""","""
End If
Next i%
PrepareSQL = SQL$
End Function
Private Sub PassSQL()
SQLString = PrepareSQL
SQLString = "execute function getinfomusic(""" + SQLString + """)"
'For direct SQL (DML) include transaction
MainScreen.oDataGroupMusic.BeginTransaction
Set oVTableMusic = MainScreen.oDataGroupMusic.ExecuteSQLCommand(SQLString)
MainScreen.oDataGroupMusic.CommitTransaction
If oVTableMusic Is Nothing Then           'No data return
MsgBox ("No Data in this Multimedia database")
MainScreen.oDataGroupMusic.DeleteVirtualTable ("oVTableMusic")
Else: SearchSong.Hide
Load Result
Result.Show
End If
End Sub

Private Sub Text1_GotFocus(Index As Integer)
Label2.Visible = True
Select Case Index
    Case 0
    Label2.Caption = "MS001"
    Case 1
    Label2.Caption = "I knew I loved you"
    Case 2
    Label2.Caption = "Savage Garden"
    Case 4
    Label2.Caption = "1999"
    Case 6
    Label2.Caption = "RS Promotion"
End Select
End Sub
