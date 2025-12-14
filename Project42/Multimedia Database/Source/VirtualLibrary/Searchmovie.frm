VERSION 5.00
Begin VB.Form Searchmovie 
   Caption         =   "ระบบค้นหาภาพยนตร์"
   ClientHeight    =   6105
   ClientLeft      =   1575
   ClientTop       =   1455
   ClientWidth     =   6090
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6105
   ScaleWidth      =   6090
   StartUpPosition =   2  'CenterScreen
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
      Height          =   675
      Left            =   120
      TabIndex        =   15
      Top             =   4560
      Width           =   5835
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
         Left            =   2760
         TabIndex        =   17
         Top             =   300
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
         Height          =   195
         Left            =   480
         TabIndex        =   16
         Top             =   300
         Visible         =   0   'False
         Width           =   2175
      End
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
      Left            =   4680
      Style           =   1  'Graphical
      TabIndex        =   14
      ToolTipText     =   "เริ่มค้นหา"
      Top             =   5460
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
      Left            =   2640
      Style           =   1  'Graphical
      TabIndex        =   13
      ToolTipText     =   "ล้างข้อมูลการค้นหา"
      Top             =   5460
      Width           =   960
   End
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
      Left            =   360
      Style           =   1  'Graphical
      TabIndex        =   12
      ToolTipText     =   "ไปหน้าการค้นหาหลัก"
      Top             =   5460
      Width           =   960
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
      Index           =   5
      Left            =   2760
      TabIndex        =   11
      Top             =   3660
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
      Left            =   2760
      TabIndex        =   10
      Top             =   3060
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
      Left            =   2760
      TabIndex        =   9
      Top             =   1860
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
      Left            =   2760
      TabIndex        =   8
      Top             =   1260
      Visible         =   0   'False
      Width           =   2850
   End
   Begin VB.CheckBox Check1 
      Caption         =   " ชื่อของบริษัทผู้สร้าง"
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
      Index           =   5
      Left            =   420
      TabIndex        =   6
      Top             =   3720
      Width           =   2055
   End
   Begin VB.CheckBox Check1 
      Caption         =   " ปีที่สร้างภาพยนตร์"
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
      Left            =   420
      TabIndex        =   5
      Top             =   3180
      Width           =   2175
   End
   Begin VB.CheckBox Check1 
      Caption         =   " นักแสดง"
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
      Left            =   420
      TabIndex        =   3
      Top             =   1980
      Width           =   1755
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
      Height          =   4275
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5835
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
         ItemData        =   "Searchmovie.frx":0000
         Left            =   2640
         List            =   "Searchmovie.frx":0010
         Sorted          =   -1  'True
         TabIndex        =   18
         Text            =   "Action"
         Top             =   2400
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
         Index           =   0
         Left            =   2640
         TabIndex        =   7
         Top             =   480
         Visible         =   0   'False
         Width           =   2850
      End
      Begin VB.CheckBox Check1 
         Caption         =   " ประเภทของภาพยนตร์"
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
         Left            =   300
         TabIndex        =   4
         Top             =   2460
         Width           =   2175
      End
      Begin VB.CheckBox Check1 
         Caption         =   " ชื่อภาพยนตร์"
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
         Left            =   300
         TabIndex        =   2
         Top             =   1200
         Width           =   1755
      End
      Begin VB.CheckBox Check1 
         Caption         =   " เลขหมู่ภาพยนตร์"
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
         Left            =   300
         TabIndex        =   1
         Top             =   540
         Width           =   1755
      End
   End
End
Attribute VB_Name = "Searchmovie"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public oVTableMovie As ddoTable
Dim SQLString As String    'SQL Current
Dim Countcheck As Byte  'Count All CheckBox is Checked

Private Sub Check1_Click(Index As Integer)
If Index = 3 Then
        If Check1(3).Value = 1 Then
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
        Label1.Visible = True
        Command3.Enabled = True
Else: Command3.Enabled = False
         Label1.Visible = False
End If
End Sub
Private Sub Combo1_GotFocus()
Label2.Visible = True
Label2.Caption = "Action"
End Sub
Private Sub Command1_Click()
Unload Me
MenuClient.Show
End Sub

Private Sub Command2_Click()
For c% = 0 To 5
Check1(c%).Value = 0
Next c%
End Sub
Private Sub Command3_Click()
Dim check As Boolean
check = True
For i% = 0 To 5
     If i% = 3 Then
            If (Check1(3) = 1) And (Combo1.Text = "") Then
                    check = False
            End If
    Else:
            If (Check1(i%) = 1) And (Text1(i%).Text = "") Then
                    check = False
            End If
    End If
    If i% = 4 And (Text1(4).Text = "") Then
            Text1(4).Text = 0
    End If
Next i%
If check Then
PassSQL
Else: MsgBox ("โปรดใส่ข้อความที่คุณต้องการค้นหา ณ หัวข้อที่คุณเช็ค")
End If
End Sub
Private Sub PassSQL()
SQLString = PrepareSQL
SQLString = "execute function getinfomovie(""" + SQLString + """)"
'For direct SQL (DML) include transaction
MainScreen.oDataGroupMovie.BeginTransaction
Set oVTableMovie = MainScreen.oDataGroupMovie.ExecuteSQLCommand(SQLString)
MainScreen.oDataGroupMovie.CommitTransaction
If oVTableMovie Is Nothing Then           'No data return
MsgBox ("No Data in this Multimedia database")
MainScreen.oDataGroupMovie.DeleteVirtualTable ("oVTableMovie")
Else: Searchmovie.Hide
Load Result
Result.Show
End If
End Sub
Private Function PrepareSQL() As String
SQL$ = ""
For i% = 0 To 5
        If i% = 3 Then
            SQL$ = SQL$ + UCase(Combo1.Text)
        Else:
            SQL$ = SQL$ + UCase(Text1(i%).Text)
        End If
        If i% <> 5 Then
        SQL$ = SQL$ + ""","""
        End If
Next i%
PrepareSQL = SQL$
End Function

Private Sub Text1_GotFocus(Index As Integer)
Label2.Visible = True
Select Case Index
    Case 0
    Label2.Caption = "MV001"
    Case 1
    Label2.Caption = "Toy Story"
    Case 2
    Label2.Caption = "Merfy"
    Case 4
    Label2.Caption = "1999"
    Case 5
    Label2.Caption = "Walt Disney"
End Select
End Sub
