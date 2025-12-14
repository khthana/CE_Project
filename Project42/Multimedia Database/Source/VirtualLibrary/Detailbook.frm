VERSION 5.00
Begin VB.Form DetailBook 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "รายละเอียดของรายการค้นหา"
   ClientHeight    =   5175
   ClientLeft      =   975
   ClientTop       =   2670
   ClientWidth     =   10275
   FillColor       =   &H008080FF&
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   222
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Detailbook.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5175
   ScaleWidth      =   10275
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command2 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Back"
      Height          =   435
      Left            =   8760
      Style           =   1  'Graphical
      TabIndex        =   30
      ToolTipText     =   "กลับไปหน้าผลการค้นหา"
      Top             =   2040
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Location.."
      Height          =   435
      Index           =   1
      Left            =   8760
      MaskColor       =   &H80000000&
      Style           =   1  'Graphical
      TabIndex        =   29
      ToolTipText     =   "ตำแหน่งของหนังสือในห้องสมุด"
      Top             =   1200
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Caption         =   "ภาพตัวอย่างหน้าปกหนังสือ"
      ForeColor       =   &H00008000&
      Height          =   4035
      Left            =   5160
      TabIndex        =   28
      Top             =   120
      Width           =   3135
      Begin VB.Image Image1 
         BorderStyle     =   1  'Fixed Single
         Height          =   3435
         Left            =   180
         Stretch         =   -1  'True
         Top             =   420
         Width           =   2775
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "ที่อยู่ของหนังสือ"
      ForeColor       =   &H00008000&
      Height          =   795
      Left            =   5160
      TabIndex        =   1
      Top             =   4200
      Width           =   4935
      Begin VB.Label Label2 
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   255
         Index           =   12
         Left            =   3840
         TabIndex        =   27
         Top             =   360
         Width           =   855
      End
      Begin VB.Label Label2 
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   255
         Index           =   11
         Left            =   2460
         TabIndex        =   24
         Top             =   360
         Width           =   735
      End
      Begin VB.Label Label2 
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   255
         Index           =   10
         Left            =   1140
         TabIndex        =   19
         Top             =   360
         Width           =   795
      End
      Begin VB.Label Label1 
         Caption         =   "ห้อง"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   10
         Left            =   3300
         TabIndex        =   11
         Top             =   360
         Width           =   435
      End
      Begin VB.Label Label1 
         Caption         =   "ชั้นที่"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   8
         Left            =   1980
         TabIndex        =   10
         Top             =   360
         Width           =   435
      End
      Begin VB.Label Label1 
         Caption         =   "ตู้หนังสือ"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   7
         Left            =   300
         TabIndex        =   9
         Top             =   360
         Width           =   795
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "รายละเอียดของหนังสือ"
      ForeColor       =   &H00008000&
      Height          =   4875
      Left            =   180
      TabIndex        =   0
      Top             =   120
      Width           =   4755
      Begin VB.Label Label1 
         Caption         =   "ID"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   13
         Left            =   360
         TabIndex        =   26
         Top             =   360
         Width           =   555
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   9
         Left            =   1740
         TabIndex        =   25
         Top             =   4320
         Width           =   2010
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   8
         Left            =   1740
         TabIndex        =   23
         Top             =   3855
         Width           =   1950
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   7
         Left            =   1740
         TabIndex        =   22
         Top             =   3420
         Width           =   2070
      End
      Begin VB.Label Label1 
         Caption         =   "ชื่อผู้แต่ง 3"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   12
         Left            =   360
         TabIndex        =   21
         Top             =   2520
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "ชื่อผู้แต่ง 2"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   11
         Left            =   360
         TabIndex        =   20
         Top             =   2078
         Width           =   855
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   6
         Left            =   1740
         TabIndex        =   18
         Top             =   2970
         Width           =   2070
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   5
         Left            =   1740
         TabIndex        =   17
         Top             =   2520
         Width           =   2370
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   4
         Left            =   1740
         TabIndex        =   16
         Top             =   2085
         Width           =   2430
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   3
         Left            =   1740
         TabIndex        =   15
         Top             =   1620
         Width           =   2610
         WordWrap        =   -1  'True
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   2
         Left            =   1740
         TabIndex        =   14
         Top             =   1200
         Width           =   2490
         WordWrap        =   -1  'True
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   1
         Left            =   1740
         TabIndex        =   13
         Top             =   780
         Width           =   2130
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Label2"
         ForeColor       =   &H000000C0&
         Height          =   195
         Index           =   0
         Left            =   1740
         TabIndex        =   12
         Top             =   360
         Width           =   570
      End
      Begin VB.Label Label1 
         Caption         =   "ประเภทหนังสือ"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   6
         Left            =   360
         TabIndex        =   8
         Top             =   2970
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "ISBN"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   5
         Left            =   360
         TabIndex        =   7
         Top             =   4320
         Width           =   555
      End
      Begin VB.Label Label1 
         Caption         =   "ปีที่พิมพ์"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   4
         Left            =   360
         TabIndex        =   6
         Top             =   3850
         Width           =   735
      End
      Begin VB.Label Label1 
         Caption         =   "สำนักพิมพ์"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   3
         Left            =   360
         TabIndex        =   5
         Top             =   3420
         Width           =   975
      End
      Begin VB.Label Label1 
         Caption         =   "ชื่อผู้แต่ง 1"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   2
         Left            =   360
         TabIndex        =   4
         Top             =   1620
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "ชื่อหนังสือ"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   1
         Left            =   360
         TabIndex        =   3
         Top             =   1200
         Width           =   795
      End
      Begin VB.Label Label1 
         Caption         =   "รหัสหนังสือ"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   0
         Left            =   360
         TabIndex        =   2
         Top             =   780
         Width           =   915
      End
   End
End
Attribute VB_Name = "DetailBook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim FileImage As String
Public Filepreface As String
Private Sub Command1_Click(Index As Integer)
If Index = 0 Then
MainScreen.oDataGroupBook.DeleteVirtualTable ("oVTableDetail")
End If
DetailBook.Hide
Load ShowLibrary
ShowLibrary.Show
End Sub
Private Sub Command2_Click()
Unload Me
Result.Show
End Sub
Private Sub Form_Load()
For a% = 0 To 12
If (Result.oVTableDetail.Columns(a% + 1).Value = "") Then
Label2(a%).Caption = "ไม่มีข้อมูล"
Else:
Label2(a%).Caption = Result.oVTableDetail.Columns(a% + 1).Value
End If
Next a%
FileImage = Mid(Result.oVTableDetail.Columns(a% + 1).Value, 2, 11)
If Result.oVTableDetail.Columns(18).Value <> "" Then
Filepreface = Mid(Result.oVTableDetail.Columns(18).Value, 2, 11)
End If
Image1.Picture = LoadPicture(FileImage)
End Sub
Private Sub Form_Unload(Cancel As Integer)
Result.StatusBar1.SimpleText = "กำลังรายงานผล"
FileSystem.Kill (FileImage)
If Result.oVTableDetail.Columns(18).Value <> "" Then
FileSystem.Kill (Filepreface)
End If
End Sub

Private Sub Image1_Click()
If Result.oVTableDetail.Columns(18).Value <> "" Then
Me.Hide
Load Showpreface
Showpreface.Show
Else: MsgBox "ไม่มีข้อมูลหน้า Preface", , "ไม่มีข้อมูล"
End If
End Sub

