Attribute VB_Name = "Module1"
    '********************************************
    '   1. New Type Variable
    '********************************************
    
    '--------------------------------------------
    '   Wave File Header
    '--------------------------------------------
    Type TypeWaveHeader
        h1 As String * 4        ' Label "RIFF"
        h2 As Long              ' Filesize - 8 bytes
        h3 As String * 4        '
        h4 As String * 4        '
        h5 As Long              '
        h6 As Integer           '
        h7 As Integer           '
        h8 As Long              '
        h9 As Long              '
        h10 As Integer          '
        h11 As Integer          '
        h12 As String * 4       '
        h13 As Long             '
    End Type
    
    '********************************************
    '   2. Windows API Define
    '********************************************
    Global Const SND_SYNC = &H0  'play synchronously (default)
    Declare Function sndPlaySoundA Lib "winmm" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long
    
    '********************************************
    '   3. Database Define
    '********************************************

    Public Db As Database
    Public My_soundmap      As Recordset
    Public My_soundfont      As Recordset
    Public My_Unit               As Recordset
    '********************************************
    '   4. Files and Directory
    '********************************************
    Public dir_database            As String        ' database directory (samples "c:\cvs\snd_data.mdb")
    Public dir_data                    As String        ' (sound fonts directory) define data file path (sample c:\cvs\sound\)
    Public TextFileName          As String        ' ชื่อของ Text Files ที่เราเปิดอ่าน (Text file for reading)
    
    '********************************************
    '   5. Loop control and Process Flag
    '********************************************
    Public DebugMode        As Integer     ' define debug mode or normal run
    Public LetContinue      As Integer     ' for check button stop is press or not
    Public ErrorWarning     As Integer
    Public ForI             As Long         ' loop var
    Public Deep             As Long         ' How Deep that program read the string for compare
    
    '********************************************
    '   6. Status
    '********************************************
    Public vWordCount       As Long         ' count amount of word
    Public vSyllableCount   As Long         ' count amount of syllable
    Public WordCount        As Long                     ' count word in text file
    Public CannotReadCount  As Long
    Public counter
    
    '********************************************
    '   7. Text Read Process
    '********************************************
    '7.1 buffer
    Public CharBuff        As String * 1            ' character buffer get from file
    Public wordbuffer      As String                ' word buffer for check
    Public WordBucket(5)   As String                ' keep all words that can be
    Public Lastword        As String                ' use when fount mai ya mok
    Public NumberString    As String
    '7.2 index
    Public CurBucketIndex  As Integer               ' point to current index of bucket no
    Public BucketEndPtr(5) As Long                  ' end of word pointer
    Public StartPointPtr   As Long
    Public WorkingPtr      As Long
    '7.3 Flag
    Public Good_Word    As Boolean
    Public blank As Boolean
    Public HaveComma    As Integer                  ' for check if there are comma sign in number string
    
Public Sub Init_System()
        dir_data = "c:\cvs\sound\"        ' ตำแหน่งที่ตั้งของ sound fonts
        dir_database = "c:\cvs\snd_data.mdb"  'ตำแหน่งที่ตั้งของพจนานุกรมคำศัพท์
        
        Set Db = OpenDatabase(dir_database)
        Set My_soundfont = Db.OpenRecordset("soundfont", dbOpenTable)
        Set My_soundmap = Db.OpenRecordset("soundmap", dbOpenTable)
        Set My_Unit = Db.OpenRecordset("unit", dbOpenTable)
        
        ErrorWarning = 0
        DebugMode = 0
        LetContinue = 0
        Deep = 200                        ' กำหนดความลึกในการ scan text ในแต่ละครั้ง
End Sub
Public Sub ReadWord(WordInput As String)
    ' อ่านค่าคำที่ส่งเข้ามาออกลำโพง
    Dim i, j, counter, worked, wfile
    
    WordInput = Trim(WordInput)
    WordInput = WordInput & " "
    'If Trim(WordInput) = "ๆ" Then WordInput = Lastword
    My_soundmap.Index = "primarykey"
    My_soundmap.Seek "=", WordInput
      
      
    i = InStr(WordInput, "+")
    j = InStr(WordInput, " ")
    If i > j Then
            If j > 0 Then k = j Else k = i
    Else
            If i > 0 Then k = i Else k = j
    End If
    Do While (k > 0)
            i = sndPlaySoundA(dir_data & Mid(WordInput, 1, k - 1), 0)
            If (k + 1) < Len(WordInput) Then
                    WordInput = Mid(WordInput, k + 1, Len(WordInput))
                    i = InStr(WordInput, "+")
                    j = InStr(WordInput, " ")
                    If i > j Then
                            If j > 0 Then k = j Else k = i
                    Else
                            If i > 0 Then k = i Else k = j
                    End If
            Else
                    k = 0
            End If
    Loop
    Good_Word = True
    blank = False
End Sub

Public Sub SaySpace()
    Dim worked
    Dim Fname
    Fname = dir_data & "space.wav"
    'worked = sndPlaySoundA(Fname, 0)

End Sub

Public Function GetWaveLen(Filename As String) As Long
    On Error GoTo d001
    Dim temp As TypeWaveHeader
    
    
    Open Filename For Binary Access Read Lock Read As #1 Len = Len(temp)
    Get #1, , temp
    Close
    GetWaveLen = temp.h2 - 48
    
exit1:
    Exit Function
d001:
    GetWaveLen = 0
    Resume exit1
End Function
Public Sub GetNextChar()
    WorkingPtr = WorkingPtr + 1     ' move working file pointer
    Seek #1, WorkingPtr                     ' seek working file pointer into the right position
   Get #1, , CharBuff                          ' get byte data
End Sub

Public Sub Insert_bucket(wordbuffer As String)
        CurBucketIndex = CurBucketIndex + 1
        WordBucket(CurBucketIndex) = wordbuffer
        BucketEndPtr(CurBucketIndex) = WorkingPtr + 1
End Sub
Public Function m()
        Dim File_p1 As Long, File_p2 As Long, File_p3 As Long
        Dim file_3 As String
        Dim h1 As TypeWaveHeader, h2 As TypeWaveHeader, h3 As TypeWaveHeader
        Dim i As Byte, d As Byte
        
        File_1 = "c:\cvs\sound\ba.wav"
        File_2 = "c:\cvs\sound\a_n1.wav"
        file_3 = "c:\cvs\mix.wav"
        
        File_p1 = 1
        File_p2 = 1
        File_p3 = 1
        Open File_1 For Binary Access Read Lock Read As #2
        Open File_2 For Binary Access Read Lock Read As #3
        Open file_3 For Binary Access Write As #4
        
        Seek #2, File_p1
        Get #2, , h1
        Seek #3, File_p2
        Get #3, , h2
        
        h3 = h1
        h3.h2 = h1.h2 + h2.h2 + 28
        h3.h13 = h1.h13 + h2.h13
        Put #4, , h3
        
        File_p3 = 45
        For File_p1 = 45 To h1.h2 - 36
                Seek #2, File_p1
                Get #2, , d
                Seek #4, File_p3
                Put #4, , d
                File_p3 = File_p3 + 1
        Next File_p1
        
        For File_p2 = 45 To h2.h13 - 36
                Seek #2, File_p1
                Get #2, , d
                Seek #4, File_p3
                Put #4, , d
                File_p3 = File_p3 + 1
        Next File_p2
        Close #2: Close #3: Close #4
End Function
