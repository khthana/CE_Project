VERSION 5.00
Begin VB.Form printing 
   Caption         =   "printing"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.CommandButton Command3 
      Caption         =   "เลือก"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6840
      TabIndex        =   4
      Top             =   720
      Width           =   1095
   End
   Begin VB.ComboBox cmbIDpr 
      Height          =   315
      Left            =   4440
      TabIndex        =   3
      Text            =   "Combo1"
      Top             =   720
      Width           =   2055
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   6600
      TabIndex        =   2
      Top             =   7920
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Print"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4200
      TabIndex        =   1
      Top             =   7920
      Width           =   1695
   End
   Begin VB.TextBox Text1 
      Height          =   6615
      Left            =   2880
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   1200
      Width           =   6615
   End
End
Attribute VB_Name = "printing"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public myprinter As Printer
Public marcdbpr As Database
Public marcwspr As Workspace
Public Rectagdatapr1 As Recordset
Public Rectagdatapr2 As Recordset

Private Sub Command2_Click()
Unload Me
End Sub

Private Sub Command3_Click()
Set Rectagdatapr1 = marcdbpr.OpenRecordset("Select * from tagdata1", dbOpenDynaset)
Set Rectagdatapr2 = marcdbpr.OpenRecordset("Select * from tagdata2", dbOpenDynaset)
Rectagdatapr1.MoveFirst
Rectagdatapr2.MoveFirst
Do While Rectagdatapr1.Fields("t020_1") <> cmbIDpr.Text
  Rectagdatapr1.MoveNext
Loop
Do While Rectagdatapr2.Fields("t020_1") <> cmbIDpr.Text
  Rectagdatapr2.MoveNext
Loop
'************ show data in text box *************
'********* tag020 **********
If Rectagdatapr1.Fields("t020_1") <> " " Or Rectagdatapr1.Fields("t020_2") <> " " Or Rectagdatapr1.Fields("t020_3") <> " " Then Text1.Text = "020  "
If Rectagdatapr1.Fields("t020_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t020_1")
If Rectagdatapr1.Fields("t020_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t020_2")
If Rectagdatapr1.Fields("t020_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t020_3")
'*********tag022**********
If Rectagdatapr1.Fields("t022_1") <> " " Or Rectagdatapr1.Fields("t022_2") <> " " Or Rectagdatapr1.Fields("t022_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "022  "
If Rectagdatapr1.Fields("t022_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t022_1")
If Rectagdatapr1.Fields("t022_2") <> " " Then Text1.Text = Text1.Text & "^y" & Rectagdatapr1.Fields("t022_2")
If Rectagdatapr1.Fields("t022_3") <> " " Then Text1.Text = Text1.Text & "^z" & Rectagdatapr1.Fields("t022_3")
'********tag090***********
If Rectagdatapr1.Fields("t090_1") <> " " Or Rectagdatapr1.Fields("t090_2") <> " " Or Rectagdatapr1.Fields("t090_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "090  "
If Rectagdatapr1.Fields("t090_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t090_1")
If Rectagdatapr1.Fields("t090_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t090_2")
If Rectagdatapr1.Fields("t090_3") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr1.Fields("t090_3")
'********tag099***********
If Rectagdatapr1.Fields("t099_1") <> " " Or Rectagdatapr1.Fields("t099_2") <> " " Or Rectagdatapr1.Fields("t099_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "090  "
If Rectagdatapr1.Fields("t099_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t099_1")
If Rectagdatapr1.Fields("t099_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t099_2")
If Rectagdatapr1.Fields("t099_3") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr1.Fields("t099_3")
'********tag100***********
If Rectagdatapr1.Fields("t100_1") <> " " Or Rectagdatapr1.Fields("t100_2") <> " " Or Rectagdatapr1.Fields("t100_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "100  "
If Rectagdatapr1.Fields("t100_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t100_1")
If Rectagdatapr1.Fields("t100_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t100_2")
If Rectagdatapr1.Fields("t100_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t100_3")
If Rectagdatapr1.Fields("t100_4") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr1.Fields("t100_4")
If Rectagdatapr1.Fields("t100_5") <> " " Then Text1.Text = Text1.Text & "^q" & Rectagdatapr1.Fields("t100_5")
'********tag110***********
If Rectagdatapr1.Fields("t110_1") <> " " Or Rectagdatapr1.Fields("t110_2") <> " " Or Rectagdatapr1.Fields("t110_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "110  "
If Rectagdatapr1.Fields("t110_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t110_1")
If Rectagdatapr1.Fields("t110_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t110_2")
If Rectagdatapr1.Fields("t110_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t110_3")
If Rectagdatapr1.Fields("t110_4") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr1.Fields("t110_4")
If Rectagdatapr1.Fields("t110_5") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr1.Fields("t110_5")
If Rectagdatapr1.Fields("t110_6") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr1.Fields("t110_6")
'********tag111***********
If Rectagdatapr1.Fields("t111_1") <> " " Or Rectagdatapr1.Fields("t111_2") <> " " Or Rectagdatapr1.Fields("t111_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "111  "
If Rectagdatapr1.Fields("t111_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t111_1")
If Rectagdatapr1.Fields("t111_2") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t111_2")
If Rectagdatapr1.Fields("t111_3") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr1.Fields("t111_3")
If Rectagdatapr1.Fields("t111_4") <> " " Then Text1.Text = Text1.Text & "^e" & Rectagdatapr1.Fields("t111_4")
If Rectagdatapr1.Fields("t111_5") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr1.Fields("t111_5")
If Rectagdatapr1.Fields("t111_6") <> " " Then Text1.Text = Text1.Text & "^q" & Rectagdatapr1.Fields("t111_6")
'********tag130***********
If Rectagdatapr1.Fields("t130_1") <> " " Or Rectagdatapr1.Fields("t130_2") <> " " Or Rectagdatapr1.Fields("t130_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "130  "
If Rectagdatapr1.Fields("t130_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t130_1")
If Rectagdatapr1.Fields("t130_2") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr1.Fields("t130_2")
If Rectagdatapr1.Fields("t130_3") <> " " Then Text1.Text = Text1.Text & "^f" & Rectagdatapr1.Fields("t130_3")
If Rectagdatapr1.Fields("t130_4") <> " " Then Text1.Text = Text1.Text & "^k" & Rectagdatapr1.Fields("t130_4")
If Rectagdatapr1.Fields("t130_5") <> " " Then Text1.Text = Text1.Text & "^l" & Rectagdatapr1.Fields("t130_5")
If Rectagdatapr1.Fields("t130_6") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr1.Fields("t130_6")
If Rectagdatapr1.Fields("t130_7") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr1.Fields("t130_7")
If Rectagdatapr1.Fields("t130_8") <> " " Then Text1.Text = Text1.Text & "^s" & Rectagdatapr1.Fields("t130_8")
'********tag210***********
If Rectagdatapr1.Fields("t210_1") <> " " Or Rectagdatapr1.Fields("t210_2") <> " " Then Text1.Text = Text1.Text & vbCrLf & "210  "
If Rectagdatapr1.Fields("t210_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t210_1")
If Rectagdatapr1.Fields("t210_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t210_2")
'********tag240***********
If Rectagdatapr1.Fields("t240_1") <> " " Or Rectagdatapr1.Fields("t240_2") <> " " Then Text1.Text = Text1.Text & vbCrLf & "240  "
If Rectagdatapr1.Fields("t240_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t240_1")
If Rectagdatapr1.Fields("t240_2") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr1.Fields("t240_2")
If Rectagdatapr1.Fields("t240_3") <> " " Then Text1.Text = Text1.Text & "^f" & Rectagdatapr1.Fields("t240_3")
If Rectagdatapr1.Fields("t240_4") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr1.Fields("t240_4")
If Rectagdatapr1.Fields("t240_5") <> " " Then Text1.Text = Text1.Text & "^k" & Rectagdatapr1.Fields("t240_5")
If Rectagdatapr1.Fields("t240_6") <> " " Then Text1.Text = Text1.Text & "^l" & Rectagdatapr1.Fields("t240_6")
If Rectagdatapr1.Fields("t240_7") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr1.Fields("t240_7")
If Rectagdatapr1.Fields("t240_8") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr1.Fields("t240_8")
If Rectagdatapr1.Fields("t240_9") <> " " Then Text1.Text = Text1.Text & "^s" & Rectagdatapr1.Fields("t240_9")
'********tag242***********
If Rectagdatapr1.Fields("t242_1") <> " " Or Rectagdatapr1.Fields("t242_2") <> " " Then Text1.Text = Text1.Text & vbCrLf & "242  "
If Rectagdatapr1.Fields("t242_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t242_1")
If Rectagdatapr1.Fields("t242_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t242_2")
If Rectagdatapr1.Fields("t242_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t242_3")
If Rectagdatapr1.Fields("t242_4") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr1.Fields("t242_4")
If Rectagdatapr1.Fields("t242_5") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr1.Fields("t242_5")
If Rectagdatapr1.Fields("t242_6") <> " " Then Text1.Text = Text1.Text & "^y" & Rectagdatapr1.Fields("t242_6")
'********tag245***********
If Rectagdatapr1.Fields("t245_1") <> " " Or Rectagdatapr1.Fields("t245_2") <> " " Then Text1.Text = Text1.Text & vbCrLf & "245  "
If Rectagdatapr1.Fields("t245_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t245_1")
If Rectagdatapr1.Fields("t245_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t245_2")
If Rectagdatapr1.Fields("t245_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t245_3")
If Rectagdatapr1.Fields("t245_4") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr1.Fields("t245_4")
If Rectagdatapr1.Fields("t245_5") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr1.Fields("t245_5")
If Rectagdatapr1.Fields("t245_6") <> " " Then Text1.Text = Text1.Text & "^s" & Rectagdatapr1.Fields("t245_6")
'********tag246***********
If Rectagdatapr1.Fields("t246_1") <> " " Or Rectagdatapr1.Fields("t246_2") <> " " Then Text1.Text = Text1.Text & vbCrLf & "246  "
If Rectagdatapr1.Fields("t246_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t246_1")
If Rectagdatapr1.Fields("t246_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t246_2")
If Rectagdatapr1.Fields("t246_3") <> " " Then Text1.Text = Text1.Text & "^f" & Rectagdatapr1.Fields("t246_3")
If Rectagdatapr1.Fields("t246_4") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr1.Fields("t246_4")
If Rectagdatapr1.Fields("t246_5") <> " " Then Text1.Text = Text1.Text & "^h" & Rectagdatapr1.Fields("t246_5")
If Rectagdatapr1.Fields("t246_6") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr1.Fields("t246_6")
If Rectagdatapr1.Fields("t246_7") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr1.Fields("t246_7")
'********tag250***********
If Rectagdatapr1.Fields("t250_1") <> " " Or Rectagdatapr1.Fields("t250_2") <> " " Then Text1.Text = Text1.Text & vbCrLf & "250  "
If Rectagdatapr1.Fields("t250_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t250_1")
If Rectagdatapr1.Fields("t250_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t250_2")
'********tag260***********
If Rectagdatapr1.Fields("t260_1") <> " " Or Rectagdatapr1.Fields("t260_2") <> " " Then Text1.Text = Text1.Text & vbCrLf & "260  "
If Rectagdatapr1.Fields("t260_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t260_1")
If Rectagdatapr1.Fields("t260_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t260_2")
If Rectagdatapr1.Fields("t260_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t260_3")
'***tag300***********
If Rectagdatapr1.Fields("t300_1") <> " " Or Rectagdatapr1.Fields("t300_2") <> " " Or Rectagdatapr1.Fields("t300_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "300  "
If Rectagdatapr1.Fields("t300_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t300_1")
If Rectagdatapr1.Fields("t300_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t300_2")
If Rectagdatapr1.Fields("t300_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t300_3")
If Rectagdatapr1.Fields("t300_4") <> " " Then Text1.Text = Text1.Text & "^e" & Rectagdatapr1.Fields("t300_4")
If Rectagdatapr1.Fields("t300_5") <> " " Then Text1.Text = Text1.Text & "^f" & Rectagdatapr1.Fields("t300_5")
If Rectagdatapr1.Fields("t300_6") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr1.Fields("t300_6")
If Rectagdatapr1.Fields("t300_7") <> " " Then Text1.Text = Text1.Text & "^3" & Rectagdatapr1.Fields("t300_7")
'*******tag440***********
If Rectagdatapr1.Fields("t440_1") <> " " Or Rectagdatapr1.Fields("t440_2") <> " " Or Rectagdatapr1.Fields("t440_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "440  "
If Rectagdatapr1.Fields("t440_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t440_1")
If Rectagdatapr1.Fields("t440_2") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr1.Fields("t440_2")
If Rectagdatapr1.Fields("t440_3") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr1.Fields("t440_3")
If Rectagdatapr1.Fields("t440_4") <> " " Then Text1.Text = Text1.Text & "^v" & Rectagdatapr1.Fields("t440_4")
If Rectagdatapr1.Fields("t440_5") <> " " Then Text1.Text = Text1.Text & "^x" & Rectagdatapr1.Fields("t440_5")
'*******tag490***********
If Rectagdatapr1.Fields("t490_1") <> " " Or Rectagdatapr1.Fields("t490_2") <> " " Then Text1.Text = Text1.Text & vbCrLf & "490  "
If Rectagdatapr1.Fields("t490_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t490_1")
If Rectagdatapr1.Fields("t490_2") <> " " Then Text1.Text = Text1.Text & "^v" & Rectagdatapr1.Fields("t490_2")
'***tag500***********
If Rectagdatapr1.Fields("t500_1") <> " " Then Text1.Text = Text1.Text & vbCrLf & "500  ^a" & Rectagdatapr1.Fields("t500_1")
'***tag501***********
If Rectagdatapr1.Fields("t501_1") <> " " Then Text1.Text = Text1.Text & vbCrLf & "501  ^a" & Rectagdatapr1.Fields("t501_1")
'***tag502***********
If Rectagdatapr1.Fields("t502_1") <> " " Then Text1.Text = Text1.Text & vbCrLf & "502  ^a" & Rectagdatapr1.Fields("t502_1")
'*******tag505***********
If Rectagdatapr1.Fields("t505_1") <> " " Or Rectagdatapr1.Fields("t505_2") <> " " Or Rectagdatapr1.Fields("t505_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "505  "
If Rectagdatapr1.Fields("t505_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t505_1")
If Rectagdatapr1.Fields("t505_2") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr1.Fields("t505_2")
If Rectagdatapr1.Fields("t505_3") <> " " Then Text1.Text = Text1.Text & "^r" & Rectagdatapr1.Fields("t505_3")
'*******tag510***********
If Rectagdatapr1.Fields("t510_1") <> " " Or Rectagdatapr1.Fields("t510_2") <> " " Or Rectagdatapr1.Fields("t510_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "510  "
If Rectagdatapr1.Fields("t510_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t510_1")
If Rectagdatapr1.Fields("t510_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t510_2")
If Rectagdatapr1.Fields("t510_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t510_3")
If Rectagdatapr1.Fields("t510_4") <> " " Then Text1.Text = Text1.Text & "^x" & Rectagdatapr1.Fields("t510_4")
'*******tag520***********
If Rectagdatapr1.Fields("t520_1") <> " " Or Rectagdatapr1.Fields("t520_2") <> " " Or Rectagdatapr1.Fields("t520_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "520  "
If Rectagdatapr1.Fields("t520_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t520_1")
If Rectagdatapr1.Fields("t520_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t520_2")
If Rectagdatapr1.Fields("t520_3") <> " " Then Text1.Text = Text1.Text & "^3" & Rectagdatapr1.Fields("t520_3")
'*******tag536***********
If Rectagdatapr1.Fields("t536_1") <> " " Or Rectagdatapr1.Fields("t536_2") <> " " Or Rectagdatapr1.Fields("t536_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "536  "
If Rectagdatapr1.Fields("t536_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr1.Fields("t536_1")
If Rectagdatapr1.Fields("t536_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr1.Fields("t536_2")
If Rectagdatapr1.Fields("t536_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr1.Fields("t536_3")
If Rectagdatapr1.Fields("t536_4") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr1.Fields("t536_4")
'***tag546***********
If Rectagdatapr1.Fields("t546_1") <> " " Then Text1.Text = Text1.Text & vbCrLf & "546  ^a" & Rectagdatapr1.Fields("t546_1")
'***tag586***********
If Rectagdatapr1.Fields("t586_1") <> " " Then Text1.Text = Text1.Text & vbCrLf & "586  ^a" & Rectagdatapr1.Fields("t586_1")
'********tag600***********
If Rectagdatapr2.Fields("t600_1") <> " " Or Rectagdatapr2.Fields("t600_2") <> " " Or Rectagdatapr2.Fields("t600_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "600  "
If Rectagdatapr2.Fields("t600_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t600_1")
If Rectagdatapr2.Fields("t600_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr2.Fields("t600_2")
If Rectagdatapr2.Fields("t600_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr2.Fields("t600_3")
If Rectagdatapr2.Fields("t600_4") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t600_4")
If Rectagdatapr2.Fields("t600_5") <> " " Then Text1.Text = Text1.Text & "^k" & Rectagdatapr2.Fields("t600_5")
If Rectagdatapr2.Fields("t600_6") <> " " Then Text1.Text = Text1.Text & "^q" & Rectagdatapr2.Fields("t600_6")
If Rectagdatapr2.Fields("t600_7") <> " " Then Text1.Text = Text1.Text & "^t" & Rectagdatapr2.Fields("t600_7")
If Rectagdatapr2.Fields("t600_8") <> " " Then Text1.Text = Text1.Text & "^x" & Rectagdatapr2.Fields("t600_8")
If Rectagdatapr2.Fields("t600_9") <> " " Then Text1.Text = Text1.Text & "^y" & Rectagdatapr2.Fields("t600_9")
If Rectagdatapr2.Fields("t600_10") <> " " Then Text1.Text = Text1.Text & "^z" & Rectagdatapr2.Fields("t600_10")
If Rectagdatapr2.Fields("t600_11") <> " " Then Text1.Text = Text1.Text & "^2" & Rectagdatapr2.Fields("t600_11")
'********tag610***********
If Rectagdatapr2.Fields("t610_1") <> " " Or Rectagdatapr2.Fields("t610_2") <> " " Or Rectagdatapr2.Fields("t610_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "610  "
If Rectagdatapr2.Fields("t610_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t610_1")
If Rectagdatapr2.Fields("t610_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr2.Fields("t610_2")
If Rectagdatapr2.Fields("t610_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr2.Fields("t610_3")
If Rectagdatapr2.Fields("t610_4") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t610_4")
If Rectagdatapr2.Fields("t610_5") <> " " Then Text1.Text = Text1.Text & "^e" & Rectagdatapr2.Fields("t610_5")
If Rectagdatapr2.Fields("t610_6") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr2.Fields("t610_6")
If Rectagdatapr2.Fields("t610_7") <> " " Then Text1.Text = Text1.Text & "^k" & Rectagdatapr2.Fields("t610_7")
If Rectagdatapr2.Fields("t610_8") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t610_8")
If Rectagdatapr2.Fields("t610_9") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr2.Fields("t610_9")
If Rectagdatapr2.Fields("t610_10") <> " " Then Text1.Text = Text1.Text & "^t" & Rectagdatapr2.Fields("t610_10")
If Rectagdatapr2.Fields("t610_11") <> " " Then Text1.Text = Text1.Text & "^x" & Rectagdatapr2.Fields("t610_11")
If Rectagdatapr2.Fields("t610_12") <> " " Then Text1.Text = Text1.Text & "^y" & Rectagdatapr2.Fields("t610_12")
If Rectagdatapr2.Fields("t610_13") <> " " Then Text1.Text = Text1.Text & "^z" & Rectagdatapr2.Fields("t610_13")
If Rectagdatapr2.Fields("t610_14") <> " " Then Text1.Text = Text1.Text & "^2" & Rectagdatapr2.Fields("t610_14")
'********tag611***********
If Rectagdatapr2.Fields("t611_1") <> " " Or Rectagdatapr2.Fields("t611_2") <> " " Or Rectagdatapr2.Fields("t611_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "611  "
If Rectagdatapr2.Fields("t611_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t611_1")
If Rectagdatapr2.Fields("t611_2") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr2.Fields("t611_2")
If Rectagdatapr2.Fields("t611_3") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t611_3")
If Rectagdatapr2.Fields("t611_4") <> " " Then Text1.Text = Text1.Text & "^e" & Rectagdatapr2.Fields("t611_4")
If Rectagdatapr2.Fields("t611_5") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr2.Fields("t611_5")
If Rectagdatapr2.Fields("t611_6") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t611_6")
If Rectagdatapr2.Fields("t611_7") <> " " Then Text1.Text = Text1.Text & "^x" & Rectagdatapr2.Fields("t611_7")
If Rectagdatapr2.Fields("t611_8") <> " " Then Text1.Text = Text1.Text & "^y" & Rectagdatapr2.Fields("t611_8")
If Rectagdatapr2.Fields("t611_9") <> " " Then Text1.Text = Text1.Text & "^z" & Rectagdatapr2.Fields("t611_9")
If Rectagdatapr2.Fields("t611_10") <> " " Then Text1.Text = Text1.Text & "^2" & Rectagdatapr2.Fields("t611_10")
'********tag630***********
If Rectagdatapr2.Fields("t630_1") <> " " Or Rectagdatapr2.Fields("t630_2") <> " " Or Rectagdatapr2.Fields("t630_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "630  "
If Rectagdatapr2.Fields("t630_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t630_1")
If Rectagdatapr2.Fields("t630_2") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t630_2")
If Rectagdatapr2.Fields("t630_3") <> " " Then Text1.Text = Text1.Text & "^f" & Rectagdatapr2.Fields("t630_3")
If Rectagdatapr2.Fields("t630_4") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr2.Fields("t630_4")
If Rectagdatapr2.Fields("t630_5") <> " " Then Text1.Text = Text1.Text & "^k" & Rectagdatapr2.Fields("t630_5")
If Rectagdatapr2.Fields("t630_6") <> " " Then Text1.Text = Text1.Text & "^l" & Rectagdatapr2.Fields("t630_6")
If Rectagdatapr2.Fields("t630_7") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t630_7")
If Rectagdatapr2.Fields("t630_8") <> " " Then Text1.Text = Text1.Text & "^o" & Rectagdatapr2.Fields("t630_8")
If Rectagdatapr2.Fields("t630_9") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr2.Fields("t630_9")
If Rectagdatapr2.Fields("t630_10") <> " " Then Text1.Text = Text1.Text & "^r" & Rectagdatapr2.Fields("t630_10")
If Rectagdatapr2.Fields("t630_11") <> " " Then Text1.Text = Text1.Text & "^s" & Rectagdatapr2.Fields("t630_11")
If Rectagdatapr2.Fields("t630_12") <> " " Then Text1.Text = Text1.Text & "^t" & Rectagdatapr2.Fields("t630_12")
If Rectagdatapr2.Fields("t630_13") <> " " Then Text1.Text = Text1.Text & "^x" & Rectagdatapr2.Fields("t630_13")
If Rectagdatapr2.Fields("t630_14") <> " " Then Text1.Text = Text1.Text & "^y" & Rectagdatapr2.Fields("t630_14")
If Rectagdatapr2.Fields("t630_15") <> " " Then Text1.Text = Text1.Text & "^z" & Rectagdatapr2.Fields("t630_15")
If Rectagdatapr2.Fields("t630_16") <> " " Then Text1.Text = Text1.Text & "^2" & Rectagdatapr2.Fields("t630_16")
'********tag650***********
If Rectagdatapr2.Fields("t650_1") <> " " Or Rectagdatapr2.Fields("t650_2") <> " " Or Rectagdatapr2.Fields("t650_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "650  "
If Rectagdatapr2.Fields("t650_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t650_1")
If Rectagdatapr2.Fields("t650_2") <> " " Then Text1.Text = Text1.Text & "^x" & Rectagdatapr2.Fields("t650_2")
If Rectagdatapr2.Fields("t650_3") <> " " Then Text1.Text = Text1.Text & "^y" & Rectagdatapr2.Fields("t650_3")
If Rectagdatapr2.Fields("t650_4") <> " " Then Text1.Text = Text1.Text & "^z" & Rectagdatapr2.Fields("t650_4")
If Rectagdatapr2.Fields("t650_5") <> " " Then Text1.Text = Text1.Text & "^2" & Rectagdatapr2.Fields("t650_5")
'********tag651***********
If Rectagdatapr2.Fields("t651_1") <> " " Or Rectagdatapr2.Fields("t651_2") <> " " Or Rectagdatapr2.Fields("t651_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "651  "
If Rectagdatapr2.Fields("t651_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t651_1")
If Rectagdatapr2.Fields("t651_2") <> " " Then Text1.Text = Text1.Text & "^x" & Rectagdatapr2.Fields("t651_2")
If Rectagdatapr2.Fields("t651_3") <> " " Then Text1.Text = Text1.Text & "^y" & Rectagdatapr2.Fields("t651_3")
If Rectagdatapr2.Fields("t651_4") <> " " Then Text1.Text = Text1.Text & "^z" & Rectagdatapr2.Fields("t651_4")
If Rectagdatapr2.Fields("t651_5") <> " " Then Text1.Text = Text1.Text & "^2" & Rectagdatapr2.Fields("t651_5")
'********tag700***********
If Rectagdatapr2.Fields("t700_1") <> " " Or Rectagdatapr2.Fields("t700_2") <> " " Or Rectagdatapr2.Fields("t700_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "700  "
If Rectagdatapr2.Fields("t700_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t700_1")
If Rectagdatapr2.Fields("t700_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr2.Fields("t700_2")
If Rectagdatapr2.Fields("t700_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr2.Fields("t700_3")
If Rectagdatapr2.Fields("t700_4") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t700_4")
If Rectagdatapr2.Fields("t700_5") <> " " Then Text1.Text = Text1.Text & "^e" & Rectagdatapr2.Fields("t700_5")
If Rectagdatapr2.Fields("t700_6") <> " " Then Text1.Text = Text1.Text & "^q" & Rectagdatapr2.Fields("t700_6")
'********tag710***********
If Rectagdatapr2.Fields("t710_1") <> " " Or Rectagdatapr2.Fields("t710_2") <> " " Or Rectagdatapr2.Fields("t710_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "710  "
If Rectagdatapr2.Fields("t710_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t710_1")
If Rectagdatapr2.Fields("t710_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr2.Fields("t710_2")
If Rectagdatapr2.Fields("t710_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr2.Fields("t710_3")
If Rectagdatapr2.Fields("t710_4") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t710_4")
If Rectagdatapr2.Fields("t710_5") <> " " Then Text1.Text = Text1.Text & "^e" & Rectagdatapr2.Fields("t710_5")
If Rectagdatapr2.Fields("t710_6") <> " " Then Text1.Text = Text1.Text & "^f" & Rectagdatapr2.Fields("t710_6")
If Rectagdatapr2.Fields("t710_7") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr2.Fields("t710_7")
If Rectagdatapr2.Fields("t710_8") <> " " Then Text1.Text = Text1.Text & "^k" & Rectagdatapr2.Fields("t710_8")
If Rectagdatapr2.Fields("t710_9") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t710_9")
If Rectagdatapr2.Fields("t710_10") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr2.Fields("t710_10")
If Rectagdatapr2.Fields("t710_11") <> " " Then Text1.Text = Text1.Text & "^s" & Rectagdatapr2.Fields("t710_11")
If Rectagdatapr2.Fields("t710_12") <> " " Then Text1.Text = Text1.Text & "^t" & Rectagdatapr2.Fields("t710_12")
'********tag711***********
If Rectagdatapr2.Fields("t711_1") <> " " Or Rectagdatapr2.Fields("t711_2") <> " " Or Rectagdatapr2.Fields("t711_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "711  "
If Rectagdatapr2.Fields("t711_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t711_1")
If Rectagdatapr2.Fields("t711_2") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr2.Fields("t711_2")
If Rectagdatapr2.Fields("t711_3") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t711_3")
If Rectagdatapr2.Fields("t711_4") <> " " Then Text1.Text = Text1.Text & "^e" & Rectagdatapr2.Fields("t711_4")
If Rectagdatapr2.Fields("t711_5") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr2.Fields("t711_5")
If Rectagdatapr2.Fields("t711_6") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t711_6")
If Rectagdatapr2.Fields("t711_7") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr2.Fields("t711_7")
If Rectagdatapr2.Fields("t711_8") <> " " Then Text1.Text = Text1.Text & "^t" & Rectagdatapr2.Fields("t711_8")
'********tag730***********
If Rectagdatapr2.Fields("t730_1") <> " " Or Rectagdatapr2.Fields("t730_2") <> " " Or Rectagdatapr2.Fields("t730_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "730  "
If Rectagdatapr2.Fields("t730_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t730_1")
If Rectagdatapr2.Fields("t730_2") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t730_2")
If Rectagdatapr2.Fields("t730_3") <> " " Then Text1.Text = Text1.Text & "^f" & Rectagdatapr2.Fields("t730_3")
If Rectagdatapr2.Fields("t730_4") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr2.Fields("t730_4")
If Rectagdatapr2.Fields("t730_5") <> " " Then Text1.Text = Text1.Text & "^k" & Rectagdatapr2.Fields("t730_5")
If Rectagdatapr2.Fields("t730_6") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t730_6")
If Rectagdatapr2.Fields("t730_7") <> " " Then Text1.Text = Text1.Text & "^l" & Rectagdatapr2.Fields("t730_7")
If Rectagdatapr2.Fields("t730_8") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr2.Fields("t730_8")
If Rectagdatapr2.Fields("t730_9") <> " " Then Text1.Text = Text1.Text & "^s" & Rectagdatapr2.Fields("t730_9")
If Rectagdatapr2.Fields("t730_10") <> " " Then Text1.Text = Text1.Text & "^t" & Rectagdatapr2.Fields("t730_10")
'********tag740***********
If Rectagdatapr2.Fields("t740_1") <> " " Or Rectagdatapr2.Fields("t740_2") <> " " Or Rectagdatapr2.Fields("t740_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "740  "
If Rectagdatapr2.Fields("t740_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t740_1")
If Rectagdatapr2.Fields("t740_2") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t740_2")
If Rectagdatapr2.Fields("t740_3") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr2.Fields("t740_3")
'********tag800***********
If Rectagdatapr2.Fields("t800_1") <> " " Or Rectagdatapr2.Fields("t800_2") <> " " Or Rectagdatapr2.Fields("t800_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "800  "
If Rectagdatapr2.Fields("t800_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t800_1")
If Rectagdatapr2.Fields("t800_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr2.Fields("t800_2")
If Rectagdatapr2.Fields("t800_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr2.Fields("t800_3")
If Rectagdatapr2.Fields("t800_4") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t800_4")
If Rectagdatapr2.Fields("t800_5") <> " " Then Text1.Text = Text1.Text & "^q" & Rectagdatapr2.Fields("t800_5")
If Rectagdatapr2.Fields("t800_6") <> " " Then Text1.Text = Text1.Text & "^t" & Rectagdatapr2.Fields("t800_6")
If Rectagdatapr2.Fields("t800_7") <> " " Then Text1.Text = Text1.Text & "^v" & Rectagdatapr2.Fields("t800_7")
'********tag810***********
If Rectagdatapr2.Fields("t810_1") <> " " Or Rectagdatapr2.Fields("t810_2") <> " " Or Rectagdatapr2.Fields("t810_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "810  "
If Rectagdatapr2.Fields("t810_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t810_1")
If Rectagdatapr2.Fields("t810_2") <> " " Then Text1.Text = Text1.Text & "^b" & Rectagdatapr2.Fields("t810_2")
If Rectagdatapr2.Fields("t810_3") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr2.Fields("t810_3")
If Rectagdatapr2.Fields("t810_4") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t810_4")
If Rectagdatapr2.Fields("t810_5") <> " " Then Text1.Text = Text1.Text & "^e" & Rectagdatapr2.Fields("t810_5")
If Rectagdatapr2.Fields("t810_6") <> " " Then Text1.Text = Text1.Text & "^k" & Rectagdatapr2.Fields("t810_6")
If Rectagdatapr2.Fields("t810_7") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t810_7")
If Rectagdatapr2.Fields("t810_8") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr2.Fields("t810_8")
If Rectagdatapr2.Fields("t810_9") <> " " Then Text1.Text = Text1.Text & "^t" & Rectagdatapr2.Fields("t810_9")
If Rectagdatapr2.Fields("t810_10") <> " " Then Text1.Text = Text1.Text & "^v" & Rectagdatapr2.Fields("t810_10")
'********tag811***********
If Rectagdatapr2.Fields("t811_1") <> " " Or Rectagdatapr2.Fields("t811_2") <> " " Or Rectagdatapr2.Fields("t811_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "811  "
If Rectagdatapr2.Fields("t811_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t811_1")
If Rectagdatapr2.Fields("t811_2") <> " " Then Text1.Text = Text1.Text & "^c" & Rectagdatapr2.Fields("t811_2")
If Rectagdatapr2.Fields("t811_3") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t811_3")
If Rectagdatapr2.Fields("t811_4") <> " " Then Text1.Text = Text1.Text & "^e" & Rectagdatapr2.Fields("t811_4")
If Rectagdatapr2.Fields("t811_5") <> " " Then Text1.Text = Text1.Text & "^g" & Rectagdatapr2.Fields("t811_5")
If Rectagdatapr2.Fields("t811_6") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t811_6")
If Rectagdatapr2.Fields("t811_7") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr2.Fields("t811_7")
If Rectagdatapr2.Fields("t811_8") <> " " Then Text1.Text = Text1.Text & "^q" & Rectagdatapr2.Fields("t811_8")
If Rectagdatapr2.Fields("t811_9") <> " " Then Text1.Text = Text1.Text & "^t" & Rectagdatapr2.Fields("t811_9")
If Rectagdatapr2.Fields("t811_10") <> " " Then Text1.Text = Text1.Text & "^v" & Rectagdatapr2.Fields("t811_10")
'********tag830***********
If Rectagdatapr2.Fields("t830_1") <> " " Or Rectagdatapr2.Fields("t830_2") <> " " Or Rectagdatapr2.Fields("t830_3") <> " " Then Text1.Text = Text1.Text & vbCrLf & "830  "
If Rectagdatapr2.Fields("t830_1") <> " " Then Text1.Text = Text1.Text & "^a" & Rectagdatapr2.Fields("t830_1")
If Rectagdatapr2.Fields("t830_2") <> " " Then Text1.Text = Text1.Text & "^d" & Rectagdatapr2.Fields("t830_2")
If Rectagdatapr2.Fields("t830_3") <> " " Then Text1.Text = Text1.Text & "^f" & Rectagdatapr2.Fields("t830_3")
If Rectagdatapr2.Fields("t830_4") <> " " Then Text1.Text = Text1.Text & "^k" & Rectagdatapr2.Fields("t830_4")
If Rectagdatapr2.Fields("t830_5") <> " " Then Text1.Text = Text1.Text & "^l" & Rectagdatapr2.Fields("t830_5")
If Rectagdatapr2.Fields("t830_6") <> " " Then Text1.Text = Text1.Text & "^n" & Rectagdatapr2.Fields("t830_6")
If Rectagdatapr2.Fields("t830_7") <> " " Then Text1.Text = Text1.Text & "^p" & Rectagdatapr2.Fields("t830_7")
If Rectagdatapr2.Fields("t830_8") <> " " Then Text1.Text = Text1.Text & "^s" & Rectagdatapr2.Fields("t830_8")
If Rectagdatapr2.Fields("t830_9") <> " " Then Text1.Text = Text1.Text & "^v" & Rectagdatapr2.Fields("t830_9")
'***tag850***********
If Rectagdatapr2.Fields("t850_1") <> " " Then Text1.Text = Text1.Text & vbCrLf & "850  ^a" & Rectagdatapr2.Fields("t850_1")
'********************
End Sub

Private Sub Form_Load()
Set marcwspr = DBEngine.Workspaces(0)
Set marcdbpr = marcwspr.OpenDatabase("marcsheetdb", False, False)
'Openrecordset for select from combo box
Set idsnappr = marcdbpr.OpenRecordset("Select t020_1 from tagdata1 Order by t020_1", dbOpenSnapshot)
'checking for null database
If idsnappr.EOF Then
   MsgBox ("ไม่มีข้อมูลบนฐานข้อมูลแล้ว")
   cmbIDpr.Clear
Else
'Add item in the combo box
idsnappr.MoveFirst
cmbIDpr.Clear
Do While Not idsnappr.EOF
  cmbIDpr.AddItem (idsnappr.Fields("t020_1"))
   idsnappr.MoveNext
Loop
End If
End Sub

