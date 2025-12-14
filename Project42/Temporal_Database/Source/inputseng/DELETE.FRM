VERSION 5.00
Begin VB.Form Form4 
   Caption         =   "Confirm Delete"
   ClientHeight    =   2070
   ClientLeft      =   4065
   ClientTop       =   3810
   ClientWidth     =   3840
   LinkTopic       =   "Form4"
   ScaleHeight     =   2070
   ScaleWidth      =   3840
   Begin VB.CommandButton Command2 
      Caption         =   "&No"
      Height          =   375
      Left            =   2400
      TabIndex        =   9
      Top             =   1560
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Yes"
      Height          =   375
      Left            =   1080
      TabIndex        =   8
      Top             =   1560
      Width           =   855
   End
   Begin VB.Frame Frame1 
      Caption         =   "Please key Valid to Date"
      Height          =   855
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3615
      Begin VB.ComboBox Combo1 
         Height          =   315
         Index           =   2
         ItemData        =   "delete.frx":0000
         Left            =   2760
         List            =   "delete.frx":0061
         TabIndex        =   6
         Top             =   360
         Width           =   735
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         Index           =   1
         ItemData        =   "delete.frx":011F
         Left            =   1680
         List            =   "delete.frx":0147
         TabIndex        =   5
         Top             =   360
         Width           =   735
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         Index           =   0
         ItemData        =   "delete.frx":0172
         Left            =   360
         List            =   "delete.frx":01D3
         TabIndex        =   4
         Top             =   360
         Width           =   735
      End
      Begin VB.Label Label1 
         Caption         =   "ปี"
         Height          =   255
         Index           =   2
         Left            =   2520
         TabIndex        =   3
         Top             =   480
         Width           =   375
      End
      Begin VB.Label Label1 
         Caption         =   "เดือน"
         Height          =   255
         Index           =   1
         Left            =   1200
         TabIndex        =   2
         Top             =   480
         Width           =   375
      End
      Begin VB.Label Label1 
         Caption         =   "วัน"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   1
         Top             =   480
         Width           =   375
      End
   End
   Begin VB.Image Image1 
      Height          =   600
      Left            =   120
      Picture         =   "delete.frx":024A
      Top             =   1200
      Width           =   705
   End
   Begin VB.Label Label2 
      Caption         =   "Are you sure to Delete this record?"
      Height          =   255
      Left            =   960
      TabIndex        =   7
      Top             =   1200
      Width           =   2655
   End
End
Attribute VB_Name = "Form4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Dim chkcombo As Integer
     If (Form1.TabStrip1.SelectedItem.Index - 1) = 0 Then
        chkcombo = Combo1(1).ListIndex
        Form1.Text2(6).Text = Combo1(1).List(chkcombo)
        Form1.Text2(6).Text = Form1.Text2(6).Text + "/"
        chkcombo = Combo1(0).ListIndex
        Form1.Text2(6).Text = Form1.Text2(6).Text + Combo1(0).List(chkcombo)
        Form1.Text2(6).Text = Form1.Text2(6).Text + "/"
        chkcombo = Combo1(2).ListIndex
        Form1.Text2(6).Text = Form1.Text2(6).Text + Combo1(2).List(chkcombo)

        Form1.record_regisTT.FindLast "regis_int = " & Form1.record_regis.Fields("regis_serial").Value
        Form1.record_regisTT.Edit
        Form1.record_regisTT.Fields("Valid_to").Value = Form1.Text2(6).Text
        Form1.record_regisTT.Fields("TxStop").Value = Format(Date, "mm/dd/yyyy")
        Form1.record_regisTT.Update
        Form1.record_regis.Delete
        If Form1.record_regis.RecordCount <> 0 Then
            Form1.record_regis.MoveLast
            Form1.Label5.Caption = Form1.record_regis.RecordCount
            Form1.clear_click
            Form1.record_regis.MoveFirst
        Else: MsgBox "No data in registeration table please insert data", vbOKOnly + vbExclamation, "Data Empty"
              i1 = 0
              Form1.clear_click
              Form1.insert_click
        End If
     End If
     
     If (Form1.TabStrip1.SelectedItem.Index - 1) = 1 Then
        chkcombo = Combo1(1).ListIndex
        Form1.Text1(7).Text = Combo1(1).List(chkcombo)
        Form1.Text1(7).Text = Form1.Text1(7).Text + "/"
        chkcombo = Combo1(0).ListIndex
        Form1.Text1(7).Text = Form1.Text1(7).Text + Combo1(0).List(chkcombo)
        Form1.Text1(7).Text = Form1.Text1(7).Text + "/"
        chkcombo = Combo1(2).ListIndex
        Form1.Text1(7).Text = Form1.Text1(7).Text + Combo1(2).List(chkcombo)
            
        Form1.record_stdTT.FindLast "std_int = " & Form1.record_std.Fields("std_serial").Value
        Form1.record_stdTT.Edit
        Form1.record_stdTT.Fields("Valid_to").Value = Form1.Text1(7).Text
        Form1.record_stdTT.Fields("TxStop").Value = Format(Date, "mm/dd/yyyy")
        Form1.record_stdTT.Update
        Form1.record_std.Delete
        If Form1.record_std.RecordCount <> 0 Then
            Form1.record_std.MoveLast
            Form1.Label7.Caption = Form1.record_std.RecordCount
            Form1.record_std.MoveFirst
        Else: MsgBox "No data in student table please insert data", vbOKOnly + vbExclamation, "Data Empty"
              i1 = 0
              Form1.clear_click
              Form1.insert_click
        End If
     End If
     
     If (Form1.TabStrip1.SelectedItem.Index - 1) = 2 Then
        chkcombo = Combo1(1).ListIndex
        Form1.Text3(7).Text = Combo1(1).List(chkcombo)
        Form1.Text3(7).Text = Form1.Text3(7).Text + "/"
        chkcombo = Combo1(0).ListIndex
        Form1.Text3(7).Text = Form1.Text3(7).Text + Combo1(0).List(chkcombo)
        Form1.Text3(7).Text = Form1.Text3(7).Text + "/"
        chkcombo = Combo1(2).ListIndex
        Form1.Text3(7).Text = Form1.Text3(7).Text + Combo1(2).List(chkcombo)
     
        Form1.record_subTT.FindLast "sub_int = " & Form1.record_sub.Fields("sub_serial").Value
        Form1.record_subTT.Edit
        Form1.record_subTT.Fields("Valid_to").Value = Form1.Text3(7).Text
        Form1.record_subTT.Fields("TxStop").Value = Format(Date, "mm/dd/yyyy")
        Form1.record_subTT.Update
        Form1.record_sub.Delete
        If Form1.record_sub.RecordCount <> 0 Then
            Form1.record_sub.MoveLast
            Form1.Label9.Caption = Form1.record_sub.RecordCount
            Form1.record_sub.MoveFirst
        Else: MsgBox "No data in subject table please insert data", vbOKOnly + vbExclamation, "Data Empty"
              i1 = 0
              Form1.clear_click
              Form1.insert_click
        End If
     End If
    Form4.Hide
    Form4.Visible = False
    Form1.Enabled = True
    Form1.Show
End Sub

Private Sub Command2_Click()
    Form4.Hide
    Form4.Visible = False
    Form1.Enabled = True
    Form1.Show
End Sub
