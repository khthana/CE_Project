VERSION 5.00
Begin VB.Form Form5 
   Caption         =   "Confirm Insert"
   ClientHeight    =   2400
   ClientLeft      =   4065
   ClientTop       =   3810
   ClientWidth     =   3855
   LinkTopic       =   "Form5"
   ScaleHeight     =   2400
   ScaleWidth      =   3855
   Visible         =   0   'False
   Begin VB.CommandButton Command2 
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   2160
      TabIndex        =   5
      Top             =   1920
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&OK"
      Height          =   375
      Left            =   720
      TabIndex        =   4
      Top             =   1920
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Caption         =   "Select"
      Height          =   1095
      Left            =   240
      TabIndex        =   1
      Top             =   600
      Width           =   3375
      Begin VB.OptionButton Option2 
         Caption         =   "I don't want to insert next record"
         Height          =   375
         Left            =   360
         TabIndex        =   3
         Top             =   600
         Width           =   2775
      End
      Begin VB.OptionButton Option1 
         Caption         =   "I want to insert next record"
         Height          =   375
         Left            =   360
         TabIndex        =   2
         Top             =   240
         Width           =   2295
      End
   End
   Begin VB.Image Image1 
      Height          =   600
      Left            =   120
      Picture         =   "Form5.frx":0000
      Top             =   0
      Width           =   705
   End
   Begin VB.Label Label1 
      Caption         =   "Are you sure to insert this data?                             and"
      Height          =   615
      Left            =   840
      TabIndex        =   0
      Top             =   240
      Width           =   2535
   End
End
Attribute VB_Name = "Form5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    If (Form1.TabStrip1.SelectedItem.Index - 1) = 0 Then
        Form1.Save_link
        Form1.record_regis.MoveLast
        Form1.Label5.Caption = Form1.record_regis.RecordCount
        
        If Option1.Value = True Then
            Form1.record_regis.AddNew
            Form1.record_regisTT.AddNew
            Form1.clear_click
            Form5.Visible = False
            Form5.Hide
            Form1.Enabled = True
            Form1.Show
        Else: Form5.Visible = False
              Form5.Hide
              Form1.Enabled = True
              Form1.Show
              Form1.i1 = 0
              Form1.regisTimeEn_false
        End If
            Form1.Combo3(0).ListIndex = 0
            Form1.Combo3(1).ListIndex = 0
            Form1.Combo3(2).ListIndex = 10
    End If

    If (Form1.TabStrip1.SelectedItem.Index - 1) = 1 Then
        Form1.Save_link
        Form1.record_std.MoveLast
        Form1.Label7.Caption = Form1.record_std.RecordCount
        
        If Option1.Value = True Then
            Form1.record_std.AddNew
            Form1.record_stdTT.AddNew
            Form1.clear_click
            Form5.Visible = False
            Form5.Hide
            Form1.Enabled = True
            Form1.Show
        Else: Form5.Visible = False
              Form5.Hide
              Form1.Enabled = True
              Form1.Show
              Form1.j1 = 0
              Form1.stdTimeEn_false
        End If
            Form1.Combo2(0).ListIndex = 0
            Form1.Combo2(1).ListIndex = 0
            Form1.Combo2(2).ListIndex = 10
    End If

    If (Form1.TabStrip1.SelectedItem.Index - 1) = 2 Then
        Form1.Save_link
        Form1.record_sub.MoveLast
        Form1.Label9.Caption = Form1.record_sub.RecordCount
        
        If Option1.Value = True Then
            Form1.record_sub.AddNew
            Form1.record_subTT.AddNew
            Form1.clear_click
            Form5.Visible = False
            Form5.Hide
            Form1.Enabled = True
            Form1.Show
        Else: Form5.Visible = False
              Form5.Hide
              Form1.Enabled = True
              Form1.Show
              Form1.k1 = 0
              Form1.subTimeEn_false
        End If
            Form1.Combo1(0).ListIndex = 0
            Form1.Combo1(1).ListIndex = 0
            Form1.Combo1(2).ListIndex = 10
    End If

End Sub

Private Sub Command2_Click()
    Form5.Visible = True
    Form5.Hide
    Form1.Enabled = True
    Form1.Show
End Sub

