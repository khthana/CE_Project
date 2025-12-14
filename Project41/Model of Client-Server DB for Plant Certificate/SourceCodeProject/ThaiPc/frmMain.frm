VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "COMCTL32.OCX"
Begin VB.Form frmMain 
   Caption         =   "เมนูโปรแกรมระบบการออกใบรับรองปลอดศัตรูพืช ( กรมวิชาการเกษตร )"
   ClientHeight    =   2775
   ClientLeft      =   1335
   ClientTop       =   2145
   ClientWidth     =   9390
   LinkTopic       =   "Form1"
   ScaleHeight     =   2775
   ScaleWidth      =   9390
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   810
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9390
      _ExtentX        =   16563
      _ExtentY        =   1429
      ButtonWidth     =   1270
      ButtonHeight    =   1270
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   21
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "report"
            Object.ToolTipText     =   "กดเพื่อออกใบรับรองพืช"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "Export"
            Object.ToolTipText     =   "กดเพื่อกรอกบัญชีรายชื่อพืชส่งออก"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button5 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "plant"
            Object.ToolTipText     =   "กดเพื่อกรอกข้อมูลพืช"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
         BeginProperty Button6 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button7 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "country"
            Object.ToolTipText     =   "กดเพื่อกรอกข้อมูลประเทศ"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
         BeginProperty Button8 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button9 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "group"
            Object.ToolTipText     =   "กดเพื่อกรอกข้อมูลกลุ่มพืช"
            Object.Tag             =   ""
            ImageIndex      =   7
         EndProperty
         BeginProperty Button10 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button11 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "Exporter"
            Object.ToolTipText     =   "กดเพื่อกรอกข้อมูลผู้ส่งออก"
            Object.Tag             =   ""
            ImageIndex      =   6
         EndProperty
         BeginProperty Button12 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            ImageIndex      =   5
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button13 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "exit"
            Object.ToolTipText     =   "กดเพื่อเลิกการทำงาน"
            Object.Tag             =   ""
            ImageIndex      =   5
         EndProperty
         BeginProperty Button14 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button15 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button16 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button17 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button18 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "Adhoc"
            Object.ToolTipText     =   "กดเพื่อค้นหาข้อมูล"
            Object.Tag             =   ""
            ImageIndex      =   10
         EndProperty
         BeginProperty Button19 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "Sum"
            Object.ToolTipText     =   "กดเพื่อทำรายงานสรุป"
            Object.Tag             =   ""
            ImageIndex      =   13
         EndProperty
         BeginProperty Button20 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "Detail"
            Object.ToolTipText     =   "กดเพื่อทำรายละเอียดเกี่ยวกับพืช"
            Object.Tag             =   ""
            ImageIndex      =   14
         EndProperty
         BeginProperty Button21 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "label"
            Object.ToolTipText     =   "กดเพื่อทำลาเบลผู้ส่งออก"
            Object.Tag             =   ""
            ImageIndex      =   17
         EndProperty
      EndProperty
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   240
      Top             =   960
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   17
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":0634
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":094E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":0C68
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":0F82
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":129C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":15B6
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":18D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":1BEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":1F04
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":221E
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":2538
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":2852
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":2B6C
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":2E86
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmMain.frx":31A0
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu FillData 
      Caption         =   "แบบฟอร์มข้อมูล"
      Begin VB.Menu Report 
         Caption         =   "แบบฟอร์มข้อมูลใบรับรอง"
      End
      Begin VB.Menu Attach 
         Caption         =   "แบบฟอร์มข้อมูลบัญชีพืชส่งออก"
      End
      Begin VB.Menu Plants 
         Caption         =   "แบบฟอร์มข้อมูลรายละเอียดพืช"
      End
      Begin VB.Menu Country 
         Caption         =   "แบบฟอร์มข้อมูลรายละเอียดประเทศ"
      End
      Begin VB.Menu group 
         Caption         =   "แบบฟอร์มข้อมูลกลุ่มพืช"
      End
   End
   Begin VB.Menu Exit1 
      Caption         =   "เลิกการทำงาน"
      Begin VB.Menu Exit 
         Caption         =   "เลิกการทำงาน"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub group_Click()
    frmPlantsGroup.Show
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
    Select Case Button.Key
        Case "report"
            LoadApplication
        Case "Export"
            LoadExport
        Case "plant"
            LoadPlants
        Case "country"
            LoadCountry
        Case "group"
            LoadGroup
        Case "exit"
            Unload Me
        Case "Sum"
            LoadSum
        Case "Detail"
            LoadDetail
        Case "Exporter"
            LoadExporter
        Case "Adhoc"
            LoadAdhoc
        Case "label"
            LoadLabel
            
    End Select
End Sub
Private Sub LoadApplication()
    Dim frmApp As frmApplications
    Set frmApp = New frmApplications
    frmApp.Show
End Sub
Private Sub LoadExport()
    Dim frmEx As frmAccount
    Set frmEx = New frmAccount
    frmEx.Show
End Sub
Private Sub LoadCountry()
    Dim frmCountry As frmCountry
    Set frmCountry = New frmCountry
    frmCountry.Show
End Sub
Private Sub LoadPlants()
    Dim frmPlants As frmPlantDetail
    Set frmPlants = New frmPlantDetail
    frmPlants.Show
End Sub
Private Sub LoadGroup()
    Dim frmPlantsGroup As frmPlantsGroup
    Set frmPlantsGroup = New frmPlantsGroup
    frmPlantsGroup.Show
End Sub
Private Sub LoadSum()
    Dim frmSum As frmSumReport
    Set frmSum = New frmSumReport
    frmSum.Show
End Sub
Private Sub LoadDetail()
    Dim frmDetail As frmDetail
    Set frmDetail = New frmDetail
    frmDetail.Show
End Sub
Private Sub LoadExporter()
    Dim frmEx1 As frmExMas
    Set frmEx1 = New frmExMas
    frmEx1.Show
End Sub
Private Sub LoadAdhoc()
    Dim frmAd As frmAdHoc
    Set frmAd = New frmAdHoc
    frmAd.Show
End Sub
Private Sub LoadLabel()
    Dim frmLa As frmLabel
    Set frmLa = New frmLabel
    frmLa.Show
End Sub
Private Sub Country_Click()
    frmCountry.Show
End Sub
Private Sub Form_Unload(Cancel As Integer)
    Unload Me
End Sub
Private Sub Attach_Click()
    frmAccount.Show
End Sub
Private Sub Exit_click()
    Unload Me
End Sub
Private Sub Plants_Click()
    frmPlantDetail.Show
End Sub
Private Sub Report_Click()
    frmApplications.Show
End Sub

