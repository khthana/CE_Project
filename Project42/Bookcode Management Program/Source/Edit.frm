VERSION 5.00
Begin VB.Form editform 
   Caption         =   "Form1"
   ClientHeight    =   6675
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7935
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MinButton       =   0   'False
   ScaleHeight     =   6675
   ScaleWidth      =   7935
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
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
      Height          =   375
      Left            =   7080
      TabIndex        =   2
      Top             =   1080
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Ok"
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
      Left            =   6120
      TabIndex        =   1
      Top             =   1080
      Width           =   735
   End
   Begin VB.ComboBox cmbID 
      Height          =   315
      ItemData        =   "Edit.frx":0000
      Left            =   3240
      List            =   "Edit.frx":0002
      TabIndex        =   0
      Top             =   1080
      Width           =   2535
   End
   Begin VB.Label Label3 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   5400
      TabIndex        =   5
      Top             =   2760
      Width           =   2415
   End
   Begin VB.Label Label2 
      Caption         =   "ชื่อหนังสือ : "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   3120
      TabIndex        =   4
      Top             =   2760
      Width           =   1695
   End
   Begin VB.Label Label1 
      Caption         =   "โปรดเลือกรหัสหนังสือที่ท่านต้องการแก้ไข"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   3480
      TabIndex        =   3
      Top             =   360
      Width           =   4575
   End
End
Attribute VB_Name = "editform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public marcdbedit As Database
Public marcwsedit As Workspace
Public Rectagdata1 As Recordset
Public Rectagdata2 As Recordset
Public idsnap As Recordset

Private Sub cmbID_click()
Set Rectagdata1 = marcdbedit.OpenRecordset("select * from tagdata1", dbOpenDynaset)
Rectagdata1.MoveFirst
Do While Rectagdata1.Fields("t020_1") <> cmbID.Text
  Rectagdata1.MoveNext
Loop
Label3.Caption = (Rectagdata1.Fields("t130_1"))
End Sub




Private Sub Command1_Click()
'Open recordset for show in each FORM and FIELDS
Set Rectagdata1 = marcdbedit.OpenRecordset("select * from tagdata1", dbOpenDynaset)
Set Rectagdata2 = marcdbedit.OpenRecordset("select * from tagdata2", dbOpenDynaset)
Rectagdata1.MoveFirst
Rectagdata2.MoveFirst
Do While Rectagdata1.Fields("t020_1") <> cmbID.Text
  Rectagdata1.MoveNext
Loop
Do While Rectagdata2.Fields("t020_1") <> cmbID.Text
  Rectagdata2.MoveNext
Loop
Rectagdata1.Edit
Rectagdata2.Edit
'******* assign key to edit to mainmenu form *******
mainmenu.editkey = cmbID.Text
'**** Start display fields in the textbox of each form*********
'*************** tag008***************
tag008.tag008_1.Text = (Rectagdata1.Fields("t008_1"))
tag008.tag008_2.Text = (Rectagdata1.Fields("t008_2"))
tag008.tag008_3.Text = (Rectagdata1.Fields("t008_3"))
tag008.tag008_4.Text = (Rectagdata1.Fields("t008_4"))
tag008.tag008_5.Text = (Rectagdata1.Fields("t008_5"))
tag008.tag008_6.Text = (Rectagdata1.Fields("t008_6"))
tag008.tag008_7.Text = (Rectagdata1.Fields("t008_7"))
tag008.tag008_8.Text = (Rectagdata1.Fields("t008_8"))
tag008.tag008_9.Text = (Rectagdata1.Fields("t008_9"))
tag008.tag008_10.Text = (Rectagdata1.Fields("t008_10"))
tag008.tag008_11.Text = (Rectagdata1.Fields("t008_11"))
tag008.tag008_12.Text = (Rectagdata1.Fields("t008_12"))
tag008.tag008_13.Text = (Rectagdata1.Fields("t008_13"))
tag008.tag008_14.Text = (Rectagdata1.Fields("t008_14"))
tag008.tag008_15.Text = (Rectagdata1.Fields("t008_15"))
tag008.tag008_16.Text = (Rectagdata1.Fields("t008_16"))
tag008.tag008_17.Text = (Rectagdata1.Fields("t008_17"))
tag008.tag008_18.Text = (Rectagdata1.Fields("t008_18"))
tag008.tag008_19.Text = (Rectagdata1.Fields("t008_19"))
tag008.tag008_20.Text = (Rectagdata1.Fields("t008_20"))
tag008.tag008_21.Text = (Rectagdata1.Fields("t008_21"))
tag008.tag008_22.Text = (Rectagdata1.Fields("t008_22"))
tag008.tag008_23.Text = (Rectagdata1.Fields("t008_23"))
tag008.tag008_24.Text = (Rectagdata1.Fields("t008_24"))
tag008.tag008_25.Text = (Rectagdata1.Fields("t008_25"))
'*************** tag020***************
tag020.tag020_1.Text = (Rectagdata1.Fields("t020_1"))
tag020.tag020_2.Text = (Rectagdata1.Fields("t020_2"))
tag020.tag020_3.Text = (Rectagdata1.Fields("t020_3"))
tag020.tag022_1.Text = (Rectagdata1.Fields("t022_1"))
tag020.tag022_2.Text = (Rectagdata1.Fields("t022_2"))
tag020.tag022_3.Text = (Rectagdata1.Fields("t022_3"))
'*************** tag090***************
tag090.tag090_1.Text = (Rectagdata1.Fields("t090_1"))
tag090.tag090_2.Text = (Rectagdata1.Fields("t090_2"))
tag090.tag090_3.Text = (Rectagdata1.Fields("t090_3"))
tag090.tag099_1.Text = (Rectagdata1.Fields("t099_1"))
tag090.tag099_2.Text = (Rectagdata1.Fields("t099_2"))
tag090.tag099_3.Text = (Rectagdata1.Fields("t099_3"))
'*************** tag100***************
tag100.tag100_1.Text = (Rectagdata1.Fields("t100_1"))
tag100.tag100_2.Text = (Rectagdata1.Fields("t100_2"))
tag100.tag100_3.Text = (Rectagdata1.Fields("t100_3"))
tag100.tag100_4.Text = (Rectagdata1.Fields("t100_4"))
tag100.tag100_5.Text = (Rectagdata1.Fields("t100_5"))
'=========
tag100.tag110_1.Text = (Rectagdata1.Fields("t110_1"))
tag100.tag110_2.Text = (Rectagdata1.Fields("t110_2"))
tag100.tag110_3.Text = (Rectagdata1.Fields("t110_3"))
tag100.tag110_4.Text = (Rectagdata1.Fields("t110_4"))
tag100.tag110_5.Text = (Rectagdata1.Fields("t110_5"))
tag100.tag110_6.Text = (Rectagdata1.Fields("t110_6"))
'=========
tag100.tag111_1.Text = (Rectagdata1.Fields("t111_1"))
tag100.tag111_2.Text = (Rectagdata1.Fields("t111_2"))
tag100.tag111_3.Text = (Rectagdata1.Fields("t111_3"))
tag100.tag111_4.Text = (Rectagdata1.Fields("t111_4"))
tag100.tag111_5.Text = (Rectagdata1.Fields("t111_5"))
tag100.tag111_6.Text = (Rectagdata1.Fields("t111_6"))
'=========
tag100.tag130_1.Text = (Rectagdata1.Fields("t130_1"))
tag100.tag130_2.Text = (Rectagdata1.Fields("t130_2"))
tag100.tag130_3.Text = (Rectagdata1.Fields("t130_3"))
tag100.tag130_4.Text = (Rectagdata1.Fields("t130_4"))
tag100.tag130_5.Text = (Rectagdata1.Fields("t130_5"))
tag100.tag130_6.Text = (Rectagdata1.Fields("t130_6"))
tag100.tag130_7.Text = (Rectagdata1.Fields("t130_7"))
tag100.tag130_8.Text = (Rectagdata1.Fields("t130_8"))
'*************** tag210***************
tag210.tag210_1.Text = (Rectagdata1.Fields("t210_1"))
tag210.tag210_2.Text = (Rectagdata1.Fields("t210_2"))
'=========
tag210.tag240_1.Text = (Rectagdata1.Fields("t240_1"))
tag210.tag240_2.Text = (Rectagdata1.Fields("t240_2"))
tag210.tag240_3.Text = (Rectagdata1.Fields("t240_3"))
tag210.tag240_4.Text = (Rectagdata1.Fields("t240_4"))
tag210.tag240_5.Text = (Rectagdata1.Fields("t240_5"))
tag210.tag240_6.Text = (Rectagdata1.Fields("t240_6"))
tag210.tag240_7.Text = (Rectagdata1.Fields("t240_7"))
tag210.tag240_8.Text = (Rectagdata1.Fields("t240_8"))
tag210.tag240_9.Text = (Rectagdata1.Fields("t240_9"))
'=========
tag210.tag242_1.Text = (Rectagdata1.Fields("t242_1"))
tag210.tag242_2.Text = (Rectagdata1.Fields("t242_2"))
tag210.tag242_3.Text = (Rectagdata1.Fields("t242_3"))
tag210.tag242_4.Text = (Rectagdata1.Fields("t242_4"))
tag210.tag242_5.Text = (Rectagdata1.Fields("t242_5"))
tag210.tag242_6.Text = (Rectagdata1.Fields("t242_6"))
'=========
tag210.tag245_1.Text = (Rectagdata1.Fields("t245_1"))
tag210.tag245_2.Text = (Rectagdata1.Fields("t245_2"))
tag210.tag245_3.Text = (Rectagdata1.Fields("t245_3"))
tag210.tag245_4.Text = (Rectagdata1.Fields("t245_4"))
tag210.tag245_5.Text = (Rectagdata1.Fields("t245_5"))
tag210.tag245_6.Text = (Rectagdata1.Fields("t245_6"))
'=========
tag210.tag246_1.Text = (Rectagdata1.Fields("t246_1"))
tag210.tag246_2.Text = (Rectagdata1.Fields("t246_2"))
tag210.tag246_3.Text = (Rectagdata1.Fields("t246_3"))
tag210.tag246_4.Text = (Rectagdata1.Fields("t246_4"))
tag210.tag246_5.Text = (Rectagdata1.Fields("t246_5"))
tag210.tag246_6.Text = (Rectagdata1.Fields("t246_6"))
tag210.tag246_7.Text = (Rectagdata1.Fields("t246_7"))
'*************** tag250**************
tag250.tag250_1.Text = (Rectagdata1.Fields("t250_1"))
tag250.tag250_2.Text = (Rectagdata1.Fields("t250_2"))
'=========
tag250.tag260_1.Text = (Rectagdata1.Fields("t260_1"))
tag250.tag260_2.Text = (Rectagdata1.Fields("t260_2"))
tag250.tag260_3.Text = (Rectagdata1.Fields("t260_3"))
'=========
tag250.tag300_1.Text = (Rectagdata1.Fields("t300_1"))
tag250.tag300_2.Text = (Rectagdata1.Fields("t300_2"))
tag250.tag300_3.Text = (Rectagdata1.Fields("t300_3"))
tag250.tag300_4.Text = (Rectagdata1.Fields("t300_4"))
tag250.tag300_5.Text = (Rectagdata1.Fields("t300_5"))
tag250.tag300_6.Text = (Rectagdata1.Fields("t300_6"))
tag250.tag300_7.Text = (Rectagdata1.Fields("t300_7"))
'=========
tag250.tag440_1.Text = (Rectagdata1.Fields("t440_1"))
tag250.tag440_2.Text = (Rectagdata1.Fields("t440_2"))
tag250.tag440_3.Text = (Rectagdata1.Fields("t440_3"))
tag250.tag440_4.Text = (Rectagdata1.Fields("t440_4"))
tag250.tag440_5.Text = (Rectagdata1.Fields("t440_5"))
'=========
tag250.tag490_1.Text = (Rectagdata1.Fields("t490_1"))
tag250.tag490_2.Text = (Rectagdata1.Fields("t490_2"))
'*************** tag500**************
tag500.tag500_1.Text = (Rectagdata1.Fields("t500_1"))
'=========
tag500.tag501_1.Text = (Rectagdata1.Fields("t501_1"))
'=========
tag500.tag502_1.Text = (Rectagdata1.Fields("t502_1"))
'=========
tag500.tag505_1.Text = (Rectagdata1.Fields("t505_1"))
tag500.tag505_2.Text = (Rectagdata1.Fields("t505_2"))
tag500.tag505_3.Text = (Rectagdata1.Fields("t505_3"))
'=========
tag500.tag510_1.Text = (Rectagdata1.Fields("t510_1"))
tag500.tag510_2.Text = (Rectagdata1.Fields("t510_2"))
tag500.tag510_3.Text = (Rectagdata1.Fields("t510_3"))
tag500.tag510_4.Text = (Rectagdata1.Fields("t510_4"))
'=========
tag500.tag520_1.Text = (Rectagdata1.Fields("t520_1"))
tag500.tag520_2.Text = (Rectagdata1.Fields("t520_2"))
tag500.tag520_3.Text = (Rectagdata1.Fields("t520_3"))
'=========
tag500.tag536_1.Text = (Rectagdata1.Fields("t536_1"))
tag500.tag536_2.Text = (Rectagdata1.Fields("t536_2"))
tag500.tag536_3.Text = (Rectagdata1.Fields("t536_3"))
tag500.tag536_4.Text = (Rectagdata1.Fields("t536_4"))
'=========
tag500.tag546_1.Text = (Rectagdata1.Fields("t546_1"))
'=========
tag500.tag586_1.Text = (Rectagdata1.Fields("t586_1"))
'*************** tag600***************
tag600.tag600_1.Text = (Rectagdata2.Fields("t600_1"))
tag600.tag600_2.Text = (Rectagdata2.Fields("t600_2"))
tag600.tag600_3.Text = (Rectagdata2.Fields("t600_3"))
tag600.tag600_4.Text = (Rectagdata2.Fields("t600_4"))
tag600.tag600_5.Text = (Rectagdata2.Fields("t600_5"))
tag600.tag600_6.Text = (Rectagdata2.Fields("t600_6"))
tag600.tag600_7.Text = (Rectagdata2.Fields("t600_7"))
tag600.tag600_8.Text = (Rectagdata2.Fields("t600_8"))
tag600.tag600_9.Text = (Rectagdata2.Fields("t600_9"))
tag600.tag600_10.Text = (Rectagdata2.Fields("t600_10"))
tag600.tag600_11.Text = (Rectagdata2.Fields("t600_11"))
'==============
tag600.tag610_1.Text = (Rectagdata2.Fields("t610_1"))
tag600.tag610_2.Text = (Rectagdata2.Fields("t610_2"))
tag600.tag610_3.Text = (Rectagdata2.Fields("t610_3"))
tag600.tag610_4.Text = (Rectagdata2.Fields("t610_4"))
tag600.tag610_5.Text = (Rectagdata2.Fields("t610_5"))
tag600.tag610_6.Text = (Rectagdata2.Fields("t610_6"))
tag600.tag610_7.Text = (Rectagdata2.Fields("t610_7"))
tag600.tag610_8.Text = (Rectagdata2.Fields("t610_8"))
tag600.tag610_9.Text = (Rectagdata2.Fields("t610_9"))
tag600.tag610_10.Text = (Rectagdata2.Fields("t610_10"))
tag600.tag610_11.Text = (Rectagdata2.Fields("t610_11"))
tag600.tag610_12.Text = (Rectagdata2.Fields("t610_12"))
tag600.tag610_13.Text = (Rectagdata2.Fields("t610_13"))
tag600.tag610_14.Text = (Rectagdata2.Fields("t610_14"))
'=============
tag600.tag611_1.Text = (Rectagdata2.Fields("t611_1"))
tag600.tag611_2.Text = (Rectagdata2.Fields("t611_2"))
tag600.tag611_3.Text = (Rectagdata2.Fields("t611_3"))
tag600.tag611_4.Text = (Rectagdata2.Fields("t611_4"))
tag600.tag611_5.Text = (Rectagdata2.Fields("t611_5"))
tag600.tag611_6.Text = (Rectagdata2.Fields("t611_6"))
tag600.tag611_7.Text = (Rectagdata2.Fields("t611_7"))
tag600.tag611_8.Text = (Rectagdata2.Fields("t611_8"))
tag600.tag611_9.Text = (Rectagdata2.Fields("t611_9"))
tag600.tag611_10.Text = (Rectagdata2.Fields("t611_10"))
'==============
tag600.tag630_1.Text = (Rectagdata2.Fields("t630_1"))
tag600.tag630_2.Text = (Rectagdata2.Fields("t630_2"))
tag600.tag630_3.Text = (Rectagdata2.Fields("t630_3"))
tag600.tag630_4.Text = (Rectagdata2.Fields("t630_4"))
tag600.tag630_5.Text = (Rectagdata2.Fields("t630_5"))
tag600.tag630_6.Text = (Rectagdata2.Fields("t630_6"))
tag600.tag630_7.Text = (Rectagdata2.Fields("t630_7"))
tag600.tag630_8.Text = (Rectagdata2.Fields("t630_8"))
tag600.tag630_9.Text = (Rectagdata2.Fields("t630_9"))
tag600.tag630_10.Text = (Rectagdata2.Fields("t630_10"))
tag600.tag630_11.Text = (Rectagdata2.Fields("t630_11"))
tag600.tag630_12.Text = (Rectagdata2.Fields("t630_12"))
tag600.tag630_13.Text = (Rectagdata2.Fields("t630_13"))
tag600.tag630_14.Text = (Rectagdata2.Fields("t630_14"))
tag600.tag630_15.Text = (Rectagdata2.Fields("t630_15"))
tag600.tag630_16.Text = (Rectagdata2.Fields("t630_16"))
'==============
tag600.tag650_1.Text = (Rectagdata2.Fields("t650_1"))
tag600.tag650_2.Text = (Rectagdata2.Fields("t650_2"))
tag600.tag650_3.Text = (Rectagdata2.Fields("t650_3"))
tag600.tag650_4.Text = (Rectagdata2.Fields("t650_4"))
tag600.tag650_5.Text = (Rectagdata2.Fields("t650_5"))
'=============
tag600.tag651_1.Text = (Rectagdata2.Fields("t651_1"))
tag600.tag651_2.Text = (Rectagdata2.Fields("t651_2"))
tag600.tag651_3.Text = (Rectagdata2.Fields("t651_3"))
tag600.tag651_4.Text = (Rectagdata2.Fields("t651_4"))
tag600.tag651_5.Text = (Rectagdata2.Fields("t651_5"))
'*************** tag700***************
tag700.tag700_1.Text = (Rectagdata2.Fields("t700_1"))
tag700.tag700_2.Text = (Rectagdata2.Fields("t700_2"))
tag700.tag700_3.Text = (Rectagdata2.Fields("t700_3"))
tag700.tag700_4.Text = (Rectagdata2.Fields("t700_4"))
tag700.tag700_5.Text = (Rectagdata2.Fields("t700_5"))
tag700.tag700_6.Text = (Rectagdata2.Fields("t700_6"))
'============
tag700.tag710_1.Text = (Rectagdata2.Fields("t710_1"))
tag700.tag710_2.Text = (Rectagdata2.Fields("t710_2"))
tag700.tag710_3.Text = (Rectagdata2.Fields("t710_3"))
tag700.tag710_4.Text = (Rectagdata2.Fields("t710_4"))
tag700.tag710_5.Text = (Rectagdata2.Fields("t710_5"))
tag700.tag710_6.Text = (Rectagdata2.Fields("t710_6"))
tag700.tag710_7.Text = (Rectagdata2.Fields("t710_7"))
tag700.tag710_8.Text = (Rectagdata2.Fields("t710_8"))
tag700.tag710_9.Text = (Rectagdata2.Fields("t710_9"))
tag700.tag710_10.Text = (Rectagdata2.Fields("t710_10"))
tag700.tag710_11.Text = (Rectagdata2.Fields("t710_11"))
tag700.tag710_12.Text = (Rectagdata2.Fields("t710_12"))
'============
tag700.tag711_1.Text = (Rectagdata2.Fields("t711_1"))
tag700.tag711_2.Text = (Rectagdata2.Fields("t711_2"))
tag700.tag711_3.Text = (Rectagdata2.Fields("t711_3"))
tag700.tag711_4.Text = (Rectagdata2.Fields("t711_4"))
tag700.tag711_5.Text = (Rectagdata2.Fields("t711_5"))
tag700.tag711_6.Text = (Rectagdata2.Fields("t711_6"))
tag700.tag711_7.Text = (Rectagdata2.Fields("t711_7"))
tag700.tag711_8.Text = (Rectagdata2.Fields("t711_8"))
'============
tag700.tag730_1.Text = (Rectagdata2.Fields("t730_1"))
tag700.tag730_2.Text = (Rectagdata2.Fields("t730_2"))
tag700.tag730_3.Text = (Rectagdata2.Fields("t730_3"))
tag700.tag730_4.Text = (Rectagdata2.Fields("t730_4"))
tag700.tag730_5.Text = (Rectagdata2.Fields("t730_5"))
tag700.tag730_6.Text = (Rectagdata2.Fields("t730_6"))
tag700.tag730_7.Text = (Rectagdata2.Fields("t730_7"))
tag700.tag730_8.Text = (Rectagdata2.Fields("t730_8"))
tag700.tag730_9.Text = (Rectagdata2.Fields("t730_9"))
tag700.tag730_10.Text = (Rectagdata2.Fields("t730_10"))
'============
tag700.tag740_1.Text = (Rectagdata2.Fields("t740_1"))
tag700.tag740_2.Text = (Rectagdata2.Fields("t740_2"))
tag700.tag740_3.Text = (Rectagdata2.Fields("t740_3"))
'*************** tag800***************
tag800.tag800_1.Text = (Rectagdata2.Fields("t800_1"))
tag800.tag800_2.Text = (Rectagdata2.Fields("t800_2"))
tag800.tag800_3.Text = (Rectagdata2.Fields("t800_3"))
tag800.tag800_4.Text = (Rectagdata2.Fields("t800_4"))
tag800.tag800_5.Text = (Rectagdata2.Fields("t800_5"))
tag800.tag800_6.Text = (Rectagdata2.Fields("t800_6"))
tag800.tag800_7.Text = (Rectagdata2.Fields("t800_7"))
'=============
tag800.tag810_1.Text = (Rectagdata2.Fields("t810_1"))
tag800.tag810_2.Text = (Rectagdata2.Fields("t810_2"))
tag800.tag810_3.Text = (Rectagdata2.Fields("t810_3"))
tag800.tag810_4.Text = (Rectagdata2.Fields("t810_4"))
tag800.tag810_5.Text = (Rectagdata2.Fields("t810_5"))
tag800.tag810_6.Text = (Rectagdata2.Fields("t810_6"))
tag800.tag810_7.Text = (Rectagdata2.Fields("t810_7"))
tag800.tag810_8.Text = (Rectagdata2.Fields("t810_8"))
tag800.tag810_9.Text = (Rectagdata2.Fields("t810_9"))
tag800.tag810_10.Text = (Rectagdata2.Fields("t810_10"))
'=============
tag800.tag811_1.Text = (Rectagdata2.Fields("t811_1"))
tag800.tag811_2.Text = (Rectagdata2.Fields("t811_2"))
tag800.tag811_3.Text = (Rectagdata2.Fields("t811_3"))
tag800.tag811_4.Text = (Rectagdata2.Fields("t811_4"))
tag800.tag811_5.Text = (Rectagdata2.Fields("t811_5"))
tag800.tag811_6.Text = (Rectagdata2.Fields("t811_6"))
tag800.tag811_7.Text = (Rectagdata2.Fields("t811_7"))
tag800.tag811_8.Text = (Rectagdata2.Fields("t811_8"))
tag800.tag811_9.Text = (Rectagdata2.Fields("t811_9"))
tag800.tag811_10.Text = (Rectagdata2.Fields("t811_10"))
'=============
tag800.tag830_1.Text = (Rectagdata2.Fields("t830_1"))
tag800.tag830_2.Text = (Rectagdata2.Fields("t830_2"))
tag800.tag830_3.Text = (Rectagdata2.Fields("t830_3"))
tag800.tag830_4.Text = (Rectagdata2.Fields("t830_4"))
tag800.tag830_5.Text = (Rectagdata2.Fields("t830_5"))
tag800.tag830_6.Text = (Rectagdata2.Fields("t830_6"))
tag800.tag830_7.Text = (Rectagdata2.Fields("t830_7"))
tag800.tag830_8.Text = (Rectagdata2.Fields("t830_8"))
tag800.tag830_9.Text = (Rectagdata2.Fields("t830_9"))
'=============
tag800.tag850_1.Text = (Rectagdata2.Fields("t850_1"))
'************************************
tagselect.Show
tag020.Show
mainmenu.editstatus = True
Unload Me
End Sub

Private Sub Command2_Click()
Unload Me
End Sub

Private Sub Form_Load()
Set marcwsedit = DBEngine.Workspaces(0)
Set marcdbedit = marcwsedit.OpenDatabase("marcsheetdb", False, False)
'Openrecordset for select from combo box
Set idsnap = marcdbedit.OpenRecordset("select t020_1 from tagdata1 Order by t020_1", dbOpenSnapshot)
If idsnap.EOF Then
   MsgBox ("ไม่มีข้อมูลบนฐานข้อมูลแล้ว")
   Command1.Visible = False
   cmbID.Clear
Else
'Add item in the combo box
idsnap.MoveFirst
cmbID.Clear
Do While Not idsnap.EOF
   cmbID.AddItem (idsnap.Fields("t020_1"))
    idsnap.MoveNext
Loop
End If
End Sub


