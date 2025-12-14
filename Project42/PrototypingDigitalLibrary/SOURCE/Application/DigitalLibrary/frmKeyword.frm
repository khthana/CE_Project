VERSION 5.00
Begin VB.Form frmKeyword 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Digital Library"
   ClientHeight    =   3195
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4905
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3195
   ScaleWidth      =   4905
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
      Begin VB.CheckBox chkKeyword1 
         Caption         =   "คำค้นที่ 1"
         Height          =   330
         Left            =   240
         TabIndex        =   1
         Top             =   240
         Width           =   1215
      End
      Begin VB.CheckBox chkKeyword2 
         Caption         =   "คำค้นที่ 2"
         Height          =   330
         Left            =   240
         TabIndex        =   3
         Top             =   720
         Width           =   1215
      End
      Begin VB.CheckBox chkKeyword3 
         Caption         =   "คำค้นที่ 3"
         Height          =   330
         Left            =   240
         TabIndex        =   5
         Top             =   1200
         Width           =   1215
      End
      Begin VB.CheckBox chkKeyword4 
         Caption         =   "คำค้นที่ 4"
         Height          =   330
         Left            =   240
         TabIndex        =   7
         Top             =   1680
         Width           =   1215
      End
      Begin VB.CheckBox chkKeyword5 
         Caption         =   "คำค้นที่ 5"
         Height          =   330
         Left            =   240
         TabIndex        =   9
         Top             =   2160
         Width           =   1215
      End
      Begin VB.TextBox txtKeyword1 
         Height          =   375
         Left            =   1560
         TabIndex        =   2
         Top             =   240
         Width           =   3015
      End
      Begin VB.TextBox txtKeyword2 
         Height          =   375
         Left            =   1560
         TabIndex        =   4
         Top             =   720
         Width           =   3015
      End
      Begin VB.TextBox txtKeyword3 
         Height          =   375
         Left            =   1560
         TabIndex        =   6
         Top             =   1200
         Width           =   3015
      End
      Begin VB.TextBox txtKeyword4 
         Height          =   375
         Left            =   1560
         TabIndex        =   8
         Top             =   1680
         Width           =   3015
      End
      Begin VB.TextBox txtKeyword5 
         Height          =   375
         Left            =   1560
         TabIndex        =   10
         Top             =   2160
         Width           =   3015
      End
   End
End
Attribute VB_Name = "frmKeyword"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub btnPaper_Click()

    Unload Me

End Sub

Private Sub chkKeyword1_Click()

    'เช็คการคลิกที่ช่อง chkKeyword1
    If chkKeyword1.Value = 1 Then
        txtKeyword1.Enabled = True
    Else
        txtKeyword1.Enabled = False
    End If
    
End Sub

Private Sub chkKeyword2_Click()

    'เช็คการคลิกที่ช่อง chkKeyword2
    If chkKeyword2.Value = 1 Then
        txtKeyword2.Enabled = True
    Else
        txtKeyword2.Enabled = False
    End If
    
End Sub

Private Sub chkKeyword3_Click()

    'เช็คการคลิกที่ช่อง chkKeyword3
    If chkKeyword3.Value = 1 Then
        txtKeyword3.Enabled = True
    Else
        txtKeyword3.Enabled = False
    End If
    
End Sub

Private Sub chkKeyword4_Click()

    'เช็คการคลิกที่ช่อง chkKeyword4
    If chkKeyword4.Value = 1 Then
        txtKeyword4.Enabled = True
    Else
        txtKeyword4.Enabled = False
    End If
    
End Sub

Private Sub chkKeyword5_Click()

    'เช็คการคลิกที่ช่อง chkKeyword5
    If chkKeyword5.Value = 1 Then
        txtKeyword5.Enabled = True
    Else
        txtKeyword5.Enabled = False
    End If
    
End Sub

Private Sub Form_Load()

    frmKeyword.Icon = LoadPicture(App.Path & "\Icon.ico")
    
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
        
        'เช็คสถานะของ chkKeyword
        Call CheckStatus
    End If
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

    'เช็ค PaperDyn อยู่ในสถานะ Add หรือ Edit
    If (frmPaper.PaperDyn.EditMode = dbEditAdd) Or (frmPaper.PaperDyn.EditMode = dbEditInProgress) Then
        If chkKeyword1.Value = 1 Then
            frmPaper.PaperDyn.Fields("Keyword1") = Trim(txtKeyword1.Text)
        Else
            frmPaper.PaperDyn.Fields("Keyword1") = ""
        End If
        
        If chkKeyword2.Value = 1 Then
            frmPaper.PaperDyn.Fields("Keyword2") = Trim(txtKeyword2.Text)
        Else
            frmPaper.PaperDyn.Fields("Keyword2") = ""
        End If
        
        If chkKeyword3.Value = 1 Then
            frmPaper.PaperDyn.Fields("Keyword3") = Trim(txtKeyword3.Text)
        Else
            frmPaper.PaperDyn.Fields("Keyword3") = ""
        End If
        
        If chkKeyword4.Value = 1 Then
            frmPaper.PaperDyn.Fields("Keyword4") = Trim(txtKeyword4.Text)
        Else
            frmPaper.PaperDyn.Fields("Keyword4") = ""
        End If
        
        If chkKeyword5.Value = 1 Then
            frmPaper.PaperDyn.Fields("Keyword5") = Trim(txtKeyword5.Text)
        Else
            frmPaper.PaperDyn.Fields("Keyword5") = ""
        End If
    End If
    
    Call frmPaper.CheckKeyword
    
End Sub

Private Sub EnableTxt(EnableFlag As Boolean)

    'Enable หรือ Disable ช่องรับข้อมูล
    chkKeyword1.Enabled = EnableFlag
    chkKeyword2.Enabled = EnableFlag
    chkKeyword3.Enabled = EnableFlag
    chkKeyword4.Enabled = EnableFlag
    chkKeyword5.Enabled = EnableFlag
    txtKeyword1.Enabled = EnableFlag
    txtKeyword2.Enabled = EnableFlag
    txtKeyword3.Enabled = EnableFlag
    txtKeyword4.Enabled = EnableFlag
    txtKeyword5.Enabled = EnableFlag
    
End Sub

Private Sub ClearData()

    txtKeyword1.Text = ""
    txtKeyword2.Text = ""
    txtKeyword3.Text = ""
    txtKeyword4.Text = ""
    txtKeyword5.Text = ""
    
End Sub

Private Sub DisplayFields()

    txtKeyword1.Text = frmPaper.PaperDyn.Fields("Keyword1")
    txtKeyword2.Text = frmPaper.PaperDyn.Fields("Keyword2")
    txtKeyword3.Text = frmPaper.PaperDyn.Fields("Keyword3")
    txtKeyword4.Text = frmPaper.PaperDyn.Fields("Keyword4")
    txtKeyword5.Text = frmPaper.PaperDyn.Fields("Keyword5")
    
End Sub

Private Sub CheckText()

    If txtKeyword1.Text <> "" Then
        chkKeyword1.Value = 1
    Else
        chkKeyword1.Value = 0
    End If
    
    If txtKeyword2.Text <> "" Then
        chkKeyword2.Value = 1
    Else
        chkKeyword2.Value = 0
    End If
    
    If txtKeyword3.Text <> "" Then
        chkKeyword3.Value = 1
    Else
        chkKeyword3.Value = 0
    End If
    
    If txtKeyword4.Text <> "" Then
        chkKeyword4.Value = 1
    Else
        chkKeyword4.Value = 0
    End If
    
    If txtKeyword5.Text <> "" Then
        chkKeyword5.Value = 1
    Else
        chkKeyword5.Value = 0
    End If
    
End Sub

Private Sub CheckStatus()

    'เช็คสถานะของ chkKeyword
    Call chkKeyword1_Click
    Call chkKeyword2_Click
    Call chkKeyword3_Click
    Call chkKeyword4_Click
    Call chkKeyword5_Click
    
End Sub
