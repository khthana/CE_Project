VERSION 5.00
Begin VB.Form SearchBook 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "ระบบค้นหาหนังสือ"
   ClientHeight    =   5775
   ClientLeft      =   1455
   ClientTop       =   2565
   ClientWidth     =   5595
   Icon            =   "Searchbook.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5775
   ScaleWidth      =   5595
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
      Height          =   795
      Left            =   120
      TabIndex        =   15
      Top             =   4080
      Width           =   5355
      Begin VB.Label Label2 
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
         Left            =   180
         TabIndex        =   17
         Top             =   360
         Visible         =   0   'False
         Width           =   2235
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
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
         Left            =   2400
         TabIndex        =   16
         Top             =   360
         Width           =   60
      End
   End
   Begin VB.CheckBox Check1 
      Caption         =   " ปีที่พิมพ์"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   5
      Left            =   420
      TabIndex        =   14
      Top             =   3420
      Width           =   1275
   End
   Begin VB.CheckBox Check1 
      Caption         =   " สำนักพิมพ์"
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
      Index           =   4
      Left            =   420
      TabIndex        =   13
      Top             =   2820
      Width           =   1395
   End
   Begin VB.CheckBox Check1 
      Caption         =   " ประเภทของหนังสือ"
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
      Left            =   420
      TabIndex        =   12
      Top             =   2220
      Width           =   1875
   End
   Begin VB.CheckBox Check1 
      Caption         =   " ชื่อผู้แต่ง"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   2
      Left            =   420
      TabIndex        =   11
      Top             =   1680
      Width           =   1155
   End
   Begin VB.CheckBox Check1 
      Caption         =   " ชื่อหนังสือ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   1
      Left            =   420
      TabIndex        =   10
      Top             =   1140
      Width           =   1275
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
      Height          =   3810
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   5340
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
         ItemData        =   "Searchbook.frx":0442
         Left            =   2220
         List            =   "Searchbook.frx":0455
         Sorted          =   -1  'True
         TabIndex        =   18
         Text            =   "Computer"
         Top             =   2040
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
         Left            =   2220
         TabIndex        =   9
         Top             =   360
         Visible         =   0   'False
         Width           =   2850
      End
      Begin VB.CheckBox Check1 
         Caption         =   " เลขหมู่หนังสือ"
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
         TabIndex        =   8
         Top             =   420
         Width           =   1575
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
         Left            =   2220
         TabIndex        =   7
         Top             =   900
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
         Left            =   2220
         TabIndex        =   6
         Top             =   1440
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
         Left            =   2220
         TabIndex        =   5
         Top             =   2640
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
         Index           =   5
         Left            =   2220
         MaxLength       =   4
         TabIndex        =   4
         Text            =   "0"
         Top             =   3180
         Visible         =   0   'False
         Width           =   2850
      End
   End
   Begin VB.CommandButton Command3 
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
      Left            =   2340
      Style           =   1  'Graphical
      TabIndex        =   2
      ToolTipText     =   "ล้างข้อมูลการค้นหา"
      Top             =   5100
      Width           =   960
   End
   Begin VB.CommandButton Command2 
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
      Left            =   4260
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "เริ่มค้นหา"
      Top             =   5100
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
      TabIndex        =   1
      ToolTipText     =   "ไปหน้าการค้นหาหลัก"
      Top             =   5100
      Width           =   960
   End
End
Attribute VB_Name = "SearchBook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public oVTableBook As ddoTable
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
                If Index = 5 Then
                Text1(5).Text = 0
                Else: Text1(Index).Text = ""
                End If
                Label1.Visible = False
                Countcheck = Countcheck - 1
        End If
End If
If Countcheck > 0 Then
    Command2.Enabled = True
    Label2.Visible = True
Else: Command2.Enabled = False
    Label2.Visible = False
End If
End Sub
Private Sub Combo1_GotFocus()
Label1.Visible = True
Label1.Caption = "Computer"
End Sub



Private Sub Command1_Click()
Unload Me
MenuClient.Show
End Sub
Private Sub Command2_Click()
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
Next i%
If check Then
PassSQL
Else: MsgBox ("โปรดใส่ข้อความที่คุณต้องการค้นหา ณ หัวข้อที่คุณเช็ค")
End If
End Sub
Private Function PrepareSQL() As String
SQL$ = ""
For i% = 0 To 4
        If i% = 3 Then
            SQL$ = SQL$ + UCase(Combo1.Text)
        Else:
            SQL$ = SQL$ + UCase(Text1(i%).Text)
        End If
        If i% <> 4 Then
            SQL$ = SQL$ + ""","""
        End If
Next i%
SQL$ = SQL$ + """," + Text1(5).Text
PrepareSQL = SQL$
End Function
Private Sub PassSQL()
SQLString = PrepareSQL
SQLString = "execute function getinfobook(""" + SQLString + ")"
'For direct SQL (DML) include transaction
MainScreen.oDataGroupBook.BeginTransaction
Set oVTableBook = MainScreen.oDataGroupBook.ExecuteSQLCommand(SQLString)
MainScreen.oDataGroupBook.CommitTransaction
If oVTableBook Is Nothing Then                   'No data return
MsgBox ("No Data in this Multimedia database")
MainScreen.oDataGroupBook.DeleteVirtualTable ("oVTableBook")
Else: SearchBook.Hide
Load Result
Result.Show
End If
End Sub
Private Sub Command3_Click()
For c% = 0 To 5
Check1(c%).Value = 0
Next c%
End Sub
'This Event Demonstrate example inputting in text for Search book
Private Sub Text1_GotFocus(Index As Integer)
Label1.Visible = True
Select Case Index
    Case 0
    Label1.Caption = "QA.456"
    Case 1
    Label1.Caption = "411 Digital"
    Case 2
    Label1.Caption = "Pratya"
    Case 4
    Label1.Caption = "Amazon"
    Case 5
    Label1.Caption = "1998"
End Select
End Sub
