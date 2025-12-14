VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Hack file"
   ClientHeight    =   4185
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   4185
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command3 
      Caption         =   "Command2"
      Height          =   375
      Left            =   2400
      TabIndex        =   9
      Top             =   3720
      Width           =   2055
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   375
      Left            =   240
      TabIndex        =   8
      Top             =   3720
      Width           =   2055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   375
      Left            =   4200
      TabIndex        =   7
      Top             =   600
      Width           =   375
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   375
      Left            =   240
      TabIndex        =   6
      Top             =   3120
      Width           =   4215
   End
   Begin VB.TextBox Text3 
      Height          =   375
      Left            =   240
      TabIndex        =   5
      Text            =   "Text1"
      Top             =   2640
      Width           =   4215
   End
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Text            =   "Text1"
      Top             =   1632
      Width           =   4215
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   240
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   624
      Width           =   3975
   End
   Begin VB.Label Label3 
      Caption         =   "Label1"
      Height          =   375
      Left            =   240
      TabIndex        =   4
      Top             =   2136
      Width           =   4215
   End
   Begin VB.Label Label2 
      Caption         =   "Label1"
      Height          =   375
      Left            =   240
      TabIndex        =   2
      Top             =   1128
      Width           =   4215
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   4215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'***************************************************************
' Name: Modify (hack) any file, including *.exe files!
' Description:Change and hack the contents of ANY FILE! Imagine
'     customizing your favorite software. Change the captions on command
'     buttons, passwords, or even title bars and replace them with your
'     own words. You can even modify the embedded comments, Developer
'     info, names, copyrights, etc... of a *.exe file without losing the
'     integrity of it.  The possibilities are endless. You could,
'     perhaps write a shareware program in VB that will embed the
'     registered user's Name directly into your main EXE file, then if
'     the user passes a copy to a friend, his name is still embedded in
'     it. This code is great, with a little practice, you may be able to
'     bypass expiration dates, passwords, time limits and much more! Slap
'     yourself for not having this technology and using other people's
'     confusing nonfunctional VB code.
' By: Patrick K. Bigley
'
'***************************************************************
' Modifications:  5/21/99 by Shannon Carter
'   I have modified the code to check for all occurrences of the string
'   in each block, instead of just the first one.  I have also added a
'   GUI interface that allows the user to select a file (using a dialog),
'   and enter the two strings, and also to specify whether the search
'   should be case-sensitive.
'
'   Also, please note that if the replacement string is longer than the
'   search string, it will be truncated, and if the search string is longer
'   than the replacement string, the replacement string will be padded
'   with spaces at the end.  (This is the original functionality.)
'
'   To create the form:
'      You'll need three text boxes, three command buttons, and a checkbox.
'      I left them with default names and the code below sets the captions
'      properly.  The first command button should be made square and the
'      same height as Text1, and placed to the right of Text1.  It is the
'      button that invokes the file chooser dialog.  The other two buttons
'      can go at the bottom.
'
'   You may consider adding an option to view the file after changes have
'   been made.  You can use the Shell command to invoke notepad or some
'   other viewer/editor.
'***************************************************************
'
' Inputs:  None
'
' Returns:  None
'
'Assumes:  Some modified files may not function properly, so be careful.
'
'Side Effects:  Make backup copies of the files that you are modifying
'
'Code provided by Planet Source Code(tm) (http://www.PlanetSource
'     Code.com) 'as is', without warranties as to performance, fitness,
'     merchantability,and any other warranty (whether expressed or impl
'     ied).
'***************************************************************

Const ChunkSize = 4096
'4096 seems to work best on my PC and I am
'sure it will work well on yours too.

Private Sub Command2_Click()

    Dim Msg, Style, Title, Help, Ctxt, Response, MyString
    Msg = "WARNING! You are about to change the "
    Msg = Msg & "contents of a file. Are you sure want to Do this?"
    Msg = Msg & vbCrLf & vbCrLf & "It is HIGHLY RECOMMENDED that you make "
    Msg = Msg & "a backup copy of this file before continuing!"
    Msg = Msg & vbCrLf & vbCrLf & "Do you want to continue?"
    Style = vbYesNo + vbCritical + vbDefaultButton2
    Title = "WARNING! File Modification is Ready."
    Response = MsgBox(Msg, Style, Title, Help, Ctxt)

    If Response = vbYes Then ' User chose Yes.
        MyString = "Yes"
    Else
        MyString = "No"
    End If

    If MyString = "Yes" Then
        'Below, we are looking for the string "hello" and
        'replacing it with "SeeYa" in the file called
        '"test.txt" Only the first occurance will be replaced
        'The file can be any size. Any ASCII binary symbol
        '(case sensitive) can be replaced in ANY kind of file.
        '
        'To try this example, create a text file called 'c:\test.txt'
        'and fill it with text and make sure the word "hello" is
        'in there somewhere.
        '
        'If you are daring, look at the contents of an EXE file with
        'an editor (MS editor.exe is good) and
        'see if you can find a key word, such as a titlebar caption,
        'command button caption, or even a password. Then you can
        'modify it. Be careful, sometimes this can ruin a good program,
        'so make backup copies.
        'ChangeFile "c:\test.txt", "hello", "SeeYa"
        ChangeFile Text1.Text, Text2.Text, Text3.Text
    End If

End Sub

Private Function FindInString(StartPos As Integer, StrToSearch As String, _
    StrToFind As String) As Integer

    If Check1.Value = 0 Then
        FindInString = InStr(StartPos, UCase(StrToSearch), UCase(StrToFind))
    Else
        FindInString = InStr(StartPos, StrToSearch, StrToFind)
    End If

End Function

Public Sub ChangeFile(FName$, IDString$, NString$)
    'The DIM variables below are correctly defined, but I personally
    'am not good at judging what types to use, so I avoided them
    'but left them in their original condition for you to use
    'Dim PosString As Integer, WhereString As Integer
    'Dim FileNumber As String, A$, NewString$
    'Dim AString As String * ChunkSize
    'Here is what I am using, and it works GREAT, especially
    'on large files!
    
    Dim PosString, WhereString
    Dim FileNumber, A$, NewString$
    Dim AString As String * ChunkSize
    Dim IsChanged As Boolean
    Dim BlockIsChanged As Boolean
    Dim NumChanges As Integer
    
    IsChanged = False
    BlockIsChanged = False
    On Error GoTo Problems
    FileNumber = FreeFile
    PosString = 1
    WhereString = 0
    AString = Space$(ChunkSize)
    'Make sure strings have same size

    If Len(IDString$) > Len(NString$) Then
        NewString$ = NString$ + Space$(Len(IDString$) - Len(NString$))
    Else
        NewString$ = Left$(NString$, Len(IDString$))
    End If

    Open FName$ For Binary As FileNumber
    NumChanges = 0

    If LOF(FileNumber) < ChunkSize Then
        A$ = Space$(LOF(FileNumber))
        Get #FileNumber, 1, A$
        WhereString = FindInString(1, A$, IDString$)
    Else
        A$ = Space$(ChunkSize)
        Get #FileNumber, 1, A$
        WhereString = FindInString(1, A$, IDString$)
    End If

    Do
        While WhereString <> 0
            tempstring = Left$(A$, WhereString - 1) & NewString$ & Mid$(A$, WhereString + Len(NewString$))
            A$ = tempstring
            NumChanges = NumChanges + 1
            IsChanged = True
            BlockIsChanged = True
            WhereString = FindInString(WhereString + 1, A$, IDString$)
        Wend

        If BlockIsChanged Then
            Put #FileNumber, PosString, A$
            BlockIsChanged = False
        End If
        
        PosString = ChunkSize + PosString - Len(IDString$)
        ' If we're finished, exit the loop

        If EOF(FileNumber) Or PosString > LOF(FileNumber) Then
            Exit Do
        End If

        ' Get the next chunk to scan

        If PosString + ChunkSize > LOF(FileNumber) Then
            A$ = Space$(LOF(FileNumber) - PosString + 1)
            Get #FileNumber, PosString, A$
            WhereString = FindInString(1, A$, IDString$)
        Else
            A$ = Space$(ChunkSize)
            Get #FileNumber, PosString, A$
            WhereString = FindInString(1, A$, IDString$)
        End If

    Loop Until EOF(FileNumber) Or PosString > LOF(FileNumber)

    Beep

    If IsChanged = True Then
        Msg = Chr$(34) & FName$ & Chr$(34) & " has been modified." & vbCrLf
        Msg = Msg & NumChanges & " occurrence(s) of " & Chr$(34) & IDString$ & _
        Chr$(34) & " replaced With " & Chr$(34) & _
        Left$(NString$, Len(IDString$)) & Chr$(34)
        MsgBox Msg, vbInformation, "File modification completed"
    Else
        MsgBox "File has not been modified.", vbInformation, "Could not find string"
    End If

    Close
    Exit Sub
Problems:
    Close
    MsgBox "An Error has occurred." & vbCrLf & Err.Description, _
    vbExclamation, "Error number " & Err.Number
End Sub

Private Sub Command1_Click()

    Dim Ans As String
    Ans = GetOpenFileNameDLG("File to hack *.*|*.*", "Please Select a file", "", Me.hwnd)


    If Ans <> "" Then
        Text1.Text = Ans
    End If

End Sub

Private Sub Command3_Click()

    Unload Me
End Sub

Private Sub Form_Load()

    Label1.Caption = "Select file:"
    Label2.Caption = "Search for:"
    Label3.Caption = "Change to:"
    Check1.Caption = "Case-sensitive search?"
    Check1.Value = 1
    Command1.Caption = "..."
    Command2.Caption = "Make Changes"
    Command3.Caption = "E&xit"
    Command3.Cancel = True
    Text1.Text = ""
    Text2.Text = ""
    Text3.Text = ""
End Sub


