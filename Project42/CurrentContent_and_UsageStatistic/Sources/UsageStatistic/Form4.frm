VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Form4 
   Caption         =   "Form4"
   ClientHeight    =   8370
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   8205
   LinkTopic       =   "Form4"
   ScaleHeight     =   8370
   ScaleWidth      =   8205
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.TextBox Text25 
      Height          =   315
      Left            =   7080
      TabIndex        =   25
      Text            =   "0"
      Top             =   6720
      Width           =   855
   End
   Begin VB.TextBox Text24 
      Height          =   495
      Left            =   5880
      TabIndex        =   24
      Text            =   "0"
      Top             =   7320
      Width           =   855
   End
   Begin VB.TextBox Text23 
      Height          =   495
      Left            =   5880
      TabIndex        =   23
      Text            =   "0"
      Top             =   6720
      Width           =   855
   End
   Begin VB.TextBox Text22 
      Height          =   495
      Left            =   2040
      TabIndex        =   22
      Text            =   "0"
      Top             =   6720
      Width           =   1695
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   3480
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
   End
   Begin VB.TextBox Text19 
      Height          =   375
      Left            =   3960
      TabIndex        =   17
      Top             =   7800
      Width           =   1095
   End
   Begin VB.TextBox Text18 
      Height          =   375
      Left            =   3960
      TabIndex        =   16
      Top             =   7440
      Width           =   1095
   End
   Begin VB.TextBox Text17 
      Height          =   315
      Left            =   3960
      TabIndex        =   15
      Top             =   7080
      Width           =   1095
   End
   Begin VB.TextBox Text16 
      Height          =   435
      Left            =   3960
      TabIndex        =   14
      Top             =   6600
      Width           =   1095
   End
   Begin VB.Timer Timer1 
      Left            =   480
      Top             =   120
   End
   Begin VB.Frame Frame2 
      Caption         =   "การเชื่อมต่อกับฮารด์แวร์"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3255
      Left            =   240
      TabIndex        =   11
      Top             =   3240
      Width           =   9855
      Begin VB.Frame Frame3 
         Caption         =   "หมายเลขตู้ที่เปิดให้บริการ"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2775
         Left            =   2160
         TabIndex        =   26
         Top             =   240
         Width           =   7215
         Begin VB.CheckBox Check1 
            Caption         =   "ตู้ที่ 1 "
            Height          =   210
            Left            =   240
            TabIndex        =   61
            Top             =   240
            Width           =   975
         End
         Begin VB.CheckBox Check2 
            Caption         =   "ตู้ที่ 2 "
            Height          =   165
            Left            =   240
            TabIndex        =   60
            Top             =   480
            Width           =   975
         End
         Begin VB.CheckBox Check3 
            Caption         =   "ตู้ที่ 3"
            Height          =   210
            Left            =   240
            TabIndex        =   59
            Top             =   720
            Width           =   855
         End
         Begin VB.CheckBox Check4 
            Caption         =   "ตู้ที่ 4 "
            Height          =   255
            Left            =   240
            TabIndex        =   58
            Top             =   960
            Width           =   855
         End
         Begin VB.CheckBox Check5 
            Caption         =   "ตู้ที่ 5"
            Height          =   255
            Left            =   240
            TabIndex        =   57
            Top             =   1200
            Width           =   855
         End
         Begin VB.CheckBox Check6 
            Caption         =   "ตู้ที่ 6"
            Height          =   255
            Left            =   240
            TabIndex        =   56
            Top             =   1440
            Width           =   855
         End
         Begin VB.CheckBox Check7 
            Caption         =   "ตู้ที่ 7"
            Height          =   255
            Left            =   240
            TabIndex        =   55
            Top             =   1680
            Width           =   975
         End
         Begin VB.CheckBox Check8 
            Caption         =   "ตู้ที่ 8 "
            Height          =   255
            Left            =   240
            TabIndex        =   54
            Top             =   1920
            Width           =   855
         End
         Begin VB.CheckBox Check9 
            Caption         =   "ตู้ที่ 9"
            Height          =   255
            Left            =   240
            TabIndex        =   53
            Top             =   2160
            Width           =   855
         End
         Begin VB.CheckBox Check10 
            Caption         =   "ตู้ที่ 10"
            Height          =   255
            Left            =   240
            TabIndex        =   52
            Top             =   2400
            Width           =   975
         End
         Begin VB.CheckBox Check11 
            Caption         =   "ตู้ที่ 11 "
            Height          =   255
            Left            =   1440
            TabIndex        =   51
            Top             =   240
            Width           =   975
         End
         Begin VB.CheckBox Check12 
            Caption         =   "ตู้ที่ 12"
            Height          =   255
            Left            =   1440
            TabIndex        =   50
            Top             =   480
            Width           =   975
         End
         Begin VB.CheckBox Check13 
            Caption         =   "ตู้ที่ 13 "
            Height          =   255
            Left            =   1440
            TabIndex        =   49
            Top             =   720
            Width           =   975
         End
         Begin VB.CheckBox Check14 
            Caption         =   "ตู้ที่ 14"
            Height          =   255
            Left            =   1440
            TabIndex        =   48
            Top             =   960
            Width           =   975
         End
         Begin VB.CheckBox Check15 
            Caption         =   "ตู้ที่ 15"
            Height          =   255
            Left            =   1440
            TabIndex        =   47
            Top             =   1200
            Width           =   975
         End
         Begin VB.CheckBox Check16 
            Caption         =   "ตู้ที่ 16 "
            Height          =   255
            Left            =   1440
            TabIndex        =   46
            Top             =   1440
            Width           =   1095
         End
         Begin VB.CheckBox Check17 
            Caption         =   "ตู้ที่ 17"
            Height          =   255
            Left            =   1440
            TabIndex        =   45
            Top             =   1680
            Width           =   1095
         End
         Begin VB.CheckBox Check18 
            Caption         =   "ตู้ที่ 18 "
            Height          =   255
            Left            =   1440
            TabIndex        =   44
            Top             =   1920
            Width           =   975
         End
         Begin VB.CheckBox Check19 
            Caption         =   "ตู้ที่ 19"
            Height          =   255
            Left            =   1440
            TabIndex        =   43
            Top             =   2160
            Width           =   1095
         End
         Begin VB.CheckBox Check20 
            Caption         =   "ตู้ที่ 20 "
            Height          =   255
            Left            =   1440
            TabIndex        =   42
            Top             =   2400
            Width           =   975
         End
         Begin VB.CheckBox Check21 
            Caption         =   "ตู้ที่ 21 "
            Height          =   255
            Left            =   2760
            TabIndex        =   41
            Top             =   240
            Width           =   1095
         End
         Begin VB.CheckBox Check23 
            Caption         =   "ตู้ที่ 23 "
            Height          =   255
            Left            =   2760
            TabIndex        =   40
            Top             =   720
            Width           =   975
         End
         Begin VB.CheckBox Check24 
            Caption         =   "ตู้ที่ 24 "
            Height          =   255
            Left            =   2760
            TabIndex        =   39
            Top             =   960
            Width           =   1095
         End
         Begin VB.CheckBox Check25 
            Caption         =   "ตู้ที่ 25 "
            Height          =   255
            Left            =   2760
            TabIndex        =   38
            Top             =   1200
            Width           =   975
         End
         Begin VB.CheckBox Check26 
            Caption         =   "ตู้ที่ 26 "
            Height          =   255
            Left            =   2760
            TabIndex        =   37
            Top             =   1440
            Width           =   1095
         End
         Begin VB.CheckBox Check27 
            Caption         =   "ตู้ที่ 27 "
            Height          =   255
            Left            =   2760
            TabIndex        =   36
            Top             =   1680
            Width           =   975
         End
         Begin VB.CheckBox Check28 
            Caption         =   "ตู้ที่ 28 "
            Height          =   255
            Left            =   2760
            TabIndex        =   35
            Top             =   1920
            Width           =   975
         End
         Begin VB.CheckBox Check29 
            Caption         =   "ตู้ที่ 29 "
            Height          =   255
            Left            =   2760
            TabIndex        =   34
            Top             =   2160
            Width           =   975
         End
         Begin VB.CheckBox Check30 
            Caption         =   "ตู้ที่ 30 "
            Height          =   255
            Left            =   2760
            TabIndex        =   33
            Top             =   2400
            Width           =   1095
         End
         Begin VB.CheckBox Check31 
            Caption         =   "ตู้ที่ 31 "
            Height          =   210
            Left            =   3960
            TabIndex        =   32
            Top             =   360
            Width           =   975
         End
         Begin VB.CommandButton Command4 
            Caption         =   "ตกลง"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   3960
            TabIndex        =   31
            Top             =   960
            Width           =   975
         End
         Begin VB.TextBox Text6 
            Enabled         =   0   'False
            Height          =   375
            Left            =   3960
            TabIndex        =   30
            Top             =   2040
            Width           =   855
         End
         Begin VB.CommandButton Command7 
            Caption         =   "ยกเลิก"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   5160
            TabIndex        =   29
            Top             =   960
            Width           =   975
         End
         Begin VB.CheckBox Check22 
            Caption         =   "ตู้ที่ 22 "
            Height          =   255
            Left            =   2760
            TabIndex        =   28
            Top             =   480
            Width           =   975
         End
         Begin VB.ComboBox Combo3 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            ItemData        =   "Form4.frx":0000
            Left            =   6000
            List            =   "Form4.frx":000A
            TabIndex        =   27
            Text            =   "2"
            Top             =   240
            Width           =   615
         End
         Begin VB.Label Label2 
            Caption         =   "Comport"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   4920
            TabIndex        =   63
            Top             =   360
            Width           =   975
         End
         Begin VB.Label Label3 
            Caption         =   "รวม"
            Height          =   375
            Left            =   3960
            TabIndex        =   62
            Top             =   1680
            Width           =   495
         End
      End
      Begin VB.TextBox Text20 
         Height          =   315
         Left            =   1320
         TabIndex        =   21
         Top             =   360
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.CommandButton Command6 
         Caption         =   "End"
         Height          =   735
         Left            =   120
         TabIndex        =   13
         Top             =   1800
         Width           =   1095
      End
      Begin VB.CommandButton Command5 
         Caption         =   "Start"
         Height          =   735
         Left            =   120
         TabIndex        =   12
         Top             =   1080
         Width           =   1095
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "ลบข้อมูล"
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
      Left            =   6960
      TabIndex        =   7
      Top             =   1080
      Width           =   4335
      Begin VB.TextBox Text8 
         Height          =   375
         Left            =   2400
         TabIndex        =   19
         Top             =   1560
         Width           =   1575
      End
      Begin VB.OptionButton Option2 
         Caption         =   "โดยวัน/เดือน/ปี"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   840
         TabIndex        =   18
         Top             =   1440
         Width           =   1335
      End
      Begin VB.TextBox Text7 
         Height          =   375
         Left            =   2400
         TabIndex        =   10
         Top             =   840
         Width           =   1575
      End
      Begin VB.OptionButton Option1 
         Caption         =   "โดย ID#"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   840
         TabIndex        =   9
         Top             =   960
         Width           =   1575
      End
      Begin VB.CommandButton Command3 
         Caption         =   "ลบ"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   360
         TabIndex        =   8
         Top             =   360
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "วัน/เดือน/ปี"
         Height          =   255
         Left            =   2520
         TabIndex        =   20
         Top             =   1320
         Width           =   1455
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "ออกจากตารางจัดเก็บสถิติ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   6840
      TabIndex        =   6
      Top             =   0
      Width           =   2895
   End
   Begin VB.TextBox Text5 
      Height          =   375
      Left            =   5760
      TabIndex        =   5
      Top             =   1440
      Width           =   1095
   End
   Begin VB.TextBox Text4 
      Height          =   375
      Left            =   5760
      TabIndex        =   4
      Top             =   1080
      Width           =   1095
   End
   Begin VB.TextBox Text3 
      Height          =   375
      Left            =   5760
      TabIndex        =   3
      Top             =   720
      Width           =   1095
   End
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   5760
      TabIndex        =   2
      Top             =   360
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   5760
      TabIndex        =   1
      Top             =   0
      Width           =   1095
   End
   Begin VB.Data DATA1 
      Connect         =   "Access"
      DatabaseName    =   "D:\Project_duck\Project\order1.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   1080
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   2  'Snapshot
      RecordSource    =   "STATISTIC"
      Top             =   120
      Visible         =   0   'False
      Width           =   2220
   End
   Begin MSDBGrid.DBGrid DISPLAYTABLE 
      Bindings        =   "Form4.frx":0014
      Height          =   2775
      Left            =   0
      OleObjectBlob   =   "Form4.frx":0028
      TabIndex        =   0
      Top             =   360
      Width           =   5415
   End
End
Attribute VB_Name = "Form4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public NODESNAP As Recordset
Public STATISTICSNAP1 As Recordset
Public STATISTICSNAP As Recordset
Public ORDERWS As Workspace
Public ORDERDB As Database
Public SQLCOMMAND As String
Dim DATA_READ As String
Dim flag_end As Boolean
Dim Checksum As Variant
Dim Num_node As String
Dim data_send As String
Dim EXIT_TIME As Boolean
Dim Data_node0 As String
Dim Data_node1 As String
Dim Data_Book0 As String
Dim Data_Book1 As String
Dim Var_node As String
Dim End_Connect As Boolean
Dim error_flag As Boolean
Dim sum As Integer
Dim TEMP1 As Integer


Private Sub Check1_Click()
If Check1.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check2_Click()
If Check2.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check3_Click()
If Check3.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check4_Click()
If Check4.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check5_Click()
If Check5.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub

Private Sub Check6_Click()
If Check6.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub

Private Sub Check7_Click()
If Check7.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check8_Click()
If Check8.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check9_Click()
If Check9.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check10_Click()
If Check10.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check11_Click()
If Check11.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check12_Click()
If Check12.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check13_Click()
If Check13.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check14_Click()
If Check14.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check15_Click()
If Check15.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check16_Click()
If Check16.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub

Private Sub Check17_Click()
If Check17.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub

Private Sub Check18_Click()
If Check18.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check19_Click()
If Check19.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check20_Click()
If Check20.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check21_Click()
If Check21.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check22_Click()
If Check22.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check23_Click()
If Check23.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check24_Click()
If Check24.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check25_Click()
If Check25.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check26_Click()
If Check26.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If
End Sub

Private Sub Check27_Click()
If Check27.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub

Private Sub Check28_Click()
If Check28.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub

Private Sub Check29_Click()
If Check29.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check30_Click()
If Check30.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub
Private Sub Check31_Click()
If Check31.Value = 0 Then
    sum = sum - 1
Else
   sum = sum + 1
   End If

End Sub

'****************************
'****************************
'****************************
Sub send_process()
If sum = 0 Then
    MsgBox "กรุณาใส่หมายเลขตู้วารสารที่เปิดบรืการ"
Else
    Do
    
    If Check1.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "01"
    Call senddata
    End If
    
    If Check2.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "02"
    Call senddata
    End If
    
    If Check3.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "03"
    Call senddata
    End If
    If Check4.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "04"
    Call senddata
    End If
    If Check5.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "05"
    Call senddata
    End If
    If Check6.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "06"
    Call senddata
    End If
    If Check7.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "07"
    Call senddata
    End If
    If Check8.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "08"
    Call senddata
    End If
    If Check9.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "09"
    Call senddata
    End If
    If Check10.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "10"
    Call senddata
    End If
    
    
  If Check11.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "11"
    Call senddata
    End If
    
    If Check12.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "12"
    Call senddata
    End If
    
    If Check13.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "13"
    Call senddata
    End If
    
    If Check14.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "14"
    Call senddata
    End If
    
    If Check15.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "15"
    Call senddata
    End If
    
    If Check16.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "16"
    Call senddata
    End If
    
    If Check17.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "17"
    Call senddata
    End If
    
    If Check18.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "18"
    Call senddata
    End If
    
    If Check19.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "19"
    Call senddata
    End If
    
    If Check20.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "20"
    Call senddata
    End If
    
    
    If Check21.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "21"
    Call senddata
    End If
    
    If Check22.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "22"
    Call senddata
    End If
    
    If Check23.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "23"
    Call senddata
    End If
    
    If Check24.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "24"
    Call senddata
    End If
    
    If Check25.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "25"
    Call senddata
    End If
    
    If Check26.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "26"
    Call senddata
    End If
    
    If Check27.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "27"
    Call senddata
    End If
    
    If Check28.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "28"
    Call senddata
    End If
    
    If Check29.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "29"
    Call senddata
    End If
    
    If Check30.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "30"
    Call senddata
    End If
    
    If Check31.Value = 1 And End_Connect = False Then
    For J% = 1 To 500
    For i% = 1 To 10000
    Next i%
    Next J%
    Var_node = "31"
    Call senddata
    End If

    Loop Until End_Connect = True
End If

End Sub

Private Sub OPENQUERY()
On Error GoTo handleerror

Set STATISTICSNAP = ORDERDB.OpenRecordset(SQLCOMMAND, dbOpenSnapshot)
Text5.Text = STATISTICSNAP.Fields(ID#)
Exit Sub
handleerror:
    error_flag = True
' MsgBox "Error &,error(err.number)"
'  GoTo send_process
End Sub

Private Sub Command2_Click()
On Error GoTo handleerror

STATISTICSNAP1.Close
ORDERDB.Close
Unload Me
Form1.Show
Exit Sub
handleerror:
 MsgBox "Error &,error(err.number)"
End Sub


Private Sub Command3_Click()
Dim TEMP1 As Variant
Dim TEMP_DATA As Variant
Dim M_NUM As String
Dim D_NUM As String
Dim Y_NUM As String
Dim TEMP2 As Variant
'On Error GoTo handleError
If STATISTICSNAP1.RecordCount = 0 Then
   MsgBox "ไม่มีข้อมูลให้ลบ"
Else
If Not (Option1.Value Or Option2.Value) Then
  MsgBox "กรุณาเลือกระหว่างลบด้วย ID# หรือ ลบด้วยวันที่ (Date)"
Else
If Option1.Value = True Then
    If Text7.Text = "" Then
    MsgBox " กรุณาใส่ ID# ที่ต้องการลบ"
    Else
    STATISTICSNAP1.MoveFirst
    If MsgBox("ต้องการลบข้อมูล , คุณแน่ใจแล้วหรือยัง?", [vbYesNo]) = vbYes Then
    Do While Not STATISTICSNAP1.EOF
        TEMP1 = STATISTICSNAP1.Fields("ID#")
        If (TEMP1 = Text7.Text) Or (TEMP1 = Text7.Text & " ") Then
            'STATISTICSNAP1.Update
            STATISTICSNAP1.Delete
            
        End If
    STATISTICSNAP1.MoveNext
    Loop
  '  STATISTICSNAP1.Update
    End If
    End If
End If
';----------
If Option2.Value = True Then
    If Text8.Text = "" Then
      MsgBox " กรุณาใส่วันที่(Date) ที่ต้องการลบ"
    Else
    STATISTICSNAP1.MoveFirst
    If MsgBox("ต้องการลบข้อมูล , คุณแน่ใจแล้วหรือยัง?", [vbYesNo]) = vbYes Then
     
      '  If Len(TEMP2) = 8 Then
      '  M_NUM = Mid(TEMP2, 4, 2)  'Left(TEMP2, 2)
       ' D_NUM = Mid(TEMP2, 4, 2)
       ' Y_NUM = Right(TEMP2, 2)
        
       ' End If
        'If Len(TEMP2) = 7 Then
        'M_NUM = Mid(TEMP2, 4, 1)  '  Left(TEMP2, 1)
        'M_NUM = "0" & M_NUM
        'D_NUM = Mid(TEMP2, 1, 2)
        'Y_NUM = Right(TEMP2, 2)

        'End If
        'TEMP_DATA = D_NUM & "/" & M_NUM & "/" & Y_NUM
        TEMP_DATA = DateValue(Text8.Text)
    
    Do While Not STATISTICSNAP1.EOF
        TEMP2 = (STATISTICSNAP1.Fields("Date"))
    ' TEMP2 = FormatDateTime(Date, vbShortDate)
        If TEMP2 = TEMP_DATA Then
           ' STATISTICSNAP1.Update
           STATISTICSNAP1.Delete
        End If
    STATISTICSNAP1.MoveNext
    Loop
'    STATISTICSNAP1.Update
    End If
    End If
End If

End If
Set Data1.Recordset = STATISTICSNAP1
Text7.Text = ""
Text8.Text = ""
STATISTICSNAP1.Requery
End If

'handleError:
 'MsgBox "Error &,error(err.number)"
End Sub

Private Sub Command4_Click()
initial
Command5.Visible = True
Command7.Visible = True
Command4.Visible = False
Check1.Enabled = False
Check2.Enabled = False
Check3.Enabled = False
Check4.Enabled = False
Check5.Enabled = False
Check6.Enabled = False
Check7.Enabled = False
Check8.Enabled = False
Check9.Enabled = False
Check10.Enabled = False
Check11.Enabled = False
Check12.Enabled = False
Check13.Enabled = False
Check14.Enabled = False
Check15.Enabled = False
Check16.Enabled = False
Check17.Enabled = False
Check18.Enabled = False
Check19.Enabled = False
Check20.Enabled = False
Check21.Enabled = False
Check22.Enabled = False
Check23.Enabled = False
Check24.Enabled = False
Check25.Enabled = False
Check26.Enabled = False
Check27.Enabled = False
Check28.Enabled = False
Check29.Enabled = False
Check30.Enabled = False
Check31.Enabled = False

Text6.Text = sum
End Sub

Private Sub Command5_Click()
'initial
Command5.Visible = False
Command6.Visible = True
TEMP1 = 0
If MSComm1.PortOpen = False Then
 MSComm1.PortOpen = True
End If
 End_Connect = False
Call send_process
End Sub

Private Sub Command6_Click()
Command5.Visible = True
Command6.Visible = False
If MSComm1.PortOpen = True Then
MSComm1.PortOpen = False
End If
End_Connect = True
End Sub

Private Sub Command7_Click()
Command4.Visible = True
Command7.Visible = False
Check1.Enabled = True
Check2.Enabled = True
Check3.Enabled = True
Check4.Enabled = True
Check5.Enabled = True
Check6.Enabled = True
Check7.Enabled = True
Check8.Enabled = True
Check9.Enabled = True
Check10.Enabled = True
Check11.Enabled = True
Check12.Enabled = True
Check13.Enabled = True
Check14.Enabled = True
Check15.Enabled = True
Check16.Enabled = True
Check17.Enabled = True
Check18.Enabled = True
Check19.Enabled = True
Check20.Enabled = True
Check21.Enabled = True
Check22.Enabled = True
Check23.Enabled = True
Check24.Enabled = True
Check25.Enabled = True
Check26.Enabled = True
Check27.Enabled = True
Check28.Enabled = True
Check29.Enabled = True
Check30.Enabled = True
Check31.Enabled = True
'MSComm1.PortOpen = False
End Sub
Private Sub Form_Load()
Dim sqlcommand1 As String
'initial
'Text21.Text = 0
Text22.Text = 0
sum = 0
Command6.Visible = False
Command5.Visible = False
Command7.Visible = False
Check1.Enabled = True
Check2.Enabled = True
Check3.Enabled = True
Check4.Enabled = True
Check5.Enabled = True
Check6.Enabled = True
Check7.Enabled = True
Check8.Enabled = True
Check9.Enabled = True
Check10.Enabled = True
Check11.Enabled = True
Check12.Enabled = True
Check13.Enabled = True
Check14.Enabled = True
Check15.Enabled = True
Check16.Enabled = True
Check17.Enabled = True
Check18.Enabled = True
Check19.Enabled = True
Check20.Enabled = True
Check21.Enabled = True
Check22.Enabled = True
Check23.Enabled = True
Check24.Enabled = True
Check25.Enabled = True
Check26.Enabled = True
Check27.Enabled = True
Check28.Enabled = True
Check29.Enabled = True
Check30.Enabled = True
Check31.Enabled = True



'Label1.Visible = False
Text7.Visible = False
'Text8.Visible = False
Set ORDERWS = DBEngine.Workspaces(0)
Set ORDERDB = ORDERWS.OpenDatabase("C:\PROJECT\ORDER1.MDB", False, False)

 sqlcommand1 = "select (statistic.[Date])  , statistic.[Time],statistic.[ID#],"
 sqlcommand1 = sqlcommand1 & "detail2.[Tiltle],detail2.[volume],detail2.[number]"
 sqlcommand1 = sqlcommand1 & "FROM statistic LEFT JOIN DETAIL2 ON statistic.[ID#] = DETAIL2.[ID#]"
 sqlcommand1 = sqlcommand1 & "order  BY statistic.[Date]"

Set STATISTICSNAP1 = ORDERDB.OpenRecordset(sqlcommand1, dbOpenDynaset)
STATISTICSNAP1.Requery
Set Data1.Recordset = STATISTICSNAP1

End Sub

Private Sub Option1_Click()
Option1.Value = True
Option2.Value = False
Label1.Visible = True
Text7.Visible = True
Text8.Visible = False
Label1.Visible = False
Text7.SetFocus
End Sub

Private Sub Option2_Click()
Option2.Value = True
Option1.Value = False
Text7.Visible = False
Text8.Visible = True
Label1.Visible = False
Label1.Visible = True
Text8.SetFocus
End Sub
Sub initial()

    MSComm1.CommPort = Combo3.Text
   

  '  MSComm1.CommPort = 1
    MSComm1.Settings = "9600,n,8,1"
    MSComm1.InputLen = 7
    MSComm1.InBufferSize = 7
    'MSComm1.RThreshold = 7
    If MSComm1.PortOpen = False Then
    MSComm1.PortOpen = True
    End If
End Sub

Sub senddata()
    If MSComm1.PortOpen = False Then
    MSComm1.PortOpen = True
    End If
    EXIT_TIME = False
    Num_node = Var_node
    Checksum = Asc(Mid(Num_node, 1, 1))
    Checksum = Checksum Xor Asc(Mid(Num_node, 2, 1))
    Checksum = Checksum Xor Asc(Chr(33)) Xor Asc(Chr(33)) Xor Asc(Chr(33))
    data_send = Chr(58) & Chr(33) & Chr(33) & Chr(33) & Mid(Num_node, 1, 1) & Mid(Num_node, 2, 1) & Chr(Checksum)
    MSComm1.RTSEnable = False
    MSComm1.Output = data_send
    Text25.Text = Int(Text25.Text) + 1
    
    For J% = 1 To 1000
    Next J%

    MSComm1.PortOpen = False
    flag_end = False
    
    Do
      Text20.Visible = False
      EXIT_TIME = False
      
      If MSComm1.PortOpen = False Then
       MSComm1.PortOpen = True
      End If
      MSComm1.RTSEnable = True
      
      Timer1.Interval = 1200
      Timer1.Enabled = True
      
     
    Do
       DoEvents
    Loop Until MSComm1.InBufferCount >= 7 Or EXIT_TIME = True
    Timer1.Enabled = False
If EXIT_TIME = False Then
    Text20.Visible = False
    DATA_READ = MSComm1.Input
    Checksum = Asc(Mid(DATA_READ, 2, 1)) Xor Asc(Mid(DATA_READ, 3, 1))
    Checksum = Checksum Xor Asc(Mid(DATA_READ, 4, 1))
    Checksum = Checksum Xor Asc(Mid(DATA_READ, 5, 1))
    Checksum = Checksum Xor Asc(Mid(DATA_READ, 6, 1))
    Checksum = Chr(Checksum)
    
         If Mid(DATA_READ, 2, 1) = "%" Or Mid(DATA_READ, 3, 1) = "%" Or Mid(DATA_READ, 4, 1) = "%" Then
            'Text21.Text = Int(Text21.Text) + 1
            'Call read_start
            'flag_end = False
         End If
          If Mid(DATA_READ, 2, 1) = "$" Then
            Call read_DATA
            flag_end = False
         End If
          If Mid(DATA_READ, 2, 1) = "&" Or Mid(DATA_READ, 3, 1) = "&" Or Mid(DATA_READ, 4, 1) = "&" Then
            Text22.Text = Int(Text22.Text) + 1
            Call read_end
            flag_end = True
         End If

    Else
    Text20.Visible = True
    Exit Sub
  
End If
     Loop Until flag_end = True
End Sub
Sub read_start()
'Text9.Text = Mid(DATA_READ, 1, 1)
'Text10.Text = Mid(DATA_READ, 2, 1) & Mid(DATA_READ, 3, 1) & Mid(DATA_READ, 4, 1)
'Text11.Text = Mid(DATA_READ, 5, 1) & Mid(DATA_READ, 6, 1)
'Text12.Text = Mid(DATA_READ, 7, 1)
End Sub

Sub read_DATA()
Dim date_record As Variant
Dim time_record As Variant
Dim ID_record As Variant
'Text13.Text = Mid(DATA_READ, 1, 1)
'Text14.Text = Mid(DATA_READ, 2, 1)
Data_node0 = Mid(DATA_READ, 3, 1)
Data_node1 = Mid(DATA_READ, 4, 1)
Data_Book0 = Mid(DATA_READ, 5, 1)
Data_Book1 = Mid(DATA_READ, 6, 1)
'Text15.Text = Mid(DATA_READ, 7, 1)
'------------------------
date_record = Date
time_record = Time
Text4.Text = time_record
'Text3.Text = Date
'Text4.Text = Time
Text1.Text = Data_node0 & Data_node1
Text2.Text = Data_Book0 & Data_Book1
'----------------------
strnode = Text1.Text
strbook = Text2.Text
If strnode <> "" And strbook <> "" Then
    SQLCOMMAND = "SELECT DAILY1.[ID#]  FROM [DAILY1] Where [NODE#] ='" & strnode & "'"
    SQLCOMMAND = SQLCOMMAND & "AND [BOOK#] ='" & strbook & "'"
    Call OPENQUERY
    If error_flag = False Then
    ID_record = Text5.Text
    
    Text3.Text = date_record
    data_reocrd = FormatDateTime(Date, vbShortDate)
    'time_record = Text4.Text
    'date_record = CDate(Text3.Text)
    STATISTICSNAP1.AddNew
    STATISTICSNAP1("DATE") = date_record
    STATISTICSNAP1("TIME") = time_record
    STATISTICSNAP1("ID#") = ID_record
    STATISTICSNAP1.Update
    STATISTICSNAP1.Requery
    STATISTICSNAP1.MoveLast
    
    DISPLAYTABLE.Visible = True
    Set Data1.Recordset = STATISTICSNAP1
    End If
Else
    MsgBox "กรุณาใส่หมายเลตู้วารสาร(NODE#) และหมายเลขวารสาร(BOOK#)"
End If

End Sub
Sub read_end()

Text16.Text = Mid(DATA_READ, 1, 1)
Text17.Text = Mid(DATA_READ, 2, 1) & Mid(DATA_READ, 3, 1) & Mid(DATA_READ, 4, 1)
Text18.Text = Mid(DATA_READ, 5, 1) & Mid(DATA_READ, 6, 1)
Text19.Text = Mid(DATA_READ, 7, 1)
Text20.Text = TEMP1 + 1
If Mid(DATA_READ, 6, 1) = "1" Then
    Text23.Text = Text23.Text + 1
End If
If Mid(DATA_READ, 6, 1) = "2" Then
    Text24.Text = Text24.Text + 1
End If

End Sub

Private Sub Text13_Change()

End Sub

Private Sub Timer1_Timer()
EXIT_TIME = True
Timer1.Enabled = False
End Sub
