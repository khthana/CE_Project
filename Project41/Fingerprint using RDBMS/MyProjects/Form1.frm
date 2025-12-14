VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.1#0"; "COMCTL32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.1#0"; "COMDLG32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form Form1 
   Caption         =   "Informix Fingprint Database"
   ClientHeight    =   6120
   ClientLeft      =   1920
   ClientTop       =   1140
   ClientWidth     =   8355
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   9.75
      Charset         =   222
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6120
   ScaleWidth      =   8355
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8355
      _ExtentX        =   14737
      _ExtentY        =   794
      ButtonWidth     =   688
      ButtonHeight    =   635
      Appearance      =   1
      ImageList       =   "imgpicture"
      _Version        =   327680
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   6
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "openfile"
            Object.ToolTipText     =   "เปิดแฟ้มข้อมูล (Open File)"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "insertdata"
            Object.ToolTipText     =   "เพิ่มข้อมูลลงฐานข้อมูล (Insert Data)"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "selectdata"
            Object.ToolTipText     =   "ค้นหาลายนิ้วมือ (Select Fingerprint)"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button6 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "close"
            Object.ToolTipText     =   "ออกจากโปรแกรม (Close)"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
      EndProperty
      MouseIcon       =   "Form1.frx":014A
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   5055
      Left            =   360
      TabIndex        =   1
      Top             =   720
      Width           =   7575
      _ExtentX        =   13361
      _ExtentY        =   8916
      _Version        =   327680
      Tabs            =   5
      TabsPerRow      =   5
      TabHeight       =   520
      BackColor       =   -2147483626
      ForeColor       =   16711680
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Original"
      TabPicture(0)   =   "Form1.frx":0166
      Tab(0).ControlCount=   4
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Picture1"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Command1"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Command7"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "Command10"
      Tab(0).Control(3).Enabled=   0   'False
      TabCaption(1)   =   "Smoothing"
      TabPicture(1)   =   "Form1.frx":0182
      Tab(1).ControlCount=   2
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Command2"
      Tab(1).Control(0).Enabled=   -1  'True
      Tab(1).Control(1)=   "Picture2"
      Tab(1).Control(1).Enabled=   -1  'True
      TabCaption(2)   =   "Binalize"
      TabPicture(2)   =   "Form1.frx":019E
      Tab(2).ControlCount=   2
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Command3"
      Tab(2).Control(0).Enabled=   -1  'True
      Tab(2).Control(1)=   "Picture3"
      Tab(2).Control(1).Enabled=   -1  'True
      TabCaption(3)   =   "Thinning"
      TabPicture(3)   =   "Form1.frx":01BA
      Tab(3).ControlCount=   2
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "Command4"
      Tab(3).Control(0).Enabled=   -1  'True
      Tab(3).Control(1)=   "Picture4"
      Tab(3).Control(1).Enabled=   -1  'True
      TabCaption(4)   =   "Extraction"
      TabPicture(4)   =   "Form1.frx":01D6
      Tab(4).ControlCount=   9
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "Label2"
      Tab(4).Control(0).Enabled=   0   'False
      Tab(4).Control(1)=   "Label1"
      Tab(4).Control(1).Enabled=   0   'False
      Tab(4).Control(2)=   "Picture5"
      Tab(4).Control(2).Enabled=   0   'False
      Tab(4).Control(3)=   "Command5"
      Tab(4).Control(3).Enabled=   0   'False
      Tab(4).Control(4)=   "Command6"
      Tab(4).Control(4).Enabled=   0   'False
      Tab(4).Control(5)=   "Text2"
      Tab(4).Control(5).Enabled=   0   'False
      Tab(4).Control(6)=   "Command8"
      Tab(4).Control(6).Enabled=   0   'False
      Tab(4).Control(7)=   "Text1"
      Tab(4).Control(7).Enabled=   0   'False
      Tab(4).Control(8)=   "Command9"
      Tab(4).Control(8).Enabled=   0   'False
      Begin VB.CommandButton Command10 
         BackColor       =   &H00FFC0C0&
         Caption         =   "Pre-Processing GO!"
         Height          =   615
         Left            =   4800
         Style           =   1  'Graphical
         TabIndex        =   20
         Top             =   3120
         Width           =   2295
      End
      Begin VB.CommandButton Command9 
         BackColor       =   &H00FFFF80&
         Caption         =   "Undo Post"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   -70200
         MaskColor       =   &H000000FF&
         Style           =   1  'Graphical
         TabIndex        =   19
         Top             =   2040
         Width           =   2055
      End
      Begin VB.TextBox Text1 
         BackColor       =   &H00808000&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   -70200
         TabIndex        =   17
         Top             =   3120
         Width           =   2055
      End
      Begin VB.CommandButton Command8 
         BackColor       =   &H00FFFF80&
         Caption         =   "Post Processing"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   -70200
         Style           =   1  'Graphical
         TabIndex        =   16
         Top             =   1440
         Width           =   2055
      End
      Begin VB.CommandButton Command7 
         BackColor       =   &H00FF8080&
         Caption         =   "Show Oriented Field"
         Height          =   615
         Left            =   4800
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   1920
         Width           =   2295
      End
      Begin VB.TextBox Text2 
         BackColor       =   &H00808000&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   -70200
         Locked          =   -1  'True
         TabIndex        =   13
         Top             =   4080
         Width           =   2055
      End
      Begin VB.CommandButton Command6 
         BackColor       =   &H00FFFF80&
         Caption         =   "ลบจุด"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   -69120
         Style           =   1  'Graphical
         TabIndex        =   12
         Top             =   840
         Width           =   975
      End
      Begin VB.CommandButton Command5 
         BackColor       =   &H00FFFF80&
         Caption         =   "เพิ่มจุด"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   -70200
         Style           =   1  'Graphical
         TabIndex        =   11
         Top             =   840
         Width           =   975
      End
      Begin VB.PictureBox Picture5 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3900
         Left            =   -74520
         MouseIcon       =   "Form1.frx":01F2
         ScaleHeight     =   256
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   256
         TabIndex        =   10
         Top             =   720
         Width           =   3900
      End
      Begin VB.CommandButton Command4 
         BackColor       =   &H00FF8080&
         Caption         =   "Extraction"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   14.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   -70200
         Style           =   1  'Graphical
         TabIndex        =   9
         Top             =   720
         Width           =   2295
      End
      Begin VB.PictureBox Picture4 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3900
         Left            =   -74520
         ScaleHeight     =   256
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   256
         TabIndex        =   8
         Top             =   720
         Width           =   3900
      End
      Begin VB.CommandButton Command3 
         BackColor       =   &H00C0C000&
         Caption         =   "Thinnig"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   14.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   -70200
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   720
         Width           =   2295
      End
      Begin VB.PictureBox Picture3 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3900
         Left            =   -74520
         ScaleHeight     =   256
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   256
         TabIndex        =   6
         Top             =   720
         Width           =   3900
      End
      Begin VB.CommandButton Command2 
         BackColor       =   &H00FFFF80&
         Caption         =   "Binalize"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   14.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   -70200
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   720
         Width           =   2295
      End
      Begin VB.PictureBox Picture2 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3900
         Left            =   -74520
         ScaleHeight     =   256
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   256
         TabIndex        =   4
         Top             =   720
         Width           =   3900
      End
      Begin VB.CommandButton Command1 
         BackColor       =   &H00C0C000&
         Caption         =   "Smoothing"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   14.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   4800
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   720
         Width           =   2295
      End
      Begin VB.PictureBox Picture1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3900
         Left            =   480
         ScaleHeight     =   256
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   256
         TabIndex        =   2
         Top             =   720
         Width           =   3900
      End
      Begin VB.Label Label1 
         Caption         =   "Ride Width"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   375
         Left            =   -70200
         TabIndex        =   18
         Top             =   2760
         Width           =   855
      End
      Begin VB.Label Label2 
         Caption         =   "Ride Counter"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   375
         Left            =   -70200
         TabIndex        =   14
         Top             =   3720
         Width           =   975
      End
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   3960
      Top             =   120
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327680
      DialogTitle     =   "เปิดรูปภาพลายนิ้วมือ"
      Filter          =   "Bitmap File (*.bmp)|*.bmp"
      Flags           =   2101252
   End
   Begin ComctlLib.ImageList imgpicture 
      Left            =   2760
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   19
      ImageHeight     =   18
      MaskColor       =   12632256
      _Version        =   327680
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   4
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "Form1.frx":0ABC
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "Form1.frx":0C26
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "Form1.frx":0F40
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "Form1.frx":125A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu mainfile 
      Caption         =   "&File"
      Begin VB.Menu mainopen 
         Caption         =   "&Open"
         Index           =   0
         Shortcut        =   ^O
      End
      Begin VB.Menu mainsub 
         Caption         =   "-"
         Index           =   1
      End
      Begin VB.Menu mainexit 
         Caption         =   "&Exit"
         Index           =   2
         Shortcut        =   ^E
      End
   End
   Begin VB.Menu maininsert 
      Caption         =   "&Insert"
      Begin VB.Menu maininsertform 
         Caption         =   "&Insert data"
         Index           =   0
         Shortcut        =   ^I
      End
   End
   Begin VB.Menu mainsert 
      Caption         =   "&Search"
      Begin VB.Menu mainsearchdata 
         Caption         =   "&Search data"
         Index           =   0
         Shortcut        =   ^S
      End
   End
   Begin VB.Menu mainhelp 
      Caption         =   "&Help"
      Begin VB.Menu mainabouthelp 
         Caption         =   "&About help"
         Index           =   0
         Shortcut        =   ^H
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public m_cImage As CImageProcess
Public oEngine As ddoEngine
Public oProject As ddoProject
Public groupInsert As ddoDataGroup
Public groupSelect As ddoDataGroup

Private Sub Command1_Click() ' Smoothing
    Picture1.Picture = LoadPicture("_tn.bmp")
    m_cImage.SmoothFilter Picture1
    Picture2.Picture = Picture1.Picture
    SavePicture Picture2, "_smg.bmp"
    Picture1.Picture = LoadPicture("_tn.bmp")
    Command2.Enabled = True
End Sub

Private Sub Command10_Click()
    Call Command1_Click
    Call Command2_Click
    Call Command3_Click
    Call Command4_Click
    MsgBox "กระบวนการ Pre-Processing ทั้งหมดได้ทำเสร็จแล้ว", vbInformation, "แสดงสถานะ"
End Sub

Private Sub Command2_Click() ' Binalize
    Picture2.Picture = LoadPicture("_smg.bmp")
    m_cImage.BinaryFilter Picture2
    Picture3.Picture = Picture2.Picture
    SavePicture Picture3, "_bin.bmp"
    Picture2.Picture = LoadPicture("_smg.bmp")
    Command3.Enabled = True
End Sub

Private Sub Command3_Click() ' Thinning
    Picture3.Picture = LoadPicture("_bin.bmp")
    m_cImage.ThinFilter Picture3
    Picture4.Picture = Picture3.Picture
    SavePicture Picture4, "_thin.bmp"
    Picture3.Picture = LoadPicture("_bin.bmp")
    Command4.Enabled = True
End Sub

Private Sub Command4_Click() ' Extraction
Dim i, j, ex As Integer
        Picture4.Picture = LoadPicture("_thin.bmp")
        m_cImage.ExtractFilter Picture4
        Picture5.Picture = Picture4.Picture
        Picture4.Picture = LoadPicture("_thin.bmp")
        Call Drawnfeature
        Command5.Enabled = True
        Command6.Enabled = True
        Command8.Enabled = True
        Command9.Enabled = True
        Text1.Enabled = True
End Sub

Private Sub Command5_Click() ' เพิ่มจุด
    Command5.Enabled = False
    Command6.Enabled = True
End Sub

Private Sub Command6_Click() ' ลบจุด
    Command5.Enabled = True
    Command6.Enabled = False
End Sub

Private Sub Command7_Click() ' Show and Hide Oriented Field
Dim i, j As Integer
Dim angle As Double
Dim pi As Double
If Command7.Caption = "Show Oriented Field" Then
    pi = 3.14159265358979
    For i = 1 To 16
        For j = 1 To 16
        angle = m_cImage.OrientedField(i, j) * pi / 180
        If m_cImage.OrientedField(i, j) <= 90 Then
            Picture1.Line ((i - 1) * 16, m_cImage.yMax - (j - 1) * 16)- _
            (Int(16 * Cos(angle)) + (i - 1) * 16, m_cImage.yMax - (Int(16 * Sin(angle)) + (j - 1) * 16)), QBColor(14)
       Else
            Picture1.Line (i * 16, m_cImage.yMax - (j - 1) * 16)- _
            (Int(16 * Cos(angle)) + i * 16, m_cImage.yMax - (Int(16 * Sin(angle)) + (j - 1) * 16)), QBColor(14)
        End If
        Next j
    Next i
    Command7.Caption = "Hide Oriented Filed"
Else
    Picture1.Picture = LoadPicture("_tn.bmp")
    Command7.Caption = "Show Oriented Field"
End If
End Sub

Private Sub Command8_Click() 'Post Processing
 m_cImage.RideWidth = Val(Text1.Text)
    If m_cImage.RideWidth > 5 Then
        m_cImage.Post_Pro (2)
        m_cImage.Post_Pro (3)
        m_cImage.Post_Pro (4)
        Picture5.Picture = LoadPicture("_thin.bmp")
        Call Drawnfeature
    Else
        MsgBox "Ride Width ต้องมีค่ามากกว่า 5", vbCritical, "Exception"
    End If
End Sub

Private Sub Command9_Click() ' Undo all Post processing
    m_cImage.Undoextracted
    Call Drawnfeature
End Sub

Private Sub Form_Load()
    Set oEngine = New ddoEngine
    Set oProject = oEngine.CurrentProject
    Set groupInsert = oProject.CreateDataGroup("fingerprint", "Insert", "cli_fing.mlt")
    groupInsert.Logon
    groupInsert.CreateLink ("fingerprint.fid")
    groupInsert.CreateLink ("fingerprint.picture")
    groupInsert.CreateLink ("fingerprint.fing")
    Set groupSelect = oProject.CreateDataGroup("for_query", "Select", "cli_fing.mlt")
    groupSelect.Logon
    groupSelect.CreateLink ("for_query.query")
    SSTab1.Enabled = False
    Command1.Enabled = False
    Command2.Enabled = False
    Command3.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False
    Command6.Enabled = False
    Command7.Enabled = False
    Command8.Enabled = False
    Command9.Enabled = False
    Command10.Enabled = False
    Text1.Enabled = False
    Set m_cImage = New CImageProcess
End Sub

Private Sub mainabouthelp_Click(Index As Integer)
    Form1.Enabled = False
    frmAbout.Show
End Sub

Private Sub mainexit_Click(Index As Integer)
    Call confirmexit
End Sub

Private Sub maininsertform_Click(Index As Integer)
    Insert.Show
    Form1.Enabled = False
End Sub

Private Sub mainopen_Click(Index As Integer)
    Call Fileopen
End Sub

Private Sub mainsearchdata_Click(Index As Integer)
    Form1.Enabled = False
    Searchdata.Show
End Sub

Private Sub Picture5_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Dim Active As Boolean
    If Command5.Enabled Xor Command6.Enabled Then
        If Not Command6.Enabled Then ' ลบจุด
            Active = m_cImage.SubFeature(x, m_cImage.yMax - y)
        ElseIf Not Command5.Enabled Then  ' เพิ่มจุด
            Active = m_cImage.AddFeature(x, m_cImage.yMax - y)
        End If
        If Active Then
            Picture5.Picture = LoadPicture("_thin.bmp")
            Call Drawnfeature
        End If
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
    If Button.Key = "openfile" Then
        Call Fileopen
    ElseIf Button.Key = "close" Then
        Call confirmexit
    ElseIf Button.Key = "insertdata" Then
        Form1.Enabled = False
        Insert.Show
    ElseIf Button.Key = "selectdata" Then
        Form1.Enabled = False
        Searchdata.Show
    End If
End Sub

Private Sub Fileopen()
Dim Currentdir As String
    Currentdir = CurDir
    CommonDialog1.Action = 1
    If CommonDialog1.filename <> "" Then
        Picture1.Picture = LoadPicture(CommonDialog1.filename)
        SSTab1.Enabled = True
        Command1.Enabled = True ' Smoothing Command
        Command7.Enabled = True ' Show Oriented Command
        Command10.Enabled = True 'Show Pre-Processing GO
    End If
    ChDir (Currentdir)
    If CommonDialog1.filename <> "" Then
        SavePicture Picture1, "_tn.bmp"
        m_cImage.OrientedFilter Picture1
    End If
End Sub

Private Sub confirmexit()
Dim endfile As Integer

endfile = MsgBox("ออกจากการทำงาน", vbYesNo, "Fingerprint Database")
If endfile = vbYes Then
    End
End If
End Sub

Private Sub Drawnfeature()
Dim i, j, ex As Integer
Dim bx, by As Integer
Dim pi, angle As Double

pi = 3.14159265358979
For i = 0 To m_cImage.xMax
    For j = 0 To m_cImage.yMax
        ex = m_cImage.Feature(i, j)
        If ex <> 0 Then
            Picture5.Circle (i, m_cImage.yMax - j), 3, QBColor(11)
            bx = (i \ 16) + 1
            by = (j \ 16) + 1
            angle = m_cImage.OrientedField(bx, by) * pi / 180
            Picture5.Line (i, m_cImage.yMax - j)- _
            (Int(16 * Cos(angle)) + i, m_cImage.yMax - (Int(16 * Sin(angle)) + j)), QBColor(14)
        End If
    Next j
Next i
Text2.Text = m_cImage.RideCount
End Sub
