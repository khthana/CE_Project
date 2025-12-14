VERSION 5.00
Begin VB.Form Searchdata 
   Caption         =   "Search Fingerprint"
   ClientHeight    =   7830
   ClientLeft      =   735
   ClientTop       =   345
   ClientWidth     =   10320
   Icon            =   "select.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7830
   ScaleWidth      =   10320
   Begin VB.PictureBox referencepic 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      Height          =   3900
      Left            =   4560
      ScaleHeight     =   256
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   256
      TabIndex        =   14
      Top             =   120
      Width           =   3900
   End
   Begin VB.PictureBox querypic 
      AutoSize        =   -1  'True
      Height          =   3900
      Left            =   240
      ScaleHeight     =   256
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   256
      TabIndex        =   13
      Top             =   120
      Width           =   3900
   End
   Begin VB.CommandButton cmdCancel 
      BackColor       =   &H00FF8080&
      Caption         =   "Back"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   8640
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   3360
      Width           =   1575
   End
   Begin VB.Frame Frame1 
      Caption         =   "Result"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   3615
      Left            =   120
      TabIndex        =   1
      Top             =   4080
      Width           =   9855
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":1272
         Height          =   1455
         Index           =   9
         Left            =   8160
         Style           =   1  'Graphical
         TabIndex        =   11
         Top             =   1920
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":87E4
         Height          =   1455
         Index           =   8
         Left            =   6240
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   1920
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":FD56
         Height          =   1455
         Index           =   7
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   9
         Top             =   1920
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":172C8
         Height          =   1455
         Index           =   6
         Left            =   2280
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   1920
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":1E83A
         Height          =   1455
         Index           =   5
         Left            =   360
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   1920
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":25DAC
         Height          =   1455
         Index           =   4
         Left            =   8160
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   360
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":2D31E
         Height          =   1455
         Index           =   3
         Left            =   6240
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   360
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":34890
         Height          =   1455
         Index           =   2
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   360
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":3BE02
         Height          =   1455
         Index           =   1
         Left            =   2280
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   360
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         DisabledPicture =   "select.frx":43374
         Height          =   1455
         Index           =   0
         Left            =   360
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   360
         Width           =   1455
      End
   End
   Begin VB.CommandButton cmdSearchgo 
      BackColor       =   &H00FF8080&
      Caption         =   "Search Go!"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   8640
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   2280
      Width           =   1575
   End
   Begin VB.Label Label2 
      Caption         =   "MATCH:"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Left            =   8520
      TabIndex        =   16
      Top             =   720
      Width           =   1575
   End
   Begin VB.Label Label1 
      Caption         =   "KEY:"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Left            =   8520
      TabIndex        =   15
      Top             =   240
      Width           =   1575
   End
End
Attribute VB_Name = "Searchdata"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim pic_file(1 To 10) As String
Dim id(1 To 10) As Integer
Dim percent(1 To 10) As Integer

Private Sub cmdCancel_Click()
    Form1.Enabled = True
    Unload Searchdata
End Sub

Private Sub cmdSearchgo_Click()
    Dim Vttable As ddoTable
    Dim oBlob As ddoBlob
    Dim i, Number_items As Integer
        
    Set Vttable = Form1.groupSelect.CreateVirtualTable("fingerprint match")
    'Caution This following instruction is Powerful and eaten resource very much
    Vttable.QueryCommand = "Select score2(query,fing),fid from fingerprint,for_query order by 1 desc"
    Vttable.ExecuteCommand QUERY_CMD
    If Vttable.LastRecord Then
        Number_items = Vttable.CurrentRecordNumber
    End If
    If Number_items > 10 Then
        Number_items = 10
    End If
    For i = 1 To Number_items
        id(i) = Vttable.Records(i).Columns("fid").Value
        percent(i) = Int(100 * Vttable.Records(i).Columns(1).Value)
        pic_file(i) = "pic" + Str(i) + ".bmp"
    Next i
    For i = 1 To Number_items
        Vttable.QueryCommand = "Select fid,picture,fing from fingerprint where fid = " + Str(id(i))
        Vttable.ExecuteCommand QUERY_CMD
        Set oBlob = Vttable.Columns("picture").Value
        oBlob.SaveToFile pic_file(i)
        Option1(i - 1).DownPicture = LoadPicture(pic_file(i))
        Option1(i - 1).Picture = LoadPicture(pic_file(i))
        Option1(i - 1).Enabled = True
    Next i
    Form1.groupSelect.DeleteVirtualTable ("fingerprint match")
End Sub

Private Sub Form_Load()
Dim ttable As ddoTable
Dim Number_items As Integer
Dim i, j, ex, bx, by As Integer
Dim buffer(6000) As Long

    cmdSearchgo.Enabled = False
    For i = 0 To 9
        Option1(i).Enabled = False
    Next i
    Number_items = 0
    querypic.Picture = LoadPicture("_tn.bmp")
    ' Load data to buffer
    For i = 0 To Form1.m_cImage.xMax
        For j = 0 To Form1.m_cImage.yMax
            ex = Form1.m_cImage.Feature(i, j)
            If ex <> 0 Then
                buffer(Number_items) = CLng(i)          'X  axis load
                Number_items = Number_items + 1
                buffer(Number_items) = CLng(j)
                Number_items = Number_items + 1 'Y axis load
                bx = (i \ 16) + 1
                by = (j \ 16) + 1
                buffer(Number_items) = CLng(Form1.m_cImage.OrientedField(bx, by))     ' Zeta load
                Number_items = Number_items + 1 'Next pointer
            End If
        Next j
    Next i
    If (Number_items) Mod 3 = 0 Then
        cmdSearchgo.Enabled = True
        Set ttable = Form1.groupSelect.Tables("for_query")
        ttable.QueryData
        ttable.Columns("query").Value.SetData buffer, Number_items
        Form1.groupSelect.SaveConfirm = False
        Form1.groupSelect.BeginTransaction
        ttable.SaveData
        Form1.groupSelect.CommitTransaction
        Form1.groupSelect.SaveConfirm = True
    Else
        cmdSearchgo.Enabled = False
        MsgBox "เกิดข้อผิดพลาดในการ load data เพื่อทำการ search", vbCritical, "Load error!"
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call cmdCancel_Click
End Sub

Private Sub Option1_Click(Index As Integer)
    referencepic.Picture = Option1(Index).Picture
    Label1.Caption = "KEY: " + Str(id(Index + 1))
    Label2.Caption = "MATCH: " + Str(percent(Index + 1)) + "%"
End Sub
