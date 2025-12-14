VERSION 5.00
Begin VB.Form frmSearchFile 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Digital Library"
   ClientHeight    =   3930
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6225
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3930
   ScaleWidth      =   6225
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton btnCancel 
      Caption         =   "ยกเลิก"
      Height          =   375
      Left            =   5280
      TabIndex        =   1
      Top             =   600
      Width           =   855
   End
   Begin VB.CommandButton btnSave 
      Caption         =   "ตกลง"
      Height          =   375
      Left            =   5280
      TabIndex        =   0
      Top             =   120
      Width           =   855
   End
   Begin VB.Frame Frame1 
      Height          =   3855
      Left            =   120
      TabIndex        =   6
      Top             =   0
      Width           =   5055
      Begin VB.ComboBox cmbTypeFile 
         Height          =   330
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   3360
         Width           =   2295
      End
      Begin VB.DriveListBox Drive1 
         Height          =   330
         Left            =   2640
         TabIndex        =   2
         Top             =   3360
         Width           =   2295
      End
      Begin VB.DirListBox Dir1 
         Height          =   1770
         Left            =   2640
         TabIndex        =   3
         Top             =   1080
         Width           =   2295
      End
      Begin VB.FileListBox File1 
         Height          =   1770
         Left            =   120
         TabIndex        =   5
         Top             =   1080
         Width           =   2295
      End
      Begin VB.TextBox txtFilePaper 
         Height          =   375
         Left            =   120
         TabIndex        =   7
         Top             =   600
         Width           =   2295
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ไดร์ฟ"
         Height          =   210
         Left            =   2640
         TabIndex        =   12
         Top             =   3000
         Width           =   405
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ประเภทไฟล์บทความ"
         Height          =   210
         Left            =   120
         TabIndex        =   11
         Top             =   3000
         Width           =   1440
      End
      Begin VB.Label LabelPath 
         BackStyle       =   0  'Transparent
         Caption         =   "Path"
         Height          =   210
         Left            =   2640
         TabIndex        =   10
         Top             =   600
         Width           =   2265
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ไดเรกเทอรี"
         Height          =   210
         Left            =   2640
         TabIndex        =   9
         Top             =   240
         Width           =   825
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "ชื่อไฟล์บทความ"
         Height          =   210
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   1080
      End
   End
End
Attribute VB_Name = "frmSearchFile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim TypeFile As String

Private Sub btnCancel_Click()

    frmPaper.ClickbtnSearchFile = False
    Unload Me

End Sub

Private Sub btnSave_Click()

    frmPaper.FileName = txtFilePaper.Text
    frmPaper.txtFilePaper.Text = txtFilePaper.Text
    frmPaper.PathName = LabelPath.Caption
    frmPaper.ClickbtnSearchFile = True
    Unload Me
    
End Sub

Private Sub cmbTypeFile_Click()

    Call CheckTypeFile
    
End Sub

Private Sub Dir1_Change()

     File1.Path = Dir1.Path
    LabelPath.Caption = Dir1.Path
    
End Sub

Private Sub Drive1_Change()

    Dir1.Path = Drive1.Drive
    
End Sub

Private Sub File1_Click()

    txtFilePaper.Text = File1.FileName
    
End Sub

Private Sub Form_Load()

    frmSearchFile.Icon = LoadPicture(App.Path & "\Icon.ico")
    
    'กำหนดไดร์ฟ
    Drive1.Drive = App.Path
    
    'Clear ข้อมูล
    txtFilePaper.Text = ""
    
    'Disable ช่องรับข้อมูล
    txtFilePaper.Enabled = False
    
    'แสดงประเภทไฟล์บทความ
    Call AddTypeFile
    cmbTypeFile.Text = cmbTypeFile.List(0)
    
End Sub

Private Sub AddTypeFile()

    cmbTypeFile.AddItem ("Acrobat (*.Pdf)")
    cmbTypeFile.AddItem ("Microsoft Word (*.Doc)")
    cmbTypeFile.AddItem ("All File (*.*)")
    
End Sub

Private Sub CheckTypeFile()

    If cmbTypeFile.Text = "Acrobat (*.Pdf)" Then
        File1.Pattern = "*.Pdf"
    ElseIf cmbTypeFile.Text = "Microsoft Word (*.Doc)" Then
        File1.Pattern = "*.Doc"
    ElseIf cmbTypeFile.Text = "All File (*.*)" Then
        File1.Pattern = "*.*"
    End If
    
End Sub
