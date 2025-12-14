VERSION 5.00
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Begin VB.Form frmSumReport 
   Caption         =   "แบบฟอร์มจัดทำรายงานสรุปผลรวมการส่งออกพืช"
   ClientHeight    =   6135
   ClientLeft      =   1665
   ClientTop       =   930
   ClientWidth     =   8025
   LinkTopic       =   "Form2"
   ScaleHeight     =   6135
   ScaleWidth      =   8025
   Begin Crystal.CrystalReport crptSum8 
      Left            =   6840
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "sum8.rpt"
      WindowTitle     =   "รายงานสรุปยอดการส่งออกเฉพาะประเทศ"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "เลิกการทำงาน"
      Height          =   495
      Left            =   6240
      TabIndex        =   26
      Top             =   5400
      Width           =   1215
   End
   Begin Crystal.CrystalReport crptSum7 
      Left            =   6360
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "sum7.rpt"
      WindowTitle     =   "รายงานสรุปยอดการส่งออกเฉพาะพืช"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptSum6 
      Left            =   5880
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "sum6.rpt"
      WindowTitle     =   "รายงานสรุปยอดการส่งออกเฉพาะกลุ่มพืช"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptSum5 
      Left            =   5400
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "sum5.rpt"
      WindowTitle     =   "รายงานสรุปยอดการส่งออกโดยทางรถไฟ"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptSum4 
      Left            =   4920
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "sum4.rpt"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptSum3 
      Left            =   4440
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "sum3.rpt"
      WindowTitle     =   "รายงานสรุปยอดการส่งออกโดยทางเรือ"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptSum1 
      Left            =   3480
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "sum1.rpt"
      WindowTitle     =   "รายงานสรุปยอดการส่งออกทั้งหมด"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptSum2 
      Left            =   3960
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "sum2.rpt"
      WindowTitle     =   "รายงานสรุปยอดการส่งออกทั้งหมดโดยละเอียด"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin VB.Frame Frame4 
      Caption         =   "รหัสประเทศที่ต้องการทำรายงาน"
      Height          =   1095
      Left            =   360
      TabIndex        =   23
      Top             =   4800
      Width           =   3255
      Begin VB.TextBox Text4 
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
         Left            =   1320
         TabIndex        =   24
         Top             =   480
         Width           =   1695
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "รหัสประเทศ :"
         Height          =   210
         Left            =   120
         TabIndex        =   25
         Top             =   480
         Width           =   945
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "รหัสกลุ่มพืช / พืชที่ต้องการทำรายงาน"
      Height          =   1695
      Left            =   360
      TabIndex        =   20
      Top             =   2880
      Width           =   3255
      Begin VB.TextBox Text5 
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
         Left            =   1320
         TabIndex        =   28
         Top             =   1080
         Width           =   1695
      End
      Begin VB.TextBox Text3 
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
         Left            =   1320
         TabIndex        =   21
         Top             =   480
         Width           =   1695
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "รหัสพืช :"
         Height          =   210
         Index           =   1
         Left            =   240
         TabIndex        =   27
         Top             =   1080
         Width           =   600
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "รหัสกลุ่มพืช :"
         Height          =   210
         Index           =   0
         Left            =   240
         TabIndex        =   22
         Top             =   480
         Width           =   900
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "ช่วงเวลาที่ทำการสรุป"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2295
      Left            =   3840
      TabIndex        =   7
      Top             =   2880
      Width           =   3855
      Begin VB.CommandButton Command1 
         Caption         =   "พิมพ์รายงาน"
         Height          =   495
         Left            =   2400
         TabIndex        =   11
         Top             =   1560
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
         Left            =   2400
         TabIndex        =   9
         Top             =   720
         Width           =   1095
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
         Height          =   375
         Left            =   360
         TabIndex        =   8
         Top             =   720
         Width           =   1095
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "( ปี,เดือน,วัน )"
         Height          =   210
         Index           =   3
         Left            =   1200
         TabIndex        =   19
         Top             =   1800
         Width           =   975
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "( ปี,เดือน,วัน )"
         Height          =   210
         Index           =   2
         Left            =   1200
         TabIndex        =   18
         Top             =   1560
         Width           =   975
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "1998,12,30"
         Height          =   210
         Index           =   1
         Left            =   360
         TabIndex        =   17
         Top             =   1800
         Width           =   780
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "1991,01,25"
         Height          =   210
         Index           =   0
         Left            =   360
         TabIndex        =   16
         Top             =   1560
         Width           =   765
      End
      Begin VB.Label Label4 
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
         Left            =   240
         TabIndex        =   15
         Top             =   1200
         Width           =   795
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "ถึงวันที่"
         Height          =   210
         Left            =   1680
         TabIndex        =   14
         Top             =   840
         Width           =   495
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "กรุณากรอกช่วงเวลาที่ต้องการจะทำรายงานสรุป :"
         Height          =   210
         Left            =   240
         TabIndex        =   10
         Top             =   360
         Width           =   3300
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "ประเภทของรายงานสรุป"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   360
      TabIndex        =   0
      Top             =   480
      Width           =   7335
      Begin VB.OptionButton Option8 
         Caption         =   "สรุปยอดการส่งออกเฉพาะประเทศ"
         Height          =   255
         Left            =   3720
         TabIndex        =   29
         Top             =   1440
         Width           =   2775
      End
      Begin VB.OptionButton Option7 
         Caption         =   "สรุปยอดการส่งออกเฉพาะพืช"
         Height          =   255
         Left            =   3720
         TabIndex        =   12
         Top             =   1080
         Width           =   2655
      End
      Begin VB.OptionButton Option6 
         Caption         =   "สรุปยอดการส่งออกเฉพาะกลุ่มพืช"
         Height          =   210
         Left            =   3720
         TabIndex        =   6
         Top             =   720
         Width           =   2775
      End
      Begin VB.OptionButton Option5 
         Caption         =   "สรุปยอดการส่งออกโดยทางรถไฟ"
         Height          =   210
         Left            =   3720
         TabIndex        =   5
         Top             =   360
         Width           =   2775
      End
      Begin VB.OptionButton Option4 
         Caption         =   "สรุปยอดการส่งออกโดยทางอากาศ"
         Height          =   255
         Left            =   240
         TabIndex        =   4
         Top             =   1440
         Width           =   2655
      End
      Begin VB.OptionButton Option3 
         Caption         =   "สรุปยอดการส่งออกโดยทางเรือ"
         Height          =   255
         Left            =   240
         TabIndex        =   3
         Top             =   1080
         Width           =   2535
      End
      Begin VB.OptionButton Option2 
         Caption         =   "สรุปยอดการส่งออกทั้งหมดโดยละเอียด"
         Height          =   210
         Left            =   240
         TabIndex        =   2
         Top             =   720
         Width           =   3015
      End
      Begin VB.OptionButton Option1 
         Caption         =   "สรุปยอดการส่งออกทั้งหมด"
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   360
         Width           =   2175
      End
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "กรุณาเลือกประเภทของรายงานที่ต้องการสรุป :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   13
      Top             =   120
      Width           =   3120
   End
End
Attribute VB_Name = "frmSumReport"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim str As String
Dim Opchk1, Opchk2, Opchk3, Opchk4, Opchk5, Opchk6 As Boolean
Private Sub cmdExit_Click()
    Unload Me
End Sub

Private Sub Command1_Click()
On Error GoTo ProcError
   
   '--------------------------------
    If Option1.Value = True Then
        crptSum1.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{ExportPlants.ExportDate} >= Date(" & Text1.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text2.Text & ")"
        crptSum1.SelectionFormula = str
        crptSum1.Action = 1
    End If
   '--------------------------------
    If Option2.Value = True Then
        crptSum2.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{ExportPlants.ExportDate} >= Date(" & Text1.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text2.Text & ")"
        crptSum2.SelectionFormula = str
        crptSum2.Action = 1
    End If
   '---------------------------------
    If Option3.Value = True Then
        crptSum3.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{ExportPlants.ExportDate} >= Date(" & Text1.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text2.Text & ")"
        crptSum3.SelectionFormula = str
        crptSum3.Action = 1
    End If
   '----------------------------------
   If Option4.Value = True Then
        crptSum4.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{ExportPlants.ExportDate} >= Date(" & Text1.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text2.Text & ")"
        crptSum4.SelectionFormula = str
        crptSum4.Action = 1
    End If
   '----------------------------------
   If Option5.Value = True Then
        crptSum5.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{ExportPlants.ExportDate} >= Date(" & Text1.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text2.Text & ")"
        crptSum5.SelectionFormula = str
        crptSum5.Action = 1
    End If
   '----------------------------------
   If Option6.Value = True Then
        crptSum6.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{ExportPlants.ExportDate} >= Date(" & Text1.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text2.Text & ")" & _
              "and {PlantsDetail.GroupID} = '" & Text3.Text & "' "
        crptSum6.SelectionFormula = str
        crptSum6.Action = 1
    End If
   '----------------------------------
   If Option7.Value = True Then
        crptSum7.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{ExportPlants.ExportDate} >= Date(" & Text1.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text2.Text & ")" & _
              "and {ExportPlants.PlantCode} = '" & Text5.Text & "' "
        crptSum7.SelectionFormula = str
        crptSum7.Action = 1
    End If
   '----------------------------------
   If Option8.Value = True Then
        crptSum8.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str = "{ExportPlants.ExportDate} >= Date(" & Text1.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text2.Text & ")" & _
              "and {Country.CountryNo} = '" & Text4.Text & "' "
        crptSum8.SelectionFormula = str
        crptSum8.Action = 1
    End If
   '----------------------------------
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

