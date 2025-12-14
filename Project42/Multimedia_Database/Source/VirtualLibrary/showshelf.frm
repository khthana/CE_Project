VERSION 5.00
Begin VB.Form ShowShelf 
   Caption         =   "ที่อยู่โดยละเอียดบนตู้หนังสือ"
   ClientHeight    =   5310
   ClientLeft      =   1815
   ClientTop       =   1755
   ClientWidth     =   8370
   Icon            =   "showshelf.frx":0000
   LinkTopic       =   "Form2"
   ScaleHeight     =   5310
   ScaleWidth      =   8370
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "รายละเอียด"
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
      Height          =   2955
      Left            =   4020
      TabIndex        =   1
      Top             =   780
      Width           =   4275
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
         Height          =   255
         Left            =   720
         TabIndex        =   11
         Top             =   2410
         Width           =   1275
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
         Left            =   1260
         TabIndex        =   10
         Top             =   1980
         Width           =   2115
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
         Left            =   1080
         TabIndex        =   9
         Top             =   1500
         Width           =   1695
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
         Height          =   315
         Left            =   1080
         TabIndex        =   8
         Top             =   1050
         Width           =   1815
      End
      Begin VB.Label Label6 
         Caption         =   "label6"
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
         Height          =   495
         Left            =   1140
         TabIndex        =   7
         Top             =   540
         Width           =   3015
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
         Height          =   375
         Left            =   120
         TabIndex        =   6
         Top             =   2400
         Width           =   855
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
         Height          =   435
         Left            =   120
         TabIndex        =   5
         Top             =   1980
         Width           =   1035
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
         Left            =   120
         TabIndex        =   4
         Top             =   1500
         Width           =   915
      End
      Begin VB.Label Label2 
         Caption         =   "เลขหมู่ :"
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
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   1020
         Width           =   795
      End
      Begin VB.Label Label1 
         Caption         =   "ชื่อหนังสือ :"
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
         Index           =   0
         Left            =   120
         TabIndex        =   2
         Top             =   540
         Width           =   915
      End
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Back"
      DownPicture     =   "showshelf.frx":0442
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
      Left            =   5820
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "กลับไปหน้าที่แล้ว"
      Top             =   4260
      Width           =   975
   End
   Begin VB.Image Image4 
      Height          =   1275
      Left            =   180
      Stretch         =   -1  'True
      Top             =   3660
      Width           =   915
   End
   Begin VB.Image Image3 
      Height          =   5295
      Left            =   0
      Stretch         =   -1  'True
      Top             =   0
      Width           =   3795
   End
End
Attribute VB_Name = "ShowShelf"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim ShelfLevel  As Integer   'ตำแหน่งของชั้น
Dim PartLevel As String 'ตำแหน่งของส่วนของชั้น
Private Sub Command1_Click()
    Unload Me
    Load ShowLibrary
    ShowLibrary.Show
End Sub

Private Sub Form_Load()
Label6.Caption = Result.oVTableDetail.Columns(3).Value
Label7.Caption = Result.oVTableDetail.Columns(2).Value
Label8.Caption = Result.oVTableDetail.Columns(12).Value
Select Case Result.oVTableDetail.Columns(15).Value
        Case "L"
                Label9.Caption = "ซ้าย"
        Case "M"
                Label9.Caption = "กลาง"
        Case "R"
                Label9.Caption = "ขวา"
End Select
Label10.Caption = Result.oVTableDetail.Columns(13).Value
ShelfLevel = Result.oVTableDetail.Columns(12).Value
PartLevel = Result.oVTableDetail.Columns(15).Value
Image3.Picture = LoadPicture("e:\Project\ProjectVB\VirtualLibrary\picture\bookshelf1.gif")
Image3.Visible = False
Image4.Picture = LoadPicture("e:\Project\ProjectVB\VirtualLibrary\picture\Bookpoin3.gif")
Image4.Visible = False
  If ShelfLevel = 3 And PartLevel = "L" Then
       Image4.Left = 180
       Image4.Top = 700
       Image3.Visible = True
        Image4.Visible = True
    ElseIf ShelfLevel = 3 And PartLevel = "M" Then
        Image4.Top = 700
        Image4.Left = 1080
         Image3.Visible = True
        Image4.Visible = True
        ElseIf ShelfLevel = 3 And PartLevel = "R" Then
        Image4.Top = 700
        Image4.Left = 2250
         Image3.Visible = True
        Image4.Visible = True
        ElseIf ShelfLevel = 2 And PartLevel = "L" Then
        Image4.Top = 2160
        Image4.Left = 180
         Image3.Visible = True
        Image4.Visible = True
        ElseIf ShelfLevel = 2 And PartLevel = "M" Then
        Image4.Top = 2160
        Image4.Left = 1080
         Image3.Visible = True
        Image4.Visible = True
        ElseIf ShelfLevel = 2 And PartLevel = "R" Then
        Image4.Top = 2200
        Image4.Left = 2250
         Image3.Visible = True
        Image4.Visible = True
        ElseIf ShelfLevel = 1 And PartLevel = "L" Then
        Image4.Top = 3860
        Image4.Left = 180
         Image3.Visible = True
        Image4.Visible = True
        ElseIf ShelfLevel = 1 And PartLevel = "M" Then
        Image4.Top = 3860
        Image4.Left = 1080
         Image3.Visible = True
        Image4.Visible = True
        ElseIf ShelfLevel = 1 And PartLevel = "R" Then
        Image4.Top = 3860
        Image4.Left = 2250
         Image3.Visible = True
        Image4.Visible = True
        End If
End Sub


