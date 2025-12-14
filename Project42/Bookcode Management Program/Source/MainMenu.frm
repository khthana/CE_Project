VERSION 5.00
Begin VB.Form mainmenu 
   BackColor       =   &H0080FFFF&
   ClientHeight    =   8880
   ClientLeft      =   60
   ClientTop       =   60
   ClientWidth     =   11880
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   ScaleHeight     =   8880
   ScaleWidth      =   11880
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.Frame Frame1 
      BackColor       =   &H0080FFFF&
      Caption         =   "MARC SHEET PROGRAM"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF00FF&
      Height          =   8535
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   11415
      Begin VB.CommandButton Command5 
         Caption         =   "จบการทำงานของโปรแกรม"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Index           =   1
         Left            =   3120
         TabIndex        =   6
         Top             =   7080
         Width           =   5295
      End
      Begin VB.CommandButton Command6 
         Caption         =   "จัดพิมพ์ MARC SHEET"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   3120
         TabIndex        =   5
         Top             =   5880
         Width           =   5295
      End
      Begin VB.CommandButton Command4 
         Caption         =   "ค้นหา MARC SHEET"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   3120
         TabIndex        =   4
         Top             =   4680
         Width           =   5295
      End
      Begin VB.CommandButton Command3 
         Caption         =   "ลบ MARC SHEET"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   3120
         TabIndex        =   3
         Top             =   3480
         Width           =   5295
      End
      Begin VB.CommandButton Command2 
         Caption         =   "แก้ไข MARC SHEET"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   3120
         TabIndex        =   2
         Top             =   2280
         Width           =   5295
      End
      Begin VB.CommandButton Command1 
         Caption         =   "สร้าง MARC SHEET ใหม่"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Index           =   0
         Left            =   3120
         TabIndex        =   1
         Top             =   1080
         Width           =   5295
      End
   End
End
Attribute VB_Name = "mainmenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public marcws As Workspace
Public marcdb As Database
Public sqlcommand As String
Public editkey As String
Public editstatus As Boolean
Private Sub Command1_Click(Index As Integer)
editstatus = False
tagselect.Show
tag008.Show
End Sub

Private Sub Command2_Click()
editform.Show
End Sub

Private Sub Command3_Click()
deleteform.Show
End Sub

Private Sub Command4_Click()
searchform.Show
End Sub

Private Sub Command5_Click(Index As Integer)
Unload Me
End Sub


Public Sub quitting()
mainmenu.Visible = False
If MsgBox("ออกจากโปรแกรม ?", vbOKCancel) = vbOK Then
Unload tag008
Unload tag020
Unload tag090
Unload tag100
Unload tag210
Unload tag250
Unload tag500
Unload tag600
Unload tag700
Unload tag800
Unload tagselect
mainmenu.Visible = True
Else
End If
End Sub

Private Sub Command6_Click()
printing.Show
End Sub

Private Sub Form_Load()
On Error GoTo HandleError
Set marcws = DBEngine.Workspaces(0)
Set marcdb = marcws.OpenDatabase("marcsheetdb.mdb", False, False)
Exit Sub
HandleError:
MsgBox Error(Err.Number)
End Sub
Public Sub saving()
'***************TABLE Tagdata1*****************
'++++++++++++++FIELDS++++++++++++++++++++
If editstatus = False Then
 '****************TAG008**********************
sqlcommand = "INSERT INTO TagData1 (t008_1,t008_2,t008_3,t008_4,t008_5,t008_6,t008_7,t008_8,t008_9,t008_10,t008_11,t008_12,t008_13,t008_14,t008_15,t008_16,t008_17,t008_18,t008_19,t008_20,t008_21,t008_22,t008_23,t008_24,t008_25,"
'****************TAG020**********************
sqlcommand = sqlcommand & "t020_1,t020_2,t020_3,"
'****************TAG022**********************
sqlcommand = sqlcommand & "t022_1,t022_2,t022_3,"
'****************TAG090**********************
sqlcommand = sqlcommand & "t090_1,t090_2,t090_3,"
'****************TAG099**********************
sqlcommand = sqlcommand & "t099_1,t099_2,t099_3,"
'****************TAG100**********************
sqlcommand = sqlcommand & "t100_1,t100_2,t100_3,t100_4,t100_5,"
'****************TAG110**********************
sqlcommand = sqlcommand & "t110_1,t110_2,t110_3,t110_4,t110_5,t110_6,"
'****************TAG111**********************
sqlcommand = sqlcommand & "t111_1,t111_2,t111_3,t111_4,t111_5,t111_6,"
'****************TAG130**********************
sqlcommand = sqlcommand & "t130_1,t130_2,t130_3,t130_4,t130_5,t130_6,t130_7,t130_8,"
'****************TAG210**********************
sqlcommand = sqlcommand & "t210_1,t210_2 ,"
'****************TAG240**********************
sqlcommand = sqlcommand & "t240_1,t240_2,t240_3,t240_4,t240_5,t240_6,t240_7,t240_8,t240_9,"
'****************TAG242**********************
sqlcommand = sqlcommand & "t242_1,t242_2,t242_3,t242_4,t242_5,t242_6,"
'****************TAG245**********************
sqlcommand = sqlcommand & "t245_1,t245_2,t245_3,t245_4,t245_5,t245_6,"
'****************TAG246**********************
sqlcommand = sqlcommand & "t246_1,t246_2,t246_3,t246_4,t246_5,t246_6,t246_7,"
'****************TAG250**********************
sqlcommand = sqlcommand & "t250_1,t250_2,"
'****************TAG260**********************
sqlcommand = sqlcommand & "t260_1,t260_2,t260_3,"
'****************TAG300**********************
sqlcommand = sqlcommand & "t300_1,t300_2,t300_3,t300_4,t300_5,t300_6,t300_7,"
'****************TAG440**********************
sqlcommand = sqlcommand & "t440_1,t440_2,t440_3,t440_4,t440_5,"
'****************TAG490**********************
sqlcommand = sqlcommand & "t490_1,t490_2,"
'****************TAG500**********************
sqlcommand = sqlcommand & "t500_1,"
'****************TAG510**********************
sqlcommand = sqlcommand & "t501_1,"
'****************TAG502**********************
sqlcommand = sqlcommand & "t502_1,"
'****************TAG505**********************
sqlcommand = sqlcommand & "t505_1,t505_2,t505_3,"
'****************TAG510**********************
sqlcommand = sqlcommand & "t510_1,t510_2,t510_3,t510_4,"
'****************TAG520**********************
sqlcommand = sqlcommand & "t520_1,t520_2,t520_3,"
'****************TAG536**********************
sqlcommand = sqlcommand & "t536_1,t536_2,t536_3,t536_4,"
'****************TAG546**********************
sqlcommand = sqlcommand & "t546_1,"
'****************TAG586**********************
sqlcommand = sqlcommand & "t586_1)"

'+++++++++++++++DATA+++++++++++++++++++++
'****************TAG008**********************
sqlcommand = sqlcommand & " VALUES ("
sqlcommand = sqlcommand & "'" & tag008.tag008_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_9.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_10.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_11.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_12.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_13.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_14.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_15.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_16.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_17.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_18.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_19.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_20.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_21.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_22.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_23.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_24.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag008.tag008_25.Text & " '" & ","
'****************TAG020**********************
sqlcommand = sqlcommand & "'" & tag020.tag020_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag020.tag020_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag020.tag020_3.Text & " '" & ","
'****************TAG022**********************
sqlcommand = sqlcommand & "'" & tag020.tag022_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag020.tag022_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag020.tag022_3.Text & " '" & ","
'****************TAG090**********************
sqlcommand = sqlcommand & "'" & tag090.tag090_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag090.tag090_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag090.tag090_3.Text & " '" & ","
'****************TAG099**********************
sqlcommand = sqlcommand & "'" & tag090.tag099_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag090.tag099_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag090.tag099_3.Text & " '" & ","
'****************TAG100**********************
sqlcommand = sqlcommand & "'" & tag100.tag100_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag100_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag100_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag100_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag100_5.Text & " '" & ","
'****************TAG110**********************
sqlcommand = sqlcommand & "'" & tag100.tag110_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag110_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag110_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag110_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag110_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag110_6.Text & " '" & ","
'****************TAG111**********************
sqlcommand = sqlcommand & "'" & tag100.tag111_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag111_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag111_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag111_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag111_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag111_6.Text & " '" & ","
'****************TAG130**********************
sqlcommand = sqlcommand & "'" & tag100.tag130_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag130_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag130_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag130_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag130_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag130_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag130_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag100.tag130_8.Text & " '" & ","
'****************TAG210**********************
sqlcommand = sqlcommand & "'" & tag210.tag210_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag210_2.Text & " '" & ","
'****************TAG240**********************
sqlcommand = sqlcommand & "'" & tag210.tag240_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag240_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag240_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag240_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag240_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag240_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag240_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag240_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag240_9.Text & " '" & ","
'****************TAG242**********************
sqlcommand = sqlcommand & "'" & tag210.tag242_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag242_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag242_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag242_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag242_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag242_6.Text & " '" & ","
'****************TAG245**********************
sqlcommand = sqlcommand & "'" & tag210.tag245_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag245_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag245_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag245_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag245_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag245_6.Text & " '" & ","
'****************TAG246**********************
sqlcommand = sqlcommand & "'" & tag210.tag246_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag246_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag246_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag246_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag246_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag246_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag210.tag246_7.Text & " '" & ","
'****************TAG250**********************
sqlcommand = sqlcommand & "'" & tag250.tag250_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag250_2.Text & " '" & ","
'****************TAG260**********************
sqlcommand = sqlcommand & "'" & tag250.tag260_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag260_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag260_3.Text & " '" & ","
'****************TAG300**********************
sqlcommand = sqlcommand & "'" & tag250.tag300_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag300_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag300_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag300_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag300_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag300_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag300_7.Text & " '" & ","
'****************TAG440**********************
sqlcommand = sqlcommand & "'" & tag250.tag440_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag440_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag440_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag440_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag440_5.Text & " '" & ","
'****************TAG490**********************
sqlcommand = sqlcommand & "'" & tag250.tag490_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag250.tag490_2.Text & " '" & ","
'****************TAG500**********************
sqlcommand = sqlcommand & "'" & tag500.tag500_1.Text & " '" & ","
'****************TAG501**********************
sqlcommand = sqlcommand & "'" & tag500.tag501_1.Text & " '" & ","
'****************TAG502**********************
sqlcommand = sqlcommand & "'" & tag500.tag502_1.Text & " '" & ","
'****************TAG505**********************
sqlcommand = sqlcommand & "'" & tag500.tag505_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag505_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag505_3.Text & " '" & ","
'***************TAG510**********************
sqlcommand = sqlcommand & "'" & tag500.tag510_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag510_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag510_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag510_4.Text & " '" & ","
'***************TAG520**********************
sqlcommand = sqlcommand & "'" & tag500.tag520_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag520_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag520_3.Text & " '" & ","
'***************TAG536**********************
sqlcommand = sqlcommand & "'" & tag500.tag536_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag536_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag536_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag500.tag536_4.Text & " '" & ","
'****************TAG546**********************
sqlcommand = sqlcommand & "'" & tag500.tag546_1.Text & " '" & ","
'****************TAG586**********************
sqlcommand = sqlcommand & "'" & tag500.tag586_1.Text & " '"
sqlcommand = sqlcommand & ")"
marcdb.Execute sqlcommand
'***********************TABLE  Tagdata2**********************
'++++++++++++++FIELDS++++++++++++++++++++
'****************primarykey is t020_1************************
sqlcommand = "INSERT INTO TagData2 (t020_1,"
'****************tag 600************************
sqlcommand = sqlcommand & "t600_1 , t600_2, t600_3, t600_4, t600_5, t600_6, t600_7, t600_8, t600_9, t600_10, t600_11, "
'****************tag 610************************
sqlcommand = sqlcommand & "t610_1,t610_2,t610_3,t610_4,t610_5,t610_6,t610_7,t610_8,t610_9,t610_10,t610_11,t610_12,t610_13,t610_14,"
'****************tag 611************************
sqlcommand = sqlcommand & "t611_1,t611_2,t611_3,t611_4,t611_5,t611_6,t611_7,t611_8,t611_9,t611_10,"
'****************tag 630************************
sqlcommand = sqlcommand & "t630_1,t630_2,t630_3,t630_4,t630_5,t630_6,t630_7,t630_8,t630_9,t630_10,t630_11,t630_12,t630_13,t630_14,t630_15,t630_16,"
'****************tag 650************************
sqlcommand = sqlcommand & "t650_1,t650_2,t650_3,t650_4,t650_5,"
'****************tag 651************************
sqlcommand = sqlcommand & "t651_1,t651_2,t651_3,t651_4,t651_5,"
'****************tag 700************************
sqlcommand = sqlcommand & "t700_1,t700_2,t700_3,t700_4,t700_5,t700_6,"
'****************tag 710************************
sqlcommand = sqlcommand & "t710_1,t710_2,t710_3,t710_4,t710_5,t710_6,t710_7,t710_8,t710_9,t710_10,t710_11,t710_12,"
'****************tag 711************************
sqlcommand = sqlcommand & "t711_1,t711_2,t711_3,t711_4,t711_5,t711_6,t711_7,t711_8,"
'****************tag 730************************
sqlcommand = sqlcommand & "t730_1,t730_2,t730_3,t730_4,t730_5,t730_6,t730_7,t730_8,t730_9,t730_10,"
'****************tag 740************************
sqlcommand = sqlcommand & "t740_1,t740_2,t740_3,"
'****************tag 800************************
sqlcommand = sqlcommand & "t800_1,t800_2,t800_3,t800_4,t800_5,t800_6,t800_7,"
'****************tag 810************************
sqlcommand = sqlcommand & "t810_1,t810_2,t810_3,t810_4,t810_5,t810_6,t810_7,t810_8,t810_9,t810_10,"
'****************tag 811************************
sqlcommand = sqlcommand & "t811_1,t811_2,t811_3,t811_4,t811_5,t811_6,t811_7,t811_8,t811_9,t811_10,"
'****************tag 830************************
sqlcommand = sqlcommand & "t830_1,t830_2,t830_3,t830_4,t830_5,t830_6,t830_7,t830_8,t830_9,"
'****************tag 850************************
sqlcommand = sqlcommand & "t850_1)"
'++++++++++++++++FIELDS+++++++++++++++++++++
'******************primary key is t020_1**************************
sqlcommand = sqlcommand & " VALUES ("
sqlcommand = sqlcommand & "'" & tag020.tag020_1.Text & " '" & ","
'******************tag 600**************************
sqlcommand = sqlcommand & "'" & tag600.tag600_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_9.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_10.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag600_11.Text & " '" & ","
'******************tag 610**************************
sqlcommand = sqlcommand & "'" & tag600.tag610_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_9.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_10.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_11.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_12.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_13.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag610_14.Text & " '" & ","
'******************tag 611**************************
sqlcommand = sqlcommand & "'" & tag600.tag611_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag611_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag611_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag611_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag611_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag611_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag611_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag611_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag611_9.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag611_10.Text & " '" & ","
'******************tag 630**************************
sqlcommand = sqlcommand & "'" & tag600.tag630_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_9.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_10.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_11.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_12.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_13.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_14.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_15.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag630_16.Text & " '" & ","
'******************tag 650**************************
sqlcommand = sqlcommand & "'" & tag600.tag650_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag650_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag650_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag650_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag650_5.Text & " '" & ","
'******************tag 651**************************
sqlcommand = sqlcommand & "'" & tag600.tag651_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag651_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag651_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag651_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag600.tag651_5.Text & " '" & ","
'******************tag 700**************************
sqlcommand = sqlcommand & "'" & tag700.tag700_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag700_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag700_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag700_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag700_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag700_6.Text & " '" & ","
'******************tag 710**************************
sqlcommand = sqlcommand & "'" & tag700.tag710_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_9.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_10.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_11.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag710_12.Text & " '" & ","
'******************tag 711**************************
sqlcommand = sqlcommand & "'" & tag700.tag711_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag711_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag711_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag711_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag711_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag711_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag711_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag711_8.Text & " '" & ","
'******************tag 730**************************
sqlcommand = sqlcommand & "'" & tag700.tag730_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag730_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag730_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag730_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag730_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag730_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag730_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag730_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag730_9.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag730_10.Text & " '" & ","
'******************tag 740**************************
sqlcommand = sqlcommand & "'" & tag700.tag740_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag740_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag700.tag740_3.Text & " '" & ","
'******************tag 800**************************
sqlcommand = sqlcommand & "'" & tag800.tag800_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag800_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag800_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag800_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag800_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag800_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag800_7.Text & " '" & ","
'******************tag 810**************************
sqlcommand = sqlcommand & "'" & tag800.tag810_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag810_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag810_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag810_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag810_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag810_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag810_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag810_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag810_9.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag810_10.Text & " '" & ","
'******************tag 811**************************
sqlcommand = sqlcommand & "'" & tag800.tag811_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag811_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag811_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag811_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag811_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag811_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag811_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag811_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag811_9.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag811_10.Text & " '" & ","
'******************tag 830**************************
sqlcommand = sqlcommand & "'" & tag800.tag830_1.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag830_2.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag830_3.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag830_4.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag830_5.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag830_6.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag830_7.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag830_8.Text & " '" & ","
sqlcommand = sqlcommand & "'" & tag800.tag830_9.Text & " '" & ","
'******************tag 850**************************
sqlcommand = sqlcommand & "'" & tag800.tag850_1.Text & " '"
'*****************************
sqlcommand = sqlcommand & ")"
marcdb.Execute sqlcommand
'*********************************************
'************Begin Update process****************
Else
 sqlcommand = "UPDATE  tagdata1 SET  "
 '*****************tag008*****************
 sqlcommand = sqlcommand & "t008_1='" & tag008.tag008_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_2='" & tag008.tag008_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_3='" & tag008.tag008_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_4='" & tag008.tag008_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_5='" & tag008.tag008_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_6='" & tag008.tag008_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_7='" & tag008.tag008_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_8='" & tag008.tag008_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_9='" & tag008.tag008_9.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_11='" & tag008.tag008_11.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_12='" & tag008.tag008_12.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_13='" & tag008.tag008_13.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_14='" & tag008.tag008_14.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_15='" & tag008.tag008_15.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_16='" & tag008.tag008_16.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_17='" & tag008.tag008_17.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_18='" & tag008.tag008_18.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_19='" & tag008.tag008_19.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_20='" & tag008.tag008_20.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_21='" & tag008.tag008_21.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_22='" & tag008.tag008_22.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_23='" & tag008.tag008_23.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_24='" & tag008.tag008_24.Text & "'" & ","
 sqlcommand = sqlcommand & "t008_25='" & tag008.tag008_25.Text & "'" & ","
 '*****************tag020*****************
 sqlcommand = sqlcommand & "t020_1='" & tag020.tag020_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t020_2='" & tag020.tag020_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t020_3='" & tag020.tag020_3.Text & "'" & ","
 '==================
 sqlcommand = sqlcommand & "t022_1='" & tag020.tag022_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t022_2='" & tag020.tag022_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t022_3='" & tag020.tag022_3.Text & "'" & ","
 '*****************tag090*****************
 sqlcommand = sqlcommand & "t090_1='" & tag090.tag090_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t090_2='" & tag090.tag090_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t090_3='" & tag090.tag090_3.Text & "'" & ","
 '=================
 sqlcommand = sqlcommand & "t099_1='" & tag090.tag099_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t099_2='" & tag090.tag099_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t099_3='" & tag090.tag099_3.Text & "'" & ","
 '*****************tag100*****************
 sqlcommand = sqlcommand & "t100_1='" & tag100.tag100_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t100_2='" & tag100.tag100_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t100_3='" & tag100.tag100_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t100_4='" & tag100.tag100_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t100_5='" & tag100.tag100_5.Text & "'" & ","
 '================
 sqlcommand = sqlcommand & "t110_1='" & tag100.tag110_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t110_2='" & tag100.tag110_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t110_3='" & tag100.tag110_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t110_4='" & tag100.tag110_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t110_5='" & tag100.tag110_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t110_6='" & tag100.tag110_6.Text & "'" & ","
 '================
  sqlcommand = sqlcommand & "t111_1='" & tag100.tag111_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t111_2='" & tag100.tag111_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t111_3='" & tag100.tag111_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t111_4='" & tag100.tag111_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t111_5='" & tag100.tag111_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t111_6='" & tag100.tag111_6.Text & "'" & ","
  '================
 sqlcommand = sqlcommand & "t130_1='" & tag100.tag130_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t130_2='" & tag100.tag130_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t130_3='" & tag100.tag130_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t130_4='" & tag100.tag130_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t130_5='" & tag100.tag130_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t130_6='" & tag100.tag130_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t130_7='" & tag100.tag130_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t130_8='" & tag100.tag130_8.Text & "'" & ","
  '*****************tag210*****************
 sqlcommand = sqlcommand & "t210_1='" & tag210.tag210_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t210_2='" & tag210.tag210_2.Text & "'" & ","
 '=================
 sqlcommand = sqlcommand & "t240_1='" & tag210.tag240_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t240_2='" & tag210.tag240_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t240_3='" & tag210.tag240_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t240_4='" & tag210.tag240_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t240_5='" & tag210.tag240_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t240_6='" & tag210.tag240_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t240_7='" & tag210.tag240_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t240_8='" & tag210.tag240_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t240_9='" & tag210.tag240_9.Text & "'" & ","
  '=================
 sqlcommand = sqlcommand & "t242_1='" & tag210.tag242_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t242_2='" & tag210.tag242_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t242_3='" & tag210.tag242_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t242_4='" & tag210.tag242_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t242_5='" & tag210.tag242_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t242_6='" & tag210.tag242_6.Text & "'" & ","
 '=================
 sqlcommand = sqlcommand & "t245_1='" & tag210.tag245_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t245_2='" & tag210.tag245_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t245_3='" & tag210.tag245_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t245_4='" & tag210.tag245_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t245_5='" & tag210.tag245_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t245_6='" & tag210.tag245_6.Text & "'" & ","
 '=================
 sqlcommand = sqlcommand & "t246_1='" & tag210.tag246_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t246_2='" & tag210.tag246_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t246_3='" & tag210.tag246_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t246_4='" & tag210.tag246_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t246_5='" & tag210.tag246_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t246_6='" & tag210.tag246_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t246_7='" & tag210.tag246_7.Text & "'" & ","
  '*****************tag250*****************
 sqlcommand = sqlcommand & "t250_1='" & tag250.tag250_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t250_2='" & tag250.tag250_2.Text & "'" & ","
 '================
 sqlcommand = sqlcommand & "t260_1='" & tag250.tag260_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t260_2='" & tag250.tag260_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t260_3='" & tag250.tag260_3.Text & "'" & ","
 '================
 sqlcommand = sqlcommand & "t300_1='" & tag250.tag300_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t300_2='" & tag250.tag300_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t300_3='" & tag250.tag300_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t300_4='" & tag250.tag300_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t300_5='" & tag250.tag300_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t300_6='" & tag250.tag300_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t300_7='" & tag250.tag300_7.Text & "'" & ","
 '================
 sqlcommand = sqlcommand & "t440_1='" & tag250.tag440_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t440_2='" & tag250.tag440_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t440_3='" & tag250.tag440_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t440_4='" & tag250.tag440_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t440_5='" & tag250.tag440_5.Text & "'" & ","
 '================
 sqlcommand = sqlcommand & "t490_1='" & tag250.tag490_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t490_2='" & tag250.tag490_2.Text & "'" & ","
  '*****************tag500*****************
 sqlcommand = sqlcommand & "t500_1='" & tag500.tag500_1.Text & "'" & ","
 '===============
 sqlcommand = sqlcommand & "t501_1='" & tag500.tag501_1.Text & "'" & ","
  '===============
 sqlcommand = sqlcommand & "t502_1='" & tag500.tag502_1.Text & "'" & ","
  '===============
 sqlcommand = sqlcommand & "t505_1='" & tag500.tag505_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t505_2='" & tag500.tag505_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t505_3='" & tag500.tag505_3.Text & "'" & ","
  '===============
 sqlcommand = sqlcommand & "t510_1='" & tag500.tag510_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t510_2='" & tag500.tag510_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t510_3='" & tag500.tag510_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t510_4='" & tag500.tag510_4.Text & "'" & ","
 '===============
 sqlcommand = sqlcommand & "t520_1='" & tag500.tag520_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t520_2='" & tag500.tag520_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t520_3='" & tag500.tag520_3.Text & "'" & ","
 '===============
sqlcommand = sqlcommand & "t536_1='" & tag500.tag536_1.Text & "'"
 '******************where*************************
sqlcommand = sqlcommand & "where t020_1='" & editkey & "'"
marcdb.Execute sqlcommand
'*******Next update continue because it can update max 103 fields****************
sqlcommand = "UPDATE  tagdata1 SET  "
sqlcommand = sqlcommand & "t536_2='" & tag500.tag536_2.Text & "'" & ","
sqlcommand = sqlcommand & "t536_3='" & tag500.tag536_3.Text & "'" & ","
sqlcommand = sqlcommand & "t536_4='" & tag500.tag536_4.Text & "'" & ","
 '===============
sqlcommand = sqlcommand & "t546_1='" & tag500.tag546_1.Text & "'" & ","
 '===============
sqlcommand = sqlcommand & "t586_1='" & tag500.tag586_1.Text & "'"
 '******************where*************************
 sqlcommand = sqlcommand & "where t020_1='" & editkey & "'"
 marcdb.Execute sqlcommand
'*****************next table in tagdata2****************
sqlcommand = "UPDATE  tagdata2 SET  "
'****************primary key************************
sqlcommand = sqlcommand & "t020_1='" & tag020.tag020_1.Text & "'" & ","
 '*****************tag600*****************
 sqlcommand = sqlcommand & "t600_1='" & tag600.tag600_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_2='" & tag600.tag600_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_3='" & tag600.tag600_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_4='" & tag600.tag600_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_5='" & tag600.tag600_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_6='" & tag600.tag600_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_7='" & tag600.tag600_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_8='" & tag600.tag600_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_9='" & tag600.tag600_9.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_10='" & tag600.tag600_10.Text & "'" & ","
 sqlcommand = sqlcommand & "t600_11='" & tag600.tag600_11.Text & "'" & ","
 '*****************tag610*****************
 sqlcommand = sqlcommand & "t610_1='" & tag600.tag610_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_2='" & tag600.tag610_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_3='" & tag600.tag610_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_4='" & tag600.tag610_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_5='" & tag600.tag610_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_6='" & tag600.tag610_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_7='" & tag600.tag610_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_8='" & tag600.tag610_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_9='" & tag600.tag610_9.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_10='" & tag600.tag610_10.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_11='" & tag600.tag610_11.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_12='" & tag600.tag610_12.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_13='" & tag600.tag610_13.Text & "'" & ","
 sqlcommand = sqlcommand & "t610_14='" & tag600.tag610_14.Text & "'" & ","
 '*****************tag611*****************
 sqlcommand = sqlcommand & "t611_1='" & tag600.tag611_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t611_2='" & tag600.tag611_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t611_3='" & tag600.tag611_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t611_4='" & tag600.tag611_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t611_5='" & tag600.tag611_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t611_6='" & tag600.tag611_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t611_7='" & tag600.tag611_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t611_8='" & tag600.tag611_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t611_9='" & tag600.tag611_9.Text & "'" & ","
 sqlcommand = sqlcommand & "t611_10='" & tag600.tag611_10.Text & "'" & ","
 '*****************tag630*****************
 sqlcommand = sqlcommand & "t630_1='" & tag600.tag630_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_2='" & tag600.tag630_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_3='" & tag600.tag630_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_4='" & tag600.tag630_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_5='" & tag600.tag630_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_6='" & tag600.tag630_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_7='" & tag600.tag630_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_8='" & tag600.tag630_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_9='" & tag600.tag630_9.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_10='" & tag600.tag630_10.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_11='" & tag600.tag630_11.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_12='" & tag600.tag630_12.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_13='" & tag600.tag630_13.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_14='" & tag600.tag630_14.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_15='" & tag600.tag630_15.Text & "'" & ","
 sqlcommand = sqlcommand & "t630_16='" & tag600.tag630_16.Text & "'" & ","
 '*****************tag650*****************
 sqlcommand = sqlcommand & "t650_1='" & tag600.tag650_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t650_2='" & tag600.tag650_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t650_3='" & tag600.tag650_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t650_4='" & tag600.tag650_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t650_5='" & tag600.tag650_5.Text & "'" & ","
 '*****************tag651*****************
 sqlcommand = sqlcommand & "t651_1='" & tag600.tag651_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t651_2='" & tag600.tag651_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t651_3='" & tag600.tag651_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t651_4='" & tag600.tag651_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t651_5='" & tag600.tag651_5.Text & "'" & ","
  '*****************tag700*****************
 sqlcommand = sqlcommand & "t700_1='" & tag700.tag700_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t700_2='" & tag700.tag700_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t700_3='" & tag700.tag700_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t700_4='" & tag700.tag700_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t700_5='" & tag700.tag700_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t700_6='" & tag700.tag700_6.Text & "'" & ","
  '*****************tag710*****************
 sqlcommand = sqlcommand & "t710_1='" & tag700.tag710_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_2='" & tag700.tag710_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_3='" & tag700.tag710_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_4='" & tag700.tag710_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_5='" & tag700.tag710_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_6='" & tag700.tag710_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_7='" & tag700.tag710_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_8='" & tag700.tag710_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_9='" & tag700.tag710_9.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_10='" & tag700.tag710_10.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_11='" & tag700.tag710_11.Text & "'" & ","
 sqlcommand = sqlcommand & "t710_12='" & tag700.tag710_12.Text & "'" & ","
   '*****************tag711*****************
 sqlcommand = sqlcommand & "t711_1='" & tag700.tag711_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t711_2='" & tag700.tag711_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t711_3='" & tag700.tag711_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t711_4='" & tag700.tag711_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t711_5='" & tag700.tag711_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t711_6='" & tag700.tag711_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t711_7='" & tag700.tag711_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t711_8='" & tag700.tag711_8.Text & "'" & ","
'*****************tag730*****************
 sqlcommand = sqlcommand & "t730_1='" & tag700.tag730_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t730_2='" & tag700.tag730_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t730_3='" & tag700.tag730_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t730_4='" & tag700.tag730_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t730_5='" & tag700.tag730_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t730_6='" & tag700.tag730_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t730_7='" & tag700.tag730_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t730_8='" & tag700.tag730_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t730_9='" & tag700.tag730_9.Text & "'" & ","
 sqlcommand = sqlcommand & "t730_10='" & tag700.tag730_10.Text & "'" & ","
 '*****************tag740*****************
 sqlcommand = sqlcommand & "t740_1='" & tag700.tag740_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t740_2='" & tag700.tag740_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t740_3='" & tag700.tag740_3.Text & "'"
 '****************where*************
  sqlcommand = sqlcommand & "where t020_1='" & editkey & "'"
 marcdb.Execute sqlcommand
 '**************continue ******************
 sqlcommand = "UPDATE  tagdata2 SET  "
 '*****************tag800*****************
 sqlcommand = sqlcommand & "t800_1='" & tag800.tag800_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t800_2='" & tag800.tag800_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t800_3='" & tag800.tag800_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t800_4='" & tag800.tag800_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t800_5='" & tag800.tag800_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t800_6='" & tag800.tag800_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t800_7='" & tag800.tag800_7.Text & "'" & ","
 '*****************tag810*****************
 sqlcommand = sqlcommand & "t810_1='" & tag800.tag810_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t810_2='" & tag800.tag810_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t810_3='" & tag800.tag810_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t810_4='" & tag800.tag810_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t810_5='" & tag800.tag810_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t810_6='" & tag800.tag810_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t810_7='" & tag800.tag810_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t810_8='" & tag800.tag810_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t810_9='" & tag800.tag810_9.Text & "'" & ","
 sqlcommand = sqlcommand & "t810_10='" & tag800.tag810_10.Text & "'" & ","
  '*****************tag811*****************
 sqlcommand = sqlcommand & "t811_1='" & tag800.tag811_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t811_2='" & tag800.tag811_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t811_3='" & tag800.tag811_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t811_4='" & tag800.tag811_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t811_5='" & tag800.tag811_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t811_6='" & tag800.tag811_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t811_7='" & tag800.tag811_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t811_8='" & tag800.tag811_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t811_9='" & tag800.tag811_9.Text & "'" & ","
 sqlcommand = sqlcommand & "t811_10='" & tag800.tag811_10.Text & "'" & ","
  '*****************tag830****************
 sqlcommand = sqlcommand & "t830_1='" & tag800.tag830_1.Text & "'" & ","
 sqlcommand = sqlcommand & "t830_2='" & tag800.tag830_2.Text & "'" & ","
 sqlcommand = sqlcommand & "t830_3='" & tag800.tag830_3.Text & "'" & ","
 sqlcommand = sqlcommand & "t830_4='" & tag800.tag830_4.Text & "'" & ","
 sqlcommand = sqlcommand & "t830_5='" & tag800.tag830_5.Text & "'" & ","
 sqlcommand = sqlcommand & "t830_6='" & tag800.tag830_6.Text & "'" & ","
 sqlcommand = sqlcommand & "t830_7='" & tag800.tag830_7.Text & "'" & ","
 sqlcommand = sqlcommand & "t830_8='" & tag800.tag830_8.Text & "'" & ","
 sqlcommand = sqlcommand & "t830_9='" & tag800.tag830_9.Text & "'" & ","
  '*****************tag850****************
 sqlcommand = sqlcommand & "t850_1='" & tag800.tag850_1.Text & "'"
 '******************where*************************
 sqlcommand = sqlcommand & "where t020_1='" & editkey & "'"
 marcdb.Execute sqlcommand
End If
End Sub
