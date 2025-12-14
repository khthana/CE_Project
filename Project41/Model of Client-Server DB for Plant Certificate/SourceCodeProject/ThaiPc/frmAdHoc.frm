VERSION 5.00
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Begin VB.Form frmAdHoc 
   Caption         =   "แบบฟอร์มค้นหาข้อมูลต่างๆ"
   ClientHeight    =   4380
   ClientLeft      =   2010
   ClientTop       =   1275
   ClientWidth     =   7620
   LinkTopic       =   "Form1"
   ScaleHeight     =   4380
   ScaleWidth      =   7620
   Begin Crystal.CrystalReport crptAd4 
      Left            =   6480
      Top             =   720
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "ad4.rpt"
      WindowTitle     =   "รายงานการค้นหาข้อมูลชนิดและปริมาณสินค้าที่ส่งออก( ตามผู้ส่งออก )"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptAd3 
      Left            =   5880
      Top             =   720
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "ad3.rpt"
      WindowTitle     =   "รายงานการค้นหาข้อมูลผู้นำเข้า"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin Crystal.CrystalReport crptAd2 
      Left            =   6480
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "ad2.rpt"
      WindowTitle     =   "รายงานการค้นหาข้อมูลผู้ส่งออก"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "เลิกการทำงาน"
      Height          =   495
      Left            =   6000
      TabIndex        =   15
      Top             =   3720
      Width           =   1455
   End
   Begin VB.Frame Frame2 
      Caption         =   "กรุณาเลือกข้อมูลที่ต้องการค้นหา"
      Height          =   1935
      Left            =   240
      TabIndex        =   4
      Top             =   2280
      Width           =   5535
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
         Height          =   315
         Left            =   3840
         TabIndex        =   16
         Top             =   1440
         Width           =   1455
      End
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
         Height          =   315
         Left            =   1680
         TabIndex        =   13
         Top             =   1440
         Width           =   1455
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
         Height          =   315
         Left            =   1680
         TabIndex        =   11
         Top             =   1080
         Width           =   1455
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
         Height          =   315
         Left            =   1680
         TabIndex        =   9
         Top             =   720
         Width           =   1455
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
         Height          =   315
         Left            =   1680
         TabIndex        =   7
         Top             =   360
         Width           =   1455
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
         Left            =   3360
         TabIndex        =   22
         Top             =   360
         Width           =   795
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "1991,01,25"
         Height          =   210
         Index           =   0
         Left            =   3480
         TabIndex        =   21
         Top             =   720
         Width           =   765
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "1998,12,30"
         Height          =   210
         Index           =   1
         Left            =   3480
         TabIndex        =   20
         Top             =   960
         Width           =   780
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "( ปี,เดือน,วัน )"
         Height          =   210
         Index           =   2
         Left            =   4320
         TabIndex        =   19
         Top             =   720
         Width           =   975
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "( ปี,เดือน,วัน )"
         Height          =   210
         Index           =   3
         Left            =   4320
         TabIndex        =   18
         Top             =   960
         Width           =   975
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "ถึงวันที่"
         Height          =   210
         Index           =   4
         Left            =   3240
         TabIndex        =   17
         Top             =   1440
         Width           =   495
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "วันที่ส่งออก :"
         Height          =   210
         Index           =   3
         Left            =   240
         TabIndex        =   14
         Top             =   1440
         Width           =   855
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "รหัสผู้นำเข้า :"
         Height          =   210
         Index           =   2
         Left            =   240
         TabIndex        =   12
         Top             =   1080
         Width           =   915
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "รหัสผู้ส่งออก :"
         Height          =   210
         Index           =   1
         Left            =   240
         TabIndex        =   10
         Top             =   720
         Width           =   930
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "รหัสใบรับรองพืช :"
         Height          =   210
         Index           =   0
         Left            =   240
         TabIndex        =   8
         Top             =   360
         Width           =   1245
      End
   End
   Begin VB.CommandButton cmdPrint 
      Caption         =   "ค้นหาและพิมพ์"
      Height          =   495
      Left            =   6000
      TabIndex        =   2
      Top             =   3000
      Width           =   1455
   End
   Begin VB.Frame Frame1 
      Caption         =   "กรุณาเลือกชนิดของข้อมูลที่ต้องการค้นหา"
      Height          =   2055
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   5535
      Begin VB.OptionButton Option3 
         Caption         =   "ค้นหาข้อมูลผู้นำเข้า"
         Height          =   210
         Left            =   360
         TabIndex        =   6
         Top             =   1110
         Width           =   2175
      End
      Begin VB.OptionButton Option4 
         Caption         =   "ค้นหาชนิดและปริมาณสินค้าที่ส่งออก ( ตามผู้ส่งออก )"
         Height          =   210
         Left            =   360
         TabIndex        =   5
         Top             =   1500
         Width           =   3975
      End
      Begin VB.OptionButton Option1 
         Caption         =   "ค้นหาข้อมูลใบรับรอง"
         Height          =   210
         Left            =   360
         TabIndex        =   1
         Top             =   360
         Width           =   2055
      End
      Begin VB.OptionButton Option2 
         Caption         =   "ค้นหาข้อมูลผู้ส่งออก"
         Height          =   255
         Left            =   360
         TabIndex        =   3
         Top             =   720
         Width           =   2055
      End
   End
   Begin Crystal.CrystalReport crptAd1 
      Left            =   5880
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "ad1.rpt"
      WindowTitle     =   "รายงานการค้นหาข้อมูลใบรับรอง"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
End
Attribute VB_Name = "frmAdHoc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim str1, str2 As String
Private Sub cmdExit_Click()
    Unload Me
End Sub
Private Sub cmdPrint_Click()
On Error GoTo ProcError
   
   '--------------------------------
   If Option1.Value = True Then
        crptAd1.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str1 = "{Applications.RefNo} = '" & Text1.Text & "' "
        crptAd1.SelectionFormula = str1
        crptAd1.Action = 1
   End If
   '--------------------------------
   If Option2.Value = True Then
        crptAd2.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str1 = "{Exporter.ExporterNumber} = '" & Text2.Text & "' "
        crptAd2.SelectionFormula = str1
        crptAd2.Action = 1
   End If
   '--------------------------------
   If Option3.Value = True Then
        crptAd3.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str1 = "{Consignee.ConsigneeNumber} = '" & Text3.Text & "' "
        crptAd3.SelectionFormula = str1
        crptAd3.Action = 1
   End If
   '--------------------------------
   If Option4.Value = True Then
        crptAd4.Connect = "DSN = DBProject;UID = sa;PWD = thaipc ;DSQ = "
        str1 = "{Exporter.ExporterNumber} = '" & Text2.Text & "'  and {ExportPlants.ExportDate} >= Date(" & Text4.Text & ")" & _
              "and {ExportPlants.ExportDate} <= Date(" & Text5.Text & ")"
        crptAd4.SelectionFormula = str1
        crptAd4.Action = 1
   End If
   '--------------------------------

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
