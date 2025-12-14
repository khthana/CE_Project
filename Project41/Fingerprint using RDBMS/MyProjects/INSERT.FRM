VERSION 5.00
Begin VB.Form Insert 
   Caption         =   "Insert Data"
   ClientHeight    =   5520
   ClientLeft      =   2505
   ClientTop       =   2445
   ClientWidth     =   7800
   Icon            =   "insert.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5520
   ScaleWidth      =   7800
   Begin VB.CommandButton Command1 
      BackColor       =   &H00FF8080&
      Caption         =   "Cancel Insert"
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
      Left            =   4080
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   4680
      Width           =   3615
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      Height          =   3900
      Left            =   120
      ScaleHeight     =   256
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   256
      TabIndex        =   3
      Top             =   600
      Width           =   3900
   End
   Begin VB.TextBox Key 
      Height          =   285
      Left            =   840
      TabIndex        =   0
      Top             =   120
      Width           =   1455
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H00FF8080&
      Caption         =   "Insert Data !"
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
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   4680
      Width           =   3855
   End
   Begin VB.TextBox Data 
      Height          =   3885
      Left            =   4080
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   600
      Width           =   3615
   End
   Begin VB.Label Label1 
      Caption         =   "Key"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   495
   End
End
Attribute VB_Name = "Insert"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Number_items As Integer
Private buffer(6000) As Long

Private Sub Command1_Click()
    Form1.Enabled = True
    Unload Insert
End Sub

Private Sub Command4_Click()
    Dim i As Integer
    Dim Insert_table As ddoTable ', Temp_table
    Dim send As ddoOpaque
    Dim Image As ddoBlob
    Dim sendRecord As ddoRecord
    
    If Key.Text <> "" And Val(Key.Text) <> 0 Then
        Set Insert_table = Form1.groupInsert.Tables("fingerprint")
        Set sendRecord = Insert_table.NewRecord
        i = Val(Key.Text)
        sendRecord.Columns("fid").Value = i
        Set Image = sendRecord.Columns("picture").Value
        Image.LoadFromFile "_tn.bmp"
        Set send = sendRecord.Columns("fing").Value
        send.SetData buffer, Number_items
        Form1.groupInsert.BeginTransaction
        Insert_table.SaveData
        Form1.groupInsert.CommitTransaction
        Call Command1_Click
    Else
        MsgBox "ต้องป้อนค่า Key ให้ถูกต้อง", vbCritical, "Primary Key Value Error"
    End If
End Sub

Private Sub Form_Load()
Dim i, j, ex, bx, by As Integer
Dim pi, angle As Double

    Command4.Enabled = False
    pi = 3.14159265358979
    Number_items = 0
    Picture1.Picture = LoadPicture("_tn.bmp")
    For i = 0 To Form1.m_cImage.xMax
        For j = 0 To Form1.m_cImage.yMax
            ex = Form1.m_cImage.Feature(i, j)
            If ex <> 0 Then
            
                buffer(Number_items) = CLng(i)          'X  axis load
                Number_items = Number_items + 1
                buffer(Number_items) = CLng(j)
                Number_items = Number_items + 1 'Y axis load
                bx = (i \ 16) + 1
                by = (j \ 16) + 1
                buffer(Number_items) = CLng(Form1.m_cImage.OrientedField(bx, by))     ' Zeta load
                Number_items = Number_items + 1 'Next pointer
                
                angle = Form1.m_cImage.OrientedField(bx, by) * pi / 180
                Picture1.Circle (i, Form1.m_cImage.yMax - j), 3, QBColor(11)
                Picture1.Line (i, Form1.m_cImage.yMax - j)- _
                (Int(16 * Cos(angle)) + i, Form1.m_cImage.yMax - (Int(16 * Sin(angle)) + j)), QBColor(14)
            End If
        Next j
    Next i
    If (Number_items) Mod 3 = 0 Then
        Command4.Enabled = True
        For i = 0 To Number_items
            Data.Text = Data.Text + Str(buffer(i)) + " "
        Next i
    Else
        Command4.Enabled = False
        MsgBox "เกิดข้อผิดพลาดในการ load data", vbCritical, "Load error!"
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call Command1_Click
End Sub
