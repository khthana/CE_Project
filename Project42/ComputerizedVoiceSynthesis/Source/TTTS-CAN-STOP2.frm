VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form frm_main 
   BackColor       =   &H00C0C000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Computerize Voice Synthesis"
   ClientHeight    =   6540
   ClientLeft      =   1110
   ClientTop       =   1245
   ClientWidth     =   8640
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6540
   ScaleWidth      =   8640
   Begin MSComDlg.CommonDialog CommonDialog1 
      Index           =   1
      Left            =   2520
      Top             =   2280
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.TextBox InputSentense 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   450
      Left            =   2040
      TabIndex        =   10
      Top             =   4800
      Width           =   6375
   End
   Begin VB.TextBox ShowFilename 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   1200
      TabIndex        =   2
      Top             =   5520
      Width           =   3855
   End
   Begin VB.TextBox TextFileSize 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   1200
      TabIndex        =   1
      Top             =   5880
      Width           =   1335
   End
   Begin RichTextLib.RichTextBox text_output 
      Height          =   4215
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   7435
      _Version        =   393217
      BackColor       =   12648447
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"TTTS-CAN-STOP2.frx":0000
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00C0C000&
      Height          =   1095
      Left            =   120
      TabIndex        =   3
      Top             =   5280
      Width           =   8295
      Begin VB.Timer Timer1 
         Interval        =   10
         Left            =   5160
         Top             =   -120
      End
      Begin VB.TextBox ShowCannotReadCount 
         Appearance      =   0  'Flat
         Height          =   300
         Left            =   7080
         TabIndex        =   8
         Top             =   600
         Width           =   975
      End
      Begin VB.TextBox ShowWordCount 
         Appearance      =   0  'Flat
         Height          =   300
         Left            =   7080
         TabIndex        =   6
         Top             =   240
         Width           =   975
      End
      Begin VB.Label Label7 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C000&
         Caption         =   "จำนวนคำที่อ่านไม่ได้"
         Height          =   255
         Left            =   5400
         TabIndex        =   9
         Top             =   600
         Width           =   1455
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C000&
         Caption         =   "จำนวนคำที่อ่านได้"
         Height          =   255
         Left            =   5400
         TabIndex        =   7
         Top             =   240
         Width           =   1335
      End
      Begin VB.Label Label1 
         BackColor       =   &H00C0C000&
         Caption         =   "ชื่อไฟล์"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label3 
         BackColor       =   &H00C0C000&
         Caption         =   "ขนาดไฟล์"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   600
         Width           =   855
      End
   End
   Begin RichTextLib.RichTextBox text_output2 
      Height          =   2655
      Left            =   3000
      TabIndex        =   12
      Top             =   120
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   4683
      _Version        =   393217
      BackColor       =   12648447
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"TTTS-CAN-STOP2.frx":00FA
   End
   Begin RichTextLib.RichTextBox text_output3 
      Height          =   2655
      Left            =   5880
      TabIndex        =   16
      Top             =   120
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   4683
      _Version        =   393217
      BackColor       =   12648447
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"TTTS-CAN-STOP2.frx":01F4
   End
   Begin RichTextLib.RichTextBox text_output4 
      Height          =   1215
      Left            =   3000
      TabIndex        =   17
      Top             =   3120
      Width           =   5535
      _ExtentX        =   9763
      _ExtentY        =   2143
      _Version        =   393217
      BackColor       =   12648447
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"TTTS-CAN-STOP2.frx":02EE
   End
   Begin VB.Label Label10 
      BackColor       =   &H00C0C000&
      Caption         =   "อัฒพยางค์"
      Height          =   255
      Left            =   5520
      TabIndex        =   19
      Top             =   4440
      Width           =   855
   End
   Begin VB.Label Label9 
      BackColor       =   &H00C0C000&
      Caption         =   "คำอ่าน"
      Height          =   255
      Left            =   7050
      TabIndex        =   18
      Top             =   2815
      Width           =   615
   End
   Begin VB.Label Label5 
      BackColor       =   &H00C0C000&
      Caption         =   "ข้อความที่ทำการตัดคำแล้ว"
      Height          =   255
      Left            =   3360
      TabIndex        =   15
      Top             =   2815
      Width           =   1815
   End
   Begin VB.Label Label2 
      BackColor       =   &H00C0C000&
      Caption         =   "ข้อความต้นแบบ"
      Height          =   255
      Left            =   1680
      TabIndex        =   14
      Top             =   4440
      Width           =   1095
   End
   Begin VB.Label Label4 
      BackColor       =   &H00C0C000&
      Caption         =   "คำ"
      Height          =   255
      Left            =   6720
      TabIndex        =   13
      Top             =   5520
      Width           =   495
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C000&
      Caption         =   "ใส่ประโยคที่ต้องการอ่าน"
      Height          =   255
      Left            =   240
      TabIndex        =   11
      Top             =   4920
      Width           =   1695
   End
   Begin VB.Menu File_ 
      Caption         =   "แฟ้ม"
      Begin VB.Menu OpenFile_ 
         Caption         =   "เปิดแฟ้มข้อความ"
      End
      Begin VB.Menu Cutword_menu 
         Caption         =   "&ตัดคำ"
      End
      Begin VB.Menu exit_ 
         Caption         =   "ออกจากโปรแกรม"
      End
   End
   Begin VB.Menu main_add_word 
      Caption         =   "เพิ่มคำศัพท์"
      Begin VB.Menu Menu_Add_Word 
         Caption         =   "เพิ่มคำศัพท์"
      End
   End
   Begin VB.Menu Win_ 
      Caption         =   "&หน้าต่าง"
      Begin VB.Menu Clearwin 
         Caption         =   "ลบข้อความในหน้าต่าง"
      End
   End
   Begin VB.Menu help_ 
      Caption         =   "&เกี่ยวกับผู้พัฒนา"
      Begin VB.Menu about_ 
         Caption         =   "เกี่ยวกับผู้พัฒนา"
      End
   End
End
Attribute VB_Name = "frm_main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim TextSize, WordCount
Dim FileNum, Mode, Handle
Dim CurrentPos
Dim soundbuff(1000000) As Byte

Dim wordbuffer              ' temp area for use as word buffer
Dim Word1                   ' word 1 area
Dim Word2                   ' word 2 area

Dim StartPtr        As Long       ' start pointer
Dim BufferStartPtr  As Long       ' pointer for WordBuffer point to start position
Dim BufferEndPtr    As Long       ' pointer for WordBuffer point to end position
Dim CurrentBucketNo As Integer    ' current word buffer have 2 bucket

Private Sub Butt_Click()

End Sub

Private Sub about__Click()
        MsgBox "โปรแกรมนี้พัฒนาโดย นาย รัฐิติ์พงษ์ และ นาย อัศวิน"
End Sub

Private Sub Ask_help_Click()

End Sub

Private Sub Clearwin_Click()
    TextFileName = ""
    text_output = ""
    text_output2 = ""
    text_output3 = ""
    text_output4 = ""
    text_output5 = ""
End Sub

Private Sub Cutword_menu_Click()
   On Error GoTo d001
    '------------------------------------------
    '
    '------------------------------------------
    If TextFileName = "" Then
        MsgBox ("กรุณาเลือกไฟล์ที่ต้องการอ่านจาก เมนู ไฟล์")
        Exit Sub
    End If
    LetContinue = 1
exit1:
    Exit Sub
d001:
    
    Resume exit1

End Sub

Private Sub exit__Click()
    Close
    Unload frm_main
End Sub

Private Sub File__Click()

End Sub

Private Sub Form_Load()
    Dim work
    Dim temp
    
    'debug for test define large array
    'For temp = 1 To 1000000
    '    MsgBox (soundbuff(temp))
    'Next temp
    
    Init_System    ' initialize system
    ShowWordCount.Text = 1
End Sub

Private Sub Frame2_DragDrop(Source As Control, X As Single, Y As Single)

End Sub

Private Sub InputSentense_KeyPress(KeyAscii As Integer)
    On Error GoTo goon:
    Dim Tempfile
    Dim Datatext
    
    If KeyAscii = 27 Then
        InputSentense.Text = ""
    End If
    If KeyAscii = 13 Then
            Tempfile = "cvs.tmp"
            Close   ' close before kill
            Kill Tempfile
            Datatext = InputSentense.Text & "  " & Chr(13)
        ' MsgBox (Datatext) debug
goon:
        
        Open Tempfile For Binary Access Write As #1
            Put #1, , Datatext
        Close #1
        TextFileName = Tempfile
        TextSize = FileLen(Tempfile)    ' Returns file length (bytes).
        TextFileSize.Text = TextSize
        
        Open TextFileName For Binary Access Read As #1
        My_soundmap.Index = "primarykey"
        '-------------------------
        ' initialize  variable
        '-------------------------
        Init_Var
        LetContinue = 1
    End If
exit1:
    Exit Sub
d001:
    Resume exit1
End Sub

Private Sub InputWord_Change()
    ReadWord (InputWord.Text)
End Sub

Private Sub Menu_Add_Word_Click()

    Dictionary.Show
    'Add_New_Word.Show
End Sub

Private Sub OpenFile__Click()
    '------------------------------------
    ' Display the File Open dialog box.
    '-------------------------------------
    CommonDialog1(1).Flags = vbOFNReadOnly Or vbOFNFileMustExist
    CommonDialog1(1).DefaultExt = "*.txt"
    CommonDialog1(1).CancelError = True
    CommonDialog1(1).Filter = "text File (*.txt)|*.txt"
    On Error GoTo exit_1
    CommonDialog1(1).ShowOpen
    If Err <> 0 Then
        ' No file selected from the Open File dialog box.
        Exit Sub
    End If

    'open text window to show detail
    text_output.LoadFile CommonDialog1(1).Filename, rtfText
    TextSize = FileLen(CommonDialog1(1).Filename)    ' Returns file length (bytes).
    TextFileSize.Text = TextSize

    TextFileName = CommonDialog1(1).Filename
    ShowFilename = CommonDialog1(1).Filename
    Close
    Open TextFileName For Binary Access Read Lock Read As #1
    My_soundmap.Index = "primarykey"
    '-------------------------
    ' initialize  variable
    '-------------------------
    Init_Var
    

d001:
    Exit Sub
    
exit_1:
    Resume d001
    
End Sub

Private Sub Timer1_Timer()
    'On Error GoTo d001
    Dim worked
    Dim CharBuffCmp         ' use for compare with criteria
    Dim TestPtr                  ' use for test event such as test for char after space
    Dim TestBuff                ' use as temp buffer when call test
    
        If LetContinue = 1 Then
                '------------------------------------------------------
                ' check if end of file then stop reading
                '------------------------------------------------------
                If StartPointPtr >= TextSize Then
                        StartPointPtr = 1
                        LetContinue = 0
                        Exit Sub
                End If
                CutWord
        End If
exit1:
    Exit Sub
d001:
    MsgBox ("มีข้อผิดพลาดของโปรแกรมเกิดขึ้น")
    Resume exit1
End Sub

Public Function Check_Word_in_Bucket(i As Integer) As Integer
        Dim asccharbuff

        If i > 0 Then
                Seek #1, BucketEndPtr(i)
                Get #1, , CharBuff
                ' ถ้าคำที่ยาวที่สุดตามหลังด้วยสระ
                 asccharbuff = Asc(CharBuff)
                If (asccharbuff > 128 And asccharbuff < 144) Or (asccharbuff > 151 And asccharbuff < 161) Or (CharBuff = "า") Or (asccharbuff > 211 And asccharbuff < 219) Or (asccharbuff > 230 And asccharbuff < 237) Or CharBuff = "ะ" Then
                        'MsgBox (" เป็นสระ ")
                        i = Check_Word_in_Bucket(i - 1)
                        If i = 0 Then i = i + 1
                Else
                        StartPointPtr = BucketEndPtr(i)
                End If
        End If
        Check_Word_in_Bucket = i
End Function
Public Sub Not_read()
        ShowCannotReadCount = ShowCannotReadCount + 1
End Sub
Public Function CutWord()
        Dim i, pass
        Dim char As String * 1
        
        NotRead = 0
        WorkingPtr = StartPointPtr
        wordbuffer = "": NumberString = ""
        pass = False
        ClearBucket
        
        Do Until (EOF(1)) Or (pass = True)
                Seek #1, WorkingPtr
                Get #1, , CharBuff
                Select Case CharBuff
                        Case " ", Chr(13), Chr(10), Chr(8), Chr(0)
                        ' ถ้าอักขระที่อ่านเข้ามา = space หรือ เครื่องหมาย enter หมายความว่าจบคำแล้วไม่ต้องไล่ความลึกในการหา
                        'และถ้าพบคำสุดท้ายที่ค้างอยู่ใน bucket ให้อ่านออกเสียง
                                pass = True
                                If (Len(wordbuffer) > 1) And (CurBucketIndex = 0) Then
                                        If Good_Word Then ShowCannotReadCount = ShowCannotReadCount + 1
                                        Good_Word = False
                                        WorkingPtr = StartPointPtr
                                End If
                                If (CharBuff = " ") And (Len(wordbuffer) = 0) Then
                                        WorkingPtr = WorkingPtr + 1
                                        Seek #1, WorkingPtr
                                        Get #1, , char
                                        Do While char = " "
                                                WorkingPtr = WorkingPtr + 1
                                                Seek #1, WorkingPtr
                                                Get #1, , char
                                        Loop
                                        WorkingPtr = WorkingPtr - 1
                                        If (char <> "ๆ") Then i = sndPlaySoundA(dir_data & "blank.wav", 0)
                                End If
                                If (CharBuff = Chr(13)) And (Len(wordbuffer) = 0) Then
                                        i = sndPlaySoundA(dir_data & "blank.wav", 0)
                                        i = sndPlaySoundA(dir_data & "blank.wav", 0)
                                End If
                        Case "0" To "9"
                                If CurBucketIndex > 0 Then SayWordLeftInBucket (Check_Word_in_Bucket(CurBucketIndex))
                                Read_Number
                        Case "ๆ"
                                If CurBucketIndex > 0 Then
                                        pass = True
                                        WorkingPtr = WorkingPtr - 1
                                Else
                                        CurBucketIndex = 1
                                        WordBucket(1) = Lastword
                                        pass = True
                                        WorkingPtr = WorkingPtr + 1
                                        Seek #1, WorkingPtr
                                        Get #1, , char
                                        Do While char = " "
                                                WorkingPtr = WorkingPtr + 1
                                                Seek #1, WorkingPtr
                                                Get #1, , char
                                        Loop
                                        BucketEndPtr(1) = WorkingPtr
                                        WorkingPtr = WorkingPtr - 1
                                End If
                        Case Else
                                wordbuffer = wordbuffer & CharBuff
                                My_soundmap.Seek "=", wordbuffer
                                If Not My_soundmap.NoMatch Then Insert_bucket (wordbuffer)
                                WorkingPtr = WorkingPtr + 1
                End Select
        Loop
        StartPointPtr = WorkingPtr + 1
        If CurBucketIndex > 0 Then SayWordLeftInBucket (Check_Word_in_Bucket(CurBucketIndex))
End Function

Public Sub ClearBucket()
        For ForI = 1 To 5                ' set ตระกร้าทั้ง 5 สำหรับใส่คำให้เป็น 0
                WordBucket(ForI) = ""
                BucketEndPtr(ForI) = 0
        Next ForI
        CurBucketIndex = 0
End Sub
Public Sub SayWordLeftInBucket(i As Integer)
        Dim s1 As String, s2 As String, s3 As String, s4 As String
        
        'อ่านคำที่อยู่ใน Bucket
        WordCount = WordCount + 1               ' ตัวนับคำเพิ่มขึ้น
        ShowWordCount = WordCount               ' แสดงผลจำนวนคำที่อ่าน
        s1 = WordBucket(i)
        s2 = Convert_To_Payang(s1)
        s3 = Convert_Middle_Pattern(s2)
        Lastword = s1                                                   ' เก็บคำสุดท้ายที่อ่านไว้
        text_output2.Text = text_output2.Text & s1 & " "
        text_output3.Text = text_output3.Text & s2 & " "
        text_output4.Text = text_output4.Text & s3 & " "
        StartPointPtr = BucketEndPtr(i)
        ReadWord (s3)            ' อ่านคำออกลำโพง
End Sub

Private Sub Init_Var()
        ' Pointer
        StartPointPtr = 1       ' Start point file pointer สำหรับเซ็ทเป็นค่าเริ่มต้นในแต่ละครั้ง
        WorkingPtr = 1          'Working file pointer สำหรับการอ่านไฟล์มีละไบท์
        
        CurBucketIndex = 0  'แรกเริ่มตัวชี้ ตระกร้าคำ (words bucket) = 0
        ShowWordCount = 0
        
        wordbuffer = ""         ' buffer สำหรับคำที่ใช้ในขณะตรวจสอบคำในพจนานุกรม
        NumberString = ""
        
        For ForI = 1 To 5                ' set ตระกร้าทั้ง 5 สำหรับใส่คำให้เป็น 0
                WordBucket(ForI) = ""
                BucketEndPtr(ForI) = 0
        Next ForI
        
        ' Status ใช้เพียงแสดงผลไม่มีผลต่อการทำงานของโปรแกรม
        WordCount = 0                   ' จำนวนคำ
        CannotReadCount = 0       ' จำนวนที่อ่านไม่ได้
        ShowWordCount.Text = 0
        ShowCannotReadCount = 0
End Sub

Public Sub Read_Number()
        Dim i, j, k, old, pass, komma, jud
        
        komma = 0: jud = 0
        old = WorkingPtr
        pass = False
        'เช็คความยาวตัวเลข
        i = 0
        Do
                Select Case CharBuff
                        Case ","
                                pass = True
                                komma = komma + 1
                        Case "."
                                jud = jud + 1
                        Case Else
                                i = i + 1
                End Select
                GetNextChar
        Loop Until (CharBuff < "0" Or CharBuff > "9") And CharBuff <> "," And CharBuff <> "."
                
        WorkingPtr = old
        Seek #1, WorkingPtr
        Get #1, , CharBuff
        'เพิ่มคำอ่านหน่วยแทรกไปในตัวเลข
        For j = 1 To i
                If CharBuff <> "," Then
                        If pass = True Then
                            Select Case i - jud - j
                                    Case 0
                                            If CharBuff = "1" Then Insert_bucket ("เอ็ด") Else Insert_bucket (CharBuff)
                                    Case 1
                                            If CharBuff = "2" Then Insert_bucket ("ยี่")
                                            If CharBuff <> "1" And CharBuff <> "2" Then Insert_bucket (CharBuff)
                                    Case Else
                                            Insert_bucket (CharBuff)
                            End Select
                            If CharBuff = "0" Then ClearBucket
                        Else
                            Insert_bucket (CharBuff)
                        End If
                        If CurBucketIndex > 0 Then SayWordLeftInBucket (1)
                        ClearBucket
                        If CharBuff = "." Then pass = False
                        If j < i And pass = True And CharBuff <> "0" Then
                                k = (i - j + 1 - jud) Mod 7
                                If (i - j + 1 - jud) > 7 Then k = k + 1
                                Select Case k
                                        Case 0
                                                Insert_bucket ("ล้าน")
                                        Case 6
                                                Insert_bucket ("แสน")
                                        Case 5
                                                Insert_bucket ("หมื่น")
                                        Case 4
                                                Insert_bucket ("พัน")
                                        Case 3
                                                Insert_bucket ("ร้อย")
                                        Case 2
                                                Insert_bucket ("สิบ")
                                End Select
                                SayWordLeftInBucket (1)
                                ClearBucket
                        End If
                Else
                        j = j - 1
                End If
                GetNextChar
        Next j
                                
        WorkingPtr = old + i + komma
End Sub



































