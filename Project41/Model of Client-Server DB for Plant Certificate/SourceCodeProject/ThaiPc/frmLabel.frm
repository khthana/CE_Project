VERSION 5.00
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Begin VB.Form frmLabel 
   Caption         =   "แบบฟอร์มจัดทำลาเบล"
   ClientHeight    =   3990
   ClientLeft      =   3870
   ClientTop       =   1350
   ClientWidth     =   4335
   LinkTopic       =   "Form1"
   ScaleHeight     =   3990
   ScaleWidth      =   4335
   Begin VB.Frame Frame2 
      Caption         =   "กรุณาเลือกรหัสกลุ่มพืชของผู้ส่งออกที่จะจัดทำลาเบล"
      Height          =   975
      Left            =   240
      TabIndex        =   6
      Top             =   2040
      Width           =   3855
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
         Height          =   375
         Left            =   1080
         TabIndex        =   7
         Top             =   360
         Width           =   1455
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "รหัสกลุ่ม :"
         Height          =   210
         Left            =   240
         TabIndex        =   8
         Top             =   480
         Width           =   675
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "เลิกการทำงาน"
      Height          =   495
      Left            =   2880
      TabIndex        =   5
      Top             =   3240
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "พิมพ์ลาเบล"
      Height          =   495
      Left            =   1560
      TabIndex        =   4
      Top             =   3240
      Width           =   1215
   End
   Begin Crystal.CrystalReport crptLabel3 
      Left            =   1080
      Top             =   3360
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "label3.rpt"
      WindowTitle     =   "รูปแบบลาเบลผู้ส่งออกตามกลุ่มพืชที่ส่งออก"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptLabel2 
      Left            =   600
      Top             =   3360
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "label2.rpt"
      WindowTitle     =   "รูปแบบลาเบลผู้ส่งออกทางเรือ"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptLabel1 
      Left            =   120
      Top             =   3360
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "label1.rpt"
      WindowTitle     =   "รูปแบบลาเบลผู้ส่งออกทางอากาศ"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin VB.Frame Frame1 
      Caption         =   "กรุณาเลือกประเภทของลาเบลที่ต้องการ"
      Height          =   1815
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   3855
      Begin VB.OptionButton Option3 
         Caption         =   "ผู้ส่งออกตามกลุ่มพืชที่ส่งออก"
         Height          =   210
         Left            =   360
         TabIndex        =   3
         Top             =   1200
         Width           =   2295
      End
      Begin VB.OptionButton Option2 
         Caption         =   "ผู้ส่งออกทางเรือ"
         Height          =   210
         Left            =   360
         TabIndex        =   2
         Top             =   840
         Width           =   2055
      End
      Begin VB.OptionButton Option1 
         Caption         =   "ผู้ส่งออกทางอากาศ"
         Height          =   210
         Left            =   360
         TabIndex        =   1
         Top             =   480
         Width           =   2175
      End
   End
End
Attribute VB_Name = "frmLabel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Command1_Click()
    Dim str1 As String
On Error GoTo ProcError
    
'-------------------------------------
   If Option1.Value = True Then
        crptLabel1.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str1 = "{Exporter.ExporterNumber}[1 to 2] = '10' "
        crptLabel1.SelectionFormula = str1
        crptLabel1.Action = 1
   End If
'--------------------------------------
    If Option2.Value = True Then
        crptLabel2.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str1 = "{Exporter.ExporterNumber}[1 to 2] = '20' "
        crptLabel2.SelectionFormula = str1
        crptLabel2.Action = 1
   End If
'--------------------------------------
ProcExit:
    Exit Sub
ProcError:
    MsgBox Err.Number & vbCrLf & Err.Description
    Resume ProcExit
End Sub

Private Sub Command2_Click()
    Unload Me
End Sub

