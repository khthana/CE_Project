VERSION 5.00
Begin VB.Form frmAuthor 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Digital Library"
   ClientHeight    =   3195
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4875
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3195
   ScaleWidth      =   4875
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton btnPaper 
      Caption         =   "กลับไปหน้าจอบทความ"
      Height          =   375
      Left            =   3000
      TabIndex        =   0
      Top             =   2760
      Width           =   1815
   End
   Begin VB.Frame Frame1 
      Height          =   2655
      Left            =   120
      TabIndex        =   11
      Top             =   0
      Width           =   4695
      Begin VB.TextBox txtAuthor5 
         Height          =   375
         Left            =   1560
         TabIndex        =   10
         Top             =   2160
         Width           =   3015
      End
      Begin VB.TextBox txtAuthor4 
         Height          =   375
         Left            =   1560
         TabIndex        =   8
         Top             =   1680
         Width           =   3015
      End
      Begin VB.TextBox txtAuthor3 
         Height          =   375
         Left            =   1560
         TabIndex        =   6
         Top             =   1200
         Width           =   3015
      End
      Begin VB.TextBox txtAuthor2 
         Height          =   375
         Left            =   1560
         TabIndex        =   4
         Top             =   720
         Width           =   3015
      End
      Begin VB.TextBox txtAuthor1 
         Height          =   375
         Left            =   1560
         TabIndex        =   2
         Top             =   240
         Width           =   3015
      End
      Begin VB.CheckBox chkAuthor5 
         Caption         =   "ผู้แต่งคนที่ 5"
         Height          =   330
         Left            =   240
         TabIndex        =   9
         Top             =   2160
         Width           =   1215
      End
      Begin VB.CheckBox chkAuthor4 
         Caption         =   "ผู้แต่งคนที่ 4"
         Height          =   330
         Left            =   240
         TabIndex        =   7
         Top             =   1680
         Width           =   1215
      End
      Begin VB.CheckBox chkAuthor3 
         Caption         =   "ผู้แต่งคนที่ 3"
         Height          =   330
         Left            =   240
         TabIndex        =   5
         Top             =   1200
         Width           =   1215
      End
      Begin VB.CheckBox chkAuthor2 
         Caption         =   "ผู้แต่งคนที่ 2"
         Height          =   330
         Left            =   240
         TabIndex        =   3
         Top             =   720
         Width           =   1215
      End
      Begin VB.CheckBox chkAuthor1 
         Caption         =   "ผู้แต่งคนที่ 1"
         Height          =   330
         Left            =   240
         TabIndex        =   1
         Top             =   240
         Width           =   1215
      End
   End
End
Attribute VB_Name = "frmAuthor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub btnPaper_Click()

    Unload Me

End Sub

Private Sub chkAuthor1_Click()

    'เช็คการคลิกที่ช่อง chkAuthor1
    If chkAuthor1.Value = 1 Then
        txtAuthor1.Enabled = True
    Else
        txtAuthor1.Enabled = False
    End If
    
End Sub

Private Sub chkAuthor2_Click()

    'เช็คการคลิกที่ช่อง chkAuthor2
    If chkAuthor2.Value = 1 Then
        txtAuthor2.Enabled = True
    Else
        txtAuthor2.Enabled = False
    End If
    
End Sub

Private Sub chkAuthor3_Click()

    'เช็คการคลิกที่ช่อง chkAuthor3
    If chkAuthor3.Value = 1 Then
        txtAuthor3.Enabled = True
    Else
        txtAuthor3.Enabled = False
    End If
    
End Sub

Private Sub chkAuthor4_Click()

    'เช็คการคลิกที่ช่อง chkAuthor4
    If chkAuthor4.Value = 1 Then
        txtAuthor4.Enabled = True
    Else
        txtAuthor4.Enabled = False
    End If
    
End Sub

Private Sub chkAuthor5_Click()

    'เช็คการคลิกที่ช่อง chkAuthor5
    If chkAuthor5.Value = 1 Then
        txtAuthor5.Enabled = True
    Else
        txtAuthor5.Enabled = False
    End If
    
End Sub

Private Sub Form_Load()

    frmAuthor.Icon = LoadPicture(App.Path & "\Icon.ico")
    
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
        If chkAuthor1.Value = 1 Then
            frmPaper.PaperDyn.Fields("Author1") = Trim(txtAuthor1.Text)
        Else
            frmPaper.PaperDyn.Fields("Author1") = ""
        End If
        
        If chkAuthor2.Value = 1 Then
            frmPaper.PaperDyn.Fields("Author2") = Trim(txtAuthor2.Text)
        Else
            frmPaper.PaperDyn.Fields("Author2") = ""
        End If
        
        If chkAuthor3.Value = 1 Then
            frmPaper.PaperDyn.Fields("Author3") = Trim(txtAuthor3.Text)
        Else
            frmPaper.PaperDyn.Fields("Author3") = ""
        End If
        
        If chkAuthor4.Value = 1 Then
            frmPaper.PaperDyn.Fields("Author4") = Trim(txtAuthor4.Text)
        Else
            frmPaper.PaperDyn.Fields("Author4") = ""
        End If
        
        If chkAuthor5.Value = 1 Then
            frmPaper.PaperDyn.Fields("Author5") = Trim(txtAuthor5.Text)
        Else
            frmPaper.PaperDyn.Fields("Author5") = ""
        End If
    End If
    
    Call frmPaper.CheckAuthor

End Sub

Private Sub EnableTxt(EnableFlag As Boolean)

    'Enable หรือ Disable ช่องรับข้อมูล
    chkAuthor1.Enabled = EnableFlag
    chkAuthor2.Enabled = EnableFlag
    chkAuthor3.Enabled = EnableFlag
    chkAuthor4.Enabled = EnableFlag
    chkAuthor5.Enabled = EnableFlag
    txtAuthor1.Enabled = EnableFlag
    txtAuthor2.Enabled = EnableFlag
    txtAuthor3.Enabled = EnableFlag
    txtAuthor4.Enabled = EnableFlag
    txtAuthor5.Enabled = EnableFlag
    
End Sub

Private Sub ClearData()

    txtAuthor1.Text = ""
    txtAuthor2.Text = ""
    txtAuthor3.Text = ""
    txtAuthor4.Text = ""
    txtAuthor5.Text = ""
    
End Sub

Private Sub DisplayFields()

    txtAuthor1.Text = frmPaper.PaperDyn.Fields("Author1")
    txtAuthor2.Text = frmPaper.PaperDyn.Fields("Author2")
    txtAuthor3.Text = frmPaper.PaperDyn.Fields("Author3")
    txtAuthor4.Text = frmPaper.PaperDyn.Fields("Author4")
    txtAuthor5.Text = frmPaper.PaperDyn.Fields("Author5")
    
End Sub

Private Sub CheckText()

    If txtAuthor1.Text <> "" Then
        chkAuthor1.Value = 1
    Else
        chkAuthor1.Value = 0
    End If
    
    If txtAuthor2.Text <> "" Then
        chkAuthor2.Value = 1
    Else
        chkAuthor2.Value = 0
    End If
    
    If txtAuthor3.Text <> "" Then
        chkAuthor3.Value = 1
    Else
        chkAuthor3.Value = 0
    End If
    
    If txtAuthor4.Text <> "" Then
        chkAuthor4.Value = 1
    Else
        chkAuthor4.Value = 0
    End If
    
    If txtAuthor5.Text <> "" Then
        chkAuthor5.Value = 1
    Else
        chkAuthor5.Value = 0
    End If
    
End Sub

Private Sub CheckStatus()

    'เช็คสถานะของ chkAuthor
    Call chkAuthor1_Click
    Call chkAuthor2_Click
    Call chkAuthor3_Click
    Call chkAuthor4_Click
    Call chkAuthor5_Click
    
End Sub

