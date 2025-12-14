VERSION 5.00
Begin VB.Form frmAbstract 
   Caption         =   "Digital Library"
   ClientHeight    =   3915
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5025
   LinkTopic       =   "Form1"
   ScaleHeight     =   3915
   ScaleWidth      =   5025
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton btnPaper 
      Caption         =   "กลับไปหน้าจอบทความ"
      Height          =   375
      Left            =   3120
      TabIndex        =   0
      Top             =   3480
      Width           =   1815
   End
   Begin VB.Frame Frame1 
      Height          =   3375
      Left            =   120
      TabIndex        =   5
      Top             =   0
      Width           =   4815
      Begin VB.TextBox txtEngAbstract 
         Height          =   1455
         Left            =   1080
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   4
         Top             =   1800
         Width           =   3615
      End
      Begin VB.TextBox txtThaiAbstract 
         Height          =   1455
         Left            =   1080
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   2
         Top             =   240
         Width           =   3615
      End
      Begin VB.CheckBox chkEngAbstract 
         Caption         =   "Abstract"
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   1800
         Width           =   975
      End
      Begin VB.CheckBox chkThaiAbstract 
         Caption         =   "บทคัดย่อ"
         Height          =   375
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   975
      End
   End
End
Attribute VB_Name = "frmAbstract"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub btnPaper_Click()
    
    Unload Me
    
End Sub

Private Sub chkEngAbstract_Click()

    'เช็คการคลิกที่ช่อง chkEngAbstract
    If chkEngAbstract.Value = 1 Then
        txtEngAbstract.Enabled = True
    Else
        txtEngAbstract.Enabled = False
    End If
    
End Sub

Private Sub chkThaiAbstract_Click()

    'เช็คการคลิกที่ช่อง chkThaiAbstract
    If chkThaiAbstract.Value = 1 Then
        txtThaiAbstract.Enabled = True
    Else
        txtThaiAbstract.Enabled = False
    End If
    
End Sub

Private Sub Form_Load()

    frmAbstract.Icon = LoadPicture(App.Path & "\Icon.ico")
    
    'แสดงข้อมูลบนหน้าจอ
    Call DisplayFields
    
    'Disable ช่องรับข้อมูล
    Call EnableTxt(False)
    
    'เช็ค PaperDyn อยู่ในสถานะ Add หรือ Edit
    If (frmPaper.PaperDyn.EditMode = dbEditAdd) Or (frmPaper.PaperDyn.EditMode = dbEditInProgress) Then
        'Enable ช่องรับข้อมูล
        Call EnableTxt(True)
        
        'เช็คข้อความบนหน้าจอ
        Call CheckText
        
        'เช็คสถานะของ chkAuthor
        Call CheckStatus
    End If
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

    'เช็ค PaperDyn เมื่ออยู่ในสถานะ Add หรือ Edit
    If (frmPaper.PaperDyn.EditMode = dbEditAdd) Or (frmPaper.PaperDyn.EditMode = dbEditInProgress) Then
        If chkThaiAbstract.Value = 1 Then
            frmPaper.PaperDyn.Fields("ThaiAbstract") = Trim(txtThaiAbstract.Text)
        Else
            frmPaper.PaperDyn.Fields("ThaiAbstract") = ""
        End If
        
        If chkEngAbstract.Value = 1 Then
            frmPaper.PaperDyn.Fields("EngAbstract") = Trim(txtEngAbstract.Text)
        Else
            frmPaper.PaperDyn.Fields("EngAbstract") = ""
        End If
    End If
    
    'แสดงบทคัดย่อ
    Call frmPaper.CheckAbstract
    
End Sub

Private Sub EnableTxt(EnableFlag As Boolean)

    'Enable หรือ Disable ช่องรับข้อมูล
    chkThaiAbstract.Enabled = EnableFlag
    chkEngAbstract.Enabled = EnableFlag
    txtThaiAbstract.Enabled = EnableFlag
    txtEngAbstract.Enabled = EnableFlag
    
End Sub

Private Sub ClearData()

    txtThaiAbstract.Text = ""
    txtEngAbstract.Text = ""
    
End Sub

Private Sub DisplayFields()

    txtThaiAbstract.Text = frmPaper.PaperDyn.Fields("ThaiAbstract")
    'txtThaiAbstract.Text = frmPaper.PaperDyn.Fields("ThaiAbstract")
    txtEngAbstract.Text = frmPaper.PaperDyn.Fields("EngAbstract")
    
End Sub

Private Sub CheckText()

    If txtThaiAbstract.Text <> "" Then
        chkThaiAbstract.Value = 1
    Else
        chkThaiAbstract.Value = 0
    End If
    
    If txtEngAbstract.Text <> "" Then
        chkEngAbstract.Value = 1
    Else
        chkEngAbstract.Value = 0
    End If
    
End Sub

Private Sub CheckStatus()

    'เช็คสถานะของ chkAbstract
    Call chkThaiAbstract_Click
    Call chkEngAbstract_Click
    
End Sub
