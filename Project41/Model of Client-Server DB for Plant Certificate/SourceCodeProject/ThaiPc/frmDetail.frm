VERSION 5.00
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Begin VB.Form frmDetail 
   Caption         =   "แบบฟอร์มจัดทำรายละเอียดของพืชที่ส่งออก"
   ClientHeight    =   6165
   ClientLeft      =   3180
   ClientTop       =   1095
   ClientWidth     =   6270
   LinkTopic       =   "Form1"
   ScaleHeight     =   6165
   ScaleWidth      =   6270
   Begin Crystal.CrystalReport crptDetail6 
      Left            =   5640
      Top             =   720
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "detail6.rpt"
      WindowTitle     =   "รายละเอียดผู้ส่งออกทางเรือ"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptDetail5 
      Left            =   5160
      Top             =   720
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "detail5.rpt"
      WindowTitle     =   "รายละเอียดผู้ส่งออกทางอากาศ"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptDetail4 
      Left            =   4680
      Top             =   720
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "detail4.rpt"
      WindowTitle     =   "รายละเอียดประเทศทั้งหมด"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptDetail3 
      Left            =   5640
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "detail3.rpt"
      WindowTitle     =   "รายละเอียดพืชทั้งหมด"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptDetail7 
      Left            =   4680
      Top             =   1200
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "detail7.rpt"
      WindowTitle     =   "รายละเอียดผู้นำเข้าทั้งหมด"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptDetail2 
      Left            =   5160
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "detail2.rpt"
      WindowTitle     =   "รายละเอียดกลุ่มพืชทั้งหมด"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin VB.CommandButton Command1 
      Caption         =   "พิมพ์รายงาน"
      Height          =   495
      Left            =   4800
      TabIndex        =   13
      Top             =   4080
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "เลิกการทำงาน"
      Height          =   495
      Left            =   4800
      TabIndex        =   12
      Top             =   4800
      Width           =   1215
   End
   Begin Crystal.CrystalReport crptDetail1 
      Left            =   4680
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "Detail1.rpt"
      WindowTitle     =   "รายงานสรุปรายละเอียดของพืชที่ส่งออก"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin VB.Frame Frame2 
      Caption         =   "ช่วงเวลาที่ต้องการจัดทำรายงาน ( เฉพาะรายงานสรุป ) "
      Height          =   2175
      Index           =   0
      Left            =   120
      TabIndex        =   2
      Top             =   3360
      Width           =   4455
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
         Left            =   720
         TabIndex        =   4
         Top             =   720
         Width           =   1215
      End
      Begin VB.TextBox Text2 
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
         Left            =   3000
         TabIndex        =   3
         Top             =   720
         Width           =   1215
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "( ปี,เดือน,วัน )"
         Height          =   210
         Index           =   1
         Left            =   1440
         TabIndex        =   11
         Top             =   1800
         Width           =   975
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "( ปี,เดือน,วัน )"
         Height          =   210
         Index           =   0
         Left            =   1440
         TabIndex        =   10
         Top             =   1560
         Width           =   975
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "กรุณาใส่ช่วงเวลาที่ต้องการทำรายงาน"
         Height          =   210
         Left            =   480
         TabIndex        =   9
         Top             =   360
         Width           =   2550
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "ถึงวันที่"
         Height          =   210
         Left            =   2160
         TabIndex        =   8
         Top             =   840
         Width           =   495
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "ตัวอย่าง :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   360
         TabIndex        =   7
         Top             =   1200
         Width           =   795
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "1991,02,11"
         Height          =   210
         Index           =   0
         Left            =   480
         TabIndex        =   6
         Top             =   1560
         Width           =   750
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "1991,12,30"
         Height          =   210
         Index           =   1
         Left            =   480
         TabIndex        =   5
         Top             =   1800
         Width           =   765
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "กรุณาเลือกประเภทของรายละเอียดของพืชที่ต้องการ"
      Height          =   3135
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4455
      Begin VB.OptionButton Option7 
         Caption         =   "รายละเอียดผู้นำเข้าทั้งหมด"
         Height          =   210
         Left            =   240
         TabIndex        =   19
         Top             =   2640
         Width           =   2175
      End
      Begin VB.OptionButton Option6 
         Caption         =   "รายละเอียดผู้ส่งออกทางเรือ"
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   2280
         Width           =   2655
      End
      Begin VB.OptionButton Option5 
         Caption         =   "รายละเอียดผู้ส่งออกทางอากาศ"
         Height          =   210
         Left            =   240
         TabIndex        =   17
         Top             =   1920
         Width           =   2415
      End
      Begin VB.OptionButton Option4 
         Caption         =   "รายละเอียดประเทศทั้งหมด"
         Height          =   210
         Left            =   240
         TabIndex        =   16
         Top             =   1560
         Width           =   2295
      End
      Begin VB.OptionButton Option2 
         Caption         =   "รายละเอียดกลุ่มพืชทั้งหมด"
         Height          =   210
         Left            =   240
         TabIndex        =   15
         Top             =   840
         Width           =   2415
      End
      Begin VB.OptionButton Option3 
         Caption         =   "รายละเอียดพืชทั้งหมด"
         Height          =   210
         Left            =   240
         TabIndex        =   14
         Top             =   1200
         Width           =   2295
      End
      Begin VB.OptionButton Option1 
         Caption         =   "รายงานสรุปรายละเอียดพืชที่ส่งออก"
         Height          =   210
         Left            =   240
         TabIndex        =   1
         Top             =   480
         Width           =   2895
      End
   End
End
Attribute VB_Name = "frmDetail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim str As String
Private Sub Command1_Click()
On Error GoTo ProcError
   
   '--------------------------------
    If Option1.Value = True Then
        crptDetail1.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{ExportPlants.ExportDate} >= Date(" & Text1.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text2.Text & ")"
        crptDetail1.SelectionFormula = str
        crptDetail1.Action = 1
    End If
   '--------------------------------
    If Option2.Value = True Then
        crptDetail2.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{PlantsGroup.GroupID} > '00'"
        crptDetail2.SelectionFormula = str
        crptDetail2.Action = 1
    End If
    '-------------------------------
    If Option3.Value = True Then
        crptDetail3.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{PlantsDetail.GroupID} > '00'"
        crptDetail3.SelectionFormula = str
        crptDetail3.Action = 1
    End If
    '-------------------------------
    If Option4.Value = True Then
        crptDetail4.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{Country.CountryNo} > '00'"
        crptDetail4.SelectionFormula = str
        crptDetail4.Action = 1
    End If
    '-------------------------------
    If Option5.Value = True Then
        crptDetail5.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{Exporter.ExporterNumber}[1 to 2] = '10' "
        crptDetail5.SelectionFormula = str
        crptDetail5.Action = 1
    End If
    '-------------------------------
    If Option6.Value = True Then
        crptDetail6.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{Exporter.ExporterNumber}[1 to 2] = '20'"
        crptDetail6.SelectionFormula = str
        crptDetail6.Action = 1
    End If
    '-------------------------------
    If Option7.Value = True Then
        crptDetail7.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{Consignee.ConsigneeNumber} > '00'"
        crptDetail7.SelectionFormula = str
        crptDetail7.Action = 1
    End If
    '-------------------------------

ProcExit:
    Exit Sub
ProcError:
    
    If Err.Number = 20515 Then
        MsgBox "ตรวจพบข้อผิดพลาด !" & vbCrLf & _
        "- คุณอาจจะไม่ได้ใส่ช่วงเวลาที่ต้องการจะจัดทำรายงาน" & _
        vbCrLf & "  หรือใส่ข้อความไม่ครบ กรุณาตรวจสอบอีกครั้ง"
    Else: MsgBox Err.Number & vbCrLf & Err.Description
    End If
    Resume ProcExit
End Sub
Private Sub Command2_Click()
    Unload Me
End Sub
